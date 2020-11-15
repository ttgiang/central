<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "SPOPE";
	String task = "Modify_outline";
	String kix = "d17j24i101951595";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			out.println(CourseCopy.copyOutline(conn,campus,"K40j23i92523199","K40j23i92523199","ICS","169",user,"comments"));
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static Msg copyOutlineX(Connection connection,
												String campus,
												String fromAlpha,
												String fromNum,
												String toAlpha,
												String toNum,
												String user,
												String comments) throws Exception {

Logger logger = Logger.getLogger("test");

		// here, campus is the campus of the user copying the outline

		Msg msg = new Msg();

		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";
		String temp = "";

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		String[] select;

		String currentDate = AseUtil.getCurrentDateString();

		Connection conn = null;
		conn = AsePool.createLongConnection();

		// kix was sent in as fromAlpha as a substitute to avoid having to make the foot print
		// to much longer. kix is used to recall type.
		String kix = "";
		String[] info = null;
		String fromCampus = "";
		String type = "";
		String kixOld = "";
		String kixNew = "";

		boolean debug = false;

		logger.info("-------------- CourseCopy - START");

		try {
			conn = AsePool.createLongConnection();

			// permit copy at all times with debug on
			debug = true;

			kix = fromAlpha;
			info = Helper.getKixInfo(conn,kix);
			fromAlpha = info[Constant.KIX_ALPHA];
			fromNum = info[Constant.KIX_NUM];
			fromCampus = info[Constant.KIX_CAMPUS];
			type = info[Constant.KIX_TYPE];

			kixOld = kix;
			kixNew = SQLUtil.createHistoryID(1);

			if (debug) logger.info("user: " + user);
			if (debug) logger.info("kixOld - " + kixOld);
			if (debug) logger.info("kixNew - " + kixNew);
			if (debug) logger.info("fromCampus/toCampus: " + fromCampus + "/" + campus);
			if (debug) logger.info("fromAlpha/fromNum: " + fromAlpha + "/" + fromNum);
			if (debug) logger.info("toAlpha/toNum: " + toAlpha + "/" + toNum);

			// similar to modifying outline.

			// to prepage for copy of an approved course, the following is necessary
			// 0) make sure the course doesn't already exist in the main table (both CUR and PRE)
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for edits (updateTemp)
			// 4) put the temp record in course table for use (insertToCourse)

			if (	!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "PRE") &&
					!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "CUR")) {

				// do not copy campus data. just need to make empty shell
				sql = "tblCourse,tblCampusData,tblCoreq,tblCourseCompAss,tblPreReq,tblXRef,tblCourseContentSLO,tblExtra".split(",");
				tempSQL = "tblTempCourse,tblTempCampusData,tblTempCoreq,tblTempCourseCompAss,tblTempPreReq,tblTempXRef,tblTempCourseContentSLO,tblTempExtra".split(",");

				sqlManual = "tblCourseACCJC".split(",");
				tempSQLManual = "tblTempCourseACCJC".split(",");

				totalTables = sql.length;
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				Outlines.deleteTempOutline(conn,kixOld);
				if (debug) logger.info("deleteTempOutline completed");

				Outlines.insertIntoTemp(conn,kixOld);
				if (debug) logger.info("insertIntoTemp completed");

				/*
				 * update temp data (course)
				 */
				String reason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br/>"
									+ "Copied from " + fromAlpha + " " + fromNum
									+ "<br/><br/>" + comments;

				thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1', "
					+ " proposer=?,historyid=?,dateproposed=?,auditdate=NULL,reviewdate=NULL,assessmentdate=NULL,coursedate=NULL, "
					+ " coursealpha=?,coursenum=?,campus=?,"+Constant.COURSE_REASON+"=? "
					+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, kixNew);
				ps.setString(2, user);
				ps.setString(3, kixNew);
				ps.setString(4, currentDate);
				ps.setString(5, toAlpha);
				ps.setString(6, toNum);
				ps.setString(7, campus);
				ps.setString(8, reason);
				ps.setString(9, kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("updated temp table - " + rowsAffected + " row");

				/*
					campus data is handled below
				*/
				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					temp = tempSQL[i].toLowerCase();
					if (temp.indexOf("campusdata") == -1){
						thisSQL = "UPDATE "
								+ tempSQL[i]
								+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=?,campus=? "
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1, kixNew);
						ps.setString(2, currentDate);
						ps.setString(3, toAlpha);
						ps.setString(4, toNum);
						ps.setString(5, campus);
						ps.setString(6, kixOld);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("UPDATE1C " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
					}
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQLManual[i]
							+ " SET historyid=?,coursetype='PRE',campus=?,auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					ps.setString(2,campus);
					ps.setString(3,AseUtil.getCurrentDateTimeString());
					ps.setString(4,kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info(kixOld + " - Outlines - updateTempOutlineType: UPDATE1D " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}

				/*
				 * insert to prod
				 */
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					temp = tempSQL[i].toLowerCase();
					if (temp.indexOf("campusdata") == -1){
						thisSQL = "INSERT INTO "
								+ sql[i]
								+ " SELECT * FROM "
								+ tempSQL[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("INSERT1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
					}
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
					if (debug) logger.info("INSERT1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				ps.close();

				//
				//	if copying from to same campus, allow copy of campus data. If not, just create empty shell
				//
				if (!CampusDB.courseExistByCampus(conn,campus,toAlpha,toNum,"PRE")) {
					if (campus.equals(fromCampus)){
						thisSQL = "UPDATE tblTempCampusData "
								+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=?,campus=? "
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						ps.setString(2,currentDate);
						ps.setString(3,toAlpha);
						ps.setString(4,toNum);
						ps.setString(5,campus);
						ps.setString(6,kixOld);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();

						thisSQL = "INSERT INTO tblCampusData "
								+ " SELECT * FROM tblTempCampusData "
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("updated temp campus data - " + rowsAffected + " row");
					}
					else{
						thisSQL = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,CourseType,auditby,campus) VALUES(?,?,?,?,?,?)";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						ps.setString(2,toAlpha);
						ps.setString(3,toNum);
						ps.setString(4,"PRE");
						ps.setString(5,user);
						ps.setString(6,campus);
						rowsAffected = ps.executeUpdate();
						ps.close();
						if (debug) logger.info("updated temp campus data - " + rowsAffected + " row");
					}

				} // if (!CampusDB.courseExistByCampus(conn,campus,toAlpha,toNum,"PRE")) {

				/*
				 * copyLinkedTables
				 */
				rowsAffected = LinkedUtil.copyLinkedTables(conn,kixOld,kixNew,toAlpha,toNum,user);
				if (debug) logger.info("copyLinkedTables - " + rowsAffected + " row");

				/*
				 * update outline campus
				 */
				CampusDB.updateCampusOutline(conn,kixNew,campus);
				if (debug) logger.info("updateCampusOutline completed - " + kixNew);

				/*
				 * delete temp
				 */
				Outlines.deleteTempOutline(conn,kixNew);
				if (debug) logger.info("deleteTempOutline completed");

				/*
				 * SLO
				 */
				rowsAffected = SLODB.insertSLO(conn,campus,toAlpha,toNum,user,"MODIFY",kixNew);
				if (debug) logger.info("SLO - " + rowsAffected + " row");

				msg.setKix(kixNew);

			} else {
				msg.setMsg("NotAllowToCopyOutline");
			} // if valid course type

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseCopy: copyOutlineX -"
								+ " kixOld: " + kixOld
								+ " kixNew: " + kixNew
								+ " Exception: " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");

			logger.fatal(user + " - CourseCopy: copyOutlineX - " + CourseCopy.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
					if (debug) logger.info("connection released");
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}
		}

		logger.info("-------------- CourseCopy - END");

		return msg;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>