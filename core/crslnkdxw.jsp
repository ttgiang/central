<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkdxw.jsp
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

	String kix = website.getRequestParameter(request,"kix");
	String alpha = "";
	String num = "";

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	fieldsetTitle = pageTitle;
	pageTitle = pageTitle + " (" + courseDB.setPageTitle(conn,"",alpha,num,campus) + ")";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage){
		String src = website.getRequestParameter(request,"src","",false);
		String dst = website.getRequestParameter(request,"dst","",false);
		int level1 = website.getRequestParameter(request,"level1",0,false);
		int level2 = website.getRequestParameter(request,"level2",-1,false);
		out.println("<p align=\"center\"><font class=\"textblackth\">Linked Outline Items " + pageTitle + "</font></p>");
		//out.println(LinkedUtil.showLinkedItemReport(conn,kix,src,dst,level1,level2,true));
		out.println(LinkedUtil.printLinkedMaxtrixContent(conn,kix,src,user,true));
	}

	asePool.freeConnection(conn,"crslnkdxw",user);
%>

</body>
</html>