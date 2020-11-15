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
	*	testfix29.jsp - fill in #29 for KAP
   *
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
	}

	out.println("Start<br/>");
	out.println(processItem(conn) + " <br/>");
	out.println(processItem2(conn) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**	processItem
	*/
	public static String processItem(Connection conn){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// add historyid to reviewer table

		try{
			String sql = "SELECT DISTINCT campus,coursealpha,coursenum FROM tblReviewers";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String campus = rs.getString("campus");
				String alpha = rs.getString("coursealpha");
				String num = rs.getString("coursenum");
				String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
				System.out.println(kix);
				sql = "UPDATE tblReviewers SET historyid=? WHERE campus=? AND coursealpha=? AND coursenum=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.setString(2,campus);
				ps2.setString(3,alpha);
				ps2.setString(4,num);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

				logger.info("updated " + rowsAffected + " rows for " + kix);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return "done";
	}

	/*
	**	processItem
	*/
	public static String processItem2(Connection conn){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// set coursenum for task table

		try{
			String sql = "SELECT campus, coursealpha, historyid FROM tblTasks WHERE coursenum='' OR coursenum is null";

			sql = "SELECT t.campus, t.historyid, v.divisioncode "
				+ "FROM tblTasks t INNER JOIN "
				+ "vw_ProgramForViewing v ON t.historyid = v.historyid AND t.campus = v.campus "
				+ "WHERE t.coursenum='' OR t.coursenum IS NULL ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String campus = rs.getString("campus");
				String kix = rs.getString("historyid");
				String divisioncode = rs.getString("divisioncode");

				System.out.println(kix);
				sql = "UPDATE tblTasks SET coursenum=? WHERE campus=? AND historyid=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,divisioncode);
				ps2.setString(2,campus);
				ps2.setString(3,kix);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

				logger.info("updated " + rowsAffected + " rows for " + kix);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processItem: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processItem: " + ex.toString());
		}

		return "done";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

