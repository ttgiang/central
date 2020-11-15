<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

<%@ page import="javax.activation.DataHandler"%>
<%@ page import="javax.activation.DataSource"%>
<%@ page import="javax.activation.FileDataSource"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.MessagingException"%>
<%@ page import="javax.mail.Multipart"%>
<%@ page import="javax.mail.SendFailedException"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.AddressException"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>

<%@ page import="com.ase.aseutil.util.ZipUtilityDB"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "VIET";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "515h17i11209";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		Mailer mailer = new Mailer();
		mailer.setFrom(user);
		mailer.setTo("TEST,KOMENAKA2,KOMENAKA,BKG,DEBIE,HOTTA");
		mailer.setCC(null);
		mailer.setBCC(null);
		mailer.setAlpha(alpha);
		mailer.setNum(num);
		mailer.setCampus(campus);
		mailer.setSubject("emailOutlineApprovalRequest");
		mailer.setKix(kix);
		mailer.setOwner(user);
		sendMail(conn,mailer,"emailOutlineApprovalRequest");
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	private static String sendMail 		= "";
	private static String sendMailDebug = "";
	private static String domain 			= "";
	private static String mailName 		= "";
	private static String mailAccess		= "";
	private static String testSystem 	= "";
	private static String href 			= "";
	private static String smtp 			= "";
	private static String attachment		= "";
	private static String server 			= "";

	/**
	 * config
	 */
	public void config(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

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

			if (domain == null || domain.length() == 0)
				domain = Constant.SMTP_DOMAIN;
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

		Logger logger = Logger.getLogger("test");

		int i = 0;

		String content = "";
		String subject = "";
		String email = "";
		String sFrom = "";
		String sTO = "";
		String sToSaved = "";
		String sCC = "";
		String uid = "";

		String localHost = SysDB.getSys(conn,"localHost");
		String cctest = SysDB.getSys(conn,"testSystem");
		String central = SysDB.getSys(conn,"central");

		boolean hasMailToSend = false;
		boolean isTestSystem = false;
		boolean isAProgram = false;
		int rowsAffected = 0;

		boolean personalizedMail = false;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"MailerDB");

			if (debug) logger.info("-------------------- sendMail START");

			// when content and subject are available, we skip sending via bundle
			personalizedMail = mailer.getPersonalizedMail();

			String kix = AseUtil.nullToBlank(mailer.getKix());

			sFrom = AseUtil.nullToBlank(mailer.getFrom());

			String campus = AseUtil.nullToBlank(mailer.getCampus());

			sTO = AseUtil.nullToBlank(mailer.getTo()).toLowerCase();
			boolean isDistributionList = DistributionDB.isDistributionList(conn,campus,sTO);
			if (isDistributionList){
				sTO = DistributionDB.getDistributionMembers(conn,campus,sTO);
			}

			sToSaved = sTO;

			sCC = AseUtil.nullToBlank(mailer.getCC()).toLowerCase();
			isDistributionList = DistributionDB.isDistributionList(conn,campus,sCC);
			if (isDistributionList){
				sCC = DistributionDB.getDistributionMembers(conn,campus,sCC);
			}

			String sBCC = AseUtil.nullToBlank(mailer.getBCC());
			String alpha = AseUtil.nullToBlank(mailer.getAlpha());
			String num = AseUtil.nullToBlank(mailer.getNum());

			config(conn);

			//debug = false;
			//isTestSystem = false;
			//sendMail = "YES";
			//href = "http://www.cnn.com";
			//testSystem = "http://www.yahoo.com";

			// ----------------------------------------------------------------------
			// subject and content - using resource bundle (only if not personalized)
			// ----------------------------------------------------------------------
			if (!personalizedMail){
				String[] subjectAndContent = getSubjectAndContent(conn,campus,alpha,num,mailBundle,debug);
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

			// for outline approval, check to see if there are notes to include in message
			// for outline review, retrieve message if any
			if (!personalizedMail){
				String[] noteAndContent = getApprovalNoteAndContent(conn,kix,content,mailer,mailBundle,debug);
				String note = noteAndContent[0];
				content = noteAndContent[1];
			}

			Properties props = System.getProperties();
			props.put("mail.host", smtp);
			props.put("mail.transport.protocol", "smtp");

			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(true);
			Message msg = new MimeMessage(mailSession);
			sFrom = getEmailAccount(conn,domain,sFrom.toLowerCase());
			msg.setFrom(new InternetAddress(sFrom));

			mailer.setSubject(subject);
			mailer.setContent(content);

			// with valid list of email addresses, send to only those wishing to receive mail
			// immediately. for those wanting to receive only 1 per day, they will be sent
			// manually by the system with note to see their task list.

			// for test system, if email is turned on, send mail only to the person
			// using the system at the time
			if (isTestSystem){
				try{
					uid = mailer.getOwner().toLowerCase();
					sTO = getEmailAccount(conn,domain,uid);
					if (uid != null && uid.length() > 0 && UserDB.getSendNow(conn,uid)){
						hasMailToSend = true;
						email = sTO;
						msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
					}
					else{
						mailer.setFrom(sTO);
						mailer.setTo(sTO);
						mailer.setCC("DAILY");
						logSentOnceMail(conn,mailer);
					}
					logger.info("Testing by: " + sFrom + " to " + sToSaved);
				}
				catch(Exception exTO){
					logger.info("TO ADDRESS ERROR: (" + sTO + ")\n"
						+ exTO.toString()
						+ "\n"
						+ sTO);
				}
			}
			else{
				if (sTO != null && sTO.length() > 0 ){
					sTO = createMailNameList(conn,domain,sTO);
					String[] to = sTO.toLowerCase().split(",");

					for (i=0; i<to.length; i++) {
						try{
							uid = to[i].substring(0,to[i].indexOf("@"));
							email = getEmailAccount(conn,domain,uid);

							if (uid != null && uid.length() > 0 && UserDB.getSendNow(conn,uid)){
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
				}

System.out.println(sTO);

				// sCC eMails
				if (sCC != null && sCC.length() > 0 ){
					sCC = createMailNameList(conn,domain,sCC);
					String[] cc = sCC.toLowerCase().split(",");
					for (i=0; i<cc.length; i++) {
						try{
							uid = cc[i].substring(0,cc[i].indexOf("@"));
							email = getEmailAccount(conn,domain,uid);
							if (uid != null && uid.length() > 0 && UserDB.getSendNow(conn,uid)){
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

			if (sCC != null && sCC.length() > 0){
				sCC = sCC.replace(",,",",");
			}

			// hasMailToSend = true only when there is someone to send to. This is necessary
			// since users may opt to have mail sent only once per day. if so, coming here
			// will cause to/cc to be empty
			if (sendMail.equals(Constant.YES) && hasMailToSend){
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

					// -------------------------------------------------
					// attachments
					// -------------------------------------------------
					if (attachment.equals(Constant.YES) && UserDB.getUserAttachment(conn, sToSaved)){

						String fileName = processAttachment(conn,campus,kix,sFrom);
						if (fileName != null && fileName.length() > 0){
							MimeBodyPart attachmentPart = new MimeBodyPart();
							FileDataSource fds = new FileDataSource(fileName);
							attachmentPart.setDataHandler(new DataHandler(fds));
							attachmentPart.setFileName(fds.getName());
							mp.addBodyPart(attachmentPart);
						} // fileName

						if (debug) logger.info("processing attachment");

					} // attachment

					msg.setContent(mp);

					// for testing purposes, turning on mailing to make sure it gets here
					// but not sending out depending on the SMTP.
					if (!smtp.toLowerCase().equals(Constant.SMTP_05045)){
//Transport.send(msg);
						if (debug) logger.info("mail transported");
					}
					else{
						if (debug) logger.info("***** mail not transported");
					} // smtp

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

			if (debug){
				logger.info("mailer: " + mailer);
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("from: " + sFrom);
				logger.info("to: " + sTO);
				logger.info("cc: " + sCC);
				logger.info("mailBundle: " + mailBundle);
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
				logger.info("personalizedMail: " + personalizedMail);
				logger.info("isTestSystem: " + isTestSystem);
				logger.info("hasMailToSend: " + hasMailToSend);
			} // debug

			// this is here even in testing to show that mail logging to history is working
			if (hasMailToSend){
				mailer.setFrom(getEmailAccount(conn,domain,sFrom));
				mailer.setTo(getEmailAccount(conn,domain,sTO));
				mailer.setCC(getEmailAccount(conn,domain,sCC));
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
			logger.fatal("MailerDB - sendMail - SendFailedException: " + e.toString() + "\n" + mailer);
		}
		catch(javax.mail.MessagingException e){
			logMailToSend(conn,sFrom,sTO,sCC,subject,content);
			logger.fatal("MailerDB - sendMail - MessagingException: " + e.toString() + "\n" + mailer);
		}
		catch(Exception e){
			logMailToSend(conn,sFrom,sTO,sCC,subject,content);
			logger.fatal("MailerDB - sendMail - Exception: " + e.toString() + "\n" + mailer);
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
	public static String getEmailAccount(java.sql.Connection conn,String domain,String account){

		Logger logger = Logger.getLogger("test");

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

				if (account.indexOf(",") > -1){
					String[] to = new String[100];
					to = account.toLowerCase().split(",");
					email = "";
					String thisMail = "";
					for (int i=0; i<to.length; i++) {
						temp = to[i].trim();
						udb = UserDB.getUserByName(conn,temp);
						if (udb != null){
							thisMail = udb.getEmail();

							if (i==0)
								email = thisMail;
							else
								email = email + "," + thisMail;
						}
					}
				}
				else{
					udb = UserDB.getUserByName(conn,account);
					if (udb != null){
						email = udb.getEmail();
					}
				}
			}

		} catch (Exception e) {
			logger.fatal("MailerDB: getEmailAccount ("+account+") - " + e.toString());
		}

		return email;
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

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

		String[] noteAndContent = new String[2];

		int rowsAffected = 0;

		String note = "";

		if (mailBundle.equals("emailOutlineApprovalRequest") && mailer.getId() > 0){
			if (debug) logger.info("has note");

			note = IniDB.getNote(conn,mailer.getId());
			if (note != null && note.length() > 0){
				content = content + "<br/><br/>" + note;
			}
		}
		else if (mailBundle.equals("emailReviewerInvite")){
			if (debug) logger.info("has reviewer comments");

			String getReviewMisc = MiscDB.getReviewMisc(conn,kix);
			if (getReviewMisc != null && getReviewMisc.length() > 0){
				content = getReviewMisc + "<br/><br/>" + content;
				if (debug) logger.info("found reviewer comments");
			}

			rowsAffected = MiscDB.deleteReviewMisc(conn,kix);
		} // emailOutlineApprovalRequest

		noteAndContent[0] = note;
		noteAndContent[1] = content;

		return noteAndContent;
	}

	/**
	 * getSubjectAndContent
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
	public String[] getSubjectAndContent(Connection conn,
															String campus,
															String alpha,
															String num,
															String mailBundle,
															boolean debug) throws Exception {

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

		String fileName = null;

		// do we attach a single primary file or all related documents
		String attachRelatedDocuments = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AttachRelatedDocuments");
		if (attachRelatedDocuments.equals(Constant.YES)){
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

		Logger logger = Logger.getLogger("test");

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

			if ("YES".equals(sendMail)){

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
	 * addAtachments
	 */
	protected void addAtachments(String[] attachments,Multipart multipart) throws MessagingException, AddressException {

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

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
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logMail(Connection conn, Mailer mailer, int processed) {

		Logger logger = Logger.getLogger("test");

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"MailerDB");

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
			ps.setInt(11,processed);
			int rowsAffected = ps.executeUpdate();
			ps.close();
			if (debug) logger.info("AseUtil: logMail - mail sent - FROM: " + mailer.getFrom() + " TO: " + mailer.getTo());
		} catch (Exception e) {
			logger.fatal("AseUtil: logMail - " + e.toString());
		}
	}

	/**
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logSentOnceMail(Connection conn, Mailer mailer) {

		Logger logger = Logger.getLogger("test");

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

		Logger logger = Logger.getLogger("test");

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
	 * @return	int
	 */
	public static int sendMailOnce(Connection conn,javax.servlet.http.HttpSession session,boolean testRun) throws Exception {

		Logger logger = Logger.getLogger("test");

		boolean debug = DebugDB.getDebug(conn,"MailerDB");

		String user = "";
		String campus = "";

		int mailProcessed = 0;

		try {
			if (debug) logger.info("MailerDB: sendMailOnce - START");

			String systemEmail = SysDB.getSys(conn,"systemEmail");

			if (debug) logger.info("MailerDB: sendMailOnce - systemEmail - " + systemEmail);
			if (debug) logger.info("MailerDB: sendMailOnce - testRun - " + testRun);

			if (systemEmail != null && systemEmail.length() > 0){

				MailerDB mailerDB = new MailerDB();
				Mailer mailer = new Mailer();

				if (debug) logger.info("MailerDB: sendMailOnce - got mailer");

				//String sql = "SELECT id,[to],subject,campus FROM tblMail WHERE processed=0 AND cc='DAILY'";

				// all the people to notify
				// select distinct to send only 1 per person.
				String sql = "SELECT DISTINCT [to],campus FROM tblMail WHERE processed=0 AND cc='DAILY'";
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
						logger.info("MailerDB: sendMailOnce to - " + user);
					}
					else
						logger.info("MailerDB: sendMailOnce TEST to - " + user);

					++mailProcessed;

				}	// while
			}	// if

			if (debug) logger.info("MailerDB: sendMailOnce - END");

		} catch (SQLException se) {
			logger.fatal("MailerDB: sendMailOnce - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: sendMailOnce - " + e.toString());
		}

		return mailProcessed;
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

		Logger logger = Logger.getLogger("test");

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

			if (debug) logger.info("confirmNotification - " + user + " confirmed " + rowsAffected + " messages");

		} catch (SQLException se) {
			logger.fatal("MailerDB: confirmNotification - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MailerDB: confirmNotification - " + e.toString());
		}

		return rowsAffected;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>