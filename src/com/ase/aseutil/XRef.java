/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// XRef.java
//
package com.ase.aseutil;

public class XRef {

	/**
	* Historyid nvarchar
	**/
	private String historyid = null;

	/**
	* Campus nvarchar
	**/
	private String campus = null;

	/**
	* CourseAlpha nvarchar
	**/
	private String courseAlpha = null;

	/**
	* CourseNum nvarchar
	**/
	private String courseNum = null;

	/**
	* CourseType nvarchar
	**/
	private String courseType = null;

	/**
	* Id numeric
	**/
	int id = 0;

	/**
	* CourseAlphaX nvarchar
	**/
	private String courseAlphaX = null;

	/**
	* CourseNumX nvarchar
	**/
	private String courseNumX = null;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	/**
	* Auditby nvarchar
	**/
	private String auditBy = null;

	private boolean pending = false;

	/**
	*
	**/
	public XRef(){}

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
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getCourseAlphaX(){ return this.courseAlphaX; }
	public void setCourseAlphaX(String value){ this.courseAlphaX = value; }

	/**
	*
	**/
	public String getCourseNumX(){ return this.courseNumX; }
	public void setCourseNumX(String value){ this.courseNumX = value; }

	/**
	*
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	*
	**/
	public boolean getPending(){ return this.pending; }
	public void setPending(boolean value){ this.pending = value; }

	/**
	*
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	public String toString(){
		return "Historyid: " + getHistoryid() +
		"Campus: " + getCampus() +
		"CourseAlpha: " + getCourseAlpha() +
		"CourseNum: " + getCourseNum() +
		"CourseType: " + getCourseType() +
		"Id: " + getId() +
		"CourseAlphaX: " + getCourseAlphaX() +
		"CourseNumX: " + getCourseNumX() +
		"Auditdate: " + getAuditDate() +
		"Auditby: " + getAuditBy() +
		"Pending: " + getPending() +
		"";
	}

	/*
	tblXRef.setHistoryid(rs.getString(i++));
	tblXRef.setCampus(rs.getString(i++));
	tblXRef.setCourseAlpha(rs.getString(i++));
	tblXRef.setCourseNum(rs.getString(i++));
	tblXRef.setCourseType(rs.getString(i++));
	tblXRef.setId(rs.getString(i++));
	tblXRef.setCourseAlphaX(rs.getString(i++));
	tblXRef.setCourseNumX(rs.getString(i++));
	tblXRef.setAuditdate(rs.getString(i++));
	tblXRef.setAuditby(rs.getString(i++));

	tblXRef.getHistoryid();
	tblXRef.getCampus();
	tblXRef.getCourseAlpha();
	tblXRef.getCourseNum();
	tblXRef.getCourseType();
	tblXRef.getId();
	tblXRef.getCourseAlphaX();
	tblXRef.getCourseNumX();
	tblXRef.getAuditdate();
	tblXRef.getAuditby();
	*/

}
