/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int cancelProgram(Connection conn,Programs program) {
 *	public static Msg cancelProgramReview(Connection conn,String campus,String kix,String user) throws Exception {
 *	public static int countPendingOutlinesForApproval(Connection conn,String campus,int division) throws SQLException {
 *	public static int countProgramQuestions(Connection conn,String campus) throws Exception {
 *	public static int deleteProgram(Connection conn,Programs program) {
 *	public static boolean enablingDuringApproval(Connection conn,String campus,String kix) throws Exception {
 *	public static HashMap enabledEditItems(Connection conn,String campus,String kix) throws Exception {
 *	public static boolean enableProgramItems(Connection conn,String campus,String kix,String user) {
 *	public static String getApproverNames(Connection conn,String campus,int route) throws Exception {
 *	public static ArrayList getColumnNames(Connection conn,String campus) {
 *	public static String getHistoryIDFromTitle(Connection conn,String campus,String title,String type) {
 *	public static int getLastPersonToApproveSeq(Connection conn,String campus,String kix){
 *	public static int getLastSequenceToApprove(Connection conn,String campus,String kix) throws SQLException {
 *	public static Programs getProgram(Connection conn,String campus,int id) {
 *	public static ArrayList getProgramAnswers(Connection conn,String campus,int id) {
 *	public static String getProgramDivision(Connection conn,String campus,String kix) throws SQLException {
 *	public static String getProgramEdit1(Connection conn,String campus,String kix) throws SQLException {
 *	public static String getProgramEdit2(Connection conn,String campus,String kix) throws SQLException {
 *	public static String[] getProgramEdits(Connection conn,String campus,String kix) throws SQLException {
 *	public static String getProgramForCourseDisplay(Connection conn,String campus,String kix) throws Exception {
 *	public static String getProgramProgress(Connection conn,String campus,String kix) throws SQLException {
 *	public static String getProgramProposer(Connection conn,String campus,String kix) {
 *	public static int getProgramSequenceByNumber(Connection conn,String campus,int number) throws Exception {
 *	public static String getProgramTitle(Connection conn,String campus,String kix) {
 *	public static int getProgramRoute(Connection conn,String campus,String kix) {
 *	public static ArrayList getProgramQuestions(Connection conn,String campus) {
 *	public static String getSubProgress(Connection conn,String kix){
 *	public static int insertProgram(Connection conn,Programs program) {
 *	public static boolean isApprovedProgramEditable(Connection conn,String campus,String kix) {
 *	public static boolean isAProgram(Connection conn,String campus,String kix) throws SQLException {
 *	public static boolean isEditable(Connection conn,String campus,String kix,String user) {
 *	public static boolean isNewProgram(Connection conn,String campus,String title,int degree,int division) throws SQLException {
 *	public static boolean isNextApprover(Connection conn,String campus,String kix,String user,int route) throws SQLException {
 *	public static boolean isProgramRestorable(Connection conn,String kix,String user) throws SQLException {
 *	public static boolean isProgramReviewable(Connection connection,
 *															String campus,
 *															String kix,
 *															String user) throws SQLException {
 *	public static Msg isProgramDeleteCancellable(Connection conn,String campus,String kix,String user){
 *	public static String listProgramAttachments(Connection conn,String campus,String kix){
 *	public static String listProgramsOutlinesDesignedFor(Connection conn,String campus,String kix){
 *	public static boolean programExistByTitleCampus(Connection conn,String campus,String kix,String type) throws SQLException {
 *	public static int programsRequiringApproval(Connection conn,String kix) throws Exception {
 *	public static Msg reviewProgram(Connection conn,String campus,String kix,String user) throws Exception {
 *	public static int setProgramEdit(Connection conn,String campus,String kix,String edits) throws SQLException {
 *	public static String showApprovalProgress(Connection conn,String campus,String user){
 *	public static Msg showCompletedApprovals(Connection conn,String campus,String kix){
 *	public static String showPendingApprovals(Connection conn,String campus,String kix,String completed,int route){
 *	public static String showProgramProgress(Connection conn,String campus){
 *	public static int updateReason(Connection conn,String kix,String reason,String user) throws Exception {
 *	public static String viewProgram(Connection conn,String campus,String kix,String type) {
 *
 * @author ttgiang
 */

//
// ProgramsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ResourceBundle;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class ProgramsDB {

	static Logger logger = Logger.getLogger(ProgramsDB.class.getName());

	public ProgramsDB() throws Exception {}

	/**
	 * getProgramQuestions
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList getProgramQuestions(Connection conn,String campus) {

		ArrayList<String> questions = new ArrayList<String>();

		String sql = "SELECT seq,question "
						+ "FROM vw_programitems "
						+ "WHERE campus=? "
						+ "AND include='Y' "
						+ "AND seq>0 "
						+ "ORDER BY seq";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				questions.add(AseUtil.nullToBlank(rs.getString("seq"))
							+ ". "
							+ AseUtil.nullToBlank(rs.getString("question")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramQuestions - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramQuestions - " + ex.toString());
		}

		return questions;
	}

	/**
	 * getColumnNames
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList getColumnNames(Connection conn,String campus) {

		ArrayList<String> columns = new ArrayList<String>();

		String sql = "SELECT Field_Name "
					+ "FROM vw_programitems "
					+ "WHERE campus=? "
					+ "AND include='Y' "
					+ "AND seq>0 "
					+ "ORDER BY Seq";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				columns.add(AseUtil.nullToBlank(rs.getString("Field_Name")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getColumnNames - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getColumnNames - " + ex.toString());
		}

		return columns;
	}

	/**
	 * getProgramAnswers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 * @return	ArrayList
	 */
	public static ArrayList getProgramAnswers(Connection conn,String campus,String kix,String type) {

		//Logger logger = Logger.getLogger("test");

		ArrayList<String> answers = null;

		int numberOfAnswers = 0;
		String questions = "";

		try{
			questions = QuestionDB.getProgramColumns(conn,campus);

			if (questions != null){
				String sql = "SELECT " + questions + " FROM tblPrograms WHERE campus=? AND historyid=? AND type=?";
				numberOfAnswers = ProgramsDB.countProgramQuestions(conn,campus);
				if (numberOfAnswers > 0){
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,type);
					ResultSet rs = ps.executeQuery();
					if(rs.next()){
						answers = new ArrayList<String>();
						String[] aQuestions = questions.split(",");

						for(int i=0; i<numberOfAnswers; i++){
							answers.add(AseUtil.nullToBlank(rs.getString(aQuestions[i])));
						}
					}
					rs.close();
					ps.close();
				}
			} // questions != null

		} catch (SQLException e) {
			logger.fatal("ProgramsDB.getProgramAnswers\n" + questions + "\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB.getProgramAnswers\n" + questions + "\n" + e.toString());
		}

		return answers;
	}

	/**
	 * getProgram
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	Programs
	 */
	public static Programs getProgram(Connection conn,String campus,String kix) {

		String sql = "SELECT * "
					+ "FROM vw_ProgramForViewing "
					+ "WHERE campus=? "
					+ "AND historyid=?";

		Programs program = null;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				program = new Programs();
				program.setAuditBy(AseUtil.nullToBlank(rs.getString("Updated By")));

				AseUtil aseUtil = new AseUtil();
				program.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("Updated Date"),Constant.DATE_DATETIME));

				program.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				program.setDegree(rs.getInt("degreeid"));
				program.setDegreeDescr(AseUtil.nullToBlank(rs.getString("degreeTitle")));
				program.setDegreeTitle(AseUtil.nullToBlank(rs.getString("degreeTitle")));
				program.setDescription(AseUtil.nullToBlank(rs.getString("descr")));
				program.setDivision(rs.getInt("divisionid"));
				program.setDivisionDescr(AseUtil.nullToBlank(rs.getString("divisionname")));
				program.setDivisionName(AseUtil.nullToBlank(rs.getString("divisionname")));
				program.setEffectiveDate(AseUtil.nullToBlank(rs.getString("Effective Date")));
				program.setDescription(AseUtil.nullToBlank(rs.getString("descr")));
				program.setHistoryId(AseUtil.nullToBlank(rs.getString("historyid")));
				program.setProgram(AseUtil.nullToBlank(rs.getString("program")));
				program.setProgress(AseUtil.nullToBlank(rs.getString("progress")));
				program.setProposer(AseUtil.nullToBlank(rs.getString("proposer")));
				program.setRoute(rs.getInt("route"));
				program.setSubProgress(AseUtil.nullToBlank(rs.getString("subprogress")));
				program.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				program.setType(AseUtil.nullToBlank(rs.getString("type")));

				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgram - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgram - " + ex.toString());
		}

		return program;
	}

	/**
	 * getProgramToModify
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	Programs
	 */
	public static Programs getProgramToModify(Connection conn,String campus,String kix) {

		String sql = "SELECT * FROM vw_ProgramForViewing WHERE campus=? AND historyid=?";

		Programs program = null;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				AseUtil aseUtil = new AseUtil();
				program = new Programs();
				program.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				program.setHistoryId(AseUtil.nullToBlank(rs.getString("historyid")));
				program.setDegreeDescr(AseUtil.nullToBlank(rs.getString("program")));
				program.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				program.setEffectiveDate(AseUtil.nullToBlank(rs.getString("effectivedate")));
				program.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				program.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
				program.setType(AseUtil.nullToBlank(rs.getString("type")));
				program.setDegree(rs.getInt("degreeid"));
				program.setDescription(AseUtil.nullToBlank(rs.getString("descr")));
				program.setDegreeTitle(AseUtil.nullToBlank(rs.getString("degreeTitle")));
				program.setProgress(AseUtil.nullToBlank(rs.getString("progress")));
				program.setDivision(rs.getInt("divisionid"));
				program.setProposer(AseUtil.nullToBlank(rs.getString("proposer")));
				program.setDivisionDescr(AseUtil.nullToBlank(rs.getString("divisioncode")));
				program.setRoute(rs.getInt("route"));
				program.setSubProgress(AseUtil.nullToBlank(rs.getString("subprogress")));
				program.setDivisionName(AseUtil.nullToBlank(rs.getString("divisionname")));
				program.setProgram(AseUtil.nullToBlank(rs.getString("program")));
				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramToModify - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramToModify - " + ex.toString());
		}

		return program;
	}

	/**
	 * Program
	 * <p>
	 * @param conn
	 * @param program
	 * <p>
	 * @return int
	 */
	public static int insertProgram(Connection conn,Programs program) {
		int rowsAffected = 0;
		int i = 0;
		String sql = "INSERT INTO tblPrograms(campus,historyid,type,degreeid,divisionid,effectivedate,title,descr,auditby,auditdate,proposer,progress,regents,edit,edit0,edit1,edit2) "
			+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,1,'','1','1')";
		try {

			String kix = SQLUtil.createHistoryID(1);
			String campus = program.getCampus();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(++i, campus);
			ps.setString(++i, kix);
			ps.setString(++i, "PRE");
			ps.setInt(++i, program.getDegree());
			ps.setInt(++i, program.getDivision());
			ps.setString(++i, program.getEffectiveDate());
			ps.setString(++i, program.getTitle());
			ps.setString(++i, program.getDescription());
			ps.setString(++i, program.getAuditBy());
			ps.setString(++i, AseUtil. getCurrentDateTimeString());
			ps.setString(++i, program.getProposer());
			ps.setString(++i, program.getProgress());
			ps.setBoolean(++i, program.getRegentsApproval());
			rowsAffected = ps.executeUpdate();
			ps.close();

			AseUtil.logAction(conn,
									program.getProposer(),
									"ACTION",
									"Program added " + program.getTitle(),
									"",
									"",
									campus,
									kix);

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: insertProgram - " + e.toString());
		} catch(Exception e){
			logger.fatal("ProgramsDB: insertProgram - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteProgram
	 * <p>
	 * @param conn
	 * @param program
	 * <p>
	 * @return int
	 */
	public static int deleteProgram(Connection conn,Programs program) {

		/*
			delete refers to deleting of an approved outline
		*/

		int rowsAffected = 0;
		String sql = "UPDATE tblPrograms SET type='ARC',progress='ARCHIVED',auditby=?,auditdate=?,datedeleted=? WHERE type='CUR' AND historyid=?";
		try {
			String kix = program.getHistoryId();
			String[] info = Helper.getKixInfo(conn,kix);

			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];
			String title = info[Constant.KIX_PROGRAM_TITLE];

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, program.getAuditBy());
			ps.setString(2, AseUtil. getCurrentDateTimeString());
			ps.setString(3, AseUtil. getCurrentDateTimeString());
			ps.setString(4, kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			AseUtil.logAction(conn,
									proposer,
									"ACTION",
									"Program deleted " + title,
									"",
									"",
									campus,
									kix);
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: deleteProgram - " + e.toString());
		} catch(Exception e){
			logger.fatal("ProgramsDB: deleteProgram - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * cancelProgram
	 * <p>
	 * @param conn
	 * @param program
	 * <p>
	 * @return int
	 */
	public static Msg cancelProgram(Connection conn,Programs program) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Msg msg = new Msg();

		String type = "PRE";

		String taskText = "";

		try{
			String kix = program.getHistoryId();
			String campus = program.getCampus();
			String user = program.getAuditBy();
			if (kix != null && kix.length() > 0){

				String progress = getProgramProgress(conn,campus,kix);

				if (progress.equals(Constant.PROGRAM_DELETE_PROGRESS)){
					taskText = Constant.PROGRAM_DELETE_TEXT;
				}
				else if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
					taskText = Constant.PROGRAM_REVIEW_TEXT;
				}
				else if (progress.equals(Constant.PROGRAM_REVISE_PROGRESS)){
					taskText = Constant.PROGRAM_REVISE_TEXT;
				}
				else{
					taskText = Constant.PROGRAM_MODIFY_TEXT;
				}

				if (isCancellable(conn,kix,user)) {

					rowsAffected = cancelProgramX(conn,program);
					if (rowsAffected > 0){
						String title = getProgramTitle(conn,campus,kix);

						msg.setMsg("Canceled");

						rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
																Constant.PROGRAM_MODIFY_TEXT,
																campus,"","REMOVE","",
																"","",kix,Constant.PROGRAM);

						rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
																Constant.PROGRAM_REVIEW_TEXT_EXISTING,
																campus,"","REMOVE","PRE",
																"","",kix);

						rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
																Constant.PROGRAM_REVIEW_TEXT,
																campus,"","REMOVE","PRE",
																"","",kix);

						rowsAffected = TaskDB.logTask(conn,"ALL",user,title,"",
																Constant.PROGRAM_REVIEW_TEXT_NEW,
																campus,"","REMOVE","PRE",
																"","",kix);
					} // rowsAffected
					else{
						msg.setMsg("CancelFailure");
					}

				} else {
					msg.setMsg("NotCancellable");
				}
			} else {
				msg.setMsg("NotAvailableToCancel");
			} // valid kix
		}
		catch(SQLException se){
			logger.fatal("CourseCancel: cancelProgramX\n" + se.toString());
		}
		catch(Exception e){
			logger.fatal("CourseCancel: cancelProgramX\n" + e.toString());
		}

		return msg;
	}

	/**
	 * cancelProgram
	 * <p>
	 * @param conn
	 * @param program
	 * <p>
	 * @return int
	 */
	public static int cancelProgramX(Connection conn,Programs program) {

		//
		//	cancellation refers to cancelling of a proposed outline
		//

		int rowsAffected = 0;
		String sql = "UPDATE tblPrograms SET type='CAN',progress='CANCELLED',auditby=?,auditdate=? WHERE type='PRE' AND historyid=?";
		try {
			String kix = program.getHistoryId();
			String[] info = Helper.getKixInfo(conn,kix);

			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];
			String title = info[Constant.KIX_PROGRAM_TITLE];

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, program.getAuditBy());
			ps.setString(2, AseUtil. getCurrentDateTimeString());
			ps.setString(3, kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			AseUtil.logAction(conn,
									proposer,
									"ACTION",
									"Program cancelled " + title,
									"",
									"",
									campus,
									kix);

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: cancelProgram - " + e.toString());
		} catch(Exception e){
			logger.fatal("ProgramsDB: cancelProgram - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * Count number of campus questions
	 *	<p>
	 *	@return int
	 */
	public static int countProgramQuestions(Connection conn,String campus) throws Exception {

		int count = 0;

		try {
			AseUtil aseUtil = new AseUtil();
			String sql = "WHERE include='Y' AND seq>0 AND campus=" + aseUtil.toSQL(campus, 1);
			count = (int)AseUtil.countRecords(conn, "vw_programitems", sql);
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: countProgramQuestions - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: countProgramQuestions - " + e.toString());
		}

		return count;
	}

	/*
	 * Returns true if the program exists in a particular type and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 */
	public static boolean programExistByTypeCampus(Connection conn,String campus,String kix,String type) throws SQLException {

		boolean found = false;
		boolean debug = false;

		try {
			// unlike courses, programs are based on titles, degrees, and divisions

			String[] info = getProgramBasics(conn,campus,kix,type);
			String title = info[0];
			int degreeid = NumericUtil.getInt(info[1],0);
			int divisionid = NumericUtil.getInt(info[2],0);

			if(info != null && info.length==3){

				if (debug){
					logger.info("campus: " + campus);
					logger.info("kix: " + kix);
					logger.info("title: " + title);
					logger.info("degreeid: " + degreeid);
					logger.info("divisionid: " + divisionid);
					logger.info("type: " + type);
				}

				String sql = "SELECT type FROM tblPrograms WHERE campus=? AND title=? AND degreeid=? AND divisionid=? AND type=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,title);
				ps.setInt(3,degreeid);
				ps.setInt(4,divisionid);
				ps.setString(5,type);
				ResultSet rs = ps.executeQuery();
				found = rs.next();
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: programExistByTypeCampus - " + e.toString());
		}

		return found;
	}

	/**
	 * getProgramBasics
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getProgramBasics(Connection conn,String campus,String kix,String type){

		//Logger logger = Logger.getLogger("test");

		String[] info = new String[3];
		try{
			String sql = "SELECT title,degreeid,divisionid FROM tblPrograms WHERE campus=? AND historyid=? AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				info[0] = AseUtil.nullToBlank(rs.getString("title"));
				info[1] = "" + rs.getInt("degreeid");
				info[2] = "" + rs.getInt("divisionid");
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: getProgramBasics - " + ex.toString());
		}

		return info;
	}

	/*
	 * Returns true if the program exists in a particular title and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 */
	public static boolean programExistByTitleCampus(Connection conn,String campus,String kix,String type) throws SQLException {

		/*
			using the kix, find the title of the program. With the title, find whether it exists already before
			allowing to modify
		*/

		//Logger logger = Logger.getLogger("test");

		boolean bTitle = false;
		String title = "";

		try {

			Programs programs = ProgramsDB.getProgram(conn,campus,kix);
			if (programs != null){

				int degree = programs.getDegree();
				int division = programs.getDivision();

				String sql = "SELECT title FROM tblPrograms WHERE campus=? AND historyid=?";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					title = AseUtil.nullToBlank(rs.getString("title"));
					if (title != null && degree > 0 && division > 0){
						rs.close();

						sql = "SELECT seq FROM tblPrograms WHERE campus=? AND title=? AND degreeid=? AND divisionid=? AND type=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,title);
						ps.setInt(3,degree);
						ps.setInt(4,division);
						ps.setString(5,type);
						rs = ps.executeQuery();
						bTitle = rs.next();
					}
				}
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: programExistByTitleCampus - " + e.toString());
		}

		return bTitle;
	}

	/*
	 * Returns true if the program exists in a particular title and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	title		String
	 * @param	degree	int
	 * @param	division	int
	 * <p>
	 */
	public static boolean programExistByTitleCampus(Connection conn,String campus,String title,int degree,int division) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean found = false;

		try {
			String sql = "SELECT seq FROM tblPrograms WHERE campus=? AND title=? AND degreeid=? AND divisionid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,title);
			ps.setInt(3,degree);
			ps.setInt(4,division);
			ResultSet rs = ps.executeQuery();
			found = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: programExistByTitleCampus - " + e.toString());
		}

		return found;
	}

	/**
	 * viewProgram
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * @param	type
	 * <p>
	 * @return	String
	 */
	public static String viewProgram(Connection conn,String campus,String kix,String type) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();
		String t1 = "";
		String t2 = "";
		String t3 = "";
		String temp = "";

		String question = null;

		int i = 0;

		String row1 = "<tr>"
			+"<td height=\"20\" class=textblackTH width=\"02%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" width=\"98%\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"02%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"datacolumn\" width=\"98%\" valign=\"top\"><| answer |></td>"
			+"</tr>";

		String extra = "<tr>"
			+"<td height=\"20\" colspan=\"2\" valign=\"top\">"
			+ "<fieldset class=\"FIELDSET100\"><legend>Other Departments</legend><| extra |></fieldset><br/>"
			+ "</td>"
			+"</tr>";

		try{
			String auditby = "";
			String auditdate = "";
			String title = "";
			String effectiveDate = "";
			String description = "";
			String degreeDescr = "";
			String divisionDescr = "";
			int degree = 0;
			int division = 0;

			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			if (!"".equals(kix)){
				Programs program = ProgramsDB.getProgram(conn,campus,kix);
				if ( program != null ){
					title = program.getTitle();
					effectiveDate  = program.getEffectiveDate();
					description = program.getDescription();
					degreeDescr = program.getDegreeDescr();
					divisionDescr = program.getDivisionDescr();
					auditby = program.getAuditBy();
					auditdate = program.getAuditDate();
					degree = program.getDegree();
					division = program.getDivision();

					output.append("<table width=\"100%\" summary=\"ase1\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Degree:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + degreeDescr + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Division:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + divisionDescr + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Title:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + title + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Description:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + description + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" valign=\"top\">Effective Date:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + effectiveDate + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td colspan=\"2\"><br/><hr size=\"1\"></td>"
						+ "</tr>"
						+ "</table>");

					ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,type);
					ArrayList columns = ProgramsDB.getColumnNames(conn,campus);

					String column = "";

					if (answers != null){

						i = 0;

						output.append("<table summary=\"ase2\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">");

						// in create mode, LEE only prints 7
						boolean isNewProgram = false;
						isNewProgram = ProgramsDB.isNewProgram(conn,campus,title,degree,division);
						int itemsToPrint = answers.size();

						if (isNewProgram && "LEE".equals(campus))
							itemsToPrint = Constant.PROGRAM_ITEMS_TO_PRINT_ON_CREATE;

						String sql = "SELECT questionseq,question FROM tblProgramQuestions "
										+ "WHERE campus=? AND include='Y' ORDER BY questionseq";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ResultSet rs = ps.executeQuery();
						while(rs.next() && i < itemsToPrint){
							t1 = row1;
							t1 = t1.replace("<| counter |>",AseUtil.nullToBlank(rs.getString("questionseq")));
							t1 = t1.replace("<| question |>",AseUtil.nullToBlank(rs.getString("question")));
							output.append(t1);

							t2 = row2;
							t2 = t2.replace("<| answer |>",(String)answers.get(i));

							output.append(t2);

							column = (String)columns.get(i);

							String enableOtherDepartmentLink = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOtherDepartmentLink");
							if ((Constant.ON).equals(enableOtherDepartmentLink)){
								if (column != null && column.indexOf(Constant.PROGRAM_RATIONALE) > -1){
									temp = ExtraDB.getOtherDepartments(conn,
																					Constant.PROGRAM_RATIONALE,
																					campus,
																					kix,
																					false,
																					true);

									if (temp != null && temp.length() > 0){
										t3 = extra;
										t3 = t3.replace("<| extra |>",temp);
										output.append(t3);
									} // temp
								} // PROGRAM_RATIONALE
							} // enableOtherDepartmentLink

							++i;
						}
						rs.close();
						ps.close();

						output.append("</table>");

					} // answers != null

					String attachments = ProgramsDB.listProgramAttachments(conn,campus,kix);
					if (attachments != null && attachments.length() > 0){
						output.append("<table summary=\"ase3\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\"><tr><td>");
						output.append("<fieldset class=\"FIELDSET100\">"
							+ "<legend>Attachments</legend>"
							+ Html.BR()
							+ attachments
							+ "</fieldset>" );
							output.append("</td></tr></table>");
					}

					String outineSubmissionWithProgram = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutineSubmissionWithProgram");
					int counter = ProgramsDB.countPendingOutlinesForApproval(conn,campus,division);
					if (outineSubmissionWithProgram.equals(Constant.ON) && counter > 0){
						output.append("<table summary=\"ase4\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\"><tr><td>");
						output.append("<fieldset class=\"FIELDSET100\">"
							+ "<legend>Outlines Associated with this Program</legend>"
							+ Html.BR()
							+ Helper.listOutlinesForSubmissionWithProgram(conn,campus,division)
							+ "</fieldset>" );
							output.append("</td></tr></table>");
					}

					output.append("<table summary=\"ase5\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr>"
						+ "<td colspan=\"2\"><br/><hr size=\"1\"></td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Campus:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + campus + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Updated By:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + auditby + "</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td class=\"textblackth\" width=\"25%\" valign=\"top\">Updated Date:&nbsp;</td>"
						+ "<td class=\"datacolumn\" valign=\"top\">" + auditdate + "</td>"
						+ "</tr>"
						+ "</table>");

					temp = "<table summary=\"ase6\" border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>"
							+ "<tr><td>"
							+ output.toString()
							+ "</td></tr>"
							+ "</table>";
				} // program != null
			} // kix != null

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: viewProgram - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: viewProgram - " + ex.toString());
		}

		return temp;
	}

	/**
	 * listProgramAttachments
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String listProgramAttachments(Connection conn,String campus,String kix){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String fullName = "";
		String fileName = "";
		int version = 0;
		int id = 0;
		String link = "";
		String rowColor = "";
		boolean found = false;
		int j = 0;

		try{
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			String sql = "SELECT a.id, a.filename, v.fullname, v.version "
				+ "FROM vw_AttachedLatestVersion v INNER JOIN "
				+ "tblAttach a ON v.historyid = a.historyid "
				+ "AND v.campus = a.campus "
				+ "AND v.version = a.version "
				+ "AND v.fullname = a.fullname "
				+ "WHERE v.historyid=? "
				+ "AND v.campus=? "
				+ "AND (v.category=? OR v.category=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,campus);
			ps.setString(3,Constant.PROGRAM);
			ps.setString(4,"programs");
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				fullName = AseUtil.nullToBlank(rs.getString("fullname"));
				fileName = AseUtil.nullToBlank(rs.getString("filename"));
				version = rs.getInt("version");
				id = rs.getInt("id");

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><a href=\"attchst.jsp?kix="+kix+"&id="+id+"\" title=\"view attachment history\" class=\"linkcolumn\"><img src=\"../images/attachment.gif\" border=\"0\"></a></td>");
				listings.append("<td class=\"datacolumn\"><a href=\""+documentsURL+"programs/"+campus+"/"+fileName+"\" title=\"" + fullName + "\" class=\"linkcolumn\" target=\"_blank\">" + version + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + fullName + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"10%\">History</td>" +
					"<td class=\"textblackth\" width=\"10%\">Version</td>" +
					"<td class=\"textblackth\" width=\"80%\">File Name</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
		}
		catch( SQLException e ){
			logger.fatal("ProgramsDB: listProgramAttachments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ProgramsDB: listProgramAttachments - " + ex.toString());
		}

		return listing;
	}

	/**
	 * getKixInfo
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfo(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int counter = 10;
		String sql = "SELECT tp.title, td.divisioncode, tp.type, tp.proposer, tp.campus, tp.historyid, tp.route, tp.progress, tp.subprogress, tp.title "
						+ "FROM tblPrograms tp INNER JOIN tblDivision td ON tp.campus = td.campus AND tp.divisionid = td.divid "
						+ "WHERE tp.historyid=?";
		String[] info = new String[counter];

		try{
			for (i=0;i<counter;i++)
				info[i] = "";

			String dataType[] = {"s","s","s","s","s","s","i","s","s","s"};

			if (kix != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					info = SQLUtil.resultSetToArray(rs,dataType);
				}
				rs.close();
				ps.close();
			} // kix
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: getKixInfo - " + ex.toString());
			info[0] = "";
		}

		return info;
	}

	/**
	 * getProgramTitle
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String getProgramTitle(Connection conn,String campus,String kix) {

		String sql = "SELECT title "
					+ "FROM vw_ProgramForViewing "
					+ "WHERE campus=? "
					+ "AND historyid=?";

		String title = "";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramTitle - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramTitle - " + ex.toString());
		}

		return title;
	}

	/*
	 * Returns true if the program exists in a particular title and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	title		String
	 * @param	degree	int
	 * @param	division	int
	 * <p>
	 */
	public static boolean isNewProgram(Connection conn,String campus,String title,int degree,int division) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean newProgram = false;

		try {
			String sql = "SELECT COUNT(degreeid) AS counter "
							+ "FROM tblPrograms "
							+ "WHERE campus=? "
							+ "AND title=? "
							+ "AND degreeid=? "
							+ "AND divisionid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,title);
			ps.setInt(3,degree);
			ps.setInt(4,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				int count = rs.getInt("counter");

				// there should only be 1 returned record to be new
				if (count == 1)
					newProgram = true;
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isNewProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isNewProgram - " + e.toString());
		}

		return newProgram;
	}

	/*
	 * Returns true if the kix is a program
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 */
	public static boolean isAProgram(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isPogram = false;

		try {
			String sql = "SELECT degreeid FROM tblPrograms WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			isPogram = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		}

		return isPogram;
	}

	/*
	 * Returns true if the kix is a program
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 */
	public static boolean isAProgram(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isPogram = false;

		try {
			String sql = "SELECT degreeid FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			isPogram = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		}

		return isPogram;
	}

	/*
	 * Returns true if the kix is a program
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 */
	public static boolean isAProgram(Connection conn,String campus,String alpha,String num,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isPogram = false;

		try {
			String sql = "SELECT degreeid FROM tblPrograms WHERE campus=? AND title=? AND divisionid=? AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setInt(3,NumericUtil.getInt(num,0));
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			isPogram = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isAProgram - " + e.toString());
		}

		return isPogram;
	}

	/*
	 * Returns true if the alpha is a title in program
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * <p>
	 */
	public static boolean isAProgramByTitle(Connection conn,String campus,String alpha) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isPogram = false;

		try {
			String sql = "SELECT degreeid FROM tblPrograms WHERE campus=? and title=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			isPogram = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isAProgramByTitle - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isAProgramByTitle - " + e.toString());
		}

		return isPogram;
	}

	/*
	 * Returns true if the kix is a program
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	proposer	Connection
	 * @param	user		String
	 * @param	route		int
	 * <p>
	 */
	public static Msg setProgramForApproval(Connection conn,
															String campus,
															String kix,
															String proposer,
															String user,
															int route,
															String outineSubmissionWithProgram) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		int lastSequence = 0;
		int nextSequence = 1;

		String lastApprover = "";
		String nextApprover = "";

		String lastDelegate = "";
		String nextDelegate = "";

		String completeList = "";
		String lastCompleteList = "";

		String sql = "";

		boolean approvalCompleted = false;

		Approver approver = new Approver();
		boolean approved = false;
		boolean experimental = false;
		PreparedStatement ps = null;
		ResultSet rs = null;

		long count = 0;

		String modifyText = null;
		String approvalText = null;
		String mailProperty = null;
		String alpha = "";
		String num = "";
		String divisionDescr = "";

		boolean debug = DebugDB.getDebug(conn,"ProgramsDB");

		if (debug) logger.info("ProgramDB - setProgramForApproval START");

		try {
			if (debug) {
				logger.info("route - " + route);
				logger.info("proposer - " + proposer);
			}

			approver = ApproverDB.getApprovers(conn,kix,proposer,false,route);
			modifyText = Constant.PROGRAM_MODIFY_TEXT;
			approvalText = Constant.PROGRAM_APPROVAL_TEXT;
			mailProperty = "emailProgramApprovalRequest";

			if (approver != null){

				String[] approvers = new String[20];
				approvers = approver.getAllApprovers().split(",");

				String[] delegates = new String[20];
				delegates = approver.getAllDelegates().split(",");

				String[] completeLists = new String[20];
				completeLists = approver.getAllCompleteList().split(",");

				if (debug){
					logger.info("approvers: " + approver.getAllApprovers());
					logger.info("delegates: " + approver.getAllDelegates());
					logger.info("completeLists: " + approver.getAllCompleteList());
				}

				Programs program = new Programs();
				if (!kix.equals(Constant.BLANK)){
					program = ProgramsDB.getProgramToModify(conn,campus,kix);
					if ( program != null ){
						alpha = program.getTitle();
						divisionDescr = program.getDivisionDescr();
					}
				}

				// if nothing is in history, send mail to first up else who's next
				// get max sequence and determine who was last
				// if last approved, send to next; if last reject, resend
				count = ApproverDB.countApprovalHistory(conn,kix);
				if (count == 0){
					if (debug) logger.info("countApprovalHistory count is 0 or no one started");

					lastSequence = 1;
					nextSequence = 1;
					approved = false;

					nextApprover = approvers[0];
					lastApprover = nextApprover;

					nextDelegate = delegates[0];
					lastDelegate = nextDelegate;

					completeList = completeLists[0];
					lastCompleteList = completeList;
				}
				else{
					sql = "SELECT approver,approved " +
						"FROM tblApprovalHist " +
						"WHERE seq IN " +
						"(SELECT MAX(seq) AS Expr1 " +
						"FROM tblApprovalHist " +
						"WHERE historyid=?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					if (rs.next()) {
						lastApprover = AseUtil.nullToBlank(rs.getString("approver"));
						approved = rs.getBoolean("approved");
						lastSequence = ApproverDB.getApproverSequence(conn,lastApprover,route);
						if (debug) logger.info("lastSequence: " + lastSequence);
					}
					rs.close();
					ps.close();
				}	// if count

				// if approved and not the last person, get next; else where do we go back to
				if (approved){
					if (debug) logger.info("approved");

					if (!lastApprover.equals(approvers[approvers.length-1])){
						nextSequence = lastSequence + 1;

						// adjust for 0th based array
						nextApprover = approvers[--nextSequence];

						approvalCompleted = false;
					}
					else
						approvalCompleted = true;
				}
				else{
					if (debug) logger.info("not approved");

					String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
					if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection)){
						if (debug) logger.info("Constant.REJECT_START_WITH_REJECTER");
						nextApprover = lastApprover;
						nextDelegate = lastDelegate;
						completeList = lastCompleteList;
					}
					else if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection)){
						if (debug) logger.info("Constant.REJECT_START_FROM_BEGINNING");
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						completeList = completeLists[0];
					}
					else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
						if (debug) logger.info("Constant.REJECT_STEP_BACK_ONE");
						// a step back would be the last person to approve this outline in history.
						// since this is rejection, we have to look for the last person to approve
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						completeList = completeLists[0];
					}

					approvalCompleted = false;
				}	// if approved

				if (!approvalCompleted){

					// when not yet completed with approvals and this is the first time in,
					// we also have to check whether we need to send outlines with programs
					if (outineSubmissionWithProgram.equals(Constant.ON)){
						int division = getProgramDivision(conn,campus,kix);
						String outlineProposer = "";
						rowsAffected = 0;
						sql = "SELECT DISTINCT coursealpha,coursenum,proposer " +
							" FROM tblCourse" +
							" WHERE campus=? " +
							" AND progress='PENDING' " +
							" AND coursealpha IN " +
							" ( " +
							" SELECT coursealpha " +
							" FROM tblChairs " +
							" WHERE programid=? " +
							" ) " +
							" ORDER BY coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setInt(2,division);
						rs = ps.executeQuery();
						while(rs.next()){
							++rowsAffected;
							alpha = rs.getString("coursealpha");
							num = rs.getString("coursenum");
							outlineProposer = rs.getString("proposer");
							msg = CourseDB.setCourseForApproval(conn,
																			campus,
																			alpha,
																			num,
																			outlineProposer,
																			Constant.COURSE_APPROVAL_TEXT,
																			route,
																			outlineProposer);
							if (debug) logger.info(rowsAffected + ". outline approval submitted for - " + alpha + " " + num);
						}
						rs.close();
						ps.close();

						//
						// if there are no coures left to send for approval, remove the task created for DC
						//
						int counter = countPendingOutlinesForApproval(conn,campus,division);
						if (counter == 0){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	proposer,
																	"",
																	"",
																	Constant.APPROVAL_PENDING_TEXT,
																	campus,
																	"",
																	"REMOVE",
																	"PRE");
						} // counter

						counter = countPendingOutlinesForDeleteApproval(conn,campus,division);
						if (counter == 0){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	proposer,
																	"",
																	"",
																	Constant.DELETE_APPROVAL_PENDING_TEXT,
																	campus,
																	"",
																	"REMOVE",
																	"PRE");
						} // counter

					} //outineSubmissionWithProgram

					sql = "UPDATE tblPrograms "
							+ "SET edit=0,edit0='',edit1='3',edit2='3',progress=?,route=? "
							+ "WHERE campus=? "
							+ "AND historyid=? "
							+ "AND type='PRE'";
					ps = conn.prepareStatement(sql);
					ps.setString(1,Constant.PROGRAM_APPROVAL_PROGRESS);
					ps.setInt(2,route);
					ps.setString(3,campus);
					ps.setString(4,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("course set for approval");

					// delete modify task for author
					rowsAffected = TaskDB.logTask(conn,
															proposer,
															proposer,
															alpha,
															divisionDescr,
															modifyText,
															campus,
															"",
															"REMOVE",
															"PRE",
															"",
															"",
															kix,
															Constant.PROGRAM);

					if (debug) logger.info("modify task removed - rowsAffected " + rowsAffected);

					ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
					String domain = "@" + bundle.getString("domain");
					String toNames = "";
					String ccNames = "";

					// if the approver list is not complete and there is no approval yet, it's because the division
					// chair was not decided or known.
					if ("0".equals(completeList) && count== 0){
						msg.setCode(1);
						msg.setMsg("forwardURL");
						if (debug) logger.info("forwardURL");
					}
					else{
						rowsAffected = TaskDB.logTask(conn,
																nextApprover,
																proposer,
																alpha,
																divisionDescr,
																approvalText,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_APPROVER,
																kix,
																Constant.PROGRAM);

						if (nextDelegate != null && nextDelegate.length() > 0){
							rowsAffected = TaskDB.logTask(conn,
																	nextDelegate,
																	proposer,
																	alpha,
																	divisionDescr,
																	approvalText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER,
																	kix,
																	Constant.PROGRAM);

							if (debug) logger.info("approval task created - rowsAffected " + rowsAffected);
						}

						User udb = UserDB.getUserByName(conn,nextApprover);
						if (udb.getUH()==1)
							toNames = nextApprover + domain;
						else
							toNames = udb.getEmail();

						if (debug) logger.info("toNames: " + toNames);

						ccNames = "";
						if (nextDelegate != null && nextDelegate.length() > 0 && !nextDelegate.equals(nextApprover)){
							udb = UserDB.getUserByName(conn,nextDelegate);
							if (udb.getUH()==1)
								ccNames = nextDelegate + domain;
							else
								ccNames = udb.getEmail();
						}
						if (debug) logger.info("ccNames: " + ccNames);

						String sender = proposer + domain;

						// include proposer in CC
						if (ccNames != null)
							ccNames = ccNames + "," + proposer;
						else
							ccNames = proposer;

						MailerDB mailerDB = new MailerDB(conn,sender,toNames,ccNames,"",alpha,num,campus,mailProperty,kix,proposer);

						AseUtil.logAction(conn,
												proposer,
												"ACTION",
												"Program approval submitted for "+ toNames,
												alpha,
												num,
												campus,
												kix);

						if (debug) logger.info("mail sent");
					} // complete list
				} // approvalCompleted?
			} // if (approver != null){

		} catch (SQLException ex) {
			logger.fatal(kix + " - ProgramsDB: setProgramForApproval - " + ex.toString());
			msg.setMsg("ProgramApprovalError");
		} catch (Exception e) {
			logger.fatal(kix + " - ProgramsDB: setProgramForApproval - " + e.toString());
		}

		if (debug) logger.info("ProgramsDB - setProgramForApproval END");

		return msg;
	} // setProgramForApproval

	/**
	* isNextApprover - is this the next person to approve
	*
	* @param	conn
	* @param	campus
	* @param	kix
	* @param	user
	*
	**/
	public static boolean isNextApprover(Connection conn,String campus,String kix,String user) throws SQLException {

		int route = getProgramRoute(conn,campus,kix);

		return isNextApprover(conn,campus,kix,user,route);
	}

	public static boolean isNextApprover(Connection conn,String campus,String kix,String user,int route) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean debug = DebugDB.getDebug(conn,"ProgramsDB");

		//debug = true;

		boolean nextApprover = false;
		boolean multiLevel = false;
		int userSequence = 0;
		int lastSequenceToApprove = 0;
		int nextSequence = 0;

		boolean lastApproverVotedNO = false;

		if (debug) {
			logger.info("-------------------------------------------");
			logger.info(user + " - ProgramsDB isNextApprover - STARTS");
		}

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String proposer = info[Constant.KIX_PROPOSER];

		if (debug){
			logger.info("title - " + alpha);
			logger.info("division - " + num);
			logger.info("route - " + route);
		}

		try {
			/*
			 * if a recall took place, allow the person trying to approve and having a task to continue
			 * a recall constitute non-approval
			 *
			 * if the last voter voted NO, then the ideal way is to have it kicked off from the start. That
			 * means the last sequence is 0 or just like no vote yet.
			 *
			 * what is this user's approval sequence (userSequence). if not
			 * found, then the user is not authorize to approve. returns error.
			 * if is part of approval sequence, then determine where in line the
			 * last approver was (lastSequenceToApprove). the last sequence + 1 should be
			 * this user's sequence in order to move on.
			 * if the user is not on the list of approver sequence, are they on a distribution list?
			 * if so, confirm that there is more or less to approve
			 */

			String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.PROGRAM_APPROVAL_TEXT);
			boolean recalledApprovalHistory = HistoryDB.recalledApprovalHistory(conn,kix,alpha,num,user);
			if (taskAssignedToApprover != null
				&& taskAssignedToApprover.length() > 0
				&& taskAssignedToApprover.equals(user)
				&& recalledApprovalHistory){
				return true;
			}
			if (debug){
				logger.info("taskAssignedToApprover - " + taskAssignedToApprover);
				logger.info("recalledApprovalHistory - " + recalledApprovalHistory);
			}

			// was this kicked back for revision? we know it was if the last approved vote was no in history
			// look at the reject system setting to determine when it was kicked back, who it should go to
			lastApproverVotedNO = ApproverDB.lastApproverVotedNO(conn,campus,kix);
			if (lastApproverVotedNO){
				if (debug) logger.info("last approver rejected outline");

				String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
				if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection)){
					lastSequenceToApprove = 0;
					if (debug) logger.info("REJECT_START_FROM_BEGINNING");
				}
				else if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection)){
					// get highest id from history of rejected items
					// that's the person to send to. however, minus one from the sequence so
					// that lastSequenceToApprove + 1 = the correct person
					lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);

					if (debug){
						logger.info("REJECT_START_WITH_REJECTER");
						logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
						logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-1));
					}

					lastSequenceToApprove = lastSequenceToApprove - 1;
				}
				else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
					// figure out who was last to disapprove. get that sequence and subtract 2.
					// subtract 1 to accommodate going back by one step.
					// however, nextSequence is lastSequenceToApprove + 1 so subtract another for that
					lastSequenceToApprove = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

					if (debug){
						logger.info("REJECT_STEP_BACK_ONE");
						logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
						logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-2));
					}

					lastSequenceToApprove = lastSequenceToApprove - 2;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
				else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection)){

					// look for the task to see who approver selected to restart. with the name,
					// get the sequence and subtract to get the process rolling
					if (taskAssignedToApprover != null && taskAssignedToApprover.length() > 0)
						lastSequenceToApprove = ApproverDB.getApproverSequence(conn,taskAssignedToApprover,route);

					if (debug){
						logger.info("REJECT_APPROVER_SELECTS");
						logger.info("taskAssignedToApprover: " + taskAssignedToApprover);
					}

					lastSequenceToApprove = lastSequenceToApprove - 1;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
			} // lastApproverVotedNO
			else
				lastSequenceToApprove = ProgramsDB.getLastSequenceToApprove(conn,campus,kix);

			if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);

			// was lastSequenceToApprove a distribution list? if yes, is approval for distribution completed?
			boolean isDistributionList = false;
			boolean distributionApprovalCompleted = true;

			String distributionList = ApproverDB.getApproversBySeq(conn,campus,lastSequenceToApprove,route);

			if (distributionList != null && distributionList.length() > 0)
				isDistributionList = DistributionDB.isDistributionList(conn,campus,distributionList);

			if (isDistributionList)
				distributionApprovalCompleted = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distributionList,lastSequenceToApprove);

			if (debug){
				logger.info("distributionList: " + distributionList);
				logger.info("isDistributionList: " + isDistributionList);
				logger.info("distributionApprovalCompleted: " + distributionApprovalCompleted);
			}

			// if is a distribution list and the distribution approval not completed, then sequence is last sequence
			if (isDistributionList && !distributionApprovalCompleted)
				nextSequence = lastSequenceToApprove;
			else
				nextSequence = lastSequenceToApprove + 1;

			if (debug) logger.info("nextSequence: " + nextSequence);

			/*
				retrieve approver info (structure of first/last/next)
				without route number, nothing works at this point
			*/
			if (route > 0){
				Approver approver = ApproverDB.getApproverByNameAndSequence(conn,campus,alpha,num,user,route,nextSequence);
				if (approver != null) {
					if (debug) logger.info("approver: " + approver);

					userSequence = Integer.parseInt(approver.getSeq());
					if (debug) logger.info("userSequence: " + userSequence);

					// make sure the next approver is set appropriately when not distribution list
					if (userSequence == 0) {
						nextApprover = false;
					} else {
						if (isDistributionList && !distributionApprovalCompleted)
							nextApprover = true;
						else{
							if ((lastSequenceToApprove + 1) == userSequence)
								nextApprover = true;
							else
								nextApprover = false;
						}
					}

					if (debug){
						logger.info("nextApprover: " + nextApprover);
						logger.info("multiLevel: " + multiLevel);
					}

					/*
					 * if is next approver and is multilevel (divisional approver),
					 * make sure the user's department is the same as the alpha.
					 */
					if (nextApprover && multiLevel) {
						if (alpha.equals(UserDB.getUserDepartment(conn,user,alpha))) {
							nextApprover = true;
						} else {
							nextApprover = false;
						}
					}

					if (debug) logger.info("nextApprover: " + nextApprover);

				} else {
					nextApprover = false;
				} // approver = null
			}	// route > 0
			else
				nextApprover = false;

			if (debug) logger.info(kix + " - ProgramsDB - isNextApprover - " + user + " - (" + nextApprover + ")");

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isNextApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: isNextApprover - " + ex.toString());
		}

		if (debug) logger.info(kix + " - " + user + " - ProgramsDB isNextApprover - ENDS");

		return nextApprover;
	} // nextApprover

	/**
	* getApproverNames - returns list of approvers for a route (CSV)
	*
	* @param	conn
	* @param	campus
	* @param	route
	*
	**/
	public static String getApproverNames(Connection conn,String campus,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer approvers = new StringBuffer();
		String approver = null;
		int first = 0;

		try {

			String query = "SELECT approver "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND "
				+ "route=?"
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (first==0)
					approvers.append(AseUtil.nullToBlank(rs.getString(1)));
				else
					approvers.append("," + AseUtil.nullToBlank(rs.getString(1)));

				++first;
			}
			rs.close();
			ps.close();

			approver = approvers.toString();

		} catch (SQLException se) {
			logger.fatal("ProgramsDB: getApproverNames\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getApproverNames - " + e.toString());
		}

		return approver;
	}

	/**
	* getLastPersonToApproveSeq - sequence number of the last person to approve. -1 if none
	*
	* @param	conn
	* @param	campus
	* @param	kix
	*
	**/
	public static int getLastPersonToApproveSeq(Connection conn,String campus,String kix){

		//Logger logger = Logger.getLogger("test");

		int seq = -1;

		try{
			String sql = "SELECT MAX(approver_seq) AS MaxOfseq "
				+ "FROM tblApprovalHist "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND approved='1'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				seq = NumericUtil.nullToZero(rs.getInt("MaxOfseq"));

			// 0 is equivalent to not found or no one approved yet
			if (seq == 0)
				seq = -1;

			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ProgramsDB: getLastPersonToApproveSeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ProgramsDB: getLastPersonToApproveSeq - " + ex.toString());
		}

		return seq;
	}

	/*
	 * getProgramProgress
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return String
	 */
	public static String getProgramProgress(Connection conn,String campus,String kix) throws SQLException {

		String progress = "";

		try {
			String query = "SELECT progress FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				progress = rs.getString(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramProgress - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramProgress - " + ex.toString());
		}

		return progress;
	}

	/**
	 * getProgramDivision
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int getProgramDivision(Connection conn,String campus,String kix) {

		String sql = "SELECT divisionid "
					+ "FROM tblPrograms "
					+ "WHERE campus=? "
					+ "AND historyid=?";

		int division = 0;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				division = rs.getInt("divisionid");
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramDivision - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramDivision - " + ex.toString());
		}

		return division;
	}

	/**
	 * getProgramDegreeDescr
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String getProgramDegreeDescr(Connection conn,String kix) {

		String sql = "SELECT program "
					+ "FROM vw_ProgramForViewing "
					+ "WHERE historyid=?";

		String degreeDescr = "";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				degreeDescr = AseUtil.nullToBlank(rs.getString("program"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramDegreeDescr - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramDegreeDescr - " + ex.toString());
		}

		return degreeDescr;
	}

	/**
	 * getProgramRoute
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int getProgramRoute(Connection conn,String campus,String kix) {

		String sql = "SELECT route "
					+ "FROM tblPrograms "
					+ "WHERE campus=? "
					+ "AND historyid=?";

		int route = 0;

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				route = rs.getInt("route");
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramRoute - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramRoute - " + ex.toString());
		}

		return route;
	}

	/**
	 * getProgramProposer
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String getProgramProposer(Connection conn,String campus,String kix) {

		String sql = "SELECT proposer FROM tblprograms WHERE campus=? AND historyid=?";

		String proposer = "";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramProposer - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramProposer - " + ex.toString());
		}

		return proposer;
	}

	/*
	 * isProgramApprovalCancellable
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isProgramApprovalCancellable(Connection conn,String campus,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		/*
			cancelling an outline takes the following steps

			1) Is the outline in APPROVAL status
			2) Is this the proposer
			3) If cancel anytime is true or not history yet
		*/

		int rowsAffected = 0;
		Msg msg = new Msg();
		boolean programApprovalCancellable = false;
		boolean cancelApprovalAnyTime = false;

		try{
			String progress = getProgramProgress(conn,campus,kix);
			if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)){
				logger.info("ProgramsDB: isProgramApprovalCancellable - IS APPROVAL PROCESS");
				String proposer = getProgramProposer(conn,campus,kix);
				if (proposer.equals(user)){
					logger.info("ProgramsDB: isProgramApprovalCancellable - IS PROPOSER");
					String temp = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelApprovalAnyTime");
					if ("1".equals(temp))
						cancelApprovalAnyTime = true;

					boolean approvalStarted = HistoryDB.approvalStarted(conn,campus,kix,user);

					if (cancelApprovalAnyTime || !approvalStarted){
						logger.info("ProgramsDB: isProgramApprovalCancellable - OK TO CANCEL");
						msg.setResult(true);
					}
					else{
						msg.setMsg("ProgramApprovalStarted");
						logger.info("ProgramsDB: isProgramApprovalCancellable - Approval started by approvers.");
					} // history
				}	// proposer
				else{
					msg.setMsg("ProgramProposerCanCancel");
					logger.info("ProgramsDB: isProgramApprovalCancellable - Attempting to cancel when not proposer of outline.");
				}	// proposer
			} // approval
			else{
				msg.setMsg("ProgramNotInApprovalStatus");
				logger.info("ProgramsDB: isProgramApprovalCancellable - Attempting to cancel outline approval that is not cancellable.");
			}	// approval
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: isProgramApprovalCancellable - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: isProgramApprovalCancellable - " + e.toString());
		}

		return msg;
	}

	/*
	 * cancelProgramApproval
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelProgramApproval(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int route = 0;

		String type = "PRE";
		String progressText = "";
		String programMessage = "";

		boolean debug = false;

		/*
			cancelling approval takes the following steps:

			1) Make sure it's in the correct progress and isprogramApprovalCancellable
			2) update the course record
			3) send notification to all
			4) clear history
		*/

		if (debug) logger.info(kix + " - PROGRAMSDB - CANCELPROGRAMAPPROVAL - START");

		Msg msg = ProgramsDB.isProgramApprovalCancellable(conn,campus,kix,user);
		if (msg.getResult()){
			try{
				String progress = "";
				String alpha = "";
				String num = "";
				int degree = 0;
				int division = 0;
				String divisionDescr = "";

				Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
				if ( program != null ){
					progress = program.getProgress();
					alpha = program.getTitle();
					route = program.getRoute();
					degree = program.getDegree();
					division = program.getDivision();
					divisionDescr = program.getDivisionDescr();
				}

				if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS))
					progressText = Constant.PROGRAM_APPROVAL_TEXT;

				String sql = "UPDATE tblprograms SET edit=1,progress='MODIFY',edit1='1',edit2='1',route=0,subprogress='' " +
					"WHERE campus=? AND historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - update record");

				// when cancelling, find names of all who have approved/revised as well as the person
				// with the task to approve
				sql = "SELECT DISTINCT approver FROM tblApprovalHist WHERE historyid=?";
				String approvers = SQLUtil.resultSetToCSV(conn,sql,kix);

				String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,progressText);
				if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - submittedFor - " + submittedFor);

				if (approvers != null && approvers.length() > 0)
					approvers = approvers + "," + submittedFor;
				else
					approvers = submittedFor;
				if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - approvers - " + approvers);

				if (approvers != null && approvers.length() > 0){
					DistributionDB.notifyDistribution(conn,campus,alpha,num,type,user,approvers,"","emailOutlineCancelApproval","",user);
					AseUtil.loggerInfo("PROGRAMSDB - cancelProgramApproval - send notification: ",campus,user,alpha,num);
					if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - distribution list sent to - " + approvers);
				}

				// remove all tasks from approvers, then put task back for modifying outline
				rowsAffected = TaskDB.logTask(conn,"ALL",user,alpha,divisionDescr,
														progressText,campus,"","REMOVE","PRE",
														"","",kix,Constant.PROGRAM);
				if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - remove approve program task - " + rowsAffected + " rows");

				boolean isNewProgram = ProgramsDB.isNewProgram(conn,campus,alpha,degree,division);
				if (isNewProgram)
					programMessage = Constant.PROGRAM_CREATE_TEXT;
				else
					programMessage = Constant.PROGRAM_MODIFY_TEXT;

				rowsAffected = TaskDB.logTask(conn,user,user,alpha,divisionDescr,
														programMessage,campus,Constant.BLANK,
														Constant.TASK_ADD,Constant.PRE,Constant.BLANK,
														Constant.BLANK,kix,Constant.PROGRAM);
				if (debug) logger.info(kix + " - PROGRAMSDB - cancelProgramApproval - add modify task");

				sql = "DELETE FROM tblApprovalHist WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

				sql = "DELETE FROM tblApprovalHist2 WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// delete review history and reviewers if any
				sql = "DELETE FROM tblReviewHist WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

				sql = "DELETE FROM tblReviewHist2 WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// refractor ReviewerDB.removeReviewers
				// this line replaces commented out below
				rowsAffected = ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user);

				AseUtil.logAction(conn,
										user,
										"ACTION",
										"Program approval cancelled ",
										alpha,
										num,
										campus,
										kix);

			}
			catch(SQLException se){
				logger.fatal(kix + " - PROGRAMSDB: cancelProgramApproval - " + se.toString());
			}
			catch(Exception e){
				logger.fatal(kix + " - PROGRAMSDB: cancelProgramApproval - " + e.toString());
			}
		}
		else{
			if (debug) logger.info(msg.getMsg());
		}

		if (debug) logger.info(kix + " - PROGRAMSDB: CANCELPROGRAMAPPROVAL - END");

		return msg;
	}

	/*
	 * getLastSequenceToApprove In table approval history, there are entries indicating
	 * when someone took their turns. If found in that table for a course and
	 * campus, that means user approval took place.
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 * <p>
	 * @return int
	 */
	public static int getLastSequenceToApprove(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int sequence = 0;

		// returns the sequence number of the last approver for this outline
		try {
			String sql = "SELECT approver_seq AS lastSeq, approved  "
				+ "FROM tblApprovalHist "
				+ "WHERE id = ("
				+ "SELECT max(id) "
				+ "FROM tblApprovalHist "
				+ "WHERE historyid=? "
				+ "AND approved=1)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				boolean approved = rs.getBoolean("approved");
				sequence = rs.getInt("lastSeq");

				// if the last person rejected, set back by one to get system to go resend
				// accordingly.
				if (!approved)
					sequence = sequence - 1;
			}
			else
				sequence = 0;

			rs.close();
			ps.close();

			// logger.info(kix + " ProgramDB: getLastSequenceToApprove (" + sequence + ")");
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getLastSequenceToApprove - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getLastSequenceToApprove - " + ex.toString());
		}

		return sequence;
	}

	/*
	 * isProgramDeleteCancellable
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix 		String
	 * @param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isProgramDeleteCancellable(Connection conn,String campus,String kix,String user){

		//Logger logger = Logger.getLogger("test");

		/*
			cancelling an outline takes the following steps

			1) Is the outline in DELETE status
			2) Is this the proposer
			3) If cancel anytime is true or not history yet
		*/

		int rowsAffected = 0;
		Msg msg = new Msg();
		boolean programDeleteCancellable = false;
		boolean cancelApprovalAnyTime = false;
		boolean approvalStarted = false;
		String proposer = "";

		try{
			if ((Constant.PROGRAM_DELETE_PROGRESS).equals(ProgramsDB.getProgramProgress(conn,campus,kix)) ){
				logger.info("ProgramsDB: isProgramDeleteCancellable - IS APPROVAL PROCESS");
				proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
				if (proposer.equals(user)){
					logger.info("ProgramsDB: isProgramDeleteCancellable - IS PROPOSER");
					String temp = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelApprovalAnyTime");
					if ("1".equals(temp))
						cancelApprovalAnyTime = true;

					approvalStarted = HistoryDB.approvalStarted(conn,campus,kix,user);

					if (cancelApprovalAnyTime || !approvalStarted){
						logger.info("ProgramsDB: isProgramDeleteCancellable - OK TO CANCEL");
						msg.setResult(true);
					}
					else{
						msg.setMsg("ProgramApprovalStarted");
						logger.info("ProgramsDB: isProgramDeleteCancellable - Approval started by approvers.");
					} // history
				}	// proposer
				else{
					msg.setMsg("ProgramProposerCanCancel");
					logger.info("ProgramsDB: isProgramDeleteCancellable - Attempting to cancel when not proposer of outline.");
				}	// proposer
			} // approval
			else{
				msg.setMsg("ProgramNotInDeleteStatus");
				logger.info("ProgramsDB: isProgramDeleteCancellable - Attempting to cancel outline approval that is not cancellable.");
			}	// approval
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: isProgramDeleteCancellable - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: isProgramDeleteCancellable - " + e.toString());
		}

		return msg;
	}

	/**
	 * getHistoryIDFromTitle(
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	title		String
	 * @param	type		String
	 * @param	degid		int
	 * @param	divid		int
	 * <p>
	 * @return	String
	 */
	public static String getHistoryIDFromTitle(Connection conn,String campus,String title,String type) {

		return getHistoryIDFromTitle(conn,campus,title,type,0,0);

	}

	public static String getHistoryIDFromTitle(Connection conn,String campus,String title,String type,int deg,int div) {

		String historyid = "";

		try{
			String sql = "SELECT historyid FROM tblPrograms WHERE campus=? AND title=? AND type=? AND degreeid=? AND divisionid=? ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,title);
			ps.setString(3,type);
			ps.setInt(4,deg);
			ps.setInt(5,div);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				historyid = AseUtil.nullToBlank(rs.getString("historyid"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getHistoryIDFromTitle( - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getHistoryIDFromTitle( - " + e.toString());
		}

		return historyid;
	}

	/*
	 * enablingDuringApproval
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean enablingDuringApproval(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean enabled = false;

		 // enabling is when approver wishes to enable items for proposer to edit
		 // to be in enabling mode, the following must be true:
		 //	1) the approval process must be on
		 //	2) edit1 and edit2 must have commas to indicate that individual items have been enabled

		String progress = ProgramsDB.getProgramProgress(conn,campus,kix);
		String programEdit1 = getProgramEdit1(conn,campus,kix);

		if ((Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress) && programEdit1.indexOf(",") > -1)
			enabled = true;

		return enabled;
	}

	/*
	 * getProgramEdit1
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return String
	 */
	public static String getProgramEdit1(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String edit = "";

		try {
			String sql = "SELECT edit1 FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramEdit1 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramEdit1 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getProgramEdit2
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return String
	 */
	public static String getProgramEdit2(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String edit = "";

		try {
			String sql = "SELECT edit2 FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramEdit2 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramEdit2 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getProgramEdits
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getProgramEdits(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String[] edits = null;

		try {
			String query = "SELECT edit0,edit1,edit2 FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				edits = new String[3];
				edits[0] = rs.getString(1);
				edits[1] = rs.getString(2);
				edits[2] = rs.getString(3);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramEdits - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: getProgramEdits - " + ex.toString());
		}

		return edits;
	}

	/*
	 * enableProgramItems - ability to enable outline items
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean enableProgramItems(Connection conn,String campus,String kix,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean editable = false;
		boolean enable = false;
		String proposer = "";
		String progress = "";
		String type = "PRE";

		try {
			long countApprovalHistory = ApproverDB.countApprovalHistory(conn,kix);

			editable = isEditable(conn,campus,kix,user);
			proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
			progress = ProgramsDB.getProgramProgress(conn,campus,kix);

			if (editable && user.equals(proposer) && "MODIFY".equals(progress) & countApprovalHistory == 0)
				enable = true;
			else
				enable = false;

		} catch (SQLException e) {
			logger.fatal(kix + " - ProgramsDB: enableProgramItems - " + e.toString());
		} catch (Exception ex) {
			logger.fatal(kix + " - ProgramsDB: enableProgramItems - " + ex.toString());
		}

		return enable;
	}

	/*
	 * A course is editable only if: edit flag=true,progress=modify,user=proposer and no approval history found
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isEditable(Connection conn,String campus,String kix,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean editable = false;
		String proposer = "";
		String progress = "";

		try {
			String sql = "SELECT edit,proposer,progress " +
							"FROM tblPrograms " +
							"WHERE campus=? " +
							"AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				editable = rs.getBoolean(1);
				proposer = rs.getString(2);
				progress = rs.getString(3);
			}
			rs.close();
			ps.close();

			//if (editable && user.equals(proposer) && "MODIFY".equals(progress) & countApprovalHistory == 0)
			long countApprovalHistory = ApproverDB.countApprovalHistory(conn,kix);

			// course is editable in following ways:
			// 1) when modifying, it has to be the proposer of the outline
			// 2) for delete, it is automatically editable
			if (editable && user.equals(proposer) && (Constant.PROGRAM_MODIFY_PROGRESS).equals(progress))
				editable = true;
			else if ((Constant.PROGRAM_APPROVAL_PENDING_TEXT).equals(progress))
				editable = true;
			else if ((Constant.PROGRAM_DELETE_PROGRESS).equals(progress))
				editable = true;
			else
				editable = false;

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isEditable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: isEditable - " + ex.toString());
		}

		return editable;
	}

	/*
	 * updateReason - update reason field with timestamp
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	reason	String
	 *	@param	user		String
	 *	<p>
	 *	@return int
	 */
	public static int updateReason(Connection conn,String kix,String reason,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String currentReason = "";
		int rowsAffected = 0;

		String sql = "SELECT " + Constant.COURSE_REASON + " "
						+ "FROM tblPrograms "
						+ "WHERE historyid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				currentReason = AseUtil.nullToBlank(rs.getString(Constant.COURSE_REASON));

				currentReason = "<strong>"
									+ AseUtil.getCurrentDateTimeString() + " - " + user
									+ "</strong><br/>"
									+ reason
									+ "<br/><br/>"
									+ currentReason;
				sql = "UPDATE tblPrograms SET " + Constant.COURSE_REASON + "=? WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,currentReason);
				ps.setString(2,kix);
				rowsAffected = ps.executeUpdate();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ProgramsDB: updateReason - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * isApprovedProgramEditable
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isApprovedProgramEditable(Connection conn,String campus,String kix) {

		//Logger logger = Logger.getLogger("test");

		/*
			approved program is editable if it exists in CUR but not as PRE
		*/

		boolean editable = false;

		try {
			if (!ProgramsDB.programExistByTitleCampus(conn,campus,kix,"PRE")
					&& ProgramsDB.programExistByTitleCampus(conn,campus,kix,"CUR")) {
				editable = true;
			}

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isApprovedProgramEditable - " + e.toString());
		}

		return editable;
	}

	/*
	 * getProgramsForCourseSelection
	 *	<p>
	 * @param	conn
	 * @param	campus
	 *	<p>
	 * @return String
	 */
	public static String getProgramsForCourseSelection(Connection conn,String campus) throws Exception {

		return getProgramsForCourseSelection(conn,campus,"control");

	}

	/*
	 * getProgramsForCourseSelection
	 *	<p>
	 * @param	conn
	 * @param	campus
	 * @param	controlName
	 *	<p>
	 * @return String
	 */
	public static String getProgramsForCourseSelection(Connection conn,String campus,String controlName) throws Exception {

		String temp = "";
		String sql = "SELECT vw.historyid, rtrim(vw.Program) + ' - ' + rtrim(vw.divisioncode) + ' - ' + rtrim(tbl.title) AS title "
			+ "FROM vw_ProgramForViewing vw INNER JOIN "
			+ "(SELECT title, MAX([Updated Date]) AS updated "
			+ "FROM vw_ProgramForViewing "
			+ "WHERE campus='_campus_' "
			+ "AND type='CUR' "
			+ "GROUP BY title) tbl ON vw.title = tbl.title "
			+ "AND vw.[Updated Date] = tbl.updated "
			+ "ORDER BY vw.Program, vw.divisioncode, tbl.title";

		try {
			AseUtil au = new AseUtil();
			sql = sql.replace("_campus_",campus);
			temp = au.createSelectionBox(conn,sql,controlName,"delegated",false);
			au = null;
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getProgramsForCourseSelection\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getProgramForCourseDisplay
	 *	<p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 *	<p>
	 * @return String
	 */
	public static String getProgramForCourseDisplay(Connection conn,String campus,String kix) throws Exception {

		String temp = "";
		try {
			Programs program = ProgramsDB.getProgram(conn,campus,kix);
			if (program != null){
				temp = Html.BR() +
								"&nbsp;&nbsp;<font class=\"textblackth\">Program:</font>&nbsp;&nbsp;" + program.getDegreeDescr() + Html.BR() +
								Html.BR() +
								"&nbsp;&nbsp;<font class=\"textblackth\">Division:</font>&nbsp;&nbsp;" + program.getDivisionDescr() + Html.BR() +
								Html.BR() +
								"&nbsp;&nbsp;<font class=\"textblackth\">Title:</font>&nbsp;&nbsp;" + program.getTitle() + Html.BR() + Html.BR();
			}
			program = null;
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getProgramForCourseDisplay\n" + e.toString());
		}

		return temp;
	}

	/**
	 * listProgramsOutlinesDesignedFor - use outline kix to collect all program kix for which the outline
	 *													was designed for.
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * @param	enableDelete
	 * @param	showPending
	 * <p>
	 * @return	String
	 */
	public static String listProgramsOutlinesDesignedFor(Connection conn,
																			String campus,
																			String kix,
																			boolean enableDelete,
																			boolean showPending){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String programKix = "";
		String rowColor = "";
		String historyid = "";

		String deleteColumn = "";
		String aHrefStart = "";
		String aHrefEnd = "";
		String link = "";

		boolean pending = false;
		String sPending = "";

		boolean found = false;

		int j = 0;
		int id = 0;

		try{
			 String ProgramLinkedToOutlineRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ProgramLinkedToOutlineRequiresApproval");

			if (enableDelete){
				deleteColumn = ",historyid,id ";
				aHrefStart = "<a href=\"crsprg.jsp?lid=_LINK_&src="+Constant.COURSE_PROGRAM+"\" class=\"linkcolumn\">";
				aHrefEnd = "</a>";
			}

			String sql = "SELECT grading,pending " + deleteColumn +
					" FROM tblExtra" +
					" WHERE campus=? " +
					" AND historyid=? " +
					" AND src='"+Constant.COURSE_PROGRAM+"'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				link = "";

				programKix = AseUtil.nullToBlank(rs.getString("grading"));
				pending = rs.getBoolean("pending");

				if (enableDelete){
					historyid = AseUtil.nullToBlank(rs.getString("historyid"));
					id = rs.getInt("id");
					link = aHrefStart.replace("_LINK_",historyid + "&id=" + id + "&ack=r&kix=" + kix);
				}

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				Programs program = ProgramsDB.getProgram(conn,campus,programKix);
				if (program != null){
					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\">" + program.getDegreeDescr() + "</td>");
					listings.append("<td class=\"datacolumn\">" + program.getDivisionDescr() + "</td>");
					listings.append("<td class=\"datacolumn\">" + link + program.getTitle() + aHrefEnd + "</td>");

					if (showPending && (Constant.ON).equals(ProgramLinkedToOutlineRequiresApproval))
						listings.append("<td class=\"datacolumn\">" + sPending + "</td>");

					listings.append("</tr>");
				}
				program = null;
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr height=\"30\" bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">" +
					"<td class=\"textblackTH\">Program</td>" +
					"<td class=\"textblackTH\">Division</td>" +
					"<td class=\"textblackTH\">Title</td>";

				if (showPending && (Constant.ON).equals(ProgramLinkedToOutlineRequiresApproval))
					listing += "<td valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>";

				listing += "</tr>" +
								listings.toString() +
								"</table>";
			}
			else{
				listing = "";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listProgramsOutlinesDesignedFor - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listProgramsOutlinesDesignedFor - " + ex.toString());
		}

		return listing;
	}

	/*
	 * countPendingOutlinesForApproval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	division	int
	 * <p>
	 */
	public static int countPendingOutlinesForApproval(Connection conn,String campus,int division) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int counter = 0;

		try {
			String sql = "SELECT COUNT(historyid) AS counter "
							+ "FROM tblCourse "
							+ "WHERE campus=? "
							+ "AND progress='PENDING' "
							+ "AND coursealpha IN  (SELECT coursealpha FROM tblChairs WHERE programid=?) ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				counter = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: countPendingOutlinesForApproval - " + e.toString());
		}

		return counter;
	}

	/*
	 * countPendingOutlinesForDeleteApproval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	division	int
	 * <p>
	 */
	public static int countPendingOutlinesForDeleteApproval(Connection conn,String campus,int division) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int counter = 0;

		try {
			String sql = "SELECT COUNT(historyid) AS counter "
							+ "FROM tblCourse "
							+ "WHERE campus=? "
							+ "AND progress='PENDING' AND subprogress='DELETE' "
							+ "AND coursealpha IN  (SELECT coursealpha FROM tblChairs WHERE programid=?) ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				counter = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: countPendingOutlinesForDeleteApproval - " + e.toString());
		}

		return counter;
	}

	/*
	 * programsRequiringApproval
	 *	<p>
	 * @param	conn
	 * @param	kix
	 *	<p>
	 * @return	int
	 */
	public static int programsRequiringApproval(Connection conn,String kix) throws Exception {

		int count = 0;

		try{
			String sql = "SELECT COUNT(pending) AS counter FROM tblExtra WHERE historyid=? AND pending=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				count = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		}catch(Exception e){
			logger.fatal("ProgramsDB - programsRequiringApproval: " + e.toString());
		}

		return count;
	}

	/*
	 * showApprovalProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return String
	 */
	public static String showApprovalProgress(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String program = "";
		String divisionName = "";
		String division = "";
		String title = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String kix = "";
		String temp = "";
		String routingSequence = "";
		String effectiveDate = "";

		String rowColor = "";
		String link = "";
		String linkProgram = "";
		String linkHistory = "";

		int i = 0;
		int j = 0;
		int route = 0;
		int rowsAffected = 0;

		boolean found = false;
		boolean debug = false;
		boolean processProgram = false;
		boolean approved = false;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;
		String sql = "";

		Approver ap = null;
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("------------------------------ START");

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");

			String select = " historyid,program,divisionname,title,proposer,Progress,route,subprogress,kid,divisioncode,effectivedate ";

			boolean testing = false;

			if (testing){
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? AND title='Practice in CC' "
					+ "ORDER BY program,divisionname,title";

				debug = true;
			}
			else{
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? "
					+ "ORDER BY program,divisionname,title";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				program = AseUtil.nullToBlank(rs.getString("program"));
				divisionName = AseUtil.nullToBlank(rs.getString("divisionname"));
				division = AseUtil.nullToBlank(rs.getString("divisioncode"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				effectiveDate = AseUtil.nullToBlank(rs.getString("effectiveDate"));
				route = rs.getInt("route");

				if (debug){
					logger.info("program: " + program);
					logger.info("divisionName: " + divisionName);
					logger.info("kix: " + kix);
					logger.info("route: " + route);
				}

				//
				//	when progress is modify, and it shows up on the approval status list, that means it has a route number.
				//	with a route number, there should be approval history as well. This means it was sent back for revision.
				//	if no approval history exists, then the program should not be on this report. Route must be left
				//	from some time in the past programming.
				//
				processProgram = true;

				if (progress.equals(Constant.PROGRAM_MODIFY_PROGRESS)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processProgram = false;
					else
						progress = Constant.COURSE_REVISE_TEXT;
				}
				else if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)){
					progress = Constant.COURSE_APPROVAL_TEXT;
				}

				if (!ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR")){
					progress = "NEW";
				}

				if (debug) logger.info("progress: " + progress);

				if (processProgram){

					link = "vwhtml.jsp?cps="+campus+"&kix=" + kix;
					linkProgram = link;
					linkHistory = "?kix=" + kix;

					if (route > 0){
						ap = ApproverDB.getApprovers(conn,kix,proposer,false,route);
					}

					String pdf = "";

					if (enableCCLab.equals(Constant.ON)){
						pdf = "<a href=\"vwpdf.jsp?kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" border=\"0\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>&nbsp;&nbsp;";
					}

					if (ap == null){
						listing.append("<tr>"
							+ "<td align=\"left\">"
							+ pdf
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/icon_forum.gif\" border=\"0\" alt=\"view approval progress\" title=\"view approval progress\"></a>&nbsp;&nbsp;"
							+ "</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress))
							listing.append("<td align=\"left\"><a href=\"/central/core/prgprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + program + " " + divisionName + "</a></td>");
						else
							listing.append("<td align=\"left\">" + program + " " + divisionName + "</td>");

						listing.append("<td>" + effectiveDate + "</td>"
							+ "<td align=\"left\">&nbsp;</td>"
							+ "<td align=\"left\">&nbsp;</td>"
							+ "<td align=\"left\">&nbsp;</td>"
							+ "<td align=\"left\">&nbsp;</td>"
							+ "<td align=\"left\">&nbsp;</td>"
							+ "</tr>");
					}
					else{
						if (debug) logger.info("got approvers");

						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) {
								logger.info("4. lastApprover: " + lastApprover);
								logger.info("4. lastApproverSeq: " + lastApproverSeq);
								logger.info("4. approved: " + approved);
							}
						} // (h != null){

						/*
							if nothing comes from history, the we are at the beginning. however,
							if there is something, figure out who should be up

							if approved was the last from history, the add one to the sequence to get the
							next person.

							array is 0th but we built the approver sequence starting from 1;

						*/
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;

							lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{

							/*
								who is next to approve. if the last person approved, then
								increase by 1 to get to the next person.
							*/
							if (approved)
								++lastApproverSeq;

							// check for comma to remove delegate from showing on reporet
							lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
							if (lastApprover.indexOf(",") > -1)
								lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));

							// check for comma to remove delegate from showing on reporet
							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

							/*
								is the task assigned to the right person? If not, remove the task.
							*/
							String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													title,
																													division,
																													Constant.PROGRAM_APPROVAL_TEXT);
							if (	!"".equals(taskAssignedToApprover) &&
									!taskAssignedToApprover.equals(lastApprover) &&
									!taskAssignedToApprover.equals(proposer)){

								// delete task
								rowsAffected = TaskDB.logTask(conn,
																		taskAssignedToApprover,
																		taskAssignedToApprover,
																		title,
																		division,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		type);

								if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);

							}

						} // lastApproverSeq == 0

						if (debug) logger.info("lastApprover: " + lastApprover);
						if (debug) logger.info("nextApprover: " + nextApprover);

						// determine fast track link
						String fastTrack = "";
						if((isSysAdmin || isCampusAdmin) &&
							(progress.equals(Constant.TASK_APPROVE) || progress.equals(Constant.TASK_NEW) || progress.equals(Constant.TASK_DELETE)))
						{
							fastTrack = "&nbsp;&nbsp;<a href=\"prgfstrk.jsp?kix=" + kix + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>";
						}

						listing.append("<tr>"
							+ "<td align=\"left\">"
							+ pdf
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval progress\" title=\"view approval progress\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" onclick=\"asePopUpWindow(this.href,'aseWincrsrvwcmnts2','800','600','yes','center');return false\" onfocus=\"this.blur()\" class=\"linkcolumn\" title=\"approver comments\"><img src=\"images/comment.gif\" border=\"0\" alt=\"approver comments\" title=\"approver comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prginfy.jsp?h=1&kix=" + kix + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseviewhistory','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/details.gif\" border=\"0\" alt=\"view program detail\" title=\"view program detail\"></a>&nbsp;&nbsp;"
							+ fastTrack);

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin){
							listing.append("<td align=\"left\">" + program + " - " + divisionName + "</td>");
						}
						else
							listing.append("<td align=\"left\">" + program + " - " + divisionName + "</td>");

						listing.append("<td align=\"left\">" + title + "</td>" +
							"<td align=\"left\">" + effectiveDate + "</td>" +
							"<td align=\"left\">" + progress + "</td>" +
							"<td align=\"left\">" + proposer + "</td>" +
							"<td align=\"left\">" + lastApprover + "</td>" +
							"<td align=\"left\">" + nextApprover + "</td>" +
							"<td align=\"left\">" + routingSequence + "</td>" +
							"</tr>");

						found = true;
					} // if ap != null

					ap = null;

				} // processProgram

			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------------------ END");
		}
		catch(SQLException sx){
			logger.fatal("ProgramsDB: showApprovalProgress - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: showApprovalProgress - " + ex.toString());
		}

		if (found){
			temp = "<div id=\"container90\"><div id=\"demo_jui\"><table class=\"display\" id=\"showApprovalProgress\">" +
						"<thead><tr><th>&nbsp;</th>" +
						"<th align=\"left\">Program</th>" +
						"<th align=\"left\">Title</th>" +
						"<th align=\"left\">Effective</th>" +
						"<th align=\"left\">Progress</th>" +
						"<th align=\"left\">Proposer</th>" +
						"<th align=\"left\">Current<br/>Approver</th>" +
						"<th align=\"left\">Next<br/>Approver</th>" +
						"<th align=\"left\">Routing<br/>Sequence</th></tr></thead><tbody>" +
						listing.toString() +
						"</tbody></table></div></div>";
		}
		else{
			temp = "<p align=\"center\">Programs not found</p>";
		}

		return temp;
	} // ProgramsDB.showApproverProgress

	public static String showApprovalProgressOBSOLETE(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String program = "";
		String divisionName = "";
		String division = "";
		String title = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String kix = "";
		String temp = "";
		String routingSequence = "";
		String effectiveDate = "";

		String rowColor = "";
		String link = "";
		String linkProgram = "";
		String linkHistory = "";

		int i = 0;
		int j = 0;
		int route = 0;
		int rowsAffected = 0;

		boolean found = false;
		boolean debug = false;
		boolean processProgram = false;
		boolean approved = false;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;
		String sql = "";

		Approver ap = null;
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("------------------------------ START");

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String select = " historyid,program,divisionname,title,proposer,Progress,route,subprogress,kid,divisioncode,effectivedate ";

			boolean testing = false;

			if (testing){
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? AND title='Practice in CC' "
					+ "ORDER BY program,divisionname,title";

				debug = true;
			}
			else{
				sql = "SELECT " + select
					+ "FROM vw_ProgramsApprovalStatus "
					+ "WHERE campus=? "
					+ "ORDER BY program,divisionname,title";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				program = AseUtil.nullToBlank(rs.getString("program"));
				divisionName = AseUtil.nullToBlank(rs.getString("divisionname"));
				division = AseUtil.nullToBlank(rs.getString("divisioncode"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				effectiveDate = AseUtil.nullToBlank(rs.getString("effectiveDate"));
				route = rs.getInt("route");

				if (debug) logger.info("program: " + program);
				if (debug) logger.info("divisionName: " + divisionName);
				if (debug) logger.info("kix: " + kix);
				if (debug) logger.info("route: " + route);

				/*
					when progress is modify, and it shows up on the approval status list, that means it has a route number.
					with a route number, there should be approval history as well. This means it was sent back for revision.
					if no approval history exists, then the program should not be on this report. Route must be left
					from some time in the past programming.
				*/
				processProgram = true;

				if (progress.equals(Constant.PROGRAM_MODIFY_PROGRESS)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processProgram = false;
					else
						progress = Constant.COURSE_REVISE_TEXT;
				}
				else if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)){
					progress = Constant.COURSE_APPROVAL_TEXT;
				}

				if (!ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR")){
					progress = "NEW";
				}

				if (debug) logger.info("progress: " + progress);

				if (processProgram){

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					link = "vwhtml.jsp?cps="+campus+"&kix=" + kix;
					linkProgram = link;
					linkHistory = "?kix=" + kix;

					if (route > 0)
						ap = ApproverDB.getApprovers(conn,kix,proposer,false,route);

					if (ap == null){
						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/icon_forum.gif\" border=\"0\" alt=\"view approval progress\" title=\"view approval progress\"></a>&nbsp;&nbsp;"
							+ "</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress))
							listing.append("<td class=\"datacolumn\"><a href=\"/central/core/prgprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + program + " " + divisionName + "</a></td>");
						else
							listing.append("<td class=\"datacolumn\">" + program + " " + divisionName + "</td>");

						listing.append("<td class=\"datacolumn\">" + effectiveDate + "</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "</tr>");
					}
					else{
						if (debug) logger.info("got approvers");

						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("ap.getAllApprovers(): " + ap.getAllApprovers());

						/*
							get the last person approving from history
						*/
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) {
								logger.info("4. lastApprover: " + lastApprover);
								logger.info("4. lastApproverSeq: " + lastApproverSeq);
								logger.info("4. approved: " + approved);
							}
						} // (h != null){

						/*
							if nothing comes from history, the we are at the beginning. however,
							if there is something, figure out who should be up

							if approved was the last from history, the add one to the sequence to get the
							next person.

							array is 0th but we built the approver sequence starting from 1;

						*/
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;

							lastApprover = arr[lastApproverSeq];

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{

							/*
								who is next to approve. if the last person approved, then
								increase by 1 to get to the next person.
							*/
							if (approved)
								++lastApproverSeq;

							// check for comma to remove delegate from showing on reporet
							lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
							if (lastApprover.indexOf(",") > -1)
								lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));

							// check for comma to remove delegate from showing on reporet
							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

							/*
								is the task assigned to the right person? If not, remove the task.
							*/
							String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													title,
																													division,
																													Constant.PROGRAM_APPROVAL_TEXT);
							if (	!"".equals(taskAssignedToApprover) &&
									!taskAssignedToApprover.equals(lastApprover) &&
									!taskAssignedToApprover.equals(proposer)){

								// delete task
								rowsAffected = TaskDB.logTask(conn,
																		taskAssignedToApprover,
																		taskAssignedToApprover,
																		title,
																		division,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		type);

								if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);

							}

						} // lastApproverSeq == 0

						if (debug) logger.info("lastApprover: " + lastApprover);
						if (debug) logger.info("nextApprover: " + nextApprover);

						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prgstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval progress\" title=\"view approval progress\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp?md=0&kix=" + kix + "&qn=0\" onclick=\"asePopUpWindow(this.href,'aseWincrsrvwcmnts2','800','600','yes','center');return false\" onfocus=\"this.blur()\" class=\"linkcolumn\" title=\"approver comments\"><img src=\"images/comment.gif\" border=\"0\" alt=\"approver comments\" title=\"approver comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"prginfy.jsp?h=1&kix=" + kix + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseviewhistory','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/details.gif\" border=\"0\" alt=\"view program detail\" title=\"view program detail\"></a>&nbsp;&nbsp;");

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin){
							listing.append("<td class=\"datacolumn\" nowrap>" + program + " - " + divisionName + "</td>");
						}
						else
							listing.append("<td class=\"datacolumn\" nowrap>" + program + " - " + divisionName + "</td>");

						listing.append("<td class=\"datacolumn\">" + title + "</td>" +
							"<td class=\"datacolumn\">" + effectiveDate + "</td>" +
							"<td class=\"datacolumn\">" + progress + "</td>" +
							"<td class=\"datacolumn\">" + proposer + "</td>" +
							"<td class=\"datacolumn\">" + lastApprover + "</td>" +
							"<td class=\"datacolumn\">" + nextApprover + "</td>" +
							"<td class=\"datacolumn\">" + routingSequence + "</td>" +
							"</tr>");

						found = true;
					} // if ap != null

					ap = null;

				} // processProgram

			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------------------ END");
		}
		catch(SQLException sx){
			logger.fatal("ProgramsDB: showApprovalProgress - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: showApprovalProgress - " + ex.toString());
		}

		if (found)
			temp = "<table class=\""+campus+"BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
						"<tr class=\""+campus+"BGColor\" height=\"30\"><td>&nbsp;</td>" +
						"<td valign=\"bottom\">Program</td>" +
						"<td valign=\"bottom\">Title</td>" +
						"<td valign=\"bottom\">Effective Date</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"<td valign=\"bottom\">Proposer</td>" +
						"<td valign=\"bottom\">Current<br/>Approver</td>" +
						"<td valign=\"bottom\">Next<br/>Approver</td>" +
						"<td valign=\"bottom\">Routing<br/>Sequence</td></tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Programs not found</p>";

		return temp;
	} // showApproverProgress

	/**
	 * showCompletedApprovals
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static Msg showCompletedApprovals(Connection conn,String campus,String kix){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String rtn = "";

		int seq = 0;
		String approvers = "";
		String title = "";
		String dte = "";
		String approved = "";
		String position = "";
		String role = "";
		String progress = "";

		int j = 0;

		Msg msg = new Msg();
		String approver = "";

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			// vw_ApprovalHistory
			String sql = "SELECT ta.campus,ta.coursealpha,ta.coursenum,ta.seq,ta.historyid,ta.approver,tu.title,tu.[position],ta.dte,ta.approved,tu.department,ta.inviter,ta.role,ta.approver_seq,ta.progress "
				+ "FROM tblApprovalHist ta,tblUsers tu "
				+ "WHERE ta.approver = tu.userid AND progress <> 'RECALLED' "
				+ "UNION "
				+ "SELECT campus,coursealpha,coursenum,seq,historyid,approver,'DISTRIBUTION LIST','DISTRIBUTION LIST',dte,approved,'','','',0,0 "
				+ "FROM tblApprovalHist ta "
				+ "WHERE approver LIKE '%]'";

			sql = "SELECT seq, approver_seq, approver, title, position, dte, approved, role, progress "
				+ "FROM vw_ApprovalHistory WHERE campus=? AND historyid=? ORDER BY dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				seq = rs.getInt("approver_seq");
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				position = AseUtil.nullToBlank(rs.getString("position"));
				dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),6);
				role = AseUtil.nullToBlank(rs.getString("role"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));

				if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					progress = "REVIEWED";
				}

				approved = AseUtil.nullToBlank(rs.getString("approved"));
				if (approved.equals(Constant.ON)){
					approved = "YES";
				}
				else{
					approved = "NO";
				}

				// only approvers get a yes/no vote
				if (!role.equals(Constant.TASK_APPROVER)){
					approved = "";
				}

				if (j==1){
					approvers = approver;
				}
				else{
					approvers = approvers + "," + approver;
				}

				buf.append("<tr>" +
					"<td align=\"left\">" + seq + "</td>" +
					"<td align=\"left\">" + approver + "</td>" +
					"<td align=\"left\">" + title + "</td>" +
					"<td align=\"left\">" + position + "</td>" +
					"<td align=\"right\">" + dte + "</td>" +
					"<td align=\"left\">" + role + "</td>" +
					"<td align=\"left\">" + approved + "</td>" +
					"<td align=\"left\">" + progress + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ProgramsDB: showCompletedApprovals - " + se.toString());
		}catch(Exception ex){
			logger.fatal("ProgramsDB: showCompletedApprovals - " + ex.toString());
		}

		rtn = "<div id=\"container90\"><div id=\"demo_jui\"><table class=\"display\" id=\"showCompletedApprovals\">" +
				"<thead><tr>" +
				"<th align=\"left\">Sequence</th>" +
				"<th align=\"left\">Approver</th>" +
				"<th align=\"left\">Title</th>" +
				"<th align=\"left\">Position</th>" +
				"<th align=\"right\">Date</th>" +
				"<th align=\"left\">Role</th>" +
				"<th align=\"left\">Approved</th>" +
				"<th align=\"left\">Progress</th>" +
				"</tr></thead><tbody>" +
				buf.toString() +
				"</tbody></table></div> </div>";

		msg.setMsg(approvers);
		msg.setErrorLog(rtn);

		return msg;
	}

	/**
	 * showPendingApprovals
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	completed	String
	 * @param	route			int
	 * <p>
	 * @return	String
	 */
	public static String showPendingApprovals(Connection conn,String campus,String kix,String completed,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String approver = "";
		String delegated = "";
		String pendingApprovers = "";
		String position = "";
		String title = "";
		String rtn = "";

		String distributionList = "";
		String distributionListMembers = "";
		String[] aDistributionList = null;
		boolean distributionApprovalCompleted = false;

		int j = 0;
		int sequence = 0;
		int lastSequenceToApprove = 0;

		boolean found = false;
		boolean firstSequenceExists = false;
		String sql = "";

		try{
			completed = "'" + completed.replace(",","','") + "'";

			// take care of complete distribution list if any. list starts and ends with [].
			// if the list members have approved 100%, then remove the list from listing.
			sql = "SELECT approver FROM tblApprover WHERE route=? AND approver LIKE '[[]%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				// get the list name
				distributionList = AseUtil.nullToBlank(rs.getString(1));
				if (distributionList != null && distributionList.length() > 0){
					// get list members
					distributionListMembers = DistributionDB.getDistributionMembers(conn,campus,distributionList);
					if (distributionListMembers != null && distributionListMembers.length() > 0){

						// split members into array. for loop checks to verify that members have/have not approved
						// if all approved, then this list is no longer listed
						// start with list being completed by default. If a name is not found in the for-loop, then
						// set distributionApprovalCompleted = false;

						distributionApprovalCompleted = true;

						aDistributionList = distributionListMembers.split(",");

						for(int z=0;z<aDistributionList.length;z++){
							if (completed.indexOf(aDistributionList[z])==-1){
								distributionApprovalCompleted = false;
							}
						} // for

						// if completed, add to excluded (completed) list
						if (distributionApprovalCompleted)
							completed += ",'" + distributionList + "'";

					} // if distributionListMembers
				} // if distributionList
			} // while
			rs.close();
			ps.close();

			sql = "";

			//
			//	with programs, we are not concerned with sequence 1 from approver sequence.
			//	#1 is from the division table as chair
			//
			lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);
			if (lastSequenceToApprove<1){
				lastSequenceToApprove = 1;

				sql = "SELECT 1 AS Sequence, d.chairname AS Approver, '' AS delegated, tu.title, tu.[position], tu.department, tu.campus, " + route + " AS route "
						+ "FROM tblDivision d INNER JOIN tblUsers tu ON d.campus = tu.campus AND d.chairname = tu.userid "
						+ "WHERE d.divid=1 "
						+ "UNION ";
			}

			sql += ""
				+ "SELECT ta.approver_seq AS Sequence,ta.approver,ta.delegated,tu.title,tu.[position],tu.department,tu.campus,ta.route "
				+ "FROM tblApprover ta INNER JOIN "
				+ "tblUsers tu ON ta.approver = tu.userid "
				+ "WHERE ta.campus=? AND route=? AND approver_seq>? "
				+ "UNION "
				+ "SELECT approver_seq AS Sequence,approver,delegated,'DISTRIBUTION LIST','DISTRIBUTION LIST','',campus,route "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND route=? AND approver LIKE '%]' AND approver_seq>?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,lastSequenceToApprove);
			ps.setString(4,campus);
			ps.setInt(5,route);
			ps.setInt(6,lastSequenceToApprove);
			rs = ps.executeQuery();
			while ( rs.next() ){
				// name of first approver at DC level is not always available since
				// CC does not know who is DC for all alphas. When that happens,
				// sequence 1 or first person will not be found here.
				// firstSequenceExists = true means we found the DC otherwise we did not.
				// if not, we want to get that name from the task assignment and include
				// in the data returned.
				sequence = NumericUtil.nullToZero(rs.getInt("sequence"));

				if (sequence==1){
					firstSequenceExists = true;
				}

				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				position = AseUtil.nullToBlank(rs.getString("position"));

				// list of pending approvers for use later
				if (j== 0){
					pendingApprovers = approver;
				}
				else{
					pendingApprovers = pendingApprovers + "," + approver;
				}

				buf.append("<tr>" +
					"<td align=\"left\">" + sequence + "</td>" +
					"<td align=\"left\">" + approver + "</td>" +
					"<td align=\"left\">" + title + "</td>" +
					"<td align=\"left\">" + position + "</td>" +
					"<td align=\"left\">" + delegated + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				rtn = buf.toString();
			}
		}
		catch(SQLException se){
			logger.fatal("ProgramsDB: showPendingApprovals - " + sql);
		}catch(Exception ex){
			logger.fatal("ProgramsDB: showPendingApprovals - " + ex.toString());
		}

		if (found){
			rtn = "<div id=\"container90\"><div id=\"demo_jui\"><table class=\"display\" id=\"showPendingApprovals\">" +
				"<thead><tr>" +
				"<th align=\"left\">Sequence</th>" +
				"<th align=\"left\">Approver</th>" +
				"<th align=\"left\">Title</th>" +
				"<th align=\"left\">Position</th>" +
				"<th align=\"left\">Delegate</th>" +
				"</tr></thead><tbody>" +
				rtn +
				"</tbody></table></div> </div>";
		}
		else
			rtn = "";

		return rtn;
	}

	/*
	 * showProgramProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String
	 */
	public static String showProgramProgress(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String program = "";
		String divisionName = "";
		String effectivedate = "";
		String progress = "";
		String proposer = "";
		String title = "";
		boolean found = false;
		int j = 0;

		String kix = "";
		String rowColor = "";
		String temp = "";
		String status = "";

		try{
			String sql = "SELECT campus,program,divisionname,proposer,progress,type,title,historyid,route,effectivedate "
							+ "FROM vw_ProgramForViewing "
							+ "WHERE campus=? "
							+ "AND (progress<>'APPROVED' AND progress<>'ARCHIVED') "
							+ "ORDER BY program,divisionname,title,effectivedate";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				program = AseUtil.nullToBlank(rs.getString("program"));
				divisionName = AseUtil.nullToBlank(rs.getString("divisionname"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				effectivedate = AseUtil.nullToBlank(rs.getString("effectivedate"));
				title = AseUtil.nullToBlank(rs.getString("title"));

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				// outline detail
				listing.append("<tr bgcolor=\"" + rowColor + "\" height=\"20\">" +
					"<td class=\"datacolumn\">" + program + " - " + divisionName + "</td>" +
					"<td class=\"datacolumn\">" + title + "</td>" +
					"<td class=\"datacolumn\">" + effectivedate + "</td>" +
					"<td class=\"datacolumn\">" + proposer + "</td>" +
					"<td class=\"datacolumn\">" + progress + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ProgramsDB: showProgramProgress\n" + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: showProgramProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table width=\"98%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"20\">" +
						"<td class=\"textblackTH\">Program</td>" +
						"<td class=\"textblackTH\">Title</td>" +
						"<td class=\"textblackTH\">Effective Date</td>" +
						"<td class=\"textblackTH\">Proposer</td>" +
						"<td class=\"textblackTH\">Progress</td>" +
						"</tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "Program not found";

		return temp;
	}

	/*
	 * A program isProgramRestorable only if there is no other program in PRE progress
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isProgramRestorable(Connection conn,String campus,String kix) throws SQLException {

		boolean restorable = false;

		try {

			if (isAProgram(conn,campus,kix) && !programExistByTypeCampus(conn,campus,kix,"PRE")){
				restorable = true;
			}

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isProgramRestorable - " + e.toString());
		}

		return restorable;
	}

	/*
	 * enabledEditItems
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 * <p>
	 *	@return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap enabledEditItems(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		HashMap hashMap = null;

		try {
			String programItems = "";

			programItems = ProgramsDB.getProgramEdit1(conn,campus,kix);

			if (programItems != null && programItems.length() > 0 && programItems.indexOf(",") > -1){
				hashMap = new HashMap();
				String[] aprogramItems = programItems.split(",");
				for(int z=0;z<aprogramItems.length;z++){
					if (!"0".equals(aprogramItems[z]))
						hashMap.put(aprogramItems[z],new String(aprogramItems[z]));
				}
			}
		} catch (SQLException ex) {
			logger.fatal("ProgramsDB: enabledEditItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: enabledEditItems - " + e.toString());
		}

		return hashMap;
	} // enabledEditItems

	 /* getProgramSequenceByNumber - get the sequence that is associated with this number
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	number
	 *	<p>
	 *	@return int
	 */
	public static int getProgramSequenceByNumber(Connection conn,String campus,int number) throws Exception {

		String sql = "SELECT questionseq FROM tblprogramquestions WHERE campus=? AND questionnumber=?";
		int questionSequence = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, number);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				questionSequence = resultSet.getInt(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("ProgramsDB: getProgramSequenceByNumber\n" + ex.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getProgramSequenceByNumber - " + e.toString());
		}

		return questionSequence;
	}

	/*
	 * isProgramItemEditable - returns true if the item is editable (unlocked)
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	item		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isProgramItemEditable(Connection conn,String campus,String kix,int item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean found = false;

		try {
			String getProgramEditItem = null;

			getProgramEditItem = ProgramsDB.getProgramEdit1(conn,campus,kix);

			/*
				edit1 contains 1 (edit), 2 (approval), or 3 (review)
				when the length is longer than 1 character, then we are enabled for individual
				item edits

				resulting string should be something like ,1,0,0,0,0,
				where commas are at start and end to help with the indexOf method
				this is just a quicker search and not having to loop until we find.
			*/

			if (getProgramEditItem != null && getProgramEditItem.indexOf(",") > -1){
				if (item > 0){
					String sItem = "," + Integer.toString(item) + ",";
					if (("," + getProgramEditItem + ",").indexOf(sItem) != -1)
						found = true;
				} // item > 0
			}// getProgramEditItem

		} catch (SQLException ex) {
			logger.fatal("ProgramsDB: isProgramItemEditable - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isProgramItemEditable - " + e.toString());
		}

		return found;
	}

	/*
	 * whoEnabledThisItem - returns name of the person who enabled an item
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 * @param	item
	 *	<p>
	 *	@return String
	 */
	public static String whoEnabledThisItem(Connection conn,String campus,String kix,int item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String reviewer = "";

		try {
			/*
				returns the name of the person who enabled this item on the tab (source)
			*/
			String sql = "SELECT reviewer "
					+ "FROM tblReviewHist "
					+ "WHERE id IN (SELECT MAX(id) AS counter "
					+ "FROM tblReviewHist "
					+ "WHERE historyid=? "
					+ "AND enabled=1 "
					+ "AND item=? "
					+ "AND source=? "
					+ "GROUP BY reviewer)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,item);
			ps.setString(3,"-1");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				reviewer = AseUtil.nullToBlank(rs.getString("reviewer"));
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("ProgramsDB: whoEnabledThisItem - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: whoEnabledThisItem - " + e.toString());
		}

		return reviewer;
	}

	/*
	 * reviewProgram
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 * @param	mode		int
	 * @param	user		String
	 * @param	hide		boolean
	 *	<p>
	 *	@return Msg
	 */
	public static Msg reviewProgram(Connection conn,String campus,String kix,int mode,String user) throws Exception {

		return reviewProgram(conn,campus,kix,mode,user,false);
	}

	public static Msg reviewProgram(Connection conn,String campus,String kix,int mode,String user,boolean hide) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		AseUtil aseUtil = new AseUtil();

		StringBuffer program = new StringBuffer();
		String sql = "";
		String temp = "";
		int j = 0;

		String bgcolor = "";

		HashMap hashMap = null;
		Question question;

		// allow viewing of approval process.
		boolean allowToComment = true;
		boolean debug = false;

		// used for jquery popup links
		String linkedKey = "";

		int fid = 0;
		int mid = 0;

		boolean display = true;

		try{

			debug = DebugDB.getDebug(conn,"ProgramsDB");

			// this works. just not in use.
			// not yet created
			//allowToComment = canCommentOnProgram(conn,kix,user);

			long reviewerComments = 0;

			//String[] qn = "1,2,3,4,5,6,10,7,12,9,8,13,11".split(",");

			j = 0;

			ArrayList answers = ProgramsDB.getProgramAnswers(conn,campus,kix,"PRE");
			ArrayList list = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");

			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				fid = ForumDB.getForumID(conn,campus,kix);
			}

			if (answers != null){

				program.append( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );

				hashMap = MiscDB.getProgramEnabledItems(conn,kix);

				sql = "SELECT questionnumber,questionseq,question "
								+ "FROM tblProgramQuestions WHERE campus=? AND include='Y' ORDER BY questionseq";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					question = (Question)list.get(j);

					display = true;
					bgcolor = "";

					if(hashMap != null && hashMap.containsValue(question.getNum())){
						bgcolor="bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"";
					}

					// do we show or hide the highlights
					if (hide && bgcolor.equals("")){
						display = false;
					}

					if (enableMessageBoard.equals(Constant.OFF)){
						reviewerComments = ReviewerDB.countComments(conn,kix,Integer.parseInt(question.getNum()),Constant.TAB_PROGRAM,0);
					}
					else{
						reviewerComments = ForumDB.countPostsToForum(conn,kix,j+1);
					}

					if (display){
						program.append("<tr "+bgcolor+"><td align=\"left\" valign=\"top\" width=\"05%\" nowrap>" + (j+1) + ". ");

						if (allowToComment){

							if (enableMessageBoard.equals(Constant.OFF)){
								program.append("<a href=\"prgcmnt.jsp?c="+Constant.TAB_PROGRAM+"&md="+mode+"&kix=" + kix + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\"></a>&nbsp;");
							}
							else{
								String forumMode = "";
								if (mode==Constant.APPROVAL){
									forumMode = "apr";
								}
								else if (mode==Constant.REVIEW){
									forumMode = "rvw";
								}
								mid = ForumDB.getTopLevelPostingMessage(conn,fid,j+1);
								program.append("<a href=\"forum/displayusrmsg.jsp?rtn="+forumMode+"&t=-1&fid="+fid+"&mid="+mid+"&item="+(j+1)+"&kix="+kix+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;");
							}

							linkedKey = Constant.TAB_PROGRAM + "_" + question.getNum() + "_" + (j+1) ;
							program.append("<a class=\"popupItem\" id=\""+linkedKey+"\" href='##'><img src=\"../images/flash.gif\" title=\"quick comments\" alt=\"quick comments\" id=\"quick_comments\" /></a>&nbsp;");
						}

						if (reviewerComments>0)
							program.append("<a href=\"prgrvwcmnts.jsp?c="+Constant.TAB_PROGRAM+"&md="+mode+"&kix=" + kix + "&qn=" + question.getNum() + "\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>");
						else
							program.append("<img src=\"images/no-comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\">&nbsp;(" + reviewerComments + ")</td>");

						program.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + question.getQuestion() + "</td></tr>" +
							"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + (String)answers.get(j) + "</td></tr>");

					} // display

					++j;

				} // while
				rs.close();
				ps.close();

				program.append("<tr><td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\"><h3 class=\"subheader\"><a name=\"attachment\">Attachments</></h3></td></tr>");

				String attachments = ProgramsDB.listProgramAttachments(conn,campus,kix);
				if (attachments != null && attachments.length() > 0){
					program.append("<tr><td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\" class=\"textblackth\">"
					+ attachments
					+ "</td></tr>");
				}
				else{
					program.append("<tr><td align=\"left\" valign=\"top\" colspan=\"2\" width=\"100%\" class=\"textblackth\">"
					+ "Attachment not found</td></tr>");
				}

				if (kix != null) {
					program.append("<tr>"
						+ "<td align=\"center\" colspan=\"2\" width=\"100%\">"
						+ "<a href=\"prgrvwcmnts.jsp?md="+mode+"&kix=" + kix + "&qn=0\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWincrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>view comments</span></a>");

					if (fid > 0){
						program.append("&nbsp;&nbsp;<a href=\"./forum/prt.jsp?fid=" + fid + "\" class=\"button\" onclick=\"asePopUpWindow(this.href,'aseWincrsrvwcmnts2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><span>review comments</span></a>");
					}

					String subProgress = ProgramsDB.getSubProgress(conn,kix);
					if (mode==Constant.REVIEW && !subProgress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){
						program.append("&nbsp;&nbsp;<a href=\'prgrvwerx.jsp?f=1&kix=" + kix + "\' class=\'button\'><span>I'm finished</span></a></a></p>");
					}

					program.append("</td></tr>");

				}

				program.append("</table>");

				msg.setErrorLog(program.toString());
			} // if (answers != null)

			answers = null;

		}
		catch( SQLException e ){
			msg.setMsg("ProgramsDB");
			logger.fatal("Programs: reviewProgram\n" + e.toString());
		}
		catch( Exception ex ){
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: reviewProgram - " + ex.toString());
		}

		return msg;
	} // reviewProgram

	/**
	 * showProgramsModifiedByAcademicYear
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	fromDate		String
	 * @param	toDate		String
	 * @param	progress		String
	 * <p>
	 * @return	String
	 */
	public static String showProgramsModifiedByAcademicYear(Connection conn,
																				String campus,
																				String fromDate,
																				String toDate,
																				String progress){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String divisionname = "";
		String dateApproved = "";
		String title = "";
		String proposer = "";
		String sql = "";
		String temp = "";
		String link = "";
		boolean found = false;
		int row = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT historyid, divisionname, title, proposer, dateapproved "
				+ "FROM vw_ProgramForViewing "
				+ "WHERE campus=? "
				+ "AND progress=? "
				+ "AND (YEAR(dateapproved)>=? AND YEAR(dateapproved)<=?) "
				+ "ORDER BY divisionname, title ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ps.setString(3,fromDate);
			ps.setString(4,toDate);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				divisionname = aseUtil.nullToBlank(rs.getString("divisionname"));
				title = aseUtil.nullToBlank(rs.getString("title"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				dateApproved = aseUtil.ASE_FormatDateTime(rs.getString("dateapproved"),Constant.DATE_DATETIME);

				temp = "";

				if (++row % 2 == 0)
					listing.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				else
					listing.append(Constant.TABLE_ROW_START);

				//link = "<a href=\"/centraldocs/docs/outlines/"+campus+"/"+kix+".html\" class=\"linkcolumn\" target=\"_blank\">" + divisionname + "</a>";
				link = "<a href=\"/central/core/vwhtml.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">" + divisionname + "</a>";

				listing.append(
								Constant.TABLE_CELL_DATA_COLUMN
								+ "<a href=\"prgvwx.jsp?type=CUR&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view program\" title=\"view program\"></a>&nbsp;&nbsp;"
								+ "<a href=\"prginfy.jsp?h=1&kix=" + kix + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseviewhistory','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/details.gif\" border=\"0\" alt=\"view program detail\" title=\"view program detail\"></a>"
								+ Constant.TABLE_CELL_END
								+ Constant.TABLE_CELL_DATA_COLUMN + divisionname + Constant.TABLE_CELL_END
								+ Constant.TABLE_CELL_DATA_COLUMN + title + Constant.TABLE_CELL_END
								+ Constant.TABLE_CELL_DATA_COLUMN + proposer + Constant.TABLE_CELL_END
								+ Constant.TABLE_CELL_DATA_COLUMN + dateApproved + Constant.TABLE_CELL_END
								);

				listing.append(Constant.TABLE_ROW_END);

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = Constant.TABLE_START
					+ Constant.TABLE_ROW_START_HIGHLIGHT
					+ Constant.TABLE_CELL_HEADER_COLUMN + "&nbsp;" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Department/Division" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Title" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Proposer" + Constant.TABLE_CELL_END
					+ Constant.TABLE_CELL_HEADER_COLUMN + "Date Approved" + Constant.TABLE_CELL_END
					+ Constant.TABLE_ROW_END
					+ listing.toString()
					+ Constant.TABLE_END;
			}
			else
				temp = "";

			aseUtil = null;
		}
		catch(SQLException ex){
			logger.fatal("ProgramsDB: showProgramsModifiedByAcademicYear - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: showProgramsModifiedByAcademicYear - " + ex.toString());
		}

		return temp;
	} // showProgramsModifiedByAcademicYear

	/*
	 * Is this program reviewable? If so, is this the proposer? Only proposer can invite.
	 * progress = review or modify or review in approval
	 * review requested = proposer
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	kix
	 * @param	user
	 * <p>
	 * @return boolean
	 */
	public static boolean isProgramReviewable(Connection conn,String campus,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean reviewable = false;
		String proposer = "";
		String progress = "";
		String subprogress = "";

		try {
			String sql = "SELECT proposer,progress,subprogress FROM tblPrograms WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				proposer = AseUtil.nullToBlank(rs.getString(1));
				progress = AseUtil.nullToBlank(rs.getString(2));
				subprogress = AseUtil.nullToBlank(rs.getString(3));
			}
			rs.close();
			ps.close();

			String currentApprover = ApproverDB.getCurrentProgramApprover(conn,campus,kix);
			if (currentApprover == null){
				currentApprover = Constant.BLANK;
			}

			// if the proposer and modify or review or review in approval
			// else if current approver and approval or delete
			if (user.equals(proposer)
					&& (		progress.equals(Constant.PROGRAM_MODIFY_PROGRESS)
							|| progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)
							|| subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL))){
				reviewable = true;
			}
			else if (	(	progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) ||
							progress.equals(Constant.PROGRAM_DELETE_PROGRESS))
						||
						user.equals(currentApprover)
				){
				reviewable = true;
			}
			else{
				reviewable = false;
			}

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isProgramReviewable - " + e.toString());
			reviewable = false;
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isProgramReviewable - " + e.toString());
			reviewable = false;
		}

		return reviewable;
	}

	/*
	 * cancelProgramReview - cancels the review process after requesting to start.
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelProgramReview(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in review process
		 * 1) Must be proposer
		 * 2) Cannot have any comments in the system (tblReviewHist)
		 * 3) Remove tasks
		 * 4) Notify reviewers
		 */

		int rowsAffected = 0;
		int i = 0;
		Msg msg = new Msg();
		String SQL = "";
		PreparedStatement ps;

		String alpha = "";
		String divisionDescr = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String cancelReviewAnyTime = "";
		String currentApprover = "";

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("-------------------> cancelProgramReview - START");

			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			divisionDescr = info[Constant.KIX_PROGRAM_DIVISION];
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			subprogress = info[Constant.KIX_SUBPROGRESS];

			if (debug){
				logger.info("kix: " + kix);
				logger.info("title: " + alpha);
				logger.info("divisionDescr: " + divisionDescr);
				logger.info("proposer: " + proposer);
				logger.info("progress: " + progress);
				logger.info("subprogress: " + subprogress);
			}

			if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS) || subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){

				currentApprover = ApproverDB.getCurrentProgramApprover(conn,campus,kix);

				cancelReviewAnyTime = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelReviewAnyTime");

				if (debug){
					logger.info("currentApprover: " + currentApprover);
					logger.info("cancelProgramReview: " + cancelReviewAnyTime);
				}

				if (proposer.equals(user) || currentApprover.equals(user)){

					if (cancelReviewAnyTime.equals(Constant.ON) || !HistoryDB.reviewStarted(conn,campus,kix)){

						// miscdb holds edit1 and edit2 for both course and program.
						// using the call to get back edit1 and 2 are same for both and
						// we are recycling rather than having to recreate new
						if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
							SQL = "UPDATE tblPrograms SET edit=1,progress='MODIFY',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
								"WHERE campus=? AND historyid=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
							ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
							ps.setString(3,campus);
							ps.setString(4,kix);
							rowsAffected = ps.executeUpdate();
						}
						else if (subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){
							SQL = "UPDATE tblPrograms SET edit=0,progress='APPROVAL',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
								"WHERE campus=? AND historyid=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
							ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
							ps.setString(3, campus);
							ps.setString(4, kix);
							rowsAffected = ps.executeUpdate();
						}
						if (debug) logger.info("reset to modify status - " + rowsAffected + " rows");

						// remove reviewer task
						String reviewers = ReviewerDB.getReviewerNames(conn,campus,kix);
						if (!reviewers.equals(Constant.BLANK) && reviewers!=null){

							// refractor ReviewerDB.removeReviewers
							rowsAffected = ReviewerDB.removeReviewers(conn,campus,kix,alpha,divisionDescr,user);

							// truncation problem
							DistributionDB.notifyDistribution(conn,
																		campus,
																		alpha,
																		divisionDescr,
																		"",
																		user,
																		reviewers,
																		"",
																		"emailOutlineCancelReview",
																		"",
																		user);
						} // if !(Constant.BLANK).

						// update review history
						SQL = "INSERT INTO tblReviewHist2 "
								+ "(id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled ) "
								+ "SELECT id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled "
								+ "FROM tblReviewHist "
								+ "WHERE campus=? "
								+ "AND historyid=?";
						ps = conn.prepareStatement(SQL);
						ps.setString(1,campus);
						ps.setString(2,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("moved review to backup history - " + rowsAffected + " rows");

						SQL = "DELETE FROM tblReviewHist WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(SQL);
						ps.setString(1,campus);
						ps.setString(2,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("delete reviews from active table - " + rowsAffected + " rows");

						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																alpha,
																divisionDescr,
																Constant.PROGRAM_REVIEW_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																"REMOVE",
																Constant.PRE);
						if (debug) logger.info("remove review task - " + rowsAffected + " rows");

						if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS))
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	divisionDescr,
																	Constant.PROGRAM_MODIFY_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_REVIEWER,
																	kix,
																	Constant.PROGRAM);
						else
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	divisionDescr,
																	Constant.PROGRAM_APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_REVIEWER,
																	kix,
																	Constant.PROGRAM);

						if (debug) logger.info("recreate task for proposer - " + rowsAffected + " rows");

					}
					else{
						msg.setMsg("ProgramReviewStarted");
						if (debug) logger.info("ProgramsDB: cancelProgramReview - Review started by reviewers.");
					}
				}
				else{
					msg.setMsg("ProgramProposerCanCancel");
					if (debug) logger.info("ProgramsDB: cancelProgramReview - Attempting to cancel when not proposer of program.");
				}
			}
			else{
				msg.setMsg("ProgramNotInReviewStatus");
				if (debug) logger.info("ProgramsDB: cancelProgramReview - Attempting to cancel program review that is not cancellable.");
			}

			AseUtil.logAction(conn,
									proposer,
									"ACTION",
									"Program review cancelled " + alpha,
									"",
									"",
									campus,
									kix);

			if (debug) logger.info("-------------------> cancelProgramReview - END");

		} catch (SQLException ex) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: cancelProgramReview - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("ProgramsDB: cancelProgramReview - " + e.toString());
		}

		return msg;
	} // cancelProgramReview

	/**
	 * getSubProgress
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * <p>
	 * @return	String
	 */
	public static String getSubProgress(Connection conn,String kix){

		String subProgress = "";

		try{
			String sql = "SELECT subProgress FROM tblPrograms WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				subProgress = AseUtil.nullToBlank(rs.getString(1));
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ProgramsDB: getSubProgress - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("ProgramsDB: getSubProgress - " + ex.toString());
		}

		return subProgress;
	}

	/*
	 * endReviewerTask
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg endReviewerTask(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String currentApprover = "";
		String sql = "";
		String mode = "APPROVAL";

		int rowsAffected = 0;
		int numberOfReviewers = 0;

		PreparedStatement ps = null;

		boolean reviewInApproval = false;
		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ProgramsDB");

			if (debug) logger.info("------------------------ endReviewerTask - START");

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_PROGRAM_TITLE];
			String num = info[Constant.KIX_PROGRAM_DIVISION];
			String proposer = info[Constant.KIX_PROPOSER];
			String progress = info[Constant.KIX_PROGRESS];
			String subprogress = info[Constant.KIX_SUBPROGRESS];

			if (subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL) ||
					subprogress.equals(Constant.PROGRAM_REVIEW_IN_DELETE)){

				reviewInApproval = true;

				if (subprogress.equals(Constant.PROGRAM_REVIEW_IN_DELETE)){
					mode = "DELETE";
				}
			} // mode

			msg.setMsg("");

			// end user's review task. If this is the proposer and it was
			// intended to remove users from review, then SQL is different.
			sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();

			currentApprover = TaskDB.getInviter(conn,campus,kix,user);

			if (debug){
				logger.info("kix - " + kix);
				logger.info("currentApprover - " + currentApprover);
				logger.info("user - " + user);
				logger.info("alpha - " + alpha);
				logger.info("num - " + num);
				logger.info("proposer - " + proposer);
				logger.info("progress - " + progress);
				logger.info("subprogress - " + subprogress);
				logger.info("reviewInApproval: " + reviewInApproval);
				logger.info("mode: " + mode);
				logger.info("review completed - " + rowsAffected + " row");
			}

			rowsAffected = TaskDB.logTask(conn,
													user,
													user,
													alpha,
													num,
													Constant.PROGRAM_REVIEW_TEXT,
													campus,
													Constant.BLANK,
													Constant.TASK_REMOVE,
													Constant.PRE,"","",kix,Constant.PROGRAM);
			if (debug) logger.info("review task removed - " + rowsAffected + " row");

			//
			// it's possible that no reviewer added comments. If so, rowsAffected is still 0
			//
			if (rowsAffected >= 0) {
				// if all reviewers have completed their task, let's reset the
				// course and get back to modify mode. also, backup history
				sql = "WHERE historyid = '" + SQLUtil.encode(kix)
						+ "' AND " + "campus = '" + SQLUtil.encode(campus)
						+ "'";

				numberOfReviewers = (int)AseUtil.countRecords(conn,"tblReviewers",sql);

				if (numberOfReviewers == 0) {

					if (subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){
						reviewInApproval = true;
					}

					if (reviewInApproval){
						sql = "UPDATE tblPrograms "
							+ "SET edit=0,edit0='',progress='APPROVAL',subprogress='' "
							+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("reset to program approval - " + rowsAffected + " row");
					}
					else{
						sql = "UPDATE tblPrograms SET edit=1,edit0='',edit1=?,edit2=?,progress='MODIFY' "
							+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
						ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
						ps.setString(3,campus);
						ps.setString(4,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("reset to program modify - " + rowsAffected + " row");
					}

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("move history data - " + rowsAffected + " row");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// if reviews were done during the approval process, put the task back to Approve outline for the
					// currentApprover kicking off the review. Task and message should be directed to currentApprover and not proposer
					// it's possible that the currentApprover is not known so we send null to the function to at least determine
					// if the approval process is in flight.

					// because the review process within approval removed the task for the person kicking off the review
					// then send back to the person requesting the review to start approving.
					MailerDB mailerDB = null;

					if (debug) logger.info("reviewInApproval - " + reviewInApproval);

					if (reviewInApproval){

						if (currentApprover != null && currentApprover.length() > 0)
							mailerDB = new MailerDB(conn,
															user,
															currentApprover,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailProgramReviewCompleted",
															kix,
															user);

						rowsAffected = TaskDB.logTask(conn,
																currentApprover,
																user,
																alpha,
																num,
																Constant.PROGRAM_APPROVAL_TEXT,
																campus,
																"Approve process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.PROGRAM);
						if (debug){
							logger.info("reviewInApproval - mail sent to - " + currentApprover);
							logger.info("reviewInApproval - task created for - " + currentApprover);
						}
					}
					else{
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																proposer,
																alpha,
																num,
																Constant.PROGRAM_MODIFY_TEXT,
																campus,
																"Review process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.PROGRAM);
						mailerDB = new MailerDB(conn,
														user,
														proposer,
														Constant.BLANK,
														Constant.BLANK,
														alpha,
														num,
														campus,
														"emailProgramReviewCompleted",
														kix,
														user);

						if (debug){
							logger.info("reviewInApproval - mail sent to - " + proposer);
							logger.info("reviewInApproval - task created for - " + proposer);
						}
					}
				} // endTask

			} // rowsAffected

			if (debug) logger.info("------------------------ endReviewerTask - END");

		} catch (SQLException e) {
			logger.fatal("ProgramsDB - endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		} catch (Exception e) {
			logger.fatal("ProgramsDB - endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * Determines if user is allowed to review a program and that it is not yet expired
	 * <p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param kix		String
	 *	@param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isProgramReviewer(Connection conn,String campus,String kix,String user) throws Exception {

		boolean reviewer = false;
		int counter = 0;

		try {
			String table = "tblReviewers tbr INNER JOIN tblPrograms tc ON "
					+ "(tbr.campus = tc.campus) AND "
					+ "(tbr.historyid = tc.historyid) ";

			String where = "GROUP BY tbr.historyid,tc.type,tbr.userid,tc.reviewdate "
					+ "HAVING (tbr.historyid='" + SQLUtil.encode(kix) + "' "
					+ " AND tc.type='PRE' "
					+ " AND tbr.userid='" + SQLUtil.encode(user) + "' "
					+ " AND tc.reviewdate >= " + DateUtility.getSystemDateSQL("yyyy-MM-dd") + ")";

			counter = (int) AseUtil.countRecords(conn,table,where);

			if (counter > 0)
				reviewer = true;
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isProgramReviewer - " + e.toString());
			reviewer = false;
		}

		return reviewer;
	}

	/*
	 * setProgramEdit
	 *	<p>
	 *	@return int
	 */
	public static int setProgramEdit(Connection conn,String campus,String kix,String edits) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblPrograms SET edit=1,edit1=? WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,edits);
			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: setProgramEdit - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: setProgramEdit - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * approveProgramReview
	 *	<p>
	 *	@param	connection
	 * @param	campus
	 * @param	kix
	 * @param	user
	 * @param	approval
	 * @param	comments
	 *	<p>
	 *	@return int
	 */
	public static int approveProgramReview(Connection conn,String campus,String kix,String user,String comments) throws Exception {

		int rowsAffected = 0;
		String divisionDescr = "";
		String title = "";

		try{
			// because this is reviews within an approval, we don't have the ability to approve
			// so set the approved flag to FALSE.

			int sequence = ApproverDB.getSequenceNotApproved(conn,campus,kix);
			String inviter = TaskDB.getInviter(conn,campus,kix,user);

			if (!HistoryDB.isMatch(conn,campus,kix,user,inviter)){

				Programs program = ProgramsDB.getProgram(conn,campus,kix);
				if ( program != null ){
					title = program.getTitle();
					divisionDescr = program.getDivisionDescr();
				}

				rowsAffected = HistoryDB.addHistory(conn,
																title,
																divisionDescr,
																campus,
																user,
																CourseApproval.getNextSequenceNumber(conn),
																false,comments,kix,
																sequence,0,0,0,inviter,
																Constant.TASK_REVIEWER,
																Constant.COURSE_REVIEW_TEXT);
			}
			else{
				rowsAffected = HistoryDB.updateHistory(conn,campus,user,comments,kix,0,0,0,inviter);
			}

		}
		catch(Exception e){
			logger.fatal("ProgramsDB: approveProgramReview - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getProgramItem
	 *	<p>
	 *	@return String
	 */
	public static String getProgramItem(Connection conn,String kix,String column) throws SQLException {

		return getItem(conn,kix,column);
	}

	/*
	 * getProgramItem
	 *	<p>
	 *	@return String
	 */
	public static String getItem(Connection conn,String kix,String column) throws SQLException {

		String programItem = "";

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT " + column + " FROM tblPrograms WHERE historyid=?");
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				programItem = AseUtil.nullToBlank(rs.getString(column));

				if (programItem != null && programItem.length() > 0){
					if (DateUtility.isDate(programItem)){
						programItem = DateUtility.formatDateAsString(programItem);
					}
				}

			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getProgramItem - " + e.toString());
		}

		return programItem;
	}

	/*
	 * getProgramItem
	 *	<p>
	 *	@return String
	 */
	public static String getProgramItem(Connection conn,String campus,String alpha,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String programItem = "";

		try {
			String sql = "SELECT " + column + " FROM tblPrograms WHERE campus=? AND title=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				programItem = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: getProgramItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramsDB: getProgramItem - " + e.toString());
		}

		return programItem;
	}

	/*
	 * A program is cancallable only if: edit flag = true and progress = modify
	 * and canceller = proposer
	 * <p>
	 *	@param	Connection	connection
	 *	@param	String		kix
	 *	@param	String		user
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCancellable(Connection conn,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean cancellable = false;
		String proposer = "";
		String progress = "";

		try {
			String sql = "SELECT edit,proposer,progress FROM tblprograms WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cancellable = rs.getBoolean(1);
				proposer = rs.getString(2);
				progress = rs.getString(3);
			}

			// only the proposer may cancel a pending course
			if (cancellable && user.equals(proposer) &&
				(	progress.equals(Constant.PROGRAM_MODIFY_PROGRESS) ||
					progress.equals(Constant.PROGRAM_DELETE_PROGRESS) ||
					progress.equals(Constant.PROGRAM_REVISE_PROGRESS)
				)){
				cancellable = true;
			}
			else{
				cancellable = false;
			}

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ProgramsDB: isCancellable - " + e.toString());
			cancellable = false;
		}

		return cancellable;
	}

	/**
	 * setSubProgress
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	subProgress	String
	 * <p>
	 * @return	int
	 */
	public static int setSubProgress(Connection conn,String kix,String subProgress){

		int rowsAffected = 0;

		try{
			String sql = "UPDATE tblprograms SET subprogress=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,subProgress);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ProgramsDB: setSubProgress - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramsDB: setSubProgress - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * showProgramStatus
	 *	<p>
	 * @param	conn	Connection
	 * @param	sql	String
	 *	<p>
	 *	@return String
	 */
	public static String showProgramStatus(Connection conn,String sql) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"prgidx\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">&nbsp;</th>"
				+ "<th align=\"left\">Program</th>"
				+ "<th align=\"left\">Division Name</th>"
				+ "<th align=\"left\">Title</th>"
				+ "<th align=\"left\">Effective</th>"
				+ "<th align=\"left\">Audited By</th>"
				+ "<th align=\"right\">Audited Date</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String program = AseUtil.nullToBlank(rs.getString("program"));
				String divisionName = AseUtil.nullToBlank(rs.getString("DivisionName"));
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String effective = AseUtil.nullToBlank(rs.getString("Effective"));
				String auditedBy = AseUtil.nullToBlank(rs.getString("AuditedBy"));
				String auditedDate = aseUtil.ASE_FormatDateTime(rs.getString("auditeddate"),Constant.DATE_DATETIME);

				buf.append("<tr>"
					+ "<td align=\"left\">"
					+ "<a href=\"prgvwx.jsp?type=PRE&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" title=\"view program\"></a>&nbsp;"
					+ "<a href=\"prgedt6.jsp?type=PRE&kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" title=\"request program approval\"></a>"
					+ "</td>"
					+ "<td align=\"left\"><a href=\"prgedt.jsp?kix="+kix+"\" class=\"linkcolumn\">" + program + "</a></td>"
					+ "<td align=\"left\">" + divisionName + "</td>"
					+ "<td align=\"left\">" + title + "</td>"
					+ "<td align=\"left\">" + effective + "</td>"
					+ "<td align=\"left\">" + auditedBy + "</td>"
					+ "<td align=\"right\">" + auditedDate + "</td>"
					+ "</tr>");
			}
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("ProgramsDB - showProgramStatus: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ProgramsDB - showProgramStatus: " + e.toString());
		}

		return buf.toString() + "</tbody></table></div></div>";
	}

	/*
	 * isProgramReviewerNoDateCheck
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isProgramReviewerNoDateCheck(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean reviewer = false;
		int counter = 0;

		try {
			String table = "tblReviewers ";
			String where = "WHERE campus='" + SQLUtil.encode(campus) + "' "
					+ " AND historyid='" + SQLUtil.encode(kix) + "' "
					+ " AND userid='" + SQLUtil.encode(user) + "' ";
			counter = (int) AseUtil.countRecords(conn,table,where);

			if (counter > 0)
				reviewer = true;
		} catch (Exception e) {
			logger.fatal("ProgramsDB: isProgramReviewer - " + e.toString());
			reviewer = false;
		}

		return reviewer;
	}

	/*
	 * getCreatedDates
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getCreatedDates(Connection conn,String campus,String type) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil aseUtil = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT DISTINCT tblPrograms.type, tblPrograms.title, MAX(logs.datetime) AS created, tblPrograms.proposer, logs.historyid "
					+ "FROM (SELECT id, userid, script, action, alpha, num, datetime, campus, historyid "
					+ "FROM tblUserLog "
					+ "WHERE (action LIKE 'Create program%' OR action LIKE 'Program created -%') AND (campus=?) "
					+ "UNION "
					+ "SELECT id, userid, script, action, alpha, num, datetime, campus, historyid "
					+ "FROM tblUserLog2 "
					+ "WHERE (action LIKE 'Create program%' OR action LIKE 'Program created -%') AND (campus=?)) AS logs INNER JOIN "
					+ "tblPrograms ON logs.campus = tblPrograms.campus AND logs.historyid = tblPrograms.historyid "
					+ "GROUP BY tblPrograms.type, tblPrograms.title, tblPrograms.proposer, logs.historyid "
					+ "HAVING tblPrograms.type=? "
					+ "ORDER BY tblPrograms.title, tblPrograms.type ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,campus);
				ps.setString(3,type);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											aseUtil.nullToBlank(rs.getString("title")),
											aseUtil.ASE_FormatDateTime(rs.getString("created"),Constant.DATE_SHORT),
											aseUtil.nullToBlank(rs.getString("proposer")),
											aseUtil.nullToBlank(rs.getString("historyid")),
											"",
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

				aseUtil = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ProgramsDB - getCreatedDates: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ProgramsDB - getCreatedDates: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String footerStatus(Connection conn,String kix,String type) {

		String footerStatus = "";

		try{
			if(type.equals("ARC")){
				footerStatus = "Archived on " + getItem(conn,kix,"dateapproved");
			}
			else if(type.equals("CUR")){
				footerStatus = "Approved on " + getItem(conn,kix,"dateapproved");
			}
			else if(type.equals("PRE")){
				footerStatus = "Last modified on " + getItem(conn,kix,"auditdate");
			}
		}
		catch(Exception e){
			logger.fatal("footerStatus ("+kix+"/"+type+"): " + e.toString());
		}

		return footerStatus;
	}

	/*
	 * setItem
	 *	<p>
	 *	@return int
	 */
	public static int setItem(Connection conn,String campus,String kix,String column,String data,String dataType) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblPrograms SET "+column+"=? WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			if (dataType.equals("s"))
				ps.setString(1,data);
			else
				ps.setInt(1,Integer.parseInt(data));

			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramsDB: setItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ProgramsDB: setItem - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}