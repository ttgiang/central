<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dgr.jsp
	*	2007.09.01
	**/

	boolean processPage = true;
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "50%";
	String pageTitle = "Degree Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dgr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	try{
		String auditby = "";
		String auditdate = "";
		String degreeCode = "";
		String degreeTitle = "";
		String degreeDescr = "";

		// make sure we have and id to work with. if one exists,
		// it has to be greater than 0
		int lid = website.getRequestParameter(request,"lid", 0);

		String rtn = website.getRequestParameter(request,"rtn", "");

		if (lid > 0){
			Degree degree = DegreeDB.getCampusDegree(conn,lid);
			if (degree != null){
				degreeTitle = degree.getTitle();
				degreeCode = degree.getAlpha();
				degreeDescr = degree.getDescr();
			}
		}

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/dgr\'>" );
		out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>ID:&nbsp;</td>" );
		out.println("					 <td>");

		if (!"".equals(lid)){
			out.println(lid);
			out.println("							<input type=\'hidden\' name=\'lid\' value=\'"+lid+"\'>" );
		}
		else{
			out.println("<input size=\'10\' class=\'input\' name=\'lid\' type=\'text\' value=\'\'></td>" );
		}

		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Code:&nbsp;</td>" );
		out.println("					 <td class=\'datacolumn\'><input size=\'10\' maxlength=\'10\' class=\'input\'  name=\'degreeCode\' type=\'text\' value=\'" + degreeCode+ "\'>&nbsp;(10 characters maximum)</td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Title:&nbsp;</td>" );
		out.println("					 <td class=\'datacolumn\'><input size=\'60\' class=\'input\'  name=\'degreeTitle\' type=\'text\' value=\'" + degreeTitle + "\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Description:&nbsp;</td>" );
		out.println("					 <td class=\'datacolumn\'><input size=\'60\' class=\'input\'  name=\'degreeDescr\' type=\'text\' value=\'" + degreeDescr + "\'></td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );

		if (lid > 0){
			//out.println("							<input title=\'save entered data\' type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			//out.println("							<input title=\'delete selected data\' type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
		}
		else{
			//out.println("							<input title=\'insert entered data\' type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
		}

		out.println("							<input title=\'abort selected operation\' type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"document.aseForm.formAction.value = 'c';\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("							<input type=\'hidden\' name=\'campus\' value=\'"+campus+"\'>" );
		out.println("							<input type=\'hidden\' name=\'rtn\' value=\'"+rtn+"\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"dgr",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
