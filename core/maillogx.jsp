<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	maillogx.jsp - view mail sent
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Email Sent";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String helpButton = website.getRequestParameter(request,"help");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	int id = website.getRequestParameter(request,"lid",0);

	String from = "";
	String to = "";
	String cc = "";
	String subject = "";
	String content = "";
	String dte = "";
	String attachment = "";

	if (id > 0){
		Mailer mailer = MailerDB.getMail(conn,id);
		if (mailer != null){
			from = mailer.getFrom();
			to = mailer.getTo();
			cc = mailer.getCC();
			subject = mailer.getSubject();
			content = mailer.getContent();
			dte = mailer.getDte();
			attachment = mailer.getAttachment();
		}
	}

	asePool.freeConnection(conn,"maillogx",user);
%>

<p class="textblackthcenter">
<table width="100%" cellspacing='1' cellpadding='4' align="center"  border="0">
	<tr>
		<td class="textblackth">Date Sent</td>
		<td class="datacolumn"><%=dte%></td>
	</tr>
	<tr>
		<td class="textblackth">From</td>
		<td class="datacolumn"><%=from%></td>
	</tr>
	<tr>
		<td class="textblackth">To</td>
		<td class="datacolumn"><%=to.replace(",","<br/>")%></td>
	</tr>
	<tr>
		<td class="textblackth">CC</td>
		<td class="datacolumn"><%=cc%></td>
	</tr>

	<%
		if (attachment != null && attachment.length() > 0){
	%>
			<tr>
				<td class="textblackth">Attachment</td>
				<td class="datacolumn"><a href="<%=attachment%>" target="_blank"><img src="../images/attachment.gif" border="0"></a></td>
			</tr>
	<%
		}
	%>

	<tr>
		<td class="textblackth">Subject</td>
		<td class="datacolumn"><%=subject%></td>
	</tr>
	<tr>
		<td class="textblackth">Content</td>
		<td class="datacolumn"><%=content%></td>
	</tr>
</table>

</p>

</body>
</html>