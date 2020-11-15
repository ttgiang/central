/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Jobs.java
//
package com.ase.aseutil;

public class Jobs {

	/**
	* Id numeric identity
	**/
	int id = 0;

	/**
	* job varchar
	**/
	private String job = null;

	/**
	* historyID varchar
	**/
	private String historyID = null;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* alpha varchar
	**/
	private String alpha = null;

	/**
	* num varchar
	**/
	private String num = null;

	/**
	* auditBy varchar
	**/
	private String auditBy = null;

	/**
	* auditDate smalldatetime
	**/
	private String auditDate = null;

	/**
	* S1 varchar
	**/
	private String S1 = null;

	/**
	* S2 varchar
	**/
	private String S2 = null;

	/**
	* S3 varchar
	**/
	private String S3 = null;

	/**
	* N1 numeric
	**/
	private int N1 = 0;

	/**
	* N2 numeric
	**/
	private int N2 = 0;

	/**
	* N3 numeric
	**/
	private int N3 = 0;

	/**
	* T1 Jobs
	**/
	private String T1 = null;

	/**
	* T2 Jobs
	**/
	private String T2 = null;

	/**
	* T3 Jobs
	**/
	private String T3 = null;

	public Jobs(){
		this.id = 0;
		this.job = "";
		this.historyID = "";
		this.campus = "";
		this.alpha = "";
		this.num = "";
		this.auditBy = "";
		this.auditDate = "";
		this.S1 = "";
		this.S2 = "";
		this.S3 = "";
		this.N1 = 0;
		this.N2 = 0;
		this.N3 = 0;
		this.T1 = "";
		this.T2 = "";
		this.T3 = "";
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** job varchar
	**/
	public String getJob(){ return this.job; }
	public void setJob(String value){ this.job = value; }

	/**
	** historyID varchar
	**/
	public String getHistoryID(){ return this.historyID; }
	public void setHistoryID(String value){ this.historyID = value; }

	/**
	** campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** alpha varchar
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	** num varchar
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

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
	** S1 varchar
	**/
	public String getS1(){ return this.S1; }
	public void setS1(String value){ this.S1 = value; }

	/**
	** S2 varchar
	**/
	public String getS2(){ return this.S2; }
	public void setS2(String value){ this.S2 = value; }

	/**
	** S3 varchar
	**/
	public String getS3(){ return this.S3; }
	public void setS3(String value){ this.S3 = value; }

	/**
	** N1 numeric
	**/
	public int getN1(){ return this.N1; }
	public void setN1(int value){ this.N1 = value; }

	/**
	** N2 numeric
	**/
	public int getN2(){ return this.N2; }
	public void setN2(int value){ this.N2 = value; }

	/**
	** N3 numeric
	**/
	public int getN3(){ return this.N3; }
	public void setN3(int value){ this.N3 = value; }

	/**
	** T1 Jobs
	**/
	public String getT1(){ return this.T1; }
	public void setT1(String value){ this.T1 = value; }

	/**
	** T2 Jobs
	**/
	public String getT2(){ return this.T2; }
	public void setT2(String value){ this.T2 = value; }

	/**
	** T3 Jobs
	**/
	public String getT3(){ return this.T3; }
	public void setT3(String value){ this.T3 = value; }


	public String toString(){
		return "Id: " + getId() +
		"job: " + getJob() +
		"historyID: " + getHistoryID() +
		"campus: " + getCampus() +
		"alpha: " + getAlpha() +
		"num: " + getNum() +
		"auditBy: " + getAuditBy() +
		"auditDate: " + getAuditDate() +
		"S1: " + getS1() +
		"S2: " + getS2() +
		"S3: " + getS3() +
		"N1: " + getN1() +
		"N2: " + getN2() +
		"N3: " + getN3() +
		"T1: " + getT1() +
		"T2: " + getT2() +
		"T3: " + getT3() +
		"";
	}

}
