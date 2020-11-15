<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	newsdltx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";
	String pageTitle = "News Detail";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	int lid = 0;

	lid = website.getRequestParameter(request,"lid", 0);
	NewsDB newsDB = new NewsDB();
	News news = new News();

	if (processPage && lid > 0){
		news = newsDB.getNews( conn, lid);
	}

	asePool.freeConnection(conn,"newsdtlx",user);
%>

<table width="100%" cellspacing='1' cellpadding="6" style="BORDER-TOP: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-RIGHT: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-BOTTOM: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid; BORDER-LEFT: textblackTRTheme<%=session.getAttribute("aseTheme")%> 1px solid" align="center" border="0">
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		 <td class="textblackTH" width="20%">Author:&nbsp;</td>
		 <td class='dataColumn'><%=news.getAuditBy()%></td>
	</tr>
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		 <td class="textblackTH" width="20%">Date Posted:&nbsp;</td>
		 <td class='dataColumn'><%=news.getAuditDate()%></td>
	</tr>
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		 <td class="textblackTH" width="20%">Title:&nbsp;</td>
		 <td class='dataColumn'><%=news.getTitle()%></td>
	</tr>
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		 <td class="textblackTH" width="20%">News:&nbsp;</td>
		 <td class='dataColumn'><%=news.getContent()%></td>
	</tr>
</table>

</body>
</html>