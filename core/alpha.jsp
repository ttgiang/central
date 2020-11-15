<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	alpha.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "50%";
	String pageTitle = "Outline Discipline Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/alpha.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	try{
		String lid = "";
		String coursealpha = "";
		String discipline = "";
		String auditby = "";
		String auditdate = "";
		String sql;

		// make sure we have and id to work with. if one exists,
		// it has to be greater than 0
		lid = website.getRequestParameter(request,"lid", "");

		if ("0".equals(lid))
			lid = "";

		if (!"".equals(lid)){
			discipline = AlphaDB.getDescription(conn,lid);
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/as\'>" );
		out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Alpha:&nbsp;</td>" );
		out.println("					 <td>");

		if (!"".equals(lid)){
			out.println(lid);
			out.println("							<input type=\'hidden\' name=\'lid\' value=\'"+lid+"\'>" );
		}
		else{
			out.println("<input size=\'60\' class=\'input\' name=\'lid\' type=\'text\' value=\'\'></td>" );
		}

		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Discipline:&nbsp;</td>" );
		out.println("					 <td><input size=\'60\' class=\'input\'  name=\'discipline\' type=\'text\' value=\'" + discipline + "\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );

		if (!"".equals(lid)){
			out.println("							<input title=\'save entered data\' type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input title=\'delete selected data\' type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			out.println("							<input title=\'insert entered data\' type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input title=\'abort selected operation\' type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"alpha",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
