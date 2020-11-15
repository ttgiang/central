<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "GG";
	String num = "101A";
	String type = "ARC";
	String user = "ACOSTA";
	String task = "Modify_outline";
	String kix = "g17g21l12174";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			//out.println(checkOutLineDates(conn,"enddate")+Html.BR());
			//out.println(checkOutLineDates(conn,"reviewdate")+Html.BR());
			//out.println(checkOutLineDates(conn,"experimentaldate")+Html.BR());

//ApproverDB.setApprovalRouting(conn,campus,alpha,num,1315);
//out.println(setCourseForApprovalX(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,user));

//runReport(request,response);

//setCourseReviewers(conn,campus,alpha,num,"THANHG","THANHG,ACOSTA","11/30/2012","COMMENTS",kix,0);

			/*

			kix = "G52a8c9139538";
			if(kix != null && kix.length() > 0){

				String[] info = helper.getKixInfo(conn,kix);
				String kalpha = info[Constant.KIX_ALPHA];
				String knum = info[Constant.KIX_NUM];
				String ktype = info[Constant.KIX_TYPE];
				String kcampus = info[Constant.KIX_CAMPUS];

				// move entry to archived table
				if(kcampus.equals("LEE") && kalpha.equals("ART") && knum.equals("116")){
					com.ase.aseutil.CourseCurrentToArchive cca = new com.ase.aseutil.CourseCurrentToArchive();
					msg = cca.moveCurrentToArchived(conn,kcampus,kalpha,knum,user);
					cca = null;

					out.println("Msg: " + aseUtil.nullToBlank(msg.getErrorLog()) + Html.BR() + Html.BR());
				}
			}

			*/


		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

// review in review work

	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate,
															String comments,
															String kix,
															int level) throws Exception {

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

		String deleteText = "";
		String deleteProposedText = "";
		String deleteApprovedText = "";

		String reviewText = "";
		String reviewDescr = "";
		String createTaskText = "";
		String reviewTaskText = "";
		String category = "";

		String taskCategory = "";

		int rowsAffected;
		int i = 0;
		Msg msg = null;

		String thisProgress = "";		// progress of the outline or program

		// review within review
		if(level == 0){
			level = 1;
		}

		String reviewerProgress = Constant.COURSE_REVIEW_TEXT;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

debug = true;

			if (debug) logger.info("------------------- setCourseReviewers - START");

			if (kix == null || kix.length() == 0){
				kix = Helper.getKix(conn,campus,alpha,num,type);
			}

			isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

			if (isAProgram){
				category = Constant.PROGRAM;
				taskCategory = Constant.PROGRAM;

				createTaskText = Constant.PROGRAM_CREATE_TEXT;

				modifyText = Constant.PROGRAM_MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_PROGRAM;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_PROGRAM;

				approvalText = Constant.PROGRAM_APPROVAL_TEXT;

				deleteText = Constant.PROGRAM_DELETE_TEXT;
				deleteProposedText = Constant.TASK_DELETE_PROPOSED_PROGRAM;
				deleteApprovedText = Constant.TASK_DELETE_APPROVED_PROGRAM;

				reviewText = Constant.PROGRAM_REVIEW_PROGRESS;
				reviewDescr = Constant.PROGRAM_MODIFICATION;
				reviewTaskText = Constant.PROGRAM_REVIEW_TEXT;

				thisProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,kix,user,level);

				reviewerProgress = Constant.PROGRAM_REVIEW_PROGRESS;
			}
			else{
				category = Constant.COURSE;
				taskCategory = "";

				createTaskText = "";

				modifyText = Constant.MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_OUTLINE;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_OUTLINE;

				approvalText = Constant.APPROVAL_TEXT;

				deleteText = Constant.DELETE_TEXT;
				deleteProposedText = Constant.TASK_DELETE_PROPOSED_OUTLINE;
				deleteApprovedText = Constant.TASK_DELETE_APPROVED_OUTLINE;

				reviewText = Constant.COURSE_REVIEW_TEXT;
				reviewDescr = Constant.OUTLINE_MODIFICATION;
				reviewTaskText = Constant.REVIEW_TEXT;

				thisProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);
				currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,alpha,num,user,level);

				reviewerProgress = Constant.COURSE_REVIEW_TEXT;
			}

			String proposer = CourseDB.getCourseItem(conn,kix,"proposer");

			if (debug){
				logger.info("kix: " + kix);
				logger.info("user: " + user);
				logger.info("proposer: " + proposer);
				logger.info("isAProgram: " + isAProgram);

				logger.info("modifyText: " + modifyText);
				logger.info("modifyProposedText: " + modifyProposedText);
				logger.info("modifyApprovedText: " + modifyApprovedText);

				logger.info("deleteText: " + deleteText);
				logger.info("deleteProposedText: " + deleteProposedText);
				logger.info("deleteApprovedText: " + deleteApprovedText);

				logger.info("approvalText: " + approvalText);

				logger.info("reviewText: " + reviewText);
				logger.info("reviewDescr: " + reviewDescr);
				logger.info("reviewTaskText: " + reviewTaskText);

				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("thisProgress: " + thisProgress);
				logger.info("reviewers: " + reviewers);
				logger.info("reviewDate: " + reviewDate);

				logger.info("level: " + level);
				logger.info("progress: " + progress);
			}

			// when arriving here with no data for reviewers and date, this means that
			// the user have removed all remaining reviewers from the list to review.
			// being so, this means there is no one left to review so we should
			// clear the table and reset the course to modify state. This would
			// be the same as someone clicking 'I'm finished' and completing the process.
			if (reviewers.equals(Constant.BLANK) && reviewDate.equals(Constant.BLANK)){
ReviewerDB.deleteReviewers(conn,campus,alpha,num,true,user,level);

				if (isAProgram)
					msg = ProgramsDB.endReviewerTask(conn,campus,kix,user);
				else
					msg = CourseDB.endReviewerTask(conn,campus,alpha,num,user);

				rtrn = true;

				AseUtil.loggerInfo("ReviewerDB: setCourseReviewers ",campus,user,alpha, num);
			}
			else{
				//
				//	assign task and add users
				//
				//	1) Get list of current users
				//	2) Don't send to anyone already on the list
				//	3) Delete names removed from list
				//	4) Remove modify outline task from proposer
				//
				inviter = user;

				//
				// remove existing reviewers at level 1 only. these are reviewers invited by the proposer (level = 1)
				//
				if (currentReviewers != null && !currentReviewers.equals(Constant.BLANK)){
					sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND historyid=? AND userid=? and level=?";
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
						ps.setInt(6,level);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("task removed for: " + removal[i]);

						AseUtil.logAction(conn,
												user,
												Constant.TASK_REMOVE,
												"review task removed for: " + removal[i],
												alpha,
												num,
												campus,
												kix);
					} // for

					if (debug) logger.info("current reviewers removed: " + currentReviewers);

				}	// if currentReviewers

				//--------------------------------------------------
				// progress must be APPROVAL for next check
				//--------------------------------------------------
				if (thisProgress != null &&
					(	thisProgress.equals(Constant.COURSE_APPROVAL_TEXT) ||
						thisProgress.equals(Constant.COURSE_DELETE_TEXT) ||
						thisProgress.equals(Constant.PROGRAM_APPROVAL_PROGRESS))){
mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,null);
				}
				if (debug) logger.info("mayKickOffReview: " + mayKickOffReview);

				if(mayKickOffReview){
					if (thisProgress.equals(Constant.COURSE_DELETE_TEXT)){
						progress = Constant.COURSE_DELETE_TEXT;
					}
					else{
						progress = Constant.COURSE_APPROVAL_TEXT;
					}
				}

				//--------------------------------------------------
				// if there are reviewers to add, process here
				//--------------------------------------------------
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
							if (dist.equals(""))
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
					while(reviewers.indexOf(",,") > -1){
						reviewers = reviewers.replaceAll(",,",",");
					}

					if (debug) logger.info("non duplicates: " + reviewers);

					//
					// set progress for review table. default is REVIEW for proposer
					//
					reviewerProgress = Constant.COURSE_REVIEW_TEXT;

					if(thisProgress.equals(Constant.COURSE_APPROVAL_TEXT) ||
						thisProgress.equals(Constant.COURSE_DELETE_TEXT) ||
						thisProgress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)){

						//
						// if review is requested by approver, then we are review in approval
						//
						reviewerProgress = Constant.COURSE_REVIEW_IN_APPROVAL;

					}

					//
					// set the review progress properly for REVIEW_IN_REVIEW
					//
					if(level > 1){
						reviewerProgress = Constant.COURSE_REVIEW_IN_REVIEW;
					}

					//
					// insert into task table
					//
					sql = "INSERT INTO tblReviewers (coursealpha,coursenum,userid,campus,historyid,inviter,level,progress,duedate) VALUES(?,?,?,?,?,?,?,?,?)";
					tasks = reviewers.split(",");
					for (i=0; i<tasks.length; i++) {
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
						ps.setString(3,tasks[i]);
						ps.setString(4,campus);
						ps.setString(5,kix);
						ps.setString(6,user);
						ps.setInt(7,level);
						ps.setString(8,reviewerProgress);
						ps.setString(9,reviewDate);

						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("creating task for " + tasks[i]);

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

						AseUtil.logAction(conn,user,"ACTION","review task added for: " + tasks[i],alpha,num,campus,kix);

					} // for
					if (debug){
						logger.info("tasks created");
						logger.info("reviewers.length: " + reviewers.length());
					}

					// greater than 2 because it's possible to have a single comma after removing dups
					if (!reviewers.equals(Constant.BLANK) && reviewers.length() > 2){
						// park this entry temporarily so that we can grab the content for mailing to reviewers
						String reason = "Proposer comments:<br/><br/>"
											+ comments
											+ ". <br/><br/>Review requested by: "
											+ reviewDate;

						rowsAffected = MiscDB.insertMisc(conn,campus,kix,alpha,num,Constant.PRE,"emailReviewerInvite",reason,user);

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

				//----------------------------------------------------------------------------
				// FORUM
				//----------------------------------------------------------------------------
				String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
				if (enableMessageBoard.equals(Constant.ON)){
					if(ForumDB.getForumID(conn,campus,kix) == 0){

						// create the new forum and add proposer to access
						int fid = ForumDB.createMessageBoard(conn,campus,user,kix);
						if(fid > 0){
							Board.addBoardMember(conn,fid,user);
						}
					}
					else{
						//
						// ER18 - if the forum was previoused closed and review is starting
						ForumDB.openForum(conn,campus,user,kix);

						// ER18 - end any pending notification to proposer
						ForumDB.setNotified(conn,user,ForumDB.getForumID(conn,kix),Constant.ON);

						// ER18 - end any open editing started by proposer
						Board.endReviewProcess(conn,campus,kix,user);
					} // forum
				} // board is enabled

				//----------------------------------------------------------------------------
				// set course to review only status
				//----------------------------------------------------------------------------
				if (isAProgram){
					sql = "UPDATE tblPrograms SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
							+ "WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,progress);
					ps.setString(2,reviewDate);
					ps.setString(3,campus);
					ps.setString(4,kix);
				}
				else{
					if (thisProgress.equals(Constant.COURSE_DELETE_TEXT)){
						sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=?,subprogress=? "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
						ps = conn.prepareStatement(sql);
						ps.setString(1,progress);
						ps.setString(2,reviewDate);
						ps.setString(3,Constant.COURSE_REVIEW_IN_DELETE);
						ps.setString(4,campus);
						ps.setString(5,alpha);
						ps.setString(6,num);
					}
					else{
						sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
						ps = conn.prepareStatement(sql);
						ps.setString(1,progress);
						ps.setString(2,reviewDate);
						ps.setString(3,campus);
						ps.setString(4,alpha);
						ps.setString(5,num);
					}
				}
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("update status to " + progress);

				// update comments to show review information
				// String reason = "Outline review sent to " + reviewers + ". Review requested by: " + reviewDate;
				// Outlines.updateReason(conn,kix,reason,user);

				// set appropriate outline progress and remove tasks for current approvers
				if(mayKickOffReview){

					if (isAProgram){
						ProgramsDB.setSubProgress(conn,kix,Constant.PROGRAM_REVIEW_IN_APPROVAL);
					}
					else{
						Outlines.setSubProgress(conn,kix,Constant.COURSE_REVIEW_IN_APPROVAL);
					}

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

					if (debug) AseUtil.loggerInfo("ReviewerDB: Outlines.setSubProgress ",campus,user,alpha, num);
				} // mayKickOffReview

				//
				// remove task from proposer. for REVIEW_IN_REVIEW, we don't bother with this section
				//
				if(user.equals(proposer)){
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);
					if (debug) System.out.println("proposer task removed ("+modifyText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyProposedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("proposed task removed ("+modifyProposedText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyApprovedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("approved task removed ("+modifyApprovedText+") " + rowsAffected + " row");

					// remove create task
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,createTaskText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("approved task removed ("+createTaskText+") " + rowsAffected + " row");

					// remove delete task
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("proposer task removed ("+deleteText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteProposedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("proposed task removed ("+deleteProposedText+") " + rowsAffected + " row");

					// remove task from proposer
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteApprovedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) System.out.println("approved task removed ("+deleteApprovedText+") " + rowsAffected + " row");

				} // remove task from proposer

				rtrn = true;

				AseUtil.logAction(conn,user,"ADD","Request outline review ("+ reviewers + ")",alpha,num,campus,kix);

			} // else blank reviewers

			if (debug) logger.info("------------------- setCourseReviewers - END");

		} catch (Exception e) {
			logger.fatal(" " + e.toString());
			rtrn = false;
		}

		return rtrn;
	} // setCourseReviewers

////

	private static Msg setCourseForApprovalX(Connection conn,
														String campus,
														String alpha,
														String num,
														String proposer,
														String mode,
														String user) throws Exception {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		int lastSequence = 0;
		int nextSequence = 1;
		int numberOfApproversThisSequence = 0;

		String lastApprover = "";
		String nextApprover = "";

		String lastDelegate = "";
		String nextDelegate = "";

		String completeList = "";

		String sql = "";

		boolean approvalCompleted = false;

		Approver approver = new Approver();
		boolean approved = false;
		boolean experimental = false;
		PreparedStatement ps = null;

		long count = 0;

		String packetApproval = "";

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);
		info = null;

		boolean deleteApproval = false;

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"CourseDB");

debug = true;

			if (debug) logger.info("-------------------- CourseDB - setCourseForApproval START");

			packetApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

			// for courses going through deletion as packets, we need to adjust
			// data before moving on here. data for the course was adjusted when
			// the approval process began
			if(kix != null && packetApproval.equals(Constant.ON)){

				info = Helper.getKixInfo(conn,kix);
				String progress = info[Constant.KIX_PROGRESS];
				String subprogress = info[Constant.KIX_SUBPROGRESS];
				info = null;

				if(progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT) && subprogress.equals(Constant.COURSE_DELETE_TEXT) ){

					deleteApproval = true;

					sql = "UPDATE tblcourse SET progress=?,subprogress='' WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,Constant.COURSE_DELETE_TEXT);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					mode = Constant.COURSE_DELETE_TEXT;
				}

				progress = "";
				subprogress = "";
				sql = "";

			} // kix and packetApproval

			String taskText = "";
			if (mode.equals(Constant.COURSE_DELETE_TEXT)){
				taskText = Constant.DELETE_TEXT;
			}
			else{
				taskText = Constant.APPROVAL_TEXT;
			}

			experimental = Outlines.isExperimental(num);

			//----------------------------------------------------------------------------
			// FORUM
			//----------------------------------------------------------------------------
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				if(ForumDB.getForumID(conn,campus,kix) == 0){
					// create the new forum and add proposer to access
					int fid = ForumDB.createMessageBoard(conn,campus,user,kix);
					if(fid > 0){
						Board.addBoardMember(conn,fid,user);
					}
				}
			} // board is enabled

			// get list of names. if approved, find next, else resend
			approver = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
			if (debug){
				logger.info("experimental: " + experimental);
				logger.info("route: " + route);
				logger.info("packetApproval: " + packetApproval);
				//logger.info("approver: " + approver);
			} // debug

			if (approver != null){
				// break into array
				String[] approvers = new String[20];
				approvers = approver.getAllApprovers().split(",");

				String[] delegates = new String[20];
				delegates = approver.getAllDelegates().split(",");

				completeList = approver.getAllCompleteList();

				if (debug){
					logger.info("approvers: " + approver.getAllApprovers());
					logger.info("delegates: " + approver.getAllDelegates());
					logger.info("completeList: " + approver.getAllCompleteList());
				}

				// if nothing is in history, send mail to first up else who's next
				// get max sequence and determine who was last
				// if last approved, send to next; if last reject, resend
				count = ApproverDB.countApprovalHistory(conn,kix);
				if (count == 0){
					if (debug) logger.info("countApprovalHistory count is 0 or no one started");

					lastSequence = 1;
					nextSequence = 1;
					approved = false;

					numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,lastSequence,route);
					String ApprovalSubmissionAsPackets = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

					// when only a single approver at sequence 1, use it
					if (numberOfApproversThisSequence == 1){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("only 1 approver this sequence");
					}
					else if (numberOfApproversThisSequence > 1 && ApprovalSubmissionAsPackets.equals(Constant.ON)){
						// at start up, if this is the first person then check for department chair
						// if the chair is there, then get the delegate
						nextApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
						if (nextApprover != null && nextApprover.length() > 0){
							nextDelegate = ChairProgramsDB.getDelegatedName(conn,campus,alpha);
							if (debug) logger.info("department chair found - " + nextApprover + "/" + nextDelegate);
						}
					} // numberOfApproversThisSequence

					// however, if department chair not set up, use approver sequence
					if (nextApprover == null || nextApprover.length() == 0){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("department chair not found");
					}

					lastApprover = nextApprover;
					lastDelegate = nextDelegate;

					// TrackItemChanges
					Outlines.trackItemChanges(conn,campus,kix,user);
				}
				else{
					sql = "SELECT approver,approved " +
						"FROM tblApprovalHist WHERE seq IN " +
						"(SELECT MAX(seq) AS Expr1 FROM tblApprovalHist WHERE historyid=?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						lastApprover = AseUtil.nullToBlank(rs.getString("approver"));
						approved = rs.getBoolean("approved");
						lastSequence = ApproverDB.getApproverSequence(conn,lastApprover,route);
						if (debug) logger.info("lastSequence: " + lastSequence);
					}
					rs.close();
					ps.close();
				}	// if count

				numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);

				// if approved and not the last person, get next; else where do we go back to
				if (approved){
					if (debug) logger.info("approved");

					if (!lastApprover.equals(approvers[approvers.length-1])){
						nextSequence = lastSequence + 1;

						// adjust for 0th based array
						nextApprover = approvers[--nextSequence];

						approvalCompleted = false;
					}
					else
						approvalCompleted = true;
				}
				else{
					if (debug) logger.info("not approved");

					String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
					if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_WITH_REJECTER)){
						if (debug) logger.info("Constant.REJECT_START_WITH_REJECTER");
						nextApprover = lastApprover;
						nextDelegate = lastDelegate;
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_FROM_BEGINNING)){
						if (debug) logger.info("Constant.REJECT_START_FROM_BEGINNING");
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_STEP_BACK_ONE)){
						if (debug) logger.info("Constant.REJECT_STEP_BACK_ONE");
						// a step back would be the last person to approve this outline in history.
						// since this is rejection, we have to look for the last person to approve
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else {
						// in case whereToStartOnOutlineRejection was not set
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}

					approvalCompleted = false;
				}	// if approved

				if (debug){
					logger.info("taskText " + taskText);
					logger.info("lastApprover: " + lastApprover);
					logger.info("nextApprover: " + nextApprover);
					logger.info("nextDelegate: " + nextDelegate);
					logger.info("nextSequence: " + nextSequence);
					logger.info("completeList: " + completeList);
					logger.info("numberOfApproversThisSequence: " + numberOfApproversThisSequence);
				}

				if (!approvalCompleted){
					sql = "UPDATE tblCourse "
							+ "SET edit=0,edit0='',edit1='3',edit2='3',progress=?,reviewdate=null "
							+ "WHERE campus=? "
							+ "AND coursealpha=? "
							+ "AND coursenum=? "
							+ "AND coursetype='PRE'";
					ps = conn.prepareStatement(sql);
					ps.setString(1,mode);
					ps.setString(2,campus);
					ps.setString(3,alpha);
					ps.setString(4,num);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("course set for approval");

					// delete modify or revise task for author
					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.MODIFY_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("modify task removed - rowsAffected " + rowsAffected);

					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.REVISE_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("revise task removed - rowsAffected " + rowsAffected);

					// delete review tasks for all in this outline
					rowsAffected = TaskDB.logTask(conn,"ALL",proposer,alpha,num,
															Constant.REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("review tasks removed - rowsAffected " + rowsAffected);

					// delete approval pending for user who is likely to be the DC
					if(deleteApproval){
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.DELETE_APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}
					else{
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}

					if (debug) logger.info("approval pending tasks removed - rowsAffected " + rowsAffected);

					//	if the approver list is not complete and there is no approval yet, it's because the division
					//	chair was not decided or known.
					//	if numberOfApproversThisSequence = 1, then there is only one person this sequence
					//	so just send it. If more than one, show a list.
					//
					//	above is overridden by packetApproval is ON. In which case, the chair of the department is first up

					if (	completeList.equals(Constant.OFF) &&
							count== 0 &&
							numberOfApproversThisSequence > 1 &&
							packetApproval.equals(Constant.OFF)){
						msg.setCode(1);
						msg.setMsg("forwardURL");
					}
					else{

						rowsAffected = TaskDB.logTask(conn,
																nextApprover,
																proposer,
																alpha,
																num,
																taskText,
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
																	taskText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER);
						}

						if (debug) logger.info("approval task created - rowsAffected " + rowsAffected);

						MailerDB mailerDB = new MailerDB(conn,
																	proposer,
																	nextApprover,
																	nextDelegate,
																	Constant.BLANK,
																	alpha,
																	num,
																	campus,
																	"emailOutlineApprovalRequest",
																	kix,
																	proposer);

						if (debug) logger.info("mail sent");
					}
				}
			} // if (approver != null){

			if (debug) logger.info("-------------------- CourseDB - setCourseForApproval END");

		} catch (SQLException ex) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + ex.toString());
			msg.setMsg("CourseApprovalError");
		} catch (Exception e) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + e.toString());
		}

		return msg;
	} // CourseDB: setCourseForApprovalX

//
// DO NOT TOUCH BELOW HERE
//

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

edits = "80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49,0,0,0,0";

Logger logger = Logger.getLogger("test");

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

System.out.println("------------------------");

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
System.out.println("group: " + (i+1) + "; idx: " + idx);
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

System.out.println("dep: " + j + "; s: " + seq + "; q: " + questionNumber);

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


%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html
