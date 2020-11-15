<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	Statement stmt = null;
	ResultSet rs = null;
	String sql = "";
	String temp = "";
	String[] questions = new String[100];
	String campus = "LEECC";
	int columnCount = 0;

	// get course field names that are included by campus
	sql = "SELECT CCCM6100.question_friendly, question " +
		"FROM tblCourseQuestions tcc INNER JOIN CCCM6100 ON tcc.questionnumber = CCCM6100.id " +
		"WHERE tcc.campus='" + campus + "' AND tcc.type='Course' AND tcc.include='Y' " +
		"ORDER BY tcc.questionseq";
	stmt = conn.createStatement();
	rs = aseUtil.openRecordSet( stmt, sql );
	while ( rs.next() ) {
		if ( temp.length() == 0 )
			temp = (String)rs.getString("question_friendly");
		else
			temp = temp + "," + (String)rs.getString("question_friendly");

		questions[columnCount++] = (String)rs.getString("question");
	}	// if rs.next

	rs.close();
	rs = null;
	stmt.close();

	out.println( temp );
}
catch (Exception e){
	out.println( e.toString() );
};


%>