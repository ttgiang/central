<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String user = "THANHG";
	String campus = "LEECC";
	int counter = 0;

	String sql = "WHERE courseAlpha = '" + SQLUtil.encode(alpha) + "' AND " +
		"coursenum = '" + SQLUtil.encode(num) + "' AND " +
		"campus = '" + SQLUtil.encode(campus) + "'";
	long lNumRecs = 0;

	java.sql.Statement stmt = conn.createStatement();
	java.sql.ResultSet rs = stmt.executeQuery("SELECT COUNT(0) FROM " + "tblReviewers" + " " + sql);
	if ( rs != null && rs.next() ) {
		lNumRecs = rs.getLong(1);
	}
	rs.close();
	stmt.close();

	out.println( lNumRecs );
}
catch (Exception e)
{};


%>