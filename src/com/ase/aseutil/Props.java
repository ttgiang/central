/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Props.java
//
package com.ase.aseutil;

public class Props {

	/**
	* Id int identity
	**/
	private int id;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Propname varchar
	**/
	private String propName = null;

	/**
	* Propdescr varchar
	**/
	private String propDescr = null;

	/**
	* Subject varchar
	**/
	private String subject = null;

	/**
	* Content varchar
	**/
	private String content = null;

	/**
	* Cc varchar
	**/
	private String cc = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	public Props(){}

	public Props(String campus,String propname,String propdescr,String subject,String content,String cc,String auditby){
		this.campus = campus;
		this.propName = propname;
		this.propDescr = propdescr;
		this.subject = subject;
		this.content = content;
		this.cc = cc;
		this.auditBy = auditby;
	}

	public Props(int id,String campus,String propname,String propdescr,String subject,String content,String cc,String auditby){
		this.id = id;
		this.campus = campus;
		this.propName = propname;
		this.propDescr = propdescr;
		this.subject = subject;
		this.content = content;
		this.cc = cc;
		this.auditBy = auditby;
	}

	/**
	*
	**/
	public int getID(){ return this.id; }
	public void setID(int value){ this.id = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getPropName(){ return this.propName; }
	public void setPropName(String value){ this.propName = value; }

	/**
	*
	**/
	public String getPropDescr(){ return this.propDescr; }
	public void setPropDescr(String value){ this.propDescr = value; }

	/**
	*
	**/
	public String getSubject(){ return this.subject; }
	public void setSubject(String value){ this.subject = value; }

	/**
	*
	**/
	public String getContent(){ return this.content; }
	public void setContent(String value){ this.content = value; }

	/**
	*
	**/
	public String getCC(){ return this.cc; }
	public void setCC(String value){ this.cc = value; }

	/**
	*
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	*
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	public String toString(){
		return "Id: " + getID() +
		"Campus: " + getCampus() +
		"Propname: " + getPropName() +
		"Propdescr: " + getPropDescr() +
		"Subject: " + getSubject() +
		"Content: " + getContent() +
		"Cc: " + getCC() +
		"Auditby: " + getAuditBy() +
		"Auditdate: " + getAuditDate() +
		"";
	}
}
