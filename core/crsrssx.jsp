<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrssx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Reassign Ownership";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsrssx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		String fromName = website.getRequestParameter(request,"fromList", "");
		String toName = website.getRequestParameter(request,"toList", "");

		out.println( "Reassigning from <font class=\"textblackth\">" + fromName + "</font> to <font class=\"textblackth\">" + toName + "</font><br><br>");
		out.println(Outlines.listAssignedTasks(conn,campus,fromName,toName));
	}

	asePool.freeConnection(conn,"crsrssx",user);
%>

<p align="left"><font class="textblackth">NOTE:</font> place a check mark to the left of the outline you wish to transfer. Toggling the top most check box selects or deselects all check boxes.</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>