<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*
	* 	submittedfor and submittedby should not be the same value unless it is the proposer
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(Html.BR() + process1(conn));
			out.println(Html.BR() + process2(conn));
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!
	/*
	 * process
	 *	<p>
	 *	<p>
	 */
	public static String process1(Connection conn) throws SQLException {

Logger logger = Logger.getLogger("test");

		int recordsRead = 0;
		int recordsProcessed = 0;

		logger.info("------------------ process START");

		try {
			String sql = "";

			sql = "SELECT  t.id ,t.campus, t.submittedfor, t.submittedby, c.proposer, t.coursealpha, t.coursenum, c.historyid "
				+ "FROM tblTasks t, tblCourse c "
				+ "WHERE t.campus = c.campus "
				+ "AND t.coursealpha = c.CourseAlpha "
				+ "AND t.coursenum = c.CourseNum "
				+ "AND t.submittedfor=t.submittedby";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				++recordsRead;

				int id = rs.getInt("id");
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String submittedfor = AseUtil.nullToBlank(rs.getString("submittedfor"));
				String submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				if (!proposer.equals(submittedfor) && proposer != null){
					sql = "UPDATE tbltasks SET submittedby=? WHERE campus=? AND id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,proposer);
					ps2.setString(2,campus);
					ps2.setInt(3,id);
					recordsProcessed += ps2.executeUpdate();
					ps2.close();
					logger.info("Course task entry changed submittedby from " + submittedfor + " to " + proposer);
				} // proposer
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TestRun: process1 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TestRun: process1 - " + e.toString());
		}

		logger.info("Course: read " + recordsRead + " and processed " + recordsProcessed + " records");
		logger.info("------------------ process END");

		return "Course: read " + recordsRead + " and processed " + recordsProcessed + " records";
	}

	/*
	 * process
	 *	<p>
	 *	<p>
	 */
	public static String process2(Connection conn) throws SQLException {

Logger logger = Logger.getLogger("test");

		int recordsRead = 0;
		int recordsProcessed = 0;

		logger.info("------------------ process START");

		try {
			String sql = "";

			sql = "SELECT t.id, t.campus, t.submittedby, t.submittedfor, c.proposer, c.historyid "
				+ "FROM tblTasks t INNER JOIN "
				+ "tblPrograms c ON t.campus = c.campus AND t.historyid = c.historyid ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				++recordsRead;

				int id = rs.getInt("id");
				String submittedfor = AseUtil.nullToBlank(rs.getString("submittedfor"));
				String submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				if (submittedby == null || submittedby.length() == 0){
					sql = "UPDATE tbltasks SET submittedby=? WHERE campus=? AND id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,proposer);
					ps2.setString(2,campus);
					ps2.setInt(3,id);
					recordsProcessed += ps2.executeUpdate();
					ps2.close();
					logger.info("Program task entry changed submittedby from " + submittedfor + " to " + proposer);
				} // proposer
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TestRun: process2 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TestRun: process2 - " + e.toString());
		}

		logger.info("Programs: read " + recordsRead + " and processed " + recordsProcessed + " records");
		logger.info("------------------ process END");

		return "Programs: read " + recordsRead + " and processed " + recordsProcessed + " records";
	}
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>