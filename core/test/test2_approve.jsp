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
	String kix = "112b10g9193";
	int t = 0;

	out.println("Start<br/>");

	try{
		//out.println(Outlines.countTableItems(conn,kix));
		//msg = approveOutlineAccess(conn,campus,alpha,num,user);
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

	public static Msg approveOutlineAccess(Connection conn,
														String campus,
														String alpha,
														String num,
														String user) throws Exception {

		int LAST_APPROVER 	= 2;
		int ERROR_CODE 		= 3;

		Logger logger = Logger.getLogger("test");

		boolean debug = false;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int i = 0;

		Msg msg = new Msg();
		PreparedStatement ps;

		int tblTempCourseACCJC = 0;
		int tblTempCourseCompetency = 1;
		int tblCourseLinked = 2;
		int tblGESLO = 3;

		String[] select;
		select = new String[4];
		select[tblTempCourseACCJC] = "Campus,CourseAlpha,CourseNum,CourseType,ContentID,CompID,Assessmentid,ApprovedDate,AssessedDate,AssessedBy,AuditDate,auditby,historyid";
		select[tblTempCourseCompetency] = "historyid,campus,coursealpha,coursenum,coursetype,content,auditdate,auditby,rdr";
		select[tblCourseLinked] = "campus,historyid,src,seq,dst,coursetype,auditdate,auditby";
		select[tblGESLO] = "campus,historyid,geid,slolevel,sloevals,auditby,auditdate,coursetype";

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String manual = "tblCourseACCJC,tblCourseCompetency,tblCourseLinked,tblGESLO";
		String tempManual = "tblTempCourseACCJC,tblTempCourseCompetency,tblTempCourseLinked,tblTempGESLO";

		String thisSQL = "";
		String currentDate = AseUtil.getCurrentDateString();
		String kixARC = SQLUtil.createHistoryID(1);
		String kixPRE = Helper.getKix(conn,campus,alpha,num,"PRE");
		String kixCUR = Helper.getKix(conn,campus,alpha,num,"CUR");
		String reviewDate = DateUtility.calculateReviewDate(conn,campus,TermsDB.getOutlineTerm(conn,kixPRE));

		StringBuffer userLog = new StringBuffer();

		/*
			 to make a proposed course to current, do the following
			 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			 2) make a copy of the CUR course in temp table (insertToTemp)
			 3) update key fields and prep for archive (updateTemp)
			 4) put the temp record in courseARC table for use (insertToCourseARC)
			 5) delete the current course from tblCourse
			 6) change the PRE course in current course to CUR
			 7) clean up the temp table (deleteFromTemp)
			 8) move current approval history to log table
			 9) clear current approval history
		*/

		sql = Constant.MAIN_TABLES.split(",");
		tempSQL = Constant.TEMP_TABLES.split(",");
		totalTables = sql.length;

		sqlManual = manual.split(",");
		tempSQLManual = tempManual.split(",");
		totalTablesManual = sqlManual.length;

		conn.setAutoCommit(false);

		userLog.append("kixARC: " + kixARC + "<br/>");
		userLog.append("kixCUR: " + kixCUR + "<br/>");
		userLog.append("kixPRE: " + kixPRE + "<br/><br/>");

		try {
			/*
			*	delete from temp tables PRE or CUR ids and start clean
			*/
			userLog.append("--- DELETE FROM TEMP ---<br/>");
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE historyid=? OR historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixPRE);
				ps.setString(2,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixPRE+"'");
				thisSQL = thisSQL.replace("OR historyid=?","OR historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE historyid=? OR historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixPRE);
				ps.setString(2,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixPRE+"'");
				thisSQL = thisSQL.replace("OR historyid=?","OR historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			/*
			*	insert from production into temp table (CUR to become ARC)
			*/
			userLog.append("<br/>--- INSERT CUR TO TEMP ---<br/>");
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ tempSQL[i]
						+ " SELECT * FROM "
						+ sql[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixCUR," - CourseModify - approveOutlineAccess - INSERT ",0,0,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ tempSQLManual[i]
						+ " SELECT " + select[i] + " FROM "
						+ sqlManual[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixCUR," - CourseModify - approveOutlineAccess - INSERT ",0,0,rowsAffected,thisSQL,true);
			}

			/*
			*	update temp data prior to inserting into archived tables (kixCUR is now kixARC)
			*/
			userLog.append("<br/>--- UPDATE CUR TO ARC IN TEMP ---<br/>");
			thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=?,historyid=? "
				+ "WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,user);
			ps.setString(2,currentDate);
			ps.setString(3,kixARC);
			ps.setString(4,kixCUR);
			thisSQL = thisSQL.replace(",historyid=?",",historyid='"+kixARC+"'");
			thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
			thisSQL = showProgress(thisSQL,kixARC,kixCUR);
			userLog.append(thisSQL+"<br/>");
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			logIt(kixARC," - CourseApproval - approveOutlineAccess - update2 - ",(i+1),tableCounter,rowsAffected,thisSQL,true);

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQL[i]
						+ " SET coursetype='ARC',auditdate=?,historyid=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, currentDate);
				ps.setString(2, kixARC);
				ps.setString(3, kixCUR);
				thisSQL = thisSQL.replace(",historyid=?",",historyid='"+kixARC+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				thisSQL = showProgress(thisSQL,kixARC,kixCUR);
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseApproval - approveOutlineAccess - update3a ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQLManual[i]
						+ " SET coursetype='ARC',auditdate=?,historyid=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, currentDate);
				ps.setString(2, kixARC);
				ps.setString(3, kixCUR);
				thisSQL = thisSQL.replace(",historyid=?",",historyid='"+kixARC+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				thisSQL = showProgress(thisSQL,kixARC,kixCUR);
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseApproval - approveOutlineAccess - update3b ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			}

			/*
			* insert data from temp into archived tables
			*/
			userLog.append("<br/>--- MOVE TEMP ARC TO ARCHIVE ---<br/>");
			sql[0] = "tblCourseARC";
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ tempSQL[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixARC);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseModify - approveOutlineAccess - INSERT ",0,0,rowsAffected,thisSQL,true);
			}
			sql[0] = "tblCourse";

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sqlManual[i]
						+ " SELECT " + select[i] + " FROM "
						+ tempSQLManual[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixARC);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseModify - approveOutlineAccess - INSERT ",0,0,rowsAffected,thisSQL,true);
			}

			/*
			* delete the current table data before moving from temp back to it
			*/
			userLog.append("<br/>--- INSERT CUR FROM ACTIVE ---<br/>");
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i] + " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + sqlManual[i] + " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixCUR);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixCUR+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			/*
			* set the modified data to current
			*/
			userLog.append("<br/>--- UPDATE PRE TO CUR ---<br/>");
			thisSQL = "UPDATE tblCourse " +
				"SET coursetype='CUR',progress='APPROVED',edit1='',edit2='',coursedate=?,auditdate=?,proposer=?,reviewdate=? " +
				"WHERE historyid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,currentDate);
			ps.setString(2,currentDate);
			ps.setString(3,user);
			ps.setString(4,reviewDate);
			ps.setString(5,kixPRE);
			thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixPRE+"'");
			thisSQL = showProgress(thisSQL,kixPRE,kixPRE);
			userLog.append(thisSQL+"<br/>");
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			logIt(kixPRE," - CourseApproval - approveOutlineAccess - update4 - ",(i+1),tableCounter,rowsAffected,thisSQL,true);

			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='CUR',auditdate=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,currentDate);
				ps.setString(2,kixPRE);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixPRE+"'");
				thisSQL = showProgress(thisSQL,kixPRE,kixPRE);
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseApproval - approveOutlineAccess - update5a ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sqlManual[i]
						+ " SET coursetype='CUR',auditdate=? WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,currentDate);
				ps.setString(2,kixPRE);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixPRE+"'");
				thisSQL = showProgress(thisSQL,kixPRE,kixPRE);
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseApproval - approveOutlineAccess - update5b ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			}

			/*
			*	clean up temp tables
			*/
			userLog.append("<br/>--- CLEAN TEMP ---<br/>");
			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + tempSQL[i] + " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixARC);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + tempSQLManual[i] + " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixARC);
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				thisSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixARC+"'");
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixARC," - CourseModify - approveOutlineAccess - DELETE ",0,0,rowsAffected,thisSQL,true);
			}

			// update history table
			tableCounter = 2;
			sql[0] = "INSERT INTO tblApprovalHist2 (id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments, approver_seq ) "
					+ "SELECT tba.id, tba.historyid, '"
					+ currentDate
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments, tba.approver_seq "
					+ "FROM tblApprovalHist tba "
					+ "WHERE campus=? AND "
					+ "CourseAlpha=? AND " + "CourseNum=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";

			for (i=0; i<tableCounter; i++) {
				thisSQL = sql[i];
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				thisSQL = showProgress(thisSQL,kixARC,kixARC);
				userLog.append(thisSQL+"<br/>");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				logIt(kixPRE," - CourseModify - HISTORY ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			}

			// if an outline was in PRE status during SLO work, make sure the SLO coursetype follows the
			// outline to CUR
			thisSQL = "UPDATE tblSLO SET coursetype='CUR',auditby=?,auditdate=? WHERE hid=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,user);
			ps.setString(2,AseUtil.getCurrentDateString());
			ps.setString(3,kixPRE);
			thisSQL = showProgress(thisSQL,kixPRE,kixPRE);
			userLog.append(thisSQL+"<br/>");
			rowsAffected = ps.executeUpdate();
			logIt(kixCUR," - CourseModify - HISTORY ",(i+1),tableCounter,rowsAffected,thisSQL,true);
			ps.close();

			conn.commit();
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			userLog.append("SQLException: " + ex.toString()+"<br/>");
			logger.fatal(user + " - CourseApproval: approveOutlineAccess\n" + ex.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);
			msg.setErrorLog("Exception");
			conn.rollback();
			logger.info(kixPRE + " - " + user + "- CourseApproval: approveOutlineAccess - Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			userLog.append("Exception: " + e.toString()+"<br/>");
			logger.fatal(user + " - CourseApproval: approveOutlineAccess\n" + e.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);

			try {
				conn.rollback();
				logger.info(kixPRE + " - " + user + "- CourseApproval: approveOutlineAccess - Rolling back transaction");
			} catch (SQLException exp) {
				userLog.append("SQLException: " + exp.toString()+"<br/>");
				msg.setCode(ERROR_CODE);
				logger.fatal(user + " - CourseApproval: approveOutlineAccess\n" + exp.toString());
				msg.setMsg("Exception");
				msg.setErrorLog("Exception");
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
