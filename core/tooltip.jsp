<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tooltip.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String src = website.getRequestParameter(request,"src","");

	String alpha = website.getRequestParameter(request,"a","");
	String num = website.getRequestParameter(request,"n","");

	int si = website.getRequestParameter(request,"si",0);
	int type = website.getRequestParameter(request,"tp",0);

	String popup = "";

	if (processPage){
		if (src.equals("item")){
			popup = QuestionDB.getCourseQuestion(conn,campus,type,si);
		}
		else if (src.equals("outline")){
			//popup = QuestionDB.getCourseQuestion(conn,campus,type,si);
		}
	}

	asePool.freeConnection(conn,"tooltip",user);
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFB3" width="40%" style="border: 1px solid #C0C0C0; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">
		<tr>
			<td>&nbsp;</td>
			<td>
				<font class="black">
					<p>
						<%=popup%>
					</p>
				</font>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</body>
</html>
