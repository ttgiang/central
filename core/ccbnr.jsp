<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccbnr.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Banner";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	asePool.freeConnection(conn,"crs",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">
		<tr>
			<td>
				<ul>
					<li><a href="rstrctns.jsp" class="linkcolumn">Class Restrictions</a></li>
					<li><a href="bnr.jsp" class="linkcolumn">Courses & Terms</a></li>
					<li><a href="alphaidx.jsp" class="linkcolumn">Course Alphas</a></li>
					<li><a href="cllgidx.jsp" class="linkcolumn">CollegesRequest</a></li>
					<li><a href="dprtmnt.jsp" class="linkcolumn">Departments</a></li>
					<li><a href="dvsn.jsp" class="linkcolumn">Divisions</a></li>
					<li><a href="stds.jsp" class="linkcolumn">Field of Study</a></li>
					<li><a href="lvlidx.jsp" class="linkcolumn">Levels</a></li>
					<li><a href="trms.jsp" class="linkcolumn">Terms</a></li>
				</ul>
			</td>
		</tr>
</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
