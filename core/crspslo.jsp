<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crspslo.jsp	- 	quick list entry for PSLO for entire alphpa at a campus
	*						PSLOs are added to CUR outlines for entire ALPHA at a campus
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Quick List Program SLO Entry";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/quickpsloentry.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";

	String alphaIdx = aseUtil.getPropertySQL(session,"alphas");
	String alphaList = aseUtil.createSelectionBox(conn,alphaIdx,"alpha","","","",false,"onChange=\"javascript:alphaOnChange();\"");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crspslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p>
<font class="textblackth">Use this function to quickly add Program SLOs to an entire ALPHA.
<br/>Outlines currently going through the modification process are not included.&nbsp;&nbsp;
</font>
</p>

<%
	if (processPage){
%>
<form name="aseForm" method="post" action="crspslox.jsp">
	<table width="60%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Campus:</td>
			<td width="90%" valign="top" class="datacolumn"><%=campus%></td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Alpha:</td>
			<td width="90%" valign="top" class="datacolumn"><%=alphaList%></td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td height="30" width="100%" valign="top" colspan="2">
				<font class="textblackth">Paste your list in the box below then separate each item with double slashes (//).<br/>
				Finalize the list by	removing all unnecessary text and spaces.</font><br/>
				<textarea name="lst" cols="110" rows="10" class="input"></textarea>
			</td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td height="30" width="100%" valign="top" colspan="2">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<input title="continue" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
				<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
			</td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td colspan="2" valign="top" class="datacolumn"><div style="border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="output"></div></td>
		</tr>
	</table>
</form>

<%
	}
%>

<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"crspslo",user);
%>

</body>
</html>
