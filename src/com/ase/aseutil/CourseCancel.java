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
// CourseCancel.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseCancel {
	static Logger logger = Logger.getLogger(CourseCancel.class.getName());

	static CourseDB courseDB = null;

	static boolean debug = false;

	public CourseCancel() throws Exception{
		courseDB = new CourseDB();
	}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	/*
	 * Cancelling a outline means to move it to cancelled table and not
	 * delete.
	 * <p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * <p>
	 *	@return int
	 */
	public static Msg cancelOutline(Connection connection,String campus,String kix,String user) throws Exception {


		debug = DebugDB.getDebug(connection,"CourseCancel");

		String[] info = Helper.getKixInfo(connection,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		Msg msg = cancelOutline(connection,campus,alpha,num,user);

		return msg;
	}

	public static Msg cancelOutline(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		/*
		 * in case user presses refresh, we want to prevent multiple executions.
		 * Only run when the course is still cancellable.
		 *
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 */

		debug = DebugDB.getDebug(conn,"CourseCancel");

		Msg msg = new Msg();
		String type = "PRE";
		String taskText = "";

		try{
			String kix = Helper.getKix(conn,campus,alpha,num,type);
			if (kix != null && kix.length() > 0){
				String progress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

				if (progress.equals(Constant.COURSE_DELETE_TEXT)){
					taskText = Constant.DELETE_TEXT;
				}
				else if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					taskText = Constant.REVIEW_TEXT;
				}
				else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
					taskText = Constant.REVISE_TEXT;
				}
				else{
					taskText = Constant.MODIFY_TEXT;
				}

				if (courseDB.isCourseCancellable(conn,kix,user)) {
					if (debug) AseUtil.logAction(conn, user, "CANCEL - START","Outline cancel ("+ alpha + " " + num + ")",alpha,num,campus,kix);

					msg = cancelOutlineX(conn, campus, alpha, num, user);

					//
					// delete any rename in progress
					//
					RenameDB renameDB = new RenameDB();
					renameDB.delete(conn,campus,kix);
					renameDB = null;

					int rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,taskText,campus,"crscan","REMOVE",type);

					if (debug) AseUtil.logAction(conn, user, "CANCEL - END","Outline cancel ("+ alpha + " " + num + ")",alpha,num,campus,kix);
				} else {
					msg.setMsg("NotCancellable");
					if (debug) logger.info(user + " - Attempting to cancel outline that is not cancellable.");
				}
			} else {
				msg.setMsg("NotAvailableToCancel");
				if (debug) logger.info(user + " - Attempting to cancel outline that is not available.");
			} // valid kix
		}
		catch(SQLException e){
			logger.fatal(user + " - CourseCancel: cancelOutline\n" + e.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal(user + " - CourseCancel: cancelOutline\n" + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * cancelOutlineX
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg cancelOutlineX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		boolean debug = false;

		Msg msg = new Msg();
		String[] sql = new String[15];
		String[] tempSQL = new String[15];
		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select;

		String thisSQL = "";
		String kix = "";
		String kixCAN = SQLUtil.createHistoryID(1);;

		conn.setAutoCommit(false);

		try {
			kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			debug = DebugDB.getDebug(conn,"CourseCancel");

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			PreparedStatement ps = null;

			/*
			*	update PRE data as CAN
			*/
			thisSQL = "INSERT INTO tblCourseCAN SELECT * FROM tblCourse WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("INSERT PRE TO CAN " + " - " + rowsAffected + " row");

			thisSQL = "UPDATE tblCourseCAN "
				+ "SET id=?,historyid=?,coursetype='CAN',progress='CANCELLED',coursedate=?,proposer=? "
				+ "WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixCAN);
			ps.setString(2,kixCAN);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,user);
			ps.setString(5,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("UPDATE PRE TO CAN " + " - " + rowsAffected + " row");

			thisSQL = "DELETE FROM tblCourse WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("DELETE CUR " + " - " + rowsAffected + " row");

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET historyid=?,coursetype='CAN',auditdate=?,auditby=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCAN);
				ps.setString(2,AseUtil.getCurrentDateTimeString());
				ps.setString(3,user);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("UPDATE CAN " + " - " + rowsAffected + " row");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sqlManual[i]
						+ " SET historyid=?,coursetype='CAN',auditdate=?,auditby=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCAN);
				ps.setString(2,AseUtil.getCurrentDateTimeString());
				ps.setString(3,user);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("UPDATE CAN " + " - " + rowsAffected + " row");
			}

			tableCounter = 4;
			sql[0] = "INSERT INTO tblApprovalHist2 (id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments, progress) "
					+ "SELECT tba.id, tba.historyid, '"
					+ AseUtil.getCurrentDateTimeString()
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments, tba.progress FROM tblApprovalHist tba WHERE historyid=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE historyid=?";
			sql[2] = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE historyid=?";
			sql[3] = "DELETE FROM tblReviewHist WHERE historyid=?";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = sql[i];
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
			}
			if (debug) logger.info("INSERT HISTORY " + " - " + rowsAffected + " row");

			// refractor ReviewerDB.removeReviewers
			// this line replaces commented out below
			rowsAffected = ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user);
			if (debug) logger.info("CourseCancel: cancelOutlineX - deleted " + rowsAffected + " tasks");

			/*
			 * update outline campus
			 */
			CampusDB.updateCampusOutline(conn,kixCAN,campus);
			CampusDB.removeCampusOutline(conn,campus,alpha,num,"PRE");

			// when cancelling, delete the SLO entry in progress
			thisSQL = "DELETE FROM tblSLO WHERE hid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("delete SLO entry " + " - " + rowsAffected + " row");
			ps.close();

			//
			// text
			//
			thisSQL = "update tbltext set historyid=? where historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixCAN);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			if (debug) logger.info("UPDATE text historyid " + rowsAffected + " row");

			// delete the miscallaneous item
			rowsAffected = MiscDB.deleteMisc(conn,kix);
			if (debug) logger.info(kix + " -  deleting misc - " + rowsAffected + " rows");

			// close the active forum
			ForumDB.closeForum(conn,campus,user,kix,kixCAN);

			// clean up
			ParkDB.deleteApproverCommentedItems(conn,kix);
			MiscDB.deleteStickyMisc(conn,kix);

			conn.commit();

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseCancel: cancelOutlineX\n" + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("CourseCancel: cancelOutlineX\n" + e.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				msg.setMsg("Exception");
				logger.fatal("CourseCancel: cancelOutlineX\n" + exp.toString());
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

	public void close() throws SQLException {}

}