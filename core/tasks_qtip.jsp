<%@ include file="ase.jsp" %>
<%@ page import="java.io.File"%>

<%
	/**
	*	ASE
	*	prfl.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Lab";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String profile = website.getRequestParameter(request,"p","");
	String kix = website.getRequestParameter(request,"kix","");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];

	if(!profile.equals(Constant.BLANK) && !kix.equals(Constant.BLANK)){

		Task task = com.ase.aseutil.TaskDB.getUserTask(conn,campus,alpha,num,profile,user);
		if(task != null){

			String filename = aseUtil.getCurrentDrive()
								+ ":"
								+ com.ase.aseutil.SysDB.getSys(conn,"documents")
								+ "profiles\\"+profile.toUpperCase()+".png";

			//
			// place all code depending on 'profile' above this line
			//
			String output = "photo not available.";
			File prfl = new File(filename);
			if(!prfl.exists()){
				profile = "profile";
			}

			out.println("<table width=400 border=0>"
					+ "<tr><td width=100px rowspan=3>"
					+
					"<img src=\"/centraldocs/docs/profiles/"+profile+".png\" alt=\""+profile+"\" title=\""+profile+"\">"
					+ "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=100px>Task created on:</td><td class=\"datacolumn\">" + task.getDte() + "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=100px>Description:</td><td class=\"datacolumn\" valign=\"top\">" + task.getMessage() + "</td></tr>"
					+ "</table>");

			task = null;

		} // valid user

	} // valid profile

	asePool.freeConnection(conn,"tasks_qtip",user);
%>
