/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  AseJobParms.java
//
package com.ase.aseutil.jobs;

public class AseJobParms {

	private String jobName = null;
	private String campus = null;
	private String kix = null;
	private String alpha = null;
	private String num = null;
	private String type = null;
	private String user = null;
	private int recordCount = 0;

	private String parm1 = null;
	private String parm2 = null;
	private String parm3 = null;
	private String parm4 = null;

	public AseJobParms(){}

	public AseJobParms(String campus,String user,String kix,String alpha,String num,String type,String parm1){

		this.campus = campus;
		this.user = user;
		this.kix = kix;
		this.alpha = alpha;
		this.num = num;
		this.type = type;
		this.parm1 = parm1;

	}

	public AseJobParms(String jobName,String campus,String user,String kix,String alpha,String num,String type,String parm1){

		this.jobName = jobName;
		this.campus = campus;
		this.user = user;
		this.kix = kix;
		this.alpha = alpha;
		this.num = num;
		this.type = type;
		this.parm1 = parm1;

	}

	/**
	** campus
	**/
	public String getJobName(){ return this.jobName; }
	public void setJobName(String value){ this.jobName = value; }

	/**
	** campus
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** kix
	**/
	public String getKix(){ return this.kix; }
	public void setKix(String value){ this.kix = value; }

	/**
	** alpha
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	** num
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

	/**
	** type
	**/
	public String getType(){ return this.type; }
	public void setType(String value){ this.type = value; }

	/**
	** user
	**/
	public String getUser(){ return this.user; }
	public void setUser(String value){ this.user = value; }

	/**
	** record count
	**/
	public int getRecordCount(){ return this.recordCount; }
	public void setRecordCount(int value){ this.recordCount = value; }

	/**
	** parm1
	**/
	public String getParm1(){ return this.parm1; }
	public void setParm1(String value){ this.parm1 = value; }

	/**
	** parm2
	**/
	public String getParm2(){ return this.parm2; }
	public void setParm2(String value){ this.parm2 = value; }

	/**
	** parm3
	**/
	public String getParm3(){ return this.parm3; }
	public void setParm3(String value){ this.parm3 = value; }

	/**
	** parm4
	**/
	public String getParm4(){ return this.parm4; }
	public void setParm4(String value){ this.parm4 = value; }

	public String toString(){

		return "Jobname: " + getJobName() +  "<br>" +
			"Campus: " + getCampus() +  "<br>" +
			"Kix: " + getKix() +  "<br>" +
			"Alpha: " + getAlpha() +  "<br>" +
			"Num: " + getNum() +  "<br>" +
			"Type: " + getType() +  "<br>" +
			"User: " + getUser() +  "<br>" +
			"Record Count: " + getRecordCount() +  "<br>" +
			"Parm1: " + getParm1() +  "<br>" +
			"Parm2: " + getParm2() +  "<br>" +
			"Parm3: " + getParm3() +  "<br>" +
			"Parm4: " + getParm4() +  "<br>" +
			"";
	}

} // class
