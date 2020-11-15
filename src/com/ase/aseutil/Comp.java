/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Comp.java
//
package com.ase.aseutil;

public class Comp {

	int compID;
	private String id;
	private String alpha;
	private String num;
	private String campus;
	private String comp;
	private String comments;
	private String auditBy;
	private String auditDate;
	private String approved;
	private String approvedBy;
	private String approvedDate;

	public Comp() {}

	public String getID() {
		return this.id;
	}

	public void setID(String value) {
		this.id = value;
	}

	public int getCompID() {
		return this.compID;
	}

	public void setCompID(int value) {
		this.compID = value;
	}

	public String getAlpha() {
		return this.alpha;
	}

	public void setAlpha(String value) {
		this.alpha = value;
	}

	public String getNum() {
		return this.num;
	}

	public void setNum(String value) {
		this.num = value;
	}

	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	public String getComp() {
		return this.comp;
	}

	public void setComp(String value) {
		this.comp = value;
	}

	public String getApproved() {
		return this.approved;
	}

	public void setApproved(String value) {
		this.approved = value;
	}

	public String getAuditDate() {
		return this.auditDate;
	}

	public void setAuditDate(String value) {
		try{
			AseUtil aseUtil = new AseUtil();

			if (value != null){
				value = aseUtil.ASE_FormatDateTime(value,Constant.DATE_DATETIME);
			}
		}
		catch(Exception e){}

		this.auditDate = value;
	}

	public String getApprovedDate() {
		return this.approvedDate;
	}

	public void setApprovedDate(String value) {
		try{
			AseUtil aseUtil = new AseUtil();

			if (value != null){
				value = aseUtil.ASE_FormatDateTime(value,Constant.DATE_DATETIME);
			}
		}
		catch(Exception e){}

		this.approvedDate = value;
	}

	public String getAuditBy() {
		return this.auditBy;
	}

	public void setAuditBy(String value) {
		this.auditBy = value;
	}

	public String getApprovedBy() {

		if (this.approvedBy==null)
			return "";
		else
			return this.approvedBy;
	}

	public void setApprovedBy(String value) {
		this.approvedBy = value;
	}

	/**
	*
	**/
	public String getComments(){ return this.comments; }
	public void setComments(String value){ this.comments = value; }

	public String toString(){
		return
			"CompId: " + getCompID() + "\n" +
			"Campus: " + getCampus() + "\n" +
			"CourseAlpha: " + getAlpha() + "\n" +
			"CourseNum: " + getNum() + "\n" +
			"Comp: " + getComp() + "\n" +
			"Comments: " + getComments() + "\n" +
			"ApprovedBy: " + getApprovedBy() + "\n" +
			"ApprovedDate: " + getApprovedDate() + "\n" +
			"AuditDate: " + getAuditDate() + "\n" +
			"AuditBy: " + getAuditBy() + "\n" +
			"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}
