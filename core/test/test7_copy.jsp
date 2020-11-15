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

	kix = helper.getKix(conn,campus,alpha,num,"CUR");

	out.println("Start<br/>");

	try{
		//out.println(Outlines.countTableItems(conn,kix));
		//msg = copyOutlineAccess(conn,campus,"ICS","100","ICS","117",user);
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
	public static Msg copyOutlineAccess(Connection conn,
													String campus,
													String fromAlpha,String fromNum,
													String toAlpha, String toNum,
													String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		int tblTempCourseACCJC = 0;
		int tblTempCourseCompetency = 1;
		int tblCourseLinked = 2;
		int tblGESLO = 3;
		String[] select;

		StringBuffer userLog = new StringBuffer();

		String currentDate = AseUtil.getCurrentDateString();

		String kixOld = Helper.getKix(conn,campus,fromAlpha,fromNum,"CUR");
		String kixNew = SQLUtil.createHistoryID(1);

		boolean debug = false;

		conn.setAutoCommit(false);

		try {
			// similar to modifying outline.

			// to prepage for copy of an approved course, the following is necessary
			// 0) make sure the course doesn't already exist in the main table (both CUR and PRE)
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for edits (updateTemp)
			// 4) put the temp record in course table for use (insertToCourse)

			if (	!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "PRE") &&
					!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "CUR")) {

				sql = Constant.MAIN_TABLES.split(",");
				tempSQL = Constant.TEMP_TABLES.split(",");

				sqlManual = Constant.MANUAL_TABLES.split(",");
				tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

				totalTables = sql.length;
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				userLog.append("<br/>Old: " + kixOld + "<br/>");
				userLog.append("New: " + kixNew + "<br/><br/>");

				conn.setAutoCommit(false);

				userLog.append("--- DELETE FROM TEMP ---<br/>");
				userLog.append(Outlines.deleteTempOutline(conn,kixOld));

				userLog.append("--- INSERT TO TEMP ---<br/>");
				userLog.append(Outlines.insertIntoTemp(conn,kixOld));

				//----------------------------------------
				// update temp data
				//----------------------------------------
				userLog.append("--- UPDATE TEMP ---<br/>");
				userLog.append("<ul>");
				String reason = "Copied from " + fromAlpha + " " + fromNum;
				thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1', "
					+ " proposer=?,historyid=?,dateproposed=?,auditdate=NULL,reviewdate=NULL,assessmentdate=NULL,coursedate=NULL, "
					+ " coursealpha=?,coursenum=?,reason=? "
					+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, kixNew);
				ps.setString(2, user);
				ps.setString(3, kixNew);
				ps.setString(4, currentDate);
				ps.setString(5, toAlpha);
				ps.setString(6, toNum);
				ps.setString(7, reason);
				ps.setString(8, kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(user + " - CourseCopy - copyOutlineAccess - UPDATE1 - " + rowsAffected + " row");

				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQL[i]
							+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=? "
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1, kixNew);
					ps.setString(2, currentDate);
					ps.setString(3, toAlpha);
					ps.setString(4, toNum);
					ps.setString(5, kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixNew+"'");
					junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(user + " - CourseCopy - copyOutlineAccess - UPDATE1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQLManual[i]
							+ " SET historyid=?,coursetype='PRE',auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					ps.setString(2,AseUtil.getCurrentDateString());
					ps.setString(3,kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("SET historyid=?","SET historyid='"+kixNew+"'");
					junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(kixOld + " - Outlines - updateTempOutlineType: UPDATE1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				userLog.append("</ul>");

				//----------------------------------------
				// insert to prod
				//----------------------------------------
				userLog.append("--- INSERT TO PROD ---<br/>");
				userLog.append("<ul>");
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sql[i]
							+ " SELECT * FROM "
							+ tempSQL[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(user + " - CourseCopy - copyOutlineAccess - INSERT1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sqlManual[i]
							+ " SELECT " + select[i] + " FROM "
							+ tempSQLManual[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(user + " - CourseCopy - copyOutlineAccess - INSERT1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				userLog.append("</ul>");
				ps.close();

				//----------------------------------------
				// delete temp
				//----------------------------------------
				userLog.append("--- DELETE FROM TEMP ---<br/>");
				userLog.append(Outlines.deleteTempOutline(conn,kixNew));

				//----------------------------------------
				// SLO
				//----------------------------------------
				rowsAffected = SLODB.insertSLO(conn,campus,toAlpha,toNum,user,"MODIFY",kixNew);
				logger.info(user + " - CourseCopy - copyOutlineAccess - SLO - " + rowsAffected + " row");

				conn.commit();

				conn.setAutoCommit(true);
			} else {
				msg.setMsg("NotAllowToCopyOutline");
			}
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			userLog.append("rolling back - " + ex.toString() + "<br/>");
			logger.fatal(user + " - CourseCopy: copyOutline - " + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
			logger.info(user + " - CourseCopy: copyOutline - Rolling back transaction");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");

			try {
				conn.rollback();
				userLog.append("rolling back - " + CourseCopy.toString() + "<br/>");
				logger.info(user + " - CourseCopy: copyOutline - Rolling back transaction");
			} catch (SQLException exp) {
				userLog.append(exp.toString() + "<br/>");
				logger.fatal(user + " - CourseCopy: copyOutline - " + exp.toString());
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
	 * @param	kixNew	String
	 */
	public static String showProgress(String sql,String kix,String kixNew) {

		Logger logger = Logger.getLogger("test");

		try{
			sql = sql.replace("SET historyid=?","SET kixNew='" + kixNew + "'");
			sql = sql.replace("WHERE historyid=?","WHERE kixNew='" + kix + "'");
			sql = sql.replace("OR historyid=?","OR kixNew='" + kix + "'");
			sql = sql.replace("hid=?","hid='" + kix + "'");

			if (sql.indexOf("id=?")>0)
				sql = sql.replace("SET id=?","SET id='" + kixNew + "'");

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
