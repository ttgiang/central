/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @auditby ttgiang
 */

//
// AuthorityDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class AuthorityDB {

	static Logger logger = Logger.getLogger(AuthorityDB.class.getName());

	public AuthorityDB() throws Exception {}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	code		String
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String code) throws SQLException {
		String sql = "SELECT code FROM tblAuthority WHERE campus=? AND code=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,code);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * insertAuthority
	 * <p>
	 * @param	conn			Connection
	 * @param	Authority	Authority
	 * <p>
	 * @return	int
	 */
	public static int insertAuthority(Connection conn, Authority authority) {

		String sql = "INSERT INTO tblauthority(id,campus,code,descr,level,chair,delegated,auditby,auditdate) VALUES (?,?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,getNextID(conn));
			ps.setString(2,authority.getCampus());
			ps.setString(3,authority.getCode());
			ps.setString(4,authority.getDescr());
			ps.setInt(5,authority.getLevel());
			ps.setString(6,authority.getChair());
			ps.setString(7,authority.getDelegated());
			ps.setString(8,authority.getAuditBy());
			ps.setString(9,AseUtil.getCurrentDateTimeString());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB: insertAuthority\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB - updateAuthority: " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateAuthority
	 *	<p>
	 *	@param	conn
	 * @param	authority
	 *	<p>
	 *	@return	int
	 */
	public static int updateAuthority(Connection conn, Authority authority) {
		int rowsAffected = 0;
		String sql = "UPDATE tblAuthority SET code=?,descr=?,chair=?,delegated=?,level=? WHERE id=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,authority.getCode());
			ps.setString(2,authority.getDescr());
			ps.setString(3,authority.getChair());
			ps.setString(4,authority.getDelegated());
			ps.setInt(5,authority.getLevel());
			ps.setInt(6,authority.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB - updateAuthority: " + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB - updateAuthority: " + e.toString());
		}

		return rowsAffected;
	}
	/**
	 * deleteAuthority
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteAuthority(Connection conn,int id) {

		String sql = "DELETE FROM tblAuthority WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB: deleteAuthority\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB - updateAuthority: " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getAuthorityByID
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	<p>
	 *	@return 	Authority
	 */
	public static Authority getAuthorityByID(Connection conn,int id) {

		Authority authority = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * from tblAuthority WHERE id=?");
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				authority = new Authority();
				authority.setCode(AseUtil.nullToBlank(rs.getString("code")));
				authority.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
				authority.setChair(AseUtil.nullToBlank(rs.getString("chair")));
				authority.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
				authority.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				authority.setLevel(rs.getInt("level"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB: getAuthorityByID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB: getAuthorityByID - " + e.toString());
		}

		return authority;
	}

	/*
	 * getNextID
	 *	<p>
	 *	@return int
	 */
	public static int getNextID(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) AS maxid FROM tblAuthority";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid") + 1;
			}

			if (id==0){
				id = 1;
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AuthorityDB: getNextID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("AuthorityDB: getNextID - " + e.toString());
		}

		return id;
	}

	/*
	 * showAuthorityLevel
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String showAuthorityLevel(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{
			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"authidx\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">&nbsp;</th>"
				+ "<th align=\"left\">Code</th>"
				+ "<th align=\"left\">Description</th>"
				+ "<th align=\"left\">Responsible Persion</th>"
				+ "<th align=\"left\">Delegate Name</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			String sql = "SELECT id,Code,descr,chair,delegated FROM tblAuthority WHERE campus=? ORDER BY code";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("id");
				String code = AseUtil.nullToBlank(rs.getString("code"));
				String descr = AseUtil.nullToBlank(rs.getString("descr"));
				String chair = AseUtil.nullToBlank(rs.getString("chair"));
				String delegated = AseUtil.nullToBlank(rs.getString("delegated"));

				buf.append("<tr>"
					+ "<td align=\"left\"><a href=\"pgrchr.jsp?programid="+id+"\" class=\"linkcolumn\"><img src=\"../images/ed_link.gif\" border=\"0\" title=\"link authority level\"></a></td>"
					+ "<td align=\"left\"><a href=\"auth.jsp?lid="+id+"\" class=\"linkcolumn\">" + code + "</a></td>"
					+ "<td align=\"left\">" + descr + "</td>"
					+ "<td align=\"left\">" + chair + "</td>"
					+ "<td align=\"left\">" + delegated + "</td>"
					+ "</tr>");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("AuthorityDB - showAuthorityLevel: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("AuthorityDB - showAuthorityLevel: " + e.toString());
		}

		return buf.toString() + "</tbody></table></div></div>";
	}

	public void close() throws SQLException {}

}