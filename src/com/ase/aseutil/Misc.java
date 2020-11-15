/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * Taskliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Misc.java
//
package com.ase.aseutil;

public class Misc{

	/**
	* Id int identity
	**/
	private int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Historyid varchar
	**/
	private String historyId = null;

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
	* Descr varchar
	**/
	private String descr = null;

	/**
	* val varchar
	**/
	private String val = null;

	/**
	* val varchar
	**/
	private String userId = null;

	/**
	* val varchar
	**/
	private String edited1 = null;
	private String edited2 = null;

	/**
	*
	**/
	public Misc(){
		this.id = 0;
		this.campus = "";
		this.historyId = "";
		this.courseAlpha = "";
		this.courseNum = "";
		this.courseType = "";
		this.descr = "";
		this.val = "";
		this.userId = "";
	}

	public Misc(int id,
						String Campus,
						String Historyid,
						String Coursealpha,
						String Coursenum,
						String Coursetype,
						String Descr,
						String val){
		this.id = id;
		this.campus = Campus;
		this.historyId = Historyid;
		this.courseAlpha = Coursealpha;
		this.courseNum = Coursenum;
		this.courseType = Coursetype;
		this.descr = Descr;
		this.val = val;
	}

	public Misc(int id,
						String Campus,
						String Historyid,
						String Coursealpha,
						String Coursenum,
						String Coursetype,
						String Descr,
						String val,
						String userId){
		this.id = id;
		this.campus = Campus;
		this.historyId = Historyid;
		this.courseAlpha = Coursealpha;
		this.courseNum = Coursenum;
		this.courseType = Coursetype;
		this.descr = Descr;
		this.val = val;
		this.userId = userId;
	}

	/**
	** Id int identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Historyid varchar
	**/
	public String getHistoryId(){ return this.historyId; }
	public void setHistoryId(String value){ this.historyId = value; }

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
	** Descr varchar
	**/
	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	/**
	** Descr varchar
	**/
	public String getUserId(){ return this.userId; }
	public void setUserId(String value){ this.userId = value; }

	/**
	** val varchar
	**/
	public String getVal(){ return this.val; }
	public void setVal(String value){ this.val = value; }

	/**
	** edited varchar
	**/
	public String getEdited1(){ return this.edited1; }
	public void setEdited1(String value){ this.edited1 = value; }

	public String getEdited2(){ return this.edited2; }
	public void setEdited2(String value){ this.edited2 = value; }

	public String toString(){
		return "Id: " + getId() +
		"Campus: " + getCampus() +
		"Historyid: " + getHistoryId() +
		"Coursealpha: " + getCourseAlpha() +
		"Coursenum: " + getCourseNum() +
		"Coursetype: " + getCourseType() +
		"Descr: " + getDescr() +
		"Val: " + getVal() +
		"UserID: " + getUserId() +
		"Edited1: " + getEdited1() +
		"Edited2: " + getEdited2() +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}
