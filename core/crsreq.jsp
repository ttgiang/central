<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsreq.jsp - course prereq/coreq
	*	TODO	need to get grading over to JS for saving
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// these values were set in crsedt
	String pageTitle = "";
	String subTitle = "";
	String help = "";
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

	String table = website.getRequestParameter(request,"aseRequisite","",true);
	String currentTab = website.getRequestParameter(request,"aseCurrentTab","",true);
	String currentNo = website.getRequestParameter(request,"asecurrentSeq","",true);
	String campusName = CampusDB.getCampusName(conn,campus);

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy")){
		validCaller = true;
	}

	String constant = "";

	if (processPage){

		// screen has configurable item. setting determines whether
		// users are sent directly to news or task screen after login
		session.setAttribute("aseConfig","1");
		session.setAttribute("aseConfigMessage","Determines whether someone should be notified when requisites are added/deleted.");

		if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
			response.sendRedirect("sltcrs.jsp?cp=crsreq&viewOption=CUR");
		}

		if ("1".equals(table)){
			pageTitle = "Pre-Requisites";
			help = "Pre-Requisite";
			constant = Constant.IMPORT_PREREQ;
		}
		else if ( "2".equals(table)){
			pageTitle = "Co-Requisites";
			help = "Co-Requisite";
			constant = Constant.IMPORT_COREQ;
		}

		subTitle = pageTitle;
		fieldsetTitle = pageTitle;
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	}
	else{
		caller = "";
	}

	String grading = "";
	String ax = "";
	String nx = "";
	int ix = 0;
	String consent = "1";

	String edit = website.getRequestParameter(request,"e","0");
	if (edit.equals(Constant.ON)){

		ax = website.getRequestParameter(request,"a","");
		nx = website.getRequestParameter(request,"n","");
		ix = website.getRequestParameter(request,"i",0);

		if (ix > 0){
			String[] rtn = RequisiteDB.getEditData(conn,campus,kix,ax,nx,ix,constant);
			if (rtn != null){
				grading = rtn[0];
				consent = rtn[1];
			}
		} // ix

	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<%@ include file="bigbox.jsp" %>
	<script type="text/javascript" src="js/crsreq.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage && validCaller){
		try{
		%>
			<table width="80%" cellspacing="1" cellpadding="5" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center" border="0">
				<form method="post" name="aseForm" action="crsreqidx.jsp">
					<input type="hidden" name="thisOption" value="CUR">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td colspan="2">
							<table width="100%" cellspacing='1' cellpadding='2' border="0">
								<tr class="textblackTRTheme" + session.getAttribute("aseTheme") + "">
									<td class="textbrownTH" width="10%">&nbsp;</td>
									<td class="textbrownTH" width="80%"><p align="center" class="textbrownTH"><%=subTitle%> for <%=pageTitle%></p><br></td>
									<td class="textbrownTH" width="10%">&nbsp;
										<a href="/centraldocs/docs/help/V_EnterPrerequisite.swf" class="linkColumn" target="_blank"><img src="../images/vol.gif" border="0" alt="show help video" title="show help video"></a>&nbsp;&nbsp;
										<a href="vwcrsy.jsp?pf=1&kix=<%=kix%>&comp=0" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline"></a>&nbsp;&nbsp;
										<img src="images/helpicon.gif" border="0" alt="show help" title="show help" onclick="switchMenu('crshlp');">
									</td>
								</tr>
							</table>
						 </td>
					</tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td colspan="2">
							<%
								String helpArg1 = "Course";
								String helpArg2 = help;
							%>
							<%@ include file="crshlpx.jsp" %>
						</td>
					</tr>

					<tr>
						 <td class="textblackTH" nowrap>Campus:&nbsp;</td>
						 <td class="dataColumn"><%=campusName%>
							<input type="hidden" name="thisCampus" value="<%=campus%>">
						 </td>
					</tr>

					<tr>
						 <td class="textblackTH" nowrap>Alpha:&nbsp;</td>
						 <td><input type="text" class="inputajax" id="alpha" name="alpha" autocomplete="off" value="<%=ax%>" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.SHORT_ALPHA%>','',document.aseForm.thisOption,document.aseForm.thisCampus,'')">&nbsp;(IE: ICS)
							<input type="hidden" id="alpha_hidden" name="alpha_ID" value="<%=ax%>">
					</td></tr>

					<tr>
						 <td class="textblackTH" nowrap>Number:&nbsp;</td>
						 <td><input type="text" class="inputajax" id="numbers" name="numbers" autocomplete="off" value="<%=nx%>" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.ALPHA_NUMBER_LIMIT_PREREQ%>',document.aseForm.alpha_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')">&nbsp;(IE: 100)
							<input type="hidden" id="numbers_hidden" name="numbers_ID" value="<%=nx%>">
					</td></tr>

					<tr>
						 <td class="textblackTH" nowrap>Comment:&nbsp;</td>
						 <td>
						 	<textarea cols="60" rows="5" name="grading" id="grading" class="input"><%=grading%></textarea>
<%
	String ckEditorName = "grading";
%>

	<%@ include file="ckeditor01.jsp" %>

						 </td>
					</tr>

					<%
						String displayOrConsentForPreReqs = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");

						if (displayOrConsentForPreReqs.equals(Constant.ON)){
					%>
						<tr>
							 <td class="textblackTH" nowrap>or Consent:&nbsp;</td>
							 <td><input type="checkbox" id="consent" name="consent" value="<%=consent%>">
							</td>
						</tr>
					<%
						}
					%>

					<tr>
						 <td class="textblackTH" nowrap>&nbsp;</td>
						 <td>
							<input type="hidden" name="thisAlpha" value="<%=alpha%>">
							<input type="hidden" name="thisNum" value="<%=num%>">
							<input type="hidden" name="reqID" value="<%=ix%>">
							<input type="hidden" name="act" value="">
							<input type="hidden" name="cat" value="requisite">
							<input type="hidden" name="thisType" value="PRE">
							<input type="hidden" name="thisTable" value="<%=table%>">
							<input type="hidden" name="kix" value="<%=kix%>">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save data entry" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onclick="return aseSubmitClick('a');">
							<input title="return to outline modification" type="submit" name="aseFinish" value="Close" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=currentTab%>','<%=currentNo%>','<%=caller%>','<%=campus%>')">
					</td></tr>
				</form>
				<tr>
					 <td colspan=2 align=center>
						<%
							// in edit mode, we use PRE
							String thisType = "PRE";
							if(!caller.equals("crsedt")){
								String[] kixInfo = helper.getKixInfo(conn,kix);
								thisType = kixInfo[Constant.KIX_TYPE];
							}

							out.println(RequisiteDB.getRequisitesForEdit(conn,campus,alpha,num,thisType,table));
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

	asePool.freeConnection(conn,"crsreq",user);

%>

<p align="left"><b>Instruction:</b> <font>select the alpha and number designated as <%=subTitle%> for taking</font> <%=alpha%>&nbsp;<%=num%>.<br></p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
