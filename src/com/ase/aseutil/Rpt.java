/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Rpt.java
//
package com.ase.aseutil;

public class Rpt {

	/**
	* Id numeric identity
	**/
	private int id;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Rptname varchar
	**/
	private String rptName = null;

	/**
	* rptFileName varchar
	**/
	private String rptFileName = null;

	/**
	* rptTitle varchar
	**/
	private String rptTitle = null;

	/**
	* rptFormat char
	**/
	private String rptFormat = null;

	/**
	* rptFormat char
	**/
	private String rptParm1 = null;
	private String rptParm2 = null;
	private String rptParm3 = null;
	private String rptParm4 = null;

	public Rpt(){}

	public Rpt (int id,String campus,String rptName,String rptFileName,String rptTitle,String rptFormat){
		this.id = 0;
		this.campus = "";
		this.rptName = "";
		this.rptFileName = "";
		this.rptTitle = "";
		this.rptFormat = "";
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
	** Rptname varchar
	**/
	public String getRptName(){ return this.rptName; }
	public void setRptName(String value){ this.rptName = value; }

	/**
	** rptFileName varchar
	**/
	public String getRptFileName(){ return this.rptFileName; }
	public void setRptFileName(String value){ this.rptFileName = value; }

	/**
	** rptTitle varchar
	**/
	public String getRptTitle(){ return this.rptTitle; }
	public void setRptTitle(String value){ this.rptTitle = value; }

	/**
	** rptFormat char
	**/
	public String getRptFormat(){ return this.rptFormat; }
	public void setRptFormat(String value){ this.rptFormat = value; }

	/**
	** rptFormat char
	**/
	public String getRptParm1(){ return this.rptParm1; }
	public void setRptParm1(String value){ this.rptParm1 = value; }

	public String getRptParm2(){ return this.rptParm2; }
	public void setRptParm2(String value){ this.rptParm2 = value; }

	public String getRptParm3(){ return this.rptParm3; }
	public void setRptParm3(String value){ this.rptParm3 = value; }

	public String getRptParm4(){ return this.rptParm4; }
	public void setRptParm4(String value){ this.rptParm4 = value; }

	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Rptname: " + getRptName() +
		"rptFileName: " + getRptFileName() +
		"rptTitle: " + getRptTitle() +
		"rptFormat: " + getRptFormat() +
		"rptParm1: " + getRptParm1() +
		"rptParm2: " + getRptParm2() +
		"rptParm3: " + getRptParm3() +
		"rptParm4: " + getRptParm4() +
		"";
	}
}
