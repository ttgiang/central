/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
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

public class EditFieldsServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(EditFieldsServlet.class.getName());

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		int i = 0;
		int rowsAffected = 0;
		String sAction = "";
		String checkField = "";
		String rtn = "index";
		String url;
		String sql = "";
		String message = "";
		String[] junk = null;

		String kix = "";

		final int EDIT 		= 1;				// when modify from existing
		final int APPROVAL	= 2;
		final int MODIFY		= 3;				// enabling after modification starts
		int currentAction 	= APPROVAL;

		Msg msg = new Msg();

		int iAction = 0;
		boolean moveOn = true;
		boolean updateReason = true;
		String reason = "";
		String noMsg = "0";
		String auditby = "";

		int voteFor = 0;
		int voteAgainst = 0;
		int voteAbstain = 0;

		boolean debug = false;
		boolean allItemsEnabled = false;

		String disabled = "";

		AsePool connectionPool = AsePool.getInstance();
		Connection connection = connectionPool.getConnection();
		try {

			debug = DebugDB.getDebug(connection,"EditFieldsServlet");

			if (debug) logger.info("EditFieldsServlet - START");

			PreparedStatement ps = null;

			msg.setMsg("");

			WebSite website = new WebSite();

			String campus = website.getRequestParameter(request,"campus");
			String alpha = website.getRequestParameter(request,"alpha");
			String num = website.getRequestParameter(request,"num");

			auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			kix = Helper.getKix(connection,campus,alpha,num,"PRE");
			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			String enabledForEdits = website.getRequestParameter(request,"enabledForEdits","");

			if (debug){
				logger.info("campus - " + campus);
				logger.info("alpha - " + alpha);
				logger.info("num - " + num);
				logger.info("kix - " + kix);
				logger.info("enabledForEdits - " + enabledForEdits);
			}

			boolean foundCourse = false;
			boolean foundCampus = false;

			/*
				totalEnabledFields is the count of fields enabled for edits. If this count
				is the same as the number of items on the screen, then we are saying that all
				fields are editable. If so, set edit1 and edit2 to 1. Don't bother setting 0s and 1s
				since it's all the same.

				When the fields are equal, then we don't moveOn; otherwise moveOn = true to force
				update of edit fields to 1s and 0s.
			*/
			int totalEnabledFields = website.getRequestParameter(request,"totalEnabledFields", 0);

			// total fields requires +2 for alpha and number which is only valid when
			// toggling for all fieldd
			int toggledAll = website.getRequestParameter(request,"toggledAll", 0);
			if(toggledAll==1){
				totalEnabledFields = totalEnabledFields + 2;
			}

			// how many checkboxes are there
			int fieldCountSystem = website.getRequestParameter(request,"fieldCountSystem", 0);
			int fieldCountCampus = website.getRequestParameter(request,"fieldCountCampus", 0);

			if (debug){
				logger.info("totalEnabledFields - " + totalEnabledFields);
				logger.info("fieldCountSystem - " + fieldCountSystem);
				logger.info("fieldCountCampus - " + fieldCountCampus);
			}

			//
			//	if there is nothing to go back to, go to index.
			//
			rtn = website.getRequestParameter(request,"rtn");
			int editing = website.getRequestParameter(request, "edit", 0);
			boolean enablingDuringApproval = website.getRequestParameter(request, "enabling", false);

			if (enablingDuringApproval){
				rtn = "index";
				currentAction = APPROVAL;
			}
			else if (editing==1){
				currentAction = MODIFY;
				noMsg = Constant.ON;
			}
			else if (rtn==null || rtn.length()==0){
				rtn = "index";
				currentAction = APPROVAL;
			}
			else if ("crsedt".equals(rtn)){
				currentAction = EDIT;
				noMsg = Constant.OFF;
			}

			final int cancelAction = 1;
			final int submitAction = 2;

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			if (sAction.equalsIgnoreCase("cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("submit")) iAction = submitAction;

			String proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,"PRE");

			if (debug){
				logger.info("sAction - " + sAction);
				logger.info("proposer - " + proposer);
				logger.info("currentAction - " + currentAction);
				logger.info("enablingDuringApproval - " + enablingDuringApproval);
			}

			switch (iAction) {
				case cancelAction:
					rtn = "index";

					if (currentAction==APPROVAL)
						message = "Operation was cancelled successfully.";
					else if (currentAction==EDIT || currentAction==MODIFY){
						message = "Operation was cancelled successfully.";
					}

					AseUtil.logAction(connection,auditby,"EditFields","Cancelled",alpha,num,campus,kix);

					break;
				case submitAction:

					moveOn = true;

					// if attempting to edit, and this is a new modification, we need to move the outline
					// into PRE from CUR or new. For existing mods, we don't have to do this.
					if (currentAction==EDIT){

						if (debug) logger.info("currentAction1: " + currentAction);

						msg = CourseModify.modifyOutline(connection,campus,alpha,num,auditby,Constant.COURSE_MODIFY_TEXT);
						if ("Exception".equals(msg.getMsg())){
							message = "Outline modification failed.";
							session.setAttribute("aseException", "Exception");
							moveOn = false;
							updateReason = false;
						}
						else if (!"".equals(msg.getMsg())){
							message = "Unable to modify outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
							moveOn = false;
							updateReason = false;
						}
						else
							kix = msg.getKix();

						if (debug) logger.info("CourseModify.modifyOutline");

						if (moveOn){
							// if coming in here for the very first time, kix would be empty until
							// modify outline is called as in the lines above
							if (kix == null || kix.length() == 0)
								kix = Helper.getKix(connection,campus,alpha,num,"PRE");

							// add entry in outline campus for quick retrieval
							CampusDB.updateCampusOutline(connection,kix,campus);
							if (debug) logger.info("update campus outline");

							if (totalEnabledFields==(fieldCountSystem+fieldCountCampus) && moveOn==true)
								message = "Selected items have been enabled for modifications (EDIT ACTION).";
						}

						if (msg.getKix() != null && msg.getKix().length() > 0)
							kix = msg.getKix();
					} // edit

					//
					//	moveOn is true only if select items were enabled for edits. If all were enabled,
					//	we don't have to go through here. this section sets up the 1s and 0s that
					//	is needed for edit.
					//
					if (moveOn){

						if (debug) logger.info("moveOn");

						//
						//	save the comment/reason for this modification. had to do so here because
						//	the modifyoutline routine call above moves records from CUR to PRE but not
						//	updating this data
						//
						//	DO NOT COMBINE as ELSE to above IF
						//

						if (currentAction==MODIFY || updateReason){

							if (debug) logger.info("currentAction2: " + currentAction);

							reason = website.getRequestParameter(request,"reason");
							if (!reason.equals(Constant.BLANK)){
								rowsAffected = Outlines.updateReason(connection,kix,reason,auditby);
							}
						}

						//
						//	allocate enough room to get back check marks
						//	hiddenFieldSystem is a CSV hidden form field
						//

						String[] hiddenFieldSystem = new String[fieldCountSystem];
						hiddenFieldSystem = website.getRequestParameter(request,"hiddenFieldSystem").split(",");

						String[] hiddenFieldCampus = new String[fieldCountCampus];
						hiddenFieldCampus = website.getRequestParameter(request,"hiddenFieldCampus").split(",");

						String editSystem = ""; // course item tab
						String editCampus = ""; // campus tab
						String temp = "";

						//
						//	for all fields, check to see if it was checked. if yes, set to 1, else 0;
						//	the final result is CSV of 0's and 1's of items that can be edited.
						//
						//	if the totalEnabledFields==(fieldCountSystem+fieldCountCampus) then
						//	set the edit values to 1 to indicate that all fields are editable. if not,
						//	go through and enable only those needing to be turned on.
						//
						if (totalEnabledFields==(fieldCountSystem+fieldCountCampus)){
							editSystem = "1";
							editCampus = "1";
							foundCourse = true;
							foundCampus = true;

							allItemsEnabled = true;

							if (debug) logger.info("all items enabled");
						}
						else{

							if (debug) logger.info("partial items enabled");

							for (i=0; i<fieldCountSystem; i++) {
								checkField =  "Course_" + hiddenFieldSystem[i];
								temp = website.getRequestParameter(request,checkField);

								// for system setting OutlineItemsRequiredForMods, certain outline items are enabled
								// automatically on modifications. when enabled, they are also disabled from user's
								// use. when disabled, process cannot pick up the value so for any disabled control
								// there is a hidden control with the same name include '_disabled' included.
								// this control is hidden and has the value of 1 indicating it's going to be used and
								// is on. on form submission, the disabled value (temp) is not found so the
								// hiddened value (disabled) is used in its place.

								disabled = website.getRequestParameter(request,checkField+"_disabled");
								if(disabled != null && disabled.equals(Constant.ON)){
									temp = disabled;
								}

								if (temp != null && temp.equals(Constant.ON)){
									temp = hiddenFieldSystem[i];
									foundCourse = true;
								}
								else{
									temp = "0";
								}

								// create enable string
								if (editSystem.length() == 0){
									editSystem = temp;
								}
								else{
									editSystem += "," + temp;
								}
							}

							for (i=0; i<fieldCountCampus; i++) {
								checkField = "Campus_" + hiddenFieldCampus[i];
								temp = website.getRequestParameter(request,checkField);

								disabled = website.getRequestParameter(request,checkField+"_disabled");
								if(disabled != null && disabled.equals(Constant.ON)){
									temp = disabled;
								}

								if (temp != null && temp.equals(Constant.ON)){
									temp = hiddenFieldCampus[i];
									foundCampus = true;
								}
								else
									temp = "0";

								if (editCampus.length() == 0)
									editCampus = temp;
								else
									editCampus += "," + temp;
							}

							//
							// after collecting on screen selection, check for dependencies
							// start by saving all items (allEditableItems and editableItems)
							// if the call to dependency check returns editableItems not equals allEditableItems
							// we know dependency was created
							// take the combined returned string and reset back editSystem and editCampus
							// dependency checking on EDIT from existing only
							//
							if(currentAction==EDIT && enabledForEdits.equals(Constant.BLANK)){
								String allEditableItems = editSystem+","+editCampus;
								String editableItems = allEditableItems;
								editableItems = setItemDependencies(connection,campus,allEditableItems);
								if(!editableItems.equals(allEditableItems)){
									int maxCourseItems = CourseDB.countCourseQuestions(connection,campus,"Y","",1);
									editSystem = "";
									editCampus = "";

									int z = 0;

									String[] xyz = editableItems.split(",");

									// remove all items for course tab (based on count in maxCourseItems);
									for(z=0; z<maxCourseItems; z++){
										if(z==0){
											editSystem = xyz[z];
										}
										else{
											editSystem = editSystem + "," + xyz[z];
										}
									} // for z

									// remaining items are for campus tab
									for(int w=z; w<xyz.length; w++){
										if(editCampus.equals(Constant.BLANK)){
											editCampus = xyz[w];
										}
										else{
											editCampus = editCampus + "," + xyz[w];
										}
									} // for w

								} // !editableItems.equals(allEditableItems)

							} // currentAction==EDIT

						} // (totalEnabledFields==(fieldCountSystem+fieldCountCampus))

						// if selections were made, save. If selections were made individually
						// for one section but not the other, it means that the unselected section
						// would be disabled.
						if (foundCourse || foundCampus) {

							if (debug) logger.info("found course or campus items");

							sql = "UPDATE tblCourse SET edit1=?,edit2=? WHERE campus=? AND CourseAlpha=? AND coursenum=? AND CourseType='PRE'";
							ps = connection.prepareStatement(sql);
							ps.setString(1, editSystem);
							ps.setString(2, editCampus);
							ps.setString(3, campus);
							ps.setString(4, alpha);
							ps.setString(5, num);
							rowsAffected = ps.executeUpdate();
							ps.close();
							ps = null;

							if (currentAction==MODIFY || updateReason){

								if (debug) logger.info("currentAction3: " + currentAction);

								if (kix.equals("")){
									kix = Helper.getKix(connection,campus,alpha,num,"PRE");
								}

								// save editable items to misc table so that we can create report showing items being
								// modified for this outline

								String sEditSystem = "";
								String sEditCampus = "";

								if(allItemsEnabled){
									sEditSystem = "";
									sEditCampus = "";
								}
								else{
									sEditSystem = CCCM6100DB.getSequenceFromQuestionNumbers(connection,
																											campus,
																											Constant.TAB_COURSE,
																											editSystem,
																											true);

									sEditCampus = CCCM6100DB.getSequenceFromQuestionNumbers(connection,
																											campus,
																											Constant.TAB_CAMPUS,
																											editCampus,
																											true);
								} // allItemsEnabled

								rowsAffected = MiscDB.insertMisc(connection,
																			campus,
																			kix,
																			alpha,
																			num,
																			"PRE",
																			Constant.OUTLINE_MODIFICATION,
																			editSystem,
																			auditby,
																			sEditSystem,
																			sEditCampus);
							}

							message = "Selected items have been enabled for modifications (" + alpha + " " + num + ").";

							if (currentAction==APPROVAL){

								if (debug) logger.info("currentAction4: " + currentAction);

								String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

								// comment coming from session because after rejecting, the application was
								// sent to showfield to enable fields for modifications
								String approvalComment = (String)session.getAttribute("aseApplicationComments");

								voteFor = NumericUtil.getNumeric(session,"aseApplicationVoteFor");
								voteAgainst = NumericUtil.getNumeric(session,"aseApplicationVoteAgainst");
								voteAbstain = NumericUtil.getNumeric(session,"aseApplicationVoteAbstain");

								if (debug) {
									logger.info("voteFor - " + voteFor);
									logger.info("voteAgainst - " + voteAgainst);
									logger.info("voteAbstain - " + voteAbstain);
								}

								// editSystem is in this format: "0,0,3,0,0,0,13,15,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
								// we want to clean up the string and have only 3,13,15,16
								// proceed only if user enable items for edits
								// convert the question number to question seq so it's easier to understand
								if (editSystem.indexOf(",")>-1 || !"1".equals(editSystem)){

									junk = editSystem.split(",");
									editSystem = "";
									for (int z=0;z<junk.length;z++){
										if (!"0".equals(junk[z])){
											if ("".equals(editSystem))
												editSystem = junk[z];
											else
												editSystem = editSystem + "," + junk[z];
										}
									}

									editSystem = CCCM6100DB.getSequenceFromQuestionNumbers(connection,
																											campus,
																											Constant.TAB_COURSE,
																											editSystem,
																											true);

									if (debug) logger.info(""
													+ auditby
													+ " - Enabled course items for revision: "
													+ editSystem);

									// add blank lines between
									if (approvalComment != null && approvalComment.length() > 0){
										approvalComment = approvalComment + "<br/><br/>";
									}

									approvalComment = approvalComment
										+ "Revision requested for the following items on <b>COURSE</b> tab: "
										+ editSystem
										+ "<br/><br/>";
								} // (editSystem.indexOf(",")>-1 || !"1".equals(editSystem))

								if (debug) logger.info("editSystem processed");

								if (editCampus.indexOf(",")>-1 || !"1".equals(editCampus)){
									junk = editCampus.split(",");
									editCampus = "";
									for (int z=0;z<junk.length;z++){
										if (!"0".equals(junk[z])){
											if ("".equals(editCampus))
												editCampus = junk[z];
											else
												editCampus = editCampus + "," + junk[z];
										}
									}

									if (editCampus != null && editCampus.length() > 0){

										editCampus = CCCM6100DB.getSequenceFromQuestionNumbers(connection,
																												campus,
																												Constant.TAB_CAMPUS,
																												editCampus,
																												true);
										if (debug) logger.info(""
														+ auditby
														+ " - Enabled campus items for revision: "
														+ editCampus);

										approvalComment = approvalComment
											+ "Revision requested for the following items on <b>"+campus+"</b> tab: "
											+ editCampus
											+ "<br/><br/>";
									}
								} // (editCampus.indexOf(",")>-1 || !"1".equals(editCampus))

								if (debug) logger.info("editCampus processed");

								// clean up
								ParkDB.deleteApproverCommentedItems(connection,kix,user);

								// approve and move on again
								msg = CourseDB.approveOutline(connection,
																		campus,
																		alpha,
																		num,
																		user,
																		false,
																		approvalComment,
																		voteFor,
																		voteAgainst,
																		voteAbstain);

								if (debug) logger.info("CourseDB.approveOutline");

								if (!"Exception".equals(msg.getMsg())){
									String email = UserDB.getUserEmail(connection,user);
									if (email != null && email.length() > 0){

										String modifiedBy = "";

										// depending on what to do with rejected outlines.
										String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(connection,campus);
										if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_FROM_BEGINNING)){
											modifiedBy = proposer;
											message = "Selected items have been enabled for modifications by " + modifiedBy + ".";
										}
										else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_WITH_REJECTER)){
											modifiedBy = proposer;
											message = "Selected items have been enabled for modifications by " + modifiedBy + ".";
										}
										else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_STEP_BACK_ONE)){

											// for taking a step back, find the current sequence then send back to minus 1
											// if current is 1, send back to proposer.
											// if current is 2, determine who in the 1 level should receive.
											// do this by checking whether they started approving already.
											int route = Outlines.getRoute(connection,kix);
											int approverSequence = ApproverDB.getApproverSequence(connection,user,route);
											if (approverSequence>1){
												if (approverSequence==2)
													modifiedBy  = ApproverDB.getHistoryApproverBySeq(connection,campus,alpha,num,1);
												else
													modifiedBy  = ApproverDB.getApproversBySeq(connection,campus,--approverSequence,route);

												message = "Outline revision was returned to " + modifiedBy + ".";
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
									message = "Unable to continue with outline approval.";
								}
							}	// currentAction==APPROVAL

						} else {
							message = "When requesting revision for an outline, you must enable items for the author to modify.<br>"
									+ "Click the browser\'s back button to select items for modifications, or cancel this operation.";
						} // if found course and found campus

						AseUtil.logAction(connection,auditby,"EditFields","Submit",alpha,num,campus,kix);
					}	// moveOn

					break;
			}

			session.setAttribute("aseApplicationMessage", message);

			if (debug) logger.info("EditFieldsServlet - END");

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", message);
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"EditFieldsServlet",auditby);
		}

		if ("Exception".equals(msg.getMsg())) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?nomsg=" + noMsg + "&rtn=" + rtn + "&kix=" + kix);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	 * setItemDependencies - set items dependent on other items on
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	table		int
	 * @param	edits		String
	 * <p>
	 * @return	String
	 */
	public static String setItemDependencies(Connection conn,String campus,String edits){

		//Logger logger = Logger.getLogger("test");

		/*
			1 - [5,4,13,27,28,29]
			2 - [6,4,13,28,29,31,32]
			3 - [7,4,13,28,29]
			4 - [8,4,18,19,20,21,22,28,29]
			5 - [9,4,19,24,25,28,29]
			6 - [10,4,11,28,29]
			7 - [11,4,10]
			8 - [14,28,29]
			9 - [16,28,29]
			10 - [18,4,19,20,21,22,23,28,29,31,32]
			11 - [26,28,29]
		*/

		// with 4
		//edits = "0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,1,2,3,13,73,4,32,0,9,15,0,16,0,18,23,76,75,19,20,24,72,12,37,7,49,0,8,1,0

		// with 16
		//edits = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,16,0,18,23,76,75,19,20,0,0,12,0,7,49,0,8,1,0

		// with 4 & 16
		//edits = "0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,1,2,3,13,73,4,32,0,9,15,0,16,0,18,23,76,75,19,20,24,72,12,37,7,49,0,8,1,0


		// edits comes in like this "0,0,0,0,8,0,0,0,0,55,0,0,0,0,15,0,0,0,0,96,0"
		// numbers not zero are actual question numbers as created in CCCM6100.

		// need to look at dependencies and turn on any other items for modifiction
		//
		// system setting OutlineItemDependencies looks something like this: [2,5,6],[7,8,20]
		//
		// we go through all items and if any grouped item is enabled, we enable all items in the group
		//
		// for example, for grouping 1 (2,5,6), if 2 or 5 or 6 is enabled, then 2, 5, and 6 are all enabled.

		String outlineItemDependencies = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineItemDependencies");

		if(outlineItemDependencies != null && outlineItemDependencies.length() > 0){

			outlineItemDependencies = outlineItemDependencies.replace(" ","");

			// the original edit string (what user selected)
			String[] aSystem = edits.split(",");

			// include comma at the end to help split work properly since we use
			// commas within brackets; example: [1,2,3],[4,5,6]
			// in this scenario, enable items 1, 2, 3, 4, 5, and 6 along
			// with all that has been enabled in edits
			outlineItemDependencies = outlineItemDependencies + ",";

			// break apart grouping into array elements
			String[] enabled = outlineItemDependencies.split("],");

			int table = Constant.TAB_COURSE;
			int maxCourseItems = 0;

			// get the number of questions on the course tab. we use this value
			// to help retrieve the sequence for the item we need to work with
			try{
				maxCourseItems = CourseDB.countCourseQuestions(conn,campus,"Y","",table);
			}
			catch(Exception e){
				maxCourseItems = 0;
			}

			int j = 0;

			int idx = 0;

			for(int i = 0; i <enabled.length ; i++){

				//System.out.println("------------------------");

				try{

					// break apart grouping
					enabled[i] = enabled[i].replace("[","");

					// check each grouping to see if items were enabled
					// if found, then enable all items in grouping
					// one grouping at a time
					String[] dependencies = enabled[i].split(",");

					if(dependencies != null){

						// for each group, start with fresh listing. this makes each group
						// independent of the ones before and after
						String[] grouping = edits.split(",");

						j = 0;

						boolean dependencyFound = false;

						while(j < dependencies.length && dependencyFound == false){

							idx = NumericUtil.getInt(dependencies[j],0);

							// user selected items are by sequence
							// and array elements are 0-based so we adjust here
							if(idx > 0 && !grouping[idx-1].equals(Constant.OFF)){
								//System.out.println("group: " + (i+1) + "; idx: " + idx);
								dependencyFound = true;
							} // valid idx

							++j;

						} // while j

						// if item in grouping found, enable all other items in group
						if(dependencyFound){

							for(j = 0; j < dependencies.length; j++){
								// get the item or sequence and retrieve the
								// actual question number to enable
								idx = NumericUtil.getInt(dependencies[j],0);

								int seq = idx;

								if (idx < maxCourseItems){
									table = Constant.TAB_COURSE;
								}
								else{
									// when on campus tab, subtract to
									// realign seq based on number of items on tab
									// for example if the array element is 23
									// and course tab has 21, then the seq on
									// campus is 2
									table = Constant.TAB_CAMPUS;
									seq = seq - maxCourseItems;
								}

								int questionNumber = QuestionDB.getQuestionNumber(conn,campus,table,seq);

								aSystem[idx-1] = "" + questionNumber;

								//System.out.println("dep: " + j + "; s: " + seq + "; q: " + questionNumber);

							} // for j

						} // dependencyFound


					} // dependencies

				}
				catch(ArrayIndexOutOfBoundsException e){
					logger.fatal("EditFieldServlet.outlineItemDependencies: " + e.toString());
				}
				catch(Exception e){
					logger.fatal("EditFieldServlet.outlineItemDependencies: " + e.toString());
				}

			} // for i

			// put enabled items back into string
			edits = "";
			for(j=0; j<aSystem.length; j++){

				if(j==0){
					edits = aSystem[j];
				}
				else{
					edits = edits + "," + aSystem[j];
				}

			} // j

		} // outlineItemDependencies

		return edits;

	}

	/**
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}