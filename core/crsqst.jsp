<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsqst.jsp	- display course questions
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Questions";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/headerli.jsp" %>

<table border="0" cellpadding="2">

<%
	/*
		display list of items based on the tab displayed.
		valid values are 1 or 2 for course or campus tab
	*/
	int type = website.getRequestParameter(request,"type",0);
	if ( type > 0 ){
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		ArrayList list = QuestionDB.getCourseQuestions(conn,type,campus);
		if ( list != null ){
			Question question;
			for (int i=0; i<list.size(); i++){
				question = (Question)list.get(i);
				out.println( "<tr><td valign=top>" + question.getNum() + "</td><td valign=top>" + question.getQuestion() + "</td></tr>" );
			}
		}
	}
	else{
		out.println( "<tr><td valign=top>Data not available</td></tr>" );
	}

	asePool.freeConnection(conn);
%>

</table>

<%@ include file="../inc/footerli.jsp" %>
</body>
</html>