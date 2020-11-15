<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrpt.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Reports";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix");
	String type = website.getRequestParameter(request,"type");
	String progress = website.getRequestParameter(request,"progress","APPROVED");
	String src = website.getRequestParameter(request,"src");

	String message = "";
	String alpha = "";
	String num = "";
	String proposer = "";
	String tableWidth = "80%";

	String fromDate = website.getRequestParameter(request,"from","");
	String toDate = website.getRequestParameter(request,"to","");

	int reportNumber = -1;
	boolean showSummary = false;
	boolean export = false;
	String[] statusTab = null;

	fieldsetTitle = pageTitle;

	// determine report to show
	if (!"".equals(src) && processPage){
		if (!"".equals(kix)){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];
			type = info[Constant.KIX_TYPE];
			proposer = info[Constant.KIX_PROPOSER];
		}

		if ("app".equals(src) || "mod".equals(src)){
			reportNumber = 0;
			showSummary = false;
			tableWidth = "100%";

			if ("app".equals(src))
				pageTitle = "Programs approved by academic year";
			else if ("mod".equals(src))
				pageTitle = "Programs modified by academic year";
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" cellpadding="2" width="<%=tableWidth%>" align="center" cellspacing="1">
	<tr>
		<td>
<%

	if (processPage){
		switch(reportNumber){
			case 0:
				%>
					<form name="aseForm" method="post" action="?">
						<table width="40%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td width="20%" valign="top" class="textblackth">From:</td>
								<td width="80%" valign="top"><input type="text" name="from" class="input" size="6" maxlength="4" value="<%=fromDate%>">&nbsp;(YYYY)</td>
							</tr>
							<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td width="20%" valign="top" class="textblackth">To:</td>
								<td width="80%" valign="top"><input type="text" name="to" class="input" size="6" maxlength="4" value="<%=toDate%>">&nbsp;(YYYY)</td>
							</tr>
							<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
								<td height="30" width="100%" valign="top" colspan="2" align="right">
									<input type="submit" value=" Go " class="inputsmallgray">
									<input type="hidden" name="src" value="<%=src%>">&nbsp;&nbsp;
								</td>
							</tr>
						</table>
					</form>
					<br/>
				<%

				if (!"".equals(fromDate) && !"".equals(toDate)){
					progress = "";

					if ("app".equals(src))
						progress = "APPROVED";

					out.println(ProgramsDB.showProgramsModifiedByAcademicYear(conn,campus,fromDate,toDate,progress));
				}

				break;

			default:
				message = (String)session.getAttribute("aseJasperMessage");
				break;
		}	// switch
	}	// processPage

	asePool.freeConnection(conn,"prgrpt-"+src,user);
%>
		</td>
	</tr>
	<tr>
		<td>
			<%
				out.println(message);
				session.setAttribute("aseJasperMessage","");
			%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
