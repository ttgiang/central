<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*
	*	crsedt.jsp	- modification
	*	crsedt0.jsp - banner tab
	*	crsedt4.jsp - extra data
	*	crsedt5.jsp - item index
	*	crsedt6.jsp - confirmation page for outline approval
	*
	*	2007.09.02 - extrahelp and datatype
	*	2007.09.02 - jump to 3rd tab is on add only
	*	2007.09.01
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	/*
		safety built in to prevent user from hitting the back button to continue editing
		value set in crsedtx.jsp for finish, review, and approval.
	*/
	if ( "0".equals(session.getAttribute("aseWorkInProgress").toString()) ){
		//session.setAttribute("aseApplicationMessage","Edit session has ended.");
		//response.sendRedirect("msg.jsp?rtn=index");
		//return;
	}

	String campus = (String)session.getAttribute("aseCampus");
	String courseAlpha = "";
	String courseNum = "";
	String type = "";

	// course to work with. Do not use session variables for alpha and num here
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		courseAlpha = info[0];
		courseNum = info[1];
		type = info[2];
	}
	else{
		courseAlpha = website.getRequestParameter(request,"alpha");
		courseNum = website.getRequestParameter(request,"num");
		type = "PRE";
	}

	// is there a course and number to work with?
	if ( ( courseAlpha == null || courseAlpha.length() == 0 ) && ( courseNum == null || courseNum.length() == 0) ){
		String edt = website.getRequestParameter(request,"edt","");
		response.sendRedirect("sltcrs.jsp?cp=crsedt&viewOption=" + edt);
	}

	// GUI
	String chromeWidth = "80%";
	String tab = "";
	String pageTitle = courseDB.setPageTitle(conn,"",courseAlpha,courseNum,campus);
	fieldsetTitle = "Outline Maintenance";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");
	session.setAttribute("aseCallingPage","crsedt");

	// tab we are one
	String[] sTabs = new String[3];		// tabs available
	String[] sTabBg = new String[3];		// tab background colors
	String[] ini = new String[3];			// text for specific tabs
	String[] sEdits = new String[100];	// individual edit flags for each field
	boolean bEdit = false;					// determines weather overall can edit or not
	boolean bApproval = false;				// a 3 is in the edit field

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
	String extraClass = "";
	String extraDisabled = "";
	String extraTitle = "";					// button title
	String extraCmdTitle = "";				// button tip
	String extraHelp = "";

	String temp;
	int currentTab = 0;
	String validate = "0";					// should the field be validated
	String recyclePage = "0";				// cycle back to #1 when reaching end
	boolean lock = false;					// whether to lock the input field

	// tab BANNER related variables
	int numberOfFields = 8;
	int counter = 0;
	String[] fieldLabels = new String[numberOfFields];
	String[] fieldValues = new String[numberOfFields];

	// tab COURSE related variables
	// which question, next question
	int minNo = 1;
	int maxNo = 99;							// arbitrary number
	int currentSeq = 1;						// this is the sequence we chose to have the question appear
	int currentNo = 1;						// this is the question number in the CCCM6100
	long displaySeq = 0;						// the item being displayed
	int nextNo = 2;							// next item (initialization)
	long newNo = 0;
	int endOfThisTab = 0;					// is this the last question (maxNo) for this tab
	long reviewerComments = 0;				// display count of reviewer comments for this item

	String sql;
	String[] checkValues;

	// input fields
	int question_len = 0;
	int question_max = 0;
	String question = "";
	String question_ini = "";
	String question_type = "";
	String question_friendly = "";
	String question_explain = "";
	String questionData[] = new String[2];
	String question_change = "N";					// determines whether a question should appear on create
	String questionTab = "";
	String HTMLFormField = "";
	String HTMLFormFieldExplain = "";
	String controlName = "questions";
	int i = 0;
	int j = 0;

	// how many questions on this tab
	int questionCount = 0;

	// determine tab to highligh
	if ( request.getParameter("ts") != null )
		currentTab = website.getRequestParameter(request,"ts",0);
	else
		currentTab = 0;

	// turn them all off by default then turn on the one that
	// was selected
	sTabs = "taboff,taboff,taboff".split(",");
	sTabs[currentTab] = "tabon";

	sTabBg = "bgtaboff,bgtaboff,bgtaboff".split(",");
	sTabBg[currentTab] = "bgtabon";

	// no exists either as a weblink or a form submission. either way
	// it represents the question to retrieve
	if ( request.getParameter("no") != null ){
		currentSeq = website.getRequestParameter(request,"no",0);
		nextNo = currentSeq + 1;
	}

	// these are used from other pages called by this page but
	// never referenced on this page itself
	session.setAttribute("aseAlpha", courseAlpha);
	session.setAttribute("aseNum", courseNum);
	session.setAttribute("asecurrentSeq", String.valueOf(currentSeq));
	session.setAttribute("aseCurrentTab", String.valueOf(currentTab));

	// this array helps determine the tab we are on and also
	// the values to key on for reading from database
	ini = "Banner,Course,Campus".split(",");
	questionTab = ini[currentTab];

	// course tab means it's for all campuses or SYStem wide
	if ( questionTab.equals("Course") ){
		tab = "SYS";
	}

	Banner banner = new Banner();

	switch (currentTab){
		case 0 :
			// on banner tab, read data and show as is
			banner = BannerDB.getBanner(conn,courseAlpha,courseNum,campus);
			break;
		case 1 :
		case 2 :
			/*
				look up total number of questions by type and campus.

				for newly created courses, select where include = Y and change = N

				for existing modifications, select include = Y and not worry about change
			*/
			if (!courseDB.courseExistByTypeCampus(conn,campus,courseAlpha,courseNum,"CUR"))
				maxNo = courseDB.countCourseQuestions(conn,campus,"Y","N",currentTab);
			else
				maxNo = courseDB.countCourseQuestions(conn,campus,"Y","",currentTab);

			// prevent overflow/out of bounds
			if ( nextNo > maxNo )
				nextNo = minNo;

			/*
				this is used for adding a new question; stored for moving forward;
				could easily request from the database the max and add 1 to it.
				this is less work on the db side.
			*/
			newNo = maxNo + 1;

			//System.out.println("currentSeq : " + currentSeq + "<br>");
			//System.out.println("campus : " + campus + "<br>");
			//System.out.println("currentTab : " + currentTab + "<br>");
			CCCM6100 cccm6100 = CCCM6100DB.getCCCM6100(conn,currentSeq,campus,currentTab);
			if ( cccm6100 != null ){
				question = cccm6100.getCCCM6100();
				question_ini = cccm6100.getQuestion_Ini();
				question_type = cccm6100.getQuestion_Type();
				question_len = cccm6100.getQuestion_Len() + 20;
				question_max = cccm6100.getQuestion_Max();
				question_friendly = cccm6100.getQuestion_Friendly();
				question_explain = cccm6100.getQuestion_Explain();
				question_change = cccm6100.getChange();
				//out.println( "-------" + "<br>");
				//out.println( cccm6100 + "<br>");

				if (currentTab == 1){
					if ("crosslisted".equals(question_friendly)){
						extraData = courseDB.getCrossListing(conn,campus,courseAlpha,courseNum);
						extraButton = "cross-listing";
						extraForm = "crsxrf";
						extraTitle = "Cross Listing";
						extraCmdTitle = "enter additional cross listing";
					}
					else if ("X15".equals(question_friendly)){
						extraData = courseDB.getRequisites(conn,campus,courseAlpha,courseNum,"PRE",1,"");
						extraButton = "pre-requisite";
						extraForm = "crsreq";
						session.setAttribute("aseRequisite", "1");
						extraTitle = "Pre-Requisite";
						extraCmdTitle = "enter additional Pre-Requisites";
					}
					else if ("X16".equals(question_friendly)){
						extraData = courseDB.getRequisites(conn,campus,courseAlpha,courseNum,"PRE",2,"");
						extraButton = "co-requisite";
						extraForm = "crsreq";
						session.setAttribute("aseRequisite", "2");
						extraTitle = "Co-Requisite";
						extraCmdTitle = "enter additional Co-Requisites";
					}
					else if ("X18".equals(question_friendly)){
						extraData = CompDB.getCompsAsHTMLList(conn,courseAlpha,courseNum,campus,"PRE","",true);
						extraButton = "SLO";
						extraForm = "crscmp";
						extraTitle = "SLO";
						extraCmdTitle = "enter additional SLO";
					}
					else if ("X19".equals(question_friendly)){
						extraData = courseDB.getCourseContent(conn,campus,courseAlpha,courseNum,"PRE","");
						extraButton = "content";
						extraForm = "crscntnt";
						extraTitle = "Content";
						extraCmdTitle = "enter additional Content";
					}
				}	// currentTab
			}

			/*
				get the data for the course and number requested
				lookupx is used because we want the field and the edit code
				edit code is a string of CSV. 0 if not editable, and the question
				number if it is.
				questionData[0] is the value and questionData[1] contains the CSV
			*/
			questionData = courseDB.lookUpQuestion(conn,campus,courseAlpha,courseNum,question_friendly,currentTab);
			//out.println( "question_friendly: **" + question_friendly + "**<br>" );
			//out.println( "Data0: **" + questionData[0] + "**<br>" );
			//out.println( "Edit" + currentTab + ": **" + questionData[1] + "**<br>" );

			// set to good data
			if ( "NODATA".equals(questionData[0]) || "ERROR".equals(questionData[0]) ) {
				questionData[0] = "";
				questionData[1] = "";
			}
			else{
				if (question_friendly.indexOf("date") > -1 ){
					validate = "1";
					questionData[0] = aseUtil.ASE_FormatDateTime(questionData[0],6);
					extraHelp = "<font class=\"datacolumn\">(MM/DD/YYYY)</font>";
				}
			}

			/*
				questionData[1] = 1 for edit
				questionData[1] = 2 for review
				questionData[1] = 3 for approval
				questionData[1] = 1's and 0's for editable disapprovals

				sEdits contain array of 1's and 0's
			*/
			if ( questionData[1] == null || questionData[1].length() == 0 ){
				questionData[1] = "";
				for ( i=0; i<maxNo; i++ ){
					if ( i != 0 )
						questionData[1] += ",";

					questionData[1] += "0";
				}
			}
			else{
				/*
					the only time a single character is in this field is when the content
					contains a 1 to indicate ok to edit all fields
						when editable, all fields are opened
					contains a 2 to indicate we are under review process
					contains a 3 to indicate we are under approval process
				*/
				if ( "1".equals(questionData[1]) ){
					bEdit = true;
				}
				else if ( "2".equals(questionData[1])){
					reviewDisabled = "disabled";
					reviewClass = "off";
					bEdit = false;
					submitDisabled = "disabled";
					submitClass = "off";
				}
				else {
					reviewDisabled = "disabled";
					reviewClass = "off";
					bEdit = true;
					submitDisabled = "";
					bApproval = true;
					approvalDisabled = "true";

					/*
						when the length is greater than 1, it's because we are in
						approval and the editable flags are turn on/off

						extra button contains data that are filled out for an outline
						like pre/co req and cross listing. if not allowed to edit,
						turn off.
					*/
					sEdits = questionData[1].split(",");
					if ("0".equals(sEdits[currentSeq-1])){
						bEdit = false;
						lock = true;
						submitDisabled = "disabled";
						submitClass = "off";
						extraDisabled	= "disabled";
						extraClass = "off";
					}
					else{
						extraDisabled	= "";
						extraClass = "";
					}
				}
			} 	//	questionData[1] == null

			// at no time do we allow editing of fields 1 and 2 (course alpha and number)
			// or editing on tab 1
			if ((currentSeq<3 && currentTab==1) || (currentTab==0)){
				submitDisabled = "disabled";
				submitClass = "off";
				lock = true;
			}

			/*
				for testing to fill data automatically. extract data to fit the length of the expected
				field.
			*/
			if ("THANHG".equals(session.getAttribute("aseUserName").toString())) {
				if ( "".equals(questionData[0]) && "wysiwyg".equals(question_type)) {
					questionData[0] = question;
				}
				else{
					if (currentTab == 1 && "".equals(questionData[0])){
						if ("X15,X16,X17,coursedescr,X18,X19,X60,X25,X27,X32,X33,X44,X50,X37,X41,X40,X20,X46,X47,X48,X49,X52".
								indexOf(question_friendly) != -1 ){
							questionData[0] = questionData[0] + "<br>" + (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
						}
						else if (question_friendly.indexOf("date") > -1 ){
								questionData[0] = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
						}
					}
				}
			}

			// draw the field on screen. get the explained data if available.
			HTMLFormField = aseUtil.drawHTMLField(conn,
									question_type,
									question_ini,
									controlName,
									questionData[0],
									question_len,
									question_max,
									lock);

			if(question_explain!=null && question_explain.length()>0){
				HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,courseAlpha,courseNum,type,question_explain);

				if ("THANHG".equals((String)session.getAttribute("aseUserName"))) {
					HTMLFormFieldExplain = HTMLFormFieldExplain + "<br>" + (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
				}

				HTMLFormFieldExplain = aseUtil.drawHTMLField(conn,
										"wysiwyg",
										"",
										"explain",
										HTMLFormFieldExplain,
										0,
										0,
										lock);
			}

			break;
	}	// switch

	/*
		Question number represents the question as numbered by CCCM6100.
		Question sequence is the order that we want the question to appear in.

		In order to get the correct reviwer commennt, we have to use the question number
		that is directly connected to the sequence we are looking at.
	*/

	displaySeq = currentSeq;
	currentNo = QuestionDB.getQuestionNumber(conn,campus,currentTab,currentSeq);
	reviewerComments = ReviewerDB.countReviewerComments(conn,campus,courseAlpha,courseNum,currentNo,"reviewed");
	recyclePage = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","RecyclePage");

	/* if this is the last question on this tab and in add mode, push user to 3rd tab */
	if (currentSeq == maxNo)
		endOfThisTab = 1;

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="highslide/highslide.js"></script>
	<script type="text/javascript" src="highslide/highslide-html.js"></script>
	<script type="text/javascript" src="highslide/highslide2.js"></script>
	<link rel="stylesheet" type="text/css" href="highslide/highslide.css">

	<script language="JavaScript" src="js/functions.js"></script>
	<script language="JavaScript" src="js/crsedt.js"></script>

	<link rel="stylesheet" type="text/css" href="styles/tabs.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>

	<%@ include file="tooltip/tooltip.jsp" %>
	<%@ include file="lib/extra.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" action="crsedtx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD>
					<TABLE id=tabs_tda cellSpacing=0 cellPadding=0 summary="course edit" border=0>
						<TBODY>
							<TR>
								<TD class="<%=sTabs[0]%>" noWrap height=20>
									<A href="?ts=0&kix=<%=kix%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Banner
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[0]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[1]%>" noWrap height=20>
									<A href="?ts=1&kix=<%=kix%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Course
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[1]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[2]%>" noWrap height=20>
									<A href="?ts=2&kix=<%=kix%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0><%=campus%>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[2]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR><TD class=bgtabon width="100%"><IMG height=3 alt="" src="../images/tab.gif" width=0></TD></TR>
			<%
				switch (currentTab){
					case 0 :
							%>
								<%@ include file="crsedt0.jsp" %>
							<%
						break;
					case 1 :
					case 2 :
							%>
								<tr>
									<td class="textblackTH">
										<table width="100%" border="0">
											<tr>
												<td class="textblackTH" width="70%"><br/><%=displaySeq%>.&nbsp;<%=question%>&nbsp;<%=extraHelp%></td>
												<td align="right"><a onmouseover="showHelpText(<%=currentTab%>,<%=currentSeq%>); return false;" onmouseout="hideHelpText()" href="##"><img src="images/helpicon.gif" border="0" alt="show help"></a>&nbsp;&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr><td>&nbsp;</td></tr>
								<tr><td class="dataColumn" height="100" valign="top"><%=HTMLFormField%><br/><%=HTMLFormFieldExplain%></td></tr>
							<%
								if (extraButton!="" && extraData!=null){
							%>
									<%@ include file="crsedt4.jsp" %>
							<%
								}
							%>
								<tr>
									<td align="right">
										<br><br>
										<hr size="1" />
										<input type="hidden" value="<%=nextNo%>" name="no">
										<input type="hidden" value="<%=currentSeq%>" name="lastNo">
										<input type="hidden" value="<%=newNo%>" name="newNo">
										<input type="hidden" value="<%=currentTab%>" name="currentTab">
										<input type="hidden" value="<%=endOfThisTab%>" name="endOfThisTab">
										<input type="hidden" value="<%=recyclePage%>" name="recyclePage">
										<%
											if (extraButton != ""){
										%>
											<input title="<%=extraCmdTitle%>" type="submit" value="<%=extraButton%>" <%=extraDisabled%> class="inputsmallgray<%=extraClass%>" onClick="return extraForm('<%=extraForm%>')">
										<%
											}
										%>

										<input title="save entered data" type="submit" value="Save" <%=submitDisabled%> class="inputsmallgray<%=submitClass%>" onClick="return checkForm('s')">
										<input title="end this operation" type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
										<input title="request outline review" type="submit" value="Review" <%=reviewDisabled%> class="inputsmallgray<%=reviewClass%>" onClick="return checkForm('r')">
										<input title="request outline approval" type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">&nbsp;

										<input type="hidden" value="q" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
										<input type="hidden" value="<%=question_friendly%>" name="column">
										<input type="hidden" value="<%=questionTab%>" name="questionTab">
										<input type="hidden" value="<%=courseAlpha%>" name="alpha">
										<input type="hidden" value="<%=courseNum%>" name="num">
										<input type="hidden" value="<%=question_explain%>" name="question_explain">
										<input type="hidden" value="0" name="selectedCheckBoxes">
									</td>
								</tr>
								<%@ include file="crsedt5.jsp" %>
							<%
					break;
				}
			%>
			<input type="hidden" value="<%=validate%>" name="validate">
			<input type="hidden" value="<%=lock%>" name="lock">
			<input type="hidden" value="<%=kix%>" name="kix">
		</TBODY>
	</TABLE>
</form>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<div class="highslide-html-content" id="highslide-html" style="width: 700px">
	<!--
		remove this line to make print button appear correctly.
		<div class="highslide-move" style="border: 0; height: 18px; padding: 2px; cursor: default">
	-->
		<p align="right">
			<a href="#" onclick="window.print();" class="controlx">Print</a>&nbsp;
			<a href="#" onclick="return hs.close(this)" class="controlx">Close</a>
		</p>
	<!-- </div> -->
	<div class="highslide-body"></div>
</div>

</body>
</html>
