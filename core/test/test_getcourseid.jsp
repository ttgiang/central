<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String campus = "LEECC";

	String query = "SELECT id " +
		"FROM tblCourse  " +
		"WHERE CourseAlpha='" + SQLUtil.encode(alpha) + "' AND " +
		"CourseNum='" + SQLUtil.encode(num) + "' AND " +
		"CourseType='PRE' AND " +
		"campus='" + SQLUtil.encode(campus) + "'";

	Statement statement = conn.createStatement();
	ResultSet results = statement.executeQuery(query);

	if ( results.next() )
		out.println( results.getInt(1) );

	results.close();
	statement.close();
}
catch (Exception e){
	out.println( e.toString() );
};


%>