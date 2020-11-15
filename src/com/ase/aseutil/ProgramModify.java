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
// ProgramModify.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ProgramModify {
	static Logger logger = Logger.getLogger(ProgramModify.class.getName());

	public ProgramModify(){}

	/*
	 * modifyOutline - Initialize key fields for approved outline modifications
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 * @return Msg
	 */
	public static Msg modifyProgram(Connection conn,String campus,String kix,String user) throws SQLException {

		return modifyProgram(conn,campus,kix,user,"","");
	}

	public static Msg modifyProgram(Connection conn,String campus,String kix,String user,String mode,String comment) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Msg msg = new Msg();

		try{
			//
			//	make sure we don't already have 2 of the same in PROPOSED and APPROVED
			//
			if (ProgramsDB.isApprovedProgramEditable(conn,campus,kix)) {
				msg = modifyProgramX(conn,campus,kix,user,mode,comment);
			}
			else{
				msg.setMsg("NotEditable");
			}
		}
		catch(SQLException se){
			logger.fatal("ProgramModify: modifyProgram\n" + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal("ProgramModify: modifyProgram\n" + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * modifyProgramX
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	user			String
	 *	<p>
	 * @return Msg
	 */

	public static Msg modifyProgramX(Connection conn,String campus,String kix,String user) throws Exception {

		return modifyProgramX(conn,campus,kix,user,"","");

	}

	public static Msg modifyProgramX(Connection conn,String campus,String kix,String user,String mode,String comment) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;

		String kixNew = "";
		String title = "";

		String taskText = "";

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ProgramModify");

			if (mode.equals(Constant.PROGRAM_DELETE_PROGRESS)){
				taskText = Constant.PROGRAM_DELETE_TEXT;
			}
			else{
				taskText = Constant.PROGRAM_MODIFY_TEXT;
			}

			/*
				1) place a copy of CUR into temp and make it PRE
				2) update data to reflect changes to take place
				3) copy from temp to and put into main
			*/

			// delete from temp so it's not left behind and mess up in the future
			String sql = "DELETE FROM tbltempPrograms WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("cleaned up from temp table - " + kix);

			sql = "INSERT INTO tbltempPrograms "
							+ "SELECT * FROM tblPrograms WHERE campus=? AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();

			if (rowsAffected>0){
				kixNew = SQLUtil.createHistoryID(1);

				msg.setKix(kixNew);

				sql = "UPDATE tbltempPrograms "
						+ "SET historyid=?,type='PRE',edit=1,edit0='',edit1='1',edit2='1',route=0,progress='MODIFY',auditby=?,auditdate=?,proposer=?,dateapproved=null,regentsdate=null "
						+ "WHERE campus=? "
						+ "AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kixNew);
				ps.setString(2,user);
				ps.setString(3,AseUtil. getCurrentDateTimeString());
				ps.setString(4,user);
				ps.setString(5,campus);
				ps.setString(6,kix);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("modifying program from kix " + kix + " to " + kixNew);

				// move temp copy to work on
				sql = "INSERT INTO tblPrograms "
								+ "SELECT * FROM tbltempPrograms WHERE campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kixNew);
				rowsAffected = ps.executeUpdate();

				// delete from temp so it's not left behind and mess up in the future
				sql = "DELETE FROM tbltempPrograms WHERE campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kixNew);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("cleaned up from temp table");

				title = ProgramsDB.getProgramTitle(conn,campus,kixNew);

				if(debug){
					logger.info("kixNew: " + kixNew);
					logger.info("title: " + title);
					logger.info("taskText: " + taskText);
				}

				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														title,
														"",
														taskText,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER,
														kixNew,
														Constant.PROGRAM,
														"EXISTING");

			}
			else{
				logger.fatal("ProgramsDB - modifyProgramX: Insert into temp failed.");
			}
		}
		catch(SQLException e){
			logger.fatal("ProgramsDB - modifyProgramX: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramsDB - modifyProgramX: " + e.toString());
		}

		return msg;
	}

	public void close() throws SQLException {}

}