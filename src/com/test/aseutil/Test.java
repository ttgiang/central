/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.test.aseutil;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

import java.sql.*;

import net.sourceforge.jtds.jdbc.Driver;

import com.javaexchange.dbConnectionBroker.*;

import java.io.*;
import java.util.*;


/**
 * @author tgiang
 *
 */
public class Test {

	static Logger logger = Logger.getLogger(Test.class.getName());

	public static void main(final String[] args) {

		Connection conn = null;

		try {
			System.out.println("Staring...");

			AseUtil au = new AseUtil();

			String server = "";
			String database = "";
			String user = "";
			String pw = "";

			server = "fih-05045";
			database = "ccv2";
			user = "ccusr";
			pw = "tw0c0mp1ex4u";

			AsePool asePool = AsePool.getInstance(server,user,pw);

			conn = asePool.getConnection();

			System.out.println("Ending...");

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("" + e.toString());
			}
		}
	}
}

class DB{

	public DB() {}

	public Connection dbConnect(String server,String db,String db_userid, String db_password){

		Logger logger = Logger.getLogger(DB.class.getName());

		Connection conn = null;

		try{
			String db_connect_string = "jdbc:jtds:sqlserver://" + server + ":1433/" + db;
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			conn = DriverManager.getConnection(db_connect_string, db_userid, db_password);
			System.out.println("connected");
		}
		catch (Exception e){
			logger.fatal("" + e.toString());
		}

		return conn;
	}
};