<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "";
	String num = "";
	String campus = "";
	PreparedStatement preparedStatement;
	int rowsAffected;

	// code to reset review dates once expired
	// 1. get all courses where the review date is less than today and in reivew progress
	// 2. loop through and reset to modify mode
	String update = "UPDATE tblCourse SET reviewdate=null,progress='MODIFY',edit='1',edit1='1',edit2='1' WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype='PRE'";
	String query = "SELECT CourseAlpha, CourseNum, campus, reviewdate " +
		"FROM tblCourse " +
		"WHERE CourseType='PRE' AND " +
		"progress='REVIEW' AND " +
		"reviewdate < #" + aseUtil.getCurrentDate() + "#";
	//out.println( query );
	Statement statement = conn.createStatement();
	ResultSet results = statement.executeQuery(query);
	while (results.next() ){
		alpha = results.getString(1);
		num = results.getString(2);
		campus = results.getString(3);
		out.println( alpha + "-" + num + "-" + campus + "<br>" );

		preparedStatement = conn.prepareStatement(update);
		preparedStatement.setString (1, alpha);
		preparedStatement.setString (2, num);
		preparedStatement.setString (3, campus);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();
	}

	results.close();
	statement.close();
}
catch (Exception e){
	out.println( e.toString() );
};


%>