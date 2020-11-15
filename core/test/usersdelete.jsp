<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
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
<%
String tmpfld = null;
String escapeString = "\\\\'";

// Single delete record
String key = request.getParameter("key");
if (key == null || key.length() == 0 ) {
	response.sendRedirect("userslist.jsp");
	response.flushBuffer();
	return;
}
String sqlKey = "`user_id`=" + "" + key.replaceAll("'",escapeString) + "";

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Display
		String strsql = "SELECT * FROM `users` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("userslist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `users` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("userslist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: users<br><br><a href="userslist.jsp">Back to List</a></span></p>
<form action="usersdelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr bgcolor="#594FBF">
		<td><span class="jspmaker" style="color: #FFFFFF;">user id</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">user login</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">user password</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">user level</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">name</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">email</span>&nbsp;</td>
	</tr>
<%
int recCount = 0;
while (rs.next()){
	recCount ++;
	String bgcolor = "#FFFFFF"; // Set row color
%>
<%
	if (recCount%2 != 0 ) { // Display alternate color for rows
		bgcolor = "#F5F5F5";
	}
%>
<%
	String x_user_id = "";
	String x_user_login = "";
	String x_user_password = "";
	String x_user_level = "";
	String x_name = "";
	String x_email = "";

	// user_id
	x_user_id = String.valueOf(rs.getLong("user_id"));

	// user_login
	if (rs.getString("user_login") != null){
		x_user_login = rs.getString("user_login");
	}
	else{
		x_user_login = "";
	}

	// user_password
	if (rs.getString("user_password") != null){
		x_user_password = rs.getString("user_password");
	}
	else{
		x_user_password = "";
	}

	// user_level
	x_user_level = String.valueOf(rs.getLong("user_level"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
		x_name = "";
	}

	// email
	if (rs.getString("email") != null){
		x_email = rs.getString("email");
	}
	else{
		x_email = "";
	}
%>
	<tr bgcolor="<%= bgcolor %>">
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="jspmaker"><% out.print(x_user_id); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_user_login); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_user_password); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_user_level); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_name); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_email); %>&nbsp;</td>
  </tr>
<%
}
rs.close();
rs = null;
stmt.close();
stmt = null;
conn.close();
conn = null;
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
</table>
<p>
<input type="submit" name="Action" value="CONFIRM DELETE">
</form>
<%@ include file="footer.jsp" %>
