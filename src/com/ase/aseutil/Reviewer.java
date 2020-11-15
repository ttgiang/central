/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// reviewer.java
//
package com.ase.aseutil;

public class Reviewer implements Comparable {
	/**
	 * Id COUNTER
	 */
	int ID = 0;

	/**
	 * Historyid VARCHAR
	 */
	String historyID = null;

	/**
	 * Coursealpha VARCHAR
	 */
	String courseAlpha = null;

	/**
	 * Coursenum VARCHAR
	 */
	String courseNum = null;

	/**
	 * item INTEGER
	 */
	int item = 0;

	/**
	 * dte DATETIME
	 */
	String dte = null;

	/**
	 * campus VARCHAR
	 */
	String campus = null;

	/**
	 * reviewer VARCHAR
	 */
	String reviewer = null;

	/**
	 * comments VARCHAR
	 */
	String comments = null;


	/**
	 * progress VARCHAR
	 */
	String progress = null;

	/**
	 * level INTEGER
	 */
	int level = 0;

	/**
	 * duedate
	 */
	String dueDate = null;

	public Reviewer() {
	}

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
	public int getItem() {
		return this.item;
	}

	public void setItem(int value) {
		this.item = value;
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
	public String getReviewer() {
		return this.reviewer;
	}

	public void setReviewer(String value) {
		this.reviewer = value;
	}

	/**
	 *
	 */
	public String getComments() {
		return this.comments;
	}

	public void setComments(String value) {
		this.comments = value;
	}

	/**
	 *
	 */
	public String getProgress() {
		return this.progress;
	}

	public void setProgress(String value) {
		this.progress = value;
	}

	/**
	 *
	 */
	public int getLevel() {
		return this.level;
	}

	public void setLevel(int value) {
		this.level = value;
	}

	/**
	 *
	 */
	public String getDueDate() {
		return this.dueDate;
	}

	public void setDueDate(String value) {
		this.dueDate = value;
	}

	public String toString() {
		return "Id: " + getID() + "<br>\n"
				+ "Historyid: " + getHistoryID() + "<br>\n"
				+ "Coursealpha: " + getCourseAlpha() + "<br>\n"
				+ "Coursenum: " + getCourseNum() + "<br>\n"
				+ "item: " + getItem() + "<br>\n"
				+ "dte: " + getDte() + "<br>\n"
				+ "campus: " + getCampus() + "<br>\n"
				+ "reviewer: " + getReviewer() + "<br>\n"
				+ "comments: " + getComments() + "<br>\n" + ""
				+ "progress: " + getProgress() + "<br>\n" + ""
				+ "level: " + getLevel() + "<br>\n" + ""
				+ "duedate: " + getDueDate() + "<br>\n" + ""
				;
	}

	public int compareTo(Object object) {
		return 0;
	}

}