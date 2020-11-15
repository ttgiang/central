<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscat.jsp - course catalog (printer friendly)
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crsassr";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String discipline = website.getRequestParameter(request,"type");
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<table width="660" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" width="03%">&nbsp;</td>
		<td valign="top">
			<%
				String campus = website.getRequestParameter(request,"aseCampus","",true);
				out.println("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR/><BR/>");
				out.println(SyllabusDB.listCatalog(conn,campus,idx,discipline));
				asePool.freeConnection(conn);
			%>
		</td>
	</tr>
	<tr><td colspan="2" height="50" valign="bottom"><div class="hr"></div><p align="center" class="copyright"><%=aseUtil.copyright()%></p></td></tr>
</table>
</body>
</html>
