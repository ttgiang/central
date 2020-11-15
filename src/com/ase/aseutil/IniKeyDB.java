/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * public static String getIniKey(Connection connection,String key)
 *
 * @author ttgiang
 */

//
// IniKeyDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class IniKeyDB {

	static Logger logger = Logger.getLogger(IniKeyDB.class.getName());

	public IniKeyDB() throws Exception {}

	/**
	 * getIniKey
	 * <p>
	 * @param	conn	Connection
	 * @param	key	String
	 * <p>
	 * @return	IniKey
	 */
	public static IniKey getIniKey(Connection conn,String key) {

		String sql = "SELECT * FROM tblIniKey WHERE kid=?";
		IniKey ik = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,key);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				ik = new IniKey();
				ik.setId(rs.getInt("id"));
				ik.setKid(aseUtil.nullToBlank(rs.getString("kid")));
				ik.setOptions(aseUtil.nullToBlank(rs.getString("options")));
				ik.setDescr(aseUtil.nullToBlank(rs.getString("descr")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("IniKeyDB: getIniKey\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("IniKeyDB: getIniKey\n" + ex.toString());
		}

		return ik;
	}

	/**
	 * getOptions
	 * <p>
	 * @param	conn	Connection
	 * @param	key	String
	 * <p>
	 * @return	String
	 */
	public static String getOptions(Connection conn,String key) {

		String options = "";

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT options FROM tblIniKey WHERE kid=?");
			ps.setString(1,key);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				options = AseUtil.nullToBlank(rs.getString("options"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("IniKeyDB: getOptions\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("IniKeyDB: getOptions\n" + ex.toString());
		}

		return options;
	}

	/**
	 * getOptionsX
	 * <p>
	 * @param	conn	Connection
	 * @param	key	String
	 * <p>
	 * @return	String
	 */
	public static String[] getOptionsX(Connection conn,String key) {

		String[] options = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT options,valu,html FROM tblIniKey WHERE kid=?");
			ps.setString(1,key);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				options = new String[3];

				options[0] = AseUtil.nullToBlank(rs.getString("options"));

				// values and options are identical when values is empty
				options[1] = AseUtil.nullToBlank(rs.getString("valu"));
				if (options[1] == null || options[1].length() == 0){
					options[1] = options[0];
				}

				options[2] = AseUtil.nullToBlank(rs.getString("html"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("IniKeyDB: getOptions\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("IniKeyDB: getOptions\n" + ex.toString());
		}

		return options;
	}

	public void close() throws SQLException {}

}