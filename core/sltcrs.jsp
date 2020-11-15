<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%!
	/**
	*	ASE
	*	sltcrs.jsp
	*	2007.09.01	driver to select course and table. Caller page contains
	*					name of page that called this driver. Once done, it will
	*					be sent back to the caller page with the course, num and view.
	**/

	// global declaration
	String progress = "";
%>

<%
	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("")){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseWorkInProgress", "0");

	String chromeWidth = "80%";
	String pageTitle = "";
	String alpha = null;
	String num = null;
	String viewOption = null;
	String message = "";
	String campus = "";
	String rtn = "";					// if caller is to go somewhere, this is the value for where
	String proposer = "";
	String url = "";

	String user = website.getRequestParameter(request,"aseUserName","",true);
	String jsid = (String)session.getId();

	boolean simple = false;			// display selection for using AJAX

	boolean useKix = false;			// use kix as passing parameter
	String kix = "";					// kix value
	String kixType = "PRE";			// type for kix data

	boolean debug = false;

%>

<%@ include file="pages.jsp" %>

<%
	String formName = website.getRequestParameter(request,"formName","");
	String callerPage = website.getRequestParameter(request,"cp", "");
	viewOption = website.getRequestParameter(request,"viewOption");

	if (callerPage.length() > 0){
		if ( "apprl".equals(callerPage)){
			pageTitle = "Outline Approval Status";
			codeName = APPRL;
		}
		else if ("crsappr".equals(callerPage)){
			pageTitle = "Outline Approval";
			codeName = CRSAPPR;
			progress = Constant.COURSE_APPROVAL_TEXT;
			simple = true;
		}
		else if ("crsapprslo".equals(callerPage)){
			pageTitle = "SLO Approval";
			codeName = CRSAPPRSLO;
			progress = Constant.COURSE_APPROVAL_TEXT;
			simple = true;
		}
		else if ("crscan".equals(callerPage)){
			pageTitle = "Cancel Proposed Outline";
			codeName = CRSCAN;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
			useKix = true;
		}
		else if ("crscpy".equals(callerPage)){
			pageTitle = "Copy Outline";
			codeName = CRSCPY;
			progress = Constant.COURSE_APPROVED_TEXT;
		}
		else if ("crscrt".equals(callerPage)){
			pageTitle = "Create New Outline";
			codeName = CRSCRT;
		}
		else if ("crsdlt".equals(callerPage)){
			pageTitle = "Delete Outline";
			codeName = CRSDLT;
			progress = Constant.COURSE_APPROVED_TEXT;
		}
		else if ("crsedt".equals(callerPage)){
			pageTitle = "Modify Outline";
			codeName = CRSEDT;
			progress = "OUTLINE";
			useKix = true;
		}
		else if ("crsfld".equals(callerPage)){
			pageTitle = "Display Data (raw)";
			codeName = CRSFLD;
		}
		else if ("crsrnm".equals(callerPage)){
			pageTitle = "Renumber Outline";
			codeName = CRSRNM;
			progress = Constant.COURSE_APPROVED_TEXT;
			useKix = true;
		}
		else if ("crsrvw".equals(callerPage)){
			pageTitle = "Invite Reviewers";
			codeName = CRSRVW;
			progress = Constant.COURSE_REVIEW_TEXT;
			simple = true;
		}
		else if ("crssts".equals(callerPage)){
			pageTitle = "Approval Status";
			codeName = CRSSTS;
		}
		else if ("crsvw".equals(callerPage)){
			pageTitle = "View Outline";
			codeName = CRSVW;
			progress = "wildcard";
		}
		else if ("crsxrf".equals(callerPage)){
			pageTitle = "Outlne Cross Listing";
			codeName = CRSXRF;
			progress = Constant.COURSE_APPROVED_TEXT;
		}
		else if ("crsrvwer".equals(callerPage)){
			pageTitle = "Review Outline";
			codeName = CRSRVWER;
			progress = Constant.COURSE_REVIEW_TEXT;
			simple = true;
		}
		else if ("crsassr".equals(callerPage)){
			pageTitle = "Assess Outline";
			codeName = CRSASSR;
			progress = Constant.COURSE_MODIFY_TEXT;
		}
		else if ("crsslo".equals(callerPage)){
			pageTitle = "Outline SLO Assessment";
			codeName = CRSSLO;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("vwslo".equals(callerPage)){
			pageTitle = "View Student Learning Outcomes Report";
			codeName = VWSLO;
			progress = Constant.COURSE_MODIFY_TEXT;
		}
		else if ("lstprereq".equals(callerPage)){
			pageTitle = "List outline pre-requisites";
			codeName = LSTPREREQ;
			progress = Constant.COURSE_APPROVED_TEXT;
			simple = true;
		}
		else if ("crscanappr".equals(callerPage)){
			pageTitle = "Cancel Approval Process";
			codeName = CRSCANAPPR;
			progress = Constant.COURSE_APPROVAL_TEXT;
			simple = true;
		}
		else if ("crsrwslo".equals(callerPage)){
			pageTitle = "Review SLO/Compentencies";
			codeName = CRSRWSLO;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crscanslo".equals(callerPage)){
			pageTitle = "Cancel SLO Review";
			codeName = CRSCANSLO;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crscmp".equals(callerPage)){
			pageTitle = "Edit SLO";
			codeName = CRSCMP;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crscmpz".equals(callerPage)){
			pageTitle = "Request SLO Review";
			codeName = CRSCMPZ;
			progress = Constant.COURSE_MODIFY_TEXT;
		}
		else if ("crscmpzz".equals(callerPage)){
			pageTitle = "Request SLO Review";
			codeName = CRSCMPZZ;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crssloapprcan".equals(callerPage)){
			pageTitle = "Cancel SLO Approval";
			codeName = CRSSLOAPPRCAN;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crssloappr".equals(callerPage)){
			pageTitle = "Request SLO/Competencies Approval";
			codeName = CRSSLOAPPR;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("slostrt".equals(callerPage)){
			pageTitle = "Start SLO/Competencies Assessment";
			codeName = SLOSTRT;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crsrvwcan".equals(callerPage)){
			pageTitle = "Cancel Outline Review";
			codeName = CRSRVWCAN;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("crsrqstrvw".equals(callerPage)){
			pageTitle = "Request Outline Review";
			codeName = CRSRQSTRVW;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("prgappr".equals(callerPage)){
			pageTitle = "Program Approval";
			codeName = PRGAPPR;
			progress = Constant.PROGRAM_APPROVAL_PROGRESS;
			simple = true;
		}
		else if ("prgcanappr".equals(callerPage)){
			pageTitle = "Cancel Approval Process";
			codeName = PRGCANAPPR;
			progress = Constant.PROGRAM_APPROVAL_PROGRESS;
			simple = true;
		}
		else if ("prgrvw".equals(callerPage)){
			pageTitle = "Invite Reviewers";
			codeName = PRGRVW;
			progress = Constant.PROGRAM_REVIEW_PROGRESS;
			simple = true;
		}
		else if ("prgrqstrvw".equals(callerPage)){
			pageTitle = "Request Program Review";
			codeName = PRGRQSTRVW;
			progress = Constant.PROGRAM_MODIFY_PROGRESS;
			simple = true;
		}
		else if ("prgrvwcan".equals(callerPage)){
			pageTitle = "Cancel PROGRAM Review";
			codeName = PRGRVWCAN;
			progress = Constant.PROGRAM_MODIFY_PROGRESS;
			simple = true;
		}
		else if ("shwfld".equals(callerPage)){
			pageTitle = "Enable Outline Items for Modifications";
			codeName = SHWFLD;
			progress = Constant.COURSE_MODIFY_TEXT;
			simple = true;
		}
		else if ("shwprgfld".equals(callerPage)){
			pageTitle = "Enable Program Items for Modifications";
			codeName = SHWPRGFLD;
			progress = Constant.PROGRAM_MODIFY_PROGRESS;
			simple = true;
		}
		else if ("fndrqstrvw".equals(callerPage)){
			pageTitle = "Request Foundation Course Review";
			codeName = FNDRQSTRVW;
			progress = Constant.FND_MODIFY_PROGRESS;
			simple = true;
		}
		else if ("fndrvwcan".equals(callerPage)){
			pageTitle = "Cancel Foundation Course Review";
			codeName = FNDRVWCAN;
			progress = Constant.FND_MODIFY_PROGRESS;
			simple = true;
		}
		else if ("fndrvw".equals(callerPage)){
			pageTitle = "Invite Reviewers";
			codeName = FNDRVW;
			progress = Constant.FND_REVIEW_TEXT;
			simple = true;
		}
		else{
			pageTitle = "";
			codeName = -1;
		}
	}

	fieldsetTitle = pageTitle;

	if (formName!=null && formName.equals("aseForm")){
		alpha = website.getRequestParameter(request,"alpha_ID","");

		// numbers_ID is the AJAX returned value. When it is null or empty
		// that means that it was not listed as part of the AJAX drop down.
		// However, because users are allowed to type into the box, collect
		// the content by going to 'numbers'.
		num = website.getRequestParameter(request,"numbers_ID","");
		if ( num == null || num.length() == 0 )
			num = website.getRequestParameter(request,"numbers","");

 		campus = website.getRequestParameter(request,"thisCampus","");

		// thisOption is used as a way of getting values during selection of coursetype
		// and it exists only after the form is submitted
		viewOption = website.getRequestParameter(request,"thisOption");

		if (alpha != null && num != null){
			message = "sendRedirect";		// is the course editable at this time?

			/*
			*	===> Add 4
			*/
			switch (codeName){
				case APPRL: break;  // no additional action required
				case CRSAPPR:
					// is outline ready for approval?
					if ( !"APPROVAL".equals(courseDB.getCourseProgress(conn,campus,alpha,num,"PRE"))){
						message = "This outline is not ready for the approval proceess at this time.";
					}
					else{
						if ( !courseDB.isNextApprover(conn,campus,alpha,num,user)){
							String divID = alpha + "_" + num;
							message = "It is not your turn in the queue to approve this outline.<br><br>" +
								"Click <a href=## onclick=\"aseOnLoad(\'" + divID + "\',\'\')\">here</a> for approval status.";
						}
					}
					// is this the right sequence?
					break;
				case CRSAPPRSLO: break;
				case CRSCAN:
					kix = helper.getKix(conn,campus,alpha,num,"PRE");
					if ( !courseDB.isCourseCancellable(conn,kix,user)){
						message = "You are not authorized to cancel this outline or cancellation is not permitted at this time.";
					}
					break;
				case CRSDLT:
					if ( !courseDB.isCourseDeletable(conn,campus,alpha,num,user)){
						message = "Course may not be deleted at this time.";
					}
					break;
				case CRSEDT:
					/*
						if statement checks for existing modifications. else does new modificition.
						else section does copy from CUR to PRE for modifications to take place.

						session.setAttribute("aseModificationMode", "E"); for existing mod
						session.setAttribute("aseModificationMode", "A"); for new mod
					*/
					session.setAttribute("aseModificationMode", "");
					if (courseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						kixType = "PRE";
						viewOption = "PRE";
						if (!courseDB.isEditable(conn,campus,alpha,num,user,jsid)){
							message = "You are not authorized to edit this outline or it is not editable at this time.<br><br>" +
								"Click <a href=\"vwcrs.jsp?alpha=" + alpha + "&num=" + num + "&t=PRE\">here</a> to view outline contents.";
						}
						else{
							session.setAttribute("aseModificationMode", "E");
						}
					}
					else{
						/*
							testing allows us to do edits without having to enable fields for edits
						*/
						boolean testing = false;
						kixType = "CUR";

						if (testing){
							msg = courseDB.modifyOutline(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);
							if ( "Exception".equals(msg.getMsg())){
								message = "Outline modification failed.<br><br>" + msg.getErrorLog();
							}
							else if (!"".equals(msg.getMsg())){
								message = "Unable to modify outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
							}
							else{
								viewOption = "PRE";
								session.setAttribute("aseModificationMode", "A");
							}
						}
						else{
							viewOption = "PRE";
							session.setAttribute("aseModificationMode", "A");
							callerPage = "shwfld";
							rtn = "crsedt";
						}
					}
					break;
				case CRSSTS: break; // no additional action required
				case CRSVW: break; // no additional action required
				case CRSXRF: break; // no additional action required
				case CRSCPY: break; // no additional action required
				case CRSCRT:
					session.setAttribute("aseModificationMode", "A");
					break;
				case CRSFLD: break; // no additional action required
				case CRSRNM:
					if (courseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						message = "Renumbering is not permitted while a course is being modified.";
					}
					else{
						kixType = "CUR";
					}
					break;
				case CRSRVW:
					kix = helper.getKix(conn,campus,alpha,num,"PRE");
					if (kix == null || kix.length() == 0){
						if (!ProgramsDB.isProgramReviewable(conn,campus,kix,user)){
							message = "Selected program must be in review mode OR only the proposer may invite reviewers for this program.";
						}
					}
					else{
						if (!courseDB.isCourseReviewable(conn,campus,alpha,num,user)){
							message = "Selected outline must be in review mode OR only the proposer may invite reviewers for this outline.";
						}
					}
					break;
				case CRSRVWER:
					if ( !courseDB.isCourseReviewer(conn,campus,alpha,num,user)){
						message = "You are not authorized to review this outline or the review period has expired.";
					}

					break;
				case CRSASSR:
					/*
						for assessment, before going there, add all SLOs into ACCJC table
					*/
					if ("PRE".equals(viewOption)){
						if (!courseDB.isEditable(conn,campus,alpha,num,user,jsid)){
							message = "You are not authorized to edit this course or it is not editable at this time.<br><br>" +
									"Click <a href=\"vwcrs.jsp?alpha=" + alpha + "&num=" + num + "&t=PRE\">here</a> to view course content.";
						}
						else{
							//int rowsAffected = CourseACCJCDB.appendComps(conn,campus,alpha,num,viewOption);
						}
					}
					break;
				case CRSSLO:
					if ("PRE".equals(viewOption)){
						if (!courseDB.isEditable(conn,campus,alpha,num,user,jsid)){
							message = "You are not authorized to edit this course or it is not editable at this time.<br><br>" +
									"Click <a href=\"vwcrs.jsp?alpha=" + alpha + "&num=" + num + "&t=PRE\">here</a> to view course content.";
						}
					}
					break;
				case VWSLO: break;
				case LSTPREREQ: break;
				case CRSCANAPPR:
					msg = courseDB.cancelOutlineApproval(conn,campus,alpha,num,user);
					if ("Exception".equals(msg.getMsg())){
						message = "Outline cancellation failed.<br><br>" + msg.getErrorLog();
					}
					else if ( !"".equals(msg.getMsg()) ){
						message = "Unable to cancel outline approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "Outline approval cancelled successfully<br>";
					}

					break;
				case CRSRWSLO:
					if (!DistributionDB.hasMember(conn,campus,"SLOReviewer",user)){
						message = "You are not authorized to review outline SLO/competencies.";
					}

					break;
				case CRSCANSLO:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "Cancellation is only available to the proposer of this outline.<br><br>";
					}
					else{
						if (!SLODB.sloProgress(conn,campus,alpha,num,"PRE",Constant.COURSE_REVIEW_TEXT)){
							message = "SLO review has not been requested.<br><br>";
						}
						else{
							if (SLODB.reviewStarted(conn,campus,alpha,num)){
								message = "Cancellation is not permitted once reviewers start to add comments.<br><br>";
							}
						}
					}	// proposer

					break;
				case CRSCMP:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "Only the proposer may edit SLO for " + alpha + " " + num + ".<br><br>";
					}

					break;
				case CRSCMPZ: break;
				case CRSCMPZZ:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "Only the proposer may request SLO review for " + alpha + " " + num + ".<br><br>";
					}

					break;
				case CRSSLOAPPRCAN:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "Cancellation is only available to the proposer of this outline.<br><br>";
					}
					else{
						if (!SLODB.sloProgress(conn,campus,alpha,num,"PRE","APPROVAL")){
							message = "SLO approval has not been requested.<br><br>";
						}
						else{
							if (SLODB.approvalStarted(conn,campus,alpha,num)){
								message = "Cancellation is not permitted once approvers start to add comments.<br><br>";
							}
						}
					}	// proposer

					break;
				case CRSSLOAPPR:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "Approval is only available to the proposer of this outline.<br><br>";
					}
					else{
						if (SLODB.sloProgress(conn,campus,alpha,num,"PRE",Constant.COURSE_REVIEW_TEXT)){
							message = "Approval request is not permitted while review is in progress.<br><br>";
						}
						else{
							if (SLODB.sloProgress(conn,campus,alpha,num,"PRE","APPROVAL")){
								message = "SLO approval already in progress.<br><br>";
							}
						}
					}	// proposer

					break;
				case PRGAPPR:
					// is program ready for approval?
					if ( !"APPROVAL".equals(ProgramsDB.getProgramProgress(conn,campus,kix))){
						message = "This program is not ready for the approval proceess at this time.";
					}
					else{
						if ( !ProgramsDB.isNextApprover(conn,campus,kix,user)){
							String divID = alpha + "_" + num;
							message = "It is not your turn in the queue to approve this program.<br><br>" +
								"Click <a href=## onclick=\"aseOnLoad(\'" + divID + "\',\'\')\">here</a> for approval status.";
						}
					}
					// is this the right sequence?
					break;
				case PRGCANAPPR:
					msg = ProgramsDB.cancelProgramApproval(conn,campus,kix,user);
					if ("Exception".equals(msg.getMsg())){
						message = "Program cancellation failed.<br><br>" + msg.getErrorLog();
					}
					else if ( !"".equals(msg.getMsg()) ){
						message = "Unable to cancel program approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "Program approval cancelled successfully<br>";
					}

					break;
				case SLOSTRT:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this outline.<br><br>";
					}
					else{
						if (	!SLODB.sloProgress(conn,campus,alpha,num,"PRE","APPROVED") &&
								SLODB.doesSLOExist(conn,campus,alpha,num)){
							message = "Assessment is in progress.<br><br>";
						}
					}

					break;
				case CRSRVWCAN:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this outline.<br><br>";
					}

					break;
				case PRGRVWCAN:
					proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this program.<br><br>";
					}

					break;
				case PRGRQSTRVW:
					proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this program.<br><br>";
					}

					break;
				case CRSRQSTRVW:
					proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this outline.<br><br>";
					}
					break;
				case FNDRQSTRVW:
					proposer = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this foundation course.<br><br>";
					}

					break;
				case FNDRVWCAN:
					proposer = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
					if (!proposer.equals(user)){
						message = "This option is only available to the proposer of this foundation course.<br><br>";
					}

					break;
			}	// switch
			//course = null;
		}	// if alpha
	}	// if form

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;			/* Never change this one */
			width:320px;					/* Width of box */
			height:250px;					/* Height of box */
			overflow:auto;					/* Scrolling features */
			border:1px solid #317082;	/* Dark green border */
			background-color:#FFF;		/* White background color */
			text-align:left;
			font-size:.9em;
			z-index:100;
		}
		#ajax_listOfOptions div{		/* General rule for both .optionDiv and .optionDivSelected */
			margin:1px;
			padding:1px;
			cursor:pointer;
			font-size:0.9em;
		}
		#ajax_listOfOptions .optionDiv{	/* Div for each item in list */

		}
		#ajax_listOfOptions .optionDivSelected{ /* Selected item in the list */
			background-color:#317082;
			color:#FFF;
		}
		#ajax_listOfOptions_iframe{
			background-color:#F00;
			position:absolute;
			z-index:5;
		}

		form{
			display:inline;
		}
	</style>

	<script type="text/javascript" src="js/crssts.js"></script>
	<script type="text/javascript" src="js/sltcrs.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if ("sendRedirect".equals(message)){
		asePool.freeConnection(conn);
		session.setAttribute("aseWorkInProgress", "1");
		session.setAttribute("aseAlpha", alpha);
		session.setAttribute("aseNum", num);
		session.setAttribute("aseType", viewOption);

		// before saving, have to encrypt then decrypt when done
		campus = Encrypter.encrypter(campus);
		session.setAttribute("aseCampus", campus);
		campus = website.getRequestParameter(request,"aseCampus","",true);

		aseUtil.logAction(conn,user,callerPage,callerPage,alpha,num,campus,kix);
		JSIDDB.updateJSID(conn,session.getId(),campus,callerPage,alpha,num,viewOption,user);

		if (useKix){
			kix = helper.getKix(conn,campus,alpha,num,kixType);
			url = callerPage + ".jsp?kix=" + kix + "&rtn=" + rtn;
		}
		else{
			url = callerPage + ".jsp?alpha=" + alpha + "&num=" + num  + "&campus=" + campus + "&view=" + viewOption + "&rtn=" + rtn;
		}

		if (!debug)
			response.sendRedirect(url);
		else
			out.println(url);
	}
	else{
		if (message.length()==0){
			if (!simple)
				showAjaxForm(request,response,session,out,conn,callerPage,aseUtil,viewOption);
			else
				showSimpleForm(request,response,session,out,conn,aseUtil,website,callerPage);
		}
		else
			showMessage(request,response,out,conn,message,alpha,num,campus);
	}

	asePool.freeConnection(conn,"sltcrs",user);
%>

<%!
	//
	// show this form with data
	//
	void showSimpleForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						AseUtil aseUtil,
						WebSite website,
						String caller) throws java.io.IOException {
		try{

			String user = website.getRequestParameter(request,"aseUserName","",true);
			String campus = website.getRequestParameter(request,"aseCampus","",true);
			String campusName = CampusDB.getCampusName(conn,campus);

			int idx = website.getRequestParameter(request,"idx",0);
			String type = website.getRequestParameter(request,"type");
			String helpText = "";

			boolean showType = false;
			boolean showIndex = false;
			String data = "";
			String kix = "";

			String category = "Outlines";

			if ( caller.length() > 0 ){
				if ("crsappr".equals(caller)){
					data = Helper.showOutlinesNeedingApproval(conn,campus,user,caller);
				}
				if ("crsapprslo".equals(caller)){
					data = Helper.showSLOReadyToApprove(conn,campus,user,caller);
				}
				else if ("crscan".equals(caller)){
					data = Helper.showOutlinesUserMayCancel(conn,campus,user);
				}
				else if ("crscanappr".equals(caller)){
					data = "<ul>Approvals";
					data = data + Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_APPROVAL_TEXT,caller);
					data = data + "</ul>";
					data = data + "<ul>Approval Pending";
					data = data + Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_APPROVAL_PENDING_TEXT,caller);
					data = data + "</ul>";
					data = data + "<ul>Deletions";
					data = data + Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_DELETE_TEXT,caller);
					data = data + "</ul>";
				}
				else if ("crscanslo".equals(caller)){
					data = Helper.showSLOReviewToCancel(conn,campus,user,caller);
				}
				else if ("crscmp".equals(caller)){
					session.setAttribute("asecurrentSeq", String.valueOf("0"));
					session.setAttribute("aseCurrentTab", String.valueOf("0"));
					data = Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_MODIFY_TEXT,caller);
					helpText = "Editing SLOs is available only when outlines are being modified.";
				}
				else if ("crscmpzz".equals(caller)){
					data = Helper.showOutlinesNeedingSLOReview(conn,campus,user,caller);
					helpText = "Only SLOs in MODIFY progress are available for reviews.";
				}
				else if ("crsrvw".equals(caller)){
					data = "<fieldset class=\"FIELDSET90\"><legend>Outline Review</legend>"
							+ Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_TEXT,caller)
							+ "</fieldset>";

					data += "<fieldset class=\"FIELDSET90\"><legend>Review within Approval</legend>"
							+ Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_IN_APPROVAL,caller)
							+ "</fieldset>";
				}
				else if ("crsrvwer".equals(caller)){
					data = Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_TEXT,caller);
				}
				else if ("crsrwslo".equals(caller)){
					data = Helper.showSLOByProgress(conn,campus,user,caller,Constant.COURSE_REVIEW_TEXT);
				}
				else if ("crsslo".equals(caller)){
					data = Helper.showSLOByProgress(conn,campus,user,caller,Constant.COURSE_ASSESS_TEXT);
				}
				else if ("crssloappr".equals(caller)){
					data = Helper.showOutlinesNeedingSLOApproval(conn,campus,user,caller);
					helpText = "Outlines are available for approval after all assessments have been completed.";
				}
				else if ("crssloapprcan".equals(caller)){
					data = Helper.showSLOApprovalToCancel(conn,campus,user,caller);
				}
				else if ("slostrt".equals(caller)){
					AssessedDataDB.setupAssessment(conn,campus,type,user);
					data = Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_MODIFY_TEXT,caller);
				}
				else if ("crsrvwcan".equals(caller)){
					data = "<fieldset class=\"FIELDSET90\"><legend>Outline Review</legend>"
							+ Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_TEXT,caller)
							+ "</fieldset>";

					data += "<fieldset class=\"FIELDSET90\"><legend>Review within Approval</legend>"
							+ Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_IN_APPROVAL,caller)
							+ "</fieldset>";

				}
				else if ("crsrqstrvw".equals(caller)){
					data = Helper.showOutlinesByUserProgress(conn,campus,user,Constant.COURSE_MODIFY_TEXT,caller);
				}
				if ("prgappr".equals(caller)){
					data = Helper.showProgramsNeedingApproval(conn,campus,user,caller);
					category = "Programs";
				}
				if ("prgcanappr".equals(caller)){
					data = Helper.showProgramsUserMayCancel(conn,campus,user,caller);
					category = "Programs";
				}
				else if ("prgrvwcan".equals(caller)){
					data = Helper.showProgramsInReview(conn,campus,user,caller);
				}
				else if ("prgrvw".equals(caller)){
					data = Helper.showProgramsInReview(conn,campus,user,"crsrvw");
				}
				else if ("prgrqstrvw".equals(caller)){
					data = Helper.showProgramsByUserProgress(conn,campus,Constant.PROGRAM_MODIFY_PROGRESS,user,caller);
				}
				else if ("fndrqstrvw".equals(caller)){
					data = com.ase.aseutil.fnd.FndDB.showByProposer(conn,campus,user,caller);
				}
				else if ("fndrvwcan".equals(caller)){
					data = "<fieldset class=\"FIELDSET90\"><legend>Foundation Course Review</legend>"
							+ com.ase.aseutil.fnd.FndDB.showByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_TEXT,caller)
							+ "</fieldset>";

					data += "<fieldset class=\"FIELDSET90\"><legend>Review within Approval</legend>"
							+ com.ase.aseutil.fnd.FndDB.showByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_IN_APPROVAL,caller)
							+ "</fieldset>";
				}
				else if ("fndrvw".equals(caller)){
					data = "<fieldset class=\"FIELDSET90\"><legend>Foundation Course Review</legend>"
							+ com.ase.aseutil.fnd.FndDB.showByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_TEXT,"crsrvw")
							+ "</fieldset>";

					data += "<fieldset class=\"FIELDSET90\"><legend>Foundation Course Review within Approval</legend>"
							+ com.ase.aseutil.fnd.FndDB.showByUserProgress(conn,campus,user,Constant.COURSE_REVIEW_IN_APPROVAL,"crsrvw")
							+ "</fieldset>";
				}
				else if ("shwfld".equals(caller)){
					// attached edit=1 to URL to tell shwfld that we are enabling additional items
					// admins should have full access to enable items
					// blanking out user name will tell the calling class to
					// display all

					boolean campusAdmin = SQLUtil.isCampusAdmin(conn,user);
					boolean sysAdmin = SQLUtil.isSysAdmin(conn,user);
					String userName = "";

					if (!campusAdmin && !sysAdmin){
						userName = user;
					}

					data = Helper.showOutlinesToEnableItems(conn,campus,userName,Constant.COURSE_MODIFY_TEXT,caller);

					data = data.replace("?kix=","?edit=1&kix=");
				}
				else if ("shwprgfld".equals(caller)){
					data = Helper.showProgramsByProgress(conn,campus,Constant.PROGRAM_MODIFY_PROGRESS,caller);
					data = data.replace("?kix=","?edit=1&kix=");
				}
				else{
					showType = false;
					showIndex = false;
				}
			}

			out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Campus:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>" + campusName );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>User:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\'>" + user );
			out.println("			</td></tr>" );

			if (showType){
				out.println("			<tr>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Outline Type:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\'>");
				out.println("<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
				out.println("&nbsp;<a href=\"?type=ARC\" class=\"linkcolumn\">Archived</a>&nbsp;&nbsp;" );
				out.println("&nbsp;<a href=\"?type=CUR\" class=\"linkcolumn\">Approved</a>&nbsp;&nbsp;" );
				out.println("&nbsp;<a href=\"?type=PRE\" class=\"linkcolumn\">Proposed</a>&nbsp;" );
				out.println("<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
				out.println("</form>" );
				out.println("			</td></tr>" );
			}

			if (showIndex){
				out.println("			<tr>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\'>" + Helper.drawAlphaIndex(idx,type) );
				out.println("			</td></tr>" );

				out.println("			<tr>" );
				out.println("				 <td class=\'normaltext\' colspan=\"2\" height=\"30\">&nbsp;&nbsp;Note: Select the outline type you wish to view then the alpha index to display available outlines.</td>" );
				out.println("			</td></tr>" );
			}
			else{
				out.println("			<tr>" );
				out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>"+category+":&nbsp;</td>" );
				out.println("				 <td class=\'dataColumn\'>" + data);
				out.println("			</td></tr>" );
			}

			// form buttons
			out.println("	</table>" );

			if (!"".equals(helpText))
				out.println("<p align=\"left\">Note: " + helpText + "</p>");
		}
		catch( Exception e ){
			out.println(e.toString());
		}

	}

	//
	// show this form with data using Ajax
	//
	void showAjaxForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						String callerPage,
						AseUtil aseUtil,
						String viewOption) throws java.io.IOException {
		try{
			String sql = "";
			String view = "";

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			String campusName = CampusDB.getCampusName(conn,campus);

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			// course by type
			// when viewOption does not have any value, display all 3 course types
			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTH\'>Type:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" );
			if ( (viewOption == null || viewOption.length() == 0) && (!"OUTLINE".equals(progress))){
				out.println("<input onchange=\'checkCourseType()\' type='radio' value='ARC' name='viewOption1'>&nbsp;Archived&nbsp;" );
				out.println("<input onchange=\'checkCourseType()\' type='radio' value='CUR' name='viewOption1'>&nbsp;Approved&nbsp;" );
				out.println("<input onchange=\'checkCourseType()\' type='radio' value='PRE' name='viewOption1'>&nbsp;Proposed&nbsp;" );
				out.println("<input type=\'hidden\' name=\'edt\' value=\'1\'>" );
				out.println("<input type=\'hidden\' name=\'thisOption\' value=\'\'>" );
			}
			else{
				if ( viewOption.equals("ARC")){
					view = "Archived";
				}
				else if (viewOption.equals("CUR")){
					view = "Approved";
				}
				else if (viewOption.equals("PRE")){
					view = "Proposed";
				}
				else if ("OUTLINE".equals(progress)){
					view = "Modify Outline";
				}

				out.println("					<input type=\'hidden\' name=\'edt\' value=\'0\'>" );
				out.println( view );
				out.println("					<input type=\'hidden\' name=\'thisOption\' value=\'" + viewOption + "\'>" );
			}
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" );
			out.println(campusName);
			out.println("					<input type=\'hidden\' name=\'thisCampus\' value=\'" + campus + "\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			// outline by short alpha and number
			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTH\' nowrap>1) Course Alpha & Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha3\" name=\"alpha3\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS3\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha3_hidden\" name=\"alpha3_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers3\" name=\"numbers3\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS3\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alpha3_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers3_hidden\" name=\"numbers3_ID\">" );
			out.println("				</td></tr>" );

			// OR
			out.println("				<tr height=\"25\">" );
			out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
			out.println("				</tr>" );

			// outline by number and course
			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTH\' nowrap>2) Course Number & Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers2\" name=\"numbers2\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS2\',event,\'/central/servlet/ACS\'," + aseUtil.NUMBER + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers2_hidden\" name=\"numbers2_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha2\" name=\"alpha2\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS2\',event,\'/central/servlet/ACS\'," + aseUtil.NUMBER_ALPHA + ",document.aseForm.numbers2_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha2_hidden\" name=\"alpha2_ID\">" );
			out.println("				</td></tr>" );

			// OR
			out.println("				<tr  height=\"25\"class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
			out.println("				</tr>" );

			// outline by alpha and number
			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTH\' nowrap>3) Discipline & Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA + ",'','',document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers\" name=\"numbers\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alpha_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers_hidden\" name=\"numbers_ID\">" );
			out.println("				</td></tr>" );

			// form buttons
			out.println("				<tr height=\"25\">" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'cp\' value=\'" + callerPage + "\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm()\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("<p align=\"left\" class=\"normaltext\"><font class=\"textblackTH\">NOTE:</font> Using rows 1 or 2, select the alpha and number for the outline you wish to operate on.");
			out.println("If the alpha is not known, use row 3 to select by discipline and number.</p>");
			out.println("<p align=\"left\" class=\"normaltext\"><font class=\"textblackTH\">Example:</font><br>Row 1: ICS 100, ENG 100<br/>");
			out.println("Row 2: 100 ENG, 100 ICS<br/>");
			out.println("Row 3: Information & Computer Science 100, English 100</p>");
			out.println("					 </td>" );
			out.println("				</tr>" );


			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	//
	// showMessage
	//
	void showMessage(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						String message,
						String alpha,
						String num,
						String campus) throws java.io.IOException {

		//out.println( "alpha: " + alpha );
		//out.println( "num: " + num );
		//out.println( "campus: " + campus );
		//alpha = "ICS";
		//num = "218";
		// when the course does not show up in the screen for selection and
		// user types in the number, it's still valid but won't matter here.
		// only when actual data comes through will this section show detail.

		String divID = alpha + "_" + num;
		out.println( "<br><p align=\'center\'>" + message + "</p>" );
		out.println( "<p align=\'center\'><div id=\'" + divID + "\'></div></p>" );
		out.println( "<p align=\'center\'><div id=\'APPROVER_LISTING\'></div></p>" );
		try{
			com.ase.aseutil.CourseDB course = new com.ase.aseutil.CourseDB();
			out.println ( "<p align=center>" + course.showCourseProgress(conn,campus,alpha,num,"PRE") + "</p>" );
			course = null;
		}
		catch(Exception ex){
			out.println( ex.toString() );
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
