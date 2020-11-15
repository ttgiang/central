/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// CCCM6100DB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class CCCM6100DB {
	static Logger logger = Logger.getLogger(CCCM6100DB.class.getName());

	public CCCM6100DB() throws Exception {}

	/*
		See com.test.aseutil.CCCM6100DBTest to rerun test for this object
	*/

	/*
	 * getCCCM6100
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	seq			int
	 *	@param	campus		String
	 *	@param	tab			int
	 *	<p>
	 *	@return CCCM6100
	 */
	public static CCCM6100 getCCCM6100(Connection connection,int seq,String campus,int tab) throws Exception {

		String sql;
		String view = "";

		if (tab == 1) {
			view = "vw_CCCM6100_Sys";
		} else {
			view = "vw_CCCM6100_Campus";
		}

		sql = "SELECT question,question_ini,question_type,question_len,question_max,question_friendly,"
				+ "campus,question_explain,change,required,helpFile,audioFile,rules,rulesform,defalt,comments,len,counttext,extra,permanent,append,headertext "
				+ "FROM "
				+ view
				+ " WHERE campus=? AND questionseq=?";

		CCCM6100 cccm6100 = new CCCM6100();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cccm6100.setCCCM6100(AseUtil.nullToBlank(rs.getString("question")));
				cccm6100.setQuestion_Ini(AseUtil.nullToBlank(rs.getString("question_ini")));
				cccm6100.setQuestion_Type(AseUtil.nullToBlank(rs.getString("question_type")));
				cccm6100.setQuestion_Len(rs.getInt("question_len"));
				cccm6100.setQuestion_Max(rs.getInt("question_max"));
				cccm6100.setQuestion_Friendly(AseUtil.nullToBlank(rs.getString("question_friendly")));
				cccm6100.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				cccm6100.setQuestion_Explain(AseUtil.nullToBlank(rs.getString("question_explain")));
				cccm6100.setQuestion_Change(AseUtil.nullToBlank(rs.getString("change")));
				cccm6100.setRequired(AseUtil.nullToBlank(rs.getString("required")));
				cccm6100.setHelpFile(AseUtil.nullToBlank(rs.getString("helpFile")));
				cccm6100.setAudioFile(AseUtil.nullToBlank(rs.getString("audioFile")));
				cccm6100.setRules(rs.getBoolean("rules"));
				cccm6100.setRulesForm(AseUtil.nullToBlank(rs.getString("rulesForm")));
				cccm6100.setDefalt(AseUtil.nullToBlank(rs.getString("defalt")));
				cccm6100.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				cccm6100.setUserLen(rs.getInt("len"));
				cccm6100.setCounter(AseUtil.nullToBlank(rs.getString("counttext")));
				cccm6100.setExtra(AseUtil.nullToBlank(rs.getString("extra")));
				cccm6100.setPermanent(AseUtil.nullToBlank(rs.getString("permanent")));
				cccm6100.setAppend(AseUtil.nullToBlank(rs.getString("append")));
				cccm6100.setHeaderText(AseUtil.nullToBlank(rs.getString("headertext")));
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100 - " + e.toString());
		}

		return cccm6100;
	}

	/*
	 * getCCCM6100ByFriendlyName
	 *	<p>
	 *	@param	connection			Connection
	 *	@param	questionFriendly	String
	 *	<p>
	 *	@return CCCM6100
	 */
	public static CCCM6100 getCCCM6100ByFriendlyName(Connection connection,String questionFriendly) throws Exception {

		String sql = "SELECT id,question_friendly,question_type,question_len,question_max,question_ini,question_explain,cccm6100,rules,rulesform "
			+ "FROM CCCM6100 "
		 	+ "WHERE question_friendly=?";
		CCCM6100 cccm6100 = new CCCM6100();
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, questionFriendly);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cccm6100.setId(rs.getInt("id"));
				cccm6100.setQuestion_Friendly(AseUtil.nullToBlank(rs.getString("question_friendly")));
				cccm6100.setQuestion_Type(AseUtil.nullToBlank(rs.getString("question_type")));
				cccm6100.setQuestion_Len(rs.getInt("question_len"));
				cccm6100.setQuestion_Max(rs.getInt("question_max"));
				cccm6100.setQuestion_Ini(AseUtil.nullToBlank(rs.getString("question_ini")));
				cccm6100.setQuestion_Explain(AseUtil.nullToBlank(rs.getString("question_explain")));
				cccm6100.setCCCM6100(AseUtil.nullToBlank(rs.getString("cccm6100")));
				cccm6100.setRules(rs.getBoolean("rules"));
				cccm6100.setQuestion_Len(rs.getInt("question_len"));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByFriendlyName - " + e.toString());
			cccm6100 = null;
		}

		return cccm6100;
	}

	/*
	 * getCCCM6100ByQuestionNumber
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	qn		int
	 *	<p>
	 *	@return CCCM6100
	 */
	public static CCCM6100 getCCCM6100ByQuestionNumber(Connection conn,int qn) throws Exception {

		String sql = "SELECT id,question_friendly,question_type,question_len,question_max,question_ini,question_explain,cccm6100,rules,rulesform,len,counttext,extra,permanent,append "
			+ "FROM CCCM6100 "
		 	+ "WHERE campus='SYS' AND type='Course' AND question_number=?";

		CCCM6100 cccm6100 = new CCCM6100();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,qn);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cccm6100.setId(rs.getInt("id"));
				cccm6100.setQuestion_Friendly(AseUtil.nullToBlank(rs.getString("question_friendly")));
				cccm6100.setQuestion_Type(AseUtil.nullToBlank(rs.getString("question_type")));
				cccm6100.setQuestion_Len(rs.getInt("question_len"));
				cccm6100.setQuestion_Max(rs.getInt("question_max"));
				cccm6100.setQuestion_Ini(AseUtil.nullToBlank(rs.getString("question_ini")));
				cccm6100.setQuestion_Explain(AseUtil.nullToBlank(rs.getString("question_explain")));
				cccm6100.setCCCM6100(AseUtil.nullToBlank(rs.getString("cccm6100")));
				cccm6100.setRules(rs.getBoolean("rules"));
				cccm6100.setRulesForm(AseUtil.nullToBlank(rs.getString("rulesForm")));
				cccm6100.setUserLen(rs.getInt("len"));
				cccm6100.setCounter(AseUtil.nullToBlank(rs.getString("counttext")));
				cccm6100.setExtra(AseUtil.nullToBlank(rs.getString("extra")));
				cccm6100.setPermanent(AseUtil.nullToBlank(rs.getString("permanent")));
				cccm6100.setAppend(AseUtil.nullToBlank(rs.getString("append")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByQuestionNumber - " + e.toString());
			cccm6100 = null;
		}

		return cccm6100;
	}

	/*
	 * getCCCM6100ByID
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	lid			int
	 *	<p>
	 *	@return CCCM6100
	 */
	public static CCCM6100 getCCCM6100ByID(Connection connection, int lid)throws Exception {

		String sql = "SELECT id,question_friendly,question_type,question_len,question_max,question_ini,question_explain,rules,rulesform,len,counttext,extra,permanent,append "
			+ "FROM CCCM6100 WHERE id=?";

		CCCM6100 cccm6100 = new CCCM6100();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, lid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cccm6100.setId(rs.getInt("id"));
				cccm6100.setQuestion_Friendly(AseUtil.nullToBlank(rs.getString("question_friendly")));
				cccm6100.setQuestion_Type(AseUtil.nullToBlank(rs.getString("question_type")));
				cccm6100.setQuestion_Len(rs.getInt("question_len"));
				cccm6100.setQuestion_Max(rs.getInt("question_max"));
				cccm6100.setQuestion_Ini(AseUtil.nullToBlank(rs.getString("question_ini")));
				cccm6100.setQuestion_Explain(AseUtil.nullToBlank(rs.getString("question_explain")));
				cccm6100.setRules(rs.getBoolean("rules"));
				cccm6100.setRulesForm(AseUtil.nullToBlank(rs.getString("rulesForm")));
				cccm6100.setUserLen(rs.getInt("len"));
				cccm6100.setCounter(AseUtil.nullToBlank(rs.getString("counttext")));
				cccm6100.setExtra(AseUtil.nullToBlank(rs.getString("extra")));
				cccm6100.setPermanent(AseUtil.nullToBlank(rs.getString("permanent")));
				cccm6100.setAppend(AseUtil.nullToBlank(rs.getString("append")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByID - " + e.toString());
			cccm6100 = null;
		}

		return cccm6100;
	}

	/*
	 * getCCCM6100ByIDCampusCourse
	 *	<p>
	 *	@param	connection		Connection
	 *	@param	id					int
	 *	@param	campus			String
	 *	@param	questionType	String
	 *	<p>
	 *	@return CCCM6100
	 */
	public static CCCM6100 getCCCM6100ByIDCampusCourse(Connection connection,
																		int id,
																		String campus,
																		String questionType) throws Exception {

		String table = "";

		CCCM6100 cccm6100 = null;

		if (questionType.equals("r"))
			table = "vw_CCCM6100ByIDCampusCourse";
		else if (questionType.equals("c"))
			table = "vw_CCCM6100ByIDCampusItems";
		else if (questionType.equals("p"))
			table = "vw_CCCM6100ByIDProgramItems";

		String sql = "SELECT id,questionnumber,questionseq,question,include,question_friendly,"
				+ "question_type,question_len,question_max,question_ini,auditby,auditdate,help, "
				+ "question_explain,change,required,helpfile,audiofile,rules,rulesform,defalt,comments,len,counttext,extra,permanent,append,headertext "
				+ "FROM " + table + " WHERE campus=? AND id=?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, id);
			ResultSet rs = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			if (rs.next()) {
				cccm6100 = new CCCM6100();
				cccm6100.setId(rs.getInt(1));
				cccm6100.setQuestion_Number(rs.getInt(2));
				cccm6100.setQuestionSeq(rs.getInt(3));
				cccm6100.setCCCM6100(aseUtil.nullToBlank(rs.getString(4)));
				cccm6100.setInclude(aseUtil.nullToBlank(rs.getString(5)));
				cccm6100.setQuestion_Friendly(aseUtil.nullToBlank(rs.getString(6)));
				cccm6100.setQuestion_Type(aseUtil.nullToBlank(rs.getString(7)));
				cccm6100.setQuestion_Len(rs.getInt(8));
				cccm6100.setQuestion_Max(rs.getInt(9));
				cccm6100.setQuestion_Ini(aseUtil.nullToBlank(rs.getString(10)));
				cccm6100.setAuditBy(rs.getString(11));
				cccm6100.setAuditDate(aseUtil.ASE_FormatDateTime(aseUtil.nullToBlank(rs.getString(12)),Constant.DATE_DATETIME));
				cccm6100.setHelp(aseUtil.nullToBlank(rs.getString(13)));
				cccm6100.setQuestion_Explain(aseUtil.nullToBlank(rs.getString(14)));
				cccm6100.setChange(aseUtil.nullToBlank(rs.getString(15)));
				cccm6100.setRequired(aseUtil.nullToBlank(rs.getString(16)));
				cccm6100.setHelpFile(aseUtil.nullToBlank(rs.getString("helpFile")));
				cccm6100.setAudioFile(aseUtil.nullToBlank(rs.getString("audioFile")));
				cccm6100.setRules(rs.getBoolean("rules"));
				cccm6100.setRulesForm(AseUtil.nullToBlank(rs.getString("rulesForm")));
				cccm6100.setDefalt(AseUtil.nullToBlank(rs.getString("defalt")));
				cccm6100.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				cccm6100.setUserLen(rs.getInt("len"));
				cccm6100.setCounter(AseUtil.nullToBlank(rs.getString("counttext")));
				cccm6100.setExtra(AseUtil.nullToBlank(rs.getString("extra")));
				cccm6100.setPermanent(AseUtil.nullToBlank(rs.getString("permanent")));
				cccm6100.setAppend(AseUtil.nullToBlank(rs.getString("append")));
				cccm6100.setHeaderText(AseUtil.nullToBlank(rs.getString("headertext")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByIDCampusCourse - " + e.toString());
		}

		return cccm6100;
	}

	/*
	 * getCCCM6100s
	 *	<p>
	 *	@param	connection		Connection
	 *	<p>
	 *	@return String
	 */
	public static String getCCCM6100s(Connection connection) {

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String rowColor = "";
		boolean found = false;
		int j = 0;

		try {
			CCCM6100 cccm6100;
			String sql = "SELECT cccm6100,question_ini,question_type,question_len,question_friendly,question_number,question_max,question_explain,len "
				+ "FROM cccm6100 "
				+" WHERE type='Course' AND "
				+ "campus='SYS' "
				+ "ORDER BY question_number";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (rs.next()) {
				found = true;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\"" + rowColor + "\" height=\"20\" class=\"datacolumn\">"
					+ "<td valign=\'top\'>" + rs.getInt("Question_Number") + "</td>"
					+ "<td valign=\'top\'>&nbsp;</td>"
					+ "<td valign=\'top\'>" + aseUtil.nullToBlank(rs.getString("cccm6100")) + "</td>"
					+ "<td valign=\'top\'>&nbsp;</td>"
					+ "<td valign=\'top\'>" + aseUtil.nullToBlank(rs.getString("question_explain")) + "</td>"
					+ "</tr>");
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table width=\"90%\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\">"
						+ "<tr bgcolor=#C0C0C0 class=\"textblackth\" height=\"20\">"
						+ "<td valign=\'top\'>#</td>"
						+ "<td valign=\'top\' width=\"03%\">&nbsp;</td>"
						+ "<td valign=\'top\'>Question</td>"
						+ "<td valign=\'top\' width=\"03%\">&nbsp;</td>"
						+ "<td valign=\'top\'>Explain</td>"
						+ "</tr>"
						+ buf.toString()
						+ "</table>";
			}

		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100s - " + e.toString());
		}

		return temp;
	}

	/*
	 * getCCCMQuestionNumber
	 *	<p>
	 *	@param	connection			Connection
	 *	@param	campus				String
	 *	@param	type					String
	 *	@param	questionFriendly	String
	 *	<p>
	 *	@return int
	 */
	public static int getCCCMQuestionNumber(Connection connection,
														String campus,
														String type,
														String questionFriendly)throws Exception {


		String sql = "SELECT question_number FROM CCCM6100 WHERE campus=? AND type=? AND question_friendly=?";

		int questionNumber = 0;

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,type);
			ps.setString(3,questionFriendly);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				questionNumber = rs.getInt(1);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCMQuestionNumber - " + e.toString());
		}

		return questionNumber;
	}

	/*
	 * getExplainColumnValue
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	column	String
	 *	<p>
	 *	@return String
	 */
	public static String getExplainColumnValue(Connection conn,String column) throws Exception {

		String explain = "";
		String sql = "SELECT question_explain FROM CCCM6100 WHERE question_friendly=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				explain = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getExplainColumnValue - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getExplainColumnValue - " + e.toString());
		}

		return explain;
	}

	/*
	 * getQuestionTypeColumnValue
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	column	String
	 *	<p>
	 *	@return String
	 */
	public static String getQuestionTypeColumnValue(Connection conn,String column) throws Exception {

		String type = "";
		String sql = "SELECT question_type "
			+ "FROM CCCM6100 "
			+ "WHERE question_friendly=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				type = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getQuestionTypeColumnValue - " + e.toString());
		}

		return type;
	}

	/*
	 * getSequenceFromQuestionNumbers - returns CSV of question seq from question numbers
	 *												tab is either TAB_COURSE or TAB_CAMPUS
	 *	<p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	tab				int
	 * @param	questionNumber	String
	 * @param	sort				boolean
	 *	<p>
	 * @return String
	 */
	public static String getSequenceFromQuestionNumbers(Connection conn,
																		String campus,
																		int tab,
																		String questionNumber) throws Exception {

		return getSequenceFromQuestionNumbers(conn,campus,tab,questionNumber,false);
	}

	public static String getSequenceFromQuestionNumbers(Connection conn,
																		String campus,
																		int tab,
																		String questionNumber,
																		boolean sort) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";
		int seq = 0;
		int maxNo = 0;

		try {
			String table = "";

			// if the question sequence is alpha or num, don't include in list of editable items
			boolean include = false;

			if (tab==-1){
				table = "tblProgramQuestions";
			}
			else if (tab == Constant.TAB_COURSE){
				table = "tblCourseQuestions";
			}
			else if (tab == Constant.TAB_CAMPUS){
				// set to correct table as well as figuring how many questions are
				// on the course tab so that we can correctly display sequence
				table = "tblCampusQuestions";
				maxNo = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			}

			//
			// make sure we have valid data
			//
			if(questionNumber == null || questionNumber.equals("")){
				questionNumber = "0";
			}

			String sql = "SELECT questionseq "
				+ "FROM " + table + " WHERE campus=? AND (questionnumber IN ("+questionNumber+")) ";

			if(sort){
				sql = sql + " ORDER BY questionseq";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt(1);

				// adjust sequence because campus tab is continuation from course
				if (tab == Constant.TAB_CAMPUS){
					seq = seq + maxNo;
				}

				include = true;

				if (tab == Constant.TAB_COURSE){
					if (	QuestionDB.isCourseNumFromSequence(conn,campus,seq) ||
							QuestionDB.isCourseAlphaFromSequence(conn,campus,seq)){
						include = false;
					} // not include course alpha and number
				}

				if (include){
					if ("".equals(csv))
						csv = "" + seq;
					else
						csv = csv + "," + seq;
				} // include

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			campus = "campus: " + campus + "; tab: " + tab + "; questionNumber: " + questionNumber;
			logger.fatal("CCCM6100DB.getSequenceFromQuestionNumbers: \n" + campus + "\n" + e.toString());
		} catch (Exception e) {
			campus = "campus: " + campus + "; tab: " + tab + "; questionNumber: " + questionNumber;
			logger.fatal("CCCM6100DB.getSequenceFromQuestionNumbers: \n" + campus + "\n" + e.toString());
		}

		return csv;
	}

	/*
	 * getCCCM6100ByColumn
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	column	String
	 *	<p>
	 *	@return String
	 */
	public static String getCCCM6100ByColumn(Connection conn,String column) throws Exception {

		String type = "";
		String sql = "SELECT cccm6100 FROM CCCM6100 WHERE question_friendly=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				type = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByColumn - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCM6100ByColumn - " + e.toString());
		}

		return type;
	}

	/*
	 * CCCMInUse
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	showText	int
	 *	<p>
	 *	@return String
	 */
	public static String CCCMInUse(Connection conn,int showText) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String rowColor = "";
		int counter = 0;
		int i = 0;
		boolean found = false;

		try{

			StringBuffer buf = new StringBuffer();

			String server = SysDB.getSys(conn,"server");

			int allCampuses = 0;

			// number of campuses and names
			String campuses = CampusDB.getCampusNames(conn);
			String[] aCampuses = campuses.split(",");

			allCampuses = aCampuses.length;

			// campus to hold data that are included
			String[] aCampus = new String[allCampuses];

			int Question_Number = 0;
			String CCCM6100 = "";
			String Question_Friendly = "";

			String question = "";
			String campus = "";

			// 1) read all questions for courses
			// 2) for each question, find all campuses using it (include=Y)
			// 3) put togeter array for output
			String sql = "SELECT Question_Number, CCCM6100, Question_Friendly "
					+ "FROM CCCM6100 "
					+ "WHERE (campus = 'SYS') AND (type = 'Course') "
					+ "ORDER BY Question_Number";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				// 1) course question
				Question_Number = rs.getInt("Question_Number");
				Question_Friendly = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
				CCCM6100 = AseUtil.nullToBlank(rs.getString("CCCM6100"));

				// clear array
				for (i = 0; i < allCampuses; i++){
					aCampus[i] = "&nbsp;";
				}

				// 2) get questions from campuses
				sql = "SELECT question, campus "
						+ "FROM tblCourseQuestions "
						+ "WHERE type='Course' AND include='Y' AND questionnumber=? "
						+ "ORDER BY campus";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,Question_Number);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()){
					question = AseUtil.nullToBlank(rs2.getString("question"));
					campus = AseUtil.nullToBlank(rs2.getString("campus"));

					if (showText==0){
						question = "<img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"\" border=\"0\" />";
					}

					// place data in the correct campus box
					i = 0;
					found = false;
					while (i < allCampuses && !found){
						if (campus.equals(aCampuses[i])){
							aCampus[i] = question;
							found = true;
						}
						++i;
					}

				}	// while
				rs2.close();
				ps2.close();

				if (counter++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\""+rowColor+"\">"
							+ "<td valign=\"top\"><a href=\"cccmx.jsp?qn="+Question_Number+"\" class=\"linkcolumn\">" + Question_Number + "</a></td>"
							+ "<td valign=\"top\">" + CCCM6100 + "</td>");


				if(showText<2){
					for (i = 0; i < allCampuses; i++){
						buf.append("<td valign=\"top\">" + aCampus[i] + "</td>");
					} // for i

					buf.append("</tr>");
				}
				else if(showText==2){
					buf.append("</tr>");
					buf.append("<tr bgcolor=\""+rowColor+"\"><td>&nbsp;</td><td valign=\"top\"><table border=1 cellpadding=4 width=\"100%\">");
					for (i = 0; i < allCampuses; i++){
						if(aCampus[i] != null && aCampus[i].length() > 0 && !aCampus[i].equals("&nbsp;")){
							buf.append("<tr><td width=\"05%\" valign=\"top\">" + aCampuses[i] + "</td><td valign=\"top\">" + aCampus[i] + "</td></tr>");
						}
					} // for i
					buf.append("</table></td></tr>");
				}
			}	// while
			rs.close();
			ps.close();

			temp = "<table border=1 cellpadding=4 width=\"100%\">"
					+ "<tr bgcolor=\"#dbeaf5\">"
					+ "<td valign=\"top\">#</td>"
					+ "<td valign=\"top\">CCCM6100</td>";

			if(showText<2){
				for (i = 0; i < allCampuses; i++){
					temp += "<td valign=\"top\">" + aCampuses[i] + "</td>";
				} // for i
			}
			else if(showText==2){
				//temp += "<td valign=\"top\">Campus</td>";
			}

			temp += "</tr>" + buf.toString() + "</table>";

		}
		catch(SQLException se ){
			logger.fatal("CCCM6100DB: CCCMInUse - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("CCCM6100DB: CCCMInUse - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getCCCMQuestionFriendly
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	qn		int
	 *	<p>
	 *	@return String
	 */
	public static String getCCCMQuestionFriendly(Connection connection,int qn)throws Exception {


		String sql = "SELECT question_friendly FROM CCCM6100 WHERE campus=? AND type=? AND question_number=?";

		String question_friendly = "";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,"SYS");
			ps.setString(2,"Course");
			ps.setInt(3,qn);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question_friendly = rs.getString(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getCCCMQuestionFriendly - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCCCMQuestionFriendly - " + e.toString());
		}

		return question_friendly;
	}

	/*
	 * displayCourseInUseByAlpha
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	qn		int
	 *	@param	idx	int
	 *	<p>
	 *	@return String
	 */
	public static String displayCourseInUseByAlpha(Connection conn,int idx,int qn) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();

		String savedAlpha = "";
		String alpha = "";
		String num = "";

		try{

			// get the question friendly from the question number
			String friendly = CCCM6100DB.getCCCMQuestionFriendly(conn,qn);

			if (friendly != null && friendly.length() > 0){
				String sql = "SELECT DISTINCT CourseAlpha, CourseNum "
						+ "FROM tblCourse "
						+ "WHERE (NOT ("+friendly+" IS NULL)) "
						+ "AND (CourseType = 'CUR') "
						+ "AND coursealpha like '" + (char)idx + "%' "
						+ "ORDER BY CourseAlpha, CourseNum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("CourseNum"));

					if (!savedAlpha.equals(alpha)){

						// close the last UL tag
						if (!(Constant.BLANK).equals(savedAlpha))
							temp.append("</ul>");

						savedAlpha = alpha;

						// start a new UL tag
						temp.append("<li><a href=\"cccmy.jsp?a="+alpha+"&idx="+idx+"&idx="+idx+"&qn="+qn+"\" class=\"linkcolumn\">" + savedAlpha + "</a></li><ul>");
					}

					temp.append("<li><a href=\"cccmy.jsp?a="+alpha+"&n="+num+"&idx="+idx+"&qn="+qn+"\" class=\"linkcolumn\">" + alpha + " - " + num + "</a></li>");
				}	// while
				rs.close();
				ps.close();
			} // friendly

		}
		catch(SQLException se ){
			logger.fatal("CCCM6100DB: displayCourseInUseByAlpha - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("CCCM6100DB: displayCourseInUseByAlpha - " + ex.toString());
		}

		return "<ul>" + temp.toString() + "</ul>";
	}

	/*
	 * displayCourseInUseByFriendly
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	alpha	String
	 *	@param	num	String
	 *	@param	qn		int
	 *	<p>
	 *	@return String
	 */
	public static String displayCourseInUseByFriendly(Connection conn,String alpha,String num,int qn) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();

		String campus = "";
		String title = "";
		String question = "";
		String friendlyData = "";

		try{

			// get the question friendly from the question number
			String friendlyName = CCCM6100DB.getCCCMQuestionFriendly(conn,qn);

			if (friendlyName != null && friendlyName.length() > 0){

				String sql = "SELECT campus,coursenum,coursetitle,"+friendlyName+" "
						+ "FROM tblCourse "
						+ "WHERE coursealpha=? ";

				if (num != null && num.length() > 0)
						sql += "AND coursenum=? ";

				sql += "AND CourseType='CUR' "
						+ "AND (NOT ("+friendlyName+" IS NULL)) "
						+ "ORDER BY campus, coursenum ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);

				if (num != null && num.length() > 0)
					ps.setString(2,num);

				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					friendlyData = AseUtil.nullToBlank(rs.getString(friendlyName));
					title = AseUtil.nullToBlank(rs.getString("coursetitle"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));

					question = QuestionDB.getCourseQuestionByNumber(conn,campus,Constant.TAB_COURSE,qn);

					temp.append("<li>"
								+ "<font class=\"textblackth\">" + campus + "</font>"
								+ Html.BR()
								+ "<font class=\"textblackitalic\">Course Title:</font> <font class=\"datacolumn\">" + title + " (" + alpha + " " + num + ")</font>"
								+ Html.BR()
								+ "<font class=\"textblackitalic\">Course Question:</font>  <font class=\"datacolumn\">" + question + "</font>"
								+ Html.BR()
								+ Html.BR()
								+ "<font class=\"datacolumn\">" + friendlyData + "</font>"
								+ Html.BR()
								+ Html.BR()
								+ "</li>"
								);
				}	// while
				rs.close();
				ps.close();
			} // friendly
		}
		catch(SQLException se ){
			logger.fatal("CCCM6100DB: displayCourseInUseByFriendly - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("CCCM6100DB: displayCourseInUseByFriendly - " + ex.toString());
		}

		return "<ul>" + temp.toString() + "</ul>";
	}

	/*
	 * displayCommentsBox - determines whether the comment box should be display for a question
	 * <p>
	 *	@param	conn		connection
	 *	@param	campus	String
	 *	@param	column	String
	 * <p>
	 *	@return boolean
	 */
	public static boolean displayCommentsBox(Connection conn,String campus,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean commentsBox = false;
		String comments = "";

		try {
			String sql = "SELECT tcq.comments "
							+ "FROM tblCourseQuestions tcq INNER JOIN "
							+ "CCCM6100 c ON tcq.questionnumber = c.Question_Number "
							+ "WHERE c.campus='SYS' "
							+ "AND c.type='Course' "
							+ "AND tcq.campus=? "
							+ "AND c.Question_Friendly=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				comments = AseUtil.nullToBlank(rs.getString(1));
				if (comments.equals("Y")){
					commentsBox = true;
				}
			}
			else{
				rs.close();
				ps.close();

				sql = "SELECT tcq.comments FROM CCCM6100 cm INNER JOIN "
					+ "tblCampusQuestions tcq ON cm.Question_Number = tcq.questionnumber "
					+ "WHERE (cm.campus=?) AND (cm.type='Campus') AND (cm.Question_Friendly=?) AND (tcq.campus=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,column);
				ps.setString(3,campus);
				rs = ps.executeQuery();
				if (rs.next()) {
					comments = AseUtil.nullToBlank(rs.getString(1));
					if (comments.equals("Y")){
						commentsBox = true;
					}
				}

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: displayCommentsBox - " + e.toString());
		}

		return commentsBox;
	}

	/*
	 * getQuestions
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	view			String
	 * @param	included		String
	 * <p>
	 * @return Banner
	 */
	public static List<CCCM6100> getQuestions(Connection conn,String campus,String view,String included) throws Exception {

		List<CCCM6100> CCCM6100Data = null;

		try {
			if (CCCM6100Data == null){

            CCCM6100Data = new LinkedList<CCCM6100>();

				String sql = "SELECT id,seq,Question,Field_Name,Question_Type,Include,Required,Comments,Len,counttext,extra "
							+ "FROM " + view + " WHERE campus=? ";

				if (included != null && included.length() == 1){
					sql += " AND include=? ";
				}

				sql += " ORDER BY seq";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);

				if (included != null && included.length() == 1){
					ps.setString(2,included);
				}

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	CCCM6100Data.add(new CCCM6100(
										rs.getInt("id"),
										rs.getInt("seq"),
										AseUtil.nullToBlank(rs.getString("Question")),
										AseUtil.nullToBlank(rs.getString("Field_Name")),
										AseUtil.nullToBlank(rs.getString("Question_Type")),
										AseUtil.nullToBlank(rs.getString("Include")),
										AseUtil.nullToBlank(rs.getString("Required")),
										AseUtil.nullToBlank(rs.getString("Comments")),
										rs.getInt("Len"),
										AseUtil.nullToBlank(rs.getString("counttext")),
										AseUtil.nullToBlank(rs.getString("extra"))
									));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getQuestions\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getQuestions\n" + e.toString());
			return null;
		}

		return CCCM6100Data;
	}

	/*
	 * getCourseFriendlyNameFromSequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 *	@param	qn			int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseFriendlyNameFromSequence(Connection conn,String campus,int seq)throws Exception {


		String sql = "SELECT cm.Question_Friendly "
			+ "FROM tblCourseQuestions cq INNER JOIN "
			+ "CCCM6100 cm ON cq.questionnumber = cm.Question_Number "
			+ "WHERE (cq.campus=?) AND (cq.questionseq > 0) AND (cq.include = 'Y') "
			+ "AND (cm.campus = 'Sys') AND (cm.type = 'Course') AND cq.questionseq=? ";

		String question_friendly = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question_friendly = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getCourseFriendlyNameFromSequence - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCourseFriendlyNameFromSequence - " + e.toString());
		}

		return question_friendly;
	}

	/*
	 * getCampusFriendlyNameFromSequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 *	@param	qn			int
	 *	<p>
	 *	@return String
	 */
	public static String getCampusFriendlyNameFromSequence(Connection conn,String campus,int seq)throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "SELECT cm.Question_Friendly "
			+ "FROM tblCampusQuestions cq INNER JOIN "
			+ "CCCM6100 cm ON cq.questionnumber = cm.Question_Number "
			+ "WHERE (cq.campus=?) AND (cq.questionseq > 0) AND (cq.include = 'Y') "
			+ "AND (cm.campus=?) AND (cm.type='Campus') AND cq.questionseq=? ";

		String question_friendly = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ps.setInt(3,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				question_friendly = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CCCM6100DB: getCampusFriendlyNameFromSequence - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CCCM6100DB: getCampusFriendlyNameFromSequence - " + e.toString());
		}

		return question_friendly;
	}

	/*
	 * OutlineHelpText
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 *	@return String
	 */
	public static String OutlineHelpText(Connection conn) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String rowColor = "";
		int counter = 0;
		int i = 0;
		boolean found = false;

		try{

			StringBuffer buf = new StringBuffer();

			int allCampuses = 0;

			// number of campuses and names
			String campuses = CampusDB.getCampusNames(conn);
			String[] aCampuses = campuses.split(",");

			allCampuses = aCampuses.length;

			// campus to hold data that are included
			String[] aCampus = new String[allCampuses];

			int Question_Number = 0;
			String CCCM6100 = "";
			String Question_Friendly = "";

			String question = "";
			String campus = "";

			// 1) read all questions for courses
			// 2) for each question, find all campuses using it (include=Y)
			// 3) put togeter array for output
			String sql = "SELECT Question_Number, CCCM6100, Question_Friendly FROM CCCM6100 "
					+ "WHERE (campus = 'SYS') AND (type = 'Course') ORDER BY Question_Number";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				// 1) course question
				Question_Number = rs.getInt("Question_Number");
				Question_Friendly = AseUtil.nullToBlank(rs.getString("Question_Friendly"));
				CCCM6100 = AseUtil.nullToBlank(rs.getString("CCCM6100"));

				// clear array
				for (i = 0; i < allCampuses; i++){
					aCampus[i] = "&nbsp;";
				}

				// 2) get questions from campuses
				sql = "SELECT help as question, campus "
						+ "FROM tblCourseQuestions "
						+ "WHERE type='Course' AND include='Y' AND questionnumber=? "
						+ "ORDER BY campus";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,Question_Number);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()){
					question = AseUtil.nullToBlank(rs2.getString("question"));
					campus = AseUtil.nullToBlank(rs2.getString("campus"));

					// place data in the correct campus box
					i = 0;
					found = false;
					while (i < allCampuses && !found){
						if (campus.equals(aCampuses[i])){
							aCampus[i] = question;
							found = true;
						}
						++i;
					}

				}	// while
				rs2.close();
				ps2.close();

				if (counter++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\""+rowColor+"\">"
							+ "<td valign=\"top\"><a href=\"cccmx.jsp?qn="+Question_Number+"\" class=\"linkcolumn\">" + Question_Number + "</a></td>"
							+ "<td valign=\"top\">" + CCCM6100 + "</td>"
							+ "</tr>");

				buf.append("<tr bgcolor=\""+rowColor+"\"><td>&nbsp;</td><td valign=\"top\"><table border=1 cellpadding=4 width=\"100%\">");
				for (i = 0; i < allCampuses; i++){
					if(aCampus[i] != null && aCampus[i].length() > 0 && !aCampus[i].equals("&nbsp;")){
						buf.append("<tr><td width=\"05%\" valign=\"top\">" + aCampuses[i] + "</td><td valign=\"top\">" + aCampus[i] + "</td></tr>");
					}
				} // for i
				buf.append("</table></td></tr>");

			}	// while
			rs.close();
			ps.close();

			temp = "<table border=1 cellpadding=4 width=\"100%\">"
					+ "<tr bgcolor=\"#dbeaf5\">"
					+ "<td valign=\"top\">#</td>"
					+ "<td valign=\"top\">CCCM6100</td>";
			temp += "</tr>" + buf.toString() + "</table>";

		}
		catch(SQLException se ){
			logger.fatal("CCCM6100DB: OutlineHelpText - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("CCCM6100DB: OutlineHelpText - " + ex.toString());
		}

		return temp;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}