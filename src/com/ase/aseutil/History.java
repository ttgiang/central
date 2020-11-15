/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// History.java
//
package com.ase.aseutil;

public class History implements Comparable {

	/**
	 * Id COUNTER
	 */
	int ID = 0;

	/**
	 * historyID VARCHAR
	 */
	String historyID = null;

	/**
	 * Approvaldate DATETIME
	 */
	String approvalDate = null;

	/**
	 * courseAlpha VARCHAR
	 */
	String courseAlpha = null;

	/**
	 * courseNum VARCHAR
	 */
	String courseNum = null;

	/**
	 * dte DATETIME
	 */
	String dte = null;

	/**
	 * campus VARCHAR
	 */
	String campus = null;

	/**
	 * seq INTEGER
	 */
	int seq = 0;
	int approverSeq = 0;

	/**
	 * approver VARCHAR
	 */
	String approver = null;

	/**
	 * inviter VARCHAR
	 */
	String inviter = null;

	/**
	 * role VARCHAR
	 */
	String role = null;

	/**
	 * approved BIT
	 */
	boolean approved = false;

	/**
	 * comment VARCHAR
	 */
	String comment = null;

	/**
	 * progress VARCHAR
	 */
	String progress = null;

	int voteFor = 0;
	int voteAgainst = 0;
	int voteAbstain = 0;

	public History() {}

	/**
	 *
	 */
	public int getID() {
		return this.ID;
	}

	public void setID(int value) {
		this.ID = value;
	}

	/**
	 *
	 */
	public String getHistoryID() {
		return this.historyID;
	}

	public void setHistoryID(String value) {
		this.historyID = value;
	}

	/**
	 *
	 */
	public String getApprovalDate() {
		return this.approvalDate;
	}

	public void setApprovalDate(String value) {
		this.approvalDate = value;
	}

	/**
	 *
	 */
	public String getCourseAlpha() {
		return this.courseAlpha;
	}

	public void setCourseAlpha(String value) {
		this.courseAlpha = value;
	}

	/**
	 *
	 */
	public String getCourseNum() {
		return this.courseNum;
	}

	public void setCourseNum(String value) {
		this.courseNum = value;
	}

	/**
	 *
	 */
	public String getDte() {
		return this.dte;
	}

	public void setDte(String value) {
		this.dte = value;
	}

	/**
	 *
	 */
	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	/**
	 *
	 */
	public int getSeq() {
		return this.seq;
	}

	public void setSeq(int value) {
		this.seq = value;
	}

	/**
	 *
	 */
	public int getApproverSeq() {
		return this.approverSeq;
	}

	public void setApproverSeq(int value) {
		this.approverSeq = value;
	}

	/**
	 *
	 */
	public String getApprover() {
		return this.approver;
	}

	public void setApprover(String value) {
		this.approver = value;
	}

	/**
	 *
	 */
	public boolean getApproved() {
		return this.approved;
	}

	public void setApproved(boolean value) {
		this.approved = value;
	}

	/**
	 *
	 */
	public String getComments() { return this.comment; }
	public void setComments(String value) { this.comment = value; }

	/**
	 *
	 */
	public int getVoteAgainst() { return this.voteAgainst; }
	public void setVoteAgainst(int value) { this.voteAgainst = value; }

	/**
	 *
	 */
	public int getVoteAbstain() { return this.voteAbstain; }
	public void setVoteAbstain(int value) { this.voteAbstain = value; }

	/**
	 *
	 */
	public int getVoteFor() { return this.voteFor; }
	public void setVoteFor(int value) { this.voteFor = value; }

	/**
	 *
	 */
	public String getInviter() { return this.inviter; }
	public void setInviter(String value) { this.inviter = value; }

	/**
	 *
	 */
	public String getRole() { return this.role; }
	public void setRole(String value) { this.role = value; }

	/**
	 *
	 */
	public String getProgress() { return this.progress; }
	public void setProgress(String value) { this.progress = value; }

	public String toString() {
		return "Id: " + getID() + "<br>\n" + "historyID: " + getHistoryID()
				+ "<br>\n" + "Approvaldate: " + getApprovalDate() + "<br>\n"
				+ "courseAlpha: " + getCourseAlpha() + "<br>\n" + "courseNum: "
				+ getCourseNum() + "<br>\n" + "dte: " + getDte() + "<br>\n"
				+ "campus: " + getCampus() + "<br>\n" + "seq: " + getSeq()
				+ "<br>\n" + "approver: " + getApprover() + "<br>\n"
				+ "approved: " + getApproved() + "<br>\n"
				+ "getVoteFor: " + getVoteFor() + "<br>\n"
				+ "getVoteAgainst: " + getVoteAgainst() + "<br>\n"
				+ "getVoteAbstain: " + getVoteAbstain() + "<br>\n"
				+ "inviter: " + getInviter() + "<br>\n" + ""
				+ "role: " + getRole() + "<br>\n" + ""
				+ "progress: " + getProgress() + "<br>\n" + ""
				+ "approverSeq: " + getApproverSeq() + "<br>\n" + ""
				+ "comments: " + getComments() + "<br>\n" + "";
	}

	public int compareTo(Object object) {
		return 0;
	}

}