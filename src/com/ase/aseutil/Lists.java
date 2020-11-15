/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Lists.java
//
package com.ase.aseutil;

public class Lists {

	/**
	* Id numeric identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Src varchar
	**/
	private String src = null;

	/**
	* Program varchar
	**/
	private String program = null;

	/**
	* Alpha varchar
	**/
	private String alpha = null;

	/**
	* Comments text
	**/
	private String comments = null;

	/**
	* AuditDate smalldatetime
	**/
	private String auditDate = null;

	/**
	* AuditBy varchar
	**/
	private String auditBy = null;

	/**
	* Rdr int
	**/
	private int rdr = 0;

	public Lists (){
		this.id = 0;
		this.campus = null;
		this.src = null;
		this.program = null;
		this.alpha = null;
		this.comments = null;
		this.auditDate = null;
		this.auditBy = null;
		this.rdr = 0;
	}

	public Lists (int id,String campus,String src,String program,String alpha,String comments,String auditDate,String auditBy,int tdr){
		this.id = id;
		this.campus = campus;
		this.src = src;
		this.program = program;
		this.alpha = alpha;
		this.comments = comments;
		this.auditDate = auditDate;
		this.auditBy = auditBy;
		this.rdr = rdr;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Src varchar
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

	/**
	** Program varchar
	**/
	public String getProgram(){ return this.program; }
	public void setProgram(String value){ this.program = value; }

	/**
	** Alpha varchar
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	** Comments text
	**/
	public String getComments(){ return this.comments; }
	public void setComments(String value){ this.comments = value; }

	/**
	** AuditDate smalldatetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	** AuditBy varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** Rdr int
	**/
	public int getRdr(){ return this.rdr; }
	public void setRdr(int value){ this.rdr = value; }


	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Src: " + getSrc() +
		"Program: " + getProgram() +
		"Alpha: " + getAlpha() +
		"Comments: " + getComments() +
		"AuditDate: " + getAuditDate() +
		"AuditBy: " + getAuditBy() +
		"Rdr: " + getRdr() +
		"";
	}
}
