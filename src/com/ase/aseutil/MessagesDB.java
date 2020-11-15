/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// MessagesDB.java
//
package com.ase.aseutil;

import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;

public class MessagesDB {

	static Logger logger = Logger.getLogger(MessagesDB.class.getName());

	public MessagesDB() throws Exception {}

	/**
	 * getItem
	 * <p>
	 * @param	conn		Connection
	 * @param	mid		int
	 * @param	column	String
	 * <p>
	 * @return	String
	 */
	public static String getItem(Connection conn,int mid,String column) throws SQLException {

		String item = "";

		try{
			String sql = "SELECT "+column+" FROM messages WHERE message_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("MessagesDB - getItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("MessagesDB - getItem: " + e.toString());
		}

		return item;
	}

	/**
	 * getNumericItem
	 * <p>
	 * @param	conn		Connection
	 * @param	mid		int
	 * @param	column	String
	 * <p>
	 * @return	int
	 */
	public static int getNumericItem(Connection conn,int mid,String column) throws SQLException {

		int item = 0;

		try{
			String sql = "SELECT "+column+" FROM messages WHERE message_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = rs.getInt(column);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("MessagesDB - getNumericItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("MessagesDB - getNumericItem: " + e.toString());
		}

		return item;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}
