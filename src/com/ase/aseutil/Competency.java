/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Competency.java
//
package com.ase.aseutil;

public class Competency implements Comparable {

	/**
	* Historyid varchar
	**/
	String historyid;

	/**
	* Seq int identity
	**/
	int seq;

	/**
	* Campus varchar
	**/
	String campus;

	/**
	* CourseAlpha varchar
	**/
	String coursealpha;

	/**
	* CourseNum varchar
	**/
	String coursenum;

	/**
	* CourseType varchar
	**/
	String coursetype;

	/**
	* content text
	**/
	String content;

	/**
	* AuditDate smalldatetime
	**/
	String auditdate;

	/**
	* AuditBy varchar
	**/
	String auditby;

	int rdr;

	public Competency(){}

	/**
	*
	**/
	public Competency(String historyid,String campus,String alpha,String num,String content,String user) {
		this.historyid = historyid;
		this.campus = campus;
		this.coursealpha = alpha;
		this.coursenum = num;
		this.content = content;
		this.auditby = user;
	}

	/**
	*
	**/
	public String getHistoryid() {
		return this.historyid;
	}

	public void setHistoryid(String value) {
		this.historyid = value;
	}

	/**
	*
	**/
	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	/**
	*
	**/
	public String getCourseAlpha() {
		return this.coursealpha;
	}

	public void setCourseAlpha(String value) {
		this.coursealpha = value;
	}

	/**
	*
	**/
	public String getCourseNum() {
		return this.coursenum;
	}

	public void setCourseNum(String value) {
		this.coursenum = value;
	}

	/**
	*
	**/
	public String getCourseType() {
		return this.coursetype;
	}

	public void setCourseType(String value) {
		this.coursetype = value;
	}

	/**
	*
	**/
	public String getContent() {
		return this.content;
	}

	public void setContent(String value) {
		this.content = value;
	}

	/**
	*
	**/
	public String getAuditDate() {
		return this.auditdate;
	}

	public void setAuditDate(String value) {
		this.auditdate = value;
	}

	/**
	*
	**/
	public String getAuditBy() {
		return this.auditby;
	}

	public void setAuditBy(String value) {
		this.auditby = value;
	}

	/**
	*
	**/
	public int getSeq() {
		return this.seq;
	}

	public void setSeq(int value) {
		this.seq = value;
	}

	/**
	*
	**/
	public int getRdr() {
		return this.rdr;
	}

	public void setRdr(int value) {
		this.seq = rdr;
	}

	public String toString(){
		return "Historyid: " + getHistoryid() +
		"Seq: " + getSeq() +
		"Campus: " + getCampus() +
		"CourseAlpha: " + getCourseAlpha() +
		"CourseNum: " + getCourseNum() +
		"CourseType: " + getCourseType() +
		"content: " + getContent() +
		"AuditDate: " + getAuditDate() +
		"AuditBy: " + getAuditBy() +
		"";
	}

	public int compareTo(Object object) {
		return (0);
	}

}