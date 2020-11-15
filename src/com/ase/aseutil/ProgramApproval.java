/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static Msg addApprovalTask(Connection conn,String kix,String nextApprover,String nextDelegate){
 *	public static int rejectProgram(Connection conn,String kix,Approver approver){
 *	public static int removeApprovalTask(Connection conn,String kix,String thisApprover,String thisDelegate){
 * public static int updateVoting(Connection conn,String kix,int voteFor,int voteAgainst,int voteAbstain) throws SQLException {
 *
 * void close () throws SQLException{}
 *
 */

//
// ProgramApproval.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class ProgramApproval {

	static Logger logger = Logger.getLogger(ProgramApproval.class.getName());

	public ProgramApproval() throws Exception{}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;
	final static int EXCEPTION_CODE 	= -1;

	/*
	 * approveProgram
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
	public static Msg approveProgram(Connection conn,
												String campus,
												String kix,
												String user,
												boolean approval,
												String comments,
												int voteFor,
												int voteAgainst,
												int voteAbstain) throws Exception {

		//Logger logger = Logger.getLogger("test");

		/*
		 * in case user presses refresh, we want to prevent multiple executions.
		 * Only run when there is an outline is in approval status.
		 *
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * if there is an outline, is this the next approver
		 */

		Msg msg = new Msg();

		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

		if (debug) logger.info("-------------------------------------");
		if (debug) logger.info(kix + " - " + user + " - APPROVEPROGRAM - STARTS");

		try{
			String progress = ProgramsDB.getProgramProgress(conn,campus,kix);

			if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) || progress.equals(Constant.PROGRAM_DELETE_PROGRESS)) {
				if (ProgramsDB.isNextApprover(conn,campus,kix,user)) {
					if (debug) logger.info("starting approveprogramx.");
					msg = approveProgramX(conn,campus,kix,user,approval,comments,voteFor,voteAgainst,voteAbstain);
				} else {
					msg.setMsg("NotYourTurnToApprove");
					if (debug) logger.info("Attempting to approve out of sequence.");
				}
			} else {
				msg.setMsg("NoProgramToApprove");
				if (debug) logger.info("Attempting to approve program that is not editable.");
			}
		}
		catch(Exception e){
			msg.setMsg("Exception");
			logger.fatal("ProgramApproval: approveProgram - " + e.toString());
		}

		if (debug) logger.info(kix + " - " + user + " - APPROVEPROGRAM - ENDS");

		return msg;
	}

	public static Msg approveProgramX(Connection conn,
												String campus,
												String kix,
												String user,
												boolean approval,
												String comments,
												int voteFor,
												int voteAgainst,
												int voteAbstain) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean fastTrack = false;

		if (comments.equals(Constant.FAST_TRACK_TEXT)){
			fastTrack = true;
		}

		int xyz = -1;
		int z = 0;

		Msg msg = new Msg();

		String type = "PRE";
		String pageBreak = "<br/>";

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
		boolean continueApproval = false;

		MailerDB mailerDB;
		Mailer mailer = new Mailer();

		//int ERROR_CODE = 3;
		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

		String alpha = "";
		String num = "";
		int route = 0;

		try {

			Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
			if ( program != null ){
				alpha = program.getTitle();
				num = program.getDivisionDescr();
				route = program.getRoute();
				proposer = program.getProposer();
			}

			approver = ApproverDB.getApprovers(conn,kix,user,false,route);
			lastSequence = ApproverDB.maxApproverSeqID(conn,campus,route);
			distribution = approver.getDistributionList();
			distName = approver.getDistributionName();
			thisDelegate = approver.getDelegated();
			thisSequence = Integer.parseInt(approver.getSeq());

			if (debug){
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("user: " + user);
				logger.info("route: " + route);
				logger.info("lastSequence: " + lastSequence);
				logger.info("proposer: " + proposer);
				logger.info("approver:\n" + approver);
				logger.info("distribution: " + distribution);
				logger.info("distName: " + distName);
				logger.info("thisDelegate: " + thisDelegate);
				logger.info("thisSequence: " + thisSequence);
			}

			if (distribution){
				thisApprover = ApproverDB.getApproversBySeq(conn,campus,thisSequence,route);
				thisApprover = DistributionDB.getDistributionMembers(conn,campus,thisApprover);
				if (debug) logger.info("Distribution approval");
			}
			else{
				thisApprover = user;
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

			approversThisSequence = ApproverDB.getApproverCount(conn,campus,thisSequence,route);
			approversNextSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);

			if (debug){
				logger.info("thisApprover: " + thisApprover);
				logger.info("approversThisSequence: " + approversThisSequence);
				logger.info("nextApprover: " + nextApprover);
				logger.info("nextDelegate: " + nextDelegate);
				logger.info("nextSequence: " + nextSequence);
				logger.info("approversNextSequence: " + approversNextSequence);
			}

			if (user.equals(ApproverDB.getDivisionChairApprover(conn,campus,alpha,num))){
				divisionChair = true;
			}

			//
			//	if !approved, send back to proposer
			//	if approved, several options are available
			//
			//		1) last approver - thisSequence==lastSequence
			//		2) more than 1 user this sequence and not division chair or
			//			division chair could not be determined
			//		3) single approver and more to come
			//		4) single approver as part of distribution
			//
			// add to history

			String approvalProgress = "";
			if (approval){
				approvalProgress = Constant.PROGRAM_APPROVAL_PROGRESS;
			}
			else{
				approvalProgress = Constant.PROGRAM_REVISE_PROGRESS;
			}

			HistoryDB.addHistory(conn,
										alpha,
										num,
										campus,
										user,
										HistoryDB.getNextSequenceNumber(conn),
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

			AseUtil.logAction(conn, user, "ACTION","Save history ",alpha,num,campus,kix);

			if (debug) logger.info("add history - " + user);

			if (!approval) {
				msg = ProgramApproval.rejectProgram(conn,kix,approver,user);
				AseUtil.logAction(conn, user, "ACTION","Program revision requested by "+ user,alpha,num,campus,kix);
			}
			else{
				AseUtil.logAction(conn, user, "ACTION","Program approval by "+ user,alpha,num,campus,kix);

				// voting buttons available at division chair only
				int totalVotes = voteFor + voteAgainst + voteAbstain;
				if (totalVotes > 0)
					ProgramApproval.updateVoting(conn,kix,voteFor,voteAgainst,voteAbstain);

				if (debug) logger.info("processed voting logic");

				if (thisSequence==lastSequence){
					rowsAffected = TaskDB.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
					mailer.setSubject("emailApproveProgram");
					mailer.setFrom(thisApprover);
					mailer.setTo(proposer);
					msg = ProgramApproval.processLastApprover(conn,kix,mailer,user);
					if (msg.getCode()==ERROR_CODE || ("Exception".equals(msg.getMsg()))){
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																user,
																alpha,
																num,
																Constant.MODIFY_TEXT,
																campus,
																"",
																"ADD",
																type,
																Constant.TASK_PROPOSER,
																Constant.TASK_PROPOSER,
																kix,
																Constant.PROGRAM);
						if (debug) logger.info("task recreated for - " + proposer);
					}
					else{
						AseUtil.logAction(conn, user, "ACTION","Program final approval by "+ user,alpha,num,campus,kix);
						if (debug) logger.info("last person - " + thisApprover);
					}

					rowsAffected = IniDB.updateNote(conn,route,"",user);
					if (debug) logger.info("approval note cleared");
				}
				else{
					if (debug) logger.info("not last person - " + thisApprover);

					if (approversNextSequence > 1 && !distribution){
						rowsAffected = TaskDB.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
						msg.setCode(nextSequence);
						msg.setMsg("forwardURL");
						msg.setKix(kix);
						forward = true;
						if (debug) logger.info("multiple approvers next sequence = " + approversNextSequence);
					}
					else{
						if (distribution){
							continueApproval = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distName,thisSequence);
							rowsAffected = TaskDB.removeApprovalTask(conn,kix,user,thisDelegate);
							comment = " - distribution list sequence - ";
							if (debug) logger.info("distribution list");
						}
						else {
							continueApproval = true;
							if (approversThisSequence==1){
								comment = " - single user this sequence - task removed - ";
							}
							else{
								comment = " - multiple users this sequence - task removed - ";
							}

							if (debug) logger.info("not distribution list");
						}

						// during a distribution approval and there are more to complete, we don't do this
						if (continueApproval){
							if (debug) logger.info("continueApproval");

							// remove existing tasks
							rowsAffected = TaskDB.removeApprovalTask(conn,kix,thisApprover,thisDelegate);
							if (debug) logger.info("removeApprovalTask - ("+thisApprover+"/"+thisDelegate+") - " + rowsAffected);

							// add new tasks
							if (nextApprover != null){
								msg = TaskDB.addApprovalTask(conn,kix,nextApprover,nextApprover);
								if (debug && msg.getResult()) logger.info("addApprovalTask - ("+nextApprover+"/"+nextApprover+") " + msg);

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
									if (nextDelegate.equals("")){
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

									String approverSendsNextApprovalEmail = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System",
																																"ApproverSendsNextApprovalEmail");
									if (approverSendsNextApprovalEmail.equals(Constant.ON)){
										sender = user;
									}

									mailerDB = new MailerDB(conn,
																	sender,
																	nextApprover,
																	nextDelegate,
																	"",
																	alpha,
																	num,
																	campus,
																	"emailProgramApprovalRequest",
																	kix,
																	user);

									if (debug){
										logger.info("approval email sent to next approver - " + nextApprover);
										logger.info("approval email sent to next delegate - " + nextDelegate);
									}

								} // !fastTrack
							} // nextApprover
						}
						else{
							if (debug) logger.info("not continueApproval");
							thisApprover = user;
							thisDelegate = "";
							nextApprover = "";
							nextDelegate = "";
						}	// continueApproval

					}	// approversNextSequence
				}	// thisSequence==lastSequence
			} // !approval

		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setCode(EXCEPTION_CODE);
			logger.fatal(kix + " -  " + user + " - approveProgramX - " + e.toString());
		}

		return msg;
	} // ProgramApproval: approveProgramX

	/*
	 * rejectProgram
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param approver	Approver
	 *	@param user			String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg rejectProgram(Connection conn,String kix,Approver approver,String user){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

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

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ProgramApproval");

			if (debug) logger.info("rejectProgram - START");

			// who are we dealing with at this time? collect info to have task removed
			String thisApprover = approver.getApprover();
			String thisDelegate = approver.getDelegated();
			int sequence = Integer.parseInt(approver.getSeq());
			if (approver.getDistributionList()){
				thisApprover = ApproverDB.getApproversBySeq(conn,campus,sequence,route);
				thisApprover = DistributionDB.getDistributionMembers(conn,campus,thisApprover);
			}
			rowsAffected = TaskDB.removeApprovalTask(conn,kix,thisApprover,thisDelegate);

			if (debug) logger.info("rejectProgram - thisApprover - " + thisApprover);
			if (debug) logger.info("rejectProgram - thisDelegate - " + thisDelegate);
			if (debug) logger.info("rejectProgram - rowsAffected - " + rowsAffected);

			// depending on the system settings for rejection, we may either send back to the proposer
			// or in the case of step back, we send back to the previous approver.
			String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
			if (debug) logger.info("rejectProgram - whereToStartOnOutlineRejection - " + whereToStartOnOutlineRejection);

			if (	(Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection) ||
					(Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection) ){

				bundle = "emailProgramReject";
				inviterTask = Constant.TASK_PROPOSER;
				roleTask = Constant.TASK_PROPOSER;
				message = Constant.PROGRAM_MODIFY_TEXT;
				progress = Constant.PROGRAM_MODIFY_PROGRESS;
				edit = 1;

				mailFrom = approver.getApprover();
				mailTo = proposer;
			}
			else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){

				bundle = "emailApproveProgram";
				roleTask = Constant.TASK_APPROVER;
				inviterTask = Constant.TASK_APPROVER;
				message = Constant.PROGRAM_APPROVAL_TEXT;
				progress = Constant.PROGRAM_APPROVAL_PROGRESS;
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
					if (sequence==1)
						stepBackApprover = HistoryDB.getCompletedApproverBySequence(conn,kix,sequence);
					else
						stepBackApprover = ApproverDB.getApproversBySeq(conn,campus,sequence,route);

					mailTo = stepBackApprover;
					mailCC = proposer;
				}
				else{
					bundle = "emailProgramReject";
					roleTask = Constant.TASK_PROPOSER;
					inviterTask = Constant.TASK_PROPOSER;
					message = Constant.PROGRAM_MODIFY_TEXT;
					progress = Constant.PROGRAM_MODIFY_PROGRESS;
					edit = 1;
					mailTo = proposer;
				}
			}
			else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection)){
				// this condition permits approver to select who to send the outline back to.
				// in this case, we do a forwardURL and stop processing the rest of the routine
				// code 1 tells lstappr that we are going to list the entire route and the proposer
				moveOn = false;
				msg.setCode(1);
				msg.setMsg("forwardURL");
				msg.setKix(kix);
			}

			if (debug){
				logger.info("bundle - " + bundle);
				logger.info("roleTask - " + roleTask);
				logger.info("inviterTask - " + inviterTask);
				logger.info("message - " + message);
				logger.info("progress - " + progress);
				logger.info("mailTo - " + mailTo);
				logger.info("moveOn - " + moveOn);
				logger.info("edit - " + edit);
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
															"",
															"ADD",
															type,
															inviterTask,
															roleTask,
															kix,
															Constant.PROGRAM);
					if (debug) logger.info(kix + " - add task for " + message + ": " + tasks[i] + " - " + rowsAffected + " rows");
				}

				MailerDB mailerDB = new MailerDB(conn,
															mailFrom,
															mailTo,
															mailCC,
															"",
															alpha,
															num,
															campus,
															bundle,
															kix,
															user);

				String sql = "UPDATE tblPrograms "
					+ "SET edit=?,progress=? "
					+ "WHERE historyid=? "
					+ "AND campus=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,edit);
				ps.setString(2,progress);
				ps.setString(3,kix);
				ps.setString(4,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}	// moveOn

			if (debug) logger.info("rejectProgram - END");

		} catch (SQLException se) {
			logger.fatal(kix + " - ProgramApproval - rejectProgram - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - ProgramApproval - rejectProgram - " + e.toString());
		}

		return msg;
	}

	/*
	 * rejectProgramToProposer	- goes directly to the propser
	 *	<p>
	 *	@param conn			Connection
	 *	@param kix			String
	 *	@param approver	Approver
	 *	<p>
	 *	@return Msg
	 */
	public static Msg rejectProgramToProposer(Connection conn,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

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
		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ProgramApproval");

			bundle = "emailProgramReject";
			inviterTask = Constant.TASK_PROPOSER;
			roleTask = Constant.TASK_PROPOSER;
			message = Constant.PROGRAM_MODIFY_TEXT;
			progress = Constant.PROGRAM_MODIFY_PROGRESS;
			edit = 1;

			mailFrom = user;
			mailTo = proposer;

			rowsAffected = TaskDB.logTask(conn,
													mailTo,
													mailFrom,
													alpha,
													num,
													message,
													campus,
													"",
													"ADD",
													type,
													inviterTask,
													roleTask,
													kix,
													Constant.PROGRAM);
			if (debug) logger.info(kix + " - add task for " + message + ": " + mailTo + " - " + rowsAffected + " rows");

			MailerDB mailerDB = new MailerDB(conn,mailFrom,mailTo,"","",alpha,num,campus,bundle,kix,user);

			// update program data
			String enableOutlineEdit = "UPDATE tblPrograms "
				+ "SET edit=?,progress=? "
				+ "WHERE kix=? "
				+ "AND campus=?";
			PreparedStatement ps = conn.prepareStatement(enableOutlineEdit);
			ps.setInt(1,edit);
			ps.setString(2,progress);
			ps.setString(3,kix);
			ps.setString(4,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException se) {
			logger.fatal(kix + " - ProgramApproval - rejectProgramToProposer - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - ProgramApproval - rejectProgramToProposer - " + e.toString());
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
	public static int cleanUp(Connection conn,
										String kix,
										String user,
										int sequence) throws Exception {


		//Logger logger = Logger.getLogger("test");

		String[] tasks = new String[20];
		int xyz = 0;
		int z = 0;
		int rowsAffected = 0;

		String delegated = "";
		String temp = "";

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

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
					rowsAffected = TaskDB.logTask(conn,
															tasks[z],
															tasks[z],
															alpha,
															num,
															Constant.PROGRAM_APPROVAL_TEXT,
															campus,
															"",
															"REMOVE",
															type,
															"",
															"",
															kix,
															Constant.PROGRAM);
					if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + tasks[z]);
				}
			}
			else{
				lastApprovers = user;
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.PROGRAM_APPROVAL_TEXT,
														campus,
														"",
														"REMOVE",
														type,
														"",
														"",
														kix,
														Constant.PROGRAM);
				if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + user);
			}

			// remove/add tasks depending on approver or delegate; either way, must remove
			// approver or delegate
			delegated = ApproverDB.getDelegateByApproverName(conn,campus,user,route);
			if (!"".equals(delegated)){
				rowsAffected = TaskDB.logTask(conn,
														proposer,
														delegated,
														alpha,
														num,
														Constant.PROGRAM_APPROVAL_TEXT,
														campus,
														"",
														"REMOVE",
														type,
														"",
														"",
														kix,
														Constant.PROGRAM);
				if (debug) logger.info(kix + " - " + (++xyz) + ". cleanUp - remove task - " + delegated);
			}
			else{
				delegated = ApproverDB.getApproverByDelegateName(conn,campus,user,route);
				if (!"".equals(delegated)){
					rowsAffected = TaskDB.logTask(conn,
															proposer,
															delegated,
															alpha,
															num,
															Constant.PROGRAM_APPROVAL_TEXT,
															campus,
															"",
															"REMOVE",
															type,
															"",
															"",
															kix,
															Constant.PROGRAM);
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
				removeApproverFromSequence(conn,campus,kix,user,sequence);

		} catch (Exception e) {
			logger.fatal(kix + " -  " + user + " - ProgramApproval: cleanUp - " + e.toString());
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
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];
		String campus = info[Constant.KIX_CAMPUS];
		int route = Integer.parseInt(info[Constant.KIX_ROUTE]);

		String sql = "";
		int xyz = 0;
		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ProgramApproval");

			/*
				1) approve the outline by moving to ARC, setting to CUR
				2) if all goes well, send notification, remove task
				3) if not, remove last history entry and have it done again
			*/
			msg = updateProgram(campus,kix,proposer);
			if (msg.getCode()==ERROR_CODE){
				sql = "DELETE FROM tblApprovalHist WHERE campus=? AND historyid=? AND approver=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, kix);
				ps.setString(3, mailer.getFrom());
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info(kix + " - update program failed");
				msg.setMsg("Exception");
			}
			else{
				msg.setCode(LAST_APPROVER);

				MailerDB mailerDB = new MailerDB(conn,mailer.getFrom(),proposer,"","",alpha,num,campus,"emailApproveProgram",kix,user);
				if (debug) logger.info("send mail emailApproveProgram");

				// notify and add task for registrar
				DistributionDB.notifyDistribution(conn,campus,alpha,num,"",mailer.getFrom(),"","","emailNotifiedWhenProgramApproved","NotifiedWhenApproved",user);
				if (debug) logger.info("send mail emailNotifiedWhenProgramApproved");

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
														alpha,num,campus,"emailApprovedProgramToApprovers",kix,user);

						AseUtil.logAction(conn, user, "ACTION","Program notifications sent to "
																+ allApprovers.replace(",",", ")
																+ " ("+ alpha + " " + num + ")","","",campus,kix);
					}

				}

				// createTaskForApprovedOutline
				String createTaskForApprovedOutline = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","createTaskForApprovedOutline");
				if ("1".equals(createTaskForApprovedOutline)){
					String distributionMembers = DistributionDB.getDistributionMembers(conn,campus,"NotifiedWhenApproved");
					if (distributionMembers != null && distributionMembers.length() > 0){
						String[] tasks = new String[20];
						tasks = distributionMembers.split(",");
						for (int z=0;z<tasks.length;z++){
							rowsAffected = TaskDB.logTask(conn,
																	tasks[z],
																	proposer,
																	alpha,
																	num,
																	Constant.PROGRAM_APPROVED_TEXT,
																	campus,
																	"",
																	"ADD",
																	"CUR",
																	"",
																	"",
																	kix,
																	Constant.PROGRAM);
							if (debug) logger.info("create task emailNotifiedWhenProgramApproved - " + tasks[z]);
							AseUtil.logAction(conn,proposer,"ADD","Outline approved task ("+ tasks[z] + ")",alpha,num,campus,kix);
						} // for
					} // if distributionMembers
				} // if createTaskForApprovedOutline
			}  // if msg.getCode()==ERROR_CODE
		} catch (SQLException se) {
			logger.fatal(kix + " - ProgramApproval: processLastApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - ProgramApproval: processLastApprover - " + e.toString());
		}

		return msg;

	}

	/*
	 * setProgramForApproval
	 *	<p>
	 * sends approval notice. called when list of approvers is presented to user for selection.
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	approver		String
	 * @param	seq			String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg setProgramForApproval(Connection conn,
														String campus,
														String kix,
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
		String proposer = "";
		String alpha = "";
		String num = "";

		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

		if (debug) logger.info(approver + " - ProgramApproval - setProgramForApproval - start");

		try{
			if (!"".equals(approver)){
				Programs program = new Programs();
				if (!"".equals(kix)){
					program = ProgramsDB.getProgramToModify(conn,campus,kix);
					if ( program != null ){
						alpha = program.getTitle();
						num = program.getDivisionDescr();
						proposer = program.getProposer();
					}
				}

				tasks = approver.split(",");
				for (int z=0;z<tasks.length;z++){
					rowsAffected = TaskDB.logTask(conn,
															tasks[z],
															tasks[z],
															alpha,
															num,
															Constant.PROGRAM_APPROVAL_TEXT,
															campus,
															"",
															"REMOVE",
															type,
															"",
															"",
															kix,
															Constant.PROGRAM);
					if (debug) logger.info(approver + " - ProgramApproval - approveProgramX - delete approver task - rowsAffected " + rowsAffected);

					rowsAffected = TaskDB.logTask(conn,
															tasks[z],
															proposer,
															alpha,
															num,
															Constant.PROGRAM_APPROVAL_TEXT,
															campus,
															"",
															"ADD",
															type,
															proposer,
															Constant.TASK_APPROVER,
															kix,
															Constant.PROGRAM);
					if (debug) logger.info("ProgramsDB - setProgramForApproval - approval task created - rowsAffected " + rowsAffected);

					if (toNames.length()==0)
						toNames = tasks[z];
					else
						toNames = toNames + "," + tasks[z];
				} // for

				sender = proposer + domain;
				MailerDB mailerDB = new MailerDB(conn,sender,toNames,proposer,"",alpha,num,campus,"emailOutlineApprovalRequest",kix);
				if (debug) logger.info("ProgramsDB - setProgramForApproval - mail sent - " + approver);
			} // approver
		} catch (SQLException se) {
			msg.setMsg("Exception");
			logger.fatal(approver + " - ProgramApproval: setProgramForApproval - " + se.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal(approver + " - ProgramApproval: setProgramForApproval - " + e.toString());
		}

		if (debug) logger.info(approver + " - " + kix + " - ProgramApproval: setProgramForApproval - ENDS");

		return msg;
	}

	/*
	 * removeApproverFromSequence
	 *	<p>
	 * sends approval notice. called when list of approvers is presented to user for selection.
	 *	<p>
	 *	@param	connection		Connection
	 * @param	campus			String
	 * @param	kix				String
	 * @param	user				String
	 * @param	seq				int
	 *	<p>
	 *	@return int
	 */
	public static int removeApproverFromSequence(Connection conn,
																String campus,
																String kix,
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
		int z = 0;
		int xyz = 0;
		String proposer = "";
		String alpha = "";
		String num = "";
		int route = 0;

		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

		try{
			Programs program = new Programs();
			if (!"".equals(kix)){
				program = ProgramsDB.getProgramToModify(conn,campus,kix);
				if ( program != null ){
					alpha = program.getTitle();
					num = program.getDivisionDescr();
					proposer = program.getProposer();
					route = program.getRoute();
				}
			}

			if (debug) logger.info(kix + " - " + (++xyz) + ". ProgramApproval - removeApproverFromSequence - user - " + user);

			// 1) get list of approvers for this sequence into approvers
			approvers = ApproverDB.getApproversBySeq(conn,campus,seq,route);
			if (debug) logger.info(kix + " - " + (++xyz) + ". ProgramApproval - removeApproverFromSequence - " + approvers);

			if (approvers.indexOf('[')==0){
				approvers = DistributionDB.removeBracketsFromList(approvers);
				approvers = DistributionDB.getDistributionMembers(conn,campus,approvers);
			}

			if (debug) logger.info(kix + " - " + (++xyz) + ". ProgramApproval - removeApproverFromSequence - approvers - " + approvers);

			// 2) remove people already approved
			approvers = approvers.replace(user,"");
			approvers = approvers.replace(",,",",");

			// remove first comma
			if (approvers.indexOf(",")==0)
				approvers = approvers.substring(1,approvers.length());

			if (debug) logger.info(kix + " - " + (++xyz) + ". ProgramApproval - removeApproverFromSequence - approvers - " + approvers);

			// 3) afer for loop, cycle through list of remaining and add them to history
			tasks = approvers.split(",");
			for (z=0;z<tasks.length;z++){
				if (!"".equals(tasks[z])){
					HistoryDB.addHistory(conn,alpha,num,campus,
												tasks[z],HistoryDB.getNextSequenceNumber(conn),
												true,"Approval not required",kix,seq);
					if (debug) logger.info(kix + " - " + (++xyz) + ". ProgramApproval - removeApproverFromSequence - history - " + tasks[z]);
				} // if
			} // for
		} catch (SQLException se) {
			logger.fatal(kix + " - ProgramApproval: removeApproverFromSequence - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - ProgramApproval: removeApproverFromSequence - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	/*
	 * updateProgram
	 *	<p>
	 * @param	campus		String
	 * @param	kix			String
	 * @param	user			String
	 *	<p>
	 *	@return int
	 */
	public static Msg updateProgram(String campus,String kixPRE,String user) throws Exception {

		//int LAST_APPROVER 	= 2;
		//int ERROR_CODE 		= 3;
		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int i = 0;

		Msg msg = new Msg();
		PreparedStatement ps;

      Connection conn = null;

		String sql = null;
		String title = "";
		String degree = "";
		String division = "";

		int deg = 0;
		int div = 0;

		String progress = "";

		String currentDate = AseUtil.getCurrentDateTimeString();

		logger.info("UPDATEPROGRAM - START");

		boolean debug = DebugDB.getDebug(conn,"ProgramApproval");

		try {

			conn = AsePool.createLongConnection();

			conn.setAutoCommit(false);

			Programs program = ProgramsDB.getProgramToModify(conn,campus,kixPRE);
			if ( program != null ){
				title = program.getTitle();
				progress = program.getProgress();

				degree = program.getDegreeDescr();
				deg = program.getDegree();

				division = program.getDivisionDescr();
				div = program.getDivision();

				program = null;
			}

			if (debug){
				logger.info("kixPRE: " + kixPRE);
				logger.info("title: " + title);
				logger.info("progress: " + progress);
				logger.info("degree: " + degree + " (" + deg + ")");
				logger.info("division: " + division + " (" + div + ")");
			}

			//
			// is there a current or approved program?
			//
			String kixCUR = ProgramsDB.getHistoryIDFromTitle(conn,campus,title,"CUR",deg,div);
			if (debug) logger.info("kixCUR: " + kixCUR);

			String kixARC = "";

			if (kixCUR != null && kixCUR.length() > 0){

				int degCUR = 0;
				int divCUR = 0;
				Programs programCUR = ProgramsDB.getProgramToModify(conn,campus,kixCUR);
				if ( programCUR != null ){
					degCUR = programCUR.getDegree();
					divCUR = programCUR.getDivision();

					programCUR = null;
				}

				if (debug){
					logger.info("kixCUR: " + kixCUR);
					logger.info("degree: " + degCUR);
					logger.info("division: " + divCUR);
				}

				kixARC = SQLUtil.createHistoryID(1);
				sql = "UPDATE tblPrograms SET type='ARC',progress='ARCHIVED',historyid=? WHERE historyid=? AND degreeid=? AND divisionid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kixARC);
				ps.setString(2,kixCUR);
				ps.setInt(3,degCUR);
				ps.setInt(4,divCUR);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("CUR 2 ARC " + rowsAffected + " rows");
			}

			//
			// make the proposed program the new approved program
			//
			sql = "UPDATE tblPrograms SET type='CUR',progress='APPROVED',proposer=?,dateapproved=? WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,currentDate);
			ps.setString(3,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("PRE 2 CUR " + rowsAffected + " rows");

			//
			// archive approval history and set KIX to match with ARCHIVED
			//
			if(!kixARC.equals(Constant.BLANK)){
				sql = "UPDATE tblApprovalHist2 SET historyid=? WHERE campus=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kixARC);
				ps.setString(2,campus);
				ps.setString(3,kixCUR);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("update archive history - " + rowsAffected + " rows");
			} // archive exists?

			//
			// APPROVAL HISTORY
			//
			sql = "INSERT INTO tblApprovalHist2 (id,historyid,approvaldate,coursealpha,coursenum,"
					+ "dte,campus,seq,approver,approved,comments,approver_seq,votesFor,votesAgainst,votesAbstain,inviter,role,progress) "
					+ "SELECT tba.id,'"+kixPRE+"', '"
					+ currentDate
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments, tba.approver_seq, "
					+ "tba.votesFor,tba.votesAgainst,tba.votesAbstain,tba.inviter,tba.role,tba.progress "
					+ "FROM tblApprovalHist tba "
					+ "WHERE campus=? "
					+ "AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("update history - " + rowsAffected + " rows");

			sql = "DELETE FROM tblApprovalHist WHERE campus=? AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("delete history - " + rowsAffected + " rows");

			//
			// REVIEW HISTORY
			//
			sql = "INSERT INTO tblReviewHist2 "
					+ "(id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled) "
					+ "SELECT id, '"+kixPRE+"', campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled "
					+ "FROM tblReviewHist "
					+ "WHERE campus=? "
					+ "AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("update reviews - " + rowsAffected + " rows");

			sql = "DELETE FROM tblReviewHist WHERE campus=? AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kixPRE);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			if (debug) logger.info("delete reviews - " + rowsAffected + " rows");

			// delete the miscallaneous item
			rowsAffected = MiscDB.deleteMisc(conn,kixPRE);

			conn.commit();

			conn.setAutoCommit(true);

			//
			// creating outline is only possible after commit
			//
			Tables.createPrograms(campus,kixPRE,degree,division);

		} catch (SQLException ex) {
			//
			// this is caught before exception. However, there are instances
			// where it may be valid and still executes.
			//
			conn.rollback();
			logger.fatal(user + " - ProgramApproval: updateProgram\n" + ex.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);
			msg.setErrorLog("Exception");
			if (debug) logger.info(kixPRE + " - " + user + "- ProgramApproval: updateProgram - Rolling back transaction");
		} catch (Exception e) {
			//
			// must do since for any exception, a rollback is a must.
			//
			logger.fatal(user + " - ProgramApproval: updateProgram\n " + e.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);

			try {
				conn.rollback();
				if (debug) logger.info(kixPRE + " - " + user + "- ProgramApproval: updateProgram - Rolling back transaction");
			} catch (SQLException exp) {
				msg.setCode(ERROR_CODE);
				logger.fatal(user + " - ProgramApproval: updateProgram\n " + exp.toString());
				msg.setMsg("Exception");
				msg.setErrorLog("Exception");
			}
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("ProgramApproval: updateProgram - " + e.toString());
			}
		}

		logger.info("UPDATEPROGRAM - END");

		return msg;
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
			String sql = "UPDATE tblPrograms "
				+ "SET votefor=?,voteagainst=?,voteabstain=? "
				+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,voteFor);
			ps.setInt(2,voteAgainst);
			ps.setInt(3,voteAbstain);
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramApproval: updateVoting - " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}
}