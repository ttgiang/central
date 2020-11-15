<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	vwcrsxy.jsp
	*	2007.09.01	view outline.
	*				for PRE and CUR, send directly to vwcrsx since there would always
	*				be only 1 of each. For ARC, show user all the different versions
	*
	**/

	//
	// experimental PDF work for sysadm only
	//

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","vwcrs");

	String user = website.getRequestParameter(request,"aseUserName","",true);

	String chromeWidth = "90%";
	String pageTitle = "View Outline";
	fieldsetTitle = "View Outline";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
		String kix = (String)session.getAttribute("kix");
		String rpt = (String)session.getAttribute("rpt");
		String tp = (String)session.getAttribute("tp");

		session.setAttribute("aseReport","outline");

		response.sendRedirect("/central/servlet/progress?kix="+ kix+"&rpt="+rpt+"&tp="+tp);
	}

	asePool.freeConnection(conn,"vwcrsxy",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
