<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	taskq.jsp
	*	2010.01.18	display task for notification
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Task Notification";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/outlineapproval.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";

	String category = "";
	String kix = website.getRequestParameter(request,"kix","");

	boolean isProgram = ProgramsDB.isAProgram(conn,kix);

	if (isProgram){
		category = "Program";
	}
	else{
		category = "Outline";
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
	%>
		<fieldset class="FIELDSET90">
			<legend><%=category%> Information</legend>
<%
			if (isProgram){

				String degreeDescr = "";
				String divisionDescr = "";
				String title = "";
				String effectiveDate = "";
				String description = "";

				Programs program = ProgramsDB.getProgram(conn,campus,kix);
				if ( program != null ){
					degreeDescr = program.getDegreeDescr();
					divisionDescr = program.getDivisionDescr();
					title = program.getTitle();
					effectiveDate  = program.getEffectiveDate();
					description = program.getDescription();

%>
					<table width="100%" cellSpacing=0 cellPadding=5 border="0">
						<TBODY>
							<tr>
								<td class="textblackth" width="15%" valign="top">Degree:&nbsp;</td>
								<td class="datacolumn" valign="top"><%=degreeDescr%></td>
							</tr>
							<tr>
								<td class="textblackth" width="15%" valign="top">Division:&nbsp;</td>
								<td class="datacolumn" valign="top"><%=divisionDescr%></td>
							</tr>
							<tr>
								<td class="textblackth" valign="top">Title:&nbsp;</td>
								<td class="datacolumn" valign="top"><%=title%></td>
							</tr>
							<tr>
								<td class="textblackth" valign="top">Description:&nbsp;</td>
								<td class="datacolumn" valign="top"><%=description%></td>
							</tr>
							<tr>
								<td class="textblackth" valign="top">Effective Date:&nbsp;</td>
								<td class="datacolumn" valign="top"><%=effectiveDate%></td>
							</tr>
						</TBODY>
					<table>
<%
				}
			}
			else{
				String[] statusTab = null;
				statusTab = courseDB.getCourseDates(conn,kix);
%>
			<%@ include file="crsedt9.jsp" %>
<%
			}
%>
			<br/><div class="hr"></div>
			<p align="left"><a href="taskqx.jsp?kix=<%=kix%>" class="linkcolumn">Confirm notifications</a>
			<br/><br/>Confirming receipt of notifications removes the task from your task list.
			</p>
		</fieldset>
	<%
	}

	asePool.freeConnection(conn,"taskq",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
