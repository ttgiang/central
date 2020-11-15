/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 * 
 * @author ttgiang
 */

//
// Terms.java
//
package com.ase.aseutil;

public class Terms implements Comparable {

	/**
	 * TERM_CODE VARCHAR
	 */
	String TERM_CODE = null;

	/**
	 * TERM_DESCRIPTION VARCHAR
	 */
	String TERM_DESCRIPTION = null;

	public Terms() {
	}

	/**
	 * 
	 */
	public String getTERM_CODE() {
		return this.TERM_CODE;
	}

	public void setTERM_CODE(String value) {
		this.TERM_CODE = value;
	}

	/**
	 * 
	 */
	public String getTERM_DESCRIPTION() {
		return this.TERM_DESCRIPTION;
	}

	public void setTERM_DESCRIPTION(String value) {
		this.TERM_DESCRIPTION = value;
	}

	public String toString() {
		return "TERM_CODE: " + getTERM_CODE() + "TERM_DESCRIPTION: "
				+ getTERM_DESCRIPTION() + "";
	}

	public int compareTo(Object object) {
		return 0;
	}
}