/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *
 * @author ttgiang
 */

//
// DateTime.java
//
package com.ase.aseutil.datetime;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.NumericUtil;

import org.apache.log4j.Logger;

public class DateTime {

	static Logger logger = Logger.getLogger(DateTime.class.getName());

	// day
	static int mm = 0;
	static int dd = 0;
	static int yy = 0;

	// time
	static int hh = 0;
	static int mn = 0;
	static int ss = 0;

	// day
	static String s_mm = "";
	static String s_dd = "";
	static String s_yy = "";

	// time
	static String s_hh = "";
	static String s_mn = "";
	static String s_ss = "";

	static String ampm = "";

	public DateTime() {

		String now = AseUtil.getCurrentDateTimeString();

		if(now != null){

			//
			// now is in format of "mm/dd/yyyy hh:mm:ss ampm"
			// when split by space, we have 3 tokens
			//
			// date and time also come with 3 tokens.
			// date split by /
			// time split by :
			//
			String[] aNow = now.split(" ");

			if(aNow.length == 3){

				if(aNow[0] != null){
					String[] aDate = aNow[0].split("/");
					if(aDate.length == 3){

						s_mm = aDate[0];
						s_dd = aDate[1];
						s_yy = aDate[2];

						mm = NumericUtil.getInt(aDate[0],0);
						dd = NumericUtil.getInt(aDate[1],0);
						yy = NumericUtil.getInt(aDate[2],0);
					}
				}

				if(aNow[1] != null){
					String[] aTime = aNow[1].split(":");
					if(aTime.length == 3){

						s_hh = aTime[0];
						s_mn = aTime[1];
						s_ss = aTime[2];

						hh = NumericUtil.getInt(aTime[0],0);
						mn = NumericUtil.getInt(aTime[1],0);
						ss = NumericUtil.getInt(aTime[2],0);
					}
				}

				ampm = aNow[2];

			} // there are 3 tokens to work with

		} // now


	}

	/**
	*	getCurrentDate
	*
	**/
	public String getCurrentDate(){

		return s_mm+"/"+s_dd+"/"+s_yy;

	}

	/**
	*	getCurrentTime
	*
	**/
	public String getCurrentTime(){

		return s_hh+":"+s_mn+":"+s_ss+" "+ampm;

	}

	/**
	*	getCurrentDateTime
	*
	**/
	public String getCurrentDateTime(){

		return s_mm+"/"+s_dd+"/"+s_yy+" "+s_hh+":"+s_mn+":"+s_ss+" "+ampm;

	}

	/**
	*	getDay
	*
	**/
	public int getDay(){

		return dd;

	}

	public String getDayString(){

		return s_dd;

	}

	/**
	*	getMonth
	*
	**/
	public int getMonth(){

		return mm;

	}

	public String getMonthString(){

		return s_mm;

	}

	/**
	*	getYear
	*
	**/
	public int getYear(){

		return yy;

	}

	public String getYearString(){

		return s_yy;

	}

	/**
	*	getHour
	*
	**/
	public int getHour(){

		return hh;

	}

	public int getHour12(){

		return hh;

	}

	public int getHour24(){

		int hours24 = hh;

		if(getAmPm().toLowerCase().equals("pm")){
			hours24 = hours24 + 12;
		}

		return hours24;

	}

	public String getHourString(){

		return s_hh;

	}

	/**
	*	getMinutes
	*
	**/
	public int getMinutes(){

		return mn;

	}

	public String getMinutesString(){

		return s_mn;

	}

	/**
	*	getSeconds
	*
	**/
	public int getSeconds(){

		return ss;

	}

	public String getSecondsString(){

		return s_ss;

	}

	/**
	*	getAmPm
	*
	**/
	public String getAmPm(){

		return ampm;

	}

	/**
	*	close - returns current year
	*
	**/
	public void close() {}

}