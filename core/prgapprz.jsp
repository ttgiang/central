<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgapprz	- mailer
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String from = user;

	String to = website.getRequestParameter(request,"nextApprover","");
	String content = website.getRequestParameter(request,"content","");
	String kix = website.getRequestParameter(request,"kix","");
	int voteFor = website.getRequestParameter(request,"voteFor",0);
	int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
	int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);
	int route = website.getRequestParameter(request,"route",0);
	int getLastSequenceToApprove = website.getRequestParameter(request,"getLastSequenceToApprove",0);
	String comments = website.getRequestParameter(request,"comments","");

	String message = "";
	String url = "";

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Program Recommendation";
	fieldsetTitle = "Program Recommendation";

	String sendMail = SysDB.getSys(conn,"sendMail");

	if (from!=null && from.length()>0 && to!=null && to.length()>0){

		String[] info = helper.getKixInfo(conn,kix);
		String subject = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String type = info[Constant.KIX_TYPE];
		String proposer = info[Constant.KIX_PROPOSER];

		// save data
		msg = ProgramApproval.approveProgram(conn,campus,kix,user,true,comments,voteFor,voteAgainst,voteAbstain);
		if ("Exception".equals(msg.getMsg()) ){
			message = "Program approval failed.<br><br>" + msg.getErrorLog();
		}
		else if ("forwardURL".equals(msg.getMsg()) ){
			url = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
		}
		else if (!"".equals(msg.getMsg())){
			message = "Unable to approve program.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
		}
		else{
			if (msg.getCode() == 2)
				message = "Program was approved and finalized.";
		}

		if (msg.getCode() != -1){

			int rowsAffected = TaskDB.logTask(conn,
													to,
													from,
													subject,
													num,
													Constant.PROGRAM_APPROVAL_TEXT,
													campus,
													"",
													"ADD",
													type,
													proposer,
													Constant.TASK_APPROVER,
													kix,
													Constant.PROGRAM);

			// send mail
			MailerDB mailerDB = new MailerDB();

			from = mailerDB.getEmailAccount(conn,"@hawaii.edu",from);
			to = mailerDB.getEmailAccount(conn,"@hawaii.edu",to);

			if (Validation.isValidEmail(from) && Validation.isValidEmail(to)){

				if (sendMail.equals(Constant.YES) || sendMail.equals(Constant.ON)){
					Properties props = System.getProperties();
					props.put("mail.host", SysDB.getSys(conn,"smtp"));
					props.put("mail.transport.protocol", "smtp");

					Session mailSession = Session.getDefaultInstance(props, null);
					mailSession.setDebug(true);

					Message mail = new MimeMessage(mailSession);
					mail.setHeader("X-Mailer","sendhtml");
					mail.setSentDate(new java.util.Date());
					mail.setFrom(new InternetAddress(from));
					mail.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
					mail.setSubject("CC: Program Approval Recommendation ("+subject+")");

					MimeBodyPart mbp = new MimeBodyPart();
					mbp.setContent(content,"text/html");

					MimeMultipart mp = new MimeMultipart();
					mp.setSubType("related");
					mp.addBodyPart(mbp);
					mail.setContent(mp);
					Transport.send(mail);
				} // send mail

				Mailer mailer = new Mailer();
				mailer.setSubject(subject);
				mailer.setFrom(from);
				mailer.setTo(to);
				aseUtil.logMail(conn,mailer);

				AseUtil.logAction(conn,
										user,
										"ACTION",
										"Approval recommendation ("+subject+") from " + from + " to " + to ,
										"",
										"",
										campus,
										kix);

				message = "Recommendation was sent successfully.<br/><br/>"
					+ "<font class=\"textblackth\">From:</font> <font class=\"datacolumn\">" + from + "</font><br/><br/>"
					+ "<font class=\"textblackth\">To:</font> <font class=\"datacolumn\">" + to + "</font><br/><br/>";
			}
			else{
				message = "Mail was not sent.<br/><br/>"
					+ "Check mail data and try again.";
			} // validation

		} // approved && finalized
	}
	else{
		message = "Unable to process for transport.";
	} // from and to

	asePool.freeConnection(conn,"prgapprz",user);

	//
	// becase we decided to send recommendation, we won't forward
	// to page for name selection. name should be known
	//
	if (url != null && url.length() > 0 ){
		//response.sendRedirect(url);
	}

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

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
