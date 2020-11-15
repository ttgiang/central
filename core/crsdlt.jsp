<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdlt.jsp	delete outline
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Delete Approved Outline";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsdlt.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		if (processPage){
			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			String sql = aseUtil.getPropertySQL(session,"alphas2");
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Outline:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println("<form name=\"aseForm\" method=\"post\" action=\"crsdlt.jsp\">");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
			out.println("</form>");
			out.println("			</td></tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

			if ("".equals(alpha))
				out.println("				<p align=\"center\"><br/><br/>Select alpha to show available outlines</p>" );
			else
				out.println(helper.listOutlineForDelete(conn,campus,"CUR","crsdltxx",0,alpha,num));

			out.println("				</div>" );
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"crsdlt",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
