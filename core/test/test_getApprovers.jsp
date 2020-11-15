<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "I44h24e971";
	String src = "x43";
	String dst = "I44h24e971";

	out.println("Start<br/>");
	//out.println(getApprovers(conn,campus,alpha,proposer,false));
	//out.println(setCourseForApprovalX(conn,campus,alpha,num,proposer,Constant.COURSE_DELETE_TEXT));

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static Approver getApprovers(Connection conn,
													String campus,
													String alpha,
													String user,
													boolean experimental) throws Exception {

		Logger logger = Logger.getLogger("test");

		StringBuffer allApprovers = new StringBuffer();
		StringBuffer allDelegates = new StringBuffer();
		StringBuffer allSequences = new StringBuffer();
		String thisApprover = "";
		String thisDelegated = "";
		String position = "";
		int thisSeq = 0;
		int currentSeq = 0;
		int firstSeq = 0;
		int nextSeq = 0;
		int prevSeq = 0;
		int lastSeq = -1;
		String sql = "";
		Approver approver = new Approver();

		// when the approver is not found, present list for user to select from
		boolean approverFound = false;

		try {
			user = user.toUpperCase();

			if (experimental)
				sql = "SELECT a.approver,a.delegated,a.approver_seq,u.position " +
					"FROM tblApprover a, tblUsers u " +
					"WHERE a.approver = u.userid AND " +
					"a.campus=? AND " +
					"a.experimental=0 " +
					"ORDER BY a.approver_seq";
			else
				sql = "SELECT a.approver,a.delegated,a.approver_seq,u.position " +
					"FROM tblApprover a, tblUsers u " +
					"WHERE a.approver = u.userid AND " +
					"a.campus=? " +
					"ORDER BY a.approver_seq";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				thisApprover = AseUtil.nullToBlank(results.getString("approver")).trim();
				thisDelegated = AseUtil.nullToBlank(results.getString("delegated")).trim();
				thisSeq = results.getInt("approver_seq");
				position = AseUtil.nullToBlank(results.getString("position")).trim();

				if (position.indexOf("DIVISION") >-1 ){
					thisApprover = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
					if (!"".equals(thisApprover))
						approverFound = true;
					//System.out.println("alpha: " + alpha + " - " + thisApprover + "/ (" + approverFound + ")");
				}

				// default empty delegates to the approve
				if ("".equals(thisDelegated))
					thisDelegated = thisApprover;

				// determine the current approver (-1 for array adjustment)
				if (user.trim().equals(thisApprover) && approver.getApprover().length() == 0) {
					currentSeq = thisSeq-1;
				}

				// csv representing list of approvers. Do not append if already there.
				// this happens when the division chair comes across
				if (!"".equals(thisApprover)){
					if (allApprovers.indexOf(thisApprover)<0){

						if (allApprovers.length() > 0){
							allApprovers.append(",");
							allDelegates.append(",");
							allSequences.append(",");
						}

						allApprovers.append(thisApprover);
						allDelegates.append(thisDelegated);
						allSequences.append(thisSeq);

						++lastSeq;
					}
				}
			}
			results.close();
			ps.close();

			// include the last approver
			if (thisApprover != null && thisApprover.length() > 0) {
				approver.setAllApprovers(allApprovers.toString());
				approver.setAllDelegates(allDelegates.toString());
				approver.setAllSequences(allSequences.toString());
			}

			// the array index is set as is shown below but the
			// actual sequence setting should be +1 to show the sequence
			// as starting from 1 and not 0 (user friendly)
			if (lastSeq >= 0) {
				nextSeq = currentSeq + 1;
				if (nextSeq > lastSeq)
					nextSeq = lastSeq;

				prevSeq = currentSeq - 1;
				if (prevSeq < 0)
					prevSeq = 0;

				String[] approvers = new String[lastSeq+1];
				approvers = allApprovers.toString().split(",");

				String[] delegates = new String[lastSeq+1];
				delegates = allDelegates.toString().split(",");

				approver.setApprover(approvers[currentSeq]);
				approver.setDelegated(delegates[currentSeq]);
				approver.setSeq(Integer.toString(++currentSeq));

				approver.setFirstApprover(approvers[0]);
				approver.setFirstDelegate(delegates[0]);
				approver.setFirstSequence(Integer.toString(1));

				approver.setPreviousApprover(approvers[prevSeq]);
				approver.setPreviousDelegate(delegates[prevSeq]);
				approver.setPreviousSequence(Integer.toString(++prevSeq));

				approver.setNextApprover(approvers[nextSeq]);
				approver.setNextDelegate(delegates[nextSeq]);
				approver.setNextSequence(Integer.toString(++nextSeq));

				approver.setLastApprover(approvers[lastSeq]);
				approver.setLastDelegate(delegates[lastSeq]);
				approver.setLastSequence(Integer.toString(++lastSeq));

				approver.setCompleteList(approverFound);
			}
		} catch (Exception e) {
			logger.fatal("ApproverDB: getApprovers\n" + e.toString());
			approver = null;
		}

		return approver;
	}

	private static Msg setCourseForApprovalX(Connection conn,
														String campus,
														String alpha,
														String num,
														String proposer,
														String mode) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		int lastSequence = 0;
		int nextSequence = 1;
		String lastApprover = "";
		String nextApprover = "";
		String sql = "";

		boolean approvalCompleted = false;

		Approver approver = new Approver();
		boolean approved = false;
		boolean experimental = true;
		PreparedStatement ps = null;

		long count = 0;

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		logger.info("-----------------------------------------------------------------");
		logger.info(kix + " - CourseDB - setCourseForApproval start");

		try {
			// experimental?
			if (num.indexOf("97") >= 0 || num.indexOf("98") >= 0)
				experimental = true;

			// get list of names. if approved, find next, else resend
			approver = ApproverDB.getApprovers(conn,campus,alpha,proposer,experimental);

			// break into array
			String[] approvers = new String[20];
			approvers = approver.getAllApprovers().split(",");

			// if nothing is in history, send mail to first up else who's next
			// get max sequence and determine who was last
			// if last approved, send to next; if last reject, resend
			count = ApproverDB.countApprovalHistory(conn,kix);
			if (count == 0){
				lastSequence = 1;
				nextSequence = 1;
				approved = false;
				nextApprover = approvers[0];
				lastApprover = nextApprover;
			}
			else{
				sql = "SELECT approver,approved " +
					"FROM tblApprovalHist " +
					"WHERE seq IN " +
					"(SELECT MAX(seq) AS Expr1 " +
					"FROM tblApprovalHist " +
					"WHERE historyid=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					lastApprover = AseUtil.nullToBlank(rs.getString("approver")).trim();
					approved = rs.getBoolean("approved");
					lastSequence = ApproverDB.getApproverSequence(conn,lastApprover);
				}
				rs.close();
				ps.close();
			}	// if count

			// if approved and not the last person, get next;
			// else where do we go back to
			if (approved){
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
				String ReturnToStartOnOutlineRejection = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ReturnToStartOnOutlineRejection");
				if ("0".equals(ReturnToStartOnOutlineRejection))
					nextApprover = lastApprover;
				else
					nextApprover = approvers[0];

				approvalCompleted = false;
			}	// if approved

			//logger.info("CourseDB - kix - " + kix);
			//logger.info("CourseDB - count - " + count);
			//logger.info("CourseDB - " + approver.getAllApprovers());
			//logger.info("CourseDB - lastApprover - " + lastApprover);
			//logger.info("CourseDB - nextApprover - " + nextApprover);
			//logger.info("CourseDB - approved - " + approved);
			//logger.info("CourseDB - lastSequence - " + lastSequence);
			//logger.info("CourseDB - nextSequence - " + nextSequence);
			//logger.info("CourseDB - approvalCompleted - " + approvalCompleted);

			if (!approvalCompleted){
				sql = "UPDATE tblCourse " +
					"SET edit=0,edit0='',edit1='3',edit2='3',progress='APPROVAL' " +
					"WHERE coursetype='PRE' AND " +
					"coursealpha=? AND " +
					"coursenum=? AND " +
					"campus=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				ps.setString(3,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.info(kix + " - CourseDB - setCourseForApproval - course set for approval");

				// delete modify task for author
				rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,"Modify outline",campus,"crsedt.jsp","REMOVE","PRE");
				logger.info(kix + " - CourseDB - setCourseForApproval - modify task removed - rowsAffected " + rowsAffected);

				// delete review tasks for all in this outline
				rowsAffected = TaskDB.logTask(conn,"ALL","ALL",alpha,num,"Review outline",campus,"crsedt.jsp","REMOVE","PRE");
				logger.info(kix + " - CourseDB - setCourseForApproval - review tasks removed - rowsAffected " + rowsAffected);

				//String ASE_PROPERTIES = "ase.central.Ase";

				ResourceBundle bundle = ResourceBundle.getBundle(ASE_PROPERTIES);
				String domain = "@" + bundle.getString("domain");
				String toNames = "";

				// if the approver list is not complete and there is no approval yet, it's because the division
				// chair was not decided or known. Forward user to list of division chairs to select from
				if (!approver.getCompleteList() && count== 0){
					msg.setCode(1);
					msg.setMsg("forwardURL");
				}
				else{
					rowsAffected = TaskDB.logTask(conn,nextApprover,proposer,alpha,num,"Approve outline",campus,"crsedt.jsp","ADD","PRE");
					logger.info(kix + " - CourseDB - setCourseForApproval - approval task created - rowsAffected " + rowsAffected);

					User udb = UserDB.getUserByName(conn,nextApprover);

					if (udb.getUH()==1)
						toNames = nextApprover + domain;
					else
						toNames = udb.getEmail();

					String sender = proposer + domain;
					MailerDB mailerDB = new MailerDB(conn,sender,toNames,"","",alpha,num,campus,"emailOutlineApprovalRequest",kix);
					logger.info(kix + " - CourseDB - setCourseForApproval - mail sent");
				}
			}

		} catch (SQLException ex) {
			logger.fatal(kix + " - CourseDB: setCourseForApproval\n" + ex.toString());
			msg.setMsg("CourseApprovalError");
		} catch (Exception e) {
			logger.fatal(kix + " - CourseDB: setCourseForApproval\n" + e.toString());
		}

		logger.info("-----------------------------------------------------------------");

		return msg;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
