<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ase.aseutil.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>

<%@ include file="../inc/db.jsp" %>

<%

out.println("starting...<br>");
try {
	String sql = "SELECT userid,userlevel,campus,division,email FROM tblUsers WHERE userid='THANHG' and password='123456'";

	Statement stmt = null;
	stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	while ( rs.next() ) {
		//out.println(sql + "<br>" );
		out.println( rs.getString(1) + "<br>" );
		out.println( rs.getString(2) + "<br>" );
		out.println( rs.getString(3) + "<br>" );
		out.println( rs.getString(4) + "<br>" );
		out.println( rs.getString(5) + "<br>" );
	}
	rs.close();
	rs = null;
	stmt.close();
}
catch (Exception e) {
	out.println(e.toString());
}
out.println("ending...<br>");

%>

<html>
<head>
</head>

<body topmargin="0" leftmargin="0">

</body>
</html>