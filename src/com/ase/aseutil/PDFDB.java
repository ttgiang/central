/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 *	public static int insert(Connection,PDF)
 *
 * @author ttgiang
 */

//
// PDFDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class PDFDB {
	static Logger logger = Logger.getLogger(PDFDB.class.getName());

	public PDFDB() throws Exception {}

	/**
	 * insert
	 */
	public static int insert(Connection conn,PDF pdf) {

		int rowsAffected = 0;

		if (conn == null)
			conn = ConnDB.getConnection();

		if (pdf != null){
			String sql = "INSERT INTO tblPDF (type,userid,kix,field01,field02,seq,colum) VALUES (?,?,?,?,?,?,?)";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,pdf.getType());
				ps.setString(2,pdf.getUserID());
				ps.setString(3,pdf.getKix());
				ps.setString(4,pdf.getField01());
				ps.setString(5,pdf.getField02());
				ps.setInt(6,pdf.getSeq());
				ps.setString(7,pdf.getColum());
				rowsAffected = ps.executeUpdate();
				ps.close();
			} catch (SQLException e) {
				logger.fatal("PDFDB: insert\n" + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * delete
	 * <p>
	 * @param	conn	Connection
	 * @param	uid	String
	 * @param	type	String
	 * <p>
	 */
	public static int delete(Connection conn,String uid,String type) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblPDF WHERE userid=? AND type=?";

		if (conn == null)
			conn = ConnDB.getConnection();

		if (uid != null){
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,uid);
				ps.setString(2,type);
				rowsAffected = ps.executeUpdate();
				//logger.info("PDFDB - delete: " + type + " (" + rowsAffected + " rows deleted)");
				ps.close();
			} catch (SQLException e) {
				logger.fatal("PDFDB: delete - " + e.toString());
			}
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}