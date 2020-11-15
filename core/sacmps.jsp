<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sacmps.jsp - campus admin SA page
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "System Administrations";
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

	<!-- CLEAN -->
	<tr>
		<td width="72%" bgcolor="#E0E0E0"><b>Clean Up</b></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><a href="sausrlg.jsp" class="linkcolumn">Clean User Log</a></li>
				<li><a href="samllg.jsp" class="linkcolumn">Clean Mail Log</a></li>
				<li><a href="sahstlg.jsp" class="linkcolumn">Clean History Logs</a></li>
			</ul>
		</td>
	</tr>

	<!-- EXPORT -->
	<tr>
		<td width="72%" bgcolor="#E0E0E0"><b>Fixing Data</b></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><a href="crsxprt.jsp" class="linkcolumn">Export Campus Data</a></li>
			</ul>
		</td>
	</tr>

	<!-- MAINTENANCE -->
	<tr>
		<td width="72%" bgcolor="#E0E0E0"><b>Maintenance</b></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><a href="/central/core/dfqsts.jsp" class="linkcolumn">Course Item Definition</a></li>
				<li><a href="/central/core/crttpl.jsp" class="linkcolumn">Create Outline Template</a></li>
				<li><a href="/central/core/crsfld.jsp" class="linkcolumn">Display Course Content (raw data)</a></li>
				<li><a href="/central/core/jsid.jsp" class="linkcolumn">Session Audit</a></li>
				<li><a href="/central/core/verifySQL.jsp" class="linkcolumn">Verify SQL</a></li>
			</ul>
		</td>
	</tr>

	<!-- LOGS -->
	<tr>
		<td width="72%" bgcolor="#E0E0E0"><b>Logs</b></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><a href="/central/core/crslg.jsp" class="linkcolumn">CC Logs</a></li>
			</ul>
		</td>
	</tr>

	<!-- TEMPLATES -->
	<tr>
		<td width="72%" bgcolor="#E0E0E0"><b>Templates</b></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><a href="crttpl.jsp" class="linkcolumn">Create Outline Template</a></li>
			</ul>
		</td>
	</tr>

</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
