<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	expdltxx.jsp	- expedited delete
	*
	*	2013.01.17
	*
	*	In this process, an outline was approved for deletion using ReasonsForMods
	*	where the reason = DELETE. The course goes through the normal approval
	*	process. once approved, the course goes through here. the end result
	*	is moving a cur to arc
	*
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";
	String message = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Expedited Outline Delete";

	if (processPage && !kix.equals(Constant.BLANK) && type.equals(Constant.CUR)){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){

				CourseDelete cd = new CourseDelete();
				msg = cd.expeditedDelete(conn,campus,alpha,num,user);
				cd = null;

				message = "Outline deleted successfully";
			}
			else{
				message = "Invalid security code<br><br>Click <a href=\"expdltx.jsp?kix="+kix+"\" class=\"linkcolumn\">here</a> to try again.";
			}
		}	// form
	}
	else{
		message = "Invalid security code";
	} //processPage

	asePool.freeConnection(conn,"expdltxx",user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

