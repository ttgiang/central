<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "DF00126";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form name="aseForm" action="testz.jsp" method="post">
<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	tg00000.jsp
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		try{

			out.println("Data correction: ");

			com.ase.aseutil.healthcheck.HealthCheck hc = new com.ase.aseutil.healthcheck.HealthCheck();
			out.println(hc.tg00000(conn));
			hc = null;

			out.println("<br><br>return to <a href=\"sa.jsp\" class=\"linkcolumn\">sysadm</a>");

		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	asePool.freeConnection(conn,"df00126",user);
%>

</table>

</form>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>