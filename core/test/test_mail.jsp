<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.mail.*,javax.servlet.*,javax.mail.internet.*,com.ase.aseutil.*"%>

<%
	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String sender = "ttgiang@hawaii.rr.com";
	String proposer = "ttgiang@yahoo.com";
	String reviewers = "ttgiang@yahoo.com";
	String toEMail = "ttgiang@yahoo.com";
	String toNames = "ttgiang@yahoo.com";
	String cc = "hotta@hawaii.edu";

	MailerDB mailerDB = new MailerDB(conn,sender,toNames,cc,"",alpha,num,campus,"emailOutlineApprovalRequest");
	out.println("emailOutlineApprovalRequest<br>");
	mailerDB = new MailerDB(conn,sender,proposer,cc,"",alpha,num,campus,"emailApproveOutline");
	out.println("emailApproveOutline<br>");
	mailerDB = new MailerDB(conn,sender,reviewers,cc,"",alpha,num,campus,"emailReviewerInvite");
	out.println("emailReviewerInvite<br>");
	mailerDB = new MailerDB(conn,sender,proposer,cc,"",alpha,num,campus,"emailRejectOutline");
	out.println("emailRejectOutline<br>");
	mailerDB = new MailerDB(conn,sender,toEMail,cc,"",alpha,num,campus,"emailReviewerComment");
	out.println("emailReviewerComment<br>");
%>