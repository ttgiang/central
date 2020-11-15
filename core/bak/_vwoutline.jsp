<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwoutline.jsp	view outline
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// GUI
	String campus = (String)session.getAttribute("aseCampus");
	String user = (String)session.getAttribute("aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "View Outline";
	fieldsetTitle = "View Outline";

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/vwoutline.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0" onload="aseOnLoad('<%=idx%>');">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Campus:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>" + campusName );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) Outline Type:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>");
		out.println("<form method=\'post\' name=\'aseForm\' action=\'?\'>" );

		String[] thisType = new String[3];
		thisType[0] = "ARC";
		thisType[1] = "CUR";
		thisType[2] = "PRE";

		String[] thisTitle = new String[3];
		thisTitle[0] = "Archived";
		thisTitle[1] = "Approved";
		thisTitle[2] = "Proposed";

		int thisCounter = 0;
		int thisTotal = 3;

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

		// filled by vwoutline.jsp
		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );
		out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );
		out.println("				<p align=center></p>" );
		out.println("				</div>" );
		out.println("			 </td>" );
		out.println("		</tr>" );

		// form buttons
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
