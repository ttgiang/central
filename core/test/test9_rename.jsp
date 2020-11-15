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
		//msg = renameOutlineAccess(conn,campus,"ICS","100","ICS","199",user);
		//out.println(msg.getUserLog());
		//TaskDB.logTask(conn,"THANHG","THANHG","ICS","199","Modify outline",campus,"","ADD","");
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!

	public static Msg renameOutlineAccess(Connection conn,
											String campus,
											String fromAlpha,
											String fromNum,
											String toAlpha,
											String toNum,
											String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		Msg msg = new Msg();
		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] sqlManual = new String[20];
		String[] select;

		String thisSQL = "";
		String junkSQL = "";

		String kixOld = Helper.getKix(conn,campus,fromAlpha,fromNum,"CUR");
		String kixNew = SQLUtil.createHistoryID(1);

		StringBuffer userLog = new StringBuffer();

		boolean debug = true;

		conn.setAutoCommit(false);

		try {
			userLog.append("<br/>Old: " + kixOld + "<br/>");
			userLog.append("New: " + kixNew + "<br/><br/>");

			sql = Constant.MAIN_TABLES.split(",");
			sqlManual = Constant.MANUAL_TABLES.split(",");

			totalTables = sql.length;
			totalTablesManual = sqlManual.length;

			select = Outlines.getTempTableSelects();

			tableCounter = totalTables;
			userLog.append("--- UPDATE ---<br/>");
			userLog.append("<ul>");
			for (i=0; i<tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursealpha=?,coursenum=?,historyid=? "
						+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,toAlpha);
				ps.setString(2,toNum);
				ps.setString(3,kixNew);
				ps.setString(4,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(user + " - CourseRename - renameOutlineAccess (" + kixNew + ") - " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}

			tableCounter = totalTablesManual;
			for (i=0; i<tableCounter; i++) {
				if (select[i].indexOf("coursealpha")!=-1){
					thisSQL = "UPDATE "
							+ sqlManual[i]
							+ " SET coursealpha=?,coursenum=?,historyid=? "
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,toAlpha);
					ps.setString(2,toNum);
					ps.setString(3,kixNew);
					ps.setString(4,kixOld);
				}
				else{
					thisSQL = "UPDATE "
							+ sqlManual[i]
							+ " SET historyid=? "
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					ps.setString(2,kixOld);

				}
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kixNew+"'");
				userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
				logger.info(user + " - CourseRename - renameOutlineAccess (" + kixNew + ") - " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
			}
			userLog.append("</ul>");

			thisSQL = "UPDATE tblSLO "
					+ " SET coursealpha=?,coursenum=?,hid=? "
					+ " WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, toAlpha);
			ps.setString(2, toNum);
			ps.setString(3, kixNew);
			ps.setString(4, campus);
			ps.setString(5, fromAlpha);
			ps.setString(6, fromNum);
			rowsAffected = ps.executeUpdate();
			logger.info(user + " - CourseRename - renameOutlineAccess - SLO - " + rowsAffected + " row");

			ps.close();

			conn.commit();
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseRename: renameOutlineAccess\n" + ex.toString());
			userLog.append("SQLException - " + ex.toString() + "<br/>");
			msg.setMsg("Exception");
			conn.rollback();
			logger.info(user + " - CourseRename: renameOutlineAccess - Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");

			try {
				conn.rollback();
				userLog.append("rolling back - " + e.toString() + "<br/>");
				logger.info(user + " - CourseRename: renameOutlineAccess - Rolling back transaction\n" + e.toString());
			} catch (SQLException exp) {
				userLog.append("SQLException - " + exp.toString() + "<br/>");
				logger.fatal(user + " - CourseRename: renameOutlineAccess\n" + exp.toString());
			}
		}

		conn.setAutoCommit(true);

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
