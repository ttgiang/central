<%@page import="com.ase.aseutil.*"%>
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite">
	<%website.init(application.getRealPath("/central/test/"));%>
</jsp:useBean>
<HTML>
<HEAD>
<TITLE>ASE</TITLE>
</HEAD>
<BODY>

<%
	User user = website.user;

	if( user == null || ( !user.isAdmin()) )
	{
		user.adminLogin(request,response);
		return;
	}

%>

</BODY>
</HTML>
