/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 */

package com.ase.aseutil;

public class Upload {

	/**
	 * returns white list for file uploads
	 * <p>
	 *
	 * @return String
	 */
	public static String getWhiteList() {

		return ".csv,.doc,.mpg,.pdf,.xls,.docx,.xlsx";
	}

	/**
	 * returns black list for file uploads
	 * <p>
	 *
	 * @return String
	 */
	public static String getBlackList() {

		return ".bat,.com,.exe,.vbs";
	}

	/**
	 * returns upload file size limit
	 * <p>
	 *
	 * @return int
	 */
	public static int getUploadSizeThreshold() {

		String temp = "10000000";

		return Integer.valueOf(temp);
	}

}