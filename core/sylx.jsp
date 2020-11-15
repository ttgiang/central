<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sylx.jsp	- create syllabus
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	/*
		when lid is available and greater than 0, don't finish this page.
	*/
	int lid = website.getRequestParameter(request,"lid", 0);
	if (lid > 0)
		response.sendRedirect("syl.jsp?lid="+lid);

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "View Outline Detail";
	fieldsetTitle = "View Outline Detail";

	String type = website.getRequestParameter(request,"type","CUR");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/sylx.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

	String sql = aseUtil.getPropertySQL(session,"alphas2");
	out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
	out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Outline:&nbsp;</td>" );
	out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
	out.println("<form name=\"aseForm\" method=\"post\" action=\"sylx.jsp\">");
	out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
	out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
	out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
	out.println("</form>");
	out.println("			</td></tr>" );

	out.println("		<tr>" );
	out.println("			 <td colspan=2 align=left>" );
	out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );

	if (alpha != null && alpha.length() > 0)
		out.println(helper.listCampusOutlinesByAlpha(conn,campus,"CUR","syl",0,alpha,num));

	out.println("				</div>" );
	out.println("			 </td>" );
	out.println("		</tr>" );

	out.println("	</table>" );

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
