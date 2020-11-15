<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dfqstr.jsp
	*	2008.01.23	resequence course items
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String questionType = website.getRequestParameter(request,"t","r");

	String pageTitle = "Resequence Outline Items";

	if (questionType.equals("p")){
		pageTitle = "Resequence Program Items";
	}
	else if (questionType.equals("p")){
		pageTitle = "Resequence Program Items";
	}
	else if (questionType.equals("p")){
		pageTitle = "Resequence Program Items";
	}

	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		int rowsAffected = QuestionDB.resequenceItems(conn,questionType,campus,user);
	}

	asePool.freeConnection(conn,"dfqstr",user);
%>

Course items resequenced for <%=campus%>.<br><br>
Click <a href="dfqst.jsp?t=<%=questionType%>" class="linkcolumn">here</a> to return to item definition

<%@ include file="../inc/footer.jsp" %>

</body>
</html>



