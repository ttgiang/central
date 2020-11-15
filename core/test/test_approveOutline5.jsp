<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Course Question Listing";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%
	String user = "THANHG";
	String campus = "LEECC";
	String thisApprover = "";
	int thisSeq = 0;
	int currentSeq = 0;
	int firstSeq = 1;
	int nextSeq = 0;
	int prevSeq = 0;
	int lastSeq = 0;
	String alpha = "ICS";
	String num = "241";

		int tableCounter = 0;
		int stepCounter = 0;
		int i = 0;
		int rowsAffected = 0;

		int steps = 44;

		StringBuffer errorLog = new StringBuffer();
//Msg msg = new Msg();
		PreparedStatement preparedStatement;
		String[] sql = new String[20];


		// to make a proposed course to current, do the following
		// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
		// 2) make a copy of the CUR course in temp table (insertToTemp)
		// 3) update key fields and prep for archive (updateTemp)
		// 4) put the temp record in courseARC table for use (insertToCourseARC)
		// 5) delete the current course from tblCourse
		// 6) change the PRE course in current course to CUR
		// 7) clean up the temp table (deleteFromTemp)
		// 8) move current approval history to log table
		// 9) clear current approval history

		stepCounter = 0;

		try{
			// delete temp data
			tableCounter = 6;
			sql[0] = "DELETE FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "DELETE FROM tblTempCoreq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "DELETE FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "DELETE FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "DELETE FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[5] = "DELETE FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}


			// delete into temp what is currently in the main tables
			tableCounter = 6;
			sql[0] = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[1] = "INSERT INTO tblTempCoreq SELECT * FROM tblCoreq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[2] = "INSERT INTO tblTempPreReq SELECT * FROM tblPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[3] = "INSERT INTO tblTempCourseAssess SELECT * FROM tblCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[4] = "INSERT INTO tblTempCourseComp SELECT * FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[5] = "INSERT INTO tblTempCourseContent SELECT * FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// update temp data prior to inserting into archived tables
			sql[0] = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE coursealpha=? AND coursenum=? AND campus=?";
			preparedStatement = conn.prepareStatement(sql[0]);
			preparedStatement.setString(1, user);
			preparedStatement.setString(2, AseUtil.getCurrentDateString());
			preparedStatement.setString(3, alpha);
			preparedStatement.setString(4, num);
			preparedStatement.setString(5, campus);
			rowsAffected = preparedStatement.executeUpdate();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			tableCounter = 5;
			sql[0] = "UPDATE tblTempCoreq SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "UPDATE tblTempPreReq SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "UPDATE tblTempCourseAssess SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "UPDATE tblTempCourseComp SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "UPDATE tblTempCourseContent SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, AseUtil.getCurrentDateString());
				preparedStatement.setString(2, campus);
				preparedStatement.setString(3, alpha);
				preparedStatement.setString(4, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// insert data from temp into archived tables
			tableCounter = 6;
			sql[0] = "INSERT INTO tblCourseARC SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			sql[1] = "INSERT INTO tblARCCoReq SELECT * FROM tblTempCoreq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			sql[2] = "INSERT INTO tblARCPreReq SELECT * FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			sql[3] = "INSERT INTO tblARCCourseAssess SELECT * FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			sql[4] = "INSERT INTO tblARCCourseComp SELECT * FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			sql[5] = "INSERT INTO tblARCCourseContent SELECT * FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// delete the current table data before moving from temp back to it
			tableCounter = 6;
			sql[0] = "DELETE FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[1] = "DELETE FROM tblCoReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[2] = "DELETE FROM tblPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[3] = "DELETE FROM tblCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[4] = "DELETE FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			sql[5] = "DELETE FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// set the modified data to current
			tableCounter = 6;
			sql[0] = "UPDATE tblCourse SET coursetype='CUR',progress='APPROVED',edit1='',edit2='' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[1] = "UPDATE tblCoReq SET coursetype='CUR' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[2] = "UPDATE tblPreReq SET coursetype='CUR' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[3] = "UPDATE tblCourseAssess SET coursetype='CUR' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[4] = "UPDATE tblCourseComp SET coursetype='CUR' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[5] = "UPDATE tblCourseContent SET coursetype='CUR' WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// clean up temp tables
			tableCounter = 6;
			sql[0] = "DELETE FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "DELETE FROM tblTempCoreq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "DELETE FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "DELETE FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "DELETE FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[5] = "DELETE FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			// update history table
			tableCounter = 2;
			sql[0] = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, " +
						"dte, campus, seq, approver, approved, comments ) " +
						"SELECT tba.id, tba.historyid, '" + AseUtil.getCurrentDateString() + "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  " +
						"tba.approver, tba.approved, tba.comments " +
						"FROM tblApprovalHist tba " +
						"WHERE campus=? AND " +
						"CourseAlpha=? AND " +
						"CourseNum=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
				//out.println("" + i + ": " + sql[i]+"<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}


			preparedStatement.close();
		}
		catch(SQLException ex) {
			/*
				this is caught before exception. However, there are instances where
				it may be valid and still executes.
			*/
			//-->logger.fatal("CourseDB: approveOutlineAccess\n" + ex.toString() + "\n" + errorLog.toString());
out.println("CourseDB: approveOutlineAccess\n" + ex.toString() + "\n" + errorLog.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			conn.rollback();
			//-->logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");
		}
		catch (Exception e){
			/*
				must do since for any exception, a rollback is a must.
			*/
			//-->logger.fatal("CourseDB: approveOutlineAccess\n" + e.toString() + "\n" + errorLog.toString());
out.println("CourseDB: approveOutlineAccess\n" + e.toString() + "\n" + errorLog.toString());

			try{
				conn.rollback();
				//-->logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");
			}catch(SQLException exp) {
				//-->logger.fatal("CourseDB: approveOutlineAccess\n" + exp.toString() + "\n" + errorLog.toString());
				msg.setMsg("Exception");
				msg.setErrorLog(errorLog.toString());
			}
		}

%>

</body>
</html>