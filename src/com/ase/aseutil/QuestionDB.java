/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 *	public static boolean areItemsEnabled(Connection conn,String kix) throws Exception {
 *	public static int cccm6100Question(Connection connection, int lid,String type,int length,int max,String ini,String explain)
 *	public static String getCampusColumms(Connection conn,String campus) throws Exception {
 *	public static String getCampusColummNames(Connection conn,String campus) throws Exception {
 *	public static ResultSet getCampusQuestion(Connection conn,int tab,String campus)
 *	public static int[] getCourseEditableItems(Connection conn,String campus) throws Exception {
 *	public static String getCourseQuestion(Connection connection,String campus,int type,int question)
 *	public static Question getCourseQuestionByColumn(Connection connection,String campus,String column)
 *	public static Question getCourseQuestionByColumn(Connection connection,String campus,String column,int type)
 *	public static String getCourseQuestionBySequence(Connection connection,String campus,int type,int seq) throws Exception {
 *	public static String getCourseHelp(Connection connection,String campus,int type,int question)
 *	public static ArrayList getCampusQuestions(Connection connection,String campus)
 *	public static ArrayList getCourseQuestions(Connection connection,int type,String campus)
 *	public static ArrayList getCourseQuestionsByNumber(Connection connection,int type,String campus)
 *	public static ArrayList getCampusQuestionsByInclude(Connection conn,String campus, String include)
 *	public static ArrayList getCourseQuestionsInclude(Connection conn,String campus,String include)
 *	public static String getExplainData(Connection connection,String campus,String alpha,String num,String type,String explain)
 *	public static help getHelp(Connection connection,String category,String title,String campus)
 *	public static int getQuestionNumber(Connection conn,String campus,int type,int seq)
 *	public static ArrayList getProgramQuestionsInclude(Connection conn,String campus,String include) throws Exception {
 *	public static boolean isCourseItemEditable(Connection conn,String kix,int item) throws Exception {
 *	public static int resequenceItems(Connection conn,String questionType,String campus,String user)
 *	public static Msg resequenceItems2(Connection conn, String questionType,String campus, String sequences)
 * showFields(Connection conn,String campus,String alpha,String num,String rtn,int editing,boolean enabling)
 *	public static String showProgramFields(Connection conn,String campus,String kix,String rtn,int editing,boolean enabling) throws SQLException {
 *	public static Msg updateQuestion(Connection conn,int lid,int newSeq,int oldSeq,int questionNumber,
 *												String questionType,String campus,
 *												String question,String help,String included,String change,String auditby,
 *												String auditdate,String questionType) throws SQLException
 *
 */

//
// QuestionDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

public class QuestionDB {
	static Logger logger = Logger.getLogger(CourseDB.class.getName());

	public QuestionDB() throws Exception {}

	final static int NEW_GREATER_OLD = 0;
	final static int OLD_GREATER_NEW = 1;
	final static int NO_CHANGE 		= 2;
	final static int INSERT_QUESTION = 3;
	final static int REMOVE_QUESTION = 4;

	/**
	 * update course items
	 * <p>
	 * @param conn			Connection
	 * @param cccm			CCCM6100
	 * @param oldSeq		int
	 * @param tableName	String
	 * <p>
	 * @return Msg
	 */
	public static Msg updateQuestion(Connection conn,CCCM6100 cccm,int oldSeq,String tableName) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int junk = 0;
		int totalElements = 0;

		int lid = cccm.getId();
		int newSeq = cccm.getQuestionSeq();
		int questionNumber = cccm.getQuestion_Number();
		String questionType = cccm.getType();
		String campus = cccm.getCampus();
		String question = cccm.getCCCM6100();
		String headerText = cccm.getHeaderText();
		String help = cccm.getHelp();
		String included = cccm.getInclude();
		String required = cccm.getRequired();
		String change = cccm.getQuestion_Change();
		String auditby = cccm.getAuditBy();
		String auditdate = cccm.getAuditDate();
		String helpFile = cccm.getHelpFile();
		String audioFile = cccm.getAudioFile();
		String questionFriendly = cccm.getQuestion_Friendly();
		String defalt = cccm.getDefalt();
		String comments = cccm.getComments();
		int len = cccm.getUserLen();
		String counter = cccm.getCounter();
		String extra = cccm.getExtra();

		// ------------------------------
		// 1 is the start of things to do when adding to the course/campus/program item screens
		// ------------------------------
		String permanent = cccm.getPermanent();
		String append = cccm.getAppend();

		/*
			there are possible scenarios

			0) Include is N

			1) Old Seq = 0

				When old sequence is 0 and include is yes, this means that we are activating an item

			2) new seq = old seq

				do not have to check for include = N or Y. When N, handled by #0. If yes, no change here.

			3) new seq is greater old seq

			4) new seq is less than old seq
				changing the sequence number.
				1) start by putting the requested change out of the way
				2) update all sequence between the new seq and old seq
				3) update the displaced item from #1 with the correct value

				for example, assuming the old seq = 6 and we want to make it to 2

				Original order:		1 2 3 4 5 6 7 8 9 10
				#1 above:				-1 1 2 3 4 5 7 8 9 10	(6 was moved out of the way by setting to -1)
				#2 above:				-1 1 3 4 5 6 7 8 9 10	(everthing from the old seq to less than new seq is moved)
				#3	above:				1 2 3 4 5 6 7 8 9 10		(put -1 back into its correct spot)

		*/
		int qNumber = 0;				// question number from database
		int qSeq = 0;					// sequence from database
		int rowsAffected = 0;
		String sql;
		String table = "";
		PreparedStatement ps;

		int total = 0;							// temp variable
		int i = 0;
		Msg msg = new Msg();

		int os = 0;
		int ns = 0;
		int qn = 0;

		boolean debug = false;

		int direction = 0;

		try {
			AseUtil aseUtil = new AseUtil();

			debug = DebugDB.getDebug(conn,"QuestionDB");

			if (debug) logger.info("----------------- START");

			if (tableName.equals(Constant.TABLE_COURSE)){
				table = "tblCourseQuestions";
			}
			else if (tableName.equals(Constant.TABLE_CAMPUS)){
				table = "tblCampusQuestions";
			}
			else if (tableName.equals(Constant.TABLE_PROGRAM)){
				table = "tblProgramQuestions";
			}

			if (debug){
				logger.info("lid: " + lid);
				logger.info("newSeq: " + newSeq);
				logger.info("questionNumber: " + questionNumber);
				logger.info("questionType: " + questionType);
				logger.info("campus: " + campus);
				logger.info("question: " + question);
				logger.info("help: " + help);
				logger.info("included: " + included);
				logger.info("Comments: " + comments);
				logger.info("required: " + required);
				logger.info("change: " + change);
				logger.info("auditby: " + auditby);
				logger.info("auditdate: " + auditdate);
				logger.info("helpFile: " + helpFile);
				logger.info("audioFile: " + audioFile);
				logger.info("questionFriendly: " + questionFriendly);
				logger.info("defalt: " + defalt);
				logger.info("table: " + table);
				logger.info("len: " + len);
				logger.info("counter: " + counter);
				logger.info("extra: " + extra);
				logger.info("header text: " + headerText);
				logger.info("permanent: " + permanent);
				logger.info("append: " + append);
			}

			// ------------------------------
			// 2
			// ------------------------------

			if (included.equals("N")){

				if (debug) logger.info("NOT included");

				// when removing item from use, reset the question to what is in CCCM6100
				CCCM6100 cm = CCCM6100DB.getCCCM6100ByFriendlyName(conn,questionFriendly);

				//1
				sql = "UPDATE " + table
					+ " SET questionseq=0,include='N',comments='Y',auditby=?,auditdate=?,question=?,help=?,defalt=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, auditby);
				ps.setString(2, AseUtil.getCurrentDateTimeString());
				ps.setString(3, cm.getCCCM6100());
				ps.setString(4, cm.getCCCM6100());
				ps.setString(5, cm.getDefalt());
				ps.setString(6, campus);
				ps.setInt(7, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM "
						+ table
						+ " WHERE campus=? AND include='Y' AND questionseq > ? ORDER BY questionseq";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, oldSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os - 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
				}
				rs.close();
				ps.close();

				direction = REMOVE_QUESTION;

			} // REMOVE_QUESTION
			else if (oldSeq==0){

				if (debug) logger.info("oldSeq==0");

				//1 - moving everything up by 1
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? AND include='Y' AND questionseq>=? ORDER BY questionseq DESC";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, newSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os + 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
				}
				rs.close();
				ps.close();

				// ------------------------------
				// 3
				// ------------------------------

				//2 - add new
				sql = "UPDATE "
					+ table
					+ " SET questionseq=?,include='Y',change=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?, "
					+ "help=?,defalt=?,question=?,comments=?,len=?,counttext=?,extra=?,permanent=?,append=?,headertext=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, change);
				ps.setString(3, auditby);
				ps.setString(4, AseUtil.getCurrentDateTimeString());
				ps.setString(5, required);
				ps.setString(6, helpFile);
				ps.setString(7, audioFile);
				ps.setString(8, help);
				ps.setString(9, defalt);
				ps.setString(10, question);
				ps.setString(11, comments);
				ps.setInt(12, len);
				ps.setString(13, counter);
				ps.setString(14, extra);
				ps.setString(15, permanent);
				ps.setString(16, append);
				ps.setString(17, headerText);
				ps.setString(18, campus);
				ps.setInt(19, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				direction = INSERT_QUESTION;

			} // INSERT_QUESTION
			else if (newSeq == oldSeq){

				if (debug) logger.info("newSeq==oldSeq");

				// ------------------------------
				// 4
				// ------------------------------

				sql = "UPDATE "
					+ table
					+ " SET change=?,question=?,help=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?,defalt=?,"
					+ "comments=?,len=?,include=?,counttext=?,extra=?,permanent=?,append=?,headertext=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, change);
				ps.setString(2, question);
				ps.setString(3, help);
				ps.setString(4, auditby);
				ps.setString(5, AseUtil.getCurrentDateTimeString());
				ps.setString(6, required);
				ps.setString(7, helpFile);
				ps.setString(8, audioFile);
				ps.setString(9, defalt);
				ps.setString(10, comments);
				ps.setInt(11, len);
				ps.setString(12, included);
				ps.setString(13, counter);
				ps.setString(14, extra);
				ps.setString(15, permanent);
				ps.setString(16, append);
				ps.setString(17, headerText);
				ps.setString(18, campus);
				ps.setInt(19, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				direction = NO_CHANGE;
			}
			else if (newSeq > oldSeq){

				if (debug) logger.info("newSeq>oldSeq");

				// ------------------------------
				// 5
				// ------------------------------

				//1
				sql = "UPDATE "
					+ table
					+ " SET questionseq=-1,question=?,help=?,include=?,change=?,auditby=?,auditdate=?,required=?,helpfile=?,"
					+ "audiofile=?,defalt=?,comments=?,len=0,counttext=?,extra=?,permanent=?,append=?,headertext=? "
					+ " WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);

				ps.setString(2, help);
				ps.setString(3, included);
				ps.setString(4, change);
				ps.setString(5, auditby);
				ps.setString(6, AseUtil.getCurrentDateTimeString());
				ps.setString(7, required);
				ps.setString(8, helpFile);
				ps.setString(9, audioFile);
				ps.setString(10, defalt);
				ps.setString(11, comments);
				ps.setString(12, counter);
				ps.setString(13, extra);
				ps.setString(14, permanent);
				ps.setString(15, append);
				ps.setString(16, headerText);
				ps.setString(17, campus);
				ps.setInt(18, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? AND include='Y' AND (questionseq>? AND questionseq<=?) ORDER BY questionseq";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, oldSeq);
				ps.setInt(3, newSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os - 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
				}
				rs.close();
				ps.close();

				// ------------------------------
				// 6
				// ------------------------------

				//3
				sql = "UPDATE "
					+ table
					+ " SET questionseq=?,required=?,helpfile=?,audiofile=?,comments=?,len=?,counttext=?,extra=?,permanent=?,append=?,headertext=? WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, required);
				ps.setString(3, helpFile);
				ps.setString(4, audioFile);
				ps.setString(5, comments);
				ps.setInt(6, len);
				ps.setString(7, counter);
				ps.setString(8, extra);
				ps.setString(9, permanent);
				ps.setString(10, append);
				ps.setString(11, headerText);
				ps.setString(12, campus);
				ps.setInt(13, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				direction = NEW_GREATER_OLD;
			} // NEW_GREATER_OLD
			else if (newSeq < oldSeq){

				if (debug) logger.info("newSeq < oldSeq");

				// ------------------------------
				// 7
				// ------------------------------

				//1
				sql = "UPDATE "
					+ table
					+ " SET questionseq=-1,question=?,help=?,include=?,change=?,auditby=?,auditdate=?,"
					+ "required=?,helpfile=?,audiofile=?,defalt=?,comments=?,len=?,counttext=?,extra=?,permanent=?,append=?,headertext=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);
				ps.setString(2, help);
				ps.setString(3, included);
				ps.setString(4, change);
				ps.setString(5, auditby);
				ps.setString(6, AseUtil.getCurrentDateTimeString());
				ps.setString(7, required);
				ps.setString(8, helpFile);
				ps.setString(9, audioFile);
				ps.setString(10, defalt);
				ps.setString(11, comments);
				ps.setInt(12, len);
				ps.setString(13, counter);
				ps.setString(14, extra);
				ps.setString(15, permanent);
				ps.setString(16, append);
				ps.setString(17, headerText);
				ps.setString(18, campus);
				ps.setInt(19, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? AND include='Y' AND (questionseq>=? AND questionseq<?) ORDER BY questionseq DESC";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, newSeq);
				ps.setInt(3, oldSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os + 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE "
							+ table
							+ " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
				}
				rs.close();
				ps.close();

				// ------------------------------
				// 8
				// ------------------------------

				//3
				sql = "UPDATE "
						+ table
						+ " SET questionseq=?,change=?,required=?,helpfile=?,audiofile=?,comments=?,len=?,counttext=?,extra=?,permanent=?,append=?,headertext=? WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, change);
				ps.setString(3, required);
				ps.setString(4, helpFile);
				ps.setString(5, audioFile);
				ps.setString(6, comments);
				ps.setInt(7, len);
				ps.setString(8, counter);
				ps.setString(9, extra);
				ps.setString(10, permanent);
				ps.setString(11, append);
				ps.setString(12, headerText);
				ps.setString(13, campus);
				ps.setInt(14, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				direction = OLD_GREATER_NEW;
			} // OLD_GREATER_NEW

			if (debug) logger.info("----------------- END");

			aseUtil = null;

			if (direction != NO_CHANGE){
				resetQuestionFlags(conn,campus,oldSeq,newSeq,direction,tableName);
			}

		} catch (SQLException se) {
			logger.fatal("QuestionDB: updateQuestion - " + se.toString());
			msg.setMsg("Exception");
			msg.setErrorLog("QuestionDB: updateQuestion - " + se.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: updateQuestion - " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog("QuestionDB: updateQuestion - " + e.toString());
		}

		return msg;
	} // updateQuestion

	/**
	 * update course items as maintained by system administrator
	 * <p>
	 *
	 * @param lid course item
	 * @param type item type
	 * @param length item length
	 * @param max maximum length of item
	 * @param ini refernce to table
	 * <p>
	 */
	public static int cccm6100Question(Connection connection,
													int lid,
													String type,
													int length,
													int max,
													String ini,
													String explain) {

		return cccm6100Question(connection,lid,type,length,max,ini,explain,length);

	}


	public static int cccm6100Question(Connection connection,
													int lid,
													String type,
													int length,
													int max,
													String ini,
													String explain,
													int len) {

		int rowsAffected = 0;
		String sql = "UPDATE CCCM6100 SET question_len=?,question_max=?,question_type=?,question_ini=?,question_explain=?,len=? WHERE id=?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, length);
			ps.setInt(2, max);
			ps.setString(3, type);
			ps.setString(4, ini);
			ps.setString(5, explain);
			ps.setInt(6, len);
			ps.setInt(7, lid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: cccm6100Question - " + e.toString());
			rowsAffected = 0;
		}

		return rowsAffected;
	}

	/**
	 * resequenceItems once defined by user
	 * <p>
	 * @param conn 		Connection
	 * @param tableName	String
	 * @param campus 		String
	 * @param user 		String
	 * <p>
	 */
	public static int resequenceItems(Connection conn,String tableName,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int questionnumber = 0;
		int i = 0;

		boolean debug = false;

		try {
			PreparedStatement ps;
			String resequenceSQL;
			String resetExcludedItemsSQL;
			String table = "";
			String view = "";
			String resequence = "";
			String campusField = "";
			String sql = "";

			if (tableName.equals("r")) {
				table = "tblCourseQuestions";
				view = "vw_CourseQuestions";
				resequence = SQL.vw_ResequenceCourseItems;
				campusField = "courseitems";
			} else if (tableName.equals("c")){
				table = "tblCampusQuestions";
				view = "vw_CampusQuestions";
				resequence = SQL.vw_ResequenceCampusItems;
				campusField = "campusitems";
			} else if (tableName.equals("p")){
				table = "tblProgramQuestions";
				view = "vw_programquestions";
				resequence = SQL.vw_ResequenceProgramItems;
				campusField = "programitems";
			}

			resequenceSQL = "UPDATE "
								+ table
								+ " SET questionseq=? "
								+ "WHERE campus=? "
								+ "AND type='Course' "
								+ "AND questionseq=?";

			//
			// loop through and renumber question sequence. this is done in case there are gaps
			//
			i = 0;
			sql = "SELECT questionseq, question_number "
						+ "FROM " + view
						+ " WHERE campus=? "
						+ "ORDER BY questionseq";
			ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int oldSeq = rs.getInt(1);
				int newSeq = ++i;
				questionnumber = rs.getInt("question_number");
				ps = conn.prepareStatement(resequenceSQL);
				ps.setInt(1, newSeq);
				ps.setString(2, campus);
				ps.setInt(3, oldSeq);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("questionnumber: " + questionnumber + " from: " + oldSeq + "; to: " + newSeq);
			}
			rs.close();
			ps.close();

			// reset excluded items
			resetExcludedItemsSQL = "UPDATE "
											+ table
											+ " SET questionseq=0 "
											+ "WHERE campus=? "
											+ "AND type='Course' "
											+ "AND include='N'";
			ps = conn.prepareStatement(resetExcludedItemsSQL);
			ps.setString(1, campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			//
			// save field names get course field names that are included by campus
			//
			String temp = "";
			sql = "SELECT question_friendly "
					+ "FROM (" + resequence
					+ ") as tblX "
					+ "WHERE campus=? "
					+ "ORDER BY questionseq";
			ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			rs = ps.executeQuery();
			while (rs.next()) {
				if (temp.length() == 0)
					temp = AseUtil.nullToBlank(rs.getString("question_friendly"));
				else
					temp = temp + "," + AseUtil.nullToBlank(rs.getString("question_friendly"));
			}
			rs.close();
			rs = null;

			if (temp.length() > 0) {
				ps = conn.prepareStatement("UPDATE tblCampus SET " + campusField + "=? WHERE campus=?");
				ps.setString(1,temp);
				ps.setString(2,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// recreate the outline
				Outlines.createOutlineTemplate(conn,campus,"outline","CUR",user);
				Outlines.createOutlineTemplate(conn,campus,"outline","PRE",user);
			}

			if (debug) logger.info("QuestionDB: items resequenced - " + user);

		} catch (SQLException e) {
			logger.fatal("QuestionDB: resequenceItems - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("QuestionDB: resequenceItems - " + ex.toString());
		}

		return rowsAffected;
	} // resequenceItems

	/**
	 * getCampusQuestion
	 * <p>
	 *
	 * @param campus
	 * TODO is this one needed
	 * <p>
	 */
	public static ResultSet getCampusQuestion(Connection conn,int tab,String campus) {

		ResultSet rs = null;

		try {
			String sql = "";

			if (tab == 1){
				sql = SQL.vw_CourseQuestions;
			}
			else{
				sql = SQL.vw_CampusQuestions;
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCampusQuestion - " + e.toString());
		}

		return rs;
	}

	/**
	 * getCampusQuestion
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	tab		int
	 * @param	help		int
	 * <p>
	 * @return	String
	 */
	public static String getCampusQuestion(Connection conn,String campus,int tab) {

		return getCampusQuestion(conn,campus,tab,0);
	}

	public static String getCampusQuestion(Connection conn,String campus,int tab,int help) {

		//Logger logger = Logger.getLogger("test");

		String descr = "";
		String questionseq = "";
		String bgColor = "";
		String requiredItems = "";
		String data = "";
		StringBuffer question = new StringBuffer();
		int i = 0;

		try {

			if (help==0){
				data = "question";
			}
			else{
				data = "help";
			}

			// collect all required questions
			String sql = "SELECT questionseq FROM vw_OutlineValidation WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (requiredItems.equals(Constant.BLANK))
					requiredItems = AseUtil.nullToBlank(rs.getString(1));
				else
					requiredItems = requiredItems + "," + AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();

			// if requiredItems is not empty, place commas before and after for later use
			// when doing indexOf, the before and after commas make it possible for us
			// to find the index of item when it is surrounded by commas. this includes
			// the first and last entries as well.
			if (!requiredItems.equals(Constant.BLANK)){
				requiredItems = "," + requiredItems + ",";
			}

			// read and display all questions for outline modifications. if a question here
			// matches with a seqenece from the prior read, highlight to indicate that it is
			// a required outline item
			if (tab == Constant.TAB_COURSE){
				sql = SQL.vw_CourseQuestions;
			}
			else{
				i = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
				sql = SQL.vw_CampusQuestions;
			}
			ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			rs = ps.executeQuery();
			while (rs.next()) {
				descr = AseUtil.nullToBlank(rs.getString(data));
				questionseq = "," + AseUtil.nullToBlank(rs.getString("questionseq")) + ",";

				bgColor = "";
				if (!requiredItems.equals(Constant.BLANK)){
					if (requiredItems.indexOf(questionseq) >-1 )
						bgColor = "LIGHTYELLOW";
				}

				question.append("<tr bgcolor=\""+bgColor+"\"><td valign=top>" + (++i) + "</td><td valign=top>" + descr + "</td></tr>");
			}
			rs.close();
			ps.close();

			descr = question.toString();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCampusQuestion - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("QuestionDB: getCampusQuestion\n" + ex.toString());
		}

		return descr;
	}

	/*
	 * getCourseQuestions
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	type			int
	 * @param	question		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestion(Connection conn,String campus,int type,int question) throws Exception {

		String thisQuestion = "";
		String sql = "";
		try {
			if (type==1){
				sql = "tblCourseQuestions";
			}
			else{
				sql = "tblCampusQuestions";
			}

			if(question > 0){
				sql = "SELECT question FROM " + sql + " WHERE campus=? AND questionseq=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, question);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					thisQuestion = AseUtil.nullToBlank(rs.getString("question"));
				}
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCourseQuestion - " + e.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestion - " + e.toString());
		}

		return thisQuestion;
	}

	/*
	 * getCourseQuestionByNumber
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	type			int
	 * @param	question		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionByNumber(Connection connection,String campus,int type,int question) throws Exception {

		String thisQuestion = "";
		String sql = "";
		try {
			if (type==Constant.TAB_COURSE)
				sql = "tblCourseQuestions";
			else if (type==Constant.TAB_CAMPUS)
				sql = "tblCampusQuestions";
			else if (type==Constant.TAB_PROGRAM)
				sql = "tblProgramQuestions";

			sql = "SELECT question FROM " + sql + " WHERE campus=? AND questionnumber=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, question);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				thisQuestion = AseUtil.nullToBlank(resultSet.getString(1));
			}
			resultSet.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseQuestionByNumber - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionByNumber - " + e.toString());
		}

		return thisQuestion;
	}

	/*
	 * getCourseQuestionBySequence
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	type			String
	 * @param	seq			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionBySequence(Connection connection,String campus,int type,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String question = "";
		String sql = "";
		try {
			if (type==Constant.TAB_COURSE){
				sql = "tblCourseQuestions";
			}
			else if (type==Constant.TAB_CAMPUS){
				sql = "tblCampusQuestions";

				// depending on where we are callling from, the seq may be
				// the total of course questions + the sequence on campus
				// this logic takes into account for that and sets things straight.
				int courseTabCount = CourseDB.countCourseQuestions(connection,campus,"Y","",1);
				if (seq > courseTabCount){
					seq = seq - courseTabCount;
				}
			}
			else if (type==Constant.TAB_PROGRAM){
				sql = "tblProgramQuestions";
			}

			sql = "SELECT question FROM " + sql + " WHERE campus=? AND questionseq=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				question = AseUtil.nullToBlank(rs.getString("question"));

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseQuestionBySequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionBySequence - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionBySequence
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	source		String
	 * @param	question		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionBySequence(Connection connection,String campus,String source,int question) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String thisQuestion = "";
		int thisQuestionSeq = 0;
		String sql = "";
		try {
			if ("1".equals(source))
				sql = "tblCourseQuestions";
			else if ("2".equals(source))
				sql = "tblCampusQuestions";
			else if ("-1".equals(source))
				sql = "tblProgramQuestions";

			sql = "SELECT question,questionseq FROM " + sql + " WHERE campus=? AND questionnumber=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, question);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				thisQuestion = AseUtil.nullToBlank(rs.getString("question"));
				thisQuestionSeq = rs.getInt("questionseq");
				thisQuestion = thisQuestion + "~" + thisQuestionSeq;
			}
			else
				thisQuestion = "0~0";

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseQuestionBySequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionBySequence - " + e.toString());
		}

		return thisQuestion;
	}

	/*
	 * getCourseQuestionByFriendlyName
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	column		String
	 * @param	type			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionByFriendlyName(Connection connection,String campus,String column,int type) throws Exception {

		String sql = "";
		String question = "";

		try {
			if (type==1)
				sql = "vw_CourseQuestionsYN";
			else
				sql = "vw_CampusQuestionsYN";

			sql = "SELECT question FROM " + sql + " WHERE campus=? AND Question_Friendly=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question = AseUtil.nullToBlank(rs.getString("question"));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionByFriendlyName - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionTypeByFriendlyName
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	column		String
	 * @param	type			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionTypeByFriendlyName(Connection connection,String campus,String column,int type) throws Exception {

		String sql = "";
		String question = "";

		try {
			if (type==1)
				sql = "vw_CourseQuestionsYN";
			else
				sql = "vw_CampusQuestionsYN";

			sql = "SELECT question_type FROM " + sql + " WHERE campus=? AND Question_Friendly=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question = AseUtil.nullToBlank(rs.getString("question_type"));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionTypeByFriendlyName - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionByColumn
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	column		String
	 * @param	type			int
	 *	<p>
	 *	@return Question
	 */
	public static Question getCourseQuestionByColumn(Connection connection,String campus,String column,int type) throws Exception {

		String sql = "";
		Question question = null;

		try {
			if (type==1){
				sql = "vw_CourseQuestionsYN";
			}
			else{
				sql = "vw_CampusQuestionsYN";
			}

			sql = "SELECT * FROM " + sql + " WHERE campus=? AND Question_Friendly=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question = new Question();
				question.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				question.setSeq(AseUtil.nullToBlank(rs.getString("questionseq")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionByColumn - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionByColumn
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	column		String
	 *	<p>
	 *	@return Question
	 */
	public static Question getCourseQuestionByColumn(Connection connection,String campus,String column) throws Exception {

		Question question = null;

		try {
			String sql = "SELECT * FROM vw_AllQuestions WHERE campus=? AND Question_Friendly=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question = new Question();
				question.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				question.setSeq(AseUtil.nullToBlank(rs.getString("questionseq")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionByColumn - " + e.toString());
		}

		return question;
	}

	/*
	 * getExplainData
	 *	<p>
	 *	@return String
	 */
	public static String getExplainData(Connection connection,
													String campus,
													String alpha,
													String num,
													String type,
													String explain) throws Exception {

		String explainQuestion = "";
		String sql = "";
		try {
			sql = "SELECT " + explain + " FROM tblCampusData WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				explainQuestion = AseUtil.nullToBlank(resultSet.getString(1)).trim();
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getExplainData - " + e.toString());
		}

		return explainQuestion ;
	}

	/*
	 * getCourseHelp
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	type			int
	 * @param	question		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseHelp(Connection connection,String campus,int type,int question) throws Exception {

		String thisHelp = "";
		String sql = "";
		try {

			if (type==1)
				sql = "SELECT help FROM tblCourseQuestions WHERE campus=? AND questionseq=?";
			else
				sql = "SELECT help FROM tblCampusQuestions WHERE campus=? AND questionseq=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, question);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				thisHelp = AseUtil.nullToBlank(resultSet.getString(1)).trim();
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseHelp - " + e.toString());
		}

		return thisHelp;
	}

	/*
	 * getHelp
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	category		String
	 *	@param	title			String
	 *	@param	campus		String
	 *	<p>
	 *	@return Help
	 */
	public static Help getHelp(Connection connection,String category,String title,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// in the original design, help was only in TTG=campus; now that campuses are creating help
		// need to check there first.

		Help help = null;
		String sql = "";

		try {
			sql = "SELECT * FROM vw_HelpGetContent WHERE campus=? AND category=? AND title=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,title);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				help = new Help();
				help.setId(AseUtil.nullToBlank(rs.getString("id")));
				help.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				help.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				help.setSubTitle(AseUtil.nullToBlank(rs.getString("subtitle")));
				help.setContent(AseUtil.nullToBlank(rs.getString("content")));
				help.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				help.setAuditDate(AseUtil.nullToBlank(rs.getString("auditdate")));
				help.setContent(AseUtil.nullToBlank(rs.getString("content")));
			}
			else{
				rs.close();
				sql = "SELECT * FROM vw_HelpGetContent WHERE campus='TTG' AND category=? AND title=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,category);
				ps.setString(2,title);
				rs = ps.executeQuery();
				if (rs.next()) {
					help = new Help();
					help.setId(AseUtil.nullToBlank(rs.getString("id")));
					help.setCategory(AseUtil.nullToBlank(rs.getString("category")));
					help.setTitle(AseUtil.nullToBlank(rs.getString("title")));
					help.setSubTitle(AseUtil.nullToBlank(rs.getString("subtitle")));
					help.setContent(AseUtil.nullToBlank(rs.getString("content")));
					help.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
					help.setAuditDate(AseUtil.nullToBlank(rs.getString("auditdate")));
					help.setContent(AseUtil.nullToBlank(rs.getString("content")));
				}
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getHelp - " + e.toString());
		}

		return help;
	}

	/*
	 * getScreenHelp
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	category		String
	 *	@param	title			String
	 *	@param	campus		String
	 *	<p>
	 *	@return String
	 */
	public static String getScreenHelp(Connection connection,String category,String title,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// in the original design, help was only in TTG=campus; now that campuses are creating help
		// need to check there first.

		String help = "";
		String sql = "";

		try {
			sql = "SELECT * FROM vw_HelpGetContent WHERE campus=? AND category=? AND title=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,title);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				help = AseUtil.nullToBlank(rs.getString("content"));
			}
			else{
				rs.close();
				sql = "SELECT * FROM vw_HelpGetContent WHERE campus='TTG' AND category=? AND title=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,category);
				ps.setString(2,title);
				rs = ps.executeQuery();
				if (rs.next()) {
					help = AseUtil.nullToBlank(rs.getString("content"));
				}
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getScreenHelp - " + e.toString());
		}

		return help;
	}

	/*
	 * getCampusQuestions
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getCampusQuestions(Connection connection,String campus) throws Exception {
		String sql = "SELECT question,question_number FROM vw_CampusQuestions WHERE campus=?";

		ArrayList<Question> list = new ArrayList<Question>();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet resultSet = ps.executeQuery();
			Question question;
			while (resultSet.next()) {
				question = new Question();
				question.setQuestion(resultSet.getString(1).trim());
				question.setNum(resultSet.getString(2).trim());
				list.add(question);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCampusQuestions - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCourseQuestions <p> @return ArrayList
	 */
	public static ArrayList getCourseQuestions(Connection connection,int type,String campus) throws Exception {

		String sql = "SELECT questionnumber,question FROM tblCourseQuestions WHERE campus=? AND type=? ORDER BY questionnumber";
		ArrayList<Question> list = new ArrayList<Question>();
		try {
			String sType = "";

			if (type == 1)
				sType = "Course";
			else if (type == 2)
				sType = "Campus";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, sType);
			ResultSet resultSet = ps.executeQuery();
			Question question;
			while (resultSet.next()) {
				question = new Question();
				question.setNum(resultSet.getString(1).trim());
				question.setQuestion(resultSet.getString(2).trim());
				list.add(question);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestions - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCourseQuestionsByInclude
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getCourseQuestionsInclude(Connection conn,String campus,String include) throws Exception {

		String sql = "SELECT c.questionnumber, c.question, c.headertext, c.type, c.questionseq, cc.Question_Friendly "
			+ "FROM tblCourseQuestions c INNER JOIN CCCM6100 cc  "
			+ "ON c.questionnumber = cc.Question_Number "
			+ "WHERE (c.campus=?)  "
			+ "AND (c.include=?) "
			+ "AND (cc.campus='SYS') "
			+ "AND (cc.type='Course') "
			+ "ORDER BY c.questionseq ";

		ArrayList<Question> list = new ArrayList<Question>();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, include);
			ResultSet rs = ps.executeQuery();
			Question question;
			while (rs.next()) {
				question = new Question();
				question.setNum(AseUtil.nullToBlank(rs.getString("questionnumber")));
				question.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				question.setHeaderText(AseUtil.nullToBlank(rs.getString("headertext")));
				question.setType(AseUtil.nullToBlank(rs.getString("type")));
				question.setSeq(AseUtil.nullToBlank(rs.getString("questionseq")));
				question.setFriendly(AseUtil.nullToBlank(rs.getString("Question_Friendly")));
				list.add(question);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCourseQuestionsByInclude\n"
				+ "---------------------------------------\n"
				+ "SQLState\n" + e.getSQLState()
				+ "Message\n" + e.getMessage()
				+ "Vendor\n" + e.getErrorCode());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionsByInclude\n" + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCampusQuestionsByInclude
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getCampusQuestionsByInclude(Connection conn,String campus, String include) throws Exception {

		String sql = "SELECT questionnumber,question,headertext,type,questionseq "
			+ "FROM tblCampusQuestions "
			+ "WHERE campus=? "
			+ "AND include=? "
			+ "ORDER BY questionseq";
		ArrayList<Question> list = new ArrayList<Question>();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, include);
			ResultSet rs = ps.executeQuery();
			Question question;
			while (rs.next()) {
				question = new Question();
				question.setNum(AseUtil.nullToBlank(rs.getString("questionnumber")));
				question.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				question.setType(AseUtil.nullToBlank(rs.getString("type")));
				question.setSeq(AseUtil.nullToBlank(rs.getString("questionseq")));
				question.setHeaderText(AseUtil.nullToBlank(rs.getString("headertext")));
				list.add(question);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCourseQuestionsByInclude\n"
				+ "---------------------------------------\n"
				+ "SQLState\n" + e.getSQLState()
				+ "Message\n" + e.getMessage()
				+ "Vendor\n" + e.getErrorCode());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCampusQuestionsByInclude\n"
					+ e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getQuestionNumber - get the number that is associated with this seq
	 *	<p>
	 *	@return int
	 */
	public static int getQuestionNumber(Connection conn,String campus,int seq) throws Exception {

		int questionNumber = 0;

		String table = "tblCourseQuestions";

		int maxNoCourse = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);

		if(seq > maxNoCourse){
			table = "tblCampusQuestions";
			seq = seq - maxNoCourse;
		}

		String sql = "SELECT questionnumber FROM " + table + " WHERE campus=? AND questionseq=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, seq);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				questionNumber = resultSet.getInt(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getQuestionNumber\n" + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getQuestionNumber - " + e.toString());
		}

		return questionNumber;
	}

	public static int getQuestionNumber(Connection conn,String campus,int type,int seq) throws Exception {

		String table = "tblCourseQuestions";

		if (type==2){
			table = "tblCampusQuestions";
		}

		String sql = "SELECT questionnumber FROM " + table + " WHERE campus=? AND questionseq=?";
		int questionNumber = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, seq);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				questionNumber = resultSet.getInt(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getQuestionNumber\n" + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getQuestionNumber - " + e.toString());
		}

		return questionNumber;
	}

	/*
	 * getCourseSequenceByNumber - get the sequence that is associated with this number
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	type
	 *	@param	number
	 *	<p>
	 *	@return int
	 */
	public static int getCourseSequenceByNumber(Connection conn,String campus,String type,int number) throws Exception {

		String table = "tblCourseQuestions";

		if (type.equals("2")){
			table = "tblCampusQuestions";
		}

		String sql = "SELECT questionseq FROM " + table + " WHERE campus=? AND questionnumber=?";
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
			logger.fatal("QuestionDB: getCourseSequenceByNumber\n" + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseSequenceByNumber - " + e.toString());
		}

		return questionSequence;
	}

	/*
	 * showFields
	 * <p>
	 *	@param	conn						Connection
	 *	@param	campus					String
	 *	@param	alpha						String
	 *	@param	num						String
	 *	@param	rtn						String
	 *	@param	editing					int
	 *	@param	enabling					boolean
	 * @param	enableOutlineItems	boolean
	 * @param	enabledForEdits		String
	 * <p>
	 *	@return String
	 */
	public static String showFields(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int editing,
												boolean enabling) throws SQLException {

		return showFields(conn,campus,alpha,num,rtn,editing,enabling,false,null);
	}

	public static String showFields(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int editing,
												boolean enabling,
												boolean enableOutlineItems,
												String enabledForEdits) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String hiddenFieldCampus = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		int fieldCountCampus = 0;
		Question question;

		int i = 0;
		int savedCounter = 0;
		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		int editsCount = 0;
		String thisEdit = null;
		String rowColor = "";

		String type = Constant.PRE;

		String checkedOn = "";

		// checked array works on PRE and required array works on CUR
		// required is for enableitemsformods

		String outlineItemsRequiredForMods = "";
		String[] enabled = null;
		String[] required = null;
		String disabled = "";
		String hidden = "";
		int outlineItems = 0;
		int wrkIdx = 0;
		int z = 0;

		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"QuestionDB");

			// if a PRE does not exists, then we are requesting modification for the first time
			// so read MISC accordingly
			if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,Constant.PRE)){
				type = Constant.CUR;
			}

			if (debug) {
				logger.info("---------------- QuestionDB - showFields - START");
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("editing: " + editing);
				logger.info("enabling: " + enabling);
			}

			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">")
				.append("<tr bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

				if (debug) logger.info("course items: " + totalItems);

				// initialize
				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				//
				//	editing is available when we are coming back in to enable additional fields
				//
				//	edit1-2 contains a single value of '1' indiciating that all fields are editable.
				//	however, during the modification/approval process, edit1-2 may contain CSV
				//	due to rejection or reasons for why editing is needed
				//
				//	when the value is a single '1', we set up for all check marks ON.
				//
				//	when there are multiple values (more than a '1' or a comma is there), we
				//	set up for ON/OFF.
				//
				//	enabling is when approvers wishes to enable items for edits by proposer.
				//
				//----------------------------------------------------------------
				// campus questions
				//----------------------------------------------------------------
				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,Constant.PRE);
				}
				else if (enableOutlineItems){

					// when enableOutlineItems is true, we use data from miscdb.edit1 and 2
					// for shwfld.jsp. this happens if we are revising items during approval
					edits = new String[3];

					// we never have items to enable if not in PRE
					if(type.equals(Constant.PRE)){
						edits[0] = "";
						edits[1] = MiscDB.getCourseEditFromMiscEdit(conn,campus,Helper.getKix(conn,campus,alpha,num,Constant.PRE),Constant.TAB_COURSE);
						edits[2] = MiscDB.getCourseEditFromMiscEdit(conn,campus,Helper.getKix(conn,campus,alpha,num,Constant.PRE),Constant.TAB_CAMPUS);
					} // type = PRE
					else{
						edits[0] = "";
						edits[1] = "";
						edits[2] = "";
					}

				} // if editing || enabling

				if(debug){
					logger.info("enableOutlineItems: " + enableOutlineItems);
					logger.info("course edits[0]: " + edits[0]);
					logger.info("course edits[1]: " + edits[1]);
					logger.info("course edits[2]: " + edits[2]);
				}

				//
				// figure out what to enable
				//
				if (edits != null){
					if (edits[1] != null && !edits[1].equals(Constant.BLANK)){
						thisEdit = edits[1];

						// thisEdit is ON or 1 only if all items were turned on
						// else condition manages enabled items
						if (thisEdit.equals(Constant.ON)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");

							// cannot base loops on number of questions since questions
							// may be added removed from an outline at will. Base on number
							// of edit flags.
							if (checkMarks!=null){
								editsCount = checkMarks.length;
							}

							for (i=0; i<editsCount; i++){
								if (!checkMarks[i].equals(Constant.OFF)){
									checked[i] = "checked";
								} // if
							}	// for
						} // if equals 1
					}
				} // edits != null

				savedCounter = list.size();

				//
				// enabled required items on modification (first time from CUR only)
				//
				outlineItems = 	CourseDB.countCourseQuestions(conn,campus,"Y","",1) +
										CourseDB.countCourseQuestions(conn,campus,"Y","",2);

				// create array and set to all disabled
				required = new String[outlineItems];
				for(z = 0; z <required.length ; z++){
					required[z] = "";
				} // z

				//--------------------------------------------------------
				// outlineItemsRequiredForMods
				// this is only going to happen for new mods
				//--------------------------------------------------------
				if(type.equals(Constant.CUR)){

					outlineItemsRequiredForMods = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineItemsRequiredForMods");

					if(outlineItemsRequiredForMods != null && outlineItemsRequiredForMods.length() > 0){

						// remove spaces between items
						outlineItemsRequiredForMods = outlineItemsRequiredForMods.replace(" ","");

						enabled = outlineItemsRequiredForMods.split(",");

						// these are the required items
						for(z = 0; z <enabled.length ; z++){
							wrkIdx = NumericUtil.getInt(enabled[z],0) - 1;
							required[wrkIdx] = "checked";
						} // z

					} // if we have items to disable

				}
				else if(enabledForEdits != null && enabledForEdits.length() > 0){

					// ER00009 - when reviewers/approvers enable items for edits
					// by adding notes, we want to turn them on automatically
					// when coming to this screen

					// remove spaces between items
					enabledForEdits = enabledForEdits.replace(" ","");

					enabled = enabledForEdits.split(",");

					// these are the required items
					for(z = 0; z <enabled.length ; z++){
						wrkIdx = NumericUtil.getInt(enabled[z],0) - 1;
						required[wrkIdx] = "checked";
					} // z

				} // type

				if(debug){
					logger.info("enabledForEdits: " + enabledForEdits);
				}

				for (i=0; i<savedCounter; i++){

					question = (Question)list.get(i);
					// field names are Course_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum();
					cQuestionSeq = question.getSeq();
					cQuestion = question.getQuestion();
					cQuestionFriendly = question.getFriendly();

					fieldName = "Course_" + cQuestionNumber;

					// collect all fields and save on screen
					if ( hiddenFieldSystem.length() == 0 ){
						hiddenFieldSystem = cQuestionNumber;
					}
					else{
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;
					}

					++fieldCountSystem;

					String value = "";
					String filedType = "checkbox";

					//
					// when modifying from CUR, enable and lock by default items that are required
					// disabled items are not picked up during processing so we add '_disabled' to field name
					// for disabled items. in doing so, servlet will check on form submission
					//
					disabled = "";
					hidden = "";
					if(type.equals(Constant.CUR) && required[i].equals("checked")){
						disabled = "disabled";
						hidden = "<input type=\"hidden\" name=\"" + fieldName + "_disabled\" value=\"1\">";
						rowColor = Constant.COLOR_STAND_OUT;

						checkedOn = required[i];
					}
					else{
						// row colors
						if (i % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						if(enabledForEdits != null && enabledForEdits.length() > 0){
							checkedOn = required[i];
						}
						else{
							checkedOn = checked[i];
						}
					}

					//
					// alpha and number not allowed to be touched
					//
					value = "1";
					if (cQuestionFriendly.equals("coursealpha") || cQuestionFriendly.equals("coursenum")){
						value = "0";
						filedType = "hidden";
					}

					buf.append("<tr bgcolor=\"")
						.append(rowColor)
						.append("\"><td valign=top align=\"right\" class=\"textblackth\">")
						.append(cQuestionSeq)
						.append(".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\""+filedType+"\" name=\"")
						.append(fieldName)
						.append("\" value=\""+value+"\" ")
						.append(checkedOn)
						.append(" " + disabled + ">")
						.append(hidden)
						.append("</td><td valign=top class=\"datacolumn\">")
						.append(cQuestion + "</td></tr>");

				}	// for
			}	// if list for campus

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><div class=\"hr\"></div></td></tr>");

			//----------------------------------------------------------------
			// campus questions
			//----------------------------------------------------------------
			list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			if (list != null){
				totalItems = list.size();

				if (debug) logger.info("campus items: " + totalItems);

				checked = new String[totalItems];
				for (i=0; i<totalItems; i++){
					checked[i] = "";
				}

				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,Constant.PRE);
				}
				else if (enableOutlineItems){
					// when enableOutlineItems is true, we use data from miscdb.edit1 and 2
					// for shwfld.jsp
					// picked up edits[2] up above
				} // if editing || enabling

				if (edits != null && !edits[2].equals(Constant.BLANK)){
					thisEdit = edits[2];
					if (thisEdit.equals(Constant.ON)){
						for (i=0; i<totalItems; i++){
							checked[i] = "checked";
						}
					}
					else{
						checkMarks = thisEdit.split(",");
						for (i=0; i<totalItems && i<checkMarks.length; i++){
							if (!(Constant.OFF).equals(checkMarks[i]))
								checked[i] = "checked";
						}
					}
				} // edits != null

				for (i=0; i<totalItems; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Campus_" + cQuestionNumber;

					if ( hiddenFieldCampus.length() == 0 )
						hiddenFieldCampus = cQuestionNumber;
					else
						hiddenFieldCampus = hiddenFieldCampus +"," + cQuestionNumber;

					++fieldCountCampus;

					//
					// when modifying from CUR, enable and lock by default items that are required
					//
					disabled = "";
					hidden = "";
					if(type.equals(Constant.CUR) && required[i+savedCounter].equals("checked")){
						disabled = "disabled";
						hidden = "<input type=\"hidden\" name=\"" + fieldName + "_disabled\" value=\"1\">";
						rowColor = Constant.COLOR_STAND_OUT;

						checkedOn = required[i+savedCounter];
					}
					else{
						if (i % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						if(enabledForEdits != null && enabledForEdits.length() > 0){
							checkedOn = required[i+savedCounter];
						}
						else{
							checkedOn = checked[i];
						}
					}

					buf.append("<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">")
						.append(savedCounter+i+1)
						.append(".&nbsp;</td><td valign=\"top\" height=\"30\">")
						.append("<input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checkedOn)
						.append(" " + disabled + ">")
						.append(hidden)
						.append("</td><td valign=top class=\"datacolumn\">" +  cQuestion + "</td></tr>");

				}	// for
			}	// if campus

			int totalEnabledFields = fieldCountSystem + fieldCountCampus;

			buf.append("<tr>")
				.append("<td class=\"textblackTHRight\" colspan=\"3\"><div class=\"hr\"></div>")
				.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;")
				.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">")
				.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">")
				.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">")
				.append("<input type=\"hidden\" name=\"alpha\" value=\"" + alpha + "\">")
				.append("<input type=\"hidden\" name=\"num\" value=\"" + num + "\">")
				.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">")
				.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\">")
				.append("<input type=\"hidden\" name=\"edit\" value=\"" + editing + "\">")
				.append("<input type=\"hidden\" name=\"enabling\" value=\"" + enabling + "\">")
				.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">")
				.append("<input type=\"hidden\" name=\"fieldCountCampus\" value=\"" + fieldCountCampus + "\">")
				.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">")
				.append("<input type=\"hidden\" name=\"hiddenFieldCampus\" value=\"" + hiddenFieldCampus + "\">")
				.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">")
				.append("<input type=\"hidden\" name=\"toggledAll\" value=\"" + totalEnabledFields + "\">")
				.append("<input type=\"hidden\" name=\"enabledForEdits\" value=\"" + enabledForEdits + "\">")
				.append("</td>")
				.append("</tr>")
				.append("</table>" );

			if (debug) logger.info("---------------- QuestionDB - showFields - END");

		}
		catch( SQLException e ){
			logger.info("QuestionDB: showFields - " + e.toString());
		}
		catch( Exception ex ){
			logger.info("QuestionDB: showFields - " + ex.toString());
		}

		return buf.toString();

	} // QuestionDB: showFields

	public static String showFieldsOBSOLETE(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int editing,
												boolean enabling,
												boolean enableOutlineItems,
												String enabledForEdits) throws SQLException {

		//Logger logger = Logger.getLogger("test");

// not ready to make this happen yet
enabledForEdits = null;

		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String hiddenFieldCampus = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		int fieldCountCampus = 0;
		Question question;

		int i = 0;
		int savedCounter = 0;
		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		int editsCount = 0;
		String thisEdit = null;
		String rowColor = "";

		String type = Constant.PRE;

		String checkedOn = "";

		// checked array works on PRE and required array works on CUR
		// required is for enableitemsformods

		String outlineItemsRequiredForMods = "";
		String[] enabled = null;
		String[] required = null;
		String disabled = "";
		String hidden = "";
		int outlineItems = 0;
		int wrkIdx = 0;
		int z = 0;

		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"QuestionDB");

			// if a PRE does not exists, then we are requesting modification for the first time
			// so read MISC accordingly
			if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,Constant.PRE)){
				type = Constant.CUR;
			}

			if (debug) {
				logger.info("---------------- QuestionDB - showFields - START");
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("editing: " + editing);
				logger.info("enabling: " + enabling);
			}

			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">")
				.append("<tr bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

				if (debug) logger.info("course items: " + totalItems);

				// initialize
				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				//
				//	editing is available when we are coming back in to enable additional fields
				//
				//	edit1-2 contains a single value of '1' indiciating that all fields are editable.
				//	however, during the modification/approval process, edit1-2 may contain CSV
				//	due to rejection or reasons for why editing is needed
				//
				//	when the value is a single '1', we set up for all check marks ON.
				//
				//	when there are multiple values (more than a '1' or a comma is there), we
				//	set up for ON/OFF.
				//
				//	enabling is when approvers wishes to enable items for edits by proposer.
				//
				//----------------------------------------------------------------
				// campus questions
				//----------------------------------------------------------------
				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,Constant.PRE);
				}
				else if (enableOutlineItems){

					// when enableOutlineItems is true, we use data from miscdb.edit1 and 2
					// for shwfld.jsp. this happens if we are revising items during approval
					edits = new String[3];

					// we never have items to enable if not in PRE
					if(type.equals(Constant.PRE)){
						edits[0] = "";
						edits[1] = MiscDB.getCourseEditFromMiscEdit(conn,campus,Helper.getKix(conn,campus,alpha,num,Constant.PRE),Constant.TAB_COURSE);
						edits[2] = MiscDB.getCourseEditFromMiscEdit(conn,campus,Helper.getKix(conn,campus,alpha,num,Constant.PRE),Constant.TAB_CAMPUS);
					} // type = PRE
					else{
						edits[0] = "";
						edits[1] = "";
						edits[2] = "";
					}

				} // if editing || enabling

				//
				// figure out what to enable
				//
				if (edits != null){
					if (edits[1] != null && !edits[1].equals(Constant.BLANK)){
						thisEdit = edits[1];

						// thisEdit is ON or 1 only if all items were turned on
						// else condition manages enabled items
						if (thisEdit.equals(Constant.ON)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");

							// cannot base loops on number of questions since questions
							// may be added removed from an outline at will. Base on number
							// of edit flags.
							if (checkMarks!=null){
								editsCount = checkMarks.length;
							}

							for (i=0; i<editsCount; i++){
								if (!checkMarks[i].equals(Constant.OFF)){
									checked[i] = "checked";
								} // if
							}	// for
						} // if equals 1
					}
				} // edits != null

				savedCounter = list.size();

				//
				// enabled required items on modification (first time from CUR only)
				//
				outlineItems = 	CourseDB.countCourseQuestions(conn,campus,"Y","",1) +
										CourseDB.countCourseQuestions(conn,campus,"Y","",2);

				// create array and set to all disabled
				required = new String[outlineItems];
				for(z = 0; z <required.length ; z++){
					required[z] = "";
				} // z

				//--------------------------------------------------------
				// outlineItemsRequiredForMods
				// this is only going to happen for new mods
				//--------------------------------------------------------
				if(type.equals(Constant.CUR)){

					outlineItemsRequiredForMods = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineItemsRequiredForMods");

					if(outlineItemsRequiredForMods != null && outlineItemsRequiredForMods.length() > 0){

						// remove spaces between items
						outlineItemsRequiredForMods = outlineItemsRequiredForMods.replace(" ","");

						enabled = outlineItemsRequiredForMods.split(",");

						// these are the required items
						for(z = 0; z <enabled.length ; z++){
							wrkIdx = NumericUtil.getInt(enabled[z],0) - 1;
							required[wrkIdx] = "checked";
						} // z

					} // if we have items to disable

				}
				else if(enabledForEdits != null && enabledForEdits.length() > 0){

					// ER00009 - when reviewers/approvers enable items for edits
					// by adding notes, we want to turn them on automatically
					// when coming to this screen

					// remove spaces between items
					enabledForEdits = enabledForEdits.replace(" ","");

					enabled = enabledForEdits.split(",");

					// these are the required items
					for(z = 0; z <enabled.length ; z++){
						wrkIdx = NumericUtil.getInt(enabled[z],0) - 1;
						required[wrkIdx] = "checked";
					} // z

				} // type

				for (i=0; i<savedCounter; i++){

					question = (Question)list.get(i);
					// field names are Course_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum();
					cQuestionSeq = question.getSeq();
					cQuestion = question.getQuestion();
					cQuestionFriendly = question.getFriendly();

					fieldName = "Course_" + cQuestionNumber;

					// collect all fields and save on screen
					if ( hiddenFieldSystem.length() == 0 ){
						hiddenFieldSystem = cQuestionNumber;
					}
					else{
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;
					}

					++fieldCountSystem;

					String value = "";
					String filedType = "checkbox";

					//
					// when modifying from CUR, enable and lock by default items that are required
					// disabled items are not picked up during processing so we add '_disabled' to field name
					// for disabled items. in doing so, servlet will check on form submission
					//
					disabled = "";
					hidden = "";
					if(type.equals(Constant.CUR) && required[i].equals("checked")){
						disabled = "disabled";
						hidden = "<input type=\"hidden\" name=\"" + fieldName + "_disabled\" value=\"1\">";
						rowColor = Constant.COLOR_STAND_OUT;

						checkedOn = required[i];
					}
					else{
						// row colors
						if (i % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						checkedOn = checked[i];
					}

					//
					// alpha and number not allowed to be touched
					//
					value = "1";
					if (cQuestionFriendly.equals("coursealpha") || cQuestionFriendly.equals("coursenum")){
						value = "0";
						filedType = "hidden";
					}

					buf.append("<tr bgcolor=\"")
						.append(rowColor)
						.append("\"><td valign=top align=\"right\" class=\"textblackth\">")
						.append(cQuestionSeq)
						.append(".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\""+filedType+"\" name=\"")
						.append(fieldName)
						.append("\" value=\""+value+"\" ")
						.append(checkedOn)
						.append(" " + disabled + ">")
						.append(hidden)
						.append("</td><td valign=top class=\"datacolumn\">")
						.append(cQuestion + "</td></tr>");

				}	// for
			}	// if list for campus

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><div class=\"hr\"></div></td></tr>");

			//----------------------------------------------------------------
			// campus questions
			//----------------------------------------------------------------
			list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			if (list != null){
				totalItems = list.size();

				if (debug) logger.info("campus items: " + totalItems);

				checked = new String[totalItems];
				for (i=0; i<totalItems; i++){
					checked[i] = "";
				}

				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,Constant.PRE);
				}
				else if (enableOutlineItems){
					// when enableOutlineItems is true, we use data from miscdb.edit1 and 2
					// for shwfld.jsp
					// picked up edits[2] up above
				} // if editing || enabling

				if (edits != null && !edits[2].equals(Constant.BLANK)){
					thisEdit = edits[2];
					if (thisEdit.equals(Constant.ON)){
						for (i=0; i<totalItems; i++){
							checked[i] = "checked";
						}
					}
					else{
						checkMarks = thisEdit.split(",");
						for (i=0; i<totalItems && i<checkMarks.length; i++){
							if (!(Constant.OFF).equals(checkMarks[i]))
								checked[i] = "checked";
						}
					}
				} // edits != null

				for (i=0; i<totalItems; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Campus_" + cQuestionNumber;

					if ( hiddenFieldCampus.length() == 0 )
						hiddenFieldCampus = cQuestionNumber;
					else
						hiddenFieldCampus = hiddenFieldCampus +"," + cQuestionNumber;

					++fieldCountCampus;

					//
					// when modifying from CUR, enable and lock by default items that are required
					//
					disabled = "";
					hidden = "";
					if(type.equals(Constant.CUR) && required[i+savedCounter].equals("checked")){
						disabled = "disabled";
						hidden = "<input type=\"hidden\" name=\"" + fieldName + "_disabled\" value=\"1\">";
						rowColor = Constant.COLOR_STAND_OUT;

						checkedOn = required[i+savedCounter];
					}
					else{
						if (i % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						checkedOn = checked[i];
					}

					buf.append("<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">")
						.append(savedCounter+i+1)
						.append(".&nbsp;</td><td valign=\"top\" height=\"30\">")
						.append("<input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checkedOn)
						.append(" " + disabled + ">")
						.append(hidden)
						.append("</td><td valign=top class=\"datacolumn\">" +  cQuestion + "</td></tr>");

				}	// for
			}	// if campus

			int totalEnabledFields = fieldCountSystem + fieldCountCampus;

			buf.append("<tr>")
				.append("<td class=\"textblackTHRight\" colspan=\"3\"><div class=\"hr\"></div>")
				.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;")
				.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">")
				.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">")
				.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">")
				.append("<input type=\"hidden\" name=\"alpha\" value=\"" + alpha + "\">")
				.append("<input type=\"hidden\" name=\"num\" value=\"" + num + "\">")
				.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">")
				.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\">")
				.append("<input type=\"hidden\" name=\"edit\" value=\"" + editing + "\">")
				.append("<input type=\"hidden\" name=\"enabling\" value=\"" + enabling + "\">")
				.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">")
				.append("<input type=\"hidden\" name=\"fieldCountCampus\" value=\"" + fieldCountCampus + "\">")
				.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">")
				.append("<input type=\"hidden\" name=\"hiddenFieldCampus\" value=\"" + hiddenFieldCampus + "\">")
				.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">")
				.append("<input type=\"hidden\" name=\"toggledAll\" value=\"" + totalEnabledFields + "\">")
				.append("</td>")
				.append("</tr>")
				.append("</table>" );

			if (debug) logger.info("---------------- QuestionDB - showFields - END");

		}
		catch( SQLException e ){
			logger.info("QuestionDB: showFields - " + e.toString());
		}
		catch( Exception ex ){
			logger.info("QuestionDB: showFields - " + ex.toString());
		}

		return buf.toString();

	} // QuestionDB: showFields

	/*
	 * getCampusColumms - returns list of columns from course and campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getCampusColumms(Connection conn,String campus) throws Exception {

		AseUtil aseUtil = new AseUtil();

		String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
		String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

		return f1 + "," + f2;
	}

	/*
	 * getCampusColummNames - returns list of columns from course and campus. Course columns
	 *									start with c. and campus s.
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getCampusColummNames(Connection conn,String campus) throws Exception {

		AseUtil aseUtil = new AseUtil();

		String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
		String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

		f1 = "c." + f1.replace(",",",c.");
		f2 = "s." + f2.replace(",",",s.");

		return f1 + "," + f2;
	}

	/*
	 * getCourseEditableItems - returns array of question numbers in use by campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return int[]
	 */
	public static int[] getCourseEditableItems(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int[] qn = null;
		int i = 0;

		try {
			String sql = "SELECT count(questionnumber) "
				+ "FROM tblCourseQuestions "
				+ "WHERE campus=? "
				+ "AND include=? "
				+ "AND questionseq>0 ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				i = rs.getInt(1);
			}
			rs.close();
			ps.close();

			qn = new int[i];

			i = -1;

			sql = "SELECT questionnumber "
				+ "FROM tblCourseQuestions "
				+ "WHERE campus=? "
				+ "AND include=? "
				+ "AND questionseq>0 "
				+ "ORDER BY questionseq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			rs = ps.executeQuery();
			while (rs.next()) {
				int x = NumericUtil.nullToZero(rs.getInt("questionnumber"));
				if (x > 0)
					qn[++i] = x;
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getCourseEditableItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseEditableItems - " + e.toString());
		}

		return qn;
	}

	/*
	 * getCampusEditableItems - returns array of question numbers in use by campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return int[]
	 */
	public static int[] getCampusEditableItems(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int[] qn = null;
		int i = 0;

		try {
			String sql = "SELECT count(questionnumber) FROM tblCampusQuestions "
				+ "WHERE campus=? AND include=? AND questionseq>0 ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				i = rs.getInt(1);
			}
			rs.close();
			ps.close();

			qn = new int[i];

			i = -1;

			sql = "SELECT questionnumber FROM tblCampusQuestions "
				+ "WHERE campus=? AND include=? AND questionseq>0 ORDER BY questionseq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			rs = ps.executeQuery();
			while (rs.next()) {
				int x = NumericUtil.nullToZero(rs.getInt("questionnumber"));
				if (x > 0)
					qn[++i] = x;
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getCampusEditableItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCampusEditableItems - " + e.toString());
		}

		return qn;
	}

	/*
	 * setCourseEnabledItems - sets individual enabled items
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	q			int
	 *	@param	enabled	boolean
	 *	@param	tb			String
	 *	<p>
	 *	@return int
	 */
	public static int setCourseEnabledItems(Connection conn,
														String campus,
														String alpha,
														String num,
														int q,
														boolean enabled,
														String tb) throws Exception {

		// Logger logger = Logger.getLogger("test");

		int i = 0;

		// get the questions in use. Must be ordered by questions seq
		int[] qnCourse = QuestionDB.getCourseEditableItems(conn,campus);
		int[] qnCampus = QuestionDB.getCampusEditableItems(conn,campus);

		// get current editable items (if any)
		int courseEdits = 1;
		int campusEdits = 2;
		String[] aCourseEdits = null;
		String[] aCampusEdits = null;
		String[] edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");
		if (edits != null){
			// since we are here to enable items for edit, if a comma was not found,
			// that means we currently permit edits on all items.
			// for this to work, we remove edits on all items and set all to off
			// and permit following code below to enable the appropriate ones.

			// edits are either 1 to indicate editable for all items in outline,
			// or CSV of question numbers allowed to edit
			// check for comma to ensure that it's enabled or not

			if (edits[courseEdits].indexOf(",") == -1){
				aCourseEdits = new String[qnCourse.length];
				for(i=0; i<qnCourse.length; i++){
					aCourseEdits[i] = "0";
				}
			}
			else{
				aCourseEdits = edits[courseEdits].split(",");
			}

			if (edits[campusEdits].indexOf(",") == -1){
				aCampusEdits = new String[qnCourse.length];
				for(i=0; i<qnCourse.length; i++){
					aCampusEdits[i] = "0";
				}
			}
			else{
				aCampusEdits = edits[campusEdits].split(",");
			}
		}

		// if the question matches the one needing enablement, set it
		// qnCourse contains actual question numbers
		// q is the question to enable
		// qnCourse and aCourseEdits should be in order
		boolean found = false;
		String junk = "";
		int rowsAffected = 0;

		// tb = 1 for course tab
		if (tb.equals("1")){
			found = false;
			i=0;
			while(i<qnCourse.length && !found){
				if (qnCourse[i]>0){
					if (qnCourse[i]==q){
						if (enabled)
							aCourseEdits[i] = q+"";
						else
							aCourseEdits[i] = "0";

						found = true;
					}
				}

				i++;
			}

		}
		else{
			found = false;
			i=0;
			while(i<qnCampus.length && !found){
				if (qnCampus[i]>0){
					if (qnCampus[i]==q){
						if (enabled)
							aCampusEdits[i] = q+"";
						else
							aCampusEdits[i] = "0";

						found = true;
					}
				}

				i++;
			}
		}

		// reassemble as string to save back to table
		junk = "";
		for(i=0; i<aCourseEdits.length; i++){
			if (i==0 || (Constant.BLANK).equals(junk))
				junk = aCourseEdits[i];
			else
				junk = junk + "," + aCourseEdits[i];
		}
		rowsAffected = CourseDB.setCourseEdit1(conn,campus,alpha,num,"PRE",junk);

		// reassemble as string to save back to table
		junk = "";
		for(i=0; i<aCampusEdits.length; i++){
			if (i==0 || (Constant.BLANK).equals(junk))
				junk = aCampusEdits[i];
			else
				junk = junk + "," + aCampusEdits[i];
		}
		rowsAffected = CourseDB.setCourseEdit2(conn,campus,alpha,num,"PRE",junk);

		return rowsAffected;
	}

	/*
	 * isCourseItemEditable - returns true if the item is editable (unlocked)
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	item		int
	 * @param	tb			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCourseItemEditable(Connection conn,String kix,int item,String tb) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean found = false;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];
			String getCourseEditItem = null;

			// 1 if course and 2 is campus
			if ("1".equals(tb))
				getCourseEditItem = CourseDB.getCourseEdit1(conn,campus,alpha,num,type);
			else
				getCourseEditItem = CourseDB.getCourseEdit2(conn,campus,alpha,num,type);

			/*
				edit1 contains 1 (edit), 2 (approval), or 3 (review)
				when the length is longer than 1 character, then we are enabled for individual
				item edits

				resulting string should be something like ,1,0,0,0,0,
				where commas are at start and end to help with the indexOf method
				this is just a quicker search and not having to loop until we find.
			*/

			if (getCourseEditItem != null && getCourseEditItem.indexOf(",") > -1){
				if (item > 0){
					String sItem = "," + Integer.toString(item) + ",";
					if (("," + getCourseEditItem + ",").indexOf(sItem) != -1)
						found = true;
				} // item > 0
			}// getCourseEditItem

		} catch (SQLException ex) {
			logger.fatal("QuestionDB: isCourseItemEditable - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: isCourseItemEditable - " + e.toString());
		}

		return found;
	}

	/*
	 * areItemsEnabled - returns true if any item in edit1 or edit2 is enabled (existence of comma)
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean areItemsEnabled(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean enabled = false;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];

			String courseItems = CourseDB.getCourseEdit1(conn,campus,alpha,num,type);
			String campusItems = CourseDB.getCourseEdit2(conn,campus,alpha,num,type);

			// true if items in edit1 or edit2 contains a comma
			if (	(courseItems != null && courseItems.indexOf(",") > -1) ||
			 		(campusItems != null && campusItems.indexOf(",") > -1) ){
				enabled = true;
			}

		} catch (SQLException ex) {
			logger.fatal("QuestionDB: areItemsEnabled - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: areItemsEnabled - " + e.toString());
		}

		return enabled;
	}

	/*
	 * enabledEditItems - returns hashmap of enabled items
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	item		int
	 *	<p>
	 *	@return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap enabledEditItems(Connection conn,String kix,int item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// see MiscDB.enabledItem()

		HashMap hashMap = null;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];
			String courseItems = "";

			// place enabled items in hashmap for use
			if (item == 1)
				courseItems = CourseDB.getCourseEdit1(conn,campus,alpha,num,type);
			else
				courseItems = CourseDB.getCourseEdit2(conn,campus,alpha,num,type);

			// when there is a comma, we are in enabled mode.
			if (courseItems != null && courseItems.length() > 0 && courseItems.indexOf(",") > -1){
				hashMap = new HashMap();
				String[] aCourseItems = courseItems.split(",");
				for(int z=0;z<aCourseItems.length;z++){
					if (!aCourseItems[z].equals("0"))
						hashMap.put(aCourseItems[z],new String(aCourseItems[z]));
				}
			}
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: enabledEditItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: enabledEditItems - " + e.toString());
		}

		return hashMap;
	}

	/*
	 * isItemIncluded - returns true if the item is included as a question on campus tab
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	friendly	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isItemIncluded(Connection conn,String campus,String friendly) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean enabled = false;

		try {
			String sql = "SELECT tcq.include "
				+ "FROM tblCourseQuestions tcq INNER JOIN CCCM6100 c "
				+ "ON tcq.questionnumber = c.Question_Number "
				+ "WHERE tcq.campus=? "
				+ "AND c.type='Course' "
				+ "AND c.Question_Friendly=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,friendly);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if ("Y".equals(AseUtil.nullToBlank(rs.getString("include"))))
					enabled = true;
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: isItemIncluded - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: isItemIncluded - " + e.toString());
		}

		return enabled;
	}

	/*
	 * getQuestionNumberByColumn
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	column	String
	 *	<p>
	 *	@return int
	 */
	public static int getQuestionNumberByColumn(Connection conn,String campus,String column) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int qn = 0;

		try {
			String sql = "SELECT question_number "
				+ "FROM vw_CourseItems "
				+ "WHERE campus=? "
				+ "AND field_name=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				qn = rs.getInt("question_number");
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getQuestionNumberByColumn - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getQuestionNumberByColumn - " + e.toString());
		}

		return qn;
	}

	/*
	 * getCourseEnabledItemSeq - returns array of question numbers in use by campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEnabledItemSeq(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String qn = null;

		try {
			String sql = "SELECT seq FROM vw_CourseItems WHERE campus=? AND seq>0 ORDER BY seq";

			String results = SQLUtil.resultSetToCSV(conn,sql,campus);

			if (results != null && results.length() > 0){
				qn = results;
			}
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getCourseEnabledItemSeq - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseEnabledItemSeq - " + e.toString());
		}

		return qn;
	}

	/*
	 * getCourseEnabledItemQuestionNumber - returns array of question numbers in use by campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEnabledItemQuestionNumber(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String qn = null;

		try {
			String sql = "SELECT question_number "
				+ "FROM vw_CourseItems "
				+ "WHERE campus=? "
				+ "AND seq>0 "
				+ "ORDER BY seq";

			String results = SQLUtil.resultSetToCSV(conn,sql,campus);

			if (results != null && results.length() > 0){
				qn = results;
			}
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getCourseEnabledItemQuestionNumber - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseEnabledItemQuestionNumber - " + e.toString());
		}

		return qn;
	}

	/*
	 * whoEnabledThisItem - returns name of the person who enabled an item
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 * @param	item
	 * @param	tb
	 *	<p>
	 *	@return String
	 */
	public static String whoEnabledThisItem(Connection conn,String kix,int item,String tb) throws Exception {

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
			ps.setString(3,tb);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				reviewer = AseUtil.nullToBlank(rs.getString("reviewer"));
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: whoEnabledThisItem - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: whoEnabledThisItem - " + e.toString());
		}

		return reviewer;
	}

	/*
	 * getProgramColumns - returns list of columns from course and campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getProgramColumns(Connection conn,String campus) throws Exception {

		AseUtil aseUtil = new AseUtil();

		String f1 = aseUtil.lookUp(conn, "tblCampus", "programitems", "campus='" + campus + "'" );

		return f1;
	}

	/*
	 * showProgramFields
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	rtn		String
	 *	@param	editing	int
	 *	@param	enabling	boolean
	 * <p>
	 *	@return String
	 */
	public static String showProgramFields(Connection conn,
														String campus,
														String kix,
														String rtn,
														int editing,
														boolean enabling) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		Question question;

		int i = 0;
		int savedCounter = 0;
		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		int editsCount = 0;
		String thisEdit = null;
		String rowColor = "";

		boolean debug = true;

		try{
			if (debug){
				logger.info("QuestionDB - showProgramFields - START");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("rtn: " + rtn);
				logger.info("editing: " + editing);
				logger.info("enabling: " + enabling);
			}

			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			buf.append("<tr bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

				if (debug) logger.info("totalItems: " + totalItems);

				// initialize
				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				/*
					editing is available when we are coming back in to enable additional fields

					edit1-2 contains a single value of '1' indiciating that all fields are editable.
					however, during the modification/approval process, edit1-2 may contain CSV
					due to rejection or reasons for why editing is needed

					when the value is a single '1', we set up for all check marks ON.

					when there are multiple values (more than a '1' or a comma is there), we
					set up for ON/OFF.

					enabling is when approvers wishes to enable items for edits by proposer.
				*/
				if (editing==1 || enabling){
					edits = ProgramsDB.getProgramEdits(conn,campus,kix);

					if (edits != null && !(Constant.BLANK).equals(edits[1])){
						thisEdit = edits[1];

						if (thisEdit == null)
							thisEdit = "";

						if (debug) logger.info("thisEdit: " + thisEdit);

						if ((Constant.ON).equals(thisEdit)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");

							// cannot base loops on number of questions since questions
							// may be added removed from an outline at will. Base on number
							// of edit flags.
							if (checkMarks!=null)
								editsCount = checkMarks.length;

							if (debug) logger.info("editsCount: " + editsCount);

							for (i=0; i<editsCount; i++){
								if (!(Constant.OFF).equals(checkMarks[i]))
									checked[i] = "checked";
							}	// for
						} // if equals 1
					}
				}	// if editing || enabling

				savedCounter = list.size();

				if (debug) logger.info("savedCounter: " + savedCounter);

				for (i=0; i<savedCounter; i++){
					question = (Question)list.get(i);
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();
					fieldName = "Program_" + cQuestionNumber;

					if ( hiddenFieldSystem.length() == 0 )
						hiddenFieldSystem = cQuestionNumber;
					else
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;

					++fieldCountSystem;

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">"
							+ cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\""
							+ fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top class=\"datacolumn\">"
							+ cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><div class=\"hr\"></div></td></tr>");

			buf.append("<tr>" );
			buf.append("<td class=\"textblackTHRight\" colspan=\"3\"><div class=\"hr\"></div>" );
			buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;");
			buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">" );
			buf.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">" );
			buf.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">" );
			buf.append("<input type=\"hidden\" name=\"kix\" value=\"" + kix + "\">" );
			buf.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">" );
			buf.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\">" );
			buf.append("<input type=\"hidden\" name=\"edit\" value=\"" + editing + "\">" );
			buf.append("<input type=\"hidden\" name=\"enabling\" value=\"" + enabling + "\">" );
			buf.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">" );
			buf.append("</td>" );
			buf.append("</tr>" );
			buf.append( "</table>" );

			if (debug) logger.info("QuestionDB - showProgramFields - END");
		}
		catch( SQLException e ){
			logger.info("QuestionDB: showProgramFields - " + e.toString());
		}
		catch( Exception ex ){
			logger.info("QuestionDB: showProgramFields - " + ex.toString());
		}

		return buf.toString();
	}

	/*
	 * getCourseQuestionsByInclude
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getProgramQuestionsInclude(Connection conn,String campus,String include) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "SELECT questionnumber,question,type,questionseq "
					+ "FROM tblProgramQuestions "
					+ "WHERE campus=? AND "
					+ "include=? "
					+ "ORDER BY questionseq";
		ArrayList<Question> list = new ArrayList<Question>();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, include);
			ResultSet rs = ps.executeQuery();
			Question question;
			while (rs.next()) {
				question = new Question();
				question.setNum(AseUtil.nullToBlank(rs.getString(1)));
				question.setQuestion(AseUtil.nullToBlank(rs.getString(2)));
				question.setType(AseUtil.nullToBlank(rs.getString(3)));
				question.setSeq(AseUtil.nullToBlank(rs.getString(4)));
				list.add(question);
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getCourseQuestionsByInclude\n");
			logger.fatal("---------------------------------------\n");
			logger.fatal("SQLState\n" + ex.getSQLState());
			logger.fatal("Message\n" + ex.getMessage());
			logger.fatal("Vendor\n" + ex.getErrorCode());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionsByInclude\n"
					+ e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * resetQuestionFlags
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	oldSeq
	 *	@param	newSeq
	 *	@param	direction
	 *	<p>
	 *	@return int
	 */
	public static int resetQuestionFlags(Connection conn,
														String campus,
														int oldSeq,
														int newSeq,
														int direction,
														String tableName) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String kix = "";
		String alpha = "";
		String num = "";
		String type = "PRE";
		String table = "";

		String edit = "";
		String oldValue = "";
		String fieldName = "";
		String[] aEdit = null;

		int i = 0;
		int length = 0;
		int rowsAffected = 0;

		boolean debug = true;

		try{
			if (tableName.equals(Constant.TABLE_COURSE)){
				table = "tblCourse";
				fieldName = "edit1";
			}
			else if (tableName.equals(Constant.TABLE_CAMPUS)){
				table = "tblCampusData";
				fieldName = "edit2";
			}
			else if (tableName.equals(Constant.TABLE_PROGRAM)){
				table = "tblPrograms";
				fieldName = "edit1";
			}

			if (debug){
				logger.info("======================== resetQuestionFlags - START");
				logger.info("direction: " + direction);
				logger.info("campus: " + campus);
				logger.info("oldSeq: " + oldSeq);
				logger.info("newSeq: " + newSeq);
			}

			// decrement for work with array
			--oldSeq;
			--newSeq;

			String sql = "SELECT historyid,coursealpha,coursenum,edit1 "
					+ "FROM " + table + " "
					+ "where campus=? AND coursetype='PRE' AND edit1 like '%,%' "
					+ "ORDER BY coursealpha,coursenum ";

			if (tableName.equals(Constant.TABLE_PROGRAM)){
				sql = "SELECT historyid,title as coursealpha,divisionid as coursenum,edit1 "
						+ "FROM " + table + " "
						+ "where campus=? AND type='PRE' AND edit1 like '%,%' "
						+ "ORDER BY coursealpha,coursenum ";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = rs.getString("historyid");
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				edit = rs.getString("edit1");

				if (edit != null){
					if (debug){
						logger.info("-----------------------");
						logger.info(alpha + " " + num);
						logger.info(edit);
					}

					switch (direction){
						case NEW_GREATER_OLD:

							// move items 1 up front to make room for a new item at new seq

							aEdit = edit.split(",");

							length = aEdit.length;

							// prevent out of range
							if (newSeq > length-1)
								--newSeq;

							oldValue = aEdit[oldSeq];

							for(i=oldSeq; i<newSeq; i++){
								aEdit[i] = aEdit[i+1];
							}

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case OLD_GREATER_NEW:

							// move items 1 back to make room for a new item at new seq

							aEdit = edit.split(",");

							length = aEdit.length;

							oldValue = aEdit[oldSeq];

							for(i=oldSeq; i>newSeq; i--)
								aEdit[i] = aEdit[i-1];

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case NO_CHANGE:
							break;
						case INSERT_QUESTION:
							// since we are inserting a new element, we must grow the array by 1 before split
							// we also have to add the new question number to the list
							edit = edit + ",0";
							aEdit = edit.split(",");

							length = aEdit.length;

							// newSeq was subtracted earlier to accommodate array based processing.
							// to get the qusetion number corresponding to the seq, must add 1 back
							oldValue = "" + getQuestionNumber(conn,campus,1,newSeq+1);

							for(i=length-1; i>newSeq; i--)
								aEdit[i] = aEdit[i-1];

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case REMOVE_QUESTION:
							aEdit = edit.split(",");

							length = aEdit.length;

							for(i=oldSeq; i<length-1; i++)
								aEdit[i] = aEdit[i+1];

							// recombine without the last item that is now removed
							edit = "";
							for(i=0; i<length-1; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
					} // switch

					if (debug) logger.info(edit);

					sql = "UPDATE " + table + " SET " + fieldName + "=? WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,edit);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
				} // if edit
			} // while
			rs.close();
			ps.close();

			rs = null;
			ps = null;

			if (debug) logger.info("======================== resetQuestionFlags - END");
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}

		return 0;

	} // resetQuestionFlags

	public static int resetQuestionFlagsOBSOLETE(Connection conn,
														String campus,
														int oldSeq,
														int newSeq,
														int direction,
														String tableName) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String kix = "";
		String alpha = "";
		String num = "";
		String type = "PRE";
		String table = "";

		String edit = "";
		String oldValue = "";
		String fieldName = "";
		String[] aEdit = null;

		int i = 0;
		int length = 0;
		int rowsAffected = 0;

		boolean debug = true;

		try{
			if (tableName.equals(Constant.TABLE_COURSE)){
				table = "tblCourse";
				fieldName = "edit1";
			}
			else if (tableName.equals(Constant.TABLE_CAMPUS)){
				table = "tblCampusData";
				fieldName = "edit2";
			}
			else if (tableName.equals(Constant.TABLE_PROGRAM)){
				table = "tblPrograms";
				fieldName = "edit1";
			}

			if (debug){
				logger.info("======================== resetQuestionFlags - START");
				logger.info("direction: " + direction);
				logger.info("campus: " + campus);
				logger.info("oldSeq: " + oldSeq);
				logger.info("newSeq: " + newSeq);
			}

			// decrement for work with array
			--oldSeq;
			--newSeq;

			String sql = "SELECT historyid,coursealpha,coursenum,edit1 "
					+ "FROM " + table + " "
					+ "where campus=? AND coursetype='PRE' AND edit1 like '%,%' "
					+ "ORDER BY coursealpha,coursenum ";

			if (tableName.equals(Constant.TABLE_PROGRAM)){
				sql = "SELECT historyid,coursealpha,coursenum,edit1 "
						+ "FROM " + table + " "
						+ "where campus=? AND type='PRE' AND edit1 like '%,%' "
						+ "ORDER BY coursealpha,coursenum ";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = rs.getString("historyid");
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				edit = rs.getString("edit1");

				if (edit != null){
					if (debug){
						logger.info("-----------------------");
						logger.info(alpha + " " + num);
						logger.info(edit);
					}

					switch (direction){
						case NEW_GREATER_OLD:

							// move items 1 up front to make room for a new item at new seq

							aEdit = edit.split(",");

							length = aEdit.length;

							// prevent out of range
							if (newSeq > length-1)
								--newSeq;

							oldValue = aEdit[oldSeq];

							for(i=oldSeq; i<newSeq; i++){
								aEdit[i] = aEdit[i+1];
							}

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case OLD_GREATER_NEW:

							// move items 1 back to make room for a new item at new seq

							aEdit = edit.split(",");

							length = aEdit.length;

							oldValue = aEdit[oldSeq];

							for(i=oldSeq; i>newSeq; i--)
								aEdit[i] = aEdit[i-1];

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case NO_CHANGE:
							break;
						case INSERT_QUESTION:
							// since we are inserting a new element, we must grow the array by 1 before split
							// we also have to add the new question number to the list
							edit = edit + ",0";
							aEdit = edit.split(",");

							length = aEdit.length;

							// newSeq was subtracted earlier to accommodate array based processing.
							// to get the qusetion number corresponding to the seq, must add 1 back
							oldValue = "" + getQuestionNumber(conn,campus,1,newSeq+1);

							for(i=length-1; i>newSeq; i--)
								aEdit[i] = aEdit[i-1];

							aEdit[newSeq] = oldValue;

							edit = "";
							for(i=0; i<length; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
						case REMOVE_QUESTION:
							aEdit = edit.split(",");

							length = aEdit.length;

							for(i=oldSeq; i<length-1; i++)
								aEdit[i] = aEdit[i+1];

							// recombine without the last item that is now removed
							edit = "";
							for(i=0; i<length-1; i++){
								if (i==0)
									edit = aEdit[i];
								else
									edit = edit + "," + aEdit[i];
							}

							break;
					} // switch

					if (debug) logger.info(edit);

					sql = "UPDATE " + table + " SET " + fieldName + "=? WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,edit);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
				} // if edit
			} // while
			rs.close();
			ps.close();

			rs = null;
			ps = null;

			if (debug) logger.info("======================== resetQuestionFlags - END");
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}

		return 0;

	} // resetQuestionFlags

	/*
	 * getProgramEditableItems - returns array of question numbers in use by campus
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return int[]
	 */
	public static int[] getProgramEditableItems(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int[] qn = null;
		int i = 0;

		try {
			String sql = "SELECT count(questionnumber) "
				+ "FROM tblProgramQuestions "
				+ "WHERE campus=? "
				+ "AND include=? "
				+ "AND questionseq>0 ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				i = rs.getInt(1);
			}
			rs.close();
			ps.close();

			qn = new int[i];

			i = -1;

			sql = "SELECT questionnumber "
				+ "FROM tblProgramQuestions "
				+ "WHERE campus=? "
				+ "AND include=? "
				+ "AND questionseq>0 "
				+ "ORDER BY questionseq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Y");
			rs = ps.executeQuery();
			while (rs.next()) {
				int x = NumericUtil.nullToZero(rs.getInt("questionnumber"));
				if (x > 0)
					qn[++i] = x;
			}
			rs.close();
			ps.close();
		} catch (SQLException ex) {
			logger.fatal("QuestionDB: getProgramEditableItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getProgramEditableItems - " + e.toString());
		}

		return qn;
	}

	/*
	 * setProgramEnabledItems - sets individual enabled items
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	q			int
	 *	@param	enabled	boolean
	 *	@param	tb			String
	 *	<p>
	 *	@return int
	 */
	public static int setProgramEnabledItems(Connection conn,
															String campus,
															String kix,
															int q,
															boolean enabled,
															String tb) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"QuestionDB");

			if (debug) logger.info("---------------------- START");

			// get the questions in use. Must be ordered by questions seq
			int[] qnProgram = QuestionDB.getProgramEditableItems(conn,campus);

			if (debug){
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("q: " + q);
				logger.info("enabled: " + enabled);
				logger.info("tb: " + tb);
			}

			if (qnProgram != null){

				if (debug) logger.info("qnProgram.length: " + qnProgram.length);

				// get current editable items (if any)
				int programEdits = 1;
				String[] aProgramEdits = null;
				String[] edits = ProgramsDB.getProgramEdits(conn,campus,kix);
				if (edits != null){

					if (debug) logger.info("edits not null");

					// since we are here to enable items for edit, if a comma was not found,
					// that means we currently permit edits on all items.
					// for this to work, we remove edits on all items and set all to off
					// and permit following code below to enable the appropriate ones.

					// edits are either 1 to indicate editable for all items in outline,
					// or CSV of question numbers allowed to edit
					// check for comma to ensure that it's enabled or not

					if (edits[programEdits].indexOf(",") == -1){
						aProgramEdits = new String[qnProgram.length];
						for(i=0; i<qnProgram.length; i++){
							aProgramEdits[i] = "0";
						}
					}
					else{
						aProgramEdits = edits[programEdits].split(",");
					}

					// if the question matches the one needing enablement, set it
					// qnProgram contains actual question numbers
					// q is the question to enable
					// qnProgram and aProgramEdits should be in order
					boolean found = false;
					String junk = "";

					found = false;
					i=0;
					while(i<qnProgram.length && !found){

						if (qnProgram[i]>0){

							if (qnProgram[i]==q){

								if (enabled)
									aProgramEdits[i] = ""+q;
								else
									aProgramEdits[i] = "0";

								found = true;
							}
						} // question number > 0

						i++;
					} // while

					// reassemble as string to save back to table
					junk = "";
					for(i=0; i<aProgramEdits.length; i++){
						if (i==0 || (Constant.BLANK).equals(junk))
							junk = aProgramEdits[i];
						else
							junk = junk + "," + aProgramEdits[i];
					}
					rowsAffected = ProgramsDB.setProgramEdit(conn,campus,kix,junk);

				} // edits != null

			} // qnProgram != null

			if (debug) logger.info("---------------------- END");

		}
		catch(SQLException e){
			logger.fatal("QuestionDB: setProgramEnabledItems - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("QuestionDB: setProgramEnabledItems - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getExplainColumnNameName - returns data stored in explain field for course
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	friendly	String
	 *	<p>
	 *	@return String
	 */
	public static String getExplainColumnName(Connection conn,String friendly) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String explain = "";
		String sql = "SELECT question_explain FROM CCCM6100 WHERE question_friendly=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, friendly);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				explain = AseUtil.nullToBlank(rs.getString("question_explain"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("QuestionDB: getExplainColumnNameName - " + e.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getExplainColumnNameName - " + e.toString());
		}

		return explain;
	}

	/*
	 * getCheckedItems - returns data stored in explain field for course
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	item	String
	 *	@param	keys	String
	 *	<p>
	 *	@return String
	 */
	public static String getCheckedItems(Connection conn,String campus,String item,String keys,int direction) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		String sql = "SELECT kdesc FROM tblini WHERE campus=? AND category=? AND id IN ("+keys+") ORDER BY seq";

		String dir = "";

		try {
			if (keys != null && keys.length() > 0){
				if (direction == Constant.HORIZONTAL)
					dir = "; ";
				else
					dir = Html.BR();

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,item);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					sb.append(AseUtil.nullToBlank(rs.getString("kdesc")) + dir);
				}
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("QuestionDB: getCheckedItems - " + e.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getCheckedItems - " + e.toString());
		}

		return sb.toString();
	}

	/*
	 * getFormattedData - returns data formatted properly
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	fieldname	String
	 *	@param	data			String
	 *	<p>
	 *	@return String
	 */
	public static String getFormattedData(Connection conn,String campus,String kix,String fieldName,String data) {

		//Logger logger = Logger.getLogger("test");

		try{
			String user = "";

			AseUtil ae = new AseUtil();

			String questionType = QuestionDB.getCourseQuestionTypeByFriendlyName(conn,campus,fieldName,1);

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];

			if (fieldName.toLowerCase().indexOf("date") > -1) {
				data = ae.ASE_FormatDateTime(data,Constant.DATE_DATETIME);
			}
			else if (questionType.equals("radio")){

				if (fieldName.toLowerCase().indexOf("status") > -1){
					if (data.equals("0")){
						data = "Inactive";
					}
					else if (data.equals("1")){
						data = "Active";
					}
				}
				else{
					if (data.equals("0")){
						data = "NO";
					}
					else if (data.equals("1")){
						data = "YES";
					}
				}
			}
			else if (questionType.equals("check")){

				// retrieve listing of data from INI table
				String ini = QuestionDB.getCourseQuestionINIFromFriendlyName(conn,campus,fieldName);
				if (ini != null && !ini.equals(Constant.BLANK)){

					String[] reuse = data.split(",");

					for(int k=0;k<reuse.length;k++){

						if (NumericUtil.getInt(reuse[k],0) > 0){
							String junk = "campus='"+campus+"' AND category='"+ini+"' AND id=" + reuse[k];
							String[] lookupData = ae.lookUpX(conn,"tblINI","kid,kdesc",junk);
							junk = lookupData[1];
							if (junk != null && junk.length() > 0){
								if (k==0)
									data = "<li class=\"datacolumn\">" + junk + "</li>";
								else
									data = data + "<li class=\"datacolumn\">" + junk + "</li>";
							}
						} // valid number

					} // for

				} // valid ini

				if (fieldName.equals(Constant.COURSE_METHODEVALUATION)){

					if (campus.equals(Constant.CAMPUS_UHMC)){
						data = data + "<br>" + Outlines.showMethodEval(conn,campus,kix);
					}

					data = data
						+ "<br>"
						+ LinkedUtil.printLinkedMaxtrixContent(conn,kix,fieldName,user,true,true);
				}

			}

			ae = null;
		}
		catch(Exception e){
			logger.fatal("QuestionDB: getFormattedData - " + e.toString());
		}

		return data;

	} // QuestionDB: getFormattedData

	/*
	 * getColumnData - returns data based on the column and kix
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	fieldname	String
	 *	@param	kix			String
	 *	<p>
	 *	@return String
	 */
	public static String getColumnData(Connection conn,String fieldName,String kix) {

		//Logger logger = Logger.getLogger("test");

		String content = "";

		fieldName = fieldName.toUpperCase();

		try {

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String campus = info[Constant.KIX_CAMPUS];

			if (fieldName.equalsIgnoreCase(Constant.COURSE_CROSSLISTED)){
				content = CourseDB.getCrossListing(conn,kix);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
				content = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_CONTENT)){
				content = ContentDB.getContentAsHTMLList(conn,campus,alpha,num,type,kix,false,false);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_COREQ)){
				content = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_COREQ,"");
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
				content = CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,fieldName);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_PREREQ)){
				content = RequisiteDB.getRequisites(conn,campus,alpha,num,type,Constant.REQUISITES_PREREQ,"");
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_PROGRAM)){
				content = ProgramsDB.listProgramsOutlinesDesignedFor(conn,campus,kix,false,true);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO)){
				content = GenericContentDB.getContentAsHTMLList(conn,kix,Constant.COURSE_PROGRAM_SLO);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_RECPREP)){
				content = ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_TEXTMATERIAL)){
				content = TextDB.getTextAsHTMLList(conn,kix);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_CONTACT_HOURS)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_CONTACT_HOURS_X,content,Constant.VERTICAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_EXPECTATIONS)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_EXPECTATIONS_X,content,Constant.VERTICAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_GRADING_OPTIONS)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_GRADING_OPTIONS_X,content,Constant.VERTICAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_METHOD_DELIVERY)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_METHOD_DELIVERY_X,content,Constant.VERTICAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_METHODEVALUATION)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_METHODEVALUATION_X,content,Constant.HORIZONTAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_METHODINSTRUCTION)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_METHODINSTRUCTION_X,content,Constant.VERTICAL);
			}
			else if (fieldName.equalsIgnoreCase(Constant.COURSE_SEMESTER)){
				content = QuestionDB.getCheckedItems(conn,campus,Constant.COURSE_SEMESTER_X,content,Constant.VERTICAL);
			}

		} catch (SQLException e) {
			logger.fatal("QuestionDB: getColumnData - " + e.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: getColumnData - " + e.toString());
		}

		return content;
	} // QuestionDB: getColumnData

	/*
	 * getCourseFriendlyNameFromNumber
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	num			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseFriendlyNameFromNumber(Connection connection,String campus,int num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String question = "";

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionnumber=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				question = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseFriendlyNameFromNumber - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseFriendlyNameFromNumber - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseFriendlyNameFromSequence
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	seq			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseFriendlyNameFromSequence(Connection connection,String campus,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String question = "";

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionseq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				question = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseFriendlyNameFromSequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseFriendlyNameFromSequence - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionINIFromSequence
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	seq			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionINIFromSequence(Connection connection,String campus,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String question = "";

		try {
			String sql = "SELECT cc.Question_ini "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionseq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				question = AseUtil.nullToBlank(rs.getString("Question_ini"));
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseQuestionINIFromSequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionINIFromSequence - " + e.toString());
		}

		return question;
	}

	/*
	 * getCourseQuestionINIFromFriendlyName
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	seq			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseQuestionINIFromFriendlyName(Connection connection,String campus,String friendlyName) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String question = "";

		try {
			String sql = "SELECT cc.Question_ini "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cc.question_friendly=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,friendlyName);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				question = AseUtil.nullToBlank(rs.getString("Question_ini"));
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getCourseQuestionINIFromFriendlyName - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getCourseQuestionINIFromFriendlyName - " + e.toString());
		}

		return question;
	}

	/*
	 * isCourseAlphaFromSequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCourseAlphaFromSequence(Connection connection,String campus,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean isAlpha = false;

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionseq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				String question = AseUtil.nullToBlank(rs.getString("question_friendly"));

				if (question.toLowerCase().equals("coursealpha")){
					isAlpha = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: isCourseAlphaFromSequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: isCourseAlphaFromSequence - " + e.toString());
		}

		return isAlpha;
	}

	/*
	 * isCourseAlphaFromNumber
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	num		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCourseAlphaFromNumber(Connection connection,String campus,int num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean isAlpha = false;

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionnumber=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				String question = AseUtil.nullToBlank(rs.getString("question_friendly"));

				if (question.toLowerCase().equals("coursealpha")){
					isAlpha = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: isCourseAlphaFromNumber - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: isCourseAlphaFromNumber - " + e.toString());
		}

		return isAlpha;
	}

	/*
	 * isCourseNumFromSequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCourseNumFromSequence(Connection connection,String campus,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean isNum = false;

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionseq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				String question = AseUtil.nullToBlank(rs.getString("question_friendly"));

				if (question.toLowerCase().equals("coursenum")){
					isNum = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: isCourseNumFromSequence - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: isCourseNumFromSequence - " + e.toString());
		}

		return isNum;
	}

	/*
	 * isCourseNumFromNumber - is this item COURSENUM when given the sequence number from course question
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	num		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCourseNumFromNumber(Connection connection,String campus,int num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean isNum = false;

		try {
			String sql = "SELECT cc.Question_Friendly "
					+ "FROM tblCourseQuestions cq INNER JOIN CCCM6100 cc "
					+ "ON cq.questionnumber = cc.Question_Number "
					+ "WHERE cq.campus=? AND cc.campus='SYS' AND cc.type='Course' AND cq.include='Y' AND cq.questionnumber=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				String question = AseUtil.nullToBlank(rs.getString("question_friendly"));

				if (question.toLowerCase().equals("coursenum")){
					isNum = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: isCourseNumFromNumber - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: isCourseNumFromNumber - " + e.toString());
		}

		return isNum;
	}

	/*
	 * getCourseItemData
	 *	<p>
	 *	@param	conn	Connection
	 * @param	user	String
	 * @param	kix	String
	 * @param	tab	int
	 * @param	seq	int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseItemData(Connection conn,String user,String kix,int tab,int seq) {

		//Logger logger = Logger.getLogger("test");

		String data = "";

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String proposer = info[3];
			String campus = info[4];

			String friendlyName = "";
			String outlineData = "";

			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);
			if (seq > courseTabCount){
				friendlyName = CCCM6100DB.getCampusFriendlyNameFromSequence(conn,campus,seq-courseTabCount);
				outlineData = CampusDB.getCampusItem(conn,kix,friendlyName);
			}
			else{
				friendlyName = CCCM6100DB.getCourseFriendlyNameFromSequence(conn,campus,seq);
				outlineData = CourseDB.getCourseItem(conn,kix,friendlyName);
			}

			if (friendlyName != null && friendlyName.length() > 0){
				data = Outlines.formatOutline(conn,
														friendlyName,
														campus,
														alpha,
														num,
														type,
														kix,
														outlineData,
														true,
														user);
			}

		}
		catch(Exception e){
			logger.fatal("QuestionDB: getCourseItemData - " + e.toString());
		}

		return data;

	}

	/*
	 * isDefaultTextPermanent - returns true if the column default text is permanent
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	tab		int
	 * @param	column 	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isDefaultTextPermanent(Connection conn,String campus,int tab,String column) {

		//Logger logger = Logger.getLogger("test");

		boolean permanent = false;

		try{

			String sql = "";

			if(tab==Constant.TAB_COURSE){
				sql = "SELECT permanent FROM (" + SQL.vw_getCourseQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}
			else if(tab==Constant.TAB_CAMPUS){
				sql = "SELECT permanent FROM (" + SQL.vw_getCampusQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}
			else if(tab==Constant.TAB_PROGRAM){
				sql = "SELECT permanent FROM (" + SQL.vw_getProgramQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}


			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				if(AseUtil.nullToBlank(rs.getString("permanent")).equals("Y")){
					permanent = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal("QuestionDB: isDefaultTextPermanent - " + e.toString());
		}

		return permanent;

	}

	/*
	 * defaultTextAppends - returns true or false based on appends ("A"fter or "B"efore)
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	tab		int
	 * @param	column 	String
	 * @param	appends 	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean defaultTextAppends(Connection conn,String campus,int tab,String column,String appends) {

		//Logger logger = Logger.getLogger("test");

		boolean appending = false;

		try{

			if (isDefaultTextPermanent(conn,campus,tab,column)){

				String sql = "";

				if(tab==Constant.TAB_COURSE){
					sql = "SELECT append FROM (" + SQL.vw_getCourseQuestionInfo() +") as vw WHERE campus=? AND question_friendly=? AND append=?";
				}
				else if(tab==Constant.TAB_CAMPUS){
					sql = "SELECT append FROM (" + SQL.vw_getCampusQuestionInfo() +") as vw WHERE campus=? AND question_friendly=? AND append=?";
				}
				else if(tab==Constant.TAB_PROGRAM){
					sql = "SELECT append FROM (" + SQL.vw_getProgramQuestionInfo() +") as vw WHERE campus=? AND question_friendly=? AND append=?";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,column);
				ps.setString(3,appends);
				ResultSet rs = ps.executeQuery();
				appending = rs.next();
				rs.close();
				ps.close();
			}

		}
		catch(Exception e){
			logger.fatal("QuestionDB: defaultTextAppends - " + e.toString());
		}

		return appending;

	}

	/*
	 * getDefaultText
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	tab		int
	 * @param	column	String
	 *	<p>
	 *	@return String
	 */
	public static String getDefaultText(Connection conn,String campus,int tab,String column) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String defaultText = "";

		try {
			String sql = "";

			if(tab==Constant.TAB_COURSE){
				sql = "SELECT defalt FROM (" + SQL.vw_getCourseQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}
			else if(tab==Constant.TAB_CAMPUS){
				sql = "SELECT defalt FROM (" + SQL.vw_getCampusQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}
			else if(tab==Constant.TAB_PROGRAM){
				sql = "SELECT defalt FROM (" + SQL.vw_getProgramQuestionInfo() +") as vw WHERE campus=? AND question_friendly=?";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				defaultText = AseUtil.nullToBlank(rs.getString("defalt"));
			}
			rs.close();
			ps.close();
		}
		catch (SQLException se) {
			logger.fatal("QuestionDB: getDefaultText - " + se.toString());
		}
		catch (Exception e) {
			logger.fatal("QuestionDB: getDefaultText - " + e.toString());
		}

		return defaultText;
	}

	/*
	 */
	public void close() throws SQLException {}

}

