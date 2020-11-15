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

public class Assess implements Comparable {

	private String assessmentid = null;
	private String assessment = null;
	private String campus = null;
	private String auditby = null;
	private String auditdate = null;

	public Assess() {}

	public Assess(
		String assessmentid,
		String assessment,
		String campus,
		String auditby,
		String auditdate) {
		this.assessmentid = assessmentid;
		this.assessment = assessment;
		this.campus = campus;
		this.auditby = auditby;
		this.auditdate = auditdate;
	}

	public String getId() {
		return this.assessmentid;
	}

	public void setId(String value) {
		this.assessmentid = value;
	}

	public String getAssessment() {
		return this.assessment;
	}

	public void setAssessment(String value) {
		this.assessment = value;
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