<%@ page language="java"  %>
<%
String cookieName = "CC_User";
Cookie cookies[] = request.getCookies();
Cookie myCookie = null;

if (cookies != null){
	for (int i = 0; i < cookies.length; i++){
		myCookie = cookies[i];
		out.println( myCookie.getValue() + "<br>");
	}
}
%>
<html>
<head>
<title>Show Saved Cookie</title>
</head>
<body>
