<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdocs.jsp - first implementation of JQUERY
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI

	String pageTitle = "";
	String docType = website.getRequestParameter(request,"t","c");
	String docStatus = website.getRequestParameter(request,"s","a");

	if (docType.equals("c")){
		pageTitle = "Course Documents";
	}
	else{
		pageTitle = "Program Documents";
	}

	fieldsetTitle = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="./js/listnav/listnavmeta.jsp" %>

</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%@ include file="./js/listnav/listnavheader.jsp" %>

<%
	if (processPage){
		out.println(helper.listWordDocsJquery(conn,campus,docType,docStatus));
	}

	asePool.freeConnection(conn,"crsdocs",user);
%>

<%@ include file="./js/listnav/listnavfooter.jsp" %>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
