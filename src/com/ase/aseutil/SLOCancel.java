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
// SLOCancel.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class SLOCancel {

	static Logger logger = Logger.getLogger(SLOCancel.class.getName());

	static CourseDB courseDB = null;

	public SLOCancel() throws Exception{
		courseDB = new CourseDB();
	}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;
	final static boolean debug			= true;

	/*
	 * Cancelling a outline means to move it to cancelled table and not
	 * delete. <p> @return int
	 */
	public static Msg cancelAssesssment(Connection connection,
												String campus,
												String kix,
												String user) throws Exception {

		/*
		 * in case user presses refresh, we want to prevent multiple executions.
		 * Only run when the course is still cancellable.
		 *
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 */

		logger.info("SLOCANCEL: CANCELASSESSSMENT - START");

		String alpha = "";
		String num = "";
		String type = "";

		Msg msg = new Msg();
		try{
			if (SLODB.isCancellable(connection,kix,user)) {
				if (!"".equals(kix)){
					String[] info = Helper.getKixInfo(connection,kix);
					alpha = info[0];
					num = info[1];
					type = info[2];
				}
				msg = cancelAssesssment(connection,campus,alpha,num,user,kix);
				AseUtil.loggerInfo("SLOCancel - cancelAssesssment: ",campus,user,alpha,num);
				int rowsAffected = TaskDB.logTask(connection,user,user,alpha,num,"SLO Assessment",campus,"","REMOVE",type);
			} else {
				msg.setMsg("NotCancellable");
				logger.info("SLOCancel: cancelAssesssment - Attempting to cancel outline that is not cancellable.");
			}
		}
		catch(SQLException se){
			logger.fatal("SLOCancel: cancelAssesssment\n" + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal("SLOCancel: cancelAssesssment\n" + e.toString());
			msg.setMsg("Exception");
		}

		logger.info("SLOCANCEL: CANCELASSESSSMENT - END");

		return msg;
	}

	public static Msg cancelAssesssment(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String kix) throws Exception {

		int rowsAffected = 0;
		String sql = "";
		Msg msg = new Msg();

		conn.setAutoCommit(false);

		try {
			/*
			 * 1) move to arc table
			 *	2) update to cancel/archive
			 *	3) delete from main
			 */

			AseUtil aseUtil = new AseUtil();
			PreparedStatement ps = null;

			sql = "INSERT INTO tblSLOARC "
				+ "SELECT hid, campus, CourseAlpha, CourseNum, CourseType, progress, comments, auditby, auditdate "
				+ "FROM tblSLO "
				+ "WHERE hid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - insert " + rowsAffected + " row");
			ps.clearParameters();

			sql = "UPDATE tblSLOARC "
				+ "SET CourseType='ARC', progress='CANCELLED',auditby=?, auditdate=? "
				+ "WHERE hid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,aseUtil.getCurrentDateTimeString());
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - update " + rowsAffected + " row");
			ps.clearParameters();

			sql = "DELETE FROM tblSLO WHERE hid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - delete " + rowsAffected + " row");
			ps.clearParameters();

			sql = "INSERT INTO tblAssessedDataARC "
				+ "select campus, CourseAlpha, CourseNum, CourseType, accjcid, qid, question, approvedby, approveddate, auditby, auditdate "
				+ "from tblAssessedData "
				+ "where campus=? AND "
				+ "coursealpha=? AND "
				+ "coursenum=? AND "
				+ "auditby=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,user);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - insert " + rowsAffected + " row");
			ps.clearParameters();

			sql = "update tblAssessedDataARC "
				+ "set CourseType='ARC', auditby=?, auditdate=? "
				+ "where campus=? AND "
				+ "coursealpha=? AND "
				+ "coursenum=? AND "
				+ "auditby=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,aseUtil.getCurrentDateTimeString());
			ps.setString(3,campus);
			ps.setString(4,alpha);
			ps.setString(5,num);
			ps.setString(6,user);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - update " + rowsAffected + " row");
			ps.clearParameters();

			sql = "delete from tblAssessedData "
				+ "where campus=? AND "
				+ "coursealpha=? AND "
				+ "coursenum=? AND "
				+ "auditby=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,user);
			rowsAffected = ps.executeUpdate();
			logger.info("SLOCancel - cancelAssesssment - delete " + rowsAffected + " row");
			ps.clearParameters();

			conn.commit();

			AseUtil.logAction(conn,user,"SLOCancel","Assessment Cancelled",alpha,num,campus,kix);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("SLOCancel: cancelAssesssment\n" + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("SLOCancel: cancelAssesssment\n" + e.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				msg.setMsg("Exception");
				logger.fatal("SLOCancel: cancelAssesssment\n" + exp.toString());
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

	public void close() throws SQLException {}

}