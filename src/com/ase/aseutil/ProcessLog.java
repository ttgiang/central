/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// ProcessLog.java
//
package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ProcessLog {

	static Logger logger = Logger.getLogger(ProcessLog.class.getName());

	final static String inputFileName = AseUtil.getCurrentDirectory().substring(0, 1) + ":/tomcat/webapps/central/logs/ccv2.log";
	final static String DELIM = ",";

	public ProcessLog() {}

	/**
	 * createLog
	 *
	 */
	public String createLog(Connection conn) {

		StringBuffer buffer = new StringBuffer();

		String inLine = null;

		int rowsAffected = 0;

		PreparedStatement ps = null;

		try {
			buffer.append("<br/>Starting log processing<br/>");
			buffer.append("clear old data<br/>");
			String sql = "DELETE FROM tblLogs";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();

			buffer.append("read log for processing<br/>");
			FileReader inputFileReader = new FileReader(inputFileName);

			buffer.append("create BufferedReader Object for FileReader Object<br/");
			BufferedReader inputStream = new BufferedReader(inputFileReader);

			buffer.append("starting file read<br/");
			sql = "INSERT INTO tblLogs (logs) VALUES (?)";
			while ((inLine = inputStream.readLine()) != null) {
				ps = conn.prepareStatement(sql);
				ps.setString(1,inLine);
				rowsAffected += ps.executeUpdate();
			}
			buffer.append("file read completd<br/>");
			inputStream.close();
			ps.close();

			buffer.append("processed " + rowsAffected + " rows<br/>");
			buffer.append("Ending log processing<br/>");

		} catch (SQLException e) {
			logger.fatal("ProcessLog: " + e.toString());
		} catch (IOException e) {
			logger.fatal("ProcessLog: " + e.toString());
		}

		return buffer.toString();
	}

	public void close() throws SQLException {}
}

