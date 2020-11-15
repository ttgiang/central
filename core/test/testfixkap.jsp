<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "MAU";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	out.println("Start<br/>");
	//out.println("fix linked2..." + fix01(conn) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	fix01 - fill linked2 with historyid from linked
	*/
	public static int fix01(Connection conn){

		Logger logger = Logger.getLogger("test");

		int i = 0;
		int id= 0;
		int rowsAffected = 0;
		String historyid= "";
		String auditby = "";
		int seq = 0;

		try{
			String sql = "SELECT historyid,seq,id,auditby "
				+ "FROM tblCourseLinked "
				+ "WHERE campus='KAP'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				seq = rs.getInt("seq");
				historyid = rs.getString("historyid");
				auditby = rs.getString("auditby");
				sql = "UPDATE tblCourseLinked2 "
					+ "SET historyid=?,auditby=? "
					+ "WHERE id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,historyid);
				ps.setString(2,auditby);
				ps.setInt(3,id);
				rowsAffected = ps.executeUpdate();
			}
			rs.close();
			ps.close();

			sql = "DELETE FROM tblCourseLinked2 "
				+ "WHERE historyid is null";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
		}
		catch(SQLException sx){
			logger.fatal("fix01: fix01 - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fix01: fix01 - " + ex.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

