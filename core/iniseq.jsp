<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ini.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "System Settings - Resequence";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/iniseq.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String category = website.getRequestParameter(request,"s", "");

	if (processPage && category != null && category.length() > 0 ){
		out.println(IniDB.drawResequenceForm(conn,campus,category));
	}

	asePool.freeConnection(conn,"iniseq",user);
%>

<p align="left">

Select the sequence number for each item in the above list as you would like the list to appear. Once the list is set to your satisfaction, click 'Save'.
<br>
Select 'AutoSave' to have CC automatically resequence the list in alphabetical order.
</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>