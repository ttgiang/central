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
	*	testfixdups.jsp
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	out.println("Start<br/>");
	//out.println(process01(conn,"LEE"));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**
	**
	*/
	public static int process01(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String historyid = "";
		String alpha = "";
		String num = "";

		// read all the dups
		try{
			String sql = "SELECT coursealpha,coursenum "
				+ "FROM zz_Duplicates "
				+ "WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				process02(conn,campus,alpha,num);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("process: process01 - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("process: process01 - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	**
	**
	*/
	public static int process02(Connection conn,String campus,String alpha,String num){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String historyid = "";

		// take the dups and find in tblCourse2. If not found, delete
		try{
			String sql = "SELECT historyid "
				+ "FROM tblCourse "
				+ "WHERE campus=? "
				+ "AND coursealpha=? "
				+ "AND coursenum=? "
				+ "AND coursetype=? "
				+ "AND progress=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,"CUR");
			ps.setString(5,"APPROVED");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				process03(conn,historyid,campus,alpha,num);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("process: process02 - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("process: process02 - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	**
	**
	*/
	public static int process03(Connection conn,String historyid,String campus,String alpha,String num){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// take the dups and find in tblCourse2. If not found, delete
		try{
			String sql = "SELECT historyid "
				+ "FROM tblCourse2 "
				+ "WHERE campus=? "
				+ "AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,historyid);
			ResultSet rs = ps.executeQuery();
			if (!rs.next()) {
				process04(conn,historyid,campus,alpha,num);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("process: process03 - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("process: process03 - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	**
	**
	*/
	public static int process04(Connection conn,String historyid,String campus,String alpha,String num){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// take the dups and find in tblCourse2. If not found, delete
		try{
			String sql = "DELETE FROM tblCourse "
				+ "WHERE campus=? "
				+ "AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,historyid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "DELETE FROM tblCampusData "
				+ "WHERE campus=? "
				+ "AND historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,historyid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			logger.info(campus + " - " + alpha + " - " + num + " - " + historyid);
		}
		catch(SQLException sx){
			logger.fatal("process: process04 - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("process: process04 - " + ex.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

