/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * Questionliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Question.java
//
package com.ase.aseutil;

public class Question {

	private String campus;
	private String friendly;
	private String question;
	private String headerText;
	private String help;
	private String type;
	private String num;
	private String seq;
	private String defalt;

	public Question() {}

	public String getQuestion() { return this.question; }
	public void setQuestion(String value) { this.question = value; }

	public String getHeaderText() { return this.headerText; }
	public void setHeaderText(String value) { this.headerText = value; }

	public String getHelp() { return this.help; }
	public void setHelp(String value) { this.help = value; }

	public String getNum() { return this.num; }
	public void setNum(String value) { this.num = value; }

	public String getSeq() { return this.seq; }
	public void setSeq(String value) { this.seq = value; }

	public String getCampus() { return this.campus; }
	public void setCampus(String value) { this.campus = value; }

	public String getFriendly() { return this.friendly; }
	public void setFriendly(String value) { this.friendly = value; }

	public String getDefalt() { return this.defalt; }
	public void setDefalt(String value) { this.defalt = value; }

	/*
	 * added to support selection from shwfld
	 */
	public String getType() {return this.type;}
	public void setType(String value) {this.type = value;}

	public String toString(){
		return
		"getQuestion: " + getQuestion() + "<br>" +
		"getHeaderText: " + getHeaderText() + "<br>" +
		"getHelp: " + getHelp() +  "<br>" +
		"getNum: " + getNum() +  "<br>" +
		"getSeq: " + getSeq() +  "<br>" +
		"getType: " + getType() +  "<br>" +
		"getCampus: " + getCampus() +  "<br>" +
		"getFriendly: " + getFriendly() +  "<br>" +
		"defalt: " + getDefalt() +  "<br>" +
		"";
	}

}
