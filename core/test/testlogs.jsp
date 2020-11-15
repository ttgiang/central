<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cmprx.jsp	outline copy/compare
	*	2007.09.01
	**/

	// NEED TO WORK OUT PAGING

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String user = website.getRequestParameter(request,"aseUserName","",true);
	String view = website.getRequestParameter(request,"view","",false);

	String pageTitle = "Log Processing";
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
				out.println("Start<br/>");

				if (processPage){
					if ("".equals(view)){
						ProcessLog p = new ProcessLog();
						out.println(p.createLog(conn));
						out.println("<br/><a href=\"?view=1\" class=\"linkcolumn\">view log</a><br/>");
					}
					else{
						String sql = aseUtil.getPropertySQL(session,"logs");
						paging = new com.ase.paging.Paging();
						paging.setSQL(sql);
						paging.setScriptName("?view=1");
						paging.setUrlKeyName("view");
						paging.setAllowAdd(false);
						paging.setRecordsPerPage(15);
						out.print(paging.showRecords(conn,request,response));
						paging = null;
					}
				}

				out.println("<br/>End");

				asePool.freeConnection(conn,"testlogs",user);
			%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

