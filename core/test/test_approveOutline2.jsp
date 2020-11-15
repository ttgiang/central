<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

String alpha = "ICS";
String num = "241";
String campus = "LEECC";
String user = "THANHG";
String message = "";

msg = courseDB.approveOutline(conn,campus,alpha,num,user,true,"comments");
if ( "Exception".equals(msg.getMsg()) ){
	message = "Outline approval failed.<br><br>" + msg.getErrorLog();
}
else if ( !"".equals(msg.getMsg()) ){
	message = "Unable to approve outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
}
else{
	if ( msg.getCode() == 2 )
		message = "Outline was approved and finalized.";
	else
		message = "Outline was approved.";
}

out.println( message );

%>