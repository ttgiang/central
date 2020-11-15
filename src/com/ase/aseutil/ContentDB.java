/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static Msg addRemoveCourseContent(Connection connection,String action,String campus,String alpha,String num,String user,
 *														String descr,String content,int reqID,String kix)
 *	public static int deleteContents(Connection conn,String campus,String kix) {
 * public static String getContentAsHTMLList(Connection connection,String alpha,String num,String campus,String type,
 *					String hid,boolean detail,boolean includeAssessment)
 *	public static Content getContentByID(Connection connection,int id)
 * public static String getContent(Connection connection,String alpha,String num,String contentid,String campus)
 *	public static StringBuffer getContents(Connection connection,String campus,String alpha,String num,String type)
 *	public static String getContentsByKix(Connection connection,String kix)
 *	public static ArrayList getContentsListByKix(Connection connection,String kix)
 *	public static String getContentForEdit(Connection connection,String campus,String alpha,String num,String type)
 * public static String getCourseContent(Connection connection,String campus,String alpha,String num,String type,String hid)
 *	public static int getNextContentID(Connection connection)
 *	public static int getNextRDR(Connection conn,String kix) throws SQLException {
 *	public static boolean hasSLO(Connection connection,String campus,String alpha,String num,String type,int contentid)
 *	public static boolean isContentAdded(Connection connection,String campus,String alpha,String num,String type,String descr)
 *	public static int updateContent(Connection conn,String kix,String content) throws SQLException {
 *	public static int updateContents(Connection conn,String campus,String kix,String content) {
 *
 */

//
// ContentDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class ContentDB {
	static Logger logger = Logger.getLogger(ContentDB.class.getName());

	public ContentDB() throws Exception {}

	/*
	 * getContents
	 *	<p>
	 *	@return StringBuffer
	 */
	public static StringBuffer getContents(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) {

		String getSQL = "SELECT contentid,shortcontent FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
		StringBuffer buf = new StringBuffer();

		try {
			PreparedStatement preparedStatement = connection.prepareStatement(getSQL);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				buf.append("<option value=\"" + resultSet.getInt(1) + "\">" + resultSet.getString(2).trim() + "</option>");
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: getContents\n" + e.toString());
			buf = null;
		}

		return buf;
	}

	/*
	 * getContentsByKix
	 *	<p>
	 *	@return String
	 */
	public static String getContentsByKix(Connection connection,String kix) {

		String getSQL = "SELECT contentid,shortcontent FROM tblCourseContent WHERE historyid=?";
		StringBuffer buf = new StringBuffer();
		String temp = "";

		boolean found = false;

		try {
			PreparedStatement preparedStatement = connection.prepareStatement(getSQL);
			preparedStatement.setString(1, kix);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				buf.append("<tr><td valign=\"top\"><input type=\"radio\" name=\"contentGroup\" value=\"" + resultSet.getInt(1) + "\"></td>" +
					"<td>&nbsp;&nbsp;</td>" +
					"<td valign=\"top\">" + resultSet.getString(2).trim() + "<br/><br/></td></tr>");
				found = true;
			}
			resultSet.close();
			preparedStatement.close();

			temp = buf.toString();

		} catch (Exception e) {
			logger.fatal("ContentDB: getContentsByKix\n" + e.toString());
			buf = null;
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + temp + "</table>";

		return temp;
	}

	/*
	 * getContentsListByKix
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getContentsListByKix(Connection connection,String kix) {

		ArrayList<Content> list = new ArrayList<Content>();
		Content content;

		try {
			String sql = "SELECT contentid,longcontent FROM tblCourseContent WHERE historyid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				content = new Content();
				content.setContentID(rs.getInt(1));
				content.setLongContent(rs.getString(2).trim());
				list.add(content);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: getContentsListByKix\n" + e.toString());
			return null;
		}

		return list;
	}

	/*
	 * getContentByID
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				int
	 *	<p>
	 *	@return Content
	 */
	public static Content getContentByID(Connection connection,int id){

		String getSQL = "SELECT * FROM tblCourseContent WHERE contentid=?";
		Content content = new Content();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(getSQL);
			preparedStatement.setInt(1, id);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				content.setCourseAlpha(AseUtil.nullToBlank(resultSet.getString("CourseAlpha")).trim());
				content.setCourseNum(AseUtil.nullToBlank(resultSet.getString("CourseNum")).trim());
				content.setCourseType(AseUtil.nullToBlank(resultSet.getString("CourseType")).trim());
				content.setContentID(resultSet.getInt("ContentID"));
				content.setCampus(AseUtil.nullToBlank(resultSet.getString("Campus")).trim());
				content.setShortContent(AseUtil.nullToBlank(resultSet.getString("ShortContent")).trim());
				content.setLongContent(AseUtil.nullToBlank(resultSet.getString("LongContent")).trim());
				content.setAuditDate(AseUtil.nullToBlank(resultSet.getString("auditdate")).trim());
				content.setAuditBy(AseUtil.nullToBlank(resultSet.getString("auditby")).trim());
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: getContentByID\n" + e.toString());
			content = null;
		}

		return content;
	}

	/*
	 * addRemoveCourseContent
	 * <p>
	 * @param	connection	Connection
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	user			String
	 * @param	desc			String
	 * @param	content		String
	 * @param	reqID			int
	 * @param	user			String
	 * <p>
	 * @return Msg
	 */
	public static Msg addRemoveCourseContent(Connection connection,
														String action,
														String campus,
														String alpha,
														String num,
														String user,
														String descr,
														String content,
														int reqID,
														String kix) throws SQLException {

		int rowsAffected = 0;
		Msg msg = new Msg();
		String insertSQL = "INSERT INTO tblCourseContent(coursealpha,coursenum,campus,coursetype,shortcontent,longcontent,auditby,historyid,contentid,rdr) VALUES(?,?,?,?,?,?,?,?,?,?)";
		String removeSQL = "DELETE FROM tblCourseContent WHERE contentid=?";
		String updateSQL = "UPDATE tblCourseContent SET shortcontent=?,longcontent=?,auditby=?,auditdate=? WHERE contentid=?";

		try {
			String sql = "";
			boolean nextStep = true;

			String[] info = Helper.getKixInfo(connection,kix);
			String type = info[2];

			/*
			 * for add mode, don't add if already there. for remove, just
			 * proceed
			 */
			if ("a".equals(action)) {
				if (reqID > 0)
					sql = updateSQL;
				else
					sql = insertSQL;
			}
			else if ("r".equals(action)){
				sql = removeSQL;
			}

			if (nextStep) {
				PreparedStatement ps = connection.prepareStatement(sql);

				if ("a".equals(action)) {
					if (reqID > 0){
						ps.setString(1, descr);
						ps.setString(2, content);
						ps.setString(3, user);
						ps.setString(4, AseUtil.getCurrentDateTimeString());
						ps.setInt(5, reqID);
					}
					else{
						ps.setString(1, alpha);
						ps.setString(2, num);
						ps.setString(3, campus);
						ps.setString(4, "PRE");
						ps.setString(5, descr);
						ps.setString(6, content);
						ps.setString(7, user);
						ps.setString(8, kix);
						ps.setInt(9, getNextContentID(connection));
						ps.setInt(10, getNextRDR(connection,kix));
					}
				}
				else if ("r".equals(action)){
					ps.setInt(1, reqID);
				}

				rowsAffected = ps.executeUpdate();
				ps.close();
				msg.setMsg("Successful");
				msg.setCode(0);
			}
		} catch (SQLException e) {
			msg.setMsg("Exception");
			logger.fatal("ContentDB: addRemoveCourseContent - " + e.toString());
		} catch (Exception ex) {
			msg.setMsg("Exception");
			logger.fatal("ContentDB: addRemoveCourseContent - " + ex.toString());
		}

		return msg;
	}

	/*
	 * has content been added
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isContentAdded(Connection connection,
													String campus,
													String alpha,
													String num,
													String type,
													String descr) throws SQLException {

		boolean added = false;

		try {
			String sql = "SELECT coursealpha " +
				"FROM tblCourseContent " +
				"WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=? AND shortcontent=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, descr);
			ResultSet results = ps.executeQuery();
			added = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ContentDB: isContentAdded\n" + e.toString());
		}

		return added;
	}

	/*
	 * getContentForEdit
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * <p>
	 * @return String
	 */
	public static String getContentForEdit(Connection connection,
																String campus,
																String alpha,
																String num,
																String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int id = 0;
		String shortContent = "";
		String content = "";
		StringBuffer buf = new StringBuffer();
		String kix = "";

		kix = Helper.getKix(connection,campus,alpha,num,type);

		sql = "SELECT ContentID,ShortContent,LongContent FROM tblCourseContent " +
				"WHERE campus=? AND Coursealpha=? AND Coursenum=? AND coursetype=? " +
				"ORDER BY rdr";

		String image1 = "reviews4";
		String image2 = "reviews1";
		String dst2 = "Content";
		String src2 = Constant.COURSE_CONTENT;

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
				+ "&nbsp;<a href=\"crsrdr.jsp?s=c&ci="+Constant.COURSE_ITEM_CONTENT+"&kix="+kix+"&\"><img src=\"../images/ed_list_num.gif\" border=\"0\" alt=\"reorder list\" title=\"reorder list\"></a>&nbsp;</td>"
				+ "<td width=\"97%\" valign=\"top\" class=\"textblackTH\">Content</td><tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				shortContent = aseUtil.nullToBlank(rs.getString(2));
				content = aseUtil.nullToBlank(rs.getString(3));

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<a href=\"crscntnt.jsp?e=1&kix="+kix+"&id="+id+"\" alt=\"edit entry\"><img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\"></a>&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + id + "\');\">" +
					"<td valign=\"top\" class=\"dataColumn\">" + content + "</td></tr>");

					//"<a href=\"crsslolnk.jsp?kix=" + kix + "&src=" + src2 + "&cid=" + id + "\"><img src=\"../images/" + image1 + ".gif\" border=\"0\" title=\"link SLO\" alt=\"link SLO\" id=\"linkSLO\"></a>&nbsp;" +
					//"<img src=\"../images/"+image2+".gif\" border=\"0\" title=\"link competency\" alt=\"link competency\" id=\"linkCompetency\" onclick=\"return aseSubmitClick0('"+kix+"','"+src2+"','Competency',"+id+",'crscntnt');\">&nbsp;&nbsp;" +
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ContentDB: getContentForEdit\n" + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("ContentDB: getContentForEdit\n" + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/*
	 * getNextContentID
	 *	<p>
	 *	@return int
	 */
	public static int getNextContentID(Connection connection) throws SQLException {

		int id = 1;

		try {
			String sql = "SELECT MAX(ContentID) + 1 AS maxid FROM tblCourseContent";
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ContentDB: getNextContentID\n" + e.toString());
		}

		return id;
	}

	/*
	 * hasSLO
	 * <p>
	 *	whether there are SLO tied to this content
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
	public static boolean hasSLO(Connection connection,
														String campus,
														String alpha,
														String num,
														String type,
														int contentid) throws Exception {

		boolean hasData = false;
		String sql = "SELECT count(contentid) "
			+ "FROM tblCourseContentSLO "
			+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND contentid=?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			preparedStatement.setInt(5, contentid);
			ResultSet rs = preparedStatement.executeQuery();
			if (rs.next() && rs.getInt(1) > 0 )
				hasData = true;
			rs.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: hasSLO\n" + e.toString());
		}

		//logger.info("ContentDB - hasSLO - " + alpha + " - " + num);

		return hasData;
	}

	/*
	 * getContent
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	alpha			String
	 *	@param	num			String
	 * @param	contentid	String
	 * @param	campus		String
	 *	<p>
	 *	@return String
	 */
	public static String getContent(Connection connection,String alpha,String num,String contentid,String campus) throws Exception {

		String getSQL = "SELECT longcontent "
			+ "FROM tblCourseContent "
			+ "WHERE campus=? AND courseAlpha=? AND courseNum=? AND contentid=?";
		String content = null;

		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, contentid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				content = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: getContent\n" + e.toString());
		}

		return content;
	}

	/*
	 * getSelectedSLOs are assessments linked to outline competencies <p>
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	@param	contentid	String
	 *	<p>
	 * @return String
	 */
	public static String getSelectedSLOs(Connection connection,
																String kix,
																String contentid) throws Exception {

		String sql = "SELECT sloid "
			+ "FROM tblCourseContentSLO "
			+ "WHERE historyid=? AND "
			+ "contentid=? ";
		String selected = "";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,kix);
			preparedStatement.setString(2,contentid);
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
			logger.fatal("ContentDB: getSelectedSLOs\n" + e.toString());
		}

		//logger.info("ContentDB - getSelectedSLOs - " + selected);

		return selected;
	}

	/*
	 * getContentAsHTMLList - Identical to getComps except returning string with
	 * HTML table for display
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		campus
	 * @param	String		type
	 * @param	String		hid
	 * @param	boolean		detail
	 * @param	boolean		includeAssessment
	 *	<p>
	 * @return String
	 */
	public static String getContentAsHTMLList(Connection connection,
															String campus,
															String alpha,
															String num,
															String type,
															String hid,
															boolean includeSLO,
															boolean includeAssessment) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sqlContent = "";
		String sqlSLO = "";
		String sqlAssess = "";

		StringBuffer contents = new StringBuffer();
		StringBuffer SLO = new StringBuffer();
		StringBuffer assess = new StringBuffer();

		boolean found = false;
		boolean foundDetail = false;
		boolean foundAssess = false;

		PreparedStatement ps = null;
		PreparedStatement stmtSLO = null;
		PreparedStatement stmtAssess = null;

		ResultSet rsSLO = null;
		ResultSet rsAssess = null;

		String temp = "";
		String linked = "";

		int contentID = 0;

		sqlAssess = "SELECT assessment FROM vw_slo2assessment WHERE historyid=? AND compid=?";

		sqlSLO = "SELECT tc.Comp,tc.CompID "
			+ "FROM tblCourseContentSLO ts, tblCourseComp tc "
			+ "WHERE ts.historyid=tc.historyid AND "
			+ "ts.historyid=? AND "
			+ "ts.sloid=tc.CompID AND "
			+ "ts.contentid=?";

		sqlContent = "SELECT ContentID, LongContent "
			+ "FROM tblCourseContent WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? ORDER BY rdr";

		try {
			ps = connection.prepareStatement(sqlContent);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				found = true;

				contentID = resultSet.getInt("ContentID");

				if (Outlines.isCompetencyLinked2Content(connection,hid,contentID+"","0"))
					linked = "&nbsp;&nbsp;<a href=\"crslnkdxw.jsp?src="
								+ Constant.COURSE_CONTENT
								+ "&kix="+hid
								+ "&level1="+contentID+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\"><img src=\"../images/ed_link2.gif\" alt=\"\" border=\"0\"></a>";
				else
					linked = "";
//LINKED ITEM
linked = "";

				contents.append("<li class=\"dataColumn\">"
					+ AseUtil.nullToBlank(resultSet.getString("LongContent"))
					+ linked);

				if (includeSLO){
					SLO.setLength(0);
					foundDetail = false;

					stmtSLO = connection.prepareStatement(sqlSLO);
					stmtSLO.setString(1,hid);
					stmtSLO.setInt(2,resultSet.getInt(1));
					rsSLO = stmtSLO.executeQuery();
					while (rsSLO.next()){
						foundDetail = true;
						SLO.append("<li class=\"dataColumn\">" + rsSLO.getString(1));

						if (includeAssessment){
							assess.setLength(0);
							foundAssess = false;

							stmtAssess = connection.prepareStatement(sqlAssess);
							stmtAssess.setString(1,hid);
							stmtAssess.setInt(2,rsSLO.getInt(2));
							rsAssess = stmtAssess.executeQuery();
							while (rsAssess.next()){
								foundAssess = true;
								assess.append("<li class=\"dataColumn\">" + rsAssess.getString(1) + "</li>");
							}

							rsAssess.close();
							stmtAssess.close();

							if (foundAssess){
								SLO.append("<ul>");
								SLO.append(assess.toString());
								SLO.append("</ul>");
							}
						} // includeAssessment

						SLO.append("</li>");
					}	// while rsSLO

					rsSLO.close();
					stmtSLO.close();

					if (foundDetail){
						contents.append("<ul>");
						contents.append(SLO.toString());
						contents.append("</ul>");
					}

					contents.append("</li>");

				} // detail
			} // while

			resultSet.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td><ul>" +
					contents.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("ContentDB: getContentAsHTMLList\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getCourseContent
	 *	<p>
	 * @return String
	 */
	public static String getCourseContent(Connection connection,
													String campus,
													String alpha,
													String num,
													String type,
													String hid) throws SQLException {

		boolean hasContent = false;
		StringBuffer content = new StringBuffer();
		String temp = "";
		String sql = "";
		PreparedStatement ps;

		try {
			if ("ARC".equals(type)) {
				sql = "SELECT shortcontent,longcontent FROM tblCourseContent WHERE historyid=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1, hid);
			} else {
				sql = "SELECT shortcontent,longcontent FROM tblCourseContent WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
			}

			ResultSet results = ps.executeQuery();
			content.append("<table border=\"0\" cellspacing=\"10\" width=\"100%\">");
			content.append("<tr class=\"textblackTH\"><td valign=\"top\">Description</td><td valign=\"top\">Content</td></tr>");
			while (results.next()) {
				hasContent = true;
				alpha = results.getString(1);
				num = results.getString(2);
				content.append("<tr class=\"dataColumn\"><td valign=\"top\" width=\"30%\" nowrap>" + alpha
						+ "</td><td valign=\"top\" width=\"70%\">" + num
						+ "</td></tr>");
			}
			content.append("</table>");

			results.close();
			ps.close();

			if (hasContent)
				temp = content.toString();
			else
				temp = "";

		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseContent\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseContent\n" + ex.toString());
		}

		return temp;
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection conn,String kix) throws SQLException {

		int id = 0;
		String table = "tblCourseContent";

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid FROM "
				+ table
				+ " WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ContentDB: getNextRDR\n" + e.toString());
		}

		return id;
	}

	/*
	 * updateContent
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	content	String
	 *	<p>
	 *	@return int
	 */
	public static int updateContent(Connection conn,String kix,String content) throws SQLException {

		int rowsAffected = -1;
		String sql = "UPDATE tblCourse "
			+ "SET " + Constant.COURSE_CONTENT + "=? "
			+ "WHERE historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,content);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ContentDB: updateContent - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateContents
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	content	String
	 * <p>
	 * @return	int
	 */
	public static int updateContents(Connection conn,String campus,String kix,String content) {

		String sql = "UPDATE tblCourseContent "
			+ "SET longcontent=? "
			+ "WHERE campus=? AND historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,content);
			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("ContentDB - updateContents");
		} catch (SQLException e) {
			logger.fatal("ContentDB - updateContents: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteContents
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int deleteContents(Connection conn,String campus,String kix) {

		String sql = "DELETE FROM tblCourseContent WHERE campus=? AND historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info("ContentDB - deleteContents: " + kix);
		} catch (SQLException e) {
			logger.fatal("ContentDB - deleteContents:  " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getContentByKixID
	 * <p>
	 * @param	connection
	 * @param	kix
	 * @param	contentID
	 * <p>
	 * @return	Content
	 */
	public static Content getContentByKixID(Connection connection,String kix,int contentID){

		//Logger logger = Logger.getLogger("test");

		String getSQL = "SELECT * FROM tblCourseContent WHERE historyid=? AND contentid=?";
		Content content = null;
		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1,kix);
			ps.setInt(2,contentID);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				content = new Content();
				content.setCourseAlpha(AseUtil.nullToBlank(rs.getString("CourseAlpha")));
				content.setCourseNum(AseUtil.nullToBlank(rs.getString("CourseNum")));
				content.setCourseType(AseUtil.nullToBlank(rs.getString("CourseType")));
				content.setContentID(rs.getInt("ContentID"));
				content.setCampus(AseUtil.nullToBlank(rs.getString("Campus")));
				content.setShortContent(AseUtil.nullToBlank(rs.getString("ShortContent")));
				content.setLongContent(AseUtil.nullToBlank(rs.getString("LongContent")));
				content.setAuditDate(AseUtil.nullToBlank(rs.getString("auditdate")));
				content.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ContentDB: getContentByKixID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ContentDB: getContentByKixID - " + ex.toString());
		}

		return content;
	}

	/**
	 * copyContent
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	user
	 * @param	contentID
	 * <p>
	 * @return	int
	 */
	public static int copyContent(Connection conn,
												String kixOld,
												String kixNew,
												String alpha,
												String num,
												String user,
												int contentID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int nextID = 0;

		boolean debug = false;

		String src = Constant.COURSE_CONTENT;
		String campus = "";

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"ContentDB");

			if (debug) logger.info("CONTENTDB COPYCONTENT - STARTS");

			String sql = "INSERT INTO tblCourseContent(coursealpha,coursenum,campus,coursetype,shortcontent,longcontent,auditby,historyid,contentid,rdr) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?)";

			Content content = getContentByKixID(conn,kixOld,contentID);

			if (content != null){
				nextID = ContentDB.getNextContentID(conn);

				campus = content.getCampus();

				String[] info2 = Helper.getKixInfo(conn,kixNew);
				String toCampus = info2[Constant.KIX_CAMPUS];

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				ps.setString(3,toCampus);
				ps.setString(4,type);
				ps.setString(5,content.getShortContent());
				ps.setString(6,content.getLongContent());
				ps.setString(7,user);
				ps.setString(8,kixNew);
				ps.setInt(9, contentID);
				ps.setInt(10, ContentDB.getNextRDR(conn,kixNew));
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug) logger.info(kixNew + " - content copied");

				rowsAffected = LinkedUtil.copyLinked(conn,campus,user,type,kixOld,kixNew,src,contentID,contentID);
			}

			if (debug) logger.info("CONTENTDB COPYCONTENT - ENDS");

		} catch (SQLException e) {
			logger.fatal("ContentDB: copyContent - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ContentDB: copyContent - " + ex.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}