<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscntntx.jsp	course content
	*	TODO	tie to work flow
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Outline Content";
	fieldsetTitle = pageTitle;
	String message = "";

	String alpha = "";
	String num = "";
	String type = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
		type = (String)session.getAttribute("aseType");
	}

	//out.println(alpha + "<br>");
	//out.println(num + "<br>");

	if (alpha.length() > 0 && num.length() > 0){
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);
		int reqID = website.getRequestParameter(request,"reqID",0);

		// action add or remove (a or r)
		String action = website.getRequestParameter(request,"act", "");

		//out.println(reqID+ "<br>");
		//out.println(action+ "<br>");

		// if all the values are in place, add or remove
		if ( action.length() > 0 ){
			String descr = website.getRequestParameter(request,"description");
			String content = website.getRequestParameter(request,"content");
			if ( "a".equals( action) || "r".equals( action) ){
				msg = ContentDB.addRemoveCourseContent(conn,action,campus,alpha,num,user,descr,content,reqID,kix);

				if (!"Exception".equals(msg.getMsg()))
					if (reqID > 0)
						message = "Content was deleted successfully";
					else
						message = "Content was saved successfully";
				else
					if (reqID > 0)
						message = "Unable to delete content";
					else
						message = "Unable to save content";
			}
		}
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crscntnt.jsp?kix=<%=kix%>" class="linkcolumn">return to CONTENT screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/crsedt.jsp?ts=<%=currentTab%>&no=<%=currentNo%>&kix=<%=kix%>" class="linkcolumn">return to outline modification</a>
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
