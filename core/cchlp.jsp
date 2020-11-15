<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cchlp.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central (CC) Help";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String documentsURL = SysDB.getSys(conn,"documentsURL");

	asePool.freeConnection(conn,"cchlp",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%@ include file="idx.jsp" %>

<table align="center" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">

	<tr>
		<td valign="top">
			<h3 class="subheader">Faculty</h3>
			<ul>
				<li><a href="about.jsp" class="linkcolumn">About Curriculum Central</a></li>
				<li><a href="ccfaq.jsp" class="linkcolumn">Announcements</a></li>
				<li><a href="hlpidx.jsp" class="linkcolumn">Curriculum Central Help</a></li>

			<%
				if (SQLUtil.isSysAdmin(conn,user)){
			%>
					<li><a href="forum/dsplst.jsp?mnu=1" class="linkcolumn">Message Board</a></li>
			<%
				}
			%>

				<li><a href="rlsnotes.jsp" class="linkcolumn">Release Notes</a></li>
				<li><a href="ccnew.jsp" class="linkcolumn">Setting up CC</a></li>
				<li><a href="cccm6100.jsp" class="linkcolumn">View CCCM6100</a></li>
			</ul>
		</td>
		<td valign="top">
			<%
				if (SQLUtil.isCampusAdmin(conn,user) || SQLUtil.isSysAdmin(conn,user)){
			%>
				<h3 class="subheader">Campus Admin</h3>
			<%
				}
			%>
		</td>
		<td valign="top">
			<%
				if (SQLUtil.isSysAdmin(conn,user)){
			%>
				<h3 class="subheader">System Admin</h3>
				<ul>
					<li><a href="rqstidx.jsp" class="linkcolumn">View Request</a></li>
				</ul>
			<%
				}
			%>
		</td>
	</tr>
</table>

<p>&nbsp;</p>
<h3 class="subheaderleftjustify"><strong>Tutorial & Instructions</strong></h3>
<p>&nbsp;</p>
<table align="center" width="100%" border="0" id="table3" cellspacing="4" cellpadding="4">
	<tr>
		<td>
			<ul>
				<li><a href="<%=documentsURL%>help/CCBasics.pdf" class="linkcolumn" target="_blank">CC Basics</a></li>
				<li><a href="<%=documentsURL%>help/CCLogin.pdf" class="linkcolumn" target="_blank">CC Login</a></li>
				<li><a href="<%=documentsURL%>help/CCentralDCApproval.pdf" class="linkcolumn" target="_blank">Division Chair Approval</a></li>
				<li><a href="<%=documentsURL%>help/CCEditProfile.pdf" class="linkcolumn" target="_blank">Edit Profile</a></li>
				<li><a href="<%=documentsURL%>help/CCFastTrackApproval.pdf" class="linkcolumn" target="_blank">Fast Track Approval</a></li>
				<li><a href="<%=documentsURL%>help/CCItemMaintenance.pdf" class="linkcolumn" target="_blank">Item Maintenance</a></li>
				<li><a href="<%=documentsURL%>help/CCModifyCourse.pdf" class="linkcolumn" target="_blank">Modify Course</a></li>
				<li><a href="<%=documentsURL%>help/CCQuickListEntry.pdf" class="linkcolumn" target="_blank">Quick List Entry</a></li>
				<li><a href="<%=documentsURL%>help/CCentralReviewX.pdf" class="linkcolumn" target="_blank">Review</a></li>
				<li><a href="<%=documentsURL%>help/CCTaskMaintenance.pdf" class="linkcolumn" target="_blank">Task Maintenance</a></li>
			</ul>
		</td>
		<td valign="top">
			<ul>
				<li>Defect Reports&nbsp;
					(
						<a href="<%=documentsURL%>help/DefectReport.rtf" class="linkcolumn" target="_blank">RTF</a>
						&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
						<a href="<%=documentsURL%>help/DefectReport.doc" class="linkcolumn" target="_blank">Word 2003</a>
						&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
						<a href="<%=documentsURL%>help/DefectReport.docx" class="linkcolumn" target="_blank">Word 2007</a>
					)
				</li>
				<li><a href="<%=documentsURL%>help/ER00000-template.doc" class="linkcolumn" target="_blank">Enhancement Request</a></li>
			</ul>
		</td>
	</tr>
</table>

<p>&nbsp;</p>
<h3 class="subheaderleftjustify"><strong>Audio/Video Files</strong></h3>
<p>&nbsp;</p>
<table align="center" width="100%" border="0" id="table3" cellspacing="4" cellpadding="4">
	<tr>
		<td>
			<ul>
				<li><a href="<%=documentsURL%>help/V_ApproveOutine.swf" class="linkcolumn" target="_blank">Approve Outline</a></li>
				<li><a href="<%=documentsURL%>help/V_Explaining_Tabs.swf" class="linkcolumn" target="_blank">Course Tabs</a></li>
				<li><a href="<%=documentsURL%>help/V_EnterPrerequisite.swf" class="linkcolumn" target="_blank">Enter Prerequisites</a></li>
				<li><a href="<%=documentsURL%>help/V_EnterRecPrep.swf" class="linkcolumn" target="_blank">Enter Recommended Prep</a></li>
				<li><a href="<%=documentsURL%>help/V_AboveLoginScreen.swf" class="linkcolumn" target="_blank">How to Login</a></li>
				<li><a href="<%=documentsURL%>help/V_How_to_Log_Out.swf" class="linkcolumn" target="_blank">Logging Out</a></li>
			</ul>
		</td>
		<td>
			<ul>
				<li><a href="<%=documentsURL%>help/V_BannerMenuBar.swf" class="linkcolumn" target="_blank">Menu Bar</a></li>
				<li><a href="<%=documentsURL%>help/V_ModifyOutline.swf" class="linkcolumn" target="_blank">Modify Outline</a></li>
				<li><a href="<%=documentsURL%>help/V_ModifyTitle.swf" class="linkcolumn" target="_blank">Modify Title</a></li>
				<li><a href="<%=documentsURL%>help/V_seePSLOs.swf" class="linkcolumn" target="_blank">Program SLOs</a></li>
				<li><a href="<%=documentsURL%>help/V_Welcome_to_CC.swf" class="linkcolumn" target="_blank">Welcome to CC</a></li>
			</ul>
		</td>
	</tr>
</table>

<p>&nbsp;</p>
<h3 class="subheaderleftjustify"><strong>Icons</strong></h3>
<p>&nbsp;</p>
<table border="0" width="100%" id="table1">
	<tr>
		<td width="05%"><img src="../images/ext/pdf.gif" border="0"></td>
		<td width="45%">Display content in Adobe PDF format</td>
		<td width="05%"><img src="images/helpicon.gif" border="0"></td>
		<td width="45%">Display help for the current screen</td>
	</tr>
	<tr>
		<td width="05%"><img src="../images/vol.gif" border="0"></td>
		<td width="45%">Listen to help</td>
		<td width="05%"><img src="../images/ed_link.gif" border="0"></td>
		<td width="45%">Link outline items</td>
	</tr>
	<tr>
		<td width="05%"><img src="../images/printer.gif" border="0"></td>
		<td width="45%">Display printer friendly format</td>
		<td width="05%"><img src="images/comment.gif" border="0"></td>
		<td width="45%">view comments</td>
	</tr>
	<tr>
		<td width="05%"><img src="images/category.gif" border="0"></td>
		<td width="45%">Display outline items</td>
		<td width="05%"><img src="../images/comment.gif" border="0"></td>
		<td width="45%">Edit/add comments</td>
	</tr>
</table>

<p>&nbsp;</p>
<h3 class="subheaderleftjustify"><strong>Downloads</strong></h3>
<p>&nbsp;</p>
<table border="0" width="100%" id="table1">
	<tr>
		<td width="50"><img src="../images/quicktime.gif" border="0"></td>
		<td><a href="http://www.apple.com/quicktime/download" class="linkcolumn" target="_blank">Apple Quick Time player</a></td>
	</tr>
	<tr>
		<td width="50"><img src="../images/mp3.gif" border="0"></td>
		<td><a href="http://www.microsoft.com/windows/windowsmedia/download/" class="linkcolumn" target="_blank">Microsoft Windows Media Player</a></td>
	</tr>
	<tr>
		<td width="50"><img src="../images/swf.gif" border="0"></td>
		<td><a href="http://get.adobe.com/flashplayer/" class="linkcolumn" target="_blank">Adobe Flash Player</a></td>
	</tr>
</table>

<p>&nbsp;</p>
<table width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td bgcolor="#E0E0E0">
			NOTE: videos and tutorials were recorded and written using Kapiolani's questions and screen colors.
			<br/>Although there are differences	in the course items enabled for modifications and maintances,
			all process and options are identical across all campuses.
		</td>
	</tr>

</table>


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
