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
		System.out.println( "---------------- START" );

		System.out.println( "obtaining broker" );

		myBroker = new DbConnectionBroker("net.sourceforge.jtds.jdbc.Driver",
													"jdbc:jtds:sqlserver://d-2020-101385:1433/ccv2",
													"sa","msde",10,50,
													"c:\\tomcat\\webapps\\central\\logs\\DBConn.log",1.0,false,60,3);
		System.out.println( "got broker" );

		System.out.println( "obtaining connection" );
		conn = myBroker.getConnection();
		System.out.println( "got connection" );

		try{
			System.out.println( "obtaining statement" );
			stmt = conn.createStatement();
			System.out.println( "got statement" );

			System.out.println( "obtaining resultset" );
			ResultSet rs = stmt.executeQuery("select * from tblInfo");
			System.out.println( "got resultset" );

			System.out.println( "show resultset" );
			while (rs.next()) {
				System.out.println( rs.getString(1) );
			}

			System.out.println( "close resultset" );
			if ( rs != null ) rs.close();

			System.out.println( "close statement" );
			if ( stmt != null ) stmt.close();
		}
		catch(SQLException e){
			System.out.println( "SQLException: " +  e.toString() );
		}
		finally{
			System.out.println( "free connection" );
			myBroker.freeConnection(conn);
		}
	}
	catch (Exception e){
		System.out.println( e.toString() );
	}

%>

</body>
</html>