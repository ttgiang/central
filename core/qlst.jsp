<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	qlst.jsp	- quick SLO entry
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Quick List Entry";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<fieldset class="FIELDSET">
	<legend>Current Outlines</legend>
	<%
		out.println(Outlines.listMyOutlines(conn,campus,user,"CUR","qlst","qlst0",request,response));
	%>
</fieldset>
<br/><br/>
<fieldset class="FIELDSET">
	<legend>Proposed Outlines</legend>
	<%
		out.println(Outlines.listMyOutlines(conn,campus,user,"PRE","qlst","qlst0",request,response));
	%>
</fieldset>

<%
	asePool.freeConnection(conn);

	asePool.freeConnection(conn,"qlst",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
