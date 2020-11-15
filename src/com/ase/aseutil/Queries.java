/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static String getDistinctAlpha(Connection conn,String campus,boolean htmlSelect)
 *	public static boolean isDivisionChair(Connection conn,String user)
 *
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class Queries {
	static Logger logger = Logger.getLogger(Queries.class.getName());

	/*
	 * getDistinctAlpha
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 *	@param	htmlSelect	boolean
	 *	<p>
	 *	@return String
	 */
	public static String getDistinctAlpha(Connection conn,String campus,boolean htmlSelect) throws SQLException {

		StringBuffer list = new StringBuffer();
		String alpha = "";

		String sql = "SELECT DISTINCT coursealpha "
			+ "FROM tblCourse "
			+ "WHERE campus=? "
			+ "ORDER BY coursealpha";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				list.append("<option value=\""+alpha+"\">"+alpha+"</option>");
			}
			rs.close();
			ps.close();

			alpha = "<select name=\"alpha\" class=\"smalltext\">"
				+ "<option selected value=\"\"></option>"
				+ list.toString()
				+ "</select>";

		} catch (Exception e) {
			logger.fatal("Queries: getDistinctAlpha\n" + e.toString());
		}

		return alpha;
	}

	/*
	 * isDivisionChair
	 *	<p>
	 *	@param	conn	Connection
	 * @param	user	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isDivisionChair(Connection conn,String user) throws SQLException {

		boolean divisionChair = false;

		try {
			String query = "SELECT userid FROM tblUsers WHERE userid=? AND position like '%DIVISION%'";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				divisionChair = true;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Queries: isDivisionChair\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("Queries: isDivisionChair\n" + ex.toString());
		}

		return divisionChair;
	}

}