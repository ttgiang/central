<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	pgrchry.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String message = "";
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean debug = false;

	if (processPage){
		String formSelect = website.getRequestParameter(request,"formSelect");
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		int programid = website.getRequestParameter(request,"programid",0);

		if (debug){
			out.println("campus: " + campus + "</br>");
			out.println("user: " + user + "</br>");
			out.println("formSelect: " + formSelect + "</br>");
			out.println("programid: " + programid + "</br>");
		}
		else{
			if ( formName != null && formName.equals("aseForm") ){
				if ( "s".equalsIgnoreCase(formAction) ){
					if ( programid > 0 ){
						ChairProgramsDB.setProgramAlphs(conn,programid,formSelect);
						message = "Operation completed successfully<br/><br/>"
							+ "<a href=\"dividx.jsp\" class=\"linkcolumn\">return</a> to degree listing";
					}	// course alpha and num length
				}	// action = s
			}	// valid form
		}	// debug
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Alpha Selection";
	fieldsetTitle = "Alpha Selection";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<p align="center">
<%
	if (processPage)
		out.println(message);

	asePool.freeConnection(conn,"pgrchry",user);
%>
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
