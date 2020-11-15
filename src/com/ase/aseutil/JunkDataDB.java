/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// JunkDataDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class JunkDataDB {

	static Logger logger = Logger.getLogger(JunkDataDB.class.getName());

	//
	// this class allows us to park data for tempory use
	// no use may have more than 1 type of activity going on at a time.
	//

	public JunkDataDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String kix,String user) throws Exception {

		boolean exists = false;

		try{
			String sql = "SELECT id FROM tbljunkdata WHERE historyid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Park.isMatch ("+kix+"/"+user+"/"+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("Park.isMatch ("+kix+"/"+user+"/"+"): " + e.toString());
		}

		return exists;

	}

	/**
	 * delete
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param user	String
	 * <p>
	 * @return int
	 */
	public static int delete(Connection conn,String kix,String user) throws SQLException {

		String sql = "DELETE FROM tbljunkdata WHERE historyid=? AND userid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,user);
		int rowsAffected = ps.executeUpdate();
		ps.close();

		return rowsAffected;
	}

	/**
	 * insert
	 * <p>
	 * @param	conn		Connection
	 * @param	junkdata	JunkData
	 * <p>
	 * @return	int
	 */
	public static int insert(Connection conn, JunkData junkdata) {

		String sql = "INSERT INTO tbljunkdata(string1,string2,string3,string4,string5,string6,string7,string8,string9,string0,"
						+ "int1,int2,int3,int4,int5,int6,int7,int8,int9,int0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,junkdata.getString1());
			ps.setString(2,junkdata.getString2());
			ps.setString(3,junkdata.getString3());
			ps.setString(4,junkdata.getString4());
			ps.setString(5,junkdata.getString5());
			ps.setString(6,junkdata.getString6());
			ps.setString(7,junkdata.getString7());
			ps.setString(8,junkdata.getString8());
			ps.setString(9,junkdata.getString9());
			ps.setString(10,junkdata.getString0());
			ps.setInt(11,junkdata.getInt1());
			ps.setInt(12,junkdata.getInt2());
			ps.setInt(13,junkdata.getInt3());
			ps.setInt(14,junkdata.getInt4());
			ps.setInt(15,junkdata.getInt5());
			ps.setInt(16,junkdata.getInt6());
			ps.setInt(17,junkdata.getInt7());
			ps.setInt(18,junkdata.getInt8());
			ps.setInt(19,junkdata.getInt9());
			ps.setInt(20,junkdata.getInt0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("junkdata - insert: " + e.toString());
		} catch (Exception e) {
			logger.fatal("junkdata - insert: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertStrings
	 * <p>
	 * @param	conn		Connection
	 * @param	generic	Generic
	 * <p>
	 * @return	int
	 */
	public static int insertStrings(Connection conn, JunkData junkdata) {

		String sql = "INSERT INTO tbljunkdata(string1,string2,string3,string4,string5,string6,string7,string8,string9,string0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,junkdata.getString1());
			ps.setString(2,junkdata.getString2());
			ps.setString(3,junkdata.getString3());
			ps.setString(4,junkdata.getString4());
			ps.setString(5,junkdata.getString5());
			ps.setString(6,junkdata.getString6());
			ps.setString(7,junkdata.getString7());
			ps.setString(8,junkdata.getString8());
			ps.setString(9,junkdata.getString9());
			ps.setString(10,junkdata.getString0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("junkdata - insertStrings: " + e.toString());
		} catch (Exception e) {
			logger.fatal("junkdata - insertStrings: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertStringsWithKeys
	 * <p>
	 * @param	conn		Connection
	 * @param	generic	Generic
	 * <p>
	 * @return	int
	 */
	public static int insertStringsWithKeys(Connection conn, JunkData junkdata) {

		String sql = "INSERT INTO tbljunkdata(campus,userid,historyid,coursealpha,coursenum,coursetype,descr,"
					+ "string1,string2,string3,string4,string5,string6,string7,string8,string9,string0) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,junkdata.getCampus());
			ps.setString(2,junkdata.getUserId());
			ps.setString(3,junkdata.getHistoryId());
			ps.setString(4,junkdata.getCourseAlpha());
			ps.setString(5,junkdata.getCourseNum());
			ps.setString(6,junkdata.getCourseType());
			ps.setString(7,junkdata.getDescr());
			ps.setString(8,junkdata.getString1());
			ps.setString(9,junkdata.getString2());
			ps.setString(10,junkdata.getString3());
			ps.setString(11,junkdata.getString4());
			ps.setString(12,junkdata.getString5());
			ps.setString(13,junkdata.getString6());
			ps.setString(14,junkdata.getString7());
			ps.setString(15,junkdata.getString8());
			ps.setString(16,junkdata.getString9());
			ps.setString(17,junkdata.getString0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("junkdata - insertStringsWithKeys: " + e.toString());
		} catch (Exception e) {
			logger.fatal("junkdata - insertStringsWithKeys: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertInts
	 * <p>
	 * @param	conn		Connection
	 * @param	junkdata	junkdata
	 * <p>
	 * @return	int
	 */
	public static int insertInts(Connection conn, JunkData junkdata) {

		String sql = "INSERT INTO tbljunkdata(int1,int2,int3,int4,int5,int6,int7,int8,int9,int0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,junkdata.getInt1());
			ps.setInt(2,junkdata.getInt2());
			ps.setInt(3,junkdata.getInt3());
			ps.setInt(4,junkdata.getInt4());
			ps.setInt(5,junkdata.getInt5());
			ps.setInt(6,junkdata.getInt6());
			ps.setInt(7,junkdata.getInt7());
			ps.setInt(8,junkdata.getInt8());
			ps.setInt(9,junkdata.getInt9());
			ps.setInt(10,junkdata.getInt0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("junkdata - insertInts: " + e.toString());
		} catch (Exception e) {
			logger.fatal("junkdata - insertInts: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}