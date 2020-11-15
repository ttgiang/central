<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	about.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "About Curriculum Central (CC)";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%@ include file="idx.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td width="10%" class="textblackth" valign="top">Original date</td>
		<td valign="top" class="datacolumn">01/01/1997 - CC was created for use by Leeward Community College</td>
	</tr>
	<tr>
		<td width="10%" class="textblackth" valign="top">Major upgrade</td>
		<td valign="top" class="datacolumn">09/01/2007 - CC relaunched for use system wide</td>
	</tr>
	<tr>
		<td width="10%" class="textblackth" valign="top">Description</td>
		<td valign="top" class="datacolumn">Online Curriculum Maintenance
			<br><br>
			</ul>
				<li><a href="rlsnotes.jsp" class="linkcolumn">Release Notes</a></li>
				<li><a href="ccfaq.jsp" class="linkcolumn">Announcements</a></li>
			</ul>
		</td>
	</tr>
</table>

<%
	asePool.freeConnection(conn,"about",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
