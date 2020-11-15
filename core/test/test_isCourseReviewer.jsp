<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String user = "THANHG";
	String campus = "LEECC";
	String sql = "";
	long lNumRecs = 0;
	String reviewDate = (new SimpleDateFormat("MM/d/yyyy")).format(new java.util.Date());

	String table = "tblReviewers tbr INNER JOIN tblCourse tc ON " +
		"(tbr.campus = tc.campus) AND " +
		"(tbr.coursenum = tc.CourseNum) AND " +
		"(tbr.coursealpha = tc.CourseAlpha) ";


	sql = "GROUP BY tbr.coursealpha, tbr.coursenum, tc.CourseType, tbr.userid, tc.reviewdate " +
		"HAVING (tbr.coursealpha='" + SQLUtil.encode(alpha) + "' AND  " +
		"tbr.coursenum='" + SQLUtil.encode(num) + "' AND  " +
		"tc.CourseType='PRE' AND  " +
		"tbr.userid='" + SQLUtil.encode(user) + "' AND " +
		"tc.reviewdate>=#" + SQLUtil.encode(reviewDate) + "#)";

	sql = "SELECT COUNT(0) FROM " + table + " " + sql;

	out.println( sql );

	java.sql.Statement stmt = conn.createStatement();
	java.sql.ResultSet rs = stmt.executeQuery(sql);

	if ( rs != null && rs.next() ) {
		lNumRecs = rs.getLong(1);
	}
	rs.close();
	stmt.close();

	out.println(lNumRecs );

}
catch (Exception e){
	out.println( e.toString() );
};


%>