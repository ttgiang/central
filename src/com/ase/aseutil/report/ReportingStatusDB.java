/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// ReportingStatusDB.java
//
package com.ase.aseutil.report;

import java.io.*;
import java.sql.*;
import java.net.URLConnection;
import java.net.URL;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;

public class ReportingStatusDB {

	static Logger logger = Logger.getLogger(ReportingStatusDB.class.getName());

	public ReportingStatusDB() throws Exception {}

	/*
	 * getReportingStatus
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * @param	user	String
	 * <p>
	 * @return ReportingStatus
	 */
	public static List<ReportingStatus> getReportingStatus(Connection conn,String type,String user) throws Exception {

		List<ReportingStatus> ReportingStatusData = null;

		try {
			if (ReportingStatusData == null){

				// because of a programmer's error, progress and proposer were reversed

            ReportingStatusData = new LinkedList<ReportingStatus>();

				String sql = "SELECT * FROM tblReportingStatus WHERE type=? AND userid=? ORDER BY id";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	ReportingStatusData.add(new ReportingStatus(
										AseUtil.nullToBlank(rs.getString("userid")),
										AseUtil.nullToBlank(rs.getString("links")),
										AseUtil.nullToBlank(rs.getString("outline")),
										AseUtil.nullToBlank(rs.getString("progress")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										AseUtil.nullToBlank(rs.getString("curent")),
										AseUtil.nullToBlank(rs.getString("next")),
										AseUtil.nullToBlank(rs.getString("proposeddate")),
										AseUtil.nullToBlank(rs.getString("lastupdated")),
										AseUtil.nullToBlank(rs.getString("route")),
										AseUtil.nullToBlank(rs.getString("type")),
										AseUtil.nullToBlank(rs.getString("historyid"))
									));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("ReportingStatusDB.getReportingStatus ("+type+"/"+user+"): " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("ReportingStatusDB.getReportingStatus ("+type+"/"+user+"): " + e.toString());
			return null;
		}

		return ReportingStatusData;
	}

	/*
	 * insert
	 *	<p>
	 *	@param	conn	Connection
	 * @param	as		ReportingStatus
	 *	<p>
	 *	@return	int
	 */
	public static int insert(Connection conn,ReportingStatus as) {

		int rowsAffected = 0;

		try {
			String sql = "INSERT INTO tblReportingStatus (userid,links,outline,progress,proposer,curent,next,proposeddate,lastupdated,route,type,historyid) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,as.getUserId());
			ps.setString(2,as.getLinks());
			ps.setString(3,as.getOutline());
			ps.setString(4,as.getProgress());
			ps.setString(5,as.getProposer());
			ps.setString(6,as.getCurrent());
			ps.setString(7,as.getNext());
			ps.setString(8,as.getDateProposed());
			ps.setString(9,as.getLastUpdated());
			ps.setString(10,as.getRoute());
			ps.setString(11,as.getType());
			ps.setString(12,as.getHistoryid());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReportingStatusDB - insert: " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReportingStatusDB - insert: " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * delete
	 *	<p>
	 *	@param	conn	Connection
	 * @param	user	String
	 *	<p>
	 *	@return	int
	 */
	public static int delete(Connection conn,String user) {

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblReportingStatus WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReportingStatusDB.delete ("+user+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReportingStatusDB.delete ("+user+"): " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws Exception {}

}