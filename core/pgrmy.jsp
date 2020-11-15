<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	pgrmy.jsp	- confirm adding new list
	*	2010.01.02
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Quick List Program SLO Entry";
	fieldsetTitle = pageTitle;

	String clrList = website.getRequestParameter(request,"clrList","0");
	String alpha = website.getRequestParameter(request,"alpha","");
	String lst = website.getRequestParameter(request,"lst","");

	int rowsAffected = ListsDB.insertList(conn,campus,Constant.COURSE_PROGRAM_SLO,"",alpha,lst,clrList,user);

	String message = "";

	if (rowsAffected==1)
		message = "Program SLO saved successfully.";
	else
		message = "Error while saving Program SLO.";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/pgrmx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<br />
<p align="center"><%=message%></p>

Click <a href="pgrmidx.jsp" class="linkcolumn">here</a> to maintain additional Program SLOs

<%
	asePool.freeConnection(conn,"pgrmy",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
