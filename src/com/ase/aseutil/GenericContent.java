/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// GenericContent.java
//
package com.ase.aseutil;

public class GenericContent {

	/**
	* Id numeric identity
	**/
	int id = 0;

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* CourseAlpha varchar
	**/
	private String courseAlpha = null;

	/**
	* CourseNum varchar
	**/
	private String courseNum = null;

	/**
	* CourseType char
	**/
	private String courseType = null;

	/**
	* Src varchar
	**/
	private String src = null;

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
	* Rdr numeric
	**/
	private int rdr = 0;

	public GenericContent(){}

	public GenericContent(int id,
								String historyid,
								String campus,
								String courseAlpha,
								String courseNum,
								String courseType,
								String src,
								String comments,
								String auditDate,
								String auditBy,
								int rdr){
		this.id = id;
		this.historyid = historyid;
		this.campus = campus;
		this.courseAlpha = courseAlpha;
		this.courseNum = courseNum;
		this.courseType = courseType;
		this.src = src;
		this.comments = comments;
		this.auditDate = auditDate;
		this.auditBy = auditBy;
		this.rdr = 0;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Historyid varchar
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** CourseAlpha varchar
	**/
	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	/**
	** CourseNum varchar
	**/
	public String getCourseNum(){ return this.courseNum; }
	public void setCourseNum(String value){ this.courseNum = value; }

	/**
	** CourseType char
	**/
	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	/**
	** Src varchar
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

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
	** Rdr numeric
	**/
	public int getRdr(){ return this.rdr; }
	public void setRdr(int value){ this.rdr = value; }


	public String toString(){
		return "Id: " + getId() +
		"Historyid: " + getHistoryid() +
		"Campus: " + getCampus() +
		"CourseAlpha: " + getCourseAlpha() +
		"CourseNum: " + getCourseNum() +
		"CourseType: " + getCourseType() +
		"Src: " + getSrc() +
		"Comments: " + getComments() +
		"AuditDate: " + getAuditDate() +
		"AuditBy: " + getAuditBy() +
		"Rdr: " + getRdr() +
		"";
	}
}
