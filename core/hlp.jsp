<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	hlp.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "hlp";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "60%";
	String pageTitle = "Help Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/hlp.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		String category = "";
		String title = "";
		String subTitle = "";
		String auditDate = "";
		String auditBy = "";
		String content = "";
		String formAction = "";
		String inputName = "";
		String inputValue = "";
		String savedCampus = "";

		Help help = null;

		int lid = website.getRequestParameter(request,"lid", 0);
		if (lid>0){
			help = HelpDB.getHelp(conn,lid);
			if (help != null){
				category = help.getCategory();
				title = help.getTitle();
				subTitle = help.getSubTitle();
				content = help.getContent();
				auditBy = help.getAuditBy();
				auditDate = help.getAuditDate();
				savedCampus = help.getCampus();
			}
			formAction = "s";
			inputName = "aseSubmit";
			inputValue = "Save";
		}
		else{
			lid = 0;
			auditBy = user;
			auditDate = aseUtil.getCurrentDateTimeString();
			formAction = "i";
			inputName = "aseInsert";
			inputValue = "Insert";
			savedCampus = campus;
		}

%>
		<form method="post" name="aseForm" action="/central/servlet/ttg">
			<table height="200" width="100%" cellspacing="1" cellpadding="2" class="tableBorder0" align="center"  border="0">
				<tr>
					 <td nowrap class="textblackTH" width="15%">ID:&nbsp;</td>
					 <td class="datacolumn"><%=lid%></td>
				</tr>
				<tr>
					 <td nowrap class="textblackTH">Category:&nbsp;</td>
					<td class="datacolumn">
						<%
							String categoryDDL = aseUtil.createStaticSelectionBox("Course,PageHelp,Program",
																									"Course,PageHelp,Program",
																									"category",
																									category,
																									"input",
																									Constant.BLANK,
																									Constant.BLANK,
																									Constant.BLANK);
							out.println(categoryDDL);
						%>
					</td>
				</tr>
				<tr>
					 <td nowrap class="textblackTH">Title:&nbsp;</td>
					<td class="datacolumn"><input type="text" size="30" class="input"  name="title" value="<%=title%>"></td>
				</tr>
				<tr>
					 <td nowrap class="textblackTH">Sub title:&nbsp;</td>
					<td class="datacolumn"><input type="text" size="30" class="input"  name="subtitle" value="<%=subTitle%>"></td>
				</tr>
				<tr>
					 <td nowrap class="textblackTH">Content:&nbsp;</td>
					<td class="datacolumn">

						<textarea cols="80" id="questions" name="questions" rows="10"><%=content%></textarea>
						<script type="text/javascript">
							//<![CDATA[
								CKEDITOR.replace( 'questions',
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
				<tr>
					 <td nowrap class="textblackTH">Audit by:&nbsp;</td>
					 <td class="datacolumn"><%=auditBy%></td>
				</tr>
				<tr>
					 <td nowrap class="textblackTH">Audit date:&nbsp;</td>
					 <td class="datacolumn"><%=auditDate%></td>
				</tr>
				<tr>
					 <td class="textblackTH">Campus:&nbsp;</td>
					 <td class="datacolumn">
						<%
							if (SQLUtil.isSysAdmin(conn,user)){
								String campusDDL = aseUtil.createStaticSelectionBox(	campus+",SYS",
																										campus+",SYS",
																										"campus",
																										savedCampus,
																										"input",
																										Constant.BLANK,
																										Constant.BLANK,
																										Constant.BLANK);
								out.println(campusDDL);
							}
							else{
								out.println(savedCampus);
								out.println("<input type=\"hidden\" name=\"campus\" value=\""+savedCampus+"\">");
							}
						%>
					 </td>
				</tr>
				<tr>
					 <td class="textblackTHRight" colspan="2"><div class="hr"></div>
							<input name="lid" type="hidden" value="<%=lid%>">
							<input type="hidden" name="formAction" value="<%=formAction%>">
							<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="document.aseForm.formAction.value = "c";">
							<input type="hidden" name="formName" value="aseForm">
					 </td>
				</tr>
			</table>
		</form>

<%
	}
	catch( Exception e ){
		out.println(e.toString());
	}


	asePool.freeConnection(conn,"hlp",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
