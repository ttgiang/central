<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page import="com.ase.aseutil.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
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
<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>


<html>
<head>
    <title>Test</title>
</head>

<%
	ResultSet rs;

	try{
		int i = 0;
		String temp = "tcq.type = 'Course' AND " +
			"tcq.campus = 'LEECC'";
		String sql = "SELECT tcq.question " +
			"FROM tblCourseQuestions tcq INNER JOIN CCCM6100 c61 ON " +
			"(tcq.questionnumber = c61.question_number) " +
			"WHERE (" + temp + ")";
		Statement stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while ( rs.next() ) {
			String descr = rs.getString(1);
			out.println( "<tr><td valign=top>" + (++i) + "</td><td valign=top>" + descr + "</td></tr>" );
		}
		rs.close();
		rs = null;
	}
	catch (SQLException e){
		rs = null;
	}
%>

</body>
</html>
