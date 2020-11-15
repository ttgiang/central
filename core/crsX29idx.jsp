<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsX29idx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");
	String type = website.getRequestParameter(request,"type","CUR");

	String src = website.getRequestParameter(request,"src");
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		if ((Constant.COURSE_PROGRAM).equals(src)){
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
		}
		else if ((Constant.PROGRAM_RATIONALE).equals(src)){
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];
		}
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
	}

	String reqType = (String)session.getAttribute("aseRequisite");

	String pageTitle = "Other Departments";
	fieldsetTitle = pageTitle;

	int reqID = website.getRequestParameter(request,"reqID",0);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String message = "";
	String url = "";

	if ( processPage && alpha.length() > 0 ){

		String grading = website.getRequestParameter(request,"alpha_ID");

		if ((Constant.COURSE_PROGRAM).equals(src))
			url = "crsedt.jsp?ts="+currentTab+"&no="+currentNo+"&kix="+kix;
		else if ((Constant.PROGRAM_RATIONALE).equals(src)){
			url = "prgedt.jsp?kix="+kix;
			alpha = "";
			num = "";
		}

		// action is to add or remove (a or r)
		String action = website.getRequestParameter(request,"ack", "");
		String lid = website.getRequestParameter(request,"lid","");

		// if all the values are in place, add or remove
		if ( action.length() > 0 ){
			if ("a".equals(action) || "r".equals(action)){

				int id = website.getRequestParameter(request,"id",0);

				if ("r".equals(action))
					id = Integer.parseInt(lid);

				int rowsAffected = ExtraDB.addRemoveExtraX(conn,
																		kix,
																		action,
																		src,
																		alpha,
																		num,
																		grading,
																		user,
																		id);

				if (rowsAffected == -1){
					message = "Course alpha already selected";
				}
				else if (rowsAffected > 0){
					message = "Data saved successfully.";
				}
				else{
					message = "Unable to save data";
				}
			}	// if action
		}	// if action
	}	// if alpha length

	asePool.freeConnection(conn,"crsx29idx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crsX29.jsp?kix=<%=kix%>&src=<%=src%>" class="linkcolumn">return to <%=pageTitle%> screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/<%=url%>" class="linkcolumn">return to modification</a>
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
