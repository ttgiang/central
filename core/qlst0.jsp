<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	qlst0.jsp	- quick entry (slo or comp)
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Quick List Entry";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);

	asePool.freeConnection(conn,"qlst0",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/qlst0.js"></script>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
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
			<legend><strong>Quick List - step 2 of 4</strong></legend>
				<form name="aseForm" method="post" action="?">
					<font class="textblackth">Select item to enter quick entry</font>
					<ul>
						<li><a href="qlst1.jsp?kix=<%=kix%>&itm=<%=Constant.COURSE_OBJECTIVES%>" class="linkcolumn">Course SLOs</a></lo>
						<li><a href="qlst1.jsp?kix=<%=kix%>&itm=<%=Constant.COURSE_PROGRAM_SLO%>" class="linkcolumn">Program SLOs</a></lo>
						<li><a href="qlst1.jsp?kix=<%=kix%>&itm=<%=Constant.COURSE_COMPETENCIES%>" class="linkcolumn">Course Competencies</a></lo>
						<li><a href="qlst1.jsp?kix=<%=kix%>&itm=<%=Constant.COURSE_CONTENT%>" class="linkcolumn">Course Contents</a></lo>
					</ul>
					<input type="hidden" value="<%=kix%>" name="kix">
					<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				</form>
			</fieldset>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
