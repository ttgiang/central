<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	divmtrxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "divmtrxx";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix", "");
	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String topic = website.getRequestParameter(request,"topic", "");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Diversification Matrix";

	int rowsAffected = 0;

	if (processPage){
		rowsAffected = ValuesDB.updateDiversification(conn,request,response,campus,kix);
	}

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	asePool.freeConnection(conn,thisPage,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/divmtrxx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<p align="center">
<a href="/central/core/divmtrx.jsp?kix=<%=kix%>&topic=<%=topic%>" class="linkcolumn">return to diversification screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;
<a href="/central/core/crsedt.jsp?ts=<%=currentTab%>&no=<%=currentNo%>&kix=<%=kix%>" class="linkcolumn">return to outline modification</a>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
