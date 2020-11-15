/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// importTypeles.java
//
package com.ase.aseutil.io;

public class Import {

	/**
	* id int identity
	**/
	private int id = 0;

	/**
	* importType varchar
	**/
	private String importType = null;

	/**
	* imprtcolumns
	**/
	private String application = null;

	/**
	* applicationType varchar
	**/
	private String applicationType = null;

	/**
	* frequency varchar
	**/
	private String frequency = null;

	public Import(){}

	public Import(String importType,String applicationType,String frequency,String application){
		this.importType = importType;
		this.application = application;
		this.applicationType = applicationType;
		this.frequency = frequency;
	}

	/**
	*
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getImportType(){ return this.importType; }
	public void setImportType(String value){ this.importType = value; }

	/**
	*
	**/
	public String getApplication(){ return this.application; }
	public void setApplication(String value){ this.application = value; }

	/**
	*
	**/
	public String getApplicationType(){ return this.applicationType; }
	public void setApplicationType(String value){ this.applicationType = value; }

	/**
	*
	**/
	public String getFrequency(){ return this.frequency; }
	public void setFrequency(String value){ this.frequency = value; }

	public String toString(){
		return
		"id: " + getId() + "\n" +
		"importType: " + getImportType() + "\n" +
		"application: " + getApplication() + "\n" +
		"applicationType: " + getApplicationType() + "\n" +
		"frequency: " + getFrequency() + "\n" +
		"";
	}
}
