<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	testids.jsp
	*	2007.09.01	fix ids
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String column = "auditby";
	String tab = "tblSLO";
	String order = "id";
	String usr = "";
	String fullname = "";
	String wrongName = "";

	out.println("Start<br>");

	String sql = "SELECT " + column + " FROM " + tab + " ORDER BY " + order;
	PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	while (rs.next()){
		wrongName = rs.getString(1);
		usr = wrongName.replace(".", " ");
		fullname = "fullname='"+usr.trim()+"'";
		usr = aseUtil.lookUp(conn,"tblUsers","userid",fullname);
		if ("".equals(usr))
			out.println(fullname + " - " + usr + "<br>");
		else{
			sql = "UPDATE " + tab + " SET " + column + "=?" + " WHERE " + column + "=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,usr);
			ps.setString(2,wrongName);
			int rowsAffected = ps.executeUpdate();
			out.println(rowsAffected+"<br>");
		}
	}
	rs.close();
	ps.close();

	out.println("End<br>");

	asePool.freeConnection(conn);


	/*
LIONGSON

MNESTER

FSTANTON (missing lastname)

MOMI

ASAILIM

NMUSIC (NORMADEENE MUSICK)

BOULOS (DANIEL BOULOS)

	*/
%>
