<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slo.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "SLOs";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	asePool.freeConnection(conn,"slo",user);
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
				<h3 class="subheader">Maintenance</h3>
				<ul>
					<li><a href="/central/core/crscmp.jsp?kix=mnu&edt=PRE" class="linkcolumn">Edit SLO</a></li>
					<li><a href="/central/core/crsaslo.jsp" class="linkcolumn">Assess SLO</a></li>
					<li><a href="/central/core/crsacan.jsp" class="linkcolumn">Cancel Assessment</a></li>
				</ul>
			</td>
		</tr>

		<tr>
			<td>
				<h3 class="subheader">Review</h3>
				<ul>
					<li><a href="/central/core/crscmpzz.jsp" class="linkcolumn">Request SLO Review</a></li>
					<li><a href="/central/core/crsrwslo.jsp" class="linkcolumn">Review SLO</a></li>
					<li><a href="/central/core/crscanslo.jsp?edt=PRE" class="linkcolumn">Cancel Review Request</a></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td>
				<h3 class="subheader">Approval</h3>
				<ul>
					<li><a href="/central/core/crssloappr.jsp?edt=PRE" class="linkcolumn">Request Approval</a></li>
					<li><a href="/central/core/crsapprslo.jsp" class="linkcolumn">Approve SLO</a></li>
					<li><a href="/central/core/crssloapprcan.jsp?edt=PRE" class="linkcolumn">Cancel Approval Request</a></li>
				</ul>
			</td>
		</tr>

</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
