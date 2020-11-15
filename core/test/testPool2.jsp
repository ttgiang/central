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
	com.ase.aseutil.AsePool pool = null;
	Connection conn = null;
	Statement stmt = null;

	try {
		out.println( "obtaining broker" + "<br>" );

		ServletContext context = getServletContext();
		String logging = context.getInitParameter("aseApplicationLog");
		ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AccessDrivers");
		String host = bundle.getString("host");
		String port = bundle.getString("port");
		String db = bundle.getString("db");
		String driver = bundle.getString("driver");
		String url = bundle.getString("url");
		String user = bundle.getString("user");
		String password = bundle.getString("password");

		out.println( "logging: 	" + logging + "<br>" );
		out.println( "host: 		" + host + "<br>" );
		out.println( "port: 		" + port + "<br>" );
		out.println( "db: 		" + db + "<br>" );
		out.println( "driver: 	" + driver + "<br>" );
		out.println( "url: 		" + url + "<br>" );
		out.println( "user: 		" + user + "<br>" );

		pool = new com.ase.aseutil.AsePool(driver,url,"root","",2,6,logging,1.1,true,60,3);

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