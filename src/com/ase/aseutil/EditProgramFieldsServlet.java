/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class EditProgramFieldsServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(EditProgramFieldsServlet.class.getName());

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {}


	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

		//Logger logger = Logger.getLogger("test");

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", (Constant.BLANK));

		String sAction = Constant.BLANK;
		String checkField = Constant.BLANK;
		String sql = Constant.BLANK;
		String message = Constant.BLANK;
		String kix = Constant.BLANK;
		String reason = Constant.BLANK;
		String auditby = Constant.BLANK;
		String alpha = Constant.BLANK;
		String num = Constant.BLANK;
		String campus = Constant.BLANK;
		String proposer = Constant.BLANK;
		String noMsg = Constant.OFF;
		String editSystem = Constant.BLANK;
		String temp = Constant.BLANK;

		String rtn = "index";
		String url;
		String[] junk = null;


		final int EDIT 		= 1;
		final int APPROVAL	= 2;
		final int MODIFY		= 3;
		int currentAction 	= APPROVAL;

		Msg msg = new Msg();

		int i = 0;
		int route = 0;
		int rowsAffected = 0;
		int iAction = 0;

		int voteFor = 0;
		int voteAgainst = 0;
		int voteAbstain = 0;

		PreparedStatement ps = null;

		boolean moveOn = true;
		boolean updateReason = true;
		boolean foundProgram = false;

		boolean debug = true;

		AsePool connectionPool = AsePool.getInstance();
		Connection conn = connectionPool.getConnection();
		try {

			debug = DebugDB.getDebug(conn,"EditProgramFieldsServlet");

			if (debug){
				logger.info("--------------------------------");
				logger.info("EditProgramFieldsServlet - START");
			}

			msg.setMsg(Constant.BLANK);

			WebSite website = new WebSite();

			campus = website.getRequestParameter(request,"campus");
			kix = website.getRequestParameter(request,"kix");
			Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
			if ( program != null ){
				proposer = program.getProposer();
				route = program.getRoute();
			}

			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");
			rtn = website.getRequestParameter(request,"rtn");

			auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			int totalEnabledFields = website.getRequestParameter(request, "totalEnabledFields", 0);

			/*
				if there is nothing to go back to, go to index.
			*/
			int editing = website.getRequestParameter(request, "edit", 0);
			boolean enablingDuringApproval = website.getRequestParameter(request, "enabling", false);

			if (enablingDuringApproval){
				rtn = "index";
				currentAction = APPROVAL;
			}
			else if (editing==1){
				currentAction = MODIFY;
				noMsg = (Constant.ON);
			}
			else if (rtn==null || rtn.length()==0){
				rtn = "index";
				currentAction = APPROVAL;
			}
			else if ("prgedt".equals(rtn)){
				currentAction = EDIT;
				noMsg = "0";
			}

			if (debug) logger.info("currentAction: " + currentAction);
			if (debug) logger.info("rtn: " + rtn);

			final int cancelAction = 1;
			final int submitAction = 2;

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			if (sAction.equalsIgnoreCase("cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("submit")) iAction = submitAction;

			if (debug){
				logger.info("sAction - " + sAction);
				logger.info("proposer - " + proposer);
				logger.info("campus - " + campus);
				logger.info("kix - " + kix);
				logger.info("submit - " + submit);
				logger.info("cancel - " + cancel);
				logger.info("rtn - " + rtn);
				logger.info("editing - " + editing);
				logger.info("enablingDuringApproval - " + enablingDuringApproval);
			}

			reason = website.getRequestParameter(request,"reason","");

			switch (iAction) {
				case cancelAction:
					rtn = "index";

					if (currentAction==APPROVAL)
						message = "Operation was cancelled successfully.";
					else if (currentAction==EDIT || currentAction==MODIFY){
						message = "Operation was cancelled successfully.";
					}

					AseUtil.logAction(conn,auditby,"EditFields","Cancelled",alpha,num,campus,kix);

					break;
				case submitAction:

					moveOn = true;

					int fieldCountSystem = website.getRequestParameter(request,"fieldCountSystem", 0);

					// if attempting to edit, and this is a new modification, we need to move the program
					// into PRE from CUR or new. For existing mods, we don't have to do this.
					if (currentAction==EDIT){

						if (debug) logger.info("currentAction==EDIT");

						msg = ProgramModify.modifyProgram(conn,campus,kix,user,Constant.PROGRAM_MODIFY_PROGRESS,reason);
						if ("Exception".equals(msg.getMsg())){
							message = "Program modification failed.";
							session.setAttribute("aseException", "Exception");
							moveOn = false;
							updateReason = false;
						}
						else if (!(Constant.BLANK).equals(msg.getMsg())){
							message = "Unable to modify program.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
							moveOn = false;
							updateReason = false;
						}
						else{
							kix = msg.getKix();
						}

						if (moveOn){
							if (totalEnabledFields==fieldCountSystem && moveOn==true)
								message = "Selected items have been enabled for modifications (EDIT ACTION).";
						}
					}

					/*
						moveOn is true only if select items were enabled for edits. If all were enabled,
						we don't have to go through here. this section sets up the 1s and 0s that
						is needed for edit.
					*/
					if (moveOn){

						if (debug) logger.info("moveOn");

						/*
							save the comment/reason for this modification. had to do so here because
							the modifyoutline routine call above moves records from CUR to PRE but not
							updating this data

							DO NOT COMBINE as ELSE to above IF
						*/

						if (currentAction==MODIFY || updateReason){
							if (debug) logger.info("currentAction==MODIFY");
							if (!reason.equals(Constant.BLANK)){
								rowsAffected = ProgramsDB.updateReason(conn,kix,reason,auditby);
							}
						}

						/*
							allocate enough room to get back check marks
							hiddenFieldSystem is a CSV hidden form field
						*/
						String[] hiddenFieldSystem = new String[fieldCountSystem];
						hiddenFieldSystem = website.getRequestParameter(request,"hiddenFieldSystem").split(",");

						if (totalEnabledFields==fieldCountSystem){
							editSystem = Constant.ON;
							foundProgram = true;
							if (debug) logger.info("all items enabled");
						}
						else{

							if (debug) logger.info("partial items enabled");

							for (i=0; i<fieldCountSystem; i++) {
								checkField =  "Program_" + hiddenFieldSystem[i];
								temp = website.getRequestParameter(request,checkField);
								if (temp != null && (Constant.ON).equals(temp)){
									temp = hiddenFieldSystem[i];
									foundProgram = true;
								}
								else
									temp = Constant.OFF;

								if (editSystem.length() == 0)
									editSystem = temp;
								else
									editSystem += "," + temp;
							}
						} // (totalEnabledFields==(fieldCountSystem))

						if (debug){
							logger.info("editSystem: " + editSystem);
							logger.info("foundProgram: " + foundProgram);
						}

						// if selections were made, save. If selections were made individually
						// for one section but not the other, it means that the unselected section
						// would be disabled.
						if (foundProgram) {

							if (debug) logger.info("found program items");

							sql = "UPDATE tblPrograms SET edit1=?,edit2='' WHERE campus=? AND historyid=?";
							ps = conn.prepareStatement(sql);
							ps.setString(1,editSystem);
							ps.setString(2,campus);
							ps.setString(3,kix);
							rowsAffected = ps.executeUpdate();
							ps.close();
							ps = null;
							if (debug) logger.info("update table " + rowsAffected + " row");

							if (currentAction==MODIFY || updateReason){

								if (debug) logger.info("currentAction==MODIFY");

								// save editable items to misc table so that we can create report showing items being
								// modified for this outline
								rowsAffected = MiscDB.insertMisc(conn,
																			campus,kix,alpha,num,"PRE",
																			Constant.PROGRAM_MODIFICATION,
																			editSystem,auditby,editSystem,"");

								if (debug) logger.info("update misc " + rowsAffected + " row");
							}

							message = "Selected items have been enabled for modifications.";

							if (currentAction==APPROVAL){

								if (debug) logger.info("currentAction==APPROVAL");

								// comment coming from session because after rejecting, the application was
								// sent to showfield to enable fields for modifications
								String approvalComment = (String)session.getAttribute("aseApplicationComments");

								voteFor = NumericUtil.getNumeric(session,"aseApplicationVoteFor");
								voteAgainst = NumericUtil.getNumeric(session,"aseApplicationVoteAgainst");
								voteAbstain = NumericUtil.getNumeric(session,"aseApplicationVoteAbstain");

								if (debug){
									logger.info("approvalComment: " + approvalComment);
									logger.info("voteFor: " + voteFor);
									logger.info("voteAgainst: " + voteAgainst);
									logger.info("voteAbstain: " + voteAbstain);
								}

								// editSystem is in this format: "0,0,3,0,0,0,13,15,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
								// we want to clean up the string and have only 3,13,15,16
								// proceed only if user enable items for edits
								// convert the question number to question seq so it's easier to understand
								if (editSystem.indexOf(",")>-1 || !(Constant.ON).equals(editSystem)){
									junk = editSystem.split(",");
									editSystem = (Constant.BLANK);
									for (int z=0;z<junk.length;z++){
										if (!"0".equals(junk[z])){
											if ((Constant.BLANK).equals(editSystem))
												editSystem = junk[z];
											else
												editSystem = editSystem + "," + junk[z];
										}
									}

									editSystem = CCCM6100DB.getSequenceFromQuestionNumbers(conn,
																											campus,
																											Constant.TAB_PROGRAM,
																											editSystem);

									if (debug) logger.info((Constant.BLANK)
																	+ auditby
																	+ " - Enabled program items for revision: "
																	+ editSystem);

									// add blank lines between
									if (approvalComment != null && approvalComment.length() > 0)
										approvalComment = approvalComment + "<br/><br/>";

									approvalComment = approvalComment
															+ "Revision requested for item(s): "
															+ editSystem
															+ "<br/><br/>";
								} // (editSystem.indexOf(",")>-1 || !(Constant.ON).equals(editSystem))

								msg = ProgramApproval.approveProgram(conn,
																				campus,
																				kix,
																				user,
																				false,
																				approvalComment,
																				voteFor,
																				voteAgainst,
																				voteAbstain);

								if (debug) logger.info("msg: " + msg);

								if (!"Exception".equals(msg.getMsg())){
									String email = UserDB.getUserEmail(conn,user);
									if (email != null && email.length() > 0){

										String modifiedBy = (Constant.BLANK);

										// depending on what to do with rejected outlines.
										String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
										if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection)){
											modifiedBy = proposer;
											message = "Selected items have been enabled for modifications by " + modifiedBy + ".";
										}
										else if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection)){
											modifiedBy = proposer;
											message = "Selected items have been enabled for modifications by " + modifiedBy + ".";
										}
										else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){

											// for taking a step back, find the current sequence then send back to minus 1
											// if current is 1, send back to proposer.
											// if current is 2, determine who in the 1 level should receive.
											// do this by checking whether they started approving already.
											int approverSequence = ApproverDB.getApproverSequence(conn,user,route);
											if (approverSequence>1){
												if (approverSequence==2)
													modifiedBy  = ApproverDB.getHistoryApproverBySeq(conn,campus,alpha,num,1);
												else
													modifiedBy  = ApproverDB.getApproversBySeq(conn,campus,--approverSequence,route);

												message = "Program revision was returned to " + modifiedBy + ".";
											}
											else{
												modifiedBy = proposer;
												message = "Selected items have been enabled for modifications by " + modifiedBy + ".";
											}
										}
										else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection)){
											// this condition permits approver to select who to send the outline back to.
											// in this case, we do a forwardURL and stop processing the rest of the routine
											// code 1 tells lstappr that we are going to list the entire route and the proposer
											msg.setCode(1);
											msg.setMsg("forwardURL");
											msg.setKix(kix);
											rtn = "lstappr";
										}	// if reject

										if (debug){
											logger.info("email FROM: " + email);
											logger.info("email TO: " + modifiedBy);
										}
									}
								}
								else{
									msg.setMsg("Exception");
									session.setAttribute("aseException", "Exception");
									message = "Unable to continue with program approval.";
								}
							}	// currentAction==APPROVAL

						} else {
							message = "When requesting revision for an program, you must enable items for the author to modify.<br>"
									+ "Click the browser\'s back button to select items for modifications, or cancel this operation.";
						} // if found course and found campus

						AseUtil.logAction(conn,auditby,"EditFields","Submit",alpha,num,campus,kix);
					}	// moveOn

					break;
			}

			session.setAttribute("aseApplicationMessage", message);

			if (debug) logger.info("EditProgramFieldsServlet - END");

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", message);
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn,"EditProgramFieldsServlet",auditby);
		}

		if ("Exception".equals(msg.getMsg())) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?nomsg=" + noMsg + "&rtn=" + rtn + "&kix=" + kix);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}