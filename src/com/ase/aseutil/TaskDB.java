/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static Msg addApprovalTask(Connection conn,String kix,String nextApprover,String nextDelegate){
 *	public static int addTask(Connection conn,String campus,String user,String alpha,String num,int code)
 *	public static int correctProposerName(Connection conn){
 *	public static void createMailLogTasks(Connection conn,String campus,String user) throws Exception {
 *	public static String createMissingModifyTasks(Connection conn,String campus,String user) throws Exception {
 *	public static String createMissingProgramTasks(Connection conn,String campus,String user) throws Exception {
 *	public static long countUserTasks(Connection conn,String user)
 * public static int deleteTask(Connection connection,int sid)
 *	public static int deleteTask(Connection conn,String campus,String user,String alpha,String num,String message) {
 *	public static String getInviter(	Connection conn,String campus,String alpha,String num,String user){
 *	public static String getRole(	Connection conn,String campus,String alpha,String num,String user){
 *	public static String getSubmittedForByTaskMessage(	Connection conn,String campus,String alpha,String num,String task){
 *	public static String getUserTasks(Connection conn,String result,String campus)
 *	public static Task getUserTask(Connection conn,int task)
 *	public static int hasTask(	Connection conn,String campus,String user){
 *	public static int logTask(Connection connection,String submittedfor,String submittedby,String alpha,
 *										String num,String message,String campus,String source,String action)
 *	public static int recreateTasks(Connection connection,String message)
 *	public static int removeApprovalTask(Connection conn,String kix,String thisApprover,String thisDelegate){
 *	public static void removeDuplicateTasks(Connection conn,String campus,String user){
 * publick static removePendingApprovalTask(Connection conn,String campus,String user)
 *	public static void removeStrayTasks(Connection conn,String campus,String user) throws SQLException {
 *	public static int removeTask(Connection conn,String campus,String kix,String user,String msg) throws Exception {
 *	public static String showTaskByOutlineSA(Connection conn,String campus,String alpha,String num,String kix) throws Exception {
 *	public static String showUserTasksJQ(Connection conn,String userCampus,String user) throws Exception {
 * public static String showTaskByCampus(Connection conn,String campus,HttpServletRequest request,HttpServletResponse response)
 * public static String showTaskByUHID(Connection conn,String uhid,HttpServletRequest request,HttpServletResponse response)
 *
 * void close () throws SQLException{}
 *
 */

//
// TaskDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.paging.Paging;

public class TaskDB {
	static Logger logger = Logger.getLogger(TaskDB.class.getName());

	public TaskDB() throws Exception {}

	/*
	 * createAdjustment
	 * <p>
	 *	@param	campus	String
	 *	@param	user		String
	 */
	public static void createAdjustment(String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Connection conn = AsePool.createLongConnection();

		if (conn != null){

			//Cron.clearReviewers(conn,campus);

			//Cron.cleanCampusOutlinesTable(conn);

			//Cron.notYourTurn(conn);

			removeStrayTasks(conn,campus,user);

			removeDuplicateTasks(conn,campus,user);

			removeStrayReviewers(conn,campus);

			resetReviewStatus(conn,campus);

			createMissingModifyTasks(conn,campus,user);

			createMissingProgramTasks(conn,campus,user);

			createMailLogTasks(conn,campus,user);

			addMissingApprovalTask(conn,campus,user);

			removePendingApprovalTask(conn,campus,user);

			correctProposerName(conn);

			addMissingCampusData(conn,campus,user);

			// this works. we just want to use it only when necessary
			//correctTaskType(conn,campus);

			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("TaskDB: createAdjustment - " + e.toString());
			}
		}

	}

	/*
	 * isMatch
	 * <p>
	 *	@param	conn				Connection
	 *	@param	campus			String
	 *	@param	alpha				String
	 *	@param	num				String
	 */
	public static boolean isMatch(Connection conn,String campus,String alpha,String num) throws SQLException {

		String sql = "SELECT id FROM tblTasks WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype='PRE'";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}


	/*
	 * isMatch
	 * <p>
	 *	@param	conn				Connection
	 *	@param	submittedfor	String
	 *	@param	alpha				String
	 *	@param	num				String
	 *	@param	message			String
	 *	@param	campus			String
	 */
	public static boolean isMatch(Connection connection,
										String submittedfor,
										String alpha,
										String num,
										String message,
										String campus) throws SQLException {

		String sql = "SELECT coursealpha FROM tblTasks WHERE campus=? AND submittedfor=? AND courseAlpha=? AND coursenum=? AND " + TaskChartDB.getMessageText(message);
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,submittedfor);
		ps.setString(3,alpha);
		ps.setString(4,num);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatch
	 * <p>
	 *	@param	conn				Connection
	 *	@param	submittedfor	String
	 *	@param	kix				String
	 *	@param	message			String
	 *	@param	campus			String
	 */
	public static boolean isMatch(Connection connection,
											String submittedfor,
											String kix,
											String message,
											String campus) throws SQLException {

		String sql = "SELECT coursealpha FROM tblTasks " +
						"WHERE campus=? AND submittedfor=? AND historyid=? AND " + TaskChartDB.getMessageText(message);
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,submittedfor);
		ps.setString(3,kix);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatch
	 * <p>
	 *	@param	conn				Connection
	 *	@param	submittedfor	String
	 *	@param	kix				String
	 *	@param	alpha				String
	 *	@param	num				String
	 *	@param	message			String
	 *	@param	campus			String
	 */
	public static boolean isMatch(Connection connection,
											String submittedfor,
											String kix,
											String alpha,
											String num,
											String message,
											String campus) throws SQLException {

		String sql = "SELECT coursealpha FROM tblTasks WHERE campus=? " +
						"AND submittedfor=? AND historyid=? AND coursealpha=? AND coursenum=? AND " + TaskChartDB.getMessageText(message);
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,submittedfor);
		ps.setString(3,kix);
		ps.setString(4,alpha);
		ps.setString(5,num);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatchNoUserName
	 * <p>
	 *	@param	conn				Connection
	 *	@param	alpha				String
	 *	@param	num				String
	 *	@param	message			String
	 *	@param	campus			String
	 */
	public static boolean isMatchNoUserName(Connection connection,
														String alpha,
														String num,
														String message,
														String campus) throws SQLException {

		String sql = "SELECT coursealpha FROM tblTasks WHERE campus=? " +
					"AND courseAlpha=? AND coursenum=? AND " + TaskChartDB.getMessageText(message);
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatchNoUserName
	 * <p>
	 *	@param	conn				Connection
	 *	@param	kix				String
	 *	@param	message			String
	 *	@param	campus			String
	 */
	public static boolean isMatchNoUserName(Connection connection,
														String kix,
														String message,
														String campus) throws SQLException {

		String sql = "SELECT coursealpha FROM tblTasks " +
						"WHERE campus=? AND historyid=? AND " + TaskChartDB.getMessageText(message);
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,kix);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/*
	 * logTask
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		submittedfor
	 * @param	String		submittedby
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		message
	 * @param	String		campus
	 * @param	String		source
	 * @param	String		action
	 * @param	String		type
	 *	<p>
	 * @return int
	 */
	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type) throws Exception {


		String inviter = "";
		String kix = "";
		String role = "";
		String category = "";

		return logTask(connection,submittedfor,submittedby,alpha,num,message,campus,source,action,type,inviter,role,kix,category);

	}

	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter) throws Exception {

		String kix = "";
		String role = "";
		String category = "";

		return logTask(connection,submittedfor,submittedby,alpha,num,message,campus,source,action,type,inviter,role,kix,category);

	}

	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter,
										String role) throws Exception {

		String kix = "";
		String category = "";

		return logTask(connection,submittedfor,submittedby,alpha,num,message,campus,source,action,type,inviter,role,kix,category);

	}

	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter,
										String role,
										String kix) throws Exception {

		String category = "";

		return logTask(connection,submittedfor,submittedby,alpha,num,message,campus,source,action,type,inviter,role,kix,category);
	}

	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter,
										String role,
										String kix,
										String category) throws Exception {

		String progress = "";

		return logTask(connection,submittedfor,submittedby,alpha,num,message,campus,source,action,type,inviter,role,kix,category,progress);

	}

	public static int logTask(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter,
										String role,
										String kix,
										String category,
										String progress) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int rowsAffected = 0;

		String[] taskText = new String[3];

		PreparedStatement ps = null;

		String junk = null;
		boolean isDistributionList = false;
		String[] names = null;
		int iJunk = 0;

		boolean debug = false;

		boolean isAProgram = false;
		boolean foundation = false;

		try {
			debug = DebugDB.getDebug(connection,"TaskDB");

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			submittedfor = submittedfor.trim();
			submittedby = submittedby.trim();

			taskText[0] = message;
			taskText[1] = progress;
			taskText[2] = "";

			//
			// at this point, do not check for Constant.BLANK kix
			//
			String[] info = null;
			if (kix == null || kix.equals(Constant.SPACE)){
				kix = Helper.getKix(connection,campus,alpha,num,type);
				info = Helper.getKixInfo(connection,kix);
				type = info[Constant.KIX_TYPE];
			}

			//
			// program?
			//
			if (kix != null && kix.length() > 0){
				isAProgram = ProgramsDB.isAProgram(connection,kix);
			}

			//
			// are we working with foundation?
			//
			if(!isAProgram){
				if(kix != null && kix.length() > 0){
					foundation = fnd.isFoundation(connection,kix);
				}
				else{
					kix = fnd.getKix(connection,campus,alpha,num,type);
					foundation = fnd.isFoundation(connection,kix);
				}
			}

			// avoid a null problem
			if (type == null || type.equals(Constant.BLANK)){
				type = "CUR";
			}

			if (debug){
				logger.info("--------------------- logTask - start");
				logger.info("submittedfor: " + submittedfor);
				logger.info("submittedby: " + submittedby);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("message: " + message);
				logger.info("campus: " + campus);
				logger.info("source: " + source);
				logger.info("action: " + action);
				logger.info("type: " + type);
				logger.info("inviter: " + inviter);
				logger.info("role: " + role);
				logger.info("kix: " + kix);
				logger.info("category: " + category);
				logger.info("progress: " + progress);
				logger.info("isAProgram: " + isAProgram);
				logger.info("foundation: " + foundation);
			}

			taskText = getTaskMenuText(connection,taskText[0],campus,alpha,num,type,kix);

			// if we are not able to find the data in old format, restore
			if (taskText == null || taskText[0] == null || taskText[0].equals(Constant.BLANK)){
				taskText[0] = message;
				taskText[1] = progress;
			}

			if (debug){
				logger.info("taskText[0]: " + taskText[0]);
				logger.info("taskText[1]: " + taskText[1]);
				logger.info("taskText[2]: " + taskText[2]);
			}

			//
			// delete or add
			//
			if (action.equals(Constant.TASK_REMOVE) || action.equals(Constant.REMOVE)) {

				if (debug) logger.info("remove requested");

				if (submittedfor.equals(Constant.TASK_ALL)) {

					if (debug) logger.info("removing all");

					if(foundation){
						if (debug) logger.info("foundation");
						sql = "DELETE FROM tblTasks WHERE campus=? AND historyid=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,taskText[0]);
					}
					else if(isAProgram){
						if (debug) logger.info("isAProgram");
						sql = "DELETE FROM tblTasks WHERE campus=? AND historyid=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,taskText[0]);
					}
					else{
						if (debug) logger.info("isACourse");
						sql = "DELETE FROM tblTasks WHERE campus=? AND courseAlpha=? AND courseNum=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,taskText[0]);
					}
				}
				else{

					if (debug) logger.info("not removing all");

					// when coming in as a distribution list, we have to break it apart
					isDistributionList = DistributionDB.isDistributionList(connection,campus,submittedby);
					if (isDistributionList){
						if (debug) logger.info("isDistributionList");
						junk = DistributionDB.getDistributionMembers(connection,campus,submittedby);
					}
					else{
						if (debug) logger.info("not distributionList");
						junk = submittedby;
					}

					if (debug) logger.info("junk: " + junk);

					names = junk.split(",");
					for (iJunk = 0; iJunk < names.length; iJunk++){
						if (category != null && category.length() > 0 && kix != null && !kix.equals(Constant.BLANK)){
							if (debug) logger.info("has category: " + names[iJunk] + " - " + taskText[0]);
							sql = "DELETE FROM tblTasks WHERE campus=? AND submittedfor=? AND historyid=? AND category=? AND message=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,names[iJunk]);
							ps.setString(3,kix);
							ps.setString(4,category);
							ps.setString(5,taskText[0]);
						}
						else{
							if (debug) logger.info("no category: " + names[iJunk] + " - " + taskText[0]);
							sql = "DELETE FROM tblTasks WHERE campus=? AND courseAlpha=? AND courseNum=? AND submittedfor=? AND message=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							ps.setString(4,names[iJunk]);
							ps.setString(5,taskText[0]);
						} //(!().equals(kix))
					} // for

				}
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug){
					logger.info("deleted: " + rowsAffected);
				}

			}
			else if (action.equals(Constant.TASK_ADD) || action.equals(Constant.ADD)) {

				if (debug) logger.info("add requested");

				// make sure not there before adding
				boolean match = false;

				// when coming in as a distribution list, we have to break it apart
				junk = "";
				isDistributionList = DistributionDB.isDistributionList(connection,campus,submittedfor);
				if (isDistributionList){
					junk = DistributionDB.getDistributionMembers(connection,campus,submittedfor);
				}
				else{
					junk = submittedfor;
				}

				names = junk.split(",");
				for (iJunk = 0; iJunk < names.length; iJunk++){
					if (kix != null && kix.length() > 0){
						match = TaskDB.isMatch(connection,names[iJunk],kix,alpha,num,taskText[0],campus);
					}
					else{
						match = TaskDB.isMatch(connection,names[iJunk],alpha,num,taskText[0],campus);
					}

					// only create task once for same key item
					if (!match){

						String proposer = "";

						info = null;

						if(foundation){
							info = fnd.getKixInfo(connection,kix);
							type = info[Constant.KIX_TYPE];
							proposer = info[Constant.KIX_PROPOSER];
						}
						else{
							// submitted by is always going to be the proposer
							if (kix != null && kix.length() > 0){
								info = Helper.getKixInfo(connection,kix);
								type = info[Constant.KIX_TYPE];
								proposer = info[Constant.KIX_PROPOSER];
							}
							else{
								if (type == null || type.length() == 0){
									type = "PRE";
								}

								proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,type);
							}
						}

						sql = "INSERT INTO tblTasks (submittedfor,submittedby,coursealpha,coursenum,message,dte,campus,coursetype,inviter,role,historyid,category,progress) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
						ps = connection.prepareStatement(sql);
						ps.setString(1,names[iJunk]);
						ps.setString(2,proposer);
						ps.setString(3,alpha);
						ps.setString(4,num);
						ps.setString(5,taskText[0]);
						ps.setString(6,AseUtil.getCurrentDateTimeString());
						ps.setString(7,campus);
						ps.setString(8,type);
						ps.setString(9,inviter);
						ps.setString(10,role);
						ps.setString(11,kix);
						ps.setString(12,category);
						ps.setString(13,taskText[1]);
						rowsAffected = ps.executeUpdate();
						ps.close();
					}
					else{
						if (debug){
							logger.info("task found for " + names[iJunk] + " - " + campus + " - " + alpha + " - " + num + " - " + taskText[0]);
						}
					}

				} // for

			}

			if (rowsAffected > 0) {
				AseUtil aseUtil = new AseUtil();

				if (taskText[0].equals(Constant.REVIEW_TEXT) || taskText[0].equals(Constant.APPROVAL_TEXT))
					taskText[0] = taskText[0] + " (" + submittedfor + ")";

				if (category.equals(Constant.PROGRAM)){
					taskText[0] = taskText[0] + " - " + alpha;
					alpha = "";
					num = "";
				}

				aseUtil.logAction(connection,submittedby,action,taskText[0],alpha,num,campus,kix);

				aseUtil = null;
			}

			fnd = null;

			if (debug){
				logger.info("--------------------- logTask - end");
			}

		} catch (Exception e) {
			logger.fatal("TaskDB: logTask\n"
				+ "action: " + action
				+ "\n"
				+ "message: " +  taskText[0]
				+ "\n"
				+ "submittedfor: " +  submittedfor
				+ "\n"
				+ "submittedby: " +  submittedby
				+ "\n"
				+ e.toString());
		}

		return rowsAffected;
	}

	public static int logTaskOBSOLETE(Connection connection,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action,
										String type,
										String inviter,
										String role,
										String kix,
										String category,
										String progress) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int rowsAffected = 0;

		String[] taskText = new String[3];

		PreparedStatement ps = null;

		String junk = null;
		boolean isDistributionList = false;
		String[] names = null;
		int iJunk = 0;

		boolean debug = false;

		boolean isAProgram = false;
		boolean foundation = false;

		try {
			debug = DebugDB.getDebug(connection,"TaskDB");

			//debug = true;

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			submittedfor = submittedfor.trim();
			submittedby = submittedby.trim();

			taskText[0] = message;
			taskText[1] = progress;
			taskText[2] = "";

			//
			// at this point, do not check for Constant.BLANK kix
			//
			String[] info = null;
			if (kix == null || kix.equals(Constant.SPACE)){
				kix = Helper.getKix(connection,campus,alpha,num,type);
				info = Helper.getKixInfo(connection,kix);
				type = info[Constant.KIX_TYPE];
			}

			//
			// program?
			//
			if (kix != null && kix.length() > 0){
				isAProgram = ProgramsDB.isAProgram(connection,kix);
			}

			//
			// are we working with foundation?
			//
			if(!isAProgram){
				if(kix != null){
					foundation = fnd.isFoundation(connection,kix);
				}
				else{
					kix = fnd.getKix(connection,campus,alpha,num,type);
					foundation = fnd.isFoundation(connection,kix);
				}
			}

			// avoid a null problem
			if (type == null || type.equals(Constant.BLANK)){
				type = "CUR";
			}

			if (debug){
				logger.info("--------------------- logTask - start");
				logger.info("submittedfor: " + submittedfor);
				logger.info("submittedby: " + submittedby);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("message: " + message);
				logger.info("campus: " + campus);
				logger.info("source: " + source);
				logger.info("action: " + action);
				logger.info("type: " + type);
				logger.info("inviter: " + inviter);
				logger.info("role: " + role);
				logger.info("kix: " + kix);
				logger.info("category: " + category);
				logger.info("progress: " + progress);
			}

			taskText = getTaskMenuText(connection,taskText[0],campus,alpha,num,type,kix);

			// if we are not able to find the data in old format, restore
			if (taskText == null || taskText[0] == null || taskText[0].equals(Constant.BLANK)){
				taskText[0] = message;
				taskText[1] = progress;
			}

			if (debug){
				logger.info("taskText[0]: " + taskText[0]);
				logger.info("taskText[1]: " + taskText[1]);
				logger.info("taskText[2]: " + taskText[2]);
			}

			// delete or add
			if (action.equals(Constant.TASK_REMOVE)) {

				if (debug) logger.info("remove requested");

				if (submittedfor.equals(Constant.TASK_ALL)) {

					if (debug) logger.info("removing all");

					if(foundation){
						if (debug) logger.info("foundation");
						sql = "DELETE FROM tblTasks WHERE campus=? AND historyid=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,taskText[0]);
					}
					else if(isAProgram){
						if (debug) logger.info("isAProgram");
						sql = "DELETE FROM tblTasks WHERE campus=? AND historyid=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,taskText[0]);
					}
					else{
						if (debug) logger.info("isACourse");
						sql = "DELETE FROM tblTasks WHERE campus=? AND courseAlpha=? AND courseNum=? AND message=?";
						ps = connection.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,taskText[0]);
					}
				}
				else{

					if (debug) logger.info("not removing all");

					// when coming in as a distribution list, we have to break it apart
					isDistributionList = DistributionDB.isDistributionList(connection,campus,submittedby);
					if (isDistributionList){
						if (debug) logger.info("isDistributionList");
						junk = DistributionDB.getDistributionMembers(connection,campus,submittedby);
					}
					else{
						if (debug) logger.info("not distributionList");
						junk = submittedby;
					}

					if (debug) logger.info("junk: " + junk);

					names = junk.split(",");
					for (iJunk = 0; iJunk < names.length; iJunk++){
						if (category != null && category.length() > 0 && kix != null && !kix.equals(Constant.BLANK)){
							if (debug) logger.info("has category: " + names[iJunk] + " - " + taskText[0]);
							sql = "DELETE FROM tblTasks WHERE campus=? AND submittedfor=? AND historyid=? AND category=? AND message=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,names[iJunk]);
							ps.setString(3,kix);
							ps.setString(4,category);
							ps.setString(5,taskText[0]);
						}
						else{
							if (debug) logger.info("no category: " + names[iJunk] + " - " + taskText[0]);
							sql = "DELETE FROM tblTasks WHERE campus=? AND courseAlpha=? AND courseNum=? AND submittedfor=? AND message=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							ps.setString(4,names[iJunk]);
							ps.setString(5,taskText[0]);
						} //(!().equals(kix))
					} // for

				}
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug){
					logger.info("deleted: " + rowsAffected);
				}

			}
			else if (action.equals(Constant.TASK_ADD)) {

				if (debug) logger.info("add requested");

				// make sure not there before adding
				boolean match = false;

				// when coming in as a distribution list, we have to break it apart
				junk = "";
				isDistributionList = DistributionDB.isDistributionList(connection,campus,submittedfor);
				if (isDistributionList){
					junk = DistributionDB.getDistributionMembers(connection,campus,submittedfor);
				}
				else{
					junk = submittedfor;
				}

				names = junk.split(",");
				for (iJunk = 0; iJunk < names.length; iJunk++){
					if (kix != null && kix.length() > 0){
						match = TaskDB.isMatch(connection,names[iJunk],kix,alpha,num,taskText[0],campus);
					}
					else{
						match = TaskDB.isMatch(connection,names[iJunk],alpha,num,taskText[0],campus);
					}

					// only create task once for same key item
					if (!match){

						String proposer = "";

						info = null;

						if(foundation){
							info = fnd.getKixInfo(connection,kix);
							type = info[Constant.KIX_TYPE];
							proposer = info[Constant.KIX_PROPOSER];
						}
						else{
							// submitted by is always going to be the proposer
							if (kix != null && kix.length() > 0){
								info = Helper.getKixInfo(connection,kix);
								type = info[Constant.KIX_TYPE];
								proposer = info[Constant.KIX_PROPOSER];
							}
							else{
								if (type == null || type.length() == 0){
									type = "PRE";
								}

								proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,type);
							}
						}

						sql = "INSERT INTO tblTasks (submittedfor,submittedby,coursealpha,coursenum,message,dte,campus,coursetype,inviter,role,historyid,category,progress) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
						ps = connection.prepareStatement(sql);
						ps.setString(1,names[iJunk]);
						ps.setString(2,proposer);
						ps.setString(3,alpha);
						ps.setString(4,num);
						ps.setString(5,taskText[0]);
						ps.setString(6,AseUtil.getCurrentDateTimeString());
						ps.setString(7,campus);
						ps.setString(8,type);
						ps.setString(9,inviter);
						ps.setString(10,role);
						ps.setString(11,kix);
						ps.setString(12,category);
						ps.setString(13,taskText[1]);
						rowsAffected = ps.executeUpdate();
						ps.close();
					}
					else{
						if (debug){
							logger.info("task found for " + names[iJunk] + " - " + campus + " - " + alpha + " - " + num + " - " + taskText[0]);
						}
					}

				} // for

			}

			if (rowsAffected > 0) {
				AseUtil aseUtil = new AseUtil();

				if (taskText[0].equals(Constant.REVIEW_TEXT) || taskText[0].equals(Constant.APPROVAL_TEXT))
					taskText[0] = taskText[0] + " (" + submittedfor + ")";

				if (category.equals(Constant.PROGRAM)){
					taskText[0] = taskText[0] + " - " + alpha;
					alpha = "";
					num = "";
				}

				aseUtil.logAction(connection,submittedby,action,taskText[0],alpha,num,campus,kix);

				aseUtil = null;
			}

			fnd = null;

			if (debug){
				logger.info("--------------------- logTask - end");
			}

		} catch (Exception e) {
			logger.fatal("TaskDB: logTask\n"
				+ "action: " + action
				+ "\n"
				+ "message: " +  taskText[0]
				+ "\n"
				+ "submittedfor: " +  submittedfor
				+ "\n"
				+ "submittedby: " +  submittedby
				+ "\n"
				+ e.toString());
		}

		return rowsAffected;
	}

	/*
	 * logTask
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		submittedfor
	 * @param	String		submittedby
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		message
	 * @param	String		campus
	 * @param	String		source
	 * @param	String		action
	 *	<p>
	 * @return int
	 */
	public static int logTask(Connection conn,
										String submittedfor,
										String submittedby,
										String alpha,
										String num,
										String message,
										String campus,
										String source,
										String action) throws Exception {

		int rowsAffected = logTask(conn,
											submittedfor.trim(),
											submittedby.trim(),
											alpha,
											num,
											message,
											campus,
											source,
											action,
											Constant.BLANK);

		return rowsAffected;
	}

	/*
	 * countUserTasks
	 *	<p>
	 * @return long
	 */
	public static long countUserTasks(Connection conn,String user) throws Exception {

		long taskCount = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			taskCount = aseUtil.countRecords(conn,
								"tblTasks",
								"WHERE submittedfor = " + aseUtil.toSQL(user,1) + " AND coursetype = 'PRE'" );
		} catch (Exception e) {
			logger.fatal("TaskDB: countUserTasks\n" + e.toString());
		}

		return taskCount;
	}

	public static long countUserTasks(Connection conn,String campus,String user) throws Exception {

		long taskCount = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			taskCount = aseUtil.countRecords(conn,
								"tblTasks",
								"WHERE campus = " + aseUtil.toSQL(campus,1)
								+ " AND submittedfor = " + aseUtil.toSQL(user,1)
								+ " AND coursetype = 'PRE'");
		} catch (Exception e) {
			logger.fatal("TaskDB: countUserTasks\n" + e.toString());
		}

		return taskCount;
	}

	/*
	 * getUserTask
	 *	<p>
	 * @return Task
	 */
	public static Task getUserTask(Connection conn,int task) throws Exception {

		String sql = "SELECT campus,submittedfor,submittedby,coursealpha,coursenum,message,dte FROM tblTasks WHERE id=?";
		Task userTask = new Task();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,task);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				userTask.setCampus(aseUtil.nullToBlank(rs.getString("campus")));
				userTask.setSubmittedFor(aseUtil.nullToBlank(rs.getString("submittedfor")));
				userTask.setSubmittedBy(aseUtil.nullToBlank(rs.getString("submittedby")));
				userTask.setCourseAlpha(aseUtil.nullToBlank(rs.getString("coursealpha")));
				userTask.setCourseNum(aseUtil.nullToBlank(rs.getString("coursenum")));
				userTask.setMessage(aseUtil.nullToBlank(rs.getString("message")));
				userTask.setDte(aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("TaskDB: getUserTask\n" + e.toString());
		}

		return userTask;
	}

	/*
	 * getUserTask
	 *	<p>
	 * @return Task
	 */
	public static Task getUserTask(Connection conn,String campus,String alpha,String num,String submittedby,String submittedfor) throws Exception {

		Task userTask = null;
		try {
			AseUtil aseUtil = new AseUtil();

			userTask = new Task();
			String sql = "SELECT campus,submittedfor,submittedby,message,dte FROM tblTasks WHERE campus=? AND coursealpha=? AND coursenum=? and submittedby=? and submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,submittedby);
			ps.setString(5,submittedfor);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				userTask.setCampus(aseUtil.nullToBlank(rs.getString("campus")));
				userTask.setSubmittedFor(aseUtil.nullToBlank(rs.getString("submittedfor")));
				userTask.setSubmittedBy(aseUtil.nullToBlank(rs.getString("submittedby")));
				userTask.setCourseAlpha(aseUtil.nullToBlank(alpha));
				userTask.setCourseNum(aseUtil.nullToBlank(num));
				userTask.setMessage(aseUtil.nullToBlank(rs.getString("message")));
				userTask.setDte(aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("TaskDB: getUserTask\n" + e.toString());
		}

		return userTask;
	}

	/*
	 * deleteTaskByID
	 *	<p>
	 * @return int
	 */
	public static int deleteTaskByID(Connection conn,int id) {

		int rowsAffected = 0;

		String sql = "DELETE FROM tblTasks WHERE id=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TaskDB: deleteTaskByID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("TaskDB: deleteTaskByID - " + ex.toString());
		}
		return rowsAffected;
	}

	/*
	 * deleteTask
	 *	<p>
	 * @return int
	 */
	public static int deleteTask(Connection connection,int sid,String uid) {

		int rowsAffected = 0;

		String sql = "";
		try {
			// need to get task info before deleting it.
			Task task = getUserTask(connection,sid);

			sql = "DELETE FROM tblTasks WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,sid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (task != null && (Constant.REVIEW_TEXT).equals(task.getMessage())){
				String campus = task.getCampus();
				String alpha = task.getCourseAlpha();
				String num = task.getCourseNum();
				sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND userid=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,uid);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("TaskDB: deleteTask - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("TaskDB: deleteTask - " + ex.toString());
		}
		return rowsAffected;
	}

	/*
	 * deleteTask
	 *	<p>
	 * @return int
	 */
	public static int deleteTask(Connection conn,String campus,String user,String alpha,String num,String message) {

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblTasks WHERE campus=? "
							+ "AND submittedfor=? AND coursealpha=? AND coursenum=? AND " + TaskChartDB.getMessageText(message);
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,alpha);
			ps.setString(4,num);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (rowsAffected > 0){
				String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

				AseUtil.logAction(conn,
										user,
										"ACTION",
										"Deleted outline approval task",
										alpha,
										num,
										campus,
										kix);
			}
		} catch (SQLException e) {
			logger.fatal("TaskDB: deleteTask - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("TaskDB: deleteTask - " + ex.toString());
		}
		return rowsAffected;
	}

	/*
	 * recreateTasks
	 *	<p>
	 * @return int
	 */
	public static int recreateTasks(Connection conn,String tsk) {

		int rowsAffected = 0;
		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";
		String message = "";
		String proposer = "";

		String sql = "SELECT campus,courseAlpha,courseNum,coursetype,proposer " +
			"FROM tblCourse " +
			"WHERE (proposer<>'' And Not proposer Is Null) AND " +
			"Progress=? AND coursetype=? ORDER BY campus, CourseAlpha, CourseNum";
		try {

			if (tsk.equals("MO")){
				message = "Modify outline";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,"MODIFY");
			ps.setString(2,"PRE");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				campus = aseUtil.nullToBlank(rs.getString("campus"));
				alpha = aseUtil.nullToBlank(rs.getString("courseAlpha"));
				num = aseUtil.nullToBlank(rs.getString("courseNum"));
				type = aseUtil.nullToBlank(rs.getString("coursetype"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				rowsAffected = logTask(conn,proposer,proposer,alpha,num,message,campus,"source","ADD",type);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TaskDB: recreateTasks\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("TaskDB: recreateTasks\n" + ex.toString());
		}
		return rowsAffected;
	}

	/*
	 * showTaskByCampus
	 * <p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * @param	HttpServletRequest		request
	 * @param	HttpServletResponse		response
	 * <p>
	 * @return String
	 */
	public static String showTaskByCampus(Connection conn,
												String campus,
												HttpServletRequest request,
												HttpServletResponse response) throws Exception {

		String temp = "";

		temp = "SELECT DISTINCT submittedfor, submittedfor As UHID, COUNT(submittedfor) AS Tasks " +
			"FROM tblTasks GROUP BY campus, submittedfor " +
			"HAVING campus='"+ campus + "' ORDER BY submittedfor";

		return temp;
	}

	/*
	 * showTaskByOutlineSA
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String showTaskByOutlineSA(Connection conn,String campus,String alpha,String num,String kix) throws Exception {

		String temp = "";
		String submittedFor = "";
		String sql = "";
		boolean found = false;
		StringBuffer listings = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT  submittedfor, message, dte FROM tblTasks "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? ORDER BY dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				submittedFor = rs.getString("submittedfor");
				listings.append("<tr height=\"30\">");
				listings.append("<td class=\"datacolumn\"><a href=\"/central/servlet/sa?c=dtsk&kix="+kix+"&usr="+submittedFor+"\" class=\"linkcolumn\">" + submittedFor + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + rs.getString(2) + "</td>");
				listings.append("<td class=\"datacolumn\">"
					+ aseUtil.ASE_FormatDateTime(aseUtil.nullToBlank(rs.getString("dte")),Constant.DATE_DATETIME)
					+ "</td>");
				listings.append("</tr>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ listings.toString()
					+ "</table>";
			}

		}catch(Exception e){
			logger.fatal("TaskDB: showTaskByOutlineSA\n" + e.toString());
		}

		return temp;
	}

	/*
	 * showTaskByUHID
	 * <p>
	 * @param	Connection	conn
	 * @param	String		uhid
	 * @param	HttpServletRequest		request
	 * @param	HttpServletResponse		response
	 * <p>
	 * @return String
	 */
	public static String showTaskByUHID(Connection conn,
												String uhid,
												HttpServletRequest request,
												HttpServletResponse response) throws Exception {

		String temp = "";

		temp = "SELECT id, coursealpha AS Alpha, coursenum AS Number, submittedby AS [Submitted By], message As Task, dte AS [Date] " +
			"FROM tblTasks WHERE submittedfor='"+ uhid + "' " +
			"ORDER BY coursealpha, coursenum, submittedby";

		return temp;
	}

	/*
	 * showUserTasksJQ
	 * <p>
	 * @param	Connection	conn
	 * @param	String		userCampus
	 * @param	String		user
	 * @param	admin			String
	 * <p>
	 * @return String
	 */
	public static String showUserTasksJQ(Connection conn,String userCampus,String user) throws Exception {

		return showUserTasksJQ(conn,userCampus,user,false);
	}

	public static String showUserTasksJQ(Connection conn,String userCampus,String user,boolean admin) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int counter = 0;

		String temp = "";
		String link = "";
		String outlineType = "";
		String proposer = "";
		String category = "";
		String id = "";
		String campus = "";
		String adminColumn = "";
		String degree = "";

		int route = 0;

		String[] info = null;

		try{
			// clear out existing data for user
			int rowsAffected = com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);

			AseUtil au = new AseUtil();

			//---------------------------------------
			// tasks
			//---------------------------------------
			String sql = "SELECT id,submittedfor,submittedby,Coursealpha,Coursenum,Coursetype,Message,dte,Campus,historyid,progress "
				+ "FROM tblTasks WHERE campus=? AND submittedfor=? AND coursetype='PRE' ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,userCampus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				id = AseUtil.nullToBlank(rs.getString("id"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("Coursetype"));
				String msg = AseUtil.nullToBlank(rs.getString("message"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String submittedFor = AseUtil.nullToBlank(rs.getString("submittedFor"));
				String submittedBy = AseUtil.nullToBlank(rs.getString("submittedby"));
				String taskProgress= AseUtil.nullToBlank(rs.getString("progress"));

				// locate the task to create proper HREF tags
				String href = "";
				String actions = "";

				boolean courseExistByTypeCampus = false;

				if (kix == null || kix.equals(Constant.BLANK)){
					kix = Helper.getKix(conn,campus,alpha,num,type);
				}

				// outline or program or foundation
				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
				boolean foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

				if(foundation){
					info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
					proposer = info[Constant.KIX_PROPOSER];
					route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
					category = Constant.FOUNDATION;
				}
				else{
					if (!isAProgram){
						info = Helper.getKixInfo(conn,kix);
						proposer = info[Constant.KIX_PROPOSER];
						route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
						category = Constant.COURSE;
						courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");
					}
					else if (!kix.equals(Constant.BLANK) && msg.toLowerCase().indexOf("program") > -1){
						info = ProgramsDB.getKixInfo(conn,kix);
						alpha = info[Constant.KIX_PROGRAM_TITLE];
						num = info[Constant.KIX_PROGRAM_DIVISION];
						type = info[Constant.KIX_TYPE];
						proposer = info[Constant.KIX_PROPOSER];
						route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
						category = Constant.PROGRAM;
						degree = ProgramsDB.getProgramDegreeDescr(conn,kix);
					}
					else{
						href = "&alpha=" + alpha + "&num=" + num + "&campus=" + campus + "&view=" + type;
					}
				}

				if (submittedBy.equals(Constant.BLANK)){
					submittedBy = proposer;
				}

				String[] taskText = getTaskMenuText(conn,msg,campus,alpha,num,type,kix);
				String displayedTask = taskText[Constant.TASK_MESSAGE];
				taskProgress = taskText[Constant.TASK_PROGRESS];
				String source = taskText[Constant.TASK_SRC];

				// for programs, we don't need to include other arguments
				if (isAProgram){
					href = "";
				}

				actions = "<a class=\"linkcolumn\" href=\"" + source + ".jsp?kix=" + kix + href + "\">"+displayedTask+"</a>";

				if (admin){
					adminColumn = "<a href=\"usrtsks03.jsp?sid="+user+"&id="+id+"\"><img src=\"../images/del.gif\" border=\"0\" alt=\"delete this task\" title=\"delete this task\"></a>";
				}

				// create links
				if (category.equals(Constant.FOUNDATION)){
					link = "vwpdf.jsp?cps="+campus+"&kix="+kix;
					temp = "<a href=\"" + link + "\" class=\"linkcolumn\" title=\"view foundation course\" target=\"_blank\">" + alpha + " " + num + "</a>";
				}
				else if (category.equals(Constant.PROGRAM)){
					link = "vwhtml.jsp?cps="+campus+"&kix="+kix;
					temp = "<a href=\"" + link + "\" class=\"linkcolumn\" title=\"view program\" target=\"_blank\">" + alpha + " (" + degree + ")</a>";
				}
				else{
					if(!kix.equals(Constant.BLANK)){

						// this approach shows the HTML created for outlines. however, on task screen, likely in PRE mode,
						// let's make sure it recreates.
						//String htmlName = com.ase.aseutil.io.Util.getHtmlNameIfExists(conn,campus,Constant.COURSE,kix,alpha,num);
						//temp = "<a href=\"" + htmlName + "\" class=\"linkcolumn\" target=\"_blank\" title=\"view outline\">" + alpha + " " + num + "</a>";
						//link = "vwcrsy.jsp?kix="+kix;
						link = "vwcrsy.jsp?pf=1&kix="+kix+"&comp=1";
						temp = "<a href=\"" + link + "\" class=\"linkcolumn\" target=\"_blank\" title=\"view outline\">" + alpha + " " + num + "</a>";

					}
					else{
						link = "vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t="+type;
						temp = "<a href=\"" + link + "\" class=\"linkcolumn\" title=\"view outline\">" + alpha + " " + num + "</a>";
					}
				}

				taskProgress = "<a href=\"vwlog.jsp?kix="+kix+"\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'asevwlog','800','600','yes','center');return false\" onfocus=\"this.blur()\">"+taskProgress+"</a>";

				com.ase.aseutil.report.ReportingStatusDB.insert(conn,
								new com.ase.aseutil.report.ReportingStatus(user,
																						submittedFor,
																						proposer,
																						taskProgress,
																						temp,
																						actions,
																						au.ASE_FormatDateTime(au.nullToBlank(rs.getString("dte")),Constant.DATE_DATETIME),
																						campus,
																						adminColumn,
																						"",
																						Constant.COURSE,
																						kix));

			} // while
			rs.close();
			ps.close();

			//---------------------------------------
			// cnv25 - add other non-critical type tasks (filedrop)
			//---------------------------------------
			com.ase.aseutil.db.FileDrop fd = new com.ase.aseutil.db.FileDrop();
			if (fd.getFileCount(conn,userCampus,user) > 0){

				sql = "SELECT DISTINCT src FROM tblfiledrop WHERE campus=? AND userid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,userCampus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				while(rs.next()){

				com.ase.aseutil.report.ReportingStatusDB.insert(conn,
								new com.ase.aseutil.report.ReportingStatus(user,
																						user,
																						user,
																						"CREATED",
																						"",
																						"<a href=\"crscat.jsp\" class=\"linkcolumn\">"+AseUtil.nullToBlank(rs.getString("src"))+"</a>",
																						"",
																						campus,
																						adminColumn,
																						"",
																						Constant.COURSE));

				} // while
				rs.close();
				ps.close();

			} // file drop

			//---------------------------------------
			// cnv18 - message board
			//---------------------------------------
			String createTaskForMessageBoard =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CreateTaskForMessageBoard");

			if (createTaskForMessageBoard.equals(Constant.ON)){

				if (ForumDB.getReplyCount(conn,user) > 0){

				com.ase.aseutil.report.ReportingStatusDB.insert(conn,
								new com.ase.aseutil.report.ReportingStatus(user,
																						user,
																						user,
																						"POSTS",
																						"",
																						"<a href=\"msgbrd.jsp\" class=\"linkcolumn\">Message Board</a>",
																						"",
																						campus,
																						adminColumn,
																						"",
																						Constant.COURSE));

				} // message board

			} // createTaskForMessageBoard

			//---------------------------------------
			// clean up
			//---------------------------------------
			au = null;


		} catch (Exception e) {
			logger.fatal("TaskDB.showUserTasksJQ ("+user+"): " + e.toString());
		}

		return "";
	} // TaskDB: showUserTasksJQ

	/*
	 * addTask
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	code		int
	 * <p>
	 * @return	int
	 */
	public static int addTask(Connection conn,String campus,String user,String alpha,String num,int code){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String proposer = "";
		String progress = "";
		String type = "";
		String task = "";

		int rowsAffected = 0;

		ResultSet rs = null;
		PreparedStatement ps = null;

		/*
			for modify outline task
				1) make sure the task is in MODIFY progress
				2) if task not created, create 1
		*/

		try {
			type = "PRE";
			sql = "SELECT historyid,proposer,progress FROM tblCourse "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			rs = ps.executeQuery();
			if (rs.next()){
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
			}
			rs.close();
			ps.close();

			switch(code){
				case Constant.APPROVAL:
					task = Constant.APPROVAL_TEXT;
					if (progress.equals(Constant.COURSE_APPROVAL_TEXT) || progress.equals(Constant.COURSE_DELETE_TEXT)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
						}
						else
							rowsAffected = 1;
					}

					break;
				case Constant.MODIFY:
					task = Constant.MODIFY_TEXT;
					if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
						}
						else
							rowsAffected = 1;
					}

					break;
				case Constant.REVIEW:
					task = Constant.REVIEW_TEXT;
					if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
						task = task.replace("_"," ");
						if (!TaskDB.isMatch(conn,user,alpha,num,task,campus)){
							rowsAffected = TaskDB.logTask(conn,user,proposer,alpha,num,task,campus,"","ADD",type);
							rowsAffected = ReviewerDB.addCourseReviewer(conn,campus,alpha,num,user,proposer);
						}
						else
							rowsAffected = 1;
					}

					break;
			}	// switch

		} catch (Exception e) {
			logger.fatal("TaskDB: addTask - " + e.toString());
		}

		return rowsAffected;
	} // TaskDB: addTask

	/*
	 * removeStrayTasks
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void removeStrayTasks(Connection conn,String campus,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//-----------------------------------------------------------------------------------------
		//
		// READ ME: any work here should be matched with com.ase.aseutil.test.StrayTaskTest
		//
		//-----------------------------------------------------------------------------------------

		String message = "";
		String alpha = "";
		String num = "";
		String type = "";
		String kix = "";
		String outlineProgress = "";
		String taskProgress = "";
		String outlineProgressStep = "";
		int rowsAffected = 0;
		int cleaned = 0;
		String reason = "";
		String category = "";

		int id = 0;

		boolean delete = false;
		boolean reviewDuringApprovalAllowed = false;
		boolean debug = false;
		boolean test = false;
		boolean isAProgram = false;
		boolean foundation = false;

		boolean programExistByTypeCampus = false;
		boolean courseExistByTypeCampus = false;
		boolean fndExistByTypeCampus = false;

		String today = (new SimpleDateFormat("MM/dd/yyyy")).format(new java.util.Date());
		String reviewDate = "";
		String subprogress = "";
		String taskType = "";

		// stray tasks are tasks not found with corresponding coures work
		try{
			debug = DebugDB.getDebug(conn,"TaskDB");

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			RenameDB renameDB = new RenameDB();

			String sql = "SELECT id,coursealpha,coursenum,coursetype,message,historyid,category "
				+ "FROM tblTasks WHERE campus=? AND submittedfor=? ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				reviewDuringApprovalAllowed = false;
				isAProgram = false;
				outlineProgressStep = "";

				id = rs.getInt("id");

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				category = AseUtil.nullToBlank(rs.getString("category"));
				message = AseUtil.nullToBlank(rs.getString("message"));

				// historyid does not always exists in task. if so, use alpha, num to find kix
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix == null || kix.length() == 0){
					kix = Helper.getKix(conn,campus,alpha,num,type);
				}

				isAProgram = ProgramsDB.isAProgram(conn,kix);
				if(!isAProgram){
					foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
				}

				//
				// type that exists
				//
				programExistByTypeCampus = ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR");
				courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");
				fndExistByTypeCampus = fnd.existByTypeCampus(conn,campus,kix,"CUR");

				//
				// subprogress
				//
				if(foundation){
					subprogress = fnd.getFndItem(conn,kix,"subprogress");
				}
				else if(isAProgram){
					subprogress = ProgramsDB.getItem(conn,kix,"subprogress");
				}
				else{
					subprogress = Outlines.getSubProgress(conn,kix);
				}

				// set to proper type for task progress
				type = "PRE";
				String[] taskText = getTaskMenuText(conn,message,campus,alpha,num,type,kix);
				taskProgress = taskText[Constant.TASK_PROGRESS];

				// review date
				if (!category.equals(Constant.PROGRAM) && message.toLowerCase().indexOf("review") > -1){
					reviewDate = CourseDB.getCourseItem(conn,kix,"reviewdate");
				}

				// get current progress from outline/program
				if (category.equals(Constant.FOUNDATION)){
					outlineProgress = fnd.getFndItem(conn,kix,"progress");
				}
				else if (category.equals(Constant.PROGRAM)){
					outlineProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				}
				else{
					outlineProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

					if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL))
						reviewDuringApprovalAllowed = true;
				}

				reason = "";
				delete = false;

				// if the task is there but the user is not the proposer of the item in modify progress, delete
				// if review task exists but not in review, delete only if not a review within approval
				// if approval task exists but not in approval, delete

				/*
					11 - task to approve or create and program not exist, delete
					21 - if delete and outline is not delete, delete
					31 - if both not modify, delete
					41 - if a program but missing progress, delete
					51 - 11
					61 - if reviewing but not in review or review in approval, delete
					71 - if approval but not in approval or delete, delete
				*/

// the problem with this approach is the special check for each condition other than the rule variables.
// for example, see step 100 where a check for program existing.

// trying to simplify the if-else checking

debug = false;

String rules = (foundation + "_" + isAProgram + "_" + taskProgress + "_" + outlineProgress + "_" + message).toLowerCase().replace(" ","_");

				if (foundation){

					if (taskProgress.toLowerCase().equals("new")){
						if (message.toLowerCase().indexOf("review") > -1){
							taskProgress = "REVIEW";
							outlineProgressStep = "001";
						}
						else if (message.toLowerCase().indexOf("work") > -1){
							taskProgress = "MODIFY";
							outlineProgressStep = "002";
						}
						else{
							outlineProgressStep = "*** 0002";
						}
					}

					if (taskProgress.toLowerCase().indexOf("approv") > -1){

						if (message.toLowerCase().equals("approve added foundation")){

							if(pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
								delete = true;
								reason = "foundation course pending approval task not available";
								outlineProgressStep = "step: 100";
							}
							else{
								outlineProgressStep = "*** 1000";
							}

						}
						else if (outlineProgress.equals(Constant.COURSE_CREATE_TEXT) &&
								!fnd.existByTypeCampus(conn,campus,kix,type)){

							// a task exists but the foundation does not so delete
							delete = true;
							reason = "not allowed to approve";
							outlineProgressStep = "step: 106";
							taskType = "approval";
						}
						else{
							outlineProgressStep = "*** 1060";
						}

					}
					else if (taskProgress.toLowerCase().indexOf("delete") > -1 && !outlineProgress.equals(Constant.COURSE_DELETE_TEXT)){
						delete = true;
						reason = "not allowed to delete";
						outlineProgressStep = "step: 110";
						taskType = "delete";
					}
					else if (taskProgress.toLowerCase().indexOf("modify") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
						delete = true;
						reason = "not allowed to modify";
						outlineProgressStep = "step: 120";
						taskType = "modify";
					}
					else if (taskProgress.toLowerCase().indexOf("work") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
						delete = true;
						reason = "not allowed to modify";
						outlineProgressStep = "step: 125";
						taskType = "work";
					}
					else if (category.equals(Constant.FOUNDATION) && outlineProgress.equals(Constant.BLANK)){
						delete = true;
						reason = "invalid progress or task";
						outlineProgressStep = "step: 130";
						taskType = "incorrect progress";
					}
					else{
						outlineProgressStep = "*** 1300";
					}

				}
				else if (isAProgram){

					// when new is task progress, it is converted here to correct because
					// it is actually in another progress and should be processed

					// FOR NOW, this code is the same as the COURSE section until we know
					// that changing taskprogress won't do more harm

					if (taskProgress.toLowerCase().equals("new")){
						if (message.toLowerCase().indexOf("review") > -1){
							taskProgress = "REVIEW";
							outlineProgressStep = "001";
						}
						else if (message.toLowerCase().indexOf("work") > -1){
							taskProgress = "MODIFY";
							outlineProgressStep = "002";
						}
						else{
							outlineProgressStep = "*** 0002";
						}
					}

					if (taskProgress.toLowerCase().indexOf("approv") > -1){

						if (message.toLowerCase().equals("approve added program")){

							if(pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
								delete = true;
								reason = "program pending approval task not available";
								outlineProgressStep = "step: 100";
							}
							else{
								outlineProgressStep = "*** 1000";
							}

						}
						else if (outlineProgress.equals(Constant.COURSE_CREATE_TEXT) &&
								!ProgramsDB.programExistByTitleCampus(conn,campus,kix,type)){

							// a task exists but the program does not so delete
							delete = true;
							reason = "not allowed to approve";
							outlineProgressStep = "step: 106";
							taskType = "approval";
						}
						else{
							outlineProgressStep = "*** 1060";
						}

					}
					else if (taskProgress.toLowerCase().indexOf("delete") > -1 && !outlineProgress.equals(Constant.COURSE_DELETE_TEXT)){
						delete = true;
						reason = "not allowed to delete";
						outlineProgressStep = "step: 110";
						taskType = "delete";
					}
					else if (taskProgress.toLowerCase().indexOf("modify") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
						delete = true;
						reason = "not allowed to modify";
						outlineProgressStep = "step: 120";
						taskType = "modify";
					}
					else if (taskProgress.toLowerCase().indexOf("work") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
						delete = true;
						reason = "not allowed to modify";
						outlineProgressStep = "step: 125";
						taskType = "work";
					}
					else if (category.equals(Constant.PROGRAM) && outlineProgress.equals(Constant.BLANK)){
						delete = true;
						reason = "invalid progress or task";
						outlineProgressStep = "step: 130";
						taskType = "incorrect progress";
					}
					else{
						outlineProgressStep = "*** 1300";
					}
				}
				else{ // isprogram

					// when new is task progress, it is converted here to correct because
					// it is actually in another progress and should be processed

					// FOR NOW, this code is the same as the PROGRAM section until we know
					// that changing taskprogress won't do more harm

					if (taskProgress.toLowerCase().equals("new")){
						if (message.toLowerCase().indexOf("review") > -1){
							taskProgress = "REVIEW";
							outlineProgressStep = "step: 131";
						}
						else if (message.toLowerCase().indexOf("work") > -1){
							taskProgress = "MODIFY";
							outlineProgressStep = "step: 132";
						}
						else{
							outlineProgressStep = "*** 1320";
						}

					}

					if (outlineProgress.equals(Constant.BLANK)){
						delete = true;
						reason = "outline does not exist to delete";
						outlineProgressStep = "step: 135";
						taskType = "incorrect progress";
					}
					else if (message.toLowerCase().indexOf("rename/renumber") > -1){
						if(!renameDB.isMatch(conn,campus,alpha,num)){
							delete = true;
							reason = "rename/renumber";
							outlineProgressStep = "step: 137";
						}
					}
					else if (taskProgress.toLowerCase().indexOf("approv") > -1){
						if (message.toLowerCase().equals("approve cross listing")){

							if(pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
								delete = true;
								reason = "pending cross listing approval task not available";
								outlineProgressStep = "step: 140";
							}
							else{
								outlineProgressStep = "*** 1400";
							}

						}
						else if (message.toLowerCase().equals("approve added requisite")){

							if(pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
								delete = true;
								reason = "pending approval task but requisites not available";
								outlineProgressStep = "step: 142";
							}

						}
						else if (message.toLowerCase().indexOf("pending") > -1 && outlineProgress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)){
							delete = false;
							reason = "pending task but outline not pending";
							outlineProgressStep = "step: 146";
						}
						else if (!(outlineProgress.equals(Constant.COURSE_APPROVAL_TEXT)) && !(outlineProgress.equals("DELETE"))){
							delete = true;
							reason = "not allowed to approve";
							outlineProgressStep = "step: 148";
						}
						else{
							outlineProgressStep = "*** 1480";
						}

						taskType = "approval";
					}
					else if ((taskProgress.toLowerCase().indexOf("modify") > -1 && outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)) &&
							!CourseDB.courseExistByProposer(conn,campus,user,alpha,num,type)){
						delete = true;
						reason = "modify text but not proposer";
						outlineProgressStep = "step: 150";
						taskType = "modify";
					}
					else if (taskProgress.toLowerCase().indexOf("review") > -1 || subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
						if (reviewDate == null || reviewDate.length() == 0 || DateUtility.compare2Dates(reviewDate,today) < 0){
							delete = true;
							reason = "In review but review date has expired";
							outlineProgressStep = "step: 160";
							taskType = "expired review";
						}
						else{
							String reviewerNames = "";
							if(subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
								reviewerNames = ReviewerDB.getReviewerNames(conn,campus,kix,"",Constant.ALL_REVIEWERS);
							}
							else{
								reviewerNames = ReviewerDB.getReviewerNames(conn,campus,kix,CourseDB.getCourseItem(conn,kix,"proposer"),Constant.ALL_REVIEWERS);
							}

							if(!reviewerNames.contains(user)){
								delete = true;
								reason = "Not a member of reviewer list";
								outlineProgressStep = "step: 165";
								taskType = "not a member of review";
							}
							else{
								outlineProgressStep = "*** 1600";
							}
						}
					}
					else if (taskProgress.toLowerCase().indexOf("review") > -1 &&
								((!reviewDuringApprovalAllowed	&& !(outlineProgress.equals("REVIEW")))
									&& !outlineProgress.equals("APPROVAL"))){
						delete = true;
						reason = "not allowed to review";
						outlineProgressStep = "step: 170";
						taskType = "not allowed to review";
					}
					else if (taskProgress.toLowerCase().indexOf("review") > -1 && !ReviewerDB.isReviewer(conn,kix,user)){
						delete = true;
						reason = "not a reviewer";
						outlineProgressStep = "step: 180";
						taskType = "not reviewer";
					}
					else if ((taskProgress.toLowerCase().indexOf("work") > -1 && outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)) &&
							!CourseDB.courseExistByProposer(conn,campus,user,alpha,num,type)){
						delete = true;
						reason = "modify text but not proposer";
						outlineProgressStep = "step: 190";
						taskType = "work";
					}
					else{
						outlineProgressStep = "*** 1900";
					}
				} // isAProgram

				//
				// above did checks on task and outline task. here, we check on the task message
				//
				if (!delete && !isAProgram && !foundation){
					if (message.toLowerCase().indexOf("approv") > -1){
						if(
								message.toLowerCase().equals(Constant.APPROVE_FND_TEXT.toLowerCase()) ||
								message.toLowerCase().equals(Constant.APPROVE_PROGRAM_TEXT.toLowerCase()) ||
								message.toLowerCase().equals(Constant.APPROVE_CROSS_LISTING_TEXT.toLowerCase()) ||
								message.toLowerCase().equals(Constant.APPROVE_REQUISITE_TEXT.toLowerCase()) ||
								message.toLowerCase().equals(Constant.RENAME_REQUEST_TEXT.toLowerCase()) ||
								message.toLowerCase().equals(Constant.RENAME_APPROVAL_TEXT.toLowerCase())
							){
								// these approval types do not affect the outline progress
								// so we leave out logic in tact and if a delete is needed
								// allow it to flow through;
								// for example, a request to approve cross listing does
								// not make an outline progress APPROVE. It remains in MODIFY
								// however if the task exists and there are no approvals,
								// delete; otherwise, keep
						}
						else if(	!outlineProgress.equals(Constant.COURSE_APPROVAL_TEXT) &&
									!outlineProgress.equals(Constant.COURSE_DELETE_TEXT) &&
									!outlineProgress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)
								){
							delete = true;
							reason = "approval task without proper outline progress";
							outlineProgressStep = "step: 300";
							taskType = "approval";
						}

					} // message
				} // !delete

				//
				// debugging
				//
				//if(debug && outlineProgressStep.indexOf("***") > -1){
				if(debug){
					logger.info("------------------------------------------");
					logger.info("foundation_isAProgram_taskProgress_outlineProgress_message");
					logger.info(rules + " ("+outlineProgressStep+")");
					logger.info("campus: " + user);
					logger.info("user: " + user);
					logger.info("alpha: " + alpha);
					logger.info("num: " + num);
					logger.info("message: " + message);
					logger.info("kix: " + kix);
					logger.info("delete: " + delete);
				}

				//
				// let's delete the stray
				//
				if (delete){
					++cleaned;

					boolean run = true;

					if (run){

						if (category.equals(Constant.COURSE)){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	num,
																	message,
																	campus,
																	"stray",
																	Constant.TASK_REMOVE,
																	type);
						}
						else if (category.equals(Constant.PROGRAM)){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	Constant.BLANK,
																	Constant.BLANK,
																	message,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type,
																	Constant.BLANK,
																	Constant.BLANK,
																	kix,
																	Constant.PROGRAM);
						}
						else if (category.equals(Constant.FOUNDATION)){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	Constant.BLANK,
																	Constant.BLANK,
																	message,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type,
																	Constant.BLANK,
																	Constant.BLANK,
																	kix,
																	Constant.FOUNDATION);
						}

						// if we were unable to remove the task, use ID instead
						if (rowsAffected == 0){
							rowsAffected = TaskDB.deleteTaskByID(conn,id);
						}

					} // run
				} // delete

			}	// while
			rs.close();
			ps.close();

			renameDB = null;

			fnd = null;

		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayTasks - " + ex.toString());
		}
	} // removeStrayTasks

	/*
	 * removeStrayReviewers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void removeStrayReviewers(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		//	read through reviewer table and check on the outline progress.
		//	if the progress is not review or subprogress not review in approval
		//	delete the reviewers from table.
		//
		//	progress of MODIFY can have subprogress of REVIEW_IN_APPROVAL
		//

		boolean debug = false;

		try{

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();

			int hours24 = dt.getHour24();
			int minutes = dt.getMinutes();
			String today = dt.getCurrentDate();

			int rowsAffected = 0;
			String alpha = "";
			String num = "";
			String type = "PRE";
			String progress = "";
			String subprogress = "";
			String kix = "";
			String sReviewDate = "";

			java.util.Date reviewDate = null;

			int counter = 0;

			//
			// this loop checks on the main review date set in course table. if dates are
			// valid with course.reviewdate, then we are good in this loop.
			//
			String sql = "SELECT DISTINCT r.coursealpha, r.coursenum, c.reviewdate, c.historyid, c.progress, c.subprogress "
					+ "FROM tblReviewers r INNER JOIN tblCourse c ON r.coursealpha = c.CourseAlpha "
					+ "AND r.coursenum = c.CourseNum AND r.campus = c.campus WHERE r.campus=? "
					+ "AND c.CourseType='PRE' ORDER BY r.coursealpha, r.coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				++counter;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				//
				// default is to delete/remove
				//
				boolean remove = true;

				int daysDiff = 0;

				reviewDate = rs.getDate("reviewdate");
				if (reviewDate != null){
					sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

					daysDiff = DateUtility.compare2Dates(sReviewDate,today);

					// review is valid only when the progress is review or the subprogress is review and
					// the review date is greater than today
					if (
							(	progress.equals(Constant.COURSE_REVIEW_TEXT) || subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL))
								&& daysDiff >= 0
						){
						remove = false;
					}
					else{
						remove = true;

						// if we have the same day, don't allow the removal until after midnight
						if(sReviewDate.equals(today)){
							if(hours24 < 24 && minutes < 60){
								remove = false;
							}
						}

					} // progress

					if(debug){
						if(remove){
							logger.info("removing - " + sReviewDate + "; outline: " + remove + "; diff: " + daysDiff);
						}
						else{
							logger.info("not removing - " + sReviewDate + "; outline: " + remove + "; diff: " + daysDiff);
						}
					} // debug

				}
				else{
					remove = true;
				} // reviewDate != null

				//
				// what now?
				//
				if(remove){

					//
					// for REVIEW_IN_REVIEW, level 99 (ALL_REVIEWERS) means to delete all
					//
					rowsAffected = ReviewerDB.deleteReviewers(conn,campus,alpha,num,false,"",Constant.ALL_REVIEWERS);

					rowsAffected = TaskDB.logTask(conn,
															Constant.TASK_ALL,
															Constant.TASK_ALL,
															alpha,
															num,
															Constant.REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.REMOVE,
															type);
				} // remove

			}	// while
			rs.close();
			ps.close();

			dt = null;

			//
			// same logic but works on foundations
			//
			removeStrayFndReviewers(conn,campus);

		}
		catch(SQLException se ){
			logger.fatal("TaskDB.removeStrayReviewers - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB.removeStrayReviewers - " + ex.toString());
		}
	} // TaskDB: removeStrayReviewers

	/*
	 * removeStrayFndReviewers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void removeStrayFndReviewers(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		//	read through reviewer table and check on the outline progress.
		//	if the progress is not review or subprogress not review in approval
		//	delete the reviewers from table.
		//
		//	progress of MODIFY can have subprogress of REVIEW_IN_APPROVAL
		//

		boolean debug = false;

		try{

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();

			int hours24 = dt.getHour24();
			int minutes = dt.getMinutes();
			String today = dt.getCurrentDate();

			int rowsAffected = 0;
			String alpha = "";
			String num = "";
			String type = "PRE";
			String progress = "";
			String subprogress = "";
			String kix = "";
			String sReviewDate = "";

			java.util.Date reviewDate = null;

			int counter = 0;

			//
			// this loop checks on the main review date set in course table. if dates are
			// valid with course.reviewdate, then we are good in this loop.
			//
			String sql = "SELECT DISTINCT r.coursealpha, r.coursenum, c.reviewdate, c.historyid, c.progress, c.subprogress "
					+ "FROM tblReviewers r INNER JOIN tblfnd c ON r.coursealpha = c.CourseAlpha "
					+ "AND r.coursenum = c.CourseNum AND r.campus = c.campus WHERE r.campus=? "
					+ "AND c.type='PRE' ORDER BY r.coursealpha, r.coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				++counter;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				//
				// default is to delete/remove
				//
				boolean remove = true;

				int daysDiff = 0;

				reviewDate = rs.getDate("reviewdate");
				if (reviewDate != null){
					sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

					daysDiff = DateUtility.compare2Dates(sReviewDate,today);

					// review is valid only when the progress is review or the subprogress is review and
					// the review date is greater than today
					if (
							(	progress.equals(Constant.COURSE_REVIEW_TEXT) || subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL))
								&& daysDiff >= 0
						){
						remove = false;
					}
					else{
						remove = true;

						// if we have the same day, don't allow the removal until after midnight
						if(sReviewDate.equals(today)){
							if(hours24 < 24 && minutes < 60){
								remove = false;
							}
						}

					} // progress

					if(debug){
						if(remove){
							logger.info("removing - " + sReviewDate + "; outline: " + remove + "; diff: " + daysDiff);
						}
						else{
							logger.info("not removing - " + sReviewDate + "; outline: " + remove + "; diff: " + daysDiff);
						}
					} // debug

				}
				else{
					remove = true;
				} // reviewDate != null

				//
				// what now?
				//
				if(remove){

					//
					// for REVIEW_IN_REVIEW, level 99 (ALL_REVIEWERS) means to delete all
					//
					rowsAffected = ReviewerDB.deleteReviewers(conn,campus,alpha,num,false,"",Constant.ALL_REVIEWERS);

					rowsAffected = TaskDB.logTask(conn,
															Constant.TASK_ALL,
															Constant.TASK_ALL,
															alpha,
															num,
															Constant.FND_REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.REMOVE,
															type);
				} // remove

			}	// while
			rs.close();
			ps.close();

			dt = null;

		}
		catch(SQLException se ){
			logger.fatal("TaskDB: removeStrayFndReviewers - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayFndReviewers - " + ex.toString());
		}
	} // TaskDB: removeStrayFndReviewers

	/*
	 * addMissingCampusData
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void addMissingCampusData(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		try{

			boolean run = true;
			if (run){
				int rowsAffected = 0;

				String sql = "SELECT historyid FROM tblCourse "
					+ "WHERE campus=? AND proposer=? AND historyid NOT IN (SELECT historyid FROM tblCampusData)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					rowsAffected = CampusDB.createCampusDataRow(conn,kix);
				}
				rs.close();
				ps.close();
			} // if run

		}
		catch(SQLException ex){
			logger.fatal("TaskDB: addMissingCampusData\n" + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("TaskDB: addMissingCampusData\n" + ex.toString());
		}
	}

	/*
	 * removeDuplicateTasks
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void removeDuplicateTasks(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		// remove duplicate tasks where 2 identical are there for one person.
		try{
			boolean run = true;
			if (run){
				int rowsAffected = 0;

				String sql = "DELETE FROM tbltasks "
					+ "WHERE campus=? "
					+ "AND submittedfor=? "
					+ "AND id IN "
					+ "( "
					+ "SELECT MIN(minid) AS minid "
					+ "FROM "
					+ "( "
					+ "SELECT MIN(id) AS MinID,  submittedfor "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "GROUP BY submittedfor, message, historyid, category, coursealpha, coursenum "
					+ "HAVING submittedfor=? AND COUNT(id) > 1 "
					+ ") inner_table "
					+ ")";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ps.setString(3,campus);
				ps.setString(4,user);
				rowsAffected = ps.executeUpdate();
				ps.close();
			} // if run
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: removeDuplicateTasks\n" + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("TaskDB: removeDuplicateTasks\n" + ex.toString());
		}
	}

	/*
	 * createMissingModifyTasks
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 * <p>
	 *	@return String
	 */
	public static String createMissingModifyTasks(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int created = 0;

		String kix = "";
		String alpha = "";
		String num = "";

		try{

			String sql = "SELECT historyid,CourseAlpha,CourseNum "
				+ "FROM tblCourse  WHERE campus=? AND proposer=? AND progress=? AND CourseType='PRE' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.COURSE_MODIFY_TEXT);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.MODIFY_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE);
				if (rowsAffected>0){
					++created;
				}
			}
			rs.close();
			ps.close();

			//
			// do the same for foundations
			//
			String message = "";

			sql = "SELECT historyid,CourseAlpha,CourseNum "
				+ "FROM tblfnd  WHERE campus=? AND proposer=? AND progress=? AND type='PRE' ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.COURSE_MODIFY_TEXT);
			rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				if (com.ase.aseutil.fnd.FndDB.existByTypeCampus(conn,campus,kix,"CUR")){
					message = Constant.FND_MODIFY_TEXT;
				}
				else{
					message = Constant.FND_CREATE_TEXT;
				}

				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														message,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER,
														kix,
														Constant.FOUNDATION);
				if (rowsAffected>0){
					++created;
				}
			}
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("TaskDB createMissingModifyTasks - " + e.toString());
		}

		return "Missing modify task created for " + user + " (" + created + " rows)";
	}

	/*
	 * createMissingProgramTasks
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 * <p>
	 *	@return String
	 */
	public static String createMissingProgramTasks(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int created = 0;

		String kix = "";
		String title = "";
		String divisioncode = "";
		String action = "";

		/*
			create missing program task. If there is a CUR, then the task is MODIFY.

			if not, then it's a create.
		*/

		try{

			String sql = "SELECT historyid, title, divisioncode FROM vw_ProgramForViewing WHERE campus=? "
				+ "AND proposer=? AND type='PRE' AND progress=? AND historyid NOT IN "
				+ "( "
				+ "SELECT historyid FROM tblTasks WHERE campus=? "
				+ "AND submittedfor=? AND category='program' AND NOT historyid IS NULL AND historyid <> '' "
				+ ")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.COURSE_MODIFY_TEXT);
			ps.setString(4,campus);
			ps.setString(5,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = rs.getString("historyid");
				title = rs.getString("title");
				divisioncode = rs.getString("divisioncode");

				if (ProgramsDB.programExistByTitleCampus(conn,campus,kix,"CUR"))
					action = Constant.PROGRAM_MODIFY_TEXT;
				else
					action = Constant.PROGRAM_CREATE_TEXT;

				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														title,
														divisioncode,
														action,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER,
														kix,
														Constant.PROGRAM);
				if (rowsAffected>0)
					++created;
			}
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("TaskDB createMissingProgramTasks - " + e.toString());
		}

		return "Missing modify task created for " + user + " (" + created + " rows)";
	}

	/*
	 * createMailLogTasks
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 * <p>
	 */
	public static void createMailLogTasks(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try{
			String domain = "@" + SysDB.getSys(conn,"domain");

			if (domain == null || domain.length() == 0){
				domain = Constant.SMTP_DOMAIN;
			}

			domain = user + domain;

			String sql = "SELECT id FROM tblMail WHERE processed=0 AND cc='DAILY' AND [to]=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,domain);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				int rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															Constant.BLANK,
															Constant.BLANK,
															Constant.MAIL_LOG_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE);
			}
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("TaskDB createMailLogTasks - " + e.toString());
		}
	}

	/*
	 * getSubmittedForByTaskMessage - get the name of person with a particular task
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	task		String
	 *	<p>
	 * @return String
	 */
	public static String getSubmittedForByTaskMessage(	Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String task){

		//Logger logger = Logger.getLogger("test");

		String approver = "";
		String sql = "";

		try{
			sql = "SELECT submittedfor FROM tblTasks WHERE campus=? "
				+ "AND coursealpha=? AND coursenum=? AND " + TaskChartDB.getMessageText(task);
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approver = AseUtil.nullToBlank(rs.getString(1));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: getSubmittedForByTaskMessage - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: getSubmittedForByTaskMessage - " + ex.toString());
		}

		return approver;
	}

	/*
	 * replaceSubmittedForByTaskMessage - get the name of person with a particular task
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	task		String
	 * @param	oldName	String
	 * @param	newName	String
	 *	<p>
	 * @return int
	 */
	public static int replaceSubmittedForByTaskMessage(Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String task,
																		String oldName,
																		String newName){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String sql = "";

		try{
			sql = "UPDATE tblTasks "
				+ "SET submittedfor=?,dte=? WHERE campus=? "
				+ "AND coursealpha=? AND coursenum=? "
				+ "AND " + TaskChartDB.getMessageText(task) + " "
				+ "AND submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,newName);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,campus);
			ps.setString(4,alpha);
			ps.setString(5,num);
			ps.setString(6,oldName);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: replaceSubmittedForByTaskMessage - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: replaceSubmittedForByTaskMessage - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getInviter - the person inviting reviewers
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	task		String
	 *	<p>
	 * @return String
	 */
	public static String getInviter(	Connection conn,String campus,String alpha,String num,String user){

		//Logger logger = Logger.getLogger("test");

		String inviter = "";
		String sql = "";

		try{
			sql = "SELECT inviter FROM tblTasks WHERE campus=? AND coursealpha=? AND coursenum=? AND submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				inviter = AseUtil.nullToBlank(rs.getString(1));

			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: getInviter - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: getInviter - " + ex.toString());
		}

		return inviter;
	}

	/*
	 * getInviter - the person inviting reviewers
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	task		String
	 *	<p>
	 * @return String
	 */
	public static String getInviter(	Connection conn,String campus,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		String inviter = "";
		String sql = "";

		try{
			sql = "SELECT inviter FROM tblTasks WHERE campus=? AND historyid=? AND submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				inviter = AseUtil.nullToBlank(rs.getString(1));

			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: getInviter - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: getInviter - " + ex.toString());
		}

		return inviter;
	}

	/*
	 * getRole - the person role of either reviewer or approver from history
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	task		String
	 *	<p>
	 * @return String
	 */
	public static String getRole(	Connection conn,String campus,String alpha,String num,String user){

		//Logger logger = Logger.getLogger("test");

		String role = "";
		String sql = "";

		try{
			sql = "SELECT role FROM tblTasks WHERE campus=? AND coursealpha=? AND coursenum=? AND submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				role = AseUtil.nullToBlank(rs.getString(1));

			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: getRole - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: getRole - " + ex.toString());
		}

		return role;
	}

	/*
	 * hasTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static int hasTask(	Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		int tasks = 0;

		try{
			String sql = "SELECT count(id) FROM tblTasks WHERE campus=? AND submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				tasks = rs.getInt(1);
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("TaskDB: hasTask - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("TaskDB: hasTask - " + ex.toString());
		}

		return tasks;
	}

	/*
	 * removeTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * @param	msg		String
	 *	<p>
	 * @return int
	 */
	public static int removeTask(Connection conn,String campus,String kix,String user,String msg) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int rowsAffected = 0;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			PreparedStatement ps = null;
			sql = "DELETE FROM tblTasks WHERE campus=? AND submittedfor=? AND courseAlpha=? AND courseNum=? "
				+ "AND " + TaskChartDB.getMessageText(msg);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,alpha);
			ps.setString(4,num);
			rowsAffected = ps.executeUpdate();
			ps.close();
			AseUtil.logAction(conn,user,"REMOVE","Outline approved task confirmed",alpha,num,campus,kix);
		} catch (Exception e) {
			logger.fatal("TaskDB: removeTask\n" + e.toString());
			return 0;
		}

		return rowsAffected;
	}

	/*
	 * removePendingApprovalTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static void removePendingApprovalTask(Connection conn,String campus,String user) throws Exception {

		removePendingApprovalTask(conn,campus,user,"","");

		return;
	}

	/*
	 * removePendingApprovalTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return int
	 */
	public static void removePendingApprovalTask(Connection conn,String campus,String user,String alpha,String num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {
			//
			//	if we find approval pending task, and there are no outlines to approve
			//	let's delete the task
			//

			int approvalPendingCount = 0;
			int rowsAffected = 0;

			if (	TaskDB.isMatch(conn,user,alpha,num,Constant.APPROVAL_PENDING_TEXT,campus)){
				approvalPendingCount = ChairProgramsDB.approvalPendingCount(conn,campus,user);
				if (approvalPendingCount==0){
					rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																alpha,
																num,
																Constant.APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
				}
			}
			else if (TaskDB.isMatch(conn,user,alpha,num,Constant.DELETE_APPROVAL_PENDING_TEXT,campus)){
				approvalPendingCount = ChairProgramsDB.approvalPendingCount(conn,campus,user);
				if (approvalPendingCount==0){
					rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																alpha,
																num,
																Constant.DELETE_APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
				}
			}


		} catch (Exception e) {
			logger.fatal("TaskDB: removePendingApprovalTask - " + e.toString());
		}

		return;
	}

	/*
	 * addMissingApprovalTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static void addMissingApprovalTask(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String alpha = "";
		String num = "";
		String proposer = "";
		String kix = "";

		try {
			sql = "SELECT coursealpha,coursenum,proposer,historyid "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND (progress=? OR (progress=? AND subprogress=?)) "
					+ "AND rtrim(coursealpha)+rtrim(coursenum) "
					+ "IN  "
					+ "( "
					+ "SELECT outline FROM ("+SQL.vw_ApprovalsWithoutTasks()+") AS vw_ApprovalsWithoutTasks "
					+ ") ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,Constant.COURSE_APPROVAL_TEXT); 				// 'APPROVAL'
			ps.setString(3,Constant.COURSE_APPROVAL_TEXT); 				// 'APPROVAL'
			ps.setString(4,Constant.COURSE_REVIEW_IN_APPROVAL);		// 'REVIEW_IN_APPROVAL'
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));

				if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
					if (CourseDB.isNextApprover(conn,campus,alpha,num,user)){
						TaskDB.logTask(conn,
											user,
											proposer,
											alpha,
											num,
											Constant.APPROVAL_TEXT,
											campus,
											Constant.BLANK,
											Constant.TASK_ADD,
											Constant.PRE);

						AseUtil.logAction(conn,
												proposer,
												"ACTION",
												"Task added ",
												alpha,
												num,
												campus,
												kix);
					}
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TaskDB: addMissingApprovalTask - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TaskDB: addMissingApprovalTask - " + e.toString());
		}

		return;
	}

	/*
	 * switchTaskMessage
	 *	<p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	alpha				String
	 * @param	num				String
	 * @param	submittedfor	String
	 * @param	fromMsg			String
	 * @param	toMsg				String
	 *	<p>
	 */
	public static void switchTaskMessage(Connection conn,
													String campus,
													String alpha,
													String num,
													String submittedfor,
													String fromMsg,
													String toMsg) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {
			String sql = "UPDATE tblTasks "
					+ "SET role='APPROVER',message=?,dte=? "
					+ "WHERE campus=? AND submittedfor=? "
					+ "AND coursealpha=? AND coursenum=? AND message=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,toMsg.trim());
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,campus);
			ps.setString(4,submittedfor);
			ps.setString(5,alpha);
			ps.setString(6,num);
			ps.setString(7,fromMsg.trim());
			int rowAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TaskDB: switchTaskMessage - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TaskDB: switchTaskMessage - " + e.toString());
		}

		return;
	}

	/*
	 * removeApprovalTask
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param thisApprover	String
	 *	@param thisDelegate	String
	 *	<p>
	 *	@return int
	 */
	public static int removeApprovalTask(Connection conn,String kix,String thisApprover,String thisDelegate){

		//logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int z = 0;

		String[] tasks = new String[20];
		String[] info = null;
		String alpha = "";
		String num = "";

		String category = "";
		String message = "";

		boolean debug = false;

		try{
			if (thisApprover != null){
				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
				if (isAProgram){
					category = Constant.PROGRAM;
					message = Constant.PROGRAM_APPROVAL_TEXT;

					info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_PROGRAM_TITLE];
					num = info[Constant.KIX_PROGRAM_DIVISION];
				}
				else{
					category = Constant.COURSE;
					message = Constant.APPROVAL_TEXT;

					info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
				}

				String type = info[Constant.KIX_TYPE];
				String proposer = info[Constant.KIX_PROPOSER];
				String campus = info[Constant.KIX_CAMPUS];
				int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

				if (thisDelegate == null || thisDelegate.length() == 0){
					thisDelegate = ApproverDB.getDelegateByApproverName(conn,campus,thisApprover,route);
				}

				String taskRemove = thisApprover;
				if (!thisDelegate.equals(Constant.BLANK) && thisApprover.indexOf(thisDelegate)<0){
					taskRemove = taskRemove + "," + thisDelegate;
				}

				if (debug){
					logger.info("category: " + category);
					logger.info("message: " + message);
					logger.info("alpha: " + alpha);
					logger.info("proposer: " + proposer);
					logger.info("campus: " + campus);
					logger.info("route: " + route);
					logger.info("thisDelegate: " + thisDelegate);
					logger.info("taskRemove: " + taskRemove);
				}

				tasks = taskRemove.split(",");
				for (z=0;z<tasks.length;z++){
					if (tasks[z] != null){
						rowsAffected += TaskDB.logTask(conn,
																tasks[z],
																tasks[z],
																alpha,
																num,
																message,
																campus,
																"",
																"REMOVE",
																type,
																"",
																"",
																kix,
																category);
						if (debug)
							logger.info(kix + " - TaskDB - removeApprovalTask: Removing approval task for " + tasks[z] + " (" + alpha + " " + num + ")");
					}
				} // for
			} // thisApprover
		}catch(Exception e){
			logger.fatal(kix + " - TaskDB: removeApprovalTask - " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * addApprovalTask
	 *	<p>
	 *	@param conn				Connection
	 *	@param kix				String
	 *	@param nextApprover	String
	 *	@param nextDelegate	String
	 *	<p>
	 *	@return msg
	 */
	public static Msg addApprovalTask(Connection conn,String kix,String nextApprover,String nextDelegate){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int z = 0;

		String[] info = null;
		String alpha = "";
		String num = "";
		String category = "";
		String message = "";

		String toNames = "";
		String[] tasks = new String[20];
		Msg msg = new Msg();

		try{
			if (nextApprover != null){
				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
				if (isAProgram){
					category = Constant.PROGRAM;
					message = Constant.PROGRAM_APPROVAL_TEXT;

					info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_PROGRAM_TITLE];
					num = info[Constant.KIX_PROGRAM_DIVISION];
				}
				else{
					category = Constant.COURSE;
					message = Constant.APPROVAL_TEXT;

					info = Helper.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
				}

				String type = info[Constant.KIX_TYPE];
				String proposer = info[Constant.KIX_PROPOSER];
				String campus = info[Constant.KIX_CAMPUS];
				int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

				if (nextDelegate == null || nextDelegate.length() == 0)
					nextDelegate = ApproverDB.getDelegateByApproverName(conn,campus,nextApprover,route);

				String taskAdd = nextApprover;
				if (!(Constant.BLANK).equals(nextDelegate) && nextApprover.indexOf(nextDelegate)<0)
					taskAdd = taskAdd + "," + nextDelegate;

				tasks = taskAdd.split(",");
				for (z=0;z<tasks.length;z++){

					if (tasks[z] != null){
						rowsAffected = TaskDB.logTask(conn,
																tasks[z],
																tasks[z],
																alpha,
																num,
																message,
																campus,
																"",
																"ADD",
																type,
																proposer,
																Constant.TASK_APPROVER,
																kix,
																category);

						if (toNames.length()==0)
							toNames = tasks[z];
						else
							toNames = toNames + "," + tasks[z];
					}
				}

				// return names for use to show who is next
				msg.setErrorLog(toNames);
			} // nextApprover
		}catch(Exception e){
			logger.fatal(kix + " - TaskDB: addApprovalTask - " + e.toString());
		}

		return msg;

	}

	/*
	 * correctProposerName
	 * <p>
	 * @param	connection
	 * <p>
	 * @return int
	 */
	public static int correctProposerName(Connection conn){

		//Logger logger = Logger.getLogger("test");

		String proposer = null;

		int id = 0;
		int rowsAffected = 0;

		try{
			//logger.info("------------------- correctProposerName START");

			/*
				correct the proposer name means that the task submittedby should always be the proposer
				and not the name of the submittedfor.

				when submittedby is not the proposer as in the case of the last AND clause, we know
				something is not right.

			*/
			String junk = "";

			// sql statements are identical with the exception that the inner sql of the second is a check
			// that THANHG is not the name in task assignment
			String[] sql = new String[2];

			sql[0] = "SELECT t.campus,t.coursealpha, t.coursenum, t.id, t.submittedby, t.submittedfor, c.proposer, t.coursetype "
						+ "FROM tblCourse c, "
						+ "( "
						+ "select id, submittedby, submittedfor, coursealpha, coursenum, campus, coursetype "
						+ "from tbltasks "
						+ "where submittedby = submittedfor "
						+ ") AS t "
						+ "WHERE c.campus=t.campus "
						+ "AND c.coursealpha=t.coursealpha "
						+ "AND c.coursenum=t.coursenum "
						+ "AND c.coursetype=t.coursetype "
						+ "AND NOT c.proposer is null "
						+ "AND c.proposer <> t.submittedby "
						+ "ORDER BY t.campus, t.coursealpha, t.coursenum, t.submittedby ";

			sql[1] = "SELECT t.campus,t.coursealpha, t.coursenum, t.id, t.submittedby, t.submittedfor, c.proposer, t.coursetype "
						+ "FROM tblCourse c, "
						+ "( "
						+ "select id, submittedby, submittedfor, coursealpha, coursenum, campus, coursetype "
						+ "from tbltasks "
						+ "where submittedby = '"+Constant.SYSADM_NAME+"' and submittedfor <> '"+Constant.SYSADM_NAME+"' "
						+ ") AS t "
						+ "WHERE c.campus=t.campus "
						+ "AND c.coursealpha=t.coursealpha "
						+ "AND c.coursenum=t.coursenum "
						+ "AND c.coursetype=t.coursetype "
						+ "AND NOT c.proposer is null "
						+ "AND c.proposer <> t.submittedby "
						+ "ORDER BY t.campus, t.coursealpha, t.coursenum, t.submittedby ";

			PreparedStatement ps = null;
			PreparedStatement ps2 = null;
			ResultSet rs = null;

			String alpha = null;
			String num = null;
			String submittedby = null;
			String submittedfor = null;

			for (int i = 0; i < sql.length; i++){

				junk = sql[i];

				ps = conn.prepareStatement(junk);
				rs = ps.executeQuery();
				while (rs.next()){
					id = rs.getInt("id");
					proposer = AseUtil.nullToBlank(rs.getString("proposer"));

					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));
					submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
					submittedfor = AseUtil.nullToBlank(rs.getString("submittedfor"));

					if (proposer != null && proposer.length() > 0){
						junk = "UPDATE tblTasks SET submittedby=? WHERE id=?";
						ps2 = conn.prepareStatement(junk);
						ps2.setString(1,proposer);
						ps2.setInt(2,id);
						ps2.executeUpdate();
						ps2.close();

						++rowsAffected;
					}

				} // while
				rs.close();
				ps.close();

			} // for

		}
		catch(SQLException x){
			logger.fatal("TaskDB: correctProposerName - " + x.toString());
		}
		catch(Exception x){
			logger.fatal("TaskDB: correctProposerName - " + x.toString());
		}

		return rowsAffected;

	} // correctProposerName

	/**
	 * getTaskMenuText
	 * <p>
	 * @param	conn	Connection
	 * @param	task	String
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getTaskMenuText(Connection conn,String task,String campus,String alpha,String num,String type,String kix) {

		//Logger logger = Logger.getLogger("test");

		String[] taskText = new String[3];
		taskText[Constant.TASK_MESSAGE] = "";
		taskText[Constant.TASK_PROGRESS] = "";
		taskText[Constant.TASK_SRC] = "";

		boolean isAProgram = false;
		boolean foundation = false;
		boolean courseExistByTypeCampus = false;
		boolean programExistByTypeCampus = false;
		boolean fndExist = false;

		try {

			boolean debug = false;

			//
			// is it a program or course outline
			//
			if(kix == null || kix.equals(Constant.BLANK)){
				isAProgram = ProgramsDB.isAProgram(conn,campus,alpha,num,type);
			}
			else{
				isAProgram = ProgramsDB.isAProgram(conn,kix);
			}

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			if(!isAProgram){
				if(kix == null || kix.equals(Constant.BLANK)){
					kix = fnd.getKix(conn,campus,alpha,num,type);
					foundation = fnd.isFoundation(conn,kix);
				}
				else{
					foundation = fnd.isFoundation(conn,kix);
				}
			}

			if(debug){
				logger.info("------------------------------");
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("task: " + task);
				logger.info("kix: " + kix);
				logger.info("isAProgram: " + isAProgram);
				logger.info("foundation: " + foundation);
			}

			//
			// determine if new or old (MUST use CUR as type for course to search for)
			//
			String typeCheck = type;
			if(!isAProgram && !foundation){
				typeCheck = "CUR";
				courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,typeCheck);
			}

			//
			// program?
			//
			String[] info = null;
			if (isAProgram){
				info = Helper.getKixInfo(conn,kix);
				type = info[Constant.KIX_TYPE];
				programExistByTypeCampus = ProgramsDB.programExistByTypeCampus(conn,campus,kix,type);
			}
			else if (foundation){
				info = fnd.getKixInfo(conn,kix);
				type = info[Constant.KIX_TYPE];
				fndExist = fnd.existByTypeCampus(conn,campus,kix,type);
			}

			TaskChart taskChart = TaskChartDB.getTaskChart(task,courseExistByTypeCampus,programExistByTypeCampus,isAProgram,foundation,fndExist);
			if (taskChart != null){
				taskText[Constant.TASK_MESSAGE] = taskChart.getMessage();
				taskText[Constant.TASK_PROGRESS] = taskChart.getProgress();
				taskText[Constant.TASK_SRC] =  taskChart.getSource();
			}
			else{
				taskText[Constant.TASK_MESSAGE] = task;
			}

			fnd = null;

		} catch (Exception e) {
			logger.fatal("TaskDB: getTaskMenuText - " + e.toString());
		}

		return taskText;
	}

	/*
	 * resetReviewStatus - find courses under review where there are no reviewers and date has past
	 * <p>
	 * @param	conn		Connection
	 * @param	campus		String
	 * <p>
	 * @return	void
	 */
	public static void resetReviewStatus(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		// NOTE: this logic is similar to resetReviewInReviewStatus. Difference is this
		// routine works on tblcourse table and resets course date and status.
		// resetReviewInReviewStatus only remove review in review
		//

		try{

			AseUtil aseUtil = new AseUtil();

			boolean debug = false;

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();

			int hours24 = dt.getHour24();
			int minutes = dt.getMinutes();
			String today = dt.getCurrentDate();

			int rowsAffected = 0;
			String alpha = "";
			String num = "";
			String type = "";

			java.util.Date reviewDate = null;

			String sql = "SELECT campus,coursealpha,coursenum,reviewdate,coursetype,progress,subprogress,route,proposer "
					+ "From tblcourse WHERE campus=? AND (progress='REVIEW' OR subprogress='REVIEW_IN_APPROVAL') "
					+ "AND (reviewdate < getdate()+1) ORDER BY campus,coursealpha,coursenum,reviewdate";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				int route = rs.getInt("route");

				String kix = Helper.getKix(conn,campus,alpha,num,type);

				//
				// default is to delete/remove
				//
				boolean remove = true;

				String sReviewDate = "";

				int daysDiff = -1;

				reviewDate = rs.getDate("reviewdate");
				if (reviewDate != null){

					sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

					daysDiff = DateUtility.compare2Dates(sReviewDate,today);

					if (daysDiff >= 0){
						remove = false;
					}
					else{
						remove = true;

						// if we have the same day, don't allow the removal until after midnight
						if(sReviewDate.equals(today)){
							if(hours24 < 24 && minutes < 60){
								remove = false;
							}
						}

					} // progress
				}
				else{
					remove = true;
				} // reviewDate != null

				if(debug){

					String outline = campus+"/"+alpha+"/"+num;

					if(remove){
						logger.info("removing - " + sReviewDate + "; outline: " + outline + "; diff: " + daysDiff);
					}
					else{
						logger.info("not removing - " + sReviewDate + "; outline: " + outline + "; diff: " + daysDiff);
					}
				} // debug

				//
				// what now?
				//
				if(remove){

					// make sure we clean up first
					rowsAffected = ReviewerDB.deleteReviewers(conn,campus,alpha,num,false);

					rowsAffected = TaskDB.logTask(conn,
							Constant.TASK_ALL,
							Constant.TASK_ALL,
							alpha,
							num,
							Constant.REVIEW_TEXT,
							campus,
							Constant.BLANK,
							Constant.REMOVE,
							type);

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					//logger.info("moved " + rowsAffected + " rows to history2: (" + alpha + " - " + num + ")");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					ps.close();

					//
					// reset starts here
					//
					if(progress.equals("APPROVAL") && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
						sql = "UPDATE tblCourse "
								+ "SET edit=0,edit0='',edit1='3',edit2='3',progress='APPROVAL',subprogress=null,reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
					}
					else{
						sql = "UPDATE tblCourse "
								+ "SET edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY',subprogress=null,reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
					}

					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					ps.setString(4, type);
					rowsAffected = ps.executeUpdate();

					//
					// create task again for approval. Modify task done elsewhere
					//
					if(progress.equals("APPROVAL") && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

						String nextDelegate = "";

						String nextApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);

						if(nextApprover != null && nextApprover.length() > 0){

							int currentSeq = ApproverDB.getApproverSequence(conn,nextApprover,route);

							if(currentSeq > 0){
								nextDelegate = ApproverDB.getDelegateBySeq(conn,campus,currentSeq,route);
							}

							rowsAffected = TaskDB.logTask(conn,
																	nextApprover,
																	proposer,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER);

							if (nextDelegate != null && nextDelegate.length() > 0){
								rowsAffected = TaskDB.logTask(conn,
																		nextDelegate,
																		proposer,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_APPROVER);
							}

						} // found nextApprover

					} // recreate task for approvers

					aseUtil.logAction(conn,"SYSTEM","Reset","Course review status reset to modify",alpha,num,campus,kix);

				} // remove

			}	// while
			rs.close();
			ps.close();

			aseUtil = null;

			resetFndReviewStatus(conn,campus);

			resetReviewInReviewStatus(conn,campus);

		}
		catch(SQLException se ){
			logger.fatal("TaskDB: resetReviewStatus - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: resetReviewStatus - " + ex.toString());
		}
	} // TaskDB: resetReviewStatus

	/*
	 * resetFndReviewStatus - find courses under review where there are no reviewers and date has past
	 * <p>
	 * @param	conn		Connection
	 * @param	campus		String
	 * <p>
	 * @return	void
	 */
	public static void resetFndReviewStatus(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		// NOTE: this logic is similar to resetReviewInReviewStatus. Difference is this
		// routine works on tblcourse table and resets course date and status.
		// resetReviewInReviewStatus only remove review in review
		//

		try{

			AseUtil aseUtil = new AseUtil();

			boolean debug = false;

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();

			int hours24 = dt.getHour24();
			int minutes = dt.getMinutes();
			String today = dt.getCurrentDate();

			int rowsAffected = 0;
			String alpha = "";
			String num = "";
			String type = "";
			String kix = "";

			java.util.Date reviewDate = null;

			String sql = "SELECT campus,coursealpha,coursenum,reviewdate,type, historyid,progress,subprogress,route,proposer "
					+ "From tblfnd WHERE campus=? AND (progress='REVIEW' OR subprogress='REVIEW_IN_APPROVAL') "
					+ "AND (reviewdate < getdate()+1) ORDER BY campus,coursealpha,coursenum,reviewdate";

			if(debug) logger.info(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("type"));
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				int route = rs.getInt("route");

				if(debug) logger.info("kix: " + kix);

				//
				// default is to delete/remove
				//
				boolean remove = true;

				String sReviewDate = "";

				int daysDiff = -1;

				reviewDate = rs.getDate("reviewdate");
				if (reviewDate != null){

					sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

					daysDiff = DateUtility.compare2Dates(sReviewDate,today);

					if (daysDiff >= 0){
						remove = false;
					}
					else{
						remove = true;

						// if we have the same day, don't allow the removal until after midnight
						if(sReviewDate.equals(today)){
							if(hours24 < 24 && minutes < 60){
								remove = false;
							}
						}

					} // progress
				}
				else{
					remove = true;
				} // reviewDate != null

				if(debug){

					String outline = campus+"/"+alpha+"/"+num;

					if(remove){
						logger.info("removing - " + sReviewDate + "; foundation: " + outline + "; diff: " + daysDiff);
					}
					else{
						logger.info("not removing - " + sReviewDate + "; foundation: " + outline + "; diff: " + daysDiff);
					}
				} // debug

				//
				// what now?
				//
				if(remove){

					// make sure we clean up first
					rowsAffected = ReviewerDB.deleteReviewers(conn,campus,alpha,num,false);

					if(debug) logger.info("delete reviewers: " + rowsAffected);

					rowsAffected = logTask(conn,
							Constant.TASK_ALL,
							Constant.TASK_ALL,
							alpha,
							num,
							Constant.FND_REVIEW_TEXT,
							campus,
							Constant.BLANK,
							Constant.REMOVE,
							type);
					if(debug) logger.info("removed tasks: " + rowsAffected);

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					if(debug) logger.info("moved " + rowsAffected + " rows to history2: (" + alpha + " - " + num + ")");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if(debug) logger.info("deleted " + rowsAffected + " rows from history: (" + alpha + " - " + num + ")");

					//
					// reset starts here
					//
					if(progress.equals("APPROVAL") && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
						sql = "UPDATE tblfnd "
								+ "SET edit=0,edit0='',edit1='3',edit2='3',progress='APPROVAL',subprogress=null,reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND type=?";
					}
					else{
						sql = "UPDATE tblfnd "
								+ "SET edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY',subprogress=null,reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND type=?";
					}

					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					ps.setString(4, type);
					rowsAffected = ps.executeUpdate();
					if(debug) logger.info("updated " + rowsAffected + " row in tblfnd: (" + alpha + " - " + num + ")");

					//
					// create task again for approval. Modify task done elsewhere
					//
					if(progress.equals("APPROVAL") && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

						String nextDelegate = "";

						String nextApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);

						if(nextApprover != null && nextApprover.length() > 0){

							int currentSeq = ApproverDB.getApproverSequence(conn,nextApprover,route);

							if(currentSeq > 0){
								nextDelegate = ApproverDB.getDelegateBySeq(conn,campus,currentSeq,route);
							}

							rowsAffected = TaskDB.logTask(conn,
																	nextApprover,
																	proposer,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER);

							if (nextDelegate != null && nextDelegate.length() > 0){
								rowsAffected = TaskDB.logTask(conn,
																		nextDelegate,
																		proposer,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_APPROVER);
							}

						} // found nextApprover

					} // recreate task for approvers

					aseUtil.logAction(conn,"SYSTEM","Reset","Foundation course review status reset to modify",alpha,num,campus,kix);

				} // remove

			}	// while
			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException se ){
			logger.fatal("TaskDB: resetFndReviewStatus - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: resetFndReviewStatus - " + ex.toString());
		}
	} // TaskDB: resetFndReviewStatus

	/*
	 * resetReviewInReviewStatus - find courses under review where there are no reviewers and date has past
	 * <p>
	 * @param	conn		Connection
	 * @param	campus		String
	 * <p>
	 * @return	void
	 */
	public static void resetReviewInReviewStatus(Connection conn,String campus) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		// NOTE: this logic is similar to resetReviewStatus. Only difference is this
		// routine works on reviewers table for review in review
		//

		try{

			AseUtil aseUtil = new AseUtil();

			boolean debug = false;

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();

			int hours24 = dt.getHour24();
			int minutes = dt.getMinutes();
			String today = dt.getCurrentDate();

			int rowsAffected = 0;
			String alpha = "";
			String num = "";

			java.util.Date reviewDate = null;

			String sql = "SELECT campus, coursealpha, coursenum, userid, historyid, inviter, [level], duedate "
					+ "From tblReviewers WHERE campus=? AND progress = 'REVIEW_IN_REVIEW' "
					+ "AND  ([level] > 1) AND (duedate < GETDATE() + 1) "
					+ "ORDER BY campus,coursealpha,coursenum,duedate";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String userid = AseUtil.nullToBlank(rs.getString("userid"));
				int level = rs.getInt("level");

				//
				// default is to delete/remove
				//
				boolean remove = true;

				String sReviewDate = "";

				int daysDiff = -1;

				reviewDate = rs.getDate("duedate");
				if (reviewDate != null){

					sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

					daysDiff = DateUtility.compare2Dates(sReviewDate,today);

					if (daysDiff >= 0){
						remove = false;
					}
					else{
						remove = true;

						// if we have the same day, don't allow the removal until after midnight
						if(sReviewDate.equals(today)){
							if(hours24 < 24 && minutes < 60){
								remove = false;
							}
						}

					} // progress
				}
				else{
					remove = true;
				} // reviewDate != null

				if(debug){

					String outline = campus+"/"+alpha+"/"+num;

					if(remove){
						logger.info("removing - " + sReviewDate + "; outline: " + outline + "; diff: " + daysDiff);
					}
					else{
						logger.info("not removing - " + sReviewDate + "; outline: " + outline + "; diff: " + daysDiff);
					}
				} // debug

				//
				// what now?
				//
				if(remove){
					rowsAffected = ReviewerDB.deleteReviewer(conn,campus,kix,alpha,num,userid,level);
				} // remove

			}	// while
			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException se ){
			logger.fatal("TaskDB: resetReviewInReviewStatus - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: resetReviewInReviewStatus - " + ex.toString());
		}
	} // TaskDB: resetReviewInReviewStatus

	/*
	 * correctTaskType
	 * <p>
	 * @param	conn		Connection
	 * @param	campus		String
	 * <p>
	 * @return	int
	 */
	public static int correctTaskType(Connection conn,String campus){

		// somewhere along the way, the wrong type was added to table task
		// causing data to not display properly. only PRE should be found
		// in tasks.

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "select id,coursealpha,coursenum from tbltasks where campus=? and coursetype='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String alpha = rs.getString("coursealpha");
				String num = rs.getString("coursenum");
				int id = rs.getInt("id");

				// does the task exists as a PRE?
				if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){

					++rowsAffected;

					sql = "update tbltasks set coursetype='PRE' where id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,id);
					ps2.executeUpdate();
					ps2.close();
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("TaskDB:correctTaskType: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("TaskDB:correctTaskType: " + e.toString());
		}

		return rowsAffected;

	} // TaskDB:correctTaskType

	/*
	 * pendingApprovalCount - count pending approvals by kix information
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	message	String
	 * <p>
	 * @return	int
	 */
	public static int pendingApprovalCount(Connection conn,
														String campus,
														String user,
														String kix,
														String alpha,
														String num,
														String message) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int counter  = 0;

		try{
			String sql = "";
			PreparedStatement ps = null;
			ResultSet rs = null;

			if(message.toLowerCase().equals("approve cross listing")){
				sql = "SELECT count(td.chairname) as counter "
					+ "FROM tblXRef tx INNER JOIN "
					+ "tblDivision td ON tx.campus = td.campus AND tx.CourseAlphaX = td.divisioncode INNER JOIN "
					+ "tblCourse tc ON tx.historyid = tc.historyid "
					+ "WHERE tx.campus=? AND (tx.pending = 1) AND td.chairname=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				if(rs.next()){
					counter = rs.getInt("counter");
				}
				rs.close();
				ps.close();
			}
			else if(message.toLowerCase().equals("approve added requisite")){
				sql = "SELECT count(tp.historyid) as counter "
						+ "FROM tblPreReq tp LEFT OUTER JOIN  "
						+ "tblCourse tc ON tp.PreReqAlpha = tc.CourseAlpha  "
						+ "AND tp.PreReqNum = tc.CourseNum AND tp.Campus = tc.campus  "
						+ "WHERE tp.Campus=? AND tp.coursealpha=? AND tp.coursenum=? AND tp.coursetype='PRE' AND tp.pending=1";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				rs = ps.executeQuery();
				if(rs.next()){
					counter = rs.getInt("counter");
				}
				rs.close();
				ps.close();

				sql = "SELECT count(tp.historyid) as counter "
						+ "FROM tblCoReq tp LEFT OUTER JOIN  "
						+ "tblCourse tc ON tp.coreqAlpha = tc.CourseAlpha  "
						+ "AND tp.coreqNum = tc.CourseNum AND tp.Campus = tc.campus  "
						+ "WHERE tp.Campus=? AND tp.coursealpha=? AND tp.coursenum=? AND tp.coursetype='PRE' AND tp.pending=1";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				rs = ps.executeQuery();
				if(rs.next()){
					counter = counter + rs.getInt("counter");
				}
				rs.close();
				ps.close();

			}
			else if(message.toLowerCase().equals("approve added program")){
				sql = "SELECT count(tp.historyid) as counter "
					+ "FROM tblExtra tp LEFT OUTER JOIN  "
					+ "vw_ProgramForViewing vw ON tp.Campus = vw.campus "
					+ "AND tp.Grading = vw.historyid  "
					+ "WHERE tp.Campus=? AND tp.historyid=? AND tp.pending=1";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				rs = ps.executeQuery();
				if(rs.next()){
					counter = rs.getInt("counter");
				}
				rs.close();
				ps.close();
			}

		} catch (Exception e) {
			logger.fatal("TaskDB: pendingApprovalCount - " + e.toString());
		}

		return counter ;

	} // TaskDB: pendingApprovalCount

	public void close() throws SQLException {}

}