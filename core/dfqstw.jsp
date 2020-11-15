<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	dfqstw.jsp
	*	2007.09.01	define course/campus questions
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "";
	String tableName = website.getRequestParameter(request,"t", "");

	if (tableName.equals(Constant.TABLE_COURSE))
		pageTitle = "Course Question Maintenance";
	else if (tableName.equals(Constant.TABLE_CAMPUS))
		pageTitle = "Campus Question Maintenance";
	else if (tableName.equals(Constant.TABLE_PROGRAM))
		pageTitle = "Program Question Maintenance";

	fieldsetTitle = pageTitle;

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/dfqstx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String formSeq = website.getRequestParameter(request,"formSeq");
	String formName = website.getRequestParameter(request,"formName");
	String formAction = website.getRequestParameter(request,"formAction");
	String code = website.getRequestParameter(request,"code", "");

	if (processPage){

		boolean debug = false;

		int i = 0;
		int j;

		int oldSeq = 0;
		int questionNumber = 0;

		int questionnumber = 0;
		int questionseq = 0;
		String question = null;
		String questionFriendly = null;
		String question_ini = null;
		String questionType = null;
		String question_len = null;
		String question_max = null;
		String help = null;
		String included = null;
		String required = null;
		String auditby = null;
		String auditdate = null;
		String message = null;
		String helpFile = null;
		String audioFile = null;
		String oldIncluded = "";
		String defalt = null;
		String comments = null;
		int userlen = 0;
		String counter = "N";
		String extra = "N";

		String permanent = null;
		String append = null;
		String headerText = null;

		int lid = website.getRequestParameter(request,"lid", 0);

		if ( lid > 0 ){
			oldSeq = website.getRequestParameter(request,"oldSeq",0);
			questionNumber = website.getRequestParameter(request,"questionNumber",0);
			questionseq = Integer.parseInt(website.getRequestParameter(request,"questionseq"));
			questionType = website.getRequestParameter(request,"question_type");
			question_ini = website.getRequestParameter(request,"question_ini");
			question_len = website.getRequestParameter(request,"question_len");
			question_max = website.getRequestParameter(request,"question_max");
			questionFriendly = website.getRequestParameter(request,"question_friendly");
			question = website.getRequestParameter(request,"question","");

			// if header text is empty, put question text in it
			headerText = website.getRequestParameter(request,"headerText","");
			if(headerText.equals(Constant.BLANK) || headerText.equals("<br />")){
				headerText = question;
			}

			help = website.getRequestParameter(request,"helpField");
			included = website.getRequestParameter(request,"include_0");
			oldIncluded = website.getRequestParameter(request,"oldIncluded");
			required = website.getRequestParameter(request,"required_0");
			helpFile = website.getRequestParameter(request,"helpfile");
			audioFile = website.getRequestParameter(request,"audiofile");
			defalt = website.getRequestParameter(request,"defalt");
			comments = website.getRequestParameter(request,"comments_0");
			auditby = user;
			auditdate = aseUtil.getCurrentDateTimeString();
			userlen = website.getRequestParameter(request,"userlen",0);
			counter = website.getRequestParameter(request,"counter_0","N");
			extra = website.getRequestParameter(request,"extra_0","N");

			permanent = website.getRequestParameter(request,"permanent");
			append = website.getRequestParameter(request,"append");

			CCCM6100 cccm = new CCCM6100();
			cccm.setId(lid);
			cccm.setCampus(campus);
			cccm.setType(questionType);
			cccm.setQuestion_Number(questionNumber);
			cccm.setCCCM6100(question);
			cccm.setHeaderText(headerText);
			cccm.setQuestion_Type(questionType);
			cccm.setInclude(included);
			cccm.setComments(comments);
			cccm.setRequired(required);
			cccm.setHelpFile(helpFile);
			cccm.setAudioFile(audioFile);
			cccm.setAuditBy(auditby);
			cccm.setAuditDate(auditdate);
			cccm.setQuestion_Friendly(questionFriendly);
			cccm.setHelp(help);
			cccm.setDefalt(defalt);
			cccm.setQuestion_Ini(question_ini);
			cccm.setQuestionSeq(questionseq);
			cccm.setQuestion_Len(0);
			cccm.setQuestion_Max(0);
			cccm.setQuestion_Change("Y");
			cccm.setUserLen(userlen);
			cccm.setCounter(counter);
			cccm.setExtra(extra);
			cccm.setPermanent(permanent);
			cccm.setAppend(append);

			message = "";

			// when all is N, no point in saving
			if (included.equals(oldIncluded) && oldIncluded.equals("N")){
				message = "";
			}
			else{
				msg = QuestionDB.updateQuestion(conn,cccm,oldSeq,tableName);
				if ("Exception".equals(msg.getMsg())){
					message = "Update failed!!!<br>";
				}
				else{
					message = "Outline item updated successfully.";
				}
			}

		} // lid > 0
	%>
		<table width="100%" cellspacing="1" cellpadding="2" class="tableBorder0" align="center"  border="0">
			<!--
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				<td class="textblackTH" nowrap>ID:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="id" value="<%=lid%>"><%=lid%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Include this item:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="include" value="<%=included%>"><%=included%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Required completion:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="required" value="<%=required%>"><%=required%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Banner Seq:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="questionnumber" value="<%=questionNumber%>"><%=questionNumber%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Campus Seq:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="questionseq" value="<%=questionseq%>"><%=questionseq%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Question:&nbsp;</td>
					<td class="datacolumn"><input type="hidden" name="question" value="<%=question%>"><%=question%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Header Text:&nbsp;</td>
					<td class="datacolumn"><input type="hidden" name="headerText" value="<%=headerText%>"><%=headerText%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Help Text:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="help" value="<%=help%>"><%=help%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Default Text:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="defalt" value="<%=defalt%>"><%=defalt%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Help File:&nbsp;</td>
					<td class="datacolumn"><input type="hidden" name="helpfile" value="<%=helpFile%>"><%=helpFile%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Audio File:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="audiofile" value="<%=audioFile%>"><%=audioFile%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Display Comment Box:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="comments" value="<%=comments%>"><%=comments%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Question Friendly Name:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="question_friendly" value="<%=questionFriendly%>"><%=questionFriendly%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Question Type:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="question_type" value="<%=questionType%>"><%=questionType%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>System Defined Length:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="question_len" value="<%=question_len%>"><%=question_len%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>System Defined Maximum:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="question_max" value="<%=question_max%>"><%=question_max%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>User Required Length:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="userlen" value="<%=userlen%>"><%=userlen%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Text Counter:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="counter" value="<%=counter%>"><%=counter%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Extra Button:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="extra" value="<%=extra%>"><%=extra%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Make default text permanent:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="permanent" value="<%=permanent%>"><%=permanent%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Append default text:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="append" value="<%=append%>"><%=append%></td>
			</tr>

			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Question Ref:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="question_ini" value="<%=question_ini%>"><%=question_ini%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Updated By:&nbsp;</td>
					<td class="datacolumn"><input type="hidden" name="auditby" value="<%=user%>"><%=user%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH" nowrap>Updated Date:&nbsp;</td>
				<td class="datacolumn"><input type="hidden" name="auditdate" value="<%=aseUtil.getCurrentDateTimeString()%>"><%=aseUtil.getCurrentDateTimeString()%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTH">Campus:&nbsp;</td>
				 <td class="datacolumn"><%=campus%></td>
			</tr>
			<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td class="textblackTHRight" colspan="2">
						<input name="lid" type="hidden" value="<%=lid%>">
						<input name="oldSeq" type="hidden" value="<%=oldSeq%>">
						<input name="questionNumber" type="hidden" value="<%=questionNumber%>">
						<input name="formSeq" type="hidden" value="<%=lid%>">
						<input type="hidden" name="formName" value="aseForm">
						<input type="hidden" name="code" value="<%=code%>">
						<input type="hidden" name="t" value="<%=tableName%>">
				 </td>
			</tr>
			-->
			<tr>
				 <td colspan="2" align="center"><br><p align="center"><%=message%></p><p align="center"><a class="linkcolumn" href="dfqst.jsp?t=<%=tableName%>">return to question listing</a></p></td>
			</tr>
		</table>
<%
	} // process Page

	asePool.freeConnection(conn,"dfqstw",user);

	// flows this way so that the connection is closed first
	if ( formAction.equals("c" ) ) {
		response.sendRedirect( "dfqst.jsp?code=" + code + "&t=" + tableName);
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
