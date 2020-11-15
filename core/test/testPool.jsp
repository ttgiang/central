<html>
<head><title>jsp direct</title></head>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page import="ase.aseutil.*"%>

<body>

<%
	com.ase.aseutil.AsePool pool = null;
	Connection conn = null;
	Statement stmt = null;

	try {
		out.println( "obtaining broker" + "<br>" );

		ServletContext context = getServletContext();
		String logging = context.getInitParameter("aseApplicationLog");
		//ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AccessDrivers");
		ResourceBundle bundle = ResourceBundle.getBundle("ase.central.OracleDrivers");
		String host = bundle.getString("host");
		String port = bundle.getString("port");
		String db = bundle.getString("db");
		String driver = bundle.getString("driver");
		String url = bundle.getString("url");
		String user = bundle.getString("user");
		String password = bundle.getString("password");

		url = url + ":" + host + ":" + port + ":" + db;

		out.println( "logging: 	" + logging + "<br>" );
		out.println( "host: 		" + host + "<br>" );
		out.println( "port: 		" + port + "<br>" );
		out.println( "db: 		" + db + "<br>" );
		out.println( "driver: 	" + driver + "<br>" );
		out.println( "url: 		" + url + "<br>" );
		out.println( "user: 		" + user + "<br>" );
		out.println( "password:	" + "************" + "<br>" );

		//pool = new com.ase.aseutil.AsePool(driver,url,user,password,2,6,logging,1.1,true,60,3);

		//Connection connection = null;
		//Class.forName(driver);
		//out.println( "out of here..." + "<br>" );
	}
	catch (Exception e){
		out.println( e.toString() );
	}

%>

</body>
</html>