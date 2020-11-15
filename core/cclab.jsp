<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccutil.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Lab";
	fieldsetTitle = pageTitle;

	boolean isCampAdm = SQLUtil.isCampusAdmin(conn,user);
	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table align="center" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">

	<tr>
		<td valign="top">
				<img src="../images/flask.png" alt="CC Lab is enabled" title="CC Lab is enabled">&nbsp;&nbsp;&nbsp;
				Curriculum Central Lab is a testing ground for experimental features that aren't quite ready for primetime. They may change, break or
				disappear at any time:
			<ul>
				<li>Print to PDF - print outlines and programs in Adobe PDF format (<img src="../images/ext/pdf.gif" alt="Adobe PDF" title="Adobe PDF">)</li>
				<li>Profile photo - attach a photo to your <a href="usrprfl.jsp" class="linkcolumn">profile</a></li>
			</ul>
		</td>
	</tr>
</table>

<br/>
<%
	asePool.freeConnection(conn,"ccutil",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
