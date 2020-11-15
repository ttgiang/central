/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @frequency ttgiang
 */

//
// ImportMap.java
//
package com.ase.aseutil.io;

import com.ase.aseutil.*;

import java.util.*;
import javax.servlet.http.*;

public class ImportMap {

	String[] staticText = new String[ImportConstant.IMPORT_DEGREE+1];

	/**
	* filename varchar
	**/
	private String filename = null;

	/**
	* application varchar
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

	/**
	* importType varchar
	**/
	private String importType = null;

	/**
	* hashMap HashMap
	**/
	private HashMap hashMap = null;

	/**
	* hashMap HashMap
	**/
	public ImportMap(){}

	private String alphaID = null;
	private String numberID = null;
	private String alphaOnlyID = null;

	private String departmentID = null;
	private String programID = null;
	private String degreeID = null;

	/**
	*
	* @param filename			String
	* @param application		String
	* @param applicationType	String
	* @param frequency			String
	* @param importType		String
	*
	**/
	public ImportMap(String filename,String application,String applicationType,String frequency,String importType){
		this.filename = filename;
		this.application = application;
		this.applicationType = applicationType;
		this.frequency = frequency;
		this.importType = importType;

		setImportMap(null);
	}

	/**
	* hashMap HashMap
	**/
	public ImportMap(HashMap hashMap){

		if (hashMap != null){
			setImportMap(hashMap);
		}
	}

	/**
	*  session HttpSession
	**/
	public ImportMap(HttpSession session){

		hashMap = (HashMap)session.getAttribute("aseListImportHashMap");

		if (hashMap != null){
			setImportMap(hashMap);
		}
	}

	/**
	*  hashMap HashMap
	**/
	public void setImportMap(HashMap hashMap){

		staticText = ImportConstant.IMPORT_TEXT.split(",");

		if (hashMap != null){

			com.ase.aseutil.util.HashUtil hashUtil = new com.ase.aseutil.util.HashUtil();

			filename = hashUtil.getHashMapParmValue(hashMap,"filename",Constant.BLANK);
			importType = hashUtil.getHashMapParmValue(hashMap,"importType",Constant.BLANK);
			application = hashUtil.getHashMapParmValue(hashMap,"application",Constant.BLANK);
			applicationType = hashUtil.getHashMapParmValue(hashMap,"applicationType",Constant.BLANK);
			frequency = hashUtil.getHashMapParmValue(hashMap,"frequency",Constant.BLANK);

			// prevent invalid data. used for parseInt
			if (importType == null || importType.equals(Constant.BLANK)){
				importType = "0";
			}

			if (application == null || application.equals(Constant.BLANK)){
				application = "0";
			}

			if (applicationType == null || applicationType.equals(Constant.BLANK)){
				applicationType = "0";
			}

			if (frequency == null || frequency.equals(Constant.BLANK)){
				frequency = "0";
			}

			alphaID = hashUtil.getHashMapParmValue(hashMap,"alphaID",Constant.BLANK);
			numberID = hashUtil.getHashMapParmValue(hashMap,"numberID",Constant.BLANK);
			alphaOnlyID = hashUtil.getHashMapParmValue(hashMap,"alphaOnlyID",Constant.BLANK);
			departmentID = hashUtil.getHashMapParmValue(hashMap,"departmentID",Constant.BLANK);
			programID = hashUtil.getHashMapParmValue(hashMap,"programID",Constant.BLANK);
			degreeID = hashUtil.getHashMapParmValue(hashMap,"degreeID",Constant.BLANK);

			hashUtil = null;

		} // hashUtil
	}

	/**
	*
	**/
	public String getFilename(){ return this.filename; }
	public void setFilename(String value){ this.filename = value; }

	/**
	*
	**/
	public String getApplication(){ return this.application; }

	public String getApplicationX(){

		String applicationX = "";

		if (NumericUtil.isInteger(application)){
			applicationX = staticText[Integer.parseInt(application)] + " (" + application + ")";
		}

		return applicationX;
	}

	public int getApplicationAsInt(){

		int id = 0;

		if (NumericUtil.isInteger(application)){
			id = Integer.parseInt(application);
		}

		return id;
	}

	public void setApplication(String value){ this.application = value; }

	/**
	*
	**/
	public String getApplicationType(){ return this.applicationType; }
	public String getApplicationTypeX(){

		String applicationTypeX = "";

		if (NumericUtil.isInteger(applicationTypeX)){
			applicationTypeX = staticText[Integer.parseInt(applicationType)] + " (" + applicationType + ")";
		}

		return applicationTypeX;

	}

	public void setApplicationType(String value){ this.applicationType = value; }

	/**
	*
	**/
	public String getFrequency(){ return this.frequency; }
	public void setFrequency(String value){ this.frequency = value; }

	/**
	*
	**/
	public String getImportType(){ return this.importType; }

	public String getImportTypeX(){

		String importTypeX = "";

		if (NumericUtil.isInteger(importType)){
			importTypeX = staticText[Integer.parseInt(importType)] + " (" + importType + ")";
		}

		return importTypeX;
	}

	public int getImportTypeAsInt(){

		int id = 0;

		if (NumericUtil.isInteger(importType)){
			id = Integer.parseInt(importType);
		}

		return id;
	}

	public void setImportType(String value){ this.importType = value; }

	/**
	*
	**/
	public String getAlphaID(){ return this.alphaID; }
	public void setAlphaID(String value){ this.alphaID = value; }

	/**
	*
	**/
	public String getNumberID(){ return this.numberID; }
	public void setNumberID(String value){ this.numberID = value; }

	/**
	*
	**/
	public String getAlphaOnlyID(){ return this.alphaOnlyID; }
	public void setAlphaOnlyID(String value){ this.alphaOnlyID = value; }

	/**
	*
	**/
	public String getDepartmentID(){ return this.departmentID; }

	public int getDepartmentIDAsInt(){

		int id = 0;

		if (NumericUtil.isInteger(departmentID)){
			id = Integer.parseInt(departmentID);
		}

		return id;
	}

	public void setDepartmentID(String value){ this.departmentID = value; }

	/**
	*
	**/
	public String getProgramID(){ return this.programID; }

	public int getProgramIDAsInt(){

		int id = 0;

		if (NumericUtil.isInteger(programID)){
			id = Integer.parseInt(programID);
		}

		return id;
	}

	public void setProgramID(String value){ this.programID = value; }

	/**
	*
	**/
	public String getDegreeID(){ return this.degreeID; }

	public int getDegreeIDAsInt(){

		int id = 0;

		if (NumericUtil.isInteger(degreeID)){
			id = Integer.parseInt(degreeID);
		}

		return id;
	}

	public void setDegreeID(String value){ this.degreeID = value; }

	public String toString(){
		return "filename: " + getFilename() + "\n" +
		"application: " + getApplication() + "\n" +
		"applicationX: " + getApplicationX() + "\n" +
		"applicationType: " + getApplicationType() + "\n" +
		"applicationTypeX: " + getApplicationTypeX() + "\n" +
		"frequency: " + getFrequency() + "\n" +
		"importType: " + getImportTypeX() + "\n" +
		"getImportTypeAsInt: " + getImportTypeAsInt() + "\n" +
		"alphaID: " + getAlphaID() + "\n" +
		"numberID: " + getNumberID() + "\n" +
		"alphaOnlyID: " + getAlphaOnlyID() + "\n" +
		"departmentID: " + getDepartmentID() + "\n" +
		"getDepartmentIDAsInt: " + getDepartmentIDAsInt() + "\n" +
		"programID: " + getProgramID() + "\n" +
		"getProgramIDInt: " + getProgramIDAsInt() + "\n" +
		"degreeID: " + getDegreeID() + "\n" +
		"getDegreeIDInt: " + getDegreeIDAsInt() + "\n" +
		"";
	}
}
