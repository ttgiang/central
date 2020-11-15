/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Ini.java
//
package com.ase.aseutil;

public class Ini implements Comparable {
	private String id = null;
	private String seq = null;
	private String category = null;
	private String kid = null;
	private String kdesc = null;
	private String kval1 = null;
	private String kval2 = null;
	private String kval3 = null;
	private String kval4 = null;
	private String kval5 = null;
	private String klanid = null;
	private String kdate = null;
	private String campus = null;
	private String kedit = null;
	private String note = null;
	private String script = null;

	public Ini() {}

	public Ini(String id, String category, String kid, String kdesc,
			String kval1, String kval2, String kval3, String kval4,
			String kval5, String klanid, String kdate, String campus,String kedit) {

		this.id = id;
		this.category = category;
		this.kid = kid;
		this.kdesc = kdesc;
		this.kval1 = kval1;
		this.kval2 = kval2;
		this.kval3 = kval3;
		this.kval4 = kval4;
		this.kval5 = kval5;
		this.klanid = klanid;
		this.kdate = kdate;
		this.campus = campus;
		this.kedit = kedit;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String value) {
		this.id = value;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String value) {
		this.category = value;
	}

	public String getKid() {
		return this.kid;
	}

	public void setKid(String value) {
		this.kid = value;
	}

	public String getKdesc() {
		return this.kdesc;
	}

	public void setKdesc(String value) {
		this.kdesc = value;
	}

	public String getKval1() {
		return this.kval1;
	}

	public void setKval1(String value) {
		this.kval1 = value;
	}

	public String getKval2() {
		return this.kval2;
	}

	public void setKval2(String value) {
		this.kval2 = value;
	}

	public String getKval3() {
		return this.kval3;
	}

	public void setKval3(String value) {
		this.kval3 = value;
	}

	public String getKval4() {
		return this.kval4;
	}

	public void setKval4(String value) {
		this.kval4 = value;
	}

	public String getKval5() {
		return this.kval5;
	}

	public void setKval5(String value) {
		this.kval5 = value;
	}

	public String getKlanid() {
		return this.klanid;
	}

	public void setKlanid(String value) {
		this.klanid = value;
	}

	public String getKdate() {
		return this.kdate;
	}

	public void setKdate(String value) {
		this.kdate = value;
	}

	public String getCampus() {return this.campus;}
	public void setCampus(String value) {this.campus = value; }

	public String getKedit() {return this.kedit;}
	public void setKedit(String value) {this.kedit = value; }

	public String getNote() {return this.note;}
	public void setNote(String value) {this.note = value; }

	public String getScript() {return this.script;}
	public void setScript(String value) {this.script = value; }

	public int compareTo(Object object) {
		return 0;
	}

	public String toString(){
		return "Id: " + getId() + "<br>" +
		"Category: " + getCategory() + "<br>" +
		"Kid: " + getKid() + "<br>" +
		"Kdesc: " + getKdesc() + "<br>" +
		"Kval1: " + getKval1() + "<br>" +
		"Kval2: " + getKval2() + "<br>" +
		"Kval3: " + getKval3() + "<br>" +
		"Kval4: " + getKval4() + "<br>" +
		"Kval5: " + getKval5() + "<br>" +
		"Klanid: " + getKlanid() + "<br>" +
		"Kdate: " + getKdate() + "<br>" +
		"Kedit: " + getKedit() + "<br>" +
		"Campus: " + getCampus() + "<br>" +
		"Note: " + getNote() + "<br>" +
		"Script: " + getScript() + "<br>" +
		"";
	}

}