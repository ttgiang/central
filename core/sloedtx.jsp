<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sloedtx.jsp
	*	2007.09.01
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "Update SLO Assessment";
	fieldsetTitle = pageTitle;

	String mode = website.getRequestParameter(request,"mode");
	boolean debug = false;
	boolean startApprovalProcess = false;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = "";
	String num = "";
	String type = "";
	String chk = "";
	String message = "";
	int i = 0;
	int answered = 0;				// number of items answered

	int lid = website.getRequestParameter(request,"lid",0);
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
		type = (String)session.getAttribute("aseType");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	if ( formName != null && formName.equals("aseForm") ){
		int controls = website.getRequestParameter(request,"controls",0);
		int controlsToShow = website.getRequestParameter(request,"controlsToShow",0);
		int chkCounter = 0;
		String answers;
		Vector<String> vector = new Vector<String>();

		/*
			1) retrieve form values and set to vector for call to servlet

			2) when successfully saved and all approvals are in (chkCounter=controls),
				then update tblcoursecomp with approval date and by

			chk is on, off or 1. on when checked from current session; off is not checked yet;
				1 is checked already and is displayed on screen.
		*/

		if (controlsToShow>0){
			for(i=0;i<controlsToShow;i++){
				answers = website.getRequestParameter(request,"ase_"+i);
				if (!"".equals(answers) && answers.length()>0)
					answered++;

				vector.addElement(new String(answers));
				chk = website.getRequestParameter(request,"chk"+i,"off");

				if ("on".equals(chk) || "1".equals(chk))
					++chkCounter;

				vector.addElement(new String(chk));
				if (debug){
					out.println(i + ":" + chk + "<br>" + answers + "<br>----");
				}
			}

			if (!debug){
				msg = AssessedDataDB.updateAssessedQuestions(conn,user,kix,lid,mode,vector,controlsToShow,formAction);
				if ("Exception".equals(msg.getMsg()))
					message = "SLO assessment update failed.<br><br>" + msg.getErrorLog();
				else{
					if (controlsToShow==Constant.SLO_ASSESS_QUESTION_COUNT && answered==Constant.SLO_ASSESS_QUESTION_COUNT){
						// if the number of control is equal to the number assessed and all answers are provided,
						//show the request for approval button.
						startApprovalProcess = true;
					}
				}
			}	// if debug
		}	// controlsToShow
	}	// valid form

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br><p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crsslo.jsp?kix=<%=kix%>&lid=<%=lid%>" class="linkcolumn">return to SLO assessment screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/vwcrsslo.jsp?kix=<%=kix%>" class="linkcolumn">View Outline SLO</a>

</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
