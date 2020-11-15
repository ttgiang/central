<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String user = "LEECC";
	String campus = "LEECC";

	String sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE coursealpha=? AND coursenum=? AND campus=?";
	PreparedStatement preparedStatement = conn.prepareStatement(sql);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	int rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();

	sql = "DELETE FROM tblReviewHist WHERE coursealpha=? AND coursenum=? AND campus=?";
	preparedStatement = conn.prepareStatement(sql);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, campus);
	rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();

	out.println(rowsAffected);

}
catch (Exception e){
	out.println( e.toString() );
};


%>