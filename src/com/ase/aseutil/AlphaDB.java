/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 */

//
// AlphaDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class AlphaDB {

	static Logger logger = Logger.getLogger(AlphaDB.class.getName());

	public AlphaDB() throws Exception {}

	/*
	 * deleteAlpha
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		String
	 *	<p>
	 *	@return	int
	 */
	public static int deleteAlpha(Connection conn, String id) {
		int rowsAffected = 0;
		String sql = "DELETE FROM BannerAlpha WHERE COURSE_ALPHA=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AlphaDB - deleteAlpha: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * getDescription
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	String
	 *	<p>
	 *	@return	String
	 */
	public static String getDescription(Connection conn, String alpha) {
		String description = "";
		String sql = "SELECT ALPHA_DESCRIPTION FROM BannerAlpha WHERE COURSE_ALPHA=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				description = rs.getString(1);

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AlphaDB - getDescription: " + e.toString());
		}
		return description;
	}

	/*
	 * insertAlpha
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	Alpha
	 *	<p>
	 *	@return	boolean
	 */
	public static int insertAlpha(Connection conn,String code,String discipline) {

		Alpha alpha = new Alpha(code,discipline);

		return insertAlpha(conn,alpha);
	}

	/*
	 * insertAlpha
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	Alpha
	 *	<p>
	 *	@return	boolean
	 */
	public static int insertAlpha(Connection conn, Alpha alpha) {
		int rowsAffected = 0;
		String sql = "INSERT INTO BannerAlpha (COURSE_ALPHA, ALPHA_DESCRIPTION) VALUES (?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha.getCourseAlpha());
			ps.setString(2,alpha.getDiscipline());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AlphaDB - insertAlpha: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	String
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,String alpha) throws SQLException {
		String sql = "SELECT COURSE_ALPHA FROM BannerAlpha WHERE COURSE_ALPHA=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,alpha);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * updateAlpha
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	Alpha
	 *	<p>
	 *	@return	int
	 */
	public static int updateAlpha(Connection conn, Alpha alpha) {
		int rowsAffected = 0;
		String sql = "UPDATE BannerAlpha SET ALPHA_DESCRIPTION=? WHERE COURSE_ALPHA=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha.getDiscipline());
			ps.setString(2,alpha.getCourseAlpha());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AlphaDB - updateAlpha: " + e.toString());
		}
		return rowsAffected;
	}

	public void close() throws SQLException {}


}