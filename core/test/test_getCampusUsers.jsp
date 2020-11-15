<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String temp = aseUtil.lookUp(conn, "tblReviewers", "userid",
				"coursealpha = " + aseUtil.toSQL("ICS",1) +
				" AND coursenum = " + aseUtil.toSQL("110",1) +
				" AND campus = " + aseUtil.toSQL("LEECC",1) );

	if ( temp != null && temp.length() > 0 ){
		String[] s = new String[100];
		s = temp.split(",");
		temp = "";
		for ( int i = 0; i < s.length; i++ ){
			if ( temp.length() == 0 )
				temp = "\'" + s[i] + "\'";
			else
				temp = temp + ",\'" + s[i] + "\'";
		}

		temp = "(" + temp + ")";
	}

			String query = "SELECT userid FROM tblUsers " +
				"WHERE campus = 'LEECC' " +
				"AND userid NOT IN " + temp + " " +
				"ORDER BY userid";

out.println( query );

}
catch (Exception e)
{};


%>