<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsinf.jsp
	*	2007.09.01	driver to select course to display (view outline detail)
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "View Outline Detail";
	fieldsetTitle = "View Outline Detail";

	String type = website.getRequestParameter(request,"type","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsinf.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) Outline Type:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>");

		int thisCounter = 0;
		int thisTotal = 3;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "CUR"; thisTitle[0] = "Approved";
		thisType[1] = "DEL"; thisTitle[1] = "Deleted";
		thisType[2] = "PRE"; thisTitle[2] = "Proposed";

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
		}

		out.println("			</td></tr>" );

		if (!type.equals(Constant.BLANK)){
			String sql = aseUtil.getPropertySQL(session,"alphas2");
			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>2) Select Outline:&nbsp;</td>" );
			out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
			out.println("<form name=\"aseForm\" method=\"post\" action=\"crsinf.jsp\">");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
			out.println("<input name=\"type\" type=\"hidden\" value=\""+type+"\">");
			out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
			out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
			out.println("</form>");
			out.println("			</td></tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );

			if (type.equals(Constant.BLANK)){
				out.println("				<p align=\"center\"><br/><br/>Please select outline type (Approved,Proposed) to display (#1)</p>" );
			}
			else if (alpha.equals(Constant.BLANK)){
				out.println("				<p align=\"center\"><br/><br/>Select alpha and number to show available outlines</p>" );
			}
			else{
				out.println(helper.listOutlineDetails(conn,type,"crsinfy",0,alpha,num));
			}

			out.println("				</div>" );
			out.println("			 </td>" );
			out.println("		</tr>" );
		} // type

		out.println("	</table>" );
	} // processPage

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

<%@ page import="org.apache.log4j.Logger"%>

