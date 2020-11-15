/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteContent(Connection conn,String kix,int id) {
 *	public static int deleteContents(Connection conn,String kix,String src) {
	public static ArrayList getContentByCampusKix(Connection conn,String campus,String src,String kix) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Text getContent(Connection conn,String kix,int id) {
 * public static String getContentAsHTMLList(Connection connection,String kix)
 *	public static int insertContent(Connection conn, Text text)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateContent(Connection conn, Text text) {
 *	public static int updateContents(Connection conn,String campus,String kix,String content) {
 *	public static int updateProgramSLO(Connection conn,String kix,String objective) throws SQLException {
 *
 * @author ttgiang
 */

//
// GenericContentDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class GenericContentDB {

	static Logger logger = Logger.getLogger(GenericContentDB.class.getName());

	public GenericContentDB() throws Exception {}

	/**
	 * insertContent
	 * <p>
	 * @param	conn	Connection
	 * @param	gc		GenericContent
	 * <p>
	 * @return	int
	 */
	public static int insertContent(Connection conn, GenericContent gc) {

		String sql = "INSERT INTO tblGenericContent(historyid,campus,coursealpha,coursenum,coursetype,src,comments,auditby,rdr,id) VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,gc.getHistoryid());
			ps.setString(2,gc.getCampus());
			ps.setString(3,gc.getCourseAlpha());
			ps.setString(4,gc.getCourseNum());
			ps.setString(5,gc.getCourseType());
			ps.setString(6,gc.getSrc());
			ps.setString(7,gc.getComments());
			ps.setString(8,gc.getAuditBy());
			ps.setInt(9,getNextRDR(conn,gc.getHistoryid(),gc.getSrc()));
			ps.setInt(10,getNextContentNumber(conn));
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - insertContent: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteContent
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteContent(Connection conn,String kix,int id) {

		String sql = "DELETE FROM tblGenericContent WHERE historyid=? AND id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - deleteContent:  " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteContents
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * <p>
	 * @return	int
	 */
	public static int deleteContents(Connection conn,String campus,String kix,String src) {

		String sql = "DELETE FROM tblGenericContent WHERE campus=? AND historyid=? AND src=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - deleteContents:  " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateProgramSLO
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	slo	String
	 *	<p>
	 *	@return int
	 */
	public static int updateProgramSLO(Connection conn,String kix,String slo) throws SQLException {

		int rowsAffected = -1;
		String sql = "UPDATE tblCourse SET " + Constant.COURSE_PROGRAM_SLO + "=? WHERE historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,slo);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GenericContentDB: updateProgramSLO - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateGenericCourseContent
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	column	String
	 *	@param	content	String
	 *	<p>
	 *	@return int
	 */
	public static int updateGenericCourseContent(Connection conn,String kix,String column,String content) throws SQLException {

		int rowsAffected = -1;
		String sql = "UPDATE tblCourse SET " + column + "=? WHERE historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,content);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GenericContentDB: updateGenericCourseContent - " + e.toString());
		}

		return rowsAffected;
	}


	/**
	 * updateContent
	 * <p>
	 * @param	conn	Connection
	 * @param	gc		GenericContent
	 * <p>
	 * @return	int
	 */
	public static int updateContent(Connection conn, GenericContent gc) {

		String sql = "UPDATE tblGenericContent SET comments=?,auditby=?,auditdate=? WHERE historyid=? AND id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,gc.getComments());
			ps.setString(2,gc.getAuditBy());
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,gc.getHistoryid());
			ps.setInt(5,gc.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - updateContent: " + e.toString());
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

		String sql = "UPDATE tblGenericContent SET comments=? WHERE campus=? AND historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,content);
			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - updateContents: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getContent
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	GenericContent
	 */
	public static GenericContent getContent(Connection conn,String kix,int id) {

		String sql = "SELECT * FROM tblGenericContent WHERE historyid=? AND id=?";
		GenericContent gc = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				gc = new GenericContent();
				gc.setHistoryid(aseUtil.nullToBlank(rs.getString("historyid")));
				gc.setCampus(aseUtil.nullToBlank(rs.getString("campus")));
				gc.setCourseAlpha(aseUtil.nullToBlank(rs.getString("coursealpha")));
				gc.setCourseNum(aseUtil.nullToBlank(rs.getString("coursenum")));
				gc.setCourseType(aseUtil.nullToBlank(rs.getString("coursetype")));
				gc.setSrc(aseUtil.nullToBlank(rs.getString("src")));
				gc.setComments(aseUtil.nullToBlank(rs.getString("comments")));
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB: getContent - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("GenericContentDB: getContent\n" + ex.toString());
		}

		return gc;
	}

	/**
	 * getComments
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	String
	 */
	public static String getComments(Connection conn,String kix,int id) {

		String sql = "SELECT comments FROM tblGenericContent WHERE historyid=? AND id=?";
		String comments = "";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				comments = aseUtil.nullToBlank(rs.getString("comments"));
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB: getComments - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("GenericContentDB: getComments\n" + ex.toString());
		}

		return comments;
	}

	/*
	 * getContentsByType
	 *	<p>
	 *	@parm	conn	Connection
	 *	@parm	kix	String
	 *	@parm	src	String
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getContentsByType(Connection conn,String kix,String src) throws Exception {

		StringBuffer buf = new StringBuffer();
		int contentID = 0;
		String comments = "";
		String sql = "";

		String image1 = "reviews";
		String image2 = "reviews1";
		String image3 = "reviews2";

		int item = 0;

		try {
			AseUtil aseUtil = new AseUtil();

			String src2 = Constant.getAlternateName(src);

			if (src.equals(Constant.COURSE_PROGRAM_SLO) || src2.equals(Constant.IMPORT_PLO)){
				item = Constant.COURSE_ITEM_PROGRAM_SLO;
			}
			else if (src.equals(Constant.COURSE_INSTITUTION_LO) || src2.equals(Constant.IMPORT_ILO)){
				item = Constant.COURSE_ITEM_ILO;
			}

			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"10%\" valign=\"top\" nowrap>"
				+ "&nbsp;<a href=\"crsrdr.jsp?src="+src+"&s=c&ci="+item+"&kix="+kix+"&\"><img src=\"../images/ed_list_num.gif\" border=\"0\" alt=\"reorder list\" title=\"reorder list\"></a>&nbsp;</td>"
				+ "<td width=\"90%\" valign=\"top\" class=\"textblackTH\">Content</td></tr>");

			sql = "SELECT id,comments "
				+ "FROM tblGenericContent "
				+ "WHERE historyid=? AND "
				+ "src=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				contentID = rs.getInt(1);
				comments = rs.getString("comments");
				buf.append("<tr><td align=\"left\" width=\"10%\" valign=\"top\" nowrap>" +
					"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit content\" alt=\"edit content\" id=\"editProgramSLO\" onclick=\"return aseSubmitClick3('"+kix+"',"+contentID+");\">&nbsp;&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete content\" alt=\"delete content\" id=\"deleteProgramSLO\" onclick=\"return aseSubmitClick2("+contentID+");\">" +
					"</td><td width=\"90%\" valign=\"top\" class=\"dataColumn\">" + comments + "</td></tr>");

					// removed link to competency because PSLO is already linked on competency screen
					//"<img src=\"../images/reviews1.gif\" border=\"0\" title=\"link competency\" alt=\"link competency\" id=\"linkCompetency\" onclick=\"return aseSubmitClick0('"+kix+"','"+src+"','Competency',"+contentID+");\">&nbsp;&nbsp;" +
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GenericContentDB: getContentsByType - " + e.toString());
			return null;
		}

		return buf.toString();
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 * @param	src	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection conn,String kix,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid FROM tblGenericContent WHERE historyid=? AND src=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid");
			}

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB: getNextRDR - " + e.toString());
		}

		return id;
	}

	/*
	 * getContentAsHTMLList - HTML table for display
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	src	String
	 *	<p>
	 * @return String
	 */
	public static String getContentAsHTMLList(Connection conn,String kix,String src) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql;
		StringBuffer content = new StringBuffer();
		boolean found = false;
		String temp = "";
		String linked = "";
		int seq = 0;

		try {

			// some src items started out with different names so we must accommodate
			String src2 = Constant.getAlternateName(src);

			sql = "SELECT id,comments FROM tblGenericContent WHERE historyid=? AND (src=? OR src=?) ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setString(3,src2);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				seq = rs.getInt("id");

				if (Outlines.isProgramSLOLinked(conn,kix,src,src,(seq+""),"0"))
					linked = "&nbsp;<a href=\"crslnkdxw.jsp?src="
						+ src
						+ "&kix="+kix
						+ "&level1="+seq+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\"><img src=\"../images/ed_link2.gif\" alt=\"\" border=\"0\"></a>";
				else
					linked = "";

//LINKED ITEM
linked = "";

				content.append("<li class=\"dataColumn\">"
					+ AseUtil.nullToBlank(rs.getString("comments"))
					+ linked
					+ "</li>");
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + content.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("GenericContentDB: getContentAsHTMLList - " + e.toString());
		}

		return temp;
	}

	/*
	 * getNextContentNumber
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextContentNumber(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblGenericContent";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB: getNextContentNumber - " + e.toString());
		}

		return id;
	}

	/*
	 * getContentByCampusKix
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	src		String
	 *	@param	kix		String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getContentByCampusKix(Connection conn,String campus,String src,String kix) {

		ArrayList<GenericContent> list = new ArrayList<GenericContent>();
		GenericContent gc;

		try {
			String sql = "SELECT id,comments FROM tblGenericContent WHERE campus=? AND src=? AND historyid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				gc = new GenericContent();
				gc.setId(rs.getInt(1));
				gc.setComments(rs.getString(2).trim());
				list.add(gc);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("GenericContentDB: getContentByCampusKix - " + e.toString());
			return null;
		}

		return list;
	}

	/**
	 * copyContent
	 * <p>
	 * @param	conn	Connection
	 * @param	gc		GenericContent
	 * <p>
	 * @return	int
	 */
	public static int copyContent(Connection conn, GenericContent gc) {

		String sql = "INSERT INTO tblGenericContent(historyid,campus,coursealpha,coursenum,coursetype,src,comments,auditby,rdr,id) VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {

			//int id = getNextContentNumber(conn);
			//int rdr = getNextRDR(conn,gc.getHistoryid(),gc.getSrc());

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,gc.getHistoryid());
			ps.setString(2,gc.getCampus());
			ps.setString(3,gc.getCourseAlpha());
			ps.setString(4,gc.getCourseNum());
			ps.setString(5,gc.getCourseType());
			ps.setString(6,gc.getSrc());
			ps.setString(7,gc.getComments());
			ps.setString(8,gc.getAuditBy());
			ps.setInt(9,gc.getRdr());
			ps.setInt(10,gc.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("GenericContentDB - copyContent: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * copyGenericContent
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	src
	 * @param	alpha
	 * @param	num
	 * @param	user
	 * @param	currentID
	 * <p>
	 * @return	int
	 */
	public static int copyGenericContent(Connection conn,
														String kixOld,
														String kixNew,
														String src,
														String alpha,
														String num,
														String user,
														int currentID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean debug = false;

		String campus = "";

		int nextID = 0;

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"GenericContentDB");

			if (debug) logger.info("GENERICCONTENTDB COPYGENERICCONTENT - STARTS");

			GenericContent GC = getContent(conn,kixOld,src,currentID);

			if (GC != null){
				campus = GC.getCampus();

				String[] info2 = Helper.getKixInfo(conn,kixNew);
				String toCampus = info2[Constant.KIX_CAMPUS];

				nextID = copyContent(conn,new GenericContent(currentID,
																			kixNew,
																			toCampus,
																			alpha,
																			num,
																			type,
																			src,
																			GC.getComments(),
																			AseUtil.getCurrentDateTimeString(),
																			user,
																			GC.getRdr()));

				if (debug) logger.info(kixNew + " - generic content copied - " + nextID + " rows");

				rowsAffected = LinkedUtil.copyLinked(conn,
																	campus,
																	user,
																	type,
																	kixOld,
																	kixNew,
																	src,
																	currentID,
																	currentID);
			}

			if (debug) logger.info("GENERICCONTENTDB COPYGENERICCONTENT - ENDS");

		} catch (SQLException e) {
			logger.fatal("GenericContentDB: copyGenericContent - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("GenericContentDB: copyGenericContent - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * getContent
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	src
	 * @param	id
	 * <p>
	 * @return	GenericContent
	 */
	public static GenericContent getContent(Connection conn,String kix,String src,int id) {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		String sql = "SELECT * FROM tblGenericContent WHERE historyid=? AND src=? AND id=?";

		GenericContent gc = null;

		try {
			debug = DebugDB.getDebug(conn,"GenericContentDB");

			if (debug) logger.info("GENERICCONTENTDB GETCONTENT - STARTS");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setInt(3,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (debug) logger.info(kix + " - generic content found");

				gc = new GenericContent();
				gc.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
				gc.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				gc.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				gc.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				gc.setCourseType(AseUtil.nullToBlank(rs.getString("coursetype")));
				gc.setSrc(AseUtil.nullToBlank(rs.getString("src")));
				gc.setComments(AseUtil.nullToBlank(rs.getString("comments")));
			}
			ps.close();

			if (debug) logger.info("GENERICCONTENTDB GETCONTENT - ENDS");

		} catch (SQLException e) {
			logger.fatal("GenericContentDB: getContent - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("GenericContentDB: getContent\n" + ex.toString());
		}

		return gc;
	}

	/**
	 * insertListFromSrc
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	dst			String
	 * @param	subtopic		String
	 * <p>
	 * @return	int
	 */
	public static int insertListFromSrc(Connection conn,
														String campus,
														String kix,
														String user,
														String src,
														String dst,
														String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String list = "";

		int rowsAffected  = 0;

		try {
			GenericContent gc = null;

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			String sql = "SELECT shortdescr FROM tblValues WHERE campus=? AND src=? AND subtopic=? ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,subtopic);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list = AseUtil.nullToBlank(rs.getString("shortdescr"));
				gc = new GenericContent(0,kix,campus,alpha,num,type,dst,list,"",user,0);
				rowsAffected = GenericContentDB.insertContent(conn,gc);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("GenericContentDB: insertListFromSrc - " + e.toString());
		} catch (Exception e) {
			logger.fatal("GenericContentDB: insertListFromSrc - " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}