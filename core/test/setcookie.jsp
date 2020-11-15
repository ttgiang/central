<%@ page language="java" import="java.util.*"%>
<%
	Cookie cookie = new Cookie ("CC_User","THANHG");
	cookie.setMaxAge(365 * 24 * 60 * 60);
	response.addCookie(cookie);

	cookie = new Cookie ("CC_Campus","LEECC");
	response.addCookie(cookie);
%>

<html>
<head>
<title>Cookie Saved</title>
</head>
<body>
<p><a href="getcookie.jsp">Next Page to view the cookie value</a><p>

</body>