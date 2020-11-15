<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "60%";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String user = (String)session.getAttribute("aseUserName");

	String sURL = "";
	String message = "";
	String temp = "";

	session.setAttribute("aseCallingPage","");

	boolean debug = false;
	int action = 0;
	int endOfThisTab = website.getRequestParameter(request,"endOfThisTab", 0);
	int recyclePage = website.getRequestParameter(request,"recyclePage", 0);
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String campus = (String)session.getAttribute("aseCampus");
	String kix = website.getRequestParameter(request,"kix");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Update Outline Content";

	if ( formName != null && formName.equals("aseForm") ){
		String currentNo = website.getRequestParameter(request,"lastNo");
		String data = website.getRequestParameter(request,"questions");
		String explain = website.getRequestParameter(request,"explain");
		String column = website.getRequestParameter(request,"column");
		String question_explain = website.getRequestParameter(request,"question_explain");
		String selectedCheckBoxes = website.getRequestParameter(request,"selectedCheckBoxes");
		String lock = website.getRequestParameter(request,"lock","false");

		/*
			numberOfControls exits when working with checks or radios. in this case
			we want to iterate the number of controls and collect their values.
		*/
		int numberOfControls = website.getRequestParameter(request,"numberOfControls", 0);
		if ( numberOfControls > 0 ){
			data = "";
			// 1 means that we have a radio or greater than 1 means check marks
			if ( numberOfControls == 1 ){
				data = website.getRequestParameter(request,"questions_0", "0");
			}
			else{
				data = selectedCheckBoxes;
			}
		}

		int nextNo = website.getRequestParameter(request,"no",0);
		int currentTab = website.getRequestParameter(request,"currentTab",0);

		if ( debug ){
			out.println( "alpha: " + alpha + "<br>");
			out.println( "num: " + num + "<br>");
			out.println( "campus: " + campus + "<br>");
			out.println( "currentNo: " + currentNo + "<br>");
			out.println( "currentTab: " + currentTab + "<br>");
			out.println( "data: " + data + "<br>");
			out.println( "explain: " + explain + "<br>");
			out.println( "question_explain: " + question_explain + "<br>");
			out.println( "formAction: " + formAction + "<br>");
			out.println( "msg code: " + msg.getCode() + "<br>");
			out.println( "column: " + column + "<br>");
			out.println( "numberOfControls: " + numberOfControls + "<br>");
			out.println( "selectedCheckBoxes: " + selectedCheckBoxes + "<br>");
			out.println( "session: " + session.getId().toString() + "<br>");

			if ("22".equals(currentNo)){
				for (int j=0; j<numberOfControls; j++)
					out.println("question_" + j + website.getRequestParameter(request,"questions_" + j) + "<br>");
			}
		}
		else{
			// tab 0 or the banner tab does not have updatable fields
			if (currentTab>0 && "false".equals(lock)){
				msg = courseDB.updateCourse(conn,
					currentNo,
					campus,
					alpha,
					num,
					column,
					data,
					explain,
					question_explain,
					session.getId().toString(),
					currentTab,
					user);
			}
			else{
				// to enter the next if condition. we know that on tab 0, it wouldn't matter
				// for tabs 1 and 2, rowsAffected is determine by the if of this else
				msg.setCode(0);
				msg.setMsg("");
			}

			if ( !"Exception".equals(msg.getMsg())){

				final int APPROVAL = 1;
				final int FINISH = 2;
				final int REVIEW = 3;
				final int SUBMIT = 4;

				if ( formAction.equalsIgnoreCase("a") ) action = APPROVAL;
				if ( formAction.equalsIgnoreCase("f") ) action = FINISH;
				if ( formAction.equalsIgnoreCase("r") ) action = REVIEW;
				if ( formAction.equalsIgnoreCase("s") ) action = SUBMIT;

				// if not desired to recycle back to item #1 at end of tab, end.
				if (endOfThisTab==1 && recyclePage==0)
					action = FINISH;

				switch (action){
					case APPROVAL :
						//NOTE: Code here is identical to REVIEW accept for PROGRESS
						session.setAttribute("aseAlpha", alpha);
						session.setAttribute("aseNum", num);

						session.setAttribute("aseModificationMode", "");
						session.setAttribute("aseWorkInProgress", "0");
						session.setAttribute("aseProgress", "APPROVAL");
						sURL = "crsedt6.jsp";
						break;
					case FINISH :
						// log user action
						session.setAttribute("aseModificationMode", "");
						aseUtil.logAction(conn,user,"crsedtx.jsp","Course edit completed",alpha,num,campus);

						message = "Outline modification has ended. You may return to make more modifications at any time.<br/><br/>" +
							"<a href=\"crsedt.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&view=PRE\" class=\"linkcolumn\">Modify outline</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +
							"<a href=\"vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE\" class=\"linkcolumn\">View outline</a>&nbsp;&nbsp;|&nbsp;&nbsp;" +
							"<a href=\"tasks.jsp\" class=\"linkcolumn\">View my tasks</a>";
						session.setAttribute("aseWorkInProgress", "0");
						break;
					case REVIEW :
						//NOTE: Code here is identical to APPROVAL accept for PROGRESS
						session.setAttribute("aseAlpha", alpha);
						session.setAttribute("aseNum", num);

						session.setAttribute("aseModificationMode", "");
						session.setAttribute("aseWorkInProgress", "0");
						session.setAttribute("aseProgress", "REVIEW");
						sURL = "crsedt6.jsp";
						break;
					case SUBMIT :
						sURL = "crsedt.jsp?ts=" + currentTab + "&no=" + nextNo + "&alpha=" + alpha + "&num=" + num;
						break;
				}	// switch
			}
			else{
				message = "Outline update failed.<br>";
			}	// msg
		}	// if debug
	}	// valid form

	asePool.freeConnection(conn);

	// clear these values when done
	if (formAction.equalsIgnoreCase("f")){
		session.setAttribute("aseAlpha", null);
		session.setAttribute("aseNum", null);
	}

	/*
		redirects to the correct URL

		if endOfThisTab == 1 then it's likely that we are on the last question for
		the tab. Also, if we are in add mode, then push to the third tab.
	*/
	String modificationMode = (String)session.getAttribute("aseModificationMode");

	if (endOfThisTab==1 && "A".equals(modificationMode))
		response.sendRedirect("crsedt.jsp?ts=2&alpha="+alpha+"&num="+num);
	else
		if (!debug && message.length() == 0)
			response.sendRedirect(sURL);
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
