/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *	public static int confirmNotification(Connection conn,String campus,String user) throws Exception {
 *	public static String createMailNameList(Connection conn,String domain,String mail) throws Exception {
 * public static String getSendMail(Connection conn)
 *
 */

//
//  GMail.java
//
package com.ase.aseutil;

import java.util.Properties;
import java.util.ResourceBundle;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
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

import org.apache.log4j.Logger;

/**
 * security constants
 */
public class GMail {

	static Logger logger = Logger.getLogger(GMail.class.getName());

	public GMail(){}

	public GMail(String from,String to,String subject,String message){

		Mailer mailer = new Mailer();
		mailer.setTo(to);
		mailer.setFrom(from);
		mailer.setSubject(subject);
		mailer.setMessage(message);
		sendMail(mailer);
		mailer = null;
	}

	/**
	 * sendMail
	 * <p>
	 * @param	conn			Connection
	 * @param	mailer		Mailer
	 * <p>
	 * @return	boolean
	 */
	public boolean sendMail(Mailer mailer) {

		boolean mailSent = false;

		//Logger logger = Logger.getLogger("test");
		try{
			String 	SMTP_HOST_NAME = "smtp.gmail.com";
			int 		SMTP_HOST_PORT = 587;
			String 	SMTP_AUTH_USER = "helpdesk@zippys.com";
			String 	SMTP_AUTH_PWD  = "Zippysit123";
			String 	SMTP_PROTOCOL  = "smtp";
			String 	SMTP_SSL  		= "true";
			String 	SMTP_AUTH  		= "true";

			boolean sessionDebug = true;

			Properties props = System.getProperties();
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.auth", "true");

			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);

			mailer.setFrom("tgiang@zippys.com");
			mailer.setTo("tgiang@zippys.com");

			msg.setFrom(new InternetAddress(mailer.getFrom()));

			InternetAddress[] address = {new InternetAddress(mailer.getTo())};

			msg.setRecipients(Message.RecipientType.TO, address);

			msg.setSubject("Helpdesk: " + mailer.getSubject());

			msg.setContent(mailer.getMessage(), "text/html");

			Transport transport = mailSession.getTransport(SMTP_PROTOCOL);
			transport.connect(SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();

			mailSent = true;
		}
		catch(SendFailedException e){
			logger.fatal("GMail - sendMail - SendFailedException: " + e.toString() + "\n" + mailer);
		}
		catch(javax.mail.MessagingException e){
			logger.fatal("GMail - sendMail - MessagingException: " + e.toString() + "\n" + mailer);
		}
		catch(Exception e){
			logger.fatal("GMail - sendMail - Exception: " + e.toString() + "\n" + mailer);
		}

		return mailSent;
	}

}
