<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsX29.jsp - Other Departments
	*	TODO	need to get grading over to JS for saving
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
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
	String src = website.getRequestParameter(request,"src");
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
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	String campusName = CampusDB.getCampusName(conn,campus);

	if (processPage){

		// screen has configurable item. setting determines whether
		// users are sent directly to news or task screen after login
		session.setAttribute("aseConfig","1");
		session.setAttribute("aseConfigMessage","See system settings for this item");

		pageTitle = "Other Departments";
		help = pageTitle;

		subTitle = pageTitle;
		fieldsetTitle = pageTitle;
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	}
	else
		caller = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<%@ include file="bigbox.jsp" %>
	<script type="text/javascript" src="js/crsX29.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if ("crsedt".equals(caller) || "prgedt".equals(caller)){
		try{
		%>
			<table width="60%" cellspacing="1" cellpadding="5" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center" border="0">
				<form method="post" name="aseForm" action="crsX29idx.jsp">
					<input type="hidden" name="thisOption" value="CUR">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td colspan="2">
							<table width="100%" cellspacing='1' cellpadding='2' border="0">
								<tr class="textblackTRTheme" + session.getAttribute("aseTheme") + "">
									<td class="textbrownTH" width="10%">&nbsp;</td>
									<td class="textbrownTH" width="80%"><p align="center" class="textbrownTH"><%=subTitle%> for <%=pageTitle%></p><br></td>
									<td class="textbrownTH" width="10%">&nbsp;
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
						 <td><input type="text" class="inputajax" id="alpha" name="alpha" autocomplete="off" value="" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.SHORT_ALPHA%>','',document.aseForm.thisOption,document.aseForm.thisCampus,'')">&nbsp;(IE: ICS)
							<input type="hidden" id="alpha_hidden" name="alpha_ID">
					</td></tr>

					<tr>
						 <td class="textblackTH" nowrap>&nbsp;</td>
						 <td>
							<input type="hidden" name="thisAlpha" value="<%=alpha%>">
							<input type="hidden" name="reqID" value="0">
							<input type="hidden" name="ack" value="">
							<input type="hidden" name="thisType" value="PRE">
							<input type="hidden" name="kix" value="<%=kix%>">
							<input type="hidden" name="src" value="<%=src%>">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save data entry" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onclick="return aseSubmitClick('a');">
							<input title="return to outline modification" type="submit" name="aseFinish" value="Close" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=currentTab%>','<%=currentNo%>')">
					</td></tr>
				</form>
				<tr>
					 <td colspan=2 align=center>
						<%
							out.println(ExtraDB.getOtherDepartments(conn,src,campus,kix,true,true));
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

	asePool.freeConnection(conn,"crsX29",user);

%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
