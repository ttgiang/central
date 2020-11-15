<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Data Conversion";
	fieldsetTitle = "Data Conversion";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	prod - use this to process any data adjustment in prod during upgrades
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	System.out.println("Start<br/>");

	if (processPage){

		// use this to process any data adjustment in prod during upgrades
		out.println(reviewersTable(conn,"course") + Html.BR());
		out.println(reviewersTable(conn,"programs") + Html.BR());
		out.println(modifyCourseSchema(conn) + Html.BR());
		out.println(modifyMisc(conn) + Html.BR());

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * modifyCourseSchema - add more columns to tblcourse
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String modifyCourseSchema(Connection conn){

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			// we check first before running
			String sql = "select count(id) as counter from cccm6100 where CCCM6100 like 'UserDefinedControl_%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				rowsAffected = rs.getInt("counter");

				if(rowsAffected == 0){

					ps.close();

					sql = "insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, "
							+ "Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext) "
							+ "values('SYS', 'Course', ?, ?, ?, 0, 0, 'wysiwyg', NULL, NULL, 'User defined control', NULL, NULL, 'N', NULL, NULL, NULL, NULL)";

					for(int i=111; i<131; i++){
						String control = "X"+i;
						ps = conn.prepareStatement(sql);
						ps.setInt(1,i);
						ps.setString(2,"UserDefinedControl_"+control);
						ps.setString(3,control);
						rowsAffected += ps.executeUpdate();
						ps.close();
					} // i
				}
				else{
					rowsAffected = 0;
				}
			}
			rs.close();

		}
		catch(SQLException e){
			logger.fatal("prod - modifyCourseSchema: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("prod - modifyCourseSchema: " + e.toString());
		}

		return "modifyCourseSchema: " + rowsAffected + " rows processed";

	}

	/*
	 * reviewersTable - set reviewer table with proper levels and progress
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String reviewersTable(Connection conn,String table){

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			table = "tbl" + table;

			String sql = "select distinct r.historyid,c.reviewdate from tblreviewers r join "+table+" c on r.historyid=c.historyid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String historyid = rs.getString("historyid");
				String reviewdate = rs.getString("reviewdate");
				sql = "update tblReviewers set level=1,progress='REVIEW',duedate=? where historyid=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,reviewdate);
				ps2.setString(2,historyid);

				rowsAffected += ps2.executeUpdate();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("prod - reviewersTable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("prod - reviewersTable: " + e.toString());
		}

		return "reviewersTable: " + rowsAffected + " rows processed for " + table;

	}

	/*
	 * modifyMisc - set edited1 and 2 to edit1 and edit2
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String modifyMisc(Connection conn){

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "SELECT id, campus, historyid, edit1, edit2, edited1, edited2 FROM tblMisc "
				+ "WHERE (NOT (edit1 IS NULL)) AND (NOT (edit2 IS NULL))";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String edit1 = AseUtil.nullToBlank(rs.getString("edit1"));
				String edit2 = AseUtil.nullToBlank(rs.getString("edit2"));

				sql = "update tblmisc set edited1=?,edited2=? WHERE campus=? AND historyid=? AND id=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,edit1);
				ps2.setString(2,edit2);
				ps2.setString(3,campus);
				ps2.setString(4,historyid);
				ps2.setInt(5,id);

				rowsAffected += ps2.executeUpdate();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("prod - modifyMisc: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("prod - modifyMisc: " + e.toString());
		}

		return "modifyMisc: " + rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>