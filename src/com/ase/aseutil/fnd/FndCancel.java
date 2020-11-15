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
// FndCancel.java
//
package com.ase.aseutil.fnd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.DebugDB;
import com.ase.aseutil.Msg;
import com.ase.aseutil.TaskDB;

public class FndCancel {

	static Logger logger = Logger.getLogger(FndCancel.class.getName());

	public FndCancel() throws Exception{}

	/**
	 * cancel
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param user		String
	 * @param kix		String
	 * @param id		int
	 * <p>
	 * @return Msg
	 */
	public static Msg cancel(Connection conn,String campus,String user,String kix,int id) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Msg msg = new Msg();

		String type = "PRE";

		String taskText = "";

		try{
			String progress = FndDB.getFndItem(conn,id,"progress");

			if (progress.equals(Constant.FND_DELETE_PROGRESS)){
				taskText = Constant.FND_DELETE_TEXT;
			}
			else if (progress.equals(Constant.FND_REVIEW_PROGRESS)){
				taskText = Constant.FND_REVIEW_TEXT;
			}
			else if (progress.equals(Constant.FND_REVISE_PROGRESS)){
				taskText = Constant.FND_REVISE_TEXT;
			}
			else{
				taskText = Constant.FND_MODIFY_TEXT;
			}

			if (FndDB.isCancellable(conn,campus,user,kix,id)) {

				if (cancelX(conn,campus,user,kix,id) > 0){
					String title = FndDB.getFndItem(conn,id,"coursetitle");

					msg.setMsg("");

					rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
															Constant.FND_MODIFY_TEXT,
															campus,"","REMOVE","",
															"","",kix,Constant.PROGRAM);

					rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
															Constant.FND_REVIEW_TEXT_EXISTING,
															campus,"","REMOVE","PRE",
															"","",kix);

					rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
															Constant.FND_REVIEW_TEXT,
															campus,"","REMOVE","PRE",
															"","",kix);

					rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
															Constant.FND_REVIEW_TEXT_NEW,
															campus,"","REMOVE","PRE",
															"","",kix);
				} // rowsAffected
				else{
					msg.setMsg("FoundationCancelFailure");
				}

			} else {
				msg.setMsg("FoundationNotCancellable");
			}
		}
		catch(SQLException e){
			logger.fatal("FndDB: cancel\n" + kix + "\n" + e.toString());
		}
		catch(Exception e){
			logger.fatal("FndDB: cancel\n" + kix + "\n" + e.toString());
		}

		return msg;
	}

	/**
	 * cancel
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param user		String
	 * @param kix		String
	 * @param id		int
	 * <p>
	 * @return int
	 */
	public static int cancelX(Connection conn,String campus,String user,String kix,int id) {

		//Logger logger = Logger.getLogger("test");

		//
		//	cancellation refers to cancelling of a proposed outline
		//

		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE tblFnd SET type='CAN',progress='"+Constant.FND_CANCEL_PROGRESS+"',auditby=?,auditdate=? WHERE type='PRE' AND historyid=? AND id=?");
			ps.setString(1, user);
			ps.setString(2, AseUtil. getCurrentDateTimeString());
			ps.setString(3, kix);
			ps.setInt(4, id);
			rowsAffected = ps.executeUpdate();
			ps.close();

			AseUtil.logAction(conn,user,"ACTION","Foundation course cancelled " + FndDB.getFndItem(conn,id,"coursetitle"),"","",campus,kix);

		} catch (SQLException e) {
			logger.fatal("FndDB: cancelX\n" + kix + "\n" + e.toString());
		} catch(Exception e){
			logger.fatal("FndDB: cancelX\n" + kix + "\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}