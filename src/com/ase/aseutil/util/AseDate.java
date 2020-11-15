/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int deleteFromAllTables(Connection conn,String user,String campus,String alpha,String num,String type)
 *
 */

package com.ase.aseutil.util;

import java.util.Calendar;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;

public class AseDate {

	static Logger logger = Logger.getLogger(AseDate.class.getName());

	/**
	*	getCurrentYear - returns current year
	*
	**/
	public static String getCurrentYear(){

		GregorianCalendar now = new GregorianCalendar();

		int yy = now.get(Calendar.YEAR);

		String syy = "" + yy;

		if (yy < 10) syy = "0" + yy;

		return syy;

	}

}
