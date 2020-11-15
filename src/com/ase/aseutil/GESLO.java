/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// GESLO.java
//
package com.ase.aseutil;

public class GESLO {

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Kix varchar
	**/
	private String historyid = null;

	/**
	* Geid int
	**/
	private int geid = 0;

	/**
	* Slolevel int
	**/
	private int sloLevel = 0;

	/**
	* Sloevals varchar
	**/
	private String sloEvals = null;

	/**
	* coursetype varchar
	**/
	private String courseType = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	public GESLO(){}

	public GESLO(int id,String campus,String historyid,int geid,int sloLevel,String sloEvals,String auditBy){
		this.id = id;
		this.campus = campus;
		this.historyid = historyid;
		this.geid = geid;
		this.sloLevel = sloLevel;
		this.sloEvals = sloEvals;
		this.auditBy = auditBy;
	}

	public GESLO(String campus,String historyid,int geid,int sloLevel,String sloEvals,String auditBy){
		this.campus = campus;
		this.historyid = historyid;
		this.geid = geid;
		this.sloLevel = sloLevel;
		this.sloEvals = sloEvals;
		this.auditBy = auditBy;
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
	public String getHistoryID(){ return this.historyid; }
	public void setHistoryID(String value){ this.historyid = value; }

	/**
	*
	**/
	public int getGeid(){ return this.geid; }
	public void setGeid(int value){ this.geid = value; }

	/**
	*
	**/
	public int getSloLevel(){ return this.sloLevel; }
	public void setSloLevel(int value){ this.sloLevel = value; }

	/**
	*
	**/
	public String getSloEvals(){ return this.sloEvals; }
	public void setSloEvals(String value){ this.sloEvals = value; }

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
	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	public String toString(){
		return "Id: " + getID() +
		"Campus: " + getCampus() +
		"Kix: " + getHistoryID() +
		"Geid: " + getGeid() +
		"Slolevel: " + getSloLevel() +
		"Sloevals: " + getSloEvals() +
		"Auditby: " + getAuditBy() +
		"Auditdate: " + getAuditDate() +
		"";
	}
}
