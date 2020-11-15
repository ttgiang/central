<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsxtr.jsp - course extra listing attached to rec prep
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = "PRE";
	}

	String currentTab = website.getRequestParameter(request,"aseCurrentTab","",true);
	String currentNo = website.getRequestParameter(request,"asecurrentSeq","",true);
	String src = website.getRequestParameter(request,"src");

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsxtr&viewOption=CUR");
	}

	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	// GUI

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "";
	String subTitle = "";
	String help = "";

	if ((Constant.COURSE_RECPREP).equals(src)){
		pageTitle = "Recommended Preparations";
		help = "RecPrep";
	}
	else if ((Constant.COURSE_PROGRAM_SLO).equals(src)){
		pageTitle = "Program SLO";
		help = "ProgramSLO";
	}

	subTitle = pageTitle;

	fieldsetTitle = pageTitle;
	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<%@ include file="bigbox.jsp" %>
	<script type="text/javascript" src="js/crsxtr.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if ("crsedt".equals(caller)){
		try{
		%>
			<table width="60%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center" border="0">
				<form method="post" name="aseForm" action="crsxtridx.jsp">
					<input type="hidden" name="thisOption" value="CUR">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td colspan="2">
							<table width="100%" cellspacing='1' cellpadding='2' border="0">
								<tr class="textblackTRTheme" + session.getAttribute("aseTheme") + "">
									<td class="textbrownTH" width="10%">&nbsp;</td>
									<td class="textbrownTH" width="80%"><p align="center" class="textbrownTH"><%=subTitle%> for <%=pageTitle%></p><br></td>
									<td class="textbrownTH" width="10%">&nbsp;<a href="crshlp.jsp?t=-1&h=<%=help%>" class="linkColumn" onclick="return hs.htmlExpand(this, { objectType: 'ajax', width: 500})"><img src="images/helpicon.gif" border="0" alt="show help" title="show help"></a></td>
								</tr>
							</table>
						 </td>
					</tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>Campus:&nbsp;</td>
						 <td class="dataColumn"><%=campusName%>
							<input type="hidden" name="thisCampus" value="<%=campus%>">
						 </td>
					</tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>Alpha:&nbsp;</td>
						 <td><input type="text" class="inputajax" id="alpha" name="alpha" autocomplete="off" value="" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.SHORT_ALPHA%>','',document.aseForm.thisOption,document.aseForm.thisCampus,'')">&nbsp;(IE: ICS)
							<input type="hidden" id="alpha_hidden" name="alpha_ID">
					</td></tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>Number:&nbsp;</td>
						 <td><input type="text" class="inputajax" id="numbers" name="numbers" autocomplete="off" value="" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.ALPHA_NUMBER_LIMIT_PREREQ%>',document.aseForm.alpha_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')">&nbsp;(IE: 100)
							<input type="hidden" id="numbers_hidden" name="numbers_ID">
					</td></tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>Comment:&nbsp;</td>
						 <td><input type="text" size="70" maxlength="50" class="input" id="grading" name="grading" value=""></td>
					</tr>
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>&nbsp;</td>
						 <td>
							<input type="hidden" name="thisAlpha" value="<%=alpha%>">
							<input type="hidden" name="thisNum" value="<%=num%>">
							<input type="hidden" name="src" value="<%=src%>">
							<input type="hidden" name="reqID" value="0">
							<input type="hidden" name="act" value="">
							<input type="hidden" name="thisType" value="PRE">
							<input type="hidden" name="kix" value="<%=kix%>">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save data entry" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onclick="return aseSubmitClick('a');">
							<input title="return to outline modification" type="submit" name="aseFinish" value="Close" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=currentTab%>','<%=currentNo%>')">
					</td></tr>
				</form>
				<tr>
					 <td colspan=2 align=center>
						<%
							out.println(ExtraDB.getExtraForEdit(conn,kix,src));
						%>
					 </td>
				</tr>
			</table>
		<%
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn);
%>

<p align="left"><b>Instruction:</b> <font>select the alpha and number designated as <%=subTitle%> for taking</font> <%=alpha%>&nbsp;<%=num%>.<br></p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
