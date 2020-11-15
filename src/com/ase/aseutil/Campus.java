/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// Campus.java
//
package com.ase.aseutil;

public class Campus implements Comparable {

	/**
	 * Id COUNTER
	 */
	int Id = 0;

	/**
	 * Campus VARCHAR
	 */
	String campus = null;

	/**
	 * campusDescr VARCHAR
	 */
	String campusDescr = null;

	/**
	 * courseItems LONGCHAR
	 */
	String courseItems = null;

	/**
	 * campusItems LONGCHAR
	 */
	String campusItems = null;

	public Campus() {
	}

	/**
	 * 
	 */
	public int getId() {
		return this.Id;
	}

	public void setId(int value) {
		this.Id = value;
	}

	/**
	 * 
	 */
	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	/**
	 * 
	 */
	public String getCampusDescr() {
		return this.campusDescr;
	}

	public void setCampusDescr(String value) {
		this.campusDescr = value;
	}

	/**
	 * 
	 */
	public String getCourseItems() {
		return this.courseItems;
	}

	public void setCourseItems(String value) {
		this.courseItems = value;
	}

	/**
	 * 
	 */
	public String getCampusItems() {
		return this.campusItems;
	}

	public void setCampusItems(String value) {
		this.campusItems = value;
	}

	public String toString() {
		return "Id: " + getId() + "Campus: " + getCampus() + "campusDescr: "
				+ getCampusDescr() + "courseItems: " + getCourseItems()
				+ "campusItems: " + getCampusItems() + "";
	}

	public int compareTo(Object object) {
		return 0;
	}
}