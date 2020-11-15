<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body>

<%

String fromAlpha = "ICS";
String fromNum = "212";

String toAlpha = "ICS";
String toNum = "218";

String user = "THANHG";
String campus = "LEECC";

int rowsAffected = 0;

	if ( !CourseDB.getCourseType(conn,campus,toAlpha,toNum,"PRE") && !CourseDB.getCourseType(conn,campus,toAlpha,toNum,"CUR")) {
		String deleteFromTemp = "DELETE FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=? AND proposer=?";
		String insertToTemp = "INSERT INTO tblCourseTemp SELECT * FROM tblcourse WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
		String updateTemp = "UPDATE tblCourseTemp SET coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='',edit2='',proposer=?,coursealpha=?,coursenum=? WHERE coursealpha=? AND coursenum=? AND campus=?";
		String insertToCourse = "INSERT INTO tblCourse SELECT * FROM tblCourseTemp WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=? AND proposer=?";

		PreparedStatement preparedStatement = conn.prepareStatement(deleteFromTemp);
		preparedStatement.setString (1, fromAlpha);
		preparedStatement.setString (2, fromNum);
		preparedStatement.setString (3, campus);
		preparedStatement.setString (4, user);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
out.println( "1" );

		preparedStatement = conn.prepareStatement(insertToTemp);
		preparedStatement.setString (1, fromAlpha);
		preparedStatement.setString (2, fromNum);
		preparedStatement.setString (3, campus);
		preparedStatement.setString (4, "CUR");
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
out.println( "2" );

		preparedStatement = conn.prepareStatement(updateTemp);
		preparedStatement.setString (1, user);
		preparedStatement.setString (2, toAlpha);
		preparedStatement.setString (3, toNum);
		preparedStatement.setString (4, fromAlpha);
		preparedStatement.setString (5, fromNum);
		preparedStatement.setString (6, campus);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
out.println( "3" );

		preparedStatement = conn.prepareStatement(insertToCourse);
		preparedStatement.setString (1, toAlpha);
		preparedStatement.setString (2, toNum);
		preparedStatement.setString (3, campus);
		preparedStatement.setString (4, "PRE");
		preparedStatement.setString (5, user);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
out.println( "4" );

		preparedStatement = conn.prepareStatement(deleteFromTemp);
		preparedStatement.setString (1, toAlpha);
		preparedStatement.setString (2, toNum);
		preparedStatement.setString (3, campus);
		preparedStatement.setString (4, user);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
out.println( "5" );

		TaskDB.logTask(conn,user,user,toAlpha,toNum,"Proposed outline",campus,"crscpy.jsp","ADD");
out.println( "6" );

		//notifyOutlineMonitors(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user);
	}
	else{
		rowsAffected = -1;
	}

%>

</body>
</html>
