/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

//
//  DBInfo.java
//
package com.ase.aseutil;

/*
 * =============================================================================
 * Copyright (c) 1998-2007 Jeffrey M. Hunter. All rights reserved.
 *
 * All source code and material located at the Internet address of
 * http://www.idevelopment.info is the copyright of Jeffrey M. Hunter and
 * is protected under copyright laws of the United States. This source code may
 * not be hosted on any other site without my express, prior, written
 * permission. Application to host any of the material elsewhere can be made by
 * contacting me at jhunter@idevelopment.info.
 *
 * I have made every effort and taken great care in making sure that the source
 * code and other content included on my web site is technically accurate, but I
 * disclaim any and all responsibility for any loss, damage or destruction of
 * data or any other property which may arise from relying on it. I will in no
 * case be liable for any monetary damages arising from such loss, damage or
 * destruction.
 *
 * As with any code, ensure to test this code in a development environment
 * before attempting to run it in production.
 * =============================================================================
 */

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBInfo {

	Connection conn = null;

	public DBInfo(Connection connection) throws Exception {

		runExample(connection);
	}

	private static String prt(Object s) {
		return s.toString();
	}

	private static String prt(int i) {
		return String.valueOf(i);
	}

	private static String prtln(Object s) {
		return (s + "<br>");
	}

	private static String prtln(int i) {
		return (i + "<br>");
	}

	private static String prtln() {
		return "";
	}

	public void runExample(Connection conn) {

		DatabaseMetaData md = null;
		String str = "";

		try {
			md = conn.getMetaData();

			try {
				str = prtln(md.getDatabaseProductName());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Product Version Number : ");
			try {
				str += prtln(md.getDatabaseProductVersion());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Database Major Version : ");
			try {
				str += prtln(md.getDatabaseMajorVersion());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Database Minor Version : ");
			try {
				str += prtln(md.getDatabaseMinorVersion());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Driver Name            : ");
			try {
				str += prtln(md.getDriverName());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Username               : ");
			try {
				str += prtln(md.getUserName());
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}

			str += prt("  - Catalogs               : ");
			try {
				ResultSet catalogs = md.getCatalogs();
				while (catalogs.next()) {
					str += prtln("    - " + catalogs.getString(1));
				}
				catalogs.close();
			} catch (SQLException e) {
				str += prtln("java.sql.SQLException: Unsupported feature");
			}
		} catch (SQLException e) {
		}
	}

	/**
	 *
	**/
	public static String tables(Connection conn){

		PreparedStatement ps = null;
		StringBuffer results = new StringBuffer();
		String table = "";
		String sql = "";

		boolean first = true;

		ResultSet rsAlpha = null;
		ResultSet rsNum = null;

		try{
			DatabaseMetaData md = conn.getMetaData();
			ResultSet rs = md.getTables(null, null, "%", null);
			while (rs.next()) {
				table = rs.getString(3);
				if (table.indexOf("vw_")<0 && table.indexOf("tblTemp")<0){
					rsAlpha = md.getColumns(null,null,table,"coursealpha");
					rsNum = md.getColumns(null,null,table,"coursenum");
					if (rsAlpha.next() && rsNum.next()) {
						if (!first){
							results.append(","+table);
						}
						else{
							results.append(table);
							first = false;
						}
					}
				}
			}
		}
		catch(SQLException se){
			results.append("Error");
		}
		catch(Exception e){
			results.append("Error");
		}

		return results.toString();
	}

}
