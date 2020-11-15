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
// CourseCurrentToArchive.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseCurrentToArchive {

	static Logger logger = Logger.getLogger(CourseCurrentToArchive.class.getName());

	public CourseCurrentToArchive(){}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	static boolean debug					= false;

	/*
	 * approveOutline
	 *	<p>
	 *	@return Msg
	 */
	public static Msg moveCurrentToArchived(Connection conn,
														String campus,
														String alpha,
														String num,
														String user) throws Exception {

		debug = DebugDB.getDebug(conn,"CourseCurrentToArchive");

		Msg msg = new Msg();

		try {
			msg = moveCurrentToArchivedX(conn,campus,alpha,num,user);
		} catch (SQLException e) {
			campus = campus + " / " + alpha + " / " + num + " / " + user;
			logger.fatal(user + " - CourseCurrentToArchive.moveCurrentToArchived ("+campus+"): " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception e) {
			campus = campus + " / " + alpha + " / " + num + " / " + user;
			logger.fatal(user + " - CourseCurrentToArchive.moveCurrentToArchived ("+campus+"): " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		}

		return msg;
	}

	public static Msg moveCurrentToArchivedX(Connection conn,
																String campus,
																String alpha,
																String num,
																String user) throws Exception {

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		Msg msg = new Msg();
		String thisSQL = "";
		String type = "CUR";
		String kix = "";

		try {
			kix = Helper.getKix(conn,campus,alpha,num,type);

			// to archive an approved course, the following is necessary
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for archive (updateTemp)
			// 4) put the temp record in courseARC table for use (insertToCourseARC)

			thisSQL = "DELETE FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("1. moveCurrentToArchived - DELETE TEMP (" + rowsAffected + ")");

			thisSQL = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("2. moveCurrentToArchived - INSERT TEMP (" + rowsAffected + ")");

			thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, user);
			ps.setString(2, AseUtil.getCurrentDateTimeString());
			ps.setString(3, campus);
			ps.setString(4, alpha);
			ps.setString(5, num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("3. moveCurrentToArchived - UPDATE TEMP (" + rowsAffected + ")");

			thisSQL = "INSERT INTO tblCourseARC SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, "ARC");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("4. moveCurrentToArchived - INSERT ARC (" + rowsAffected + ")");

			String[] sql = new String[10];
			sql = Constant.MAIN_TABLES.split(",");
			int totalTables = sql.length;
			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, AseUtil.getCurrentDateTimeString());
				ps.setString(2, campus);
				ps.setString(3, alpha);
				ps.setString(4, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("5. moveCurrentToArchived - UPDATE MAIN ("  + (i+1) + " of " + tableCounter + ", rowsAffected: " + rowsAffected + ")");
				ps.clearParameters();
			}

			try{
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
					if (debug) logger.info("5. UPDATE MAIN ("  + (i+1) + " of " + tableCounter + ", rowsAffected: " + rowsAffected + ")");
					ps.clearParameters();
				}
			}
			catch(Exception e){
				/*
				 * this is caught before exception. However, there are instances
				 * where it may be valid and still executes.
				 */
				msg.setMsg("Exception");
				msg.setErrorLog(e.toString());
				logger.fatal("moveCurrentToArchivedX ("+kix+"): " + e.toString());
			}

			//
			// text
			//
			// don't have to move text since the data is aleady in the right place
			//

			ps.close();

			ForumDB.closeForum(conn,user,ForumDB.getForumID(conn,campus,kix));

		} catch (SQLException e) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
			logger.fatal(user + " - CourseCurrentToArchive.moveCurrentToArchivedX ("+kix+"): " + e.toString());
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
			logger.fatal(user + " - CourseCurrentToArchive.moveCurrentToArchivedX ("+kix+"): " + e.toString());
		}

		return msg;
	}

	public void close() throws SQLException {}

}