/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Banner.java
//
package com.ase.aseutil;

public class Banner implements Comparable {
	/**
	 * Id COUNTER
	 */
	int Id = 0;

	/**
	 * INSTITUTION VARCHAR
	 */
	String INSTITUTION = null;

	/**
	 * CRSE_ALPHA VARCHAR
	 */
	String CRSE_ALPHA = null;

	/**
	 * CRSE_NUMBER VARCHAR
	 */
	String CRSE_NUMBER = null;

	/**
	 * EFFECTIVE_TERM VARCHAR
	 */
	String EFFECTIVE_TERM = null;

	/**
	 * CRSE_TITLE VARCHAR
	 */
	String CRSE_TITLE = null;

	/**
	 * CRSE_LONG_TITLE VARCHAR
	 */
	String CRSE_LONG_TITLE = null;

	/**
	 * CRSE_DIVISION VARCHAR
	 */
	String CRSE_DIVISION = null;

	/**
	 * CRSE_DEPT VARCHAR
	 */
	String CRSE_DEPT = null;

	/**
	 * CRSE_COLLEGE VARCHAR
	 */
	String CRSE_COLLEGE = null;

	/**
	 * MAX_RPT_UNITS VARCHAR
	 */
	String MAX_RPT_UNITS = null;

	/**
	 * REPEAT_LIMIT VARCHAR
	 */
	String REPEAT_LIMIT = null;

	/**
	 * CREDIT_HIGH VARCHAR
	 */
	String CREDIT_HIGH = null;

	/**
	 * CREDIT_LOW VARCHAR
	 */
	String CREDIT_LOW = null;

	/**
	 * CREDIT_IND VARCHAR
	 */
	String CREDIT_IND = null;

	/**
	 * CONT_HIGH VARCHAR
	 */
	String CONT_HIGH = null;

	/**
	 * CONT_LOW VARCHAR
	 */
	String CONT_LOW = null;

	/**
	 * CONT_IND VARCHAR
	 */
	String CONT_IND = null;

	/**
	 * LAB_HIGH VARCHAR
	 */
	String LAB_HIGH = null;

	/**
	 * LAB_LOW VARCHAR
	 */
	String LAB_LOW = null;

	/**
	 * LAB_IND VARCHAR
	 */
	String LAB_IND = null;

	/**
	 * LECT_HIGH VARCHAR
	 */
	String LECT_HIGH = null;

	/**
	 * LECT_LOW VARCHAR
	 */
	String LECT_LOW = null;

	/**
	 * LECT_IND VARCHAR
	 */
	String LECT_IND = null;

	/**
	 * OTH_HIGH VARCHAR
	 */
	String OTH_HIGH = null;

	/**
	 * OTH_LOW VARCHAR
	 */
	String OTH_LOW = null;

	/**
	 * OTH_IND VARCHAR
	 */
	String OTH_IND = null;

	public Banner(String a,String n,String t) {
		setCRSE_ALPHA(a);
		setCRSE_NUMBER(n);
		setCRSE_TITLE(t);
	}

	public Banner(String a,String n,String t,String ef,String dv,String dp,String rpt,String limit) {
		setCRSE_ALPHA(a);
		setCRSE_NUMBER(n);
		setCRSE_TITLE(t);
		setEFFECTIVE_TERM(ef);
		setCRSE_DIVISION(dv);
		setCRSE_DEPT(dp);
		setMAX_RPT_UNITS(rpt);
		setREPEAT_LIMIT(limit);
	}

	public Banner() {
		setId(0);
		setINSTITUTION("");
		setCRSE_ALPHA("");
		setCRSE_NUMBER("");
		setEFFECTIVE_TERM("");
		setCRSE_TITLE("");
		setCRSE_LONG_TITLE("");
		setCRSE_DIVISION("");
		setCRSE_DEPT("");
		setCRSE_COLLEGE("");
		setMAX_RPT_UNITS("");
		setREPEAT_LIMIT("");
		setCREDIT_HIGH("");
		setCREDIT_LOW("");
		setCREDIT_IND("");
		setCONT_HIGH("");
		setCONT_LOW("");
		setCONT_IND("");
		setLAB_HIGH("");
		setLAB_LOW("");
		setLAB_IND("");
		setLECT_HIGH("");
		setLECT_LOW("");
		setLECT_IND("");
		setOTH_HIGH("");
		setOTH_LOW("");
		setOTH_IND("");
	}

	/**
	 *
	 */
	public int getId() {
		return this.Id;
	}

	public void setId(int value) {
		this.Id = value;
	}

	/**
	 *
	 */
	public String getINSTITUTION() {
		return this.INSTITUTION;
	}

	public void setINSTITUTION(String value) {
		this.INSTITUTION = value;
	}

	/**
	 *
	 */
	public String getCRSE_ALPHA() {
		return this.CRSE_ALPHA;
	}

	public void setCRSE_ALPHA(String value) {
		this.CRSE_ALPHA = value;
	}

	/**
	 *
	 */
	public String getCRSE_NUMBER() {
		return this.CRSE_NUMBER;
	}

	public void setCRSE_NUMBER(String value) {
		this.CRSE_NUMBER = value;
	}

	/**
	 *
	 */
	public String getEFFECTIVE_TERM() {
		return this.EFFECTIVE_TERM;
	}

	public void setEFFECTIVE_TERM(String value) {
		this.EFFECTIVE_TERM = value;
	}

	/**
	 *
	 */
	public String getCRSE_TITLE() {
		return this.CRSE_TITLE;
	}

	public void setCRSE_TITLE(String value) {
		this.CRSE_TITLE = value;
	}

	/**
	 *
	 */
	public String getCRSE_LONG_TITLE() {
		return this.CRSE_LONG_TITLE;
	}

	public void setCRSE_LONG_TITLE(String value) {
		this.CRSE_LONG_TITLE = value;
	}

	/**
	 *
	 */
	public String getCRSE_DIVISION() {
		return this.CRSE_DIVISION;
	}

	public void setCRSE_DIVISION(String value) {
		this.CRSE_DIVISION = value;
	}

	/**
	 *
	 */
	public String getCRSE_DEPT() {
		return this.CRSE_DEPT;
	}

	public void setCRSE_DEPT(String value) {
		this.CRSE_DEPT = value;
	}

	/**
	 *
	 */
	public String getCRSE_COLLEGE() {
		return this.CRSE_COLLEGE;
	}

	public void setCRSE_COLLEGE(String value) {
		this.CRSE_COLLEGE = value;
	}

	/**
	 *
	 */
	public String getMAX_RPT_UNITS() {
		return this.MAX_RPT_UNITS;
	}

	public void setMAX_RPT_UNITS(String value) {
		this.MAX_RPT_UNITS = value;
	}

	/**
	 *
	 */
	public String getREPEAT_LIMIT() {
		return this.REPEAT_LIMIT;
	}

	public void setREPEAT_LIMIT(String value) {
		this.REPEAT_LIMIT = value;
	}

	/**
	 *
	 */
	public String getCREDIT_HIGH() {
		return this.CREDIT_HIGH;
	}

	public void setCREDIT_HIGH(String value) {
		this.CREDIT_HIGH = value;
	}

	/**
	 *
	 */
	public String getCREDIT_LOW() {
		return this.CREDIT_LOW;
	}

	public void setCREDIT_LOW(String value) {
		this.CREDIT_LOW = value;
	}

	/**
	 *
	 */
	public String getCREDIT_IND() {
		return this.CREDIT_IND;
	}

	public void setCREDIT_IND(String value) {
		this.CREDIT_IND = value;
	}

	/**
	 *
	 */
	public String getCONT_HIGH() {
		return this.CONT_HIGH;
	}

	public void setCONT_HIGH(String value) {
		this.CONT_HIGH = value;
	}

	/**
	 *
	 */
	public String getCONT_LOW() {
		return this.CONT_LOW;
	}

	public void setCONT_LOW(String value) {
		this.CONT_LOW = value;
	}

	/**
	 *
	 */
	public String getCONT_IND() {
		return this.CONT_IND;
	}

	public void setCONT_IND(String value) {
		this.CONT_IND = value;
	}

	/**
	 *
	 */
	public String getLAB_HIGH() {
		return this.LAB_HIGH;
	}

	public void setLAB_HIGH(String value) {
		this.LAB_HIGH = value;
	}

	/**
	 *
	 */
	public String getLAB_LOW() {
		return this.LAB_LOW;
	}

	public void setLAB_LOW(String value) {
		this.LAB_LOW = value;
	}

	/**
	 *
	 */
	public String getLAB_IND() {
		return this.LAB_IND;
	}

	public void setLAB_IND(String value) {
		this.LAB_IND = value;
	}

	/**
	 *
	 */
	public String getLECT_HIGH() {
		return this.LECT_HIGH;
	}

	public void setLECT_HIGH(String value) {
		this.LECT_HIGH = value;
	}

	/**
	 *
	 */
	public String getLECT_LOW() {
		return this.LECT_LOW;
	}

	public void setLECT_LOW(String value) {
		this.LECT_LOW = value;
	}

	/**
	 *
	 */
	public String getLECT_IND() {
		return this.LECT_IND;
	}

	public void setLECT_IND(String value) {
		this.LECT_IND = value;
	}

	/**
	 *
	 */
	public String getOTH_HIGH() {
		return this.OTH_HIGH;
	}

	public void setOTH_HIGH(String value) {
		this.OTH_HIGH = value;
	}

	/**
	 *
	 */
	public String getOTH_LOW() {
		return this.OTH_LOW;
	}

	public void setOTH_LOW(String value) {
		this.OTH_LOW = value;
	}

	/**
	 *
	 */
	public String getOTH_IND() {
		return this.OTH_IND;
	}

	public void setOTH_IND(String value) {
		this.OTH_IND = value;
	}

	public String toString() {
		return "Id: " + getId() + "INSTITUTION: " + getINSTITUTION()
				+ "CRSE_ALPHA: " + getCRSE_ALPHA() + "CRSE_NUMBER: "
				+ getCRSE_NUMBER() + "EFFECTIVE_TERM: " + getEFFECTIVE_TERM()
				+ "CRSE_TITLE: " + getCRSE_TITLE() + "CRSE_LONG_TITLE: "
				+ getCRSE_LONG_TITLE() + "CRSE_DIVISION: " + getCRSE_DIVISION()
				+ "CRSE_DEPT: " + getCRSE_DEPT() + "CRSE_COLLEGE: "
				+ getCRSE_COLLEGE() + "MAX_RPT_UNITS: " + getMAX_RPT_UNITS()
				+ "REPEAT_LIMIT: " + getREPEAT_LIMIT() + "CREDIT_HIGH: "
				+ getCREDIT_HIGH() + "CREDIT_LOW: " + getCREDIT_LOW()
				+ "CREDIT_IND: " + getCREDIT_IND() + "CONT_HIGH: "
				+ getCONT_HIGH() + "CONT_LOW: " + getCONT_LOW() + "CONT_IND: "
				+ getCONT_IND() + "LAB_HIGH: " + getLAB_HIGH() + "LAB_LOW: "
				+ getLAB_LOW() + "LAB_IND: " + getLAB_IND() + "LECT_HIGH: "
				+ getLECT_HIGH() + "LECT_LOW: " + getLECT_LOW() + "LECT_IND: "
				+ getLECT_IND() + "OTH_HIGH: " + getOTH_HIGH() + "OTH_LOW: "
				+ getOTH_LOW() + "OTH_IND: " + getOTH_IND() + "";
	}

	public int compareTo(Object object) {
		return (0);
	}

}