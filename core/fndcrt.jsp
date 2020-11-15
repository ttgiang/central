<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrt.jsp	view outline raw data
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","fndcrt");
	String chromeWidth = "80%";

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "screen 1 of 4 - Select course outline";
	fieldsetTitle = "Create Foundation Course";

	String type = website.getRequestParameter(request,"type", "CUR");
	String alpha = website.getRequestParameter(request,"alpha","");

	boolean target = true;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			String sql = aseUtil.getPropertySQL(session,"alphas3");
			out.println("<form name=\"aseForm\" method=\"post\" action=\"fndcrt.jsp\">");
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Course Alpha:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("<input type=\'hidden\' name=\'type\' value=\'CUR\'>" );
			out.println("			</td></tr>" );
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\" onclick=\"return aseSubmitClick();\">");
			out.println("			</td></tr>" );
			out.println("</form>");

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

			if (alpha.equals(Constant.BLANK))
				out.println("				<p align=\"center\"><br/></p>"
					+ "<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">"
					+ "<p align=\"center\"><img src=\"../images/spinner.gif\" alt=\"loading...\" border=\"0\"></p>"
					+ "</div>");
			else{
				out.println(com.ase.aseutil.fnd.FndDB.listOutlinesForFoundations(conn,alpha,campus,user));
			}

			out.println("				</div>" );
			%>
				<p><br>Legend:
				<ul>
					<li><img src="../images/add.gif" alt="create foundation course" title="create foundation course"> - create foundation course</li>
					<li><img src="../images/edit.gif" alt="edit foundation course" title="edit foundation course"> - edit foundation course (available to proposers only)</li>
					<li><img src="../images/view.gif" alt="view foundation course" title="view foundation course"> - view foundation course</li>
				</ul>
				<br/>
				FG - Foundations Global and Multicultural Perspectives<br/>
				FS - Foundations Symbolic Reasoning<br/>
				FW - Foundations Written Communication<br/>
				</p>
			<%
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"fndcrt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

