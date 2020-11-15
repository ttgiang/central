<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedt6y.jsp	- processing of approval/review confirmation
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";

	String alpha = "";
	String message = "";
	String sURL = "";
	String errorMsg = "";

	int action = 0;

	final int APPROVAL	= 1;
	final int REVIEW 		= 2;
	final int REVISE 		= 3;
	final int SUBMIT 		= 4;

	String formAction = website.getRequestParameter(request,"formAction");

	String formName = website.getRequestParameter(request,"formName");

	String progress = "";

	if (formAction.equalsIgnoreCase("a")){
		action = APPROVAL;
		progress = "APPROVAL";
	}
	else if (formAction.equalsIgnoreCase("v")){
		action = REVIEW;
		progress = "REVIEW";
	}
	else if (formAction.equalsIgnoreCase("r")){
		action = REVISE;
		progress = "REVISE";
	}
	else if (formAction.equalsIgnoreCase("s")){
		action = SUBMIT;
		progress = "APPROVAL";
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int route = website.getRequestParameter(request,"selectedRoute",0);
	String kix = website.getRequestParameter(request,"kix","");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
	}

	String pageTitle = "Program " + progress + " Request";
	fieldsetTitle = pageTitle;

	if (alpha != null){
		pageTitle = alpha;
	}

	boolean debug = false;

	if (processPage){
		if (debug){
			out.println( "campus: " + campus + "<br>");
			out.println( "alpha: " + alpha + "<br>");
			out.println( "progress: " + progress + "<br>");
			out.println( "action: " + action + "<br>");
			out.println( "formAction: " + formAction + "<br>");
			out.println( "skew: " + Skew.confirmEncodedValue(request) + "<br>");
		}
		else{
			if ( formName != null && formName.equals("aseForm") ){
				if (Skew.confirmEncodedValue(request)){

					if (action==APPROVAL){

						String outineSubmissionWithProgram = Util.getSessionMappedKey(session,"OutineSubmissionWithProgram");
						msg = ProgramsDB.setProgramForApproval(conn,campus,kix,user,user,route,outineSubmissionWithProgram);
						if ( "Exception".equals(msg.getMsg()) ){
							message = "Request for approval failed.<br><br>" + msg.getErrorLog();
						}
						else if ("forwardURL".equals(msg.getMsg()) ){
							sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
						}
						else if (!"".equals(msg.getMsg())){
							message = "Unable to initiate approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
						}
						else{
							message = "Program successfully submitted for approval.<br/><br/>";
						}

					} // skew
					else if (action==REVIEW){
						sURL = "crsrvw.jsp?kix=" + kix;
					}	// review

				} // skew
				else{
					message = "Invalid security code";
				}
			}	// form
		}	// if debug
	} //processPage

	asePool.freeConnection(conn,"prgedt6y",user);

	debug = false;

	if (debug){
		System.out.println(sURL);
	}
	else{
		if (!sURL.equals(Constant.BLANK)){
			response.sendRedirect(sURL);
		}
	}

	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
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
