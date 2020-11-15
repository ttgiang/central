<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	com.ase.aseutil.DistributionDB a = new com.ase.aseutil.DistributionDB();
	com.ase.aseutil.Distribution ap = new com.ase.aseutil.Distribution();
	ap.setTitle("Title");
	ap.setMembers("Members");
	ap.setCampus("Campus");
	a.insertList(conn,ap);
	out.println( ap );
}
catch (Exception e)
{};


%>