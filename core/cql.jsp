<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cql.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "cql";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "60%";
	String pageTitle = "Admin Work";
	fieldsetTitle = "Admin Work";
	String message = "";

	boolean isSysadm = SQLUtil.isSysAdmin(conn,user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/cql.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && isSysadm){
		try{
			String sql = "";
			String view = "";

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'cqlx.jsp\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\"asetable\" align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td nowrap>" );
			out.println("<textarea cols=\'150\' class=\'input\' name=\'content\' id=\'content\' rows=\'10\'></textarea>");
			out.println("					</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td nowrap>" );
			out.println("			<table bordercolor=\"cyan\" height=\'90\' width=\'100%\' cellspacing='1' cellpadding='3' class=\"asetable\" align=\'center\'  border=\'1\'>" );

			String row = "Field,Alias,Table,Sort,Display,Criteria,Or,Or";
			String[] rows = row.split(",");
			String formFieldType = "";

			for (int i=0;i<rows.length;i++){
				out.println("<tr>");
				out.println("<td class=\'textblackTHRight\'>"+rows[i]+":&nbsp;</td>" );

				for (int j=0;j<5;j++){
					if (rows[i].equals("Display")){
						formFieldType = "<input type=\"checkbox\" class=\"input\" name=\""+("r"+i+"c"+j)+"\">";
					}
					else if (rows[i].equals("Sort")){
						formFieldType = "<select class=\"input\" name=\""+("r"+i+"c"+j)+"\">"
											+ "<option value=\"\"></option>"
											+ "<option value=\"ascending\">ascending</option>"
											+ "<option value=\"descending\">descending</option>"
											+ "</select>";
					}
					else {
						formFieldType = "<input type=\"text\" class=\"input\" size=\"12\" name=\""+("r"+i+"c"+j)+"\">";
					}

					out.println("<td class=\'textblackTHCenter\'>"+formFieldType+"</td>" );
				}

				out.println("</tr>" );
			}

			out.println("			</table>" );
			out.println("					</td>" );
			out.println("				</tr>" );

			%>

			<TR><TD align="left" colspan="2"><br><% out.println(Skew.showInputScreen(request,true)); %></td></tr>

			<%

			// form buttons
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\' noshade>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(\'s\')\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"cql",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
