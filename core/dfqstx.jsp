<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	dfqstx.jsp
	*	2007.09.01	define course/campus questions
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "";
	String tableName = website.getRequestParameter(request,"t", "");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (tableName.equals(Constant.TABLE_COURSE))
		pageTitle = "Course Question Maintenance";
	else if (tableName.equals(Constant.TABLE_CAMPUS))
		pageTitle = "Campus Question Maintenance";
	else if (tableName.equals(Constant.TABLE_PROGRAM))
		pageTitle = "Program Question Maintenance";

	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/itemmaintenance.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";

	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dfqstx.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%

	if (processPage){

		String formSeq = website.getRequestParameter(request,"formSeq");
		String formName = website.getRequestParameter(request,"formName");
		String formAction = website.getRequestParameter(request,"formAction");
		String code = website.getRequestParameter(request,"code", "");

		int questionNumber = 0;
		int oldSeq = 0;
		String oldIncluded = "";
		String sql = "";
		int lid = website.getRequestParameter(request,"lid", 0);

		int junk = 0;

		final int formID = junk;
		final int formInclude = ++junk;
		final int formRequired = ++junk;
		final int formQN = ++junk;
		final int formQS = ++junk;
		final int form6100 = ++junk;
		final int formHeader = ++junk;
		final int formHelp = ++junk;
		final int formDefalt = ++junk;
		final int formHelpFile = ++junk;
		final int formAudio = ++junk;
		final int formComments = ++junk;
		final int formQF = ++junk;
		final int formQType = ++junk;
		final int formQLen = ++junk;
		final int formQMax = ++junk;
		final int formUserLen = ++junk;
		final int formCounter = ++junk;
		final int formExtra = ++junk;
		final int formPermanent = ++junk;
		final int formAppend = ++junk;

		final int formIni = ++junk;
		final int formAuditBy = ++junk;
		final int formAuditDate = ++junk;

		String[] sColumnValue = new String[++junk];

		String permanent = "";
		String append = "";

		if (lid>0){
			CCCM6100 cccm = CCCM6100DB.getCCCM6100ByIDCampusCourse(conn,lid,campus,tableName);
			if (cccm != null){
				sColumnValue[formID] = String.valueOf(cccm.getId());
				sColumnValue[formInclude] = cccm.getInclude();
				oldIncluded = cccm.getInclude();
				sColumnValue[formRequired] = cccm.getRequired();
				sColumnValue[formQN] = String.valueOf(cccm.getQuestion_Number());
				sColumnValue[formQS] = String.valueOf(cccm.getQuestionSeq());
				sColumnValue[form6100] = cccm.getCCCM6100();
				sColumnValue[formHeader] = cccm.getHeaderText();
				sColumnValue[formHelp] = cccm.getHelp();
				sColumnValue[formDefalt] = cccm.getDefalt();
				sColumnValue[formHelpFile] = cccm.getHelpFile();
				sColumnValue[formAudio] = cccm.getAudioFile();
				sColumnValue[formComments] = cccm.getComments();
				sColumnValue[formQF] = cccm.getQuestion_Friendly();
				sColumnValue[formQType] = cccm.getQuestion_Type();
				sColumnValue[formQLen] = String.valueOf(cccm.getQuestion_Len());
				sColumnValue[formQMax] = String.valueOf(cccm.getQuestion_Max());
				sColumnValue[formUserLen] = String.valueOf(cccm.getUserLen());
				sColumnValue[formCounter] = String.valueOf(cccm.getCounter());
				sColumnValue[formExtra] = String.valueOf(cccm.getExtra());
				sColumnValue[formPermanent] = String.valueOf(cccm.getPermanent());
				sColumnValue[formAppend] = String.valueOf(cccm.getAppend());

				permanent = sColumnValue[formPermanent];
				append = sColumnValue[formAppend];

				sColumnValue[formIni] = cccm.getQuestion_Ini();
				sColumnValue[formAuditBy] = cccm.getAuditBy();
				sColumnValue[formAuditDate] = cccm.getAuditDate();
				questionNumber = cccm.getQuestion_Number();
				oldSeq = cccm.getQuestionSeq();
			}
		}
		else{
			lid = 0;
			sql = "0,0,0,,,,,,,,,,,"
				+ user
				+ ","
				+ aseUtil.getCurrentDateTimeString();
			sColumnValue = sql.split(",");
		}


%>
		<form method="post" name="aseForm" action="dfqstw.jsp">
			<table height="180" width="100%" cellspacing="1" cellpadding="2" class="tableBorder0" align="center"  border="0">
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>ID:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formID]%><input name="id" type="hidden" value="<%=sColumnValue[formID]%>"></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Include this item:&nbsp;</td>
					<td>
						<%
							out.println(aseUtil.drawHTMLField(conn,"radio","YN","include",sColumnValue[formInclude],0,0,false,campus,false));
						%>
					</td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Required completion:&nbsp;</td>
					<td>
						<%
							out.println(aseUtil.drawHTMLField(conn,"radio","YN","required",sColumnValue[formRequired],0,0,false,campus,false));
						%>
					</td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Banner Seq:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formQN]%><input name="questionnumber" type="hidden" value="<%=sColumnValue[3]%>"></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Campus Seq:&nbsp;</td>
					 <td><input size="40" class="input" name="questionseq" type="text" value="<%=sColumnValue[formQS]%>"></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Question:&nbsp;</td>
					 <td><textarea cols="90" rows="08" class="input"  name="question"><%=sColumnValue[form6100]%></textarea></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Header Text:&nbsp;</td>
					<td>

						<textarea cols="80" id="headerText" name="headerText" rows="10"><%=sColumnValue[formHeader]%></textarea>
						<script type="text/javascript">
							//<![CDATA[
								CKEDITOR.replace( 'headerText',
									{
										toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
													],
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode: CKEDITOR.ENTER_P
									});
							//]]>
						</script>
					</td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Help Text:&nbsp;</td>
					<td>

						<textarea cols="80" id="helpField" name="helpField" rows="10"><%=sColumnValue[formHelp]%></textarea>
						<script type="text/javascript">
							//<![CDATA[
								CKEDITOR.replace( 'helpField',
									{
										toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
													],
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode: CKEDITOR.ENTER_P
									});
							//]]>
						</script>
					</td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Default Text:&nbsp;</td>
					 <td>
					 	<textarea cols="90" rows="08" class="input"  id="defalt" name="defalt"><%=sColumnValue[formDefalt]%></textarea>

						<script type="text/javascript">
							//<![CDATA[
								CKEDITOR.replace( 'defalt',
									{
										toolbar : [ ['Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','Source' ]
													],
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode: CKEDITOR.ENTER_P
									});
							//]]>
						</script>

						<p><font class="textblackth">Default Text Options:<font></p>
						<br>
						Make text permanent:
						<font class="datacolumn">
							<input type="radio" value="Y" name="permanent" <% if(permanent.equals("Y")) out.println("checked"); %> >&nbsp;Y&nbsp;&nbsp;
							<input type="radio" value="N" name="permanent" <% if(permanent.equals("N")) out.println("checked"); %> >&nbsp;N&nbsp;&nbsp;
						</font>
						<br>
						Append text:
						<font class="datacolumn">
							<input type="radio" value="B" name="append" <% if(append.equals("B")) out.println("checked"); %> >&nbsp;Before&nbsp;&nbsp;
							<input type="radio" value="A" name="append" <% if(append.equals("A")) out.println("checked"); %> >&nbsp;After&nbsp;&nbsp;&nbsp;&nbsp;
						</font>
						outline item
						<br>
						<br>
						<font class="goldhighlights">
							Note: Append text is applicable only when permanent is set to Y.
						</font>

					 </td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Help File:&nbsp;</td>
					 <td><input size="40" class="input"  name="helpfile" type="text" value="<%=sColumnValue[formHelpFile]%>"></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Audio File:&nbsp;</td>
					 <td><input size="40" class="input"  name="audiofile" type="text" value="<%=sColumnValue[formAudio]%>"></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Display Comment Box:&nbsp;</td>
					 <td>
						<%
							out.println(aseUtil.drawHTMLField(conn,"radio","YN","comments",sColumnValue[formComments],0,0,false,campus,false));
						%>
						<br>(If a comment box is available, should it be displayed? Applicable to Question Type 'WYSIWYG' or 'TEXT' only.)<br><br>
					 </td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Friendly Name:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formQF]%><input name="question_friendly" type="hidden" value="<%=sColumnValue[formQF]%>"></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Question Type:&nbsp;</td>
					 <td class="datacolumn">
						<%=sColumnValue[formQType]%><input name="question_type" type="hidden" value="<%=sColumnValue[formQType]%>">
					 </td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>System Defined Length:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formQLen]%><input name="question_len" type="hidden" value="<%=sColumnValue[formQLen]%>">
					 </td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>System Defined Maximum:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formQMax]%><input name="question_max" type="hidden" value="<%=sColumnValue[formQMax]%>"></td>
				</tr>

				<%
					//  (TTG)
					if (sColumnValue[formQType].indexOf("text") > -1 && isSysAdm){
				%>
					<tr class="textblackTRThemeCallOut">
						 <td class="textblackTH" nowrap>User Required Length:&nbsp;</td>
						 <td class="datacolumn"><input name="userlen" type="text" value="<%=sColumnValue[formUserLen]%>">
						 </td>
					</tr>
				<%
					}
				%>

				<%
					if ((sColumnValue[formQType].indexOf("text") > -1 || sColumnValue[formQType].indexOf("wysiwyg") > -1)){
				%>
					<tr class="textblackTRThemeCallOut">
						 <td class="textblackTH" nowrap>Include text counter:&nbsp;</td>
						 <td class="datacolumn">
							<%
								out.println(aseUtil.drawHTMLField(conn,"radio","YN","counter",sColumnValue[formCounter],0,0,false,campus,false));
							%>
							<br>(For questions with a text editor, should CC display the text counter?)<br><br>
						 </td>
					</tr>
				<%
					}
				%>

				<tr class="textblackTRThemeCallOut">
					 <td class="textblackTH" nowrap>Include Extra Button:&nbsp;</td>
					 <td class="datacolumn">
						<%
							out.println(aseUtil.drawHTMLField(conn,"radio","YN","extra",sColumnValue[formExtra],0,0,false,campus,false));
						%>
						<br>(For questions where extra data is available, should the extra button show? For example, content, SLO, pre/co requisites.)<br><br>
					 </td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Reference:&nbsp;</td>
					 <td class="datacolumn"><input name="question_ini" type="hidden" value="<%=sColumnValue[formIni]%>"></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Updated By:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formAuditBy]%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH" nowrap>Updated Date:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[formAuditDate]%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH">Campus:&nbsp;</td>
					 <td class="datacolumn"><%=campus%></td>
				</tr>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					 <td class="textblackTHRight" colspan="2"><div class="hr"></div>
							<input name="lid" type="hidden" value="<%=lid%>">
							<input name="questionNumber" type="hidden" value="<%=questionNumber%>">
							<input name="oldSeq" type="hidden" value="<%=oldSeq%>">
							<input name="formSeq" type="hidden" value="sc2">
							<input type="hidden" name="formAction" value="s">
							<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm('<%=tableName%>')">
							<input type="hidden" name="formName" value="aseForm">
							<input type="hidden" name="code" value="<%=code%>">
							<input type="hidden" name="oldIncluded" value="<%=oldIncluded%>">
							<input type="hidden" name="t" value="<%=tableName%>">
					 </td>
				</tr>
			</table>
		</form>
<%

	} // processPage

	asePool.freeConnection(conn,"dfqstx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
