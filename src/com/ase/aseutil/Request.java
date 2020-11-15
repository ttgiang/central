/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Text.java
//
package com.ase.aseutil;

public class Request {

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Userid varchar
	**/
	private String userid = null;

	/**
	* Status char
	**/
	private String status = null;

	/**
	* descr text
	**/
	private String descr = null;

	/**
	* Request text
	**/
	private String request = null;

	/**
	* Comments text
	**/
	private String comments = null;

	/**
	* Audit datetime
	**/
	private String auditDate = null;

	/**
	* submitted datetime
	**/
	private String submittedDate = null;

	public Request (){
		this.id = 0;
		this.campus = "";
		this.userid = "";
		this.status = "";
		this.request = "";
		this.comments = "";
		this.auditDate = "";
		this.submittedDate = "";
		this.descr = "";
	}

	public Request (int id,String campus,String userid,String status,String request,String comments,String audit,String descr){
		this.id = id;
		this.campus = campus;
		this.userid = userid;
		this.status = status;
		this.request = request;
		this.comments = comments;
		this.auditDate = auditDate;
		this.descr = descr;
	}

	/**
	** Id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Userid varchar
	**/
	public String getUserid(){ return this.userid; }
	public void setUserid(String value){ this.userid = value; }

	/**
	** Status char
	**/
	public String getStatus(){ return this.status; }
	public void setStatus(String value){ this.status = value; }

	/**
	** descr text
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	/**
	** Request text
	**/
	public String getRequest(){ return this.request; }
	public void setRequest(String value){ this.request = value; }

	/**
	** Comments text
	**/
	public String getComments(){ return this.comments; }
	public void setComments(String value){ this.comments = value; }

	/**
	** Audit datetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	** submitted datetime
	**/
	public String getSubmittedDate(){ return this.submittedDate; }
	public void setSubmittedDate(String value){ this.submittedDate = value; }

	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Userid: " + getUserid() +
		"Status: " + getStatus() +
		"Request: " + getRequest() +
		"Comments: " + getComments() +
		"Audit: " + getAuditDate() +
		"SubmittedDate: " + getSubmittedDate() +
		"";
	}

}
