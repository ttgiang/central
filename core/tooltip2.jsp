<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tooltip2.jsp - used for displaying linked items. Started in CompDB but not in use at this time
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	int si = website.getRequestParameter(request,"si",0);
	int type = website.getRequestParameter(request,"tp",0);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String question = QuestionDB.getCourseQuestion(conn,campus,type,si);

	if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
		question = CompetencyDB.getContentByID(conn,"x11k3i9241",212);
	}
	else if ((Constant.COURSE_CONTENT).equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
		Content c = ContentDB.getContentByID(conn,212);
		question = c.getLongContent();
	}
	else if ((Constant.COURSE_OBJECTIVES).equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
		question = CompDB.getObjective(conn,"x11k3i9241",212);
	}


	asePool.freeConnection(conn);
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="<%=Constant.HEADER_ROW_BGCOLOR%>" width="80%" style="border: 1px solid #C0C0C0; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">
		<tr>
			<td>&nbsp;</td>
			<td nowrap><font class="textblackth">Linking GenED to SLO<br/><br/><hr size="1" noshade></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><font class="datacolumn"><p><%=question%></p></font></td>
			<td>&nbsp;</td>
		</tr>
	</table>
</body>
</html>
