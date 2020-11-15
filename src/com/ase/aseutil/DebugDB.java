/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// DebugDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

public class DebugDB {

	static Logger logger = Logger.getLogger(DebugDB.class.getName());

	public DebugDB() throws Exception {}

	/*
	 * isMatch
	 *	<p>
	 *	@param	connection	Connection
	 * @param	page			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection connection,String page) throws SQLException {
		String query = "SELECT id FROM tblDebug WHERE page='" + SQLUtil.encode(page) + "'";
		Statement statement = connection.createStatement();
		ResultSet results = statement.executeQuery(query);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/**
	 * insertDebug
	 * <p>
	 * @param	conn	Connection
	 * @param	dbg	Debug
	 * <p>
	 * @return	int
	 */
	public static int insertDebug(Connection conn,Debug dbg) {

		String sql = "INSERT INTO tblDebug(page,debug) VALUES (?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,dbg.getPage());
			ps.setBoolean(2,dbg.getDebug());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DebugDB: insertSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteDebug
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteDebug(Connection conn,String id) {

		String sql = "DELETE FROM tblDebug WHERE page=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DebugDB: deleteSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateDebug
	 * <p>
	 * @param	conn	Connection
	 * @param	dbg	Debug
	 * <p>
	 * @return	int
	 */
	public static int updateDebug(Connection conn,Debug dbg) {

		String sql = "UPDATE tblDebug SET debug=? WHERE page=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1,dbg.getDebug());
			ps.setString(2,dbg.getPage());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DebugDB: updateSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateObjectDebug
	 * <p>
	 * @param	conn			Connection
	 * @param	objectName	String
	 * <p>
	 * @return	int
	 */
	public static int updateObjectDebug(Connection conn,String objectName) {

		String sql = "UPDATE tblDebug SET debug=? WHERE page=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1,true);
			ps.setString(2,objectName);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DebugDB: updateObjectDebug - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateDebug
	 * <p>
	 * @param	conn	Connection
	 * @param	page	String
	 * @param	debug	boolean
	 * <p>
	 * @return	int
	 */
	public static int updateDebug(Connection conn,String page,boolean debug) {

		String sql = "UPDATE tblDebug SET debug=? WHERE page=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1,debug);
			ps.setString(2,page);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DebugDB: updateDebug - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getDebug
	 *	<p>
	 *	@param	conn	Connection
	 * @param	page	String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean getDebug(Connection conn,String page) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		try {
			if (page != null && page.length() > 0){
				String sql = "SELECT debug FROM tblDebug WHERE "
					+ "id = (select case when (MAX(id) is null) then 0 else max(id) end FROM tblDebug AS tbl WHERE page=?) AND (page=?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,page);
				ps.setString(2,page);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					debug = rs.getBoolean(1);
				}
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("DebugDB.getDebug ("+page+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("DebugDB.getDebug ("+page+"): " + e.toString());
		}

		return debug;
	}

	/*
	 * tabs
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public static Msg fillDebugTables(){

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;
		Msg msg = new Msg();

		AsePool connectionPool = null;
		Connection conn = null;

		int rowsAffected = 0;

		try{
			if (debug) logger.info("-------------------- Debug Fill - START");

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			// add tables not already saved
			String sql = "INSERT INTO tbldebug (page,debug) "
					+ "SELECT name,0 "
					+ "FROM sysobjects "
					+ "WHERE type='U' AND NAME NOT IN (SELECT page FROM tbldebug)";
			PreparedStatement ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Inserted " + rowsAffected + " rows");
			ps.close();

			// there is a chance we'll have dups
			sql = "DELETE FROM tblDebug WHERE (id NOT IN (SELECT MAX(id) AS maxid FROM tblDebug GROUP BY page))";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Removed " + rowsAffected + " duplicate rows");
			ps.close();

			if (debug) logger.info("-------------------- Debug Fill - END");
		}
		catch( SQLException e ){
			logger.fatal("Tables: tabs - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("Tables: tabs - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			connectionPool.freeConnection(conn,"DebugDB","SYSADM");
		}

		return msg;
	}

		/**
		 * clearDebugFlags
		 * <p>
		 * @param	conn	Connection
		 * <p>
		 * @return	int
		 */
		public static int clearDebugFlags(Connection conn) {

			String sql = "UPDATE tblDebug SET debug=0";
			int rowsAffected = 0;
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
			} catch (SQLException e) {
				logger.fatal("DebugDB: clearDebugFlags - " + e.toString());
			}

			return rowsAffected;
		}

	public void close() throws SQLException {}

}