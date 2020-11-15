/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 * public static int deleteLog(Connection conn,String campus,String logType,String period)
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class LogData {

	static Logger logger = Logger.getLogger(LogData.class.getName());

	public LogData() throws IOException{}

	/**
	 * deleteLog
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	logType	String
	 * @param	period	String
	 * <p>
	 * @return	int
	 */
	public static int deleteLog(Connection conn,String campus,String user,String logType,String period){

		logger.info("LOGDATA - DELETELOG START");

		String table = "";
		String dateField = "";
		int rowsAffected = 0;

		if ("history".equals(logType)){
			dateField = "dte";
			table = "tblApprovalHist2";
		}
		else if ("mail".equals(logType)){
			dateField = "dte";
			table = "tblMail";
		}
		else if ("user".equals(logType)){
			dateField = "datetime";
			table = "tblUserLog";
		}

		String sql = "DELETE FROM " + table + " " +
			"WHERE campus=? AND " +
			"YEAR(" + dateField + ")=?";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,period);
			rowsAffected = ps.executeUpdate();
			ps.close();

			logger.info(user + " deleted " + rowsAffected + " rows from " + logType + " for " + campus);
		}
		catch(SQLException sx){
			logger.fatal("LogData: deleteLog\n" + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("LogData: deleteLog\n" + ex.toString());
		}

		logger.info("LOGDATA - DELETELOG ENDS");

		return rowsAffected;
	}

}
