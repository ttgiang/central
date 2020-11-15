import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailExample {
  public static void main (String args[])
      throws Exception {
    String host = args[0];
    String from = args[1];
    String to = args[2];

    // Get system properties
    Properties props = System.getProperties();

    // Setup mail server
    props.put("mail.smtp.host", host);

    // Get session
    Session session = Session.getInstance(props, null);

    // Define message
    MimeMessage message = new MimeMessage(session);
    message.setFrom(new InternetAddress(from));
    message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
    message.setSubject("Hello JavaMail");
    message.setText("Welcome to JavaMail");

    // Send message
    Transport.send(message);
  }
}