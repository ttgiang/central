<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>
<%@
	page import="com.itextpdf.text.*,com.itextpdf.text.pdf.*,com.itextpdf.text.html.*,com.itextpdf.text.html.simpleparser.*"
%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="highslide.jsp" %>
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
	String alpha = "VIET";
	String num = "197F";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "e17j2f10174";
	String message = "";
	String url = "";
	//String src = "src";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			createNotifications(conn);
		}
		catch(Exception ce){
			//System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static void createNotifications(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;

		String campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");

		String prop = "emailApproveOutline,"
						+ "emailCancelOutlineApproval,"
						+ "emailCoreqAdded,"
						+ "emailCrossListAdded,"
						+ "emailNotifiedWhenApproved,"
						+ "emailNotifiedWhenCopy,"
						+ "emailNotifiedWhenDelete,"
						+ "emailNotifiedWhenRename,"
						+ "emailOutlineCancelReview,"
						+ "emailOutlineReassigned,"
						+ "emailOutlineRecalledApproval,"
						+ "emailOutlineReject,"
						+ "emailOutlineReviewCompleted,"
						+ "emailPrereqAdded,"
						+ "emailReviewerComment,"
						+ "emailReviewerInvite,"
						+ "emailOutlineApprovalRequest,"
						+ "emailOutlineCancelApproval,"
						+ "emailApproveProgram,"
						+ "emailCrossListingApproved,"
						+ "emailMessagePosted,"
						+ "emailNotifiedWhenProgramApproved,"
						+ "emailOutlineApprovalPacketRequest,"
						+ "emailOutlineTerminationNotice,"
						+ "emailProgramAdded,"
						+ "emailProgramApproval,"
						+ "emailProgramApprovalRequest,"
						+ "emailProgramApproved,"
						+ "emailProgramReject,"
						+ "emailProgramReviewCompleted,"
						+ "emailProperties,"
						+ "emailRejectOutline,"
						+ "emailRequiredElectiveAdded,"
						+ "emailRequiredOrElectiveApproval,"
						+ "emailRequisiteApproval,"
						+ "emailRequisiteApproved,"
						+ "emailRequisiteNotApproved,"
						+ "emailSendOnce,"
						+ "emailSLOApprovalCancelled,"
						+ "emailSLOApprovalCompleted,"
						+ "emailSLOApprovalRequest,"
						+ "emailSLOReviewCancelled,"
						+ "emailSLOReviewCompleted,"
						+ "emailSLOReviewRequest,"
						+ "emailTest,"
						+ "emailCrossListingNotApproved,"
						+ "emailProgramNotApproved"
						+ "emailApproveOutlineToApprovers"
						;

		String descr = "Notify proposer of approved outline.,"
						+ "Notification sent when outline approval has been cancelled,"
						+ "Notification sent after co-requisite has been added to an outline,"
						+ "Notification sent after cross-listed has been added to an outline,"
						+ "Notify registrar of approved outline,"
						+ "Notify campus user when and outline is being copied to another campus,"
						+ "Notify campus user when and outline is deleted,"
						+ "Notify campus user when and outline is renamed or renumbered,"
						+ "Notification sent when outline approval review has been cancelled,"
						+ "Sent when CC task is assigned from one user to another,"
						+ "Sent when outline approval is recalled,"
						+ "Sent when outline requires revision,"
						+ "Notification to proposer after review has been completed,"
						+ "Notification sent after pre-requisite has been added to an outline,"
						+ "Notification after comments are added by reviewer,"
						+ "Notification to review an outline,"
						+ "Send request for outline approval,"
						+ "Send notification to approvers that outline has approval has been cancelled,"
						+ "Notify proposer of approved program,"
						+ "Notify proposer when cross listed outline has been approved,"
						+ "Notification when a message has been posted to the message board,"
						+ "Notify proposer of approved program,"
						+ "Notify Division/Department chair when packet approval is ready,"
						+ "Notification sent when and outline is ready for termination,"
						+ "Notification sent when a program is linked to a course outline.,"
						+ "Sent when a linked program requires approval,"
						+ "Notification sent when a program is ready for approval,"
						+ "Notification sent after program linking has been approved,"
						+ "Notification sent when a program requires revision,"
						+ "Notification sent to inform proposer that reviews are completed,"
						+ "emailProperties,"
						+ "Sent when outline requires revision,"
						+ "Course outline linked to other division/department,"
						+ "Linking to other division/department requires approval.,"
						+ "Requested course outline - Pre/Co requisite approval,"
						+ "Course Outline - Pre/Co Requisite Approved,"
						+ "Course Outline - Pre/Co Requisite Not Approved,"
						+ "Daily Notification,"
						+ "Course outline SLO approval notification,"
						+ "Course outline SLO approval completed notification,"
						+ "Course outline SLO approval request notification,"
						+ "Course outline SLO review notification,"
						+ "Course outline SLO review completed,"
						+ "Course Outline SLO review notification,"
						+ "emailTest,"
						+ "Notify proposer when cross listed outline has not been approved,"
						+ "Notification sent after program linking has not been approved,"
						+ "Notification sent to approvers after outline/program has been approved,"
						;

		String subject = "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Co-Requisite Added,"
						+ "Course outline ([ALPHA] [NUM]) Cross List Added,"
						+ "Course outline ([ALPHA] [NUM]) Approved,"
						+ "Course outline ([ALPHA] [NUM]) Copied,"
						+ "Course outline ([ALPHA] [NUM]) Deleted,"
						+ "Course outline ([ALPHA] [NUM]) Renamed or Renumbered,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Review Completed,"
						+ "Course outline ([ALPHA] [NUM]) Pre-Requisite Added,"
						+ "Course outline ([ALPHA] [NUM]) Review Notification,"
						+ "Course outline ([ALPHA] [NUM]) Review Request,"
						+ "Course outline ([ALPHA] [NUM]) Approval Request,"
						+ "Course outline ([ALPHA] [NUM]) Approval Cancelled,"
						+ "Program Notification,"
						+ "Course outline ([ALPHA] [NUM]) - Cross Listing Approved,"
						+ "Course outline ([ALPHA] [NUM]) Message Board Notification,"
						+ "Program Approval Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Termination,"
						+ "Course outline ([ALPHA] [NUM]) - Program Linked,"
						+ "Course outline ([ALPHA] [NUM]) - Program link Approval Requested,"
						+ "Program is ready for your approval,"
						+ "Course outline ([ALPHA] [NUM]) - Program linked Approved,"
						+ "Your program requires revision,"
						+ "Program review completed,"
						+ "emailProperties,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) - Link to Other Division/Department,"
						+ "Linking to other division/department requires approval.,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Approval Requested,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Approved,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Not Approved,"
						+ "Daily Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Completed Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Request Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Completed,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Notification,"
						+ "emailTest,"
						+ "Course outline ([ALPHA] [NUM]) - Cross Listing Not Approved,"
						+ "Course outline ([ALPHA] [NUM]) - Program linked Not Approved"
						+ "Course outline ([ALPHA] [NUM]) - Approved"
						;

		String content = "Your outline [ALPHA] [NUM] was approved.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Co Requisite added to Outline.,"
						+ "Cross Listing added to Outline.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was recently approved.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was copied.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was deleted.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was renamed or renumbered.,"
						+ "Request for review of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Outline was reassigned to you.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been recalled.,"
						+ "Your outline requires revision.,"
						+ "Outline review has been completed.,"
						+ "Pre Requisite added to Outline.,"
						+ "Reviewer comments are availble for your outline.,"
						+ "Please review requested outline.,"
						+ "Outline is ready for your approval.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Your program was approved.,"
						+ "Cross listed outline was approved.,"
						+ "A message was posted to the message board for which you'd asked to be notified.,"
						+ "This is to inform you that your program was recently approved.,"
						+ "Outline is ready for packet approval,"
						+ "This is to inform you that outline [ALPHA] [NUM] is scheduled for termination.,"
						+ "Program linked to outline.,"
						+ "A program linked to a course outline requires approval.,"
						+ "Program is ready for your approval.,"
						+ "Program linking has been approved.,"
						+ "Your program requires revision.,"
						+ "Program review has been completed.,"
						+ "emailProperties,"
						+ "Your outline requires revision.,"
						+ "Other division/department linked to program or outline.,"
						+ "Other division/department linking requires approval.,"
						+ "Pre/Co requisite added to outline and requires approval.,"
						+ "Pre/Co requisite has been approved.,"
						+ "Pre/Co requisite were not approved.,"
						+ "This is an automatated daily notificaiton from Curriculum Central.,"
						+ "Request for approval of outline has been cancelled.,"
						+ "Outline SLO has been approved.,"
						+ "Outline SLO is ready for your approval.,"
						+ "Request for review of outline has been cancelled.,"
						+ "Outline SLO review has been completed.,"
						+ "Outline SLO is ready for your review.,"
						+ "emailTest,"
						+ "Cross listed outline was not approved.,"
						+ "Program linking was not approved."
						+ "Outline was approved."
						;

		String[] props = prop.split(",");
		String[] descrs = descr.split(",");
		String[] subjects = subject.split(",");
		String[] contents = content.split(",");
		String[] campuses = campus.split(",");

		System.out.println(props.length);
		System.out.println(descrs.length);
		System.out.println(subjects.length);
		System.out.println(contents.length);

		try {
			// remove current
			String sql = "DELETE FROM tblProps";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();

			// add new
			sql = "INSERT INTO tblprops(campus,propname,propdescr,subject,content,cc,auditby,auditdate) "
					+ "VALUES(?,?,?,?,?,'','SYSTEM',getdate())";

			for(j=0; j<campuses.length; j++){
				for(i=0; i<props.length; i++){
					ps = conn.prepareStatement(sql);
					ps.setString(1,campuses[j]);
					ps.setString(2,props[i]);
					ps.setString(3,descrs[i]);
					ps.setString(4,subjects[i]);
					ps.setString(5,contents[i]);
					int rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}
		} catch (SQLException e) {
			logger.fatal("CNV: createNotifications - " + e.toString() + " - " + props[i]);
		} catch (Exception e) {
			logger.fatal("CNV: createNotifications - " + e.toString() + " - " + props[i]);
		}

		return;
	}
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

