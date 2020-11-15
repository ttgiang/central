/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Assess.java
//
package com.ase.aseutil;

public class AssessedData implements Comparable {

	/**
	* Id COUNTER
	**/
	int id = 0;

	/**
	* historyID VARCHAR
	**/
	String historyID = null;

	/**
	* Campus VARCHAR
	**/
	String campus = null;

	/**
	* CourseAlpha VARCHAR
	**/
	String courseAlpha = null;

	/**
	* CourseNum VARCHAR
	**/
	String courseNum = null;

	/**
	* CourseType VARCHAR
	**/
	String courseType = null;

	/**
	* qid int
	**/
	int qid = 0;

	/**
	* question LONGCHAR
	**/
	String question = null;

	/**
	* approvedBy LONGCHAR
	**/
	String approvedBy = null;

	/**
	* approvedDate DATETIME
	**/
	String approvedDate = null;

	/**
	* Auditby VARCHAR
	**/
	String auditBy = null;

	/**
	* Auditdate DATETIME
	**/
	String auditDate = null;

	public AssessedData(){}

	/**
	*
	**/
	public int getID(){ return this.id; }
	public void setID(int value){ this.id = value; }

	/**
	*
	**/
	public String getHistoryID(){ return this.historyID; }
	public void setHistoryID(String value){ this.historyID = value; }

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
	public String getQuestion(){ return this.question; }
	public void setQuestion(String value){ this.question = value; }

	/**
	*
	**/
	public String getApprovedBy(){ return this.approvedBy; }
	public void setApprovedBy(String value){ this.approvedBy = value; }

	/**
	*
	**/
	public int getQid(){ return this.qid; }
	public void setQid(int value){ this.qid = value; }

	/**
	*
	**/
	public String getApprovedDate(){ return this.approvedDate; }
	public void setApprovedDate(String value){ this.approvedDate = value; }

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
		"historyID: " + getHistoryID() +
		"Campus: " + getCampus() +
		"CourseAlpha: " + getCourseAlpha() +
		"CourseNum: " + getCourseNum() +
		"CourseType: " + getCourseType() +
		"question: " + getQuestion() +
		"approvedBy: " + getApprovedBy() +
		"qid: " + getQid() +
		"ApprovedDate: " + getApprovedDate() +
		"Auditby: " + getAuditBy() +
		"Auditdate: " + getAuditDate() +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}