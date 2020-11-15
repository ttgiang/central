<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccslox.jsp	- quickly collect slo, comp...
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	// item to work on
	String itm = website.getRequestParameter(request,"itm","");

	// where to return 2 when process completes. when doing
	// quick list entry from the menu, it goes back to quick list entry
	// when doing quick list entry from editing screen, return to edit
	String rtn2 = website.getRequestParameter(request,"rtn2","");

	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);

	String html = "";
	String tabTitle = "";

	if (!itm.equals(Constant.BLANK)){
		if ((Constant.COURSE_OBJECTIVES).equals(itm)){
			tabTitle = "Outline SLO";
			html = CompDB.getObjectives(conn,kix);
			if ("".equals(html))
				html = CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,itm);
		}
	}

	String pageTitle = courseDB.setPageTitle(conn,"Quick SLO Entry - ",alpha,num,campus);
	fieldsetTitle = pageTitle;

	asePool.freeConnection(conn,"ccslox",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/ccslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table width="100%" border="0">
	<tr>
		<td width="30%" valign="top">
			<fieldset class="FIELDSET280">
				<legend>Outline Information</legend>
				<%@ include file="crsedt9.jsp" %>
				<br/><br/><br/><br/><br/>
			</fieldset>
		</td>
		<td width="70%" valign="top">
			<fieldset class="FIELDSET560">
			<legend><strong>Quick SLO Entry - step 2 of 4</strong></legend>
				<form name="aseForm" method="post" action="ccsloy.jsp">
					<font class="textblackth">Paste your list in the box below then separate each item with double slashes (//).<br/>
					Finalize the list by	removing all unnecessary text and spaces.</font><br/>
					<textarea name="lst" cols="100" rows="10" class="input"></textarea>
					<br/><br/>
					<font class="textblackth">Clear existing outline content:</font> <input type="checkbox" name="clr" value="1" class="input">
					&nbsp;&nbsp;&nbsp;
					<font class="textblackth">Clear existing list:</font> <input type="checkbox" name="clrList" value="1" class="input">
					<br/><br/>
					<font class="textblackth">Replace outline content with.<br/>
					<textarea name="outlineContent" cols="100" rows="10" class="input"></textarea>
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=itm%>" name="itm">
					<input type="hidden" value="edtslo" name="rtn2">
					<input title="continue" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				</form>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td width="100%" colspan="2" valign="top">
			<fieldset class="FIELDSET">
				<legend><%=tabTitle%></legend>
				<%=html%>
			</fieldset>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
