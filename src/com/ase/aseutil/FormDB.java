/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteForm(Connection conn,String campus,int id) {
 * public static String getgetContentForEdit(Connection connection,String campus)
 *	public static Form getText(Connection conn,String campus,int id) {
 * public static String getTextAsHTMLList(Connection connection,String campus)
 *	public static int insertForm(Connection conn, Form form)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateForm(Connection conn, Form form) {
 *
 * @descr ttgiang
 */

//
// FormDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class FormDB {

	static Logger logger = Logger.getLogger(FormDB.class.getName());

	public FormDB() throws Exception {}

	/**
	 * insertForm
	 * <p>
	 * @param	conn	Connection
	 * @param	form	Form
	 * <p>
	 * @return	int
	 */
	public static int insertForm(Connection conn, Form form) {

		String sql = "INSERT INTO tblForms(campus,title,link,descr) VALUES (?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,form.getCampus());
			ps.setString(2,form.getTitle());
			ps.setString(3,form.getLink());
			ps.setString(4,form.getDescr());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FormDB: insertForm - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteForm
	 * <p>
	 * @param	conn		Connection
	 * @param	id			int
	 * <p>
	 * @return	int
	 */
	public static int deleteForm(Connection conn,int id) {

		String sql = "DELETE FROM tblForms WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FormDB: deleteForm - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateForm
	 * <p>
	 * @param	conn	Connection
	 * @param	form	Form
	 * <p>
	 * @return	int
	 */
	public static int updateForm(Connection conn, Form form) {

		String sql = "UPDATE tblForms SET title=?,link=?,descr=? "
			+ "WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,form.getTitle());
			ps.setString(2,form.getLink());
			ps.setString(3,form.getDescr());
			ps.setInt(4,form.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FormDB: updateForm - " + e.toString());
		}

		return rowsAffected;
	}


	/**
	 * getForm
	 * <p>
	 * @param	conn		Connection
	 * @param	id			int
	 * <p>
	 * @return	Form
	 */
	public static Form getForm(Connection conn,int id) {

		String sql = "SELECT * FROM tblForms WHERE id=?";
		Form form = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				form = new Form();
				form.setTitle(aseUtil.nullToBlank(rs.getString("title")));
				form.setLink(aseUtil.nullToBlank(rs.getString("link")));
				form.setDescr(aseUtil.nullToBlank(rs.getString("descr")));
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FormDB: getForm - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("FormDB: getForm - " + ex.toString());
		}

		return form;
	}

	/*
	 * getContentForEdit
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * <p>
	 * @return String
	 */
	public static String getContentForEdit(Connection conn,String campus) throws SQLException {

		String sql = "";
		int id = 0;
		String title = "";
		String descr = "";
		String link = "";
		StringBuffer buf = new StringBuffer();

		sql = "SELECT id,title,descr,link " +
				"FROM tblForms " +
				"WHERE campus=?";

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>"
				+ "<td width=\"50%\" valign=\"top\" class=\"textblackTH\">Title</td>"
				+ "<td width=\"47%\" valign=\"top\" class=\"textblackTH\">Descr</td><tr>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				title = aseUtil.nullToBlank(rs.getString(2));
				descr = aseUtil.nullToBlank(rs.getString(3));
				link = aseUtil.nullToBlank(rs.getString(4));

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
					+ "<img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\" onclick=\"return aseSubmitClick3(\'" + campus + "\'," + id + "); \">&nbsp;"
					+ "<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + campus + "\'," + id + ");\">"
					+ "<td valign=\"top\" class=\"datacolumn\"><a href=\""+link+"\" target=\"_blank\" class=\"linkcolumn\">" + title + "</a></td>"
					+ "<td valign=\"top\" class=\"datacolumn\">" + descr + "</td></tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("FormDB: getContentForEdit - " + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("FormDB: getContentForEdit - " + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/*
	 * getTextAsHTMLList
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	<p>
	 * @return String
	 */
	public static String getTextAsHTMLList(Connection connection,String campus) throws Exception {

		String sql = "";
		StringBuffer contents = new StringBuffer();
		boolean found = false;
		String temp = "";
		String title = "";
		String link = "";
		String image = "";
		String ext = "";

		sql = "SELECT title,link FROM tblForms WHERE campus=? ORDER BY title";

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				title = rs.getString("title");
				link = rs.getString("link");
				image = "<img src=\"/central/images/ext/"+AseUtil2.getFileExtension(link)+".gif\" border=\"0\">&nbsp;";
				title = "<a href=\""+link+"\" target=\"_blank\" class=\"linkcolumn\">"+title+"</a>";
				contents.append("<li class=\"datacolumn\">" + image + title + "</li>");
				found = true;
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
			else {
				temp = "Forms not found";
			}

		} catch (Exception e) {
			logger.fatal("FormDB: getTextAsHTMLList - " + e.toString());
		}

		return temp;
	}

	public void close() throws SQLException {}

}