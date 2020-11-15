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
// TablesDB.java
//
package com.ase.aseutil.io;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ase.aseutil.AseUtil;

import org.apache.log4j.Logger;

public class TablesDB {

	static Logger logger = Logger.getLogger(TablesDB.class.getName());

	public TablesDB() throws Exception {}

	/**
	 * getTable
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * <p>
	 * @return	Tables
	 */
	public static Tables getTable(Connection conn,String table) {

		Tables tables = null;
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tblTabs WHERE importtype=?");
			ps.setString(1,table);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				tables = new Tables();
				tables.setTab(AseUtil.nullToBlank(rs.getString("tab")));
				tables.setAlpha(AseUtil.nullToBlank(rs.getString("alpha")));
				tables.setNum(AseUtil.nullToBlank(rs.getString("num")));
				tables.setImportColumns(rs.getInt("importcolumns"));
				tables.setImportColumnName(AseUtil.nullToBlank(rs.getString("importcolumnname")));
				tables.setImprt(rs.getBoolean("imprt"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TablesDB: getTable\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("TablesDB: getTable\n" + ex.toString());
		}

		return tables;
	}

	public void close() throws SQLException {}

}