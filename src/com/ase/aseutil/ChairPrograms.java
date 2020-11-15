/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// ChairPrograms.java
//
package com.ase.aseutil;

public class ChairPrograms {

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Program varchar
	**/
	private String program = null;

	public ChairPrograms (int id,String campus,String program){
		this.id = id;
		this.campus = campus;
		this.program = program;
	}

	/**
	** Id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Program varchar
	**/
	public String getProgram(){ return this.program; }
	public void setProgram(String value){ this.program = value; }


	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Program: " + getProgram() +
		"";
	}
}
