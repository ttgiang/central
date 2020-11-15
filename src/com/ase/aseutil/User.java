/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// User.java
//
package com.ase.aseutil;

public class User {
	/*
	 * The following Bitmap specifies the membership
	 * +-----------------------------------+ |Admin
	 * |......|XXXXXX|XXXXXX|General| ID | 0 |0000 | 0| 0| 0| 0 No user. | 0
	 * |0000 | 0| 0| 1| 1 Registered User ( Only General thins accessible) | 1
	 * |1111 | 1| 1| 1| -1 Admin User ( All kind of rights available)
	 * +-----------------------------------+
	 *
	 */
	static final int NOT_APPROVED = 0;
	static final int REGISTERED_USER = 1;
	static final int ADMIN_USER = -1;
	static final int ADMIN_BIT_MAP = 0x8000000;
	static final int REGISTERED_BIT_MAP = 1;

	private String userid;
	private String password;
	private String fullname;
	private String firstname;
	private String lastname;
	private String position;
	private String status;
	private String division;
	private String department;
	private String email;
	private String title;
	private String salutation;
	private String location;
	private String hours;
	private String phone;
	private String campus;
	private String check;
	private String lastused;
	private String auditdate;
	private String auditby;
	private String alphas;
	private int userlevel;
	public long nACLBitmap;
	public int uh;
	public int sendNow;
	public int attachment;
	public String website;
	public String weburl;
	public String college;

	WebSite ws = null;

	StringBuffer buffer = new StringBuffer();

	public User() {
		this.userid = "";
		this.password = "";
		this.fullname = "";
		this.firstname = "";
		this.lastname = "";
		this.position = "";
		this.status = "";
		this.division = "";
		this.department = "";
		this.email = "";
		this.title = "";
		this.salutation = "";
		this.campus = "";
		this.userlevel = 1;
		this.auditby = "";
		this.auditdate = "";
		this.hours = "";
		this.phone = "";
		this.location = "";
		this.uh = 1;
		this.sendNow = 1;
		this.alphas = "";
		this.attachment = 0;
		this.website = "";
		this.weburl = "";
		this.college = "";
	}

	public User(WebSite ws) {
		ws = ws;
	}

	public User(String userid,String firstname,String lastname,
					String position,String status,String division,String department,
					String title,String campus,int userlevel) {

		this.userid = userid;
		this.firstname = firstname;
		this.lastname = lastname;
		this.position = position;
		this.status = status;
		this.division = division;
		this.department = department;
		this.title = title;
		this.campus = campus;
		this.userlevel = userlevel;
	}

	public User(String userid,String firstname,String lastname,
					String position,String status,String division,String department,
					String title,String campus,int userlevel,String college) {

		this.userid = userid;
		this.firstname = firstname;
		this.lastname = lastname;
		this.position = position;
		this.status = status;
		this.division = division;
		this.department = department;
		this.title = title;
		this.campus = campus;
		this.userlevel = userlevel;
		this.college = college;
	}

	public User(String userid,String password,String fullname,String firstname,String lastname,
					String position,String status,String division,String department,String email,
					String title,String salutation,String campus,int userlevel,String auditby,
					String auditdate,int uh) {

		this.userid = userid;
		this.password = password;
		this.fullname = fullname;
		this.firstname = firstname;
		this.lastname = lastname;
		this.position = position;
		this.status = status;
		this.division = division;
		this.department = department;
		this.email = email;
		this.title = title;
		this.salutation = salutation;
		this.campus = campus;
		this.userlevel = userlevel;
		this.auditby = auditby;
		this.auditdate = auditdate;
		this.uh = uh;

		nACLBitmap = 0;
	}

	public String getUserid() {
		return this.userid;
	}

	public boolean setUserid(String value) {
		this.userid = value;
		return true;
	}

	public String getPassword() {
		return this.password;
	}

	public boolean setPassword(String value) {
		this.password = value;
		return true;
	}

	public String getFullname() {
		return this.fullname;
	}

	public void setFullname(String value) {
		this.fullname = ws.cleanSQL(value);
	}

	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String value) {
		this.firstname = ws.cleanSQL(value);
	}

	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String value) {
		this.lastname = ws.cleanSQL(value);
	}

	public String getPosition() {
		return this.position;
	}

	public void setPosition(String value) {
		this.position = ws.cleanSQL(value);
	}

	public String getStatus() {
		return this.status;
	}

	public boolean setStatus(String value) {
		this.status = ws.cleanSQL(value);
		return true;
	}

	public String getDivision() {
		return this.division;
	}

	public boolean setDivision(String value) {
		this.division = ws.cleanSQL(value);
		return true;
	}

	public String getDepartment() {
		return this.department;
	}

	public boolean setDepartment(String value) {
		this.department = ws.cleanSQL(value);
		return true;
	}

	public String getEmail() {
		return this.email;
	}

	public boolean setEmail(String value) {
		this.email = ws.cleanSQL(value);
		return true;
	}

	public String getTitle() {
		return this.title;
	}

	public boolean setTitle(String value) {
		this.title = ws.cleanSQL(value);
		return true;
	}

	public String getSalutation() {
		return this.salutation;
	}

	public boolean setSalutation(String value) {
		this.salutation = ws.cleanSQL(value);
		return true;
	}

	public int getUserLevel() {
		return this.userlevel;
	}

	public boolean setUserLevel(int value) {
		this.userlevel = value;
		return true;
	}

	public String getCampus() {
		return this.campus;
	}

	public boolean setCampus(String value) {
		this.campus = ws.cleanSQL(value);
		return true;
	}

	public String getLocation() {
		return this.location;
	}

	public boolean setLocation(String value) {
		this.location = ws.cleanSQL(value);
		return true;
	}

	public String getHours() {
		return this.hours;
	}

	public boolean setHours(String value) {
		this.hours = ws.cleanSQL(value);
		return true;
	}

	public String getPhone() {
		return this.phone;
	}

	public String getCheck() {
		return this.check;
	}

	public boolean setCheck(String value) {
		this.check = value;
		return true;
	}

	public boolean setPhone(String value) {
		this.phone = ws.cleanSQL(value);
		return true;
	}

	public String getAuditBy() {
		return this.auditby;
	}

	public boolean setAuditBy(String value) {
		this.auditby = value;
		return true;
	}

	public String getAuditDate() {
		return this.auditdate;
	}

	public boolean setAuditDate(String value) {
		this.auditdate = value;
		return true;
	}

	public String getLastUsed() {
		return this.lastused;
	}

	public boolean setLastUsed(String value) {
		this.lastused = value;
		return true;
	}

	public int getUH() {
		return this.uh;
	}

	public boolean setUH(int value) {
		this.uh = value;
		return true;
	}

	public boolean isAdmin() {
		long nInt = nACLBitmap & ADMIN_BIT_MAP;
		return (nInt) > 0;
	}

	public boolean isRegistered() {
		long nInt = nACLBitmap & REGISTERED_BIT_MAP;
		return (nInt) > 0;
	}

	public User get(String txtEmailAddress) {
		return null;
	}

	public String getAlphas() {
		return this.alphas;
	}

	public boolean setAlphas(String value) {
		this.alphas = value;
		return true;
	}

	public int getSendNow() {
		return this.sendNow;
	}

	public boolean setSendNow(int value) {
		this.sendNow = value;
		return true;
	}

	public int getAttachment() {
		return this.attachment;
	}

	public boolean setAttachment(int value) {

		if (NumericUtil.isInteger(value)){
			this.attachment = value;
		}
		else{
			this.attachment = 0;
		}

		return true;
	}

	public String getWebsite() {
		return this.website;
	}

	public boolean setWebsite(String value) {
		this.website = value;
		return true;
	}

	public String getWeburl() {
		return this.weburl;
	}

	public boolean setWeburl(String value) {
		this.weburl = value;
		return true;
	}

	public String getCollege() {
		return this.college;
	}

	public boolean setCollege(String value) {
		this.college = value;
		return true;
	}


	public String toString(){

		return "Userid: " + getUserid() + "\n" +
		"Password: *******\n" +
		"Uh: " + getUH() +  "\n" +
		"Fullname: " + getFullname() +  "\n" +
		"Status: " + getStatus() +  "\n" +
		"Userlevel: " + getUserLevel() +  "\n" +
		"Division: " + getDivision() +  "\n" +
		"Department: " + getDepartment() +  "\n" +
		"Alphas: " + getAlphas() +  "\n" +
		"Email: " + getEmail() +  "\n" +
		"Title: " + getTitle() +  "\n" +
		"Position: " + getPosition() +  "\n" +
		"Salutation: " + getSalutation() +  "\n" +
		"Location: " + getLocation() +  "\n" +
		"Hours: " + getHours() +  "\n" +
		"Phone: " + getPhone() +  "\n" +
		"Check: " + getCheck() +  "\n" +
		"Campus: " + getCampus() +  "\n" +
		"Auditby: " + getAuditBy() +  "\n" +
		"Auditdate: " + getAuditDate() +  "\n" +
		"SendNow: " + getSendNow() +  "\n" +
		"Attachment: " + getAttachment() +  "\n" +
		"Website: " + getWebsite() +  "\n" +
		"Weburl: " + getWeburl() +  "\n" +
		"College: " + getCollege() +  "\n" +
		"";
	}
}
