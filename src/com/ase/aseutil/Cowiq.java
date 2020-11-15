/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Cowiq.java
//
package com.ase.aseutil;

public class Cowiq {

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Topic int
	**/
	private int topic = 0;

	/**
	* Seq int
	**/
	private int seq = 0;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* Category varchar
	**/
	private String category = null;

	/**
	* Header varchar
	**/
	private String header = null;

	/**
	* descr varchar
	**/
	private String descr = null;

	public Cowiq(){}

	public Cowiq (int id,int topic,int seq,String category,String header,String descr,String campus){
		this.id = id;
		this.topic = topic;
		this.seq = seq;
		this.category = category;
		this.header = header;
		this.descr = descr;
		this.campus = campus;
	}

	/**
	** Id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Topic int
	**/
	public int getTopic(){ return this.topic; }
	public void setTopic(int value){ this.topic = value; }

	/**
	** Seq int
	**/
	public int getSeq(){ return this.seq; }
	public void setSeq(int value){ this.seq = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }


	/**
	** Category varchar
	**/
	public String getCategory(){ return this.category; }
	public void setCategory(String value){ this.category = value; }

	/**
	** Header varchar
	**/
	public String getHeader(){ return this.header; }
	public void setHeader(String value){ this.header = value; }

	/**
	** descr varchar
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	public String toString(){
		return "Id: " + getId() +
		"Topic: " + getTopic() +
		"Seq: " + getSeq() +
		"Campus: " + getCampus() +
		"Category: " + getCategory() +
		"Header: " + getHeader() +
		"descr: " + getDescr() +
		"";
	}

}
