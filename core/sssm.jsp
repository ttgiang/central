<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sssm.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "System Summary";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/sssm.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<a href="/central/servlet/progress" class="linkcolumn" target="_blank">printer friendly</a>

<%
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		String category = website.getRequestParameter(request,"s", "");
		String campus = website.getRequestParameter(request,"aseCampus","",true);

		if (!"".equals(category))
			out.print(IniDB.listSystemSummary(conn,campus,category,"Y"));

		session.setAttribute("aseReport","system");
	}

	asePool.freeConnection(conn,"sssm",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>