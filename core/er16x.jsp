<%@ include file="ase.jsp" %>
<html>
<head>
	<%
		String campus = Util.getSessionMappedKey(session,"aseCampus");
		String user = Util.getSessionMappedKey(session,"aseUserName");
		String kix = website.getRequestParameter(request,"kix","");

		// display outline detail
		String[] statusTab = null;
		statusTab = courseDB.getCourseDates(conn,kix);

		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String type = info[Constant.KIX_TYPE];

		String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
		fieldsetTitle = pageTitle;

	%>
	<%@ include file="ase2.jsp" %>
</head>
<body>
<br/>
<font class="titlemessage"><%=pageTitle%></font>
<br/>
<table border="0" width="100%" class="tableCaption">
	<tr bgcolor="white">
		<td>
			<%@ include file="crsedt9.jsp" %>
		</td>
	</tr>
</table>
</body>
</html>