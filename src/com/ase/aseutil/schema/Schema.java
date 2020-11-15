/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// Schema.java
//
package com.ase.aseutil.schema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class Schema {

	static Logger logger = Logger.getLogger(Schema.class.getName());

	/**
	*	doesColumnExistInTable
	**/
	public static boolean doesColumnExistInTable(Connection conn,String table,String column){

		//Logger logger = Logger.getLogger("test");

		boolean columnExistInTable = false;

		try{
			String sql = "SELECT DISTINCT sc.name FROM sys.syscolumns AS sc INNER JOIN "
				+ "sys.sysobjects AS so ON sc.id = so.id "
				+ "WHERE (so.xtype = 'U' OR so.xtype = 'S') AND (so.name = ?) AND (sc.name = ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,table);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			columnExistInTable = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Schema.doesColumnExistInTable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Schema.doesColumnExistInTable: " + e.toString());
		}

		return columnExistInTable;
	}

} // Schema

