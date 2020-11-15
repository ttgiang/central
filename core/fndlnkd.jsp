<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndlnkd.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String type = "PRE";
	String fndType = "";
	String courseTitle = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	String courseKix = "";
	int id = website.getRequestParameter(request,"id", 0);
	String kix = fnd.getFndItem(conn,id,"historyid");
	if(!kix.equals(Constant.BLANK)){
		String[] info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		courseTitle = info[Constant.KIX_COURSETITLE];
		fndType = info[Constant.KIX_ROUTE];

		info = Helper.getKixRoute(conn,campus,alpha,num,"CUR");
		courseKix = info[0];
	}

	fnd = null;

	String pageTitle = alpha + " " + num + " - " + courseTitle + "<br/>" + fndType + " - " + fnd.getFoundationDescr(fndType);

	// GUI
	String chromeWidth = "100%";
	fieldsetTitle = "Link Foundation Items";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/fndlnkr.js"></script>
</head><body topmargin="0" leftmargin="0">

<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		if(CompDB.hasSLOs(conn,courseKix)){
			out.println(com.ase.aseutil.fnd.FndDB.getLinkedItems(conn,campus,user,id,kix,Constant.COURSE_OBJECTIVES,false));
		}
		else{
			out.println("Course objectives not found for linking");
		}
	}

	asePool.freeConnection(conn,"fndlnkd",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
</body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

