<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprz.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String message = "";
	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix", "");
	if (processPage && !(Constant.BLANK).equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

		int rowsAffected = TaskDB.deleteTask(conn,campus,user,alpha,num,Constant.APPROVAL_TEXT);
		if (rowsAffected > 0)
			message = "Task deleted successfully.";
		else
			message = "An error occurred while deleting your task.";
	}
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="center">
	<TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
		<tr><td align="center"><%=message%></td></tr>
	</table>
</p>
<%
	asePool.freeConnection(conn,"crsapprz",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>