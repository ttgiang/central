<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrss.jsp	Reassign Ownership
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String lid = website.getRequestParameter(request,"lid");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Reassign Ownership";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsrss.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){

		try{
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsrssx.jsp\'>" );
			out.println("			<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' colspan=\"4\">&nbsp;</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"40\">" );
			out.println("					 <td class=\'textblackTH\' width=\"15%\">Current Owner:&nbsp;</td>" );
			out.println("					 <td class=\'textblackTD\' width=\"35%\">"
												+ aseUtil.createSelectionBox(conn,
																					SQL.currentTaskOwner(campus),
																					"fromList","","","1",false)
												+ "</td>" );
			out.println("					 <td class=\'textblackTH\' width=\"15%\">New Owner:&nbsp;</td>" );
			out.println("					 <td class=\'textblackTD\' width=\"35%\">"
												+ aseUtil.createSelectionBox(conn,
																					SQL.campusUsers(campus),
																					"toList","","","1",false)
												+ "</td>" );
			out.println("				</tr>" );

			out.println("				<tr height=\"40\">" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">&nbsp;&nbsp;&nbsp;" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}

	} // processPage

	asePool.freeConnection(conn,"crsrss",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
