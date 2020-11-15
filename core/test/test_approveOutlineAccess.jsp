<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

		String campus = "LEECC";
		String alpha = "ICS";
		String num = "241";
		String user = "THANHG";
		boolean approval = true;
		String comments = "comments";

		int tableCounter = 0;
		int stepCounter = 0;
		int rowsAffected = 0;
		int i = 0;

		boolean DEBUG = false;

		int steps = 44;

		StringBuffer errorLog = new StringBuffer();
		PreparedStatement preparedStatement;
		String[] sql = new String[20];
		String thisSQL = "";

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

		stepCounter = 0;
		conn.setAutoCommit(false);

		try {
			// delete temp data
			// 0-5
			tableCounter = 6;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("1-----------------<br>");

			// delete into temp what is currently in the main tables
			// 6-11
			tableCounter = 6;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";

			sql[10] = "tblCourse";
			sql[11] = "tblCampusData";
			sql[12] = "tblCoreq";
			sql[13] = "tblPreReq";
			sql[14] = "tblCourseComp";
			sql[15] = "tblCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("2-----------------<br>");

			// update temp data prior to inserting into archived tables
			// 12
			thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE coursealpha=? AND coursenum=? AND campus=?";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, user);
			preparedStatement.setString(2, AseUtil.getCurrentDateString());
			preparedStatement.setString(3, alpha);
			preparedStatement.setString(4, num);
			preparedStatement.setString(5, campus);

			if (DEBUG)
				out.println("" + stepCounter + ": " + thisSQL + "<br>");
			else
				rowsAffected = preparedStatement.executeUpdate();

			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			// 13-17
			tableCounter = 5;
			sql[0] = "tblTempCoreq";
			sql[1] = "tblTempPreReq";
			sql[2] = "tblTempCourseComp";
			sql[3] = "tblTempCourseContent";
			sql[4] = "tblTempCampusData";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, AseUtil.getCurrentDateString());
				preparedStatement.setString(2, campus);
				preparedStatement.setString(3, alpha);
				preparedStatement.setString(4, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("3-----------------<br>");

			// insert data from temp into archived tables
			// 18-23
			tableCounter = 6;
			sql[0] = "tblCourseARC";
			sql[1] = "tblCampusData";
			sql[2] = "tblCoReq";
			sql[3] = "tblPreReq";
			sql[4] = "tblCourseComp";
			sql[5] = "tblCourseContent";

			sql[10] = "tblTempCourse";
			sql[11] = "tblTempCampusData";
			sql[12] = "tblTempCoreq";
			sql[13] = "tblTempPreReq";
			sql[14] = "tblTempCourseComp";
			sql[15] = "tblTempCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("4-----------------<br>");

			// delete the current table data before moving from temp back to it
			// 24-29
			tableCounter = 6;
			sql[0] = "tblCourse";
			sql[1] = "tblCampusData";
			sql[2] = "tblCoReq";
			sql[3] = "tblPreReq";
			sql[4] = "tblCourseComp";
			sql[5] = "tblCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM "
						+ sql[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("5-----------------<br>");

			// set the modified data to current
			// 30
			thisSQL = "UPDATE tblCourse SET coursetype='CUR',progress='APPROVED',edit1='',edit2='' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			preparedStatement = conn.prepareStatement(thisSQL);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);

			if (DEBUG)
				out.println("" + stepCounter + ": " + thisSQL + "<br>");
			else
				rowsAffected = preparedStatement.executeUpdate();

			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			// 31-35
			tableCounter = 5;
			sql[0] = "tblCampusData";
			sql[1] = "tblCoReq";
			sql[2] = "tblPreReq";
			sql[3] = "tblCourseComp";
			sql[4] = "tblCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='CUR',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, AseUtil.getCurrentDateString());
				preparedStatement.setString(2, campus);
				preparedStatement.setString(3, alpha);
				preparedStatement.setString(4, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("6-----------------<br>");

			// clean up temp tables
			// 36-41
			tableCounter = 6;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=?";
				preparedStatement = conn.prepareStatement(thisSQL);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("7-----------------<br>");

			// update history table
			// 42-43
			tableCounter = 2;
			sql[0] = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments ) "
					+ "SELECT tba.id, tba.historyid, '"
					+ AseUtil.getCurrentDateString()
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments "
					+ "FROM tblApprovalHist tba "
					+ "WHERE campus=? AND "
					+ "CourseAlpha=? AND " + "CourseNum=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i = 0; i < tableCounter; i++) {
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);

				if (DEBUG)
					out.println("" + stepCounter + ": " + thisSQL + "<br>");
				else
					rowsAffected = preparedStatement.executeUpdate();

				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			if (DEBUG)
				out.println("8-----------------<br>");

			conn.commit();

			preparedStatement.close();

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			//logger.fatal("CourseDB: approveOutlineAccess\n" + ex.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			conn.rollback();
			//logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");

			if (DEBUG)
				out.println(ex.toString() + "<br>");

		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			//logger.fatal("CourseDB: approveOutlineAccess\n" + e.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");

			try {
				conn.rollback();
				//logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");
			} catch (SQLException exp) {
				//logger.fatal("CourseDB: approveOutlineAccess\n" + exp.toString() + "\n" + errorLog.toString());
				msg.setMsg("Exception");
				msg.setErrorLog(errorLog.toString());
			}

			if (DEBUG)
				out.println(e.toString() + "<br>");
		}

		conn.setAutoCommit(true);

		out.println(errorLog.toString());
%>