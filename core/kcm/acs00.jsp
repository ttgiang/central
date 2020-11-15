<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>

<%
	//
	// our retrieval routine strips off .JS
	//
	session.setAttribute("redirectOnLogin","kcm/acs01_dot_jsp");
%>

<%@ include file="../ase.jsp" %>

<%
	String sql = "";

	int rowsAffected = 0;

	PreparedStatement ps = null;

	ResultSet rs = null;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>
