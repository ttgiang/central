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
	String jsid = "jsid";

		int rowsAffected = 0;
		int tableCounter = 0;
		int stepCounter = 0;
		int i = 0;
		int steps = 24;

		String[] sql = new String[15];
		//Msg msg = new Msg();
		StringBuffer errorLog = new StringBuffer();

		conn.setAutoCommit(false);

		try
		{
			PreparedStatement preparedStatement = conn.prepareStatement("SELECT firstname FROM tblINI WHERE firstname='thanhg'");

			tableCounter = 6;
			sql[0] = "DELETE FROM tblCourse WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[1] = "DELETE FROM tblCoreq WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[2] = "DELETE FROM tblPreReq WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[3] = "DELETE FROM tblCourseAssess WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[4] = "DELETE FROM tblCourseComp WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[5] = "DELETE FROM tblCourseContent WHERE  campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			for (i=0;i<tableCounter;i++){
out.println("" + stepCounter + ": " + sql[i] + "<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
			}

			tableCounter = 6;
			stepCounter = 0;
			sql[0] = "DELETE FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "DELETE FROM tblTempCoReq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "DELETE FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "DELETE FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "DELETE FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[5] = "DELETE FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i=0;i<tableCounter;i++){
out.println("" + stepCounter + ": " + sql[i] + "<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			tableCounter = 6;
			sql[0] = "INSERT INTO tblTempCourse SELECT * FROM tblcourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			sql[1] = "INSERT INTO tblTempCoReq SELECT * FROM tblCoReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			sql[2] = "INSERT INTO tblTempPreReq SELECT * FROM tblPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			sql[3] = "INSERT INTO tblTempCourseAssess SELECT * FROM tblCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			sql[4] = "INSERT INTO tblTempCourseComp SELECT * FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			sql[5] = "INSERT INTO tblTempCourseContent SELECT * FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			for (i=0;i<tableCounter;i++){
out.println("" + stepCounter + ": " + sql[i] + "<br>");
				preparedStatement = conn.prepareStatement(sql[i]);
				preparedStatement.setString(1, campus);
				preparedStatement.setString(2, alpha);
				preparedStatement.setString(3, num);
				preparedStatement.setString(4, "CUR");
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.clearParameters();
				errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");
			}

			sql[0] = "UPDATE tblTempCourse SET coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',proposer=?,historyid=?,jsid=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
			preparedStatement = conn.prepareStatement(sql[0]);
			preparedStatement.setString(1, user);
			preparedStatement.setString(2, courseDB.createHistoryID());
			preparedStatement.setString(3, jsid);
			preparedStatement.setString(4, campus);
			preparedStatement.setString(5, alpha);
			preparedStatement.setString(6, num);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.clearParameters();
			errorLog.append("<br>Step " + (++stepCounter) + " of " + steps + " (rowsAffected: " + rowsAffected + ")");

			tableCounter = 11;
			sql[0] = "UPDATE tblTempCoReq SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[1] = "UPDATE tblTempPreReq SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[2] = "UPDATE tblTempCourseAssess SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[3] = "UPDATE tblTempCourseComp SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";
			sql[4] = "UPDATE tblTempCourseContent SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";

			sql[5] = "INSERT INTO tblCourse SELECT * FROM tblTempCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[6] = "INSERT INTO tblCoReq SELECT * FROM tblTempCoReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[7] = "INSERT INTO tblPreReq SELECT * FROM tblTempPreReq WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[8] = "INSERT INTO tblCourseAssess SELECT * FROM tblTempCourseAssess WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[9] = "INSERT INTO tblCourseComp SELECT * FROM tblTempCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			sql[10] = "INSERT INTO tblCourseContent SELECT * FROM tblTempCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			for (i=0;i<tableCounter;i++){
out.println("" + stepCounter + ": " + sql[i] + "<br>");
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
		}
		catch(SQLException ex) {
			/*
				this is caught before exception. However, there are instances where
				it may be valid and still executes.
			*/
			out.println("CourseDB: modifyApprovedOutline\n" + ex.toString() + "\n" + errorLog.toString());

			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());

			conn.rollback();
		}
		catch (Exception e){
			/*
				must do since for any exception, a rollback is a must.
			*/
			out.println("CourseDB: modifyApprovedOutline\n" + e.toString() + "\n" + errorLog.toString());

			try{
				conn.rollback();
			}catch(SQLException exp) {
				out.println("CourseDB: modifyApprovedOutline\n" + exp.toString() + "\n" + errorLog.toString());
				msg.setMsg("Exception");
				msg.setErrorLog(errorLog.toString());
			}
		}

		conn.setAutoCommit(true);

		out.println(errorLog.toString());
%>

</body>
</html>