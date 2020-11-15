<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dltxy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String type = website.getRequestParameter(request,"type","");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	fieldsetTitle = "Permanently Delete Outline";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		com.ase.aseutil.util.CCUtil.deleteFromAllTables(user,campus,alpha,num,type);
%>

<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TBODY>
		<TR>
			<TD align="center">
				<br/>
				<a href="usrlog.jsp" class="linkcolumn">view action log</a>
				<span class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</span>
				<a href="dlt.jsp" class="linkcolumn">try again</a>
				<br/>
			</TD>
		</TR>
	</TBODY>
</TABLE>

<%
	} // processPage

	asePool.freeConnection(conn,"dltxy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
