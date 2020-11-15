<%@ page import="java.sql.*"%>
<%


System.out.println("1");

try{
	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver").newInstance();
	System.out.println("newInstance");
}catch (Exception ex){
	System.out.println(ex.toString());
}

Connection conn = null;

try{
	conn = DriverManager.getConnection("jdbc:odbc:ccv2","d-2020-101385\\ccusr","");
	System.out.println("DriverManager");
}catch (SQLException ex){
	System.out.println(ex.toString());
}

%>
