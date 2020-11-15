<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrsn.jsp display course comments (reason)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "";
	String kix = website.getRequestParameter(request,"kix","");

	String alpha = "";
	String num = "";
	String type = "";

	if (processPage){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	fieldsetTitle = pageTitle;
	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage && !"".equals(kix)){
		out.println("<p align=\"center\"><font class=\"textblackth\">" + pageTitle + "</font></p>");
		out.println("<p align=\"left\"><font class=\"datacolumn\">"
			+ courseDB.getCourseReason(conn,campus,alpha,num,type,kix)
			+ "</font></p>");
	}

	asePool.freeConnection(conn,"crsrsn",user);
%>

</body>
</html>