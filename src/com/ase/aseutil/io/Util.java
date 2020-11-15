/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.io;

import java.io.*;
import java.sql.Connection;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Programs;
import com.ase.aseutil.ProgramsDB;
import com.ase.aseutil.SysDB;
import com.ase.aseutil.Tables;

public class Util {

	static Logger logger = Logger.getLogger(Util.class.getName());

	/*
	 * doesHtmlExist
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	kix		String
	 * <p>
	 * @return boolean
	 */
	public static boolean doesHtmlExist(Connection conn,String campus,String type,String kix) {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try{

			if(type.equals(Constant.COURSE)){
				type = "outlines";
			}
			else if(type.equals(Constant.PROGRAM)){
				type = "programs";
			}

			String currentDrive = AseUtil.getCurrentDrive();
			String documents = SysDB.getSys(conn,"documents");

			String fileName = currentDrive
										+ ":"
										+ documents
										+ type
										+ "\\"
										+ campus
										+ "\\"
										+ kix
										+ ".html";

			File file = new File(fileName);
			exists = file.exists();
			file = null;

		} catch (Exception e) {
			logger.fatal("Util: doesHtmlExist - " + e.toString());
		}

		return exists;

	}

	/*
	 * getHtmlName
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String getHtmlName(Connection conn,String campus,String type,String kix) {

		//Logger logger = Logger.getLogger("test");

		String htmlName = "";

		try{

			if(doesHtmlExist(conn,campus,type,kix)){

				if(type.equals(Constant.COURSE)){
					type = "outlines";
				}
				else if(type.equals(Constant.PROGRAM)){
					type = "programs";
				}

				String documentsURL = SysDB.getSys(conn,"documentsURL");

				if(!documentsURL.equals(Constant.BLANK)){
					htmlName = documentsURL + type + "/" + campus + "/" + kix + ".html";
				}

			}

		} catch (Exception e) {
			logger.fatal("Util: getHtmlName - " + e.toString());
		}

		return htmlName;

	}

	/*
	 * getHtmlNameIfExists
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getHtmlNameIfExists(Connection conn,String campus,String type,String kix,String alpha,String num) {

		//Logger logger = Logger.getLogger("test");

		String htmlName = "";

		try{

			if(!doesHtmlExist(conn,campus,Constant.COURSE,kix)){

				if(type.equals(Constant.COURSE)){
					Tables.createOutlines(campus,kix,alpha,num);
				}
				else if(type.equals(Constant.PROGRAM)){

					String divisionName = "";
					String program = "";

					Programs prg = ProgramsDB.getProgram(conn,campus,kix);
					if (prg != null){
						program = prg.getProgram();
						divisionName = prg.getDivisionName();
					}

					Tables.createPrograms(campus,kix,program,divisionName);
				}

			} // create html

			if(type.equals(Constant.COURSE)){
				type = "outlines";
			}
			else if(type.equals(Constant.PROGRAM)){
				type = "programs";
			}

			String documentsURL = SysDB.getSys(conn,"documentsURL");

			if(!documentsURL.equals(Constant.BLANK)){
				htmlName = documentsURL + type + "/" + campus + "/" + kix + ".html";
			}

		} catch (Exception e) {
			logger.fatal("Util: getHtmlNameIfExists - " + e.toString());
		}

		return htmlName;

	}

}