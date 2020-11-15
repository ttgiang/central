/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int deleteText(Connection conn,String kix,int id) {
 * public static String getgetContentForEdit(Connection connection,String kix)
 *	public static Text getText(Connection conn,String kix,int id) {
 * public static String getTextAsHTMLList(Connection connection,String kix)
 *	public static int getConnection(Connection conn, Text text)
 *	public static int showText(Connection conn,String campus,String type) {
 *	public static int updateText(Connection conn, Text text) {
 *
 * @author ttgiang
 */

//
// ConnDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ConnDB {

	static Logger logger = Logger.getLogger(ConnDB.class.getName());

	public ConnDB() throws Exception {}

	/**
	 * getConnection
	 * <p>
	 * @return	Connection
	 */
	public static Connection getConnection() {

		Connection conn = null;

		AsePool connectionPool = AsePool.getInstance();

		if (connectionPool != null)
			conn = connectionPool.getConnection();

		return conn;
	}

	public void close() throws SQLException {}

}