import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SendMailTLS {

	public static void main(String[] args) {
		String host = "smtp.gmail.com";
		int port = 587;
		String username = "tgiang";
		String password = "tr!gger1011";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props);

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("tgiang@zippys.com"));
			message.setRecipients(Message.RecipientType.TO,InternetAddress.parse("tgiang@zippys.com"));
			message.setSubject("Testing Subject");
			message.setText("Dear Mail Crawler," +
					"\n\n No spam to my email, please!");

			Transport transport = session.getTransport("smtp");
			transport.connect(host, port, username, password);

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}