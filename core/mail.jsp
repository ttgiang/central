<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.mail.*,javax.servlet.*"%>

<%
		String mailType = "sendhtml";
		boolean success = true;

		try {
			// check system settings for mail defaults
			ResourceBundle bundle = ResourceBundle.getBundle("ase.central.Ase");
			String mailHost = bundle.getString("smtp");
			String useMail = bundle.getString("sendMail");
			String domain = "@" + bundle.getString("domain");
			String subject = "";
			String content = "";
			String temp = "";
			boolean sessionDebug = false;
			String email = "";
			Mailer mailer = new Mailer();

			if (mailHost != null && "YES".equals(useMail)) {
				Properties props = System.getProperties();
				props.put("mail.host",mailHost);
				props.put("mail.transport.protocol","smtp");

				//Session session = Session.getDefaultInstance(props,null);
				session.setDebug(sessionDebug);
				msg = new MimeMessage(session);

				if (mailer.getFrom() != null)
					msg.setFrom(new InternetAddress(getEmailAccount(conn,domain,mailer.getFrom())));

				/*
				 * if there is no @ in the to field, it's possible that there is
				 * a list of recipients to send to. Dissect and formulate
				 * addresses
				 */
				if (mailer.getTo() != null) {
					if (mailer.getTo().indexOf("@") < 0) {
						String[] to = new String[100];
						to = mailer.getTo().split(",");
						for (int i = 0; i < to.length; i++) {
							email = getEmailAccount(conn,domain,to[i].trim());
							msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
						}
					} else
						msg.addRecipient(Message.RecipientType.TO,new InternetAddress(mailer.getTo()));
				}

				temp = mailer.getCC();
				if (temp != null && temp.length() > 0)
					msg.addRecipient(Message.RecipientType.CC,new InternetAddress(getEmailAccount(conn,domain,temp)));

				temp = mailer.getBCC();
				if (temp != null && temp.length() > 0)
					msg.addRecipient(Message.RecipientType.BCC,new InternetAddress(getEmailAccount(conn,domain,temp)));

				if (mailBundle != null && mailBundle.length() > 0) {
					ResourceBundle emailBundle = ResourceBundle.getBundle("ase.central." + mailBundle);
					subject = emailBundle.getString("mailSubject");
					subject = subject.replace("_alpha_", mailer.getAlpha());
					subject = subject.replace("_num_", mailer.getNum());
					content = emailBundle.getString("mailContent");
				}

				msg.setSubject(subject);
				msg.setHeader("X-Mailer", mailType);
				msg.setSentDate(new Date());
				// msg.setContent(content + "password","text/plain");
				msg.setText(content);

				Transport.send(msg);

				AseUtil.logMail(conn, mailer);
			} else {
				System.out.println("Subject: " + mailBundle);
				System.out.println("From: " + getEmailAccount(conn,domain,mailer.getFrom()));
				System.out.println("To: " + getEmailAccount(conn,domain,mailer.getTo()));
				System.out.println("CC: " + getEmailAccount(conn,domain,mailer.getCC()));
				System.out.println("BCC: " + getEmailAccount(conn,domain,mailer.getBCC()));
				System.out.println("Campus: " + mailer.getCampus());
				System.out.println("Alpha: " + mailer.getAlpha());
				System.out.println("Num: " + mailer.getNum());
				logger.info("MailerDB: sendMail not enabled\n");
			}
		} catch (SendFailedException ex) {
			logger.fatal("MailerDB: sendMail\n" + ex.toString());
			success = false;
		} catch (Exception e) {
			logger.fatal("MailerDB: sendMail\n" + e.toString());
			success = false;
		}

		return success;
%>