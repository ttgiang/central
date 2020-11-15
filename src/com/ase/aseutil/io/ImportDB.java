/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.io;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import javax.servlet.http.*;

import java.sql.*;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

public class ImportDB {

	static Logger logger = Logger.getLogger(Import.class.getName());

	/**
	 * getImport
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Import
	 */
	public static Import getImport(Connection conn,int id) {

		Import imprt = null;
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tblImport WHERE id=?");
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				imprt = new Import();
				imprt.setId(id);
				imprt.setImportType(AseUtil.nullToBlank(rs.getString("importtype")));
				imprt.setApplication(AseUtil.nullToBlank(rs.getString("application")));
				imprt.setApplicationType(AseUtil.nullToBlank(rs.getString("applicationtype")));
				imprt.setFrequency(rs.getString("frequency"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ImportDB: getImport\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("ImportDB: getImport\n" + ex.toString());
		}

		return imprt;
	}

	/**
	 * getImport
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Import
	 */
	public static Import getImport(int id) {

		Import imprt = new Import();

		switch(id){

			case ImportConstant.IMPORT_COREQ:
				imprt.setId(ImportConstant.IMPORT_COREQ);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""+ImportConstant.IMPORT_COURSE_OUTLINE+"");
				imprt.setApplicationType("Add");
				imprt.setFrequency("Immediately");
				break;

			case ImportConstant.IMPORT_XLIST:
				imprt.setId(ImportConstant.IMPORT_XLIST);
				imprt.setImportType(ImportConstant.IMPORT_XLIST_DATA);
				imprt.setApplication(""+ImportConstant.IMPORT_COURSE_OUTLINE+"");
				imprt.setApplicationType("Add");
				imprt.setFrequency("Immediately");
				break;

			case ImportConstant.IMPORT_GESLO:
				imprt.setId(ImportConstant.IMPORT_GESLO);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""
											+ImportConstant.IMPORT_COURSE_OUTLINE
						+","+ImportConstant.IMPORT_COURSE_ALPHA);

//						+","+ImportConstant.IMPORT_DIV_DEPT
//						+","+ImportConstant.IMPORT_PROGRAM
//						+","+ImportConstant.IMPORT_DEGREE);
				imprt.setApplicationType("Add,Delete");
				imprt.setFrequency("Immediately,On Create");
				break;

			case ImportConstant.IMPORT_ILO:
				imprt.setId(ImportConstant.IMPORT_ILO);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""
						+ImportConstant.IMPORT_COURSE_OUTLINE
						+","+ImportConstant.IMPORT_COURSE_ALPHA);

//						+","+ImportConstant.IMPORT_DIV_DEPT
//						+","+ImportConstant.IMPORT_PROGRAM
//						+","+ImportConstant.IMPORT_DEGREE);
				imprt.setApplicationType("Add,Delete");
				imprt.setFrequency("Immediately,On Create");
				break;

			case ImportConstant.IMPORT_PREREQ:
				imprt.setId(ImportConstant.IMPORT_PREREQ);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""+ImportConstant.IMPORT_COURSE_OUTLINE+"");
				imprt.setApplicationType("Add");
				imprt.setFrequency("Immediately");
				break;

			case ImportConstant.IMPORT_PLO:
				imprt.setId(ImportConstant.IMPORT_PLO);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""
						+ImportConstant.IMPORT_COURSE_OUTLINE
						+","+ImportConstant.IMPORT_COURSE_ALPHA);

//						+","+ImportConstant.IMPORT_DIV_DEPT
//						+","+ImportConstant.IMPORT_PROGRAM
//						+","+ImportConstant.IMPORT_DEGREE);
				imprt.setApplicationType("Add,Delete");
				imprt.setFrequency("Immediately,On Create");
				break;

			case ImportConstant.IMPORT_SLO:
				imprt.setId(ImportConstant.IMPORT_SLO);
				imprt.setImportType(ImportConstant.IMPORT_COREQ_DATA);
				imprt.setApplication(""
						+ImportConstant.IMPORT_COURSE_OUTLINE
						+","+ImportConstant.IMPORT_COURSE_ALPHA);

//						+","+ImportConstant.IMPORT_DIV_DEPT
//						+","+ImportConstant.IMPORT_PROGRAM
//						+","+ImportConstant.IMPORT_DEGREE);
				imprt.setApplicationType("Add,Delete");
				imprt.setFrequency("Immediately,On Create");
				break;

		}


		return imprt;
	}

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
											if (inAlpha.equals(Constant.SPACE) || inAlpha.length() == 1){
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

	/*
	 * getInputData - translate input data and save to session. this is the data entered to indicate
	 *						where the imported list should be applied to
	 *	<p>
	 * @param	session HttpSession
	 *	<p>
	 * @return String[]
	 */
	public static String[] getInputData(HttpSession session){

		String[] inputData = new String[2];

		inputData[0] = "";
		inputData[1] = "";

		String alpha = "";
		String num = "";
		String itm = "";
		String kix = "";
		String importType = "";
		String listType = null;
		String fileName = null;	// default as null is important

		String application = null;
		String applicationType = null;
		String frequency = null;

		String alphaOnly = null;
		String program = null;
		String degree = null;

		int division = 0;
		String divisionCode = "";

		com.ase.aseutil.io.ImportMap im = new com.ase.aseutil.io.ImportMap(session);
		if (im != null){
			fileName = im.getFilename();
			importType = im.getImportType();
			application = im.getApplication();
			applicationType = im.getApplicationType();
			frequency = im.getFrequency();

			alpha = im.getAlphaID();
			num = im.getNumberID();
			alphaOnly = im.getAlphaOnlyID();

			division = im.getDepartmentIDAsInt();

			program = im.getProgramID();
			degree = im.getDegreeID();

			if (NumericUtil.isInteger(application)){

				int applicationID = Integer.parseInt(application);
				switch(applicationID){

					case ImportConstant.IMPORT_COURSE_OUTLINE :

						inputData[0] = alpha;
						inputData[1] = num;

						break;

					case ImportConstant.IMPORT_COURSE_ALPHA :

						inputData[0] = alphaOnly;

						break;

					case ImportConstant.IMPORT_DIV_DEPT :

						inputData[0] = divisionCode;

						break;

					case ImportConstant.IMPORT_PROGRAM :

						inputData[0] = program;

						break;

					case ImportConstant.IMPORT_DEGREE :

						inputData[0] = degree;

						break;

				} // switch
			} // numeric
		}
		im = null;

		return inputData;
	}

	/*
	 * drawHelpText
	 *	<p>
	 * @param	step	int
	 *	<p>
	 * @return String
	 */
	public static String drawHelpText(int step){

		StringBuffer buf = new StringBuffer();

		buf.append("<div id=\"helpPopup\" class=\"popup_block\" style=\"width: 500px; margin-top: -159px; margin-left: -290px; display: none; \">");
    	buf.append("<h3>Curriculumn Central (CC) Help</h3>");

		switch(step){
			case ImportConstant.IMPORT_TYPE :

				buf.append("Identify the type of data to import.");

				break;

			case ImportConstant.IMPORT_APPLICATION :

				buf.append("<font class=\"textblackth\">Select where the list data is applied.</font>");
				buf.append("<ul>");
				buf.append("<li>Course outline - apply the list to a single course outline (IE: ENG 100 or MATH 101)");
				buf.append("<li>Course alpha - apply the list to a course alpha (IE: all ENG or all MATH)");
				buf.append("<li>Division/Department - apply the list to an entire division or department (IE: Math & Science or Accounting & Finance)");
				buf.append("<li>Program - apply the list to a program");
				buf.append("<li>Degree - apply the list to a degree (IE: all AS, or all BS)");
				buf.append("</ul>");

				break;

			case ImportConstant.IMPORT_APPLICATION_TYPE :

				buf.append("<font class=\"textblackth\">Application Type determines what to do with the imported data.</font>");
				buf.append("<ul>");
				buf.append("<li>Add - add new data to CC");
				buf.append("<li>Delete - delete existing data from CC");
				buf.append("</ul>");

				break;

			case ImportConstant.IMPORT_FREQUENCY :

				buf.append("<font class=\"textblackth\">Determines how/when the imported data is applied.</font>");
				buf.append("<ul>");
				buf.append("<li>Immediately - upon final confirmation, import the list and apply it immediately");
				buf.append("<li>On Create - apply the data only during creation of a coure or program");
				buf.append("</ul>");

				break;

			case ImportConstant.IMPORT_CONFIRMATION :

				buf.append("Review the on screen data and confirm your selection before clicking 'Submit'.");

				break;

			default:

				buf.append("Click the browse/choose file button to locate your data file. Once you make your file selection, click upload to continue.");
				buf.append("<br><br>Note: CC uploads only comma separated value (CSV) file formats. The data file must not exceed 10MB.");

				break;

		} // switch

		buf.append("<p>&nbsp;</p><span class=\"copyright\">Copyright © 1997-2011. All rights reserved</span>");
		buf.append("</div>");

		return buf.toString();
	}

	/*
	 * drawCommandButton
	 *	<p>
	 * @param	cmdButton	String
	 * @param	enable		boolean
	 *	<p>
	 * @return String
	 */
	public static String drawCommandButton(boolean enable, String cmdButton, int step){

		StringBuffer buf = new StringBuffer();

		String enableButton = "";
		String off = "";

		buf.append("<tr align=\"right\">");
		buf.append(" <td colspan=\"2\">");
		buf.append("<br><input type=\"hidden\" name=\"formName\" value=\"aseForm\">");

		if (!enable){
			enableButton = "disabled";
			off = "off";
		}

		buf.append("<div class=\"post\">");

		buf.append("<input title=\"upload\" type=\"submit\" name=\"aseUpload\" " + enableButton + " value=\""+cmdButton+"\" class=\"inputsmallgray"+off+"\" onclick=\"return aseSubmitClick('a')\">&nbsp;");

		buf.append("<input title=\"abort selected operation\" type=\"submit\" name=\"aseClose\" value=\"Close\" class=\"inputsmallgray\" onClick=\"return cancelForm()\">&nbsp;");

		buf.append("<a href=\"#?w=500\" rel=\"helpPopup\" class=\"poplight\">");
		buf.append("<img src=\"images/helpicon.gif\" border=\"0\" alt=\"help with this screen\" title=\"help with this screen\">");
		buf.append("</a>");

		buf.append("</div>");

		buf.append("&nbsp;&nbsp;&nbsp;</td></tr>");

		buf.append("<tr align=\"right\">");
		buf.append("<td colspan=\"2\">");

		buf.append("<div style=\"visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"spinner\">");
		buf.append("<p align=\"center\"><img src=\"../images/spinner.gif\" alt=\"processing...\" border=\"0\"><br/>processing...</p>");
		buf.append("</div>");

		buf.append("</td></tr>");

		return buf.toString();
	}

	/*
	 * drawProgress
	 *	<p>
	 * @param	iMaxSteps	int
	 * @param	currentStep	int
	 * @param	session		HttpSession
	 *	<p>
	 * @return String
	 */
	public static String drawProgress(int iMaxSteps, int currentStep,ImportMap im){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		// represents progress data
		String[] clss = new String[iMaxSteps];
		String[] img = new String[iMaxSteps];

		// clear out data
		for (i=1;i<iMaxSteps;i++){
			clss[i] = "copyright";
			img[i] = "";
		}

		// set accordingly
		for (i=1;i<currentStep;i++){
			clss[i] = "datacolumn";
			img[i] = "<img src=\"../images/success-sm.gif\" alt=\"\" border=\"0\">";
		}

		// im.getFilename() has complete file location so we want to mask that and not show all
		String filename = "";
		if (im.getFilename() != null && im.getFilename().length() > 0){
			filename = im.getFilename().substring(im.getFilename().lastIndexOf("\\")+1);
		}

		String data = "";

		if (im != null){
			int applicationID = im.getApplicationAsInt();
			String alpha = im.getAlphaID();
			String num = im.getNumberID();
			String alphaOnly = im.getAlphaOnlyID();
			int division = im.getDepartmentIDAsInt();
			String program = im.getProgramID();
			String degree = im.getDegreeID();

			switch(applicationID){
				case ImportConstant.IMPORT_COURSE_OUTLINE :
					data = alpha + " " + num;
					break;

				case ImportConstant.IMPORT_COURSE_ALPHA :
					data = alphaOnly;
					break;

				case ImportConstant.IMPORT_DIV_DEPT :
					data = "" + division;
					break;

				case ImportConstant.IMPORT_PROGRAM :
					data = program;
					break;

				case ImportConstant.IMPORT_DEGREE :
					data = degree;
					break;
			} // switch
		}

		buf.append("<tr>");
		buf.append(" <td colspan=\"2\" class=\"tutheader\">");
		buf.append("<h4 class=\"tutheader\">Upload Selection Progress</h4>");
		buf.append("<table width=\"100%\" border=\"0\">");
		buf.append("<tr><td>" + img[1]+ "</td><td class=\"" + clss[1]+ "\">File uploaded</td><td class=\"" + clss[1]+"\">"+filename+"</td></tr>");
		buf.append("<tr><td>" + img[2]+ "</td><td class=\"" + clss[2]+ "\">Import type identified</td><td class=\"" + clss[1]+"\">"+im.getImportTypeX()+"</td></tr>");
		buf.append("<tr><td>" + img[3]+ "</td><td class=\"" + clss[3]+ "\">Application selected</td><td class=\"" + clss[1]+"\">"+im.getApplicationX()+" - "+data+"</td></tr>");
		buf.append("<tr><td>" + img[4]+ "</td><td class=\"" + clss[4]+ "\">Application type selected</td><td class=\"" + clss[1]+"\">"+im.getApplicationType()+"</td></tr>");
		buf.append("<tr><td>" + img[5]+ "</td><td class=\"" + clss[5]+ "\">Frequency</td><td class=\"" + clss[1]+"\">"+im.getFrequency()+"</td></tr>");
		buf.append("</table>");
		buf.append("</td>");
		buf.append("</tr>");

		return buf.toString();
	}

	/*
	 * processImportHasMap
	 *	<p>
	 * @param	session	HttpSession
	 *	<p>
	 * @return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap processImportHasMap(HttpSession session){

		HashMap hashMap = null;

		if ((HashMap)session.getAttribute("aseListImportHashMap") != null){

			hashMap = (HashMap)session.getAttribute("aseListImportHashMap");

			com.ase.aseutil.util.HashUtil hashUtil = new com.ase.aseutil.util.HashUtil();

			String fileName = hashUtil.getHashMapParmValue(hashMap,"filename",Constant.BLANK);
			String importType = hashUtil.getHashMapParmValue(hashMap,"importType",Constant.BLANK);
			String application = hashUtil.getHashMapParmValue(hashMap,"application",Constant.BLANK);
			String applicationType = hashUtil.getHashMapParmValue(hashMap,"applicationType",Constant.BLANK);
			String frequency = hashUtil.getHashMapParmValue(hashMap,"frequency",Constant.BLANK);

			String alphaID = hashUtil.getHashMapParmValue(hashMap,"alphaID",Constant.BLANK);
			String numberID = hashUtil.getHashMapParmValue(hashMap,"numberID",Constant.BLANK);
			String alphaOnlyID = hashUtil.getHashMapParmValue(hashMap,"alphaOnlyID",Constant.BLANK);

			String departmentID = hashUtil.getHashMapParmValue(hashMap,"departmentID",Constant.BLANK);
			String programID = hashUtil.getHashMapParmValue(hashMap,"programID",Constant.BLANK);
			String degreeID = hashUtil.getHashMapParmValue(hashMap,"degreeID",Constant.BLANK);

			hashUtil = null;

			// prevent invalid data. used for parseInt
			if (importType == null || importType.equals(Constant.BLANK)){
				importType = "0";
			}

			if (application == null || application.equals(Constant.BLANK)){
				application = "0";
			}

			if (applicationType == null || applicationType.equals(Constant.BLANK)){
				applicationType = "0";
			}

			if (frequency == null || frequency.equals(Constant.BLANK)){
				frequency = "0";
			}

			// clear maps and fill again with validated data
			hashMap.clear();

			hashMap.put("filename",fileName);
			hashMap.put("importType",importType);
			hashMap.put("application",application);

			hashMap.put("alphaID",alphaID);
			hashMap.put("numberID",numberID);
			hashMap.put("alphaOnlyID",alphaOnlyID);
			hashMap.put("departmentID",departmentID);
			hashMap.put("programID",programID);
			hashMap.put("degreeID",degreeID);

			hashMap.put("applicationType",applicationType);
			hashMap.put("frequency",frequency);

			session.setAttribute("aseListImportHashMap",(HashMap)hashMap);

		} // hashmap not null

		return hashMap;

	} // processImportHasMap

	/*
	 * getListType
	 *	<p>
	 * @param	cmdButton	String
	 *	<p>
	 * @return String
	 */
	public static String getListType(String importType){

		String listType = "";

		if (NumericUtil.isInteger(importType)){

			switch(Integer.parseInt(importType)){

				case ImportConstant.IMPORT_GESLO:
						listType = ImportConstant.IMPORT_GESLO_DATA;
						break;

				case ImportConstant.IMPORT_ILO:
						listType = ImportConstant.IMPORT_ILO_DATA;
						break;

				case ImportConstant.IMPORT_PLO:
						listType = ImportConstant.IMPORT_PLO_DATA;
						break;

				case ImportConstant.IMPORT_SLO:
						listType = ImportConstant.IMPORT_SLO_DATA;
						break;
			}
		} // numeric util

		return listType;
	}

	/*
	 * importListFromFile
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	filename	String
	 * @param	division	int
	 * @param	alpha		String
	 * @param	item		String
	 * <p>
	 * @return	String
	 */
	public static String importListFromFile(Connection conn,
											String campus,
											String user,
											String listType,
											String filename,
											String divisionCode,
											String alpha,
											String itm) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String message = "";

		try {

			if (filename != null && filename.length() > 0){

				String currentDrive = AseUtil.getCurrentDrive() + ":";

				String documents = SysDB.getSys(conn,"documents");

				filename = currentDrive + documents + "temp\\" + filename;

				String temp = "";
				String[] arr;
				Values values = null;
				int i = 0;

				File target = new File(filename);
				if (target.exists()){

					String line;

					BufferedReader inputStream = new BufferedReader(new FileReader(filename));

					if (inputStream != null){
						while ((line = inputStream.readLine()) != null){

							ValuesDB.insertValues(conn,
														new Values(0,campus,listType + " - " + divisionCode,alpha,line,null,user,itm));

							++rowsAffected;
						}

						inputStream.close();
					} // inputStream != null

					com.ase.aseutil.util.FileUtils fu = new com.ase.aseutil.util.FileUtils();
					fu.deleteFile(filename,user);
					fu = null;

					message = "Imported " + rowsAffected + " row(s) of data";

				}
				else{
					message = "Import file not found (" + filename + ")";
				} // target

			}
			else{
				message = "Invalid file name (" + filename + ")";
			} // filename

		} catch (Exception e) {
			message = "Error while processing import file";
			logger.fatal("Import - importListFromFile: " + e.toString());
		}

		return message;
	}

	/*
	 * importRequisitesByAlpha
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 *	@param	user			String
	 *	@param	importType	String
	 *	@param	importAlpha	String
	 *	@param	reqType		String
	 *	@param	reqAlpha		String
	 *	@param	reqNum		String
	 *	@param	action		String
	 *	<p>
	 * @return	int
	 */
	public static int importRequisitesByAlpha(Connection conn,
															String campus,
															String user,
															String importType,
															String importAlpha,
															String reqType,
															String reqAlpha,
															String reqNum,
															String action) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int total = 0;

		try{
			// select all courses by importAlpha and run through to import the requisites
			// only processing for CUR

			String sql = "SELECT historyid,coursenum "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='CUR' "
						+ "AND coursealpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,importAlpha);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				if (importType.equals(Constant.IMPORT_COREQ) || importType.equals(Constant.IMPORT_PREREQ)){

					rowsAffected = RequisiteDB.addRemoveRequisites(conn,
																					kix,
																					action,
																					campus,
																					importAlpha,
																					num,
																					reqAlpha,
																					reqNum,
																					Constant.BLANK,
																					reqType,
																					user,
																					0,
																					false);
				}
				else if (importType.equals(Constant.IMPORT_XLIST)){

					rowsAffected = XRefDB.addRemoveXlist(conn,
																		kix,
																		action,
																		campus,
																		importAlpha,
																		num,
																		reqAlpha,
																		reqNum,
																		user,
																		0);

				}

				if (rowsAffected > 0)
					++total;

			}
			rs.close();
			ps.close();

		}catch(SQLException e){
			logger.fatal("RequisiteDB - importRequisitesByAlpha: " + e.toString());
		}

		return total;
	}

	/*
	 * processImportOptions
	 *	<p>
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * @param	currentStep	int
	 *	<p>
	 * @return String
	 */
	public static String processImportOptions(HttpServletRequest request, HttpServletResponse response){

		// Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String[] staticText = com.ase.aseutil.io.ImportConstant.IMPORT_TEXT.split(",");

		String selected = "";

		int applicationID = 0;

		String maxSteps = "" + com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION;
		String frmInputType = "text";

		String fileName = "";
		String importType = "";
		String application = "";
		String applicationType = "";
		String frequency = "";

		String alphaID = "";
		String numberID = "";
		String alphaOnlyID = "";

		String departmentID = "";
		String programID = "";
		String degreeID = "";
		String temp;

		int i = 0;

		// determines whether the next button should be set
		// if not all data collected, then button should be false
		boolean enable = true;

		com.ase.aseutil.io.ImportMap im = null;
		com.ase.aseutil.io.Import imp = null;

		String importText = "";
		String frequencyText = "";
		int importTypeAsInt = 0;

		int currentStep = 0;

		int numberOfRadiosItems = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			String campus = com.ase.aseutil.Util.getSessionMappedKey(session,"aseCampus");

			String aseListImportMessage = AseUtil.nullToBlank((String)session.getAttribute("aseListImportMessage"));

			// clear before form submission goes back to driver
			session.setAttribute("aseListImportMessage",null);

			// where are we in the sequence of steps?
			if ((String)session.getAttribute("aseListImportNextStep") != null){
				temp = (String)session.getAttribute("aseListImportNextStep");
				currentStep = Integer.parseInt(temp);
			}
			else{
				currentStep = 1;
			}

			// get latest session data
			im = new com.ase.aseutil.io.ImportMap(session);
			if (im != null){
				fileName = im.getFilename();
				importType = im.getImportType();
				importTypeAsInt = im.getImportTypeAsInt();
				application = im.getApplication();
				applicationID = im.getApplicationAsInt();
				applicationType = im.getApplicationType();
				frequency = im.getFrequency();
				alphaID = im.getAlphaID();
				numberID = im.getNumberID();
				alphaOnlyID = im.getAlphaOnlyID();
				departmentID = im.getDepartmentID();
				programID = im.getProgramID();
				degreeID = im.getDegreeID();
			}

			// data reflecting the type that is permitted for this import data type
			imp = getImport(importTypeAsInt);
			if (imp != null){
				importText = "," + imp.getApplication() + ",";
				frequencyText = imp.getFrequency();
			}

			// title
			String title = "List Import";
			String subTitle = staticText[currentStep];

			// adjust for next step
			int iMaxSteps = Integer.parseInt(maxSteps);
			String nextStep = "" + (currentStep + 1);

			// command button on first screen is different
			String cmdButton = "Next";
			if (currentStep == 1){
				cmdButton = "Upload";
			}
			else if (currentStep == iMaxSteps){
				cmdButton = "Submit";
			}

			// for start
			buf.append("");
			buf.append("<table class=\"example_code notranslate\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"60%\">");
			buf.append("<tr>");
			buf.append("<td>");

			// upload of forms is different
			if (currentStep == 1){
				buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" enctype=\"multipart/form-data\" action=\"/central/servlet/digdig\">");
			}
			else{
				buf.append("<form method=\"post\" id=\"aseForm\" name=\"aseForm\" action=\"?\">");
			}

			buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" class=\"code\" align=\"center\"  border=\"0\">");

			// steps and title
			buf.append("<tr height=\"40\"><td colspan=\"2\" class=\"dataColumnCenter\"><strong>");
			buf.append(title);
			buf.append("&nbsp;-&nbsp;");
			buf.append(subTitle);
			buf.append("&nbsp;(step ");
			buf.append(currentStep);
			buf.append(" of ");
			buf.append(maxSteps);
			buf.append(")</strong></td></tr>");

			// body
			switch(currentStep){

				case com.ase.aseutil.io.ImportConstant.IMPORT_FILE :
					// upload
					buf.append("<tr height=\"30\">");
					buf.append(" <td class=\"textblackth\" valign=\"top\" width=\"20%\">Datafile:</td>");
					buf.append(" <td valign=\"top\"><input type=\"file\" value=\"" + fileName + "\" name=\"fileName\" size=\"50\" id=\"fileName\" class=\"upload\" /></td>");
					buf.append("</tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					// samples
					buf.append("<tr>");
					buf.append(" <td colspan=\"2\" class=\"tutheader\">");
					buf.append("<h4 class=\"tutheader\">Sample file formats</h4>");
					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">");
					buf.append("<tr>");
					buf.append(" <td valign=\"top\">");
					buf.append("<ul>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/coreq.txt\" class=\"linkcolumn\" target=\"_blank\">Co-Req</a><br/><br/></li>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/xlist.txt\" class=\"linkcolumn\" target=\"_blank\">Cross Listed</a><br/><br/></li>");
					buf.append("<li><img src=\"../images/ext/txt.gif\" border=\"0\" alt=\"\">&nbsp;<a href=\"/centraldocs/docs/help/prereq.txt\" class=\"linkcolumn\" target=\"_blank\">Pre Req</a><br/><br/></li>");
					buf.append("</ul>");
					buf.append("</td>");
					buf.append("</tr>");
					buf.append("</table>");
					buf.append("*Files may not exceed 10MB in size</td>");
					buf.append("</tr>");

					// for validation
					frmInputType = "text";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_TYPE :
					// import type
					buf.append("<tr height=\"30\">");
					buf.append(" <td class=\"textblackth\" valign=\"top\" width=\"20%\">Import Type:</td>");
					buf.append(" <td valign=\"top\">");

					int start = com.ase.aseutil.io.ImportConstant.IMPORT_COREQ;
					int end = com.ase.aseutil.io.ImportConstant.IMPORT_SLO;

					for (i=start;i<=end;i++){

						selected = "";
						if (importType.equals(""+i)){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+i+"\">"+staticText[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					// for validation
					frmInputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION :

					// allocating array to hold output. array size and usage is based on index
					// where the particular item is found. which means that there will be empty or null
					// cells with the exception of the element where a valid index is located.
					String[] rows = new String[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+1];

					// application
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application:</td>");
					buf.append("<td valign=\"top\">");

					buf.append("<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
					buf.append("<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );

					buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">");

					// check to see if this is the one and only available radio button. If so, auto check by default

					String applicationTemp = application;

					frmInputType = "radio";

					temp = importText;
					if (temp.startsWith(",")){
						temp = temp.substring(1);
					}

					if (temp.endsWith(",")){
						temp = temp.substring(0,temp.length()-1);
					}

					// if we don't find a comma in the string, then it's only 1 radio available
					// check to checkbox if it's the one and only item
					if (temp.indexOf(",") < 0){
						applicationTemp = temp;
						frmInputType = "checkbox";
					}

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alpha_hidden\" name=\"alphaID\"><br>"
						+ "<input type=\"text\" class=\'inputajax\' id=\"number\" name=\"number\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alphaID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')\">"
						+ "<input type=\"hidden\" id=\"number_hidden\" name=\"numberID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"alphaOnly\" name=\"alphaOnly\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"alphaOnly_hidden\" name=\"alphaOnlyID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"department\" name=\"department\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DEPARTMENT + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"department_hidden\" name=\"departmentID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"program\" name=\"program\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.PROGRAM + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"program_hidden\" name=\"programID\">"
						+ "</td></tr>";

					selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE)) selected = "checked";
					rows[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE] = "<tr><td valign=\"top\" nowrap>"
						+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE]+"</input></td>"
						+ "<td valign=\"top\">"
						+ "<input type=\"text\" class=\'inputajax\' id=\"degree\" name=\"degree\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DEGREE + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
						+ "<input type=\"hidden\" id=\"degree_hidden\" name=\"degreeID\">"
						+ "</td></tr>";

					// loop through available import to location and only display what this import type should use.
					// for example, pre, co, and xlist should only import to course outline
					int start2 = com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE;
					int end2 = com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE;

					for (i=start2;i<=end2;i++){
						if (importText.indexOf(","+i+",")>-1){
							buf.append(rows[i]);
						}

					} // for

					buf.append("</table>");

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_APPLICATION_TYPE :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Application type:</td>");
					buf.append("<td valign=\"top\">");

					String applicationTypeData = "Add,Delete";
					applicationTypeData = "Add,Delete";
					String[] aApplicationTypeData = applicationTypeData.split(",");

					for (i=0;i<aApplicationTypeData.length;i++){

						selected = "";
						if (applicationType.equals(aApplicationTypeData[i])){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+aApplicationTypeData[i]+"\">"+aApplicationTypeData[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					// for validation
					frmInputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_FREQUENCY :
					// frequency
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" width=\"20%\">Frequency:</td>");
					buf.append("<td valign=\"top\">");

					String frequencyData = frequencyText;
					String[] aFrequencyData = frequencyData.split(",");

					for (i=0;i<aFrequencyData.length;i++){

						selected = "";
						if (frequency.equals(aFrequencyData[i])){
							selected = "checked";
						}

						buf.append("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+aFrequencyData[i]+"\">"+aFrequencyData[i]+"</input><br>");
					}

					buf.append(" </td></tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					// for validation
					frmInputType = "radio";

					break;

				case com.ase.aseutil.io.ImportConstant.IMPORT_CONFIRMATION :
					// confirmation
					buf.append("<tr height=\"30\">");
					buf.append("<td class=\"textblackth\" valign=\"top\" colspan=\"2\">Confirm your import options:</td>");
					buf.append("<td valign=\"top\">&nbsp;</td>");
					buf.append("</tr>");

					// validation - cannot contain blanks or 0 (we have no 0 value option)
					if (	fileName.equals(Constant.BLANK) || importType.equals(Constant.BLANK) ||
							application.equals(Constant.BLANK) || applicationType.equals(Constant.BLANK) ||
							frequency.equals(Constant.BLANK)){

						enable = false;
					}

					buf.append("<tr>");
					buf.append(" <td colspan=\"2\" class=\"tutheader\">");
					buf.append("<ul>");
					buf.append("<li>File Name: <span class=\"datacolumn\">" + fileName + "</span><br/><br/></li>");
					buf.append("<li>Import Type: <span class=\"datacolumn\">" + staticText[Integer.parseInt(importType)] + "</span><br/><br/></li>");
					buf.append("<li>Application: <span class=\"datacolumn\">" + staticText[applicationID] + " (" + application + ")</span><br/><br/></li>");
					buf.append("<li>Application Type: <span class=\"datacolumn\">" + applicationType + "</span><br/><br/></li>");
					buf.append("<li>Frequency: <span class=\"datacolumn\">" + frequency + "</span><br/><br/></li>");
					buf.append("</ul>");
					buf.append("</tr>");

					// command buttons
					buf.append(drawCommandButton(enable,cmdButton,currentStep));

					// help text
					buf.append(drawHelpText(currentStep));

					break;

			} // switch

			buf.append("");

			if (!aseListImportMessage.equals(Constant.BLANK)){
				buf.append("<tr>");
				buf.append("<td align=\"center\" colspan=\"3\">" + aseListImportMessage + "</td>");
				buf.append("</tr>");
			}

			buf.append(drawProgress(iMaxSteps,currentStep,im));

			// footer
			buf.append("</table>");

			// frmInputType used for validation
			buf.append("<input type=\"hidden\" value=\""+frmInputType+"\" name=\"frmInputType\">");

			// next step
			buf.append("<input type=\"hidden\" value=\""+nextStep+"\" name=\"nextStep\">");

			// where to return to
			buf.append("<input type=\"hidden\" value=\""+"lstmprt"+"\" name=\"rtn\">");

			buf.append("</form>");
			buf.append("</td>");
			buf.append("</tr>");
			buf.append("</table>");

			session.setAttribute("aseListImportNextStep",""+nextStep);

		}
		catch(Exception ex){
			logger.fatal("listImport - " + ex.toString());
		}

		return buf.toString();

	} // processImportOptions

	/*
	 * setMessage
	 * <p>
	 * @param	session	HttpSession
	 * @param	nextStep	int
	 * <p>
	 * @return
	 */
	public static void setMessage(HttpSession session,int nextStep) {
		session.setAttribute("aseListImportMessage",
									"<img src=\"../images/err_alert.gif\" border=\"0\">Please make a valid selection or provide appropriate input <br>before proceeding to the next step!");

		session.setAttribute("aseListImportNextStep",""+nextStep);
	}
}