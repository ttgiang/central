/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// PDF.java
//
package com.ase.aseutil;

public class PDF implements Comparable {

	/**
	* Id numeric identity
	**/
	private int id;

	/**
	* Type varchar
	**/
	private String type;

	/**
	* User varchar
	**/
	private String userid;

	/**
	* int seq
	**/
	private int seq;

	/**
	* Kix char
	**/
	private String kix;

	/**
	* Field01 text
	**/
	private String field01;

	/**
	* Field02 text
	**/
	private String field02;

	/**
	* auditDate date
	**/
	private String auditDate;

	/**
	* colum	varchar(20)
	**/
	private String colum;

	public PDF(String type,String user,String kix,String field01,String field02,int seq){

		this.type = type;
		this.userid = user;
		this.kix = kix;
		this.field01 = field01;
		this.field02 = field02;
		this.seq = seq;
	}

	public PDF(String type,String user,String kix,String field01,String field02,int seq,String colum){

		this.type = type;
		this.userid = user;
		this.kix = kix;
		this.field01 = field01;
		this.field02 = field02;
		this.seq = seq;
		this.colum = colum;
	}

	public int getID() { return this.id; }
	public void setID(int id) { this.id = id; }

	public String getType() {return this.type;}
	public void setType(String value) {this.type = value;}

	public String getKix() {return this.kix;}
	public void setKix(String value) {this.kix = value;}

	public String getUserID() {return this.userid;}
	public void setUserID(String value) {this.userid = value;}

	public String getField01() {return this.field01;}
	public void setField01(String value) {this.field01 = value;}

	public String getField02() {return this.field02;}
	public void setField02(String value) {this.field02 = value;}

	public String getAuditDate() {return this.auditDate;}
	public void setAuditDate(String value) {this.auditDate = value;}

	public int getSeq() {return this.seq;}
	public void setSeq(int value) {this.seq = value;}

	public String getColum() {return this.colum;}
	public void setColum(String value) {this.colum = value;}

	public String toString(){
		return
		"Id: " + getID() + "<br>\n" +
		"Type: " + getType() + "<br>\n" +
		"Seq: " + getSeq() + "<br>\n" +
		"User: " + getUserID() + "<br>\n" +
		"Kix: " + getKix() + "<br>\n" +
		"Field01: " + getField01() + "<br>\n" +
		"Field02: " + getField02() + "<br>\n" +
		"Colum: " + getColum() + "<br>\n" +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}