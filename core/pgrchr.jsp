<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	pgrchr.jsp	-	select alphas for chairs
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "pgrchr";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	int programid = website.getRequestParameter(request,"programid",0);

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Alpha Selection";
	fieldsetTitle = "Alpha Selection";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/pgrchr.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
				String sql = "";
				String division = "";
				String chairName = "";

				Division d = DivisionDB.getCampusDivision(conn,programid);
				if (d != null){
					division = d.getDivisionName();
					chairName = d.getChairName();
				}

				out.println("		<form method=\'post\' name=\'aseForm\' action=\'pgrchrx.jsp\'>" );
				out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackth\' nowrap valign=top>Department/Division:</td>" );
				out.println("					 <td class=\'datacolumn\' colspan=\"2\" valign=top>" + division + "</td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackth\' nowrap valign=top>Chair Name:</td>" );
				out.println("					 <td class=\'datacolumn\' colspan=\"2\" valign=top><a href=\"div.jsp?lid="+programid+"\" class=\"linkcolumn\">" + chairName + "</a></td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTD\' colspan=\"3\" valign=top>&nbsp;</td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top>Available Alphas</td>" );
				out.println("					 <td class=\'textblackTH\' valign=\'middle\'>&nbsp;</td>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top>Selected Alphas</td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top width=\"40%\">");
				out.println(ChairProgramsDB.getBannerAlphas(conn,campus,programid));
				out.println("					</td>" );
				out.println("					 <td class=\'textblackTH\' valign=\'middle\' width=\"20%\">" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   <   \" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   >   \" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
				out.println("					 </td>" );

				out.println("					 <td class=\'textblackTD\' nowrap valign=top width=\"40%\">");
				out.println(ChairProgramsDB.getSelectAlphasX(conn,campus,programid));
				out.println("					</td>" );

				out.println("				</tr>" );

				// form buttons
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'programid\' value=\'"+programid+"\'>" );
				out.println("							<input type=\'hidden\' name=\'division\' value=\'"+division+"\'>" );
				out.println("							<input type=\'hidden\' name=\'chairName\' value=\'"+chairName+"\'>" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
				out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
				out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("			</table>" );
				out.println("		</form>" );		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"pgrchr",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
