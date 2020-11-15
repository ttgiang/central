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
	String task = "Modify_outline";
	String kix = "m55i18g94";
	int t = 0;

	kix = helper.getKix(conn,campus,alpha,num,"PRE");

	out.println("Start<br/>");

	try{
		//out.println(Outlines.countTableItems(conn,kix));
		//msg = cancelOutlineAccess(conn,campus,alpha,num,user);
		//out.println(msg.getUserLog());
		//TaskDB.logTask(conn,"THANHG","THANHG",alpha,num,"Modify outline",campus,"","REMOVE","");
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	public static Msg cancelOutlineAccess(Connection conn,
												String campus,
												String alpha,
												String num,
												String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		boolean debug = true;

		Msg msg = new Msg();
		String[] sql = new String[15];
		String[] tempSQL = new String[15];
		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select;
		StringBuffer userLog = new StringBuffer();

		String thisSQL = "";
		String junkSQL = "";
		String kix = "";
		String kixCAN = SQLUtil.createHistoryID(1);;

		conn.setAutoCommit(false);

		try {
			kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			userLog.append("kixPRE: " + kix + "<br/>");
			userLog.append("kixCAN: " + kixCAN + "<br/>");

			PreparedStatement ps = null;

			/*
			*	update PRE data as CAN
			*/
			userLog.append("<br/>--- INSERT PRE TO CAN ---<br/>");
			userLog.append("<ul>");
			thisSQL = "INSERT INTO tblCourseCAN "
					+ " SELECT * FROM tblCourse "
					+ " WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");

			thisSQL = "UPDATE tblCourseCAN "
				+ "SET historyid=?,coursetype='CAN',progress='CANCELLED',coursedate=?,proposer=? "
				+ "WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixCAN);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,user);
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixCAN+"'");
			junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			userLog.append("</ul>");

			userLog.append("<br/>--- DELETE CUR ---<br/>");
			userLog.append("<ul>");
			thisSQL = "DELETE FROM tblCourse "
					+ " WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET historyid=?,coursetype='CAN',auditdate=?,auditby=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCAN);
				ps.setString(2,AseUtil.getCurrentDateString());
				ps.setString(3,user);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixCAN+"'");
				junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sqlManual[i]
						+ " SET historyid=?,coursetype='CAN',auditdate=?,auditby=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCAN);
				ps.setString(2,AseUtil.getCurrentDateString());
				ps.setString(3,user);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixCAN+"'");
				junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			}
			userLog.append("</ul>");

			userLog.append("<br/>--- INSERT HISTORY ---<br/>");
			userLog.append("<ul>");
			tableCounter = 4;
			sql[0] = "INSERT INTO tblApprovalHist2 (id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments ) "
					+ "SELECT tba.id, tba.historyid, '"
					+ AseUtil.getCurrentDateString()
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments FROM tblApprovalHist tba WHERE historyid=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE historyid=?";
			sql[2] = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE historyid=?";
			sql[3] = "DELETE FROM tblReviewHist WHERE historyid=?";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = sql[i];
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			}
			userLog.append("</ul>");

			////////// TODO: TTG
			// when cancelling, delete the SLO entry in progress
			thisSQL = "DELETE FROM tblSLO WHERE hid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			logger.info(kix + " - CourseCancel - cancelOutlineAccess - delete SLO entry " + " - " + rowsAffected + " row");
			ps.close();

			conn.commit();

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(kix + " - CourseCancel: cancelOutlineAccess\n" + ex.toString());
			userLog.append(ex.toString() + "<br/>");
			msg.setMsg("Exception");
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(kix + " - CourseCancel: cancelOutlineAccess\n" + e.toString());
			userLog.append(e.toString() + "<br/>");
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				msg.setMsg("Exception");
				logger.fatal(kix + " - CourseCancel: cancelOutlineAccess\n" + exp.toString());
				userLog.append(exp.toString() + "<br/>");
			}
		}

		conn.setAutoCommit(true);

		if (debug)
			msg.setUserLog(userLog.toString());
		else
			msg.setUserLog("");

		return msg;
	}

	/*
	 * logIt
	 * <p>
	 * @param	kix				String
	 * @param	message			String
	 * @param	counter			int
	 * @param	tableCounter	int
	 * @param	rowsAffected	int
	 * @param	sql				String
	 */
	public static void logIt(	String kix,
										String message,
										int counter,
										int tableCounter,
										int rowsAffected,
										String sql,
										boolean logIt) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean logging = true;

		String log = "";

		if (logIt)
			log = kix + message + (counter+1) + " of " + tableCounter + " - " + rowsAffected + " row";
		else
			log = sql;

		if (logging)
			logger.info(log);
		else
			System.out.println(log);
	}

	/*
	 * showProgress
	 * <p>
	 * @param	sql			String
	 * @param	kix			String
	 * @param	historyID	String
	 */
	public static String showProgress(String sql,String kix,String historyID) {

		Logger logger = Logger.getLogger("test");

		try{
			sql = sql.replace("SET historyid=?","SET historyid='" + historyID + "'");
			sql = sql.replace("WHERE historyid=?","WHERE historyid='" + kix + "'");
			sql = sql.replace("OR historyid=?","OR historyid='" + kix + "'");
			sql = sql.replace("hid=?","hid='" + kix + "'");

			if (sql.indexOf("id=?")>0)
				sql = sql.replace("SET id=?","SET id='" + historyID + "'");

			if (sql.indexOf("proposer=?")>0)
				sql = sql.replace("proposer=?","proposer='THANHG'");

			if (sql.indexOf("auditby=?")>0)
				sql = sql.replace("auditby=?","auditby='THANHG'");

			if (sql.indexOf("jsid=?")>0)
				sql = sql.replace("jsid=?","jsid='THANHG'");

			if (sql.indexOf("assessmentdate=?")>0)
				sql = sql.replace("assessmentdate=?","assessmentdate='"+AseUtil.getCurrentDateTimeString()+"'");

			if (sql.indexOf("coursedate=?")>0)
				sql = sql.replace("coursedate=?","coursedate='"+AseUtil.getCurrentDateTimeString()+"'");

			if (sql.indexOf("dateproposed=?")>0)
				sql = sql.replace("dateproposed=?","dateproposed='"+AseUtil.getCurrentDateTimeString()+"'");

			if (sql.indexOf("auditdate=?")>0)
				sql = sql.replace("auditdate=?","auditdate='"+AseUtil.getCurrentDateTimeString()+"'");

			if (sql.indexOf("reviewdate=?")>0)
				sql = sql.replace("reviewdate=?","reviewdate='"+AseUtil.getCurrentDateTimeString()+"'");

			if (sql.indexOf("campus=?")>0)
				sql = sql.replace("campus=?","campus='KAP'");

			if (sql.indexOf("CourseAlpha=?")>0)
				sql = sql.replace("CourseAlpha=?","CourseAlpha='ICS'");

			if (sql.indexOf("CourseNum=?")>0)
				sql = sql.replace("CourseNum=?","CourseNum='100'");

			if (sql.indexOf("coursealpha=?")>0)
				sql = sql.replace("coursealpha=?","coursealpha='ICS'");

			if (sql.indexOf("coursenum=?")>0)
				sql = sql.replace("coursenum=?","coursenum='100'");
		}
		catch(Exception e){
			logger.fatal("showProgress - " + e.toString());
		}

		return sql;
	}

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
