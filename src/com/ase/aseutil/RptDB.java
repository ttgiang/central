/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int deleteText(Connection conn,String kix,int id) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Text getText(Connection conn,String kix,int id) {
 * public static String getTextAsHTMLList(Connection connection,String kix)
 *	public static int insertText(Connection conn, Text text)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateText(Connection conn, Text text) {
 *
 * @author ttgiang
 */

//
// RptDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class RptDB {

	static Logger logger = Logger.getLogger(RptDB.class.getName());

	public RptDB() throws Exception {}

	/**
	 * getText
	 * <p>
	 * @param	conn		Connection
	 * @param	report	String
	 * <p>
	 * @return	Rpt
	 */
	public static Rpt getRpt(Connection conn,String report) {

		String sql = "SELECT * FROM tblRpt WHERE rptname=?";
		Rpt rpt = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,report);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				rpt = new Rpt();
				rpt.setId(rs.getInt("id"));
				rpt.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				rpt.setRptName(AseUtil.nullToBlank(rs.getString("rptname")));
				rpt.setRptFileName(AseUtil.nullToBlank(rs.getString("rptfilename")));
				rpt.setRptTitle(AseUtil.nullToBlank(rs.getString("rpttitle")));
				rpt.setRptFormat(AseUtil.nullToBlank(rs.getString("rptformat")));
				rpt.setRptParm1(AseUtil.nullToBlank(rs.getString("rptparm1")));
				rpt.setRptParm2(AseUtil.nullToBlank(rs.getString("rptparm2")));
				rpt.setRptParm3(AseUtil.nullToBlank(rs.getString("rptparm3")));
				rpt.setRptParm4(AseUtil.nullToBlank(rs.getString("rptparm4")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RptDB: getRpt - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("RptDB: getRpt - " + ex.toString());
		}

		return rpt;
	}

	public void close() throws SQLException {}

}