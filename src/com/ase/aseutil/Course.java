/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Course.java
//
package com.ase.aseutil;

public class Course implements Comparable {
	/**
	 * id COUNTER
	 */
	int id = 0;

	/**
	 * historyid VARCHAR
	 */
	String historyid = null;

	/**
	 * CourseAlpha VARCHAR
	 */
	String CourseAlpha = null;

	/**
	 * CourseNum VARCHAR
	 */
	String CourseNum = null;

	/**
	 * CourseType VARCHAR
	 */
	String CourseType = null;

	/**
	 * edit BIT
	 */
	boolean edit = false;

	/**
	 * Progress VARCHAR
	 */
	String Progress = null;

	/**
	 * proposer VARCHAR
	 */
	String proposer = null;

	/**
	 * edit0 VARCHAR
	 */
	String edit0 = null;

	/**
	 * edit1 VARCHAR
	 */
	String edit1 = null;

	/**
	 * edit2 VARCHAR
	 */
	String edit2 = null;

	/**
	 * campus VARCHAR
	 */
	String campus = null;

	/**
	 * dispID String
	 */
	String dispID = null;

	/**
	 * Division VARCHAR
	 */
	String Division = null;

	/**
	 * coursetitle VARCHAR
	 */
	String coursetitle = null;

	/**
	 * credits VARCHAR
	 */
	String credits = null;

	/**
	 * repeatable BIT
	 */
	boolean repeatable = false;

	/**
	 * maxcredit VARCHAR
	 */
	String maxcredit = null;

	/**
	 * articulation VARCHAR
	 */
	String articulation = null;

	/**
	 * semester VARCHAR
	 */
	String semester = null;

	/**
	 * crosslisted BIT
	 */
	boolean crosslisted = false;

	/**
	 * coursedate String
	 */
	String coursedate = null;

	/**
	 * effectiveterm VARCHAR
	 */
	String effectiveterm = null;

	/**
	 * gradingoptions VARCHAR
	 */
	String gradingoptions = null;

	/**
	 * coursedescr LONGCHAR
	 */
	String coursedescr = null;

	/**
	 * hoursperweek VARCHAR
	 */
	String hoursperweek = null;

	/**
	 * reviewdate String
	 */
	String reviewdate = null;

	/**
	 * X15 LONGCHAR
	 */
	String X15 = null;

	/**
	 * X16 LONGCHAR
	 */
	String X16 = null;

	/**
	 * X17 LONGCHAR
	 */
	String X17 = null;

	/**
	 * X18 LONGCHAR
	 */
	String X18 = null;

	/**
	 * X19 LONGCHAR
	 */
	String X19 = null;

	/**
	 * X20 LONGCHAR
	 */
	String X20 = null;

	/**
	 * X21 LONGCHAR
	 */
	String X21 = null;

	/**
	 * X22 LONGCHAR
	 */
	String X22 = null;

	/**
	 * X23 LONGCHAR
	 */
	String X23 = null;

	/**
	 * X24 LONGCHAR
	 */
	String X24 = null;

	/**
	 * X25 LONGCHAR
	 */
	String X25 = null;

	/**
	 * X26 LONGCHAR
	 */
	String X26 = null;

	/**
	 * X27 LONGCHAR
	 */
	String X27 = null;

	/**
	 * X28 LONGCHAR
	 */
	String X28 = null;

	/**
	 * X29 LONGCHAR
	 */
	String X29 = null;

	/**
	 * X30 LONGCHAR
	 */
	String X30 = null;

	/**
	 * X31 LONGCHAR
	 */
	String X31 = null;

	/**
	 * X32 LONGCHAR
	 */
	String X32 = null;

	/**
	 * X33 LONGCHAR
	 */
	String X33 = null;

	/**
	 * X34 LONGCHAR
	 */
	String X34 = null;

	/**
	 * X35 LONGCHAR
	 */
	String X35 = null;

	/**
	 * X36 LONGCHAR
	 */
	String X36 = null;

	/**
	 * X37 LONGCHAR
	 */
	String X37 = null;

	/**
	 * X38 LONGCHAR
	 */
	String X38 = null;

	/**
	 * X39 LONGCHAR
	 */
	String X39 = null;

	/**
	 * X40 LONGCHAR
	 */
	String X40 = null;

	/**
	 * X41 LONGCHAR
	 */
	String X41 = null;

	/**
	 * X42 LONGCHAR
	 */
	String X42 = null;

	/**
	 * X43 LONGCHAR
	 */
	String X43 = null;

	/**
	 * X44 LONGCHAR
	 */
	String X44 = null;

	/**
	 * X45 LONGCHAR
	 */
	String X45 = null;

	/**
	 * X46 LONGCHAR
	 */
	String X46 = null;

	/**
	 * X47 LONGCHAR
	 */
	String X47 = null;

	/**
	 * X48 LONGCHAR
	 */
	String X48 = null;

	/**
	 * X49 LONGCHAR
	 */
	String X49 = null;

	/**
	 * X50 LONGCHAR
	 */
	String X50 = null;

	/**
	 * X51 LONGCHAR
	 */
	String X51 = null;

	/**
	 * X52 LONGCHAR
	 */
	String X52 = null;

	/**
	 * X53 LONGCHAR
	 */
	String X53 = null;

	/**
	 * X54 LONGCHAR
	 */
	String X54 = null;

	/**
	 * X55 LONGCHAR
	 */
	String X55 = null;

	/**
	 * X56 LONGCHAR
	 */
	String X56 = null;

	/**
	 * X57 LONGCHAR
	 */
	String X57 = null;

	/**
	 * X58 LONGCHAR
	 */
	String X58 = null;

	/**
	 * X59 LONGCHAR
	 */
	String X59 = null;

	/**
	 * X60 LONGCHAR
	 */
	String X60 = null;

	/**
	 * X61 LONGCHAR
	 */
	String X61 = null;

	/**
	 * X62 LONGCHAR
	 */
	String X62 = null;

	/**
	 * X63 LONGCHAR
	 */
	String X63 = null;

	/**
	 * reason LONGCHAR
	 */
	String reason = null;

	public Course() {}

	/**
	 *
	 */
	public int getid() {
		return this.id;
	}

	public void setid(int value) {
		this.id = value;
	}

	/**
	 *
	 */
	public String getHistoryID() {
		return this.historyid;
	}

	public void setHistoryID(String value) {
		this.historyid = value;
	}

	/**
	 *
	 */
	public String getCourseAlpha() {
		return this.CourseAlpha;
	}

	public void setCourseAlpha(String value) {
		this.CourseAlpha = value;
	}

	/**
	 *
	 */
	public String getCourseNum() {
		return this.CourseNum;
	}

	public void setCourseNum(String value) {
		this.CourseNum = value;
	}

	/**
	 *
	 */
	public String getCourseType() {
		return this.CourseType;
	}

	public void setCourseType(String value) {
		this.CourseType = value;
	}

	/**
	 *
	 */
	public boolean getedit() {
		return this.edit;
	}

	public void setedit(boolean value) {
		this.edit = value;
	}

	/**
	 *
	 */
	public String getProgress() {
		return this.Progress;
	}

	public void setProgress(String value) {
		this.Progress = value;
	}

	/**
	 *
	 */
	public String getProposer() {
		return this.proposer;
	}

	public void setProposer(String value) {
		this.proposer = value;
	}

	/**
	 *
	 */
	public String getedit0() {
		return this.edit0;
	}

	public void setedit0(String value) {
		this.edit0 = value;
	}

	/**
	 *
	 */
	public String getedit1() {
		return this.edit1;
	}

	public void setedit1(String value) {
		this.edit1 = value;
	}

	/**
	 *
	 */
	public String getedit2() {
		return this.edit2;
	}

	public void setedit2(String value) {
		this.edit2 = value;
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
	public String getDispID() {
		return this.dispID;
	}

	public void setDispID(String value) {
		this.dispID = value;
	}

	/**
	 *
	 */
	public String getDivision() {
		return this.Division;
	}

	public void setDivision(String value) {
		this.Division = value;
	}

	/**
	 *
	 */
	public String getcoursetitle() {
		return this.coursetitle;
	}

	public void setcoursetitle(String value) {
		this.coursetitle = value;
	}

	/**
	 *
	 */
	public String getcredits() {
		return this.credits;
	}

	public void setcredits(String value) {
		this.credits = value;
	}

	/**
	 *
	 */
	public boolean getrepeatable() {
		return this.repeatable;
	}

	public void setrepeatable(boolean value) {
		this.repeatable = value;
	}

	/**
	 *
	 */
	public String getmaxcredit() {
		return this.maxcredit;
	}

	public void setmaxcredit(String value) {
		this.maxcredit = value;
	}

	/**
	 *
	 */
	public String getarticulation() {
		return this.articulation;
	}

	public void setarticulation(String value) {
		this.articulation = value;
	}

	/**
	 *
	 */
	public String getsemester() {
		return this.semester;
	}

	public void setsemester(String value) {
		this.semester = value;
	}

	/**
	 *
	 */
	public boolean getcrosslisted() {
		return this.crosslisted;
	}

	public void setcrosslisted(boolean value) {
		this.crosslisted = value;
	}

	/**
	 *
	 */
	public String getcoursedate() {
		return this.coursedate;
	}

	public void setcoursedate(String value) {
		this.coursedate = value;
	}

	/**
	 *
	 */
	public String geteffectiveterm() {
		return this.effectiveterm;
	}

	public void seteffectiveterm(String value) {
		this.effectiveterm = value;
	}

	/**
	 *
	 */
	public String getgradingoptions() {
		return this.gradingoptions;
	}

	public void setgradingoptions(String value) {
		this.gradingoptions = value;
	}

	/**
	 *
	 */
	public String getcoursedescr() {
		return this.coursedescr;
	}

	public void setcoursedescr(String value) {
		this.coursedescr = value;
	}

	/**
	 *
	 */
	public String gethoursperweek() {
		return this.hoursperweek;
	}

	public void sethoursperweek(String value) {
		this.hoursperweek = value;
	}

	/**
	 *
	 */
	public String getreviewdate() {
		return this.reviewdate;
	}

	public void setreviewdate(String value) {
		this.reviewdate = value;
	}

	/**
	 *
	 */
	public String getX15() {
		return this.X15;
	}

	public void setX15(String value) {
		this.X15 = value;
	}

	/**
	 *
	 */
	public String getX16() {
		return this.X16;
	}

	public void setX16(String value) {
		this.X16 = value;
	}

	/**
	 *
	 */
	public String getX17() {
		return this.X17;
	}

	public void setX17(String value) {
		this.X17 = value;
	}

	/**
	 *
	 */
	public String getX18() {
		return this.X18;
	}

	public void setX18(String value) {
		this.X18 = value;
	}

	/**
	 *
	 */
	public String getX19() {
		return this.X19;
	}

	public void setX19(String value) {
		this.X19 = value;
	}

	/**
	 *
	 */
	public String getX20() {
		return this.X20;
	}

	public void setX20(String value) {
		this.X20 = value;
	}

	/**
	 *
	 */
	public String getX21() {
		return this.X21;
	}

	public void setX21(String value) {
		this.X21 = value;
	}

	/**
	 *
	 */
	public String getX22() {
		return this.X22;
	}

	public void setX22(String value) {
		this.X22 = value;
	}

	/**
	 *
	 */
	public String getX23() {
		return this.X23;
	}

	public void setX23(String value) {
		this.X23 = value;
	}

	/**
	 *
	 */
	public String getX24() {
		return this.X24;
	}

	public void setX24(String value) {
		this.X24 = value;
	}

	/**
	 *
	 */
	public String getX25() {
		return this.X25;
	}

	public void setX25(String value) {
		this.X25 = value;
	}

	/**
	 *
	 */
	public String getX26() {
		return this.X26;
	}

	public void setX26(String value) {
		this.X26 = value;
	}

	/**
	 *
	 */
	public String getX27() {
		return this.X27;
	}

	public void setX27(String value) {
		this.X27 = value;
	}

	/**
	 *
	 */
	public String getX28() {
		return this.X28;
	}

	public void setX28(String value) {
		this.X28 = value;
	}

	/**
	 *
	 */
	public String getX29() {
		return this.X29;
	}

	public void setX29(String value) {
		this.X29 = value;
	}

	/**
	 *
	 */
	public String getX30() {
		return this.X30;
	}

	public void setX30(String value) {
		this.X30 = value;
	}

	/**
	 *
	 */
	public String getX31() {
		return this.X31;
	}

	public void setX31(String value) {
		this.X31 = value;
	}

	/**
	 *
	 */
	public String getX32() {
		return this.X32;
	}

	public void setX32(String value) {
		this.X32 = value;
	}

	/**
	 *
	 */
	public String getX33() {
		return this.X33;
	}

	public void setX33(String value) {
		this.X33 = value;
	}

	/**
	 *
	 */
	public String getX34() {
		return this.X34;
	}

	public void setX34(String value) {
		this.X34 = value;
	}

	/**
	 *
	 */
	public String getX35() {
		return this.X35;
	}

	public void setX35(String value) {
		this.X35 = value;
	}

	/**
	 *
	 */
	public String getX36() {
		return this.X36;
	}

	public void setX36(String value) {
		this.X36 = value;
	}

	/**
	 *
	 */
	public String getX37() {
		return this.X37;
	}

	public void setX37(String value) {
		this.X37 = value;
	}

	/**
	 *
	 */
	public String getX38() {
		return this.X38;
	}

	public void setX38(String value) {
		this.X38 = value;
	}

	/**
	 *
	 */
	public String getX39() {
		return this.X39;
	}

	public void setX39(String value) {
		this.X39 = value;
	}

	/**
	 *
	 */
	public String getX40() {
		return this.X40;
	}

	public void setX40(String value) {
		this.X40 = value;
	}

	/**
	 *
	 */
	public String getX41() {
		return this.X41;
	}

	public void setX41(String value) {
		this.X41 = value;
	}

	/**
	 *
	 */
	public String getX42() {
		return this.X42;
	}

	public void setX42(String value) {
		this.X42 = value;
	}

	/**
	 *
	 */
	public String getX43() {
		return this.X43;
	}

	public void setX43(String value) {
		this.X43 = value;
	}

	/**
	 *
	 */
	public String getX44() {
		return this.X44;
	}

	public void setX44(String value) {
		this.X44 = value;
	}

	/**
	 *
	 */
	public String getX45() {
		return this.X45;
	}

	public void setX45(String value) {
		this.X45 = value;
	}

	/**
	 *
	 */
	public String getX46() {
		return this.X46;
	}

	public void setX46(String value) {
		this.X46 = value;
	}

	/**
	 *
	 */
	public String getX47() {
		return this.X47;
	}

	public void setX47(String value) {
		this.X47 = value;
	}

	/**
	 *
	 */
	public String getX48() {
		return this.X48;
	}

	public void setX48(String value) {
		this.X48 = value;
	}

	/**
	 *
	 */
	public String getX49() {
		return this.X49;
	}

	public void setX49(String value) {
		this.X49 = value;
	}

	/**
	 *
	 */
	public String getX50() {
		return this.X50;
	}

	public void setX50(String value) {
		this.X50 = value;
	}

	/**
	 *
	 */
	public String getX51() {
		return this.X51;
	}

	public void setX51(String value) {
		this.X51 = value;
	}

	/**
	 *
	 */
	public String getX52() {
		return this.X52;
	}

	public void setX52(String value) {
		this.X52 = value;
	}

	/**
	 *
	 */
	public String getX53() {
		return this.X53;
	}

	public void setX53(String value) {
		this.X53 = value;
	}

	/**
	 *
	 */
	public String getX54() {
		return this.X54;
	}

	public void setX54(String value) {
		this.X54 = value;
	}

	/**
	 *
	 */
	public String getX55() {
		return this.X55;
	}

	public void setX55(String value) {
		this.X55 = value;
	}

	/**
	 *
	 */
	public String getX56() {
		return this.X56;
	}

	public void setX56(String value) {
		this.X56 = value;
	}

	/**
	 *
	 */
	public String getX57() {
		return this.X57;
	}

	public void setX57(String value) {
		this.X57 = value;
	}

	/**
	 *
	 */
	public String getX58() {
		return this.X58;
	}

	public void setX58(String value) {
		this.X58 = value;
	}

	/**
	 *
	 */
	public String getX59() {
		return this.X59;
	}

	public void setX59(String value) {
		this.X59 = value;
	}

	/**
	 *
	 */
	public String getX60() {
		return this.X60;
	}

	public void setX60(String value) {
		this.X60 = value;
	}

	/**
	 *
	 */
	public String getX61() {
		return this.X61;
	}

	public void setX61(String value) {
		this.X61 = value;
	}

	/**
	 *
	 */
	public String getX62() {
		return this.X62;
	}

	public void setX62(String value) {
		this.X62 = value;
	}

	/**
	 *
	 */
	public String getX63() { return this.X63; }
	public void setX63(String value) { this.X63 = value; }

	/**
	 *
	 */
	public String getReason() { return this.reason; }
	public void setReason(String value) { this.reason = value; }

	/**
	 *
	 */
	public String toString() {

		return "id: " + getid() + "<br>\n" + "historyid: " + getHistoryID()
				+ "<br>\n" + "CourseAlpha: " + getCourseAlpha() + "<br>\n"
				+ "CourseNum: " + getCourseNum() + "<br>\n" + "CourseType: "
				+ getCourseType() + "<br>\n" + "campus: " + getCampus()
				+ "<br>\n" + "edit: " + getedit() + "<br>\n" + "Progress: "
				+ getProgress() + "<br>\n" + "proposer: " + getProposer()
				+ "<br>\n" + "edit0: " + getedit0() + "<br>\n" + "edit1: "
				+ getedit1() + "<br>\n" + "edit2: " + getedit2() + "<br>\n"
				+ "DispID: " + getDispID() + "<br>\n" + "Division: "
				+ getDivision() + "<br>\n" + "coursetitle: " + getcoursetitle()
				+ "<br>\n" + "credits: " + getcredits() + "<br>\n"
				+ "repeatable: " + getrepeatable() + "<br>\n" + "maxcredit: "
				+ getmaxcredit() + "<br>\n" + "articulation: "
				+ getarticulation() + "<br>\n" + "semester: " + getsemester()
				+ "<br>\n" + "crosslisted: " + getcrosslisted() + "<br>\n"
				+ "coursedate: " + getcoursedate() + "<br>\n"
				+ "effectiveterm: " + geteffectiveterm() + "<br>\n"
				+ "gradingoptions: " + getgradingoptions() + "<br>\n"
				+ "coursedescr: " + getcoursedescr() + "<br>\n"
				+ "hoursperweek: " + gethoursperweek() + "<br>\n"
				+ "reviewdate: " + getreviewdate() + "<br>\n" + "X15: "
				+ getX15() + "<br>\n" + "X16: " + getX16() + "<br>\n" + "X17: "
				+ getX17() + "<br>\n" + "X18: " + getX18() + "<br>\n" + "X19: "
				+ getX19() + "<br>\n" + "X20: " + getX20() + "<br>\n" + "X21: "
				+ getX21() + "<br>\n" + "X22: " + getX22() + "<br>\n" + "X23: "
				+ getX23() + "<br>\n" + "X24: " + getX24() + "<br>\n" + "X25: "
				+ getX25() + "<br>\n" + "X26: " + getX26() + "<br>\n" + "X27: "
				+ getX27() + "<br>\n" + "X28: " + getX28() + "<br>\n" + "X29: "
				+ getX29() + "<br>\n" + "X30: " + getX30() + "<br>\n" + "X31: "
				+ getX31() + "<br>\n" + "X32: " + getX32() + "<br>\n" + "X33: "
				+ getX33() + "<br>\n" + "X34: " + getX34() + "<br>\n" + "X35: "
				+ getX35() + "<br>\n" + "X36: " + getX36() + "<br>\n" + "X37: "
				+ getX37() + "<br>\n" + "X38: " + getX38() + "<br>\n" + "X39: "
				+ getX39() + "<br>\n" + "X40: " + getX40() + "<br>\n" + "X41: "
				+ getX41() + "<br>\n" + "X42: " + getX42() + "<br>\n" + "X43: "
				+ getX43() + "<br>\n" + "X44: " + getX44() + "<br>\n" + "X45: "
				+ getX45() + "<br>\n" + "X46: " + getX46() + "<br>\n" + "X47: "
				+ getX47() + "<br>\n" + "X48: " + getX48() + "<br>\n" + "X49: "
				+ getX49() + "<br>\n" + "X50: " + getX50() + "<br>\n" + "X51: "
				+ getX51() + "<br>\n" + "X52: " + getX52() + "<br>\n" + "X53: "
				+ getX53() + "<br>\n" + "X54: " + getX54() + "<br>\n" + "X55: "
				+ getX55() + "<br>\n" + "X56: " + getX56() + "<br>\n" + "X57: "
				+ getX57() + "<br>\n" + "X58: " + getX58() + "<br>\n" + "X59: "
				+ getX59() + "<br>\n" + "X60: " + getX60() + "<br>\n" + "X61: "
				+ getX61() + "<br>\n" + "X62: " + getX62() + "<br>\n" + "X63: "
				+ getX63() + "<br>\n"
				+ getReason() + "<br>\n" + "";
	}

	public int compareTo(Object object) {
		return (0);
	}

}