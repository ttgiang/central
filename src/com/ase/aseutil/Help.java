/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Help.java
//
package com.ase.aseutil;

public class Help implements Comparable {
	private String id = null;

	private String category = null;

	private String title = null;

	private String subtitle = null;

	private String content = null;

	private String kval3 = null;

	private String kval4 = null;

	private String kval5 = null;

	private String auditby = null;

	private String auditdate = null;

	private String campus = null;

	public Help() {
	}

	public Help(String id, String category, String title, String subtitle,
			String content, String auditby, String auditdate, String campus) {

		this.id = id;
		this.category = category;
		this.title = title;
		this.subtitle = subtitle;
		this.content = content;
		this.auditby = auditby;
		this.auditdate = auditdate;
		this.campus = campus;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String value) {
		this.id = value;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String value) {
		this.category = value;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String value) {
		this.title = value;
	}

	public String getSubTitle() {
		return this.subtitle;
	}

	public void setSubTitle(String value) {
		this.subtitle = value;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String value) {
		this.content = value;
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

	public String getCampus() {
		return this.campus;
	}

	public int compareTo(Object object) {
		return 0;
	}

}