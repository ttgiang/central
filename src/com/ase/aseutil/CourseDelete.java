/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *	public static Msg cancelOutlineDelete(Connection conn,String kix,String user) throws Exception {
 *
 */

//
// CourseDelete.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class CourseDelete {
	static Logger logger = Logger.getLogger(CourseDelete.class.getName());

	public CourseDelete(){}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	/*
	 * deleteOutline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	user		String
	 *	<p>
	 * @return Msg
	 */
	public static Msg deleteOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String type,
												String user,
												String comments) throws SQLException {

		boolean debug = DebugDB.getDebug(conn,"CourseDelete");

		int rowsAffected = 0;

		String kix = "";

		Msg msg = new Msg();
		try{

			kix = Helper.getKix(conn,campus,alpha,num,type);

			if (debug) logger.info(kix + " - COURSEDELETE: DELETEOUTLINE - START");

			if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR") &&
				!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")) {

				AseUtil.logAction(conn, user, "ACTION","Outline delete ("+ alpha + " " + num + ")",alpha,num,campus,kix);

				CourseCurrentToArchive cm = new CourseCurrentToArchive();
				msg = cm.moveCurrentToArchived(conn,campus,alpha,num,user);
				cm = null;

				if (!"Exception".equals(msg.getMsg())) {
					msg = deleteOutlineX(conn,campus,alpha,num,type,user,comments);
					if (!"Exception".equals(msg.getMsg())){
						DistributionDB.notifyDistribution(conn,campus,alpha,num,"",user,"","","emailNotifiedWhenDelete","NotifiedWhenDelete",user);
					}
				} // if error

				AseUtil.logAction(conn, user, "ACTION","Outline delete ("+ alpha + " " + num + ")",alpha,num,campus,kix);

			} // if exists
			else {
				msg.setMsg("NotAvailableToDelete");
				if (debug) logger.info(msg.getMsg());
			}
		}
		catch(SQLException se){
			logger.fatal(kix + " - CourseDelete: deleteOutline - " + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal(kix + " - CourseDelete: deleteOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		if (debug) logger.info(kix + " - COURSEDELETE: DELETEOUTLINE - END");

		return msg;
	}

	/*
	 * deleteOutlineSQL
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	user		String
	 * @param	comments	String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg deleteOutlineX(Connection conn,
														String campus,
														String alpha,
														String num,
														String type,
														String user,
														String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		Msg msg = new Msg();

		String[] sql = new String[20];
		String[] sqlManual = new String[20];
		String[] select;

		String thisSQL = "";
		String kix = "";

		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		PreparedStatement ps = null;

		AsePool connectionPool = AsePool.getInstance();
		Connection connection = connectionPool.getConnection();
		connection.setAutoCommit(false);

		try{
			debug = DebugDB.getDebug(conn,"CourseDelete");

			kix = Helper.getKix(conn,campus,alpha,num,type);

			sql = Constant.MAIN_TABLES.split(",");
			sqlManual = Constant.MANUAL_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			Outlines.deleteTempOutline(conn,kix);

			thisSQL = "DELETE FROM tblApprovalHist2 WHERE historyid=?";
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("approval history - " + rowsAffected + " row");

			thisSQL = "DELETE FROM tblReviewHist2 WHERE historyid=?";
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("review history - " + rowsAffected + " row");

			// clear out from campus column in campus outline table
			thisSQL = "UPDATE tblCampusOutlines SET " + campus + " = null WHERE coursealpha=? AND coursenum=?";
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1,alpha);
			ps.setString(2,num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kix + " - " + user + " - CourseDelete - delete HTML - " + rowsAffected + " row");

			// when cancelling, delete the SLO entry in progress
			thisSQL = "DELETE FROM tblSLO WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("delete SLO entry " + " - " + rowsAffected + " row");

			// delete the miscallaneous item
			rowsAffected = MiscDB.deleteMisc(conn,kix);
			if (debug) logger.info(kix + " -  deleting misc - " + rowsAffected + " rows");

			// clean up
			ParkDB.deleteApproverCommentedItems(conn,kix);
			MiscDB.deleteStickyMisc(conn,kix);

			connection.commit();
		} // try
		catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseDelete: deleteOutline - " + ex.toString());
			msg.setMsg("Exception");
			connection.rollback();
			if (debug) logger.info(kix + " - " + user + " - CourseDelete: deleteOutline- Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			if (debug) logger.info(kix + " - " + user + " - CourseDelete: deleteOutline - " + e.toString());
			msg.setMsg("Exception");

			try {
				connection.rollback();
				if (debug) logger.info(kix + " - " + user + " - CourseDelete: deleteOutline - Rolling back transaction");
			} catch (SQLException exp) {
				logger.fatal(user + " - CourseDelete: deleteOutline - Rolling back error - " + exp.toString());
			}
		} finally {
			connection.setAutoCommit(true);
			connectionPool.freeConnection(connection);
		}

		return msg;
	}

	/*
	 * setCourseForDelete
	 * <p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg setCourseForDelete(Connection conn,String kix,String user,int route) throws Exception {

		return setCourseForDelete(conn,kix,user,route,"");

	}

	public static Msg setCourseForDelete(Connection conn,String kix,String user,int route,String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];

		String message = "";
		String sURL = "";
		String temp = "";
		int rowsAffected = 0;

		/*
			there can only be a single outline and it has to be in APPROVED status before deleting.
			if OK to delete,
				1) use code from modifyOutlineAccess to place outline in PRE status
				2) obtain the KIX of the outline just placed in modify status
				3) kick of approval process processing
		*/

		logger.info(kix + " - COURSEDELETE - SETCOURSEFORDELETE - START");

		if (CourseDB.countSimilarOutlines(conn,campus,alpha,num)>1){
			msg.setMsg("NotAllowToDelete");
			logger.info(kix + " - CourseDelete - setCourseForDelete - Attempting to delete outline failed (" + user + ").");
		}
		else{
			msg = CourseModify.modifyOutlineX(conn,campus,alpha,num,user,Constant.COURSE_DELETE_TEXT,comments);
			if (!"Exception".equals(msg.getMsg())){

				// kix of outline to work with
				kix = Helper.getKix(conn,campus,alpha,num,"PRE");

				// notify approval to begin. must return kix for deleted outline entry (PRE) since
				// CourseModify.modifyOutlineAccess put the original CUR outline into PRE for work
				msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_DELETE_TEXT,route,user);
				msg.setKix(kix);

				// notify chairs of pre/cor/xlist departments of this action
				notifyDepartmentChairs(conn,kix,user);
			}	// if exception
		}	// if countSimilarOutlines

		logger.info(kix + " - COURSEDELETE - SETCOURSEFORDELETE - END");

		return msg;
	}

	/*
	 * notifyDepartmentChairs
	 * <p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return int
	 */
	public static int notifyDepartmentChairs(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;
		boolean found = false;

		int rowsAffected = 0;

		String sql = "";
		String alpha = "";
		String num = "";

		String taskCampus = "";
		String taskAlpha = "";
		String taskNum = "";
		String taskType = "";

		String divisionChairName = "";
		String divisionChairNameSent = "";

		MailerDB mailerDB = null;

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			taskCampus = info[Constant.KIX_CAMPUS];
			taskAlpha = info[Constant.KIX_ALPHA];
			taskNum = info[Constant.KIX_NUM];
			taskType = info[Constant.KIX_TYPE];

			// for loop to take care of pre and co reqs; pre first then co
			for(int req=0; req<3; req++){

				found = false;

				if (req==0){
					sql = "SELECT tp.PrereqAlpha AS [Alpha], tp.PrereqNum AS [num] FROM tblPreReq tp "
						+ "WHERE tp.Campus=? AND tp.coursealpha=? AND tp.coursenum=? AND tp.coursetype=?";
				}
				else if (req==1){
					sql = "SELECT tp.coreqAlpha AS [Alpha], tp.coreqNum AS [num] FROM tblCoReq tp "
						+ "WHERE tp.Campus=? AND tp.coursealpha=? AND tp.coursenum=? AND tp.coursetype=?";
				}
				else if (req==2){
					sql = "SELECT tp.coursealphaX AS [Alpha], tp.coursenumX AS [num] FROM tblXRef tp "
						+ "WHERE tp.Campus=? AND tp.coursealpha=? AND tp.coursenum=? AND tp.coursetype=?";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,taskCampus);
				ps.setString(2,taskAlpha);
				ps.setString(3,taskNum);
				ps.setString(4,taskType);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){

					alpha = AseUtil.nullToBlank(rs.getString("alpha"));

					num = AseUtil.nullToBlank(rs.getString("num"));

					divisionChairName = ChairProgramsDB.getChairName(conn,taskCampus,alpha);

					if(divisionChairName != null && divisionChairName.length() > 0){

						// save the names so we don't send them again.
						if (divisionChairNameSent.indexOf(divisionChairName)<0){
							mailerDB = new MailerDB(conn,
															user,
															divisionChairName,
															"",
															"",
															taskAlpha,
															taskNum,
															taskCampus,
															"emailOutlineTerminationNotice",
															kix,
															user);

							divisionChairNameSent += "," + divisionChairName;
						}
					}
				}
				rs.close();
				ps.close();
			} // for

		}
		catch( SQLException e ){
			logger.fatal("CourseDelete: notifyDepartmentChairs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("CourseDelete: notifyDepartmentChairs - " + ex.toString());
		}

		return 0;
	}

	/*
	 * cancelOutlineDelete
	 * <p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelOutlineDelete(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		StringBuffer userLog = new StringBuffer();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = NumericUtil.nullToZero(info[6]);

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select = null;

		String thisSQL = "";
		String junkSQL = "";

		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int i = 0;

		PreparedStatement ps;

		/*
			cancelling approval takes the following steps:

			1) Make sure it's in the correct progress and isCourseDeleteCancellable
			2) update the course record
			3) send notification to all
			4) clear history
		*/

		try{
			msg = CourseDB.isCourseDeleteCancellable(conn,campus,alpha,num,user);
			if (msg.getResult()){
				/*
				*	delete from temp tables PRE or CUR ids and start clean
				*/
				userLog.append("--- DELETE FROM TEMP ---<br/>");
				userLog.append(Outlines.deleteTempOutline(conn,kix));

				sql = Constant.MAIN_TABLES.split(",");
				tempSQL = Constant.TEMP_TABLES.split(",");
				totalTables = sql.length;

				sqlManual = Constant.MANUAL_TABLES.split(",");
				tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				/*
				*	delete from other tables
				*/
				userLog.append("<br/>--- DELETE MAIN ---<br/>");
				userLog.append("<ul>");
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sql[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sqlManual[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				}
				userLog.append("</ul>");

				/*
				*	delete history
				*/
				userLog.append("<br/>--- DELETE HISTORY ---<br/>");
				userLog.append("<ul>");
				sql[0] = "tblApprovalHist";
				sql[1] = "tblApprovalHist2";
				sql[2] = "tblReviewHist";
				sql[3] = "tblReviewHist2";
				tableCounter = 4;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sql[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				}
				userLog.append("</ul>");

				//----------------------------------------------------------------------------
				// FORUM
				//----------------------------------------------------------------------------
				String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
				if (enableMessageBoard.equals(Constant.ON)){
					int fid = ForumDB.getForumID(conn,campus,kix);
					if(fid > 0){
						ForumDB.deleteForum(conn,fid);
					}
				}

				// delete task for proposer and also the approvals created
				userLog.append("<br/>--- DELETE TASK ---<br/>")
						.append("<ul>")
						.append("<li>(" + rowsAffected + ") Task Removed</li>")
						.append("</ul>");

				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.DELETE_TEXT,campus,"","REMOVE","PRE");
				rowsAffected = rowsAffected + TaskDB.logTask(conn,"ALL",user,alpha,num,Constant.APPROVAL_TEXT,campus,"","REMOVE","PRE");

				msg.setUserLog(userLog.toString());

			}
			else{
				msg.setMsg("OutlineNotInDeleteStatus");
			}
		}
		catch(Exception e){
			logger.fatal(kix + " - CourseDelete - cancelOutlineDelete - " + e.toString());
		}

		return msg;
	}

	/*
	 * expeditedDelete
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg expeditedDelete(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//
		// this is similar to CUR to ARC
		//

		String exception = campus + " / " + alpha + " / " + num + " / " + user;

		boolean debug = false;

		Msg msg = new Msg();

		try {

			try {
				debug = DebugDB.getDebug(conn,"CourseDelete");
			}
			catch(Exception e){
				debug = false;
			}

			msg = expeditedDeleteX(conn,campus,alpha,num,user);

		} catch (SQLException e) {
			logger.fatal("expeditedDelete ("+exception+"): " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(exception + "\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("expeditedDelete ("+exception+"): " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(exception + "\n" + e.toString());
		}

		return msg;
	}

	public static Msg expeditedDeleteX(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//
		// this is similar to CUR to ARC
		//

		boolean debug = false;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		Msg msg = new Msg();
		String thisSQL = "";
		String type = "CUR";
		String kix = "";

		try {
			PreparedStatement ps = null;

			kix = Helper.getKix(conn,campus,alpha,num,type);

			// to archive an approved course, the following is necessary
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for archive (updateTemp)
			// 4) put the temp record in courseARC table for use (insertToCourseARC)

			//
			// delete from temp tables PRE or CUR ids and start clean
			//
			Outlines.deleteTempOutline(conn,kix);
			if (debug) logger.info("01. Delete temp");

			//
			// take care of course data
			//
			thisSQL = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("02. Insert temp (" + rowsAffected + ")");

			thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, user);
			ps.setString(2, AseUtil.getCurrentDateTimeString());
			ps.setString(3, campus);
			ps.setString(4, alpha);
			ps.setString(5, num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("03. Update temp (" + rowsAffected + ")");

			thisSQL = "INSERT INTO tblCourseARC SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, "ARC");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("04. Insert ARC (" + rowsAffected + ")");

			//
			// loop starts at 1 because we are skipping tblcourse
			//
			String[] sql = new String[10];
			sql = Constant.MAIN_TABLES.split(",");
			int totalTables = sql.length;
			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setString(2,campus);
				ps.setString(3,alpha);
				ps.setString(4,num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("05. Update main-1 ("  + (i+1) + " of " + tableCounter + ", rowsAffected: " + rowsAffected + ")");
				ps.clearParameters();
			}

			try{
				//
				// loop starts at 1 because we are skipping tblcourse
				//
				String[] sqlManual = new String[10];
				sqlManual = Constant.MANUAL_TABLES.split(",");
				totalTables = sqlManual.length;
				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ sqlManual[i]
							+ " SET coursetype='ARC',auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("05. Update main-2 ("  + (i+1) + " of " + tableCounter + ", rowsAffected: " + rowsAffected + ")");
					ps.clearParameters();
				}
			}
			catch(Exception e){
				//
				// this is caught before exception. However, there are instances
				// where it may be valid and still executes.
				//
				msg.setMsg("Exception");
				msg.setErrorLog(e.toString());
				logger.fatal("expeditedDelete ("+kix+"): " + e.toString());
			}

			//
			// when all is said and done and move completed, we want to get rid of the CUR
			//
			if (courseExistByTypeKix(conn,campus,kix,"ARCx")){

				thisSQL = "DELETE FROM tblcourse where campus=? AND historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,kix);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("06. Delete course ("  + rowsAffected + ")");
				ps.close();

				//
				// refresh outline view
				//
				Tables.deleteOutline(conn,campus,kix);
				if (debug) logger.info("07. Deleting CUR HTML");

				Tables.createOutlines(campus,kix,alpha,num);
				if (debug) logger.info("08. Creating ARC HTML");

				CampusDB.removeCampusOutline(conn,campus,alpha,num,"CUR");
				if (debug) logger.info("09. Clear CUR campus outline");

				CampusDB.updateCampusOutline(conn,kix,campus);
				if (debug) logger.info("10. Create ARC campus outline");

			}

			//
			// text
			//
			// don't have to move text since the data is aleady in the right place
			//

			ps.close();

			ForumDB.closeForum(conn,user,ForumDB.getForumID(conn,campus,kix));

		} catch (SQLException e) {
			//
			// this is caught before exception. However, there are instances
			// where it may be valid and still executes.
			//
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
			logger.fatal("expeditedDelete ("+kix+"): " + e.toString());
		} catch (Exception e) {
			//
			// must do since for any exception, a rollback is a must.
			//
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
			logger.fatal("expeditedDelete ("+kix+"): " + e.toString());
		}

		return msg;
	}

	public static boolean courseExistByTypeKix(Connection conn,String campus,String kix,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		String table = "tblcourse";

		try {
			if (type.equals("ARC")){
				table = "tblcoursearc";
			}

			String sql = "SELECT coursetype FROM "+table+" WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("courseExistByTypeKix - " + e.toString());
		}

		return exists;
	}

	/*
	 * getDeletedOutline
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return Generic
	 */
	public static List<Generic> getDeletedOutline(Connection conn,String campus,String alpha,String num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {

			genericData = new LinkedList<Generic>();

			String sql = "";
			String dateField = "";

			PreparedStatement ps = null;

			AseUtil ae = new AseUtil();

			sql = "SELECT historyid,Coursealpha,Coursenum,coursedate,Proposer,coursetitle FROM vw_keeDELX WHERE campus=? AND Coursealpha=? AND Coursenum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				genericData.add(new Generic(
									AseUtil.nullToBlank(rs.getString("historyid")),
									AseUtil.nullToBlank(rs.getString("Coursealpha")),
									AseUtil.nullToBlank(rs.getString("Coursenum")),
									ae.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME),
									AseUtil.nullToBlank(rs.getString("proposer")),
									AseUtil.nullToBlank(rs.getString("coursetitle")),
									"",
									"",
									""
								));
			} // while
			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("CourseDelete: getDeletedOutline\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("CourseDelete: getDeletedOutline\n" + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}