/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int deleteFromAllTables(Connection conn,String user,String campus,String alpha,String num,String type)
 *
 */

package com.ase.aseutil.util;

import com.ase.aseutil.*;

import org.apache.log4j.Logger;

import java.sql.*;

public class CCUtil {

	static Logger logger = Logger.getLogger(CCUtil.class.getName());

	/*
	 * deleteFromAllTables
	 *	<p>
	 *	allow cc admins to delete course by campus, alpha, num and type
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 *	<p>
	 * @return	int
	 */
	public static int deleteFromAllTables(String user,String campus,String alpha,String num,String type) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected1 = 0;
		int rowsAffected2 = 0;

		AsePool connectionPool = null;

		Connection conn = null;

		PreparedStatement ps2 = null;
		ResultSet rs2 = null;

		boolean debug = false;

		boolean deleted = false;

		String temp = "";

		try {
			connectionPool = AsePool.getInstance();

			conn = connectionPool.getConnection();

			String kix = Helper.getKix(conn,campus,alpha,num,type);

			if (kix != null && kix.length() > 0){

				String sql = "SELECT distinct so.name AS tbl FROM syscolumns sc, sysobjects so "
							+ "WHERE so.id = sc.id AND so.name LIKE 'tbl%' AND so.name NOT LIKE 'tblTemp%' "
							+ "AND (sc.name ='coursealpha' OR sc.name ='alpha' OR sc.name ='historyid' OR sc.name ='kix')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String tbl = AseUtil.nullToBlank(rs.getString("tbl"));

					temp = tbl.toLowerCase().replace("tbl","");

					try{
						if (!debug){

							// attempt a delete by campus, alpha, num and type
							sql = "DELETE FROM " + tbl + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,campus);
							ps2.setString(2,alpha);
							ps2.setString(3,num);
							ps2.setString(4,type);
							rowsAffected1 = ps2.executeUpdate();
							ps2.close();
							if (rowsAffected1 > 0){
								logger.info(rowsAffected1 + " for source by alpha/num: " + temp);
							}

							// attempt a delete by history id if one exists
							sql = "DELETE FROM " + tbl + " WHERE campus=? AND historyid=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,campus);
							ps2.setString(2,kix);
							rowsAffected2 = ps2.executeUpdate();
							ps2.close();
							if (rowsAffected2 > 0){
								logger.info(rowsAffected2 + " for source by kix: " + temp);
							}

							if (rowsAffected1 > 0 || rowsAffected2 > 0){
								AseUtil.logAction(conn, user, "ACTION","Permanently deleted data from " + temp + " - " + alpha + " " + num,alpha,num,campus,kix);
							}

							deleted = true;
						}
						else{
							// in debug, do a count to show how many are deleted
							sql = "SELECT COUNT(*) FROM " + tbl + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,campus);
							ps2.setString(2,alpha);
							ps2.setString(3,num);
							ps2.setString(4,type);
							rs2 = ps2.executeQuery();
							if (rs2.next()){
								rowsAffected1 = rs2.getInt(1);
								if (rowsAffected1 > 0){
									AseUtil.logAction(conn, user, "ACTION",rowsAffected1+ " rows of data deleled from ("+ temp + ")",alpha,num,campus,kix);
								}
							}
							rs2.close();
							ps2.close();

							sql = "SELECT COUNT(*) FROM " + tbl + " WHERE campus=? AND historyid=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,campus);
							ps2.setString(2,kix);
							rs2 = ps2.executeQuery();
							if (rs2.next()){
								rowsAffected1 = rs2.getInt(1);
								if (rowsAffected1 > 0){
									AseUtil.logAction(conn, user, "ACTION",rowsAffected1+ " rows of data deleled from ("+ temp + ")",alpha,num,campus,kix);
								}
							}
							rs2.close();
							ps2.close();
						} // !debug
					}
					catch(Exception e){
						// ignore errors since not all tables will have alpha/num/type combination.
						//logger.info("deleteFromAllTables - " + e.toString());
					}
				} // while
				rs.close();
				ps.close();

				// if we deleted anything, we need to clear the campus outline from showing
				if (deleted){
					sql = "UPDATE tblCampusOutlines SET "+campus+"=null,"+campus+"_2=null "
							+ " WHERE coursealpha=? AND coursenum=? AND coursetype=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,alpha);
					ps2.setString(2,num);
					ps2.setString(3,type);
					rowsAffected1 = ps2.executeUpdate();
					ps2.close();
				} // deleted

			} // kix

		} catch (SQLException e) {
			logger.fatal("deleteFromAllTables - " + e.toString());
		} catch (Exception e) {
			logger.fatal("deleteFromAllTables - " + e.toString());
		}
		finally{
			connectionPool.freeConnection(conn,"CCUtil - deleteFromAllTables","SYSADM");
		}

		return rowsAffected1;

	} // deleteFromAllTables

	/*
	 * removeDoubleCommas
	 *	<p>
	 *	Remove commas from a string
	 *	<p>
	 * @param	str	String
	 *	<p>
	 * @return	String
	 */
	public static String removeDoubleCommas(String temp) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {

			if (temp != null && temp.indexOf(",,") > -1){
				// remove empty spaces because there is no reason for 2 commas to be
				while(temp.indexOf(",,")>-1){
					temp = temp.replace(",,",",");
				}

				// remove the last and final comma
				if (temp.equals(",") && temp.length() == 1){
					temp = Constant.BLANK;
				}
			}

		} catch (Exception e) {
			logger.fatal("removeDoubleCommas - " + e.toString());
		}

		return temp;

	} // removeDoubleCommas


}
