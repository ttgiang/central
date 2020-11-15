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

		String sErr = "";
		java.sql.Connection connection;
		try {
		  java.sql.DriverManager.registerDriver((java.sql.Driver)(Class.forName(DBDriver).newInstance()));
    	 connection = java.sql.DriverManager.getConnection(strConn , DBusername, DBpassword);

		Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		int recordCount = 0;
		int currentPage = 1;
		int relativeRecord = 0;
		int recordsPerPage = 10;

		ResultSet rs = stmt.executeQuery( "SELECT id, userid, names, coursealpha, coursenum, semester from tblCourseSyllabus " );
		rs.last();
		recordCount = rs.getRow();
		rs.beforeFirst();

		out.println( "recordCount: " + recordCount + "<br>" );
		out.println( "relativeRecord: " + relativeRecord + "<br>" );
		out.println( "recordsPerPage: " + recordsPerPage + "<br>" );

		relativeRecord = (currentPage-1) * recordsPerPage;

		// dont' allow our move to start to be out of range
		if ( relativeRecord > recordCount )
			relativeRecord = recordCount;

		if ( rs.next() ){
			rs.first();
			rs.relative(relativeRecord-1);
		}

		while (rs.next()) {
			out.println( String.valueOf(rs.getString(1)) + "<br>");
		}

		rs.close();
		rs = null;
		stmt.close();
		stmt = null;

		}
		catch (Exception e) {
		  sErr = e.toString();
		}
		out.print(sErr);
%>

</body>
</html>