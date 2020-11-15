/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Sys.java
//
package com.ase.aseutil;

public class Sys {

	/**
	* Id numeric identity
	**/
	private int id;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Named varchar
	**/
	private String named = null;

	/**
	* descr varchar
	**/
	private String descr = null;

	/**
	* Valu varchar
	**/
	private String valu = null;

	public Sys(){
		this.id = 0;
		this.campus = "";
		this.named = "";
		this.valu = "";
		this.descr = "";
	}

	public Sys(String campus,String named,String valu){
		this.campus = campus;
		this.named = named;
		this.valu = valu;
	}

	public Sys(String campus,String named,String valu,String descr){
		this.campus = campus;
		this.named = named;
		this.valu = valu;
		this.descr = descr;
	}

	public Sys(int id,String campus,String named,String valu){
		this.id = id;
		this.campus = campus;
		this.named = named;
		this.valu = valu;
	}

	public Sys(int id,String campus,String named,String valu,String descr){
		this.id = id;
		this.campus = campus;
		this.named = named;
		this.valu = valu;
		this.descr = descr;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Named varchar
	**/
	public String getNamed(){ return this.named; }
	public void setNamed(String value){ this.named = value; }

	/**
	** Valu varchar
	**/
	public String getValu(){ return this.valu; }
	public void setValu(String value){ this.valu = value; }

	/**
	** descr varchar
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Named: " + getNamed() +
		"Valu: " + getValu() +
		"Descr: " + getDescr() +
		"";
	}

}
