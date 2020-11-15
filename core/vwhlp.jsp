<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwhlp.jsp
	*	2010.10.21
	**/

	String pageTitle = "";

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pge = website.getRequestParameter(request,"page","");
	String content = "";
	String systemContent = "";
	String announcements = "";
	String title = "Curriculum Central (CC)";

	if (processPage && !page.equals(Constant.BLANK)){
		content = "Campus help is not available for this page";

		Help help = HelpDB.getHelpByCategoryPage(conn,campus,"PageHelp",pge);
		if (help != null){
			content = help.getContent();
			title = help.getTitle();
		}

		systemContent = "System help is not available for this page";
		help = HelpDB.getHelpByCategoryPage(conn,"SYS","PageHelp",pge);
		if (help != null){
			systemContent = help.getContent();
		}
	}

%>
	<title>Curriculum Central</title>
	<%@ include file="ase2.jsp" %>
</head>
<body>

<p align="center">
	<table width="100%" height="98%" border="0" cellpadding="0">
		<tr height="08%">
			<td width="01%">&nbsp;</td>
			<td class="textblackth18"><img src="../images/logos/logo<%=campus%>.jpg" border="0"><%=title%><div class="hr"></div></td>
			<td width="01%">&nbsp;</td>
		</tr>
		<tr bgcolor="#ffffff" height="91%">
			<td width="01%">&nbsp;</td>
			<td class="datacolumn" valign="top">
				<fieldset class="FIELDSET90">
					<legend>Campus Help</legend>
					<%
						out.println(content);
					%>
				</fieldset>
				<br/>
				<fieldset class="FIELDSET90">
					<legend>System Help</legend>
					<%
						out.println(systemContent);
					%>
				</fieldset>
				<br/>
			</td>
			<td width="01%">&nbsp;</td>
		</tr>
		<tr height="01%">
			<td width="01%">&nbsp;</td>
			<td class="textblackth"><div class="hr"></div>
				<%@ include file="../inc/footersimple.jsp" %>
			</td>
			<td width="01%">&nbsp;</td>
		</tr>
	</table>
</p>

<%
	asePool.freeConnection(conn,"vwhlp",user);
%>

</body>
</html>
