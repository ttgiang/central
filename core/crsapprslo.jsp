<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprslo.jsp	- approval slo
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Approve SLOs";
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
	out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );
	out.println("		<tr>" );
	out.println("			 <td colspan=2 align=left>" );

	out.println("<fieldset class=FIELDSET90><legend>SLOs ready for approval</legend><br/>" );
	out.println(helper.showSLOReadyToApprove(conn,campus,user,"crsslo"));
	out.println("</fieldset>" );

	out.println("			 </td>" );
	out.println("		</tr>" );

	out.println("	</table>" );

	asePool.freeConnection(conn);
%>

<p align="left">NOTE: Outlines are ready for approval if they are in APPROVAL progress.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
