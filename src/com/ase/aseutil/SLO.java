/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// SLO.java
//
package com.ase.aseutil;

public class SLO implements Comparable {


	/**
	* Id COUNTER
	**/
	private int Id = 0;

	/**
	* hid
	**/
	private String hid = null;

	/**
	* Campus VARCHAR
	**/
	private String campus = null;

	/**
	* CourseAlpha VARCHAR
	**/
	private String courseAlpha = null;

	/**
	* CourseNum VARCHAR
	**/
	private String courseNum = null;

	/**
	* CourseType VARCHAR
	**/
	private String courseType = null;

	/**
	* Progress VARCHAR
	**/
	private String progress = null;

	/**
	* comments VARCHAR
	**/
	private String comments = null;

	private String auditBy;
	private String auditDate;

	public SLO(){}

	public SLO(String campus,String alpha,String num,String progress,String userid,String hid) {
		this.campus = campus;
		this.courseAlpha = alpha;
		this.courseNum = num;
		this.progress = progress;
		this.auditBy = userid;
		this.hid = hid;
	}

	/**
	*
	**/
	public int getId(){ return this.Id; }
	public void setId(int value){ this.Id = value; }

	/**
	*
	**/
	public String getHid(){ return this.hid; }
	public void setHid(String value){ this.hid = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

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
	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	/**
	*
	**/
	public String getProgress(){ return this.progress; }
	public void setProgress(String value){ this.progress = value; }

	/**
	*
	**/
	public String getComments(){ return this.comments; }
	public void setComments(String value){ this.comments = value; }

	public String getAuditBy() {return this.auditBy;}
	public void setAuditBy(String value) {this.auditBy = value;}

	public String getAuditDate() {return this.auditDate;}
	public void setAuditDate(String value) {this.auditDate = value;}


	public String toString(){
		return "Id: " + getId() +
		"Hid: " + getHid() +
		"Campus: " + getCampus() +
		"CourseAlpha: " + getCourseAlpha() +
		"CourseNum: " + getCourseNum() +
		"CourseType: " + getCourseType() +
		"Progress: " + getProgress() +
		"Comments: " + getComments() +
		"auditBy: " + getAuditBy() +
		"auditDate: " + getAuditDate() +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}