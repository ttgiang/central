/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Messages.java
//
package com.ase.aseutil;

public class Messages {

	/**
	* messageID int identity
	**/
	private int messageID = 0;

	/**
	* forumID int
	**/
	private int forumID = 0;

	/**
	* item int
	**/
	private int item = 0;

	/**
	* threadID int
	**/
	private int threadID = 0;

	/**
	* threadParent int
	**/
	private int threadParent = 0;

	/**
	* threadLevel int
	**/
	private int threadLevel = 0;

	/**
	* author varchar
	**/
	private String author = null;

	/**
	* email varchar
	**/
	private String email = null;

	/**
	* notify bit
	**/
	private boolean notify = false;

	/**
	* timeStamp datetime
	**/
	private String timeStamp = null;

	/**
	* subject varchar
	**/
	private String subject = null;

	/**
	* body text
	**/
	private String body = null;

	/**
	* approved bit
	**/
	private boolean approved = false;

	private int acktion = 0;
	private int processed = 0;
	private int notified = 0;
	private String processeddate = null;

	private int sq;
	private int en;
	private int qn;

	public Messages(){}

	public Messages(int messageID,int forumID,int threadID,int threadParent,int threadLevel,String author,String email,boolean notify,String timeStamp,String subject,String body,boolean approved){
		this.messageID = messageID;
		this.forumID = forumID;
		this.threadID = threadID;
		this.threadParent = threadParent;
		this.threadLevel = threadLevel;
		this.author = author;
		this.email = email;
		this.notify = notify;
		this.timeStamp = timeStamp;
		this.subject = subject;
		this.body = body;
		this.approved = approved;
		this.acktion = 0;
		this.processed = 0;
		this.processeddate = "";
		this.notified = 0;
	}

	/**
	** messageID int identity
	**/
	public int getMessageID(){ return this.messageID; }
	public void setMessageID(int value){ this.messageID = value; }

	/**
	** forumID int
	**/
	public int getForumID(){ return this.forumID; }
	public void setForumID(int value){ this.forumID = value; }

	/**
	** item int
	**/
	public int getItem(){ return this.item; }
	public void setItem(int value){ this.item = value; }

	/**
	** threadID int
	**/
	public int getThreadID(){ return this.threadID; }
	public void setThreadID(int value){ this.threadID = value; }

	/**
	** threadParent int
	**/
	public int getThreadParent(){ return this.threadParent; }
	public void setThreadParent(int value){ this.threadParent = value; }

	/**
	** threadLevel int
	**/
	public int getThreadLevel(){ return this.threadLevel; }
	public void setThreadLevel(int value){ this.threadLevel = value; }

	/**
	** author varchar
	**/
	public String getAuthor(){ return this.author; }
	public void setAuthor(String value){ this.author = value; }

	/**
	** email varchar
	**/
	public String getEmail(){ return this.email; }
	public void setEmail(String value){ this.email = value; }

	/**
	** notify bit
	**/
	public boolean getNotify(){ return this.notify; }
	public void setNotify(boolean value){ this.notify = value; }

	/**
	** timeStamp datetime
	**/
	public String getTimeStamp(){ return this.timeStamp; }
	public void setTimeStamp(String value){ this.timeStamp = value; }

	/**
	** subject varchar
	**/
	public String getSubject(){ return this.subject; }
	public void setSubject(String value){ this.subject = value; }

	/**
	** body text
	**/
	public String getBody(){ return this.body; }
	public void setBody(String value){ this.body = value; }

	/**
	** approved bit
	**/
	public boolean getApproved(){ return this.approved; }
	public void setApproved(boolean value){ this.approved = value; }

	public String getProcessedDate(){ return this.processeddate; }
	public void setProcessedDate(String value){ this.processeddate = value; }

	public int getAcktion(){ return this.acktion; }
	public void setAcktion(int value){ this.acktion = value; }

	public int getProcessed(){ return this.processed; }
	public void setProcessed(int value){ this.processed = value; }

	public int getNotified(){ return this.notified; }
	public void setNotified(int value){ this.notified = value; }

	public int getSq() { return this.sq; }
	public void setSq(int value) {	this.sq = value; }

	public int getEn() { return this.en; }
	public void setEn(int value) {	this.en = value; }

	public int getQn() { return this.qn; }
	public void setQn(int value) {	this.qn = value; }

	public String toString(){
		return "messageID: " + getMessageID() +
		"forumID: " + getForumID() +
		"item: " + getItem() +
		"threadID: " + getThreadID() +
		"threadParent: " + getThreadParent() +
		"threadLevel: " + getThreadLevel() +
		"author: " + getAuthor() +
		"email: " + getEmail() +
		"notify: " + getNotify() +
		"timeStamp: " + getTimeStamp() +
		"subject: " + getSubject() +
		"body: " + getBody() +
		"approved: " + getApproved() +
		"processeddate: " + getProcessedDate() +
		"acktion: " + getAcktion() +
		"processed: " + getProcessed() +
		"notified: " + getNotified() +
		"sq: " + getSq() + "\n" +
		"en: " + getEn() + "\n" +
		"qn: " + getQn() + "\n" +
		"";
	}

}
