<!-
 @author ase
 @version 1.0
!>
<html>
<head><title>jsp direct</title></head>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ include file="inc/common.jsp" %>
<body>
<%
 ResultSet rs;
 Class.forName("com.mysql.jdbc.Driver").newInstance();
 java.sql.Connection myConn;
 myConn = DriverManager.getConnection("jdbc:mysql://localhost/cc?user=root&password=tr1gger");
 Statement stmt = myConn.createStatement();
 rs = stmt.executeQuery("select * from tblIni order by kid ");
 String[] sFields = getFieldsName(rs);
 if ( sFields != null ){
  for(int j = 0; j < sFields.length-1; j++) {
     out.println(sFields[j+1] + "<br>");
  }
 }
 while (rs.next()) {
  for(int j = 0; j < sFields.length-1; j++) {
   out.println(rs.getString(sFields[j+1]) + ",");
  }
  out.println( "<br>" );
 }
 stmt.close();
 myConn.close();
%>
</body>
</html>