import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

public class Mailtest
{
	public static void main(String args[]){
		try{
			send("mail.ficoh.net", "thanh.giang@ficoh.com", "thanh.giang@ficoh.com", "subject", "body");
		}
		catch (Exception ex){
			System.out.println( ex.toString() );
			System.out.println("Usage: Mailtest smtpServer toAddress fromAddress subjectText bodyText");
		}
		System.exit(0);
	}

	public static void send(String smtpServer, String to, String from, String subject, String body){
		try{
			Properties props = System.getProperties();
			// -- Attaching to default Session, or we could start a new one --
			props.put("mail.smtp.host", smtpServer);
			Session session = Session.getDefaultInstance(props, null);
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(from));
			msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to, false));
			// msg.setRecipients(Message.RecipientType.CC,InternetAddress.parse(cc, false));
			msg.setSubject(subject);
			msg.setText(body);
			// -- Set some other header information --
			//msg.setHeader("X-Mailer", "AseTech");
			msg.setSentDate(new Date());
			Transport.send(msg);
			System.out.println("Message sent OK.");
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
	}
}

