/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Debug.java
//
package com.ase.aseutil;

public class Debug {


	/**
	* Id numeric identity
	**/
	private int id;

	/**
	* Page varchar
	**/
	private String page = null;

	/**
	* Debug bit
	**/
	private boolean debug = false;

	public Debug (String page,boolean debug){
		this.page = page;
		this.debug = debug;
	}

	public Debug (int id,String page,boolean debug){
		this.id = 0;
		this.page = "";
		this.debug = false;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Page varchar
	**/
	public String getPage(){ return this.page; }
	public void setPage(String value){ this.page = value; }

	/**
	** Debug bit
	**/
	public boolean getDebug(){ return this.debug; }
	public void setDebug(boolean value){ this.debug = value; }


	public String toString(){
		return "Id: " + getId() +
		"Page: " + getPage() +
		"Debug: " + getDebug() +
		"";
	}
}
