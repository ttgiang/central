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

	if(!profile.equals(Constant.BLANK)){

		User userDB = com.ase.aseutil.UserDB.getUserByName(conn,profile);
		if(userDB != null){

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
					+ "<tr><td class=\"textblackth\" width=120px>Status:</td><td class=\"datacolumn\">" + userDB.getStatus() + "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=120px>Last Accessed:</td><td class=\"datacolumn\" valign=top>" + userDB.getLastUsed() + "</td></tr>"
					+ "</table>");

			userDB = null;

		} // valid user

	} // valid profile

	asePool.freeConnection(conn,"usridx_qtip",user);
%>

