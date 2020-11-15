/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// JobName.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.AseUtil;

public class JobName {

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Jobname varchar
	**/
	private String jobName = null;

	/**
	* Jobtitle varchar
	**/
	private String jobTitle = null;

	/**
	* Jobdescr varchar
	**/
	private String jobDescr = null;

	/**
	* Frequency char
	**/
	private String frequency = null;

	/**
	* Parm1 varchar
	**/
	private String parm1 = null;

	/**
	* Parm2 varchar
	**/
	private String parm2 = null;

	/**
	* Starttime smalldatetime
	**/
	private String startTime = null;

	/**
	* Endtime smalldatetime
	**/
	private String endTime = null;

	/**
	* Counter int
	**/
	private int counter = 0;

	/**
	* total int
	**/
	private int total = 0;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	// variables for quartz

	private long jobruntime = 0;

	private String firetime = null;

	private String result = null;

	private boolean SS = false;
	private boolean MM = false;
	private boolean HH = false;
	private boolean DD = false;
	private boolean MN = false;
	private boolean DW = false;
	private boolean YY = false;
	private boolean CMPS = false;
	private boolean KIX = false;
	private boolean ALPHA = false;
	private boolean NUM = false;
	private boolean TYPE = false;
	private boolean TASK = false;
	private boolean IDX = false;

	/*
	**	Constructor
	*/
	public JobName(){
		this.startTime = AseUtil.getCurrentDateTimeString();
	}

	public JobName (JobName job){
		this.id = job.getId();
		this.jobName = job.getJobName();
		this.jobTitle = job.getJobTitle();
		this.jobDescr = job.getJobDescr();
		this.frequency = job.getFrequency();
		this.parm1 = job.getParm1();
		this.parm2 = job.getParm2();
		this.startTime = job.getStartTime();
		this.endTime = job.getEndTime();
		this.counter = job.getCounter();
		this.total = job.getTotal();
		this.auditDate = job.getAuditDate();
		this.auditBy = job.getAuditBy();
		this.jobruntime = job.getJobRunTime();
		this.firetime = job.getFireTime();
		this.result = job.getResult();
	}

	public JobName (int id,
						String jobname,
						String jobtitle,
						String jobdescr,
						String frequency,
						String parm1,
						String parm2,
						String starttime,
						String endtime,
						int counter,
						String auditdate,
						String auditby){
		this.id = id;
		this.jobName = jobname;
		this.jobTitle = jobtitle;
		this.jobDescr = jobdescr;
		this.frequency = frequency;
		this.parm1 = parm1;
		this.parm2 = parm2;
		this.startTime = starttime;
		this.endTime = endtime;
		this.counter = counter;
		this.total = total;
		this.auditDate = auditdate;
		this.auditBy = auditby;
	}

	/**
	** Id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Jobname varchar
	**/
	public String getJobName(){ return this.jobName; }
	public void setJobName(String value){ this.jobName = value; }

	/**
	** Jobtitle varchar
	**/
	public String getJobTitle(){ return this.jobTitle; }
	public void setJobTitle(String value){ this.jobTitle = value; }

	/**
	** Jobdescr varchar
	**/
	public String getJobDescr(){ return this.jobDescr; }
	public void setJobDescr(String value){ this.jobDescr = value; }

	/**
	** Frequency char
	**/
	public String getFrequency(){ return this.frequency; }
	public void setFrequency(String value){ this.frequency = value; }

	/**
	** Parm1 varchar
	**/
	public String getParm1(){ return this.parm1; }
	public void setParm1(String value){ this.parm1 = value; }

	/**
	** Parm2 varbinary
	**/
	public String getParm2(){ return this.parm2; }
	public void setParm2(String value){ this.parm2 = value; }

	/**
	** Starttime smalldatetime
	**/
	public String getStartTime(){ return this.startTime; }
	public void setStartTime(String value){ this.startTime = value; }

	/**
	** Endtime smalldatetime
	**/
	public String getEndTime(){ return this.endTime; }
	public void setEndTime(String value){ this.endTime = value; }

	/**
	** Counter int
	**/
	public int getCounter(){ return this.counter; }
	public void setCounter(int value){ this.counter = value; }

	/**
	** total int
	**/
	public int getTotal(){ return this.total; }
	public void setTotal(int value){ this.total = value; }

	/**
	** Auditdate smalldatetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	** Auditby varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** jobruntime long
	**/
	public long getJobRunTime(){ return this.jobruntime; }
	public void setJobRunTime(long value){ this.jobruntime = value; }

	/**
	** firetime varchar
	**/
	public String getFireTime(){ return this.firetime; }
	public void setFireTime(String value){ this.firetime = value; }

	/**
	** result varchar
	**/
	public String getResult(){ return this.result; }
	public void setResult(String value){ this.result = value; }

	/**
	** SS
	**/
	public boolean getSS(){ return this.SS; }
	public void setSS(boolean value){ this.SS = value; }

	/**
	** MM
	**/
	public boolean getMM(){ return this.MM; }
	public void setMM(boolean value){ this.MM = value; }

	/**
	** HH
	**/
	public boolean getHH(){ return this.HH; }
	public void setHH(boolean value){ this.HH = value; }

	/**
	** DD
	**/
	public boolean getDD(){ return this.DD; }
	public void setDD(boolean value){ this.DD = value; }

	/**
	** MN
	**/
	public boolean getMN(){ return this.MN; }
	public void setMN(boolean value){ this.MN = value; }

	/**
	** DW
	**/
	public boolean getDW(){ return this.DW; }
	public void setDW(boolean value){ this.DW = value; }

	/**
	** YY
	**/
	public boolean getYY(){ return this.YY; }
	public void setYY(boolean value){ this.YY = value; }

	/**
	** CMPS
	**/
	public boolean getCMPS(){ return this.CMPS; }
	public void setCMPS(boolean value){ this.CMPS = value; }

	/**
	** KIX
	**/
	public boolean getKIX(){ return this.KIX; }
	public void setKIX(boolean value){ this.KIX = value; }

	/**
	** ALPHA
	**/
	public boolean getALPHA(){ return this.ALPHA; }
	public void setALPHA(boolean value){ this.ALPHA = value; }

	/**
	** NUM
	**/
	public boolean getNUM(){ return this.NUM; }
	public void setNUM(boolean value){ this.NUM = value; }

	/**
	** TYPE
	**/
	public boolean getTYPE(){ return this.TYPE; }
	public void setTYPE(boolean value){ this.TYPE = value; }

	/**
	** TASK
	**/
	public boolean getTASK(){ return this.TASK; }
	public void setTASK(boolean value){ this.TASK = value; }

	/**
	** IDX
	**/
	public boolean getIDX(){ return this.IDX; }
	public void setIDX(boolean value){ this.IDX = value; }

	public String toString(){
		return "Id: " + getId() +
		"Jobname: " + getJobName() +
		"Jobtitle: " + getJobTitle() +
		"Jobdescr: " + getJobDescr() +
		"Frequency: " + getFrequency() +
		"Parm1: " + getParm1() +
		"Parm2: " + getParm2() +
		"Starttime: " + getStartTime() +
		"Endtime: " + getEndTime() +
		"Counter: " + getCounter() +
		"Total: " + getTotal() +
		"Auditdate: " + getAuditDate() +
		"Auditby: " + getAuditBy() +
		"FireTime: " + getFireTime() +
		"Result: " + getResult() +
		"SS: " + getSS() +
		"MM: " + getMM() +
		"HH: " + getHH() +
		"DD: " + getDD() +
		"MN: " + getMN() +
		"DW: " + getDW() +
		"YY: " + getYY() +
		"CMPS: " + getCMPS() +
		"KIX: " + getKIX() +
		"ALPHA: " + getALPHA() +
		"NUM: " + getNUM() +
		"TYPE: " + getTYPE() +
		"TASK: " + getTASK() +
		"IDX: " + getIDX() +
		"";
	}

	public String toStringLog(){
		return "Id: " + getId() + "\n" +
		"Jobname: " + getJobName() + "\n" +
		"Jobtitle: " + getJobTitle() + "\n" +
		"Jobdescr: " + getJobDescr() + "\n" +
		"Frequency: " + getFrequency() + "\n" +
		"Parm1: " + getParm1() + "\n" +
		"Parm2: " + getParm2() + "\n" +
		"Starttime: " + getStartTime() + "\n" +
		"Endtime: " + getEndTime() + "\n" +
		"Counter: " + getCounter() + "\n" +
		"Total: " + getTotal() + "\n" +
		"Auditdate: " + getAuditDate() + "\n" +
		"Auditby: " + getAuditBy() + "\n" +
		"FireTime: " + getFireTime() + "\n" +
		"Result: " + getResult() + "\n" +
		"";
	}
}
