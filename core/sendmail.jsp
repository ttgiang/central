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

	Mailer mailer = new Mailer();
	mailer.setSubject("emailApproveOutline");

	mailer.setFrom("thanhg@hawaii.edu");
	mailer.setFrom("ttgiang@hawaii.rr.com");

	mailer.setTo("thanhg");
	mailer.setCC("ttgiang@yahoo.com,ttgiang@yahoo.com,ttgiang@yahoo.com");

	mailer.setAlpha(alpha);
	mailer.setNum(num);
	mailer.setCampus(campus);
	MailerDB m = new MailerDB();
	m.sendMail(conn,mailer,"emailApproveOutline");

	asePool.freeConnection(conn);
%>

<%!
	public boolean sendMail(Connection conn,Mailer mailer,String mailBundle) throws Exception {

Logger logger = Logger.getLogger("test");

		String localHost = "localhost";
		String nalo = "166.122.36.251";
		String central = "home.leeward.hawaii.edu";

		String content = "";
		String subject = "";
		String email = "";

		String sentTO = "";
		String sentCC = "";

		int i = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String kix = aseUtil.nullToBlank(mailer.getKix());
			String sTO = aseUtil.nullToBlank(mailer.getTo());
			String sFrom = aseUtil.nullToBlank(mailer.getFrom());
			String sBCC = aseUtil.nullToBlank(mailer.getBCC());
			String sCC = aseUtil.nullToBlank(mailer.getCC());
			String campus = aseUtil.nullToBlank(mailer.getCampus());
			String alpha = aseUtil.nullToBlank(mailer.getAlpha());
			String num = aseUtil.nullToBlank(mailer.getNum());

			String useMail = SysDB.getSys(conn,"sendMail");
			String useMailDebug = SysDB.getSys(conn,"sendMailDebug");
			String domain = "@" + SysDB.getSys(conn,"domain");
			String mailName = SysDB.getSys(conn,"mailName");
			String mailAccess = SysDB.getSys(conn,"mailAccess");
			String testSystem = SysDB.getSys(conn,"testSystem");
			String href = SysDB.getSys(conn,"href");
			String host = SysDB.getSys(conn,"smtp");

			//href = "http://localhost/central/core/cas.jsp";
			//href = "http://home.leeward.hawaii.edu/central/core/cas.jsp";
			//href = "http://166.122.36.251/central/core/cas.jsp";
			//String host = "mail.hawaii.edu";
			//String host = "smtp-server.hawaii.rr.com";

			ResourceBundle emailBundle = ResourceBundle.getBundle("ase.central." + mailBundle);
			if (emailBundle != null){
				subject = emailBundle.getString("mailSubject");
				subject = subject.replace("_alpha_",alpha);
				subject = subject.replace("_num_",num);
				content = emailBundle.getString("mailContent");
				content = content.replace("_href_", href);
				content = content.replace("_alpha_",alpha);
				content = content.replace("_num_",num);
			}

			// set proper subject line message
			if (href.indexOf(nalo) > -1){
				subject = subject.replace("CC:","CC Test:");
			}

			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");

			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(true);

			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(sFrom));

			if (sTO != null && sTO.length() > 0 ){
				String[] to = new String[100];
				to = sTO.toLowerCase().split(",");
				for (i=0; i<to.length; i++) {
					if (to[i].indexOf("@") < 0)
						email = getEmailAccount(conn,domain,to[i].trim());
					else
						email = to[i];

					if (Validation.isValidEmail(email)){
						if ("".equals(sentTO))
							sentTO = email;
						else
							sentTO = sentTO + "," + email;

						msg.addRecipient(Message.RecipientType.TO,new InternetAddress(email));
					}
				}
			}

			if (sCC != null && sCC.length() > 0 ){
				String[] cc = new String[100];
				cc = sCC.toLowerCase().split(",");
				for (i=0; i<cc.length; i++) {
					if (cc[i].indexOf("@") < 0)
						email = getEmailAccount(conn,domain,cc[i].trim());
					else
						email = cc[i];

					if (Validation.isValidEmail(email)){
						if ("".equals(sentCC))
							sentCC = email;
						else
							sentCC = sentCC + "," + email;

						msg.addRecipient(Message.RecipientType.CC,new InternetAddress(email));
					}
				}
			}

			msg.setSubject(subject);
			msg.setHeader("X-Mailer","sendhtml");
			msg.setSentDate(new java.util.Date());

			MimeMultipart mp = new MimeMultipart();
			mp.setSubType("related");
			MimeBodyPart mbp = new MimeBodyPart();
			mbp.setContent(content,"text/html");
			mp.addBodyPart(mbp);
			msg.setContent(mp);
			Transport.send(msg);

			logger.info("----------------------");
			logger.info("Date: " + AseUtil.getCurrentDateTimeString());
			logger.info("bundle: " + Constant.ASE_PROPERTIES);
			logger.info("domain: " + domain);
			logger.info("host: " + host);
			logger.info("href: " + href);
			logger.info("MailAccountName: " + mailName);
			logger.info("mailBundle: " + mailBundle);
			logger.info("UseMail: " + useMail);
			logger.info("Subject: " + subject);
			logger.info("From: " + sFrom);
			logger.info("To: " + sentTO);
			logger.info("CC: " + sentCC);
			logger.info("Campus: " + campus);
			logger.info("Alpha: " + alpha);
			logger.info("Num: " + num);
		}
		catch(SendFailedException sfe){
			logger.fatal("MailerDB - sendMail - SendFailedException: " + sfe.toString() );
		}
		catch(java.net.ConnectException ce){
			logger.fatal("MailerDB - sendMail - ConnectException: " + ce.toString() );
		}

		return true;
	}

	/**
	 * getEmailAccount
	 * <p>
	 * @param	conn				Connection
	 * @param	domain			Connection
	 * @param	accounts			String
	 * <p>
	 * @return	String
	 */
	public String getEmailAccount(java.sql.Connection conn,String domain,String account){

		String email = account.toLowerCase();
		String temp = "";

		/*
			get the user's email account. If this is a UH person,
			the email = userid + domain. If not UH, then the
			email is what's in the person's profife.

			We could have gotten the email from the person's profile
			for all, but if the domain changes or something happens,
			that's a lot of updating. Also, this ensures the
			domain is correct.

			if a comma is in the list sent, tokenize and create for all
		*/

		if (account != null && account.length() > 0 && account.indexOf("@") < 0) {
			if (account.indexOf(",") >= 0){
				String[] to = new String[100];
				to = account.toLowerCase().split(",");
				email = "";
				String thisMail = "";
				for (int i=0; i<to.length; i++) {
					temp = to[i].trim();
					User udb = UserDB.getUserByName(conn,temp);

					if (udb.getUH()==1)
						thisMail = temp + domain;
					else
						thisMail = udb.getEmail();

					if (i==0)
						email = thisMail;
					else
						email = email + "," + thisMail;
				}
			}
			else{
				User udb = UserDB.getUserByName(conn,account);

				if (udb.getUH()==1)
					email = account + domain;
				else
					email = udb.getEmail();
			}
		}

		return email;
	}
%>

    </table>
  </body>
</html>
