/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public static int deleteRequest(Connection conn,String kix,int id) {
 *	public static Request getRequest(Connection conn,String kix,int id) {
 *	public static int insertRequest(Connection conn, Request request)
 *	public static int updateRequest(Connection conn, Request request) {
 *
 * @comments ttgiang
 */

//
// RequestDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class RequestDB {

	static Logger logger = Logger.getLogger(RequestDB.class.getName());

	public RequestDB() throws Exception {}

	/**
	 * insertRequest
	 * <p>
	 * @param	conn	Connection
	 * @param	request	Request
	 * <p>
	 * @return	int
	 */
	public static int insertRequest(Connection conn, Request request) {

		String sql = "INSERT INTO tblRequest(descr,request,comments,status,userid,campus,auditdate,submitteddate) VALUES (?,?,?,?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,request.getDescr());
			ps.setString(2,request.getRequest());
			ps.setString(3,request.getComments());
			ps.setString(4,request.getStatus());
			ps.setString(5,request.getUserid());
			ps.setString(6,request.getCampus());
			ps.setString(7,AseUtil.getCurrentDateTimeString());
			ps.setString(8,AseUtil.getCurrentDateTimeString());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RequestDB: insertRequest\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteRequest
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteRequest(Connection conn,int id) {

		String sql = "DELETE FROM tblRequest WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RequestDB: deleteRequest\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateRequest
	 * <p>
	 * @param	conn	Connection
	 * @param	request	Request
	 * <p>
	 * @return	int
	 */
	public static int updateRequest(Connection conn, Request request) {

		String sql = "UPDATE tblRequest SET descr=?,request=?,comments=?,status=?,userid=?,campus=?,auditdate=? "
			+ "WHERE id=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,request.getDescr());
			ps.setString(2,request.getRequest());
			ps.setString(3,request.getComments());
			ps.setString(4,request.getStatus());
			ps.setString(5,request.getUserid());
			ps.setString(6,request.getCampus());
			ps.setString(7,AseUtil.getCurrentDateTimeString());
			ps.setInt(8,request.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RequestDB: updateRequest\n" + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getRequest
	 * <p>
	 * @param	conn	Connection
	 * @param	seq	int
	 * <p>
	 * @return	Request
	 */
	public static Request getRequest(Connection conn,int seq) {

		String sql = "SELECT * FROM tblRequest WHERE id=?";
		Request request = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				request = new Request();
				request.setId(rs.getInt("id"));
				request.setDescr(aseUtil.nullToBlank(rs.getString("descr")));
				request.setRequest(aseUtil.nullToBlank(rs.getString("request")));
				request.setComments(aseUtil.nullToBlank(rs.getString("comments")));
				request.setStatus(aseUtil.nullToBlank(rs.getString("status")));
				request.setUserid(aseUtil.nullToBlank(rs.getString("userid")));
				request.setCampus(aseUtil.nullToBlank(rs.getString("campus")));
				request.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
				request.setSubmittedDate(aseUtil.ASE_FormatDateTime(rs.getString("submittedDate"),Constant.DATE_DATETIME));
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RequestDB: getRequest\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("RequestDB: getRequest\n" + ex.toString());
		}

		return request;
	}

	public void close() throws SQLException {}

}