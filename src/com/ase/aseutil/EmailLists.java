/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// EmailLists.java
//
package com.ase.aseutil;

public class EmailLists {

	private int listID;
	private String title;
	private String members;
	private String campus;
	private String auditby;
	private String auditdate;

	WebSite website = null;

	public EmailLists() {}

	public EmailLists(WebSite ws) {
		website = ws;
	}

	public EmailLists(int listID, String title, String members, String campus) {
		this.listID = listID;
		this.title = title;
		this.members = members;
		this.campus = campus;
	}

	public int getListID() {
		return this.listID;
	}

	public void setListID(int value) {
		this.listID = value;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String value) {
		this.title = value;
	}

	public String getMembers() {
		return this.members;
	}

	public void setMembers(String value) {
		this.members = value;
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

	public String toString() {

		return "ID: " + getListID() + "<br>\n"
			+ "Title: " + getTitle() + "<br>\n"
			+ "Members: " + getMembers() + "<br>\n"
			+ "Campus: " + getCampus();
	}
}
