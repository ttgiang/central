<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page import="com.ase.aseutil.*"%>
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


<html>
<head>
    <title>Test</title>
</head>

<%
	  String DBDriver  ="sun.jdbc.odbc.JdbcOdbcDriver";
	  String strConn   ="jdbc:odbc:cc";
	  String DBusername="root";
	  String DBpassword="";
	  int i = 0;
	  String sErr = "";

		try {

		com.ase.aseutil.QuestionDB questionDB = new com.ase.aseutil.QuestionDB();
		int rowsAffected = questionDB.resequenceItems(conn,"LEECC");
		questionDB = null;
		out.println( "completed" );


		}
		catch (Exception e) {
		  sErr = e.toString();
		}
		out.print(sErr);
%>

</body>
</html>