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
// CourseModify.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseModify {
	static Logger logger = Logger.getLogger(CourseModify.class.getName());

	public CourseModify(){}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;

	private static boolean debug			= true;

	/*
	 * modifyOutline - Initialize key fields for approved outline modifications
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	mode			Sring
	 *	<p>
	 * @return Msg
	 */
	public static Msg modifyOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode) throws SQLException {

		/*
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * for modification of an approved outline, the outline must not exists
		 * in PRE and must exist as CUR
		 *
		 * make sure they are modifying what is in their discipline
		 */

		int rowsAffected = 0;

		debug = DebugDB.getDebug(conn,"CourseModify");

		if (debug) logger.info("COURSEMODIFY: MODIFYOUTLINE - START");

		Msg msg = new Msg();
		try{
			if (!CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "PRE")
					&& CourseDB.courseExistByTypeCampus(conn, campus, alpha, num, "CUR")) {
				if (alpha.equals(UserDB.getUserDepartment(conn,user,alpha))) {

					String kix = Helper.getKix(conn,campus,alpha,num,"CUR");

					AseUtil.logAction(conn, user, "ACTION","Outline modification ("+ alpha + " " + num + ")",alpha,num,campus,kix);

					msg = modifyOutlineX(conn,campus,alpha,num,user,mode);

				} else {
					msg.setMsg("NotAuthorizeToModify");
					logger.info("NotAuthorizeToModify from another department");
				}
			} else {
				msg.setMsg("NotEditable");
				logger.info("CourseModify: modifyOutline - Attempting to edit outline that is not editable ("+alpha + " " + num+").");
			}
		}
		catch(SQLException se){
			logger.fatal("CourseModify: modifyOutline\n" + se.toString());
			msg.setMsg("Exception");
		}
		catch(Exception e){
			logger.fatal("CourseModify: modifyOutline\n" + e.toString());
			msg.setMsg("Exception");
		}

		if (debug) logger.info("COURSEMODIFY: MODIFYOUTLINE - END");

		return msg;
	}

	/*
	 * modifyOutlineX
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	mode			Sring
	 *	<p>
	 * @return Msg
	 */
	public static Msg modifyOutlineX(Connection conn,String campus,String alpha,String num,String user,String mode)
		throws Exception {

		return modifyOutlineX(conn,campus,alpha,num,user,mode,"");

	}

	public static Msg modifyOutlineX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode,
												String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		PreparedStatement ps = null;

		String[] sql = new String[20];
		String[] tempSQL = new String[20];

		String[] sqlManual = new String[20];
		String[] tempSQLManual = new String[20];

		String thisSQL = "";
		String junkSQL = "";

		int totalTables = 0;
		int totalTablesManual = 0;

		int rowsAffected = 0;
		int tableCounter = 0;
		int i = 0;

		String[] select;

		String fromAlpha = alpha;
		String fromNum = num;
		String fromType = "CUR";

		String toAlpha = alpha;
		String toNum = num;
		String toType = "PRE";

		String currentDate = AseUtil.getCurrentDateTimeString();

		String kixOld = Helper.getKix(conn,campus,fromAlpha,fromNum,fromType);
		String kixNew = SQLUtil.createHistoryID(1);

		boolean debug = false;

		String progress = "";
		String taskText = "";

		try {
			debug = DebugDB.getDebug(conn,"CourseModify");

			if (mode.equals(Constant.COURSE_DELETE_TEXT)){
				progress = Constant.COURSE_DELETE_TEXT;
				taskText = Constant.DELETE_TEXT;
			}
			else{
				progress = Constant.COURSE_MODIFY_TEXT;
				taskText = Constant.MODIFY_TEXT;
			}

			if (debug){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("mode: " + mode);
				logger.info("progress: " + progress);
				logger.info("kixOld - " + kixOld);
				logger.info("kixNew - " + kixNew);
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

			if (!CourseDB.courseExistByTypeCampus(conn,campus,toAlpha,toNum,toType)) {

				//
				// last 2 tables are done in LinkedUtil.copyLinkedTables
				//
				//tblAttach,tblGenericContent,tblCourseContent
				//tblTempAttach,tblTempGenericContent,tblTempCourseContent
				sql = "tblCourse,tblCampusData,tblCoreq,tblCourseCompAss,tblPreReq,tblXRef,tblCourseContentSLO,tblExtra,tblAttach".split(",");
				tempSQL = "tblTempCourse,tblTempCampusData,tblTempCoreq,tblTempCourseCompAss,tblTempPreReq,tblTempXRef,tblTempCourseContentSLO,tblTempExtra,tblTempAttach".split(",");

				//
				// tblCourseCompetency and tblgeslo are done in LinkedUtil.copyLinkedTables, and is done separately
				//
				//tblCourseCompetency,tblCourseLinked,tblCourseLinked2,tblGESLO
				//tblTempCourseCompetency,tblTempCourseLinked,tblTempCourseLinked2,tblTempGESLO
				sqlManual = "tblCourseACCJC,tblCourseCompetency,tblCourseLinked,tblCourseLinked2,tblGESLO".split(",");
				tempSQLManual = "tblTempCourseACCJC,tblTempCourseCompetency,tblTempCourseLinked,tblTempCourseLinked2,tblTempGESLO".split(",");

				totalTables = sql.length;
				totalTablesManual = sqlManual.length;

				select = Outlines.getTempTableSelects();

				Outlines.deleteTempOutline(conn,kixOld);
				Outlines.insertIntoTemp(conn,kixOld);

				//
				// update temp data (course)
				//

				// correction for DF65 (ttg - 2012.14.01)

				String reason = "";

				if (mode.equals(Constant.COURSE_DELETE_TEXT)){
					reason = comments;
				}
				else if (mode.equals(Constant.COURSE_MODIFY_TEXT)){
					reason = "Initial outline modification";
				}

				reason = "<strong>"
							+ AseUtil.getCurrentDateTimeString() + " - " + user
							+ "</strong><br/>"
							+ reason;

				thisSQL = "UPDATE tblTempCourse SET id=?,coursetype='PRE',edit=1,progress='"+progress+"',edit0='',edit1='1',edit2='1', "
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
				if (debug) logger.info("UPDATE1A - " + rowsAffected + " row");

				//
				//	update temp with proper settings for modifications
				//
				thisSQL = "UPDATE tblTempCourseComp SET comments='',approved='',approvedby=null "+
					"WHERE historyid=?";
				if (debug) logger.info("update 2 of 2");
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1,kixNew);
				rowsAffected = ps.executeUpdate();
				ps.clearParameters();

				tableCounter = totalTables;
				for (i=1; i<tableCounter; i++) {
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
					if (debug) logger.info("UPDATE1D " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQL[i].replace("tblTemp","") + ")");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					if(tempSQLManual[i].equals("tblTempCourseACCJC") || tempSQLManual[i].equals("tblTempCourseLinked")){
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
						if (debug) logger.info("UPDATE1E " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQLManual[i].replace("tblTemp","") + ")");
					}
				}

				//
				// insert to prod
				//
				tableCounter = totalTables;
				for (i=0; i<tableCounter; i++) {
					thisSQL = "INSERT INTO "
							+ sql[i]
							+ " SELECT * FROM "
							+ tempSQL[i]
							+ " WHERE historyid=?";
					ps = conn.prepareStatement(thisSQL);
					ps.setString(1,kixNew);
					rowsAffected = ps.executeUpdate();
					ps.clearParameters();
					if (debug) logger.info("INSERT1A " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQL[i].replace("tblTemp","") + ")");
				}

				tableCounter = totalTablesManual;
				for (i=0; i<tableCounter; i++) {
					if(sqlManual[i].equals("tblCourseACCJC") || sqlManual[i].equals("tblCourseLinked")){
						thisSQL = "INSERT INTO "
								+ sqlManual[i]
								+ " SELECT " + select[i] + " FROM "
								+ tempSQLManual[i]
								+ " WHERE historyid=?";
						ps = conn.prepareStatement(thisSQL);
						ps.setString(1,kixNew);
						rowsAffected = ps.executeUpdate();
						ps.clearParameters();
						if (debug) logger.info("INSERT1B " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row (" + tempSQLManual[i].replace("tblTemp","") + ")");
					}
				}
				ps.close();

				rowsAffected = LinkedUtil.copyLinkedTables(conn,kixOld,kixNew,toAlpha,toNum,user);

				//
				// insert textbooks to prod
				//
				String talinSQL = "";
				talinSQL = "insert into tbltemptext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltext where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT text to temp " + rowsAffected + " row");

				talinSQL = "update tbltemptext set historyid=? where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixNew);
				ps.setString(2,kixOld);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("UPDATE temp text historyid " + rowsAffected + " row");

				talinSQL = "insert into tbltext(historyid, title, edition, author, publisher, yeer, isbn) "
					+ "select historyid, title, edition, author, publisher, yeer, isbn from tbltemptext where historyid=?";
				ps = conn.prepareStatement(talinSQL);
				ps.setString(1,kixNew);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("INSERT temp text to course " + rowsAffected + " row");

				//
				// delete temp
				//
				Outlines.deleteTempOutline(conn,kixOld);
				Outlines.deleteTempOutline(conn,kixNew);

				//
				// SLO
				//
				if (!taskText.equals(Constant.DELETE_TEXT)){
					rowsAffected = SLODB.insertSLO(conn,campus,toAlpha,toNum,user,"MODIFY",kixNew);
					if (debug) logger.info("SLO - " + rowsAffected + " row");
				}

				msg.setKix(kixNew);
				if (debug) logger.info("new kix - " + kixNew);

				// no task creation if this is a delete
				if (!taskText.equals(Constant.DELETE_TEXT)){
					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															taskText,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.TASK_PROPOSER,
															Constant.TASK_PROPOSER,
															"",
															"",
															"EXISTING");
					if (debug) logger.info("log task - " + rowsAffected + " row");

					AseUtil.logAction(conn,
											user,
											"ACTION",
											"Outline "+progress+" ("+ alpha + " " + num + ")",
											alpha,
											num,
											campus,
											kixNew);
				}

			} else {
				msg.setMsg("NotAllowToCopyOutline");
			}

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However,there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal(user + " - CourseModify: ex - " + ex.toString());
			msg.setMsg("Exception");
		} catch (Exception CourseCopy) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			msg.setMsg("Exception");
			logger.fatal(user + " - CourseModify: copyOutline - " + CourseCopy.toString());
		}

		return msg;
	}

	public void close() throws SQLException {}

}