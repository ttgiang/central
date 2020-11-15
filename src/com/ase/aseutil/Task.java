/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * Taskliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// Task.java
//
package com.ase.aseutil;

public class Task {

	/**
	* Id COUNTER
	**/
	private int id = 0;

	/**
	* Campus VARCHAR
	**/
	private String campus = null;

	/**
	* Submittedfor VARCHAR
	**/
	private String submittedFor = null;

	/**
	* Submittedby VARCHAR
	**/
	private String submittedBy = null;

	/**
	* Coursealpha VARCHAR
	**/
	private String courseAlpha = null;

	/**
	* Coursenum VARCHAR
	**/
	private String courseNum = null;

	/**
	* progress VARCHAR
	**/
	private String progress = null;

	/**
	* Message VARCHAR
	**/
	private String message = null;

	/**
	* inviter VARCHAR
	**/
	private String inviter = null;

	/**
	 * role VARCHAR
	 */
	String role = null;

	/**
	 *
	 */
	public String getRole() { return this.role; }
	public void setRole(String value) { this.role = value; }

	/**
	* Dte DATETIME
	**/
	private String dte = null;

	/**
	* HistoryID VARCHAR
	**/
	private String historyID = null;

	public Task(){}

	/**
	*
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getSubmittedFor(){ return this.submittedFor; }
	public void setSubmittedFor(String value){ this.submittedFor = value; }

	/**
	*
	**/
	public String getSubmittedBy(){ return this.submittedBy; }
	public void setSubmittedBy(String value){ this.submittedBy = value; }

	/**
	*
	**/
	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	/**
	*
	**/
	public String getCourseNum(){ return this.courseNum; }
	public void setCourseNum(String value){ this.courseNum = value; }

	/**
	*
	**/
	public String getMessage(){ return this.message; }
	public void setMessage(String value){ this.message = value; }

	/**
	*
	**/
	public String getDte(){ return this.dte; }
	public void setDte(String value){ this.dte = value; }

	/**
	*
	**/
	public String getHistoryID(){ return this.historyID; }
	public void setHistoryID(String value){ this.historyID = value; }

	/**
	 *
	 */
	public String getInviter() { return this.inviter; }
	public void setInviter(String value) { this.inviter = value; }

	/**
	 *
	 */
	public String getProgress() { return this.progress; }
	public void setProgress(String value) { this.progress = value; }

	public String toString(){
		return "Id: " + getId() + "<br>" +
		"Campus: " + getCampus() + "<br>" +
		"Submittedfor: " + getSubmittedFor() + "<br>" +
		"Submittedby: " + getSubmittedBy() + "<br>" +
		"Coursealpha: " + getCourseAlpha() + "<br>" +
		"Coursenum: " + getCourseNum() + "<br>" +
		"Message: " + getMessage() + "<br>" +
		"Dte: " + getDte() + "<br>" +
		"HistoryID: " + getHistoryID() + "<br>" +
		"Inviter: " + getInviter() + "<br>" +
		"Role: " + getRole() + "<br>" +
		"Progress: " + getProgress() + "<br>" +
		"";
	}

	public int compareTo(Object object) {
		return 0;
	}

}
