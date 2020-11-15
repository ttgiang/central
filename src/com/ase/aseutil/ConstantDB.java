/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int getConstantTypeFromString(String type){
 *
 */

//
// ConstantDB.java
//
package com.ase.aseutil;

import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ConstantDB {

	static Logger logger = Logger.getLogger(ConstantDB.class.getName());

	public ConstantDB() throws Exception {}

	/**
	 * getConstantTypeFromString
	 * <p>
	 * @param	type	String
	 * <p>
	 * @return	int
	 */
	public static int getConstantTypeFromString(String type){

		int tp = 0;

		if ("ARC".equals(type))
			tp = Constant.COURSETYPE_ARC;
		else if ("CAN".equals(type))
			tp = Constant.COURSETYPE_CAN;
		else if ("CUR".equals(type))
			tp = Constant.COURSETYPE_CUR;
		else if ("PRE".equals(type))
			tp = Constant.COURSETYPE_PRE;

		return tp;
	}

	public void close() throws SQLException {}
}