/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Answer.java
//

package com.ase.aseutil.faq;

public class Answer {

	/**
	* Id numeric identity
	**/
	private int id;

	private int seq;

	private int score;

	private boolean accepted;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* answer varchar
	**/
	private String answer = null;

	/**
	* auditBy varchar
	**/
	private String auditBy = null;

	/**
	* auditDate smalldatetime
	**/
	private String auditDate = null;

	/**
	* String profile
	**/
	private String profile = "";

	public Answer (){
		this.id = 0;
		this.seq = 0;
		this.score = 0;
	}

	public Answer (int id,int seq,int score,String answer,String auditBy,String auditDate,String campus){
		this.id = id;
		this.seq = seq;
		this.score = score;
		this.answer = answer;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.accepted = false;
		this.campus = campus;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	public int getSeq(){ return this.seq; }
	public void setSeq(int value){ this.seq = value; }

	public int getScore(){ return this.score; }
	public void setScore(int value){ this.score = value; }

	public boolean getAccepted(){ return this.accepted; }
	public void setAccepted(boolean value){ this.accepted = value; }

	/**
	** answer varchar
	**/
	public String getAnswer(){ return this.answer; }
	public void setAnswer(String value){ this.answer = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** auditBy varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** auditDate smalldatetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	**
	**/
	public String getProfile(){ return this.profile; }
	public void setProfile(String value){ this.profile = value; }

	public String toString(){
		return "Campus: " + getCampus() +
		"Id: " + getId() +
		"answer: " + getAnswer() +
		"auditBy: " + getAuditBy() +
		"auditDate: " + getAuditDate() +
		"profile: " + getProfile() +
		"";
	}
}

