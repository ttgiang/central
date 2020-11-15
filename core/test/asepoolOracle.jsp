<html>
<head><title>jsp direct</title></head>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page import="ase.aseutil.*"%>
<%@ page import="com.javaexchange.dbConnectionBroker.*"%>

<body>

<%
	AsePool pool = null;
	Connection conn = null;
	Statement stmt = null;

	try {
		out.println( "obtaining broker" + "<br>" );

		ServletContext context = getServletContext();
		String logging = context.getInitParameter("aseConnectionLog");

		pool = new AsePool("oracle.jdbc.driver.OracleDriver",
			"jdbc:oracle:thin:@127.0.0.1:1521:XE","central","tr1gger",2,6,logging,1.1,true,60,3);

		out.println( "got broker" + "<br>" );

		out.println( "obtaining connection" + "<br>" );
		conn = pool.getConnection();
		out.println( "got connection" + "<br>" );

		try{
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select count(id) from tblInfo");
			while (rs.next()) {
				out.println( rs.getString(1) + " records found in tblInfo<br>" );
			}

			if ( rs != null ) rs.close();
			if ( stmt != null ) stmt.close();
		}
		catch(SQLException e){
			out.println( "SQLException: " +  e.toString() );
		}
		finally{
			out.println( "free connection" + "<br>" );
			pool.freeConnection(conn);
		}
	}
	catch (Exception e){
		out.println( e.toString() );
	}

%>

</body>
</html>