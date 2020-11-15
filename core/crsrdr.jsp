<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrdr.jsp	reorder list
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix");
	int courseItem = website.getRequestParameter(request,"ci",0);
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	switch(courseItem){
		case Constant.COURSE_ITEM_PREREQ:
			fieldsetTitle = "Reorder Pre-Requisites";
			break;
		case Constant.COURSE_ITEM_COREQ:
			fieldsetTitle = "Reorder Co-Requisites";
			break;
		case Constant.COURSE_ITEM_SLO:
			fieldsetTitle = "Reorder SLO";
			break;
		case Constant.COURSE_ITEM_CONTENT:
			fieldsetTitle = "Reorder Course Contents";
			break;
		case Constant.COURSE_ITEM_COMPETENCIES:
			fieldsetTitle = "Reorder Competencies";
			break;
		case Constant.COURSE_ITEM_COURSE_RECPREP:
			fieldsetTitle = "Reorder Recommended Preparations";
			break;
		case Constant.COURSE_ITEM_PROGRAM_SLO:
			fieldsetTitle = "Reorder Program SLO";
			break;
		case Constant.COURSE_ITEM_ILO:
			fieldsetTitle = "Reorder Institution Learning Outcomes";
			break;
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
		String src = website.getRequestParameter(request,"src");
		String dst = website.getRequestParameter(request,"dst");

		out.println("<font class=\"textblackth\">"+pageTitle+"</font>");
		out.println(Reorder.reorderList(conn,courseItem,kix,src,dst));
	}

	asePool.freeConnection(conn,"crsrdr",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
