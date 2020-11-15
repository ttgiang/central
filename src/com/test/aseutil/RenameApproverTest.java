/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.test.aseutil;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import com.ase.aseutil.*;

import java.io.*;
import java.sql.*;


/**
 * @author tgiang
 *
 */
public class RenameApproverTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testRenameApprover() {

		boolean test = true;

		logger.info("========================== RenameApproverTest.testRenameApprover.START");

		try{
			if (getConnection() != null){

				//logger.info(renameApprover(getConnection(),"LEE","MLANE",Constant.SYSADM_NAME));

				logger.info(renameApprover(getConnection(),"LEE",Constant.SYSADM_NAME,"MLANE"));

			} // conn != null
		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}

		test = true;

		assertTrue(test);

		logger.info("========================== RenameApproverTest.testRenameApprover.END");

	}

	/*
	 * renameApprover (ER00001)
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	oldNser
	 * @param	newUser
	 * <p>
	 * @return String
	 */
	public static String renameApprover(Connection conn,String campus,String oldUser,String newUser){

		int rowsRenamed = 0;

		try{

			// -- this is only the start. change approve outline tasks only
			// there are still reviews in progress to deal with
			// when changing from a review process, need to set back to approver who kicked off review
			// consider submittedby
			// -- also need to add new alphas to profiles

			// remove approval status from task
			rowsRenamed = renameApprover01(conn,campus,oldUser,newUser);
			System.out.println("renameApprover01: " + rowsRenamed);

			// switch to a new person, send mail for review, switch back, complete review

			// reviews
			//rowsRenamed = renameApprover02(conn,campus,oldUser,newUser);
			//System.out.println("renameApprover02: " + rowsRenamed);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: renameApprover - " + ex.toString());
		}

		return "";

	} // renameApprover

	/*
	 * renameApprover01 (ER00001)
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	oldNser
	 * @param	newUser
	 * <p>
	 * @return int
	 */
	public static int renameApprover01(Connection conn,String campus,String oldUser,String newUser){

		String kix = null;
		String alpha = null;
		String num = null;
		String submittedby = null;
		String title = null;
		String proposer = null;
		String taskMsg = Constant.APPROVAL_TEXT;

		String alphas = null;

		int rowsAffected = 0;
		int rowsRenamed = 0;

		try{
			// select all outlines where the task for approval is created for person in question (olduser)
			// qualifying outlines are PRE types and progress may be APPROVAL or DELETE.
			String sql = "SELECT c.historyid,c.CourseAlpha,c.CourseNum,c.coursetitle,c.proposer,t.submittedby "
							+ "FROM tblTasks t INNER JOIN tblCourse c ON t.campus = c.campus "
							+ "AND t.coursealpha = c.CourseAlpha "
							+ "AND t.coursenum = c.CourseNum "
							+ "WHERE c.campus=? "
							+ "AND t.message=? "
							+ "AND c.CourseType='PRE' "
							+ "AND t.submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,taskMsg);
			ps.setString(3,oldUser);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				// get all tasks for current user
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				if (alphas == null){
					alphas = alpha;
				}
				else{
					alphas = alphas + "," + alpha;
				}

				// remove from current user
				rowsAffected = TaskDB.logTask(conn,
														oldUser,
														oldUser,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);

				AseUtil.logAction(conn,
										oldUser,
										"REMOVE",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// add for new user
				rowsAffected = TaskDB.logTask(conn,
														newUser,
														submittedby,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.BLANK,
														Constant.TASK_APPROVER,
														kix,
														Constant.COURSE);

				AseUtil.logAction(conn,
										newUser,
										"ADD",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// send notification
				MailerDB mailerDB = new MailerDB(conn,
															proposer,
															newUser,
															"nextDelegate",
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalRequest",
															kix,
															newUser);

				++rowsRenamed;

			} // while
			rs.close();
			ps.close();

			// add these alphas to the user's profile
			if (alphas != null){
				int profiles = UserDB.updateUserAlphas(conn,newUser,alphas);

				AseUtil.logAction(conn,
										newUser,
										"ADD",
										"Added to user list of alphas",
										Util.removeDuplicateFromString(alphas),
										"",
										campus,
										kix);
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: renameApprover01 - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: renameApprover01 - " + ex.toString());
		}

		return rowsRenamed;

	} // renameApprover01

	/*
	 * renameApprover02 (ER00001)
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	oldNser
	 * @param	newUser
	 * <p>
	 * @return int
	 */
	public static int renameApprover02(Connection conn,String campus,String oldUser,String newUser){

		String kix = null;
		String alpha = null;
		String num = null;
		String submittedby = null;
		String title = null;
		String proposer = null;
		String taskMsg = Constant.REVIEW_TEXT;

		int rowsAffected = 0;
		int rowsRenamed = 0;

		// this is only the start. change approve outline tasks only
		// there are still reviews in progress to deal with
		try{
			String sql = "SELECT c.historyid,c.CourseAlpha,c.CourseNum,c.coursetitle,c.proposer,t.submittedby "
							+ "FROM tblTasks t INNER JOIN tblCourse c ON t.campus = c.campus "
							+ "AND t.coursealpha = c.CourseAlpha "
							+ "AND t.coursenum = c.CourseNum "
							+ "WHERE c.campus=? "
							+ "AND t.message=? "
							+ "AND c.CourseType='PRE' "
							+ "AND t.submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,taskMsg);
			ps.setString(3,oldUser);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				// get all tasks for current user
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				// remove from current user
				rowsAffected = TaskDB.logTask(conn,
														oldUser,
														oldUser,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);

				AseUtil.logAction(conn,
										oldUser,
										"REMOVE",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// add for new user
				rowsAffected = TaskDB.logTask(conn,
														newUser,
														submittedby,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.BLANK,
														Constant.TASK_REVIEWER,
														kix,
														Constant.COURSE);

				AseUtil.logAction(conn,
										newUser,
										"ADD",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// send notification
				MailerDB mailerDB = new MailerDB(conn,
															proposer,
															newUser,
															"nextDelegate",
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalRequest",
															kix,
															newUser);
			++rowsRenamed;

			} // while
			rs.close();
			ps.close();

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: renameApprover02 - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: renameApprover02 - " + ex.toString());
		}

		return rowsRenamed;

	} // renameApprover02

}
