<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsgen.jsp - general content
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crsgen");

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
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
		response.sendRedirect("sltcrs.jsp?cp=crsgen&viewOption=CUR");
	}

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy")){
		validCaller = true;
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "";
	String subTitle = "";
	String help = "";

	int id = website.getRequestParameter(request,"id",0,false);

	String genContent = "";
	String importMessage = "";

	if (src.equals(Constant.COURSE_PROGRAM_SLO)){
		pageTitle = "Program SLO";
		help = "ProgramSLO";
		importMessage = "Select Program";

		if (id>0){
			genContent = GenericContentDB.getComments(conn,kix,id);
		}
	}
	else if (src.equals(Constant.COURSE_INSTITUTION_LO)){
		pageTitle = "Institution Learning Outcomes (ILO)";
		help = "ProgramILO";
		importMessage = "Select ILO";

		if (id>0){
			genContent = GenericContentDB.getComments(conn,kix,id);
		}
	}
	else if (src.equals(Constant.COURSE_GESLO)){
		pageTitle = "General Education SLO (GESLO)";
		help = "GESLO";
		importMessage = "Select GESLO";

		if (id>0){
			genContent = GenericContentDB.getComments(conn,kix,id);
		}
	}

	subTitle = pageTitle;

	fieldsetTitle = pageTitle;
	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<%@ include file="bigbox.jsp" %>
	<script type="text/javascript" src="js/crsgen.js"></script>
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
			<table width="80%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center" border="0">
				<form method="post" name="aseForm" action="/central/servlet/linker?arg=frm">
					<input type="hidden" name="thisOption" value="CUR">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td colspan="2">
							<table width="100%" cellspacing='0' cellpadding='2' border="0">
								<tr class="textblackTRTheme" + session.getAttribute("aseTheme") + "">
									<td class="textbrownTH" width="10%">&nbsp;</td>
									<td class="textbrownTH" width="80%"><p align="center" class="textbrownTH"><%=campusName%><br><%=subTitle%><br><%=pageTitle%></p><br></td>
									<td class="textbrownTH" width="10%">&nbsp;
										<a href="vwcrsy.jsp?pf=1&kix=<%=kix%>&comp=0" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline"></a>&nbsp;&nbsp;
										<img src="images/helpicon.gif" border="0" alt="show help" title="show help" onclick="switchMenu('crshlp');">
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<p align="right">
										<a href="slctlst.jsp?rtn=crsgen&kix=<%=kix%>&src=<%=src%>&dst=<%=src%>" class="linkcolumn"><%=importMessage%></a>
										&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
										<a href="qlst1.jsp?rtn2=edtpslo&kix=<%=kix%>&itm=<%=src%>" class="linkcolumn">Quick List Entry</a>&nbsp;&nbsp;
										<%
											String junk = ValuesDB.getListByCampusSrcSubTopic(conn,campus,src,alpha);
											if (junk.length() > 0){
										%>
												&nbsp;<font color="#c0c0c0">|</font>&nbsp;&nbsp;<a href="crsgenw.jsp?kix=<%=kix%>&itm=<%=src%>&alpha=<%=alpha%>" class="linkcolumn">Auto Fill Program SLO</a>&nbsp;
										<%
											}
										%>
										</p>
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
						 <td colspan="2" class="textblackTH" nowrap><%=subTitle%></td>
					</tr>

					<tr>
						 <td colspan="2">
					<%
								String ckName = "genContent";
								String ckData = genContent;
					%>
								<%@ include file="ckeditor02.jsp" %>

						 </td>
					</tr>

					<tr>
						 <td align="right" colspan="2">
							<input type="hidden" name="thisAlpha" value="<%=alpha%>">
							<input type="hidden" name="thisNum" value="<%=num%>">
							<input type="hidden" name="src" value="<%=src%>">
							<input type="hidden" name="dst" value="">
							<input type="hidden" name="keyid" value="<%=id%>">
							<input type="hidden" name="act" value="">
							<input type="hidden" name="thisType" value="PRE">
							<input type="hidden" name="thisCampus" value="<%=campus%>">
							<input type="hidden" name="kix" value="<%=kix%>">
							<input type=hidden value="crsgen" name="caller">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save data entry" type="submit" name="aseSave" value="Save" class="inputsmallgray" onclick="return aseSubmitClick('a');">
							<input title="return to outline modification" type="submit" name="aseFinish" value="Close" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=currentTab%>','<%=currentNo%>','<%=caller%>','<%=campus%>')">
					</td></tr>
				</form>
				<tr>
					 <td colspan=2 align=center>
						<%
							out.println(GenericContentDB.getContentsByType(conn,kix,src));
						%>
					 </td>
				</tr>
			</table>
		<%
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // if

	asePool.freeConnection(conn,"crsgen",user);
%>

<!--
<p align="left">
<b>Instruction:</b>&nbsp;Click the image (<img src="../images/reviews1.gif" border="0">) to the left of each PSLO to create links to other outline items.<br/>
<b>Legend:</b>
<img src="../images/reviews1.gif" border="0">=Competency;&nbsp;&nbsp;
-->

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
