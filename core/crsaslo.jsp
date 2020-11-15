<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsaslo.jsp	- assess outline
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Assess Outline SLOs";
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
	if (processPage){
		out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );
		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );

		out.println("<fieldset class=FIELDSET90><legend>Outlines being Assessed</legend><br/>" );
		out.println(helper.listOutlineAssessing(conn,campus,"crsslo",user));
		out.println("</fieldset>" );

		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );

		out.println("<fieldset class=FIELDSET90><legend>Outlines Ready for Assessment</legend><br/>" );
		out.println(helper.listOutlineAssessments(conn,campus,"crsslo",user));

		out.println("</fieldset>" );
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );
	}

	asePool.freeConnection(conn,"crsaslo",user);
%>

<p align="left">NOTE: Outlines are ready for assessment if it is an APPROVED outline.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
