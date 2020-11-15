<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccfaq.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String documentsURL = SysDB.getSys(conn,"documentsURL");

	String pageTitle = "CC Announcements";
	fieldsetTitle = "CC Announcements";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%@ include file="idx.jsp" %>

<table border="0" width="100%" cellpadding="2">
	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="textblackth">Date</td>
		<td width="90%" valign="top" class="textblackth">Description</td>
	</tr>
<!--
	<tr>
		<td width="10%" valign="top" class="datacolumn">June 2012</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/coursecatalog.pdf" title="course catalog" target="_blank" class="linkcolumn">User defined course catalog</a></li>
		</ul>
		</td>
	</tr>
-->
	<tr>
		<td width="10%" valign="top" class="datacolumn">September 2013</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/footerstatus.pdf" title="footer status" target="_blank" class="linkcolumn">Audit Stamp</a></li>
			<li><a href="<%=documentsURL%>faq/notifiedduringapproval.pdf" title="notified during approval" target="_blank" class="linkcolumn">Email notification during approval</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">May 2013</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/messageboard.pdf" title="message board" target="_blank" class="linkcolumn">Message Board - approver/reviewer comments with proposer</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">March 2013</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/usermaintenance.pdf" title="User maintenance" target="_blank" class="linkcolumn">User maintenance</a></li>
			<li><a href="<%=documentsURL%>faq/ReasonsforModifications.pdf" title="Expedited deletes" target="_blank" class="linkcolumn">Expedited deletes</a></li>
			<li><a href="<%=documentsURL%>faq/effectiveterm.pdf" title="Limiting effective terms" target="_blank" class="linkcolumn">Limiting effective terms</a></li>
			<li>Course outline & Program search</li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">June 2012</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/approvercomments.pdf" title="View approver comments" target="_blank" class="linkcolumn">View approver comments</a></li>
			<li><a href="<%=documentsURL%>faq/emailnotificationtoapprovers.pdf" title="Notify approvers when outline has been approved" target="_blank" class="linkcolumn">Notify approvers when outline has been approved</a></li>
			<li><a href="<%=documentsURL%>faq/emailattachment.pdf" title="email attachment" target="_blank" class="linkcolumn">Send outline/programs with email notification</a></li>
			<li><a href="<%=documentsURL%>faq/coursemodification.pdf" title="course modification" target="_blank" class="linkcolumn">Enhanced course modification display</a></li>
			<li><a href="<%=documentsURL%>faq/hideshowitems.pdf" title="hide/show items" target="_blank" class="linkcolumn">Hide/Show items enabled for modifications</a></li>
			<li><a href="<%=documentsURL%>faq/approvalemail.pdf" title="approvalemail" target="_blank" class="linkcolumn">Aprpoval email FROM field set to last approver or proposer</a></li>
			<li><a href="<%=documentsURL%>faq/compareitems.pdf" title="compare items" target="_blank" class="linkcolumn">Compare similar items system wide</a></li>
			<li><a href="<%=documentsURL%>faq/headertext.pdf" title="header text" target="_blank" class="linkcolumn">Display short questions when printing outlines</a></li>
			<li><a href="<%=documentsURL%>faq/additionalalphas.pdf" title="additional alphas" target="_blank" class="linkcolumn">Access to all alphas</a></li>
			<li><a href="<%=documentsURL%>faq/showgeslolinktoevals.pdf" title="show GESLO links to evaluations" target="_blank" class="linkcolumn">Show GESLO links to Evaluations</a></li>
			<li><a href="<%=documentsURL%>faq/activitylog.pdf" title="activity log" target="_blank" class="linkcolumn">Activity log search</a></li>
			<li><a href="<%=documentsURL%>faq/resequenceapproval.pdf" title="re-sequence approval" target="_blank" class="linkcolumn">Re-sequence approvers</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">December 2011</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/announcements.pdf" title="announcement" target="_blank" class="linkcolumn">Compiled Announcement</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">November 2011</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/approvalroutingaspackets.pdf" title="approval routing as packet" target="_blank" class="linkcolumn">Approval Routing as Packets</a></li>
			<li><a href="<%=documentsURL%>faq/CourseRenameRenumber.pdf" title="course rename/renumber" target="_blank" class="linkcolumn">Course Rename/renumber</a></li>
			<li><a href="<%=documentsURL%>faq/CreateCourse.pdf" title="create new course outline" target="_blank" class="linkcolumn">Create New Course Outline</a></li>
			<li><a href="<%=documentsURL%>faq/departmentdropdownlist.pdf" title="department drop down list" target="_blank" class="linkcolumn">Department Drop Down List</a></li>
			<li><a href="<%=documentsURL%>faq/dailynotification.pdf" title="email notification" target="_blank" class="linkcolumn">Email Notification</a></li>
			<li><a href="<%=documentsURL%>faq/extrabuttons.pdf" title="extra button" target="_blank" class="linkcolumn">Enable/disable extra button</a></li>
			<li><a href="<%=documentsURL%>faq/flextable.pdf" title="email notification" target="_blank" class="linkcolumn">Flex Tables</a></li>
			<li><a href="<%=documentsURL%>faq/generaleducation.pdf" title="general education SLO display" target="_blank" class="linkcolumn">General Education SLO</a></li>
			<li><a href="<%=documentsURL%>faq/outlineapprovalaspackets.pdf" title="outline approvals as packet" target="_blank" class="linkcolumn">Outlines Approvals as Packets</a></li>
			<li><a href="<%=documentsURL%>faq/QuickComment.pdf" title="quick comments" target="_blank" class="linkcolumn">Quick Comments</a></li>
			<li><a href="<%=documentsURL%>faq/sendmailfromtest.pdf" title="send mail from test" target="_blank" class="linkcolumn">Send mail from TEST system</a></li>
			<li><a href="<%=documentsURL%>faq/textwordcounter.pdf" title="email notification" target="_blank" class="linkcolumn">Text/Word Counter</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">September 2011</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/DisplayCourseTitle.pdf" title="display course title" target="_blank" class="linkcolumn">Display Course Title</a></li>
			<li><a href="<%=documentsURL%>faq/ReasonsforModifications.pdf" title="reasons for modificaitons" target="_blank" class="linkcolumn">Reasons for Modifications</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">August 2010</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/announcements-2010-08-16.pdf" title="" target="_blank" class="linkcolumn">See attached document</a></li>
			<li><a href="<%=documentsURL%>faq/itemmaintenance.pdf" title="item  maintenance" target="_blank" class="linkcolumn">Course/campus item maintenance</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">April 2010</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/import.pdf" title="import data" target="_blank" class="linkcolumn">Import Data</a></li>
			<li><a href="<%=documentsURL%>faq/outlinecompare.pdf" title="Compare Outline Items" class="linkcolumn">Compare outline items</a></li>
			<li><a href="?" title="Enable Outline Items" class="linkcolumn">Coming Soon!! Enable outline items during review</a></li>
			<li><a href="?" title="Required Outline Items" class="linkcolumn">Coming Soon!! Required outline items during modifications</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">January 2010</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/systemlist.pdf" title="System Listings" target="_blank" class="linkcolumn">System Listings</a></li>
			<li><a href="<%=documentsURL%>faq/approvedoutlinetask.pdf" title="Approved Outline Task" target="_blank" class="linkcolumn">Approved outline task</a></li>
			<li><a href="<%=documentsURL%>faq/dailynotification.pdf" title="Daily Notification" target="_blank" class="linkcolumn">Send daily notifications</a></li>
			<li><a href="<%=documentsURL%>faq/outlinecreate.pdf" title="Outline Create" target="_blank" class="linkcolumn">Create Outline (with Program SLO if available)</a></li>
			<li><a href="<%=documentsURL%>faq/quickpsloentry.pdf" title="Quick PSLO Entry" target="_blank" class="linkcolumn">Quick Program SLO Entry</a></li>
			<li><a href="<%=documentsURL%>faq/linkeditems.pdf" title="Linked Outline Items" target="_blank" class="linkcolumn">Linked Outline Items</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">December 2009</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/outlinerestore.pdf" title="Outline Restore" target="_blank" class="linkcolumn">Restoring a cancelled/withdrawn outline</a></li>
			<li><a href="<%=documentsURL%>faq/outlineapproval.pdf" title="Outline Approval" target="_blank" class="linkcolumn">Outline Approval Explained</a></li>
			<li><a href="<%=documentsURL%>faq/showkeydescription.pdf" title="Show Key Description" target="_blank" class="linkcolumn">Display abbreviated or full system values</a></li>
			<li><a href="<%=documentsURL%>faq/outlineapprovalreview.pdf" title="Outline Approval Review" target="_blank" class="linkcolumn">Outline Approval Review - include reviews during the approval process</a></li>
			<li><a href="<%=documentsURL%>faq/personalemaillist.pdf" title="Email List" target="_blank" class="linkcolumn">Personal Email Distribution List - list of frequently sent to names</a></li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">October 2009</a></td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/copy-n-paste.pdf" title="Copy and Paste" target="_blank" class="linkcolumn">Copy and Paste</a> - Depending on the source of the cut-n-past, the data may contain characters that CC does not understand. For example, MS-Word inserts many characters that confuses CC. The way to work through this is explained in the attached document.</li>
			<li><a href="<%=documentsURL%>faq/approverinstructions.pdf" title="Approver Instructions" target="_blank" class="linkcolumn">Approver Instructions</a> - ability to include instructions to outline approvers</li>
		</ul>
		</td>
	</tr>
	<tr>
		<td width="10%" valign="top" class="datacolumn">September 2009</td>
		<td width="90%" valign="top" class="datacolumn">
		<ul>
			<li><a href="<%=documentsURL%>faq/fasttrackapproval.pdf" title="Fast Track Approval" target="_blank" class="linkcolumn">Fast Track Approval</a> - ability to fast track the approval process. This option is permitted for CC campus administrator only</li>
			<li><a href="<%=documentsURL%>faq/taskmaintenance.pdf" title="Task Maintenance" target="_blank" class="linkcolumn">Task Maintenance - add/remove erroneous tasks</a></li>
			<li><a href="<%=documentsURL%>faq/additionalalphas.pdf" title="Additional Alphas" target="_blank" class="linkcolumn">Additional Alphas</a> - ability to include multiple alphas to faculty profiles</li>
		</ul>
		</td>
	</tr>
	</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
