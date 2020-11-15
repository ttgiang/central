<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dbg.jsp	system debug values
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "System Settings";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true
			});
		});
	</script>
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
%>
		<form method="post" action="/central/servlet/sith" name="aseForm">
			<table width="100%" cellspacing='1' cellpadding='2' border="0">
				<tr>
					<td>
						<a href="/central/servlet/sith?bgs=1" class="linkcolumn">disable debuging</a>
					</td>
				</tr>
			</table>
		</form>

	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>Page</th>
							  <th>Debug</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Generic g: com.ase.aseutil.SysDB.getDebugSettings(conn)){ %>
						  <tr>
							 <td align="left"><a href="dbgmod.jsp?lid=<%=g.getString1()%>" class="linkcolumn"><%=g.getString1()%></a></td>
							 <td align="left"><%=g.getString2()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	} // processPage

	asePool.freeConnection(conn,"dbg",user);

%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>