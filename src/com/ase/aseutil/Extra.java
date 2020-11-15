/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * Taskliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Extra.java
//
package com.ase.aseutil;

public class Extra{

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Src varchar
	**/
	private String src = null;

	/**
	* Id numeric
	**/
	private int id = 0;

	/**
	* Alpha char
	**/
	private String courseAlpha = null;

	/**
	* Num char
	**/
	private String courseNum = null;

	/**
	* Grading varchar
	**/
	private String grading = null;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	/**
	* Auditdate smalldatetime
	**/
	private String approvedDate = null;

	/**
	* Auditby varchar
	**/
	private String approvedBy = null;

	/**
	* Rdr numeric
	**/
	private int rdr = 0;

	private boolean pending = false;

	public Extra(String historyid,
						String campus,
						String src,
						int id,
						String courseAlpha,
						String courseNum,
						String grading,
						String auditBy,
						int rdr){
		this.campus = "";
		this.src = "";
		this.id = 0;
		this.courseAlpha = "";
		this.courseNum = "";
		this.grading = "";
		this.auditBy = "";
		this.rdr = 0;
		this.pending = false;
		this.approvedBy = "";
		this.approvedDate = "";
	}

	/**
	*
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

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

	/**
	*
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	/**
	*
	**/
	public String getCourseNum(){ return this.courseNum; }
	public void setCourseNum(String value){ this.courseNum = value; }

	/**
	*
	**/
	public String getGrading(){ return this.grading; }
	public void setGrading(String value){ this.grading = value; }

	/**
	*
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	*
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	*
	**/
	public int getRdr(){ return this.rdr; }
	public void setRdr(int value){ this.rdr = value; }

	/**
	*
	**/
	public boolean getPending(){ return this.pending; }
	public void setPending(boolean value){ this.pending = value; }

	/**
	*
	**/
	public String getApprovedDate(){ return this.approvedDate; }
	public void setApprovedDate(String value){ this.approvedDate = value; }

	/**
	*
	**/
	public String getApprovedBy(){ return this.approvedBy; }
	public void setApprovedBy(String value){ this.approvedBy = value; }


	public String toString(){
		return "Historyid: " + getHistoryid() +
		"Campus: " + getCampus() +
		"Src: " + getSrc() +
		"Id: " + getId() +
		"Alpha: " + getCourseAlpha() +
		"Num: " + getCourseNum() +
		"Grading: " + getGrading() +
		"Auditdate: " + getAuditDate() +
		"Auditby: " + getAuditBy() +
		"Rdr: " + getRdr() +
		"Approveddate: " + getApprovedDate() +
		"Approvedby: " + getApprovedBy() +
		"Pending: " + getPending() +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}
