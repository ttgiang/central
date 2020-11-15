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
	String pageTitle = "View Course Outline";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	String alpha = "ICS";
	String num = "241";
	String type = "PRE";
	String campus = "LEECC";

	msg = courseDB.viewOutlineSLO(conn,campus,alpha,num,type);
	out.println(msg.getErrorLog());
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
