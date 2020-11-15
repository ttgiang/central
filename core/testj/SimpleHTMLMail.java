import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

class SimpleHTMLMail {
    public static void main(String[] args) throws Exception{

		try{
			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", "smtp");
			props.setProperty("mail.host", "mail.ficoh.net");
			props.setProperty("mail.user", "tgiang");
			props.setProperty("mail.password", "");

			Session mailSession = Session.getDefaultInstance(props, null);
			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);
			message.setSubject("Testing javamail html");
			message.setContent("This is a test <b>HOWTO<b>", "text/html; charset=ISO-8859-1");
			message.addRecipient(Message.RecipientType.TO,new InternetAddress("thanh.giang@ficoh.com"));

			transport.connect();
			transport.sendMessage(message,message.getRecipients(Message.RecipientType.TO));
			transport.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
    }
}
