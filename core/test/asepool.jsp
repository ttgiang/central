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
		System.out.println( "obtaining broker" + "<br>" );

		String host = "THANH";
		String port = "1433";
		String driver = "net.sourceforge.jtds.jdbc.Driver";
		String url = "jdbc:jtds:sqlserver";
		String db = "er00014";
		String user = "ccusr";
		String password = "tw0c0mp1ex4u";

System.out.println(host);
System.out.println(port);
System.out.println(driver);
System.out.println(url);
System.out.println(db);

		url = "jdbc:jtds:sqlserver://" + host + ":" + port + "/" + db;

		pool = new com.ase.aseutil.AsePool(driver,url,user,password,10,50,"c:\\tomcat\\webapps\\central\\logs\\test.log",1.0,false,180,3);

		System.out.println( "got broker" + "<br>" );

		System.out.println( "obtaining connection" + "<br>" );
		conn = pool.getConnection();
		System.out.println( "got connection" + "<br>" );

		try{
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select count(id) from tblInfo");
			while (rs.next()) {
				System.out.println( rs.getString(1) + " records found in tblInfo<br>" );
			}

			if ( rs != null ) rs.close();
			if ( stmt != null ) stmt.close();
		}
		catch(SQLException e){
			System.out.println( "SQLException: " +  e.toString() );
		}
		finally{
			System.out.println( "free connection" + "<br>" );
			pool.freeConnection(conn);
		}
	}
	catch (Exception e){
		System.out.println( e.toString() );
	}

%>

</body>
</html>