<%@ include file="ase.jsp" %>
<html>
<head>
	<%
		String campus = Util.getSessionMappedKey(session,"aseCampus");
		String user = Util.getSessionMappedKey(session,"aseUserName");
		String kix = website.getRequestParameter(request,"kix","");

		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String type = info[Constant.KIX_TYPE];

		String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
		fieldsetTitle = pageTitle;

		// display outline detail
		String[] statusTab = null;
		statusTab = courseDB.getCourseDates(conn,kix);
	%>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="js/crsinfy.js"></script>

</head>
<body>
<br/>

<font class="titlemessage"><%=pageTitle%></font>

<table border="0" width="100%" class="tableCaption">
	<tr bgcolor="#ffffff">
		<td>
			<table border="0" cellpadding="2" width="100%">
				<%
					ArrayList list = HistoryDB.getHistories(conn,kix,type);
					if (list != null){
						History history;
						for (int i=0; i<list.size(); i++){
							history = (History)list.get(i);
							out.println("<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
							out.println("<tr><td valign=top>" + history.getComments() + "</td></tr>" );
						}
					}
				%>
			</table>
		</td>
	</tr>
</table>

<p><a href="##" class="linkcolumn" onClick="return moreHistory('<%=campus%>','<%=alpha%>','<%=num%>','ARC');">&nbsp;show archived history</a></p>
<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="moreHistory">
	<img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...
</div>

</body>
</html>

