/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Alpha.java
//
package com.ase.aseutil;

/**
 * <p>
 * Alpha deals with course/outline alpha
 * </p>
 *
 * <p>
 * An <code>Alpha</code> represents 1 of 2 key components for identifying an outline.
 * The other is <code>Num</code>. Combined, they make up a course outline.
 * </p>
 *
 * @author Applied Software Engineering
 */

public class Alpha implements Comparable {

	private String dispid = null;

	private String coursealpha = null;
	private String coursealpha_PATTERN = null;
	private int coursealpha_MIN_LENGTH = 3;
	private int coursealpha_MAX_LENGTH = 10;

	private String discipline = null;
	private String auditby = null;
	private String auditdate = null;

	public Alpha(String dispid, String coursealpha, String discipline,String auditby, String auditdate) {
		this.dispid = dispid;
		this.coursealpha = coursealpha;
		this.discipline = discipline;
		this.auditby = auditby;
		this.auditdate = auditdate;
	}

	public Alpha(String coursealpha,String discipline) {
		this.coursealpha = coursealpha;
		this.discipline = discipline;
	}

	public String getDispId() {
		return this.dispid;
	}

	public String getCourseAlpha() {
		return this.coursealpha;
	}

	public void setCourseAlpha(String value) {
		this.coursealpha = WebSite.cleanSQL(value);
	}

	public String getDiscipline() {
		return this.discipline;
	}

	public void setDiscipline(String value) {
		this.discipline = WebSite.cleanSQL(value);
	}

	public String getAuditBy() {
		return this.auditby;
	}

	public String getAuditDate() {
		return this.auditdate;
	}

	public int compareTo(Object object) {
		return 0;
	}

}