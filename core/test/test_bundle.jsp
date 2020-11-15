<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	ResourceBundle emailBundle = ResourceBundle.getBundle("ase.central." + "emailRejectOutline" );
	String subject = emailBundle.getString("mailSubject");
	subject = subject.replace("_alpha_", "ICS");
	subject = subject.replace("_num_", "218");
	out.println( subject + "<br>" );
}
catch (Exception e){
	out.println( e.toString() );
};


%>