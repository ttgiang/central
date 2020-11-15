/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Mailer.java
//
package com.ase.aseutil;

public class Mailer {

	private int id;
	private String owner;
	private String from;
	private String to;
	private String cc;
	private String bcc;
	private String subject;
	private String message;
	private String campus;
	private String smtp;
	private String alpha;
	private String num;
	private String kix;
	private boolean processed;
	private String content;
	private String dte;
	private String attachment;

	private boolean personalizedMail = false;
	private boolean forceMail = false;
	private boolean forceMailToRecipient = false;
	private String category = "";

	public Mailer() {

		// personalizedMail is when subject and content are provide and bypassing the bundle check
		this.owner = "";
		this.personalizedMail = false;

		// forceMail used by defect system where the mail in test is sent to techSupport in tblSystem
		this.forceMail = false;

		// in test, we set email for TO/CC to the user's name so actual users don't get spam.
		// however, it may be necessary to override for testing.
		this.forceMailToRecipient = false;

		// category defines the mail type
		this.category = "";
	}

	public String getFrom() {
		return this.from;
	}

	public void setKix(String value) {
		this.kix = value;
	}

	public String getKix() {
		return this.kix;
	}

	public void setFrom(String value) {
		this.from = value;
	}

	public String getTo() {
		return this.to;
	}

	public void setTo(String value) {
		this.to = value;
	}

	public String getCC() {
		return this.cc;
	}

	public void setCC(String value) {
		this.cc = value;
	}

	public String getBCC() {
		return this.bcc;
	}

	public void setBCC(String value) {
		this.bcc = value;
	}

	public String getSubject() {
		return this.subject;
	}

	public void setSubject(String value) {
		this.subject = value;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String value) {
		this.message = value;
	}

	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	public String getSMTP() {
		return this.smtp;
	}

	public void setSMTP(String value) {
		this.smtp = value;
	}

	public String getAlpha() {
		return this.alpha;
	}

	public void setAlpha(String value) {
		this.alpha = value;
	}

	public String getNum() {
		return this.num;
	}

	public void setNum(String value) {
		this.num = value;
	}

	public boolean getProcessed() {
		return this.processed;
	}

	public void setProcessed(boolean value) {
		this.processed = value;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String value) {
		this.content = value;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int value) {
		this.id = value;
	}

	public String getDte() {
		return this.dte;
	}

	public void setDte(String value) {
		this.dte = value;
	}

	public String getOwner() {
		return this.owner;
	}

	public void setOwner(String value) {
		this.owner = value;
	}

	//
	// getPersonalizedMail
	//
	public boolean getPersonalizedMail() {
		return this.personalizedMail;
	}

	public void setPersonalizedMail(boolean value) {
		this.personalizedMail = value;
	}

	//
	// getAttachment
	//
	public String getAttachment() {
		return this.attachment;
	}

	public void setAttachment(String value) {
		this.attachment = value;
	}

	//
	// forceMail
	//
	public boolean getForceMail() {
		return this.forceMail;
	}

	public void setForceMail(boolean value) {
		this.forceMail = value;
	}

	//
	// forceMailToRecipient
	//
	public boolean getForceMailToRecipient() {
		return this.forceMailToRecipient;
	}

	public void setForceMailToRecipient(boolean value) {
		this.forceMailToRecipient = value;
	}

	//
	// category
	//
	public String getCategory() {
		return this.category;
	}

	public void setCategory(String value) {
		this.category = value;
	}

	public String toString(){
		return
			"ID: " + getId() + "\n" +
			"Date: " + getDte() + "\n" +
			"From: " + getFrom() + "\n" +
			"To: " + getTo() + "\n" +
			"Cc: " + getCC() + "\n" +
			"Bcc: " + getBCC() + "\n" +
			"Subject: " + getSubject() + "\n" +
			"Alpha: " + getAlpha() + "\n" +
			"Num: " + getNum() + "\n" +
			"Campus: " + getCampus() + "\n" +
			"Kix: " + getKix() + "\n" +
			"Processed: " + getProcessed() + "\n" +
			"Content: " + getContent() + "\n" +
			"Owner: " + getOwner() + "\n" +
			"personalizedMail: " + getPersonalizedMail() + "\n" +
			"attachment: " + getAttachment() + "\n" +
			"forceMail: " + getForceMail() + "\n" +
			"forceMailToRecipient: " + getForceMailToRecipient() + "\n" +
			"category: " + getCategory() + "\n" +
			"";
	}
}
