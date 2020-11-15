<%@ include file="ase.jsp" %>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">

<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "THANHG";

		int rowsAffected = 0;
		int stepCounter = 0;
		int tableCounter = 0;
		int i = 0;

		int steps = 16;

//Msg msg = new Msg();
		StringBuffer errorLog = new StringBuffer();
		String[] sql = new String[15];
		String thisSQL = "";

		try {
			/*
			 * 1) start by clearing temp table 2) Insert into temp table the PRE
			 * course outline from tblCourse 3) Update the temp record with
			 * proper data 4) Insert into cancelled table 5) Delete the PRE
			 * record from course 6) clear temp table 7) move reviewer comments
			 * to history 8) move approval comments to history
			 */

			PreparedStatement preparedStatement = conn.prepareStatement("SELECT firstname FROM tblINI WHERE firstname='thanhg'");
			preparedStatement.clearParameters();

			tableCounter = 7;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			thisSQL = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, "PRE");
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			thisSQL = "UPDATE tblTempCourse SET coursetype='CAN',progress='CANCELLED',coursedate=?,proposer=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, AseUtil.getCurrentDateString());
			preparedStatement.setString(2, user);
			preparedStatement.setString(3, campus);
			preparedStatement.setString(4, alpha);
			preparedStatement.setString(5, num);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			thisSQL = "INSERT INTO tblCourseCAN SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, "CAN");
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			thisSQL = "DELETE FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			tableCounter = 6;
			sql[0] = "tblCoreq";
			sql[1] = "tblPreReq";
			sql[2] = "tblCourseComp";
			sql[3] = "tblCourseContent";
			sql[4] = "tblCampusData";
			sql[5] = "tblCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET auditdate=?,auditby=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
out.println(thisSQL+"<br>");
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, AseUtil.getCurrentDateString());
				preparedStatement.setString(2, user);
				preparedStatement.setString(3, campus);
				preparedStatement.setString(4, alpha);
				preparedStatement.setString(5, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();

				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='CAN' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
out.println(thisSQL+"<br>");
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			tableCounter = 4;
			sql[0] = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments ) "
					+ "SELECT tba.id, tba.historyid, '"
					+ AseUtil.getCurrentDateString()
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments FROM tblApprovalHist tba WHERE CourseAlpha=? AND CourseNum=? AND campus=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i = 0; i < tableCounter; i++) {
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

			rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Modify outline",campus,"crscan.jsp","REMOVE");
			AseUtil.logAction(conn,user,"courseDB","Outline Cancelled",alpha,num,campus);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			//logger.fatal("CourseDB: cancelOutline\n" + ex.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());

			out.println("<br>" + ex.toString());

		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			//logger.fatal("CourseDB: cancelOutline\n" + e.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			out.println("<br>" + e.toString());
		}

		//return msg;

		out.println(msg.getErrorLog());

%>

</body>
</html>
