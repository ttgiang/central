/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// GenericDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class GenericDB {

	static Logger logger = Logger.getLogger(GenericDB.class.getName());

	public GenericDB() throws Exception {}

	/**
	 * clearTable
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 */
	public static void clearTable(Connection conn) {

		String sql = "DELETE FROM tblGeneric";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Generic - clearTable: " + e.toString());
		} catch (Exception e) {
			logger.fatal("Generic - clearTable: " + e.toString());
		}

	}

	/**
	 * insert
	 * <p>
	 * @param	conn		Connection
	 * @param	generic	Generic
	 * <p>
	 * @return	int
	 */
	public static int insert(Connection conn, Generic generic) {

		String sql = "INSERT INTO tblGeneric(string1,string2,string3,string4,string5,string6,string7,string8,string9,string0,"
						+ "int1,int2,int3,int4,int5,int6,int7,int8,int9,int0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,generic.getString1());
			ps.setString(2,generic.getString2());
			ps.setString(3,generic.getString3());
			ps.setString(4,generic.getString4());
			ps.setString(5,generic.getString5());
			ps.setString(6,generic.getString6());
			ps.setString(7,generic.getString7());
			ps.setString(8,generic.getString8());
			ps.setString(9,generic.getString9());
			ps.setString(10,generic.getString0());
			ps.setInt(11,generic.getInt1());
			ps.setInt(12,generic.getInt2());
			ps.setInt(13,generic.getInt3());
			ps.setInt(14,generic.getInt4());
			ps.setInt(15,generic.getInt5());
			ps.setInt(16,generic.getInt6());
			ps.setInt(17,generic.getInt7());
			ps.setInt(18,generic.getInt8());
			ps.setInt(19,generic.getInt9());
			ps.setInt(20,generic.getInt0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Generic - insert: " + e.toString());
		} catch (Exception e) {
			logger.fatal("Generic - insert: " + e.toString());
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
	public static int insertStrings(Connection conn, Generic generic) {

		String sql = "INSERT INTO tblGeneric(string1,string2,string3,string4,string5,string6,string7,string8,string9,string0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,generic.getString1());
			ps.setString(2,generic.getString2());
			ps.setString(3,generic.getString3());
			ps.setString(4,generic.getString4());
			ps.setString(5,generic.getString5());
			ps.setString(6,generic.getString6());
			ps.setString(7,generic.getString7());
			ps.setString(8,generic.getString8());
			ps.setString(9,generic.getString9());
			ps.setString(10,generic.getString0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Generic - insertStrings: " + e.toString());
		} catch (Exception e) {
			logger.fatal("Generic - insertStrings: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertInts
	 * <p>
	 * @param	conn		Connection
	 * @param	generic	Generic
	 * <p>
	 * @return	int
	 */
	public static int insertInts(Connection conn, Generic generic) {

		String sql = "INSERT INTO tblGeneric(int1,int2,int3,int4,int5,int6,int7,int8,int9,int0) "
						+ "VALUES (?,?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,generic.getInt1());
			ps.setInt(2,generic.getInt2());
			ps.setInt(3,generic.getInt3());
			ps.setInt(4,generic.getInt4());
			ps.setInt(5,generic.getInt5());
			ps.setInt(6,generic.getInt6());
			ps.setInt(7,generic.getInt7());
			ps.setInt(8,generic.getInt8());
			ps.setInt(9,generic.getInt9());
			ps.setInt(10,generic.getInt0());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Generic - insertInts: " + e.toString());
		} catch (Exception e) {
			logger.fatal("Generic - insertInts: " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}