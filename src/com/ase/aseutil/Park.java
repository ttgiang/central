/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Park.java
//
package com.ase.aseutil;

public class Park {

	int id = 0;

	/**
	* varchar
	**/
	private String campus = null;
	private String userid = null;
	private String historyid = null;
	private String courseAlpha = null;
	private String courseNum = null;
	private String courseType = null;
	private String descr = null;

	private String string1 = null;
	private String string2 = null;
	private String string3 = null;
	private String string4 = null;
	private String string5 = null;
	private String string6 = null;
	private String string7 = null;
	private String string8 = null;
	private String string9 = null;
	private String string0 = null;

	/**
	* int
	**/
	private int int1 = 0;
	private int int2 = 0;
	private int int3 = 0;
	private int int4 = 0;
	private int int5 = 0;
	private int int6 = 0;
	private int int7 = 0;
	private int int8 = 0;
	private int int9 = 0;
	private int int0 = 0;

	public Park(){}

	public Park(String campus,String userid,String historyid,String descr,String s1){
		this.campus = campus;
		this.userid = userid;
		this.historyid = historyid;
		this.descr = descr;
		this.string1 = s1;
	}

	public Park(String s1,String s2,String s3,String s4,String s5,String s6,String s7,String s8,String s9){
		this.string1 = s1;
		this.string2 = s2;
		this.string3 = s3;
		this.string4 = s4;
		this.string5 = s5;
		this.string6 = s6;
		this.string7 = s7;
		this.string8 = s8;
		this.string9 = s9;
	}

	public Park(String s1,String s2,String s3,String s4,String s5,String s6,String s7,String s8,String s9,String s0){
		this.string1 = s1;
		this.string2 = s2;
		this.string3 = s3;
		this.string4 = s4;
		this.string5 = s5;
		this.string6 = s6;
		this.string7 = s7;
		this.string8 = s8;
		this.string9 = s9;
		this.string0 = s0;
	}

	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	public String getHistoryId(){ return this.historyid; }
	public void setHistoryId(String value){ this.historyid = value; }

	public String getUserId(){ return this.userid; }
	public void setUserId(String value){ this.userid = value; }

	public String getCourseAlpha(){ return this.courseAlpha; }
	public void setCourseAlpha(String value){ this.courseAlpha = value; }

	public String getCourseNum(){ return this.courseNum; }
	public void setCourseNum(String value){ this.courseNum = value; }

	public String getCourseType(){ return this.courseType; }
	public void setCourseType(String value){ this.courseType = value; }

	public String getDescr(){ return this.descr; }
	public void setDescr(String value){ this.descr = value; }

	/**
	** getString1
	**/
	public String getString1(){ return this.string1; }
	public void setString1(String value){ this.string1 = value; }

	public String getString2(){ return this.string2; }
	public void setString2(String value){ this.string2 = value; }

	public String getString3(){ return this.string3; }
	public void setString3(String value){ this.string3 = value; }

	public String getString4(){ return this.string4; }
	public void setString4(String value){ this.string4 = value; }

	public String getString5(){ return this.string5; }
	public void setString5(String value){ this.string5 = value; }

	public String getString6(){ return this.string6; }
	public void setString6(String value){ this.string6 = value; }

	public String getString7(){ return this.string7; }
	public void setString7(String value){ this.string7 = value; }

	public String getString8(){ return this.string8; }
	public void setString8(String value){ this.string8 = value; }

	public String getString9(){ return this.string9; }
	public void setString9(String value){ this.string9 = value; }

	public String getString0(){ return this.string0; }
	public void setString0(String value){ this.string0 = value; }

	/**
	** getInt1
	**/
	public int getInt1(){ return this.int1; }
	public void setInt1(int value){ this.int1 = value; }

	public int getInt2(){ return this.int2; }
	public void setInt2(int value){ this.int2 = value; }

	public int getInt3(){ return this.int3; }
	public void setInt3(int value){ this.int3 = value; }

	public int getInt4(){ return this.int4; }
	public void setInt4(int value){ this.int4 = value; }

	public int getInt5(){ return this.int5; }
	public void setInt5(int value){ this.int5 = value; }

	public int getInt6(){ return this.int6; }
	public void setInt6(int value){ this.int6 = value; }

	public int getInt7(){ return this.int7; }
	public void setInt7(int value){ this.int7 = value; }

	public int getInt8(){ return this.int8; }
	public void setInt8(int value){ this.int8 = value; }

	public int getInt9(){ return this.int9; }
	public void setInt9(int value){ this.int9 = value; }

	public int getInt0(){ return this.int0; }
	public void setInt0(int value){ this.int0 = value; }

	/**
	 * toString
	 */
	public String toString(){
		return
		"campus: " + getCampus() + "\n" +
		"user: " + getUserId() + "\n" +
		"historyid: " + getHistoryId() + "\n" +
		"alpha: " + getCourseAlpha() + "\n" +
		"num: " + getCourseNum() + "\n" +
		"type: " + getCourseType() + "\n" +
		"descr: " + getDescr() + "\n" +
		"string1: " + getString1() + "\n" +
		"string2: " + getString2() + "\n" +
		"string3: " + getString3() + "\n" +
		"string4: " + getString4() + "\n" +
		"string5: " + getString5() + "\n" +
		"string6: " + getString6() + "\n" +
		"string7: " + getString7() + "\n" +
		"string8: " + getString8() + "\n" +
		"string9: " + getString9() + "\n" +
		"string0: " + getString0() + "\n" +
		"int1: " + getInt1() + "\n" +
		"int2: " + getInt2() + "\n" +
		"int3: " + getInt3() + "\n" +
		"int4: " + getInt4() + "\n" +
		"int5: " + getInt5() + "\n" +
		"int6: " + getInt6() + "\n" +
		"int7: " + getInt7() + "\n" +
		"int8: " + getInt8() + "\n" +
		"int9: " + getInt9() + "\n" +
		"int0: " + getInt0() + "\n" +
		"";
	}
}
