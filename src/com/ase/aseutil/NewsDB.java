/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteNews(Connection connection,String campus,String id) {
 *	public static int getNextInfoID(Connection conn) {
 *	public static News getNews(Connection connection, int newsid) {
 *	public static String getNewsFileName(Connection connection, int newsid) {
 *	public static int insertNews(Connection connection, News news) {
 *	public static String listNews(Connection conn,String campus){
 *	public static int updateNews(Connection connection, News news) {
 *
 * @author ttgiang
 */

//
// NewsDB.java
//
package com.ase.aseutil;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

public class NewsDB {

	static Logger logger = Logger.getLogger(NewsDB.class.getName());

	public NewsDB() throws Exception {}

	/**
	 * getNew
	 * <p>
	 * @param	connection	Connection
	 * @param	newsid		int
	 * <p>
	 * @return	News
	 */
	public static News getNews(Connection connection, int newsid) {

		News newsDB = new News();

		String sql = "SELECT * FROM tblInfo WHERE id = ?";

		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, newsid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				newsDB.setId(aseUtil.getValue(rs, "id"));
				newsDB.setTitle(aseUtil.getValue(rs, "InfoTitle"));
				newsDB.setContent(aseUtil.getValue(rs, "InfoContent"));
				newsDB.setStartDate(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "startdate"), 6));
				newsDB.setEndDate(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "enddate"), 6));
				newsDB.setAuditBy(aseUtil.getValue(rs, "Author"));
				newsDB.setAuditDate(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "DatePosted"), 6));
				newsDB.setCampus(aseUtil.getValue(rs, "campus"));
				newsDB.setAttach(aseUtil.getValue(rs, "attach"));
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("NewsDB: getNews - " + e.toString());
			return null;
		}

		return newsDB;
	}

	/**
	 * insertNews
	 * <p>
	 * @param	connection	Connection
	 * @param	news			News
	 * <p>
	 * @return	int
	 */
	public static int insertNews(Connection connection, News news) {

		int rowsAffected = 0;

		String sql = "INSERT INTO tblInfo (id,infotitle,infocontent,author,startdate,enddate,campus,attach) VALUES (?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, getNextInfoID(connection));
			ps.setString(2, news.getTitle());
			ps.setString(3, news.getContent());
			ps.setString(4, news.getAuditBy());
			ps.setString(5, news.getStartDate());
			ps.setString(6, news.getEndDate());
			ps.setString(7, news.getCampus());
			ps.setString(8, news.getAttach());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: insertNews - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * deleteNews
	 * <p>
	 * @param	connection	Connection
	 * @param	id				String
	 * <p>
	 * @return	int
	 */
	public static int deleteNews(Connection connection,String campus,String id) {

		int rowsAffected = 0;
		String sql = "DELETE FROM tblInfo WHERE id = ?";
		try {
			rowsAffected = AttachDB.deleteUpload(connection,campus,"NEWS",NumericUtil.getInt(id));
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: deleteNews - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * updateNews
	 * <p>
	 * @param	connection	Connection
	 * @param	news			News
	 * <p>
	 * @return	int
	 */
	public static int updateNews(Connection connection, News news) {

		int rowsAffected = 0;

		String sql = "UPDATE tblInfo SET infotitle=?,infocontent=?,author=?,dateposted=?,startdate=?,enddate=?,attach=? WHERE id =?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,news.getTitle());
			ps.setString(2,news.getContent());
			ps.setString(3,news.getAuditBy());
			ps.setString(4,news.getAuditDate());
			ps.setString(5,news.getStartDate());
			ps.setString(6,news.getEndDate());
			ps.setString(7,news.getAttach());
			ps.setString(8,news.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: updateNews - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * getNextInfoID
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return	int
	 */
	public static int getNextInfoID(Connection conn) {

		int infoID = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblInfo";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				infoID = rs.getInt("maxid");
			else
				infoID = 1;
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: getNextInfoID - " + e.toString());
		}

		return infoID;

	}

	/**
	 * getNewsFileName
	 * <p>
	 * @param	connection	Connection
	 * @param	newsid		int
	 * <p>
	 * @return	String
	 */
	public static String getNewsFileName(Connection connection, int newsid) {

		String fileName = "";
		String sql = "SELECT attach FROM tblInfo WHERE id=?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, newsid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				fileName = AseUtil.nullToBlank(rs.getString("attach"));
			rs.close();
			rs = null;
			ps.close();
			ps = null;
		} catch (Exception e) {
			logger.fatal("NewsDB: getNewsFileName - " + e.toString());
		}

		return fileName;
	}

	/**
	 * listNews
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String listNews(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String rowColor = "";
		String temp = "";

		int j = 0;

		boolean found = false;

		try{
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			AseUtil aseUtil = new AseUtil();

			String startDate = aseUtil.addToDate(0);
			String endDate = aseUtil.addToDate(0);
			temp = "(enddate >= \'" + endDate + " 23:59:59\')";

			String id = "";
			String datePosted = "";
			String infoTitle = "";
			String author = "";
			String attach = "";
			String ext = "";
			String link = "";

			String sql = "SELECT id,DatePosted,InfoTitle,Author,attach "
				+ "FROM tblInfo "
				+ "WHERE campus=? "
				+ "AND _date_ "
				+ "ORDER BY dateposted desc";

			sql = sql.replace("_date_", temp );

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				ext = "";
				link = "";

				id = aseUtil.nullToBlank(rs.getString("id"));
				datePosted = aseUtil.ASE_FormatDateTime(aseUtil.nullToBlank(rs.getString("datePosted")),Constant.DATE_DATETIME);
				infoTitle = aseUtil.nullToBlank(rs.getString("infoTitle"));
				author = aseUtil.nullToBlank(rs.getString("author"));
				attach = aseUtil.nullToBlank(rs.getString("attach"));
				link = "<a href=\"newsdtlx.jsp?lid="+id+"\" title=\"" + infoTitle + "\" class=\"linkcolumn\" target=\"_blank\" onClick=\"return hs.htmlExpand(this, { objectType: 'ajax', width: 800});\">";

				if (attach.length() > 0){
					// no longer include NEWS and id
					//attach = campus + "-NEWS-" + id + "-" + attach;
					ext = "<img src=\"/central/images/ext/" + AseUtil2.getFileExtension(attach) + ".gif\" border=\"0\">";
					ext = "<a href=\""+documentsURL+"uploads/" + campus + "/" + attach + "\" class=\"linkcolumn\" target=\"_blank\">" + ext + "</a>";
				}

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\">" + link + datePosted + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + infoTitle + "&nbsp;&nbsp;" + ext+ "</td>");
				listings.append("<td class=\"datacolumn\">" + author + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table class=\"" + campus + "BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
					"<tr class=\"" + campus + "BGColor\" height=\"30\">" +
					"<td width=\"12%\">Date Posted</td>" +
					"<td width=\"78%\">Title</td>" +
					"<td width=\"10%\">Author</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
			else{
				listing = "News not found";
			}

		}
		catch( SQLException e ){
			logger.fatal("Helper: listNews - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listNews - " + ex.toString());
		}

		return listing;

	}

	/**
	 * updateAttachment
	 * <p>
	 * @param	conn			Connection
	 * @param	attachment	String
	 * @param	id				int
	 * <p>
	 * @return	int
	 */
	public static int updateAttachment(Connection conn,int id,String attachment) {

		int rowsAffected = 0;

		String sql = "UPDATE tblInfo SET attach=? WHERE id =?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,attachment);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: updateAttachment - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getLastIDByCampus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int getLastIDByCampus(Connection conn,String campus) {

		int infoID = 0;

		try {
			String sql = "SELECT MAX(id) AS maxid FROM tblInfo WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				infoID = rs.getInt("maxid");
			else
				infoID = 1;
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("NewsDB: getLastIDByCampus - " + e.toString());
		}

		return infoID;

	}

	/**
	 * listNewsJQuery
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	version	int
	 * <p>
	 * @return	String
	 */
	public static String listNewsJQuery(Connection conn,String campus,int version){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String rowColor = "";
		String temp = "";

		try{
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			AseUtil aseUtil = new AseUtil();

			String startDate = aseUtil.addToDate(0);
			String endDate = aseUtil.addToDate(0);
			temp = "(enddate >= \'" + endDate + " 23:59:59\')";

			String id = "";
			String datePosted = "";
			String infoTitle = "";
			String author = "";
			String attach = "";
			String ext = "";
			String link = "";

			int i = 0;

			String sql = "SELECT id,DatePosted,InfoTitle,Author,attach "
				+ "FROM tblInfo WHERE campus=? AND _date_ ORDER BY dateposted desc";

			sql = sql.replace("_date_", temp );

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				ext = "";
				link = "";

				id = aseUtil.nullToBlank(rs.getString("id"));
				datePosted = aseUtil.ASE_FormatDateTime(aseUtil.nullToBlank(rs.getString("datePosted")),Constant.DATE_DATETIME);
				infoTitle = aseUtil.nullToBlank(rs.getString("infoTitle"));
				author = aseUtil.nullToBlank(rs.getString("author"));
				attach = aseUtil.nullToBlank(rs.getString("attach"));

				link = "<a href=\"#dialog"+i+"\" name=\"modal\" class=\"linkcolumn\">" + datePosted + "</a>";

				if (attach.length() > 0){
					ext = "<img src=\"/central/images/ext/" + AseUtil2.getFileExtension(attach) + ".gif\" border=\"0\">";
					ext = "<a href=\""+documentsURL+"uploads/" + campus + "/" + attach + "\" class=\"linkcolumn\" target=\"_blank\">" + ext + "</a>";
				}

				listings.append("<tr>"
					+ "<td class=\"datacolumn\">" + link + "</a></td>"
					+ "<td class=\"datacolumn\">" + infoTitle + "&nbsp;&nbsp;" + ext+ "</td>"
					+ "<td class=\"datacolumn\">" + author + "</td>"
					+ "</tr>");

				++i;
			}
			rs.close();
			ps.close();

			listing = "<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"jquery\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">Date Posted</th>"
				+ "<th align=\"left\">Title</th>"
				+ "<th align=\"left\">Author</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ listings.toString()
				+ "</tbody></table></div></div>"
				+ writeNewsDiv(conn,campus,version);

		}
		catch( SQLException e ){
			logger.fatal("Helper: listNewsJQuery - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listNewsJQuery - " + ex.toString());
		}

		return listing;

	}

	/**
	 * writeNewsDiv
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	version	int
	 * <p>
	 * @return	String
	 */
	public static String writeNewsDiv(Connection conn,String campus,int version){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();

		try{
			int i = 0;

			String ext = "";

			News news = null;

			String documentsURL = SysDB.getSys(conn,"documentsURL");

			AseUtil aseUtil = new AseUtil();

			String startDate = aseUtil.addToDate(0);
			String endDate = aseUtil.addToDate(0);
			String temp = "(enddate >= \'" + endDate + " 23:59:59\')";

			String sql = "SELECT id,DatePosted,InfoTitle,Author,attach "
				+ "FROM tblInfo "
				+ "WHERE campus=? "
				+ "AND _date_ "
				+ "ORDER BY dateposted desc";

			sql = sql.replace("_date_", temp );

			listings.append("<div id=\"boxes\">");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				ext = "";
				int id = rs.getInt("id");
				String attach = AseUtil.nullToBlank(rs.getString("attach"));

				if (attach.length() > 0){
					ext = "<p><a href=\""+documentsURL+"uploads/" + campus + "/" + attach + "\" class=\"linkcolumn\" target=\"_blank\">"
						+ "<img src=\"/central/images/ext/" + AseUtil2.getFileExtension(attach) + ".gif\" border=\"0\" title=\"view attachment\" alt=\"view attachment\">"
						+ "</a></p>";
				}

				news = NewsDB.getNews(conn,id);

				if (version==1){
					listings.append("<div id=\"dialog"+i+"\" class=\"window ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable\">"
						+ "<table width=\"100%\">"
						+ "<tr>"
						+ "<td width=\"33%\">&nbsp;</td>"
						+ "<td width=\"34%\" class=\"textblackthcenter\">" + news.getTitle() + ext + "</td>"
						+ "<td width=\"33%\" align=\"right\">"
						+ "<a href=\"#\"class=\"close\"/><img src=\"../images/cancel.png\" border=\"0\" width=\"24\" height=\"24\" title=\"close\"></a>"
						+ "</td>"
						+ "</tr>"
						+ "<tr><td colspan=\"3\"><div class=\"hr\"></div></td></tr>"
						+ "<tr><td colspan=\"3\" class=\"datacolumn\">" + news.getContent() + "</td></tr>"
						+ "<tr><td colspan=\"3\"><div class=\"hr\"></div></td></tr>"
						+ "<tr>"
						+ "<td colspan=\"3\" align=\"right\">"
						+ "<a href=\"#\"class=\"close\"/><img src=\"../images/cancel.png\" border=\"0\" width=\"24\" height=\"24\" title=\"close\"></a>"
						+ "</td>"
						+ "</tr>"
						+ "</table>"
						+ "</div>");
				}
				else{
					listings.append("<div id=\"dialog"+i+"\" class=\"window ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable\">"
						+ "<p>"
						+ "<pre rel=\""+news.getTitle()+"\" class=\"prettyprint\">"
						+ "<code>"
						+ "<span class=\"pln\"><br></span>"
						+ "<p align=\"left\">"
						+ news.getContent()
						+ "</p>"
						+ "</code>"
						+ "</pre>"
						+ "<br><br>"
						+ "<a href=\"#\" class=\"close\"/><img src=\"../images/cancel.png\" border=\"0\" width=\"24\" height=\"24\" title=\"close\"></a>"
						+ "</div>");
				}

				++i;
			}
			rs.close();
			ps.close();

			listings.append("<!-- Mask to cover the whole screen -->");
			listings.append("<div id=\"mask\"></div>");
			listings.append("</div>");
		}
		catch( SQLException e ){
			logger.fatal("Helper: writeNewsDiv - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: writeNewsDiv - " + ex.toString());
		}

		return listings.toString();

	}

	/*
	 * getNews
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getNews(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id,InfoTitle,StartDate,EndDate,DatePosted,Author FROM tblInfo WHERE campus=? ORDER BY id";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											""+rs.getInt("id"),
											AseUtil.nullToBlank(rs.getString("InfoTitle")),
											ae.ASE_FormatDateTime(rs.getString("StartDate"),Constant.DATE_DATETIME),
											ae.ASE_FormatDateTime(rs.getString("EndDate"),Constant.DATE_DATETIME),
											ae.ASE_FormatDateTime(rs.getString("DatePosted"),Constant.DATE_DATETIME),
											AseUtil.nullToBlank(rs.getString("author")),
											campus,
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("IniDB - getSysSettings: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("IniDB - getSysSettings: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}