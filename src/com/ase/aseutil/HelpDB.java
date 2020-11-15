/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteHelp(Connection connection, String id) {
 * public static Help getHelp(Connection conn, int id)
 *	public static Help getHelpByCategoryPage(Connection conn,String campus,String category,String page) {
 *	public static String getPageHelp(Connection conn,String pageName,String campus) {
 *	public static boolean isMatch(Connection connection, String category) throws SQLException {
 *	public static int updateHelp(Connection connection, Help help) {
 *
 * @author ttgiang
 */

//
// HelpDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

public class HelpDB {

	static String deleteSQL;
	static String insertSQL;
	static String updateSQL;
	static String deleteSQLContent;
	static String insertSQLContent;
	static String updateSQLContent;

	static Logger logger = Logger.getLogger(HelpDB.class.getName());

	public HelpDB() throws Exception {}

	/*
	 * isMatch
	 * <p>
	 *	@param	connection	Connection
	 *	@param	category		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection connection, String category) throws SQLException {

		String query = "SELECT category FROM tblHelpIdx "
				+ "WHERE category = '" + SQLUtil.encode(category) + "'";
		Statement statement = connection.createStatement();
		ResultSet results = statement.executeQuery(query);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/*
	 * isMatch
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	category	String
	 *	@param	title		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String category,String title) throws SQLException {

		String sql = "SELECT category FROM tblHelpIdx WHERE campus=? AND category=? AND title=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,category);
		ps.setString(3,title);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatchingContent
	 * <p>
	 *	@param	conn	Connection
	 *	@param	id		int
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMatchingContent(Connection conn,int id) throws SQLException {

		String sql = "SELECT id FROM tblHelp WHERE id=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1,id);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * insertHelp
	 * <p>
	 *	@param	connection	Connection
	 *	@param	help		Help
	 * <p>
	 *	@return int
	 */
	public static int insertHelp(Connection connection, Help help) {
		int rowsAffected = 0;
		insertSQL = "INSERT INTO tblHelpIdx (category,title,subtitle,auditby,campus) VALUES (?,?,?,?,?)";
		insertSQLContent = "INSERT INTO tblHelp (id, content) VALUES (?,?)";

		try {
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, help.getCategory());
			ps.setString(2, help.getTitle());
			ps.setString(3, help.getSubTitle());
			ps.setString(4, help.getAuditBy());
			ps.setString(5, help.getCampus());
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (rowsAffected == 1) {
				com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();
				int maxId = aseUtil.dbMaxValue(connection, "tblHelpidx", "id");
				ps = connection.prepareStatement(insertSQLContent);
				ps.setInt(1,maxId);
				ps.setString(2,help.getContent());
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (Exception e) {
			logger.fatal("HelpDB - insertHelp: " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * insertHelp
	 * <p>
	 *	@param	connection	Connection
	 *	@param	id				String
	 * <p>
	 *	@return int
	 */
	public static int deleteHelp(Connection connection, String id) {
		int rowsAffected = 0;
		deleteSQL = "DELETE FROM tblHelpIdx WHERE id = ?";
		deleteSQLContent = "DELETE FROM tblHelp WHERE id = ?";

		try {
			PreparedStatement ps = connection.prepareStatement(deleteSQL);
			ps.setString(1, id);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (rowsAffected == 1) {
				ps = connection.prepareStatement(deleteSQLContent);
				ps.setString(1, id);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("HelpDB - deleteHelp: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * updateHelp
	 * <p>
	 *	@param	conn	Connection
	 *	@param	help	Help
	 * <p>
	 *	@return int
	 */
	public static int updateHelp(Connection conn, Help help) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		try {

			int id = NumericUtil.getInt(help.getId(),0);

			String sql = "UPDATE tblHelpIdx SET category=?,title=?,subtitle=?,auditby=?,auditdate=?,campus=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, help.getCategory());
			ps.setString(2, help.getTitle());
			ps.setString(3, help.getSubTitle());
			ps.setString(4, help.getAuditBy());
			ps.setString(5, help.getAuditDate());
			ps.setString(6, help.getCampus());
			ps.setString(7, help.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (rowsAffected == 1) {
				if(HelpDB.isMatchingContent(conn,id)){
					sql = "UPDATE tblHelp SET content=? WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, help.getContent());
					ps.setString(2, help.getId());
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
				else{
					sql = "INSERT INTO tblHelp (id,content) VALUES(?,?)";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,id);
					ps.setString(2,help.getContent());
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}
		} catch (SQLException e) {
			logger.fatal("HelpDB - updateHelp: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * getHelp
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return Help
	 */
	public static Help getHelp(Connection conn, int id) {
		Help help = new Help();

		try {
			String sql = "SELECT h.id,category,title,subtitle,content,auditby,auditdate,campus "
				+ "FROM tblHelpidx hi,tblHelp h "
				+ "WHERE h.id=? AND "
				+ "h.id=hi.id";

			sql = "SELECT hi.id, hi.campus, hi.category, hi.title, hi.subtitle, hi.auditby, hi.auditdate, h.[content] "
					+ "FROM tblHelp h "
					+ "RIGHT OUTER JOIN tblHelpidx hi "
					+ "ON h.id = hi.id "
					+ "WHERE hi.id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				help.setId(AseUtil.nullToBlank(rs.getString("id")));
				help.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				help.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				help.setSubTitle(AseUtil.nullToBlank(rs.getString("subtitle")));
				help.setContent(AseUtil.nullToBlank(rs.getString("content")));
				help.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				help.setAuditDate(AseUtil.nullToBlank(rs.getString("auditdate")));
				help.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("HelpDB: getHelp\n" + e.toString());
			help = null;
		}

		return help;
	}

	/*
	 * getPageHelp	- returns the name of the help file (if any) for a particular page
	 * <p>
	 * @param	conn		Connection
	 * @param	pageName	String
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public static String getPageHelp(Connection conn,String pageName,String campus) {

		String fileName = "";

		try {
			String sql = "SELECT filename "
						+ "FROM tblPageHelp "
						+ "WHERE page=? "
						+ "AND campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,pageName);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				fileName = AseUtil.nullToBlank(rs.getString("filename"));
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("HelpDB: getPageHelp - " + se.toString());
		} catch (Exception e) {
			logger.fatal("HelpDB: getPageHelp - " + e.toString());
		}

		return fileName;
	}

	/*
	 * getHelpByPage
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	pageName	String
	 * <p>
	 * @return Help
	 */
	public static Help getHelpByCategoryPage(Connection conn,String campus,String category,String page) {

		Help help = null;

		try {
			String sql = "SELECT h.id,category,title,subtitle,content,auditby,auditdate "
							+ "FROM tblHelpidx INNER JOIN tblHelp h ON tblHelpidx.id = h.id "
							+ "WHERE tblHelpidx.campus=? AND tblHelpidx.category=? AND tblHelpidx.subtitle=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,page);
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
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HelpDB: getHelpByPage - " + e.toString());
		} catch (Exception e) {
			logger.fatal("HelpDB: getHelpByPage - " + e.toString());
		}

		return help;
	}

	/*
	 * showHelpText
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return	String
	 */
	public static String showHelpText(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try {
			String sql = "SELECT questionseq,question,help FROM tblCoursequestions WHERE campus=? AND include='Y' ORDER BY questionseq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int questionseq = rs.getInt("questionseq");
				String question = AseUtil.nullToBlank(rs.getString("question"));
				String help = AseUtil.nullToBlank(rs.getString("help"));

				buf.append("<tr><td valign=\"top\" width=\"04%\" class=\"textblackth\">" + questionseq
								+ ".</td><td valign=\"top\" width=\"96%\" class=\"textblackth\">" + question
								+ "</td></tr>"
								+ "<tr><td width=\"04%\">&nbsp;</td><td valign=\"top\" width=\"96%\" class=\"datacolumn\">"
								+ help + "</td></tr>");
			}

			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("showHelpText - " + se.toString());
		} catch (Exception e) {
			logger.fatal("showHelpText - " + e.toString());
		}

		return "<table width=\"96%\" border=\"0\">"
				+ buf.toString()
				+ "</table>";

	} // showHelpText

	/*
	 * getHelpAnnouncements - returns announcements available for the current page
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	pageName	String
	 * <p>
	 * @return String
	 */
	public static String getHelpAnnouncements(Connection conn,String campus,String category,String page) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String rtn = "";

		try {
			if(page != null && page.length() > 0){

				boolean found = false;

				String sql = "SELECT h.id,category,title,subtitle,content,auditby,auditdate "
						+ "FROM tblHelpidx INNER JOIN tblHelp h ON tblHelpidx.id = h.id "
						+ "WHERE tblHelpidx.campus=? AND tblHelpidx.category=? AND tblHelpidx.subtitle like ? "
						+ "ORDER BY title ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,category);
				ps.setString(3,page+"%");

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					String title = AseUtil.nullToBlank(rs.getString("title"));
					String content = AseUtil.nullToBlank(rs.getString("content"));
					buf.append("<li><a href=\"/centraldocs/docs/faq/"+content+"\" class=\"linkcolumn\" target=\"_blank\">"+title+"</a></li>");
					found = true;
				}
				rs.close();
				ps.close();

				if(found){
					rtn = "<ul>" + buf.toString() + "</ul>";
				}
			} // page

		} catch (SQLException e) {
			logger.fatal("HelpDB.getHelpAnnouncements ("+category+"/"+page+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("HelpDB.getHelpAnnouncements ("+category+"/"+page+"): " + e.toString());
		}

		return rtn;

	}

	/*
	 * getHelpPages
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	categroy	String
	 *	<p>
	 *	@return String
	 */
	public static String getHelpPages(Connection conn,String campus,String category) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{

			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"hlpidx\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">Category</th>"
				+ "<th align=\"left\">Title</th>"
				+ "<th align=\"left\">Sub Title</th>"
				+ "<th align=\"left\">Audit By</th>"
				+ "<th align=\"left\">Audit Date</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			String sql = "SELECT id,category,title,subtitle,auditby,auditdate "
							+ "FROM tblHelpidx WHERE (campus='SYS' OR campus=?) AND category=? ORDER BY category,title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);

			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				category = AseUtil.nullToBlank(rs.getString("category"));
				int id = rs.getInt("id");
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String subtitle = AseUtil.nullToBlank(rs.getString("subtitle"));
				String auditby = AseUtil.nullToBlank(rs.getString("auditby"));
				String auditdate = aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME);

				buf.append("<tr>"
					+ "<td align=\"left\"><a href=\"hlp.jsp?lid="+id+"\" class=\"linkcolumn\">" + category + "</a></td>"
					+ "<td align=\"left\">" + title + "</td>"
					+ "<td align=\"left\">" + subtitle + "</td>"
					+ "<td align=\"left\">" + auditby + "</td>"
					+ "<td align=\"left\">" + auditdate + "</td>"
					+ "</tr>");
			}
			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException e){
			logger.fatal("HelpDB - getHelpPages: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("HelpDB - getHelpPages: " + e.toString());
		}

		return buf.toString() + "</tbody></table></div></div>";
	}

	/*
	 * close
	 */
	public void close() throws SQLException {	}

}