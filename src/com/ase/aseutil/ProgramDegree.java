/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// ProgramDegree.java
//
package com.ase.aseutil;

public class ProgramDegree {

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* Degree_id decimal
	**/
	int degree_Id = 0;

	/**
	* degree_Alpha varchar
	**/
	private String degree_Alpha = null;

	/**
	* degree_Title varchar
	**/
	private String degree_Title = null;

	/**
	* degree_Desc varchar
	**/
	private String degree_Desc = null;

	/**
	* degree_Date smalldatetime
	**/
	private String degree_Date = null;

	/**
	* addedBy varchar
	**/
	private String addedBy = null;

	/**
	* addedDate smalldatetime
	**/
	private String addedDate = null;

	/**
	* auditBy varchar
	**/
	private String auditBy = null;

	/**
	* auditDate smalldatetime
	**/
	private String auditDate = null;

	public ProgramDegree(){
		this.campus = "";
		this.degree_Id = 0;
		this.degree_Alpha = "";
		this.degree_Title = "";
		this.degree_Desc = "";
		this.degree_Date = "";
		this.addedBy = "";
		this.addedDate = "";
		this.auditBy = "";
		this.auditDate = "";
	}

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Degree_id decimal
	**/
	public int getDegree_Id(){ return this.degree_Id; }
	public void setDegree_Id(int value){this.degree_Id = value;}

	/**
	** degree_Alpha varchar
	**/
	public String getDegree_Alpha(){ return this.degree_Alpha; }
	public void setDegree_Alpha(String value){ this.degree_Alpha = value; }

	/**
	** degree_Title varchar
	**/
	public String getDegree_Title(){ return this.degree_Title; }
	public void setDegree_Title(String value){ this.degree_Title = value; }

	/**
	** degree_Desc varchar
	**/
	public String getDegree_Desc(){ return this.degree_Desc; }
	public void setDegree_Desc(String value){ this.degree_Desc = value; }

	/**
	** degree_Date smalldatetime
	**/
	public String getDegree_Date(){ return this.degree_Date; }
	public void setDegree_Date(String value){ this.degree_Date = value; }

	/**
	** addedBy varchar
	**/
	public String getAddedBy(){ return this.addedBy; }
	public void setAddedBy(String value){ this.addedBy = value; }

	/**
	** addedDate smalldatetime
	**/
	public String getAddedDate(){ return this.addedDate; }
	public void setAddedDate(String value){ this.addedDate = value; }

	/**
	** auditBy varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** auditDate smalldatetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	public String toString(){
		return "campus: " + getCampus() +
		"Degree_id: " + getDegree_Id() +
		"degree_Alpha: " + getDegree_Alpha() +
		"degree_Title: " + getDegree_Title() +
		"degree_Desc: " + getDegree_Desc() +
		"degree_Date: " + getDegree_Date() +
		"addedBy: " + getAddedBy() +
		"addedDate: " + getAddedDate() +
		"auditBy: " + getAuditBy() +
		"auditDate: " + getAuditDate() +
		"";
	}
}
