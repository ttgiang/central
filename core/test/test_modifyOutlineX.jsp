<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnmy.jsp
	*	2007.09.01
	**/

	//org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(CourseDB.class.getName());

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		return;
	}

	Logger logger = Logger.getLogger("test");

	String user = (String)session.getAttribute("aseUserName");
	String campus = (String)session.getAttribute("aseCampus");

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String fromAlpha = "ICS";
	String fromNum = "116";
	String toAlpha = "ICS";
	String toNum = "115";
	String message = "";

	String alpha = "ICS";
	String num = "212";

	/*
	msg = modifyOutline(conn,campus,alpha,num,user,session.getId());
	if ( "Exception".equals(msg.getMsg()) ){
		message = "Course modification failed.<br><br>" + msg.getErrorLog();
	}
	else if ( !"".equals(msg.getMsg()) ){
		message = "Unable to complete operation.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
	}
	else{
		message = "Request completed successfully.<br>";
	}

	logger.info(message);
	*/

	String reason = "";
	int edt = 1;

	if (edt==1)
		reason = courseDB.getCourseReason(conn,campus,alpha,num,"PRE");

	out.println("<form method=\"post\" name=\"aseForm\" action=\"/central/servlet/sng\">" );
	out.println("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
	out.println("<tr><td class=\"textblackTH\">Comments (provide comments concerning this modifications):</td></tr>");
	out.println("<tr><td><textarea name=\"comments\" cols=\"100\" rows=\"5\" class=\"input\">" + reason + "</textarea></td></tr>");
	out.println("</table>");
	out.println(showFields(conn,campus,alpha,num,"index",edt));
	out.println("</form>" );

	asePool.freeConnection(conn);
%>

<%!
	public static String showFields(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int edt) throws SQLException {

	Logger logger = Logger.getLogger("test");


		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String hiddenFieldCampus = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		int fieldCountCampus = 0;
		Question question;
		int i = 0;

		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		String thisEdit = null;

		try{
			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">\n" );
			buf.append("<tr bgcolor=\"#e1e1e1\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>\n");

			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			if (list != null){

totalItems = list.size();

// initialize
checked = new String[totalItems];
for (i=0; i<list.size(); i++){
	checked[i] = "";
}

/*
	edt is available when we are coming back in to enable additional fields

	edit1-2 contains a single value of '1' indiciating that all fields are editable.
	however, during the modification/approval process, edit1-2 may contain CSV
	due to rejection or reasons for why editing is needed

	when the value is a single '1', we set up for all check marks ON.

	when there are multiple values (more than a '1' or a comma is there), we
	set up for ON/OFF.
*/
if (edt==1){
	edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");
	if (!"".equals(edits[1])){
		thisEdit = edits[1];
		if ("1".equals(thisEdit)){
			for (i=0; i<totalItems; i++){
				checked[i] = "checked";
			}
		}
		else{
			checkMarks = thisEdit.split(",");
			for (i=0; i<totalItems; i++){
				if ("1".equals(checkMarks[i]))
					checked[i] = "checked";
			}
		}
	}
}

				for (i=0; i<totalItems; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Course_" + cQuestionNumber;

					if ( hiddenFieldSystem.length() == 0 )
						hiddenFieldSystem = cQuestionNumber;
					else
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;

					++fieldCountSystem;

					temp = "<tr><td valign=top align=\"right\">" + cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top>" + cQuestion + "</td></tr>\n";

					buf.append( temp );
				}	// for
			}	// if

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><hr size=\"1\"></td></tr>\n");

			list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			if (list != null){
				totalItems = list.size();

checked = new String[totalItems];
for (i=0; i<list.size(); i++){
	checked[i] = "";
}

if (edt==1){
	edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");
	if (!"".equals(edits[2])){
		thisEdit = edits[2];
		if ("1".equals(thisEdit)){
			for (i=0; i<totalItems; i++){
				checked[i] = "checked";
			}
		}
		else{
			checkMarks = thisEdit.split(",");
			for (i=0; i<totalItems; i++){
				if ("1".equals(checkMarks[i]))
					checked[i] = "checked";
			}
		}
	}
}
				for (i=0; i<totalItems; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Campus_" + cQuestionNumber;

					if ( hiddenFieldCampus.length() == 0 )
						hiddenFieldCampus = cQuestionNumber;
					else
						hiddenFieldCampus = hiddenFieldCampus +"," + cQuestionNumber;

					++fieldCountCampus;

					temp = "<tr><td valign=top align=\"right\">" + cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top>" +  cQuestion + "</td></tr>\n";

					buf.append( temp );
				}	// for
			}	// if

			buf.append("<tr>" );
			buf.append("<td class=\"textblackTHRight\" colspan=\"3\"><hr size=\"1\">\n" );
			buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;\n");
			buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">\n" );
			buf.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">\n" );
			buf.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">\n" );
			buf.append("<input type=\"hidden\" name=\"alpha\" value=\"" + alpha + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"num\" value=\"" + num + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\"\n>" );
			buf.append("<input type=\"hidden\" name=\"edt\" value=\"" + edt + "\"\n>" );
			buf.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"fieldCountCampus\" value=\"" + fieldCountCampus + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldCampus\" value=\"" + hiddenFieldCampus + "\">\n" );
			buf.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">\n" );
			buf.append("</td>" );
			buf.append("</tr>" );
			buf.append( "</table>" );
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: showFields\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("QuestionDB: showFields\n" + ex.toString());
		}

		return buf.toString();
	}

	/*
	 * getCourseReason
	 *	<p>
	 *	@return String
	 */
	public static String getCourseReason(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {


	Logger logger = Logger.getLogger("test");
		String reason = "";

		try {
			String query = "SELECT reason FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				reason = results.getString(1);
			}
			results.close();
			ps.close();
			AseUtil.loggerInfo("CourseDB: getCourseReason ",campus,type,alpha,num);
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseReason\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseReason\n" + ex.toString());
		}

		return reason;
	}

	/*
	 * Initialize key fields for approved core outline modifications <p> @return
	 * Msg
	 */
	public static Msg modifyOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String jsid) throws SQLException {

		/*
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * for modification of an approved outline, the outline must not exists
		 * in PRE and must exist as CUR
		 *
		 * make sure they are modifying what is in their discipline
		 */
		boolean debug = true;

	Logger logger = Logger.getLogger("test");

		if (debug) logger.info("-----------------------------------------------------------------");

		Msg msg = new Msg();
		if (!CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "PRE")
				&& CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "CUR")) {
			if (alpha.equals(UserDB.getUserDepartment(conn, user))) {
				msg = modifyOutlineX(conn,campus,alpha,num,user,jsid,debug);
			} else {
				msg.setMsg("NotAuthorizeToModify");
			}
		} else {
			msg.setMsg("NotEditable");
			logger.fatal("CourseDB: modifyOutline\nAttempting to edit outline that is not editable.");
		}

		if (debug) logger.info("-----------------------------------------------------------------");

		return msg;
	}

	public static Msg modifyOutlineX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String jsid,
												boolean debug) throws SQLException {

		int rowsAffected = 0;
		int tableCounter = 0;
		int stepCounter = 0;
		int i = 0;
		int steps = 28;

	Logger logger = Logger.getLogger("test");

		String[] sql = new String[20];
		String thisSQL = "";
		Msg msg = new Msg();

		AsePool asePool = AsePool.getInstance();
		Connection connection = asePool.getConnection();

		connection.setAutoCommit(false);

		try {
			PreparedStatement ps = null;

			tableCounter = 7;
			stepCounter = 0;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoReq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";
			for (i=0; i<tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
				if (debug) logger.info("CourseDB - modifyOutlineX - DELETE " + (i+1) + " of " + tableCounter);
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
			}

			tableCounter = 7;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoReq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";

			sql[10] = "tblCourse";
			sql[11] = "tblCampusData";
			sql[12] = "tblCoReq";
			sql[13] = "tblPreReq";
			sql[14] = "tblCourseComp";
			sql[15] = "tblCourseContent";
			sql[16] = "tblCourseCompAss";
			for (i=0; i<tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
				if (debug) logger.info("CourseDB - modifyOutlineX - insert " + (i+1) + " of " + tableCounter);
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,"CUR");
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
			}

			String historyID = SQLUtil.createHistoryID(1);
			thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',"+
				"proposer=?,historyid=?,jsid=?,reviewdate=?,assessmentdate=?,coursedate=?,dateproposed=? "+
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			if (debug) logger.info("CourseDB - modifyOutlineX - update 1 of 1");
			ps = connection.prepareStatement(thisSQL);
			ps.setString(1,historyID);
			ps.setString(2,user);
			ps.setString(3,historyID);
			ps.setString(4,jsid);
			ps.setNull(5,java.sql.Types.VARCHAR);
			ps.setNull(6,java.sql.Types.VARCHAR);
			ps.setNull(7,java.sql.Types.VARCHAR);
			ps.setString(8,AseUtil.getCurrentDateString());
			ps.setString(9,campus);
			ps.setString(10,alpha);
			ps.setString(11,num);
			rowsAffected = ps.executeUpdate();
			ps.clearParameters();

			/*
				there is a posibility that campus data won't exist. if so, create an entry here
			*/
			rowsAffected = modifyOutlineXX(conn,campus,alpha,num,user,historyID);
			if (debug) logger.info("CourseDB - modifyOutlineX - update 1 of 1");

			tableCounter = 6;
			sql[0] = "tblTempCoReq";
			sql[1] = "tblTempPreReq";
			sql[2] = "tblTempCourseComp";
			sql[3] = "tblTempCourseContent";
			sql[4] = "tblTempCampusData";
			sql[5] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET historyid=?,coursetype='PRE',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
				if (debug) logger.info("CourseDB - modifyOutlineX - update " + (i+1) + " of " + tableCounter);
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,historyID);
				ps.setString(2,AseUtil.getCurrentDateString());
				ps.setString(3,campus);
				ps.setString(4,alpha);
				ps.setString(5,num);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
			}

			tableCounter = 7;
			sql[0] = "tblCourse";
			sql[1] = "tblCampusData";
			sql[2] = "tblCoReq";
			sql[3] = "tblPreReq";
			sql[4] = "tblCourseComp";
			sql[5] = "tblCourseContent";
			sql[6] = "tblCourseCompAss";

			sql[10] = "tblTempCourse";
			sql[11] = "tblTempCampusData";
			sql[12] = "tblTempCoReq";
			sql[13] = "tblTempPreReq";
			sql[14] = "tblTempCourseComp";
			sql[15] = "tblTempCourseContent";
			sql[16] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				if (debug) logger.info("CourseDB - modifyOutlineX - insert " + (i+1) + " of " + tableCounter);
				ps = connection.prepareStatement(thisSQL);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
			}

			ps.close();

			connection.commit();
			connection.close();

			AseUtil.loggerInfo("CourseDB: modifyOutlineX ",campus,user,alpha,num);

			rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Modify outline",campus,"crsedt.jsp","ADD");

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseDB: modifyOutlineX\n" + ex.toString());
			if (debug) logger.fatal("CourseDB - modifyOutlineX - insert " + ex.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
			conn.rollback();
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("CourseDB: modifyOutlineX\n" + e.toString());

			try {
				conn.rollback();
			} catch (SQLException exp) {
				logger.fatal("CourseDB: modifyOutlineX\n" + exp.toString() + "\n");
				if (debug) logger.fatal("CourseDB - modifyOutlineX " + exp.toString());
				msg.setMsg("Exception");
				msg.setErrorLog( exp.toString());
			}
		} finally {
			asePool.freeConnection(connection);
		}

		return msg;
	}

	public static int modifyOutlineXX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String historyID) throws SQLException {

		int rowsAffected = 0;
		String thisSQL = "";

	Logger logger = Logger.getLogger("test");

		try{
			/*
				add only if not there
			*/
			if (!CampusDB.courseExistByCampus(conn,campus,alpha,num)){
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
			logger.fatal("CourseDB: modifyOutlineXX\n" + se.toString());
		}
		catch(Exception e){
			logger.fatal("CourseDB: modifyOutlineXX\n" + e.toString());
		}

		return rowsAffected;
	}

%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
</body>
</html>
