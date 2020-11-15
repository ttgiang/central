/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Search.java
//
package com.ase.aseutil.util;

public class Search {

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* src varchar
	**/
	private String src = null;

	private String auditDate = null;

	private String auditBy = null;

	public Search(){}

	public Search(String historyid,int id,String campus,String src,String auditDate,String auditBy){
		this.historyid = historyid;
		this.id = id;
		this.campus = campus;
		this.src = src;
		this.auditDate = auditDate;
		this.auditBy = auditBy;
	}

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

	/**
	*
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/**
	*
	**/
	public int getid(){ return this.id; }
	public void setid(int value){ this.id = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

	public String toString(){
		return "Historyid: " + getHistoryid() +
		"id: " + getid() +
		"campus: " + getCampus() +
		"src: " + getSrc() +
		"audit date: " + getAuditDate() +
		"audit by: " + getAuditBy() +
		"";
	}
}
