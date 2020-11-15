/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int getInt(String value) {
 *	public static int getNumeric(HttpSession session,String sess) {
 *	public static String intToString(int num) {
 *	public static boolean isInteger(String value) {
 *	public static String nullToBlank(String value) {
 *	public static int nullToZero(int value) {
 *	public static int nullToZero(String value) {
 *	public static int stringToInt(String str) {
 *
 * @author ttgiang
 */

//
// NumericUtil.java
//
package com.ase.aseutil;

import javax.servlet.http.HttpSession;

public class NumericUtil {

	public static boolean isInteger(String value) {
		if ((value == null) || (value.length() < 1)) {
			return false;
		}

		try {
			new Integer(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	public static boolean isInteger(int value) {
		try {
			new Integer(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	/*
	 * nullToZero
	 * <p>
	 * @param	vale		int
	 * <p>
	 * @return int
	 */
	public static int nullToZero(int value) {

		int val = 0;

		try {
			val = new Integer(value);
		} catch (NumberFormatException nfe) {
			return 0;
		}

		return val;
	}

	/*
	 * nullToZero
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return int
	 */
	public static int nullToZero(String value) {

		int val = 0;

		if ((value == null) || (value.length() < 1)) {
			return 0;
		}

		try {
			val = new Integer(value);
		} catch (NumberFormatException nfe) {
			return 0;
		}

		return val;
	}

	/*
	 * nullToBlank
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return String
	 */
	public static String nullToBlank(String value) {

		String val = "";

		if ((value == null) || (value.length() < 1))
			val = "";
		else
			val = value;

		return val;
	}

	/*
	 * getInt
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return int
	 */
	public static int getInt(String value) {
		value = nullToBlank(value);
		return new Integer(value).intValue();
	}

	/*
	 * getInt
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return int
	 */
	public static int getInt(String value,int def) {

		if(value==null || value.length()==0){
			value = "" + def;
		}

		value = AseUtil.nullToBlank(value);

		value = correctNegative(value);

		int val = def;

		try{
			val = new Integer(value).intValue();
		}
		catch(Exception e){
			val = def;
		}

		return val;
	}

	/*
	 * correctNegative
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return String
	 */
	public static String correctNegative(String value) {

		// numeric values with negative at the end must be moved to the front
		if (value != null){

			value = AseUtil.nullToBlank(value);

			if (value.endsWith("-")){
				value = "-" + AseUtil.nullToBlank(value.replace("-",""));
			}
		}

		return value;
	}

	/*
	 * getInt
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return int
	 */
	public static int getInt(int value,int def) {

		if(!isInteger(value)){
			value = def;
		}

		return value;
	}
	//
	// int - end
	//

	//
	// DOUBLE - start
	//
	public static boolean isDouble(String value) {
		if ((value == null) || (value.length() < 1)) {
			return false;
		}

		try {
			new Double(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	public static boolean isDouble(double value) {
		try {
			new Double(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	/*
	 * getDouble
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return double
	 */
	public static double getDouble(String value) {

		value = nullToBlank(value);

		return new Double(value).doubleValue();

	}

	/*
	 * getDouble
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return double
	 */
	public static double getDouble(String value,double def) {

		if(value==null){
			value = "" + def;
		}
		else{
			value = "" + nullToZero(value);
		}

		return new Double(value).doubleValue();
	}

	/*
	 * getDouble
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return double
	 */
	public static double getDouble(double value,double def) {

		if(!isDouble(value)){
			value = def;
		}

		return value;
	}
	//
	// DOUBLE - end
	//

	//
	// LONG - start
	//
	public static boolean isLong(String value) {
		if ((value == null) || (value.length() < 1)) {
			return false;
		}

		try {
			new Long(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	public static boolean isLong(long value) {
		try {
			new Long(value);
		} catch (NumberFormatException nfe) {
			return false;
		}

		return true;
	}

	/*
	 * getLong
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return long
	 */
	public static long getLong(String value) {

		value = nullToBlank(value);

		return new Long(value).longValue();

	}

	/*
	 * getLong
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return long
	 */
	public static long getLong(String value,long def) {

		if(value==null){
			value = "" + def;
		}
		else{
			value = "" + nullToZero(value);
		}

		return new Long(value).longValue();
	}

	/*
	 * getLong
	 * <p>
	 * @param	vale		String
	 * <p>
	 * @return long
	 */
	public static long getLong(long value,long def) {

		if(!isLong(value)){
			value = def;
		}

		return value;
	}
	//
	// LONG - end
	//

	/*
	 * getNumeric
	 * <p>
	 * @param	session	HttpSession
	 * @param	sess		String
	 * <p>
	 * @return int
	 */
	public static int getNumeric(HttpSession session,String sess) {

		String temp = "";
		int value = 0;

		try{
			temp = (String)session.getAttribute(sess);
			if (isInteger(temp))
				value = getInt(temp);
			else
				value = 0;
		}
		catch(java.lang.ClassCastException cce){
			value = 0;
		}
		catch(Exception e){
			value = 0;
		}

		return value;

	}

	/*
	 * stringToInt
	 * <p>
	 * @param	str	String
	 * <p>
	 * @return int
	 */
	public static int stringToInt(String str) {

		int value = 0;

		try{
			if (str == null || str.length() == 0)
				value = 0;
			else
				value = getInt(str);
		}
		catch(java.lang.ClassCastException cce){
			value = 0;
		}
		catch(Exception e){
			value = 0;
		}

		return value;
	}

	/*
	 * intToString
	 * <p>
	 * @param	num	int
	 * <p>
	 * @return String
	 */
	public static String intToString(int num) {

		String str = "";

		try{
			str = Integer.toString(num);
		}
		catch(java.lang.ClassCastException cce){
			str = "";
		}
		catch(Exception e){
			str = "";
		}

		return str;
	}

	/**
	 * findNumberInString
	 * <p>
	 * <p>
	 * @return int
	 */
	public static int findNumberInString(String string){

			char[] c = string.toCharArray();

			for(int i=0; i < string.length(); i++){
				 if (Character.isDigit(c[i])){
					 return i;
				 }
		  }

		  return -1;
	}

}
