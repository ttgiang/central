/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseRestore.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseRestore {
	static Logger logger = Logger.getLogger(CourseRestore.class.getName());

	static boolean debug = false;

	public CourseRestore(){}

	/*
	 * Cancelling a outline means to move it to cancelled table and not
	 * delete.
	 * <p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 * @param	user			String
	 * @param	type			String
	 * <p>
	 *	@return int
	 */
	public static Msg restoreOutline(Connection connection,String kix,String user,String courseTable) throws Exception {

		debug = DebugDB.getDebug(connection,"CourseRestore");

		if (debug) logger.info(kix + " COURSERESTORE: RESTOREOUTLINE - START");

		Msg msg = new Msg();

		try{
			if (CourseDB.isCourseRestorable(connection,kix,user)) {

				String[] info = Helper.getKixInfo(connection,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];
				String campus = info[Constant.KIX_CAMPUS];

				AseUtil.logAction(connection, user, "ACTION","Outline restore ("+ alpha + " " + num + ")",alpha,num,campus,kix);
				msg = restoreOutlineX(connection,kix,user,courseTable);
				AseUtil.logAction(connection, user, "ACTION","Outline restore ("+ alpha + " " + num + ")",alpha,num,campus,kix);
			} else {
				msg.setMsg("NotRestorable");
				if (debug) logger.info(kix + " CourseRestore: restoreOutline - Attempting to restore outline that is not restorable.");
			}
		}
		catch(SQLException se){
			logger.fatal(user + " CourseRestore: restoreOutline\n" + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal(user + " CourseRestore: restoreOutline\n" + e.toString());
			msg.setMsg("Exception");
		}

		if (debug) logger.info(kix + " COURSERESTORE: RESTOREOUTLINE - END");

		return msg;
	}

	/*
	 * restoreOutlineX
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg restoreOutlineX(Connection conn,String kix,String user,String courseTable) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		Msg msg = new Msg();
		String[] sql = new String[15];
		String[] tempSQL = new String[15];
		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select;
		StringBuffer userLog = new StringBuffer();

		String thisSQL = "";
		String junkSQL = "";
		String kixPRE = SQLUtil.createHistoryID(1);;

		conn.setAutoCommit(false);

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];

			if ("ARC".equals(courseTable))
				courseTable = "tblCourseARC";
			else
				courseTable = "tblCourseCAN";

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			PreparedStatement ps = null;

			//
			//	1) update cancelled data as PRE.
			//	2) process all dependent tables
			//	3) create task
			//

			// course table
			thisSQL = "INSERT INTO tblCourse "
					+ " SELECT * FROM " + courseTable + " "
					+ " WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kix + " CourseRestore: restoreOutlineX - INSERT TO PRE - " + rowsAffected + " row");

			thisSQL = "UPDATE tblCourse "
					+ " SET id=?,historyid=?,edit=1,coursetype='PRE',progress='MODIFY',proposer=?,coursedate=null,auditdate=null "
					+ " WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixPRE);
			ps.setString(2,kixPRE);
			ps.setString(3,user);
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " CourseRestore: restoreOutlineX - UPDATE historyid - " + rowsAffected + " row");

			// campus table
			thisSQL = "UPDATE tblCampusData "
					+ " SET historyid=?,coursetype='PRE' "
					+ " WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixPRE);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " CourseRestore: restoreOutlineX - UPDATE historyid - " + rowsAffected + " row");

			// support table
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				if (!"tblCourse".equals(sql[i]) && !"tblCampusData".equals(sql[i])){
					thisSQL = "UPDATE "
							+ sql[i]
							+ " SET historyid=?,coursetype='PRE',auditdate=?,auditby=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixPRE);
					ps.setString(2,AseUtil.getCurrentDateTimeString());
					ps.setString(3,user);
					ps.setString(4,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixPRE + " CourseRestore: restoreOutlineX - UPDATE supporting tables - " + rowsAffected + " row");
				}
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sqlManual[i]
						+ " SET historyid=?,coursetype='PRE',auditdate=?,auditby=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixPRE);
				ps.setString(2,AseUtil.getCurrentDateTimeString());
				ps.setString(3,user);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info(kixPRE + " CourseRestore: restoreOutlineX - UPDATE supporting tables - " + rowsAffected + " row");
			}

			ps.close();

			rowsAffected = TaskDB.logTask(conn,
													user,
													user,
													alpha,
													num,
													Constant.MODIFY_TEXT,
													campus,
													"",
													"ADD",
													"PRE",
													Constant.TASK_PROPOSER,
													Constant.TASK_PROPOSER);

			conn.commit();

			CampusDB.updateCampusOutline(conn,kixPRE,campus);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(kix + " CourseRestore: restoreOutlineX\n" + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(kix + " CourseRestore: restoreOutlineX\n" + e.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				msg.setMsg("Exception");
				logger.fatal(kix + " CourseRestore: restoreOutlineX\n" + exp.toString());
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

	public void close() throws SQLException {}

}