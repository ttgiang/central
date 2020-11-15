<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwcrsslo.jsp
	*	2007.09.01	view outline SLO
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "90%";
	String campus = website.getRequestParameter(request,"cps","");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
	}
	else
		response.sendRedirect("index.jsp");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "View Outline SLO";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	if (processPage){
		out.println(outlines.viewOutlineSLO(conn,campus,alpha,num,type));
	}

	asePool.freeConnection(conn,"vwcrsslo",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
