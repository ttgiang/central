/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Programs.java
//
package com.ase.aseutil;

public class Programs {

	/**
	* degree int
	**/
	private int degree = 0;
	private String degreeDescr = null;
	private String degreeTitle = null;

	/**
	* division int
	**/
	private int division = 0;
	private String divisionDescr = null;
	private String divisionName = null;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* auditBy varchar
	**/
	private String auditBy = null;

	/**
	* auditDate smalldatetime
	**/
	private String auditDate = null;

	/**
	* title varchar
	**/
	private String title = null;

	/**
	* description varchar
	**/
	private String description = null;

	/**
	* effectiveDate varchar
	**/
	private String effectiveDate = null;

	/**
	* year varchar
	**/
	private String year = null;

	/**
	* regentsApproval boolean
	**/
	private boolean regentsApproval = false;

	/**
	* proposer varchar
	**/
	private String proposer = null;

	/**
	* progress varchar
	**/
	private String progress = null;

	/**
	* historyid varchar
	**/
	private String historyid = null;

	/**
	* type varchar
	**/
	private String type = null;

	/**
	* subprogress varchar
	**/
	private String subprogress = null;

	/**
	* program varchar
	**/
	private String program = null;

	/**
	* route int
	**/
	private int route = 0;

	/**
	* constructor
	**/
	public Programs(){
		this.degree = 0;
		this.division = 0;
		this.campus= "";
		this.title = "";
		this.description = "";
		this.effectiveDate = "";
		this.year = "";
		this.auditBy = "";
		this.auditDate = "";
		this.regentsApproval = false;
		this.proposer = "";
		this.progress = "";
		this.historyid = "";
		this.type = "";
		this.degreeDescr = "";
		this.degreeTitle = "";
		this.divisionDescr = "";
		this.divisionName = "";
		this.route = 0;
		this.subprogress = "";
		this.program = "";
	}

	/**
	** degree int
	**/
	public int getDegree(){ return this.degree; }
	public void setDegree(int value){ this.degree = value; }

	public String getProgram(){ return this.program; }
	public void setProgram(String value){ this.program = value; }

	public String getDegreeDescr(){ return this.degreeDescr; }
	public void setDegreeDescr(String value){ this.degreeDescr = value; }

	public String getDegreeTitle(){ return this.degreeTitle; }
	public void setDegreeTitle(String value){ this.degreeTitle = value; }

	/**
	** division int
	**/
	public int getDivision(){ return this.division; }
	public void setDivision(int value){ this.division = value; }

	public String getDivisionDescr(){ return this.divisionDescr; }
	public void setDivisionDescr(String value){ this.divisionDescr = value; }

	public String getDivisionName(){ return this.divisionName; }
	public void setDivisionName(String value){ this.divisionName = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

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

	/**
	** title varchar
	**/
	public String getTitle(){ return this.title; }
	public void setTitle(String value){ this.title = value; }

	/**
	** description varchar
	**/
	public String getDescription(){ return this.description; }
	public void setDescription(String value){ this.description = value; }

	/**
	** effectiveDate varchar
	**/
	public String getEffectiveDate(){ return this.effectiveDate; }
	public void setEffectiveDate(String value){ this.effectiveDate = value; }

	/**
	** year varchar
	**/
	public String getYear(){

		String year = "";

		if (effectiveDate != null){
			int pos = effectiveDate.indexOf(" ");
			if(pos < 0)
				year = effectiveDate.substring(0,effectiveDate.length());
			else
				if (pos <= effectiveDate.length())
					year = effectiveDate.substring(pos+1);
				else
					year = "";
		}

		return year;
	}
	public void setYear(String value){ this.effectiveDate = value; }

	/**
	** semester varchar
	**/
	public String getSemester(){

		String semester = "";

		if (effectiveDate != null){
			int pos = effectiveDate.indexOf(" ");
			if (pos < 0)
				semester = effectiveDate.substring(0,effectiveDate.length()-1);
			else
				semester = effectiveDate.substring(0,effectiveDate.indexOf(" "));
		}

		return semester;
	}
	public void setSemester(String value){ this.effectiveDate = value; }

	/**
	** regentsApproval
	**/
	public boolean getRegentsApproval(){ return this.regentsApproval; }
	public void setRegentsApproval(boolean value){ this.regentsApproval = value; }

	/**
	** proposer varchar
	**/
	public String getProposer(){ return this.proposer; }
	public void setProposer(String value){ this.proposer = value; }

	/**
	** progress varchar
	**/
	public String getProgress(){ return this.progress; }
	public void setProgress(String value){ this.progress = value; }

	/**
	** progress varchar
	**/
	public String getSubProgress(){ return this.subprogress; }
	public void setSubProgress(String value){ this.subprogress = value; }

	/**
	** historyid varchar
	**/
	public String getHistoryId(){ return this.historyid; }
	public void setHistoryId(String value){ this.historyid = value; }

	/**
	** type varchar
	**/
	public String getType(){ return this.type; }
	public void setType(String value){ this.type = value; }

	/**
	** route int
	**/
	public int getRoute(){ return this.route; }
	public void setRoute(int value){ this.route = value; }


	public String toString(){
		return "campus: " + getCampus() +
			"auditBy: " + getAuditBy() +
			"auditDate: " + getAuditDate() +
			"title: " + getTitle() +
			"description: " + getDescription() +
			"division name: " + getDivisionName() +
			"division code: " + getDivisionDescr() +
			"degree title: " + getDegreeTitle() +
			"effectiveDate: " + getEffectiveDate() +
			"year: " + getYear() +
			"degree: " + getDegree() +
			"program: " + getProgram() +
			"division: " + getDivision() +
			"progress: " + getProgress() +
			"subprogress: " + getSubProgress() +
			"route: " + getRoute() +
			"regentsApproval: " + getRegentsApproval() +
			"historyid: " + getHistoryId() +
			"type: " + getType() +
			"";
	}
}
