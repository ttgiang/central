<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsmod.jsp	outline modifications
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// GUI
	String campus = (String)session.getAttribute("aseCampus");
	String user = (String)session.getAttribute("aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Outline Modifications";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsmod.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0" onload="aseOnLoad('<%=idx%>','<%=type%>');">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) Outline Type:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>");
		out.println("<form method=\'post\' name=\'aseForm\' action=\'?\'>" );

		int thisCounter = 0;
		int thisTotal = 2;

		String[] thisType = new String[thisTotal];
		thisType[0] = "CUR";
		thisType[1] = "PRE";

		String[] thisTitle = new String[thisTotal];
		thisTitle[0] = "Approved";
		thisTitle[1] = "Proposed";

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
		}

		out.println("<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
		out.println("</form>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>2) Alpha Index:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,type) );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'normaltext\' colspan=\"2\" height=\"30\">&nbsp;&nbsp;Note: Select the outline type you wish to view then the alpha index to display available outlines.</td>" );
		out.println("			</td></tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );
		out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );

		if ("".equals(type))
			out.println("				<p align=\"center\"><br/><br/>Please select outline type to display</p>" );
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
