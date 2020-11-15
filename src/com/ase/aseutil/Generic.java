/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Generic.java
//
package com.ase.aseutil;

public class Generic {

	/**
	* varchar
	**/
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

	public Generic(){}

	public Generic(String s1,String s2,String s3,String s4,String s5,String s6,String s7,String s8,String s9){
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

	public Generic(String s1,String s2,String s3,String s4,String s5,String s6,String s7,String s8,String s9,String s0){
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
		"string1: " + getString1() +
		"string2: " + getString2() +
		"string3: " + getString3() +
		"string4: " + getString4() +
		"string5: " + getString5() +
		"string6: " + getString6() +
		"string7: " + getString7() +
		"string8: " + getString8() +
		"string9: " + getString9() +
		"string0: " + getString0() +
		"int1: " + getInt1() +
		"int2: " + getInt2() +
		"int3: " + getInt3() +
		"int4: " + getInt4() +
		"int5: " + getInt5() +
		"int6: " + getInt6() +
		"int7: " + getInt7() +
		"int8: " + getInt8() +
		"int9: " + getInt9() +
		"int0: " + getInt0() +
		"";
	}
}
