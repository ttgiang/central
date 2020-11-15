/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// Content.java
//
package com.ase.aseutil;

public class Content implements Comparable {

	/**
	 * CourseAlpha VARCHAR
	 */
	String courseAlpha = null;

	/**
	 * CourseNum VARCHAR
	 */
	String courseNum = null;

	/**
	 * CourseType VARCHAR
	 */
	String courseType = null;

	/**
	 * ContentID COUNTER
	 */
	int contentID = 0;

	/**
	 * Campus VARCHAR
	 */
	String campus = null;

	/**
	 * ShortContent VARCHAR
	 */
	String shortContent = null;

	/**
	 * LongContent VARCHAR
	 */
	String longContent = null;

	/**
	 * Auditdate DATETIME
	 */
	String auditDate = null;

	/**
	 * Auditby VARCHAR
	 */
	String auditBy = null;

	public Content() {
	}

	/**
	 * get/setCourseAlpha*
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getCourseAlpha() {
		return this.courseAlpha;
	}

	public void setCourseAlpha(java.lang.String value) {
		this.courseAlpha = value;
	}

	/**
	 * get/setCourseNum
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getCourseNum() {
		return this.courseNum;
	}

	public void setCourseNum(java.lang.String value) {
		this.courseNum = value;
	}

	/**
	 * get/setCourseType
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getCourseType() {
		return this.courseType;
	}

	public void setCourseType(java.lang.String value) {
		this.courseType = value;
	}

	/**
	 * get/setContentID*
	 * <p>
	 * 
	 * @return java.lang.Integer
	 */
	public java.lang.Integer getContentID() {
		return this.contentID;
	}

	public void setContentID(java.lang.Integer value) {
		this.contentID = value;
	}

	/**
	 * get/setCampus
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getCampus() {
		return this.campus;
	}

	public void setCampus(java.lang.String value) {
		this.campus = value;
	}

	/**
	 * get/setShortContent
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getShortContent() {
		return this.shortContent;
	}

	public void setShortContent(java.lang.String value) {
		this.shortContent = value;
	}

	/**
	 * get/setLongContent
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getLongContent() {
		return this.longContent;
	}

	public void setLongContent(java.lang.String value) {
		this.longContent = value;
	}

	/**
	 * get/setAuditdate
	 * <p>
	 * 
	 * @return java.sql.Timestamp
	 */
	public String getAuditDate() {
		return this.auditDate;
	}

	public void setAuditDate(String value) {
		this.auditDate = value;
	}

	/**
	 * get/setAuditby
	 * <p>
	 * 
	 * @return java.lang.String
	 */
	public java.lang.String getAuditBy() {
		return this.auditBy;
	}

	public void setAuditBy(java.lang.String value) {
		this.auditBy = value;
	}

	public String toString() {
		return "CourseAlpha: " + getCourseAlpha() + "CourseNum: "
				+ getCourseNum() + "CourseType: " + getCourseType()
				+ "ContentID: " + getContentID() + "Campus: " + getCampus()
				+ "ShortContent: " + getShortContent() + "LongContent: "
				+ getLongContent() + "Auditdate: " + getAuditDate()
				+ "Auditby: " + getAuditBy() + "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}