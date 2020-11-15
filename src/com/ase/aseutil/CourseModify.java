/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseModify.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

public class CourseModify {
	static Logger logger = Logger.getLogger(CourseModify.class.getName());

	public CourseModify(){}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	private static boolean debug			= true;

	/*
	 * modifyOutline - Initialize key fields for approved outline modifications
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	mode			Sring
	 *	<p>
	 * @return Msg
	 */
	public static Msg modifyOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode) throws SQLException {

		/*
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * for modification of an approved outline, the outline must not exists
		 * in PRE and must exist as CUR
		 *
		 * make sure they are modifying what is in their discipline
		 */

		int rowsAffected = 0;

		debug = DebugDB.getDebug(conn,"CourseModify");

		if (debug) logger.info("COURSEMODIFY: MODIFYOUTLINE - START");

		Msg msg = new Msg();
		try{
			if (!CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "PRE")
					&& CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "CUR")) {
				if (alpha.equals(UserDB.getUserDepartment(conn,user,alpha))) {

					String kix = Helper.getKix(conn,campus,alpha,num,"CUR");

					AseUtil.logAction(conn, user, "ACTION","Outline modification ("+ alpha + " " + num + ")",alpha,num,campus,kix);

					msg = modifyOutlineX(conn,campus,alpha,num,user,mode);

				} else {
					msg.setMsg("NotAuthorizeToModify");
					logger.info("NotAuthorizeToModify from another department");
				}
			} else {
				msg.setMsg("NotEditable");
				logger.info("CourseModify: modifyOutline - Attempting to edit outline that is not editable ("+alpha + " " + num+").");
			}
		}
		catch(SQLException se){
			logger.fatal("CourseModify: modifyOutline\n" + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal("CourseModify: modifyOutline\n" + e.toString());
			msg.setMsg("Exception");
		}

		if (debug) logger.info("COURSEMODIFY: MODIFYOUTLINE - END");

		return msg;
	}

	/*
	 * modifyOutlineX
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	mode			Sring
	 *	<p>
	 * @return Msg
	 */
	public static Msg modifyOutlineX(Connection conn,String campus,String alpha,String num,String user,String mode)
		throws Exception {

		return modifyOutlineX(conn,campus,alpha,num,user,mode,"");

	}

	public static Msg modifyOutlineX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode,
												String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		String[] select;

		String fromAlpha = alpha;
		String fromNum = num;
		String fromType = "CUR";

		String toAlpha = alpha;
		String toNum = num;
		String toType = "PRE";

		String currentDate = AseUtil.getCurrentDateTimeString();

		String kixOld = Helper.getKix(conn,campus,fromAlpha,fromNum,fromType);
		String kixNew = SQLUtil.createHistoryID(1);

		boolean debug = false;

		String progress = "";
		String taskText = "";

		try {
			debug = DebugDB.getDebug(conn,"CourseModify");

			if (mode.equals(Constant.COURSE_DELETE_TEXT)){
				progress = Constant.COURSE_DELETE_TEXT;
				taskText = Constant.DELETE_TEXT;
			}
			else{
				progress = Constant.COURSE_MODIFY_TEXT;
				taskText = Constant.MODIFY_TEXT;
			}

			if (debug){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("mode: " + mode);
				logger.info("progress: " + progress);
				logger.info("kixOld - " + kixOld);
				logger.info("kixNew - " + kixNew);
				logger.info("fromAlpha/fromNum: " + fromAlpha + "/" + fromNum);
				logger.info("toAlpha/toNum: " + toAlpha + "/" + toNum);
			}

			// similar to modifying outline.

			// to prepage for copy of an approved course, the following is necessary
			// 0) make sure the course doesn't already exist in the main table (both CUR and PRE)
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for edits (updateTemp)
			// 4) put the temp record in course table for use (insertToCourse)

			if (!CourseDB.courseExistByTypeCampus(conn,campus,toAlpha,toNum,toType)) {

				//
				// last 2 tables are done in LinkedUtil.copyLinkedTables
				//
				//tblAttach,tblGenericContent,tblCourseContent
				//tblTempAttach,tblTempGenericContent,tblTempCourseContent
				sql = "tblCourse,tblCampusData,tblCoreq,tblCourseCompAss,tblPreReq,tblXRef,tblCourseContentSLO,tblExtra,tblAttach".split(",");
				tempSQL = "tblTempCourse,tblTempCampusData,tblTempCoreq,tblTempCourseCompAss,tblTempPreReq,tblTempXRef,tblTempCourseContentSLO,tblTempExtra,tblTempAttach".split(",");

				//
				// tblCourseCompetency and tblgeslo are done in LinkedUtil.copyLinkedTables, and is done separately
				//
				//tblCourseCompetency,tblCourseLinked,tblCourseLinked2,tblGESLO
				//tblTempCourseCompetency,tblTempCourseLinked,tblTempCourseLinked2,tblTempGESLO
				sqlManual = "tblCourseACCJC".split(",");
				tempSQLManual = "tblTempCourseACCJC".split(",");

				totalTables = sql.length;
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				Outlines.deleteTempOutline(conn,kixOld);
				Outlines.insertIntoTemp(conn,kixOld);

				//
				// update temp data (course)
				//

				// correction for DF65 (ttg - 2012.14.01)

				String reason = "";

				if (mode.equals(Constant.COURSE_DELETE_TEXT)){
					reason = comments;
				}
				else if (mode.equals(Constant.COURSE_MODIFY_TEXT)){
					reason = "Initial outline modification";
				}

				reason = "<strong>"
							+ AseUtil.getCurrentDateTimeString() + " - " + user
							+ "</strong><br/>"
							+ reason;

				thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='"+progress+"',edit0='',edit1='1',edit2='1', "
					+ " proposer=?,historyid=?,dateproposed=?,auditdate=?,reviewdate=NULL,assessmentdate=NULL,coursedate=NULL, "
					+ " coursealpha=?,coursenum=?,campus=?,"+Constant.COURSE_REASON+"=? "
					+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, kixNew);
				ps.setString(2, user);
				ps.setString(3, kixNew);
				ps.setString(4, currentDate);
				ps.setString(5, currentDate);
				ps.setString(6, toAlpha);
				ps.setString(7, toNum);
				ps.setString(8, campus);
				ps.setString(9, reason);
				ps.setString(10, kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("UPDATE1A - " + rowsAffected + " row");

				//
				//	update temp with proper settings for modifications
				//
				thisSQL = "UPDATE tblTempCourseComp SET comments='',approved='',approvedby=null "+
					"WHERE historyid=?";
				if (debug) logger.info("update 2 of 2");
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();

				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQL[i]
							+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=?,campus=? "
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1, kixNew);
					ps.setString(2, currentDate);
					ps.setString(3, toAlpha);
					ps.setString(4, toNum);
					ps.setString(5, campus);
					ps.setString(6, kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("UPDATE1D " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQL[i].replace("tblTemp","") + ")");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQLManual[i]
							+ " SET historyid=?,coursetype='PRE',campus=?,auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					ps.setString(2,campus);
					ps.setString(3,AseUtil.getCurrentDateTimeString());
					ps.setString(4,kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("UPDATE1E " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQLManual[i].replace("tblTemp","") + ")");
				}

				//
				// insert to prod
				//
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sql[i]
							+ " SELECT * FROM "
							+ tempSQL[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("INSERT1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQL[i].replace("tblTemp","") + ")");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sqlManual[i]
							+ " SELECT " + select[i] + " FROM "
							+ tempSQLManual[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("INSERT1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQLManual[i].replace("tblTemp","") + ")");
				}
				ps.close();

				rowsAffected = LinkedUtil.copyLinkedTables(conn,kixOld,kixNew,toAlpha,toNum,user);

				//
				// insert textbooks to prod
				//
				String talinSQL = "";
				talinSQL = "insert into tbltemptext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltext where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT text to temp " + rowsAffected + " row");

				talinSQL = "update tbltemptext set historyid=? where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixNew);
				ps.setString(2,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("UPDATE temp text historyid " + rowsAffected + " row");

				talinSQL = "insert into tbltext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltemptext where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixNew);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT temp text to course " + rowsAffected + " row");

				//
				// delete temp
				//
				Outlines.deleteTempOutline(conn,kixOld);
				Outlines.deleteTempOutline(conn,kixNew);

				//
				// SLO
				//
				if (!taskText.equals(Constant.DELETE_TEXT)){
					rowsAffected = SLODB.insertSLO(conn,campus,toAlpha,toNum,user,"MODIFY",kixNew);
					if (debug) logger.info("SLO - " + rowsAffected + " row");
				}

				//
				// add any linked items not already there
				//
				addLinkedItems(conn,campus,kixOld,kixNew,user);

				//
				// sending back
				//
				msg.setKix(kixNew);
				if (debug) logger.info("new kix - " + kixNew);

				// no task creation if this is a delete
				if (!taskText.equals(Constant.DELETE_TEXT)){
					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															taskText,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.TASK_PROPOSER,
															Constant.TASK_PROPOSER,
															"",
															"",
															"EXISTING");
					if (debug) logger.info("log task - " + rowsAffected + " row");

					AseUtil.logAction(conn,
											user,
											"ACTION",
											"Outline "+progress+" ("+ alpha + " " + num + ")",
											alpha,
											num,
											campus,
											kixNew);
				}

			} else {
				msg.setMsg("NotAllowToCopyOutline");
			}

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseModify: ex - " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");
			logger.fatal(user + " - CourseModify: copyOutline - " + CourseCopy.toString());
		}

		return msg;
	}


	/*
	 * addLinkedItems
	 */
	public static int addLinkedItems(Connection conn,String campus,String kixOld,String kixNew,String user){

		//Logger logger = Logger.getLogger("addLinkedItems");

		int counter = 0;
		int rowsAffected = 0;

		try{
			//
			// at this point, there should not be any new KIX items found in course links
			//
			String sql = "DELETE FROM tblCourseLinked WHERE campus=? AND historyid=? AND coursetype='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixNew);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND coursetype='PRE'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kixNew);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "SELECT id,src,seq,dst,ref FROM tblCourseLinked WHERE campus=? AND historyid=? AND coursetype='CUR' ORDER BY ID";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixOld);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int oldid = rs.getInt("id");
				int seq = rs.getInt("seq");
				int ref = rs.getInt("ref");
				String src = rs.getString("src");
				String dst = rs.getString("dst");

				if(!isMatchLinkedItems(conn,campus,kixNew,src,dst,seq)){
					sql = "insert into tblCourseLinked (campus,historyid,src,seq,dst,coursetype,auditdate,auditby,ref) values(?,?,?,?,?,?,?,?,?)";
					PreparedStatement ps2 = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
					ps2.setString(1,campus);
					ps2.setString(2,kixNew);
					ps2.setString(3,src);
					ps2.setInt(4,seq);
					ps2.setString(5,dst);
					ps2.setString(6,"PRE");
					ps2.setString(7,AseUtil.getCurrentDateTimeString());
					ps2.setString(8,user);
					ps2.setInt(9,ref);
					ps2.executeUpdate();

					ResultSet rs2 = null;
					try{
						rs2 = ps2.getGeneratedKeys();
						if(rs2.next()){
							int newid = rs2.getInt(1);
							addLinked2Items(conn,kixOld,kixNew,user,oldid,newid);
						}
						rs2.close();
						ps2.close();
					} catch (Exception e){
						e.printStackTrace();
						rs2.close();
						ps2.close();
					}

					ps2.close();

					++counter;

				} // not match

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("CourseModify.addLinkedItems: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("CourseModify.addLinkedItems: " + e.toString());
		}

		return counter;

	}

	/*
	 * addLinked2Items
	 */
	public static int addLinked2Items(Connection conn,String kixOld,String kixNew,String user,int oldid,int newid){

		//Logger logger = Logger.getLogger("addLinkedItems");

		int counter = 0;

		try{

			String sql = "SELECT id,item,item2 FROM tblCourseLinked2 WHERE historyid=? AND id=? AND coursetype='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kixOld);
			ps.setInt(2,oldid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int item = rs.getInt("item");
				int item2 = rs.getInt("item2");

				if(!isMatchLinked2Items(conn,kixNew,oldid,item,item2)){
					sql = "insert into tblCourseLinked2 (historyid,id,item,coursetype,auditdate,auditby,item2) values(?,?,?,?,?,?,?)";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kixNew);
					ps2.setInt(2,newid);
					ps2.setInt(3,item);
					ps2.setString(4,"PRE");
					ps2.setString(5,AseUtil.getCurrentDateTimeString());
					ps2.setString(6,user);
					ps2.setInt(7,item2);
					ps2.executeUpdate();
					ps2.close();

					++counter;
				} // not match

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("CourseModify.addLinked2Items: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("CourseModify.addLinked2Items: " + e.toString());
		}

		return counter;

	}

	/**
	 * isMatchLinkedItems
	 * <p>
	 * @param connection	conn
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchLinkedItems(Connection conn,String campus,String historyid,String src,String dst,int seq) throws SQLException {

		String sql = "SELECT id FROM tblCourseLinked WHERE campus=? AND historyid=? AND coursetype='PRE' AND src=? AND dst=? AND seq=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,historyid);
		ps.setString(3,src);
		ps.setString(4,dst);
		ps.setInt(5,seq);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;

	}

	/**
	 * isMatchLinked2Items
	 * <p>
	 * @param connection	conn
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchLinked2Items(Connection conn,String historyid,int id,int item,int item2) throws SQLException {

		String sql = "SELECT id FROM tblCourseLinked2 WHERE historyid=? AND coursetype='PRE' AND id=? AND item=? AND item2=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,historyid);
		ps.setInt(2,id);
		ps.setInt(3,item);
		ps.setInt(4,item2);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;

	}

	public void close() throws SQLException {}

}