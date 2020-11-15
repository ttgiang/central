<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	Banner.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Banner";
	fieldsetTitle = pageTitle;
	asePool.freeConnection(conn,"banner","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<!--
<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td width="72%" colspan="3" bgcolor="#C0C0C0"><b><%=pageTitle%></b></td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Approval Status</td>
		<td valign="top" width="75%">Shows where an outline is in the approval process.
		This is a quick view to determine where in the queue the
		outline is and who is approving .</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Approve Outline</td>
		<td valign="top" width="75%">This action is available to anyone on the list of approvers.
		The person approving must wait for his/her turn and may not go out of sequence. The list of approvers is
		maintained by the campus administrator.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Assess Outline</td>
		<td valign="top" width="75%">Assess student learning outcomes/objectives/competencies by linking SLO/objectives
		competencies to assessment.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Assess SLO</td>
		<td valign="top" width="75%">Assess student learning outcomes/objectives/competencies by linking SLO/objectives
		competencies to assessment/evaluation techniques.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Cancel Proposed Outline</td>
		<td valign="top" width="75%">Cancels/withdraws a proposed outline that is going through modification/creation.
		Contents will be archived along with all reviewer comments.</td>
	</tr>

	<tr>
		<td width="2%" valign="top" height="29"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top" height="29">Copy Outline</td>
		<td valign="top" width="75%" height="29">Copies an existing outline to
		another course alpha/number combination. This action saves time by
		allowing the user to copy an existing outline and modifying its content.
		The resulting course is placed in proposed mode (pending modifications
		and approvals).
		<br>NOTE: Destination outline may not exist on any other campus.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Create Outline</td>
		<td valign="top" width="75%">Create a new outline.
		<br>NOTE: Destination outline may not exist on any other campus.</td>
		</td>
	</tr>

	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Cross Listing</td>
		<td valign="top" width="75%">Cross list a course by identifying other courses that are the same but have a different alpha or alpha & number. For example, PSY 202 is crosslisted with WS 202.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Delete Outline</td>
		<td valign="top" width="75%">Delete existing outline from the catalog. Prior to making the course inactive in Banner, the outline is archived in CC.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Invite Reviewers</td>
		<td valign="top" width="75%">Invite people to review outline content before seeking approval from Curriculum Committee/Faculty Senate.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Modify Approved Outline</td>
		<td valign="top" width="75%">Modify an existing outline</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Modify Proposed Outline</td>
		<td valign="top" width="75%">&nbsp;</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Renumber Outline</td>
		<td valign="top" width="75%">Change the alpha/number of an existing outline. This action
		also changes all cross-listed outlines, prerequisites, and corequisites.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Review Outline</td>
		<td valign="top" width="75%">Review a modified/proposed outline. This
		action is available to those invited to review an outline.<p>Reviews may
		proceed in any order and has a time limit.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">View Outline Content</td>
		<td valign="top" width="75%">Display the content of an outline</td>
	</tr>
</table>
-->

Under Construction!!!

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
