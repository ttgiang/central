<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccjobz.jsp
	*	2009.12.20
	*
	* TO DO - we have progress of idle set up. need to determine when a job is running and ends
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String totalEntries = "";
	String processedEntries = "";

	String campus = website.getRequestParameter(request,"campus","");
	String kix = website.getRequestParameter(request,"kix","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String type = website.getRequestParameter(request,"type","");
	String task = website.getRequestParameter(request,"task","");
	String idx = website.getRequestParameter(request,"idx","");

	String pageTitle = "Curriculum Central - Create Outlines";
	fieldsetTitle = pageTitle;

	String submit = website.getRequestParameter(request,"cmdSubmit","");
	String aseForm = website.getRequestParameter(request,"aseForm","");

	if (submit != null && submit.length() > 0 && "aseForm".equals(aseForm)){

		Tables.createOutlines(campus,kix,alpha,num,task,idx,type);

		totalEntries = "" + JobsDB.countNumberInJob(conn,"CreateOutlines");

		session.setAttribute("totalEntries",totalEntries);
	}
	else{
		if ((String)session.getAttribute("totalEntries") != null){

			totalEntries = "" + JobsDB.countNumberInJob(conn,"CreateOutlines");

		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<META HTTP-EQUIV="REFRESH" CONTENT="60">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<form name="aseForm" method="post" action="?">
	<table align="center" width="80%" border="0" id="table2" cellspacing="0" cellpadding="4">
		<tr bgcolor="#E0E0E0">
			<td width="10%"><b>Campus</b></td>
			<td width="15%"><b>Kix</b></td>
			<td width="10%"><b>Alpha</b></td>
			<td width="10%"><b>Num</b></td>
			<td width="10%"><b>Type</b></td>
			<td width="10%"><b>Idx</b></td>
			<td width="10%"><b>Task</b></td>
			<td width="30%">&nbsp;</td>
		</tr>
		<tr bgcolor="#E0E0E0">
			<td><input type="text" class="input" name="campus" maxlength="4" size="4" value="<%=campus%>"></td>
			<td><input type="text" class="input" name="kix" maxlength="18" size="18" value="<%=kix%>"></td>
			<td><input type="text" class="input" name="alpha" maxlength="4" size="4" value="<%=alpha%>"></td>
			<td><input type="text" class="input" name="num" maxlength="4" size="4" value="<%=num%>"></td>
			<td><input type="text" class="input" name="type" maxlength="4" size="4" value="<%=type%>"></td>
			<td><input type="text" class="input" name="idx" maxlength="4" size="4" value="<%=idx%>"></td>
			<td><input type="text" class="input" name="task" maxlength="4" size="4" value="<%=task%>"></td>
			<td><input type="submit" class="input" name="cmdSubmit" value="Go"></td>
		</tr>
		<tr bgcolor="#E0E0E0">
			<td colspan="8" align="center"><hr size="1"></td>
		</tr>
		<tr bgcolor="#E0E0E0">
			<td colspan="8" align="center"><%=totalEntries%> entries to process</td>
		</tr>
	</table>

	<input type="hidden" value="aseForm" name="aseForm">
	<input type="hidden" value="<%=campus%>" name="campus">
	<input type="hidden" value="<%=kix%>" name="Kix">
	<input type="hidden" value="<%=alpha%>" name="alpha">
	<input type="hidden" value="<%=num%>" name="num">
	<input type="hidden" value="<%=type%>" name="type">
	<input type="hidden" value="<%=idx%>" name="idx">
	<input type="hidden" value="<%=task%>" name="task">

</form>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
