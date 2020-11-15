/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *	public static Msg cancelProgramDelete(Connection conn,String kix,String user) throws Exception {
 *
 */

//
// ProgramDelete.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ProgramDelete {
	static Logger logger = Logger.getLogger(ProgramDelete.class.getName());

	public ProgramDelete(){}

	/*
	 * cancelProgramDelete
	 * <p>
	 * @param	conn		Connection
	 * @param	kix 		String
	 * @param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelProgramDelete(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

		int rowsAffected = 0;

		PreparedStatement ps = null;

		boolean debug = false;
		/*
			cancelling approval takes the following steps:

			1) Make sure it's in the correct progress and isProgramDeleteCancellable
			2) update the course record
			3) send notification to all
			4) clear history
		*/

		if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramDelete - START");

		int i = 0;
		int tableCounter = 0;
		int numberOfTables = 4;
		String thisSQL = "";
		String[] sql = new String[numberOfTables];

		try{
			msg = ProgramsDB.isProgramDeleteCancellable(conn,campus,kix,user);
			if (!msg.getResult()){

				if (debug) logger.info("OK to DELETE");

				/*
				*	delete from temp tables PRE or CUR ids and start clean
				*/
				thisSQL = "DELETE FROM tbltempPrograms WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();

 				/*
				*	delete history
				*/
				sql[0] = "tblApprovalHist";
				sql[1] = "tblApprovalHist2";
				sql[2] = "tblReviewHist";
				sql[3] = "tblReviewHist2";
				tableCounter = numberOfTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM "
							+ sql[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("deleting history/review " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				// delete the miscallaneous item
				rowsAffected = MiscDB.deleteMisc(conn,kix);

				// delete task for proposer and also the approvals created
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.PROGRAM_DELETE_TEXT,
														campus,
														"",
														"REMOVE",
														"PRE",
														"",
														"",
														kix,
														Constant.PROGRAM);
				if (debug) logger.info("removing delete task - " + rowsAffected + " rows");

				rowsAffected = rowsAffected + TaskDB.logTask(conn,
																			"ALL",
																			user,
																			alpha,
																			num,
																			Constant.PROGRAM_APPROVAL_TEXT,
																			campus,
																			"",
																			"REMOVE",
																			"PRE",
																			"",
																			"",
																			kix,
																			Constant.PROGRAM);
				if (debug) logger.info("removing approval task - " + rowsAffected + " rows");

			}
			else{
				msg.setMsg("ProgramNotInDeleteStatus");
				if (debug) logger.info("ProgramDelete: cancelProgramDelete - OutlineNotInDeleteStatus.");
			} // msg.getResult()
		}
		catch(Exception e){
			logger.fatal(kix + " - PROGRAMSDB - cancelProgramDelete - " + e.toString());
		}

		if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramDelete - END");

		return msg;
	}


	public void close() throws SQLException {}

}