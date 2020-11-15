<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsitm.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String courseAlpha = website.getRequestParameter(request,"alpha");
	String courseNum = website.getRequestParameter(request,"num");

	// GUI
	String chromeWidth = "80%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Maintain Questions";
	fieldsetTitle = pageTitle;

	int question_len = 0;
	int question_max = 0;
	int question_number = 0;
	String question = "";
	String question_ini = "";
	String question_type = "";
	String question_friendly = "";
	String HTMLFormField;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsedt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" action="crsitmx.jsp">
	<table border=0>
		<%

		try
		{
			PreparedStatement stmt;
			ResultSet rs;

			String sql = "SELECT question, question_ini, question_type, question_len, question_max, question_friendly, questionnumber FROM tblCourseQuestions WHERE type='Course' AND campus='SYS' ORDER BY questionnumber";
			stmt = conn.prepareStatement( sql );
			rs = stmt.executeQuery();
			while ( rs.next() ) {
				question = aseUtil.getValue( rs, 1 );
				question_ini = aseUtil.getValue( rs, 2 );
				question_type = aseUtil.getValue( rs, 3 );
				question_len = Integer.parseInt(aseUtil.getValue( rs, 4 ));
				question_max = Integer.parseInt(aseUtil.getValue( rs, 5 ));
				question_friendly = aseUtil.getValue( rs, 6 );
				question_number = Integer.parseInt(aseUtil.getValue( rs, 7 ));

				out.println( "<tr><td valign=\'top\'>" +
					"<input class=\"input\" id=\"number_" + question_number + "\" name=\"number_" + question_number + "\" value=\"" + question_number + "\" size=\'4\' maxlength=\'2\'>" +
					"</td><td valign=\'top\'>" +
					"<textarea class=\"input\" id=\"question_" + question_number + "\" name=\"question_" + question_number + "\" style=\"height: 60px; width: 500px;\">" +
					question + "</textarea></td></tr>" );
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		}
		catch (Exception e){
			out.println( e.toString() );
		};

		asePool.freeConnection(conn);

		%>
		<tr><td colspan="2" align="right">
			<input type="hidden" value="<%=question_number%>" name="totalQuestions">
			<input type="submit" value="Save" class="inputsmallgray">
			<input type="submit" value="Cancel" class="inputsmallgray">
			<input type="hidden" value="q" name="formAction">
			<input type="hidden" value="aseForm" name="formName">
		</td></tr>
	</table>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
