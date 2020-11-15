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
	*	testfixhil.jsp -
	*
	*	2010.01.10	moving x18 (SLO) to X18/C22 (reason for mod)
	*	2009.12.21	moving coursetitle to banner title
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	Logger logger = Logger.getLogger("test");

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	out.println("Start<br/>");

	int rowsAffected = 0;
	String historyid = "";
	String fromItem = "";

	int counter = 1;

	try{
		/*

			SELECT     historyid, X18, X18/C22
			FROM         tblCourse
			WHERE     (campus = 'HIL') AND (X18 IS NOT NULL)
			ORDER BY CourseAlpha, CourseNum

		*/

		if (processPage){
			System.out.println("-----------------------" + AseUtil.getCurrentDateString());
			PreparedStatement ps2 = null;
			String sql = "SELECT historyid, X18 "
				+ "FROM tblcourse "
				+ "WHERE campus='HIL' AND (X18 IS NOT NULL) "
				+ "ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				fromItem = AseUtil.nullToBlank(rs.getString("X18"));
				sql = "UPDATE tblcampusdata SET C22=? WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,fromItem);
				ps2.setString(2,historyid);
				rowsAffected = ps2.executeUpdate();
				ps2.close();
				logger.info(counter + ": " + historyid);
				++counter;
			}
			rs.close();
			ps.close();
		}
	}
	catch(SQLException sx){
		System.out.println("fix - " + sx.toString());
	} catch(Exception ex){
		System.out.println("fix - " + ex.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"testfixhil","SYSADM");
%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

