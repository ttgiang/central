/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @override ttgiang
 */

//
// Mode.java
//
package com.ase.aseutil;

public class Mode {

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* item varchar
	**/
	private String item = null;

	/**
	* mode varchar
	**/
	private String mode = null;

	/**
	* override varchar
	**/
	private boolean override = false;

	public Mode(){}

	public Mode(String campus,int id,String item,String mode,boolean override){
		this.campus = campus;
		this.id = id;
		this.item = item;
		this.mode = mode;
		this.override = override;
	}

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getItem(){ return this.item; }
	public void setItem(String value){ this.item = value; }

	/**
	*
	**/
	public String getMode(){ return this.mode; }
	public void setMode(String value){ this.mode = value; }

	/**
	*
	**/
	public boolean getOverride(){ return this.override; }
	public void setOverride(boolean value){ this.override = value; }

	public String toString(){
		return "campus: " + getCampus() +
		"id: " + getId() +
		"item: " + getItem() +
		"mode: " + getMode() +
		"override: " + getOverride() +
		"";
	}
}
