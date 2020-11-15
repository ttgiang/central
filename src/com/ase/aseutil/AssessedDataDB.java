/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static String[] getAssessedData(Connection connection, int aid)
 *	public static Vector getAssessedDataVector(Connection connection, int aid)
 *	public static Vector getAssessedQuestions(Connection connection,String campus)
 *	public static String[] getAssessedQuestionsX(Connection connection,String campus)
 *	public static String incompleteAssessment(Connection conn,String campus,int idx)
 *	public static int insertAssessedData(int,String,String,String,String,String)
 *	public static String listAssessment(Connection conn,String kix,String user)
 *	public static String setupAssessment(Connection conn,String campus,String user)
 *	public static Msg updateAssessedQuestions(Connection,String,String,String,int,String,Vector,int)
 */

//
// AssessedDataDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import org.apache.log4j.Logger;

public class AssessedDataDB {

	static Logger logger = Logger.getLogger(AssessedDataDB.class.getName());

	public AssessedDataDB() throws Exception {}

	/*
	 * getAssessedData
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getAssessedData(Connection connection, int aid) {

		int counter = 30;
		int i = 0;
		String[] assess = new String[counter];
		String sql = "SELECT question,approvedby,approveddate FROM tblAssessedData WHERE accjcid=? ORDER BY qid";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, aid);
			ResultSet results = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (results.next()) {
				assess[i++] = AseUtil.nullToBlank(results.getString("question"));
				assess[i++] = AseUtil.nullToBlank(results.getString("approvedby"));
				assess[i++] = aseUtil.ASE_FormatDateTime(results.getString("approveddate"),Constant.DATE_DATETIME);
			}

			// nothing found
			if (i==0)
				assess[0] = null;

			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: getAssessedData\n" + e.toString());
			return null;
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: getAssessedData\n" + ex.toString());
			return null;
		}

		return assess;
	}

	/*
	 * getAssessedDataVector
	 *	<p>
	 *	@return Vector
	 */
	public static Vector getAssessedDataVector(Connection connection, int aid) {

		boolean found = false;
		Vector<AssessedData> vector = new Vector<AssessedData>();
		String sql = "SELECT question,approvedby,approveddate " +
			"FROM tblAssessedData WHERE accjcid=? ORDER BY qid";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, aid);
			ResultSet results = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (results.next()) {
				AssessedData ad = new AssessedData();
				ad.setQuestion(AseUtil.nullToBlank(results.getString("question")));
				ad.setApprovedBy(AseUtil.nullToBlank(results.getString("approvedby")));
				ad.setApprovedDate(aseUtil.ASE_FormatDateTime(results.getString("approveddate"),Constant.DATE_DATETIME));
				vector.addElement(ad);
				found = true;
			}

			if (!found)
				vector = null;

			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: getAssessedDataVector\n" + e.toString());
			return null;
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: getAssessedDataVector\n" + ex.toString());
			return null;
		}

		return vector;
	}

	/*
	 * getAssessedQuestions
	 *	<p>
	 *	@return Vector
	 */
	public static Vector getAssessedQuestions(Connection connection,String campus) {

		Vector<String> vector = new Vector<String>();

		String sql = "SELECT question FROM tblAssessedQuestions WHERE campus=? ORDER BY questionseq";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			ResultSet results = preparedStatement.executeQuery();

			while (results.next()) {
				vector.addElement(new String(AseUtil.nullToBlank(results.getString("question"))));
			}

			results.close();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: getAssessedQuestions\n" + e.toString());
			return null;
		}

		return vector;
	}

	/*
	 * getAssessedQuestionsX
	 *	<p>
	 *	@param Connection		connection
	 *	@param String			campus
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getAssessedQuestionsX(Connection connection,String campus) {

		String sql = "SELECT question FROM tblAssessedQuestions " +
			"WHERE campus=? " +
			"ORDER BY questionseq";
		String[] questions = new String[10];
		int i = 0;
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				questions[i++] = AseUtil.nullToBlank(rs.getString("question"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: getAssessedQuestionsX\n" + e.toString());
			return null;
		}

		return questions;
	}

	/*
	 * updateAssessedQuestions
	 *	<p>
	 *	Vector contains answer, check, answer, check, etc. There is a check, or not, after each answer
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		user
	 *	@param	String		kix,
	 *	@param	int			lid
	 *	@param	String		mode
	 *	@param	Vector		vector
	 *	@param	int			controlsToShow
	 *	@param	String		action
	 *	<p>
	 *	@return Msg
	 */
	public static Msg updateAssessedQuestions(Connection conn,
															String user,
															String kix,
															int lid,
															String mode,
															Vector vector,
															int controlsToShow,
															String action) {

		Msg msg = new Msg();
		int rowsAffected = 0;
		int i = 0;
		int maxItems = 10;
		String answers;
		String chk;
		String sql = "";
		String sql1 = "";
		String sql2 = "";
		String sql3 = "";
		PreparedStatement ps;
		boolean allApproved = true;

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String campus = info[4];

		boolean isApprover = DistributionDB.hasMember(conn,campus,"SLOApprover",user);

		if (mode.equals("u")){
			sql1 = "UPDATE tblAssessedData SET question=?,auditby=?,auditdate=? WHERE accjcid=? AND qid=?";
			sql2 = "UPDATE tblAssessedData SET question=?,auditby=?,auditdate=?,approvedby=?,approveddate=? WHERE accjcid=? AND qid=?";
		}
		else{
			sql1 = "INSERT INTO tblAssessedData (accjcid,campus,coursealpha,coursenum,coursetype,qid,question,auditby,approvedby,approveddate) VALUES(?,?,?,?,?,?,?,?,?,?)";
			sql2 = "INSERT INTO tblAssessedData (accjcid,campus,coursealpha,coursenum,coursetype,qid,approvedby,approveddate) VALUES(?,?,?,?,?,?,?,?)";
		}

		try {
			if (vector != null){

				/*
					chk is either on, off or 1. On when selection made; off is obvious. 1 is already
					selected and approved. when 1, no more updating
				*/
				if (mode.equals("u")){
					i = 1;
					for (Enumeration em = vector.elements(); em.hasMoreElements();){
						answers = (String)em.nextElement();
						chk = (String)em.nextElement();

						if (!"1".equals(chk)){
							sql = sql1;
							if ("on".equals(chk)){
								sql = sql2;
							}

							ps = conn.prepareStatement(sql);
							ps.setString(1,answers);
							ps.setString(2,user);
							ps.setString(3,AseUtil.getCurrentDateTimeString());

							if ("on".equals(chk)){
								ps.setString(4,user);
								ps.setString(5,AseUtil.getCurrentDateTimeString());
								ps.setInt(6,lid);
								ps.setInt(7,i);
							}
							else{
								ps.setInt(4,lid);
								ps.setInt(5,i);
								allApproved = false;
							}

							rowsAffected = ps.executeUpdate();
							ps.close();
						}	// if != 1

						++i;
					}	// for
				}
				else{
					i = 1;
					for (Enumeration en = vector.elements(); en.hasMoreElements();){
						answers = (String)en.nextElement();
						chk = (String)en.nextElement();

						/*
							for add mode, update audit stamp when there is an answer. If not,
							add a place holder for later use in update.

							although it doesn't make sense, we'll leave the check for chk = on
							when the answer is empty. in case it's ok to leave empty.
						*/
						if ("".equals(answers)){
							ps = conn.prepareStatement(sql2);

							ps.setInt(1,lid);
							ps.setString(2,campus);
							ps.setString(3,alpha);
							ps.setString(4,num);
							ps.setString(5,type);
							ps.setInt(6,i);

							if ("on".equals(chk)){
								ps.setString(7,user);
								ps.setString(8,AseUtil.getCurrentDateTimeString());
							}
							else{
								ps.setString(7,"");
								ps.setString(8,null);
								allApproved = false;
							}
						}
						else{
							ps = conn.prepareStatement(sql1);
							ps.setInt(1,lid);
							ps.setString(2,campus);
							ps.setString(3,alpha);
							ps.setString(4,num);
							ps.setString(5,type);
							ps.setInt(6,i);
							ps.setString(7,answers);
							ps.setString(8,user);

							if (chk.equals("on")){
								ps.setString(9,user);
								ps.setString(10,AseUtil.getCurrentDateTimeString());
							}
							else{
								ps.setString(9,"");
								ps.setString(10,null);
								allApproved = false;
							}
						}	// else not empty answers

						rowsAffected = ps.executeUpdate();
						ps.close();

						++i;
					}	// for
				}	// if-else

				/*
					when all check marks have been set to ON (approved), set the date assessed and by whom
				*/
				if (allApproved && controlsToShow==Constant.SLO_QUESTION_COUNT){
					CourseACCJCDB.setCompletedAssessedTime(conn,user,lid);
				}

				// when approved by approver, remove tasks and send mail
				if ("as".equals(action) && isApprover){
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Approve SLO",campus,"","REMOVE",type);
					logger.info("AssessedDataDB - updateAssessedQuestions - delete approver task (" + user + ") - rowsAffected " + rowsAffected);

					String getAssesser = SLODB.getAssesser(conn,campus,alpha,num);

					rowsAffected = TaskDB.logTask(conn,getAssesser,getAssesser,alpha,num,"SLO Assessment",campus,"","ADD",type);
					logger.info("AssessedDataDB - updateAssessedQuestions - add assessment task (" + user + ") - rowsAffected " + rowsAffected);

					MailerDB mailerDB = new MailerDB(conn,user,getAssesser,"","",alpha,num,campus,"emailSLOApprovalCompleted",kix,user);
				}

				// audit stamp "as" is approver's save and approval of assessment
				if ("as".equals(action) && isApprover){
					sql = "UPDATE tblSLO SET auditdate=?,progress=? WHERE hid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,"APPROVED");
					ps.setString(3,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					sql = "UPDATE tblCourseACCJC SET approveddate=?,auditby=? WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,"APPROVED");
					ps.setString(3,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
				else{
					sql = "UPDATE tblSLO SET auditdate=? WHERE hid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}

				logger.info(kix + " - AssessedDataDB: updateAssessedQuestions - " + user);

				msg.setMsg("");
			}	// if vector != null
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: updateAssessedQuestions\n" + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: updateAssessedQuestions\n" + ex.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/*
	 * incompleteAssessment		display assesments are have not been completed
	 *	<p>
	 *	@param	Connection
	 *	@param	String
	 *	@param	int
	 *	<p>
	 *	@return String
	 */
	public static String incompleteAssessment(Connection conn,String campus,int idx) {

		String alpha = "";
		String num = "";
		String title = "";
		String link = "";
		String kix = "";
		StringBuffer output = new StringBuffer();
		String outlines = "";
		boolean found = false;
		String rowColor = "";
		int j = 0;

		String sql = "SELECT distinct coursealpha,coursenum " +
			"FROM vw_Incomplete_Assessment_6 " +
			"WHERE Campus=? ";

		if (idx>0)
			sql += "AND  coursealpha like '" + (char)idx + "%' ";

		sql += "ORDER BY coursealpha,coursenum";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet results = ps.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (results.next()) {
				found = true;
				alpha = AseUtil.nullToBlank(results.getString("coursealpha")).trim();
				num = AseUtil.nullToBlank(results.getString("coursenum")).trim();
				title = CourseDB.getCourseDescription(conn,alpha,num,campus);
				link = "vwcrsslo.jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&type=PRE";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				output.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"datacolumn\"><a href=\"" + link + "\" class=\"linkcolumn\">" +
										alpha + " " + num + "</a></td><td class=\"datacolumn\">" +
										title + "</td></tr>");
			}
			results.close();
			ps.close();

			if (found){
				outlines = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"e1e1e1\"><td class=\"textblackth\" width=\"15%\">Alpha</td><td class=\"textblackth\">Title</td></tr>" +
					output.toString() +
					"</table>";
			}
			else{
				outlines = "<p>Outlines not found</p>";
			}

		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: incompleteAssessment\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: incompleteAssessment\n" + ex.toString());
		}

		return outlines;
	}

	/*
	 * insertAssessedData		insert an assessed data entry
	 *	<p>
	 *	@param	Connection
	 *	@param	int
	 *	@param	String
	 *	@param	String
	 *	@param	String
	 *	@param	String
	 *	@param	String
	 *	<p>
	 *	@return int
	 */
	public static int insertAssessedData(int accjcid,
													String campus,
													String alpha,
													String num,
													String type,
													String user) {
		int qid = 1;
		int rows = 0;
		int totalQuestions = 0;
		String sql = "";

		try {
			PreparedStatement ps = null;

			AsePool asePool = AsePool.getInstance();
			AseUtil aseUtil = new AseUtil();
			Connection conn = asePool.getConnection();

			/*
				write a record for every question in use. Start by getting the number of questions. If the totalQuestions
				is greater than 0, we have a valid reason to write records
			*/
			sql = "SELECT Count(campus) AS CountOfcampus FROM tblAssessedQuestions GROUP BY campus HAVING campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				totalQuestions = results.getInt(1);
			}
			ps.close();

			if (totalQuestions>0){
				conn.setAutoCommit(false);

				sql = "INSERT INTO tblAssessedData (accjcid,campus,coursealpha,coursenum,coursetype,qid,auditby) VALUES(?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);

				for(int i=0;i<totalQuestions;i++){
					ps.setInt(1, accjcid);
					ps.setString(2, campus);
					ps.setString(3, alpha);
					ps.setString(4, num);
					ps.setString(5, type);
					ps.setInt(6, i+1);
					ps.setString(7, user);
					rows = ps.executeUpdate();
				}
				ps.close();
				conn.setAutoCommit(true);
				AseUtil.loggerInfo("SLODB: createAssessedDataEntries",campus,user,rows + " entries","");
			}
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: insertAssessedData\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: insertAssessedData\n" + ex.toString());
		}

		return rows;
	}

	/*
	 * listAssessment		list assessments for SLO
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		kix
	 *	@param	String		user
	 *	<p>
	 *	@return Msg
	 */
	public static Msg listAssessment(Connection conn,String kix,String user) {

		StringBuffer output = new StringBuffer();
		String outlines = "";
		String id = "";
		String comp = "";
		String AssessedBy = "";
		String AssessedDate = "";

		int rowsAffected = 0;

		String campus = "";
		String alpha = "";
		String num = "";
		String type = "";

		if (!"".equals(kix)){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];
		}

		String headerClass = "class=\'" + campus + "BGColor\'";
		String oddClass = "class=\'" + campus + "BGColorRow\' bgcolor=\'#FFFFFF\'";
		String evenClass = "class=\'" + campus + "BGColorRow\' bgcolor=\'#e1e1e1\'";
		String tableClass = "class=\'" + campus + "BGColor\' width=\'100%\' cellspacing=\'1\' cellpadding=\'2\' border=\'0\'";
		String rowClass = "";

		int rowCounter = 0;
		boolean found = false;
		Msg msg = new Msg();

		try {
			AseUtil aseUtil = new AseUtil();

			/*
				when called, determine if assessment has already started.
			*/
			if (!SLODB.doesSLOExist(conn,campus,alpha,num)){
				SLO slo = new SLO(campus,alpha,num,"ASSESS",user,kix);
				rowsAffected = SLODB.updateSLO(conn,slo);
				rowsAffected = SLODB.createACCJCEntries(conn,campus,alpha,num,user);
			}

			String sql = "SELECT id,Comp,AssessedBy,AssessedDate " +
				"FROM vw_SLO " +
				"WHERE Campus=? AND CourseAlpha=? AND CourseNum=? AND CourseType=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = aseUtil.nullToBlank(rs.getString("id")).trim();
				comp = aseUtil.nullToBlank(rs.getString("Comp")).trim();

				AssessedBy = aseUtil.nullToBlank(rs.getString("AssessedBy"));
				if ("".equals(AssessedBy))
					AssessedBy = "&nbsp;";

				AssessedDate = aseUtil.ASE_FormatDateTime(rs.getString("AssessedDate"),Constant.DATE_DATETIME);
				if ("".equals(AssessedDate))
					AssessedDate = "&nbsp;";

				if ((rowCounter++ % 2) == 0)
					rowClass = oddClass;
				else
					rowClass = evenClass;

				output.append("<tr height=\"30\" " + rowClass + ">" +
					"<td valign=\"top\" width=\"5%\"><a href=\"sloedt.jsp?kix=" + kix + "&lid=" + id + "\" class=\"linkcolumn\">" + rowCounter + "</a></td>" +
					"<td valign=\"top\" width=\"60%\">" + comp + "</td>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				outlines = "<table " + tableClass + ">" +
					"<tr " + headerClass + "><td>#</td><td>Competency</td>" +
					output.toString() +
					"</table>";

				msg.setCode(0);
			}
			else{
				msg.setCode(-1);
				outlines = "<p>SLOs do not exist for this operation.<br/>";
			}

		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: listAssessment\n" + e.toString());
			msg.setCode(-1);
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: listAssessment\n" + ex.toString());
			msg.setCode(-1);
			msg.setErrorLog(ex.toString());
		}

		msg.setErrorLog(outlines);

		return msg;
	}

	/*
	 * setupAssessment		when selected for the first time to assess SLOs, create all defaults
	 *								as ASSESS for all the user's modified outlines
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		campus
	 *	@param	String		type
	 *	@param	String		user
	 *	<p>
	 *	@return int
	 */
	public static int setupAssessment(Connection conn,String campus,String type,String user) {

		int rows = 0;
		int rowsAffected = 0;
		Msg msg = new Msg();

		String alpha = "";
		String num = "";
		String kix = "";

		try {
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT campus,coursealpha,coursenum,coursetype,proposer " +
				"FROM tblCourse WHERE campus=? AND coursetype=? AND proposer=? AND progress=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, type);
			ps.setString(3, user);
			ps.setString(4, "MODIFY");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				type = aseUtil.nullToBlank(rs.getString("coursetype"));

				if (!SLODB.isMatch(conn,campus,alpha,num,"ASSESS")){
					kix = Helper.getKix(conn,campus,alpha,num,"PRE");
					rowsAffected = SLODB.insertSLO(conn,campus,alpha,num,user,"ASSESS",kix);
					rowsAffected = SLODB.createACCJCEntries(conn,campus,alpha,num,user);
					++rows;
				}
			}
			rs.close();
			ps.close();
			AseUtil.loggerInfo("AssessedDataDB: setupAssessment",campus,user,rows + " entries","");
		} catch (SQLException e) {
			logger.fatal("AssessedDataDB: setupAssessment\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessedDataDB: setupAssessment\n" + ex.toString());
		}

		return rows;
	}

	public void close() throws SQLException {}

}