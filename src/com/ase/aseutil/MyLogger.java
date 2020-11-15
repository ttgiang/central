/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// MyLogger.java
//
package com.ase.aseutil;

import org.apache.log4j.Logger;

public final class MyLogger {

	static Logger logger = Logger.getLogger(MyLogger.class.getName());

	public static void fatal(String str){
		logger.fatal(str);
	}

	public static void info(String str){
		logger.info(str);
	}

	public static void warn(String str){
		logger.warn(str);
	}
}
