<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prghst.jsp - approval history
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approval History";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
	String[] info = helper.getKixInfo(conn,kix);
	String title = info[Constant.KIX_ALPHA];
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
</head>
<body topmargin="0" leftmargin="0">

<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none" name="approval_history" class="linkcolumn">Approval History - <%=title%></a></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td>
			<table border="0" cellpadding="2" width="100%">
				<%
					if (processPage && kix != ""){

						ArrayList list = HistoryDB.getHistories(conn,kix,"PRE","");
						if (list != null){
							History history;
							for (int i=0; i<list.size(); i++){
								history = (History)list.get(i);
								out.println( "<tr class=\"rowhighlight\"><td valign=top class=\"textblackth\">" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
								out.println( "<tr><td valign=top class=\"datacolumn\">" + history.getComments() + "</td></tr>" );
							}
						}
						else{
							out.println( "<tr><td valign=top>History data not available</td></tr>" );
						}
					}

					asePool.freeConnection(conn,"prghst",user);
				%>
			</table>
		</td>
	</tr>
</table>

</body>
</html>