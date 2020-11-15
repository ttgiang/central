/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteSys(Connection conn,String kix,int id) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Sys getSys(Connection conn,String kix,int id) {
 *	public static Sys getSysDB(Connection conn,String named) {
 * public static String getSysAsHTMLList(Connection connection,String kix)
 *	public static int insertSys(Connection conn, Sys Sys)
 *	public static int showSys(Connection conn,String campus,String type) {
 *	public static int updateSys(Connection conn, Sys Sys) {
 *
 * @author ttgiang
 */

//
// SysDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class SysDB {

	static Logger logger = Logger.getLogger(SysDB.class.getName());

	public SysDB() throws Exception {}

	/*
	 * isMatch
	 *	<p>
	 *	@param	connection	Connection
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection connection,String named) throws SQLException {
		String query = "SELECT id FROM tblSystem WHERE named='" + SQLUtil.encode(named) + "'";
		Statement statement = connection.createStatement();
		ResultSet results = statement.executeQuery(query);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/**
	 * insertSys
	 * <p>
	 * @param	conn	Connection
	 * @param	sys	Sys
	 * <p>
	 * @return	int
	 */
	public static int insertSys(Connection conn, Sys sys) {

		String sql = "INSERT INTO tblSystem(campus,named,valu,descr) VALUES (?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,sys.getCampus());
			ps.setString(2,sys.getNamed());
			ps.setString(3,sys.getValu());
			ps.setString(4,sys.getDescr());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: insertSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteSys
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteSys(Connection conn,int id) {

		String sql = "DELETE FROM tblSystem WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: deleteSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteSys
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteSys(Connection conn,String id) {

		String sql = "DELETE FROM tblSystem WHERE named=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: deleteSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateSys
	 * <p>
	 * @param	conn	Connection
	 * @param	sys	Sys
	 * <p>
	 * @return	int
	 */
	public static int updateSys(Connection conn, Sys sys) {

		String sql = "UPDATE tblSystem SET valu=?,descr=? WHERE named=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,sys.getValu());
			ps.setString(2,sys.getDescr());
			ps.setString(3,sys.getNamed());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: updateSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateSys
	 * <p>
	 * @param	conn	Connection
	 * @param	named	String
	 * @param	valu	String
	 * <p>
	 * @return	int
	 */
	public static int updateSys(Connection conn,String named,String valu) {

		String sql = "UPDATE tblSystem SET valu=? WHERE named=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,valu);
			ps.setString(2,named);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: updateSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateSys
	 * <p>
	 * @param	conn	Connection
	 * @param	named	String
	 * @param	valu	String
	 * @param	descr String
	 * <p>
	 * @return	int
	 */
	public static int updateSys(Connection conn,String named,String valu,String descr) {

		String sql = "UPDATE tblSystem SET valu=?,descr=? WHERE named=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,valu);
			ps.setString(2,descr);
			ps.setString(3,named);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: updateSys - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getSys
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	Sys
	 */
	public static Sys getSys(Connection conn,int id) {

		String sql = "SELECT * FROM tblSystem WHERE id=?";
		Sys sys = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				sys = new Sys();
				sys.setId(rs.getInt("id"));
				sys.setNamed(AseUtil.nullToBlank(rs.getString("named")));
				sys.setValu(AseUtil.nullToBlank(rs.getString("valu")));
				sys.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: getSys - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SysDB: getSys - " + ex.toString());
		}

		return sys;
	}

	/**
	 * getSys
	 * <p>
	 * @param	conn	Connection
	 * @param	named	String
	 * <p>
	 * @return	String
	 */
	public static String getSys(Connection conn,String named) {

		String valu = "";
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT valu FROM tblSystem WHERE named=?");
			ps.setString(1,named);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				valu = AseUtil.nullToBlank(rs.getString("valu"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: getSys - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SysDB: getSys - " + ex.toString());
		}

		return valu;
	}

	/**
	 * getSysDB
	 * <p>
	 * @param	conn	Connection
	 * @param	named	String
	 * <p>
	 * @return	Sys
	 */
	public static Sys getSysDB(Connection conn,String named) {

		Sys sys = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT valu,campus,descr FROM tblSystem WHERE named=?");
			ps.setString(1,named);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				sys = new Sys();
				sys.setValu(AseUtil.nullToBlank(rs.getString("valu")));
				sys.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				sys.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SysDB: getSysDB - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SysDB: getSysDB - " + ex.toString());
		}

		return sys;
	}

	/**
	 * drawSysEditTable
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String drawSysEditTable(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		int i = 0;

		String rowClass = "";

		int rowCounter = 0;

		try{
			sb.append("<div id=\"aseEdit\" class=\"base-container ase-table-layer\">");

			sb.append("<div class=\"ase-table-row-header\">"
						+ "<div class=\"left-layer25\">Name</div>"
						+ "<div class=\"left-layer25\">Value&nbsp;<img src=\"../images/edit.gif\" boder=\"0\" title=\"editable column\" alt=\"editable column\"></div>"
						+ "<div class=\"left-layer50\">Description</div>"
						+ "<div id=\"ras\" class=\"space-line\"></div>"
						+ "</div>");

			String sql = "SELECT named,valu,descr FROM tblSystem ORDER BY named";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				String named = AseUtil.nullToBlank(rs.getString("named"));
				String value = AseUtil.nullToBlank(rs.getString("valu"));
				String descr = AseUtil.nullToBlank(rs.getString("descr"));

				if (++rowCounter % 2 == 0){
					rowClass = "ase-table-row-detail-alt";
				}
				else{
					rowClass = "ase-table-row-detail";
				}

				sb.append("<div id=\"record-"+i+"\" class=\""+rowClass+"\">"
					+ "<div class=\"left-layer25\"><a href=\"sysmod.jsp?lid="+named+"\" class=\"linkcolumn\">"+named+"</a></div>"
					+ "<div class=\"edit-sys-value left-layer25Edit\" id=\""+named+"\">"+value+"</div>"
					+ "<div class=\"left-layer50\">"+descr+"</div>"
					+ "<div id=\"ras\" class=\"space-line\"></div>"
					+ "</div>");

				++i;
			}

			rs.close();
			ps.close();

			sb.append("</div>");

		} catch (SQLException e) {
			logger.fatal("SysDB: createMissingSettingForCampus - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SysDB: createMissingSettingForCampus - " + e.toString());
		}

		return sb.toString();

	}

	/*
	 * getDebugSettings
	 *	<p>
	 * @param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getDebugSettings(Connection conn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

            genericData = new LinkedList<Generic>();

				String sql = "SELECT distinct [Page],Debug FROM tblDebug ORDER BY [page]";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("page")),
											AseUtil.nullToBlank(rs.getString("debug")),
											"",
											"",
											"",
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("SysDB - getDebugSettings: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("SysDB - getDebugSettings: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * resetSysAdm
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int resetSysAdm(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "UPDATE tblusers SET userlevel=3,campus=? WHERE userid LIKE '"+user+"%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SysDB: resetSysAdm - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SysDB: resetSysAdm - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * clearTempTables - each time we restart CC, we clear temp data
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 */
	public static void clearTempTables(Connection conn) {

		//Logger logger = Logger.getLogger("test");

		try{
			String sql = "SELECT name FROM sysobjects WHERE (xtype='U' OR xtype='S') AND name LIKE 'tblTemp%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String name = AseUtil.nullToBlank(rs.getString("name"));
				if (name != null && name.length() > 0){
					sql = "DELETE FROM " + name;
					PreparedStatement ps2 = conn.prepareStatement(sql);
					int rowsAffected = ps2.executeUpdate();
					ps2.close();
				}
			}
			rs.close();
			ps.close();

			AseUtil.logAction(conn, "SYSADM", "ACTION","cleared temp date","","","MAN");

		} catch (SQLException e) {
			logger.fatal("SysDB: clearTempTables - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SysDB: clearTempTables - " + e.toString());
		}

	}


	/**
	 */
	public void close() throws SQLException {}

}