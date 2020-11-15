<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";

	String query = "SELECT tc.coursetitle, tc.Progress, td.ALPHA_DESCRIPTION, tc.proposer " +
		"FROM tblCourse as tc, BannerAlpha AS td " +
		"WHERE tc.coursealpha = td.COURSE_ALPHA AND " +
		"tc.CourseAlpha='" + SQLUtil.encode(alpha) + "' AND " +
		"tc.CourseNum='" + SQLUtil.encode(num) + "' AND " +
		"tc.campus='" + SQLUtil.encode(campus) + "'";
	Statement statement = conn.createStatement();
	ResultSet results = statement.executeQuery(query);
	if (results.next()){
		String progress = "<table border=0 width=\"50%\">" +
			"<tr><td colspan=2 align=center><strong>Outline Details</strong></td></tr>" +
			"<tr><td width=\"30%\">Course:</td><td>" + alpha + " " + num + "</td></tr>" +
			"<tr><td width=\"30%\">Title:</td><td>" + results.getString(1) + "</td></tr>" +
			"<tr><td width=\"30%\">Progress:</td><td>" + results.getString(2) + "</td></tr>" +
			"<tr><td width=\"30%\">Discipline:</td><td>" + results.getString(3) + "</td></tr>" +
			"<tr><td width=\"30%\">Proposer:</td><td>" + results.getString(4) + "</td></tr></table>";

			out.println( progress );
	}

	results.close();
	statement.close();
}
catch (Exception e){
	out.println( e.toString() );
};


%>