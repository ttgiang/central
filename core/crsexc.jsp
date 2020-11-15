<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsexc.jsp - excluded from catalog (does not need alpha list selection)
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Outline Excluded from Catalog";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	try{
		int idx = website.getRequestParameter(request,"idx",0);

		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"") );
		out.println("			</td></tr>" );

		out.println("			<tr>" );
		out.println("				 <td colspan=\'2\' class=\'dataColumn\'>");
%>

<p align="center">
<img src="../images/viewcourse.gif" border="0" alt="view outline">&nbsp;view outline&nbsp;&nbsp;
</p>

<%
		out.println("				 </td>");
		out.println("			</td></tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left><br/>" );
		out.println(helper.showExcludedFromCatalog(conn,campus,idx));
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"crsexc",user);

%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
