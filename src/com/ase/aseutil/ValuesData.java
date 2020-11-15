/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Values.java
//
package com.ase.aseutil;

public class ValuesData {


	/**
	* id numeric identity
	**/
	int id = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	/**
	* Coursealpha varchar
	**/
	private String courseAlpha = null;

	/**
	* Coursenum varchar
	**/
	private String courseNum = null;

	/**
	* Coursetype char
	**/
	private String courseType = null;

	/**
	* Courseitem varchar
	**/
	private String courseItem = null;

	/**
	* Itemid numeric
	**/
	private int itemId = 0;

	/**
	* Valueids varchar
	**/
	private String valueIds = null;

	/**
	* X
	**/
	private String X = null;
	private int XID = 0;
	private String Y = null;
	private int YID = 0;

	public ValuesData(){
		this.id = 0;
		this.campus = "";
		this.historyid = "";
		this.courseAlpha = "";
		this.courseNum = "";
		this.courseType = "";
		this.courseItem = "";
		this.itemId = 0;
		this.valueIds = "";
		this.X = "";
		this.XID = 0;
		this.Y = "";
		this.YID = 0;
	}

	public ValuesData(int id,
							String Campus,
							String historyid,
							String courseAlpha,
							String courseNum,
							String courseType,
							String courseItem,
							int itemId,
							String valueIds){
		this.id = 0;
		this.campus = "";
		this.historyid = "";
		this.courseAlpha = "";
		this.courseNum = "";
		this.courseType = "";
		this.courseItem = "";
		this.itemId = 0;
		this.valueIds = "";
		this.X = "";
		this.XID = 0;
		this.Y = "";
		this.YID = 0;
	}

	/**
	** id numeric identity
	**/

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Historyid varchar
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

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
	** Coursetype char
	**/
	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	/**
	** Courseitem varchar
	**/
	public String getCourseItem(){ return this.courseItem; }
	public void setCourseItem(String value){ this.courseItem = value; }

	/**
	** Itemid numeric
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Itemid numeric
	**/
	public int getItemId(){ return this.itemId; }
	public void setItemId(int value){ this.itemId = value; }

	/**
	** Valueids varchar
	**/
	public String getValueIds(){ return this.valueIds; }
	public void setValueIds(String value){ this.valueIds = value; }

	/**
	** X varchar
	**/
	public String getX(){ return this.X; }
	public void setX(String value){ this.X = value; }

	/**
	** X varchar
	**/
	public int getXID(){ return this.XID; }
	public void setXID(int value){ this.XID = value; }

	/**
	** X varchar
	**/
	public String getY(){ return this.Y; }
	public void setY(String value){ this.Y = value; }

	/**
	** X varchar
	**/
	public int getYID(){ return this.YID; }
	public void setYID(int value){ this.YID = value; }

	public String toString(){
		return "id: " + getId() +
		"Campus: " + getCampus() +
		"Historyid: " + getHistoryid() +
		"Coursealpha: " + getCourseAlpha() +
		"Coursenum: " + getCourseNum() +
		"Coursetype: " + getCourseType() +
		"Courseitem: " + getCourseItem() +
		"Itemid: " + getItemId() +
		"Valueids: " + getValueIds() +
		"X: " + getX() +
		"XID: " + getXID() +
		"Y: " + getY() +
		"YID: " + getYID() +
		"";
	}
}
