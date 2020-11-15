<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccutil.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Additional Forms";
	fieldsetTitle = pageTitle;
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
			<%= FormDB.getTextAsHTMLList(conn,campus) %>
		</td>
	</tr>
</table>

<%
	if (SQLUtil.isCampusAdmin(conn,user))
		out.println("<p align=\"left\"><img src=\"../images/tool.gif\" border=\"\" alt=\"forms maintenance\">&nbsp;<a href=\"crsfrmsidx.jsp\" class=\"linkcolumn\">forms maintenance</a></p>");

	asePool.freeConnection(conn);
%>


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
