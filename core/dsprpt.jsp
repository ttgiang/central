<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dsprpt.jsp - display forum report
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("exp.jsp");
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
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="10" leftmargin="10">

<%
	if (processPage){
		out.println(ForumDB.displayReport(conn,src,cat));
	}

	asePool.freeConnection(conn,"dsprpt",user);
%>


</body>
</html>
