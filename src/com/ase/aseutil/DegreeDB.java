/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * public static String getDegree(Connection conn,String campus,String Degree)
 *
 * @author ttgiang
 */

//
// DegreeDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class DegreeDB {
	static Logger logger = Logger.getLogger(DegreeDB.class.getName());

	public DegreeDB() throws Exception {}

	/*
	 * getCampusDegree
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	<p>
	 *	@return 	Degree
	 */
	public static Degree getCampusDegree(Connection conn,int id) {

		Degree degree = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tblprogramdegree WHERE degreeid=?");
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				degree = new Degree();
				degree.setAlpha(AseUtil.nullToBlank(rs.getString("alpha")));
				degree.setTitle(AseUtil.nullToBlank(rs.getString("title")));
				degree.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
				degree.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DegreeDB: getCampusDegree - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DegreeDB: getCampusDegree - " + e.toString());
		}

		return degree;
	}

	/*
	 * deleteDegree
	 *	<p>
	 *	@param	conn
	 * @param	id
	 *	<p>
	 *	@return	int
	 */
	public static int deleteDegree(Connection conn,int id) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblprogramdegree WHERE degreeid=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DegreeDB - deleteDegree: " + e.toString());
		}
		return rowsAffected;
	}


	/*
	 * insertDegree
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	Alpha
	 *	<p>
	 *	@return	boolean
	 */
	public static int insertDegree(Connection conn, Degree degree) {
		int rowsAffected = 0;
		String sql = "INSERT INTO tblprogramdegree (alpha,title,descr,campus) VALUES (?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,degree.getAlpha());
			ps.setString(2,degree.getTitle());
			ps.setString(3,degree.getDescr());
			ps.setString(4,degree.getCampus());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DegreeDB - insertDegree: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String alpha) throws SQLException {
		String sql = "SELECT alpha FROM tblprogramdegree WHERE campus=? AND alpha=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * updateDegree
	 *	<p>
	 *	@param	conn
	 * @param	Degree
	 *	<p>
	 *	@return	int
	 */
	public static int updateDegree(Connection conn, Degree degree) {
		int rowsAffected = 0;
		String sql = "UPDATE tblprogramdegree SET alpha=?,title=?,descr=? WHERE degreeid=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,degree.getAlpha());
			ps.setString(2,degree.getTitle());
			ps.setString(3,degree.getDescr());
			ps.setInt(4,degree.getDegreeId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DegreeDB - updateDegree: " + e.toString());
		}
		return rowsAffected;
	}

	public void close() throws SQLException {}

}