<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	pgrchrx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String formSelect = website.getRequestParameter(request,"formSelect");
	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alphas = formSelect.replace(",","\n");

	int programid = website.getRequestParameter(request,"programid",0);
	String division = website.getRequestParameter(request,"division","");
	String chairName = website.getRequestParameter(request,"chairName","");

	// GUI
	String chromeWidth = "30%";
	String pageTitle = "Alpha Selection";
	fieldsetTitle = "Alpha Selection";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/pgrchr.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String sql = "";
			String view = "";

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'pgrchry.jsp\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackth\'>Department/Division:</td>" );
			out.println("					 <td class=\'datacolumn\'>" + division + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackth\'>Chair Name:</td>" );
			out.println("					 <td class=\'datacolumn\'>" + chairName + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Selected Alphas:&nbsp;</td>" );
			out.println("					 <td>");
			out.println("						<textarea disabled class=\"input\" id=\"alphas\" name=\"alphas\" style=\"height: 200px; width: 200px;\">"+alphas+"</textarea>");
			out.println("					 </td></tr>" );

			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'"+formSelect+"\'>" );
			out.println("							<input type=\'hidden\' name=\'programid\' value=\'"+programid+"\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
			out.println("							<input title=\"submit review request\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm0(\'s\')\">" );
			out.println("							<input title=\"abort review request\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"pgrchrx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
