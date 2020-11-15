<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="errorpge.jsp" %>
<%
response.setDateHeader("Expires", 0); // date in the past
response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.addHeader("Pragma", "no-cache"); // HTTP/1.0
%>

<html>
<head>
    <title>Test</title>
</head>

<%

out.print("1<br>");

try{
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
}catch (Exception ex){
	out.println(ex.toString());
}
out.print("2<br>");
String xDb_Conn_Str = "jdbc:mysql://localhost/cc";
out.print("3<br>");
Connection conn = null;
out.print("4<br>");
try{
	conn = DriverManager.getConnection(xDb_Conn_Str,"root","tr1gger");
	out.print("5<br>");
}catch (SQLException ex){
	out.println(ex.toString());
}
out.print("6<br>");


Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
int recordCount = 0;
int currentPage = 1;
int relativeRecord = 0;
int recordsPerPage = 10;

ResultSet rs = stmt.executeQuery( "SELECT id, userid, names, coursealpha, coursenum, semester from tblCourseSyllabus " );
rs.last();
recordCount = rs.getRow();
rs.beforeFirst();

out.println( "recordCount: " + recordCount + "<br>" );
out.println( "relativeRecord: " + relativeRecord + "<br>" );
out.println( "recordsPerPage: " + recordsPerPage + "<br>" );

relativeRecord = (currentPage-1) * recordsPerPage;

// dont' allow our move to start to be out of range
if ( relativeRecord > recordCount )
	relativeRecord = recordCount;

if ( rs.next() ){
	rs.first();
	rs.relative(relativeRecord-1);
}

rs.close();
rs = null;
stmt.close();
stmt = null;


%>

</body>
</html>