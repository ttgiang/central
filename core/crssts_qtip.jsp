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

		User userDB = com.ase.aseutil.UserDB.getUserByName(conn,profile);
		if(userDB != null){

			String filename = aseUtil.getCurrentDrive()
								+ ":"
								+ com.ase.aseutil.SysDB.getSys(conn,"documents")
								+ "profiles\\"+profile.toUpperCase()+".png";

			int postsToForumByUser = com.ase.aseutil.ForumDB.countPostsToForumByUser(conn,kix,profile);

			String image = profile;
			File prfl = new File(filename);
			if(!prfl.exists()){
				image = "profile";
			}

			out.println("<table width=400 border=0>"
					+ "<tr><td width=100px rowspan=4>"
					+
					"<img src=\"/centraldocs/docs/profiles/"+image+".png\" alt=\""+profile+"\" title=\""+profile+"\">"
					+ "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=100px>Status:</td><td class=\"datacolumn\">" + userDB.getStatus() + "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=100px>Last Accessed:</td><td class=\"datacolumn\" valign=top>" + userDB.getLastUsed() + "</td></tr>"
					+ "<tr><td class=\"textblackth\" width=100px>Actions:</td><td class=\"datacolumn\" valign=\"top\">" + profile + " has added " + postsToForumByUser + " messages</td></tr>"
					+ "</table>");

			userDB = null;

		} // valid user

	} // valid profile

	asePool.freeConnection(conn,"crssts_qtip",user);

%>

