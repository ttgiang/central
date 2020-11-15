/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Syllabus.java
//
package com.ase.aseutil;

public class Syllabus implements Comparable {

	private String syllabusID = null;
	private String alpha = null;
	private String num = null;
	private String userid = null;
	private String semester = null;
	private String year = null;
	private String auditDate = null;
	private String textBooks = null;
	private String objectives = null;
	private String grading = null;
	private String comments = null;
	private String historyID = null;
	private String prereq = null;
	private String coreq = null;
	private String recprep = null;
	private String attach = null;

	public Syllabus() {}

	public Syllabus(String id,String alpha,String num,String year,String semester,String auditDate) {
		this.syllabusID = id;
		this.alpha = alpha;
		this.num = num;
		this.year = year;
		this.semester = semester;
		this.auditDate = auditDate;
	}

	public Syllabus(String syllabusID,
							String alpha,
							String num,
							String semester,
							String year,
							String userid,
							String textBooks,
							String objectives,
							String grading,
							String comments,
							String auditDate,
							String history,
							String attach) {

		this.syllabusID = syllabusID;
		this.alpha = alpha;
		this.num = num;
		this.semester = semester;
		this.year = year;
		this.textBooks = textBooks;
		this.objectives = objectives;
		this.grading = grading;
		this.comments = comments;
		this.userid = userid;
		this.auditDate = auditDate;
		this.historyID = history;
		this.attach = attach;

		this.coreq = "";
		this.prereq = "";
		this.recprep = "";
	}

	public String getSyllabusID() {
		return this.syllabusID;
	}

	public void setSyllabusID(String value) {
		this.syllabusID = value;
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

	public String getSemester() {
		return this.semester;
	}

	public void setSemester(String value) {
		this.semester = value;
	}

	public String getYear() {
		return this.year;
	}

	public void setYear(String value) {
		this.year = value;
	}

	public String getUserID() {
		return this.userid;
	}

	public void setUserID(String value) {
		this.userid = value;
	}

	public String getTextBooks() {
		return this.textBooks;
	}

	public void setTextBooks(String value) {
		this.textBooks = value;
	}

	public String getObjectives() {
		return this.objectives;
	}

	public void setObjectives(String value) {
		this.objectives = value;
	}

	public String getComments() {
		return this.comments;
	}

	public void setComments(String value) {
		this.comments = value;
	}

	public String getGrading() {
		return this.grading;
	}

	public void setGrading(String value) {
		this.grading = value;
	}


	public String getCoreq() { return this.coreq; }
	public void setCoreq(String value) { this.coreq = value; }

	public String getPrereq() { return this.prereq; }
	public void setPrereq(String value) { this.prereq = value; }

	public String getRecprep() { return this.recprep; }
	public void setRecprep(String value) { this.recprep = value; }

	public String getAuditDate() {
		return this.auditDate;
	}

	public void setAuditDate(String value) {
		this.auditDate = value;
	}

	public String getHistoryID() {
		return this.historyID;
	}

	public void setHistoryID(String value) {
		this.historyID = value;
	}

	public String getAttach() {
		return this.attach;
	}

	public void setAttach(String value) {
		this.attach = value;
	}

	public int compareTo(Object object) {
		return 0;
	}

	public String toString() {

		return "SyllabusID: " + getSyllabusID() + "<br>\n" +
			"Alpha: " + getAlpha() + "<br>\n" +
			"Num: " + getNum() + "<br>\n" +
			"Semester: " + getSemester() + "<br>\n" +
			"Year: " + getYear() + "<br>\n" +
			"User: " + getUserID() + "<br>\n" +
			"Textbooks: " + getTextBooks() + "<br>\n" +
			"Objectives: " + getObjectives() + "<br>\n" +
			"Comments: " + getComments() + "<br>\n" +
			"Attach: " + getAttach() + "<br>\n" +
			"HistoryID: " + getHistoryID() + "<br>\n" +
			"Co-Req: " + getCoreq() + "<br>\n" +
			"Pre-Req: " + getPrereq() + "<br>\n" +
			"Recommended Preparation: " + getRecprep() + "<br>\n" +
			"Grading: " + getGrading();
	}

}