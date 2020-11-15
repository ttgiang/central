<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

String alpha = "ICS";
String num = "298B";
String campus = "LEECC";
String user = "AKANA";

try{
	Approver app = ApproverDB.getApproverByName(conn,user);
	if ( app != null ){
		out.println("Here: " + app.getSeq());
	}
	else
		out.println("There");
}
catch(SQLException e){
	out.println( "SQLException: " +  e.toString() );
}

%>