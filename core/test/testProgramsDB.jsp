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

	String campus = "HIL";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "KOMENAKA";
	String task = "Modify_outline";
	String kix = "759i29j10135";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			//out.println( "Completed approvals" );
			//msg = ProgramsDB.showCompletedApprovals(conn,campus,kix);
			//out.println(msg.getErrorLog());
			//out.println("<br/>");
			//out.println("Pending approvals");
			//out.println(showPendingApprovals(conn,campus,kix,msg.getMsg(),1282));
			//out.println(showApprovalProgress(conn,campus,user));
			//msg = reviewProgram(conn,campus,kix,user);
			//out.println(msg.getErrorLog());
			//out.println(isNextApprover(conn,campus,kix,user,708));
			//out.println(endReviewerTask(conn,campus,kix,user));

			out.println(reviewProgram(conn,campus,kix,0,user));
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static Msg reviewProgram(Connection conn,String campus,String kix,int mode,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		AseUtil aseUtil = new AseUtil();
		StringBuffer program = new StringBuffer();

		String sql = "";
		String temp = "";

		int columnCount = 0;
		int j = 0;

		Question question;
		String outputData = "";
		String bgcolor = "";

		HttpSession session = null;

		// allow viewing of approval process.
		boolean allowToComment = true;

		long reviewerComments = 0;
		String answer = "";
		String column = "";

		HashMap hashMap = null;

		try{
			// this works. just not in use.
			//allowToComment = canCommentOnOutline(conn,kix,user);

			ArrayList questions = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");
			ArrayList columns = ProgramsDB.getColumnNames(conn,campus);
			ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,"PRE");
			columnCount = columns.size();

			// with field names, get data for the course in question
			if (answers != null){

				hashMap = ProgramsDB.enabledEditItems(conn,campus,kix);

				program.append( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );
				for(j=0; j<columnCount; j++) {
					question = (Question)questions.get(j);
					answer = (String)answers.get(j);
					column = (String)columns.get(j);

					// if the item was enabled for modification, highlight
					bgcolor = "";
					if(hashMap != null && hashMap.containsValue(question.getNum()))
						bgcolor="bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"";

					reviewerComments = ReviewerDB.countReviewerComments(conn,kix,Integer.parseInt(question.getNum()),Constant.TAB_PROGRAM,Constant.REVIEW);

					program.append("<tr "+bgcolor+"><td align=\"left\" valign=\"top\" width=\"05%\" nowrap>" + (j+1) + ". ");

					if (allowToComment)
						program.append("<a href=\"crscmnt.jsp?c=1&md=" + mode + "&kix=" + kix + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\"></a>&nbsp;");

					if (reviewerComments>0)
						program.append("<a href=\"crsrvwcmnts.jsp?c=1&md=0&kix=" + kix + "&qn=" + question.getNum() + "\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>");
					else
						program.append("<img src=\"images/no-comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\">&nbsp;(" + reviewerComments + ")</td>");

					program.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + question.getQuestion() + "</td></tr>" +
						"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + answer + "</td></tr>");
				}	// for

				if (AttachDB.attachmentExists(conn,kix)){
					program.append("<tr>"
						+ "<td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\" class=\"textblackth\">Attachments:<br/>"
						+ AttachDB.getAttachmentAsHTMLList(conn,kix)
						+ "</td></tr>");
				}

				program.append("</table>");

				program.append("<p align=\'center\'>");

				// compare items
				if (kix != null) {
					program.append("<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, { objectType: \'ajax\'} )\">view all comments</a>"
										+ "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crscmpry.jsp?kix=" + kix + "\' class=\'linkColumn\' target=\'_blank\'>compare outlines</a>");
				}

				// during proposer requested review, we only display link to say finish.
				// during approver requested review, we have buttons for voting
				String subProgress = ProgramsDB.getSubProgress(conn,kix);
				if (mode==Constant.REVIEW && !(Constant.PROGRAM_REVIEW_IN_APPROVAL).equals(subProgress))
					program.append("&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crsrvwerx.jsp?f=1&kix=" + kix + "\' class=\'linkColumn\'>I'm finished</a></p>");

				program.append("</p>");

				msg.setErrorLog(program.toString());

				hashMap = null;
			}
		}
		catch( SQLException e ){
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: reviewProgram - " + e.toString());
		}
		catch( Exception ex ){
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: reviewProgram - " + ex.toString());
		}

		return msg;
	}

	public static Msg endReviewerTask(Connection conn,String campus,String kix,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		int rowsAffected = 0;
		boolean reviewInApproval = false;
		int numberOfReviewers = 0;
		String approver = "";

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("------------------------ ENDREVIEWERTASK - START");

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_PROGRAM_TITLE];
			String num = info[Constant.KIX_PROGRAM_DIVISION];
			String proposer = info[Constant.KIX_PROPOSER];
			String progress = info[Constant.KIX_PROGRESS];
			String subprogress = info[Constant.KIX_SUBPROGRESS];

			if (debug) logger.info("kix - " + kix);
			if (debug) logger.info("alpha - " + alpha);
			if (debug) logger.info("num - " + num);
			if (debug) logger.info("proposer - " + proposer);
			if (debug) logger.info("progress - " + progress);
			if (debug) logger.info("subprogress - " + subprogress);

			msg.setMsg("");

			// end user's review task
			String sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("review completed - " + rowsAffected + " row");

			/*
			 * it's possible that no reviewer added comments. If so, rowsAffected is still 0
			 */
			if (rowsAffected >= 0) {
				// if all reviewers have completed their task, let's reset the
				// course and get back to modify mode. also, backup history
				sql = "WHERE historyid = '" + SQLUtil.encode(kix)
						+ "' AND " + "campus = '" + SQLUtil.encode(campus)
						+ "'";

				numberOfReviewers = (int)AseUtil.countRecords(conn,"tblReviewers",sql);

				if (numberOfReviewers == 0) {

					if ((Constant.PROGRAM_REVIEW_IN_APPROVAL).equals(subprogress))
						reviewInApproval = true;

					// reset course from review to modify or approve
					// ttg-review
					// + "SET edit=0,edit0='',edit1='3',edit2='3',progress='APPROVAL',subprogress='' "
					//	+ "SET edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY' "
					if (reviewInApproval){
						sql = "UPDATE tblPrograms "
							+ "SET edit=0,edit0='',progress='APPROVAL',subprogress='' "
							+ "WHERE campus=? "
							+ "AND historyid=?";
					}
					else{
						sql = "UPDATE tblPrograms "
							+ "SET edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY' "
							+ "WHERE campus=? "
							+ "AND historyid=?";
					}
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("reset to program modify - " + rowsAffected + " row");

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("move history data - " + rowsAffected + " row");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// if reviews were done during the approval process, put the task back to Approve outline for the
					// approver kicking off the review. Task and message should be directed to approver and not proposer
					// it's possible that the approver is not known so we send null to the function to at least determine
					// if the approval process is in flight.

					// because the review process within approval removed the task for the person kicking off the review
					// then send back to the person requesting the review to start approving.
					MailerDB mailerDB = null;

					if (debug) logger.info("reviewInApproval - " + reviewInApproval);

					if (reviewInApproval){
						approver = TaskDB.getInviter(conn,campus,kix,user);

						if (approver != null && approver.length() > 0)
							mailerDB = new MailerDB(conn,
															user,
															approver,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailProgramReviewCompleted",
															kix,
															user);

						rowsAffected = TaskDB.logTask(conn,
																approver,
																user,
																alpha,
																num,
																Constant.PROGRAM_APPROVAL_TEXT,
																campus,
																"Approve process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.PROGRAM);
						if (debug) logger.info("reviewInApproval - mail sent to - " + approver);
						if (debug) logger.info("reviewInApproval - task created for - " + approver);
					}
					else{
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																proposer,
																alpha,
																num,
																Constant.PROGRAM_MODIFY_TEXT,
																campus,
																"Review process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.PROGRAM);
						mailerDB = new MailerDB(conn,
														user,
														proposer,
														Constant.BLANK,
														Constant.BLANK,
														alpha,
														num,
														campus,
														"emailProgramReviewCompleted",
														kix,
														user);

						if (debug) logger.info("reviewInApproval - mail sent to - " + proposer);
						if (debug) logger.info("reviewInApproval - task created for - " + proposer);
					}
				} // endTask

				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.PROGRAM_REVIEW_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
			} // rowsAffected

			if (debug) logger.info("------------------------ ENDREVIEWERTASK - END");

		} catch (Exception e) {
			logger.fatal("ProgramsDB - endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	public static Msg reviewProgram(Connection conn,String campus,String kix,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		AseUtil aseUtil = new AseUtil();

		StringBuffer program = new StringBuffer();
		String sql = "";
		String temp = "";
		int j = 0;

		String bgcolor = "";

		HashMap hashMap = null;
		Question question;

		// allow viewing of approval process.
		boolean allowToComment = true;
		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("-----------------------> START");

			if (debug) logger.info("kix: " + kix);

			// this works. just not in use.
			// not yet created
			//allowToComment = canCommentOnProgram(conn,kix,user);

			long reviewerComments = 0;

			//String[] qn = "1,2,3,4,5,6,10,7,12,9,8,13,11".split(",");

			j = 0;

			ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,"PRE");
			ArrayList list = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");

			if (answers != null){

				if (debug) logger.info("kix: " + kix);

				program.append( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );

				sql = "SELECT questionnumber,questionseq,question "
								+ "FROM tblProgramQuestions "
								+ "WHERE campus=? "
								+ "AND include='Y' "
								+ "ORDER BY questionseq";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					question = (Question)list.get(j);

					bgcolor = "";
					if(hashMap != null && hashMap.containsValue(question.getNum()))
						bgcolor="bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"";

					reviewerComments = ReviewerDB.countReviewerComments(conn,kix,Integer.parseInt(question.getNum()),Constant.TAB_PROGRAM,Constant.REVIEW);

					program.append("<tr "+bgcolor+"><td align=\"left\" valign=\"top\" width=\"05%\" nowrap>" + (j+1) + ". ");

					if (allowToComment)
						program.append("<a href=\"prgcmnt.jsp?c="+Constant.TAB_PROGRAM+"&md=0&kix=" + kix + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\"></a>&nbsp;");

					if (reviewerComments>0)
						program.append("<a href=\"crsrvwcmnts.jsp?c="+Constant.TAB_PROGRAM+"&md=0&kix=" + kix + "&qn=" + question.getNum() + "\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>");
					else
						program.append("<img src=\"images/no-comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\">&nbsp;(" + reviewerComments + ")</td>");

					program.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + question.getQuestion() + "</td></tr>" +
						"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + (String)answers.get(j) + "</td></tr>");

					++j;
				}
				rs.close();
				ps.close();

				String attachments = ProgramsDB.listProgramAttachments(conn,campus,kix);
				if (attachments != null && attachments.length() > 0){
					program.append("<tr>"
						+ "<td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\" class=\"textblackth\">Attachments:<br/>"
						+ attachments
						+ "</td></tr>");
				}

				program.append("</table>");

				program.append("<p align=\'center\'>");

				if (kix != null) {
					program.append("<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWincrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\">view all comments</a>");
				}

				program.append("</p>");

				msg.setErrorLog(program.toString());
			} // if (answers != null)

			answers = null;

			if (debug) logger.info("-----------------------> END");

		}
		catch( SQLException e ){
			msg.setMsg("ProgramsDB");
			logger.fatal("Programs: reviewProgram\n" + e.toString());
		}
		catch( Exception ex ){
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: reviewProgram - " + ex.toString());
		}

		return msg;
	} // reviewProgram

	public static String showApprovalProgress(Connection conn,String campus,String user){

Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String program = "";
		String divisionName = "";
		String division = "";
		String title = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String kix = "";
		String temp = "";
		String routingSequence = "";
		String effectiveDate = "";

		String rowColor = "";
		String link = "";
		String linkProgram = "";
		String linkHistory = "";

		int i = 0;
		int j = 0;
		int route = 0;
		int rowsAffected = 0;

		boolean found = false;
		boolean debug = false;
		boolean processProgram = false;
		boolean approved = false;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String sql = "";

		Approver ap = null;
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("------------------------------ START");

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String select = " historyid,program,divisionname,title,proposer,Progress,route,subprogress,kid,divisioncode,effectivedate ";

			boolean testing = true;

			if (testing){
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? AND historyid='y39i22i1053257' "
					+ "ORDER BY program,divisionname,title";

				debug = true;
			}
			else{
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? "
					+ "ORDER BY program,divisionname,title";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				program = AseUtil.nullToBlank(rs.getString("program"));
				divisionName = AseUtil.nullToBlank(rs.getString("divisionname"));
				division = AseUtil.nullToBlank(rs.getString("divisioncode"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				effectiveDate = AseUtil.nullToBlank(rs.getString("effectiveDate"));
				route = rs.getInt("route");

				if (debug) logger.info("program: " + program);
				if (debug) logger.info("divisionName: " + divisionName);
				if (debug) logger.info("kix: " + kix);
				if (debug) logger.info("route: " + route);

				/*
					when progress is modify, and it shows up on the approval status list, that means it has a route number.
					with a route number, there should be approval history as well. This means it was sent back for revision.
					if no approval history exists, then the program should not be on this report. Route must be left
					from some time in the past programming.
				*/
				processProgram = true;

				if ((Constant.PROGRAM_MODIFY_PROGRESS).equals(progress)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processProgram = false;
					else
						progress = "REVISE";
				}
				else if ((Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress))
					progress = "APPROVAL";

				if (debug) logger.info("progress: " + progress);

				if (processProgram){

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					link = "prgvwx.jsp?type=PRE&kix=" + kix;
					linkProgram = link;
					linkHistory = "?kix=" + kix;

					if (route > 0)
						ap = ApproverDB.getApprovers(conn,kix,proposer,false,route);

					if (ap == null){
						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress))
							listing.append("<td class=\"dataColumn\"><a href=\"/central/core/prgprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + program + " " + divisionName + "</a></td>");
						else
							listing.append("<td class=\"dataColumn\">" + program + " " + divisionName + "</td>");

						listing.append("<td class=\"dataColumn\">" + effectiveDate + "</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "</tr>");
					}
					else{
						if (debug) logger.info("got approvers");

						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						if (debug) logger.info("ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) logger.info("4. lastApprover: " + lastApprover);
							if (debug) logger.info("4. lastApproverSeq: " + lastApproverSeq);
							if (debug) logger.info("4. approved: " + approved);
						} // (h != null){

						/*
							if nothing comes from history, the we are at the beginning. however,
							if there is something, figure out who should be up

							if approved was the last from history, the add one to the sequence to get the
							next person.

							array is 0th but we built the approver sequence starting from 1;

						*/
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;

							lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
							if (lastApprover.indexOf(",") > -1)
								lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));

							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));
						}
						else{

							/*
								who is next to approve. if the last person approved, then
								increase by 1 to get to the next person.
							*/
							if (approved)
								++lastApproverSeq;

							lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
							if (lastApprover.indexOf(",") > -1)
								lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));

							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

							/*
								is the task assigned to the right person? If not, remove the task.
							*/
							String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													title,
																													division,
																													Constant.PROGRAM_APPROVAL_TEXT);

							if (	!"".equals(taskAssignedToApprover) &&
									!taskAssignedToApprover.equals(lastApprover) &&
									!taskAssignedToApprover.equals(proposer)){

								// delete task
								rowsAffected = TaskDB.logTask(conn,
																		taskAssignedToApprover,
																		taskAssignedToApprover,
																		title,
																		division,
																		Constant.APPROVAL_TEXT,
																		campus,
																		"",
																		Constant.TASK_REMOVE,
																		type);

								if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);

							}

						} // lastApproverSeq == 0

						if (debug) logger.info("lastApprover: " + lastApprover);
						if (debug) logger.info("nextApprover: " + nextApprover);

						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;");

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin){
							listing.append("<td class=\"dataColumn\" nowrap>" + program + " - " + divisionName + "</td>");
						}
						else
							listing.append("<td class=\"dataColumn\" nowrap>" + program + " - " + divisionName + "</td>");

						listing.append("<td class=\"dataColumn\">" + title + "</td>" +
							"<td class=\"dataColumn\">" + effectiveDate + "</td>" +
							"<td class=\"dataColumn\">" + progress + "</td>" +
							"<td class=\"dataColumn\">" + proposer + "</td>" +
							"<td class=\"dataColumn\">" + lastApprover + "</td>" +
							"<td class=\"dataColumn\">" + nextApprover + "</td>" +
							"<td class=\"dataColumn\">" + routingSequence + "</td>" +
							"</tr>");

						found = true;
					} // if ap != null

					ap = null;

				} // processProgram

			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------------------ END");
		}
		catch(SQLException sx){
			logger.fatal("ProgramsDB: showApprovalProgress - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: showApprovalProgress - " + ex.toString());
		}

		if (found)
			temp = "<table class=\""+campus+"BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
						"<tr class=\""+campus+"BGColor\" height=\"30\"><td>&nbsp;</td>" +
						"<td valign=\"bottom\">Program</td>" +
						"<td valign=\"bottom\">Title</td>" +
						"<td valign=\"bottom\">Effective Date</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"<td valign=\"bottom\">Proposer</td>" +
						"<td valign=\"bottom\">Current<br/>Approver</td>" +
						"<td valign=\"bottom\">Next<br/>Approver</td>" +
						"<td valign=\"bottom\">Routing<br/>Sequence</td></tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Programs not found</p>";

		return temp;
	} // showApproverProgress

	public static boolean isNextApprover(Connection conn,String campus,String kix,String user,int route) throws SQLException {

Logger logger = Logger.getLogger("test");

		boolean debug = DebugDB.getDebug(conn,"ProgramsDB");

		//debug = true;

		boolean nextApprover = false;
		boolean multiLevel = false;
		int userSequence = 0;
		int lastSequenceToApprove = 0;
		int nextSequence = 0;

		boolean lastApproverVotedNO = false;

		if (debug) logger.info("-------------------------------------------");
		if (debug) logger.info(user + " - ProgramsDB isNextApprover - STARTS");

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String proposer = info[Constant.KIX_PROPOSER];

		if (debug) logger.info("title - " + alpha);
		if (debug) logger.info("division - " + num);
		if (debug) logger.info("route - " + route);

		try {
			/*
			 * if a recall took place, allow the person trying to approve and having a task to continue
			 * a recall constitute non-approval
			 *
			 * if the last voter voted NO, then the ideal way is to have it kicked off from the start. That
			 * means the last sequence is 0 or just like no vote yet.
			 *
			 * what is this user's approval sequence (userSequence). if not
			 * found, then the user is not authorize to approve. returns error.
			 * if is part of approval sequence, then determine where in line the
			 * last approver was (lastSequenceToApprove). the last sequence + 1 should be
			 * this user's sequence in order to move on.
			 * if the user is not on the list of approver sequence, are they on a distribution list?
			 * if so, confirm that there is more or less to approve
			 */

			String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.PROGRAM_APPROVAL_TEXT);
			boolean recalledApprovalHistory = HistoryDB.recalledApprovalHistory(conn,kix,alpha,num,user);
			if (taskAssignedToApprover != null
				&& taskAssignedToApprover.length() > 0
				&& taskAssignedToApprover.equals(user)
				&& recalledApprovalHistory){
				return true;
			}
			if (debug) logger.info("taskAssignedToApprover - " + taskAssignedToApprover);
			if (debug) logger.info("recalledApprovalHistory - " + recalledApprovalHistory);

			// was this kicked back for revision? we know it was if the last approved vote was no in history
			// look at the reject system setting to determine when it was kicked back, who it should go to
			lastApproverVotedNO = ApproverDB.lastApproverVotedNO(conn,campus,kix);
			if (lastApproverVotedNO){
				if (debug) logger.info("last approver rejected outline");

				String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
				if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection)){
					lastSequenceToApprove = 0;
					if (debug) logger.info("REJECT_START_FROM_BEGINNING");
				}
				else if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection)){
					// get highest id from history of rejected items
					// that's the person to send to. however, minus one from the sequence so
					// that lastSequenceToApprove + 1 = the correct person
					lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);

					if (debug){
						logger.info("REJECT_START_WITH_REJECTER");
						logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
						logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-1));
					}

					lastSequenceToApprove = lastSequenceToApprove - 1;
				}
				else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
					// figure out who was last to disapprove. get that sequence and subtract 2.
					// subtract 1 to accommodate going back by one step.
					// however, nextSequence is lastSequenceToApprove + 1 so subtract another for that
					lastSequenceToApprove = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

					if (debug){
						logger.info("REJECT_STEP_BACK_ONE");
						logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
						logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-2));
					}

					lastSequenceToApprove = lastSequenceToApprove - 2;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
				else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection)){

					// look for the task to see who approver selected to restart. with the name,
					// get the sequence and subtract to get the process rolling
					if (taskAssignedToApprover != null && taskAssignedToApprover.length() > 0)
						lastSequenceToApprove = ApproverDB.getApproverSequence(conn,taskAssignedToApprover,route);

					if (debug){
						logger.info("REJECT_APPROVER_SELECTS");
						logger.info("taskAssignedToApprover: " + taskAssignedToApprover);
					}

					lastSequenceToApprove = lastSequenceToApprove - 1;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
			} // lastApproverVotedNO
			else
				lastSequenceToApprove = ProgramsDB.getLastSequenceToApprove(conn,campus,kix);

			if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);

			// was lastSequenceToApprove a distribution list? if yes, is approval for distribution completed?
			boolean isDistributionList = false;
			boolean distributionApprovalCompleted = true;

			String distributionList = ApproverDB.getApproversBySeq(conn,campus,lastSequenceToApprove,route);

			if (distributionList != null && distributionList.length() > 0)
				isDistributionList = DistributionDB.isDistributionList(conn,campus,distributionList);

			if (isDistributionList)
				distributionApprovalCompleted = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distributionList,lastSequenceToApprove);

			if (debug){
				logger.info("distributionList: " + distributionList);
				logger.info("isDistributionList: " + isDistributionList);
				logger.info("distributionApprovalCompleted: " + distributionApprovalCompleted);
			}

			// if is a distribution list and the distribution approval not completed, then sequence is last sequence
			if (isDistributionList && !distributionApprovalCompleted)
				nextSequence = lastSequenceToApprove;
			else
				nextSequence = lastSequenceToApprove + 1;

			if (debug) logger.info("nextSequence: " + nextSequence);

			/*
				retrieve approver info (structure of first/last/next)
				without route number, nothing works at this point
			*/
			if (route > 0){
				Approver approver = ApproverDB.getApproverByNameAndSequence(conn,campus,alpha,num,user,route,nextSequence);
				if (approver != null) {
					if (debug) logger.info("approver: " + approver);

					userSequence = Integer.parseInt(approver.getSeq());
					if (debug) logger.info("userSequence: " + userSequence);

					// make sure the next approver is set appropriately when not distribution list
					if (userSequence == 0) {
						nextApprover = false;
					} else {
						if (isDistributionList && !distributionApprovalCompleted)
							nextApprover = true;
						else{
							if ((lastSequenceToApprove + 1) == userSequence)
								nextApprover = true;
							else
								nextApprover = false;
						}
					}

					if (debug){
						logger.info("nextApprover: " + nextApprover);
						logger.info("multiLevel: " + multiLevel);
					}

					/*
					 * if is next approver and is multilevel (divisional approver),
					 * make sure the user's department is the same as the alpha.
					 */
					if (nextApprover && multiLevel) {
						if (alpha.equals(UserDB.getUserDepartment(conn, user))) {
							nextApprover = true;
						} else {
							nextApprover = false;
						}
					}

					if (debug) logger.info("nextApprover: " + nextApprover);

				} else {
					nextApprover = false;
				} // approver = null
			}	// route > 0
			else
				nextApprover = false;

			if (debug) logger.info(kix + " - ProgramsDB - isNextApprover - " + user + " - (" + nextApprover + ")");

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isNextApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: isNextApprover - " + ex.toString());
		}

		if (debug) logger.info(kix + " - " + user + " - ProgramsDB isNextApprover - ENDS");

		return nextApprover;
	} // nextApprover

	/**
	 * showPendingApprovals
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	completed	String
	 * @param	route			int
	 * <p>
	 * @return	String
	 */
	public static String showPendingApprovals(Connection conn,String campus,String kix,String completed,int route){

Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String approver = "";
		String delegated = "";
		String pendingApprovers = "";
		String position = "";
		String title = "";
		String rtn = "";

		String distributionList = "";
		String distributionListMembers = "";
		String[] aDistributionList = null;
		boolean distributionApprovalCompleted = false;

		String rowColor = "";
		int j = 0;
		int sequence = 0;
		int lastSequenceToApprove = 0;

		boolean found = false;
		boolean firstSequenceExists = false;
		String sql = "";

		try{
			completed = "'" + completed.replace(",","','") + "'";

			// take care of complete distribution list if any. list starts and ends with [].
			// if the list members have approved 100%, then remove the list from listing.
			sql = "SELECT approver " +
				"FROM tblApprover " +
				"WHERE route=? " +
				"AND approver LIKE '[[]%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				// get the list name
				distributionList = AseUtil.nullToBlank(rs.getString(1));
				if (distributionList != null && distributionList.length() > 0){
					// get list members
					distributionListMembers = DistributionDB.getDistributionMembers(conn,campus,distributionList);
					if (distributionListMembers != null && distributionListMembers.length() > 0){

						// split members into array. for loop checks to verify that members have/have not approved
						// if all approved, then this list is no longer listed
						// start with list being completed by default. If a name is not found in the for-loop, then
						// set distributionApprovalCompleted = false;

						distributionApprovalCompleted = true;

						aDistributionList = distributionListMembers.split(",");

						for(int z=0;z<aDistributionList.length;z++){
							if (completed.indexOf(aDistributionList[z])==-1){
								distributionApprovalCompleted = false;
							}
						} // for

						// if completed, add to excluded (completed) list
						if (distributionApprovalCompleted)
							completed += ",'" + distributionList + "'";

					} // if distributionListMembers
				} // if distributionList
			} // while
			rs.close();
			ps.close();

			sql = "";

			/*
				with programs, we are not concerned with sequence 1 from approver sequence.
				#1 is from the division table as chair
			*/
			lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);
			if (lastSequenceToApprove<1){
				lastSequenceToApprove = 1;

				sql = "SELECT 1 AS Sequence, d.chairname AS Approver, '' AS delegated, tu.title, tu.[position], tu.department, tu.campus, " + route + " AS route "
						+ "FROM tblDivision d INNER JOIN tblUsers tu ON d.campus = tu.campus AND d.chairname = tu.userid "
						+ "WHERE d.divid=1 "
						+ "UNION ";
			}

			sql += ""
				+ "SELECT ta.approver_seq AS Sequence,ta.approver,ta.delegated,tu.title,tu.[position],tu.department,tu.campus,ta.route "
				+ "FROM tblApprover ta INNER JOIN "
				+ "tblUsers tu ON ta.approver = tu.userid "
				+ "WHERE ta.campus=? AND route=? AND approver_seq>? "
				+ "UNION "
				+ "SELECT approver_seq AS Sequence,approver,delegated,'DISTRIBUTION LIST','DISTRIBUTION LIST','',campus,route "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND route=? AND approver LIKE '%]' AND approver_seq>?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,lastSequenceToApprove);
			ps.setString(4,campus);
			ps.setInt(5,route);
			ps.setInt(6,lastSequenceToApprove);
			rs = ps.executeQuery();
			while ( rs.next() ){
				// name of first approver at DC level is not always available since
				// CC does not know who is DC for all alphas. When that happens,
				// sequence 1 or first person will not be found here.
				// firstSequenceExists = true means we found the DC otherwise we did not.
				// if not, we want to get that name from the task assignment and include
				// in the data returned.
				sequence = NumericUtil.nullToZero(rs.getInt("sequence"));

				if (sequence==1)
					firstSequenceExists = true;

				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				position = AseUtil.nullToBlank(rs.getString("position"));

				// list of pending approvers for use later
				if (j== 0)
					pendingApprovers = approver;
				else
					pendingApprovers = pendingApprovers + "," + approver;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\"" + rowColor + "\">" +
					"<td class=\"dataColumn\" valign=\"top\">" + sequence + "</td>" +
					"<td class=\"dataColumn\" valign=\"top\">" + approver + "</td>" +
					"<td class=\"dataColumn\" valign=\"top\">" + title + "</td>" +
					"<td class=\"dataColumn\" valign=\"top\">" + position + "</td>" +
					"<td class=\"dataColumn\" valign=\"top\">" + delegated + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				rtn = buf.toString();
		}
		catch(SQLException se){
			logger.fatal("ProgramsDB: showPendingApprovals - " + sql);
		}catch(Exception ex){
			logger.fatal("ProgramsDB: showPendingApprovals - " + ex.toString());
		}

		if (found){
			rtn = "<table class=\"" + campus + "BGColor\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
				"<tr class=\"" + campus + "BGColor\">" +
				"<td>Sequence</td>" +
				"<td>Approver</td>" +
				"<td>Title</td>" +
				"<td>Position</td>" +
				"<td>Delegate</td>" +
				"</tr>" +
				rtn +
				"</table>";
		}
		else
			rtn = "";

		return rtn;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>