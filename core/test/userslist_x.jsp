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
int displayRecs = 10;
int recRange = 10;
%>
<%
String thisTable = "users3";
String thisKey = "";
String tmpfld = null;
String escapeString = "\\\\'";
String dbwhere = "";
String masterdetailwhere = "";
String searchwhere = "";
String a_search = "";
String b_search = "";
String whereClause = "";
int startRec = 0, stopRec = 0, totalRecs = 0, recCount = 0;
%>
<%

// Get search criteria for basic search
String pSearch = request.getParameter("psearch");
String pSearchType = request.getParameter("psearchtype");
if (pSearch != null && pSearch.length() > 0) {
	pSearch = pSearch.replaceAll("'",escapeString);
	if (pSearchType != null && pSearchType.length() > 0) {
		while (pSearch.indexOf("  ") > 0) {
			pSearch = pSearch.replaceAll("  ", " ");
		}
		String [] arpSearch = pSearch.trim().split(" ");
		for (int i = 0; i < arpSearch.length; i++){
			String kw = arpSearch[i].trim();
			b_search = b_search + "(";
			b_search = b_search + "`user_login` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`user_password` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`name` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`email` LIKE '%" + kw + "%' OR ";
			if (b_search.substring(b_search.length()-4,b_search.length()).equals(" OR ")) { b_search = b_search.substring(0,b_search.length()-4);}
			b_search = b_search + ") " + pSearchType + " ";
		}
	}else{
		b_search = b_search + "`user_login` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`user_password` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`name` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`email` LIKE '%" + pSearch + "%' OR ";
	}
}
if (b_search.length() > 4 && b_search.substring(b_search.length()-4,b_search.length()).equals(" OR ")) {b_search = b_search.substring(0, b_search.length()-4);}
if (b_search.length() > 5 && b_search.substring(b_search.length()-5,b_search.length()).equals(" AND ")) {b_search = b_search.substring(0, b_search.length()-5);}
%>
<%

// Build search criteria
if (a_search != null && a_search.length() > 0) {
	searchwhere = a_search; // Advanced search
}else if (b_search != null && b_search.length() > 0) {
	searchwhere = b_search; // Basic search
}

// Save search criteria
if (searchwhere != null && searchwhere.length() > 0) {
	session.setAttribute("users_searchwhere", searchwhere);
	startRec = 1; // Reset start record counter (new search)
	session.setAttribute("users_REC", new Integer(startRec));
}else{
	if (session.getAttribute("users_searchwhere") != null)
		searchwhere = (String) session.getAttribute("users_searchwhere");
}
%>
<%

// Get clear search cmd
startRec = 0;
if (request.getParameter("cmd") != null && request.getParameter("cmd").length() > 0) {
	String cmd = request.getParameter("cmd");
	if (cmd.toUpperCase().equals("RESET")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("users_searchwhere", searchwhere);
	}else if (cmd.toUpperCase().equals("RESETALL")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("users_searchwhere", searchwhere);
	}
	startRec = 1; // Reset start record counter (reset command)
	session.setAttribute("users_REC", new Integer(startRec));
}

// Build dbwhere
if (masterdetailwhere != null && masterdetailwhere.length() > 0) {
	dbwhere = dbwhere + "(" + masterdetailwhere + ") AND ";
}
if (searchwhere != null && searchwhere.length() > 0) {
	dbwhere = dbwhere + "(" + searchwhere + ") AND ";
}
if (dbwhere != null && dbwhere.length() > 5) {
	dbwhere = dbwhere.substring(0, dbwhere.length()-5); // Trim rightmost AND
}
%>
<%

// Load Default Order
String DefaultOrder = "";
String DefaultOrderType = "";

// No Default Filter
String DefaultFilter = "";

// Check for an Order parameter
String OrderBy = request.getParameter("order");
if (OrderBy != null && OrderBy.length() > 0) {
	if (session.getAttribute("users_OB") != null && ((String) session.getAttribute("users_OB")).equals(OrderBy)) {
		if (((String) session.getAttribute("users_OT")).equals("ASC")) {
			session.setAttribute("users_OT", "DESC");
		}else{
			session.setAttribute("users_OT", "ASC");
		}
	}else{
		session.setAttribute("users_OT", "ASC");
	}
	session.setAttribute("users_OB", OrderBy);
	session.setAttribute("users_REC", new Integer(1));
}else{
	OrderBy = (String) session.getAttribute("users_OB");
	if (OrderBy == null || OrderBy.length() == 0) {
		OrderBy = DefaultOrder;
		session.setAttribute("users_OB", OrderBy);
		session.setAttribute("users_OT", DefaultOrderType);
	}
}

// Open Connection to the database
try{
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = null;

// Build SQL
String strsql = "SELECT * FROM `" + thisTable + "`";
whereClause = "";
if (DefaultFilter.length() > 0) {
	whereClause = whereClause + "(" + DefaultFilter + ") AND ";
}
if (dbwhere.length() > 0) {
	whereClause = whereClause + "(" + dbwhere + ") AND ";
}
if (whereClause.length() > 5 && whereClause.substring(whereClause.length()-5, whereClause.length()).equals(" AND ")) {
	whereClause = whereClause.substring(0, whereClause.length()-5);
}
if (whereClause.length() > 0) {
	strsql = strsql + " WHERE " + whereClause;
}
if (OrderBy != null && OrderBy.length() > 0) {
	strsql = strsql + " ORDER BY `" + OrderBy + "` " + (String) session.getAttribute("users_OT");
}

rs = stmt.executeQuery(strsql);
rs.last();
totalRecs = rs.getRow();
rs.beforeFirst();
startRec = 0;
int pageno = 0;

// Check for a START parameter
if (request.getParameter("start") != null && Integer.parseInt(request.getParameter("start")) > 0) {
	startRec = Integer.parseInt(request.getParameter("start"));
	session.setAttribute("users_REC", new Integer(startRec));
}else if (request.getParameter("pageno") != null && Integer.parseInt(request.getParameter("pageno")) > 0) {
	pageno = Integer.parseInt(request.getParameter("pageno"));
	if (IsNumeric(request.getParameter("pageno"))) {
		startRec = (pageno-1)*displayRecs+1;
		if (startRec <= 0) {
			startRec = 1;
		}else if (startRec >= ((totalRecs-1)/displayRecs)*displayRecs+1) {
			startRec =  ((totalRecs-1)/displayRecs)*displayRecs+1;
		}
		session.setAttribute("users_REC", new Integer(startRec));
	}else {
		startRec = ((Integer) session.getAttribute("users_REC")).intValue();
		if (startRec <= 0) {
			startRec = 1; // Reset start record counter
			session.setAttribute("users_REC", new Integer(startRec));
		}
	}
}else{
	if (session.getAttribute("users_REC") != null)
		startRec = ((Integer) session.getAttribute("users_REC")).intValue();
	if (startRec==0) {
		startRec = 1; //Reset start record counter
		session.setAttribute("users_REC", new Integer(startRec));
	}
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">TABLE: users</span></p>
<form action="userslist_x.jsp">
<table border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td><span class="jspmaker">Quick Search (*)</span></td>
		<td><span class="jspmaker">
			<input type="text" name="psearch" size="20">
			<input type="Submit" name="Submit" value="GO">
		&nbsp;&nbsp;<a href="userslist_x.jsp?cmd=reset">Show all</a>
		</span></td>
	</tr>
	<tr><td>&nbsp;</td><td><span class="jspmaker"><input type="radio" name="psearchtype" value="" checked>Exact phrase&nbsp;&nbsp;<input type="radio" name="psearchtype" value="AND">All words&nbsp;&nbsp;<input type="radio" name="psearchtype" value="OR">Any word</span></td></tr>
</table>
</form>
<form method="post">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr bgcolor="#594FBF">
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("user_id","UTF-8") %>" style="color: #FFFFFF;">user id&nbsp;<% if (OrderBy != null && OrderBy.equals("user_id")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("user_login","UTF-8") %>" style="color: #FFFFFF;">user login&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("user_login")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("user_password","UTF-8") %>" style="color: #FFFFFF;">user password&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("user_password")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("user_level","UTF-8") %>" style="color: #FFFFFF;">user level&nbsp;<% if (OrderBy != null && OrderBy.equals("user_level")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("name","UTF-8") %>" style="color: #FFFFFF;">name&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("name")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
		<td><span class="jspmaker" style="color: #FFFFFF;">
<a href="userslist_x.jsp?order=<%= java.net.URLEncoder.encode("email","UTF-8") %>" style="color: #FFFFFF;">email&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("email")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("users_OT")).equals("ASC")) {%>5<% }else if (((String) session.getAttribute("users_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</span></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<%

// Avoid starting record > total records
if (startRec > totalRecs) {
	startRec = totalRecs;
}

// Set the last record to display
stopRec = startRec + displayRecs - 1;

// Move to first record directly for performance reason
recCount = startRec - 1;
if (rs.next()) {
	rs.first();
	rs.relative(startRec - 1);
}

long recActual = 0;

if (startRec == 1)
   rs.beforeFirst();
else
   rs.previous();

while (rs.next() && recCount < stopRec) {
	recCount++;
	if (recCount >= startRec) {
		recActual++;
%>
<%
	String bgcolor = "#FFFFFF"; // Set row color
%>
<%
	if (recCount%2 != 0) { // Display alternate color for rows
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

	// Load Key for record
	String key = "";
	key = String.valueOf(rs.getLong("user_id"));
	thisKey = key;

	// user_id
	x_user_id = String.valueOf(rs.getLong("user_id"));

	// user_login
	if (rs.getString("user_login") != null){
		x_user_login = rs.getString("user_login");
	}else{
		x_user_login = "";
	}

	// user_password
	if (rs.getString("user_password") != null){
		x_user_password = rs.getString("user_password");
	}else{
		x_user_password = "";
	}

	// user_level
	x_user_level = String.valueOf(rs.getLong("user_level"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}else{
		x_name = "";
	}

	// email
	if (rs.getString("email") != null){
		x_email = rs.getString("email");
	}else{
		x_email = "";
	}
%>
	<tr bgcolor="<%= bgcolor %>">
		<td><span class="jspmaker"><% out.print(x_user_id); %></span>&nbsp;</td>
		<td><span class="jspmaker"><% out.print(x_user_login); %></span>&nbsp;</td>
		<td><span class="jspmaker"><% out.print(x_user_password); %></span>&nbsp;</td>
		<td><span class="jspmaker"><% out.print(x_user_level); %></span>&nbsp;</td>
		<td><span class="jspmaker"><% out.print(x_name); %></span>&nbsp;</td>
		<td><span class="jspmaker"><% out.print(x_email); %></span>&nbsp;</td>
		<td><span class="jspmaker"><a href="<% key =  thisKey;
if (thisKey != null && thisKey.length() > 0) {
	out.print("usersview.jsp?key=" + java.net.URLEncoder.encode(thisKey,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">View</a></span></td>
<td><span class="jspmaker"><a href="<% key =  thisKey;
if (key != null && key.length() > 0) {
	out.print("usersedit.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Edit</a></span></td>
<td><span class="jspmaker"><a href="<% key =  thisKey;
if (key != null && key.length() > 0) {
	out.print("usersadd.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Copy</a></span></td>
<td><span class="jspmaker"><a href="<% key =  thisKey;
if (key != null && key.length() > 0) {
	out.print("usersdelete.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Delete</a></span></td>
	</tr>
<%

//	}
}
}
%>
</table>
</form>
<%

// Close recordset and connection
rs.close();
rs = null;
stmt.close();
stmt = null;
conn.close();
conn = null;
}catch(SQLException ex){
	out.println(ex.toString());
}
%>
<table border="0" cellspacing="0" cellpadding="10"><tr><td>
<%
boolean rsEof = false;
if (totalRecs > 0) {
	rsEof = (totalRecs < (startRec + displayRecs));
	int PrevStart = startRec - displayRecs;
	if (PrevStart < 1) { PrevStart = 1;}
	int NextStart = startRec + displayRecs;
	if (NextStart > totalRecs) { NextStart = startRec;}
	int LastStart = ((totalRecs-1)/displayRecs)*displayRecs+1;
	%>
<form>
	<table border="0" cellspacing="0" cellpadding="0"><tr><td><span class="jspmaker">Page</span>&nbsp;</td>
<!--first page button-->
	<% if (startRec==1) { %>
	<td><img src="images/firstdisab.gif" alt="First" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="userslist_x.jsp?start=1"><img src="images/first.gif" alt="First" width="20" height="15" border="0"></a></td>
	<% } %>
<!--previous page button-->
	<% if (PrevStart == startRec) { %>
	<td><img src="images/prevdisab.gif" alt="Previous" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="userslist_x.jsp?start=<%=PrevStart%>"><img src="images/prev.gif" alt="Previous" width="20" height="15" border="0"></a></td>
	<% } %>
<!--current page number-->
	<td><input type="text" name="pageno" value="<%=(startRec-1)/displayRecs+1%>" size="4"></td>
<!--next page button-->
	<% if (NextStart == startRec) { %>
	<td><img src="images/nextdisab.gif" alt="Next" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="userslist_x.jsp?start=<%=NextStart%>"><img src="images/next.gif" alt="Next" width="20" height="15" border="0"></a></td>
	<% } %>
<!--last page button-->
	<% if (LastStart == startRec) { %>
	<td><img src="images/lastdisab.gif" alt="Last" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="userslist_x.jsp?start=<%=LastStart%>"><img src="images/last.gif" alt="Last" width="20" height="15" border="0"></a></td>
	<% } %>
	<td><a href="usersadd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a></td>
	<td><span class="jspmaker">&nbsp;of <%=(totalRecs-1)/displayRecs+1%></span></td>
	</td></tr></table>
</form>
	<% if (startRec > totalRecs) { startRec = totalRecs;}
	stopRec = startRec + displayRecs - 1;
	recCount = totalRecs - 1;
	if (rsEof) { recCount = totalRecs;}
	if (stopRec > recCount) { stopRec = recCount;} %>
	<span class="jspmaker">Records <%= startRec %> to <%= stopRec %> of <%= totalRecs %></span>
<% }else{ %>
	<span class="jspmaker">No records found</span>
<p>
<a href="usersadd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a>
</p>
<% } %>
</td></tr></table>
<%@ include file="footer.jsp" %>
