<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccslo.jsp
	*	2009.12.20	Enter SLO for LEE
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "SLO Entry";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		int idx = website.getRequestParameter(request,"idx",0);

		out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' width=\"15%\" height=\"30\" nowrap>Alpha Index:&nbsp;</td>" );
		out.println("				 <td class=\'dataColumn\'>" + helper.drawAlphaIndex(idx,"") );
		out.println("			</td></tr>" );

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left><br/>" );
		out.println(Helper.listOutlinesForSLO(conn,campus,idx));
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );

	}

	asePool.freeConnection(conn,"ccslo",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>