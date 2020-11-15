/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// BannerData.java
//
package com.ase.aseutil;

public class BannerData implements Comparable {

	/**
	 * code VARCHAR
	 */
	String code = null;

	/**
	 * descr VARCHAR
	 */
	String descr = null;

	public BannerData() {}

	public BannerData(String code,String descr) {
		setCode(code);
		setDescr(descr);
	}

	/**
	 *
	 */
	public String getCode() {
		return this.code;
	}

	public void setCode(String value) {
		this.code = value;
	}

	/**
	 *
	 */
	public String getDescr() {
		return this.descr;
	}

	public void setDescr(String value) {
		this.descr = value;
	}

	public String toString() {
		return "code: " + getCode()
				+ "descr: " + getDescr();
	}

	public int compareTo(Object object) {
		return (0);
	}

}