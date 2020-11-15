/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Chairs.java
//
package com.ase.aseutil;

public class Chairs {

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Program int
	**/
	private int program = 0;

	/**
	* Coursealpha varchar
	**/
	private String courseAlpha = null;

	/**
	* Title varchar
	**/
	private String title = null;

	/**
	* userID char
	**/
	private String userID = null;

	public Chairs (int id,String campus,int program,String courseAlpha,String title,String userID){
		this.id = id;
		this.campus = campus;
		this.program = program;
		this.courseAlpha = courseAlpha;
		this.title = title;
		this.userID = userID;
	}

	/**
	** id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Program int
	**/
	public int getProgram(){ return this.program; }
	public void setProgram(int value){ this.program = value; }

	/**
	** Coursealpha varchar
	**/
	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	/**
	** Title varchar
	**/
	public String getTitle(){ return this.title; }
	public void setTitle(String value){ this.title = value; }

	/**
	** userID char
	**/
	public String getUserID(){ return this.userID; }
	public void setUserID(String value){ this.userID = value; }

	public String toString(){
		return "id: " + getId() +
		"Campus: " + getCampus() +
		"Program: " + getProgram() +
		"Coursealpha: " + getCourseAlpha() +
		"Title: " + getTitle() +
		"userID: " + getUserID() +
		"";
	}
}
