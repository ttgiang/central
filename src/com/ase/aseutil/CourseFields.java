/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// CourseFields.java
//
package com.ase.aseutil;

public class CourseFields implements Comparable {
	private String type = null;

	private String name = null;

	private String content = null;

	public CourseFields() {
	}

	public String getType() {
		return this.type;
	}

	public void setType(String value) {
		this.type = value;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String value) {
		this.name = value;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String value) {
		this.content = value;
	}

	public int compareTo(Object object) {
		return (0);
	}

}