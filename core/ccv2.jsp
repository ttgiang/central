<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.apache.log4j.Logger"%>

<jsp:useBean id="kookie" scope="application" class="com.ase.aseutil.CookieManager" />

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Download";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		processPage = false;

		// not permitted when not admin so we bounce back to task listing
		response.sendRedirect("tasks.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		out.println("<a href=\"/centraldocs/ccv2haw.zip\" class=\"linkcolumn\">download my DB</a>");
	}

	asePool.freeConnection(conn,"ccv2",user);

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>