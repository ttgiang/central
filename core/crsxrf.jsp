<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsxrf.jsp
	*
	*	2009.07.25	- 	remove check on course number. It's ok to add cross list to
	*					-	something not yet approved
	*	2007.09.01 	- 	original
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// these values were set in crsedt
	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");
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

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsxrf&viewOption=CUR");
	}

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy")){
		validCaller = true;
	}

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Cross List";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;	/* Never change this one */
			width:320px;	/* Width of box */
			height:250px;	/* Height of box */
			overflow:auto;	/* Scrolling features */
			border:1px solid #317082;	/* Dark green border */
			background-color:#FFF;		/* White background color */
			text-align:left;
			font-size:.9em;
			z-index:100;
		}
		#ajax_listOfOptions div{	/* General rule for both .optionDiv and .optionDivSelected */
			margin:1px;
			padding:1px;
			cursor:pointer;
			font-size:0.9em;
		}
		#ajax_listOfOptions .optionDiv{	/* Div for each item in list */

		}
		#ajax_listOfOptions .optionDivSelected{ /* Selected item in the list */
			background-color:#317082;
			color:#FFF;
		}
		#ajax_listOfOptions_iframe{
			background-color:#F00;
			position:absolute;
			z-index:5;
		}

		form{
			display:inline;
		}
	</style>

	<script type="text/javascript" src="js/crsxrf.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage && validCaller){
		try{
		%>
			<table width="80%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center" border="0">
				<form method="post" name="aseForm" action="crsxrfx.jsp">
					<input type="hidden" name="thisOption" value="CUR">

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td colspan="2">
						 <p align="center" class="textbrownTH"><%=pageTitle%>
							&nbsp;&nbsp;<a href="vwcrsy.jsp?pf=1&kix=<%=kix%>&comp=0" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="view outline" title="view outline"></a>&nbsp;&nbsp;
						 </p><br></td>
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
						 <td><input type="text" class="inputajax" id="numbers" name="numbers" autocomplete="off" value="" onkeyup="ajax_showOptions(this,'getACS',event,'/central/servlet/ACS','<%=aseUtil.ALPHA_NUMBER_LIMIT_XLIST%>',document.aseForm.alpha_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')">&nbsp;(IE: 100)
							<input type="hidden" id="numbers_hidden" name="numbers_ID">
					</td></tr>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td class="textblackTH" nowrap>&nbsp;</td>
						 <td>
							<input type="hidden" name="thisAlpha" value="<%=alpha%>">
							<input type="hidden" name="thisNum" value="<%=num%>">
							<input type="hidden" name="reqID" value="0">
							<input type="hidden" name="act" value="">
							<input type="hidden" name="thisType" value="PRE">
							<input type="hidden" name="kix" value="<%=kix%>">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save data entry" type="submit" name="aseSubmit" value="Save" class="inputsmallgray" onclick="return aseSubmitClick('a');">
							<input title="return to outline modification" type="submit" name="aseFinish" value="Close" class="inputsmallgray" onClick="return cancelForm('<%=kix%>','<%=currentTab%>','<%=currentNo%>','<%=caller%>','<%=campus%>')">
					</td></tr>
				</form>
				<tr>
					 <td colspan=2 align=center>
					 	<!--
						<br /><div style="border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 600px;" id="output">
						<p align=center></p>
						</div>
						-->
						<%
							out.println(courseDB.getXListForEdit(conn,campus,alpha,num,"PRE"));
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

	asePool.freeConnection(conn,"crsxrfx",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
