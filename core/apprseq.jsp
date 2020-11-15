<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprseq.jsp - approval sequence
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Outline Approval Sequence";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
	int oldRoute = website.getRequestParameter(request,"oldRoute",0);
	int newRoute = website.getRequestParameter(request,"newRoute",0);

	if (kix != null && kix.length() > 0 && oldRoute > 0 && newRoute > 0){
		ApproverDB.updateApproverRouting(conn,campus,kix,oldRoute,newRoute);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
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

		out.println("		<tr>" );
		out.println("			 <td colspan=2 align=left><br/>" );
		out.println(ApproverDB.showApprovalRouting(conn,campus,idx));
		out.println("			 </td>" );
		out.println("		</tr>" );

		out.println("	</table>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"apprseq",user);

%>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>
