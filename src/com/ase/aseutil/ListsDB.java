/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int addPSLOToOutline(Connection conn,String historyid,String campus,String alpha,String num,String type,String user){
 *	public static int autoFillPSLO(Connection conn,String campus,String kix,String src) throws SQLException {
 *	public static int clearList(Connection conn,String campus,String src,String alpha,String user) {
 *	public static int getNextRDR(Connection conn,String campus,String src,String alpha) throws SQLException {
 *	public static int insertList(Connection conn,String campus,String src,String program,String alpha,String lst,String clear,String user) {
 *	public static String showListBySourceAlpha(Connection conn,String campus,String src,String alpha){
 *
 * @author ttgiang
 */

//
// ListsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ListsDB {

	static Logger logger = Logger.getLogger(ListsDB.class.getName());

	public ListsDB() throws Exception {}

	/**
	 * addPSLOToOutline - add PSLOs to a newly created outline or other creation
	 * <p>
	 * @param	conn			Connection
	 * @param	historyid	String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * @param	user			String
	 * <p>
	 * @return	int
	 */
	public static int addPSLOToOutline(Connection conn,
														String historyid,
														String campus,
														String alpha,
														String num,
														String type,
														String user){

//public static int addSrcToOutline(Connection conn,

		StringBuffer listing = new StringBuffer();
		String comment = "";
		int rowsAffected = 0;

		try{
			if (QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_PROGRAM_SLO)){
				GenericContent gc = null;

				String sql = "SELECT comments " +
					"FROM tblLists " +
					"WHERE campus=? " +
					"AND src=? " +
					"AND alpha=? " +
					"ORDER BY rdr";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_PROGRAM_SLO);
				ps.setString(3,alpha);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					comment = AseUtil.nullToBlank(rs.getString("comments"));
					gc = new GenericContent(0,historyid,campus,alpha,num,type,Constant.COURSE_PROGRAM_SLO,comment,"",user,0);
					rowsAffected += GenericContentDB.insertContent(conn,gc);
				}
				rs.close();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("ListsDB: addPSLOToOutline - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("ListsDB: addPSLOToOutline - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * showListBySourceAlpha - show a list
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	alpha		String
	 * <p>
	 * @return	String
	 */
	public static String showListBySourceAlpha(Connection conn,String campus,String src,String alpha){

		StringBuffer listing = new StringBuffer();
		String comment = "";
		boolean found = false;

//ValuesDB.getListBySrcSubTopic(conn,campus,Constant.COURSE_PROGRAM_SLO,alpha);
		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT comments " +
				"FROM tblLists " +
				"WHERE campus=? " +
				"AND src=? " +
				"AND alpha=? " +
				"ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,Constant.COURSE_PROGRAM_SLO);
			ps.setString(3,alpha);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				comment = aseUtil.nullToBlank(rs.getString("comments"));
				listing.append("<li>" + comment + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				comment = "<ul>" + listing.toString() + "</ul>";
		}
		catch(SQLException se){
			logger.fatal("ListsDB: showListBySourceAlpha - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("ListsDB: showListBySourceAlpha - " + ex.toString());
		}

		return comment;
	}

	/*
	 * autoFillPSLO
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 *	<p>
	 *	@return int
	 */
	public static int autoFillPSLO(Connection conn,String campus,String kix,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String comments = "";
		int rowsAffected = 0;

//public static int addSrcToOutline(Connection conn,
//											String src,
//											String historyid,
//											String campus,
//											String alpha,
//											String num,
//											String type,
//											String user){


		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String proposer = info[3];

			GenericContent gc = null;

			// select requested PSLO for alpha and add to outline
			String sql = "SELECT comments FROM tblLists WHERE campus=? AND src=? and alpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,alpha);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				comments = rs.getString("comments");
				gc = new GenericContent(0,kix,campus,alpha,num,type,src,comments,"",proposer,0);
				rowsAffected += GenericContentDB.insertContent(conn,gc);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ListsDB: autoFillPSLO - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ListsDB: autoFillPSLO - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * clearList	- clear existing list
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	alpha		String
	 * @param	user		String
	 * <p>
	 * @return	int
	 */
	public static int clearList(Connection conn,String campus,String src,String alpha,String user) {

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblLists WHERE campus=? AND src=? AND alpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,alpha);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info(user + " - ListsDB.clearList - " + rowsAffected);
		} catch (SQLException se) {
			logger.fatal("ListsDB: insertList - " + se.toString());

		} catch (Exception ie) {
			logger.fatal("ListsDB: insertList - " + ie.toString());
		}

		return rowsAffected;
	}

	/*
	 * insertList
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	program	String
	 * @param	alpha		String
	 * @param	lst		String
	 * @param	clear		String
	 * <p>
	 * @return	int
	 */
	public static int insertList(Connection conn,
											String campus,
											String src,
											String program,
											String alpha,
											String lst,
											String clear,
											String user) {

		int rowsAffected = 0;
		int i = 0;
		String[] arr;

		try {
			PreparedStatement ps = null;
			AseUtil aseUtil = new AseUtil();

			String sql = "INSERT INTO tblLists(campus,src,program,alpha,comments,auditdate,auditby,rdr) VALUES (?,?,?,?,?,?,?,?)";

			// clear existing list before updating
			if ("1".equals(clear)){
				clearList(conn,campus,src,alpha,user);
			}

			// split content and save
			arr = lst.split("//");
			for(i=0;i<arr.length;i++){
				if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0){
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,src);
					ps.setString(3,program);
					ps.setString(4,alpha);
					ps.setString(5,arr[i]);
					ps.setString(6,aseUtil.getCurrentDateTimeString());
					ps.setString(7,user);
					ps.setInt(8,getNextRDR(conn,campus,src,alpha));
					rowsAffected += ps.executeUpdate();
					ps.close();
				} // if arr
			}	// for

			logger.info(user + " - ListsDB.insert - " + rowsAffected);

			if (i==rowsAffected)
				rowsAffected = 1;
			else
				rowsAffected = -1;

		} catch (SQLException se) {
			logger.fatal("ListsDB: insertList - " + se.toString());

		} catch (Exception ie) {
			logger.fatal("ListsDB: insertList - " + ie.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	alpha		String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection conn,String campus,String src,String alpha) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid "
				+ " FROM tblLists "
				+ " WHERE campus=? AND src=? AND alpha=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid");
			}

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ListsDB: getNextRDR - " + e.toString());
		}

		return id;
	}

	public void close() throws SQLException {}

}