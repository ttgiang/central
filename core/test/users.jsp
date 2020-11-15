<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="errorpge.jsp" %>
<%
response.setDateHeader("Expires", 0); // date in the past
response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.addHeader("Pragma", "no-cache"); // HTTP/1.0
%>

<% Locale locale = Locale.getDefault();
response.setLocale(locale);%>
<% session.setMaxInactiveInterval(30*60); %>
<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>
<%@ include file="pagingvar.jsp" %>

<html>
<head>
    <title>Test</title>
    <link rel="stylesheet" href="../inc/style.css">
</head>

<%
		//<jsp:useBean id="paging" scope="session" class="ase.paging.Paging"/>
		//paging.setDetail("index.asp?report=2&search=");
		//paging.setTableRowBackgroundColor("#3d84cc");
		//paging.setEvenRowColor("#E1E1E1");
		//paging.setNumberOfColumns(3);
		//paging.setSortColumns("user_id,name,email");
		//paging.setFormatColumns("user_id,name,email");
		//paging.setSumColumns("user_id,name,email");
		//paging.setTemplateHeader(strHeader);
		//paging.setTemplate(strTemplate);
		//paging.setTemplateFooter(strFooter);
		//paging.setTemplateNavigation(strNavigation);
		//paging.setScriptName("paging.jsp");
		//paging.setRecordsPerPage(recordsPerPage);
		//paging.setDetail("");
		//ase.paging.Paging paging = new ase.paging.Paging(asePage,"SELECT * from users3",aseSrt,aseCol);

		ase.paging.Paging paging = new ase.paging.Paging();
		paging.setTableWidth("660");
		paging.setSQL("SELECT * from users ");
		paging.setSortOrder(aseSrt);
		paging.setOrderBy(aseCol);
		paging.SetAllignDataType(true);
		paging.setDebug(true);
		out.print( paging.showRecords(conn,asePage) );
		paging = null;

		conn.close();
		conn = null;
%>

</body>
</html>