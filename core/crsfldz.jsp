<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*
	*	crsfld.jsp	- modification
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String thisPage = "crsfldz";

	session.setAttribute("aseCallingPage","crsfldy");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";

	int seq = website.getRequestParameter(request,"no",0);
	int table = website.getRequestParameter(request,"t",0);
	String col = website.getRequestParameter(request,"nox","");
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=crsfld&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "80%";
	String tab = "";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Maintenance";

	// input fields

	String question = "";
	String question_explain = "";
	String question_friendly = "";
	String question_Extra = "";
	String questionNumber = "";

	String questionData[] = new String[2];
	String HTMLFormField = "";
	String HTMLFormFieldExplain = "";
	String controlName = "questions";

	if (seq > 0 || (col != null && col.length() > 0)){
		CCCM6100 cccm6100 = null;

		if (seq > 0){
			cccm6100 = CCCM6100DB.getCCCM6100(conn,seq,campus,table);
		}
		else{
			cccm6100 = CCCM6100DB.getCCCM6100ByFriendlyName(conn,col);
		}

		if ( cccm6100 != null ){
			question = cccm6100.getCCCM6100();
			question_explain = cccm6100.getQuestion_Explain();
			question_friendly = cccm6100.getQuestion_Friendly();
			question_Extra = cccm6100.getExtra();

			String question_ini = cccm6100.getQuestion_Ini();
			String question_type = cccm6100.getQuestion_Type();
			int question_len = cccm6100.getQuestion_Len() + 20;
			int question_max = cccm6100.getQuestion_Max();
			int question_userlen = cccm6100.getUserLen();

			String commentsBox = cccm6100.getComments();

			questionData = courseDB.lookUpQuestion(conn,campus,alpha,num,type,question_friendly,table);

			if (question_friendly.toLowerCase().indexOf("date") > -1) {
				questionData[0] = aseUtil.ASE_FormatDateTime(questionData[0],Constant.DATE_DATETIME);
			}

			// draw the field on screen. get the explained data if available.
			HTMLFormField = aseUtil.drawHTMLField(conn,
									question_type,
									question_ini,
									controlName,
									questionData[0],
									question_len,
									question_max,
									false,
									campus,
									false,
									question_friendly,
									question_userlen);

			// do we display consent for pre/co req in its current state
			String displayConsentForCourseMods = Util.getSessionMappedKey(session,"DisplayConsentForCourseMods");
			if (	displayConsentForCourseMods.equals(Constant.OFF) &&
				(	question_friendly.equals(Constant.COURSE_PREREQ) ||
					question_friendly.equals(Constant.COURSE_COREQ) ||
					question_friendly.equals(Constant.COURSE_COMPARABLE) )
				) {
				HTMLFormField = "";
			} // DisplayConsentForCourseMods

			if (question_friendly.equals(Constant.COURSE_GESLO)){
				HTMLFormField = "";
				HTMLFormFieldExplain = GESLODB.getGESLO(conn,campus,kix,false);
			}
			else{
				if(question_explain!=null && question_explain.length()>0 && commentsBox.equals("Y")){
					HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,alpha,num,type,question_explain);
					HTMLFormFieldExplain = aseUtil.drawHTMLField(conn,
											"wysiwyg",
											"",
											"explain",
											HTMLFormFieldExplain,
											0,
											0,
											false,
											"",
											false);
				}
			}
		}

		int maxNo = 0;
		questionNumber = "" + seq;
		if (table==2){
			maxNo = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			questionNumber = "" + (seq + maxNo);
		}
		else{
			questionNumber = "" + (seq);
		}

		question = questionNumber + ". " + question;
	} // seq > 0

	asePool.freeConnection(conn,"crsfldz",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="lib/extra.jsp" %>
	<script language="JavaScript" src="js/crsfldz.js"></script>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/textcounter.js"></script>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && (seq > 0 || (col != null && col.length() > 0))){

		String courseAlpha = alpha;
		String courseNum = num;
		String extraData = "";
		String extraCmdTitle = "";
		String extraButton = "";
		String extraArg = "";
		String extraForm = "";
		String extraTitle = "";
		boolean messagePage = false;

		String extraDisabled = "";
		String extraClass = "";

			// this is for data retrieval to display the exta button
			if (question_Extra.equals("Y")){
		%>
			<%@ include file="crsedt14.jsp" %>
		<%
			} // extra button
		%>

<form method="post" action="/central/servlet/pokey" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<tr>
				<td class="textblackTH"><%=question%></td>
			</tr>
			<tr>
				<td class="dataColumn" height="100" valign="top">
					<%
						if (extraButton.length() > 0 && extraData != null && extraTitle.length() > 0){
					%>
							<table width="100%" border="0">
								<tr>
									<td>
										<%@ include file="crsedt4.jsp" %>
									</td>
								</tr>
							</table>
					<%
						} // extraButton

					%>

					<%=HTMLFormField%><br/><%=HTMLFormFieldExplain%>

				</td>
			</tr>
			<TR><TD align="left"><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<tr>
				<td align="left">
					<br><br>
					<hr size="1" />

					<%
						boolean showWarning = false;

						if(question_Extra.toLowerCase().equals("y") && extraTitle.length() > 0 && extraButton.length() > 0 ){
							showWarning = true;
					%>
						<input title="<%=extraCmdTitle%>" type="submit" value="<%=extraButton%>" class="inputsmallgrayextra<%=extraClass%>" onClick="return extraForm('<%=extraForm%>','<%=extraArg%>','<%=kix%>')">
					<%
						}
					%>

					<input title="save entered data" type="submit" value="Save" class="inputsmallgray" onClick="return checkForm()">
					<input title="end this operation" type="submit" value="Close" class="inputsmallgray" onClick="return closeForm()">

					<%
						if(showWarning){
					%>
						<p>
							<font color="red">NOTE: You MUST click the above 'Save' button whenever you edit extra data behind the yellow (extra data) button.</font>
						</p>
					<%
						}
					%>

					<input type="hidden" value="q" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
					<input type="hidden" value="<%=table%>" name="table">
					<input type="hidden" value="<%=question_friendly%>" name="column">
					<input type="hidden" value="<%=questionNumber%>" name="questionNumber">
					<input type="hidden" value="<%=question_explain%>" name="question_explain">
					<input type="hidden" value="0" name="selectedCheckBoxes">
					<input type="hidden" value="raw" name="src">
				</td>
			</tr>
		</TBODY>
	</TABLE>
</form>

<%
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
