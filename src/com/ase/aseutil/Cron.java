/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * boolean cronJob
 *	public static int cleanCampusOutlinesTable(Connection conn){
 *
 */

//
// Cron.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class Cron {
	static Logger logger = Logger.getLogger(Cron.class.getName());

	/*
	 * constructor
	 *
	 */
	public Cron(Connection conn,javax.servlet.http.HttpSession session,String dataType) throws Exception{

		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

		dataType = "SQL";

		clearReviewers(conn,campus);

		deActivateUsers(conn,campus,dataType);

		cleanCampusOutlinesTable(conn);

		notYourTurn(conn);
	}

	/*
	 * clearReviewers
	 *
	 */
	public static void clearReviewers(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// handled by TaskDB.removeStrayReviewers

		int rowsAffected = 0;

		boolean debug = false;

		try {
			if (debug) logger.info("------------------- Cron clearReviewer START");

			String alpha = "";
			String num = "";
			String proposer = "";
			String kix = "";
			String progress = "";
			String subprogress = "";
			String updateSQL = "";
			String taskText = "";
			String logActionText = "";
			String logActionName = "";
			String currentApprover = "";
			String reviewDate = "";
			String remover = "";

			/*
			 * code to reset review dates once expired
			 * 1. get all courses where the review date is less than today and in review progress
			 *	2. loop through and reset to modify mode
			 *	3. delete pending reviewer names and tasks
			 * 4. create task for proposer
			 */
			String updateReview = "UPDATE tblCourse SET reviewdate=null,progress='MODIFY',edit='1',edit1='1',edit2='1',subprogress='' "
					+ "WHERE historyid=?";

			String updateReviewInApproval = "UPDATE tblCourse SET reviewdate=null,progress='APPROVAL',edit='0',edit1='3',edit2='3',subprogress='' "
					+ "WHERE historyid=?";

			String select = "SELECT campus,CourseAlpha,CourseNum,reviewdate,proposer,historyid,progress,subprogress ";

			String sql = select
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND reviewdate < " + DateUtility.getSystemDateSQL("yyyy-MM-dd") + " "
					+ "AND ((CourseType='PRE' AND progress='REVIEW') "
					+ "OR (CourseType='PRE' AND Progress='APPROVAL' AND SubProgress='REVIEW_IN_APPROVAL')) "
					+ "ORDER BY CourseAlpha, CourseNum";

			if (campus == null){
				// same as above but without campus
				sql = select
					+ "FROM tblCourse "
					+ "WHERE reviewdate < " + DateUtility.getSystemDateSQL("yyyy-MM-dd") + " "
					+ "AND ((CourseType='PRE' AND progress='REVIEW') "
					+ "OR (CourseType='PRE' AND Progress='APPROVAL' AND SubProgress='REVIEW_IN_APPROVAL')) "
					+ "ORDER BY CourseAlpha, CourseNum";
			}

			// 1-2
			PreparedStatement ps2 = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			if (campus != null){
				ps.setString(1, campus);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
				num = AseUtil.nullToBlank(rs.getString("CourseNum"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));

				AseUtil ae = new AseUtil();
				reviewDate = ae.ASE_FormatDateTime(rs.getString("reviewdate"),Constant.DATE_DATETIME);
				ae = null;

				if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
					updateSQL = updateReviewInApproval;
					taskText = Constant.APPROVAL_TEXT;
					currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					logActionText = "Review period expired ("+reviewDate+"). Recreated approval task for: " + currentApprover;
					remover = currentApprover;
					logActionName = currentApprover;
				}
				else if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					updateSQL = updateReview;
					taskText = Constant.MODIFY_TEXT;
					logActionText = "Review period expired ("+reviewDate+"). Recreated modify task for: " + proposer;
					remover = proposer;
					logActionName = proposer;
				}
				ps2 = conn.prepareStatement(updateSQL);
				ps2.setString(1,kix);
				rowsAffected = ps2.executeUpdate();
				ps2.close();
				if (debug) logger.info(rowsAffected + " - " + taskText + " - " + alpha + " - " + num);

				// 3. remove existing task for proposer
				rowsAffected = ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,remover);
				if (debug) logger.info("deleted " + rowsAffected + " tasks");

				// 4. add task for proposer
				rowsAffected = TaskDB.logTask(conn,
														logActionName,
														proposer,
														alpha,
														num,
														taskText,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE);

				AseUtil.logAction(conn,
										logActionName,
										"ACTION",
										logActionText,
										alpha,
										num,
										campus,
										kix);
			}

			rs.close();
			ps.close();

			if (debug) logger.info("------------------- Cron clearReviewer END");

		} catch (SQLException e) {
			logger.fatal("Cron: clearReviewers - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Cron: clearReviewers - " + e.toString());
		}

		return;
	}

	/*
	 * deActiveUsers
	 *
	 * @return boolean
	 */
	public static boolean deActivateUsers(Connection conn,String campus,String dataType) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// String dataType not used

		boolean cron = true;
		int rowsAffected = 0;

		try {
			Ini ini = IniDB.getIniByCampusCategoryKid(conn,campus,"System","DaysToDeactivate");
			if (ini != null){
				int days = NumericUtil.getInt(ini.getKval1(),0);

				if (days>0){
					String sql = "";
					PreparedStatement ps = null;

					// run based on having campus or not
					if (campus!= null && campus.length() > 0){
						sql = "SELECT campus,userid FROM tblUsers WHERE campus=? AND status<>'Inactive' AND (DateDiff(day,[lastused],getdate())>?)";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setInt(2,days);
					}
					else{
						sql = "SELECT campus,userid FROM tblUsers WHERE status<>'Inactive' AND (DateDiff(day,[lastused],getdate())>?)";
						ps = conn.prepareStatement(sql);
						ps.setInt(1,days);
					}

					ResultSet rs = ps.executeQuery();
					while(rs.next()){
						String userid = rs.getString("userid");
						campus = rs.getString("campus");
						sql = "UPDATE tblUsers SET status='Inactive' WHERE campus=? AND userid=? AND status<>'Inactive'";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,campus);
						ps2.setString(2,userid);
						rowsAffected = ps2.executeUpdate();
						ps2.close();

						if (rowsAffected>0){
							AseUtil.logAction(conn,"CronJob","ACTION","Deactivated user "+userid,"SUCCESS","",campus,"");
						}
						else{
							AseUtil.logAction(conn,"CronJob","ACTION","Deactivated user "+userid,"FAILED","",campus,"");
						}
					}
					rs.close();
					ps.close();
				}
			}

		} catch (Exception e) {
			logger.fatal("Cron: deActiveUsers - " + e.toString());
			cron = false;
		}

		return cron;
	}

	/**
	 * cleanCampusOutlinesTable - remove non linked outlines from CampusOutlines
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return	int
	 */
	public static int cleanCampusOutlinesTable(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;
		boolean linked = false;
		String[] campuses = null;
		String historyid = "";
		String alpha = "";
		String num = "";
		long id = 0;

		boolean debug = false;

		try{
			String campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");
			if (campus != null){

				if (debug) logger.info("------------------- cleanCampusOutlinesTable START");

				campuses = campus.split(",");
				String sql = "SELECT id, coursealpha, coursenum, " + campus
								+ " FROM tblCampusOutlines ORDER BY coursealpha,coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					linked = false;

					id = rs.getLong("id");
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));

					for (i=0;i<campuses.length;i++){
						historyid = AseUtil.nullToBlank(rs.getString(campuses[i]));

						if (!historyid.equals(Constant.BLANK))
							linked = true;
					}

					if (!linked){
						rowsAffected += CampusDB.removeCampusOutline(conn,id);
						if (debug) logger.info("removed from campus outlines - " + alpha + " " + num);
					}
				}
				rs.close();
				ps.close();

				if (debug) logger.info("------------------- cleanCampusOutlinesTable END");

			} // campus
		}
		catch( SQLException e ){
			logger.fatal("Cron: cleanCampusOutlinesTable - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Cron: cleanCampusOutlinesTable - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * notYourTurn
	 */
	public static void notYourTurn(Connection conn){

		//Logger logger = Logger.getLogger("test");

		// approvers are assigned out of sequence and is receiving not your turn to approve
		// this routine runs through current approvals to identify where it is that
		// a person should not be but has a test on his/her list to approve.

		// if it's there incorrectly, it should be deleted or left there since a message
		// is made available for user to delete the incorrect task

		// for now, we only display the outlines for references. no actual fix implemented

		boolean debug = false;

		try{
			if(debug) logger.info("------------------- START");

			String sql = "SELECT historyid,coursealpha,coursenum,proposer,route,coursetype,campus "
						+ "FROM tblCourse WHERE progress='APPROVAL' ORDER BY coursealpha,coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				int route = rs.getInt("route");

				if (route > 0){

					String approver = ApproverDB.getApproverNames(conn,campus,alpha,route);

					if (approver != null && approver.length() > 0){
						String[] approvers = approver.split(",");

						int lastApproverSequence = ApproverDB.getLastApproverSequence(conn,campus,kix);

						if (lastApproverSequence < approvers.length){

							if (!CourseDB.isNextApprover(conn,campus,alpha,num,approvers[lastApproverSequence])){

								if(debug){
									logger.info("------------------------------------------");
									logger.info("kix: " + kix);
									logger.info("alhpa: " + alpha);
									logger.info("num: " + num);
									logger.info("proposer: " + proposer);
									logger.info("route: " + route);
									logger.info("current Approver: " + (lastApproverSequence-1) + " - " + approvers[lastApproverSequence-1]);
									logger.info("next Approver: " + (lastApproverSequence) + " - " + approvers[lastApproverSequence]);
								}

								int rowsAffected = TaskDB.logTask(conn,
																		approvers[lastApproverSequence],
																		approvers[lastApproverSequence],
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		type);
								if (rowsAffected > 0){
									if (debug) logger.info("out of sequence approval task removed");
								}

							}
						} // lastApproverSequence

					} // approver

				} // route

			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------- END");

		}
		catch(SQLException e){
			logger.info("Cron - notYourTurn - " + e.toString());
		}
		catch(Exception e){
			logger.info("Cron - notYourTurn - " + e.toString());
		}

	} // notYourTurn

	public void close() throws SQLException {}

}