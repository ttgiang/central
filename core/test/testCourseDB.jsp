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
	String alpha = "ART";
	String num = "114";
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
			out.println(isCourseReviewer(conn,campus,alpha,num,user));
		}
		catch(Exception ce){
			//System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static boolean isCourseReviewer(Connection conn,String campus,String alpha,String num,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		boolean reviewer = false;
		boolean debug = false;

		int counter = 0;

		try {
			if (debug) logger.info("--------------------- START");

			String today = (new SimpleDateFormat("MM/d/yyyy")).format(new java.util.Date());

			if (debug) logger.info("today: " + today);

			String table = "tblReviewers tbr INNER JOIN tblCourse tc ON "
					+ "(tbr.campus = tc.campus) AND "
					+ "(tbr.coursenum = tc.CourseNum) AND "
					+ "(tbr.coursealpha = tc.CourseAlpha) ";

			String where = "GROUP BY tbr.coursealpha,tbr.coursenum,tc.CourseType,tbr.userid,tc.reviewdate "
					+ "HAVING (tbr.coursealpha='"
					+ SQLUtil.encode(alpha)
					+ "' AND  "
					+ "tbr.coursenum='"
					+ SQLUtil.encode(num)
					+ "' AND  "
					+ "tc.CourseType='PRE' AND  "
					+ "tbr.userid='"
					+ SQLUtil.encode(user)
					+ "' AND "
					+ "tc.reviewdate>=\'"
					+ SQLUtil.encode(today) + "\')";


System.out.println(table);
System.out.println(where);

			counter = (int) AseUtil.countRecords(conn,table,where);

			if (debug) logger.info("counter: " + counter);

			if (counter > 0)
				reviewer = true;

			if (debug) logger.info("--------------------- END");

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseReviewer - " + e.toString());
			reviewer = false;
		}

		return reviewer;
	}

	public static boolean getNextApprover(Connection conn,String campus,String alpha,String num,String user) throws SQLException {

Logger logger = Logger.getLogger("test");

		boolean debug = true;

		boolean nextApprover = false;
		boolean multiLevel = false;
		int userSequence = 0;
		int lastSequenceToApprove = 0;
		int nextSequence = 0;

		boolean lastApproverVotedNO = false;

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);

		try {
			debug = DebugDB.getDebug(conn,"CourseDB");

debug = true;

			if (debug) logger.info("----------------- getNextApprover - STARTS");

			if (debug) logger.info("kix: " + kix);

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

			String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);
			boolean recalledApprovalHistory = HistoryDB.recalledApprovalHistory(conn,kix,alpha,num,user);
			if (taskAssignedToApprover != null
				&& taskAssignedToApprover.length() > 0
				&& taskAssignedToApprover.equals(user)
				&& recalledApprovalHistory){
				return true;
			}

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

					if (debug) logger.info("REJECT_START_WITH_REJECTER");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-1));

					lastSequenceToApprove = lastSequenceToApprove - 1;
				}
				else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
					// figure out who was last to disapprove. get that sequence and subtract 2.
					// subtract 1 to accommodate going back by one step.
					// however, nextSequence is lastSequenceToApprove + 1 so subtract another for that
					lastSequenceToApprove = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

					if (debug) logger.info("REJECT_STEP_BACK_ONE");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-2));

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

					if (debug) logger.info("REJECT_APPROVER_SELECTS");
					if (debug) logger.info("taskAssignedToApprover: " + taskAssignedToApprover);

					lastSequenceToApprove = lastSequenceToApprove - 1;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
			} // lastApproverVotedNO
			else
				lastSequenceToApprove = CourseDB.getLastSequenceToApprove(conn,campus,alpha,num);

			if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);

			// was lastSequenceToApprove a distribution list? if yes, is approval for distribution completed?
			boolean isDistributionList = false;
			boolean distributionApprovalCompleted = true;

			String distributionList = ApproverDB.getApproversBySeq(conn,campus,lastSequenceToApprove,route);

			if (distributionList != null && distributionList.length() > 0)
				isDistributionList = DistributionDB.isDistributionList(conn,campus,distributionList);

			if (isDistributionList)
				distributionApprovalCompleted = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distributionList,lastSequenceToApprove);

			if (debug) logger.info("distributionList: " + distributionList);
			if (debug) logger.info("isDistributionList: " + isDistributionList);
			if (debug) logger.info("distributionApprovalCompleted: " + distributionApprovalCompleted);

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
				if (debug) logger.info("route: " + route);

				Approver approver = ApproverDB.getApproverByNameAndSequence(conn,campus,alpha,num,user,route,nextSequence);
				if (approver != null) {
					if (debug) logger.info("approver: " + approver);

					if (approver.getSeq() != null && approver.getSeq().length() > 0){
						userSequence = Integer.parseInt(approver.getSeq());
						if (debug) logger.info("userSequence: " + userSequence);
					}

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

					if (debug) logger.info("nextApprover: " + nextApprover);
					if (debug) logger.info("multiLevel: " + multiLevel);

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
					if (debug) logger.info("approver sequence not found");

					nextApprover = false;
				} // approver = null
			}	// route > 0
			else
				nextApprover = false;

			if (debug) logger.info("----------------- getNextApprover - END");

		} catch (SQLException e) {
			logger.fatal("CourseDB: getNextApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getNextApprover - " + ex.toString());
		}

		return nextApprover;
	} // nextApprover

	public static boolean isNextApprover(Connection conn,String campus,String alpha,String num,String user) throws SQLException {

Logger logger = Logger.getLogger("test");

		boolean debug = true;

		boolean nextApprover = false;
		boolean multiLevel = false;
		int userSequence = 0;
		int lastSequenceToApprove = 0;
		int nextSequence = 0;

		boolean lastApproverVotedNO = false;

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);

		try {
			debug = DebugDB.getDebug(conn,"CourseDB");

debug = true;

			if (debug) logger.info("----------------- isNextApprover - STARTS");

			if (debug) logger.info("kix: " + kix);

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

			String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);
			boolean recalledApprovalHistory = HistoryDB.recalledApprovalHistory(conn,kix,alpha,num,user);
			if (taskAssignedToApprover != null
				&& taskAssignedToApprover.length() > 0
				&& taskAssignedToApprover.equals(user)
				&& recalledApprovalHistory){
				return true;
			}

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

					if (debug) logger.info("REJECT_START_WITH_REJECTER");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-1));

					lastSequenceToApprove = lastSequenceToApprove - 1;
				}
				else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
					// figure out who was last to disapprove. get that sequence and subtract 2.
					// subtract 1 to accommodate going back by one step.
					// however, nextSequence is lastSequenceToApprove + 1 so subtract another for that
					lastSequenceToApprove = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

					if (debug) logger.info("REJECT_STEP_BACK_ONE");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-2));

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

					if (debug) logger.info("REJECT_APPROVER_SELECTS");
					if (debug) logger.info("taskAssignedToApprover: " + taskAssignedToApprover);

					lastSequenceToApprove = lastSequenceToApprove - 1;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
			} // lastApproverVotedNO
			else
				lastSequenceToApprove = CourseDB.getLastSequenceToApprove(conn,campus,alpha,num);

			if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);

			// was lastSequenceToApprove a distribution list? if yes, is approval for distribution completed?
			boolean isDistributionList = false;
			boolean distributionApprovalCompleted = true;

			String distributionList = ApproverDB.getApproversBySeq(conn,campus,lastSequenceToApprove,route);

			if (distributionList != null && distributionList.length() > 0)
				isDistributionList = DistributionDB.isDistributionList(conn,campus,distributionList);

			if (isDistributionList)
				distributionApprovalCompleted = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distributionList,lastSequenceToApprove);

			if (debug) logger.info("distributionList: " + distributionList);
			if (debug) logger.info("isDistributionList: " + isDistributionList);
			if (debug) logger.info("distributionApprovalCompleted: " + distributionApprovalCompleted);

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
				if (debug) logger.info("route: " + route);

				Approver approver = ApproverDB.getApproverByNameAndSequence(conn,campus,alpha,num,user,route,nextSequence);
				if (approver != null) {
					if (debug) logger.info("approver: " + approver);

					if (approver.getSeq() != null && approver.getSeq().length() > 0){
						userSequence = Integer.parseInt(approver.getSeq());
						if (debug) logger.info("userSequence: " + userSequence);
					}

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

					if (debug) logger.info("nextApprover: " + nextApprover);
					if (debug) logger.info("multiLevel: " + multiLevel);

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
					if (debug) logger.info("approver sequence not found");

					nextApprover = false;
				} // approver = null
			}	// route > 0
			else
				nextApprover = false;

			if (debug) logger.info("----------------- isNextApprover - END");

		} catch (SQLException e) {
			logger.fatal("CourseDB: isNextApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: isNextApprover - " + ex.toString());
		}

		return nextApprover;
	} // nextApprover

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>