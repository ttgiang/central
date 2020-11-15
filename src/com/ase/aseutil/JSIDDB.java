/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// JSIDDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class JSIDDB {
	static Logger logger = Logger.getLogger(JSIDDB.class.getName());

	public JSIDDB() throws Exception {}

	/**
	 * getJSID
	 * <p>
	 * @param connection	Connection
	 * @param user			String
	 * <p>
	 * @return JSID
	 */
	public static JSID getJSID(Connection connection,String user) {

		JSID jid = new JSID();
		try {
			String sql = "SELECT * FROM tblJSID WHERE username=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				jid.setCampus(AseUtil.nullToBlank(rs.getString("campus")).trim());
				jid.setPage(AseUtil.nullToBlank(rs.getString("page")).trim());
				jid.setAlpha(AseUtil.nullToBlank(rs.getString("alpha")).trim());
				jid.setNum(AseUtil.nullToBlank(rs.getString("num")).trim());
				jid.setType(AseUtil.nullToBlank(rs.getString("type")).trim());
				jid.setStart(AseUtil.nullToBlank(rs.getString("start")).trim());
				jid.setAudit(AseUtil.nullToBlank(rs.getString("audit")).trim());
				jid.setEndDate(AseUtil.nullToBlank(rs.getString("enddate")).trim());
				jid.setUserName(AseUtil.nullToBlank(rs.getString("username")).trim());
			}
			else{
				jid = null;
			}

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("JSIDDB: getJSID\n" + e.toString());
			return null;
		}
		return jid;
	}

	/**
	 * insertJSID
	 * <p>
	 * @param connection	Connection
	 * @param jsid			String
	 * @param campus		String
	 * @param alpha		String
	 * @param num			String
	 * @param type			String
	 * @param user			String
	 * <p>
	 * @return int
	 */
	 public static int insertJSID(Connection connection,
											String jsid,
											String campus,
											String user,
											String alpha,
											String num,
											String type) {
		int rowsAffected = 0;
		String sql = "";
		try {
			PreparedStatement ps;
			if (getJSID(connection,user) == null){
				sql = "INSERT INTO tblJSID (jsid,campus,username,alpha,num,type,start,audit) VALUES (?,?,?,?,?,?,?,?)";
				ps = connection.prepareStatement(sql);
				ps.setString(1, jsid);
				ps.setString(2, campus);
				ps.setString(3, user);
				ps.setString(4, alpha);
				ps.setString(5, num);
				ps.setString(6, type);
				ps.setString(7, AseUtil.getCurrentDateTimeString());
				ps.setString(8, AseUtil.getCurrentDateTimeString());
				rowsAffected = ps.executeUpdate();
			}
			else{
				sql = "UPDATE tblJSID SET alpha=?,num=?,type=?,start=?,audit=?,enddate=?,page='' WHERE username=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1, alpha);
				ps.setString(2, num);
				ps.setString(3, type);
				ps.setString(4, AseUtil.getCurrentDateTimeString());
				ps.setString(5, AseUtil.getCurrentDateTimeString());
				ps.setString(6, null);
				ps.setString(7, user);
				rowsAffected = ps.executeUpdate();
			}
			ps.close();

			//AseUtil.loggerInfo("JSIDDB: Start Session ",campus,user,AseUtil.getCurrentDateTimeString(),num);
		} catch (SQLException e) {
			logger.fatal("JSIDDB: insertJSID - " + user + " - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * updateJSID
	 * <p>
	 * @param connection	Connection
	 * @param jsid			String
	 * @param campus		String
	 * @param page			String
	 * @param alpha		String
	 * @param num			String
	 * @param type			String
	 * @param user			String
	 * <p>
	 * @return int
	 */
	public static int updateJSID(Connection connection,
									String jsid,
									String campus,
									String page,
									String alpha,
									String num,
									String type,
									String user) {
		int rowsAffected = 0;
		String sql = "UPDATE tblJSID SET page=?,alpha=?,num=?,type=?,audit=? WHERE username=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, page);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, AseUtil.getCurrentDateTimeString());
			ps.setString(6, user);
			rowsAffected = ps.executeUpdate();

			ps.close();

			//AseUtil.loggerInfo("JSIDDB: Update Session ",campus,alpha,num,user);
		} catch (SQLException e) {
			logger.fatal("JSIDDB: updateJSID\n" + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * removeJSID
	 * <p>
	 * @param connection	Connection
	 * @param jsid			String
	 * @param campus		String
	 * @param user			String
	 * <p>
	 * @return int
	 */
	public static int removeJSID(Connection connection,String jsid,String campus,String user) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblJSID WHERE username=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,user);
			rowsAffected = ps.executeUpdate();

			ps.close();

			AseUtil.loggerInfo("JSIDDB: removeJSID ",campus,"","",user);
		} catch (SQLException e) {
			logger.fatal("JSIDDB: removeJSID\n" + e.toString());
		}
		return rowsAffected;
	}

	/**
	 * endJSID
	 * <p>
	 * @param connection	Connection
	 * @param jsid			String
	 * @param campus		String
	 * @param user			String
	 * <p>
	 * @return int
	 */
	public static int endJSID(Connection conn,String jsid,String campus,String user) {
		int rowsAffected = 0;
		String sql = "UPDATE tblJSID SET page=?,audit=?,enddate=? WHERE username=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,null);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,user);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// clear previously created temp data
			com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);

			AseUtil.loggerInfo("JSIDDB: End Session ",campus,AseUtil.getCurrentDateTimeString(),"",user);
		} catch (SQLException e) {
			logger.fatal("JSIDDB: endJSID\n" + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	public void close() throws SQLException {}

}