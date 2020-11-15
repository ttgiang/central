<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprdte.jsp - approver dates
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approver Dates";
	String display = website.getRequestParameter(request,"dsp","");
	String route = website.getRequestParameter(request,"route","0");
	String message = "";

	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/outlineapproval.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

	// pageClear = 1 is when this page is called from menu selection. This means
	// it's the first time to this page. If so, start with a clear page with
	// no saved session value.
	String pageValue = "";
	String pageClear = website.getRequestParameter(request,"pageClr","");
	if ("".equals(pageClear)){
		pageValue = website.getRequestParameter(request,"asePageAPPRDTE","",true);
		if ("0".equals(route) && !"".equals(pageValue))
			route = pageValue;
		else
			session.setAttribute("asePageAPPRDTE",route);
	}

	int rte = NumericUtil.stringToInt(route);

	String HTMLFormField = "";

	if (processPage)
		HTMLFormField = Html.drawListBox(conn,"ApprovalRouting","route",route,campus,false,false);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script language="JavaScript" src="js/CalendarPopup.js"></script>
	<link href="../inc/calendar.css" rel="stylesheet" type="text/css">
	<SCRIPT language="JavaScript" id="dateID">
		var dateCal = new CalendarPopup("dateDiv");
		dateCal.setCssPrefix("CALENDAR");
	</SCRIPT>

	<script type="text/javascript" src="js/apprdte.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%
	if (display != null && display.length() > 0){
%>
	<%@ include file="../inc/headerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/header.jsp" %>

	<table border="0" cellpadding="2" width="90%" align="center" cellspacing="1">
		<tr>
			<td width="40%" height="30" valign="top" align="left" nowrap>
			 <%
			 		if (processPage){
						out.println("<form name=\"aseForm\" method=\"post\" action=\"?\">");
						out.println("<font class=\"textblackth\">Approval Routing: </font>" + HTMLFormField);
						out.println("<input type=\"hidden\" name=\"src\" value=\"trms\">");
						out.println("<input type=\"submit\" name=\"aseSubmit\" value=\"Go\" class=\"Input\">");
						out.println("</form>");
					}
			 %>
			</td>
		</tr>
	</table>

<%
	}

	if (processPage && rte > 0){
		out.println("<form name=\"aseForm2\" method=\"post\" action=\"apprdtex.jsp\">");
		out.println(ApproverDB.showApproversDateInput(conn,campus,Integer.parseInt(route)));
		out.println("<p align=\"right\"><input type=\"submit\" name=\"cmdSubmit\" value=\"Submit\" class=\"input\">");
		out.println("<input type=\"submit\" name=\"cmdCancel\" value=\"Cancel\" class=\"input\" onClick=\"return cancelForm()\">");
		out.println("<input type=\"hidden\" value=\"c\" name=\"formAction\">");
		out.println("<input type=\"hidden\" value=\"aseForm2\" name=\"formName\">");
		out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></form>");
	}
%>

<p align="center">NOTE: date must be in mm/dd/yyyy format</p>

<%
	asePool.freeConnection(conn,"apprdte",user);

	if ( display != null && display.length() > 0 ){
%>
	<%@ include file="../inc/footerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/footer.jsp" %>
<%
	}
%>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
