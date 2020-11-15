/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Fnd.java
//
package com.ase.aseutil.fnd;

public class Fnd implements Comparable {

	private String id = null;
	private String fld = null;
	private int seq = 0;
	private int en = 0;
	private int qn = 0;
	private String hallmark = null;
	private String explanatory = null;
	private String question = null;
	private String type = null;
	private String campus = null;
	private String auditby = null;
	private String auditdate = null;

	public Fnd() {
	}

	public Fnd(String id,int seq,int en,int qn,String type,String hallmark,String explanatory,String question,String campus,String auditby, String auditdate) {
		this.id = id;
		this.seq = seq;
		this.en = en;
		this.qn = qn;
		this.hallmark = hallmark;
		this.explanatory = explanatory;
		this.question = question;
		this.type = type;
		this.campus = campus;
		this.auditby = auditby;
		this.auditdate = auditdate;

		this.fld = type+"_"+seq+"_"+en+"_"+qn;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String value) {
		this.id = value;
	}

	public String getFld() {
		return this.fld;
	}

	public void setFld(String value) {
		this.fld = value;
	}

	public int getSeq() {
		return this.seq;
	}

	public void setSeq(int value) {
		this.seq = value;
	}

	public int getEn() {
		return this.en;
	}

	public void setEn(int value) {
		this.en = value;
	}

	public int getQn() {
		return this.qn;
	}

	public void setQn(int value) {
		this.qn = value;
	}

	public String getHallmark() {
		return this.hallmark;
	}

	public void setHallmark(String value) {
		this.hallmark = value;
	}

	public String getExplanatory() {
		return this.explanatory;
	}

	public void setExplanatory(String value) {
		this.explanatory = value;
	}

	public String getQuestion() {
		return this.question;
	}

	public void setQuestion(String value) {
		this.question = value;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String value) {
		this.type = value;
	}

	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	public String getAuditBy() {
		return this.auditby;
	}

	public void setAuditBy(String value) {
		this.auditby = value;
	}

	public String getAuditDate() {
		return this.auditdate;
	}

	public void setAuditDate(String value) {
		this.auditdate = value;
	}

	public String toString() {
		return "Id: " + getId() + "<br>\n"
				+ "Fld: " + getFld() + "<br>\n"
				+ "Type: " + getType() + "<br>\n"
				+ "Seq: " + getSeq() + "<br>\n"
				+ "En: " + getEn() + "<br>\n"
				+ "Qn: " + getQn() + "<br>\n"
				+ "hallmark: " + getHallmark() + "<br>\n"
				+ "explanatory: " + getExplanatory() + "<br>\n"
				+ "question: " + getQuestion() + "<br>\n"
				+ "Campus: " + getCampus() + "<br>\n"
				+ "Auditby: " + getAuditBy() + "<br>\n"
				+ "AuditDate: " + getAuditDate() + "<br>\n" + "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}