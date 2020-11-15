<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsslosts.jsp	- slo status (does not need alpha selection)
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "View SLO Status";
	fieldsetTitle = "View SLO Status";

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>1) SLO Progress:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>");
		out.println("<form method=\'post\' name=\'aseForm\' action=\'?\'>" );

		int thisCounter = 0;
		int thisTotal = 10;
		String[] thisType = new String[thisTotal];
		thisType = Constant.SLO_PROGRESS.split(",");
		thisTotal = thisType.length;
		thisCounter = 0;

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisType[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisType[thisCounter] + "</a>&nbsp;&nbsp;" );
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

		// filled by crsslostsx.jsp
		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left><br/>" );
		out.println(SLODB.showSLOProgress(conn,campus,type,idx));
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
