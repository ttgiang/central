/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Attach.java
//
package com.ase.aseutil;

public class Attach {

	/**
	* Id numeric identity
	**/
	private int id;

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* category varchar
	**/
	private String category = null;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Coursealpha varchar
	**/
	private String courseAlpha = null;

	/**
	* Coursenum varchar
	**/
	private String courseNum = null;

	/**
	* Coursetype varchar
	**/
	private String courseType = null;

	/**
	* filedescr varchar
	**/
	private String fileDescr = null;

	/**
	* Filename varchar
	**/
	private String fileName = null;

	/**
	* Filesize float
	**/
	double fileSize;

	/**
	* Filedate datetime
	**/
	private String fileDate = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	/**
	* Auditdate datetime
	**/
	private String auditDate = null;

	/**
	* fullName varchar
	**/
	private String fullName = null;

	/**
	* version int
	**/
	private int version = 0;

	public Attach(){}

	public Attach (int id,
						String historyid,
						String campus,
						String courseAlpha,
						String courseNum,
						String courseType,
						String fileDescr,
						String fileName,
						double fileSize,
						String fileDate,
						String auditBy,
						String auditDate,
						String category){
		this.id = id;
		this.historyid = historyid;
		this.campus = campus;
		this.courseAlpha = courseAlpha;
		this.courseNum = courseNum;
		this.courseType = courseType;
		this.fileDescr = fileDescr;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.fileDate = fileDate;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.category = category;
	}

	public Attach (int id,
						String historyid,
						String campus,
						String courseAlpha,
						String courseNum,
						String courseType,
						String fileDescr,
						String fileName,
						double fileSize,
						String fileDate,
						String auditBy,
						String auditDate,
						String category,
						int version,
						String fullName){
		this.id = id;
		this.historyid = historyid;
		this.campus = campus;
		this.courseAlpha = courseAlpha;
		this.courseNum = courseNum;
		this.courseType = courseType;
		this.fileDescr = fileDescr;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.fileDate = fileDate;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.category = category;
		this.version = version;
		this.fullName = fullName;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Historyid varchar
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/**
	** category varchar
	**/
	public String getCategory(){ return this.category; }
	public void setCategory(String value){ this.category = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Coursealpha varchar
	**/
	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	/**
	** Coursenum varchar
	**/
	public String getCourseNum(){ return this.courseNum; }
	public void setCourseNum(String value){ this.courseNum = value; }

	/**
	** Coursetype varchar
	**/
	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	/**
	** Filedescr varchar
	**/
	public String getFileDescr(){ return this.fileDescr; }
	public void setFileDescr(String value){ this.fileDescr = value; }

	/**
	** Filename varchar
	**/
	public String getFileName(){ return this.fileName; }
	public void setFileName(String value){ this.fileName = value; }

	/**
	** Filesize float
	**/
	public double getFileSize(){ return this.fileSize; }
	public void setFileSize(Double value){ this.fileSize = value; }

	/**
	** Filedate datetime
	**/
	public String getFileDate(){ return this.fileDate; }
	public void setFileDate(String value){ this.fileDate = value; }

	/**
	** Auditby varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** Auditdate datetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }

	/**
	** fullName varchar
	**/
	public String getFullName(){ return this.fullName; }
	public void setFullName(String value){ this.fullName = value; }

	/**
	** version	int
	**/
	public int getVersion(){ return this.version; }
	public void setVersion(int value){ this.version = value; }

	public String toString(){
		return "Id: " + getId() +
		"Historyid: " + getHistoryid() +
		"Campus: " + getCampus() +
		"Category: " + getCategory() +
		"Coursealpha: " + getCourseAlpha() +
		"Coursenum: " + getCourseNum() +
		"Coursetype: " + getCourseType() +
		"Filedescr: " + getFileDescr() +
		"Filename: " + getFileName() +
		"Fullname: " + getFullName() +
		"Version: " + getVersion() +
		"Filesize: " + getFileSize() +
		"Filedate: " + getFileDate() +
		"Auditby: " + getAuditBy() +
		"Auditdate: " + getAuditDate() +
		"";
	}
}
