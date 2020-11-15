<%@ include file="../ase.jsp" %>

<html>
<head><title>jsp direct</title></head>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page import="com.ase.aseutil.*"%>

<body>

<%
	conn = asePool.getConnection();
	Statement stmt = null;

	Ini ini = new Ini
	(
		"0",
		"banner_questions",
		"10",
		"",
		"THANH.GIANG",
		(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date())
	);

	try{
		int rowsAffected = 0;
		IniDB iniDB = new IniDB();
		PreparedStatement preparedStatement = conn.prepareStatement ("INSERT INTO tblIni (kid, kval, kval2, klanid) VALUES (?, ?, ?, ?)");
		preparedStatement.setString (1, ini.getKid());
		preparedStatement.setString (2, ini.getKval());
		preparedStatement.setString (3, ini.getKval2());
		preparedStatement.setString (4, ini.getKlanid());
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
		out.print( "Inserted: " + rowsAffected );

/*
		PreparedStatement preparedStatement1 = conn.prepareStatement ("DELETE FROM tblInfo WHERE id = ?");
		preparedStatement1.setString (1, "13");
		rowsAffected = preparedStatement1.executeUpdate();
		preparedStatement1.close ();
		out.print( "Deleted: " + rowsAffected );

		PreparedStatement preparedStatement2 = conn.prepareStatement ("UPDATE tblInfo SET infotitle=?, infocontent=?, author=?, dateposted=? WHERE id =?");
		preparedStatement2.setString (1, news.getTitle());
		preparedStatement2.setString (2, news.getContent());
		preparedStatement2.setString (3, news.getAuditBy());
		preparedStatement2.setString (4, news.getAuditDate());
		preparedStatement2.setString (5, "12");
		rowsAffected = preparedStatement2.executeUpdate();
		preparedStatement2.close ();
		out.print( "Updated: " + rowsAffected );
*/
	}
	catch( Exception e ){
		out.print( e.toString() );
	}
	finally{
		asePool.freeConnection(conn);
	}

%>

</body>
</html>