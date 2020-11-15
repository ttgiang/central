<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

String alpha = "ICS";
String num = "241";
String campus = "LEECC";
String user = "THANHG";

int rowsAffected = 0;
int steps = 9;
String errorLog = "";
PreparedStatement preparedStatement;

String deleteFromTemp = "DELETE FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=?";
String insertToTemp = "INSERT INTO tblCourseTemp SELECT * FROM tblcourse WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype='CUR'";
String updateTemp = "UPDATE tblCourseTemp SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE coursealpha=? AND coursenum=? AND campus=?";
String insertToCourseARC = "INSERT INTO tblCourseARC SELECT * FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
String deleteFromCourse = "DELETE FROM tblCourse WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
String updateCourse = "UPDATE tblCourse SET coursetype='CUR',progress='APPROVED',edit1='',edit2='' WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype='PRE'";
String appendHistory = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, " +
	"dte, campus, seq, approver, approved, comments ) " +
	"SELECT tba.id, tba.historyid, '" + AseUtil.getCurrentDateString() + "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  " +
	"tba.approver, tba.approved, tba.comments " +
	"FROM tblApprovalHist tba " +
	"WHERE CourseAlpha=? AND " +
	"CourseNum=? AND " +
	"campus=?";
String deleteHistory = "DELETE FROM tblApprovalHist WHERE coursealpha=? AND coursenum=? AND campus=?";

out.println( "setting commit to false...<br>");

conn.setAutoCommit(false);

try{
	preparedStatement = conn.prepareStatement(deleteFromTemp);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 1 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- deleteFromTemp";

	preparedStatement = conn.prepareStatement(insertToTemp);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 2 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- insertToTemp";

	preparedStatement = conn.prepareStatement(updateTemp);
	preparedStatement.setString(1, user);
	preparedStatement.setString(2, AseUtil.getCurrentDateString());
	preparedStatement.setString(3, alpha);
	preparedStatement.setString(4, num);
	preparedStatement.setString(5, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 3 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- updateTemp";

	preparedStatement = conn.prepareStatement(insertToCourseARC);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	preparedStatement.setString(4, "ARC");
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 4 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- insertToCourseARC";

	preparedStatement = conn.prepareStatement(deleteFromCourse);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	preparedStatement.setString(4, "CUR");
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 5 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- deleteFromCourse";

	preparedStatement = conn.prepareStatement(updateCourse);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 6 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- updateCourse";

	preparedStatement = conn.prepareStatement(deleteFromTemp);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 7 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- deleteFromTemp";

	preparedStatement = conn.prepareStatement(appendHistory);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 8 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- appendHistory";

	preparedStatement = conn.prepareStatement(deleteHistory);
	preparedStatement.setString(1, alpha);
	preparedStatement.setString(2, num);
	preparedStatement.setString(3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	errorLog += "<br>Step 9 of " + steps + " (rowsAffected: " + rowsAffected + ") " + "- deleteHistory";

	conn.commit();

	out.println( "setting commit to true...<br>");

	preparedStatement.close ();

	out.println( "closed preparedStatement...<br>");

}
catch(SQLException ex) {
	out.println("<BR>--- SQLException caught ---<BR>");

	while (ex != null) {
		out.println("Message:   " + ex.getMessage() + "<br>");
		out.println("SQLState:  " + ex.getSQLState() + "<br>");
		out.println("ErrorCode: " + ex.getErrorCode() + "<br>" );
		ex = ex.getNextException();
		out.println("");
	} // while

	conn.rollback();
	out.println( "rollling back...<br>");

} // catch
catch (Exception e){

	out.println( errorLog + "<br>" );

	try{
		conn.rollback();
		out.println( "rollling back...<br>");
	}catch(SQLException exp) {

		out.println( "Error: " + e.toString() );

		out.println("<BR>--- SQLException caught ---<BR>");
		while (exp != null) {
			out.println("Message:   " + exp.getMessage() + "<br>");
			out.println("SQLState:  " + exp.getSQLState() + "<br>");
			out.println("ErrorCode: " + exp.getErrorCode() + "<br>");
			exp = exp.getNextException();
			out.println("");
		} // while
	} // catch
} // catch

out.println( errorLog + "<br>" );

conn.setAutoCommit(true);

%>