/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// IniKey.java
//
package com.ase.aseutil;

public class IniKey {

	/**
	* Id numeric identity
	**/
	private int id = 0;

	/**
	* Kid varchar
	**/
	private String kid = null;

	/**
	* Options varchar
	**/
	private String options = null;

	/**
	* Descr varchar
	**/
	private String descr = null;

	public IniKey(){}

	public IniKey(int id,String kid,String options,String descr){
		this.id = id;
		this.kid = kid;
		this.options = options;
		this.descr = descr;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Kid varchar
	**/
	public String getKid(){ return this.kid; }
	public void setKid(String value){ this.kid = value; }

	/**
	** Options varchar
	**/
	public String getOptions(){ return this.options; }
	public void setOptions(String value){ this.options = value; }

	/**
	** Descr varchar
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }


	public String toString(){
		return "Id: " + getId() +
			"Kid: " + getKid() +
			"Options: " + getOptions() +
			"Descr: " + getDescr() +
		"";
	}
}
