/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// ParkDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class ParkDB {

	static Logger logger = Logger.getLogger(ParkDB.class.getName());

	//
	// this class allows us to park data for tempory use
	//
	// APPROVER_COMMENTED_ITEMS - items approvers commented on.
	//

	public ParkDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param user		String
	 * @param descr	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String kix,String user,String descr) throws Exception {

		boolean exists = false;

		try{
			String sql = "SELECT id FROM tblpark WHERE historyid=? AND userid=? AND descr=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,user);
			ps.setString(3,descr);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Park.isMatch ("+kix+"/"+user+"/"+descr+"/"+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("Park.isMatch ("+kix+"/"+user+"/"+descr+"/"+"): " + e.toString());
		}

		return exists;

	}

	/**
	 * setApproverCommentedItems
	 * <p>
	 * @param	conn	Connection
	 * @param	park	Park
	 * <p>
	 * @return	int
	 */
	public static int setApproverCommentedItems(Connection conn, Park park) {

		int rowsAffected = 0;

		try {

			String descr = getApproverCommentedText();

			if(!isMatch(conn,park.getHistoryId(),park.getUserId(),descr)){
				String sql = "INSERT INTO tblpark(campus,userid,historyid,descr,string1) VALUES(?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,park.getCampus());
				ps.setString(2,park.getUserId());
				ps.setString(3,park.getHistoryId());
				ps.setString(4,descr);
				ps.setString(5,park.getString1());
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				String sql = "UPDATE tblpark SET string1=? WHERE userid=? AND historyid=? AND descr=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,park.getString1());
				ps.setString(2,park.getUserId());
				ps.setString(3,park.getHistoryId());
				ps.setString(4,descr);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}


		} catch (SQLException e) {
			logger.fatal("Park.setApproverCommentedItems: " + e.toString());
		} catch (Exception e) {
			logger.fatal("Park.setApproverCommentedItems: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getApproverCommentedItems
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param user	String
	 * <p>
	 * @return String
	 */
	public static String getApproverCommentedItems(Connection conn,String kix,String user) throws SQLException {

		String items = "";

		String descr = getApproverCommentedText();

		String sql = "SELECT string1 FROM tblpark WHERE historyid=? AND userid=? AND descr=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,user);
		ps.setString(3,descr);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			items = AseUtil.nullToBlank(rs.getString("string1"));
		}
		rs.close();
		ps.close();

		return items;
	}

	/**
	 * deleteApproverCommentedItems
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param user	String
	 * <p>
	 * @return int
	 */
	public static int deleteApproverCommentedItems(Connection conn,String kix,String user) throws SQLException {

		String descr = getApproverCommentedText();

		String sql = "DELETE FROM tblpark WHERE historyid=? AND userid=? AND descr=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,user);
		ps.setString(3,descr);
		int rowsAffected = ps.executeUpdate();
		ps.close();

		return rowsAffected;
	}

	/**
	 * deleteApproverCommentedItems
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * <p>
	 * @return int
	 */
	public static int deleteApproverCommentedItems(Connection conn,String kix) throws SQLException {

		String descr = getApproverCommentedText();

		String sql = "DELETE FROM tblpark WHERE historyid=? AND descr=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,descr);
		int rowsAffected = ps.executeUpdate();
		ps.close();

		return rowsAffected;
	}

	/**
	 * getApproverCommentedText
	 * <p>
	 * @return String
	 */
	public static String getApproverCommentedText() throws SQLException {

		return "APPROVER_COMMENTED_ITEMS";

	}

	/**
	 * isItemEnabled
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param user	String
	 * @param seq	int
	 * <p>
	 * @return boolean
	 */
	public static boolean isItemEnabled(Connection conn,String kix,String user,int seq) throws SQLException {

		// the items are stored as CSV. we get the items back, add a comma to then end for
		// ease of checking

		boolean enabled = false;

		String items = com.ase.aseutil.ParkDB.getApproverCommentedItems(conn,kix,user);
		if(items != null){
			String itemToCheck = ","+seq+",";
			items = "," + items + ",";
			if(items.contains(itemToCheck)){
				enabled = true;
			}
		}

		return enabled;

	}

	/**
	 * removeEnabledItem - returns items after removing item
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * @param user	String
	 * @param seq	int
	 * <p>
	 * @return String
	 */
	public static String removeEnabledItem(Connection conn,String kix,String user,int seq) throws SQLException {

		// the items are stored as CSV. we get the items back, check if there then replace
		// not really a toggle. just add or remove.

		boolean debug = true;

		String itemToCheck = "," + seq + ",";

		String items = com.ase.aseutil.ParkDB.getApproverCommentedItems(conn,kix,user);

		if(items != null && items.length() > 0){

			// items is something like 1,3,26,24
			// adding commas looks like this ,1,3,26,24,
			// itemToCheck looks like this ,1,
			// when checking contains itemToCheck in items, we find the exact match if any
			items = "," + items + ",";

			items = items.replace(itemToCheck,",");

			// when done, we remove the starting and ending comma
			if(items.startsWith(",")){
				items = items.substring(1);
			}

			if(items.endsWith(",")){
				items = items.substring(0,items.length()-1);
			}

			// after removal and there's nothing left, we delete the entry
			if(items == null || items.length() == 0){
				deleteApproverCommentedItems(conn,kix,user);
			}

		}

		return items;

	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}