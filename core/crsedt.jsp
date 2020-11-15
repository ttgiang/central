<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*
	*	crsedt.jsp	- modification
	*	crsedtx.jsp - form submission
	*	crsedt0.jsp - banner tab (first tab)
	*	crsedt1.jsp - banner tab (first tab)
	*	crsedt2.jsp - switch for tabs to show; help button (course tab/extra data command button)
	*	crsedt3.jsp - switch for form data retrieval
	*	crsedt4.jsp - extra data
	*	crsedt5.jsp - item index
	*	crsedt6.jsp - confirmation page for outline approval
	*	crsedt7.jsp - display all available tabs
	*	crsedt8.jsp - calls 9 to show progress tab
	*	crsedt9.jsp - progress tab
	*	crsedt10.jsp - additonal forms tab
	*	crsedt11.jsp - attachment tab
	*	crsedt12.jsp - display reviewer/approver comments & approval history; main tab buttons
	*	crsedt13.jsp - expanded help screen called from crsedt2
	*	2007.09.02 - extrahelp and datatype
	*	2007.09.02 - jump to 3rd tab is on add only
	*	2007.09.01
	*
	**/

	// authorized to page?

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","crsedt");

	String thisPage = "crsedt";

	String tester = "THANHG1";

	boolean debug = false;
	boolean itemRequired = false;
	boolean explainRequired = false;
	boolean extraDataFound = false;
	boolean showExplainEditor = false;
	boolean approvalInProgress = false;

	int route = 0;
	int tempInt = 0;

	//
	// remove fck import if we are not going to use FCK
	//
	boolean useCkEditor = true;
	String ckEditors = "";

	String progress = "";
	String proposer = "";
	String type = "PRE";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String faculty = Util.getSessionMappedKey(session,"aseUserName");
	boolean isCampAdm = SQLUtil.isCampusAdmin(conn,faculty);
	boolean isSysAdm = SQLUtil.isSysAdmin(conn,faculty);

	// reset visit to forum
	session.setAttribute("aseOrigin",null);
	session.setAttribute("aseOriginItem",null);
	session.setAttribute("aseOriginTab",null);

	// kix set in session to be used when going to the forum
	session.setAttribute("aseKix",null);

	// course to work with. Do not use session variables for alpha and num here
	String courseAlpha = website.getRequestParameter(request,"alpha","");
	String courseNum = website.getRequestParameter(request,"num","");
	String kix = website.getRequestParameter(request,"kix","");

	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		courseAlpha = info[Constant.KIX_ALPHA];
		courseNum = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
		proposer = info[Constant.KIX_PROPOSER];
		progress = info[Constant.KIX_PROGRESS];
	}
	else{
		if(!courseAlpha.equals("") && !courseNum.equals("")){
			kix = helper.getKix(conn,campus,courseAlpha,courseNum,type);
			progress = CourseDB.getCourseProgress(conn,campus,courseAlpha,courseNum,type);
			proposer = courseDB.getCourseProposer(conn,campus,courseAlpha,courseNum,"PRE");
		}
	}

	// stop process since there is no valid data
	if(kix.equals("") && courseAlpha.equals("") && courseNum.equals("")){
		processPage = false;
		response.sendRedirect("msg3.jsp?rtn=crsedt&cde=NOACCESS&kix="+kix);
	}

	// must be valid progress before editing is permitted
	if (!progress.equals(Constant.COURSE_MODIFY_TEXT) && !progress.equals(Constant.COURSE_REVISE_TEXT)){
		processPage = false;
	}

	// authorized to edit?
	if (processPage && !courseAlpha.equals(UserDB.getUserDepartment(conn,faculty,courseAlpha,request))) {
		processPage = false;
		response.sendRedirect("msg3.jsp?rtn=crsedt&cde=NOACCESS&kix="+kix);
	}

	// the faculty attempting to modify must be the proposer
	if (processPage && !faculty.equals(proposer)){
		processPage = false;
		response.sendRedirect("msg3.jsp?rtn=modify&kix="+kix+"&p="+proposer);
	}

	// it's possible that the task created to modify this outline is out of order with the actual
	// outline status. For example, task to modify created but outline already in approval.
	if (processPage && "APPROVAL".equals(courseDB.getCourseProgress(conn,campus,courseAlpha,courseNum,"PRE"))){
		processPage = false;
		response.sendRedirect("msg3.jsp?rtn=crsedt&cde=CONFLICT&kix="+kix);
	}

	// is there a course and number to work with?
	// even if there was a kix, it doesn't mean it translates into the correct alpha and number
	if (processPage && courseAlpha.equals("") && courseNum.equals("")){
		processPage = false;
		response.sendRedirect("sltcrs.jsp?cp=crsedt&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "80%";
	String tab = "";
	String pageTitle = courseDB.setPageTitle(conn,"",courseAlpha,courseNum,campus);
	fieldsetTitle = "Outline Maintenance";

	// outline audit stamp
	String lastUpdated = courseDB.getCourseItem(conn,kix,"auditdate");
	String[] taskText = TaskDB.getTaskMenuText(conn,"Work on New Course Outline",campus,courseAlpha,courseNum,"PRE",kix);
	String outlineStatus = taskText[Constant.TASK_MESSAGE];

	CCCM6100 cccm6100 = null;
	FCKeditor fckEditor = null;
	FCKeditor fckEditorExplain = null;
	String fckEditorWidth = "800";

	// tab we are one
	final int totalTabs  		= Constant.TAB_COUNT;
	final int TAB_BANNER 		= Constant.TAB_BANNER;
	final int TAB_COURSE 		= Constant.TAB_COURSE;
	final int TAB_CAMPUS 		= Constant.TAB_CAMPUS;
	final int TAB_STATUS 		= Constant.TAB_STATUS;
	final int TAB_FORMS 			= Constant.TAB_FORMS;
	final int TAB_ATTACHMENT 	= Constant.TAB_ATTACHMENT;

	// number of items on the course tab. used for count on campus tab
	int courseTabCount	= 0;

	String[] sTabs 	= new String[totalTabs];		// tabs available
	String[] sTabBg	= new String[totalTabs];		// tab background colors
	String[] ini 		= new String[totalTabs];		// text for specific tabs
	int currentTab 	= 0;

	String[] sEdits 	= new String[100];				// individual edit flags for each field
	boolean bEdit 		= false;								// determines weather overall can edit or not
	boolean bApproval = false;								// a 3 is in the edit field

	String aseLinker = "";					// session data being passed around

	// if the item in view is editable, leave empty else disabled
	String approvalDisabled = "";
	String reviewDisabled = "";
	String submitDisabled = "";

	// class representing button state
	String approvalClass = "";
	String reviewClass = "";
	String submitClass = "";

	String extraData = "";					// these fields control what button text, class to show
	String extraButton = "";				// when there are extra data to display
	String extraForm = "";
	String extraArg = "";
	String extraClass = "";
	String extraDisabled = "";
	String extraTitle = "";					// button title
	String extraCmdTitle = "";				// button tip
	String extraHelp = "";
	String hasRules = "";					// DIVERSIFICATION
	String rulesForm = "";

	String temp;
	String validate = "0";					// should the field be validated
	String recyclePage = "0";				// cycle back to #1 when reaching end
	boolean lock = false;					// whether to lock the input field

	//
	//	message pages are those where there are no input fields. Just a message
	//	during the course work. This is to provide extra instructions during the
	//	course edit process.
	//
	//	by default, it is false until the friendly name is Constant.MESSAGE_PAGE
	//
	boolean messagePage = false;

	// tab COURSE related variables; which question, next question
	int minNo = 1;
	int maxNo = 99;							// arbitrary number
	int maxNoCampus = 0;						// number of questions on campus tab
	int maxNoCourse = 0;						// number of questions on course tab
	int currentSeq = 1;						// this is the sequence we chose to have the question appear
	int currentNo = 1;						// this is the question number in the CCCM6100
	long displaySeq = 0;						// the item being displayed
	int nextNo = 2;							// next item (initialization)
	long newNo = 0;
	int endOfThisTab = 0;					// is this the last question (maxNo) for this tab

	long reviewerComments = 0;				// display count of reviewer comments for this item
	long approverComments = 0;				// display count of approver comments for this item
	long approvalHistory = 0;				// display count of approval comments

	long commentsCount = 0;					// number of comments for a particular question

	String sql;
	String[] checkValues;

	// input fields
	int question_len = 0;
	int question_max = 0;
	int question_userlen = 0;
	String question = "";
	String question_ini = "";
	String question_type = "";
	String question_friendly = "";
	String question_defalt = "";
	String question_explain = "";
	String questionData[] = new String[2];
	String question_change = "N";					// determines whether a question should appear on create
	String questionTab = "";
	String questionHelp = "";
	String questionAudio = "";
	String question_CountText = "N";
	String question_Extra = "Y";
	String HTMLFormField = "";
	String HTMLFormFieldExplain = "";
	String controlName = "questions";
	String commentsBox = "Y";
	int i = 0;
	int j = 0;

	int defaultTab = Constant.TAB_COURSE;					// see ER00023

	// determine tab to highligh. default start on course tab (ER00023)
	if ( request.getParameter("ts") != null ){
		currentTab = website.getRequestParameter(request,"ts",defaultTab);
	}
	else{
		currentTab = defaultTab;
	}

	// turn them all off by default then turn on the one that
	// was selected
	sTabs = "taboff,taboff,taboff,taboff,taboff,taboff".split(",");
	sTabs[currentTab] = "tabon";

	sTabBg = "bgtaboff,bgtaboff,bgtaboff,bgtaboff,bgtaboff,bgtaboff".split(",");
	sTabBg[currentTab] = "bgtabon";

	// this array helps determine the tab we are on and also
	// the values to key on for reading from database
	ini = "Banner,Course,Campus,Status,Forms,Attachments".split(",");
	questionTab = ini[currentTab];

	// course tab means it's for all campuses or SYStem wide
	if (questionTab.equals("Course") ){
		tab = "SYS";
	}

	// are revisions allowed during approval blackout
	String allowRevisionsDuringApprovalBlackout = Util.getSessionMappedKey(session,"AllowRevisionsDuringApprovalBlackout");

	// message board
	String enableMessageBoard = Util.getSessionMappedKey(session,"EnableMessageBoard");

	// this is our forum id
	int fid = ForumDB.getForumID(conn,campus,kix);

	// banner tab data
	Banner banner = new Banner();
	String[] statusTab = null;

	// no exists either as a weblink or a form submission. either way
	// it represents the question to retrieve
	if ( request.getParameter("no") != null ){
		currentSeq = website.getRequestParameter(request,"no",0);
		nextNo = currentSeq + 1;
	}

	if (currentTab==TAB_CAMPUS || currentTab==TAB_COURSE){
		maxNo = courseDB.countCourseQuestions(conn,campus,"Y","",currentTab);
		maxNoCampus = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
		maxNoCourse = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
	}

	//=================================================================
	// by default, we don't condensed. once the expand/collapse
	// is available, we save to session.
	// recall from session. if available, set value

	// by default, we show all items
	//--------------------------------------------------------------
	boolean showAllIndex = true;

	String junkEdits = "";

	if (currentTab==TAB_CAMPUS){
		junkEdits = courseDB.getCourseEdit2(conn,campus,courseAlpha,courseNum,type);
	}
	else if(currentTab==TAB_COURSE){
		junkEdits = courseDB.getCourseEdit1(conn,campus,courseAlpha,courseNum,type);
	}

	//--------------------------------------------------------------
	// when all is enabled, the value of edit1 is "1"
	//--------------------------------------------------------------
	if(junkEdits != null && !junkEdits.equals(Constant.ON)){
		showAllIndex = false;
	}

	//--------------------------------------------------------------
	// by default, we don't condense
	//--------------------------------------------------------------
	boolean condensedIndex = false;

	String idx = website.getRequestParameter(request,"idx","");

	if(idx.equals("0") || idx.equals("1")){
		session.setAttribute("aseEditIndex",idx);
	}
	else{
		idx = (String)session.getAttribute("aseEditIndex");
	}

	if(idx != null && idx.equals("1")){
		condensedIndex = true;
	}

	//--------------------------------------------------------------
	// tgiang - 2012.04.05
	// if condensed, advance the sequence to the next editable item
	//--------------------------------------------------------------
	if (condensedIndex && (currentTab==TAB_CAMPUS || currentTab==TAB_COURSE) && junkEdits != null){

		// with commas split items
		sEdits = junkEdits.split(",");

		if (sEdits.length > currentSeq){

			int junkNum = 0;

			int junkSeq = currentSeq-1;
			if (junkSeq < 0){
				junkSeq = 0;
			}
			else if (junkSeq > maxNo){
				junkSeq = maxNo;
			}

			// move until we find an enabled item
			while(junkSeq < maxNo && sEdits[junkSeq].equals(Constant.OFF)){
				++junkSeq;
			} // while

			if(junkSeq==maxNo){
				--junkSeq;
			}

			if(junkSeq < maxNo && !sEdits[junkSeq].equals(Constant.OFF)){
				junkNum = NumericUtil.getInt(sEdits[junkSeq],0);
				junkSeq = QuestionDB.getCourseSequenceByNumber(conn,campus,""+currentTab,junkNum);
				currentSeq = junkSeq;
			}

			nextNo = currentSeq + 1;

			// if nothing left after this item, force end
			// start with element following current
			junkSeq = currentSeq;
			if (junkSeq < 0){
				junkSeq = 0;
			}
			else if (junkSeq > maxNo){
				junkSeq = maxNo;
			}

			// default to end of road
			endOfThisTab = 1;

			// move until we find an enabled item. if we find one
			// then we are not at end of road
			while(junkSeq < maxNo){
				if(!sEdits[junkSeq].equals(Constant.OFF)){
					endOfThisTab = 0;
				}
				++junkSeq;
			} // while


		} // sEdits

		// reset to allow the rest of the page to continue processing
		sEdits = null;
		sEdits = new String[100];

	} // condensedIndex
	//=================================================================

%>
	<%@ include file="crsedt3.jsp" %>
<%

	// these are used from other pages called by this page but
	// never referenced on this page itself
	session.setAttribute("aseAlpha", courseAlpha);
	session.setAttribute("aseNum", courseNum);
	session.setAttribute("asecurrentSeq", String.valueOf(currentSeq));
	session.setAttribute("aseCurrentTab", String.valueOf(currentTab));
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseCreate","1");
	session.setAttribute("aseApplicationMessage","");
	session.setAttribute("aseCallingPage","crsedt");

	//
	//	Question number represents the question as numbered by CCCM6100.
	//	Question sequence is the order that we want the question to appear in.
	//
	//	In order to get the correct reviwer commennt, we have to use the question number
	//	that is directly connected to the sequence we are looking at.
	//

	displaySeq = currentSeq;
	currentNo = QuestionDB.getQuestionNumber(conn,campus,currentTab,currentSeq);

	if (currentTab==0)
		tempInt = 0;
	else
		tempInt = currentNo;

	reviewerComments = ReviewerDB.countReviewerComments(conn,kix,tempInt,currentTab,Constant.REVIEW);
	reviewerComments += ReviewerDB.countReviewerComments(conn,kix,tempInt,currentTab,Constant.REVIEW_IN_APPROVAL);
	approverComments = ReviewerDB.countReviewerComments(conn,kix,tempInt,currentTab,Constant.APPROVAL);
	approvalHistory = ApproverDB.countApprovalHistory(conn,kix);

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines how CC should behaves when reaching the last item for modification.");

	// do we start page back at 1 after reaching the end
	recyclePage = Util.getSessionMappedKey(session,"RecyclePage");

	// if there are entries in the history table and a route exists, then approval is in progress
	if (ApproverDB.countApprovalHistory(conn,kix) > 0 && route > 0){
		approvalInProgress = true;
		reviewDisabled = "disabled";
		reviewClass = "off";
	}

	// if this is the last question on this tab and in add mode, push user to 3rd tab
	if (currentSeq == maxNo){
		endOfThisTab = 1;
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>

	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

	<script language="JavaScript" src="js/crsedt.js"></script>

	<link rel="stylesheet" type="text/css" href="styles/tabs.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<script language="JavaScript" type="text/javascript" src="js/textcounter.js"></script>

	<%@ include file="tooltip/tooltip.jsp" %>
	<%@ include file="lib/extra.jsp" %>

	<script language="JavaScript" src="js/CalendarPopup.js"></script>
	<link href="../inc/calendar.css" rel="stylesheet" type="text/css">
	<SCRIPT language="JavaScript" id="dateID">
		var dateCal = new CalendarPopup("dateDiv");
		dateCal.setCssPrefix("CALENDAR");
	</SCRIPT>

	<%@ include file="highslide.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheaderx.jsp" %>

<%
	if (processPage){
%>
	<form method="post" action="crsedtx.jsp" name="aseForm">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<TR>
					<TD>
						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
							<tr>
								<td width="50%" align="left"><%@ include file="crsedt7.jsp" %></td>
								<td width="50%" align="left"><div style="border: 0px solid rgb(204, 204, 204); overflow: height: 20px; width: 20px;" id="validationMsg"></div></td>
							</tr>
						</table>
					</TD>
				</TR>
				<TR><TD class=bgtabon width="100%"><IMG height=3 alt="" src="../images/tab.gif" width=0></TD></TR>
				<%@ include file="crsedt2.jsp" %>
				<input type="hidden" value="0" name="catchChange">
				<input type="hidden" value="0" name="validate">
				<input type="hidden" value="<%=lock%>" name="lock">
				<input type="hidden" value="<%=kix%>" name="kix">
				<input type="hidden" value="<%=itemRequired%>" name="itemRequired">
				<input type="hidden" value="<%=explainRequired%>" name="explainRequired">
				<input type="hidden" value="<%=question_type%>" name="dataType">
			</TBODY>
		</TABLE>
	</form>

	<div class="hr"></div>

	<font class="textblackth">Button Description</font>
	<ul>
		<li class="textblack">Save - save entered data. This button is available only when edits are permitted</li>
		<li class="textblack">Close - end this operation</li>
		<li class="textblack">Review - request outline review. This button is not available during the approval or review process</li>
		<li class="textblack">Approval - request outline approval</li>
	</ul>

	<font class="textblackth">Note</font>
	<ul>
		<li class="textblack">Attachments - only the latest version is shown on outline and edit view. To view all versions, go to the attachment maintenance screen on the attachment tab.</li>
	</ul>

<%
	}
	else{
		out.println("Only outlines with status of MODIFY or REVISE may be modified."
			+ "<p><a href=\"tasks.jsp\" class=\"linkcolumn\">return to task listing</a>"
			+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<a href=\"crsrvwsts.jsp\" class=\"linkcolumn\">check review status</a></p>");
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"crsedt",faculty);
%>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

<script type="text/javascript">
//<![CDATA[

	// Create all editor instances at the end of the page, so we are sure
	// that the "bottomSpace" div is available in the DOM (IE issue).

	// take editors created from textarea and create ckeditors

	// js ckEditors is set to jsp ckEditors content
	var ckEditors = "<%=ckEditors%>";

	// split to get each element
	var editors = ckEditors.split(",");

	// loop and create
	for(i=0;i<editors.length;i++){

		CKEDITOR.replace( editors[i],
			{
				toolbar : [
								['Bold','Italic','Underline','Strike','Subscript','Superscript' ],
								['NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ],
								['Link','Unlink','Anchor' ],
								['Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ],
								'/',
								['Find','Replace','-','SelectAll' ],
								['Styles','Format','Font','FontSize','-','RemoveFormat' ],
								['TextColor','BGColor' ],
								['Source']
							],
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode: CKEDITOR.ENTER_P
			}
		);

	}

//]]>
</script>

</body>
</html>
