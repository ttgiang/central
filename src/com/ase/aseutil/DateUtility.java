/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static String addToDate(int numberOfDays)
 *	public static void addToDate2()
 *	public static void compare2Dates()
 *	public static void daysBetween1Dates()
 *	public static void daysInMonth()
 *	public static String formatDateAsString(String date){
 *	public static void getDayofTheDate()
 *	public static String getSystemDate(String format){
 *	public static String getSystemDateSQL(String format){
 *	public static boolean isDate(String date){
 *	public static boolean isTodayInRangeWith(Connection conn,String campus,String iniKey) throws SQLException {
 *	public static boolean isLeapYear(int year)
 *	public static void subToDate()
 *	public static void validateAGivenDate()
 *
 * @author ttgiang
 */

//
// DateUtility.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

public class DateUtility {

	static Logger logger = Logger.getLogger(IniDB.class.getName());

	/*
	 *	stringToDate
	 * <p>
	 *	@param	String
	 * <p>
	 *	@return
	*/
	public static java.util.Date stringToDate(String dateStr) {

		Calendar calendar = null;
		java.util.Date date = null;

		try{
			if (dateStr != null){
				String strDate = dateStr;

				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

				date = (java.util.Date)formatter.parse(strDate);

				//calendar = Calendar.getInstance();

				//calendar.setTime(date);
			}
		}
		catch(Exception e){
			//
		}

		//return calendar.getTime();

		return date;
	}

	/*
	 *	addToDate
	 * <p>
	 *	@param	numberOfDays	int
	 * <p>
	 *	@return	String
	*/
	public static String addToDate(int numberOfDays) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, numberOfDays);
		String DATE_FORMAT = Constant.CC_DATE_FORMAT;
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		return sdf.format(cal.getTime());

		// Substract 30 days from the calendar
		// cal.add(Calendar.DATE, -30);
		// System.out.println("30 days ago: " + cal.getTime());

		// Add 10 months to the calendar
		// cal.add(Calendar.MONTH, 10);
		// System.out.println("10 months later: " + cal.getTime());

		// Substract 1 year from the calendar
		// cal.add(Calendar.YEAR, -1);
		// System.out.println("1 year ago: " + cal.getTime());
	}

	/*
	 * Add Day/Month/Year to a Date add() is used to add values to a Calendar
	 * object. You specify which Calendar field is to be affected by the
	 * operation (Calendar.YEAR, Calendar.MONTH, Calendar.DATE).
	 */
	public static void addToDate2() {
		System.out.println("In the ADD Operation");
		String DATE_FORMAT = "dd-MM-yyyy"; // Refer Java DOCS for formats
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		Calendar c1 = Calendar.getInstance();
		Date d1 = new Date();
		System.out.println("Todays date in Calendar Format : " + c1);
		System.out.println("c1.getTime() : " + c1.getTime());
		System.out.println("c1.get(Calendar.YEAR): " + c1.get(Calendar.YEAR));
		System.out.println("Todays date in Date Format : " + d1);
		c1.set(2007, 10, 20); // (year,month,date)
		System.out.println("c1.set(2007,10,20) : " + c1.getTime());
		c1.add(Calendar.DATE, 40);
		System.out.println("Date + 20 days is : " + sdf.format(c1.getTime()));
		System.out.println();
		System.out.println();
	}

	/*
	 * Substract Day/Month/Year to a Date roll() is used to substract values to
	 * a Calendar object. You specify which Calendar field is to be affected by
	 * the operation (Calendar.YEAR, Calendar.MONTH, Calendar.DATE).
	 *
	 * Note: To substract, simply use a negative argument. roll() does the same
	 * thing except you specify if you want to roll up (add 1) or roll down
	 * (substract 1) to the specified Calendar field. The operation only affects
	 * the specified field while add() adjusts other Calendar fields. See the
	 * following example, roll() makes january rolls to december in the same
	 * year while add() substract the YEAR field for the correct result
	 *
	 */
	public static void subToDate() {
		System.out.println("In the SUB Operation");
		String DATE_FORMAT = "dd-MM-yyyy";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		Calendar c1 = Calendar.getInstance();
		c1.set(1999, 0, 20);
		System.out.println("Date is : " + sdf.format(c1.getTime()));

		// roll down, substract 1 month
		c1.roll(Calendar.MONTH, false);
		System.out.println("Date roll down 1 month : "
				+ sdf.format(c1.getTime()));

		c1.set(1999, 0, 20);
		System.out.println("Date is : " + sdf.format(c1.getTime()));
		c1.add(Calendar.MONTH, -1);
		// substract 1 month
		System.out.println("Date minus 1 month : " + sdf.format(c1.getTime()));
		System.out.println();
		System.out.println();
	}

	public static void daysBetween1Dates() {
		Calendar c1 = Calendar.getInstance(); // new GregorianCalendar();
		Calendar c2 = Calendar.getInstance(); // new GregorianCalendar();
		c1.set(1999, 0, 20);
		c2.set(1999, 0, 22);
		System.out.println("Days Between " + c1.getTime() + "\t" + c2.getTime()
				+ " is");
		System.out.println((c2.getTime().getTime() - c1.getTime().getTime())
				/ (24 * 3600 * 1000));
		System.out.println();
		System.out.println();
	}

	public static void daysInMonth() {
		Calendar c1 = Calendar.getInstance(); // new GregorianCalendar();
		c1.set(1999, 6, 20);
		int year = c1.get(Calendar.YEAR);
		int month = c1.get(Calendar.MONTH);
		int[] daysInMonths = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		daysInMonths[1] += DateUtility.isLeapYear(year) ? 1 : 0;
		System.out.println("Days in " + month + "th month for year " + year
				+ " is " + daysInMonths[c1.get(Calendar.MONTH)]);
		System.out.println();
		System.out.println();
	}

	public static void getDayofTheDate() {
		Date d1 = new Date();
		String day = null;
		DateFormat f = new SimpleDateFormat("EEEE");
		try {
			day = f.format(d1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("The dat for " + d1 + " is " + day);
		System.out.println();
		System.out.println();
	}

	public static void validateAGivenDate() {
		String dt = "20011223";
		String invalidDt = "20031315";
		String dateformat = "yyyyMMdd";
		Date dt1 = null, dt2 = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(dateformat);
			sdf.setLenient(false);
			dt1 = sdf.parse(dt);
			dt2 = sdf.parse(invalidDt);
			System.out.println("Date is ok = " + dt1 + "(" + dt + ")");
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		} catch (IllegalArgumentException e) {
			System.out.println("Invalid date");
		}
		System.out.println();
		System.out.println();
	}

	public static void compare2Dates() {

		SimpleDateFormat fm = new SimpleDateFormat("dd-MM-yyyy");
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();

		c1.set(2000, 02, 15);
		c2.set(2001, 02, 15);

		System.out.print(fm.format(c1.getTime()) + " is ");
		if (c1.before(c2)) {
			System.out.println("less than " + c2.getTime());
		} else if (c1.after(c2)) {
			System.out.println("greater than " + c2.getTime());
		} else if (c1.equals(c2)) {
			System.out.println("is equal to " + fm.format(c2.getTime()));
		}
		System.out.println();
		System.out.println();
	}

	public static boolean isLeapYear(int year) {
		if ((year % 100 != 0) || (year % 400 == 0)) {
			return true;
		}
		return false;
	}

	/*
	 * calculateReviewDate
	 *	<p>
	 *	@param conn				Connection
	 *	@param campus			String
	 *	@param num				String
	 *	@param effectiveTerm	String
	 *	<p>
	 *	@return String
	 */
	public static String calculateReviewDate(Connection conn,String campus,String num,String effectiveTerm) throws SQLException {

			//Logger logger = Logger.getLogger("test");

			String reviewDate = "";
			String temp = "";
			String term = "";
			String iniSetting = "";
			int space = 0;
			int year = 0;
			int reviewYear = 0;
			int month = 0;

			/*
				effectiveTerm comes in format of 200410 (?)

				1) take the term and find the description (FALL 2004 or SUMMER 2004 Accelerated or Summer II 2004)
				2) with the term description, get the term and year
				3) get the review year for the specific campus
				4) add to year from term
				5) determine the term (FALL/SPRING/SUMMER/WINTER)
					then create review date
			*/

			try{

				if (effectiveTerm != null && effectiveTerm.length() >0){
					effectiveTerm = TermsDB.getTermDescription(conn,effectiveTerm);

					space = effectiveTerm.indexOf(Constant.SPACE);

					if (space > -1){

						// extract the season (FALL, SUMMER, WINTER)
						term = effectiveTerm.substring(0,space).toUpperCase();

						// extract remainder following term above
						effectiveTerm = effectiveTerm.substring(space+1);

						// if we are dealing with roman numerals, trim then pad the start with a space
						// to be used for replace statement below. The need to add the space in front
						// is to avoid search and repalce of 'I' in words like WINTER.
						effectiveTerm = effectiveTerm.trim();
						effectiveTerm = Constant.SPACE + effectiveTerm;

						// replace roman numerals. not necessary. must include space before because
						// that's the separation from term
						effectiveTerm = effectiveTerm.replace(Constant.SPACE + "III",Constant.SPACE);
						effectiveTerm = effectiveTerm.replace(Constant.SPACE + "II",Constant.SPACE);
						effectiveTerm = effectiveTerm.replace(Constant.SPACE + "I",Constant.SPACE);

						effectiveTerm = effectiveTerm.trim();

						// is there another space? if yes, account for that
						space = effectiveTerm.indexOf(Constant.SPACE);
						if (space > -1){
							effectiveTerm = effectiveTerm.substring(0,space);
						}

						effectiveTerm = effectiveTerm.trim();

						//
						// do we have a valid year?
						//
						try{
							year = Integer.parseInt(effectiveTerm);
						}
						catch(Exception e){
							year = 0;
						}

						if(year > 0){

							//
							// make sure we have the right settings
							//
							if (num.indexOf("97") >= 0 || num.indexOf("98") >= 0){
								iniSetting = "ReviewDateForExperimental";
							}
							else{
								iniSetting = "ReviewDate";
							}

							//
							// system setting holding number of years for next review date
							//
							temp = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System",iniSetting);
							if(!temp.equals(Constant.BLANK)){
								try{
									reviewYear = Integer.parseInt(temp);
								}
								catch(Exception e){
									reviewYear = 0;
								}

								if(reviewYear > 0){
									year = year + reviewYear;

									if (term.toLowerCase().indexOf("fall") > -1){
										month = 9;
									}
									else if(term.toLowerCase().indexOf("spring") > -1){
										month = 1;
									}
									else if(term.toLowerCase().indexOf("summer") > -1){
										month = 6;
									}
									else if(term.toLowerCase().indexOf("winterf") > -1){
										month = 12;
									}

									reviewDate = month + "/1/" + year;
								} // valid review year

							} // system setting found

						} // valid year found

					}
				}
			}
			catch(Exception e){
				temp = "campus: " + campus + "; num: " + num + "; term: " + effectiveTerm;
				logger.fatal("DateUtility.calculateReviewDate ("+temp+") " + e.toString());
			}

			return reviewDate;
	}

	/*
	 * isTodayInRangeWith
	 *	<p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param iniKey	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isTodayInRangeWith(Connection conn,String campus,String iniKey) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean todayInRangeWith = false;

		try{
			// include time to make sure we mark all possible date period
			String endTime = " 23:59:59";
			String startTime = " 00:00:00";

			String[] listRange = Util.getINIKeyValues(conn,campus,iniKey);
			if (listRange != null && !"NODATA".equals(listRange[0])){

				if (	listRange[0] != null && listRange[0].length() > 0 &&
						listRange[1] != null && listRange[1].length() > 0){

					// compose date objects
					java.util.Date startDate = new java.util.Date(listRange[0] + startTime);
					java.util.Date endDate = new java.util.Date(listRange[1] + endTime);
					java.util.Date today = new java.util.Date();

					// set up calendar
					Calendar calStart = Calendar.getInstance();
					Calendar calEnd = Calendar.getInstance();
					Calendar calToday = Calendar.getInstance();

					calStart.setTime(startDate);
					calEnd.setTime(endDate);
					calToday.setTime(today);

					if (	(calStart.before(calToday) || calStart.equals(calToday)) &&
							(calEnd.after(calToday) || calEnd.equals(calToday)))
						todayInRangeWith = true;
				}

			}
		}
		catch(Exception ce){
			logger.fatal("DateUtil - isTodayInRangeWith: " + ce.toString());
		}

		return todayInRangeWith;
	}

	/*
	 * isValidDate
	 *	<p>
	 *	@param date
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isValidDate(String date){

		 // set date format, this can be changed to whatever format
		 // you want, MM-dd-yyyy, MM.dd.yyyy, dd.MM.yyyy etc.
		 // you can read more about it here:
		 // http://java.sun.com/j2se/1.4.2/docs/api/index.html

		if(date==null || date.length() == 0)
			return false;

		// break into components so we can formulate as mm/dd/yyyy
		String[] s = date.split("/");

		// must have 3 components
		if (s.length < 3)
			return false;

		if (!NumericUtil.isInteger(s[0]))
			return false;

		if (!NumericUtil.isInteger(s[1]))
			return false;

		if (!NumericUtil.isInteger(s[2]))
			return false;

		// pad with 0 if less than 10 (need to be mm)
		int n0 = Integer.parseInt(s[0]);
		if (s[0].length()==1 && n0 < 10)
			s[0] = "0" + s[0];

		// pad with 0 if less than 10 (need to be dd)
		int n1 = Integer.parseInt(s[1]);
		if (s[1].length()==1 && n1 < 10)
			s[1] = "0" + s[1];

		// reformulate date
		date = s[0] + "/" + s[1] + "/" + s[2];

		SimpleDateFormat sdf = new SimpleDateFormat(Constant.CC_DATE_FORMAT);

		Date testDate = null;

		try{
			testDate = sdf.parse(date);
		}
		catch (ParseException e){
			return false;
		}

		if (!sdf.format(testDate).equals(date))
			return false;

		return true;

	} // end isValidDate

	/*
	 * compare2Dates
	 *	<p>
	 *	@param d1	String
	 *	@param d2	String
	 *	<p>
	 *	@return int
	 */
	public static int compare2Dates(String d1,String d2) {

		int rtn = -99;

		if (isValidDate(d1) && isValidDate(d2)){

			SimpleDateFormat fm = new SimpleDateFormat(Constant.CC_DATE_FORMAT);

			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();

			c1.setTime(stringToDate(d1));
			c2.setTime(stringToDate(d2));

			if (c1.before(c2))
				rtn = -1;
			else if (c1.after(c2))
				rtn = 1;
			else if (c1.equals(c2))
				rtn = 0;

		}

		return rtn;
	}

	/*
	public static boolean isDate(CharSequence date) {

		// some regular expression
		 // with a space before, zero or one time
		String time = "(\\s(([01]?\\d)|(2[0123]))[:](([012345]\\d)|(60))"
						+ "[:](([012345]\\d)|(60)))?";

		// no check for leap years (Schaltjahr)
		// and 31.02.2006 will also be correct
		String day = "(([12]\\d)|(3[01])|(0?[1-9]))"; 	// 01 up to 31
		String month = "((1[012])|(0\\d))"; 				// 01 up to 12
		String year = "\\d{4}";

		// define here all date format
		ArrayList patterns = new ArrayList();
		patterns.add(Pattern.compile(day + "[-.]" + month + "[-.]" + year + time));
		patterns.add(Pattern.compile(year + "-" + month + "-" + day + time));
		// here you can add more date formats if you want

		// check dates
		for (Pattern p : patterns){
			if (p.matcher(date).matches())
				return true;
		}

		return false;
	}

	*/

	/*
	 * isDate
	 *	<p>
	 *	@param date
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isDate(String date){

		//Logger logger = Logger.getLogger("test");

		boolean rtn = false;

		if (date != null){

			String format = "";

			// remove the space between date and time if one exist
			if (date.indexOf(" ") > 0)
				date = date.substring(0,date.indexOf(" "));

			if (date.indexOf("/") > 0)
				format = "MM/dd/yyyy";
			else
				format = "yyyy-MM-dd";

			java.util.Date testDate = null;

			// set up the format
			SimpleDateFormat sdf = new SimpleDateFormat(format);

			// attempt a parse
			try {
				testDate = sdf.parse(date);
				rtn = true;
			}
			catch (java.text.ParseException e){
				rtn = false;
			}

			// if parse successful, check if date is same
			try{
				if (testDate != null){
					if (!sdf.format(testDate).equals(date))
						rtn = false;
				}
			}
			catch(Exception e){
				rtn = false;
			}

		}

		return rtn;

	} // isDate

	/*
	 * formatDateAsString
	 *	<p>
	 *	@param date
	 *	<p>
	 *	@return String
	 */
	public static String formatDateAsString(String date){

		//Logger logger = Logger.getLogger("test");

		String str = "";

		if (date != null){

			String format = "";

			// remove the space between date and time if one exist
			if (date.indexOf(" ") > 0)
				date = date.substring(0,date.indexOf(" "));

			if (date.indexOf("/") > 0)
				format = "MM/dd/yyyy";
			else
				format = "yyyy-MM-dd";

			java.util.Date testDate = null;

			// set up the format from string to date
			SimpleDateFormat sdf = new SimpleDateFormat(format);

			// attempt a parse. if successful, convert to format for CC use
			try {
				testDate = sdf.parse(date);
				str = (new SimpleDateFormat("MM/d/yyyy")).format(testDate);
			}
			catch (java.text.ParseException e){
				logger.fatal("DateUtility - formatDateAsString: " + e.toString());
			}
			catch (Exception e){
				logger.fatal("DateUtility - formatDateAsString: " + e.toString());
			}
		}

		return str;

	} // formatDateAsString

	/*
	 * getSystemDate
	 *	<p>
	 *	@return String
	 */
	public static String getSystemDate(String format){

		//Logger logger = Logger.getLogger("test");

		String systemDate = "";

		try {
			systemDate = (new SimpleDateFormat(format)).format(new java.util.Date());
		}
		catch (Exception e){
			logger.fatal("DateUtility - getSystemDate: " + e.toString());
		}

		return systemDate;

	} // formatDateAsString

	/*
	 * getSystemDateSQL
	 *	<p>
	 *	@return String
	 */
	public static String getSystemDateSQL(String format){

		return "CONVERT(DATETIME, '" + getSystemDate(format) + " 00:00:00', 102)";

	} // formatDateAsString

	/**
	 * addDays
	 * <p>
	 * @return	String
	*/
   public static String addDays(java.util.Date day, int days) throws Exception {

		try{
			String DATE_FORMAT = Constant.CC_DATE_FORMAT;

			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat(DATE_FORMAT);

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(day);
			calendar.add(Calendar.DATE,days);

			return sdf.format(calendar.getTime());
		}
		catch(Exception e){
			logger.fatal("DateUtility - addDays: " + e.toString());
		}

		return "";
	}

	/**
	 * daysBetween2Dates
	 * <p>
	 * @return	long
	*/
   public static long daysBetween2Dates(java.util.Date day1, java.util.Date day2) throws Exception {

		//Logger logger = Logger.getLogger("test");

		long diffDays = 0;

		try{
			// Creates two calendars instances
			Calendar cal1 = Calendar.getInstance();
			Calendar cal2 = Calendar.getInstance();

			// Set the date for both of the calendar instance
			cal1.setTime(day1);
			cal2.setTime(day2);

			// Get the represented date in milliseconds
			long milis1 = cal1.getTimeInMillis();
			long milis2 = cal2.getTimeInMillis();

			// Calculate difference in milliseconds
			long diff = milis2 - milis1;

			// Calculate difference in days
			diffDays = diff / (24 * 60 * 60 * 1000);
		}
		catch(Exception e){
			logger.fatal("DateUtility - daysBetween2Dates: " + e.toString());
		}

		return diffDays;
	}


}