/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseCopy.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseCopy {

	static Logger logger = Logger.getLogger(CourseCopy.class.getName());

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	public CourseCopy() throws Exception{}

	/*
	 * copyOutline
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 *	@param	fromAlpha	String
	 *	@param	fromNum		String
	 *	@param	toAlpha		String
	 *	@param	toNum			String
	 *	@param	user			String
	 * @param	comments		String
	 *	<p>
	 * @return Msg
	 */
	public static Msg copyOutline(Connection conn,
											String campus,
											String fromAlpha,
											String fromNum,
											String toAlpha,
											String toNum,
											String user,
											String comments) throws SQLException {

		int rowsAffected = 0;

		// similar to modifying outline.

		// to prepage for copy of an approved course, the following is necessary
		// 0) make sure the course doesn't already exist in the main table (both CUR and PRE)
		// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
		// 2) make a copy of the CUR course in temp table (insertToTemp)
		// 3) update key fields and prep for edits (updateTemp)
		// 4) put the temp record in course table for use (insertToCourse)

		boolean debug = DebugDB.getDebug(conn,"CourseCopy");

		if (debug) logger.info(user + " - COURSECOPY: COPYOUTLINE - START");

		Msg msg = new Msg();

		String type = "";

		try{
			// kix was sent in as fromAlpha as a substitute to avoid having to make the foot print
			// to much longer. kix is used to recall type.
			String kix = fromAlpha;
			String[] info = Helper.getKixInfo(conn,kix);
			fromAlpha = info[Constant.KIX_ALPHA];
			fromNum = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];

			msg = CourseDB.isCourseCopyable(conn,campus,toAlpha,toNum);
			if ("".equals(msg.getMsg())){
				AseUtil.logAction(conn,
										user,
										"COPY - START",
										"Outline copy ("+ fromAlpha + " " + fromNum + ")",
										fromAlpha,
										fromNum,
										campus,
										kix);

				msg = copyOutlineX(conn,campus,kix,kix,toAlpha,toNum,user,comments);

				if (!"Exception".equals(msg.getMsg())){

					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															toAlpha,
															toNum,
															Constant.MODIFY_TEXT,
															campus,
															"",
															"ADD",
															"PRE");

					AseUtil.logAction(conn, user, "copied","Course copied ("+ fromAlpha + " " + fromNum + ")",toAlpha,toNum,campus);

					DistributionDB.notifyDistribution(conn,
																campus,
																fromAlpha,
																fromNum,
																type,
																user,
																"",
																"",
																"emailNotifiedWhenCopy",
																"NotifiedWhenCopy",
																user);

					Tables.createOutlines(campus,kix,fromAlpha,fromNum);

				} // !exception

				AseUtil.logAction(conn,
										user,
										"COPY - END",
										"Outline copy ("+ fromAlpha + " " + fromNum + ")",
										toAlpha,
										toNum,
										campus,
										kix);

			}
			else{
				msg.setErrorLog("Outline not isCourseCopyable at this time.");
			} // is copyable

		}
		catch(SQLException se){
			logger.fatal(user + " - CourseCopy: copyOutline - " + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal(user + " - CourseCopy: copyOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		if (debug) logger.info(user + " - COURSECOPY: COPYOUTLINE - END");

		return msg;
	}

	/*
	 * copyOutlineX
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 *	@param	fromAlpha	String
	 *	@param	fromNum		String
	 *	@param	toAlpha		String
	 *	@param	toNum			String
	 *	@param	user			String
	 * @param	comments		String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg copyOutlineX(Connection connection,
												String campus,
												String fromAlpha,
												String fromNum,
												String toAlpha,
												String toNum,
												String user,
												String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// here, campus is the campus of the user copying the outline

		Msg msg = new Msg();

		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";
		String temp = "";

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		String[] select;

		String currentDate = AseUtil.getCurrentDateTimeString();

		Connection conn = null;
		conn = AsePool.createLongConnection();

		// kix was sent in as fromAlpha as a substitute to avoid having to make the foot print
		// to much longer. kix is used to recall type.
		String kix = "";
		String[] info = null;
		String fromCampus = "";
		String type = "";
		String kixOld = "";
		String kixNew = "";

		boolean debug = false;

		if (debug) logger.info("-------------- CourseCopy - START");

		try {
			conn = AsePool.createLongConnection();

			kix = fromAlpha;
			info = Helper.getKixInfo(conn,kix);
			fromAlpha = info[Constant.KIX_ALPHA];
			fromNum = info[Constant.KIX_NUM];
			fromCampus = info[Constant.KIX_CAMPUS];
			type = info[Constant.KIX_TYPE];

			kixOld = kix;
			kixNew = SQLUtil.createHistoryID(1);

			if (debug){
				logger.info("user: " + user);
				logger.info("kixOld - " + kixOld);
				logger.info("kixNew - " + kixNew);
				logger.info("fromCampus/toCampus: " + fromCampus + "/" + campus);
				logger.info("fromAlpha/fromNum: " + fromAlpha + "/" + fromNum);
				logger.info("toAlpha/toNum: " + toAlpha + "/" + toNum);
			}

			// similar to modifying outline.

			// to prepage for copy of an approved course, the following is necessary
			// 0) make sure the course doesn't already exist in the main table (both CUR and PRE)
			// 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			// 2) make a copy of the CUR course in temp table (insertToTemp)
			// 3) update key fields and prep for edits (updateTemp)
			// 4) put the temp record in course table for use (insertToCourse)

			if (	!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "PRE") &&
					!CourseDB.courseExistByTypeCampus(conn, campus, toAlpha, toNum, "CUR")) {

				// do not copy campus data. just need to make empty shell
				// copy of all other data is in LinkedUtil.copyLinkedTables(conn,kixOld,kixNew,toAlpha,toNum,user);
				sql = "tblCourse,tblCampusData,tblCoreq,tblCourseCompAss,tblPreReq,tblXRef,tblCourseContentSLO,tblExtra".split(",");
				tempSQL = "tblTempCourse,tblTempCampusData,tblTempCoreq,tblTempCourseCompAss,tblTempPreReq,tblTempXRef,tblTempCourseContentSLO,tblTempExtra".split(",");

				sqlManual = "tblCourseACCJC".split(",");
				tempSQLManual = "tblTempCourseACCJC".split(",");

				totalTables = sql.length;
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				Outlines.insertIntoTemp(conn,kixOld);

				if (debug) logger.info("insertIntoTemp completed");

				/*
				 * update temp data (course)
				 */
				String reason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br/>"
									+ "Copied from " + fromAlpha + " " + fromNum
									+ "<br/><br/>" + comments;

				thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1', "
					+ " proposer=?,historyid=?,dateproposed=?,auditdate=?,reviewdate=NULL,assessmentdate=NULL,coursedate=NULL, "
					+ " coursealpha=?,coursenum=?,campus=?,"+Constant.COURSE_REASON+"=? "
					+ " WHERE historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, kixNew);
				ps.setString(2, user);
				ps.setString(3, kixNew);
				ps.setString(4, currentDate);
				ps.setString(5, currentDate);
				ps.setString(6, toAlpha);
				ps.setString(7, toNum);
				ps.setString(8, campus);
				ps.setString(9, reason);
				ps.setString(10, kixOld);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();
				if (debug) logger.info("updated temp table - " + rowsAffected + " row");

				//
				//	campus data is handled below
				//
				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
					temp = tempSQL[i].toLowerCase();
					if (temp.indexOf("campusdata") == -1){
						thisSQL = "UPDATE "
								+ tempSQL[i]
								+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=?,campus=? "
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1, kixNew);
						ps.setString(2, currentDate);
						ps.setString(3, toAlpha);
						ps.setString(4, toNum);
						ps.setString(5, campus);
						ps.setString(6, kixOld);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("UPDATE1C " + temp.replace("tbl","") + ": " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
					}
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "UPDATE "
							+ tempSQLManual[i]
							+ " SET historyid=?,coursetype='PRE',campus=?,auditdate=? WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					ps.setString(2,campus);
					ps.setString(3,AseUtil.getCurrentDateTimeString());
					ps.setString(4,kixOld);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("UPDATE1D " + tempSQLManual[i].replace("tbl","") + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}

				//
				// insert to prod
				//
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					temp = tempSQL[i].toLowerCase();
					if (temp.indexOf("campusdata") == -1){
						thisSQL = "INSERT INTO "
								+ sql[i]
								+ " SELECT * FROM "
								+ tempSQL[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("INSERT1A " + temp.replace("tbl","") + ": " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
					}
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sqlManual[i]
							+ " SELECT " + select[i] + " FROM "
							+ tempSQLManual[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("INSERT1B " + sqlManual[i].replace("tbl","") + ": " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				}
				ps.close();

				//
				// insert textbooks to prod
				//
				thisSQL = "insert into tbltemptext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltext where historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT text to temp " + rowsAffected + " row");

				thisSQL = "update tbltemptext set historyid=? where historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				ps.setString(2,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("UPDATE temp text historyid " + rowsAffected + " row");

				thisSQL = "insert into tbltext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltemptext where historyid=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT temp text to coures " + rowsAffected + " row");

				//
				//	if copying from to same campus, allow copy of campus data. If not, just create empty shell
				//
				if (!CampusDB.courseExistByCampus(conn,campus,toAlpha,toNum,"PRE")) {
					if (campus.equals(fromCampus)){
						thisSQL = "UPDATE tblTempCampusData "
								+ " SET historyid=?,coursetype='PRE',auditdate=?,coursealpha=?,coursenum=?,campus=? "
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						ps.setString(2,currentDate);
						ps.setString(3,toAlpha);
						ps.setString(4,toNum);
						ps.setString(5,campus);
						ps.setString(6,kixOld);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();

						thisSQL = "INSERT INTO tblCampusData SELECT * FROM tblTempCampusData WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("updated temp campus data - " + rowsAffected + " row");
					}
					else{
						thisSQL = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,CourseType,auditby,campus) VALUES(?,?,?,?,?,?)";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						ps.setString(2,toAlpha);
						ps.setString(3,toNum);
						ps.setString(4,"PRE");
						ps.setString(5,user);
						ps.setString(6,campus);
						rowsAffected = ps.executeUpdate();
						ps.close();
						if (debug) logger.info("updated temp campus data - " + rowsAffected + " row");
					}

				} // if (!CampusDB.courseExistByCampus(conn,campus,toAlpha,toNum,"PRE")) {

				//
				// copyLinkedTables
				//
				rowsAffected = LinkedUtil.copyLinkedTables(conn,kixOld,kixNew,toAlpha,toNum,user);
				if (debug) logger.info("copyLinkedTables - " + rowsAffected + " row");

				//
				// update outline campus
				//
				CampusDB.updateCampusOutline(conn,kixNew,campus);
				if (debug) logger.info("updateCampusOutline completed - " + kixNew);

				// for html print processing
				Html.updateHtml(conn,Constant.COURSE,kixNew);

				//
				// delete temp
				//
				Outlines.deleteTempOutline(conn,kixOld);
				Outlines.deleteTempOutline(conn,kixNew);
				if (debug) logger.info("deleteTempOutline completed");

				//
				// SLO
				//
				rowsAffected = SLODB.insertSLO(conn,campus,toAlpha,toNum,user,"MODIFY",kixNew);
				if (debug) logger.info("SLO - " + rowsAffected + " row");

				//
				// create HTML
				//
				Tables.createOutlines(campus,kixNew,toAlpha,toNum);

				msg.setKix(kixNew);

			} else {
				msg.setMsg("NotAllowToCopyOutline");
			} // if valid course type

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseCopy: copyOutlineX -"
								+ " kixOld: " + kixOld
								+ " kixNew: " + kixNew
								+ " Exception: " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");

			logger.fatal(user + " - CourseCopy: copyOutlineX - " + CourseCopy.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
					if (debug) logger.info("connection released");
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}
		}

		if (debug) logger.info("-------------- CourseCopy - END");

		return msg;
	}

	public void close() throws SQLException {}

}