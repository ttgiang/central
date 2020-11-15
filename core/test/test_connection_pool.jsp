<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page import="com.javaexchange.dbConnectionBroker.*"%>
<%@ page contentType="text/html; chars=UTF-8" %>
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


<html>
<head>
    <title>Test</title>
</head>

<%
	DbConnectionBroker myBroker;
	Connection conn = null;
	Statement stmt = null;

	try {
		out.println( "obtaining broker" + "<br>" );
		myBroker = new DbConnectionBroker("sun.jdbc.odbc.JdbcOdbcDriver",
			"jdbc:odbc:cc",
			"root","",2,6,
			"c:\\tomcat\\DBConn\\DBConn.log",1.1,true,60,3);
		out.println( "got broker" + "<br>" );

		out.println( "obtaining connection" + "<br>" );
		conn = myBroker.getConnection();
		out.println( "got connection" + "<br>" );

		try{
			out.println( "obtaining statement" + "<br>" );
			stmt = conn.createStatement();
			out.println( "got statement" + "<br>" );

			out.println( "obtaining resultset" + "<br>" );
			ResultSet rs = stmt.executeQuery("select * from tblInfo");
			out.println( "got resultset" + "<br>" );

			out.println( "show resultset" + "<br>" );
			while (rs.next()) {
				out.println( rs.getString(1) + "<br>" );
			}

			out.println( "close resultset" + "<br>" );
			if ( rs != null ) rs.close();

			out.println( "close statement" + "<br>" );
			if ( stmt != null ) stmt.close();
		}
		catch(SQLException e){
			out.println( "SQLException: " +  e.toString() );
		}
		finally{
			out.println( "free connection" + "<br>" );
			myBroker.freeConnection(conn);
		}
	}
	catch (Exception e){
		out.println( e.toString() );
	}

%>

</body>
</html>