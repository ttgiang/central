/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Faq.java
//

package com.ase.aseutil.faq;

public class Faq {

	/**
	* Id numeric identity
	**/
	private int id;

	private int answeredseq;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* category varchar
	**/
	private String category = null;

	/**
	* Question varchar
	**/
	private String question = null;

	/**
	* auditBy varchar
	**/
	private String auditBy = null;

	/**
	* auditDate smalldatetime
	**/
	private String auditDate = null;

	/**
	* auditDate smalldatetime
	**/
	private boolean notify = false;

	/**
	* String profile
	**/
	private String profile = "";
	private String askedby = "";

	public Faq (){}

	public Faq (int id,String campus,String question,String auditBy,String auditDate,String category){
		this.id = id;
		this.campus = campus;
		this.question = question;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.answeredseq = 0;
		this.category = category;
	}

	public Faq (int id,String campus,String question,String auditBy,String auditDate,String category,String askedby){
		this.id = id;
		this.campus = campus;
		this.question = question;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.answeredseq = 0;
		this.category = category;
		this.askedby = askedby;
	}

	public Faq (int id,String campus,String question,String auditBy,String auditDate,String category,boolean notify){
		this.id = id;
		this.campus = campus;
		this.question = question;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.answeredseq = 0;
		this.category = category;
		this.notify = notify;
	}

	public Faq (int id,String campus,String question,String auditBy,String auditDate,String category,boolean notify,String askedby){
		this.id = id;
		this.campus = campus;
		this.question = question;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.answeredseq = 0;
		this.category = category;
		this.notify = notify;
		this.askedby = askedby;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	public int getAnsweredSeq(){ return this.answeredseq; }
	public void setAnsweredSeq(int value){ this.answeredseq = value; }

	/**
	** category varchar
	**/
	public String getCategory(){ return this.category; }
	public void setCategory(String value){ this.category = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Question varchar
	**/
	public String getQuestion(){ return this.question; }
	public void setQuestion(String value){ this.question = value; }

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
	** auditDate smalldatetime
	**/
	public boolean getNotify(){ return this.notify; }
	public void setNotify(boolean value){ this.notify = value; }

	/**
	**
	**/
	public String getProfile(){ return this.profile; }
	public void setProfile(String value){ this.profile = value; }

	/**
	**
	**/
	public String getAskedby(){ return this.askedby; }
	public void setAskedby(String value){ this.askedby = value; }

	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Category: " + getCategory() +
		"Question: " + getQuestion() +
		"auditBy: " + getAuditBy() +
		"auditDate: " + getAuditDate() +
		"notify: " + getNotify() +
		"profile: " + getProfile() +
		"asked by: " + getAskedby() +
		"";
	}
}

