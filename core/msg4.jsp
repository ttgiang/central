<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	msg4.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String rtn = website.getRequestParameter(request,"rtn","");
	String kix = website.getRequestParameter(request,"kix", "");
	String enabledForEdits = website.getRequestParameter(request,"e", "");
	String bkmrk = website.getRequestParameter(request,"bkmrk", "");

	int mode = website.getRequestParameter(request,"md",0);

	String alpha = "";
	String num = "";
	String type = "";

	String[] info = null;

	boolean foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
	if(foundation){
		info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
	}
	else{
		info = helper.getKixInfo(conn,kix);
	}

	alpha = info[Constant.KIX_ALPHA];
	num = info[Constant.KIX_NUM];
	type = info[Constant.KIX_TYPE];

	//
	// message sent back from servlet
	//
	String message = (String)session.getAttribute("aseApplicationMessage");
	if (message==null){
		message = "";
	}

	//
	// data sent back from jqueryserlvet has bookmark used to return user to location
	// where reviewer/approver comments were made
	//
	String link = rtn + ".jsp?kix="+kix+"&e="+enabledForEdits+"#"+bkmrk;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%

	if(!bkmrk.equals(Constant.BLANK)){
		out.println(message + "<br><br><a href=\"/central/core/" + link + "\" class=\"linkcolumn\">return to previous page</a>");
	}

	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"msg4",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>