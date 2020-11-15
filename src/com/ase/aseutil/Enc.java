/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @campus ttgiang
 */

//
// Enc.java
//
package com.ase.aseutil;

public class Enc {

	/**
	* alpha varchar
	**/
	private String alpha = null;

	/**
	* campus varchar
	**/
	private String campus = null;

	/**
	* data varchar
	**/
	private String data = null;

	/**
	* dst varchar
	**/
	private String dst = null;

	/**
	* kix varchar
	**/
	private String key1 = null;
	private String key2 = null;
	private String key3 = null;
	private String key4 = null;
	private String key5 = null;
	private String key6 = null;
	private String key7 = null;
	private String key8 = null;
	private String key9 = null;

	/**
	* kix varchar
	**/
	private String kix = null;

	/**
	* num varchar
	**/
	private String num = null;

	/**
	* skew boolean
	**/
	private String skew = null;

	/**
	* src varchar
	**/
	private String src = null;

	/**
	* user varchar
	**/
	private String user = null;

	public Enc() throws Exception {
		this.alpha = "";
		this.campus = "";
		this.data = "";
		this.dst = "";
		this.key1 = "";
		this.key2 = "";
		this.key3 = "";
		this.key4 = "";
		this.key5 = "";
		this.key6 = "";
		this.key7 = "";
		this.key8 = "";
		this.key9 = "";
		this.kix = "";
		this.num = "";
		this.skew = "";
		this.src = "";
		this.user = "";
	}

	/**
	*
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	*
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	*
	**/
	public String getData(){ return this.data; }
	public void setData(String value){ this.data = value; }

	/**
	*
	**/
	public String getDst(){ return this.dst; }
	public void setDst(String value){ this.dst = value; }

	/**
	*
	**/
	public String getKey1(){ return this.key1; }
	public void setKey1(String value){ this.key1 = value; }

	public String getKey2(){ return this.key2; }
	public void setKey2(String value){ this.key2 = value; }

	public String getKey3(){ return this.key3; }
	public void setKey3(String value){ this.key3 = value; }

	public String getKey4(){ return this.key4; }
	public void setKey4(String value){ this.key4 = value; }

	public String getKey5(){ return this.key5; }
	public void setKey5(String value){ this.key5 = value; }

	public String getKey6(){ return this.key6; }
	public void setKey6(String value){ this.key6 = value; }

	public String getKey7(){ return this.key7; }
	public void setKey7(String value){ this.key7 = value; }

	public String getKey8(){ return this.key8; }
	public void setKey8(String value){ this.key8 = value; }

	public String getKey9(){ return this.key9; }
	public void setKey9(String value){ this.key9 = value; }

	/**
	*
	**/
	public String getKix(){ return this.kix; }
	public void setKix(String value){ this.kix = value; }

	/**
	*
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

	/**
	*
	**/
	public String getSkew(){ return this.skew; }
	public void setSkew(String value){ this.skew = value; }

	/**
	*
	**/
	public String getSrc(){ return this.src; }
	public void setSrc(String value){ this.src = value; }

	/**
	*
	**/
	public String getUser(){ return this.user; }
	public void setUser(String value){ this.user = value; }

	public String toString(){
		return
		"Alpha: " + getAlpha() + "\n" +
		"Campus: " + getCampus() + "\n" +
		"Data: " + getData() + "\n" +
		"Dst: " + getDst() + "\n" +
		"Key1: " + getKey1() + "\n" +
		"Key2: " + getKey2() + "\n" +
		"Key3: " + getKey3() + "\n" +
		"Key4: " + getKey4() + "\n" +
		"Key5: " + getKey5() + "\n" +
		"Key6: " + getKey6() + "\n" +
		"Key7: " + getKey7() + "\n" +
		"Key8: " + getKey8() + "\n" +
		"Key9: " + getKey9() + "\n" +
		"Kix: " + getKix() + "\n" +
		"Num: " + getNum() + "\n" +
		"Skew: " + getSkew() + "\n" +
		"Src: " + getSrc() + "\n" +
		"User: " + getUser() + "\n" +
		"";
	}

}
