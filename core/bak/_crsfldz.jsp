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
	String col = website.getRequestParameter(request,"nox","");
	int table = website.getRequestParameter(request,"t",0);
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
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
	String question_type = "";

	String questionData[] = new String[2];
	String HTMLFormField = "";
	String HTMLFormFieldExplain = "";
	String controlName = "questions";

	String ckName = controlName;
	String ckData = "";

	CCCM6100 cccm6100 = null;

	if (seq > 0 || (col != null && col.length() > 0)){

		if (seq > 0)
			cccm6100 = CCCM6100DB.getCCCM6100(conn,seq,campus,table);
		else
			cccm6100 = CCCM6100DB.getCCCM6100ByFriendlyName(conn,col);

		if ( cccm6100 != null ){
			question = cccm6100.getCCCM6100();
			question_explain = cccm6100.getQuestion_Explain();
			question_friendly = cccm6100.getQuestion_Friendly();
			question_Extra = cccm6100.getExtra();
			question_type = cccm6100.getQuestion_Type();

			String question_ini = cccm6100.getQuestion_Ini();
			int question_len = cccm6100.getQuestion_Len() + 20;
			int question_max = cccm6100.getQuestion_Max();

			String commentsBox = cccm6100.getComments();

			questionData = courseDB.lookUpQuestion(conn,campus,alpha,num,type,question_friendly,table);

			// dates are handled differently
			if (question_friendly.toLowerCase().indexOf("date") > -1) {
				questionData[0] = aseUtil.ASE_FormatDateTime(questionData[0],Constant.DATE_DATETIME);
			}

			// do we use ckEditor?
			if(question_type.equals("wysiwyg")){
				ckData = questionData[0];
			}
			else{
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
																	false);
			}

			if (question_friendly.equals(Constant.COURSE_GESLO)){
				HTMLFormField = "";
				HTMLFormFieldExplain = GESLODB.getGESLO(conn,campus,kix,false);
			}
			else{
				if(question_explain!=null && question_explain.length()>0 && commentsBox.equals("Y")){
					HTMLFormFieldExplain = QuestionDB.getExplainData(conn,campus,alpha,num,type,question_explain);
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
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
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

					<table width="80%" border="0">
						<tr>
							<td>
								<%
									if(question_type.equals("wysiwyg")){
								%>
									<%@ include file="ckeditor02.jsp" %>
								<%
									}
								%>

								<%=HTMLFormField%><br/>

								<%
									if(!HTMLFormFieldExplain.equals(Constant.BLANK)){

									String ckName03 = "explain";
									String ckData03 = HTMLFormFieldExplain;

								%>
									<%@ include file="ckeditor03.jsp" %>
								<%
									}
								%>
							</td>
						</tr>
					</table>

				</td>
			</tr>
			<TR><TD align="left"><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<tr>
				<td align="right">

					<div class="hr"></div>

					<%
						if(question_Extra.toLowerCase().equals("y") && extraTitle.length() > 0 && extraButton.length() > 0 ){
					%>
						<input title="<%=extraCmdTitle%>" type="submit" value="<%=extraButton%>" class="inputsmallgrayextra<%=extraClass%>" onClick="return extraForm('<%=extraForm%>','<%=extraArg%>','<%=kix%>')">
					<%
						}
					%>

					<input title="save entered data" type="submit" value="Save" class="inputsmallgray" onClick="return checkForm()">
					<input title="end this operation" type="submit" value="Close" class="inputsmallgray" onClick="return closeForm()">

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
