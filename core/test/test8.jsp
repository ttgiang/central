<%@ page import="org.apache.log4j.Logger"%>
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

	String campus = "KAP";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100";
	String type = "CUR";
	String task = "Modify_outline";
	String kix = "m55i18g94";
	int t = 0;

	kix = helper.getKix(conn,campus,alpha,num,"CUR");

	out.println("Start<br/>");

	try{
		//out.println(Outlines.countTableItems(conn,kix));
		//msg = deleteOutlineAccess(conn,campus,alpha,num,type,user);
		//out.println(msg.getUserLog());
		//TaskDB.logTask(conn,"THANHG","THANHG","ICS","109","Modify outline",campus,"","ADD","");
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	public static Msg deleteOutlineAccess(Connection conn,
														String campus,
														String alpha,
														String num,
														String type,
														String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String[] sql = new String[20];
		String[] sqlManual = new String[20];
		String[] select;

		String thisSQL = "";
		String junkSQL = "";

		String kix = "";

		int rowsAffected = 0;

		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		StringBuffer userLog = new StringBuffer();

		boolean debug = true;

		PreparedStatement ps = null;

		try{
			kix = Helper.getKix(conn,campus,alpha,num,type);

			sql = Constant.MAIN_TABLES.split(",");
			sqlManual = Constant.MANUAL_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			conn.setAutoCommit(false);

			userLog.append("<br/>Kix: " + kix + "<br/>");

			userLog.append("--- DELETE FROM TEMP ---<br/>");
			userLog.append(Outlines.deleteTempOutline(conn,kix));

			userLog.append("--- DELETE FROM HISTORY ---<br/>");
			userLog.append("<ul>");
			thisSQL = "DELETE FROM tblApprovalHist2 WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			//rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			logger.info(user + " - CourseDelete - deleteOutline - approval history - " + rowsAffected + " row");
			userLog.append("</ul>");

			userLog.append("--- DELETE FROM REVIEW ---<br/>");
			userLog.append("<ul>");
			thisSQL = "DELETE FROM tblReviewHist2 WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			//rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			logger.info(user + " - CourseDelete - deleteOutline - review history - " + rowsAffected + " row");
			userLog.append("</ul>");

			// when cancelling, delete the SLO entry in progress
			thisSQL = "DELETE FROM tblSLO WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			//rowsAffected = ps.executeUpdate();
			logger.info(user + " - CourseCancel - deleteOutline - delete SLO entry " + " - " + rowsAffected + " row");

			ps.close();

			conn.commit();
		} // try
		catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			userLog.append("rolling back - " + ex.toString() + "<br/>");
			logger.fatal(user + " - CourseDelete: deleteOutline\n" + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
			logger.info(user + " - CourseDelete: deleteOutline- Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.info(user + " - CourseDelete: deleteOutline\n" + e.toString());
			userLog.append("Exception - " + e.toString() + "<br/>");
			msg.setMsg("Exception");

			try {
				conn.rollback();
				userLog.append("rolling back - " + e.toString() + "<br/>");
				logger.info(user + " - CourseDelete: deleteOutline - Rolling back transaction");
			} catch (SQLException exp) {
				userLog.append("SQLException - " + exp.toString() + "<br/>");
				logger.fatal(user + " - CourseDelete: deleteOutline - Rolling back error\n" + exp.toString());
			}
		} finally {
			conn.setAutoCommit(true);
		}

		if (debug)
			msg.setUserLog(userLog.toString());
		else
			msg.setUserLog("");

		return msg;
	}
%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
