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
request.setCharacterEncoding("UTF-8");
String key = request.getParameter("key");
if (key == null || key.length() == 0 ) {
	response.sendRedirect("userslist.jsp");
	response.flushBuffer();
	return;
}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}

// Get fields from form
Object x_user_id = null;
Object x_user_login = null;
Object x_user_password = null;
Object x_user_level = null;
Object x_name = null;
Object x_email = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `users` WHERE `user_id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("userslist.jsp");
			response.flushBuffer();
			return;
		}else{
			rs.first();

			// Get the field contents
	x_user_id = String.valueOf(rs.getLong("user_id"));
			if (rs.getString("user_login") != null){
				x_user_login = rs.getString("user_login");
			}else{
				x_user_login = "";
			}
			if (rs.getString("user_password") != null){
				x_user_password = rs.getString("user_password");
			}else{
				x_user_password = "";
			}
	x_user_level = String.valueOf(rs.getLong("user_level"));
			if (rs.getString("name") != null){
				x_name = rs.getString("name");
			}else{
				x_name = "";
			}
			if (rs.getString("email") != null){
				x_email = rs.getString("email");
			}else{
				x_email = "";
			}
		}
		rs.close();
	}else if (a.equals("U")) {// Update

		// Get fields from form
		if (request.getParameter("x_user_login") != null){
			x_user_login = (String) request.getParameter("x_user_login");
		}else{
			x_user_login = "";
		}
		if (request.getParameter("x_user_password") != null){
			x_user_password = (String) request.getParameter("x_user_password");
		}else{
			x_user_password = "";
		}
		if (request.getParameter("x_user_level") != null){
			x_user_level = (String) request.getParameter("x_user_level");
		}else{
			x_user_level = "";
		}
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_email") != null){
			x_email = (String) request.getParameter("x_email");
		}else{
			x_email = "";
		}

		// Open record
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `users` WHERE `user_id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("userslist.jsp");
			response.flushBuffer();
			return;
		}

		// Field user_login
		tmpfld = ((String) x_user_login);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("user_login");
		}else{
			rs.updateString("user_login", tmpfld);
		}

		// Field user_password
		tmpfld = ((String) x_user_password);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("user_password");
		}else{
			rs.updateString("user_password", tmpfld);
		}

		// Field user_level
		tmpfld = ((String) x_user_level).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("user_level");
		} else {
			rs.updateInt("user_level",Integer.parseInt(tmpfld));
		}

		// Field name
		tmpfld = ((String) x_name);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("name");
		}else{
			rs.updateString("name", tmpfld);
		}

		// Field email
		tmpfld = ((String) x_email);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = null;
		}
		if (tmpfld == null) {
			rs.updateNull("email");
		}else{
			rs.updateString("email", tmpfld);
		}
		rs.updateRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("userslist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
		out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Edit TABLE: users<br><br><a href="userslist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_user_login && !EW_hasValue(EW_this.x_user_login, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_user_login, "TEXT", "Invalid Field - user login"))
                return false; 
        }
if (EW_this.x_user_password && !EW_hasValue(EW_this.x_user_password, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_user_password, "TEXT", "Invalid Field - user password"))
                return false; 
        }
if (EW_this.x_user_level && !EW_hasValue(EW_this.x_user_level, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_user_level, "TEXT", "Incorrect integer - user level"))
                return false; 
        }
if (EW_this.x_user_level && !EW_checkinteger(EW_this.x_user_level.value)) {
        if (!EW_onError(EW_this, EW_this.x_user_level, "TEXT", "Incorrect integer - user level"))
            return false; 
        }
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  name="usersedit" action="usersedit.jsp" method="post">
<p>
<input type="hidden" name="a" value="U">
<input type="hidden" name="key" value="<%= key %>">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">user id</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><% out.print(x_user_id); %></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">user login</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_user_login" size="30" maxlength="15" value="<%= HTMLEncode((String)x_user_login) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">user password</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_user_password" size="30" maxlength="15" value="<%= HTMLEncode((String)x_user_password) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">user level</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_user_level" size="30" value="<%= HTMLEncode((String)x_user_level) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">name</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_name" size="30" maxlength="50" value="<%= HTMLEncode((String)x_name) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">email</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_email" size="30" maxlength="30" value="<%= HTMLEncode((String)x_email) %>"></span>&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="EDIT">
</form>
<%@ include file="footer.jsp" %>
