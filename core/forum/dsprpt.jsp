<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dsprpt.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String thisPage = "dsprpt";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// when looking at a listing of forums, we clear the session to start over
	session.setAttribute("aseKix",null);

	String src = website.getRequestParameter(request,"src","");
	String cat = website.getRequestParameter(request,"cat","");
	String status = website.getRequestParameter(request,"status","");

	session.setAttribute("aseReport","defect");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<br/><br/>

<%
	if (processPage){
		out.println(ForumDB.displayReport(conn,src,catc));
	}

	asePool.freeConnection(conn,"dsprpt",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
