<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwx.jsp
	*	2007.09.01
	*	TODO: when inviting more reviewers, be careful not to send message to existing reviewers
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String message = "";
	String campus = "";
	String user = "";
	String kix = "";
	String alpha = "";
	String num = "";

	boolean isAProgram = false;
	boolean foundation = false;

	if (processPage){
		String formSelect = website.getRequestParameter(request,"formSelect");
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		String reviewDate = website.getRequestParameter(request,"reviewDate","");
		String comments = website.getRequestParameter(request,"comments","");

		campus = Util.getSessionMappedKey(session,"aseCampus");
		user = Util.getSessionMappedKey(session,"aseUserName");
		kix = website.getRequestParameter(request,"kix","");

		isAProgram = ProgramsDB.isAProgram(conn,kix);

		if(!isAProgram){
			foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
		}

		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");

		//
		// REVIEW_IN_REVIEW
		//
		int level = website.getRequestParameter(request,"level",0);

		boolean debug = false;

		if (debug){
			out.println("campus: " + campus + "</br>");
			out.println("isAProgram: " + isAProgram + "</br>");
			out.println("foundation: " + foundation + "</br>");
			out.println("kix: " + kix + "</br>");
			out.println("alpha: " + alpha + "</br>");
			out.println("num: " + num + "</br>");
			out.println("user: " + user + "</br>");
			out.println("formSelect: " + formSelect + "</br>");
			out.println("reviewDate: " + reviewDate + "</br>");
			out.println("comments: " + comments + "</br>");
		}
		else{
			if ( formName != null && formName.equals("aseForm") ){
				if ( formAction.equalsIgnoreCase("s") ){
					if ( (alpha.length() > 0 && num.length() > 0) || kix.length() > 0 ){
						boolean setReviewers = ReviewerDB.setCourseReviewers(conn,
																								campus,
																								alpha,
																								num,
																								user,
																								formSelect,
																								reviewDate,
																								comments,
																								kix,
																								level);
						String reviewers = formSelect;
						String reviewersForDisplay = EmailListsDB.expandListNames(conn,campus,user,reviewers);
						if (setReviewers){
							if (reviewersForDisplay.equals(","))
								message = "Operation completed successfully";
							else
								message = "Review request sent to the following: " + reviewersForDisplay;
						}
						else{
							message = "Unable to send review request to: " + reviewersForDisplay;
						} // setReviewers
					}	// course alpha and num length
				}	// action = s
			}	// valid form
		}	// debug
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	if(foundation){
		fieldsetTitle = "Review Foundation Course";
	}
	else{
		if(isAProgram){
			fieldsetTitle = "Review Program";
		}
		else{
			fieldsetTitle = "Review Outline";
		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsrvw.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage)
		out.println(message);

	asePool.freeConnection(conn,"crsrvwx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

