<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscsv.jsp - JQUERY implementation (export needs to be completed)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Reports";
	fieldsetTitle = pageTitle;

	String message = "";
	String reportName = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String rpt = website.getRequestParameter(request,"rpt","");
	String exportType = website.getRequestParameter(request,"et","C");

	// determine export to show
	if (processPage){
		if(exportType.equals("C")){
			reportName = "Course Data";
			com.ase.aseutil.export.KualiExport sng = new com.ase.aseutil.export.KualiExport();
			message = sng.KualiExport(conn,rpt,campus,user);
			sng = null;
		}
		else{
			reportName = "Program Data";
			com.ase.aseutil.export.Programs sng = new com.ase.aseutil.export.Programs();
			message = sng.Programs(conn,rpt,user);
			sng = null;
		}
	} // processPage

	fieldsetTitle = "Export - " + reportName;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" cellpadding="2" width="80%" align="center" cellspacing="1">
	<tr>
		<td>
			<%
				if (!message.equals(Constant.BLANK)){
			%>
					Export processing completed successfully.
					<br/><br/>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To view your report, click <a href="/centraldocs/docs/temp/<%=message%>.csv" class="linkcolumn" target="_blank">here</a>.
					<br/><br/>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To download your report, do the following:
					<br>
					<ul>
						<li>Right-mouse click <a href="/centraldocs/docs/temp/<%=message%>.csv" class="linkcolumn" target="_blank">here</a></li>
						<li>Select 'Save link as..'</li>
						<li>Save your report with extension CSV (IE. reportname.csv)</li>
					</ul>
					<img src="../images/rightarrow1.png" border="0">&nbsp;&nbsp;To export more data, click <a href="/central/core/export.jsp" class="linkcolumn">here</a>.
					<br/><br/>
			<%
				}

				session.setAttribute("aseJasperMessage","");
			%>
		</td>
	</tr>
</table>

<%
	asePool.freeConnection(conn,"kualiexport",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
