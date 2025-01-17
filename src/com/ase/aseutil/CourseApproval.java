/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static Msg addApprovalTask(Connection conn,String kix,String nextApprover,String nextDelegate){
 *	public static int rejectOutline(Connection conn,String kix,Approver approver){
 *	public static int removeApprovalTask(Connection conn,String kix,String thisApprover,String thisDelegate){
 * public static int updateVoting(Connection conn,String kix,int voteFor,int voteAgainst,int voteAbstain) throws SQLException {
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseApproval.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class CourseApproval {

	static Logger logger = Logger.getLogger(CourseApproval.class.getName());

	public CourseApproval() throws Exception{}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	static boolean debug = false;

	/*
	 * approveOutline
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	approval		bollean
	 * @param	String		comments
	 * @param	voteFor		int
	 * @param	voteAgainst	int
	 * @param	voteAbstain	int
	 *	<p>
	 *	@return int
	 */
	public static Msg approveOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments,
												int voteFor,
												int voteAgainst,
												int voteAbstain) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//
		// in case user presses refresh, we want to prevent multiple executions.
		// Only run when there is an outline is in approval status.
		//
		// this is just double checking before executing. it's already checked
		// during the outline selection.
		//
		// if there is an outline, is this the next approver
		//

		Msg msg = new Msg();

		String type = "PRE";
		String kix = Helper.getKix(conn,campus,alpha,num,type);

		try{

			debug = DebugDB.getDebug(conn,"CourseApproval");

			String progress = CourseDB.getCourseProgress(conn,campus,alpha,num,"PRE");
			if (debug) logger.info(kix + " - progress - " + progress);

			if (progress.equals(Constant.COURSE_APPROVAL_TEXT) || progress.equals(Constant.COURSE_DELETE_TEXT)) {

				if (debug) logger.info(kix + " - correct progress");

				if (CourseDB.isNextApprover(conn,campus,alpha,num,user)) {

					if (debug) logger.info(kix + " - isNextApprover");

					AseUtil.logAction(conn, user, "ACTION","Outline approval ("+ alpha + " " + num + ")",alpha,num,campus,kix);

					msg = approveOutlineX(conn,campus,alpha,num,user,approval,comments,voteFor,voteAgainst,voteAbstain);

					AseUtil.logAction(conn, user, "ACTION","Outline approval ("+ alpha + " " + num + ")",alpha,num,campus,kix);

				} else {
					msg.setMsg("NotYourTurnToApprove");
					if (debug) logger.info(kix + " - " + user + " -  approveOutline - Attempting to approve out of sequence.");
				}
			} else {
				msg.setMsg("NoOutlineToApprove");
				if (debug) logger.info(kix + " - " + user + " -  approveOutline - Attempting to approve outline that is not editable.");
			}
		}
		catch(Exception e){
			msg.setMsg("Exception");
			logger.fatal(kix + " - " + user + " -  approveOutline - " + e.toString());
		}

		return msg;
	}

	public static Msg approveOutlineX(Connection connection,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments,
												int voteFor,
												int voteAgainst,
												int voteAbstain) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//boolean debug = true;

		boolean fastTrack = false;

		if (comments.equals(Constant.FAST_TRACK_TEXT)){
			fastTrack = true;
		}

		int z = 0;

		Connection conn = AsePool.createLongConnection();

		Msg msg = new Msg();

		String type = "PRE";

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);

		Approver approver = new Approver();

		String thisApprover = "";
		String thisDelegate = "";
		boolean thisExperiment = false;
		int thisSequence = 0;
		int approversThisSequence = 0;

		String skippedApprover = "";
		int skippedSequence = 0;

		String nextApprover = "";
		String nextDelegate = "";
		String nextExperiment = "";
		int nextSequence = 0;
		int approversNextSequence = 0;

		int lastSequence = 0;
		String proposer = "";
		String distName = "";

		boolean experimental = false;			// if experimental, sends to list of deans
		boolean distribution = false;			// current approver is part of distribution
		boolean forward = false;				// current approver is part of distribution
		boolean divisionChair = false;

		String mailSubject = "";
		String mailFrom = "";
		String mailTo = "";
		String mailCC = "";

		String sql = "";
		int rowsAffected = 0;
		String[] tasks = new String[20];
		String comment = "";
		boolean continueToNextApproval = false;

		MailerDB mailerDB;
		Mailer mailer = new Mailer();

		try {

			if (debug) logger.info(kix + " - " + user + " - approveOutlineX - START");

			experimental = Outlines.isExperimental(num);

			approver = ApproverDB.getApprovers(conn,campus,alpha,num,user,experimental,route);

			lastSequence = ApproverDB.maxApproverSeqID(conn,campus,route);

			distribution = approver.getDistributionList();

			distName = approver.getDistributionName();

			thisDelegate = approver.getDelegated();
			thisSequence = Integer.parseInt(approver.getSeq());
			thisExperiment = approver.getExcludeFromExperimental();

			if (distribution){
				thisApprover = ApproverDB.getApproversBySeq(conn,campus,thisSequence,route);
				thisApprover = DistributionDB.getDistributionMembers(conn,campus,thisApprover);
				if (debug) logger.info("Distribution approval");
			}
			else{
				thisApprover = user;
			}

			if (debug){
				logger.info("experimental: " + experimental);
				logger.info("thisSequence: " + thisSequence);
				logger.info("thisDelegate: " + thisDelegate);
				logger.info("lastSequence: " + lastSequence);
				logger.info("\napprover:\n" + approver);
			}

			// when thisApprover is empty, it's likely that there was no set approver the system could find
			// so it was selected by the user
			if (thisApprover.equals(Constant.BLANK)){
				thisApprover =  user;
			}

			nextApprover = approver.getNextApprover();
			nextDelegate = approver.getNextDelegate();
			nextSequence = Integer.parseInt(approver.getNextSequence());
			nextExperiment = approver.getNextExperiment();

			// if the next up is not approving because of experimental, get the one after
			// however if the next is experiment and is last person, then this current
			// is the last to approve
			if (nextExperiment != null && nextExperiment.equals(Constant.ON) && experimental){
				skippedApprover = nextApprover;
				skippedSequence = nextSequence;

				if (lastSequence==nextSequence){
					lastSequence = thisSequence;
				}
				else{
					Approver ap = ApproverDB.getApprovers(conn,campus,alpha,num,nextApprover,experimental,route);
					nextApprover = ap.getNextApprover();
					nextDelegate = ap.getNextDelegate();
					nextSequence = Integer.parseInt(ap.getNextSequence());
					nextExperiment = ap.getNextExperiment();
				}
			}

			proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);
			approversThisSequence = ApproverDB.getApproverCount(conn,campus,thisSequence,route);
			approversNextSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);

			if (user.equals(ApproverDB.getDivisionChairApprover(conn,campus,alpha))){
				divisionChair = true;
			}

			if (debug) {
				logger.info("proposer: " + proposer);
				logger.info("approversThisSequence: " + approversThisSequence);
				logger.info("approversNextSequence: " + approversNextSequence);
				logger.info("thisApprover: " + thisApprover);
				logger.info("thisDelegate: " + thisDelegate);
				logger.info("divisionChair: " + divisionChair);
			}

			/*
				if !approved, send back to proposer
				if approved, several options are available

					1) last approver - thisSequence==lastSequence
					2) more than 1 user this sequence and not division chair or
						division chair could not be determined
					3) single approver and more to come
					4) single approver as part of distribution
			*/
			// add to history

			String approvalProgress = "";
			if (approval){
				approvalProgress = Constant.COURSE_APPROVED_TEXT;
			}
			else{
				approvalProgress = Constant.COURSE_REVISE_TEXT;
			}
			if (debug) logger.info("approvalProgress - " + approvalProgress);

			HistoryDB.addHistory(conn,
										alpha,
										num,
										campus,
										user,
										CourseApproval.getNextSequenceNumber(conn),
										approval,
										comments,
										kix,
										thisSequence,
										voteFor,
										voteAgainst,
										voteAbstain,
										proposer,
										Constant.TASK_APPROVER,
										approvalProgress);

			// for experimental outlines, skip over and set to true for approved
			if (!skippedApprover.equals(Constant.BLANK)){
				HistoryDB.addHistory(conn,
											alpha,
											num,
											campus,
											skippedApprover,
											CourseApproval.getNextSequenceNumber(conn),
											true,
											"Skip due to experimental outline",
											kix,
											skippedSequence,
											0,
											0,
											0,
											proposer,
											Constant.TASK_APPROVER,
											approvalProgress);
			}

			AseUtil.logAction(conn, user, "ACTION","Save history ",alpha,num,campus,kix);

			if (debug) logger.info("add history - " + user);

			if (!approval) {
				msg = rejectOutline(conn,kix,approver,user);
				AseUtil.logAction(conn, user, "ACTION","Outline revision requested by "+ user,alpha,num,campus,kix);
			}
			else{

				// clean up for this user
				ParkDB.deleteApproverCommentedItems(conn,kix,user);

				AseUtil.logAction(conn, user, "ACTION","Outline approval by "+ user,alpha,num,campus,kix);

				int totalVotes = voteFor + voteAgainst + voteAbstain;
				if (totalVotes > 0){
					CourseApproval.updateVoting(conn,kix,voteFor,voteAgainst,voteAbstain);
				}
				if (debug) logger.info("totalVotes - " + totalVotes);

				if (thisSequence==lastSequence){
					rowsAffected = CourseApproval.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
					mailer.setSubject("emailApproveOutline");
					mailer.setFrom(thisApprover);
					mailer.setTo(proposer);
					msg = processLastApprover(conn,kix,mailer,user);
					if (msg.getCode()==3 || ("Exception".equals(msg.getMsg()))){
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																user,
																alpha,
																num,
																Constant.MODIFY_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																type,
																Constant.TASK_PROPOSER,
																Constant.TASK_PROPOSER);
						if (debug) logger.info("task recreated for - " + proposer);
					}
					else{
						AseUtil.logAction(conn, user, "ACTION","Outline final approval by "+ user,alpha,num,campus,kix);
						if (debug) logger.info("last person - " + thisApprover);
					}

					rowsAffected = IniDB.updateNote(conn,route,"",user);
					if (debug) logger.info("approval note cleared");

				}
				else{
					if (debug) logger.info("not last person - " + thisApprover);

					if (approversNextSequence > 1 && !distribution){
						rowsAffected = CourseApproval.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
						msg.setCode(nextSequence);
						msg.setMsg("forwardURL");
						msg.setKix(kix);
						forward = true;
						if (debug) logger.info("multiple approvers next sequence = " + approversNextSequence);
					}
					else{
						if (distribution){
							if (debug) logger.info("distribution list");

							continueToNextApproval = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distName,thisSequence);
							if (debug) logger.info("continueToNextApproval - " + continueToNextApproval);

							rowsAffected = CourseApproval.removeApprovalTask(conn,kix,user,thisDelegate);
							if (debug) logger.info("removeApprovalTask - " + rowsAffected);

							comment = " - distribution list sequence - ";
						}
						else {
							continueToNextApproval = true;
							if (approversThisSequence==1)
								comment = " - single user this sequence - task removed - ";
							else
								comment = " - multiple users this sequence - task removed - ";

							if (debug) logger.info("not distribution list");
						}

						// during a distribution approval and there are more to complete, we don't do this
						if (continueToNextApproval){
							if (debug) logger.info("continueToNextApproval");

							// remove existing tasks
							rowsAffected = CourseApproval.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
							if (debug) logger.info("removeApprovalTask - " + rowsAffected);

							// add new tasks
							msg = CourseApproval.addApprovalTask(conn,kix,nextApprover,nextDelegate);
							if (debug) logger.info("addApprovalTask - " + rowsAffected);

							if (nextDelegate.indexOf(nextApprover)>-1){
								nextDelegate = nextDelegate.replace(nextApprover,"");
							}

							//-----------------------------------------------------------
							// include proposer in notifications as an FYI (ER00035)
							//-----------------------------------------------------------
							String includeProposerOnApprovalEmail = IniDB.getIniByCampusCategoryKidKey1(conn,
																														campus,
																														"System",
																														"IncludeProposerOnApprovalEmail");
							if(includeProposerOnApprovalEmail.equals(Constant.ON)){
								if (nextDelegate.equals(Constant.BLANK)){
									nextDelegate = proposer;
								}
								else{
									nextDelegate = nextDelegate + "," + proposer;
								}

								if (debug) {
									logger.info("includeProposerOnApprovalEmail - " + includeProposerOnApprovalEmail);
								}
							} // includeProposerOnApprovalEmail

							//-----------------------------------------------------------
							// send mail
							//-----------------------------------------------------------
							if (!fastTrack){

								String sender = proposer;

								String approverSendsNextApprovalEmail = IniDB.getIniByCampusCategoryKidKey1(conn,
																																campus,
																																"System",
																																"ApproverSendsNextApprovalEmail");
								if (approverSendsNextApprovalEmail.equals(Constant.ON)){
									sender = user;
								}

								mailerDB = new MailerDB(conn,
																sender,
																nextApprover,
																nextDelegate,
																Constant.BLANK,
																alpha,
																num,
																campus,
																"emailOutlineApprovalRequest",
																kix,
																user);
								if (debug){
									logger.info("approval email sent to next approver - " + nextApprover);
									logger.info("approval email sent to next delegate - " + nextDelegate);
								}

							}
						}
						else{
							if (debug) logger.info("not continueToNextApproval");
							thisApprover = user;
							thisDelegate = "";
							nextApprover = "";
							nextDelegate = "";
						}	// continueToNextApproval

					}	// approversNextSequence
				}	// thisSequence==lastSequence
			} // !approval

			if (debug) logger.info(kix + " - " + user + " - approveOutlineX - END");

		} catch (Exception e) {
			msg.setMsg("Exception");
			campus = campus + "/" + alpha + "/" +num + "/" +user;
			logger.fatal(kix + " CourseApproval.approveOutlineX ("+campus+"): " + e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
					if (debug) logger.info("connection released");
				}
			}
			catch(Exception e){
				logger.fatal("CourseApproval: approveOutlineX - " + e.toString());
			}
		}

		return msg;
	} // CourseApproval: approveOutlineX

	/*
	 * rejectOutline
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param approver	Approver
	 *	@param user			String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg rejectOutline(Connection conn,String kix,Approver approver,String user){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = Integer.parseInt(info[6]);

		String bundle = "";
		String mailFrom = "";
		String mailTo = "";
		String mailCC = "";
		String progress = "";
		String message = "";
		String roleTask = "";
		String inviterTask = "";
		int edit = 0;

		Msg msg = new Msg();

		boolean moveOn = true;

		try{

			if (debug) logger.info(approver);

			// who are we dealing with at this time? collect info to have task removed
			String thisApprover = approver.getApprover();
			String thisDelegate = approver.getDelegated();
			int sequence = Integer.parseInt(approver.getSeq());
			if (approver.getDistributionList()){
				thisApprover = ApproverDB.getApproversBySeq(conn,campus,sequence,route);
				thisApprover = DistributionDB.getDistributionMembers(conn,campus,thisApprover);
			}
			rowsAffected = removeApprovalTask(conn,kix,thisApprover,thisDelegate);

			// depending on the system settings for rejection, we may either send back to the proposer
			// or in the case of step back, we send back to the previous approver.
			String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);

			if (debug){
				logger.info("thisApprover: " + thisApprover);
				logger.info("sequence: " + sequence);
				logger.info("whereToStartOnOutlineRejection: " + whereToStartOnOutlineRejection);
			}

			if (	whereToStartOnOutlineRejection.equals(Constant.REJECT_START_WITH_REJECTER) ||
					whereToStartOnOutlineRejection.equals(Constant.REJECT_START_FROM_BEGINNING) ){

				if (debug) logger.info("whereToStartOnOutlineRejection: REJECT_START_WITH_REJECTER");

				bundle = "emailOutlineReject";
				inviterTask = Constant.TASK_PROPOSER;
				roleTask = Constant.TASK_PROPOSER;
				message = Constant.REVISE_TEXT;
				progress = Constant.COURSE_REVISE_TEXT;
				edit = 1;

				mailFrom = approver.getApprover();
				mailTo = proposer;
			}
			else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_STEP_BACK_ONE)){

				if (debug) logger.info("whereToStartOnOutlineRejection: REJECT_STEP_BACK_ONE");

				bundle = "emailApproveOutline";
				roleTask = Constant.TASK_APPROVER;
				inviterTask = Constant.TASK_APPROVER;
				message = Constant.APPROVAL_TEXT;
				progress = Constant.COURSE_APPROVAL_TEXT;
				edit = 0;

				// figure out who to send back to. Step back one is to previous approver as long
				// as there is one. If not, back to proposer.
				mailFrom = approver.getApprover();
				if (--sequence > 0){
					String stepBackApprover = "";

					// if the sequence is 1, check to make sure who should get the message.
					// at sequence 1, it's possible that no one is identify as a div chair. when
					// that happens, they all get the message because there may be too many ones

					// to get the right one and since this is a rejection, check the names that
					// is available against the person who'd already approved as sequence 1.
					if (sequence==1){
						stepBackApprover = HistoryDB.getCompletedApproverBySequence(conn,kix,sequence);
					}
					else{
						stepBackApprover = ApproverDB.getApproversBySeq(conn,campus,sequence,route);
					}

					mailTo = stepBackApprover;
					mailCC = proposer;
				}
				else{
					bundle = "emailOutlineReject";
					roleTask = Constant.TASK_PROPOSER;
					inviterTask = Constant.TASK_PROPOSER;
					message = Constant.REVISE_TEXT;
					progress = Constant.COURSE_REVISE_TEXT;
					edit = 1;
					mailTo = proposer;
				}
			}
			else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_APPROVER_SELECTS)){
				// this condition permits approver to select who to send the outline back to.
				// in this case, we do a forwardURL and stop processing the rest of the routine
				// code 1 tells lstappr that we are going to list the entire route and the proposer
				moveOn = false;
				msg.setCode(1);
				msg.setMsg("forwardURL");
				msg.setKix(kix);
			}
			else {
				// when there are no settings for return upon rejection
				moveOn = true;
				bundle = "emailOutlineReject";
				roleTask = Constant.TASK_PROPOSER;
				inviterTask = Constant.TASK_PROPOSER;
				message = Constant.REVISE_TEXT;
				progress = Constant.COURSE_REVISE_TEXT;
				edit = 1;
				mailFrom = approver.getApprover();
				mailTo = proposer;
			}

			if (debug){
				logger.info("bundle: " + bundle);
				logger.info("roleTask: " + roleTask);
				logger.info("inviterTask: " + inviterTask);
				logger.info("message: " + message);
				logger.info("progress: " + progress);
				logger.info("mailTo: " + mailTo);
			}

			if (moveOn){
				String[] tasks = new String[100];
				tasks = mailTo.split(",");
				for (int i=0; i<tasks.length; i++) {
					rowsAffected = TaskDB.logTask(conn,
															tasks[i],
															mailFrom,
															alpha,
															num,
															message,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															type,
															inviterTask,
															roleTask);
					if (debug) logger.info(kix + " - add task for " + message + ": " + tasks[i] + "; " + rowsAffected + " rows");
				}

				MailerDB mailerDB = new MailerDB(conn,mailFrom,mailTo,mailCC,"",alpha,num,campus,bundle,kix,user);

				// update course data
				String enableOutlineEdit = "UPDATE tblCourse SET edit=?,progress=? WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
				PreparedStatement ps = conn.prepareStatement(enableOutlineEdit);
				ps.setInt(1,edit);
				ps.setString(2,progress);
				ps.setString(3,alpha);
				ps.setString(4,num);
				ps.setString(5,campus);
				ps.setString(6,type);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}	// moveOn

		} catch (SQLException se) {
			logger.fatal(kix + " - rejectOutline - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - rejectOutline - " + e.toString());
		}

		return msg;
	}

	/*
	 * rejectOutlineToProposer	- goes directly to the propser
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param approver	Approver
	 *	<p>
	 *	@return Msg
	 */
	public static Msg rejectOutlineToProposer(Connection conn,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = Integer.parseInt(info[6]);

		String bundle = "";
		String mailFrom = "";
		String mailTo = "";
		String mailCC = "";
		String progress = "";
		String message = "";
		String roleTask = "";
		String inviterTask = "";
		int edit = 0;

		Msg msg = new Msg();

		boolean moveOn = true;

		try{
			bundle = "emailOutlineReject";
			inviterTask = Constant.TASK_PROPOSER;
			roleTask = Constant.TASK_PROPOSER;
			message = "Modify outline";
			progress = "MODIFY";
			edit = 1;

			mailFrom = user;
			mailTo = proposer;

			rowsAffected = TaskDB.logTask(conn,mailTo,mailFrom,alpha,num,message,campus,"","ADD",type,inviterTask,roleTask);
			if (debug) logger.info(kix + " - add task for " + message + ": " + mailTo + " - " + rowsAffected + " rows");

			MailerDB mailerDB = new MailerDB(conn,mailFrom,mailTo,"","",alpha,num,campus,bundle,kix,user);

			// update course data
			String enableOutlineEdit = "UPDATE tblCourse SET edit=?,progress=? WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(enableOutlineEdit);
			ps.setInt(1,edit);
			ps.setString(2,progress);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,campus);
			ps.setString(6,type);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException se) {
			logger.fatal(kix + " - rejectOutlineToProposer - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - rejectOutlineToProposer - " + e.toString());
		}

		return msg;
	}

	/*
	 * cleanUp
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param user			String
	 * @param sequence	int
	 *	<p>
	 *	@return int
	 */
	public static int cleanUp(Connection conn,String kix,String user,int sequence) throws Exception {


		//Logger logger = Logger.getLogger("test");

		String[] tasks = new String[20];
		int xyz = 0;
		int z = 0;
		int rowsAffected = 0;

		String delegated = "";
		String temp = "";

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = Integer.parseInt(info[6]);

		try{

			String lastApprovers = ApproverDB.getApproversBySeq(conn,campus,sequence,route);

			if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - lastApprovers - " + lastApprovers);

			// if previous was a distribution list, need to process all members of list.
			if (lastApprovers.indexOf('[')==0){
				lastApprovers = DistributionDB.removeBracketsFromList(lastApprovers);
				lastApprovers = DistributionDB.getDistributionMembers(conn,campus,lastApprovers);

				if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - lastApprovers - " + lastApprovers);

				tasks = lastApprovers.split(",");
				for (z=0;z<tasks.length;z++){
					rowsAffected = TaskDB.logTask(conn,tasks[z],tasks[z],alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
					if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + tasks[z]);
				}
			}
			else{
				lastApprovers = user;
				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
				if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + user);
			}

			// remove/add tasks depending on approver or delegate; either way, must remove
			// approver or delegate
			delegated = ApproverDB.getDelegateByApproverName(conn,campus,user,route);
			if (!"".equals(delegated)){
				rowsAffected = TaskDB.logTask(conn,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
				if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + delegated);
			}
			else{
				delegated = ApproverDB.getApproverByDelegateName(conn,campus,user,route);
				if (!"".equals(delegated)){
					rowsAffected = TaskDB.logTask(conn,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
					if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + delegated);
				}
			}

			if (!"".equals(delegated))
				lastApprovers = lastApprovers + "," + delegated;

			if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - lastApprovers - " + lastApprovers);

			// remove approvers of same sequence after list of users were presented for selection.
			// this happens because CC does not know who to send to. The approver is removed above.
			// the person not selected is removed here.
			// this should only be done as long as the user sequence is not a division chair
			User usr = UserDB.getUserByName(conn,user);
			temp = usr.getPosition().toLowerCase();
			if (temp.indexOf("division")<0)
				removeApproverFromSequence(conn,campus,alpha,num,user,sequence);

		} catch (Exception e) {
			logger.fatal(kix + " -  " + user + " -  cleanUp - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * processLastApprover
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param user			String
	 * @param sequence	int
	 * @param user			String
	 *	<p>
	 *	@return int
	 */
	public static Msg processLastApprover(Connection conn,String kix,Mailer mailer,String user){

		//Logger logger = Logger.getLogger("test");
		//int LAST_APPROVER 	= 2;
		//int ERROR_CODE 		= 3;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		String progress = info[Constant.KIX_PROGRESS];
		int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

		String sql = "";
		int xyz = 0;
		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;

		String taskText = "";

		try{

			if (progress.toLowerCase().indexOf("delete") > -1){
				taskText = Constant.DELETED_TEXT;
			}
			else{
				taskText = Constant.APPROVED_TEXT;
			}

			if (debug) logger.info("processLastApprover - taskText: " + taskText);

			/*
				1) approve the outline by moving to ARC, setting to CUR
				2) if all goes well, send notification, remove task
				3) if not, remove last history entry and have it done again
			*/
			msg = finalizeOutline(campus,alpha,num,proposer);

			// clean up
			ParkDB.deleteApproverCommentedItems(conn,kix);
			MiscDB.deleteStickyMisc(conn,kix);

			if (msg.getCode()==ERROR_CODE){
				sql = "DELETE FROM tblApprovalHist "
					+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND approver=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, mailer.getFrom());
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("processLastApprover - finalizeOutline failed");
				msg.setMsg("Exception");
			}
			else{
				msg.setCode(LAST_APPROVER);

				MailerDB mailerDB = new MailerDB(conn,mailer.getFrom(),proposer,"","",alpha,num,campus,"emailApproveOutline",kix,user);
				if (debug) logger.info("processLastApprover - send mail emailApproveOutline");

				// notify and add task for registrar
				DistributionDB.notifyDistribution(conn,campus,alpha,num,"",mailer.getFrom(),"","","emailNotifiedWhenApproved","NotifiedWhenApproved",user);
				if (debug) logger.info("processLastApprover - send mail emailNotifiedWhenApproved");

				// notify approvers when outline approved (requested by MAN).
				String notifyApproversWhenApproved = IniDB.getIniByCampusCategoryKidKey1(conn,
																	campus,
																	"System",
																	"NotifyApproversWhenApproved");
				if (notifyApproversWhenApproved.equals(Constant.ON)){

					String allApprovers = ApproverDB.getApproversByRoute(conn,campus,route);
					if (allApprovers != null){
						mailerDB = new MailerDB(conn,mailer.getFrom(),
														allApprovers,"","",
														alpha,num,campus,"emailApprovedOutlineToApprovers",kix,user);

						AseUtil.logAction(conn, user, "ACTION","Outline notifications sent to "
																+ allApprovers.replace(",",", ")
																+ " ("+ alpha + " " + num + ")",alpha,num,campus,kix);
					}

				}

				// createTaskForApprovedOutline
				String createTaskForApprovedOutline = IniDB.getIniByCampusCategoryKidKey1(conn,
																	campus,
																	"System",
																	"createTaskForApprovedOutline");
				if (createTaskForApprovedOutline.equals(Constant.ON)){
					String distributionMembers = DistributionDB.getDistributionMembers(conn,campus,"NotifiedWhenApproved");
					if (distributionMembers != null && distributionMembers.length() > 0){
						String[] tasks = new String[20];
						tasks = distributionMembers.split(",");
						for (int z=0;z<tasks.length;z++){
							rowsAffected = TaskDB.logTask(conn,tasks[z],proposer,alpha,num,taskText,campus,"","ADD","CUR");
							if (debug) logger.info("processLastApprover - create task emailNotifiedWhenApproved - " + tasks[z]);
							AseUtil.logAction(conn,proposer,"ADD","Outline approved task ("+ tasks[z] + ")",alpha,num,campus,kix);
						} // for
					} // if distributionMembers
				} // if createTaskForApprovedOutline

				// tell CC that this outline is available for viewing under report. this saves
				// time from having to locate the kix everytime attempting to review report
				if (taskText.equals(Constant.DELETED_TEXT)){
					sql = "UPDATE tblCampusOutlines SET " + campus + " = null WHERE coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kix + " - " + user + " - CourseDelete - delete HTML - " + rowsAffected + " row");
				}
				else{
					CampusDB.removeCampusOutline(conn,campus,alpha,num,"PRE");
					CampusDB.updateCampusOutline(conn,kix,campus);
					if (debug) logger.info(kix + " CourseApproval - campus outline updated");
				}

			}  // if msg.getCode()==ERROR_CODE
		} catch (SQLException se) {
			logger.fatal(kix + " -  processLastApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " -  processLastApprover - " + e.toString());
		}

		return msg;

	}

	/*
	 * setCourseForApproval
	 *	<p>
	 * sends approval notice. called when list of approvers is presented to user for selection.
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	approver		String
	 * @param	seq			String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg setCourseForApproval(Connection conn,
														String campus,
														String alpha,
														String num,
														String approver,
														int seq,
														String user) throws Exception {

		Msg msg = new Msg();

		String[] tasks = new String[20];
		User udb = new User();
		int rowsAffected = 0;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		String domain = "@" + bundle.getString("domain");
		String toNames = "";
		String sender = "";
		String temp = "";
		String type = "PRE";
		String kix = "";
		String proposer = "";

		if (debug) logger.info(approver + " - setCourseForApproval - START");

		try{
			if (!"".equals(approver)){
				kix = Helper.getKix(conn,campus,alpha,num,type);
				proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);

				tasks = approver.split(",");
				for (int z=0;z<tasks.length;z++){
					rowsAffected = TaskDB.logTask(conn,
															tasks[z],
															tasks[z],
															alpha,
															num,
															Constant.APPROVAL_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															type);
					if (debug) logger.info(approver + " - approveOutlineX - delete approver task - rowsAffected " + rowsAffected);

					rowsAffected = TaskDB.logTask(conn,
															tasks[z],
															proposer,
															alpha,
															num,
															Constant.APPROVAL_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															type,
															proposer,
															Constant.TASK_APPROVER);
					if (debug) logger.info("CourseDB - setCourseForApproval - approval task created - rowsAffected " + rowsAffected);

					if (toNames.length()==0)
						toNames = tasks[z];
					else
						toNames = toNames + "," + tasks[z];
				} // for

				// TrackItemChanges
				if (seq==1){
					Outlines.trackItemChanges(conn,campus,kix,user);
				} // seq = 1 and it is for TrackItemChanges

				sender = proposer + domain;
				MailerDB mailerDB = new MailerDB(conn,
															sender,
															toNames,
															proposer,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalRequest",
															kix);
				if (debug) logger.info("CourseDB - setCourseForApproval - mail sent - " + approver);
			}
		} catch (SQLException se) {
			msg.setMsg("Exception");
			logger.fatal(approver + " -  setCourseForApproval - " + se.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal(approver + " -  setCourseForApproval - " + e.toString());
		}

		if (debug) logger.info(approver + " - " + kix + " -  setCourseForApproval - END");

		return msg;
	}

	/*
	 * removeApproverFromSequence
	 *	<p>
	 * sends approval notice. called when list of approvers is presented to user for selection.
	 *	<p>
	 *	@param	connection		Connection
	 * @param	campus			String
	 * @param	alpha				String
	 * @param	num				String
	 * @param	user				String
	 * @param	seq				int
	 *	<p>
	 *	@return int
	 */
	public static int removeApproverFromSequence(Connection conn,
																String campus,
																String alpha,
																String num,
																String user,
																int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// when presented with a list of names to select from, the ones selected will get message to
		// approve. The one not selected should be removed from approval sequence.
		//
		// 1) get list of approvers for this sequence into approvers
		// 2) in the for look, remove names of selected folks from variable approvers
		// 3) after for look, cycle through list of remaining approvers and remove them from approval seq

		String[] tasks = new String[20];
		int rowsAffected = 0;
		String temp = "";
		String type = "PRE";
		String approvers = "";
		String kix = "";
		int z = 0;
		int xyz = 0;

		try{
			String[] info = Helper.getKixRoute(conn,campus,alpha,num,type);
			kix = info[0];
			int route = Integer.parseInt(info[1]);

			if (debug) logger.info(kix + " - " + (++xyz) + ". CourseApproval - removeApproverFromSequence - user - " + user);

			// 1) get list of approvers for this sequence into approvers
			approvers = ApproverDB.getApproversBySeq(conn,campus,seq,route);
			if (debug) logger.info(kix + " - " + (++xyz) + ". CourseApproval - removeApproverFromSequence - " + approvers);

			if (approvers.indexOf('[')==0){
				approvers = DistributionDB.removeBracketsFromList(approvers);
				approvers = DistributionDB.getDistributionMembers(conn,campus,approvers);
			}

			if (debug) logger.info(kix + " - " + (++xyz) + ". CourseApproval - removeApproverFromSequence - approvers - " + approvers);

			// 2) remove people already approved
			approvers = approvers.replace(user,"");
			approvers = approvers.replace(",,",",");

			// remove first comma
			if (approvers.indexOf(",")==0)
				approvers = approvers.substring(1,approvers.length());

			if (debug) logger.info(kix + " - " + (++xyz) + ". CourseApproval - removeApproverFromSequence - approvers - " + approvers);

			// 3) afer for loop, cycle through list of remaining and add them to history
			tasks = approvers.split(",");
			for (z=0;z<tasks.length;z++){
				if (!"".equals(tasks[z])){
					HistoryDB.addHistory(conn,alpha,num,campus,
												tasks[z],getNextSequenceNumber(conn),
												true,"Approval not required",kix,seq);
					if (debug) logger.info(kix + " - " + (++xyz) + ". CourseApproval - removeApproverFromSequence - history - " + tasks[z]);
				} // if
			} // for
		} catch (SQLException se) {
			logger.fatal(kix + " -  removeApproverFromSequence - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " -  removeApproverFromSequence - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * finalizeOutline
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 *	<p>
	 *	@return int
	 */
	public static Msg finalizeOutline(String campus,String alpha,String num,String user) throws Exception {

		//int LAST_APPROVER 	= 2;
		//int ERROR_CODE 		= 3;
		//Logger logger = Logger.getLogger("test");

		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int i = 0;

		Msg msg = new Msg();
		PreparedStatement ps;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

      Connection conn = null;

		String thisSQL = null;
		String kixPRE = null;
		String progress = null;
		String kixCUR = null;
		String reviewDate = null;

		String currentDate = AseUtil.getCurrentDateTimeString();
		String kixARC = SQLUtil.createHistoryID(1);

		/*
			 to make a proposed course to current, do the following
			 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			 2) make a copy of the CUR course in temp table (insertToTemp)
			 3) update key fields and prep for archive (updateTemp)
			 4) put the temp record in courseARC table for use (insertToCourseARC)
			 5) delete the current course from tblCourse
			 6) change the PRE course in current course to CUR
			 7) clean up the temp table (deleteFromTemp)
			 8) move current approval history to log table
			 9) clear current approval history
		*/
		sql = Constant.MAIN_TABLES.split(",");
		tempSQL = Constant.TEMP_TABLES.split(",");
		totalTables = sql.length;

		sqlManual = Constant.MANUAL_TABLES.split(",");
		tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
		totalTablesManual = sqlManual.length;

		String[] select = Outlines.getTempTableSelects();

		try {
			conn = AsePool.createLongConnection();

			kixPRE = Helper.getKix(conn,campus,alpha,num,"PRE");
			kixCUR = Helper.getKix(conn,campus,alpha,num,"CUR");
			progress = CourseDB.getCourseProgress(conn,campus,alpha,num,"PRE");
			reviewDate = DateUtility.calculateReviewDate(conn,campus,num,TermsDB.getOutlineTerm(conn,kixPRE));

			//
			// delete from temp tables PRE or CUR ids and start clean
			//
			Outlines.deleteTempOutline(conn,kixPRE);

			if (debug) {
				logger.info(" kixPRE " + kixPRE);
				logger.info(" kixCUR " + kixCUR);
				logger.info(" progress " + progress);
				logger.info(" reviewDate " + reviewDate);
				logger.info(" deleteTempOutline");
			}

			//
			//	insert from production into temp table (CUR to become ARC)
			//  kixCUR is empty because an outline is not available
			//
			if (!kixCUR.equals(Constant.BLANK)){
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					if (sql[i].indexOf("attach") == -1){
						thisSQL = "INSERT INTO "
								+ tempSQL[i]
								+ " SELECT * FROM "
								+ sql[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixCUR);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
					}
					if (debug) logger.info(" INSERT2A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					if (sqlManual[i].indexOf("attach") == -1){
						thisSQL = "INSERT INTO "
								+ tempSQLManual[i]
								+ " SELECT " + select[i] + " FROM "
								+ sqlManual[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixCUR);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
					}
					if (debug) logger.info(" INSERT2B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				//
				//	update temp data prior to inserting into archived tables (kixCUR is now kixARC)
				//

				thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=?,historyid=?,id=? "
					+ "WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,user);
				ps.setString(2,currentDate);
				ps.setString(3,kixARC);
				ps.setString(4,kixARC);
				ps.setString(5,kixCUR);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info(" UPDATE " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");

				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQL[i]
							+ " SET coursetype='ARC',auditdate=?,historyid=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1, currentDate);
					ps.setString(2, kixARC);
					ps.setString(3, kixCUR);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(" UPDATE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQLManual[i]
							+ " SET coursetype='ARC',auditdate=?,historyid=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1, currentDate);
					ps.setString(2, kixARC);
					ps.setString(3, kixCUR);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(" UPDATE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				//
				// insert data from temp into archived tables
				//
				sql[0] = "tblCourseARC";
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sql[i]
							+ " SELECT * FROM "
							+ tempSQL[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixARC);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixARC + " -  INSERT-ARC-A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
				sql[0] = "tblCourse";

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sqlManual[i]
							+ " SELECT " + select[i] + " FROM "
							+ tempSQLManual[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixARC);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixARC + " -  INSERT-ARC-B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				//
				// delete the current table data before updating from PRE to CUR
				//
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sql[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixCUR);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(" DELETE-CUR-A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sqlManual[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixCUR);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(" DELETE-CUR-B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
			} // blank kixCUR


			//
			// set the modified data to current
			// when approving an outline being modified, the progress is MODIFY
			// when approving an outline for deletion, the progress is DELETE
			// for modification, data currently in PRE status goes to CUR
			// for deletion, delete both CUR and PRE
			//
			if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
				thisSQL = "UPDATE tblCourse " +
					"SET coursetype='CUR',route=0,progress='APPROVED',edit1='',edit2='',coursedate=?,auditdate=?,proposer=?,reviewdate=? " +
					"WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,currentDate);
				ps.setString(2,currentDate);
				ps.setString(3,user);
				ps.setString(4,reviewDate);
				ps.setString(5,kixPRE);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info(kixPRE + " -  UPDATE-PRE - " + rowsAffected + " rows");

				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ sql[i]
							+ " SET coursetype='CUR',auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,currentDate);
					ps.setString(2,kixPRE);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixPRE + " -  UPDATE-PRE-A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ sqlManual[i]
							+ " SET coursetype='CUR',auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,currentDate);
					ps.setString(2,kixPRE);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixPRE + " -  UPDATE-PRE-B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
			}
			else{
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sql[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixPRE);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixPRE + " -  DELETE-PRE-A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM " + sqlManual[i] + " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixPRE);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixPRE + " -  DELETE-PRE-B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
			}

			//
			// text
			//
			thisSQL = "update tbltext set historyid=? where historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixARC);
			ps.setString(2,kixCUR);
			rowsAffected = ps.executeUpdate();
			ps.close();
			if (debug) logger.info(kixPRE + " -  UPDATE-text - " + rowsAffected + " rows");

			//
			//	clean up temp tables
			//
			Outlines.deleteTempOutline(conn,kixARC);
			Outlines.deleteTempOutline(conn,kixPRE);

			// when approved of existing outline, the CUR version goes to ARC with a new KIX
			// we update the approval history of the CUR version to match the KIX created for ARC
			thisSQL = "UPDATE tblApprovalHist2 SET historyid=? WHERE campus=? AND historyid=? AND CourseAlpha=? AND CourseNum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, kixARC);
			ps.setString(2, campus);
			ps.setString(3, kixCUR);
			ps.setString(4, alpha);
			ps.setString(5, num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  UPDATE HISTORY - " + rowsAffected + " rows");

			// update history table
			thisSQL = "INSERT INTO tblApprovalHist2 (id,historyid,approvaldate,coursealpha,coursenum,"
					+ "dte,campus,seq,approver,approved,comments,approver_seq,votesFor,votesAgainst,votesAbstain,inviter,role,progress) "
					+ "SELECT tba.id,'"+kixPRE+"', '"
					+ currentDate
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments, tba.approver_seq, "
					+ "tba.votesFor,tba.votesAgainst,tba.votesAbstain,tba.inviter,tba.role,tba.progress "
					+ "FROM tblApprovalHist tba "
					+ "WHERE campus=? AND "
					+ "CourseAlpha=? AND "
					+ "CourseNum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  UPDATE HISTORY - " + rowsAffected + " rows");

			thisSQL = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  DELETE HISTORY - " + rowsAffected + " rows");

			// when approved of existing outline, the CUR version goes to ARC with a new KIX
			// we update the approval history of the CUR version to match the KIX created for ARC
			thisSQL = "UPDATE tblReviewHist2 SET historyid=? WHERE campus=? AND historyid=? AND CourseAlpha=? AND CourseNum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, kixARC);
			ps.setString(2, campus);
			ps.setString(3, kixCUR);
			ps.setString(4, alpha);
			ps.setString(5, num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  UPDATE HISTORY - " + rowsAffected + " rows");

			// update review history
			thisSQL = "INSERT INTO tblReviewHist2 "
					+ "(id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled) "
					+ "SELECT id, '"+kixPRE+"', campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled "
					+ "FROM tblReviewHist "
					+ "WHERE campus=? AND "
					+ "CourseAlpha=? AND "
					+ "CourseNum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  UPDATE COMMENTS - " + rowsAffected + " rows");

			thisSQL = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  DELETE COMMENTS - " + rowsAffected + " rows");

			// if an outline was in PRE status during SLO work, make sure the SLO coursetype follows the
			// outline to CUR
			thisSQL = "UPDATE tblSLO SET coursetype='CUR',auditby=?,auditdate=? WHERE hid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,user);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.close();
			if (debug) logger.info(kixPRE + " -  SLO - " + rowsAffected + " rows");

			// WE ONLY DO THIS IF A MOVE TO ARC HAPPENS
			// when approved of existing outline, the CUR version goes to ARC with a new KIX
			// we update the approval history of the CUR version to match the KIX created for ARC
			thisSQL = "UPDATE forums SET historyid=? WHERE campus=? AND historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, kixARC);
			ps.setString(2, campus);
			ps.setString(3, kixCUR);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info(kixPRE + " -  update forum - " + rowsAffected + " rows");

			// delete the miscallaneous item
			rowsAffected = MiscDB.deleteMisc(conn,kixPRE);
			if (debug) logger.info(kixPRE + " -  deleting misc - " + rowsAffected + " rows");

			// close the forum
			rowsAffected = ForumDB.closeForum(conn,campus,user,kixPRE);
			if (debug) logger.info(kixPRE + " -  Forum closed - " + rowsAffected + " rows");

			// for approvals, we must remove anything existing and create new
			Tables.deleteOutline(conn,campus,kixARC);
			Tables.createOutlines(campus,kixARC,alpha,num);

			Tables.deleteOutline(conn,campus,kixCUR);
			Tables.createOutlines(campus,kixCUR,alpha,num);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " -  ("+sql[i]+"/"+sqlManual[i]+") \n " + ex.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);
			msg.setErrorLog("Exception");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(user + " -  ("+sql[i]+"/"+sqlManual[i]+")  \n " + e.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);
		}

		return msg;
	}

	/*
	 * logIt
	 * <p>
	 * @param	kix				String
	 * @param	message			String
	 * @param	counter			int
	 * @param	tableCounter	int
	 * @param	rowsAffected	int
	 * @param	sql				String
	 */
	public static void logIt(	String kix,
										String message,
										int counter,
										int tableCounter,
										int rowsAffected,
										String sql,
										boolean logIt) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean logging = true;

		String log = "";

		if (logIt)
			log = kix + message + (counter+1) + " of " + tableCounter + " - " + rowsAffected + " rows";
		else
			log = sql;

		if (logging)
			if (debug) logger.info(log);
		else
			System.out.println(log);
	}

	/*
	 * getNextCompID
	 *	<p>
	 *	@return int
	 */
	public static int getNextSequenceNumber(Connection connection) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(seq) + 1 AS maxid FROM tblApprovalHist";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseApproval: getNextCompID - " + e.toString());
		}

		return id;
	}

	/*
	 * updateVoting
	 *	<p>
	 *	@param	conn			Connection
	 * @param	kix			String
	 * @param	voteFor		int
	 * @param	voteAgainst	int
	 * @param	voteAbstain	int
	 *	<p>
	 *	@return int
	 */
	public static int updateVoting(Connection conn,String kix,int voteFor,int voteAgainst,int voteAbstain) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse "
				+ "SET votesfor=?,votesagainst=?,votesabstain=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,voteFor);
			ps.setInt(2,voteAgainst);
			ps.setInt(3,voteAbstain);
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseApproval: updateVoting - " + e.toString());
		}

		return rowsAffected;
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

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int z = 0;

		String[] tasks = new String[20];
		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		String progress = info[Constant.KIX_PROGRESS];
		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

		boolean debug = false;
		boolean delete = false;

		String taskText = "";

		try{

			debug = DebugDB.getDebug(conn,"CourseApproval");

			if (progress.toLowerCase().indexOf("delete") > -1){
				taskText = Constant.DELETE_TEXT;
				delete = true;
			}
			else{
				taskText = Constant.APPROVAL_TEXT;
			}

			if (debug) logger.info(kix + " - removeApprovalTask: taskText " + taskText);

			String taskRemove = thisApprover;

			if (thisDelegate == null || thisDelegate.length() == 0)
				thisDelegate = ApproverDB.getDelegateByApproverName(conn,campus,thisApprover,route);

			if (!thisDelegate.equals(Constant.BLANK) && thisApprover.indexOf(thisDelegate)<0)
				taskRemove = taskRemove + "," + thisDelegate;

			tasks = taskRemove.split(",");
			for (z=0;z<tasks.length;z++){

			 	rowsAffected += TaskDB.logTask(conn,
														tasks[z],
														tasks[z],
														alpha,
														num,
														taskText,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														type,
														Constant.BLANK,
														Constant.BLANK,
														Constant.BLANK,
														Constant.BLANK,
														Constant.BLANK);

				if (debug) logger.info(kix + " - removeApprovalTask: Removing approval task for " + tasks[z] + " (" + alpha + " " + num + ")");

				if(delete){
					rowsAffected += TaskDB.logTask(conn,
															tasks[z],
															tasks[z],
															alpha,
															num,
															Constant.DELETE_TEXT_EXISTING,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															type,
															Constant.BLANK,
															Constant.BLANK,
															Constant.BLANK,
															Constant.BLANK,
															Constant.BLANK);
				}

			}

		}catch(Exception e){
			logger.fatal(kix + " -  removeApprovalTask - " + e.toString());
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

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		String progress = info[Constant.KIX_PROGRESS];

		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

		String toNames = "";
		String[] tasks = new String[20];
		Msg msg = new Msg();

		String taskText = "";

		try{
			if (progress.toLowerCase().indexOf("delete") > -1){
				taskText = Constant.DELETE_TEXT;
			}
			else{
				taskText = Constant.APPROVAL_TEXT;
			}

			// is this a distribution?
			if (nextApprover.indexOf("[") > -1 &&	nextApprover.indexOf("[") > -1){
				nextApprover = DistributionDB.getDistributionMembers(conn,campus,nextApprover);
			}

			if (nextDelegate == null || nextDelegate.length() == 0){
				nextDelegate = ApproverDB.getDelegateByApproverName(conn,campus,nextApprover,route);

				// is this a distribution?
				if (nextDelegate.indexOf("[") > -1 &&	nextDelegate.indexOf("[") > -1){
					nextDelegate = DistributionDB.getDistributionMembers(conn,campus,nextDelegate);
				}
			}

			String taskAdd = nextApprover;
			if (!nextDelegate.equals(Constant.BLANK) && nextApprover.indexOf(nextDelegate)<0){
				taskAdd = taskAdd + "," + nextDelegate;
			}

			tasks = taskAdd.split(",");
			for (z=0;z<tasks.length;z++){
				rowsAffected = TaskDB.logTask(conn,
														tasks[z],
														tasks[z],
														alpha,
														num,
														taskText,
														campus,
														Constant.PRE,
														Constant.TASK_ADD,
														type,
														proposer,
														Constant.TASK_APPROVER);

				if (debug) logger.info(kix + " -  addApprovalTask - adding approval task for " + tasks[z] + " (" + alpha + " " + num + ")");

				if (toNames.length()==0)
					toNames = tasks[z];
				else
					toNames = toNames + "," + tasks[z];
			}

			// return names for use to show who is next
			msg.setErrorLog(toNames);

		}catch(Exception e){
			logger.fatal(kix + " -  addApprovalTask - " + e.toString());
		}

		return msg;

	}

	/*
	 * close
	 */
	public void close() throws SQLException {}
}