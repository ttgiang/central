/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// News.java
//
package com.ase.aseutil;

public class News implements Comparable {
	private String id = null;
	private String title = null;
	private String content = null;
	private String startdate = null;
	private String enddate = null;
	private String auditby = null;
	private String auditdate = null;
	private String campus = null;
	private String attach = null;

	public News() {
		this.title = "";
		this.content = "";
		this.startdate = "";
		this.enddate = "";
		this.campus = "";
		this.attach = "";
	}

	public News(String id,
					String title,
					String content,
					String startdate,
					String enddate,
					String auditby,
					String auditdate,
					String campus,
					String attach) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.startdate = startdate;
		this.enddate = enddate;
		this.auditby = auditby;
		this.auditdate = auditdate;
		this.campus = campus;
		this.attach = attach;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String value) {
		this.id = value;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String value) {
		this.title = value;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String value) {
		this.content = value;
	}

	public String getStartDate() {
		return this.startdate;
	}

	public void setStartDate(String value) {
		this.startdate = value;
	}

	public String getEndDate() {
		return this.enddate;
	}

	public void setEndDate(String value) {
		this.enddate = value;
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

	public void setCampus(String value) {
		this.campus = value;
	}

	public String getAttach() {
		return this.attach;
	}

	public void setAttach(String value) {
		this.attach = value;
	}

	public String toString(){
		return "id: " + getId() + "<br/>" +
		"title: " + getTitle() + "<br/>" +
		"content: " + getTitle() + "<br/>" +
		"startdate: " + getStartDate() + "<br/>" +
		"enddate: " + getEndDate() + "<br/>" +
		"auditby: " + getAuditBy() + "<br/>" +
		"auditdate: " + getAuditDate() + "<br/>" +
		"campus: " + getCampus() + "<br/>" +
		"attach: " + getAttach() + "<br/>" +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}