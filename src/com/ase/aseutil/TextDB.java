/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int deleteText(Connection conn,String kix,int id) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Text getText(Connection conn,String kix,int id) {
 * public static String getTextAsHTMLList(Connection connection,String kix)
 *	public static int insertText(Connection conn, Text text)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateText(Connection conn, Text text) {
 *
 * @author ttgiang
 */

//
// TextDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class TextDB {

	static Logger logger = Logger.getLogger(TextDB.class.getName());

	public TextDB() throws Exception {}

	/**
	 * insertText
	 * <p>
	 * @param	conn	Connection
	 * @param	text	Text
	 * <p>
	 * @return	int
	 */
	public static int insertText(Connection conn, Text text) {

		String sql = "INSERT INTO tblText(historyid,title,edition,author,publisher,yeer,isbn) VALUES (?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,text.getHistoryid());
			ps.setString(2,text.getTitle());
			ps.setString(3,text.getEdition());
			ps.setString(4,text.getAuthor());
			ps.setString(5,text.getPublisher());
			ps.setString(6,text.getYeer());
			ps.setString(7,text.getIsbn());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TextDB: insertText\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteText
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteText(Connection conn,String kix,int id) {

		String sql = "DELETE FROM tblText WHERE historyid=? AND seq=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TextDB: deleteText\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateText
	 * <p>
	 * @param	conn	Connection
	 * @param	text	Text
	 * <p>
	 * @return	int
	 */
	public static int updateText(Connection conn, Text text) {

		String sql = "UPDATE tblText SET title=?,edition=?,author=?,publisher=?,yeer=?,isbn=? "
			+ "WHERE historyid=? AND seq=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,text.getTitle());
			ps.setString(2,text.getEdition());
			ps.setString(3,text.getAuthor());
			ps.setString(4,text.getPublisher());
			ps.setString(5,text.getYeer());
			ps.setString(6,text.getIsbn());
			ps.setString(7,text.getHistoryid());
			ps.setInt(8,text.getSeq());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TextDB: updateText\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getText
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	seq	int
	 * <p>
	 * @return	Text
	 */
	public static Text getText(Connection conn,String kix,int seq) {

		String sql = "SELECT * FROM tblText WHERE historyid=? AND seq=?";
		Text text = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				text = new Text();
				text.setHistoryid(aseUtil.nullToBlank(rs.getString("historyid")));
				text.setTitle(aseUtil.nullToBlank(rs.getString("title")));
				text.setEdition(aseUtil.nullToBlank(rs.getString("edition")));
				text.setAuthor(aseUtil.nullToBlank(rs.getString("author")));
				text.setPublisher(aseUtil.nullToBlank(rs.getString("publisher")));
				text.setYeer(aseUtil.nullToBlank(rs.getString("yeer")));
				text.setIsbn(aseUtil.nullToBlank(rs.getString("isbn")));
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TextDB: getText\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("TextDB: getText\n" + ex.toString());
		}

		return text;
	}

	/*
	 * getTextAsHTMLList
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return String
	 */
	public static String getTextAsHTMLList(Connection connection,String kix) throws Exception {

		String sql = "";
		StringBuffer contents = new StringBuffer();
		boolean found = false;
		String temp = "";

		sql = "SELECT title,edition,author,publisher,yeer,isbn FROM tblText WHERE historyid=?";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;

				String author = AseUtil.nullToBlank(rs.getString("author"));
				if (!author.equals(Constant.BLANK)){
					author = author + ".&nbsp;";
				}

				String title = AseUtil.nullToBlank(rs.getString("title"));
				if (!title.equals(Constant.BLANK)){
					title = "<u>" + title + "</u>.&nbsp;";
				}

				String edition = AseUtil.nullToBlank(rs.getString("edition"));
				if (!edition.equals(Constant.BLANK)){
					edition = edition + ".&nbsp;";
				}

				String publisher = AseUtil.nullToBlank(rs.getString("publisher"));
				if (!publisher.equals(Constant.BLANK)){
					publisher = publisher + ",&nbsp;";
				}

				String yeer = AseUtil.nullToBlank(rs.getString("yeer"));
				if (!yeer.equals(Constant.BLANK)){
					yeer = yeer;
				}

				String isbn = AseUtil.nullToBlank(rs.getString("isbn"));
				if (!isbn.equals(Constant.BLANK)){
					isbn = ",&nbsp;" + isbn + ".";
				}
				else{
					isbn = ".";
				}

				contents.append("<li class=\"datacolumn\">"
					+ author
					+ title
					+ edition
					+ publisher
					+ yeer
					+ isbn
					+ "<br/><br/>");
				contents.append("</li>");
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td>&nbsp;</td></tr>" +
					"<tr><td><ul>" +
					contents.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("TextDB: getTextAsHTMLList\n" + e.toString());
		}

		return temp;
	}


	/*
	 * getContentForEdit
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * <p>
	 * @return String
	 */
	public static String getContentForEdit(Connection connection,String kix) throws SQLException {

		String sql = "";
		int seq = 0;
		String title = "";
		String author = "";
		StringBuffer buf = new StringBuffer();

		sql = "SELECT seq,title,author " +
				"FROM tblText " +
				"WHERE historyid=?";

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>"
				+ "<td width=\"50%\" valign=\"top\" class=\"textblackTH\">Title</td>"
				+ "<td width=\"47%\" valign=\"top\" class=\"textblackTH\">Author</td><tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt(1);
				title = aseUtil.nullToBlank(rs.getString(2));
				author = aseUtil.nullToBlank(rs.getString(3));

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
					+ "<img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\" onclick=\"return aseSubmitClick3(\'" + kix + "\'," + seq + "); \">&nbsp;"
					+ "<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + kix + "\'," + seq + ");\">"
					+ "<td valign=\"top\" class=\"datacolumn\">" + title + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + author + "</td></tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("TextDB: getContentForEdit\n" + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("TextDB: getContentForEdit\n" + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/**
	 * showText
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	term		String
	 * <p>
	 * @return	String
	 */
	public static String showText(Connection conn,String campus,String type){

		return showText(conn,campus,type,Constant.BLANK);
	}

	public static String showText(Connection conn,String campus,String type,String term){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String coursetitle = "";
		String author = "";
		String title = "";
		String edition = "";
		String publisher = "";
		String yeer = "";
		String isbn = "";
		boolean found = false;
		String temp = "";

		String holdAlpha = "";

		try{
			String sql = SQL.textMaterials;
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,type);
			ps.setString(3,term);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				author = AseUtil.nullToBlank(rs.getString("author"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				edition = AseUtil.nullToBlank(rs.getString("edition"));
				publisher = AseUtil.nullToBlank(rs.getString("publisher"));
				yeer = AseUtil.nullToBlank(rs.getString("yeer"));
				isbn = AseUtil.nullToBlank(rs.getString("isbn"));

				if (holdAlpha.equals(Constant.BLANK) || !alpha.equals(holdAlpha)){
					holdAlpha = alpha;
				}
				else{
					alpha = "";
				}

				listing.append("<tr class=\"\">"
					+ "<td valign=\"top\" class=\"datacolumn\">" + alpha + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + num + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + coursetitle + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + author + "</td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + title + "</td></tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>"
					+ "<tr class=\"textblackTRTheme\">"
					+ "<td width=\"05%\" valign=\"top\" class=\"textblackTH\">Alpha</td>"
					+ "<td width=\"05%\" valign=\"top\" class=\"textblackTH\">Num</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Course Title</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Author</td>"
					+ "<td width=\"30%\" valign=\"top\" class=\"textblackTH\">Book Title</td></tr>"
					+ listing.toString()
					+ "</table>";
			}
		}
		catch(Exception ex){
			logger.fatal("TextDB: showText\n" + ex.toString());
		}

		return temp;
	}

	public void close() throws SQLException {}

}