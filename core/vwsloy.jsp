<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwsloy.jsp
	*	2007.09.01	view outline slo
	*
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "90%";
	String pageTitle = "View Outline SLO";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase3.jsp" %>
</head>
<body topmargin="10" leftmargin="10">
<table width="660">
	<tr>
		<td valign="top" width="03%">&nbsp;</td>
		<td valign="top">
			<%
				String campus = website.getRequestParameter(request,"aseCampus","",true);
				String alpha = (String)session.getAttribute("aseAlpha");
				String num = (String)session.getAttribute("aseNum");
				String type = (String)session.getAttribute("aseType");
				StringBuffer slo = Outlines.viewOutlineSLO(conn,campus,alpha,num,type);

				out.println("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<BR>");
				out.println(courseDB.setPageTitle(conn,"",alpha,num,campus) + "</p>");

				out.println(slo.toString());

				asePool.freeConnection(conn);
			%>
		</td>
	</tr>
	<tr><td colspan="2" height="50" valign="bottom"><div class="hr"></div><p align="center" class="copyright"><%=aseUtil.copyright()%></p></td></tr>
</table>
</body>
</html>
