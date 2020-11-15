/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 *	public static String getStatement(Connection conn,String campus,String stmt) throws Exception {
 *	public static boolean statementExists(Connection conn,String campus,String stmt) throws Exception {
 *
 */

//
// StmtDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class StmtDB {
	static String deleteSQL;

	static String insertSQL;

	static String updateSQL;

	static {
		deleteSQL = "DELETE FROM tblStatement WHERE id = ?";
		insertSQL = "INSERT INTO tblStatement (type, statement, campus, auditby) VALUES (?,?,?,?)";
		updateSQL = "UPDATE tblStatement SET Type=?, statement=?, campus=?, auditby=?, auditdate=? WHERE id =?";
	}

	static Logger logger = Logger.getLogger(StmtDB.class.getName());

	public StmtDB() throws Exception {
	}

	public static int insertStmt(Connection connection, Stmt stmt) {
		int rowsAffected = 0;
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, stmt.getType());
			preparedStatement.setString(2, stmt.getStmt());
			preparedStatement.setString(3, stmt.getCampus());
			preparedStatement.setString(4, stmt.getAuditBy());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		}
		return rowsAffected;
	}

	public static int deleteStmt(Connection connection, String id) {
		int rowsAffected = 0;
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement(deleteSQL);
			preparedStatement.setString(1, id);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		}
		return rowsAffected;
	}

	public static int updateStmt(Connection connection, Stmt stmt) {
		int rowsAffected = 0;
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement(updateSQL);
			preparedStatement.setString(1, stmt.getType());
			preparedStatement.setString(2, stmt.getStmt());
			preparedStatement.setString(3, stmt.getCampus());
			preparedStatement.setString(4, stmt.getAuditBy());
			preparedStatement.setString(5, stmt.getAuditDate());
			preparedStatement.setString(6, stmt.getId());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * getStatement
	 * <p>
	 * @return stmt
	 */
	public static Stmt getStatement(Connection connection, int id, String campus)
			throws Exception {

		String sql = "SELECT id,type,campus,statement,auditby,auditdate FROM tblStatement WHERE id=? AND campus=?";
		Stmt stmt = new Stmt();
		AseUtil aseUtil = new AseUtil();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, String.valueOf(id));
			preparedStatement.setString(2, campus);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				stmt.setId(resultSet.getString(1).trim());
				stmt.setType(resultSet.getString(2).trim());
				stmt.setCampus(resultSet.getString(3).trim());
				stmt.setStmt(resultSet.getString(4).trim());
				stmt.setAuditBy(resultSet.getString(5).trim());
				stmt.setAuditDate(aseUtil.ASE_FormatDateTime(resultSet.getString(6),Constant.DATE_DATETIME));
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			logger.fatal("StmtDB: getStatement\n" + e.toString());
			stmt = null;
		}

		return stmt;
	}

	/*
	 * statementExists
	 * <p>
	 * @return boolean
	 */
	public static boolean statementExists(Connection conn,String campus,String stmt) throws Exception {

		String sql = "SELECT id FROM tblStatement WHERE campus=? AND type=?";

		boolean exists = false;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,stmt);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("StmtDB: statementExists - " + e.toString());
		} catch (Exception e) {
			logger.fatal("StmtDB: statementExists - " + e.toString());
		}

		return exists;
	}

	/*
	 * getStatement
	 * <p>
	 * @return String
	 */
	public static Stmt getStatement(Connection conn,String campus,String s) throws Exception {

		String sql = "SELECT id,type,campus,statement,auditby,auditdate  FROM tblStatement WHERE campus=? AND type=?";

		Stmt stmt = null;

		AseUtil aseUtil = new AseUtil();

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,s);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				stmt = new Stmt();
				stmt.setId(AseUtil.nullToBlank(rs.getString(1)));
				stmt.setType(AseUtil.nullToBlank(rs.getString(2)));
				stmt.setCampus(AseUtil.nullToBlank(rs.getString(3)));
				stmt.setStmt(AseUtil.nullToBlank(rs.getString(4)));
				stmt.setAuditBy(AseUtil.nullToBlank(rs.getString(5)));
				stmt.setAuditDate(aseUtil.ASE_FormatDateTime(AseUtil.nullToBlank(rs.getString(6)),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("StmtDB: getStatement - " + e.toString());
		} catch (Exception e) {
			logger.fatal("StmtDB: getStatement - " + e.toString());
		}

		return stmt;
	}

	/*
	 * getCatalogStatement - returns the template used to create catalog
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getCatalogStatement(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		String sql = "SELECT statement FROM tblStatement WHERE campus=? AND type=?";

		String statement = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"Catalog");
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				statement = AseUtil.nullToBlank(rs.getString("statement"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("StmtDB: getCatalogStatement - " + e.toString());
		} catch (Exception e) {
			logger.fatal("StmtDB: getCatalogStatement - " + e.toString());
		}

		return statement;
	}

	public void close() throws SQLException {
	}

}