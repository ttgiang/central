/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static boolean approvalStarted(Connection,String,String,String)
 * public static boolean createSLO(Connection conn,String campus,String alpha,String num,String user,String kix)
 *	public static Msg cancelSLOApproval(Connection,String,String,String,String)
 *	public static Msg cancelSLOReview(Connection,String,String)
 *	public static int createACCJCEntries(Connection,String,String,String,String)
 *	public static boolean canStartAssessment(Connection,String,String,String,String)
 *	public static int deleteSLO(Connection String){
 * public static boolean doesSLOExist(Connection,String,String,String)
 * public static String getAssesser(Connection,String campus,String alpha,String num)
 * public static boolean getSLOByID(Connection,int)
 * public static int insertSLO(Connection,SLO)
 * public static int insertSLO(Connection,String,String,String,String,String)
 *	public static int insertSLOX(Connection,String,String,String,String,String)
 * public static boolean isAssessible(Connection conn,String kix,String user)
 * public static boolean isDeletable(Connection conn, int id)
 *	public static boolean isReadyForApproval(Connection conn,String campus,String kix)
 *	public static int reviewCompleted(Connection,String kix,String user,String proposer)
 *	public static boolean reviewStarted(Connection,String,String,String)
 *	public static int saveLinkedData(HttpServletRequest request,Connection conn,String campus,
 *												String src,String kix,String user)
 *	public static String showSLOProgress(Connection,String,String,int)
 *	public static String showSLOs(Connection conn,String campus,String user,String reportName,String progress,boolean hasData)
 *	public static boolean sloProgress(Connection conn,String kix,String progress)
 *	public static boolean sloProgress(Connection,String,String,String,String,String)
 *	public static int updateSLO(Connection,SLO)
 */

//
// SLODB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class SLODB {
	static Logger logger = Logger.getLogger(SLODB.class.getName());

	public SLODB() throws Exception {}

	/**
	 * security isMatch
	 */
	public static boolean isMatch(Connection connection,
											String campus,
											String alpha,
											String num) throws SQLException {

		String sql = "SELECT id FROM tblSLO WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,"PRE");
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * security isMatch
	 */
	public static boolean isMatch(Connection connection,
										String campus,
										String alpha,
										String num,
										String progress) throws SQLException {

		String sql = "SELECT id FROM tblSLO WHERE campus=? AND coursealpha=? AND coursenum=? AND progress=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,progress);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * security insertSLO
	 */
	public static int insertSLO(Connection connection,SLO slo) {

		int rowsAffected = 0;

		rowsAffected = insertSLOX(connection,slo.getCampus(),
											slo.getCourseAlpha(),
											slo.getCourseNum(),
											slo.getAuditBy(),
											slo.getProgress(),
											slo.getHid());
		return rowsAffected;
	}

	/**
	 * security insertSLO
	 */
	public static int insertSLO(Connection connection,
											String campus,
											String alpha,
											String num,
											String user,
											String progress,
											String kix) {
		int rowsAffected = 0;

		rowsAffected = insertSLOX(connection,campus,alpha,num,user,progress,kix);

		return rowsAffected;
	}

	/**
	 * insertSLOX
	 *
	 *	returns 1 if saved successfully without a match already
	 *	returns 999 if a match was found
	 */
	public static int insertSLOX(Connection conn,
											String campus,
											String alpha,
											String num,
											String user,
											String progress,
											String kix) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String mailMsg = "";							// mail message
		String sloList = "";							// who to send to (reviewers or approvers)
		String sloTask = "";							// names to send to
		String type = "";

		final int APPROVAL	= 0;
		final int ASSESS 		= 1;
		final int MODIFY 		= 2;
		final int REVIEW 		= 3;
		int operation 			= 0;
		boolean sendMail		= false;				// is this a sendmail operation
		String sql = "";
		PreparedStatement ps;

		if (!kix.equals("")){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}

		if ("APPROVAL".equals(progress))
			operation = APPROVAL;
		else if ("ASSESS".equals(progress))
			operation = ASSESS;
		else if ("MODIFY".equals(progress))
			operation = MODIFY;
		else if ("REVIEW".equals(progress))
			operation = REVIEW;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"SLODB");

			sloList = "";
			sloTask = "";
			mailMsg = "";

			switch(operation){
				case APPROVAL:
					sloList = "SLOApprover";
					sloTask = "Approve SLO";
					mailMsg = "emailSLOApprovalRequest";
					sendMail = true;
					break;
				case ASSESS:
					sendMail = false;
					break;
				case MODIFY:
					sendMail = false;
					break;
				case REVIEW:
					sloList = "SLOReviewer";
					sloTask = "Review SLO";
					mailMsg = "emailSLOReviewRequest";
					sendMail = true;
					break;
			}

			if (debug){
				logger.info("sloList: " + sloList);
				logger.info("sloTask: " + sloTask);
				logger.info("mailMsg: " + mailMsg);
			}

			// update and set the appropriate progress
			sql = "UPDATE tblSLO SET progress=?,auditby=?,auditdate=? WHERE hid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,progress);
			ps.setString(2,user);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// in case we didn't create one
			if(rowsAffected < 1){
				createSLO(conn,campus,alpha,num,user,kix,progress);
			}

			// for assessment, create default entries to get started
			if (operation==ASSESS){
				rowsAffected = createACCJCEntries(conn,campus,alpha,num,user);
				rowsAffected = createAssessedDataEntries(conn,campus,alpha,num,type,user);
			}

			// send mail
			if (sendMail){
				String reviewersApprovers = DistributionDB.getDistributionMembers(conn,campus,sloList);
				if (reviewersApprovers!=null && !reviewersApprovers.equals("")){
					String[] tasks = new String[100];
					tasks = reviewersApprovers.split(",");
					for (int i=0; i<tasks.length; i++) {
						rowsAffected = TaskDB.logTask(conn,tasks[i],user,alpha,num,sloTask,campus,"crsrwslo","ADD",type);
					}
				}

				MailerDB mailerDB = new MailerDB(conn,user,reviewersApprovers,"","",alpha,num,campus,mailMsg,kix,user);
			} // sendMail

			switch(operation){
				case APPROVAL:
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"SLO Assessment",campus,"","REMOVE",type);
					break;
				case ASSESS:
					break;
				case MODIFY:
					break;
				case REVIEW:
					break;
			}

		} catch (SQLException e) {
			logger.fatal("SLODB: insertSLO - " + e.toString());
			rowsAffected = 0;
		} catch (Exception ex) {
			logger.fatal("SLODB: insertSLO - " + ex.toString());
			rowsAffected = 0;
		}

		return rowsAffected;

	} // SLODB: insertSLO

	/**
	 * deleteSLO
	 */
	public static int deleteSLO(Connection connection, String id) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblSLO WHERE id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: deleteSLO - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * updateSLO
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	slo			SLO
	 *	<p>
	 *	@return int
	 */
	public static int updateSLO(Connection connection, SLO slo) {
		int rowsAffected = 0;
		int i = 0;
		String sql = "UPDATE tblSLO SET progress=?,auditby=?,auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, slo.getProgress());
			ps.setString(2, slo.getAuditBy());
			ps.setString(3, AseUtil.getCurrentDateTimeString());
			ps.setString(4, slo.getCampus());
			ps.setString(5, slo.getCourseAlpha());
			ps.setString(6, slo.getCourseNum());
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SLODB: updateSLO - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * sloProgress returns true/false depending on progress
	 *	<p>
	 *	@return boolean
	 */
	public static boolean sloProgress(Connection conn,String kix,String progress) throws SQLException {

		boolean slo = false;

		try {
			String sql = "SELECT progress FROM tblSLO WHERE hid=? AND progress=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, kix);
			ps.setString(2, progress);
			ResultSet rs = ps.executeQuery();
			slo = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: sloProgress - " + e.toString());
		}

		return slo;
	}

	/*
	 * sloProgress returns true/false depending on progress
	 *	<p>
	 *	@return boolean
	 */
	public static boolean sloProgress(Connection conn,
													String campus,
													String alpha,
													String num,
													String type,
													String progress) throws SQLException {

		boolean slo = false;

		try {
			String sql = "SELECT progress FROM tblSLO WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=? AND progress=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, progress);
			ResultSet rs = ps.executeQuery();
			slo = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: sloProgress - " + e.toString());
		}

		return slo;
	}

	/*
	 * reviewCompleted - notifies proposer that SLO review has completed
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	reviewer	String
	 * @param	proposer	String
	 * <p>
	 *	@return int
	 */
	public static int reviewCompleted(Connection conn,String kix,String reviewer,String proposer) throws SQLException {

		int rowsAffected = 0;
		String progress = "MODIFY";

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		try {
			String sql = "UPDATE tblSLO SET progress=?,auditby=?,auditdate=? WHERE hid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,progress);
			ps.setString(2,reviewer);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// get names of reviewers for show and mailing
			String reviewers = DistributionDB.getDistributionMembers(conn,campus,"SLOReviewer");

			// remove reviewer task
			if (!reviewers.equals("") && reviewers != null){
				String[] tasks = new String[100];
				tasks = reviewers.split(",");
				for (int i=0; i<tasks.length; i++) {
					rowsAffected = TaskDB.logTask(conn,tasks[i],reviewer,alpha,num,"Review SLO",campus,"crsrwslo","REMOVE",type);
				}
			}

			// notify proposer
			MailerDB mailerDB = new MailerDB(conn,reviewer,proposer,"","",alpha,num,campus,"emailSLOReviewCompleted",kix,reviewer);
		} catch (SQLException e) {
			logger.fatal("SLODB: reviewCompleted - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("SLODB: reviewCompleted - " + ex.toString());
			return 0;
		}

		return rowsAffected;
	}

	/*
	 * approvalStarted - returns true if the approval has started for an outline.
	 *<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *<p>
	 * @return boolean
	 */
	public static boolean approvalStarted(Connection connection,
														String campus,
														String alpha,
														String num) {

		boolean started = false;

		try {
			String sql = "SELECT Count(Campus) AS [counter] " +
							"FROM tblCourseComp " +
							"GROUP BY Campus, CourseAlpha, CourseNum, CourseType, ApprovedBy " +
							"HAVING Campus=? AND CourseAlpha=? AND CourseNum= ? AND CourseType='PRE' AND (ApprovedBy<>'' And ApprovedBy Is Null)";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				int x = rs.getInt("counter");
				if (x>0)
					started = true;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: approvalStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: approvalStarted - " + ex.toString());
		}

		return started;
	}

	/*
	 * reviewStarted - returns true if the reviews has started for an outline.
	 *							starting reviews means adding comments to individual SLO.
	 *<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *<p>
	 * @return	boolean
	 */
	public static boolean reviewStarted(Connection connection,
														String campus,
														String alpha,
														String num) {

		boolean started = false;

		try {

			/*
				initially, approved is null or empty. Once review begins, the values are Y or N.
				if values exists, they have been started.
			*/
			String sql = "SELECT COUNT(Campus) AS counter " +
							"FROM tblCourseComp " +
							"GROUP BY Campus, CourseAlpha, CourseNum, CourseType, Approved " +
							"HAVING Campus=? AND " +
							"CourseAlpha=? AND " +
							"CourseNum=? AND " +
							"CourseType='PRE' AND " +
							"(Approved='Y' OR Approved='N')";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				int x = rs.getInt("counter");
				if (x>0)
					started = true;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: reviewStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: reviewStarted - " + ex.toString());
		}

		return started;
	}

	/*
	 * cancelSLOApproval - cancels the approval process after requesting to start.
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelSLOApproval(Connection conn,
														String campus,
														String alpha,
														String num,
														String type,
														String user) throws Exception {

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in approval process
		 * 1) Must be proposer
		 * 2) Cannot have any comments in the system (tblApprovalHist)
		 * 3) Remove tasks
		 * 4) Notify approvers
		 */

		int rowsAffected = 0;
		Msg msg = new Msg();
		StringBuffer errorLog = new StringBuffer();

		try{
			String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);
			if (proposer.equals(user)){
				if (!approvalStarted(conn,campus,alpha,num) ){
					String sql = "UPDATE tblSLO SET progress='ASSESS' WHERE hid=?";
					String kix = Helper.getKix(conn,campus,alpha,num,type);
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();

					// get names of reviewers for show and mailing
					String approvers = DistributionDB.getDistributionMembers(conn,campus,"SLOApprover");

					// remove reviewer task
					if (!approvers.equals("") && approvers != null){
						String[] tasks = new String[100];
						tasks = approvers.split(",");
						for (int i=0; i<tasks.length; i++) {
							rowsAffected = TaskDB.logTask(conn,tasks[i],proposer,alpha,num,"Approve SLO",campus,"crsrwslo.jsp","REMOVE",type);
						}
					}
					// notify approvers
					MailerDB mailerDB = new MailerDB(conn,proposer,approvers,"","",alpha,num,campus,"emailSLOApprovalCancelled",kix,user);
				}
				else{
					msg.setMsg("SLOApprovalStarted");
					logger.info("SLODB: cancelSLOApproval - SLO approval started by approvers.");
				}
			}
			else{
				msg.setMsg("SLOProposerCanCancel");
				logger.info("SLODB: cancelSLOApproval - Attempting to cancel when not proposer of outline.");
			}
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("SLODB: cancelSLOApproval - " + ex.toString() + " - " + errorLog.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("SLODB: cancelSLOApproval - " + e.toString() + " - " + errorLog.toString());
		}

		return msg;
	}

	/*
	 * cancelSLOReview - cancels the review process after requesting to start.
	 * <p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 * @param	user	String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg cancelSLOReview(Connection conn,String kix,String user) throws Exception {

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in approval process
		 * 1) Must be proposer
		 * 2) by the time we reach here, the review check has been completed and overriden.
		 *		we don't want to allow delete once review has begun, however, overriding is
		 *		an option (see crscanslo.jsp and errorCode = 1)
		 * 3) Remove tasks
		 * 4) Notify approvers
		 */

		int rowsAffected = 0;
		Msg msg = new Msg();
		StringBuffer errorLog = new StringBuffer();

		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		try{
			String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);
			if (proposer.equals(user)){
				String sql = "UPDATE tblSLO SET progress='MODIFY' WHERE hid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();

				// get names of reviewers for show and mailing
				String reviewers = DistributionDB.getDistributionMembers(conn,campus,"SLOReviewer");

				// remove reviewer task
				if (!"".equals(reviewers) && reviewers != null){
					String[] tasks = new String[100];
					tasks = reviewers.split(",");
					for (int i=0; i<tasks.length; i++) {
						rowsAffected = TaskDB.logTask(conn,tasks[i],proposer,alpha,num,"Review SLO",campus,"crsrwslo.jsp","REMOVE",type);
						logger.info("SLODB: cancelSLOReview - remove task " + (i+1) + " of " + tasks.length + " - " + rowsAffected + " row");
					}
				}

				// notify reviewers
				MailerDB mailerDB = new MailerDB(conn,proposer,reviewers,"","",alpha,num,campus,"emailSLOReviewCancelled",kix,user);
			}
			else{
				msg.setMsg("SLOProposerCanCancel");
				logger.info("SLODB: cancelSLOReview - Attempting to cancel when not proposer of outline.");
			}
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("SLODB: cancelSLOReview - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("SLODB: cancelSLOReview - " + e.toString());
		}

		return msg;
	}

	/*
	 * canStartAssessment - can we begin assessing this outline
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean canStartAssessment(Connection conn,
															String campus,
															String alpha,
															String num,
															String user) throws Exception {

		boolean canStart = true;

		try{
			String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
			if (!proposer.equals(user)){
				canStart = false;
				logger.info("SLODB: canStartAssessment- Not proposer of outline.");
			}
			else{
				if (sloProgress(conn,campus,alpha,num,"PRE","APPROVED") || doesSLOExist(conn,campus,alpha,num)){
					canStart = false;
				}
			}
		} catch (SQLException ex) {
			canStart = false;
			logger.fatal("SLODB: canStartAssessment - " + ex.toString());
		} catch (Exception e) {
			canStart = false;
			logger.fatal("SLODB: canStartAssessment - " + e.toString());
		}

		return canStart;
	}

	/*
	 * doesSLOExist - whether there is an entry or not
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 *	@return boolean
	 */
	public static boolean doesSLOExist(Connection connection,
														String campus,
														String alpha,
														String num) {
		boolean found = false;

		try {
			String sql = "SELECT campus FROM tblSLO WHERE Campus=? AND CourseAlpha=? AND CourseNum=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet rs = ps.executeQuery();
			found = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: doesSLOExist - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: doesSLOExist - " + ex.toString());
		}

		return found;
	}

	/**
	 * createACCJCEntries - when starting to assess SLO, copy comps to ACCJC table as prep
	 * <p>
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 * @return int
	 */
	public static int createACCJCEntries(Connection conn,String campus,String alpha,String num,String user) {

		int comp = 0;
		int rows = 0;
		String type = "PRE";

		try {
			String sql = "SELECT compid FROM tblcoursecomp WHERE campus=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				comp = rs.getInt("compid");
				Msg msg = CourseACCJCDB.courseACCJC(conn,"a",user,campus,alpha,num,type,0,comp,0);
				++rows;
			}

			rs.close();
			ps.close();

			String kix = Helper.getKix(conn,campus,alpha,num,type);

		} catch (SQLException e) {
			logger.fatal("SLODB: createACCJCEntries - " + e.toString());
			rows = 0;
		} catch (Exception ex) {
			logger.fatal("SLODB: createACCJCEntries - " + ex.toString());
			rows = 0;
		}

		return rows;
	}

	/**
	 * createAssessedDataEntries - when starting to assess SLO, set up for assessment data
	 * <p>
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		boolean
	 * @param	user		String
	 * <p>
	 * @return int
	 */
	public static int createAssessedDataEntries(Connection conn,String campus,String alpha,String num,String type,String user) {

		int id = 0;
		int rows = 0;
		try {
			String sql = "SELECT id " +
				"FROM tblCourseACCJC " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, "PRE");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				rows += AssessedDataDB.insertAssessedData(id,campus,alpha,num,type,user);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SLODB: createAssessedDataEntries - " + e.toString());
			rows = 0;
		} catch (Exception ex) {
			logger.fatal("SLODB: createAssessedDataEntries - " + ex.toString());
			rows = 0;
		}

		return rows;
	}

	/**
	 * getSLOByID - returns the SLO by ID
	 *	<p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 * @return String
	 */
	public static String getSLOByID(Connection conn, int id) {

		String slo = "";

		try {
			String sql = "SELECT comp FROM tblCourseComp WHERE CompID=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				slo = AseUtil.nullToBlank(rs.getString("comp"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: getSLOByID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: getSLOByID - " + ex.toString());
		}

		return slo;
	}

	/**
	 * isDeletable - can this SLO be deleted
	 *	<p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isDeletable(Connection conn, int id) {

		boolean deletable = false;

		try {
			String sql = "SELECT COUNT(historyid) AS counter FROM tblCourseContentSLO WHERE sloid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getInt("counter")>0)
					deletable = false;
				else
					deletable = true;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: isDeletable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: isDeletable - " + ex.toString());
		}

		return deletable;
	}

	/*
	 * showSLOProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	progress	String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showSLOProgress(Connection conn,String campus,String progress,int idx){

		String alpha = "";
		String num = "";
		String type = "";
		String kix = "";
		String link = "";
		String outlines = "";
		String rowColor = "";
		String sql = "";
		String title = "";
		String proposer = "";
		StringBuffer output = new StringBuffer();

		boolean found = false;
		int j = 0;

		try {
			sql = "SELECT hid,coursealpha,coursenum,progress,auditby,coursetype FROM tblSLO WHERE campus=? ";

			if (idx>0)
				sql += "AND coursealpha like '" + (char)idx + "%' ";

			if ("".equals(progress))
				sql += "AND progress like '%%' ";
			else
				sql += "AND progress=? ";

			sql += "ORDER BY coursealpha,coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);

			if (!"".equals(progress))
				ps.setString(2, progress);

			ResultSet results = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (results.next()) {
				found = true;
				kix = AseUtil.nullToBlank(results.getString("hid"));
				alpha = AseUtil.nullToBlank(results.getString("coursealpha"));
				num = AseUtil.nullToBlank(results.getString("coursenum"));
				progress = AseUtil.nullToBlank(results.getString("progress"));
				proposer = AseUtil.nullToBlank(results.getString("auditby"));
				type = AseUtil.nullToBlank(results.getString("coursetype"));
				title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type);
				link = "vwcrsslo.jsp?kix="+kix;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				output.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">" +
					"<td><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>" +
					"<td class=\"datacolumn\">" + title + "</td>" +
					"<td class=\"datacolumn\">" + proposer + "</td>" +
					"<td class=\"datacolumn\">" + progress + "</td>" +
					"</tr>");
			}
			results.close();
			ps.close();

			if (found){
				outlines = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"e1e1e1\">" +
					"<td class=\"textblackTH\" width=\"10%\">Outline</td>" +
					"<td class=\"textblackTH\" width=\"50%\">Title</td>" +
					"<td class=\"textblackTH\" width=\"20%\">Proposer</td>" +
					"<td class=\"textblackTH\" width=\"20%\">Progress</td>" +
					"</tr>" +
					output.toString() +
					"</table>";
			}
			else{
				outlines = "<p>Outlines not found</p>";
			}

		} catch (SQLException e) {
			logger.fatal("SLODB: showSLOProgress - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: showSLOProgress - " + ex.toString());
		}

		return outlines;
	}

	/*
	 * SLO is editable as long as not in review or approval
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isEditable(Connection connection,String kix,String user) {

		boolean editable = false;
		String proposer = "";
		String progress = "";

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(connection,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		try {
			String sql = "SELECT auditby,progress FROM tblSLO WHERE hid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, kix);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				proposer = results.getString(1);
				progress = results.getString(2);
			}
			results.close();

			if (user.equals(proposer) && "MODIFY".equals(progress))
				editable = true;
			else
				editable = false;

			ps.close();

		} catch (SQLException e) {
			logger.fatal("SLODB: isEditable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: isEditable - " + ex.toString());
		}

		return editable;
	}

	/*
	 * An outline is ready for approval if all reviews have been completed
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isReadyForApproval(Connection connection,String campus,String kix) throws SQLException {

		boolean readyForApproval = true;
		int counter = 0;

		/*
			initially, the readyForApproval flag is set to TRUE; When the SQL
			statement returns and the counter is greater than 0, we know
			there are SLO's not yet reviewed so we set to false.
			also is fasle on error.

			before performing the check, make sure that we have to check based
			on the system flag to check on review.
		*/

		try {
			String SLOReviewIsNecessary = IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","SLOReviewIsNecessary");

			if (SLOReviewIsNecessary.equals("1")){
				String sql = "SELECT COUNT(id) AS counter FROM tblCourseACCJC WHERE historyid=? " +
							"GROUP BY AssessedDate HAVING AssessedDate IS NULL";

				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1, kix);
				ResultSet results = ps.executeQuery();
				if (results.next()) {
					counter = results.getInt(1);
				}

				if (counter > 0)
					readyForApproval = false;

				results.close();
				ps.close();

			}

		} catch (SQLException e) {
			logger.fatal("SLODB: isReadyForApproval - " + e.toString());
			readyForApproval = false;
		}

		return readyForApproval;
	}


	/*
	 * createSLO
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * @param	kix		String
	 *	<p>
	 * @return 	boolean
	 */
	public static boolean createSLO(Connection conn,
													String campus,
													String alpha,
													String num,
													String user,
													String kix,
													String progress) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean created = false;
		int rowsAffected = 0;

		try {
			if (!SLODB.isMatch(conn,campus,alpha,num)){
				String sql = "INSERT INTO tblSLO (campus,coursealpha,coursenum,coursetype,auditby,progress,hid) VALUES (?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,"PRE");
				ps.setString(5,user);
				ps.setString(6,progress);
				ps.setString(7,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"SLO Review",campus,"","ADD","PRE");
			}

			created = true;

		} catch (SQLException ex) {
			logger.fatal("- SLODB: createSLO - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SLODB: createSLO - " + e.toString());
		}

		return created;
	} // SLODB: createSLO

	/*
	 * isAssessible - outline is assessible if it's in MODIFY progress
	 * <p>
	 *	@param	conn	Connection
	 * @param	kix			String
	 * @param	user			String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isAssessible(Connection conn,String kix,String user) throws SQLException {

		Msg msg = new Msg();

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String proposer = info[3];
			String campus = info[4];

			String assesser = SLODB.getAssesser(conn,campus,alpha,num);

			if (isMatch(conn,campus,alpha,num) && !user.equals(assesser)){
				msg.setMsg("SLOAlreadyBeingAssessed");
				msg.setErrorLog(assesser);
			}
			else{
				String getCourseProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

				if (user.equals(proposer) && "APPROVED".equals(getCourseProgress))
					msg.setMsg("");
			}

		} catch (SQLException e) {
			logger.fatal(kix + " - SLODB: isAssessible - " + e.toString());
		}

		return msg;
	}

	/*
	 * getAssesser - name of person assessing an outline
	 * <p>
	 *	@param	conn	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 *	@return	String
	 */
	public static String getAssesser(Connection conn,String campus,String alpha,String num) throws SQLException {

		String assesser = "";

		try {
			String sql = "SELECT auditby FROM tblSLO WHERE campus=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				assesser = AseUtil.nullToBlank(rs.getString("auditby"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SLODB: getAssesser - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SLODB: getAssesser - " + ex.toString());
		}

		return assesser;
	}

	/*
	 * isCancellable - An assessment is cancallable only if progress="ASSESS" and canceller = proposer
	 * <p>
	 *	@param	conn	Connection
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCancellable(Connection connection,
															String kix,
															String user) throws SQLException {
		boolean cancellable = false;
		String proposer = "";
		String progress = "";

		try {
			String[] info = Helper.getKixInfo(connection,kix);
			String alpha = info[0];
			String num = info[1];
			String campus = info[4];

			String sql = "SELECT auditby,progress FROM tblSLO WHERE hid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				proposer = results.getString("auditby");
				progress = results.getString("progress");
			}

			if (user.equals(proposer) && "ASSESS".equals(progress))
				cancellable = true;
			else
				cancellable = false;

			results.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SLODB: isCancellable - " + e.toString());
		}

		return cancellable;
	}

	/*
	 * Cancelling a course cancelAssesssment means to move it to cancelled table and not delete.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 *	@return 	int
	 */
	public static Msg cancelAssesssment(Connection conn,String campus,String kix,String user) throws Exception {

		Msg msg = new Msg();

		try{
			SLOCancel sc = new SLOCancel();
			msg = sc.cancelAssesssment(conn,campus,kix,user);
		}
		catch(Exception e){
			logger.fatal("CourseDB: cancelAssesssment - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/**
	 * showSLOs - display SLOs by campus. Progress is the status of outlines and hasData determines
	 *		whether to show outlines with SLOs or missing SLOs
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	reportName	String
	 * @param	progress		String
	 * @param	hasData		boolean
	 * <p>
	 * @return	String
	 */
	public static String showSLOsJQUERY(Connection conn,
											String campus,
											String user,
											String reportName,
											String progress,
											boolean hasData){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String num = "";
		String title = "";
		String type = "";
		String objectives = "";
		String temp = "";

		boolean append = false;
		boolean found = false;

		try{
			String sql = SQL.showSLOs(hasData);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				objectives = AseUtil.nullToBlank(rs.getString(Constant.COURSE_OBJECTIVES));
				objectives = AseUtil2.removeHTMLTags(objectives,-1);

				temp = objectives;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = objectives.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");
				} // has data

				String alphaIdx = alpha.substring(0,1).toLowerCase();

				if (hasData){
					if (append) listing.append("<li class=\"ln-"+alphaIdx+"\"><a href=\"crsrpt.jsp?src=showSLO&kix="
						+ kix + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				}
				else{
					listing.append("<li class=\"ln-"+alphaIdx+"\"><a href=\"vwcrsx.jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&t=" + type
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				} // has data

				found = true;

			} // while
			rs.close();
			ps.close();

			if (found){
				objectives = listing.toString();
			}
			else{
				objectives = "";
			}

		}
		catch(Exception ex){
			logger.fatal("SLODB: showSLOs - " + ex.toString());
		}

		return objectives;
	}

	public static String showSLOs(Connection conn,
											String campus,
											String user,
											String reportName,
											String progress,
											boolean hasData){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String alphaIdx = "";
		String holdIdx = "";
		String holdAlpha = "";
		String num = "";
		String title = "";
		String type = "";
		String objectives = "";
		String bookmark = "";
		String savedBookmark = "";
		String line = "";
		boolean found = false;

		boolean append = false;

		String temp = "";

		try{
			String sql = SQL.showSLOs(hasData);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			if(hasData){
				ps.setString(3,campus);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				objectives = AseUtil.nullToBlank(rs.getString(Constant.COURSE_OBJECTIVES));
				objectives = AseUtil2.removeHTMLTags(objectives,-1);

				temp = objectives;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = objectives.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");
				} // has data

				bookmark = "";
				line = "";

				alphaIdx = alpha.substring(0,1);

				// display letters for quick jump
				if (!holdIdx.equals(alphaIdx)){

					if (!holdIdx.equals(Constant.BLANK)){
						bookmark = "</ul>";
					}

					holdIdx = alphaIdx;

					bookmark += "<table width=\"50%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr bgcolor=#e1e1e1>"
						+ "<td width=\"50%\"><a id=\"" + alphaIdx + "\" name=\"" + alphaIdx + "\" class=\"linkcolumn\">[" + alphaIdx + "]</a></td>"
						+ "<td width=\"50%\" align=\"right\"><a href=\"#top\" class=\"linkcolumn\">back to top</a></td>"
						+ "</tr></table>";

					bookmark += "<ul>";

				}

				// put a blank line between different ALPHAs in the same letter
				if (!holdAlpha.equals(alpha)){
					holdAlpha = alpha;
				}

				// determine how much to print
				if (hasData)
					line = "<li><a href=\"crsrpt.jsp?src=showSLO&kix="
							+ kix
							+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";
				else
					line = "<li><a href=\"vwcrsx.jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&t=" + type
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";

				// do we print or not
				if (append){
					if (!savedBookmark.equals(Constant.BLANK)){
						bookmark = savedBookmark;
					}

					listing.append(bookmark + line);

					savedBookmark = "";
				}
				else{
					// when the index changes and we don't print, we save the content and
					// print the next time around.
					savedBookmark = bookmark;
				}

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				objectives = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td align=\"center\">"
					+ Helper.drawAlphaIndexBookmark(0,reportName)
					+ "</td></tr>"
					+ "<tr><td>"
					+ listing.toString()
					+ "</td></tr>"
					+ "</table>";
			}
			else
				objectives = "";
		}
		catch(Exception ex){
			logger.fatal("SLODB: showSLOs - " + ex.toString());
		}

		return objectives;
	}

	public static String showSLOsOBSOLETE(Connection conn,
											String campus,
											String user,
											String reportName,
											String progress,
											boolean hasData){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String alphaIdx = "";
		String holdIdx = "";
		String holdAlpha = "";
		String num = "";
		String title = "";
		String type = "";
		String objectives = "";
		String bookmark = "";
		String savedBookmark = "";
		String line = "";
		boolean found = false;

		boolean append = false;

		String temp = "";

		try{
			String sql = SQL.showSLOs(hasData);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ps.setString(3,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				objectives = AseUtil.nullToBlank(rs.getString(Constant.COURSE_OBJECTIVES));
				objectives = AseUtil2.removeHTMLTags(objectives,-1);

				temp = objectives;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = objectives.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");

					// if we only want with data and the content is empty, don't append
					if (temp.equals(Constant.BLANK)){
						append = false;
					}

				} // has data

				bookmark = "";
				line = "";

				alphaIdx = alpha.substring(0,1);

				// display letters for quick jump
				if (!holdIdx.equals(alphaIdx)){

					if (!holdIdx.equals(Constant.BLANK)){
						bookmark = "</ul>";
					}

					holdIdx = alphaIdx;

					bookmark += "<table width=\"50%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr bgcolor=#e1e1e1>"
						+ "<td width=\"50%\"><a id=\"" + alphaIdx + "\" name=\"" + alphaIdx + "\" class=\"linkcolumn\">[" + alphaIdx + "]</a></td>"
						+ "<td width=\"50%\" align=\"right\"><a href=\"#top\" class=\"linkcolumn\">back to top</a></td>"
						+ "</tr></table>";

					bookmark += "<ul>";

				}

				// put a blank line between different ALPHAs in the same letter
				if (!holdAlpha.equals(alpha)){
					holdAlpha = alpha;
				}

				// determine how much to print
				if (hasData)
					line = "<li><a href=\"crsrpt.jsp?src=showSLO&kix="
							+ kix
							+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";
				else
					line = "<li><a href=\"vwcrsx.jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&t=" + type
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";

				// do we print or not
				if (append){
					if (!savedBookmark.equals(Constant.BLANK)){
						bookmark = savedBookmark;
					}

					listing.append(bookmark + line);

					savedBookmark = "";
				}
				else{
					// when the index changes and we don't print, we save the content and
					// print the next time around.
					savedBookmark = bookmark;
				}

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				objectives = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td align=\"center\">"
					+ Helper.drawAlphaIndexBookmark(0,reportName)
					+ "</td></tr>"
					+ "<tr><td>"
					+ listing.toString()
					+ "</td></tr>"
					+ "</table>";
			}
			else
				objectives = "";
		}
		catch(Exception ex){
			logger.fatal("SLODB: showSLOs - " + ex.toString());
		}

		return objectives;
	}

	/**
	 * saveLinkedData
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int saveLinkedData(HttpServletRequest request,
												Connection conn,
												String campus,
												String src,
												String kix,
												String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String message = "";
		String alpha = "";
		String num = "";
		String contentid = "";
		String temp = "";

		try {
			WebSite website = new WebSite();

			alpha = website.getRequestParameter(request, "alpha");
			num = website.getRequestParameter(request, "num");
			contentid = website.getRequestParameter(request, "keyid");

			int totalKeys = website.getRequestParameter(request,"totalKeys", 0);
			String[] hiddenCompID = new String[totalKeys];
			hiddenCompID = website.getRequestParameter(request,"allKeys").split(",");

			PreparedStatement ps = null;

			// get rid of existing before updating
			String sql = "DELETE FROM tblCourseContentSLO WHERE historyid=? AND contentid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,contentid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			/*
				for all fields, check to see if it was checked. if yes, set
				to 1, else 0;
				the final result is CSV of 0's and 1's of items that can be
				edited.
			*/
			sql = "INSERT INTO tblCourseContentSLO(campus,coursealpha,coursenum,coursetype,contentid,sloid,auditby,auditdate,historyid) VALUES(?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for (int i = 0; i < totalKeys; i++) {
				temp = website.getRequestParameter(request, "link_" + hiddenCompID[i]);
				if (temp != null && !"".equals(temp)) {
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,"PRE");
					ps.setInt(5,Integer.parseInt(contentid));
					ps.setInt(6,Integer.parseInt(temp));
					ps.setString(7,user);
					ps.setString(8,AseUtil.getCurrentDateTimeString());
					ps.setString(9,kix);
					rowsAffected = ps.executeUpdate();
				}
			}
			ps.close();

			rowsAffected = 1;

		} catch (Exception e) {
			logger.fatal("Helper: saveLinkedData - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * saveLinkedData
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	kix			String
	 * @param	user			String
	 * @param	allKeys		String
	 * @param	contentid	int
	 * <p>
	 * @return	int
	 */
	public static int saveLinkedData2(Connection conn,
												String campus,
												String src,
												String kix,
												String user,
												String allKeys,
												int contentid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String message = "";
		String alpha = "";
		String num = "";
		String type = "";
		String temp = "";

		String[] hiddenID = null;

		int totalKeys = 0;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];

			if (allKeys != null && allKeys.length() > 0){
				hiddenID = allKeys.split(",");
				totalKeys = hiddenID.length;
			}

			// get rid of existing before updating
			String sql = "DELETE FROM tblCourseContentSLO WHERE historyid=? AND contentid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,contentid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			/*
				for all fields, check to see if it was checked. if yes, set to 1, else 0;
				the final result is CSV of 0's and 1's of items that can be edited.
			*/
			sql = "INSERT INTO tblCourseContentSLO(campus,coursealpha,coursenum,coursetype,contentid,sloid,auditby,auditdate,historyid) VALUES(?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for (int i = 0; i < totalKeys; i++) {
				temp = hiddenID[i];
				if (temp != null && !"".equals(temp)) {
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					ps.setInt(5,contentid);
					ps.setInt(6,Integer.parseInt(temp));
					ps.setString(7,user);
					ps.setString(8,AseUtil.getCurrentDateTimeString());
					ps.setString(9,kix);
					rowsAffected = ps.executeUpdate();
				}
			}
			ps.close();

			rowsAffected = 1;

		} catch (Exception e) {
			logger.fatal("Helper: saveLinkedData2 - " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}