/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Degree.java
//
package com.ase.aseutil;

/**
 * <p>
 * Degree deals with course/outline Degree
 * </p>
 *
 * <p>
 * An <code>Degree</code> represents 1 of 2 key components for identifying an outline.
 * The other is <code>Num</code>. Combined, they make up a course outline.
 * </p>
 *
 * @author Applied Software Engineering
 */

public class Degree implements Comparable {

	private int degreeId = 0;
	private String title = null;
	private String alpha = null;
	private String descr = null;
	private String campus = null;

	public Degree() {}

	public Degree(int degreeId,String alpha,String title,String descr,String campus) {
		this.degreeId = degreeId;
		this.title = title;
		this.alpha = alpha;
		this.campus = campus;
		this.descr = descr;
	}

	public int getDegreeId() { return this.degreeId; }
	public void setDegreeId(int value) { this.degreeId = value; }

	public String getTitle() { return this.title; }
	public void setTitle(String value) { this.title = value; }

	public String getAlpha() { return this.alpha; }
	public void setAlpha(String value) { this.alpha = value; }

	public String getDescr() { return this.descr; }
	public void setDescr(String value) { this.descr = value; }

	public String getCampus() { return this.campus; }
	public void setCampus(String value) { this.campus = value; }

	public int compareTo(Object object) {
		return 0;
	}

}