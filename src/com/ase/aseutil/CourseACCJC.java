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

public class CourseACCJC implements Comparable {

	/**
	* Id COUNTER
	**/
	int id = 0;

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
	* content VARCHAR
	**/
	String content = null;

	/**
	* ContentID INTEGER
	**/
	int contentID = 0;

	/**
	* comp VARCHAR
	**/
	String comp = null;

	/**
	* CompID INTEGER
	**/
	int compID = 0;

	/**
	* assessment VARCHAR
	**/
	String assessment = null;

	/**
	* Assessmentid INTEGER
	**/
	int assessmentid = 0;

	/**
	* approvedDate DATETIME
	**/
	String approvedDate = null;

	/**
	* AuditDate DATETIME
	**/
	String auditDate = null;

	/**
	* AuditBy VARCHAR
	**/
	String auditBy = null;

	private String assessedBy;
	private String assessedDate;

	public CourseACCJC(){}

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
	public String getContent(){ return this.content; }
	public void setContent(String value){ this.content = value; }

	/**
	*
	**/
	public int getContentID(){ return this.contentID; }
	public void setContentID(int value){ this.contentID = value; }

	/**
	*
	**/
	public String getComp(){ return this.comp; }
	public void setComp(String value){ this.comp = value; }

	/**
	*
	**/
	public int getCompID(){ return this.compID; }
	public void setCompID(int value){ this.compID = value; }

	/**
	*
	**/
	public String getAssessment(){ return this.assessment; }
	public void setAssessment(String value){ this.assessment = value; }

	/**
	*
	**/
	public int getAssessmentid(){ return this.assessmentid; }
	public void setAssessmentid(int value){ this.assessmentid = value; }

	/**
	*
	**/
	public String getApprovedDate(){ return this.approvedDate; }
	public void setApprovedDate(String value){ this.approvedDate = value; }

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
	public String getAssessedBy() {

		if (this.assessedBy==null)
			return "";
		else
			return this.assessedBy;
	}

	public void setAssessedBy(String value) {this.assessedBy = value;}

	public String getAssessedDate() {return this.assessedDate;}

	public void setAssessedDate(String value) {
		try{
			AseUtil aseUtil = new AseUtil();

			if (value != null){
				value = aseUtil.ASE_FormatDateTime(value,Constant.DATE_DATETIME);
			}
		}
		catch(Exception e){}

		this.assessedDate = value;
	}


	public String toString(){
		return "Id: " + getID() + "<br>" +
		"Campus: " + getCampus() + "<br>" +
		"CourseAlpha: " + getCourseAlpha() + "<br>" +
		"CourseNum: " + getCourseNum() + "<br>" +
		"CourseType: " + getCourseType() + "<br>" +
		"ContentID: " + getContentID() + "<br>" +
		"Comp: " + getComp() + "<br>" +
		"CompID: " + getCompID() + "<br>" +
		"Assessmentid: " + getAssessmentid() + "<br>" +
		"AssessedBy: " + getAssessedBy() + "<br>" +
		"AssessedDate: " + getApprovedDate() + "<br>" +
		"ApprovedDate: " + getApprovedDate() + "<br>" +
		"AuditDate: " + getAuditDate() + "<br>" +
		"AuditBy: " + getAuditBy() + "<br>" +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}