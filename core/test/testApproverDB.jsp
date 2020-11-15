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
	String alpha = "ICS";
	String num = "100";
	String type = "PRE";
	String user = "SPOPE";
	String task = "Modify_outline";
	String kix = "d17j24i101951595";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			//out.println(fastTrackTest(conn,campus,user));
			//out.println(getApproverByNameAndSequence(conn,campus,alpha,num,user,708,1));
			//out.println(getApprovers(conn,campus,alpha,num,user,false,1579));
out.println(showApprovalProgress(conn,campus,user,65));
			//finalizeOutlineWithoutNotification(conn);
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

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

			PreparedStatement ps = null;

			String select = " campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid ";

			boolean testing = false;

			if (testing){
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? AND coursealpha='BURM' AND coursenum='998'";

				debug = true;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else{
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? ";

				if (idx>0)
					sql += "AND coursealpha like '" + (char)idx + "%' ";

				// connect pending outlines
				sql += " UNION "
					+ "SELECT campus, id, CourseAlpha, CourseNum, proposer, Progress, dateproposed, auditdate, 0 as [route], subprogress, '0' as [kid] "
					+ "FROM tblCourse "
					+ "WHERE campus=? AND CourseType='PRE' AND CourseAlpha<>'' AND progress='PENDING'";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,campus);
			}
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

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

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
					if (route > 0)
						ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);

					if (ap == null){

						if ((Constant.COURSE_APPROVAL_PENDING_TEXT).equals(progress)){
							lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
						}

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
							+ "<td class=\"dataColumn\">" + proposer + "</td>"
							+ "<td class=\"dataColumn\">" + lastApprover + "</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "<td class=\"dataColumn\" nowrap>" + dateproposed + "</td>"
							+ "<td class=\"dataColumn\" nowrap>" + auditdate + "</td>"
							+ "<td class=\"dataColumn\">&nbsp;</td>"
							+ "</tr>");
					}
					else{
						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						lastApproverSeq = 0;
						lastApprover = "";
						approved = false;
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

							lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{

							/*
								who is next to approve. if the last person approved, then
								increase by 1 to get to the next person.
							*/
							if (approved)
								++lastApproverSeq;

							// check for comma to remove delegate from showing on reporet
							lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
							if (lastApprover.indexOf(",") > -1)
								lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));

							// check for comma to remove delegate from showing on reporet
							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

						} // lastApproverSeq == 0

						/*
							is the task assigned to the right person? If not, remove the task.
						*/
						String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													alpha,
																													num,
																													Constant.APPROVAL_TEXT);
						if (	!(Constant.BLANK).equals(taskAssignedToApprover) &&
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
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type);

							if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);
						}

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

					ap = null;

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

	/*
	 * getApprovers all approvers by campus
	 *	<p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	alpha				String
	 * @param	num				String
	 * @param	user				String
	 * @param	experimental	boolean
	 * @param	route				int
	 *	<p>
	 * @return Approver
	 */
	public static Approver getApprovers(Connection conn,
													String campus,
													String alpha,
													String num,
													String user,
													boolean experimental,
													int route) throws Exception {

Logger logger = Logger.getLogger("test");

		Approver approver = new Approver();

		int maxSeq = ApproverDB.getMaxApproverSeq(conn,campus,route);

		String[] aApprovers = new String[maxSeq];
		String[] aDelegates = new String[maxSeq];
		String[] aExperiments =  new String[maxSeq];
		String[] aSequences =  new String[maxSeq];
		String[] aCmpleteList =  new String[maxSeq];

		StringBuffer allApprovers = new StringBuffer();
		StringBuffer allDelegates = new StringBuffer();
		StringBuffer allExperiments = new StringBuffer();
		StringBuffer allSequences = new StringBuffer();
		StringBuffer allCompleteList = new StringBuffer();

		int arrayIndex = 0;
		int currentSeq = 0;
		int startSeq = 0;
		int nextSeq = 0;
		int prevSeq = 0;
		int lastSeq = 0;

		String temp = "";
		String thisApprover = "";
		String thisDelegated = "";
		String thisExperimental = "";
		String distName = "";
		String currentApprover = "";
		String currentDelegate = "";
		String firstApprover = "";
		String dcApprover = "";

		boolean isDistributionList = false;
		boolean approverFound = false;
		boolean isAProgram = false;
		boolean debug = false;

		String delegateAtSequence1 = "";
		String approverAtSequence1 = "";

		try{

			debug = DebugDB.getDebug(conn,"ApproverDB");

debug = true;

			if (debug) logger.info("--------------------------- START");

			user = user.toUpperCase().trim();
			if (debug) logger.info("user: " + user);
			if (debug) logger.info("outline/program: " + alpha + " " + num);

			// does the routing exist? It's possible that the route was deleted
			// after assignment. Yes, I should make sure it can't be deleted. :)
			if (!IniDB.doesRoutingIDExists(conn,campus,route))
				route = IniDB.getDefaultRoutingID(conn,campus);

			if (debug) logger.info("route: " + route);

			// when kix is not available, then we have a program; if so, NUM contains division
			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
			if (kix == null || kix.length() == 0)
				isAProgram = true;

			if (debug) logger.info("isAProgram: " + isAProgram);

			if (isAProgram){
				approverAtSequence1 = DivisionDB.getChairName(conn,campus,num);
				if (approverAtSequence1 != null && approverAtSequence1.length() > 0){
					currentSeq = 0;
					currentApprover = approverAtSequence1;
					aApprovers[0] = approverAtSequence1;

					delegateAtSequence1 = DivisionDB.getDelegated(conn,campus,num);
					if (delegateAtSequence1 == null || delegateAtSequence1.length() == 0)
						delegateAtSequence1 = approverAtSequence1;

					aDelegates[0] = delegateAtSequence1;
				}
			}
			else{
//approverAtSequence1 = ApproverDB.approverAtSequenceOne(conn,campus,alpha,num);
approverAtSequence1 = approverAtSequenceOne(conn,campus,alpha,num);
				if (approverAtSequence1 != null && approverAtSequence1.length() > 0){
					currentSeq = 0;
					currentApprover = approverAtSequence1;
					aApprovers[0] = approverAtSequence1;

					// with approver at sequence 1, it's easier now to find delegate
					delegateAtSequence1 = ApproverDB.getDelegateByApproverName(conn,campus,approverAtSequence1,route);
					if (delegateAtSequence1 != null && delegateAtSequence1.length() > 0)
						aDelegates[0] = delegateAtSequence1;
					else{
						delegateAtSequence1 = approverAtSequence1;
						aDelegates[0] = delegateAtSequence1;
					}
				}
			} // is a program

			if (debug) logger.info("approverAtSequence1: " + approverAtSequence1);
			if (debug) logger.info("delegateAtSequence1: " + delegateAtSequence1);

			// if the first approver is found, start the collection of data from the second and on
			if (aApprovers[0] != null && aApprovers[0].length() > 0){
				startSeq = 1;
				allCompleteList.append("1");
			}

			if (debug) logger.info("startSeq: " + startSeq);

			// gather approvers for all sequences and create CSV
			String sql = "SELECT Approver, delegated, approver_seq, [Position], experimental "
							+ "FROM vw_Approvers2 "
							+ "WHERE route=? "
							+ "AND approver_seq>?  "
							+ "ORDER BY approver_seq, approver";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ps.setInt(2,startSeq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				approverFound = false;

				arrayIndex = rs.getInt("approver_seq") - 1;

				// approver
				thisApprover = AseUtil.nullToBlank(rs.getString("Approver"));
				if (aApprovers[arrayIndex] == null || aApprovers[arrayIndex].length() == 0)
					aApprovers[arrayIndex] = thisApprover;
				else
					aApprovers[arrayIndex] = aApprovers[arrayIndex] + "," + thisApprover;

				// delegate - default empty delegates to the approver
				thisDelegated = AseUtil.nullToBlank(rs.getString("delegated"));
				if ("".equals(thisDelegated))
					thisDelegated = thisApprover;

				if (debug) logger.info("arrayIndex: " + arrayIndex + " - " + thisApprover + "/" + thisDelegated);

				if (aDelegates[arrayIndex] == null || aDelegates[arrayIndex].length() == 0)
					aDelegates[arrayIndex] = thisDelegated;
				else
					aDelegates[arrayIndex] = aDelegates[arrayIndex] + "," + thisDelegated;

				// experiment
				thisExperimental = AseUtil.nullToBlank(rs.getString("experimental"));
				if (aExperiments[arrayIndex] == null || aExperiments[arrayIndex].length() == 0)
					aExperiments[arrayIndex] = thisExperimental;
				else
					aExperiments[arrayIndex] = aExperiments[arrayIndex] + "," + thisExperimental;

				// sequence
				if (aSequences[arrayIndex] == null || aSequences[arrayIndex].length() == 0)
					aSequences[arrayIndex] = AseUtil.nullToBlank(rs.getString("approver_seq"));
				else
					aSequences[arrayIndex] = aSequences[arrayIndex] + "," + AseUtil.nullToBlank(rs.getString("approver_seq"));

				// determine the current approver (+1 to adjust for above subtraction)
				if (thisApprover.equals(user) || thisDelegated.equals(user)) {
					currentSeq = arrayIndex;
					approverFound = true;
					currentApprover = thisApprover;
					currentDelegate = thisDelegated;
				}

				// distribution
				isDistributionList = DistributionDB.isDistributionList(conn,campus,thisApprover);
				if (isDistributionList){
					// get list of members in distribution
					distName = thisApprover;
					thisApprover = DistributionDB.getDistributionMembers(conn,campus,distName);
					// is user part of list
					if (thisApprover.indexOf(user)>-1 || thisDelegated.indexOf(user)>-1) {
						thisApprover = user;
						approver.setDistributionList(true);
						approver.setDistributionName(distName);
					}
				} // isDistributionList

				if (allCompleteList.length()>0)
					allCompleteList.append(",");

				if (approverFound)
					allCompleteList.append("1");
				else
					allCompleteList.append("0");

			}	// while

			if (debug) logger.info("currentApprover: " + currentApprover);

			// if we couldn't find the current approver, then use
			// current approver as the person with the task to approve
			if (currentApprover == null || currentApprover.length() == 0)
				currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);

			if (debug) logger.info("currentApprover: " + currentApprover);

			// if the current approver exists and is part of the first set of approvers,
			// set accordingly.
			if (currentApprover != null && currentApprover.length() > 0){
				if (aApprovers[0].indexOf(currentApprover) > -1){
					currentSeq = 0;
					aApprovers[0] = currentApprover;

					currentDelegate = ApproverDB.getDelegateByApproverName(conn,campus,currentApprover,route);
					if (currentDelegate != null && currentDelegate.length() > 0)
						aDelegates[0] = currentDelegate;
					else{
						currentDelegate = currentApprover;
						aDelegates[0] = currentDelegate;
					}
				}
			}

			if (debug) logger.info("currentSeq: " + currentSeq);

			// combine to make a list of all different types; programs don't need complete list
			// or experimental
			allApprovers.append(aApprovers[0]);
			allDelegates.append(aDelegates[0]);

			if (isAProgram)
				allExperiments.append("0");
			else
				allExperiments.append(aExperiments[0]);

			allSequences.append(1);

			for(int i=1; i<maxSeq; i++){
				allApprovers.append("," + aApprovers[i]);
				allDelegates.append("," + aDelegates[i]);

				if (isAProgram)
					allExperiments.append(",0");
				else
					allExperiments.append("," + aExperiments[i]);

				allSequences.append("," + (i+1));
			}

			// fill up approver structure with all names
			lastSeq = maxSeq - 1;

			nextSeq = currentSeq + 1;
			if (nextSeq > lastSeq)
				nextSeq = lastSeq;

			prevSeq = currentSeq - 1;
			if (prevSeq < 0)
				prevSeq = 0;

			if (debug) logger.info("lastSeq: " + lastSeq);
			if (debug) logger.info("nextSeq: " + nextSeq);
			if (debug) logger.info("prevSeq: " + prevSeq);
			if (debug) logger.info("currentSeq: " + currentSeq);

			// the current approver
			approver.setApprover(currentApprover);
			approver.setDelegated(currentDelegate);

			if ((Constant.ON).equals(aExperiments[currentSeq]))
				approver.setExcludeFromExperimental(true);
			else
				approver.setExcludeFromExperimental(false);

			// actual sequence is 1 more than array based index.
			approver.setSeq(Integer.toString(currentSeq+1));

			/*
				for programs, chair name replaces first approver
			*/
			if (isAProgram){
				String chair = ChairProgramsDB.getChairName(conn,campus,alpha);
				if (chair != null && chair.length() > 0){
					aApprovers[0] = chair;
					aDelegates[0] = ChairProgramsDB.getDelegatedName(conn,campus,alpha);
				}
			}
			approver.setFirstApprover(aApprovers[0]);
			approver.setFirstDelegate(aDelegates[0]);
			approver.setFirstExperiment(aExperiments[0]);
			approver.setFirstSequence(Integer.toString(1));

			approver.setPreviousApprover(aApprovers[prevSeq]);
			approver.setPreviousDelegate(aDelegates[prevSeq]);
			approver.setPreviousExperiment(aExperiments[prevSeq]);
			approver.setPreviousSequence(Integer.toString(++prevSeq));

			approver.setNextApprover(aApprovers[nextSeq]);
			approver.setNextDelegate(aDelegates[nextSeq]);
			approver.setNextExperiment(aExperiments[nextSeq]);
			approver.setNextSequence(Integer.toString(++nextSeq));

			approver.setLastApprover(aApprovers[lastSeq]);
			approver.setLastDelegate(aDelegates[lastSeq]);
			approver.setLastExperiment(aExperiments[lastSeq]);
			approver.setLastSequence(Integer.toString(maxSeq));

			temp = allApprovers.toString();
			approver.setAllApprovers(temp);

			approver.setAllExperiments(allExperiments.toString());
			approver.setAllDelegates(allDelegates.toString());
			approver.setAllSequences(allSequences.toString());
			approver.setAllCompleteList(allCompleteList.toString());

			approver.setCompleteList(approverFound);
			approver.setRoute(route);

			rs.close();
			ps.close();

			if (debug) logger.info("--------------------------- END");

		} catch (SQLException se) {
			logger.fatal("ApproverDB: getApprovers - " + se.toString());
			approver = null;
		} catch (Exception e) {
			logger.fatal("ApproverDB: getApprovers - " + e.toString());
			approver = null;
		}

		return approver;
	}

	public static String approverAtSequenceOne(Connection conn,String campus,String alpha,String num){

Logger logger = Logger.getLogger("test");

		String dcApprover = "";
		String firstApproverInHistory = "";
		String taskAssignedToApprover = "";
		String approverAtSequence1 = "";

		try{
			// must find the first approver so that we are not adding all fast track for first approvers

			// is this the one and only person for the route
			// if not 1 and only person for route, first is the division/department chair OR
			// if not DC, then locate first approver in the history table
			// if not in history then first task assigned
			String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
			int route = Integer.parseInt(info[1]);
System.out.println(route);

			int getApproverCount = ApproverDB.getApproverCount(conn,campus,1,route);
System.out.println(getApproverCount);

			if (getApproverCount==1)
				approverAtSequence1 = ApproverDB.getApproverBySeq(conn,campus,1,route);
			else{
				dcApprover = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
				if (dcApprover == null || dcApprover.length() == 0){
					firstApproverInHistory = ApproverDB.getHistoryApproverBySeq(conn,campus,alpha,num,1);
					if (firstApproverInHistory == null || firstApproverInHistory.length() == 0){
						taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);
						if (taskAssignedToApprover != null && taskAssignedToApprover.length() > 0)
							approverAtSequence1 = taskAssignedToApprover;
						else
							approverAtSequence1 = "";
					}
					else
						approverAtSequence1 = firstApproverInHistory;
				}
				else
					approverAtSequence1 = dcApprover;
			}

		} catch(Exception ex){
			logger.fatal("ApproverDB: approverAtSequenceOne - " + ex.toString());
		}

		return approverAtSequence1;
	}

	public static Approver getApproverByNameAndSequence(Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String user,
																		int route,
																		int sequence) throws Exception {

Logger logger = Logger.getLogger("test");

		Approver approver = null;

		boolean found = false;
		boolean debug = false;

		/*
			if we can't find the name in approver list, check to see if this person
			is a division chair. if so, find based on alpha/department

			1) Check by actual name. if found then true.
			2) If not found, check if it's division chair's turn.
				if yes, get the name of division and set up all values
		*/

		try {
			debug = DebugDB.getDebug(conn,"ApproverDB");

			if (debug) logger.info("----------------- getApproverByNameAndSequence - STARTS");

debug = true;

			if (debug) logger.info("alpha: " + alpha);
			if (debug) logger.info("num: " + num);
			if (debug) logger.info("user: " + user);
			if (debug) logger.info("route: " + route);
			if (debug) logger.info("sequence: " + sequence);

			AseUtil aseUtil = new AseUtil();

			// 1 - find the person. this person may not be in the correct alpha, but is a DC so we'll let through
			String sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND (approver=? OR delegated=?) AND route=? AND approver_seq=? "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,user);
			ps.setInt(4,route);
			ps.setInt(5,sequence);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (user.equals(ChairProgramsDB.getChairName(conn,campus,alpha))){
					approver = new Approver();
					approver.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
					approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
					approver.setSeq(rs.getString("approver_seq"));
					approver.setMultiLevel(rs.getBoolean("multilevel"));
					approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
					approver.setLanid(rs.getString("addedby"));
					approver.setDte(rs.getString("addeddate"));

					approver.setAvailableDate(rs.getString("availableDate"));
					approver.setStartDate(rs.getString("startDate"));
					approver.setEndDate(rs.getString("endDate"));

					found = true;
				}
			}
			rs.close();
			ps.close();

			if (!found && debug)
				logger.info("approver not found in sequence " + route);
			else{
				logger.info("approver found in sequence " + route);
				return approver;
			}

			// 2 - person not found in the list at the requested sequence above.
			// is this person a DC?
			if (!found){
				/*
					figure out who is next and if division chair, get that name and
					set as our next approver.
				*/
				approver = ApproverDB.getNextPersonToApprove(conn,campus,alpha,num,route);

				if ("DIVISIONCHAIR".equals(approver.getApprover())){
					sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate " +
						"FROM tblApprover " +
						"WHERE (approver=? OR delegated=?) AND route=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,"DIVISIONCHAIR");
					ps.setString(2,"DIVISIONCHAIR");
					ps.setInt(3,route);
					rs = ps.executeQuery();
					if (rs.next()) {
						String divisionChair = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
						if (divisionChair.equals(user)){
							approver = new Approver();
							approver.setApprover(divisionChair);
							approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
							approver.setSeq(rs.getString("approver_seq"));
							approver.setMultiLevel(rs.getBoolean("multilevel"));
							approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
							approver.setLanid(rs.getString("addedby"));
							approver.setDte(rs.getString("addeddate"));

							approver.setAvailableDate(rs.getString("availableDate"));
							approver.setStartDate(rs.getString("startDate"));
							approver.setEndDate(rs.getString("endDate"));

							found = true;
						}
					}

					rs.close();
					ps.close();
				} // !found
			}

			if (!found && debug)
				logger.info("approver not found as DIVISIONCHAIR");
			else{
				logger.info("approver found as DIVISIONCHAIR");
				return approver;
			}

			// 3 - if still not found, possible case is program and if so, check division table
			if (!found && DivisionDB.isChair(conn,campus,num,user)){
				approver = new Approver();
				approver.setApprover(user);
				approver.setSeq("1");
				approver.setMultiLevel(false);
				found = true;
			}

			if (!found && debug)
				logger.info("approver not in division chair");
			else{
				logger.info("approver found in division chair");
				return approver;
			}

			// 4 - if still not found, possible case is program and if so, check division table
			if (!found && DivisionDB.isChairByAlpha(conn,campus,alpha,user)){
				approver = new Approver();
				approver.setApprover(user);
				approver.setSeq("1");
				approver.setMultiLevel(false);
				found = true;
			}

			if (!found && debug)
				logger.info("approver not in division chair by alpha");
			else{
				logger.info("approver found in division chair by alpha");
				return approver;
			}

			// 5 - if not found as individual, perhaps a distribution member
			if (!found){
				sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate "
					+ "FROM tblApprover "
					+ "WHERE campus=? AND route=? AND approver_seq=? "
					+ "ORDER BY approver_seq";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				ps.setInt(3,sequence);
				rs = ps.executeQuery();
				if (rs.next()) {
					approver = new Approver();
					String temp = AseUtil.nullToBlank(rs.getString("approver"));
					approver.setApprover(temp);
					approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
					approver.setSeq(rs.getString("approver_seq"));
					approver.setMultiLevel(rs.getBoolean("multilevel"));
					approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
					approver.setLanid(rs.getString("addedby"));
					approver.setDte(rs.getString("addeddate"));
					approver.setDistributionList(true);
					approver.setDistributionName(temp);

					String distributionMembers = DistributionDB.getDistributionMembers(conn,campus,approver.getApprover());
					if (distributionMembers != null && distributionMembers.length() > 0){
						if (distributionMembers.indexOf(user)>-1)
							found = true;
					}

					approver.setAvailableDate(rs.getString("availableDate"));
					approver.setStartDate(rs.getString("startDate"));
					approver.setEndDate(rs.getString("endDate"));
				}
				rs.close();
				ps.close();
			}

			if (!found && debug)
				logger.info("approver not in distribution list");
			else{
				logger.info("approver found in distribution list");
				return approver;
			}

			// 6 - if still not found, check to see if this person has a task to approve the outline
			if (!found && ApproverDB.hasApprovalTask(conn,campus,alpha,num,user)){
				found = true;
			}

			if (!found)
				approver = ApproverDB.getApprover(conn,user,route);

			if (!found && debug)
				logger.info("approver not assigned to a task");

			if (debug) logger.info("----------------- getApproverByNameAndSequence - END");

		} catch (Exception e) {
			logger.fatal("ApproverDB: getApproverByNameAndSequence - " + e.toString());
		}

		if (!found)
			approver = null;

		return approver;
	}

	/*
	 * finalizeOutlineWithoutNotification
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static int finalizeOutlineWithoutNotification(Connection conn){

/*
	THIS VERSION ALLOWS US TO FINALIZE AN OUTLINE WITHOUT SENDING NOTIFICATIONS TO ANYONE

	this was created to help clean up after KAP
*/

Logger logger = Logger.getLogger("test");

		int LAST_APPROVER 	= 2;
		int ERROR_CODE 		= 3;

		boolean debug = true;

		try{
String campus = "KAP";
String kix = "153k3j1078";
String thisApprover = "LR24";
String proposer = "SPOPE";
String user = "LR24";
String alpha = "BOT";
String num = "105";
String type = "PRE";
int route = 0;

			Msg msg = new Msg();

			MailerDB mailerDB;
			Mailer mailer = new Mailer();

			int rowsAffected = CourseApproval.removeApprovalTask(conn,kix,thisApprover,"LR24");
			mailer.setSubject("emailApproveOutline");
			mailer.setFrom(thisApprover);
			mailer.setTo(proposer);
			msg = processLastApprover(conn,kix,mailer,user);
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
														Constant.TASK_PROPOSER);
				if (debug) logger.info(kix + " CourseApproval - approveOutlineX - task recreated for - " + proposer);
			}
			else{
				AseUtil.logAction(conn, user, "ACTION","Outline final approval by "+ user,alpha,num,campus,kix);
				if (debug) logger.info(kix + " CourseApproval - approveOutlineX - last person - " + thisApprover);
			}

			rowsAffected = IniDB.updateNote(conn,route,"",user);
			if (debug) logger.info(kix + " CourseApproval - approveOutlineX - approval note cleared");

			// tell CC that this outline is available for viewing under report. this saves
			// time from having to locate the kix everytime attempting to review report
			CampusDB.updateCampusOutline(conn,kix,campus);
			if (debug) logger.info(kix + " CourseApproval - campus outline updated");
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return 0;

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

/*
	THIS VERSION ALLOWS US TO FINALIZE AN OUTLINE WITHOUT SENDING NOTIFICATIONS TO ANYONE

	this was created to help clean up after KAP
*/

Logger logger = Logger.getLogger("test");
int LAST_APPROVER 	= 2;
int ERROR_CODE 		= 3;

		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";
		String proposer = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		proposer = info[Constant.KIX_PROPOSER];
		campus = info[Constant.KIX_CAMPUS];

		String sql = "";
		int xyz = 0;
		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;

		boolean debug = false;

		try{
			/*
				1) approve the outline by moving to ARC, setting to CUR
				2) if all goes well, send notification, remove task
				3) if not, remove last history entry and have it done again
			*/
			msg = CourseApproval.finalizeOutline(campus,alpha,num,proposer);

			if (msg.getCode()==ERROR_CODE){
				sql = "DELETE FROM tblApprovalHist "
					+ "WHERE campus=? AND "
					+ "coursealpha=? AND "
					+ "coursenum=? AND "
					+ "approver=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, mailer.getFrom());
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info(kix + " - finalizeOutline failed");
				msg.setMsg("Exception");
			}
			else{

				boolean run = false;

				if (run){
					msg.setCode(LAST_APPROVER);

					MailerDB mailerDB = new MailerDB(conn,mailer.getFrom(),proposer,"","",alpha,num,campus,"emailApproveOutline",kix,user);
					if (debug) logger.info(kix + " - send mail emailApproveOutline");

					// notify and add task for registrar
					DistributionDB.notifyDistribution(conn,campus,alpha,num,"",mailer.getFrom(),"","","emailNotifiedWhenApproved","NotifiedWhenApproved",user);
					if (debug) logger.info(kix + " - send mail emailNotifiedWhenApproved");

					String createTaskForApprovedOutline = IniDB.getIniByCampusCategoryKidKey1(conn,
																		campus,
																		"System",
																		"createTaskForApprovedOutline");
					if ((Constant.ON).equals(createTaskForApprovedOutline)){
						String distributionMembers = DistributionDB.getDistributionMembers(conn,campus,"NotifiedWhenApproved");
						if (distributionMembers != null && distributionMembers.length() > 0){
							String[] tasks = new String[20];
							tasks = distributionMembers.split(",");
							for (int z=0;z<tasks.length;z++){
								rowsAffected = TaskDB.logTask(conn,tasks[z],proposer,alpha,num,Constant.APPROVED_TEXT,campus,"","ADD","CUR");
								if (debug) logger.info(kix + " - create task emailNotifiedWhenApproved - " + tasks[z]);
								AseUtil.logAction(conn,proposer,"ADD","Outline approved task ("+ tasks[z] + ")",alpha,num,campus,kix);
							} // for
						} // if distributionMembers
					} // if createTaskForApprovedOutline
				} // if run
			}  // if msg.getCode()==ERROR_CODE
		} catch (SQLException se) {
			logger.fatal(kix + " - CourseApproval: processLastApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal(kix + " - CourseApproval: processLastApprover - " + e.toString());
		}

		return msg;

	}

	public static History getLastApproverByRole(Connection conn,String kix,String role) throws Exception {

Logger logger = Logger.getLogger("test");

		History h = null;

		try{

			String sql = "SELECT * "
					+ "FROM tblApprovalHist "
					+ "WHERE id=("
					+ "SELECT MAX(id) AS maxID "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? "
					+ "AND role=? "
					+ ")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,role);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setID(rs.getInt("id"));
				h.setHistoryID(kix);
				h.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				h.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				h.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				h.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
				h.setApproved(rs.getBoolean("approved"));

System.out.println(h.getHistoryID());

				h.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				h.setVoteFor(NumericUtil.nullToZero(rs.getInt("votesfor")));
				h.setVoteAgainst(NumericUtil.nullToZero(rs.getInt("VotesAgainst")));
				h.setVoteAbstain(NumericUtil.nullToZero(rs.getInt("VotesAbstain")));
				h.setInviter(AseUtil.nullToBlank(rs.getString("inviter")));
				h.setSeq(NumericUtil.nullToZero(rs.getInt("seq")));
				h.setApproverSeq(NumericUtil.nullToZero(rs.getInt("approver_seq")));
				h.setDte(AseUtil.nullToBlank(rs.getString("dte")));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getLastApproverByRole - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getLastApproverByRole - " + ex.toString());
		}

		return h;
	}

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

	public static String fastTrackTest(Connection conn,String campus,String user){

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

			boolean testing = true;

			if (testing){
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? AND coursealpha='PHYS' AND coursenum='100'";

				debug = true;
			}
			else{
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? ";
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

					processOutline = false;

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

					listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
										+ "<td class=\"dataColumn\">" + alpha + " " + num + "</td>"
										+ "<td class=\"dataColumn\">" + progress + "</td>"
										+ "</tr>");

					History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
					if (h != null)
						lastApproverSeq = h.getApproverSeq();

					try{
						int maxSeq = ApproverDB.maxApproverSeqID(conn,campus,route);

						rowsAffected = ApproverDB.fastTrackApprovers(conn,campus,kix,1,maxSeq,route,user);
					}
					catch(Exception e){
						//
					}

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
						"<tr class=\""+campus+"BGColor\" height=\"30\">" +
						"<td valign=\"bottom\">Outline</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"</tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Outline not found</p>";

		return temp;
	} // fastTrackTest

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>