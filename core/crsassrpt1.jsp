<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassrpt1.jsp
	*	2007.09.01	Assessment report by Discipline
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = "Assessment Report by Division";
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
			<td width="15%">Select Division:&nbsp;</td>
			<td width="85%">
				<select class="smalltext" name="crsassrpt1" onchange="showAjax(this.value,11)">
					<option value=''></option>
					<%
						try{
							// retrieve all available assessments
							ArrayList list = DisciplineDB.getDisciplines(conn);

							if ( list != null ){
								Discipline discipline;
								for (int i=0; i<list.size(); i++){
									discipline = (Discipline)list.get(i);
									%>
										<option value="<%=discipline.getCourseAlpha()%>"><%=discipline.getDiscipline()%></option>
									<%
								}
							}
						}
						catch (Exception e){
							out.println( e.toString() );
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

<div id="crsassrpt11"><b>...</b></div>
<div id="crsassrpt12"><b>...</b></div>
<div id="crsassrpt13"><b>...</b></div>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
