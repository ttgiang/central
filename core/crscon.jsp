<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscon.jsp - content --> slo --> assessment
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Linked Outline Items";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/crscon.js"></script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">

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
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "CUR"; thisTitle[0] = "Approved";
		thisType[1] = "PRE"; thisTitle[1] = "Proposed";

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

		String sql = aseUtil.getPropertySQL(session,"alphas2");
		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>OR<br/><br/>Select Outline:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\' valign=\"bottom\">");
		out.println("<form name=\"aseForm\" method=\"post\" action=\"crscon.jsp\">");
		out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,false));
		out.println("<input name=\"type\" type=\"hidden\" value=\""+type+"\">");
		out.println("<input name=\"num\" class=\"input\" type=\"text\" size=\"10\" maxlength=\"10\" value=\""+num+"\">");
		out.println("<input name=\"aseSubmit\" class=\"inputsmallgray\" type=\"submit\" value=\"Go\">");
		out.println("</form>");
		out.println("			</td></tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left>" );
		out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 800px;\" id=\"output\">" );

		if ("".equals(type) && "".equals(alpha))
			out.println("				<p align=\"center\"><br/><br/>Please select outline type to display</p>" );
		else
			if (idx==0 && "".equals(alpha))
				out.println("				<p align=\"center\"><br/><br/>Please select alpha index to display</p>" );
			else
				out.println(LinkerDB.listConnectedOutlineItems(conn,campus,type,idx,request,response,alpha,num));

		out.println("				</div>" );
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"crscon",user);

%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>