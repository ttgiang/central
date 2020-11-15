/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *
 * @author ttgiang
 */

//
// Central.java
//
package com.ase.aseutil.central;

import com.ase.aseutil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class Central {

	static Logger logger = Logger.getLogger(Central.class.getName());

	public Central() throws Exception {}

	/*
	 * countRowsInAllTables
	 *	<p>
	 *	read through all tables using different key combinations to locate data for users
	 *	<p>
	 * @param	conn	Connection
	 * @param	user	String
	 * @param	type	String
	 *	<p>
	 * @return	int
	 */
	public static int countRowsInAllTables(Connection conn,String user,String type) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			logger.fatal("========================= START");

			String sql = "SELECT campus,alpha,num,proposer,historyid FROM tblCourse WHERE proposer=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,type);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("alpha"));
				String num = AseUtil.nullToBlank(rs.getString("num"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				rowsAffected = countRowsInAllTablesX(conn,proposer,campus,alpha,num,type,historyid);

			} // while
			rs.close();
			ps.close();
			logger.fatal("========================= END");
		} catch (SQLException e) {
			logger.fatal("countRowsInAllTables - " + e.toString());
		} catch (Exception e) {
			logger.fatal("countRowsInAllTables - " + e.toString());
		}

		return rowsAffected;

	} // countRowsInAllTables

	/*
	 * countRowsInAllTables
	 *	<p>
	 *	read through all tables using different key combinations to locate data for users
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	kix		String
	 *	<p>
	 * @return	int
	 */
	public static int countRowsInAllTablesX(Connection conn,
														String user,
														String campus,
														String alpha,
														String num,
														String type,
														String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String src = "";

		try {
			PreparedStatement ps2 = null;
			ResultSet rs2 = null;

			if (kix != null && kix.length() > 0){

				logger.fatal("-------------------- " + user + " ("+campus+"-"+alpha+"-"+num+")");

				String sql = "SELECT distinct so.name AS tbl "
							+ "FROM syscolumns sc, sysobjects so "
							+ "WHERE so.id = sc.id "
							+ "AND so.name LIKE 'tbl%' "
							+ "AND so.name NOT LIKE 'tblTemp%' "
							+ "AND (sc.name ='alpha' OR sc.name ='alpha' OR sc.name ='historyid' OR sc.name ='kix')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String tbl = AseUtil.nullToBlank(rs.getString("tbl"));

					rowsAffected = 0;

					// available by full key?
					try{
						// in debug, do a count to show how many were deleted
						sql = "SELECT COUNT(*) counter FROM " + tbl
								+ " WHERE campus=? "
								+ " AND alpha=? "
								+ " AND num=? "
								+ " AND coursetype=? ";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,campus);
						ps2.setString(2,alpha);
						ps2.setString(3,num);
						ps2.setString(4,type);
						rs2 = ps2.executeQuery();
						if (rs2.next()){
							rowsAffected = rs2.getInt("counter");
							src = "full keys";
						}
						rs2.close();
						ps2.close();

					}
					catch(Exception e){
						// ignore errors since not all tables will have alpha/num/type combination.
						//logger.info("countRowsInAllTables - " + e.toString());
					}

					// available by kix?
					if (rowsAffected == 0){
						try{
							// in debug, do a count to show how many were deleted
							sql = "SELECT COUNT(*) counter FROM " + tbl
									+ " WHERE historyid=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,kix);
							rs2 = ps2.executeQuery();
							if (rs2.next()){
								rowsAffected = rs2.getInt("counter");
								src = "kix";
							}
							rs2.close();
							ps2.close();

						}
						catch(Exception e){
							// ignore errors since not all tables will have alpha/num/type combination.
							//logger.info("countRowsInAllTables - " + e.toString());
						}
					}

					// available by partial key?
					try{
						// in debug, do a count to show how many were deleted
						sql = "SELECT COUNT(*) counter FROM " + tbl
								+ " WHERE campus=? "
								+ " AND alpha=? "
								+ " AND num=? ";
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,campus);
						ps2.setString(2,alpha);
						ps2.setString(3,num);
						rs2 = ps2.executeQuery();
						if (rs2.next()){
							rowsAffected = rs2.getInt("counter");
							src = "partial keys";
						}
						rs2.close();
						ps2.close();

					}
					catch(Exception e){
						// ignore errors since not all tables will have alpha/num/type combination.
						//logger.info("countRowsInAllTables - " + e.toString());
					}

					if (rowsAffected > 0){
						logger.fatal(src + ": " + rowsAffected + " rows found in "+ tbl.toLowerCase().replace("tbl",""));
					}

				} // while
				rs.close();
				ps.close();

			} // kix

		} catch (SQLException e) {
			logger.fatal("countRowsInAllTables - " + e.toString());
		} catch (Exception e) {
			logger.fatal("countRowsInAllTables - " + e.toString());
		}

		return rowsAffected;

	} // countRowsInAllTables

	/*
	 * finalizeOutlineManually - finalizes an outline without sending mail
	 *	<p>
	 * @param	conn	Connection
	 */
	public static int finalizeOutlineManually(Connection conn,String campus,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			String[] info = Helper.getKixInfo(conn,kix);

			String proposer = info[Constant.KIX_PROPOSER];

			CourseApproval.finalizeOutline(campus,alpha,num,proposer);

			CampusDB.updateCampusOutline(conn,kix,campus);
		}
		catch(SQLException e){
			logger.fatal("Test - finalizeOutlineManually: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - finalizeOutlineManually: " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}