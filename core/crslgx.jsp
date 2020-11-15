<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslg.jsp
	*	2007.09.01	crslg.jsp
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "CC Log";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String y = website.getRequestParameter(request,"y","");
	String m = website.getRequestParameter(request,"m","");
	String d = website.getRequestParameter(request,"d","");
	String h = website.getRequestParameter(request,"h","");
	String mn = website.getRequestParameter(request,"mn","");

	out.println(SQLUtil.showUserLog(conn,y,m,d,h,mn,request,response));

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>