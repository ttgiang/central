<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crs.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Courses";
	fieldsetTitle = pageTitle;
	asePool.freeConnection(conn);
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td width="72%" colspan="6" bgcolor="#C0C0C0"><b>Administrative</b></td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="65%" colspan="5">
		<table border="0" width="100%" id="table3">
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='appridx.jsp'>Approver Sequence Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Display order of approval by campus</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='crsassidx.jsp'>Assessment Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Display assessment by campus</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='apprl.jsp'>Approval Status</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Display status of approval for a
				course</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='bnr.jsp'>Banner Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Listing of courses from Banner</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='cmps.jsp'>Campus Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Listing of institution (campuses)</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='catidx.jsp'>Catalog Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Catalog listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='disciplineidx.jsp'>College Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">College or course listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='ini.jsp'>Configuration Key Maintenance</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Administrative key settings</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='alphaidx.jsp'>Course Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Course listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='newsidx.jsp'>News Maintenance</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">News listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='stmtidx.jsp'>Statement Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">General statement listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='sylidx.jsp'>Syllabus Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Syllabus listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='tasks.jsp'>Task Listing</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">User task listing</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='usrlog.jsp'>User Activity Log</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">User action log</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='usridx.jsp'>User Maintenance</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">User maintenance</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='crsfld.jsp'>View Course Content</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">Display content of a course</td>
			</tr>
			<tr>
				<td width="5%" height="20"><img src="../images/arrow.gif" border="0"></td>
				<td width="28%" height="20"><a class='SiteLink' href='maillog.jsp'>View Mail Log</a></td>
				<td width="3%" height="20">&nbsp;</td>
				<td width="62%" height="20">View mail log</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="72%" colspan="6" bgcolor="#C0C0C0"><b>Maintenance</b></td>
	</tr>
	<tr>
		<td width="1%">x</td>
		<td width="21%"><a class='SiteLink' href='dividx.jsp'>dividx.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%"><a class='SiteLink' href='div.jsp'>div.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">x</td>
		<td width="21%"><a class='SiteLink' href='posidx.jsp'>posidx.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%"><a class='SiteLink' href='pos.jsp'>pos.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='questions.jsp'>questions.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Question maintenance (crsquest?)</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="72%" colspan="6" bgcolor="#C0C0C0"><b>Pending</b></td>
		</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%">
		<a class='SiteLink' href='con_alpha.jsp'>
		con_alpha.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Convert alpha</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='con_number.jsp'>con_number.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Convert number</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='coursemaint.jsp'>coursemaint.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='cpy.jsp'>cpy.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Copy course</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='crs_assess.jsp'>crs_assess.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Display assessed course</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='crs_de.jsp'>crs_de.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">Display DE course</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='dspcrs.jsp'>dspcrs.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='progidx.jsp'>progidx.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%"><a class='SiteLink' href='prog.jsp'>prog.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%"><a class='SiteLink' href='program.jsp'>program.jsp</a></td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='review.jsp'>review.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='role.jsp'>role.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='rptcourse.jsp'>rptcourse.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%"><a class='SiteLink' href='rptcrsslo.jsp'>rptcrsslo.jsp</a></td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
	<tr>
		<td width="1%">&nbsp;</td>
		<td width="21%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
		<td width="2%">&nbsp;</td>
		<td width="23%">&nbsp;</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
