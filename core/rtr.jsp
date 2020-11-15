<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rtr.jsp	- to get exactly to the right condition
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String rtn = website.getRequestParameter(request,"rtn","");

	asePool.freeConnection(conn,"rtr",user);

	if (rtn.equals(Constant.BLANK)){
		response.sendRedirect("/central/core/tasks.jsp");
	}
	else{
		response.sendRedirect("/central/core/" + rtn + ".jsp");
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
