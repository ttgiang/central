/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// TestDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class TestDB {

	static Logger logger = Logger.getLogger(TestDB.class.getName());

	public TestDB() throws Exception {}

	/**
	 * insertTest
	 * <p>
	 * @param	conn	Connection
	 * @param	test	Test
	 * <p>
	 * @return	int
	 */
	public static int insertTest(Connection conn,String campus,String kix,String tabo,String text1) {

		String sql = "INSERT INTO tblTest(campus,historyid,tabo,text1) VALUES (?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,tabo);
			ps.setString(4,text1);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TestDB: insertTest\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteTest
	 * <p>
	 * @param	conn	Connection
	 * @param	tabo	String
	 * @param	kix	String
	 * <p>
	 * @return	int
	 */
	public static int deleteTest(Connection conn,String tabo,String kix) {

		String sql = "DELETE FROM tblTest WHERE tabo=? AND historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,tabo);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TestDB: deleteTest\n" + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}