/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// Stmt.java
//
package com.ase.aseutil;

public class Stmt implements Comparable {
	private String id = null;

	private String statement = null;

	private String type = null;

	private String campus = null;

	private String auditby = null;

	private String auditdate = null;

	public Stmt() {
	}

	public Stmt(String id, String type, String statement, String campus,
			String auditby, String auditdate) {
		this.id = id;
		this.statement = statement;
		this.type = type;
		this.campus = campus;
		this.auditby = auditby;
		this.auditdate = auditdate;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String value) {
		this.id = value;
	}

	public String getStmt() {
		return this.statement;
	}

	public void setStmt(String value) {
		this.statement = value;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String value) {
		this.type = value;
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
		return "Id: " + getId() + "<br>\n" + "Type: " + getType() + "<br>\n"
				+ "Statement: " + getStmt() + "<br>\n" + "Campus: "
				+ getCampus() + "<br>\n" + "Auditby: " + getAuditBy()
				+ "<br>\n" + "AuditDate: " + getAuditDate() + "<br>\n" + "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}