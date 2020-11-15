/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseCreate.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseCreate {

	static Logger logger = Logger.getLogger(CourseCreate.class.getName());

	public CourseCreate() throws Exception{}

	private static boolean debug = false;

	/*
	 * createOutline
	 *	<p>
	 * @param	conn		Connection
	 * @param	alpha		String
	 * @param	num		String
	 * @param	title		String
	 * @param	user		String
	 * @param	campus	String
	 *	<p>
	 * @return boolean
	 */
	 public static boolean createOutline(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus) throws Exception {

		return createOutline(conn,alpha,num,title,comments,user,campus,"","","");

	}

	 public static boolean createOutline(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus,
													String parm1,
													String parm2,
													String parm3) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean rtn = false;

		if (!CourseDB.courseExist(conn,campus,alpha,num)){
			rtn = createOutlineX(conn,alpha,num,title,comments,user,campus,parm1,parm2,parm3);

			if (!rtn){
				if (debug) logger.info("Outline created.");
			}
			else{
				if (debug) logger.info("Unable to create outline.");
			}
		}
		else{
			if (debug) logger.info("Unable to create outline.");
		}

		return rtn;

	} // CourseCreate: createOutline

	 public static boolean createOutlineX(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus,
													String parm1,
													String parm2,
													String parm3) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean created = false;
		String historyID = "";
		String sql = "";
		int rowsAffected = 0;

		// parm1 = division code
		// parm2 = <not used>
		// parm2 = <not used>

		int totalSteps = 2;
		int stepCount = 0;

		String program = AseUtil.nullToBlank(parm1);
		String sloCode = AseUtil.nullToBlank(parm2);

		/*
		 * 1) get user information
		 *	2) create outline in modify mode
		 *	3) create campus entry
		 *	4) create task for proposer
		 */

		try {

			// 1
			User usr = UserDB.getUserByName(conn, user);

			historyID = SQLUtil.createHistoryID(1);

			AseUtil.logAction(conn, user, "ACTION","Outline create ("+ alpha + " " + num + ")",alpha,num,campus,historyID);

			if (debug) logger.info("historyID: " + historyID);

			conn.setAutoCommit(false);

			// 2
			String reason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br/>"
									+ comments;
			sql = "INSERT INTO tblCourse(id,historyid,coursealpha,coursenum,proposer,coursetitle,campus,dispid,division,"
				+ "dateproposed,"+Constant.COURSE_REASON+",coursetype,edit,edit0,edit1,edit2,auditdate,route) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,'PRE',1,'','1','1',?,0)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,historyID);
			ps.setString(2,historyID);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,user);
			ps.setString(6,title);
			ps.setString(7,campus);
			ps.setString(8,usr.getDepartment());
			ps.setString(9,usr.getDivision());
			ps.setString(10,AseUtil.getCurrentDateTimeString());
			ps.setString(11,reason);
			ps.setString(12,AseUtil.getCurrentDateTimeString());
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("created course data - " + rowsAffected + " row");
			ps.close();
			if (rowsAffected >= 0) ++stepCount;

			// 3
			sql = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,auditby,campus,"+Constant.EXPLAIN_REASONSFORMODS+") VALUES(?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, historyID);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, user);
			ps.setString(5, campus);
			ps.setString(6, comments);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("created campus data - " + rowsAffected + " row");
			if (rowsAffected >= 0) ++stepCount;

			// make sure we got the key rows added
			if (stepCount == totalSteps){

				conn.commit();

				conn.setAutoCommit(true);

				// 4
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.MODIFY_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER,
														"",
														"",
														"NEW");
				AseUtil.logAction(conn, user, "CREATE", "Outline created",alpha, num, campus,historyID);

				if (debug) logger.info("created tasks");

				//-----------------------------------------
				// IncludeGESLOOnCreate
				//-----------------------------------------
				String includeGESLOOnCreate =
						IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeGESLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_GESLO) &&
						includeGESLOOnCreate.equals(Constant.ON) ){

					rowsAffected = ValuesDB.addSrcToOutline(conn,
																		Constant.IMPORT_GESLO,
																		historyID,
																		campus,
																		alpha,
																		num,
																		Constant.PRE,
																		user);

					if (debug) logger.info("created default GESLO - " + rowsAffected + " rows");
				} // IncludeGESLOOnCreate

				//-----------------------------------------
				// IncludeILOOnCreate
				//-----------------------------------------
				String includeILOOnCreate =
						IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeILOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_INSTITUTION_LO) &&
						includeILOOnCreate.equals(Constant.ON) ){

					rowsAffected = ValuesDB.addSrcToOutline(conn,
																		Constant.IMPORT_ILO,
																		historyID,
																		campus,
																		alpha,
																		num,
																		Constant.PRE,
																		user);

					if (debug) logger.info("created default ILO - " + rowsAffected + " rows");
				} // IncludeILOOnCreate

				//-----------------------------------------
				// IncludePLOOnCreate
				//-----------------------------------------
				// PLO gets its list of names from a division or program name
				// 1) check to see if program SLO is included
				// 2) if yes, is the need to include PLO turned on in system settings
				String includePLOOnCreate =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludePLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_PROGRAM_SLO) &&
						includePLOOnCreate.equals(Constant.ON)){

					// at program level
					//if (program != null && program.length() > 0){
					//	rowsAffected = ValuesDB.insertListFromTopicSubtopic(conn,
					//																		campus,
					//																		historyID,
					//																		user,
					//																		Constant.COURSE_PROGRAM_SLO,
					//																		program);
					//	if (rowsAffected > 0){
					//		AseUtil.logAction(conn, user, "ACTION","Imported program level PSLO on create",
					//										program,"",campus,historyID);
					//	}
					//} // program

					// at alpha level
					rowsAffected = ValuesDB.addSrcToOutline(conn,
																		Constant.IMPORT_PLO,
																		historyID,
																		campus,
																		alpha,
																		num,
																		Constant.PRE,
																		user);

					if (debug) logger.info("created default PSLO - " + rowsAffected + " rows");

					// at div/department level
					//String div = ChairProgramsDB.getDivisionFromCampusAlpha(conn,campus,alpha);
					//if (div != null && div.length() > 0){
					//	rowsAffected = ValuesDB.insertListFromTopicSubtopic(conn,
					//																		campus,
					//																		historyID,
					//																		user,
					//																		Constant.COURSE_PROGRAM_SLO,
					//																		div);
					//	if (rowsAffected > 0){
					//		AseUtil.logAction(conn, user, "ACTION","Imported div/dept level PSLO on create",
					//										div,"",campus,historyID);
					//	}
					//} // div

				} // IncludePLOOnCreate

				//-----------------------------------------
				// IncludeSLOOnCreate
				//-----------------------------------------
				// SLO gets its list of names from a division or program name
				// 1) check to see if SLO is included
				// 2) if yes, is the need to include SLO turned on in system settings
				String includeSLOOnCreate =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeSLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_OBJECTIVES) &&
						includeSLOOnCreate.equals(Constant.ON)){

					//rowsAffected = CompDB.insertListFromSrc(conn,
					//													campus,
					//													historyID,
					//													user,
					//													Constant.COURSE_OBJECTIVES,
					//													sloCode);


					// import by alpha
					rowsAffected = CompDB.insertListFromSrc(conn,
																		campus,
																		historyID,
																		user,
																		Constant.IMPORT_SLO,
																		alpha);

					if (debug) logger.info("created default SLO - " + rowsAffected + " rows");

				} // IncludeSLOOnCreate

				//
				// update campus outline
				//
				CampusDB.updateCampusOutline(conn,historyID,campus);
				if (debug) logger.info("updateCampusOutline entry created");

				// for html print processing
				Html.updateHtml(conn,Constant.COURSE,historyID);
				if (debug) logger.info(" HTML entry created");

				created = true;

				AseUtil.logAction(conn, user, "ACTION","Outline created ("+ alpha + " " + num + ")",alpha,num,campus,historyID);

			} // stepCount == totalSteps
			else{

				// rollback if we are not successful

			} // stepcount

			ps.close();


		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseCreate: createOutline - " + ex.toString());

			created = false;

			if (conn != null) {
				try {
					logger.fatal("CourseCreate: createOutline - Transaction is being rolled back");
					conn.rollback();
				} catch(SQLException excep) {
					logger.fatal("CourseCreate: createOutline - Transaction rolled back error");
				}
			}

		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(historyID + " - CourseCreate: createOutline - " + e.toString());

			created = false;
		} finally {
			conn.setAutoCommit(true);
		}

		return created;
	} // CourseCreate: createOutlineX

	 public static boolean createOutlineOBSOLETE(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus,
													String parm1,
													String parm2,
													String parm3) throws Exception {

		boolean rtn = false;

		if (debug) logger.info("------------------- createoutline START");

		boolean exist = CourseDB.courseExist(conn,campus,alpha,num);
		if (!exist){
			rtn = createOutlineX(conn,alpha,num,title,comments,user,campus,parm1,parm2,parm3);

			if (!rtn){
				if (debug) logger.info("Outline created.");
			}
			else{
				if (debug) logger.info("Unable to create outline.");
			}
		}
		else{
			if (debug) logger.info("Unable to create outline.");
		}

		if (debug) logger.info("------------------- createoutline END");

		return rtn;

	}

	 public static boolean createOutlineXOBSOLETE(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus,
													String parm1,
													String parm2,
													String parm3) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean created = false;
		String historyID = "";
		String sql = "";
		int rowsAffected = 0;

		// parm1 = division code
		// parm2 = <not used>
		// parm2 = <not used>

		int totalSteps = 2;
		int stepCount = 0;

		String program = AseUtil.nullToBlank(parm1);
		String sloCode = AseUtil.nullToBlank(parm2);

		/*
		 * 1) get user information
		 *	2) create outline in modify mode
		 *	3) create campus entry
		 *	4) create task for proposer
		 */

		try {

			// 1
			User usr = UserDB.getUserByName(conn, user);

			historyID = SQLUtil.createHistoryID(1);

			AseUtil.logAction(conn, user, "ACTION","Outline create ("+ alpha + " " + num + ")",alpha,num,campus,historyID);

			if (debug) logger.info("historyID: " + historyID);

			conn.setAutoCommit(false);

			// 2
			String reason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br/>"
									+ comments;
			sql = "INSERT INTO tblCourse(id,historyid,coursealpha,coursenum,proposer,coursetitle,campus,dispid,division,"
				+ "dateproposed,"+Constant.COURSE_REASON+",coursetype,edit,edit0,edit1,edit2,auditdate,route) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,'PRE',1,'','1','1',?,0)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,historyID);
			ps.setString(2,historyID);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,user);
			ps.setString(6,title);
			ps.setString(7,campus);
			ps.setString(8,usr.getDepartment());
			ps.setString(9,usr.getDivision());
			ps.setString(10,AseUtil.getCurrentDateTimeString());
			ps.setString(11,reason);
			ps.setString(12,AseUtil.getCurrentDateTimeString());
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("created course data - " + rowsAffected + " row");
			ps.close();
			if (rowsAffected >= 0) ++stepCount;

			// 3
			sql = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,auditby,campus,"+Constant.EXPLAIN_REASONSFORMODS+") VALUES(?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, historyID);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, user);
			ps.setString(5, campus);
			ps.setString(6, comments);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("created campus data - " + rowsAffected + " row");
			if (rowsAffected >= 0) ++stepCount;

			// make sure we got the key rows added
			if (stepCount == totalSteps){

				conn.commit();

				conn.setAutoCommit(true);

				// 4
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														alpha,
														num,
														Constant.MODIFY_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER);
				AseUtil.logAction(conn, user, "CREATE", "Outline created",alpha, num, campus,historyID);

				if (debug) logger.info("created tasks");

				//-----------------------------------------
				// IncludeGESLOOnCreate
				//-----------------------------------------
				String includeGESLOOnCreate =
						IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeGESLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_GESLO) &&
						includeGESLOOnCreate.equals(Constant.ON) ){

					rowsAffected = ValuesDB.addSrcToOutline(conn,
																		Constant.COURSE_GESLO,
																		historyID,
																		campus,
																		alpha,
																		num,
																		Constant.PRE,
																		user);
					if (debug) logger.info("created default geslo - " + rowsAffected + " rows");
				} // IncludeGESLOOnCreate

				//-----------------------------------------
				// IncludeILOOnCreate
				//-----------------------------------------
				String includeILOOnCreate =
						IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeILOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_INSTITUTION_LO) &&
						includeILOOnCreate.equals(Constant.ON) ){

					rowsAffected = ValuesDB.addSrcToOutline(conn,
																		Constant.IMPORT_ILO,
																		historyID,
																		campus,
																		alpha,
																		num,
																		Constant.PRE,
																		user);
					if (debug) logger.info("created default geslo - " + rowsAffected + " rows");
				} // IncludeILOOnCreate

				//-----------------------------------------
				// IncludePLOOnCreate
				//-----------------------------------------
				// PLO gets its list of names from a division or program name
				// 1) check to see if program SLO is included
				// 2) if yes, is the need to include PLO turned on in system settings
				String includePLOOnCreate =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludePLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_PROGRAM_SLO) &&
						includePLOOnCreate.equals(Constant.ON)){

					// at program level
					//if (program != null && program.length() > 0){
					//	rowsAffected = ValuesDB.insertListFromTopicSubtopic(conn,
					//																		campus,
					//																		historyID,
					//																		user,
					//																		Constant.COURSE_PROGRAM_SLO,
					//																		program);
					//	if (rowsAffected > 0){
					//		AseUtil.logAction(conn, user, "ACTION","Imported program level PSLO on create",
					//										program,"",campus,historyID);
					//	}
					//} // program

					// at alpha level
					rowsAffected = ValuesDB.insertListFromTopicSubtopic(conn,
																						campus,
																						historyID,
																						user,
																						Constant.COURSE_PROGRAM_SLO,
																						alpha);
					if (rowsAffected > 0){
						AseUtil.logAction(conn, user, "ACTION","Imported alpha level PSLO on create",
														alpha,num,campus,historyID);
					}

					// at div/department level
					//String div = ChairProgramsDB.getDivisionFromCampusAlpha(conn,campus,alpha);
					//if (div != null && div.length() > 0){
					//	rowsAffected = ValuesDB.insertListFromTopicSubtopic(conn,
					//																		campus,
					//																		historyID,
					//																		user,
					//																		Constant.COURSE_PROGRAM_SLO,
					//																		div);
					//	if (rowsAffected > 0){
					//		AseUtil.logAction(conn, user, "ACTION","Imported div/dept level PSLO on create",
					//										div,"",campus,historyID);
					//	}
					//} // div

				} // IncludePLOOnCreate

				//-----------------------------------------
				// IncludeSLOOnCreate
				//-----------------------------------------
				// SLO gets its list of names from a division or program name
				// 1) check to see if SLO is included
				// 2) if yes, is the need to include SLO turned on in system settings
				String includeSLOOnCreate =
					IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","IncludeSLOOnCreate");
				if (	QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_OBJECTIVES) &&
						includeSLOOnCreate.equals(Constant.ON)){

					rowsAffected = CompDB.insertListFromSrc(conn,
																		campus,
																		historyID,
																		user,
																		Constant.COURSE_OBJECTIVES,
																		sloCode);


					// import by alpha
					rowsAffected = CompDB.insertListFromSrc(conn,
																		campus,
																		historyID,
																		user,
																		Constant.IMPORT_SLO,
																		alpha);

					if (debug) logger.info("created default objectives - " + rowsAffected + " rows");

				} // IncludeSLOOnCreate

				//
				// update campus outline
				//
				CampusDB.updateCampusOutline(conn,historyID,campus);
				if (debug) logger.info("updateCampusOutline entry created");

				// for html print processing
				Html.updateHtml(conn,Constant.COURSE,historyID);
				if (debug) logger.info(" HTML entry created");

				created = true;

				AseUtil.logAction(conn, user, "ACTION","Outline created ("+ alpha + " " + num + ")",alpha,num,campus,historyID);

			} // stepCount == totalSteps
			else{

				// rollback if we are not successful

			} // stepcount

			ps.close();


		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseCreate: createOutline - " + ex.toString());

			created = false;

			if (conn != null) {
				try {
					logger.fatal("CourseCreate: createOutline - Transaction is being rolled back");
					conn.rollback();
				} catch(SQLException excep) {
					logger.fatal("CourseCreate: createOutline - Transaction rolled back error");
				}
			}

		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal(historyID + " - CourseCreate: createOutline - " + e.toString());

			created = false;
		} finally {
			conn.setAutoCommit(true);
		}

		return created;
	}

	public void close() throws SQLException {}

}