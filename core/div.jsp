<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	div.jsp
	*	2007.09.01
	**/

	boolean processPage = true;
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "50%";
	String pageTitle = "Division Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/div.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		try{
			String auditby = "";
			String auditdate = "";
			String divisionName = "";
			String divisionCode = "";
			String chairName = "";
			String delegated = "";

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			int lid = website.getRequestParameter(request,"lid", 0);

			String rtn = website.getRequestParameter(request,"rtn", "");

			if (lid > 0){
				Division division = DivisionDB.getCampusDivision(conn,lid);
				if (division != null){
					divisionCode = division.getDivisionCode();
					divisionName = division.getDivisionName();
					chairName = division.getChairName();
					delegated = division.getDelegated();
				}
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/dv\'>" );
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
			out.println("					 <td class=\'textblackTH\'>Division Code:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'><input size=\'10\' maxlength=\'10\' class=\'input\'  name=\'divisionCode\' type=\'text\' value=\'" + divisionCode + "\'>&nbsp;(10 characters maximum)</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Division Name:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'><input size=\'60\' class=\'input\'  name=\'divisionName\' type=\'text\' value=\'" + divisionName+ "\'></td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Chair Name:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" );
			String sql = aseUtil.getPropertySQL(session,"chairName");
			out.println(aseUtil.createSelectionBox(conn,sql,"chairName",chairName,false));
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\'>Delegate Name:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" );
			sql = aseUtil.getPropertySQL(session,"chairName");
			out.println(aseUtil.createSelectionBox(conn,sql,"delegated",delegated,false));
			out.println("					 </td>" );
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
	} // processpage

	asePool.freeConnection(conn,"div",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
