/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Form.java
//
package com.ase.aseutil;

public class Form {

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* title varchar
	**/
	private String title = null;

	/**
	* link varchar
	**/
	private String link = null;

	/**
	* descr text
	**/
	private String descr = null;

	public Form(){}

	public Form (int id,String campus,String title,String link,String descr){
		this.id = id;
		this.title = title;
		this.link = link;
		this.descr = descr;
		this.campus = campus;
	}

	/**
	** id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** title varchar
	**/
	public String getTitle(){ return this.title; }
	public void setTitle(String value){ this.title = value; }

	/**
	** link varchar
	**/
	public String getLink(){ return this.link; }
	public void setLink(String value){ this.link = value; }

	/**
	** descr text
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }


	public String toString(){
		return "id: " + getId() +
		"campus: " + getCampus() +
		"title: " + getTitle() +
		"link: " + getLink() +
		"descr: " + getDescr() +
		"";
	}

}
