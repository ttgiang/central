/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Review.java
//
package com.ase.aseutil;

public class Review {
	private String user;
	private String alpha;
	private String num;
	private String comments;
	private String subject;
	private String history;
	private String campus;
	private String dte;
	private int item;
	private int id;
	private boolean enable;
	private boolean correctItem = false;

	private int sq;
	private int en;
	private int qn;

	WebSite website = null;

	public Review() {}

	public Review(WebSite ws) {
		website = ws;
	}

	public Review(String campus, String user, String alpha, String num, String history, String comments, String dte, int item, boolean enable) {
		this.id = 0;
		this.campus = campus;
		this.user = user;
		this.alpha = alpha;
		this.num = num;
		this.history = history;
		this.comments = comments;
		this.dte = dte;
		this.item = item;
		this.enable = enable;
		this.correctItem = false;
		this.subject = "";
	}

	public Review(String user, String alpha, String num, String comments, String history, String campus, String dte, int item, int id) {
		this.user = user;
		this.alpha = alpha;
		this.num = num;
		this.comments = comments;
		this.history = history;
		this.campus = campus;
		this.dte = dte;
		this.item = item;
		this.id = id;
		this.enable = false;
		this.correctItem = false;
		this.subject = "";
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(String value) {
		this.user = value;
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

	public String getComments() {
		return this.comments;
	}

	public void setComments(String value) {
		this.comments = value;
	}

	public String getHistory() {
		return this.history;
	}

	public void setHistory(String value) {
		this.history = value;
	}

	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	public int getItem() {
		return this.item;
	}

	public void setItem(int value) {
		this.item = value;
	}

	public String getAuditDate() {
		return this.dte;
	}

	public void setAuditDate(String value) {
		this.dte = value;
	}

	public int getId() {return this.id;}
	public void setId(int value) {this.id = value;}

	public boolean getEnable() {return this.enable;}
	public void setEnable(boolean value) {this.enable = value;}

	public boolean getCorrectItem() {return this.correctItem;}
	public void setCorrectItem(boolean value) {this.correctItem = value;}

	public String getSubject() {
		return this.subject;
	}

	public void setSubject(String value) {
		this.subject = value;
	}

	public int getSq() { return this.sq; }
	public void setSq(int value) {	this.sq = value; }

	public int getEn() { return this.en; }
	public void setEn(int value) {	this.en = value; }

	public int getQn() { return this.qn; }
	public void setQn(int value) {	this.qn = value; }

	public String toString(){
		return "User: " + getUser() + "\n" +
		"Alpha: " + getAlpha() + "\n" +
		"Num: " + getNum() + "\n" +
		"Comments: " + getComments() + "\n" +
		"History: " + getHistory() + "\n" +
		"Campus: " + getCampus() + "\n" +
		"Item: " + getItem() + "\n" +
		"Date: " + getAuditDate() + "\n" +
		"Enable: " + getEnable() + "\n" +
		"CorrectItem: " + getCorrectItem() + "\n" +
		"subject: " + getSubject() + "\n" +
		"sq: " + getSq() + "\n" +
		"en: " + getEn() + "\n" +
		"qn: " + getQn() + "\n" +
		"";
	}
}
