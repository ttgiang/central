<html>
  <head>
    <title>JSP JavaMail Example </title>
  </head>

<body>

<%@ include file="ase.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%

	String campus = Constant.CAMPUS_KAP;
	String alpha = "ICS";
	String num = "100";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "c21h19h9193";
	int t = 0;

	/*
	try{
		String host = "mail.ficoh.net";
		String to = "thanh.giang@ficoh.com";
		String from = "thanh.giang@ficoh.com";
		String subject = "Test";
		String messageText = "Body";
		boolean sessionDebug = false;

		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol", "smtp");

		Session mailSession = Session.getDefaultInstance(props, null);

		mailSession.setDebug(sessionDebug);

		Message msgMail = new MimeMessage(mailSession);

		msgMail.setFrom(new InternetAddress(from));
		InternetAddress[] address = {new InternetAddress(to)};
		msgMail.setRecipients(Message.RecipientType.TO, address);
		msgMail.setSubject(subject);
		msgMail.setSentDate(new java.util.Date());
		msgMail.setText(messageText);
		Transport.send(msgMail);

		out.println("Mail was sent to " + to);
		out.println(" from " + from);
		out.println(" using host " + host + ".");

		Mailer mailer = new Mailer();
		mailer.setSubject("emailApproveOutline");
		mailer.setFrom("thanhg");
		mailer.setTo("ttgiang@yahoo.com");
		mailer.setAlpha(alpha);
		mailer.setNum(num);
		mailer.setCampus(campus);

		//MailerDB.sendMail(conn,mailer,"emailCoreqAdded");
		//MailerDB mailerDB = new MailerDB(conn,"thanhg","thanhg","","","","","","emailOutlineApprovalRequest",kix);
	}
	catch( SendFailedException ex ){
		out.println( ex.toString() );
	}
	catch( java.net.ConnectException ce ){
		out.println( ce.toString() );
	}
	*/

	//MailerDB mailerDB = new MailerDB(conn,"THANHG","thanh.giang@ficoh.com","","","","","","emailOutlineApprovalRequest",kix);

	Mailer mailer = new Mailer();
	mailer.setSubject("emailApproveOutline");
	mailer.setFrom("thanh@hawaii.edu");
	mailer.setTo("thanh@hawaii.edu");
	mailer.setAlpha("");
	mailer.setNum("");
	mailer.setCampus("");
	MailerDB mailerDB = new MailerDB();
	mailerDB.sendMail(conn,mailer,"emailApproveOutline");
%>

    </table>
  </body>
</html>
