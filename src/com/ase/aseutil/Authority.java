/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @level ttgiang
 */

//
// Authority.java
//
package com.ase.aseutil;

public class Authority {

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* code varchar
	**/
	private String code = null;

	/**
	* descr varchar
	**/
	private String descr = null;

	/**
	* level itn
	**/
	private int level = 0;

	/**
	* auditby varchar
	**/
	private String auditby = null;

	/**
	* auditdate char
	**/
	private String auditdate = null;

	/**
	* chair char
	**/
	private String chair = null;

	/**
	* delegated char
	**/
	private String delegated = null;

	public Authority(){}

	public Authority(int id,String campus,String code,String descr,int level,String chair,String delegated,String auditby,String auditdate){
		this.id = id;
		this.campus = campus;
		this.code = code;
		this.descr = descr;
		this.level = level;
		this.auditby = auditby;
		this.auditdate = auditdate;
		this.chair = chair;
		this.delegated = delegated;
	}

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getCode(){ return this.code; }
	public void setCode(String value){ this.code = value; }

	/**
	*
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	/**
	*
	**/
	public int getLevel(){ return this.level; }
	public void setLevel(int value){ this.level = value; }

	/**
	*
	**/
	public String getAuditBy(){ return this.auditby; }
	public void setAuditBy(String value){ this.auditby = value; }

	/**
	*
	**/
	public String getAuditDate(){ return this.auditdate; }
	public void setAuditDate(String value){ this.auditdate = value; }

	/**
	*
	**/
	public String getChair(){ return this.chair; }
	public void setChair(String value){ this.chair = value; }

	/**
	*
	**/
	public String getDelegated(){ return this.delegated; }
	public void setDelegated(String value){ this.delegated = value; }

	
	public String toString(){
		return
		"campus: " + getCampus() + "\n" +
		"code: " + getCode() + "\n" +
		"id: " + getId() + "\n" +
		"descr: " + getDescr() + "\n" +
		"level: " + getLevel() + "\n" +
		"chair: " + getChair() + "\n" +
		"delegated: " + getDelegated() + "\n" +
		"auditby: " + getAuditBy() + "\n" +
		"auditdate: " + getAuditDate() + "\n" +
		"";
	}
}
