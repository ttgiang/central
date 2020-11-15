/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.log4j.Logger;

public class Import {

	static Logger logger = Logger.getLogger(Import.class.getName());

	/*
	 * importData
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	xList
	 * <p>
	 * @return String
	 */
	public static String importData(Connection conn,String campus,String user,String key,String importType) {

		//Logger logger = Logger.getLogger("test");

		String temp = "";

		int rowsAffected = 0;

		String kix = null;
		String progress = null;

		// for log file
		FileWriter fstream = null;
		BufferedWriter output = null;

		try {
			// where to find the file
			String currentDrive = AseUtil.getCurrentDrive() + ":";
			String documents = SysDB.getSys(conn,"documents");
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			// actual file name
			String fileName = user + "-" + importType + "-" + key + ".csv";
			String logFile = user + "-" + importType + "-" + key + ".log";
			String logFileURL = user + "-" + importType + "-" + key + ".log";

			// file variables
			File aFile = null;
			BufferedReader input = null;

			// for data processing
			String line = null;
			String[] aLine = null;

			// stats
			int recordsRead = 0;
			int recordsProcessed = 0;

			String type = "CUR";

			// number of columns
int numberOfColumns = 4;

			try {
				logger.info("Import - importData: " + fileName);

					// import file
				fileName = currentDrive + documents + "temp\\" + fileName;

				// link to log file
				logFileURL = documentsURL + "/temp/" + logFile;

				// log file
				logFile = currentDrive + documents + "temp\\" + logFile;

				// open file for processing
				aFile = new File(fileName);

				if (aFile.exists()){

					// create file to write progress
					fstream = new FileWriter(logFile);

					if (fstream != null){
						output = new BufferedWriter(fstream);

						output.write("User name: " + user + Html.BR() + "\n");
						output.write("Campus: " + campus + Html.BR() + "\n");
						output.write("Import Type: " + importType + Html.BR() + "\n\n");

						output.write(Html.BR() + importType + ": processing started..." + "\n\n");
					}

					// read in input file
					input = new BufferedReader(new FileReader(aFile));

					if (input != null){

						/*
						 * readLine is a bit quirky : it returns the content of a line
						 * MINUS the newline. it returns null only for the END of the
						 * stream. it returns an empty String if two newlines appear in
						 * a row.
						 */

						while ((line = input.readLine()) != null) {

							++recordsRead;

							// read 1 line at a time
							if (line != null && line.length() > 0){

								line = line.replace("NULL"," ");
								aLine = line.split(",");

								// must have correct number of columns read in
								if (aLine.length == numberOfColumns){

									try{

										String reqType = "1"; // 1 for pre req; 2 for co-req

										kix = Helper.getKix(conn,campus,aLine[0],aLine[1],type);

										if (kix != null && kix.length() > 0){

											if (importType.equals("prereq") || importType.equals("prereq")){

												if (importType.equals("prereq"))
													reqType = "1";
												else
													reqType = "2";

												rowsAffected = RequisiteDB.addRemoveRequisites(conn,
																												kix,
																												"a",
																												campus,
																												aLine[0],
																												aLine[1],
																												aLine[2],
																												aLine[3],
																												"",
																												reqType,
																												user,
																												0,
																												false);

											} // pre/co req
											else if (importType.equals("xlist")){

												if (!XRefDB.isMatch(conn,campus,aLine[0],aLine[1],type,aLine[2],aLine[3])){

													rowsAffected = XRefDB.addRemoveXlist(conn,
																										kix,
																										"a",
																										campus,
																										aLine[0],
																										aLine[1],
																										aLine[2],
																										aLine[3],
																										user,
																										0);

												} // xlist

											} // importType

											if (output != null){

												if (rowsAffected == 1)
													progress = "SUCCESS";
												else
													progress = "FAILED";

												output.write(importType + ": " + aLine[0] + " - " + aLine[1] + " - " + progress + Html.BR() + "\n");

												++recordsProcessed;
											}

										} // kix
										else{
											if (output != null)
												output.write(importType + ": course outline does not exist (" + aLine[0] + " - " + aLine[1] + ")" + Html.BR() + "\n");
										} // kix

									}
									catch(ArrayIndexOutOfBoundsException a){
										if (output != null)
											output.write(importType + ": ArrayIndexOutOfBoundsException\n" + a.toString() + Html.BR() + "\n");
									}
									catch(Exception a){
										if (output != null)
											output.write(importType + ": Exception\n" + a.toString() + Html.BR() + "\n");
									}
								} // if aLine
								else{
									if (output != null)
										output.write(importType + ": number of column do not match. Expected: " + numberOfColumns + "; Found: " + aLine.length + Html.BR() + "\n");
								} // if aLine

							}	// if line
							else{
								if (output != null)
									output.write(importType + ": empty line was encounterd" + Html.BR() + "\n");
							} // if line

						}	// while

						temp = "<p align=\"left\">"
								+ "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ "<tr><td>"
								+ "<b>Import type</b><br/>"
								+ "<ul>" + importType + "</ul><br/>"
								+ "<b>Records read</b><br/>"
								+ "<ul>" + recordsRead + "</ul><br/>"
								+ "<b>Records processed</b><br/>"
								+ "<ul>" +  recordsProcessed + "</ul><br/>"
								+ "<br>view <a href=\""+logFileURL+"\" target=\"_blank\" class=\"linkcolumn\">log</a> file<br/>"
								+ "</td></tr>"
								+ "</table>"
								+ "</p>";

						AseUtil.logAction(conn,user,"ACTION","Data upload (filename: " + key
									+ "; import type: " + importType
									+ "; read: " + recordsRead
									+ "; processed: " + recordsProcessed + ")","","",campus,"");
					}
				} // file exists

			} finally {
				input.close();
				input = null;

				if (output != null){
					output.write(Html.BR() + "\n" + importType + ": processing completed..." + Html.BR() + "\n\n");
					output.write(Html.BR() + "\nRecords read: " + recordsRead + Html.BR() +  "\n\n");
					output.write(Html.BR() + "\nRecords processed: " + recordsProcessed + Html.BR() +  "\n\n");
					output.close();
					output = null;
				}

				fstream = null;
			}
		} catch (IOException e) {
			logger.fatal("Import IOException: importData - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Import Exception: importData - " + e.toString());
		}

		return temp;
	} // importData

	/*
	 * requisites
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	requisites
	 * <p>
	 * @return String
	 */
	public static String requisites(Connection conn,String campus,String user,int requisites,String key) {

		//Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String effectiveTerm = "";
		String inAlpha = "";
		String inNum = "";
		String temp = "";
		String uploadType = "";
		String fileName = "";

		try {

			logger.info("Import - requisites : START" );

			String currentDrive = AseUtil.getCurrentDrive();

			if (requisites == Constant.REQUISITES_PREREQ){
				uploadType = "PreReq";
			}
			else{
				uploadType = "CoReq";
			}

			fileName = user + "-"+uploadType+"-" + key + ".csv";

			logger.info("Import - requisites - filename : " + fileName);

			File aFile = null;
			BufferedReader input = null;
			String line = null;
			String[] aLine = null;
			boolean outlineExist = false;

			String kix = null;
			String type = "CUR";
			String reqType = "1";
			String action = "a";

			String grading = "";
			int reqID = 0;

			StringBuffer identical = new StringBuffer();
			StringBuffer fileFormat = new StringBuffer();
			StringBuffer outLineDoesNotExist = new StringBuffer();
			StringBuffer processed = new StringBuffer();
			StringBuffer alreadyExist = new StringBuffer();

			boolean process = false;

			try {

				fileName = currentDrive + ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\" + fileName;

				aFile = new File(fileName);

				input = new BufferedReader(new FileReader(aFile));

				logger.info("Import - requisites - file opened");

				if (input != null){
					/*
					 * readLine is a bit quirky : it returns the content of a line
					 * MINUS the newline. it returns null only for the END of the
					 * stream. it returns an empty String if two newlines appear in
					 * a row.
					 */

					while ((line = input.readLine()) != null) {
						if (line != null && line.length() > 0){

							line = line.replace("NULL"," ");
							line = line.replace("null"," ");
							aLine = line.split(",");

							process = false;
							action = "a";

							if (aLine.length >= 4){

								logger.info("Import - requisites ----------------");

								try{
									alpha = aLine[0];
									num = aLine[1];

									if (aLine.length == 5)
										effectiveTerm = aLine[2];

									inAlpha = aLine[3];
									inNum = aLine[4];

									process = true;
								}
								catch(ArrayIndexOutOfBoundsException a){
									process = false;
								}

								if (process){

									outlineExist = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,type);

									if (outlineExist){

										logger.info("Import - requisites - outlineExist: " + outlineExist);

										if (alpha.equals(inAlpha) && num.equals(inNum)){
											identical.append("<li>" + line + "</li>");
											logger.info("Import - requisites - identical");
										}
										else{
											if (inAlpha.equals(Constant.SPACE)){
												action = "r";
											} // action

											logger.info("Import - requisites - action: " + action);

											// is the req already there?
											if (!RequisiteDB.isMatch(conn,requisites,campus,alpha,num,type,inAlpha,inNum)){

												kix = Helper.getKix(conn,campus,alpha,num,type);

												logger.info("Import - requisites - kix: " + kix);

												int rowsAffected = RequisiteDB.addRemoveRequisites(conn,
																													kix,
																													action,
																													campus,
																													alpha,
																													num,
																													inAlpha,
																													inNum,
																													grading,
																													reqType,
																													user,
																													reqID,
																													false);

												logger.info("Import - requisites - rowsAffected: " + rowsAffected);

												String sql = "UPDATE tblCourse SET "
																+ Constant.COURSE_EFFECTIVETERM + "=? "
																+ "WHERE campus=? "
																+ "AND coursealpha=? "
																+ "AND coursenum=? "
																+ "AND coursetype='CUR'";
												PreparedStatement ps = conn.prepareStatement(sql);
												ps.setString(1,effectiveTerm);
												ps.setString(2,campus);
												ps.setString(3,alpha);
												ps.setString(4,num);
												rowsAffected = ps.executeUpdate();
												ps.close();

												logger.info("Import - requisites - effectiveTerm: " + alpha + " - " + num + " - " + effectiveTerm);

												processed.append("<li>" + line + "</li>");
											}
											else{
												alreadyExist.append("<li>" + line + "</li>");
												logger.info("Import - requisites - alreadyExist: " + line);
											} // req exist?
										} // identical
									}
									else{
										outLineDoesNotExist.append("<li>" + line + "</li>");
										logger.info("Import - requisites - outLineDoesNotExist: " + line);
									}	// outLineDoesNotExist
								}
								else{
									fileFormat.append("<li>" + line + "</li>");
									logger.info("Import - requisites - data error: " + line);
								} // if process
							}
							else{
								fileFormat.append("<li>" + line + "</li>");
								logger.info("Import - requisites - fileFormat: " + line);
							}	// if aLine
						}	// if line

						alpha = "";
						num = "";
						inAlpha = "";
						inNum = "";

					}	// while

					temp = "<p align=\"left\">"
							+ "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ "<tr><td>"
							+ "<b>Outlines Processed</b><br/>"
							+ "<ul>" + processed.toString() + "</ul><br/>"
							+ "<b>Outlines Not Found</b><br/>"
							+ "<ul>" +  outLineDoesNotExist.toString() + "</ul><br/>"
							+ "<b>Entry Exists</b><br/>"
							+ "<ul>" +  alreadyExist.toString() + "</ul><br/>"
							+ "<b>Outlines & Upload Entries are Identical</b><br/>"
							+ "<ul>" +  identical.toString() + "</ul><br/>"
							+ "<b>Invalid Format</b><br/>"
							+ "<ul>" +  fileFormat.toString() + "</ul>"
							+ "</td></tr>"
							+ "</table>"
							+ "</p>";

					AseUtil.logAction(conn,user,"ACTION","Data upload (" + key + ")",uploadType,"",campus,"");
				}
			} finally {
				input.close();
			}

			logger.info("Import - requisites : END" );

		} catch (IOException ex) {
			logger.fatal("Import IOException: requisites - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Import Exception: requisites - " + e.toString());
		}

		return temp;
	}

	/*
	 * xList
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	xList
	 * <p>
	 * @return String
	 */
	public static String crossListed(Connection conn,String campus,String user,String key) {

		//Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String inAlpha = "";
		String inNum = "";
		String temp = "";
		String uploadType = "";

		try {
			String currentDrive = AseUtil.getCurrentDrive();
			String fileName = user + "-XList-" + key + ".csv";
			File aFile = null;
			BufferedReader input = null;
			String line = null;
			String[] aLine = null;
			boolean outlineExist = false;

			String kix = null;
			String type = "CUR";
			String grading = "";
			int reqID = 0;

			String effectiveTerm = "";

			StringBuffer identical = new StringBuffer();
			StringBuffer fileFormat = new StringBuffer();
			StringBuffer outLineDoesNotExist = new StringBuffer();
			StringBuffer processed = new StringBuffer();
			StringBuffer alreadyExist = new StringBuffer();

			boolean process = false;

			try {

				logger.info("Import - crossListed : " + fileName);

				aFile = new File(currentDrive + ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\" + fileName);

				input = new BufferedReader(new FileReader(aFile));

				if (input != null){
					/*
					 * readLine is a bit quirky : it returns the content of a line
					 * MINUS the newline. it returns null only for the END of the
					 * stream. it returns an empty String if two newlines appear in
					 * a row.
					 */

					while ((line = input.readLine()) != null) {
						if (line != null && line.length() > 0){
							line = line.replace("NULL"," ");
							aLine = line.split(",");

							if (aLine.length >= 4){

								try{
									alpha = aLine[0];
									num = aLine[1];

									if (aLine.length == 5)
										effectiveTerm = aLine[2];

									inAlpha = aLine[3];
									inNum = aLine[4];

									process = true;
								}
								catch(ArrayIndexOutOfBoundsException a){
									process = false;
								}

								if (process){
									outlineExist = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,type);

									if (outlineExist){
										if (alpha.equals(inAlpha) && num.equals(inNum)){
											identical.append("<li>" + line + "</li>");
										}
										else{
											if (" ".equals(inAlpha) || inAlpha.length() == 1){
												// ignore. not processing since there is NULL from replace statement above
											}
											else{
												// is the xrefalready there?
												if (!XRefDB.isMatch(conn,campus,alpha,num,type,inAlpha,inNum)){
													kix = Helper.getKix(conn,campus,alpha,num,type);

													int rowsAffected = XRefDB.addRemoveXlist(conn,
																										kix,
																										"a",
																										campus,
																										alpha,
																										num,
																										inAlpha,
																										inNum,
																										user,
																										reqID);

													processed.append("<li>" + line + "</li>");
												}
												else{
													alreadyExist.append("<li>" + line + "</li>");
												}
											} // blank inAlpha = NULL
										} // identical
									}
									else{
										outLineDoesNotExist.append("<li>" + line + "</li>");
									}	// outline does not exist
								} // process

							}
							else{
								fileFormat.append("<li>" + line + "</li>");
							}	// if aLine
						}	// if line

						alpha = "";
						num = "";
						inAlpha = "";
						inNum = "";
					}	// while

					temp = "<p align=\"left\">"
							+ "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ "<tr><td>"
							+ "<b>Outlines Processed</b><br/>"
							+ "<ul>" + processed.toString() + "</ul><br/>"
							+ "<b>Outlines Not Found</b><br/>"
							+ "<ul>" +  outLineDoesNotExist.toString() + "</ul><br/>"
							+ "<b>Entry Exists</b><br/>"
							+ "<ul>" +  alreadyExist.toString() + "</ul><br/>"
							+ "<b>Outlines & Upload Entries are Identical</b><br/>"
							+ "<ul>" +  identical.toString() + "</ul><br/>"
							+ "<b>Invalid Format</b><br/>"
							+ "<ul>" +  fileFormat.toString() + "</ul>"
							+ "</td></tr>"
							+ "</table>"
							+ "</p>";

					AseUtil.logAction(conn,user,"ACTION","Data upload (" + key + ")",uploadType,"",campus,"");
				}
			} finally {
				input.close();
			}
		} catch (IOException ex) {
			logger.fatal("Import IOException: XList - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Import Exception: XList - " + e.toString());
		}

		return temp;
	}

}