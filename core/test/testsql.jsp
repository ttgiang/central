<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "ICS";
	String num = "241";
	String type = "CUR";
	String sql = "";
	String campus = (String)session.getAttribute("aseCampus");

	out.println(SQLUtil.verifySQL(conn,"AseQueriesAccess.properties",out));
	asePool.freeConnection(conn);
%>
