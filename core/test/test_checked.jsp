<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,javax.servlet.*,javax.mail.internet.*"%>

<%
	if (UserDB.checked(conn,"THANHG","LEECC") == false)
		out.println("false");
	else
		out.println("true");
%>