<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

String campus = "LEECC";
String alpha = "ICS";
String num = "218";
String user = "THANHG";

int rowsAffected = 0;

try{
	// to archive an approved course, the following is necessary
	// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
	// 2) make a copy of the CUR course in temp table (insertToTemp)
	// 3) update key fields and prep for archive (updateTemp)
	// 4) put the temp record in courseARC table for use (insertToCourseARC)
	// 5) delete the current course from tblCourse

	String deleteFromTemp = "DELETE FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=?";
	String insertToTemp = "INSERT INTO tblCourseTemp SELECT * FROM tblcourse WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
	String updateTemp = "UPDATE tblCourseTemp SET coursetype='ARC',progress='ARCHIVED',proposer=? WHERE coursealpha=? AND coursenum=? AND campus=?";
	String insertToCourseARC = "INSERT INTO tblCourseARC SELECT * FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
	String deleteFromCourse = "DELETE FROM tblCourse WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
	String removeTask = "DELETE FROM tblTasks WHERE courseAlpha=? AND courseNum=? AND campus=? AND submittedfor=?";

	PreparedStatement preparedStatement = conn.prepareStatement(deleteFromTemp);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "1" );

	preparedStatement = conn.prepareStatement(insertToTemp);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	preparedStatement.setString (4, "CUR");
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "2" );

	preparedStatement = conn.prepareStatement(updateTemp);
	preparedStatement.setString (1, user);
	preparedStatement.setString (2, alpha);
	preparedStatement.setString (3, num);
	preparedStatement.setString (4, campus);
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "3" );

	preparedStatement = conn.prepareStatement(insertToCourseARC);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	preparedStatement.setString (4, "ARC");
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "4" );

	preparedStatement = conn.prepareStatement(deleteFromCourse);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	preparedStatement.setString (4, "CUR");
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "5" );

	if ( rowsAffected > 0 ){
		aseUtil.logAction(conn,user,"crsdel.jsp","Course deleted",alpha,num,campus);
	}

	preparedStatement = conn.prepareStatement(removeTask);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	preparedStatement.setString (4, user);
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
out.println( "5" );

	if ( rowsAffected > 0 ){
		aseUtil.logAction(conn,user,"crsdel.jsp","Task deleted",alpha,num,campus);
	}
}
catch (Exception e)
{
	out.println( e.toString() );
}

out.println( rowsAffected );

%>