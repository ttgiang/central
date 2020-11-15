/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// Batch.java
//
package com.ase.aseutil;

import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Batch {

	// A code showing the Batch Update Syntax
	public static void batchUpdateDemo(String userid, String password) {
		ResultSet rs = null;
		PreparedStatement ps = null;

		String url = "jdbc:odbc:bob";

		Connection con;
		Statement stmt;
		try {

			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

		} catch (java.lang.ClassNotFoundException e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());
		}

		try {

			con = DriverManager.getConnection(url, "userid", "password");
			con.setAutoCommit(false);

			stmt = con.createStatement();

			stmt.addBatch("INSERT INTO COFFEES "
					+ "VALUES('Amaretto', 49, 9.99, 0, 0)");
			stmt.addBatch("INSERT INTO COFFEES "
					+ "VALUES('Hazelnut', 49, 9.99, 0, 0)");
			stmt.addBatch("INSERT INTO COFFEES "
					+ "VALUES('Amaretto_decaf', 49, 10.99, 0, 0)");
			stmt.addBatch("INSERT INTO COFFEES "
					+ "VALUES('Hazelnut_decaf', 49, 10.99, 0, 0)");
			int[] updateCounts = stmt.executeBatch();
			con.commit();
			con.setAutoCommit(true);

			ResultSet uprs = stmt.executeQuery("SELECT * FROM COFFEES");

			System.out.println("Table COFFEES after insertion:");
			while (uprs.next()) {
				String name = uprs.getString("COF_NAME");
				int id = uprs.getInt("SUP_ID");
				float price = uprs.getFloat("PRICE");
				int sales = uprs.getInt("SALES");
				int total = uprs.getInt("TOTAL");
				System.out.print(name + "   " + id + "   " + price);
				System.out.println("   " + sales + "   " + total);
			}

			uprs.close();
			stmt.close();
			con.close();

		} catch (BatchUpdateException b) {
			System.err.println("-----BatchUpdateException-----");
			System.err.println("SQLState:  " + b.getSQLState());
			System.err.println("Message:  " + b.getMessage());
			System.err.println("Vendor:  " + b.getErrorCode());
			System.err.print("Update counts:  ");
			int[] updateCounts = b.getUpdateCounts();
			for (int i = 0; i < updateCounts.length; i++) {
				System.err.print(updateCounts[i] + "   ");
			}
			System.err.println("");

		} catch (SQLException ex) {
			System.err.println("-----SQLException-----");
			System.err.println("SQLState:  " + ex.getSQLState());
			System.err.println("Message:  " + ex.getMessage());
			System.err.println("Vendor:  " + ex.getErrorCode());
		}
	}
}