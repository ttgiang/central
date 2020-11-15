<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgvw.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "80%";
	String pageTitle = "View Program";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");

	String kix = website.getRequestParameter(request,"kix", "");
	String type = website.getRequestParameter(request,"type", "");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="10" leftmargin="10">
<table width="660">
	<tr>
		<td valign="top">
			<%
				String campus = Util.getSessionMappedKey(session,"aseCampus");
				String user = Util.getSessionMappedKey(session,"aseUserName");

				try{
					if (processPage){
						out.println("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "</p>");
						out.println(ProgramsDB.viewProgram(conn,campus,kix,type));
					}
				}
				catch( Exception e ){
					//out.println(e.toString());
				}

				asePool.freeConnection(conn,"prgvwx",user);
			%>
		</td>
	</tr>
	<tr><td height="50" valign="bottom"><div class="hr"></div><p align="center" class="copyright"><%=aseUtil.copyright()%></p></td></tr>
</table>

</body>
</html>
