/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// msg.java
//
package com.ase.aseutil;

public class Msg implements Comparable {
	private boolean result = false;

	private int code = 0;
	private String msg = null;
	private String kix = null;
	private String errorLog = null;
	private String userLog = null;

	public Msg() {
		this.msg = "";
	}

	public Msg(boolean result, String msg) {
		this.result = result;
		this.msg = msg;
	}

	public int getCode() {
		return this.code;
	}

	public void setCode(int value) {
		this.code = value;
	}

	public boolean getResult() {
		return this.result;
	}

	public void setResult(boolean value) {
		this.result = value;
	}

	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String value) {
		this.msg = value;
	}

	public String getKix() {
		return this.kix;
	}

	public void setKix(String value) {
		this.kix = value;
	}

	public String getErrorLog() { return this.errorLog; }
	public void setErrorLog(String value) { this.errorLog = value; }

	public String getUserLog() { return this.userLog; }
	public void setUserLog(String value) { this.userLog = value; }

	public String toString() {
		return "Code: " + getCode() + "<br>\n"
			+ "Result: " + getResult()
			+ "<br>\n" + "Msg: " + getMsg()
			+ "<br>\n" + "Error Log: " + getErrorLog()
			+ "<br>\n" + "User Log: " + getUserLog()
			+ "<br>\n" + "Kix: " + getKix()
			+ "<br>\n" + "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}