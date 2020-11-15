<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassrpt.jsp
	*	2007.09.01	Assessment report
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = "Assessment Report by Assessment";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/assess.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="15%">Select Assessment:&nbsp;</td>
			<td width="85%">
				<select class="smalltext" name="crsassrpt0" onchange="showAjax(this.value,1)">
					<option value=''></option>
					<%
						try{
							// retrieve all available assessments
							String campus = website.getRequestParameter(request,"aseCampus","",true);
							out.println(AssessDB.getAssessments(conn,campus,1));
						}
						catch (Exception e){
							//out.println( e.toString() );
						}
						finally{
							asePool.freeConnection(conn);
						}
					%>
				</select>
			</td>
		</tr>
	</table>
</form>

<div id="crsassrpt01"><b>...</b></div>
<div id="crsassrpt02"><b>...</b></div>
<div id="details"><b>...</b></div>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
