<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.mail.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String alpha = "ICS";
	String num = "100D";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "i36i12i9240";
	int t = 0;

	out.println("Start<br/>");
	//out.println(setCourseForDelete(conn,"o9v22b92072170",user));
	//out.println(cancelOutlineDelete(conn,"k42i12i9216",user));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!
	/*
	 * cancelOutlineDelete
	 * <p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelOutlineDelete(Connection conn,String kix,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		StringBuffer userLog = new StringBuffer();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = NumericUtil.nullToZero(info[6]);

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String[] select = null;

		String thisSQL = "";
		String junkSQL = "";

		int tableCounter = 0;
		int totalTables = 0;
		int totalTablesManual = 0;
		int rowsAffected = 0;
		int i = 0;

		PreparedStatement ps;

		/*
			cancelling approval takes the following steps:

			1) Make sure it's in the correct progress and isCourseDeleteCancellable
			2) update the course record
			3) send notification to all
			4) clear history
		*/

		logger.info("-----------------------------------------------------------------");
		logger.info(kix + " - CourseDB - cancelOutlineDelete - start");

		try{
			msg = CourseDB.isCourseDeleteCancellable(conn,campus,alpha,num,user);
			if (msg.getResult()){
				/*
				*	delete from temp tables PRE or CUR ids and start clean
				*/
				userLog.append("--- DELETE FROM TEMP ---<br/>");
				userLog.append(Outlines.deleteTempOutline(conn,kix));

				sql = Constant.MAIN_TABLES.split(",");
				tempSQL = Constant.TEMP_TABLES.split(",");
				totalTables = sql.length;

				sqlManual = Constant.MANUAL_TABLES.split(",");
				tempSQLManual = Constant.MANUAL_TEMP_TABLES.split(",");
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				/*
				*	delete from other tables
				*/
				userLog.append("<br/>--- DELETE MAIN ---<br/>");
				userLog.append("<ul>");
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM "
							+ sql[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(kix + " - CourseDB - cancelOutlineDelete - DELETE1 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM "
							+ sqlManual[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(kix + " - CourseDB - cancelOutlineDelete - DELETE2 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
				userLog.append("</ul>");

				/*
				*	delete history
				*/
				userLog.append("<br/>--- DELETE HISTORY ---<br/>");
				userLog.append("<ul>");
				sql[0] = "tblApprovalHist";
				sql[1] = "tblApprovalHist2";
				sql[2] = "tblReviewHist";
				sql[3] = "tblReviewHist2";
				tableCounter = 4;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "DELETE FROM "
							+ sql[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kix);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					junkSQL = thisSQL.replace("WHERE historyid=?","WHERE historyid='"+kix+"'");
					userLog.append("<li>(" + rowsAffected + ") " + junkSQL + "</li>");
					logger.info(kix + " - CourseDB - cancelOutlineDelete - DELETE3 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " rows");
				}
				userLog.append("</ul>");

				// delete task for proposer and also the approvals created
				userLog.append("<br/>--- DELETE TASK ---<br/>");
				userLog.append("<ul>");
				userLog.append("<li>(" + rowsAffected + ") Task Removed</li>");
				userLog.append("</ul>");
				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.DELETE_TEXT,campus,"","REMOVE","PRE");
				rowsAffected = rowsAffected + TaskDB.logTask(conn,"ALL",user,alpha,num,Constant.APPROVAL_TEXT,campus,"","REMOVE","PRE");
				logger.info(kix + " - CourseDB - cancelOutlineDelete - Task removed - " + rowsAffected + " rows");

				msg.setUserLog(userLog.toString());

			}
			else{
				msg.setMsg("OutlineNotInDeleteStatus");
				logger.info("CourseDB: cancelOutlineDelete - OutlineNotInDeleteStatus.");
			}
		}
		catch(Exception e){
			logger.fatal(kix + " - CourseDB - cancelOutlineDelete - " + e.toString());
		}

		logger.info(kix + " - CourseDB - cancelOutlineDelete - end");
		logger.info("-----------------------------------------------------------------");

		return msg;
	}

	/*
	 * setCourseForDelete
	 * <p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg setCourseForDelete(Connection conn,String kix,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = NumericUtil.nullToZero(info[6]);

		String message = "";
		String sURL = "";
		String temp = "";
		int rowsAffected = 0;

		/*
			there can only be a single outline and it has to be in APPROVED status before deleting.
			if OK to delete,
				1) use code from modifyOutlineAccess to place outline in PRE status
				2) obtain the KIX of the outline just placed in modify status
				3) create task
				5) kick of approval process processing
		*/

		logger.info("----------------------------------------");
		logger.info("setCourseForDelete - START");

		if (CourseDB.countSimilarOutlines(conn,campus,alpha,num)>1){
			msg.setMsg("NotAllowToDelete");
			logger.info("CourseDelete: setCourseForDelete - Attempting to delete outline failed (" + user + ").");
		}
		else{
			msg = CourseModify.modifyOutlineAccess(conn,campus,alpha,num,user,Constant.COURSE_DELETE_TEXT);
			if (!"Exception".equals(msg.getMsg())){

				// kix of outline to work with
				kix = Helper.getKix(conn,campus,alpha,num,"PRE");
				logger.info("setCourseForDelete - kix - " + kix);

				// create task for user
				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.DELETE_TEXT,campus,"","ADD","PRE");
				logger.info("setCourseForDelete - task created - " + rowsAffected + " row");

				// notify approval to begin
				msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_DELETE_TEXT,route);
				logger.info("setCourseForDelete - setCourseForApproval - route: " + route);
				logger.info("setCourseForDelete - setCourseForApproval - msg: " + msg);
			}	// if exception
		}	// if countSimilarOutlines

		logger.info("setCourseForDelete - END");
		logger.info("----------------------------------------");

		return msg;
	}

%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

