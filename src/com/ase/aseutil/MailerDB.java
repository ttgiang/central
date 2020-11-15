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
//  MailerDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ase.aseutil.util.ZipUtilityDB;

/**
 * security constants
 */
public class MailerDB {

	static Logger logger = Logger.getLogger(MailerDB.class.getName());

	private boolean processed 		= false;

	private static String server 			= "";
	private static String sendMail 		= "";
	private static String sendMailDebug = "";
	private static String domain 			= "";
	private static String mailName 		= "";
	private static String mailAccess		= "";
	private static String testSystem 	= "";
	private static String href 			= "";
	private static String smtp 			= "";
	private static String attachment		= "";

	public MailerDB(){}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,String from,String campus,String properties,int route,String owner) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(from);
			mailer.setCC(from);
			mailer.setBCC(from);
			mailer.setAlpha("Test Alpha");
			mailer.setNum("Test Num");
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setId(route);
			mailer.setOwner(owner);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}


	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,String from,String campus,String properties,int route) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(from);
			mailer.setCC(from);
			mailer.setBCC(from);
			mailer.setAlpha("Test Alpha");
			mailer.setNum("Test Num");
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setId(route);
			mailer.setOwner("");
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,
							String from,
							String to,
							String cc,
							String bcc,
							String alpha,
							String num,
							String campus,
							String properties) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(to);
			mailer.setCC(cc);
			mailer.setBCC(bcc);
			mailer.setAlpha(alpha);
			mailer.setNum(num);
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,
							String from,
							String to,
							String cc,
							String bcc,
							String alpha,
							String num,
							String campus,
							String properties,
							String kix) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(to);
			mailer.setCC(cc);
			mailer.setBCC(bcc);
			mailer.setAlpha(alpha);
			mailer.setNum(num);
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setKix(kix);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,
							String from,
							String to,
							String cc,
							String bcc,
							String alpha,
							String num,
							String campus,
							String properties,
							String kix,
							String owner) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(to);
			mailer.setCC(cc);
			mailer.setBCC(bcc);
			mailer.setAlpha(alpha);
			mailer.setNum(num);
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setKix(kix);
			mailer.setOwner(owner);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,
							String from,
							String to,
							String cc,
							String bcc,
							String alpha,
							String num,
							String campus,
							String properties,
							String kix,
							int route) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(to);
			mailer.setCC(cc);
			mailer.setBCC(bcc);
			mailer.setAlpha(alpha);
			mailer.setNum(num);
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setKix(kix);
			mailer.setId(route);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB for exception
	 */
	public MailerDB(Connection conn,String campus,String kix,String from,String exception,String subject) {
		try {

			// intended for use with exception notifications only

			if (kix != null && kix.length() > 0){

				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String progress = info[Constant.KIX_PROGRESS];
				String subprogress = info[Constant.KIX_SUBPROGRESS];
				String courseTitle = info[Constant.KIX_COURSETITLE];
				int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

				String techSupport = SysDB.getSys(conn,"techSupport");

				if (techSupport != null && techSupport.length() > 0){
					Mailer mailer = new Mailer();
					mailer.setCampus(campus);
					mailer.setFrom(from);
					mailer.setTo(techSupport);
					mailer.setAlpha(alpha);
					mailer.setNum(num);
					mailer.setSubject("CC Exception: " + subject);
					mailer.setContent(subject
										+ Html.BR()
										+ Html.BR()
										+ "user: " + from + Html.BR()
										+ "campus: " + campus + Html.BR()
										+ "kix: " + kix + Html.BR()
										+ "alpha: " + alpha + Html.BR()
										+ "num: " + num + Html.BR()
										+ "route: " + route + Html.BR()
										+ "progress: " + progress + Html.BR()
										+ "subprogress: " + subprogress + Html.BR()
										+ "title: " + courseTitle + Html.BR()
										+ Html.BR()
										+ exception);
					mailer.setKix(kix);
					mailer.setPersonalizedMail(true);
					sendMail(conn,mailer,"");
				}

			} // kix
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * MailerDB
	 */
	public MailerDB(Connection conn,
							String from,
							String to,
							String cc,
							String bcc,
							String alpha,
							String num,
							String campus,
							String properties,
							String kix,
							int route,
							String owner) {

		try {
			Mailer mailer = new Mailer();
			mailer.setFrom(from);
			mailer.setTo(to);
			mailer.setCC(cc);
			mailer.setBCC(bcc);
			mailer.setAlpha(alpha);
			mailer.setNum(num);
			mailer.setCampus(campus);
			mailer.setSubject(properties);
			mailer.setKix(kix);
			mailer.setId(route);
			mailer.setOwner(owner);
			sendMail(conn,mailer,properties);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}
	}

	/**
	 * sendMail
	 * <p>
	 * @param	conn			Connection
	 * @param	mailer		Mailer
	 * <p>
	 */
	public MailerDB(Connection conn,Mailer mailer) {

		try {
			sendMail(conn,mailer,"");
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}

	}

	/**
	 * sendMail
	 * <p>
	 * @param	conn			Connection
	 * @param	mailer		Mailer
	 * @param	processed	boolean
	 * <p>
	 */
	public MailerDB(Connection conn,Mailer mailer,boolean processed) {

		try {
			this.processed = processed;
			sendMail(conn,mailer,mailer.getSubject());
			updateProcessFlag(conn,mailer.getId(),this.processed);
		} catch (Exception e) {
			logger.fatal("MailerDB: MailerDB - " + e.toString());
		}

	}

	/**
	 * config
	 */
	public void config(Connection conn) throws Exception {

		try{
			server = SysDB.getSys(conn,"server");
			sendMail = SysDB.getSys(conn,"sendMail");
			sendMailDebug = SysDB.getSys(conn,"sendMailDebug");
			domain = "@" + SysDB.getSys(conn,"domain");
			mailName = SysDB.getSys(conn,"mailName");
			mailAccess = SysDB.getSys(conn,"mailAccess");
			testSystem = SysDB.getSys(conn,"testSystem");
			href = SysDB.getSys(conn,"href");
			smtp = SysDB.getSys(conn,"smtp");
			attachment = SysDB.getSys(conn,"attachment");

			if (domain == null || domain.length() == 0){
				domain = Constant.SMTP_DOMAIN;
			}
		}
		catch(Exception e){
			logger.fatal("MailerDB - config - " + e.toString());
		}
	}

	/**
	 * sendMail
	 * <p>
	 * @param	conn			Connection
	 * @param	mailer		Mailer
	 * @param	mailBundle	String
	 * <p>
	 * @return	boolean
	 */
	public boolean sendMail(Connection conn,Mailer mailer,String mailBundle) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int i = 0;

		String content = "";
		String subject = "";
		String email = "";
		String sFrom = "";
		String sTO = "";
		String sToSaved = "";
		String sCC = "";
		String sCCSaved = "";
		String uid = "";

		String localHost = SysDB.getSys(conn,"localHost");
		String cctest = SysDB.getSys(conn,"testSystem");
		String central = SysDB.getSys(conn,"central");

		boolean hasMailToSend = false;
		boolean isTestSystem = false;
		boolean isAProgram = false;
		int rowsAffected = 0;

		String fileName = "";

		boolean personalizedMail = false;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"MailerDB");

			if (debug){
				logger.info("--------");
				logger.info("sendMail");
				logger.info("--------");
			}

			// ----------------------------------------------------------------------
			// when content and subject are available, we skip sending via bundle
			// ----------------------------------------------------------------------
			personalizedMail = mailer.getPersonalizedMail();

			String kix = AseUtil.nullToBlank(mailer.getKix());

			sFrom = AseUtil.nullToBlank(mailer.getFrom());

			String campus = AseUtil.nullToBlank(mailer.getCampus());

			// ----------------------------------------------------------------------
			// expand TO address from distribution
			// ----------------------------------------------------------------------
			sTO = AseUtil.nullToBlank(mailer.getTo()).toLowerCase();
			boolean isDistributionList = DistributionDB.isDistributionList(conn,campus,sTO);
			if (isDistributionList){
				sTO = DistributionDB.getDistributionMembers(conn,campus,sTO);
			}

			sToSaved = sTO;

			// ----------------------------------------------------------------------
			// expand CC address from distribution
			// ----------------------------------------------------------------------
			sCC = AseUtil.nullToBlank(mailer.getCC()).toLowerCase();
			if (sCC.equals("DAILY")){
				sCC = "";
			}
			else{
				isDistributionList = DistributionDB.isDistributionList(conn,campus,sCC);
				if (isDistributionList){
					sCC = DistributionDB.getDistributionMembers(conn,campus,sCC);
				}
			}

			sCCSaved = sCC;

			// ----------------------------------------------------------------------
			// other data
			// ----------------------------------------------------------------------
			String sBCC = AseUtil.nullToBlank(mailer.getBCC());
			String alpha = AseUtil.nullToBlank(mailer.getAlpha());
			String num = AseUtil.nullToBlank(mailer.getNum());

			config(conn);

			if (debug){
				logger.info("campus: " + campus);
				logger.info("mailBundle: " + mailBundle);
				logger.info("personalizedMail: " + personalizedMail);
			} // debug

			// ----------------------------------------------------------------------
			// subject and content - using resource bundle (only if not personalized)
			// ----------------------------------------------------------------------
			if (!personalizedMail){
				String[] subjectAndContent = getEmailBundle(conn,campus,alpha,num,mailBundle,debug);
				subject = subjectAndContent[0];
				content = subjectAndContent[1];
			}
			else{
				subject = mailer.getSubject();
				content = mailer.getContent();
			}

			// -------------------------------------------------
			// set proper subject line message
			// -------------------------------------------------
			if (href.indexOf(testSystem) > -1 || testSystem.indexOf(Constant.LOCAL_SYSTEM) > -1){
				isTestSystem = true;
				subject = subject.replace("CC:","CC Test:");
			} // test system?

			// -------------------------------------------------------------------------------------
			// for outline approval, check to see if there are notes to include in message
			// for outline review, retrieve message if any
			// -------------------------------------------------------------------------------------
			if (!personalizedMail){
				String[] noteAndContent = getApprovalNoteAndContent(conn,kix,content,mailer,mailBundle,debug);
				String note = noteAndContent[0];
				content = noteAndContent[1];
			}

			Properties props = System.getProperties();
			props.put("mail.host", smtp);
			props.put("mail.transport.protocol", "smtp");

			Session mailSession = Session.getDefaultInstance(props, null);

			if (debug) logger.info("mailSession");

			if (debug) mailSession.setDebug(true);

			Message msg = new MimeMessage(mailSession);

			sFrom = getEmailAccount(conn,domain,sFrom.toLowerCase());

			msg.setFrom(new InternetAddress(sFrom));

			mailer.setSubject(subject);
			mailer.setContent(content);

			// -------------------------------------------------------------------------------------
			// permit test to send mail and over test flag
			// -------------------------------------------------------------------------------------
			String forceSendMailFromTestToRecipient =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ForceSendMailFromTestToRecipient");

			if (debug) logger.info("forceSendMailFromTestToRecipient");

			// -------------------------------------------------------------------------------------
			// permit test to send mail.
			// -------------------------------------------------------------------------------------
			String forceSendMailFromTest = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ForceSendMailFromTest");
			if (forceSendMailFromTest.equals(Constant.ON) && isTestSystem){

				// in test, everything goes to person online
				if(!forceSendMailFromTestToRecipient.equals(Constant.ON)){
					sTO = sFrom;
					sCC = sFrom;
				}

				sendMail = Constant.YES;
			}

			// -------------------------------------------------------------------------------------
			// if we are forcing mail to recipients, it's is treated like a prod system
			// -------------------------------------------------------------------------------------
			if(	isTestSystem &&
					forceSendMailFromTest.equals(Constant.ON) &&
					forceSendMailFromTestToRecipient.equals(Constant.ON)){

				isTestSystem = false;

			}

			if (debug){
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("from: " + sFrom);
				logger.info("to: " + sTO);
				logger.info("cc: " + sCC);
				logger.info("sendMail: " + sendMail);
				logger.info("sendMailDebug: " + sendMailDebug);
				logger.info("domain: " + domain);
				logger.info("mailName: " + mailName);
				logger.info("mailAccess: " + mailAccess);
				logger.info("server: " + server);
				logger.info("testSystem: " + testSystem);
				logger.info("href: " + href);
				logger.info("smtp: " + smtp);
				logger.info("attachment: " + attachment);
				logger.info("isTestSystem: " + isTestSystem);
				logger.info("hasMailToSend: " + hasMailToSend);
				logger.info("forceSendMailFromTest: " + forceSendMailFromTest);
				logger.info("forceSendMailFromTestToRecipient: " + forceSendMailFromTestToRecipient);
				logger.info("fileName: " + fileName);
			} // debug

			// -------------------------------------------------------------------------------------
			// with valid list of email addresses, send to only those wishing to receive mail
			// immediately. for those wanting to receive only 1 per day, they will be sent
			// manually by the system with note to see their task list.

			// for test system, if email is turned on, send mail only to the person
			// using the system at the time
			//
			// this block is for setting up email FROM/TO/CC only. Do not include any other mail items
			//
			// test section is concerned with sending all to 1 person only
			//
			// -------------------------------------------------------------------------------------
			if (isTestSystem){

				// in test, everything goes to person online unless overriden (forceSendMailFromTestToRecipient)
				if(forceSendMailFromTest.equals(Constant.ON) && !forceSendMailFromTestToRecipient.equals(Constant.ON)){
					sTO = sFrom;
					sCC = sFrom;
				}

				try{
					uid = mailer.getOwner().toLowerCase();
					if (uid == null || uid.equals(Constant.BLANK)){
						uid = sTO;
					}

					sTO = getEmailAccount(conn,domain,uid);

					if (uid != null && uid.length() > 0 && UserDB.getSendNow(conn,uid)){
						hasMailToSend = true;
						email = sTO;
						sCC = sTO;
						msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
					}
					else{
						mailer.setFrom(sTO);
						mailer.setTo(sTO);
						mailer.setCC("DAILY");
						logSentOnceMail(conn,mailer);
					}
					if (debug) logger.info("Testing by ("+mailBundle+"): " + sFrom + " to " + sTO);
				}
				catch(Exception exTO){
					logger.info("TO ADDRESS ERROR: (" + sTO + ")\n"
						+ exTO.toString()
						+ "\n"
						+ sTO);
				}
			}
			else{

				//------------------------------------------------------------
				// set up real email address
				//------------------------------------------------------------

				if (sTO != null && sTO.length() > 0 ){
					sTO = createMailNameList(conn,domain,sTO);

					if (debug) logger.info("prod mail - to: " + sTO);

					String[] to = sTO.toLowerCase().split(",");

					for (i=0; i<to.length; i++) {
						try{

							if (to[i].indexOf("@") > -1){
								email = to[i];
							}
							else{
								email = getEmailAccount(conn,domain,to[i]);
							}

							if (debug) logger.info("to email: " + email);

							// add email address to mailer
							if (email.length() > 0 && UserDB.getSendNowWithEmail(conn,campus,email)){
								hasMailToSend = true;
								msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
							}
							else{
								sTO = sTO.replace(to[i]+",","");
								sTO = sTO.replace(to[i],"");
								mailer.setFrom(sFrom);
								mailer.setTo(email);
								mailer.setCC("DAILY");
								logSentOnceMail(conn,mailer);
							}

						}
						catch(Exception exTO){
							logger.info("TO ADDRESS ERROR: (" + sTO + ")\n"
								+ exTO.toString()
								+ "\n"
								+ to[i]);
						}
					} // for
				} // if sTO

				// sCC eMails
				if (sCC != null && sCC.length() > 0 ){
					sCC = createMailNameList(conn,domain,sCC);
					String[] cc = sCC.toLowerCase().split(",");
					for (i=0; i<cc.length; i++) {
						try{

							if (cc[i].indexOf("@") > -1){
								email = cc[i];
							}
							else{
								email = getEmailAccount(conn,domain,cc[i]);
							}

							if (debug) logger.info("cc email: " + email);

							if (email.length() > 0 && UserDB.getSendNowWithEmail(conn,campus,email)){
								hasMailToSend = true;
								msg.addRecipient(Message.RecipientType.CC,new InternetAddress(email));
							}
							else{
								sCC = sCC.replace(cc[i]+",","");
								sCC = sCC.replace(cc[i],"");
								mailer.setFrom(sFrom);
								mailer.setTo(email);
								mailer.setCC("DAILY");
								logSentOnceMail(conn,mailer);
							}
						}
						catch(Exception exCC){
							logger.info("CC ADDRESS ERROR: (" + sCC + ")\n"
								+ exCC.toString()
								+ "\n"
								+ cc[i] );
						}
					} // for
				} // if CC
			} // testSystem

			sTO = sTO.replace(",,",",");

			// -------------------------------------------------------------------------------------
			// final check
			// email accounts already set. this is just for debugging output
			// -------------------------------------------------------------------------------------
			if (isTestSystem){
				if(forceSendMailFromTest.equals(Constant.ON) && !forceSendMailFromTestToRecipient.equals(Constant.ON)){
					sCC = sTO;
				}
			}
			else{
				if (sCC != null && sCC.length() > 0){
					sCC = sCC.replace(",,",",");
				}
			} // isTestSystem

			// -------------------------------------------------------------------------------------
			// forceMail was meant for use in test and the defect system.
			// it allows the override of system setting to send mail from test
			// -------------------------------------------------------------------------------------
			String mailCategory = AseUtil.nullToBlank(mailer.getCategory());
			if(mailer.getForceMail() && mailCategory.equals(Constant.DEFECT)){
				sendMail = Constant.YES;
			}

			// -------------------------------------------------------------------------------------
			// hasMailToSend = true only when there is someone to send to. This is necessary
			// since users may opt to have mail sent only once per day. if so, coming here
			// will cause to/cc to be empty
			// -------------------------------------------------------------------------------------
			if ((sendMail.equals(Constant.YES) || sendMail.equals(Constant.ON)) && hasMailToSend){
				try{
					// message
					msg.setSubject(subject);
					msg.setHeader("X-Mailer","sendhtml");
					msg.setSentDate(new java.util.Date());

					// content (body)
					MimeBodyPart bodyPart = new MimeBodyPart();
					bodyPart.setContent(content,"text/html");

					// combine all to send
					MimeMultipart mp = new MimeMultipart();
					mp.setSubType("related");
					mp.addBodyPart(bodyPart);

					//
					// attachments
					//
					if (attachment.equals(Constant.ON) && UserDB.getUserAttachment(conn, sToSaved)){

						if (debug) logger.info("processing attachment");

						fileName = processAttachment(conn,campus,kix,sFrom);
						if (fileName != null && fileName.length() > 0){
							MimeBodyPart attachmentPart = new MimeBodyPart();
							FileDataSource fds = new FileDataSource(fileName);
							attachmentPart.setDataHandler(new DataHandler(fds));
							attachmentPart.setFileName(fds.getName());
							mp.addBodyPart(attachmentPart);
						} // fileName

					} // attachment

					msg.setContent(mp);

					Transport.send(msg);
					if (debug) logger.info("mail transported");

				}
				catch(SendFailedException e){
					logger.info("SEND MAIL ERROR (SendFailedException): " + e.toString()
					 	+ "\nFROM: "
						+ sFrom
 						+ "\nTO: "
						+ sTO);
				}
				catch(javax.mail.MessagingException e){
					logger.info("SEND MAIL ERROR (MessagingException): " + e.toString()
					 	+ "\nFROM: "
						+ sFrom
 						+ "\nTO: "
						+ sTO);
				}
				catch(Exception e){
					logger.info("SEND MAIL ERROR (Exception): " + e.toString()
					 	+ "\nFROM: "
						+ sFrom
 						+ "\nTO: "
						+ sTO);
				}
			} // if send mail

			// -------------------------------------------------------------------------------------
			// clean up our override
			// -------------------------------------------------------------------------------------
			if(mailer.getForceMail() && mailCategory.equals(Constant.DEFECT)){
				sendMail = Constant.NO;
			}

			if (debug){
				logger.info("------------------------- AFTER");
				logger.info("from: " + sFrom);
				logger.info("to: " + sTO);
				logger.info("cc: " + sCC);
				logger.info("sendMail: " + sendMail);
				logger.info("sendMailDebug: " + sendMailDebug);
				logger.info("mailName: " + mailName);
				logger.info("mailAccess: " + mailAccess);
				logger.info("testSystem: " + testSystem);
				logger.info("personalizedMail: " + personalizedMail);
				logger.info("isTestSystem: " + isTestSystem);
				logger.info("hasMailToSend: " + hasMailToSend);
				logger.info("forceSendMailFromTest: " + forceSendMailFromTest);
				logger.info("forceSendMailFromTestToRecipient: " + forceSendMailFromTestToRecipient);
				logger.info("fileName: " + fileName);
			} // debug

			// -------------------------------------------------------------------------------------
			// this is here even in testing to show that mail logging to history is working
			// -------------------------------------------------------------------------------------
			if (hasMailToSend){
				mailer.setFrom(getEmailAccount(conn,domain,sFrom));
				mailer.setTo(getEmailAccount(conn,domain,sTO));
				mailer.setCC(getEmailAccount(conn,domain,sCC));
				mailer.setAttachment(fileName);
				AseUtil.logMail(conn,mailer,1);

				AseUtil.logAction(conn,
										sFrom.toUpperCase().replace("@HAWAII.EDU",""),
										"ACTION",
										subject + " (" + sTO.toUpperCase().replace("@HAWAII.EDU","") + ")",
										alpha,
										num,
										campus,
										kix);
			}

			if (debug) logger.info("-------------------- sendMail END");
		}
		catch(SendFailedException e){
			logMailToSend(conn,sFrom,sTO,sCC,subject,content);
			logger.fatal("MailerDB - sendMail - SendFailedException: " + e.toString() + "\n");
			mailer.setFrom(getEmailAccount(conn,domain,sFrom));
			mailer.setTo(getEmailAccount(conn,domain,sTO));
			mailer.setCC(getEmailAccount(conn,domain,sCC));
			mailer.setAttachment(fileName);
			logger.fatal(mailer);
		}
		catch(javax.mail.MessagingException e){
			logMailToSend(conn,sFrom,sTO,sCC,subject,content);
			logger.fatal("MailerDB - sendMail - MessagingException: " + e.toString() + "\n");
			mailer.setFrom(getEmailAccount(conn,domain,sFrom));
			mailer.setTo(getEmailAccount(conn,domain,sTO));
			mailer.setCC(getEmailAccount(conn,domain,sCC));
			mailer.setAttachment(fileName);
			logger.fatal(mailer);
		}
		catch(Exception e){
			logMailToSend(conn,sFrom,sTO,sCC,subject,content);
			logger.fatal("MailerDB - sendMail - Exception: " + e.toString() + "\n");
			mailer.setFrom(getEmailAccount(conn,domain,sFrom));
			mailer.setTo(getEmailAccount(conn,domain,sTO));
			mailer.setCC(getEmailAccount(conn,domain,sCC));
			mailer.setAttachment(fileName);
			logger.fatal(mailer);
		}

		return true;
	}

	/**
	 * logMailToSend
	 * <p>
	 * determine if we are working with property files or database for email content and subject line.
	 * <p>
	 * @param	conn		Connection
	 * @param	mailer	Mailer
	 * @param	from		String
	 * @param	to			String
	 * @param	cc			String
	 * @param	subject	String
	 * @param	content	String
	 * <p>
	 * @return	void
	 */
	public void logMailToSend(Connection conn,String from,String to,String cc,String subject,String content) throws Exception {

		Mailer mailer = new Mailer();
		mailer.setFrom(from);
		mailer.setTo(to);
		mailer.setCC(cc);
		mailer.setSubject(subject);
		mailer.setContent(content);
		AseUtil.logMail(conn,mailer);

	}

	/**
	 * getApprovalNoteAndContent
	 * <p>
	 * determine if we are working with property files or database for email content and subject line.
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	content		String
	 * @param	mailer		Mailer
	 * @param	mailBundle	String
	 * @param	debug			boolean
	 * <p>
	 * @return	String[]
	 */
	public String[] getApprovalNoteAndContent(Connection conn,
												String kix,
												String content,
												Mailer mailer,
												String mailBundle,
												boolean debug) throws Exception {

		String[] noteAndContent = new String[2];

		int rowsAffected = 0;

		String note = "";

		if (mailBundle.equals("emailOutlineApprovalRequest") && mailer.getId() > 0){

			note = IniDB.getNote(conn,mailer.getId());
			if (note != null && note.length() > 0){
				content = content + "<br/><br/>" + note;
			}

		}
		else if (mailBundle.equals("emailReviewerInvite")){

			String getMiscNote = MiscDB.getMiscNote(conn,kix,mailBundle);
			if (getMiscNote != null && getMiscNote.length() > 0){
				content = getMiscNote + "<br/><br/>" + content;
			}

			rowsAffected = MiscDB.deleteMiscNote(conn,kix,mailBundle);

		}
		else if (mailBundle.equals("emailNotifiedWhenRename")){

			//
			// included the new course alpha/number in the email (DF00111 - Manoa)
			//
			// for a rename, the original (from alpha/num) was already renamed before reaching
			// here so we cannot rely on kix for our key values because they no longer exist
			// rely on the ANT for what we need but T (type) is always going to be PRE
			//
			String getMiscNote = MiscDB.getMiscNote(conn,
																mailer.getCampus(),
																mailer.getAlpha(),
																mailer.getNum(),
																Constant.PRE,
																mailBundle);
			if (getMiscNote != null && getMiscNote.length() > 0){
				content = content.replace("was renamed or renumbered.","was renamed or renumbered.<br/><br/>" + getMiscNote);
			}

			rowsAffected = MiscDB.deleteMiscNote(conn,
																mailer.getCampus(),
																mailer.getAlpha(),
																mailer.getNum(),
																Constant.PRE,
																mailBundle);

		}
		else if (mailBundle.equals("emailRenameRenumberApproverInvite")){

			// NOT USED at this time.

			String getMiscNote = MiscDB.getMiscNote(conn,kix,Constant.COURSE_RENAME_TEXT);
			if (getMiscNote != null && getMiscNote.length() > 0){
				content = content + "<br/><br/>" + getMiscNote;
			}

			rowsAffected = MiscDB.deleteMiscNote(conn,kix,Constant.COURSE_RENAME_TEXT);

		} // emailOutlineApprovalRequest

		noteAndContent[0] = note;
		noteAndContent[1] = content;

		return noteAndContent;
	}

	/**
	 * getEmailBundle
	 * <p>
	 * determine if we are working with property files or database for email content and subject line.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	from		String
	 * @param	mailBundle	String
	 * @param	debug			boolean
	 * <p>
	 * @return	String[]
	 */
	public String[] getEmailBundle(Connection conn,String campus,String alpha,
												String num,
												String mailBundle,
												boolean debug) throws Exception {

		String[] subjectAndContent = new String[2];
		String subject = "";
		String content = "";

		// subject line and email content comes from either a properties file or a database table.
		// determine which then collect data.
		ResourceBundle emailBundle = null;
		if (mailBundle != null && mailBundle.length() > 0){

			// use database if prop returns as not null
			Props prop = PropsDB.getPropByCampusPropName(conn,campus,mailBundle);
			if (prop != null){

				if (debug) logger.info("using property config");

				subject = prop.getSubject();
				subject = subject.replace("[ALPHA]",alpha);
				subject = subject.replace("[NUM]",num);
				subject = "CC: " + subject;

				content = prop.getContent();
				content = content.replace("[ALPHA]",alpha);
				content = content.replace("[NUM]",num);

				content = content
							+ "<br><br>Log in to <a href=\"_href_\" target=\"_blank\">Curriculum Central</a>."
							+ "<br><br><strong>NOTE:</strong> This is an automated response. Do not reply to this message.";
			}
			else{
				emailBundle = ResourceBundle.getBundle("ase.central." + mailBundle);

				if (debug) logger.info("using bundle");

				subject = emailBundle.getString("mailSubject");
				subject = subject.replace("_alpha_",alpha);
				subject = subject.replace("_num_",num);

				content = emailBundle.getString("mailContent");
				content = content.replace("_alpha_",alpha);
				content = content.replace("_num_",num);
			}

			if (content != null && content.length() > 0){
				content = content.replace("_href_", href);
			}
		} // emailBundle

		subjectAndContent[0] = subject;
		subjectAndContent[1] = content;

		return subjectAndContent;
	}

	/**
	 * processAttachment
	 * <p>
	 * if attachment is turned on, determine whether to send a single document (course outline or program)
	 * or all related documents as well. Returns the filename to use for attachment.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	from		String
	 * <p>
	 * @return	String
	 */
	public String processAttachment(Connection conn,String campus,String kix,String from) throws Exception {

		String fileName = null;

		com.ase.aseutil.util.ZipUtilityDB zipDB = new com.ase.aseutil.util.ZipUtilityDB();

		// do we attach a single primary file or all related documents
		String attachRelatedDocuments = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AttachRelatedDocuments");
		if (attachRelatedDocuments.equals(Constant.ON)){
			com.ase.aseutil.util.ZipUtility zipUtility = new com.ase.aseutil.util.ZipUtility();
			zipUtility.setSource(Constant.BLANK);	// not use when kix is used
			zipUtility.setTarget(Constant.BLANK);	// default to temp folder
			zipUtility.setWildCard(kix + "*.*");
			zipUtility.setKix(kix);
			zipUtility.setUser(from.replace("",""));
			zipUtility.setCampus(campus);

			zipDB.zip(zipUtility);

			fileName = zipUtility.getTarget();
		}
		else{
			String documents = SysDB.getSys(conn,"documents");
			fileName = zipDB.createPrimaryDocument(conn,campus,documents,kix);
		}

		zipDB = null;

		return fileName;

	}

	public String processAttachmentOBSOLETE(Connection conn,String campus,String kix,String from) throws Exception {

		String fileName = null;

		// do we attach a single primary file or all related documents
		String attachRelatedDocuments = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AttachRelatedDocuments");
		if (attachRelatedDocuments.equals(Constant.ON)){
			com.ase.aseutil.util.ZipUtility zipUtility = new com.ase.aseutil.util.ZipUtility();
			zipUtility.setSource(Constant.BLANK);	// not use when kix is used
			zipUtility.setTarget(Constant.BLANK);	// default to temp folder
			zipUtility.setWildCard(kix + "*.*");
			zipUtility.setKix(kix);
			zipUtility.setUser(from.replace(domain,""));
			zipUtility.setCampus(campus);

			com.ase.aseutil.util.ZipUtilityDB zipDB = new com.ase.aseutil.util.ZipUtilityDB();
			zipDB.zip(zipUtility);

			fileName = zipUtility.getTarget();
		}
		else{
			String documents = SysDB.getSys(conn,"documents");
			fileName = ZipUtilityDB.createPrimaryDocument(conn,campus,documents,kix);
		}

		return fileName;

	}

	/**
	 * sendOnce
	 * <p>
	 * @param	conn			Connection
	 * @param	mailer		Mailer
	 * <p>
	 * @return	boolean
	 */
	public boolean sendOnce(Connection conn,Mailer mailer) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int i = 0;

		String email = "";

		String localHost = SysDB.getSys(conn,"localHost");
		String cctest = SysDB.getSys(conn,"testSystem");
		String central = SysDB.getSys(conn,"central");

		// NO CC on send once of daily notifications

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"MailerDB");

			String kix = AseUtil.nullToBlank(mailer.getKix());
			String sFrom = AseUtil.nullToBlank(mailer.getFrom());
			String sTO = AseUtil.nullToBlank(mailer.getTo());
			String campus = AseUtil.nullToBlank(mailer.getCampus());
			String content = "";
			String subject = "";

			config(conn);

			// set proper subject line message
			if (href.indexOf(cctest) > -1){
				subject = subject.replace("CC:","CC Test:");
			}

			Properties props = System.getProperties();
			props.put("mail.host", smtp);
			props.put("mail.transport.protocol", "smtp");

			if (debug) logger.info("MailerDB: sendOnce - got properties");

			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(true);

			if (debug) logger.info("MailerDB: sendOnce - got mail session");

			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(sFrom));

			if (sTO.indexOf(",") > -1){
				String[] to = sTO.toLowerCase().split(",");
				for (i=0; i<to.length; i++) {
					if (to[i] != null && to[i].length() > 0)
						msg.addRecipient(Message.RecipientType.TO,new InternetAddress(to[i]));
				}
			}
			else
				msg.addRecipient(Message.RecipientType.TO,new InternetAddress(sTO));

			if (debug) logger.info("MailerDB: sendOnce - TO - " + sTO);

			if (sendMail.equals("YES")){

				if (debug) logger.info("MailerDB: sendOnce - Send Mail is ON");

				msg.setSubject(subject);
				msg.setHeader("X-Mailer","sendhtml");
				msg.setSentDate(new java.util.Date());

				MimeMultipart mp = new MimeMultipart();
				mp.setSubType("related");
				MimeBodyPart bodyPart = new MimeBodyPart();

				ResourceBundle emailBundle = ResourceBundle.getBundle("ase.central.emailSendOnce");
				if (emailBundle != null){
					subject = emailBundle.getString("mailSubject");
					content = emailBundle.getString("mailContent");
					content = content.replace("_href_", href);
				}

				bodyPart.setContent(content,"text/html");
				mp.addBodyPart(bodyPart);
				msg.setContent(mp);

				try{
					Transport.send(msg);
					// we don't reset process flag. The user will log
					// in to confirm receipt of messages.
					// updateProcessFlag(conn,mailer.getId(),true);
				}
				catch(SendFailedException sfe){
					logger.fatal("MailerDB - sendOnce - SendFailedException: " + sTO + " - " + sfe.toString() );
				}
			}
		}
		catch(Exception ce){
			logger.fatal("MailerDB - sendOnce - ConnectException: " + ce.toString() );
		}

		return true;
	}

	/**
	 * getEmailAccount
	 * <p>
	 * @param	conn		Connection
	 * @param	domain	Connection
	 * @param	account	String
	 * <p>
	 */
	public static String getEmailAccount(Connection conn,String domain,String account){

		//Logger logger = Logger.getLogger("test");

		String email = account.toLowerCase();
		String temp = "";

		//
		//	if a comma is in the list sent, tokenize and create for all
		//

		try{
			User udb = null;

			if (account != null && account.length() > 0 && account.indexOf("@") < 0) {

				if (domain==null || domain.length()==0){
					domain = Constant.SMTP_DOMAIN;
				}

				// are we working with multi users in this list of recipients
				if (account.indexOf(",") > -1){

					String thisMail = "";

					String[] to = new String[100];

					to = account.toLowerCase().split(",");

					email = "";

					for (int i=0; i<to.length; i++) {

						temp = to[i].trim();

						udb = UserDB.getUserByName(conn,temp);
						if (udb != null){
							thisMail = udb.getEmail();

							// in case user did not include correct format for mail
							if (thisMail.indexOf("@") < 0){
								thisMail = thisMail + domain;
							}

							if (i==0)
								email = thisMail;
							else
								email = email + "," + thisMail;
						} // if udb
					} // for
				}
				else{
					udb = UserDB.getUserByName(conn,account);
					if (udb != null){
						email = udb.getEmail();

						// in case user have not logged in and configured account
						if (email.indexOf("@") < 0){
							email = account + domain;
						}

					}
				}
			}

			udb = null;

		} catch (Exception e) {
			logger.fatal("MailerDB: getEmailAccount ("+account+") - " + e.toString());
		}

		return email;
	} // MailerDB.getEmailAccount

	/**
	 * addAtachments
	 */
	protected void addAtachments(String[] attachments,Multipart multipart) throws MessagingException, AddressException {

		try {
			for (int i = 0; i <= attachments.length - 1; i++) {
				String filename = attachments[i];
				MimeBodyPart attachmentBodyPart = new MimeBodyPart();

				// use a JAF FileDataSource as it does MIME type detection
				DataSource source = new FileDataSource(filename);
				attachmentBodyPart.setDataHandler(new DataHandler(source));

				// assume that the filename you want to send is the same as the
				// actual file name - could alter this to remove the file path
				attachmentBodyPart.setFileName(filename);

				// add the attachment
				multipart.addBodyPart(attachmentBodyPart);
			}
		} catch (Exception e) {
			logger.fatal("MailerDB: sendMailX - " + e.toString());
		}
	}

	/**
	 * getMail returns a single mail entry
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Mailer
	 */
	public static Mailer getMail(Connection conn,int id) {

		//Logger logger = Logger.getLogger("test");

		String sql = "SELECT * FROM tblMail WHERE id=?";
		Mailer mailer = null;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				AseUtil aseUtil = new AseUtil();
				mailer = new Mailer();
				mailer.setId(id);
				mailer.setFrom(AseUtil.nullToBlank(rs.getString("from")));
				mailer.setTo(AseUtil.nullToBlank(rs.getString("to")));
				mailer.setCC(AseUtil.nullToBlank(rs.getString("cc")));
				mailer.setBCC(AseUtil.nullToBlank(rs.getString("bcc")));
				mailer.setSubject(AseUtil.nullToBlank(rs.getString("subject")));
				mailer.setAlpha(AseUtil.nullToBlank(rs.getString("alpha")));
				mailer.setNum(AseUtil.nullToBlank(rs.getString("num")));
				mailer.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				mailer.setContent(AseUtil.nullToBlank(rs.getString("content")));
				mailer.setDte(aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME));
				mailer.setAttachment(AseUtil.nullToBlank(rs.getString("attachment")));
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("MailerDB: getMail - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: getMail - " + e.toString());
		}

		return mailer;
	}

	/**
	 * updateProcessFlag
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Mailer
	 */
	public static int updateProcessFlag(Connection conn,int id,boolean processed) {

		String sql = "UPDATE tblMail SET processed=? WHERE id=?";
		int rowsAffected = 0;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1,processed);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("MailerDB: updateProcessFlag - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: updateProcessFlag - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getSendMail - returns YES or NO
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return	String
	 */
	public static String getSendMail(Connection conn) {

		String sendMail = "";

		try{
			sendMail = SysDB.getSys(conn,"sendMail");
			if (sendMail != null){
				if (sendMail.equals("YES"))
					sendMail = "<b>YES</b> | <a href=\"?mail=0\" class=\"linkcolumn\">NO</a>";
				else
					sendMail = "<a href=\"?mail=1\" class=\"linkcolumn\">YES</a> | <b>NO</b>";
			}
		} catch (Exception e) {
			logger.fatal("MailerDB: getSendMail - " + e.toString());
		}

		return sendMail;
	}

	/**
	 * createMailNameList
	 * <p>
	 * @param	conn		Connection
	 * @param	domain	String
	 * @param	mail		String
	 * <p>
	 * @return	String
	 */
	public static String createMailNameList(Connection conn,String domain,String mail) throws Exception {

		// takes list of names with/without domain and create proper email accounts
		// including domain

		//Logger logger = Logger.getLogger("test");

		String emailList = "";
		String email = "";

		int i = 0;

		try{
			if (mail != null && mail.length() > 0 ){

				String[] people = mail.toLowerCase().split(",");

				for (i=0; i<people.length; i++) {

					if (people[i] != null && people[i].length() > 0){

						if (people[i].indexOf("@") < 0){
							email = getEmailAccount(conn,domain,people[i]);
						}
						else{
							email = people[i];
						}

						if (Validation.isValidEmail(email)){
							if (emailList.equals(Constant.BLANK))
								emailList = email;
							else
								emailList = emailList + "," + email;
						} // validation email

					} // if people

				} // for
			} // mail != null
		}
		catch(Exception e){
			logger.fatal("MailerDB - createMailNameList: " + e.toString());
		}

		return emailList;
	}

	/**
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logMail(Connection conn, Mailer mailer, int processed) {

		AseUtil.logMail(conn,mailer,processed);

	}

	/**
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logSentOnceMail(Connection conn, Mailer mailer) {

		try {

			String campus = mailer.getCampus();
			String subject = mailer.getSubject();
			String alpha = mailer.getAlpha();
			String num = mailer.getNum();

			String kix = Helper.getKix(conn,campus,alpha,num,"");
			if (kix == null || (Constant.BLANK).equals(kix)){
				subject = subject + " - " + alpha;
				alpha = "";
				num = "";
			}

			PreparedStatement ps = conn.prepareStatement(
					"INSERT INTO tblMail ([from],[to],cc,bcc,subject,alpha,num,campus,dte,content,processed) "
				+	"VALUES(?,?,?,?,?,?,?,?,?,?,?) ");
			ps.setString(1, mailer.getFrom());
			ps.setString(2, mailer.getTo());
			ps.setString(3, mailer.getCC());
			ps.setString(4, mailer.getBCC());
			ps.setString(5, subject);
			ps.setString(6, alpha);
			ps.setString(7, num);
			ps.setString(8, campus);
			ps.setString(9, AseUtil.getCurrentDateTimeString());
			ps.setString(10, mailer.getContent());
			ps.setInt(11,0);
			int rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("AseUtil: logSentOnceMail - " + e.toString());
		}
	}

	/**
	 * deleteSendOnce
	 * <p>
	 * @param	conn	Connection
	 * @param	user	String
	 * <p>
	 * @return	int
	 */
	public static int deleteSendOnce(Connection conn,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblMail WHERE cc='DAILY' AND [to]=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("MailerDB: deleteSendOnce - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: deleteSendOnce - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * sendMailOnce
	 * <p>
	 * @param	conn		Connection
	 * @param	session	javax.servlet.http.HttpSession
	 * @param	testRun	boolean
	 * <p>
	 * @return	String[]
	 */
	public static String[] sendMailOnce(Connection conn,javax.servlet.http.HttpSession session,boolean testRun) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = DebugDB.getDebug(conn,"MailerDB");

		String user = "";
		String campus = "";

		StringBuffer sb = new StringBuffer();

		int mailProcessed = 0;

		try {
			if (debug) logger.info("MailerDB: sendMailOnce - START");

			String systemEmail = SysDB.getSys(conn,"systemEmail");

			if (systemEmail != null && systemEmail.length() > 0){

				if (debug) {
					logger.info("systemEmail - " + systemEmail);
					logger.info("testRun - " + testRun);
				}

				MailerDB mailerDB = new MailerDB();
				Mailer mailer = new Mailer();

				// all the people to notify
				// select distinct to send only 1 per person.
				String sql = "SELECT DISTINCT [to],campus FROM tblMail WHERE processed=0 AND cc='DAILY' ORDER BY campus,[to]";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					user = AseUtil.nullToBlank(rs.getString("to"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					mailer.setFrom(systemEmail);
					mailer.setTo(user);
					mailer.setCampus(campus);
					if (!testRun){
						mailerDB.sendOnce(conn,mailer);

						AseUtil.logAction(conn,
												user,
												"ACTION",
												"Daily notification",
												"",
												"",
												campus,
												"");
					}

					sb.append(campus + " - " + user + Html.BR());

					++mailProcessed;

				}	// while
			}	// if

			if (debug) logger.info("MailerDB: sendMailOnce - END");

		} catch (SQLException se) {
			logger.fatal("MailerDB: sendMailOnce - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: sendMailOnce - " + e.toString());
		}

		String[] rtn = new String[2];

		rtn[0] = "" + mailProcessed;
		rtn[1] = sb.toString();

		return rtn;
	}

	/**
	 * confirmNotification
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	int
	 */
	public static int confirmNotification(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = DebugDB.getDebug(conn,"MailerDB");

		int rowsAffected = 0;

		try {
			String domain = "@" + SysDB.getSys(conn,"domain");

			if (domain == null || domain.length() == 0)
				domain = Constant.SMTP_DOMAIN;

			domain = user + domain;

			String sql = "UPDATE tblMail SET processed=1,cc=NULL WHERE processed=0 AND cc='DAILY' AND [to]=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,domain);
			rowsAffected = ps.executeUpdate();
			ps.close();

			int tasksAffected = TaskDB.logTask(conn,user,user,"","",Constant.MAIL_LOG_TEXT,campus,"","REMOVE","PRE");

			if (debug) logger.info("MailerDB - confirmNotification - " + user + " confirmed " + rowsAffected + " messages");

		} catch (SQLException se) {
			logger.fatal("MailerDB: confirmNotification - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: confirmNotification - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * showMailLog
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	from			String
	 * @param	to				String
	 * @param	cc				String
	 * @param	subject		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	activity		String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> showMailLog(Connection conn,
															String campus,
															String from,
															String to,
															String cc,
															String subject,
															String alpha,
															String num,
															String activity) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			AseUtil ae = new AseUtil();

			genericData = new LinkedList<Generic>();

			from = ae.toSQL(from,1).replace("Null","").replace("'","");
			to = ae.toSQL(to,1).replace("Null","").replace("'","");
			cc = ae.toSQL(cc,1).replace("Null","").replace("'","");
			subject = ae.toSQL(subject,1).replace("Null","").replace("'","");
			alpha = ae.toSQL(alpha,1).replace("Null","").replace("'","");
			num = ae.toSQL(num,1).replace("Null","").replace("'","");
			activity = ae.toSQL(activity,1).replace("Null","").replace("'","");

			String sql = "SELECT id,[From],[To],cc,Subject,Alpha,Num,dte "
								+ "FROM tblmail "
								+ "WHERE campus=? "
								+ "AND [from] like '%"+from+"%' "
								+ "AND [to] like '%"+to+"%' "
								+ "AND [cc] like '%"+cc+"%' "
								+ "AND subject like '%"+subject+"%' "
								+ "AND alpha like '%"+alpha+"%' "
								+ "AND num like '%"+num+"%' "
								+ "AND convert(varchar,[dte],101) like '%"+activity+"%' "
								+ "ORDER BY ID desc ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				to = AseUtil.nullToBlank(rs.getString("to")).replace(",","<br/>");

				String id = AseUtil.nullToBlank(rs.getString("id"));

				id = "<a href=\"maillogx.jsp?lid="+id+"\" onClick=\"return hs.htmlExpand(this, { objectType: \'ajax\',width:600} )\" class=\"linkcolumn\">"
							+ AseUtil.nullToBlank(rs.getString("id"))
							+ "</a>";


				genericData.add(new Generic(
										id,
										AseUtil.nullToBlank(rs.getString("from")),
										to,
										AseUtil.nullToBlank(rs.getString("cc")),
										AseUtil.nullToBlank(rs.getString("subject")),
										AseUtil.nullToBlank(rs.getString("alpha")),
										AseUtil.nullToBlank(rs.getString("num")),
										ae.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME),
										"",
										""
									));
			} // while
			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("UserLog: showMailLog - " + e.toString());
		} catch (Exception e) {
			logger.fatal("UserLog: showMailLog - " + e.toString());
		}

		return genericData;
	}

}
