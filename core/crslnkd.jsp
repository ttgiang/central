<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkd.jsp	course outline linked itesm
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Link Outline Items";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crslnkd.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0" onload="aseOnLoad('<%=idx%>');">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"PRE") );
		out.println("			</td></tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );
		out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

		if (idx==0)
			out.println("				<p align=\"center\"><br/><br/>Select alpha index to show available outlines</p>" );
		else
			out.println("				<p align=\"center\"><br/><br/>Loading available outlines...<img src=\"../images/spinner.gif\" alt=\"Loading available outlines...\" border=\"0\"></p>" );

		out.println("				</div>" );
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
