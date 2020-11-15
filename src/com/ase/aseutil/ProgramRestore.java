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
// ProgramRestore.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ProgramRestore {
	static Logger logger = Logger.getLogger(ProgramRestore.class.getName());

	static boolean debug = true;

	public ProgramRestore(){}

	/*
	 * Cancelling a outline means to move it to cancelled table and not
	 * delete.
	 * <p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 *	@return int
	 */
	public static Msg restoreProgram(Connection conn,String campus,String kix,String user) throws Exception {

		logger.info("ProgramRestore: restoreProgram - START");

		Msg msg = new Msg();

		try{
			if (ProgramsDB.isProgramRestorable(conn,campus,kix)) {
				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_PROGRAM_TITLE];
				String num = info[Constant.KIX_PROGRAM_DIVISION];
				String type = info[Constant.KIX_TYPE];

				AseUtil.logAction(conn, user, "ACTION","Program restore ("+ alpha + " " + num + ")",alpha,num,campus,kix);

				msg = restoreProgramX(conn,campus,kix,user);

				AseUtil.logAction(conn, user, "ACTION","Program restore ("+ alpha + " " + num + ")",alpha,num,campus,kix);

			} else {
				msg.setMsg("NotRestorable");
				logger.info("ProgramRestore: restoreProgram - Attempting to restore outline that is not restorable.");
			}
		}
		catch(SQLException se){
			logger.fatal(user + " ProgramRestore: restoreProgram - " + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal(user + " ProgramRestore: restoreProgram - " + e.toString());
			msg.setMsg("Exception");
		}

		logger.info("ProgramRestore: restoreProgram - END");

		return msg;
	}

	/*
	 * restoreProgramX
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg restoreProgramX(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		Msg msg = new Msg();
		String sql = "";

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_PROGRAM_TITLE];
			String num = info[Constant.KIX_PROGRAM_DIVISION];
			String type = info[Constant.KIX_TYPE];

			PreparedStatement ps = null;

			// course table
			sql = "UPDATE tblPrograms "
				+ "SET proposer=?,type='PRE',edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY',auditby=?,auditdate=?,dateapproved=null,regentsdate=null "
				+ "WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,user);
			ps.setString(3,AseUtil. getCurrentDateTimeString());
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			logger.info("restoreProgramX - CAN to PRE - " + rowsAffected + " row");

			ps.close();

			String title = ProgramsDB.getProgramTitle(conn,campus,kix);

			rowsAffected = TaskDB.logTask(conn,
													user,
													user,
													title,
													"",
													Constant.PROGRAM_MODIFY_TEXT,
													campus,
													"",
													"ADD",
													"PRE",
													Constant.TASK_PROPOSER,
													Constant.TASK_PROPOSER,
													kix,
													Constant.PROGRAM);

			logger.info("restoreProgramX - task created for - " + user);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(kix + " ProgramRestore: restoreProgramX - " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(kix + " ProgramRestore: restoreProgramX - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	public void close() throws SQLException {}

}