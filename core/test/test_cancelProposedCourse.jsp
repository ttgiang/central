 <%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<form name="x" action="" method="POST">
<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "THANHG";
	String[] sql = new String[15];
	int tableCounter = 0;
	int i = 0;
	String jsid = "jsid";

	int rowsAffected = 0;
	int steps = 21;
	int stepCounter = 0;
	//-->Msg msg = new Msg();
	StringBuffer errorLog = new StringBuffer();

	conn.setAutoCommit(false);

	try
	{
			PreparedStatement preparedStatement = conn.prepareStatement("SELECT firstname FROM tblINI WHERE firstname='thanhg'");
			preparedStatement.clearParameters();

			tableCounter = 7;
			sql[0] = "DELETE FROM tblTempCoreq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "DELETE FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "DELETE FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "DELETE FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "DELETE FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[5] = "DELETE FROM tblTempXRef WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[6] = "DELETE FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			sql[0] = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			preparedStatement = conn.prepareStatement(sql[0]);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, "PRE");
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			sql[0] = "UPDATE tblTempCourse SET coursetype='CAN',progress='CANCELLED',coursedate=?,proposer=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			preparedStatement = conn.prepareStatement(sql[0]);
			preparedStatement.setString(1, AseUtil.getCurrentDateString());
			preparedStatement.setString(2, user);
			preparedStatement.setString(3, campus);
			preparedStatement.setString(4, alpha);
			preparedStatement.setString(5, num);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			sql[0] = "INSERT INTO tblCourseCAN SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			preparedStatement = conn.prepareStatement(sql[0]);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, "CAN");
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			tableCounter = 11;
			sql[0] = "DELETE FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[1] = "DELETE FROM tblCoreq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[2] = "DELETE FROM tblPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[3] = "DELETE FROM tblCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[4] = "DELETE FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[5] = "DELETE FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[6] = "DELETE FROM tblXRef WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[7] = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, " +
				"dte, campus, seq, approver, approved, comments ) " +
				"SELECT tba.id, tba.historyid, '" + AseUtil.getCurrentDateString() + "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  " +
				"tba.approver, tba.approved, tba.comments FROM tblApprovalHist tba WHERE CourseAlpha=? AND CourseNum=? AND campus=?";
			sql[8] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[9] = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[10] = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			preparedStatement.close();

			conn.commit();

			AseUtil.loggerInfo("CourseDB: modifyApprovedOutline ", campus, user, alpha, num);

			rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Modify Outline",campus,"crsedt.jsp","ADD");

			//-->logger.info("CourseDB: modifyApprovedOutline\n" + errorLog.toString());
	}
	catch(SQLException ex) {
		/*
			this is caught before exception. However, there are instances where
			it may be valid and still executes.
		*/
		//-->logger.fatal("CourseDB: modifyApprovedOutline\n" + ex.toString() + "\n" + errorLog.toString());

		msg.setMsg("Exception");
		msg.setErrorLog(ex.toString() + "<br>" + errorLog.toString());

		errorLog.append("<br> " + ex.toString() + "<br>" + errorLog.toString());

		conn.rollback();
		//-->logger.info("CourseDB: modifyApprovedOutline\nRolling back transaction");
	}
	catch (Exception e){
		/*
			must do since for any exception, a rollback is a must.
		*/
		//-->logger.fatal("CourseDB: approveOutlineAccess\n" + e.toString() + "\n" + errorLog.toString());
		try{
			conn.rollback();
			//-->logger.info("CourseDB: modifyApprovedOutline\nRolling back transaction");
		}catch(SQLException exp) {
			//-->logger.fatal("CourseDB: modifyApprovedOutline\n" + exp.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
		}

		errorLog.append("<br> " + e.toString() + "<br>" + errorLog.toString());
	}

	conn.setAutoCommit(true);

	out.println(errorLog.toString());

%>

</form>