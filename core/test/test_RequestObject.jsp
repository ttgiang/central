<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,javax.servlet.*,javax.mail.internet.*"%>

<%
	out.println("getContextPath: " +  request.getContextPath() + "<br>");
	out.println("getRequestURI: " + request.getRequestURI() + "<br>");
	out.println("getServletPath: " + request.getServletPath() + "<br>");
	out.println("getRequestURL: " + request.getRequestURL() + "<br>");

	StringBuffer buf = request.getRequestURL();
	String url = buf.toString();

	if (url.lastIndexOf("/") > 0){
		out.println("url: " + url + "<br>");
		int pos = url.lastIndexOf("/");
		url = url.substring(0,pos+1);
		out.println("url: " + url + "<br>");
	}
%>