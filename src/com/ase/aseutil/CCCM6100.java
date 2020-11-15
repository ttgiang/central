/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// CCCM6100.java
//
package com.ase.aseutil;

public class CCCM6100 implements Comparable {
	/**
	 * Id COUNTER
	 */
	int Id = 0;

	/**
	 * Campus VARCHAR
	 */
	String Campus = null;

	/**
	 * Type VARCHAR
	 */
	String Type = null;

	/**
	 * Question_Number SMALLINT
	 */
	int Question_Number;

	/**
	 * CCCM6100 LONGCHAR
	 */
	String CCCM6100 = null;

	/**
	 * help LONGCHAR
	 */
	String help = null;

	/**
	 * Question_Friendly VARCHAR
	 */
	String Question_Friendly = null;

	/**
	 * Question_Len SMALLINT
	 */
	int Question_Len;

	/**
	 * Question_Max SMALLINT
	 */
	int Question_Max;

	/**
	 * Question_Type VARCHAR
	 */
	String Question_Type = null;

	/**
	 * Question_Ini VARCHAR
	 */
	String Question_Ini = null;

	/**
	 * Question_Explain VARCHAR
	 */
	String Question_Explain = null;

	/**
	 * Question_Change VARCHAR
	 */
	String Question_Change = null;

	/*
	 * **** these are additions so that when combined with course questions,
	 * **** a single class is available to return all data
	 */

	/**
	 * questionseq int
	 */
	int questionSeq = 0;

	/**
	 * include VARCHAR
	 */
	String include = null;

	/**
	 * include VARCHAR
	 */
	String change = null;

	/**
	 * auditby VARCHAR
	 */
	String auditby = null;

	/**
	 * auditDate VARCHAR
	 */
	String auditdate = null;

	/**
	 * auditDate char
	 */
	String required = null;

	/**
	 * help files
	 */
	String helpFile = null;
	String audioFile = null;
	String defalt = null;
	String comments = null;

	int userLen;

	String counter = "N";

	String extra = "Y";

	String permanent = "N";		// Yes or No
	String append = "A";			// Before or After
	String headerText = null;

	/**
	 * rules
	 */
	boolean rules = false;
	String rulesForm = null;

	public CCCM6100(int id,int seq,String question,String field,String type,String include,String required,String comments,int len) {
		this.Id = id;
		this.questionSeq = seq;
		this.CCCM6100 = question;
		this.Question_Friendly = field;
		this.Question_Type = type;
		this.include = include;
		this.required = required;
		this.comments = comments;
		this.userLen = len;
	}

	public CCCM6100(int id,int seq,String question,String field,String type,String include,String required,String comments,int len,String counter) {
		this.Id = id;
		this.questionSeq = seq;
		this.CCCM6100 = question;
		this.Question_Friendly = field;
		this.Question_Type = type;
		this.include = include;
		this.required = required;
		this.comments = comments;
		this.userLen = len;
		this.counter = counter;
	}

	public CCCM6100(int id,int seq,String question,String field,String type,String include,String required,String comments,int len,String counter,String extra) {
		this.Id = id;
		this.questionSeq = seq;
		this.CCCM6100 = question;
		this.Question_Friendly = field;
		this.Question_Type = type;
		this.include = include;
		this.required = required;
		this.comments = comments;
		this.userLen = len;
		this.counter = counter;
		this.extra = extra;
	}

	public CCCM6100() {
		Id = 0;
		Question_Number = 0;
		Question_Len = 0;
		Question_Max = 0;
		questionSeq = 0;
		Campus = "";
		Type = "";
		CCCM6100 = "";
		help = "";
		Question_Friendly = "";
		Question_Type = "";
		Question_Ini = "";
		Question_Explain = "";
		Question_Change = "";
		include = "";
		change = "";
		auditby = "";
		required = "0";
		helpFile = "";
		audioFile = "";
		rules = false;
		rulesForm = "";
		defalt = "";
		headerText = "";
		userLen = 0;
		counter = "N";
		extra = "Y";
		permanent = "N";
		append = "A";
	}

	/**
	 *
	 */
	public int getId() {
		return this.Id;
	}

	public void setId(int value) {
		this.Id = value;
	}

	/**
	 *
	 */
	public String getCampus() {
		return this.Campus;
	}

	public void setCampus(String value) {
		this.Campus = value;
	}

	/**
	 *
	 */
	public String getType() {
		return this.Type;
	}

	public void setType(String value) {
		this.Type = value;
	}

	/**
	 *
	 */
	public int getQuestion_Number() {
		return this.Question_Number;
	}

	public void setQuestion_Number(int value) {
		this.Question_Number = value;
	}

	/**
	 *
	 */
	public String getCCCM6100() {
		return this.CCCM6100;
	}

	public void setCCCM6100(String value) {
		this.CCCM6100 = value;
	}

	/**
	 *
	 */
	public String getHelp() {
		return this.help;
	}

	public void setHelp(String value) {
		this.help = value;
	}

	/**
	 *
	 */
	public String getQuestion_Friendly() {
		return this.Question_Friendly;
	}

	public void setQuestion_Friendly(String value) {
		this.Question_Friendly = value;
	}

	/**
	 *
	 */
	public int getQuestion_Len() {

		return NumericUtil.nullToZero(this.Question_Len);

	}

	public void setQuestion_Len(int value) {

		this.Question_Len = NumericUtil.nullToZero(value);

	}

	/**
	 *
	 */
	public int getQuestion_Max() {

		return NumericUtil.nullToZero(this.Question_Max);

	}

	public void setQuestion_Max(int value) {

		this.Question_Max = NumericUtil.nullToZero(value);

	}

	/**
	 *
	 */
	public String getQuestion_Type() {
		return this.Question_Type;
	}

	public void setQuestion_Type(String value) {
		this.Question_Type = value;
	}

	/**
	 *
	 */
	public String getQuestion_Change() {
		return this.Question_Change;
	}

	public void setQuestion_Change(String value) {
		this.Question_Change = value;
	}

	/**
	 *
	 */
	public String getQuestion_Ini() {
		return this.Question_Ini;
	}

	public void setQuestion_Ini(String value) {
		this.Question_Ini = value;
	}

	public void setQuestion_Explain(String value) {
		this.Question_Explain = value;
	}

	/**
	 *
	 */
	public int getQuestionSeq() {
		return this.questionSeq;
	}

	public void setQuestionSeq(int value) {
		this.questionSeq = value;
	}

	/**
	 *
	 */
	public String getInclude() {
		return this.include;
	}

	public void setInclude(String value) {
		this.include = value;
	}

	/**
	 *
	 */
	public String getChange() {
		return this.change;
	}

	public void setChange(String value) {
		this.change = value;
	}

	/**
	 *
	 */
	public String getQuestion_Explain() {
		return this.Question_Explain;
	}

	/**
	 *
	 */
	public String getAuditBy() {
		return this.auditby;
	}

	public void setAuditBy(String value) {
		this.auditby = value;
	}

	/**
	 *
	 */
	public String getAuditDate() {
		return this.auditdate;
	}

	public void setAuditDate(String value) {
		this.auditdate = value;
	}

	/**
	 *
	 */
	public String getRequired() {
		return this.required;
	}

	public void setRequired(String value) {
		this.required = value;
	}

	/**
	 *
	 */
	public String getHelpFile() {
		return this.helpFile;
	}

	public void setHelpFile(String value) {
		this.helpFile = value;
	}

	public String getAudioFile() {return this.audioFile;}
	public void setAudioFile(String value) {this.audioFile = value;}

	/**
	 *	Rules
	 */
	public boolean getRules() {return this.rules;}
	public void setRules(boolean value) {this.rules = value;}

	public String getRulesForm() {return this.rulesForm;}
	public void setRulesForm(String value) {this.rulesForm = value;}

	public String getDefalt() { return this.defalt; }
	public void setDefalt(String value) { this.defalt = value; }

	public String getHeaderText() { return this.headerText; }
	public void setHeaderText(String value) { this.headerText = value; }

	public String getComments() { return this.comments; }
	public void setComments(String value) { this.comments = value; }

	public String getCounter() { return this.counter; }
	public void setCounter(String value) { this.counter = value; }

	/**
	 *	default text
	 */
	public String getPermanent() { return this.permanent; }
	public void setPermanent(String value) { this.permanent = value; }

	public String getAppend() { return this.append; }
	public void setAppend(String value) { this.append = value; }

	/**
	 *
	 */
	public int getUserLen() {

		return NumericUtil.nullToZero(this.userLen);

	}

	public void setUserLen(int value) {

		this.userLen = NumericUtil.nullToZero(value);

	}

	/**
	 *
	 */
	public String getExtra() { return this.extra; }
	public void setExtra(String value) { this.extra = value; }

	public String toString() {

		return "Id: " + getId() + "<br>\n" + "Campus: " + getCampus()
				+ "<br>\n" + "Type: " + getType() + "<br>\n"
				+ "Question_Number: " + getQuestion_Number() + "<br>\n"
				+ "CCCM6100: " + getCCCM6100() + "<br>\n"
				+ "Question_Friendly: " + getQuestion_Friendly() + "<br>\n"
				+ "Question_Len: " + getQuestion_Len() + "<br>\n"
				+ "Question_Max: " + getQuestion_Max() + "<br>\n"
				+ "Question_Type: " + getQuestion_Type() + "<br>\n"
				+ "Question_Explain: " + getQuestion_Explain() + "<br>\n"
				+ "Question_Change: " + getQuestion_Change() + "<br>\n"
				+ "Question_Ini: " + getQuestion_Ini() + "<br>\n" + "Seq: "
				+ getQuestionSeq() + "<br>\n" + "Include: " + getInclude()
				+ "<br>\n" + "Required: " + getRequired() + "<br>\n"
				+ "<br>\n" + "Audit By: " + getAuditBy() + "<br>\n"
				+ "Audit Date: " + getAuditDate() + "<br>\n" + ""
				+ "Help File: " + getHelpFile() + "<br>\n" + ""
				+ "Audio File: " + getAudioFile() + "<br>\n" + ""
				+ "Rules: " + getRules() + "<br>\n" + ""
				+ "Rules Form: " + getRulesForm() + "<br>\n"
				+ "Defalt: " + getDefalt() + "<br>\n"
				+ "comments: " + getComments() + "<br>\n"
				+ "user defined length: " + getUserLen() + "<br>\n"
				+ "count text: " + getCounter() + "<br>\n"
				+ "extra: " + getExtra() + "<br>\n"
				+ "pernament default text: " + getPermanent() + "<br>\n"
				+ "append default text: " + getAppend() + "<br>\n"
				+ "header text: " + getHeaderText() + "<br>\n"
				+ "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}