<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

String alpha = "ICS";
String num = "241";
String campus = "LEECC";
String user = "AAMODT";

try
{
	out.println(courseDB.isNextApprover(conn,campus,alpha,num,user));
}
catch (Exception e)
{};


%>