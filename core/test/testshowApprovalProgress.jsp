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
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "d17j24i101951595";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(fastTrackTest(conn,campus));
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String fastTrackTest(Connection conn,String campus,String user,int idx){

Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int j = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			boolean testing = false;

			if (testing){
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? AND coursealpha='BOT' AND coursenum='105'";

				debug = true;
			}
			else{
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? ";

				if (idx>0)
					sql += "AND coursealpha like '" + (char)idx + "%' ";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
				route = rs.getInt("route");

				if (debug) logger.info("--------------------------");

				/*
					when progress is modify, and it shows up on the approval status list, that means it has a route number.
					with a route number, there should be approval history as well. This means it was sent back for revision.
					if no approval history exists, then the outline should not be on this report. Route must be left
					from some time in the past programming.

					for review progress, it happens when the subprogress is COURSE_REVIEW_IN_APPROVAL, and there is
					a reviewer or reviewers pending. if not, it should be in approval progress
				*/

				processOutline = true;

				if ((Constant.COURSE_APPROVAL_TEXT).equals(progress) &&
					(Constant.COURSE_REVIEW_IN_APPROVAL).equals(subprogress)){

					progress = "REVIEW";

					/*
						resetting to approval progress when no reviewer remains
						also need to reset task. At this point, we don't know who
						has the task so we have to get the name from the list
					*/
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = "APPROVAL";
					}
				} // Constant.COURSE_APPROVAL_TEXT
				else if ((Constant.COURSE_MODIFY_TEXT).equals(progress)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processOutline = false;
					else
						progress = "REVISE";
				} // COURSE_MODIFY_TEXT
				else if ((Constant.COURSE_APPROVAL_TEXT).equals(progress)){
					progress = "APPROVAL";
				} // COURSE_APPROVAL_TEXT

				if (debug) logger.info("0. kix: " + kix);
				if (debug) logger.info("0. processOutline: " + processOutline);

				if (processOutline){

					if (debug) logger.info("0. processOutline: " + processOutline);

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					experimental = Outlines.isExperimental(num);

					link = "vwcrsy.jsp?pf=1&kix=" + kix;
					fastTrack = "crsfstrk.jsp?kix=" + kix;
					linkOutline = link;
					divID = alpha + "_" + num;
					linkHistory = "?kix=" + kix;
					linkComments = "?c=0&md=0&kix="+kix+"&qn=0";
					linkDetails = "?h=1&cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";

					if (!"".equals(dateproposed))
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);

					if (!"".equals(auditdate))
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

					if (debug) logger.info("1. outline: " + alpha + " - " + num);
					if (debug) logger.info("2. route: " + route);

					// get all approvers
					ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
					if (ap != null){

						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) logger.info("4. approval history lastApprover: "
																	+ lastApprover
																	+ "; lastApproverSeq: " + lastApproverSeq
																	+ "; approved: " + approved);
						} // (h != null){

						/*
							if nothing comes from history, the we are at the beginning. however,
							if there is something, figure out who should be up

							if approved was the last from history, the add one to the sequence to get the
							next person.

							array is 0th based so the next approver is is already the index of the last approver

						*/
						if (lastApproverSeq == 0){
							lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{

							/*
								who is next to approve
							*/

							if (lastApproverSeq < arr.length)
								lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];

							/*
								is the task assigned to the right person? If not, remove the task.
							*/
							String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																														campus,
																														alpha,
																														num,
																														Constant.APPROVAL_TEXT);
							if (	!"".equals(taskAssignedToApprover) &&
									!taskAssignedToApprover.equals(lastApprover) &&
									!taskAssignedToApprover.equals(proposer)){

								// delete task

								rowsAffected = TaskDB.logTask(conn,
																		taskAssignedToApprover,
																		taskAssignedToApprover,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		"",
																		Constant.TASK_REMOVE,
																		type);

								if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);

							}

						} // lastApproverSeq == 0

						if (debug) logger.info("6. lastApprover: " + lastApprover);
						if (debug) logger.info("7. nextApprover: " + nextApprover);

						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>");

						if((isSysAdmin || isCampusAdmin) && (Constant.COURSE_APPROVAL_TEXT).equals(progress))
							listing.append("&nbsp;&nbsp;<a href=\"" + fastTrack + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>");

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin)
							listing.append("<td class=\"dataColumn\" nowrap><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						else
							listing.append("<td class=\"dataColumn\" nowrap>" + alpha + " " + num + "</td>");

						listing.append("<td class=\"dataColumn\">" + progress + "</td>" +
							"<td class=\"dataColumn\">" + proposer + "</td>" +
							"<td class=\"dataColumn\">" + lastApprover + "</td>" +
							"<td class=\"dataColumn\">" + nextApprover + "</td>" +
							"<td class=\"dataColumn\" nowrap>" + dateproposed + "</td>" +
							"<td class=\"dataColumn\" nowrap>" + auditdate + "</td>" +
							"<td class=\"dataColumn\">" + routingSequence + "</td>" +
							"</tr>");
					} // if ap != null
					else{
						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin5','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin6','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>"
							+ "</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.COURSE_APPROVAL_TEXT).equals(progress))
							listing.append("<td class=\"dataColumn\"><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						else
							listing.append("<td class=\"dataColumn\">" + alpha + " " + num + "</td>");

						listing.append("<td class=\"dataColumn\">" + progress + "</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "</tr>");
					} // if ap != null
				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: fastTrackTest - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: fastTrackTest - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table class=\""+campus+"BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
						"<tr class=\""+campus+"BGColor\" height=\"30\"><td>&nbsp;</td>" +
						"<td valign=\"bottom\">Outline</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"<td valign=\"bottom\">Proposer</td>" +
						"<td valign=\"bottom\">Current<br/>Approver</td>" +
						"<td valign=\"bottom\">Next<br/>Approver</td>" +
						"<td valign=\"bottom\">Date<br/>Proposed</td>" +
						"<td valign=\"bottom\">Last<br/>Updated</td>" +
						"<td valign=\"bottom\">Routing<br/>Sequence</td></tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Outline not found</p>";

		return temp;
	} // fastTrackTest

	/*
	 * showApprovalProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showApprovalProgress(Connection conn,String campus,String user,int idx){

Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int j = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			boolean testing = false;

			if (testing){
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? AND coursealpha='BOT' AND coursenum='105'";

				debug = true;
			}
			else{
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? ";

				if (idx>0)
					sql += "AND coursealpha like '" + (char)idx + "%' ";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
				route = rs.getInt("route");

				if (debug) logger.info("--------------------------");

				/*
					when progress is modify, and it shows up on the approval status list, that means it has a route number.
					with a route number, there should be approval history as well. This means it was sent back for revision.
					if no approval history exists, then the outline should not be on this report. Route must be left
					from some time in the past programming.

					for review progress, it happens when the subprogress is COURSE_REVIEW_IN_APPROVAL, and there is
					a reviewer or reviewers pending. if not, it should be in approval progress
				*/

				processOutline = true;

				if ((Constant.COURSE_APPROVAL_TEXT).equals(progress) &&
					(Constant.COURSE_REVIEW_IN_APPROVAL).equals(subprogress)){

					progress = "REVIEW";

					/*
						resetting to approval progress when no reviewer remains
						also need to reset task. At this point, we don't know who
						has the task so we have to get the name from the list
					*/
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = "APPROVAL";
					}
				} // Constant.COURSE_APPROVAL_TEXT
				else if ((Constant.COURSE_MODIFY_TEXT).equals(progress)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processOutline = false;
					else
						progress = "REVISE";
				} // COURSE_MODIFY_TEXT
				else if ((Constant.COURSE_APPROVAL_TEXT).equals(progress)){
					progress = "APPROVAL";
				} // COURSE_APPROVAL_TEXT

				if (debug) logger.info("0. kix: " + kix);
				if (debug) logger.info("0. processOutline: " + processOutline);

				if (processOutline){

					if (debug) logger.info("0. processOutline: " + processOutline);

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					experimental = Outlines.isExperimental(num);

					link = "vwcrsy.jsp?pf=1&kix=" + kix;
					fastTrack = "crsfstrk.jsp?kix=" + kix;
					linkOutline = link;
					divID = alpha + "_" + num;
					linkHistory = "?kix=" + kix;
					linkComments = "?c=0&md=0&kix="+kix+"&qn=0";
					linkDetails = "?h=1&cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";

					if (!"".equals(dateproposed))
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);

					if (!"".equals(auditdate))
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

					if (debug) logger.info("1. outline: " + alpha + " - " + num);
					if (debug) logger.info("2. route: " + route);

					// get all approvers
					ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
					if (ap != null){

						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) logger.info("4. approval history lastApprover: "
																	+ lastApprover
																	+ "; lastApproverSeq: " + lastApproverSeq
																	+ "; approved: " + approved);
						} // (h != null){

						/*
							if nothing comes from history, the we are at the beginning. however,
							if there is something, figure out who should be up

							if approved was the last from history, the add one to the sequence to get the
							next person.

							array is 0th based so the next approver is is already the index of the last approver

						*/
						if (lastApproverSeq == 0){
							lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{

							/*
								who is next to approve
							*/

							if (lastApproverSeq < arr.length)
								lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];

							/*
								is the task assigned to the right person? If not, remove the task.
							*/
							String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																														campus,
																														alpha,
																														num,
																														Constant.APPROVAL_TEXT);
							if (	!"".equals(taskAssignedToApprover) &&
									!taskAssignedToApprover.equals(lastApprover) &&
									!taskAssignedToApprover.equals(proposer)){

								// delete task

								rowsAffected = TaskDB.logTask(conn,
																		taskAssignedToApprover,
																		taskAssignedToApprover,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		"",
																		Constant.TASK_REMOVE,
																		type);

								if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);

							}

						} // lastApproverSeq == 0

						if (debug) logger.info("6. lastApprover: " + lastApprover);
						if (debug) logger.info("7. nextApprover: " + nextApprover);

						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>");

						if((isSysAdmin || isCampusAdmin) && (Constant.COURSE_APPROVAL_TEXT).equals(progress))
							listing.append("&nbsp;&nbsp;<a href=\"" + fastTrack + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>");

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin)
							listing.append("<td class=\"dataColumn\" nowrap><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						else
							listing.append("<td class=\"dataColumn\" nowrap>" + alpha + " " + num + "</td>");

						listing.append("<td class=\"dataColumn\">" + progress + "</td>" +
							"<td class=\"dataColumn\">" + proposer + "</td>" +
							"<td class=\"dataColumn\">" + lastApprover + "</td>" +
							"<td class=\"dataColumn\">" + nextApprover + "</td>" +
							"<td class=\"dataColumn\" nowrap>" + dateproposed + "</td>" +
							"<td class=\"dataColumn\" nowrap>" + auditdate + "</td>" +
							"<td class=\"dataColumn\">" + routingSequence + "</td>" +
							"</tr>");
					} // if ap != null
					else{
						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin5','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin6','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>"
							+ "</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.COURSE_APPROVAL_TEXT).equals(progress))
							listing.append("<td class=\"dataColumn\"><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						else
							listing.append("<td class=\"dataColumn\">" + alpha + " " + num + "</td>");

						listing.append("<td class=\"dataColumn\">" + progress + "</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "</tr>");
					} // if ap != null
				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showApprovalProgress - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showApprovalProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table class=\""+campus+"BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
						"<tr class=\""+campus+"BGColor\" height=\"30\"><td>&nbsp;</td>" +
						"<td valign=\"bottom\">Outline</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"<td valign=\"bottom\">Proposer</td>" +
						"<td valign=\"bottom\">Current<br/>Approver</td>" +
						"<td valign=\"bottom\">Next<br/>Approver</td>" +
						"<td valign=\"bottom\">Date<br/>Proposed</td>" +
						"<td valign=\"bottom\">Last<br/>Updated</td>" +
						"<td valign=\"bottom\">Routing<br/>Sequence</td></tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Outline not found</p>";

		return temp;
	} // showApproverProgress

	public static String showCompletedApprovals(Connection conn,String campus,String alpha,String num){

Logger logger = Logger.getLogger("test");

		String approvers = "";
		String approver = "";
		int j = 1;

		try{
			String sql = "SELECT approver "
							+ "FROM vw_ApprovalHistory "
							+ "WHERE campus=? AND "
							+ "Coursealpha=? AND "
							+ "Coursenum=? "
							+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				approver = AseUtil.nullToBlank(rs.getString("approver"));

				if (j==1)
					approvers = approver;
				else
					approvers = approvers + "," + approver;

				++j;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showCompletedApprovals - " + se.toString());
		}catch(Exception ex){
			logger.fatal("ApproverDB: showCompletedApprovals - " + ex.toString());
		}

		return approvers;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>