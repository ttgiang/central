/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// JSID.java
//
package com.ase.aseutil;

public class JSID implements Comparable {

	/**
	* Id COUNTER
	**/
	int Id = 0;

	/**
	* Jsid VARCHAR
	**/
	String jsid = null;

	/**
	* Page VARCHAR
	**/
	String page = null;

	/**
	* Campus VARCHAR
	**/
	String campus = null;

	/**
	* Alpha VARCHAR
	**/
	String alpha = null;

	/**
	* Num VARCHAR
	**/
	String num = null;

	/**
	* Type VARCHAR
	**/
	String type = null;

	/**
	* User VARCHAR
	**/
	String userName = null;

	/**
	* Start VARCHAR
	**/
	String start = null;

	/**
	* audit VARCHAR
	**/
	String audit = null;

	/**
	* End VARCHAR
	**/
	String endDate = null;

	public JSID(){}

	/**
	*
	**/
	public int getId(){ return this.Id; }
	public void setId(int value){ this.Id = value; }

	/**
	*
	**/
	public String getjsid(){ return this.jsid; }
	public void setsid(String value){ this.jsid = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getPage(){ return this.page; }
	public void setPage(String value){ this.page = value; }

	/**
	*
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	*
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

	/**
	*
	**/
	public String getType(){ return this.type; }
	public void setType(String value){ this.type = value; }

	/**
	*
	**/
	public String getUserName(){ return this.userName; }
	public void setUserName(String value){ this.userName = value; }

	/**
	*
	**/
	public String getStart(){ return this.start; }
	public void setStart(String value){ this.start = value; }

	/**
	*
	**/
	public String getAudit(){ return this.audit; }
	public void setAudit(String value){ this.audit = value; }

	/**
	*
	**/
	public String getEndDate(){ return this.endDate; }
	public void setEndDate(String value){ this.endDate = value; }


	public String toString(){
		return "Id: " + getId() +
		"Jsid: " + getjsid() +
		"Campus: " + getCampus() +
		"Page: " + getPage() +
		"Alpha: " + getAlpha() +
		"Num: " + getNum() +
		"Type: " + getType() +
		"User: " + getUserName() +
		"Start: " + getStart() +
		"Audit: " + getAudit() +
		"End: " + getEndDate() +
		"";
	}

	public int compareTo(Object object) {
		return (0);
	}

}