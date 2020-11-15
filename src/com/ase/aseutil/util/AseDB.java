/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static Connection createLongConnection() {
 *
 * @author ttgiang
 */

//
// AseDB.java
//
package com.ase.aseutil.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ase.aseutil.bundle.BundleDB;

public class AseDB {

	static Logger logger = Logger.getLogger(AseDB.class.getName());

	public AseDB() throws Exception {}

	/*
	 * createLongConnection
	 */
	public static Connection createLongConnection() {

		Connection conn = null;

		try{
			BundleDB bundleDB = new BundleDB();

			com.ase.aseutil.bundle.Bundle bundle = bundleDB.getBundleForConnection();

			String host = bundle.getHost();
			String usr = bundle.getUid();
			String pw = bundle.getUpw();
			String port = bundle.getPort();
			String driver = bundle.getDriver();
			String url = bundle.getUrl();
			String db = bundle.getDb();

			//host = "talin";
			//port = "1433";
			//driver = "net.sourceforge.jtds.jdbc.Driver";
			//url = "jdbc:jtds:sqlserver";
			//db = "ccv2";
			//usr = "ccusr";
			//pw = "tw0c0mp1ex4u";

			url = url + "://" + host + ":" + port + "/" + db;

			Class.forName(driver);

			conn = DriverManager.getConnection(url,usr,pw);
		}
		catch(java.sql.SQLException e){
			logger.fatal("AseDB: createLongConnection - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("AseDB: createLongConnection - " + e.toString());
		}

		return conn;
	}

	/*
	 * main
	 *	<p>
	 */
	public static void main(String[] args) {

		System.out.println("----------------------------- START");

		if (args.length > 0){

			System.out.println("Method to execute: " + args[0] + "\n");

			if (args[0].equals("createSearchData")){

				System.out.println("executing: " + args[0] + "\n");

				try{
					//AseDB s = new AseDB();
					//s.createSearchData();
				}
				catch(Exception e){
					logger.fatal("AseDB - main: " + e.toString());
				}
			}
		} // if args
		else{
			System.out.println("missing method to execute");
		}

		System.out.println("----------------------------- END");
	}

	public void close() throws SQLException {}

}