<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	vwslox.jsp
	*	2007.09.01	view outline slo
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "90%";

	String campus = (String)session.getAttribute("aseCampus");
	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");
	String type = (String)session.getAttribute("aseType");

	if (alpha == null || alpha.length() == 0){
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");;
		type = website.getRequestParameter(request,"view");
		campus = (String)session.getAttribute("aseCampus");
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "View Outline SLO";

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=vwslo");
	}
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	StringBuffer slo = courseDB.viewOutlineSLO(conn,campus,alpha,num,type);
	out.println(slo.toString());
	asePool.freeConnection(conn);
%>

<hr size=1 noshade>
<p align="center"><a href="vwsloy.jsp" class="linkColumn" target="_blank">printer friendly</a></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
