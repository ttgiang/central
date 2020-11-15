<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dlt.jsp	delete outline (no archive)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Permanently Delete Outline";
	fieldsetTitle = pageTitle;

	String alpha = "";
	String num = "";
	String type = "";

	String chromeWidth = "60%";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/dlt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			out.println("<form name=\"aseForm\" method=\"post\" action=\"dltxx.jsp\">");
			out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );

			String sql = aseUtil.getPropertySQL(session,"alphas2");
			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Alpha:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Enter number:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Select Type:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println(aseUtil.createStaticSelectionBox("Archived,Cancelled,Current,Proposed","ARC,CAN,CUR,PRE","type",type,"","","BLANK","1"));
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\"><br/>");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Continue\" onClick=\"return checkForm()\">");
			out.println("<input name=\"aseCancel\" class=\"inputsmallgray\" type=\"submit\" value=\"Cancel\" onClick=\"return cancelForm()\">");
			out.println("			</td></tr>" );

			out.println("</form>");

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br/><br/>NOTE: This option permanently deletes all data for the selected course outline. It will not be available in archived status." );
			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"dlt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
