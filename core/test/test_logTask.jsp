<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "ACEVES-FOSTER";

	out.println( TaskDB.logTask(conn,user,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE") );
}
catch (Exception e){
	out.println( e.toString() );
};


%>