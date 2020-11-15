<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrtxx.jsp	create new outline.
	*	TODO: fndcrtxx.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";

	String pageTitle = "Edit Foundation Course Settings";

	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String message = "";
	//
	// id is available when coming in to adjust settings
	//
	int id = website.getRequestParameter(request,"id",0);
	if(id > 0){
		String authors = website.getRequestParameter(request,"formSelect","");
		String assessment = website.getRequestParameter(request,"assessment","");
		com.ase.aseutil.fnd.FndDB.updateFndSettings(conn,id,user,authors,assessment);
		message = "Foundation course settings updated.<br><br>Click <a href=\"fndedt.jsp?id="+id+"\" class=\"linkcolumn\">here</a> to edit foundation course.";
	}

	asePool.freeConnection(conn,"fndcrtxx",user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%=message%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
