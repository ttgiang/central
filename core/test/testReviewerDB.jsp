<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ACC";
	String num = "132";
	String type = "PRE";
	String user = "KOMENAKA";
	String task = "Modify_outline";
	String kix = "L29j28k1018";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	int item = 1;
	int seq = 1;
	String source = "1";
	String acktion = "a";
	String hid = kix;

	out.println("Start<br/>");

	if (processPage){
		try{

			boolean classTest = false;

			if (classTest){
				out.println("<br>" + ReviewerDB.getReviewHistory(conn,kix,item,campus,0,1));
				out.println("<br>" + ReviewerDB.getReviewHistory2(conn,hid,item,campus,0,1));
				out.println("<br>" + ReviewerDB.countReviewerComments(conn,kix,1,1,1));
				out.println("<br>" + ReviewerDB.countReviewerComments2(conn,kix,1,1,1));
				out.println("<br>" + ReviewerDB.countReviewerCommentsBySeq(conn,kix,1,1,1));
				out.println("<br>" + ReviewerDB.createSQL("",1,1,1));
				out.println("<br>" + ReviewerDB.getReviewerNames(conn,campus,alpha,num));
				out.println("<br>" + ReviewerDB.getAllReviewHistory(conn,hid,campus,1));
				out.println("<br>" + ReviewerDB.getCampusReviewUsers(conn,campus,campus,alpha,num,user));
				out.println("<br>" + ReviewerDB.getCampusReviewUsers2(conn,campus,campus,alpha,num,user));
				out.println("<br>" + ReviewerDB.getCourseReviewers(conn,campus,alpha,num));
				out.println("<br>" + ReviewerDB.addCourseReviewer(conn,campus,alpha,num,"THANHG"));
				out.println("<br>" + ReviewerDB.reviewerCommentsExists(conn,campus,kix,1,1));
				out.println("<br>" + ReviewerDB.getReviewsForEdit(conn,kix,user,1,1,1));
				out.println("<br>" + ReviewerDB.getReviewsForEdit2(conn,kix,user,1,1,1,false,false));
				out.println("<br>" + ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user));
				out.println("<br>" + ReviewerDB.getComment(conn,campus,kix,1));
				out.println("<br>" + ReviewerDB.getReview(conn,campus,kix,1));
				out.println("<br>" + ReviewerDB.isReviewer(conn,kix,user));
				out.println("<br>" + ReviewerDB.deleteReviewers(conn,campus,alpha,num,true));
				out.println("<br>" + ReviewerDB.hasReviewer(conn,campus,alpha,num));
				out.println("<br>" + ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,"THANHG,HOTTA",AseUtil.getCurrentDateTimeString()));
				out.println("<br>" + ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,"THANHG,HOTTA",AseUtil.getCurrentDateTimeString(),"comments"));
			} // classTest


			out.println(setCourseReviewers(conn,
													campus,
													alpha,
													num,
													user,
													"",
													aseUtil.getCurrentDateTimeString(),
													"comments",
													kix));

		}
		catch(Exception ce){
			//if (debug) System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate,
															String comments,
															String kix) throws Exception {

Logger logger = Logger.getLogger("test");

		boolean debug = false;
		boolean rtrn = false;
		boolean isAProgram = false;
		boolean mayKickOffReview = false;

		String temp = "";
		String dist = "";
		String type = "PRE";

		PreparedStatement ps;
		String sql = "";
		String toEmail = "";
		String inviter = "";
		String currentReviewers = "";
		String progress = "REVIEW";
		String approvalText = "";
		String modifyText = "";
		String modifyProposedText = "";
		String modifyApprovedText = "";
		String reviewText = "";
		String createTaskText = "";
		String reviewTaskText = "";
		String category = "";
		int rowsAffected;
		int i = 0;
		Msg msg = null;

		String thisProgress = "";		// progress of the outline or program

		if (kix == null || kix.length() == 0)
			kix = Helper.getKix(conn,campus,alpha,num,type);

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if (debug) logger.info("---------------------------- setCourseReviewers - START");

			isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

			if (isAProgram){
				category = Constant.PROGRAM;
				createTaskText = Constant.PROGRAM_CREATE_TEXT;
				modifyText = Constant.PROGRAM_MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_PROGRAM;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_PROGRAM;
				approvalText = Constant.PROGRAM_APPROVAL_TEXT;
				reviewText = Constant.PROGRAM_REVIEW_PROGRESS;
				reviewTaskText = Constant.PROGRAM_REVIEW_TEXT;
			}
			else{
				category = Constant.COURSE;
				createTaskText = "";
				modifyText = Constant.MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_OUTLINE;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_OUTLINE;
				approvalText = Constant.APPROVAL_TEXT;
				reviewText = Constant.COURSE_REVIEW_TEXT;
				reviewTaskText = Constant.REVIEW_TEXT;
			}

			if (debug) logger.info("kix: " + kix);
			if (debug) logger.info("user: " + user);
			if (debug) logger.info("isAProgram: " + isAProgram);
			if (debug) logger.info("modifyText: " + modifyText);
			if (debug) logger.info("approvalText: " + approvalText);
			if (debug) logger.info("reviewText: " + reviewText);
			if (debug) logger.info("reviewTaskText: " + reviewTaskText);
			if (debug) logger.info("alpha: " + alpha);
			if (debug) logger.info("num: " + num);

			// when arriving here with no data for reviewers and date, this means that
			// the user have removed all remaining reviewers from the list to review.
			// being so, this means there is no one left to review so we should
			// clear the table and reset the course to modify state. This would
			// be the same as someone clicking 'I'm finished' and completing the process.
			if ((Constant.BLANK).equals(reviewers) && (Constant.BLANK).equals(reviewDate)){
				ReviewerDB.deleteReviewers(conn,campus,alpha,num,true);

				if (isAProgram)
					msg = ProgramsDB.endReviewerTask(conn,campus,kix,user);
				else
					msg = CourseDB.endReviewerTask(conn,campus,alpha,num,user);

				rtrn = true;
				AseUtil.loggerInfo("ReviewerDB: setCourseReviewers ",campus,user,alpha, num);
			}
			else{
				sql = "INSERT INTO tblReviewers (coursealpha,coursenum,userid,campus,historyid) VALUES(?,?,?,?,?)";

				/*
					assign task and add users

					1) Get list of current users
					2) Don't send to anyone already on the list
					3) Delete names removed from list
					4) Remove modify outline task from proposer
				*/
				if (debug) logger.info("reviewers: " + reviewers);

				if (isAProgram)
					thisProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				else
					thisProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

				if (debug) logger.info("thisProgress: " + thisProgress);

				inviter = user;

				//get list of current reviewers and remove them
				if (isAProgram)
					currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,kix);
				else
					currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,alpha,num);

				//remove existing reviewers
				if (currentReviewers != null && !(Constant.BLANK).equals(currentReviewers)){
					sql = "DELETE "
							+ "FROM tblReviewers "
							+ "WHERE campus=? "
							+ "AND coursealpha=? "
							+ "AND coursenum=? "
							+ "AND historyid=? "
							+ "AND userid=?";
					String[] removal = new String[100];
					removal = currentReviewers.split(",");
					for (i=0; i<removal.length; i++) {
						rowsAffected = TaskDB.logTask(conn,
																removal[i],
																user,
																alpha,
																num,
																reviewTaskText,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,kix);
						ps.setString(5,removal[i]);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("task removed for: " + removal[i]);
					} // for
				}	// if currentReviewers
				if (debug) logger.info("current reviewers removed: " + currentReviewers);

				// if there are reviewers to add, process here
				if (reviewers != null && reviewers.length() > 0) {

					// distribution list? If yes, go through each item and get the list
					// of names. use substring to extract value without starting and ending
					// characters of []. combine the list into 'dist' to get a new list
					// for processing
					String[] tasks = new String[100];
					tasks = reviewers.split(",");
					for (i=0; i<tasks.length; i++) {
						temp = tasks[i];
						temp = temp.replace("[","");
						temp = temp.replace("]","");
						temp = EmailListsDB.getEmailListMembers(conn,campus,user,temp);

						if (temp != null && temp.length() > 0){
							if ("".equals(dist))
								dist = temp;
							else
								dist = dist + "," + temp;
						}
					}	// for

					// dist contains all reviewers just entered and currentReviewers are those
					// already saved in the system. combine for a complete list.
					reviewers = dist;
					if (debug) logger.info("distribution: " + dist);

					reviewers = Util.removeDuplicateFromString(reviewers);

					// after cleaning up duplicate names, remove extra commas in the middle,
					// the comma in the front and the one at the end
					while(reviewers.indexOf(",,") > -1)
						reviewers = reviewers.replaceAll(",,",",");

					if (debug) logger.info("non duplicates: " + reviewers);

					// insert into task table
					sql = "INSERT INTO tblReviewers (coursealpha,coursenum,userid,campus,historyid) VALUES(?,?,?,?,?)";
					tasks = reviewers.split(",");
					for (i=0; i<tasks.length; i++) {
						rowsAffected = TaskDB.logTask(conn,
																tasks[i],
																user,
																alpha,
																num,
																reviewTaskText,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																inviter,
																Constant.TASK_REVIEWER,
																kix,
																category);
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
						ps.setString(3,tasks[i]);
						ps.setString(4,campus);
						ps.setString(5,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("creating task for " + tasks[i]);
					} // for
					if (debug) logger.info("tasks created");

					// greater than 2 because it's possible to have a single comma after removing dups
					if (!(Constant.BLANK).equals(reviewers) && reviewers.length() > 2){
						// park this entry temporarily so that we can grab the content for mailing to reviewers
						String reason = "Proposer comments:<br/><br/>"
											+ comments
											+ ". <br/><br/>Review requested by: "
											+ reviewDate;
						sql = "INSERT INTO tblMisc(campus,historyid,coursealpha,coursenum,coursetype,descr,val,userid) VALUES(?,?,?,?,?,?,?,?)";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,alpha);
						ps.setString(4,num);
						ps.setString(5,Constant.PRE);
						ps.setString(6,reviewText);
						ps.setString(7,reason);
						ps.setString(8,user);
						rowsAffected = ps.executeUpdate();

						MailerDB mailerDB = new MailerDB(conn,
																	user,
																	reviewers,
																	Constant.BLANK,
																	Constant.BLANK,
																	alpha,
																	num,
																	campus,
																	"emailReviewerInvite",
																	kix,
																	user);
						if (debug) logger.info("sending mail using emailReviewerInvite bundle for " + kix);
					} // reviewers.length() > 2

				} // if reviewers

				// progress must be APPROVAL for next check
				if (thisProgress != null && ((Constant.COURSE_APPROVAL_TEXT).equals(thisProgress) || (Constant.PROGRAM_APPROVAL_PROGRESS).equals(thisProgress)))
					mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,null);

				if (debug) logger.info("mayKickOffReview: " + mayKickOffReview);

				if(mayKickOffReview)
					progress="APPROVAL";

				// ttg-review
				//sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
				//sql = "UPDATE tblCourse SET edit=0,edit0='',progress=?,reviewdate=? "
				// set course to review only status
				if (isAProgram){
					sql = "UPDATE tblPrograms SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
							+ "WHERE campus=? "
							+ "AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,progress);
					ps.setString(2,reviewDate);
					ps.setString(3,campus);
					ps.setString(4,kix);
				}
				else{
					sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
							+ "WHERE campus=? AND "
							+ "coursealpha=? AND "
							+ "coursenum=? AND "
							+ "coursetype='PRE'";
					ps = conn.prepareStatement(sql);
					ps.setString(1,progress);
					ps.setString(2,reviewDate);
					ps.setString(3,campus);
					ps.setString(4,alpha);
					ps.setString(5,num);
				}
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("update status to " + progress);

				// update comments to show review information
				// String reason = "Outline review sent to " + reviewers + ". Review requested by: " + reviewDate;
				// Outlines.updateReason(conn,kix,reason,user);

				// set appropriate outline progress and remove tasks for current approvers
				if(mayKickOffReview){
					Outlines.setSubProgress(conn,kix,Constant.COURSE_REVIEW_IN_APPROVAL);

					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															approvalText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("approver approval task removed " + rowsAffected + " row");

					// also remove the delegate
					String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
					int route = Integer.parseInt(info[1]);
					String delegateName = ApproverDB.getDelegateByApproverName(conn,campus,user,route);
					rowsAffected = TaskDB.logTask(conn,
															delegateName,
															delegateName,
															alpha,
															num,
															approvalText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("delegate approval task removed " + rowsAffected + " row");

					AseUtil.loggerInfo("ReviewerDB: Outlines.setSubProgress ",campus,user,alpha, num);
				} // mayKickOffReview

				// remove task from proposer
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														modifyText,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
				if (debug) logger.info("proposer task removed " + rowsAffected + " row");

				// remove task from proposer
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														modifyProposedText,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
				if (debug) logger.info("proposed task removed " + rowsAffected + " row");

				// remove task from proposer
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														modifyApprovedText,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
				if (debug) logger.info("approved task removed " + rowsAffected + " row");

				// remove create task
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														createTaskText,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
				if (debug) logger.info("approved task removed " + rowsAffected + " row");

				rtrn = true;

				AseUtil.logAction(conn,user,"ACTION","Request outline review ("+ reviewers + ")",alpha,num,campus,kix);

			} // else blank reviewers

			if (debug) logger.info("---------------------------- setCourseReviewers - END");

		} catch (Exception e) {
			logger.fatal(" " + e.toString());
			rtrn = false;
		}

		if (debug) logger.info("----------------------------");

		return rtrn;
	} // setCourseReviewers


%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>