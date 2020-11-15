<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsacan.jsp	- cancel assess process
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Cancel Assessment";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsaslo.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );
	out.println("		<tr>" );
	out.println("			 <td colspan=2 align=left>" );
	out.println("<fieldset class=FIELDSET><legend>Assessment available for cancellation</legend><br/>" );
	out.println(helper.showAssessmentsToCancel(conn,campus,user,"crsacanx"));
	out.println("</fieldset>" );
	out.println("			 </td>" );
	out.println("		</tr>" );
	out.println("	</table>" );

	asePool.freeConnection(conn);
%>

<p align="left">NOTE: Assessments are available for cancellations if it in ASSESSed status.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
