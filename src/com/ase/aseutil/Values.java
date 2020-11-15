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

public class Values {

	/**
	* Id numeric identity
	**/
	int id = 0;

	/**
	* seq numeric identity
	**/
	int seq = 0;

	/**
	* valueid numeric identity
	**/
	int valueID = 0;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Topic varchar
	**/
	private String topic = null;

	/**
	* Subtopic varchar
	**/
	private String subTopic = null;

	/**
	* Shortdescr varchar
	**/
	private String shortDescr = null;

	/**
	* Longdescr text
	**/
	private String longDescr = null;

	/**
	* src text
	**/
	private String src = null;

	/**
	* Auditby varchar
	**/
	private String auditBy = null;

	/**
	* Auditdate smalldatetime
	**/
	private String auditDate = null;

	public Values(){}

	public Values(int id,String campus,String topic,String subTopic,String shortDescr,String longDescr,String auditBy){
		this.id = id;
		this.campus = campus;
		this.topic = topic;
		this.subTopic = subTopic;
		this.shortDescr = shortDescr;
		this.longDescr = longDescr;
		this.auditBy = auditBy;
		this.auditDate = AseUtil.getCurrentDateTimeString();
		this.valueID = 0;
		this.seq = 0;
		this.src = "";
	}

	public Values(int id,int seq,String campus,String topic,String subTopic,String shortDescr,String longDescr,String auditBy,String auditDate){
		this.id = id;
		this.seq = seq;
		this.campus = campus;
		this.topic = topic;
		this.subTopic = subTopic;
		this.shortDescr = shortDescr;
		this.longDescr = longDescr;
		this.auditBy = auditBy;
		this.auditDate = auditDate;
		this.valueID = 0;
		this.src = "";
	}

	public Values(int id,String campus,String topic,String subTopic,String shortDescr,String longDescr,String auditBy,int seq){
		this.id = id;
		this.campus = campus;
		this.topic = topic;
		this.subTopic = subTopic;
		this.shortDescr = shortDescr;
		this.longDescr = longDescr;
		this.auditBy = auditBy;
		this.auditDate = AseUtil.getCurrentDateTimeString();
		this.valueID = 0;
		this.seq = seq;
		this.src = "";
	}

	public Values(int id,String campus,String topic,String subTopic,String shortDescr,String longDescr,String auditBy,int seq,String src){
		this.id = id;
		this.campus = campus;
		this.topic = topic;
		this.subTopic = subTopic;
		this.shortDescr = shortDescr;
		this.longDescr = longDescr;
		this.auditBy = auditBy;
		this.auditDate = AseUtil.getCurrentDateTimeString();
		this.valueID = 0;
		this.seq = seq;
		this.src = src;
	}

	public Values(int id,String campus,String topic,String subTopic,String shortDescr,String longDescr,String auditBy,String src){
		this.id = id;
		this.campus = campus;
		this.topic = topic;
		this.subTopic = subTopic;
		this.shortDescr = shortDescr;
		this.longDescr = longDescr;
		this.auditBy = auditBy;
		this.auditDate = AseUtil.getCurrentDateTimeString();
		this.valueID = 0;
		this.seq = 0;
		this.src = src;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** valueID numeric identity
	**/
	public int getValueID(){ return this.valueID; }
	public void setValueID(int value){ this.valueID= value; }

	/**
	** seq numeric identity
	**/
	public int getSeq(){ return this.seq; }
	public void setSeq(int value){ this.seq= value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Topic varchar
	**/
	public String getTopic(){ return this.topic; }
	public void setTopic(String value){ this.topic = value; }

	/**
	** Subtopic varchar
	**/
	public String getSubTopic(){ return this.subTopic; }
	public void setSubTopic(String value){ this.subTopic = value; }

	/**
	** Shortdescr varchar
	**/
	public String getShortDescr(){ return this.shortDescr; }
	public void setShortDescr(String value){ this.shortDescr = value; }

	/**
	** Longdescr text
	**/
	public String getLongDescr(){ return this.longDescr; }
	public void setLongDescr(String value){ this.longDescr = value; }

	/**
	** Auditby varchar
	**/
	public String getAuditBy(){ return this.auditBy; }
	public void setAuditBy(String value){ this.auditBy = value; }

	/**
	** src varchar
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

	/**
	** Auditdate smalldatetime
	**/
	public String getAuditDate(){ return this.auditDate; }
	public void setAuditDate(String value){ this.auditDate = value; }


	public String toString(){
		return
		"Id: " + getId() +
		"valueID: " + getValueID() +
		"Campus: " + getCampus() +
		"Topic: " + getTopic() +
		"Subtopic: " + getSubTopic() +
		"Seq: " + getSeq() +
		"Shortdescr: " + getShortDescr() +
		"Longdescr: " + getLongDescr() +
		"Auditby: " + getAuditBy() +
		"Auditdate: " + getAuditDate() +
		"SRC: " + getSrc() +
		"";
	}
}
