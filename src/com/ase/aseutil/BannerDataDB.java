/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// BannerDataDB.java
//
package com.ase.aseutil;

import java.io.*;
import java.sql.*;
import java.net.URLConnection;
import java.net.URL;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class BannerDataDB {

	static Logger logger = Logger.getLogger(BannerDataDB.class.getName());

	public BannerDataDB() throws Exception {}

	/**
	 * getBannerDescr
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * @param	key	String
	 * <p>
	 * @return	String
	 */
	public static String getBannerDescr(Connection conn,String table,String key) {

		String bannerDescr = "";

		try {
			// must be done before anything else
			table = getBannerTable(table);

			String code = getCodeColumn(table);
			String descr = getDescrColumn(table);

			if (!descr.equals(Constant.BLANK) && !code.equals(Constant.BLANK)){
				String sql = "SELECT "+descr+" FROM "+table+" WHERE "+code+"=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,key);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					bannerDescr = AseUtil.nullToBlank(rs.getString(descr));
				}
				rs.close();
				rs = null;
				ps.close();
				ps = null;
			} // we have data to work with

		} catch (Exception e) {
			logger.fatal("BannerData: getBannerData - " + e.toString());
		}

		return bannerDescr;
	}

	/**
	 * getBannerData
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * @param	key	String
	 * <p>
	 * @return	BannerData
	 */
	public static BannerData getBannerData(Connection conn,String table,String key) {

		BannerData data = null;

		try {
			// must be done before anything else
			table = getBannerTable(table);

			String code = getCodeColumn(table);
			String descr = getDescrColumn(table);

			if (!descr.equals(Constant.BLANK) && !code.equals(Constant.BLANK)){
				String sql = "SELECT "+descr+" FROM "+table+" WHERE "+code+"=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,key);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					data = new BannerData();
					data.setCode(key);
					data.setDescr(AseUtil.nullToBlank(rs.getString(descr)));
				}
				rs.close();
				rs = null;
				ps.close();
				ps = null;
			} // we have data to work with

		} catch (Exception e) {
			logger.fatal("BannerData: getBannerData - " + e.toString());
			return null;
		}

		return data;
	}

	/**
	 * updateBannerData
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * @param	key	String
	 * @param	data	String
	 * <p>
	 * @return	int
	 */
	public static int updateBannerData(Connection conn,String table,String key,String data) {

		int rowsAffected = 0;

		try {
			// must be done before anything else
			table = getBannerTable(table);

			String code = getCodeColumn(table);
			String descr = getDescrColumn(table);

			if (!descr.equals(Constant.BLANK) && !code.equals(Constant.BLANK)){
				String sql = "UPDATE "+table+" set "+descr+"=? WHERE "+code+"=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,data);
				ps.setString(2,key);
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps = null;
			}

		} catch (Exception e) {
			logger.fatal("BannerData: updateBannerData - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteBannerData
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * @param	key	String
	 * <p>
	 * @return	int
	 */
	public static int deleteBannerData(Connection conn,String table,String key) {

		int rowsAffected = 0;

		try {
			// must be done before anything else
			table = getBannerTable(table);

			String code = getCodeColumn(table);

			if (!code.equals(Constant.BLANK)){
				String sql = "DELETE FROM "+table+" WHERE "+code+"=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,key);
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps = null;
			}

		} catch (Exception e) {
			logger.fatal("BannerData: deleteBannerData - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertBannerData
	 * <p>
	 * @param	conn	Connection
	 * @param	table	String
	 * @param	key	String
	 * @param	data	String
	 * <p>
	 * @return	int
	 */
	public static int insertBannerData(Connection conn,String table,String key,String data) {

		int rowsAffected = 0;

		try {
			// must be done before anything else
			table = getBannerTable(table);

			String code = getCodeColumn(table);
			String descr = getDescrColumn(table);

			if (!descr.equals(Constant.BLANK) && !code.equals(Constant.BLANK)){
				String sql = "INSERT INTO "+table+" ("+code+","+descr+") VALUES(?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,key);
				ps.setString(2,data);
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps = null;
			}

		} catch (Exception e) {
			logger.fatal("BannerData: insertBannerData - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getBannerTable
	 * <p>
	 * @param	table	String
	 * <p>
	 * @return	String
	 */
	public static String getBannerTable(String table) {

		if (table.toLowerCase().equals("ba")){
			table = "banneralpha";
		}
		else if (table.toLowerCase().equals("bc")){
			table = "bannercollege";
		}
		else if (table.toLowerCase().equals("bdt")){
			table = "bannerdept";
		}
		else if (table.toLowerCase().equals("bdv")){
			table = "bannerdivision";
		}
		else if (table.toLowerCase().equals("bl")){
			table = "bannerlevel";
		}
		else if (table.toLowerCase().equals("bt")){
			table = "bannerterms";
		}

		return table;
	}


	/**
	 * getCodeColumn
	 * <p>
	 * @param	table	String
	 * <p>
	 * @return	String
	 */
	public static String getCodeColumn(String table) {

		String code = "";

		if (table.toLowerCase().equals("banneralpha")){
			code = "COURSE_ALPHA";
		}
		else if (table.toLowerCase().equals("bannercollege")){
			code = "COLLEGE_CODE";
		}
		else if (table.toLowerCase().equals("bannerdept")){
			code = "DEPT_CODE";
		}
		else if (table.toLowerCase().equals("bannerdivision")){
			code = "DIVISION_CODE";
		}
		else if (table.toLowerCase().equals("bannerlevel")){
			code = "LEVEL_CODE";
		}
		else if (table.toLowerCase().equals("bannerterms")){
			code = "TERM_CODE";
		}

		return code;
	}


	/**
	 * getDescrColumn
	 * <p>
	 * @param	table	String
	 * <p>
	 * @return	String
	 */
	public static String getDescrColumn(String table) {

		String descr = "";

		if (table.toLowerCase().equals("banneralpha")){
			descr = "ALPHA_DESCRIPTION";
		}
		else if (table.toLowerCase().equals("bannercollege")){
			descr = "COLL_DESCRIPTION";
		}
		else if (table.toLowerCase().equals("bannerdept")){
			descr = "DEPT_DESCRIPTION";
		}
		else if (table.toLowerCase().equals("bannerdivision")){
			descr = "DIVS_DESCRIPTION";
		}
		else if (table.toLowerCase().equals("bannerlevel")){
			descr = "LEVEL_DESCR";
		}
		else if (table.toLowerCase().equals("bannerterms")){
			descr = "TERM_DESCRIPTION";
		}

		return descr;
	}

	/**
	 * close
	 */
	public void close() throws Exception {}

}