<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrtz.jsp	create new outline
	*	TODO is discipline a number or string?
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String message = "";
	String alpha = "";
	String num = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s")){
				alpha = website.getRequestParameter(request,"alpha","");
				num = website.getRequestParameter(request,"num","");
				if ( alpha.length() > 0 && num.length() > 0 ){
					String title = website.getRequestParameter(request,"title","");
					String comments = website.getRequestParameter(request,"comments","");
					String divisionCode = website.getRequestParameter(request,"divisionDDL","");
					String sloCode = website.getRequestParameter(request,"sloDDL","");

					/*
						1) in case user presses refresh button, do a check here first
						2) If not there, create
					*/
					boolean debug = false;

					if (debug){
						System.out.println("campus : " + campus);
						System.out.println("alpha : " + alpha);
						System.out.println("num : " + title);
						System.out.println("comments: " + comments);
						System.out.println("user : " + user);
						System.out.println("divisionCode : " + divisionCode);
						System.out.println("sloCode : " + sloCode);
					} // debug
					else{
						boolean exist = courseDB.courseExist(conn,campus,alpha,num);
						if (!exist){
							if (CourseCreate.createOutline(conn,alpha,num,title,comments,user,campus,divisionCode,sloCode,"")){
								message = "Outline (" + alpha + " " + num + " - " + title + ") created successfully.<br><br>" +
									"<a href=\"crsedt.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&view=PRE\" class=\"linkcolumn\">Continue to outline modifications</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +
									"<a href=\"vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE\" class=\"linkcolumn\">View outline</a>";
							}
							else{
								message = "Unable to create outline.";
							}
						}
						else{
							message = MsgDB.getMsgDetail("CourseExistCampusWide") +
								"<br><br><a href=\"vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE\" class=\"linkcolumn\">View outline</a>";;
						}
					} // debug
				}	// course alpha and num length
			}	// action = s
		}	// valid form
	}

	// GUI
	String chromeWidth = "70%";
	String pageTitle = "screen 4 of 4";
	fieldsetTitle = "Create New Outline";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"crscrtz",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%=message%></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
