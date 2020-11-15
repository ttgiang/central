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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";
	String kix = "y31b8h9176";
	int t = 0;

	out.println("Start<br/>");

	try{
		//msg = modifyOutlineAccess(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);
		//out.println(msg.getUserLog());
		//TaskDB.logTask(conn,"THANHG","THANHG",alpha,num,"Modify outline",campus,"","ADD","");
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	public static Msg modifyOutlineAccess(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode) throws SQLException {

		Logger logger = Logger.getLogger("test");

		boolean debug = true;
		int i = 0;
		int rowsAffected = 0;
		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";

		String kixOld = Helper.getKix(conn,campus,alpha,num,"CUR");

		Msg msg = new Msg();
		String[] select;
		StringBuffer userLog = new StringBuffer();

		conn.setAutoCommit(false);

		try {
			String kixNew = SQLUtil.createHistoryID(1);

			PreparedStatement ps = null;

			sql = (Constant.MAIN_TABLES).split(",");
			tempSQL = (Constant.TEMP_TABLES).split(",");

			sqlManual = Constant.MANUAL_TABLES.split(",");
			tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			userLog.append("New: " + kixNew + "<br/>");
			userLog.append("Old: " + kixOld + "<br/><br/>");

			//
			//	delete from temp tables and start clean
			//
			userLog.append("--- DELETE FROM TEMP ---<br/>");
			userLog.append(Outlines.deleteTempOutline(conn,kixOld));

			//
			//	update linked data with references for use to update linked2
			//
			userLog.append("--- Synchronize Refs ---<br/>");
			if (!LinkerDB.synchronizeRefs(conn,campus,kixOld))
				throw new com.ase.exception.CentralException("Error with Synchronize Refs");

			//
			//	insert from production into temp table
			//
			userLog.append("<br/>--- INSERT CUR TO TEMP ---<br/>");
			userLog.append("<ul>");

			tableCounter = totalTables;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ tempSQL[i]
						+ " SELECT * FROM "
						+ sql[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(kixOld + " - CourseModify - modifyOutlineAccess - INSERT1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ tempSQLManual[i]
						+ " SELECT " + select[i] + " FROM "
						+ sqlManual[i]
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(kixOld + " - CourseModify - modifyOutlineAccess - INSERT1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
			userLog.append("</ul>");

			//
			//	update temp with proper settings for modifications
			//
			userLog.append("<br/>--- UPDATE CUR TO PRE IN TEMP ---<br/>");
			userLog.append("<ul>");
			thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',"
				+ "edit0='',edit1='1',edit2='1',"
				+ "proposer=?,historyid=?,jsid=?,assessmentdate=?,coursedate=?,dateproposed=?,"
				+ "votesfor=0,votesagainst=0,votesabstain=0 "
				+ "WHERE historyid=?";
			logger.info(kixNew + " - CourseModify - modifyOutlineAccess - update 1 of 2");
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixNew);
			ps.setString(2,user);
			ps.setString(3,kixNew);
			ps.setString(4,jsid);
			ps.setNull(5,java.sql.Types.VARCHAR);
			ps.setNull(6,java.sql.Types.VARCHAR);
			ps.setString(7,AseUtil.getCurrentDateString());
			ps.setString(8,kixOld);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace(",historyid=?",",historyid='"+kixNew+"'");
			junkSQL = junkSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");

			//
			//	update temp with proper settings for modifications
			//
			thisSQL = "UPDATE tblTempCourseComp SET comments='',approved='',approvedby=null "+
				"WHERE historyid=?";
			logger.info(kixNew + " - CourseModify - modifyOutlineAccess - update 2 of 2");
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,kixNew);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();
			junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			userLog.append("</ul>");

			//
			//	there is a posibility that campus data won't exist. if so, create an entry here
			//
			rowsAffected = modifyOutlineXX(campus,alpha,num,user,kixNew);
			logger.info(kixNew + " - CourseModify - modifyOutlineAccess - update campus - " + rowsAffected + " record");

			//
			//	update temp with new key values
			//
			userLog.append("<br/>--- UPDATE TEMP PRE ---<br/>");
			userLog.append("<ul>");
			tableCounter = totalTables;
			for (i=1; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ tempSQL[i]
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
				logger.info(kixNew + " - CourseModify - modifyOutlineAccess - UPDATE2A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
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
				logger.info(kixNew + " - CourseModify - modifyOutlineAccess - UPDATE2B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
			userLog.append("</ul>");

			//
			//	move temp data into production tables - new id
			//
			userLog.append("<br/>--- INSERT PRE TO ACTIVE TABLE ---<br/>");
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
				logger.info(kixNew + " - CourseModify - modifyOutlineAccess - INSERT2A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
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
				logger.info(kixNew + " - CourseModify - modifyOutlineAccess - INSERT2B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
			userLog.append("</ul>");

			//
			//	delete from temp and clean up - new id
			//
			userLog.append("<br/>--- CLEAN TEMP ---<br/>");
			userLog.append(Outlines.deleteTempOutline(conn,kixOld));
			userLog.append(Outlines.deleteTempOutline(conn,kixNew));

			//
			// create the default SLO entry. If one exists, update with the correct KIX and coursetype
			//
			userLog.append("<br/>--- SLO ---<br/>");
			userLog.append("<ul>");
			if (SLODB.isMatch(conn,campus,alpha,num)){
				thisSQL = "DELETE FROM tblSLO WHERE hid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixOld+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(kixNew + " - CourseModify - modifyOutlineAccess - SLO " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}

			thisSQL = "INSERT INTO tblSLO (campus,coursealpha,coursenum,coursetype,auditby,progress,hid) VALUES (?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,"PRE");
			ps.setString(5,user);
			ps.setString(6,"MODIFY");
			ps.setString(7,kixNew);
			rowsAffected = ps.executeUpdate();
			logger.info(kixNew + " - CourseModify: modifyOutlineAccess - SLO created - " + rowsAffected + " row");
			junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
			userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
			userLog.append("</ul>");

			ps.close();

			//
			//	sync up linked with linked2
			//
			userLog.append("--- Synchronize Linked Items ---<br/>");
			if (!LinkerDB.synchronizeLinkedItems(conn,campus,kixNew))
				throw new com.ase.exception.CentralException("Error with Synchronizing Linked Items");

			conn.commit();

			AseUtil.loggerInfo("CourseModify: modifyOutlineAccess ",campus,user,alpha,num);
		} catch (com.ase.exception.CentralException ce){
			conn.rollback();
			userLog.append(ce.toString() + "<br/>Rolling back transactions.");
			logger.fatal("CourseModify: modifyOutlineAccess (ex) - "
				+ ce.toString()
				+ ". Rolling back transactions.");
			msg.setMsg("Exception");
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			conn.rollback();
			userLog.append(ex.toString() + "<br/>");
			logger.fatal("CourseModify: modifyOutlineAccess (ex) - " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			userLog.append(e.toString() + "<br/>");
			logger.fatal("CourseModify: modifyOutlineAccess (e) - " + e.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
			} catch (SQLException exp) {
				userLog.append(exp.toString() + "<br/>");
				logger.fatal("CourseModify: modifyOutlineAccess (exp) - " + exp.toString() + "\n");
				msg.setMsg("Exception");
			}
		}

		conn.setAutoCommit(true);

		if (debug)
			msg.setUserLog(userLog.toString());
		else
			msg.setUserLog("");

		return msg;
	}

	public static int modifyOutlineXX(String campus,
													String alpha,
													String num,
													String user,
													String historyID) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String thisSQL = "";

		AsePool asePool = AsePool.getInstance();
		Connection conn = asePool.getConnection();

		try{
			/*
				add only if not there
			*/
			if (	!CampusDB.courseExistByCampus(conn,campus,alpha,num,"PRE") &&
					!CampusDB.courseExistByCampus(conn,campus,alpha,num,"CUR") ) {

				thisSQL = "INSERT INTO tblTempCampusData(historyid,CourseAlpha,CourseNum,auditby,campus) VALUES(?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(thisSQL);
				ps.setString(1,historyID);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,user);
				ps.setString(5,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();

			}
		}
		catch(SQLException se){
			logger.fatal("CourseModify: modifyOutlineXX\n" + se.toString());
			rowsAffected = -1;
		}
		catch(Exception e){
			logger.fatal("CourseModify: modifyOutlineXX\n" + e.toString());
			rowsAffected = -1;
		} finally {
			asePool.freeConnection(conn);
		}

		return rowsAffected;
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

