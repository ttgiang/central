<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prg.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Programs";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	asePool.freeConnection(conn,"prg",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">

		<tr>
			<td valign="top">
				<h3 class="subheader">Approval</h3>
				<ul>
					<li><a href="/central/core/prgsts.jsp" class="linkcolumn">Program Approval Status</a></li>
				</ul>
			</td>
			<td valign="top">
				<h3 class="subheader">Maintenance</h3>
				<ul>
					<li><a href="/central/core/prgvwidx.jsp" class="linkcolumn">Display Program</a></li>
				</ul>
			</td>
			<td valign="top">
				<h3 class="subheader">Review</h3>
				<ul>
					<li><a href="/central/core/prgrvwsts.jsp" class="linkcolumn">Program Review Status</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td valign="top" colspan="3">
				<h3 class="subheader">Progress</h3>
				<ul>
					<li><a href="/central/core/prgprgs.jsp" class="linkcolumn">Program Progress</a></li>
					<li><a href="/central/core/srchp.jsp" class="linkcolumn">Search Programs</a></li>
				</ul>
			</td>
		</tr>
		<%
			if (userLevel > Constant.FACULTY){
		%>
		<tr>
			<td valign="top" colspan="3">
			</td>
		</tr>
		<%
			}
		%>
</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
