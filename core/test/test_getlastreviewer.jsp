<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	com.ase.aseutil.ApproverDB a = new com.ase.aseutil.ApproverDB();
	com.ase.aseutil.Approver ap = new com.ase.aseutil.Approver();
	ap = a.getApprovers(conn,"LEECC","THANHG");
	out.println( ap );
}
catch (Exception e)
{};


%>