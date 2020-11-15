/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Division.java
//
package com.ase.aseutil;

/**
 * <p>
 * Division deals with course/outline Division
 * </p>
 *
 * <p>
 * An <code>Division</code> represents 1 of 2 key components for identifying an outline.
 * The other is <code>Num</code>. Combined, they make up a course outline.
 * </p>
 *
 * @author Applied Software Engineering
 */

public class Division implements Comparable {

	private int divid = 0;
	private String divisionCode = null;
	private String divisionName = null;
	private String chairName = null;
	private String campus = null;
	private String delegated = null;

	public Division() {}

	public Division(int divid,String divisionCode,String divisionName,String campus) {
		this.divid = divid;
		this.divisionCode = divisionCode;
		this.divisionName = divisionName;
		this.campus = campus;
	}

	public Division(int divid,String divisionCode,String divisionName,String campus,String chairName) {
		this.divid = divid;
		this.divisionCode = divisionCode;
		this.divisionName = divisionName;
		this.campus = campus;
		this.chairName = chairName;
	}

	public Division(int divid,String divisionCode,String divisionName,String campus,String chairName,String delegated) {
		this.divid = divid;
		this.divisionCode = divisionCode;
		this.divisionName = divisionName;
		this.campus = campus;
		this.chairName = chairName;
		this.delegated = delegated;
	}

	public int getDivid() { return this.divid; }
	public void setDivid(int value) { this.divid = value; }

	public String getDivisionCode() { return this.divisionCode; }
	public void setDivisionCode(String value) { this.divisionCode = value; }

	public String getDivisionName() { return this.divisionName; }
	public void setDivisionName(String value) { this.divisionName = value; }

	public String getChairName() { return this.chairName; }
	public void setChairName(String value) { this.chairName = value; }

	public String getDelegated() { return this.delegated; }
	public void setDelegated(String value) { this.delegated = value; }

	public String getCampus() { return this.campus; }
	public void setCampus(String value) { this.campus = value; }

	public int compareTo(Object object) {
		return 0;
	}

}