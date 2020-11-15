<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscony.jsp - content --> slo --> assessment
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";
	String pageTitle = "Outline Content --> SLO --> Assessment";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix");

	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%@ include file="crsedt9.jsp" %>
<hr size=0>
<%
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String campus = info[4];
		out.println(ContentDB.getContentAsHTMLList(conn,campus,alpha,num,type,kix,true,true));
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
