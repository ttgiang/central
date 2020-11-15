/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 *	public static int deleteAssessment(Connection connection, String id)
 *	public static Assess getAssessment(Connection connection, int aid)
 *	public static ArrayList getAssessments(Connection connection, String campus)
 *	public static StringBuffer getAssessmentsAsHTMLOptions(Connection connection,String campus)
 *	public static String getAssessmentsAsHTMLOptionsX(Connection connection,String campus)
 *	public static ArrayList getAssessmentsByAlphaNum(Connection connection,String campus,String alpha,String num)
 *	public static StringBuffer getAssessmentsByAlphaNumAsHTML(Connection connection,String campus,String alpha,String num)
 *	public static String getSelectedAssessments(Connection connection,String kix,String compid)
 *	public static String getSelectedAssessments2(Connection connection,String campus,String alpha,String num,String type)
 *	public static boolean hasAssessment(Connection connection,String campus,String alpha,String num,String type,int comp)
 *	public static int insertAssessment(Connection connection, Assess assess)
 *	public static int updateAssessment(Connection connection, Assess assess)
 *
 * @author ttgiang
 */

//
// AssessDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class AssessDB {

	static Logger logger = Logger.getLogger(AssessDB.class.getName());

	public AssessDB() throws Exception {}

	/*
	 * getAssessment
	 * <p>
	 * @param	Connection	connection
	 * @param	int			aid
	 * <p>
	 * @return Assess
	 */
	public static Assess getAssessment(Connection connection, int aid) {

		Assess assess = new Assess();
		String sql = "SELECT assessment,auditby,auditdate,campus FROM tblCourseAssess WHERE assessmentid = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, aid);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				AseUtil aseUtil = new AseUtil();
				assess.setAssessment(resultSet.getString(1).trim());
				assess.setAuditBy(resultSet.getString(2).trim());
				assess.setAuditDate(aseUtil.ASE_FormatDateTime(resultSet.getString(3),Constant.DATE_DATETIME));
				assess.setCampus(resultSet.getString(4).trim());
			}

			resultSet.close();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("AssessDB: getAssessment - " + e.toString());
			return null;
		} catch (Exception ex) {
			logger.fatal("AssessDB: getAssessment - " + ex.toString());
			return null;
		}

		return assess;
	}

	/*
	 * getAssessments
	 * <p>
	 * @param	Connection	connection
	 * @param	String		campus
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getAssessments(Connection connection, String campus) {

		String sql = "SELECT assessmentid,Assessment "
			+ "FROM tblCourseAssess "
			+ "WHERE campus=? "
			+ "ORDER BY Assessment";
		ArrayList<Assess> list = new ArrayList<Assess>();

		try {
			Assess assess;
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				assess = new Assess();
				assess.setId(resultSet.getString(1).trim());
				assess.setAssessment(resultSet.getString(2).trim());
				list.add(assess);
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessments - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getAssessments
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	junk			int
	 *	<p>
	 *	@return String
	 */
	public static String getAssessments(Connection connection,String campus,int junk) {

		String sql = "SELECT Assessment "
			+ "FROM tblCourseAssess "
			+ "WHERE campus=? "
			+ "ORDER BY Assessment";

		StringBuffer buf = new StringBuffer();
		String temp = "";
		boolean found = false;

		try {
			Assess assess;
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				buf.append("<li>" + rs.getString(2).trim() + "</li>");
				found = true;
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessments - " + e.toString());
		}

		if (found){
			temp = "<ul>" + buf.toString() + "</ul>";
		}

		return temp;
	}

	/*
	 * getAssessmentsAsHTMLOptions
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	<p>
	 *	@return StringBuffer
	 */
	public static StringBuffer getAssessmentsAsHTMLOptions(Connection connection,String campus) {

		String sql = "SELECT assessmentid,Assessment FROM tblCourseAssess WHERE campus=? ORDER BY assessmentid";
		StringBuffer buf = new StringBuffer();

		try {

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				buf.append("<option value=\"" + resultSet.getString(1).trim() + "\">" + resultSet.getString(2).trim() + "</option>");
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessmentsAsHTMLOptions - " + e.toString());
			buf = null;
		}

		//logger.info("AccessDB - getAssessmentsAsHTMLOptions");

		return buf;
	}

	/*
	 * getAssessmentsAsHTMLOptionsX
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	<p>
	 *	@return String
	 */
	public static String getAssessmentsAsHTMLOptionsX(Connection connection,String campus) {

		String sql = "SELECT assessmentid,Assessment FROM tblCourseAssess WHERE campus=? ORDER BY assessmentid";
		StringBuffer buf = new StringBuffer();
		String temp = "";

		boolean found = false;

		try {

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				buf.append("<tr><td valign=\"top\"><input type=\"radio\" name=\"assessGroup\" value=\"" + resultSet.getInt(1) + "\"></td>" +
					"<td>&nbsp;&nbsp;</td>" +
					"<td valign=\"top\">" + resultSet.getString(2).trim() + "<br/><br/></td></tr>");
				found = true;
			}
			resultSet.close();
			preparedStatement.close();

			temp = buf.toString();

		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessmentsAsHTMLOptionsX - " + e.toString());
			buf = null;
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + temp + "</table>";

		//logger.info("AccessDB - getAssessmentsAsHTMLOptionsX");

		return temp;
	}

	/*
	 * getAssessmentsByAlphaNum
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getAssessmentsByAlphaNum(Connection connection,
																	String campus,
																	String alpha,
																	String num) {

		ArrayList<Assess> list = new ArrayList<Assess>();

		try {
			Assess assess;
			String sql = "SELECT assessmentid,assessment "
				+ "FROM vw_Assessments "
				+ "WHERE campus=? AND "
				+ "coursealpha=? AND "
				+ "coursenum=? "
				+ "ORDER BY assessmentid";

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				assess = new Assess();
				assess.setId(resultSet.getString(1).trim());
				assess.setAssessment(resultSet.getString(2).trim());
				list.add(assess);
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessmentsByAlphaNum - " + e.toString());
			list = null;
		}

		//logger.info("AccessDB - getAssessmentsByAlphaNum - " + alpha + " - " + num);

		return list;
	}

	/*
	 * getAssessmentsByAlphaNumAsHTML
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	<p>
	 *	@return StringBuffer
	 */
	public static StringBuffer getAssessmentsByAlphaNumAsHTML(Connection connection,
																				String campus,
																				String alpha,
																				String num) {

		StringBuffer buf = new StringBuffer();
		String alphanum = alpha + "_" + num;
		String temp = "";

		try {
			String sql = "SELECT assessmentid,assessment FROM vw_Assessments WHERE campus=? AND coursealpha=? AND coursenum=? ORDER BY assessmentid";

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				temp = resultSet.getString(1).trim() + "_" + alphanum;
				buf.append("<option value=\"" + temp + "\">" + resultSet.getString(2).trim() + "</option>");
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getAssessmentsByAlphaNumAsHTML - " + e.toString());
			buf = null;
		}

		//logger.info("AccessDB - getAssessmentsByAlphaNumAsHTML - " + alpha + " - " + num);

		return buf;
	}

	/*
	 * insertAssessment <p> @return int
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	Assess		assess
	 *	<p>
	 *	@return	int
	 */
	public static int insertAssessment(Connection connection, Assess assess) {
		int rowsAffected = 0;
		String sql = "INSERT INTO tblCourseAssess (assessment,campus,auditby) VALUES (?,?,?)";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, assess.getAssessment());
			preparedStatement.setString(2, assess.getCampus());
			preparedStatement.setString(3, assess.getAuditBy());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("AssessDB: insertAssessment - " + e.toString());
			return 0;
		}

		//logger.info("AccessDB - getAssessmentsByAlphaNumAsHTML - " + rowsAffected + " row");

		return rowsAffected;
	}

	/*
	 * deleteAssessment
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		id
	 *	<p>
	 *	@return	int
	 */
	public static int deleteAssessment(Connection connection, String id) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblCourseAssess WHERE assessmentid = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, id);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("AssessDB: deleteAssessment - " + e.toString());
			return 0;
		}

		//logger.info("AccessDB - deleteAssessment - " + rowsAffected + " row");

		return rowsAffected;
	}

	/*
	 * updateAssessment
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	Assess		assess
	 *	<p>
	 *	@return	int
	 */
	public static int updateAssessment(Connection connection, Assess assess) {
		int rowsAffected = 0;
		String sql = "UPDATE tblCourseAssess SET assessment=?,auditby=?,auditdate=? WHERE assessmentid =?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, assess.getAssessment());
			preparedStatement.setString(2, assess.getAuditBy());
			preparedStatement.setString(3, assess.getAuditDate());
			preparedStatement.setString(4, assess.getId());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("AssessDB: updateAssessment - " + e.toString());
			return 0;
		}

		//logger.info("AccessDB - updateAssessment - " + rowsAffected + " row");

		return rowsAffected;
	}

	/*
	 * getSelectedAssessments are assessments linked to outline competencies <p>
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String 		kix
	 *	@param	String 		compid
	 *	<p>
	 * @return String
	 */
	public static String getSelectedAssessments(Connection connection,
																String kix,
																String compid) throws Exception {

		String sql = "SELECT assessmentid "
			+ "FROM tblCourseCompAss "
			+ "WHERE historyid=? AND compid=?";
		String selected = null;
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,kix);
			preparedStatement.setString(2,compid);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				if (selected == null)
					selected = resultSet.getString(1);
				else
					selected = selected + "," + resultSet.getString(1);
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getSelectedAssessments - " + e.toString());
			selected = null;
		}

		//logger.info("AccessDB - getSelectedAssessments - " + selected);

		return selected;
	}

	/*
	 * getSelectedAssessments2 are assessments linked to outline competencies using a view
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String 		campus
	 *	@param	String 		alpha
	 *	@param	String 		num
	 *	@param	String 		type
	 *	<p>
	 * @return String
	 */
	public static String getSelectedAssessments2(Connection connection,
																String campus,
																String alpha,
																String num,
																String type) throws Exception {

		String temp = "";
		String comp = "";
		String assess = "";
		String sql = "SELECT comp,assessment FROM vw_ACCJC_2 WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
		StringBuffer content = new StringBuffer();

		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			ResultSet results = preparedStatement.executeQuery();
			content.append("<table border=\"0\" cellspacing=\"10\" width=\"60%\">");
			content.append("<tr class=\"textblackTH\"><td valign=\"top\">Competency</td><td valign=\"top\">Assessment Method</td></tr>");
			while (results.next()) {
				comp = results.getString(1);
				assess = results.getString(2);
				content.append("<tr class=\"datacolumn\"><td valign=\"top\">"
						+ comp + "</td><td valign=\"top\">" + assess
						+ "</td></tr>");
			}
			content.append("</table>");
			temp = content.toString();

			results.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: getSelectedAssessments2 - " + e.toString());
		}

		//logger.info("AccessDB - getSelectedAssessments2 - " + alpha + " - " + num);

		return temp;
	}

	/*
	 * hasAssessment
	 * <p>
	 *	whether there are assessments tied to this SLO/Comp
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String 		campus
	 *	@param	String 		alpha
	 *	@param	String 		num
	 *	@param	String 		type
	 * @param	int			comp
	 * <p>
	 *	@return boolean
	 */
	public static boolean hasAssessment(Connection connection,
														String campus,
														String alpha,
														String num,
														String type,
														int comp) throws Exception {

		boolean hasData = false;
		String sql = "SELECT count(compid) "
			+ "FROM tblCourseCompAss "
			+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND compid=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			preparedStatement.setInt(5, comp);
			ResultSet rs = preparedStatement.executeQuery();
			if (rs.next() && rs.getInt(1) > 0 )
				hasData = true;
			rs.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("AssessDB: hasAssessment - " + e.toString());
			hasData = false;
		}

		//logger.info("AccessDB - hasAssessment - " + alpha + " - " + num);

		return hasData;
	}

	/*
	 * isDeletable - delete only available if not already attached to anything
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	int			lid
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isDeletable(Connection connection,int lid) {

		boolean deletable = false;
		int counter = 0;

		try {
			String sql = "SELECT count(historyid) AS counter " +
				"FROM tblCourseCompAss " +
				"WHERE assessmentid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,lid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				counter = rs.getInt("counter");
			}
			rs.close();
			ps.close();

			if (counter==0)
				deletable = true;
		} catch (SQLException e) {
			logger.fatal("AssessDB: isDeletable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("AssessDB: isDeletable - " + ex.toString());
		}

		return deletable;
	}

	public void close() throws SQLException {}

}