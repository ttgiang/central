<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsxtridx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String pageTitle = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");
	String type = website.getRequestParameter(request,"type","CUR");
	String src = website.getRequestParameter(request,"src","");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
	}

	if ((Constant.COURSE_RECPREP).equals(src)){
		pageTitle = "Recommended Preparation";
	}
	else if ((Constant.COURSE_PROGRAM_SLO).equals(src)){
		pageTitle = "Program SLO";
	}

	fieldsetTitle = pageTitle;

	int reqID = website.getRequestParameter(request,"reqID",0);

	String message = "";

	if (processPage && alpha.length()>0 && num.length()>0){
		String alphaX = website.getRequestParameter(request,"alpha_ID");
		String numX = website.getRequestParameter(request,"numbers_ID");
		String grading = website.getRequestParameter(request,"grading");

		// action is to add or remove (a or r)
		String action = website.getRequestParameter(request,"act", "");

		// if all the values are in place, add or remove
		if ( action.length() > 0 ){
			if ( alphaX.length() > 0 && numX.length() > 0 ){
				if ("a".equals(action) || "r".equals(action)){
					int rowsAffected = ExtraDB.addRemoveExtra(conn,kix,action,src,alphaX,numX,grading,user,reqID);
					if (rowsAffected == -1){
						message = "Course alpha and number already set as " + pageTitle + ".";
					}
					else if (rowsAffected > 0){
						message = "Data saved successfully.";
					}
					else{
						message = "Unable to save data";
					}
				}	// if action
			}	// if alphax length
		}	// if action
	}	// if alpha length

	asePool.freeConnection(conn,"crsxtridx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crsxtr.jsp?kix=<%=kix%>&src=<%=src%>" class="linkcolumn">return to <%=pageTitle%> screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;

<%
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	if(caller.equals("crsfldy")){
%>
		<a href="crsfldy.jsp?cps=<%=campus%>&kix=<%=kix%>" class="linkcolumn">return to raw edit</a>
<%
	}
	else {
%>
		<a href="/central/core/crsedt.jsp?ts=<%=currentTab%>&no=<%=currentNo%>&kix=<%=kix%>" class="linkcolumn">return to outline modification</a>
<%
	} // where to return caller
%>

</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
