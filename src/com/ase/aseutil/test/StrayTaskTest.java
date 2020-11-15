/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.test;

import com.test.aseutil.*;

import com.ase.aseutil.*;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import junit.framework.TestCase;
import junit.framework.TestSuite;

public class StrayTaskTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(StrayTaskTest.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 StrayTaskTest(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void StrayTaskTest(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean success = false;

		try{
			if (getConnection() != null){

				logger.info("\tStrayTaskTest started...");

				removeStrayTasks(getConnection(),getCampus());

				success = true;

				logger.info("\tStrayTaskTest ended...");

			}
		}
		catch( Exception e ){
			logger.fatal("StrayTaskTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

	/*
	 * removeStrayTasks
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	void
	 */
	public static void removeStrayTasks(Connection conn,String campus) {

		try{
			com.ase.aseutil.GenericDB.clearTable(conn);

			String sql = "";
			PreparedStatement ps = null;

			if(campus == null || campus.length() == 0){
				sql = "SELECT campus,userid FROM tblusers WHERE status='active' ORDER BY campus,userid";
				ps = conn.prepareStatement(sql);
			}
			else{
				sql = "SELECT campus,userid FROM tblusers WHERE campus=? AND status='active' ORDER BY campus,userid";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				String user = AseUtil.nullToBlank(rs.getString("userid"));

				campus = AseUtil.nullToBlank(rs.getString("campus"));

				removeStrayTasks(conn,campus,user);

			} // while
			rs.close();
			ps.close();
		}
		catch( Exception e ){
			System.out.println(e.toString());
		}

	}

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

		boolean programExistByTypeCampus = false;
		boolean courseExistByTypeCampus = false;

		String today = (new SimpleDateFormat("MM/dd/yyyy")).format(new java.util.Date());
		String reviewDate = "";
		String subprogress = "";
		String taskType = "";

		// stray tasks are tasks not found with corresponding coures work
		try{
			debug = DebugDB.getDebug(conn,"TaskDB");

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

				programExistByTypeCampus = ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR");

				courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");

				subprogress = Outlines.getSubProgress(conn,kix);

				// set to proper type for task progress
				type = "PRE";
				String[] taskText = TaskDB.getTaskMenuText(conn,message,campus,alpha,num,type,kix);
				taskProgress = taskText[Constant.TASK_PROGRESS];

				// review date
				if (!category.equals(Constant.PROGRAM) && message.toLowerCase().indexOf("review") > -1){
					reviewDate = CourseDB.getCourseItem(conn,kix,"reviewdate");
				}

				// get current progress from outline/program
				if (category.equals(Constant.PROGRAM)){
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

String rules = (isAProgram + "_" + taskProgress + "_" + outlineProgress + "_" + message).toLowerCase().replace(" ","_");

				if (isAProgram){

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

							if(TaskDB.pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
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
				else{

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
					else if (taskProgress.toLowerCase().indexOf("approv") > -1){
						if (message.toLowerCase().equals("approve cross listing")){

							if(TaskDB.pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
								delete = true;
								reason = "pending cross listing approval task not available";
								outlineProgressStep = "step: 140";
							}
							else{
								outlineProgressStep = "*** 1400";
							}

						}
						else if (message.toLowerCase().equals("approve added requisite")){

							if(TaskDB.pendingApprovalCount(conn,campus,user,kix,alpha,num,message) == 0){
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
							outlineProgressStep = "*** 1600";
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
				if (!delete){
					if (!isAProgram){
						if (message.toLowerCase().indexOf("approv") > -1){

							if(
									message.toLowerCase().equals("approve added program") ||
									message.toLowerCase().equals("approve cross listing") ||
									message.toLowerCase().equals("approve added requisite")
								){
									// these approval types does not affect the outline progress
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
					} // !isAProgram
				} // !delete

				//--------------------------------------------------------
				// save to database
				// outlineProgressStep with *** are those considered valid and not deleted
				//--------------------------------------------------------
				com.ase.aseutil.GenericDB.insertStrings(conn,
																		new Generic(campus,
																						user,
																						kix,
																						alpha,
																						num,
																						message,
																						rules,
																						outlineProgressStep,
																						""+delete,
																						""
																					));

				//
				// let's delete the stray
				//

//--------------------------------------------------------
// we don't actually want to delete. just a test run
//--------------------------------------------------------
delete = false;

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
						else{
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

						// if we were unable to remove the task, use ID instead
						if (rowsAffected == 0){
							rowsAffected = TaskDB.deleteTaskByID(conn,id);
						}

					} // run
				} // delete

			}	// while
			rs.close();
			ps.close();

		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayTasks - " + ex.toString());
		}
	} // removeStrayTasks

}