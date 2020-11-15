/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// Discipline.java
//
package com.ase.aseutil;

public class Discipline implements Comparable {
	private String dispID = null;

	private String courseAlpha = null;

	private String discipline = null;

	private String campus = null;

	private String auditby = null;

	private String auditdate = null;

	public Discipline() {
	}

	public Discipline(String dispID, String courseAlpha, String discipline,
			String campus, String auditby, String auditdate) {
		this.dispID = dispID;
		this.courseAlpha = courseAlpha;
		this.discipline = discipline;
		this.campus = campus;
		this.auditby = auditby;
		this.auditdate = auditdate;
	}

	public String getDispId() {
		return this.dispID;
	}

	public void setDispId(String value) {
		this.dispID = value;
	}

	public String getCourseAlpha() {
		return this.courseAlpha;
	}

	public void setCourseAlpha(String value) {
		this.courseAlpha = value;
	}

	public String getDiscipline() {
		return this.discipline;
	}

	public void setDiscipline(String value) {
		this.discipline = value;
	}

	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	public String getAuditBy() {
		return this.auditby;
	}

	public void setAuditBy(String value) {
		this.auditby = value;
	}

	public String getAuditDate() {
		return this.auditdate;
	}

	public void setAuditDate(String value) {
		this.auditdate = value;
	}

	public int compareTo(Object object) {
		return 0;
	}

}