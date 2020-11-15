/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// ResetDB.java
//
package com.ase.aseutil.util;

import org.apache.log4j.Logger;

import java.sql.*;
import java.util.*;

import com.ase.aseutil.*;

public class ResetDB {

	static Logger logger = Logger.getLogger(ResetDB.class.getName());

	public ResetDB() throws Exception {}

	/**
	 * resetReviewToApproval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String resetReviewToApproval(Connection conn,String campus,String kix,String user) {

		StringBuffer sb = new StringBuffer();

		try{
			//
			// delete reviewers
			//
			String sql = "delete from tblreviewers where historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			int rowsAffected = ps.executeUpdate();
			ps.close();
			sb.append("Removed " + rowsAffected + " reviewer(s)<br>");

			//
			// delete tasks for all except person we are cleaning
			//
			sql = "delete from tbltasks where campus=? and historyid=? and submittedfor<>? and progress='REVIEW'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
			sb.append("Removed " + rowsAffected + " task(s)<br>");

			//
			// set task correctly. update tbltasks to show approval in action
			//
			sql = "update tbltasks set progress='APPROVAL',message='Approve Program Proposal' "
				+ "where campus=? and submittedfor=? and historyid=? and progress='REVIEW'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			sb.append("Updated " + rowsAffected + " task for " + user + "<br>");

			//
			// set program correctly
			//
			sql = "update tblprograms set progress='APPROVAL',edit1=3,edit2=3,reviewdate=null,subprogress=null "
				+ "where campus=? and historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			sb.append("Updated " + rowsAffected + " program<br>");

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_PROGRAM_TITLE];
			String num = info[Constant.KIX_PROGRAM_DIVISION];

			AseUtil.logAction(conn,
									user,
									"ACTION",
									"Reset review to approval",
									alpha,
									num,
									campus,
									kix);

		} catch (SQLException e) {
			logger.fatal("ResetDB.resetReviewToApproval: " + e.toString());
		} catch (Exception e) {
			logger.fatal("ResetDB.resetReviewToApproval: " + e.toString());
		}

		return sb.toString();

	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}