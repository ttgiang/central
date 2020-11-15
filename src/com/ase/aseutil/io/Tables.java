/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Tables.java
//
package com.ase.aseutil.io;

public class Tables {

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* tab varchar
	**/
	private String tab = null;

	/**
	* imprtcolumns
	**/
	private int importcolumns = 0;

	/**
	* alpha varchar
	**/
	private String alpha = null;

	/**
	* num varchar
	**/
	private String num = null;

	/**
	* imprt bit
	**/
	private boolean imprt = false;

	/**
	* importcolumnname varchar
	**/
	private String importcolumnname = null;

	public Tables(){}

	public Tables(String tab,int imprtcolumns,String alpha,String num,String importcolumnname,boolean imprt){
		this.tab = tab;
		this.importcolumns = importcolumns;
		this.importcolumnname = importcolumnname;
		this.alpha = alpha;
		this.num = num;
		this.imprt = imprt;
	}

	/**
	*
	**/
	public String getTab(){ return this.tab; }
	public void setTab(String value){ this.tab = value; }

	/**
	*
	**/
	public int getImportColumns(){ return this.importcolumns; }
	public void setImportColumns(int value){ this.importcolumns = value; }

	/**
	*
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	*
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

	/**
	*
	**/
	public String getImportColumnName(){ return this.importcolumnname; }
	public void setImportColumnName(String value){ this.importcolumnname = value; }

	/**
	*
	**/
	public boolean getImprt(){ return this.imprt; }
	public void setImprt(boolean value){ this.imprt = value; }

	public String toString(){
		return "tab: " + getTab() + "\n" +
		"importcolumns: " + getImportColumns() + "\n" +
		"alpha: " + getAlpha() + "\n" +
		"num: " + getNum() + "\n" +
		"importcolumnname: " + getImportColumnName() + "\n" +
		"imprt: " + getImprt() + "\n" +
		"";
	}
}
