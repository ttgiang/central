<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page session="true" buffer="16kb"%>

<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.text.*"%>
<%@ page import="java.naming.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.activation.*"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sndrx	- mailer
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String from = website.getRequestParameter(request,"from","");
	String to = website.getRequestParameter(request,"to","");
	String cc = website.getRequestParameter(request,"cc","");
	String subject = website.getRequestParameter(request,"subject","");
	String content = website.getRequestParameter(request,"content","");
	String smtp = website.getRequestParameter(request,"smtp","");
	String debug = website.getRequestParameter(request,"debug","0");
	String message = "";

	String kix = helper.getKix(conn,campus,"ENG","100","CUR");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "eMail";
	fieldsetTitle = "eMail";

	Logger logger = Logger.getLogger("test");

	if (from!=null && from.length()>0 && to!=null && to.length()>0){

		MailerDB mailerDB = new MailerDB();

		from = mailerDB.getEmailAccount(conn,"",from);
		to = mailerDB.getEmailAccount(conn,"",to);
		cc = mailerDB.getEmailAccount(conn,"",cc);

		if (Validation.isValidEmail(from) && Validation.isValidEmail(to)){
			System.out.println("-----------------------");
			System.out.println("from: " + from);
			System.out.println("to: " + to);
			System.out.println("cc: " + cc);
			System.out.println("subject: " + subject);
			System.out.println("content: " + content);
			System.out.println("smtp: " + smtp);
			System.out.println("debug: " + debug);

			//smtp = "mail.hawaii.edu";

			Properties props = System.getProperties();
			props.put("mail.host", smtp);
			props.put("mail.transport.protocol", "smtp");
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(true);
			Message mail = new MimeMessage(mailSession);
			mail.setFrom(new InternetAddress(from));
			mail.addRecipient(Message.RecipientType.TO,new InternetAddress(to));

			if (cc!=null && cc.length()>0){
				mail.addRecipient(Message.RecipientType.CC,new InternetAddress(cc));
			}

			mail.setSentDate(new java.util.Date());
			mail.setSubject(subject);
			mail.setText(content);

			if (!debug.equals(Constant.ON)){

				MimeBodyPart bodyPart = new MimeBodyPart();
				bodyPart.setContent(content,"text/html");

				MimeMultipart mp = new MimeMultipart();
				mp.setSubType("related");
				mp.addBodyPart(bodyPart);

				boolean attachment = true;

				if (attachment){
					String documentFolder = "";
					boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
					if (isAProgram){
						documentFolder = "programs";
					}
					else{
						documentFolder = "outlines";
					}

					String[] info = helper.getKixInfo(conn,kix);
					String alpha = info[Constant.KIX_ALPHA];
					String num = info[Constant.KIX_NUM];
					String type = info[Constant.KIX_TYPE];

					com.ase.aseutil.util.ZipUtility zipUtility = new com.ase.aseutil.util.ZipUtility();
					zipUtility.setSource(Constant.BLANK);	// not use when kix is used
					zipUtility.setTarget(Constant.BLANK);	// default to temp folder
					zipUtility.setWildCard(kix + "*.*");
					zipUtility.setKix(kix);
					zipUtility.setUser(user);
					zipUtility.setCampus(campus);

					com.ase.aseutil.util.ZipUtilityDB zipDB = new com.ase.aseutil.util.ZipUtilityDB();
					zipDB.zip(zipUtility);

					String filename = zipUtility.getTarget();

					// there is a chance that the file already exist but we want
					// to create from the most recent content
					File f = new File(filename);
					if (isAProgram){
						info = Helper.getKixInfo(conn,kix);
						String degree = info[Constant.KIX_PROGRAM_TITLE];
						String division = info[Constant.KIX_PROGRAM_DIVISION];
						Tables.createPrograms(campus,kix,degree,division);
					}
					else{
						Tables.createOutlines(campus,kix,alpha,num);
					}

					if (f.exists()){
						MimeBodyPart attachmentPart = new MimeBodyPart();
						FileDataSource fds = new FileDataSource(filename);
						attachmentPart.setDataHandler(new DataHandler(fds));
						attachmentPart.setFileName(fds.getName());
						mp.addBodyPart(attachmentPart);
						mail.setContent(mp);
					}

				} // debug

				try{
					Mailer mailer = new Mailer();
					mailer.setSubject(subject);
					mailer.setMessage(content);
					mailer.setFrom(from);
					mailer.setTo(to);
					mailer.setCC(cc);
					aseUtil.logMail(conn,mailer);

					Transport.send(mail);
				}
				catch(SendFailedException e){
					logger.info("MailerDB - SEND MAIL ERROR: " + e.toString()
					 	+ "\nFROM: "
						+ from
 						+ "\nTO: "
						+ to);
				}
				catch(javax.mail.MessagingException e){
					logger.info("MailerDB - SEND MAIL ERROR: " + e.toString()
					 	+ "\nFROM: "
						+ from
 						+ "\nTO: "
						+ to);
				}
				catch(Exception e){
					logger.info("MailerDB - SEND MAIL ERROR: " + e.toString()
					 	+ "\nFROM: "
						+ from
 						+ "\nTO: "
						+ to);
				}

			}

			message = "Mail was sent successfully (DEBUG="+debug+").<br/><br/>"
				+ "<font class=\"textblackth\">From:</font> <font class=\"datacolumn\">" + from + "</font><br/><br/>"
				+ "<font class=\"textblackth\">To:</font> <font class=\"datacolumn\">" + to + "</font><br/><br/>";
		}
		else{
			message = "Mail was not sent.<br/><br/>"
				+ "Check mail data and try again.";
		}
	}
	else{
		message = "Unable to process for transport.";
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="left"><%= message %></p>

<br/>

<div class="hr"></div>

<a href="sndr.jsp" class="linkcolumn">send another</a>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
