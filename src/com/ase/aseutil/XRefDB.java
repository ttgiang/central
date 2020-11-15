/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int addRemoveXlistX(Connection connection,String kix,String action,String campus,
 *													String alpha, String num,String alphax, String numx,
 *													String user,int reqID,String type)
 *	public static int crossListingRequiringApproval(Connection conn,String kix) throws Exception {
 *	public static int getNextID(Connection conn)
 *	public static XRef getXRef(Connection conn,int id) {
 *
 * @author ttgiang
 */

//
// XRefDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class XRefDB {

	static Logger logger = Logger.getLogger(XRefDB.class.getName());

	public XRefDB() throws Exception {}

	/**
	 * getXRef
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return	XRef
	 */
	public static XRef getXRef(Connection conn,int id) {

		String sql = "SELECT * FROM tblXRef WHERE id=?";
		XRef xref = new XRef();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
			}
			ps.close();
		} catch (SQLException e) {
			logger.fatal("XRefDB: getXRef - " + e.toString());
			xref = null;
		} catch (Exception ex) {
			logger.fatal("XRefDB: getXRef - " + ex.toString());
			xref = null;
		}

		return xref;
	}

	/*
	 * getNextID
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextID(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblXref";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("XRefDB: getNextID - " + e.toString());
		}

		return id;
	}

	/*
	 * addRemoveXlist
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlist(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID) throws SQLException {

		int rowsAffected = 0;
		boolean added = true;

		String[] info = Helper.getKixInfo(connection,kix);
		String type = info[2];

		// when adding, make sure it's not already in there
		if (action.equals("a") && reqID <= 0){
			String sql = "SELECT coursealphax FROM tblxref " +
								"WHERE campus=? AND coursealpha=?  AND coursenum=?  AND coursetype=? " +
								"AND coursealphax=? AND coursenumx=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, alphax);
			ps.setString(6, numx);
			ResultSet results = ps.executeQuery();
			if (results.next()){
				added = false;
				rowsAffected = -1;
			}
			ps.close();
		}

		if (added){
			rowsAffected = addRemoveXlistX(connection,kix,action,campus,alpha,num,alphax,numx,user,reqID,type);
		}

		return rowsAffected;
	}

	/*
	 * addRemoveXlistX
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	alphax		String
	 * @param	numx			String
	 * @param	user			String
	 * @param	reqID			int
	 * @param	type			String
	 * <p>
	 * @return int
	 */
	public static int addRemoveXlistX(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String user,
													int reqID,
													String type) throws SQLException {

		boolean debug = false;

		int rowsAffected = 0;

		String insertUpdateSQL = "";

		String removeSQL = "";

		String currentType = "";

		// are we adding or updating
		if (action.equals("a")){
			if (reqID > 0)
				insertUpdateSQL = "UPDATE tblXref"
						+ " SET historyid=?,coursealphax=?,coursenumx=?,auditby=?"
						+ " WHERE id=?";
			else
				insertUpdateSQL = "INSERT INTO tblXref"
						+ " (coursealpha,coursenum,campus,coursetype,historyid,coursealphax,coursenumx,auditby,id,pending)"
						+ " VALUES(?,?,?,?,?,?,?,?,?,?)";
		}

		removeSQL = "DELETE FROM tblXref"
				+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND coursealphax=? AND coursenumx=?";

		try {
			debug = DebugDB.getDebug(connection,"XrefDB");

			String sql = "";
			PreparedStatement ps;
			boolean pending = false;

			String[] info = Helper.getKixInfo(connection,kix);
			currentType = info[2];
			String proposer = info[Constant.KIX_PROPOSER];

			if(debug){
				logger.info("kix: " + kix);
				logger.info("action: " + action);
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("alphax: " + alphax);
				logger.info("numx: " + numx);
				logger.info("user: " + user);
				logger.info("reqID: " + reqID);
				logger.info("type: " + type);
				logger.info("proposer: " + proposer);
			}


			if (action.equals("a")) {
				sql = insertUpdateSQL;
				ps = connection.prepareStatement(sql);

				if (reqID > 0){
					ps.setString(1, kix);
					ps.setString(2, alphax);
					ps.setString(3, numx);
					ps.setString(4, user);
					ps.setInt(5, reqID);
				}
				else{
					String crossListingRequiresApproval =
						IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CrossListingRequiresApproval");

					if (crossListingRequiresApproval.equals(Constant.ON)){
						pending = true;
					}

					ps.setString(1, alpha);
					ps.setString(2, num);
					ps.setString(3, campus);
					ps.setString(4, type);
					ps.setString(5, kix);
					ps.setString(6, alphax);
					ps.setString(7, numx);
					ps.setString(8, user);
					ps.setInt(9, getNextID(connection));
					ps.setBoolean(10, pending);
				}
			} else {
				sql = removeSQL;
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
				ps.setString(5, alphax);
				ps.setString(6, numx);
			}

			rowsAffected = ps.executeUpdate();

			String divisionChairName = ChairProgramsDB.getChairName(connection,campus,alphax);

			if(debug){
				logger.info("divisionChairName: " + divisionChairName);
			}

			// if enabled, notify division chair when added. this helps in the planning of sections to add
			if (action.equals(Constant.ADD) && reqID <= 0 && !currentType.equals(Constant.CUR)) {

				String NotifyDivisionChairOnCrossListAdd =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","NotifyDivisionChairOnCrossListAdd");

				if(debug){
					logger.info("NotifyDivisionChairOnCrossListAdd: " + NotifyDivisionChairOnCrossListAdd);
				}

				if (NotifyDivisionChairOnCrossListAdd.equals(Constant.ON)){

					if (!divisionChairName.equals(Constant.BLANK)){

						MailerDB mailerDB = null;

						String crossListingRequiresApproval =
							IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CrossListingRequiresApproval");

						if (crossListingRequiresApproval.equals(Constant.ON)){
							if (debug) logger.info("addRemoveXlistX - proposer: " + proposer);

							// create approval task
							rowsAffected = TaskDB.logTask(connection,
																	divisionChairName,
																	proposer,
																	alpha,
																	num,
																	Constant.APPROVE_CROSS_LISTING_TEXT,
																	campus,
																	"",
																	"ADD",
																	"PRE");
							if (debug) logger.info("addRemoveXlistX - added task for " + divisionChairName);

							mailerDB = new MailerDB(connection,
															proposer,
															divisionChairName,
															"",
															"",
															alpha,
															num,
															campus,
															"emailCrossListingApproval",
															kix,
															user);
							if (debug) logger.info("addRemoveXlistX - mail sent to " + divisionChairName);
						}
						else{
							mailerDB = new MailerDB(connection,
															user,
															divisionChairName,
															"",
															"",
															alpha,
															num,
															campus,
															"emailCrossListAdded",
															kix,
															user);
						} // crossListingRequiresApproval
					}	// if division chair name
				}	// if to notify

				AseUtil.logAction(connection,
										user,
										"ACTION",
										"Request cross listing approval ("+ alphax + " " + numx + "; Chair name: " + divisionChairName+ ")",alpha,num,campus,kix);

			}	// if action = a
			else if ((Constant.REMOVE).equals(action) && reqID <= 0){
				rowsAffected = TaskDB.logTask(connection,
														divisionChairName,
														proposer,
														alpha,
														num,
														Constant.APPROVE_CROSS_LISTING_TEXT,
														campus,
														"",
														"REMOVE",
														"PRE");

				AseUtil.logAction(connection,
										user,
										"ACTION",
										"Cancelled cross listing approval ("+ alphax + " " + numx + ")",alpha,num,campus,kix);
			}

			ps.close();

		} catch (SQLException e) {
			logger.fatal("XRefDB: addRemoveXlistX - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("XRefDB: addRemoveXlistX - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn
	 * @param	campus
	 * @param	alpha
	 * @param	num
	 * @param	type
	 * @param	reqAlpha
	 * @param	reqNum
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,
											String campus,
											String alpha,
											String num,
											String type,
											String reqAlpha,
											String reqNum) throws SQLException {

		String sql = "SELECT id "
						+ "FROM tblXRef "
						+ "WHERE campus=? "
						+ "AND coursealpha=? "
						+ "AND coursenum=? "
						+ "AND coursetype=? "
						+ "AND coursealphax=? "
						+ "AND coursenumx=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		ps.setString(5,reqAlpha);
		ps.setString(6,reqNum);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * crossListingRequiringApproval
	 *	<p>
	 * @param	conn			Connection
	 * @param	kix			String
	 *	<p>
	 * @return	int
	 */
	public static int crossListingRequiringApproval(Connection conn,String kix) throws Exception {

		int count = 0;
		String table = "";

		try{
			String sql = "SELECT COUNT(pending) AS counter "
					+ "FROM tblXref "
					+ "WHERE historyid=? "
					+ "AND pending=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				count = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		}catch(Exception e){
			logger.fatal("XRefDB - crossListingRequiringApproval: " + e.toString());
		}

		return count;
	}

	/*
	 * isPendingApproval - returns true if course is pending approval
	 *	<p>
	 *	@param	conn
	 * @param	campus
	 * @param	alpha
	 * @param	num
	 * @param	type
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isPendingApproval(Connection conn,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		String sql = "SELECT id  "
						+ "FROM tblXRef "
						+ "WHERE campus=? "
						+ "AND coursealpha=? "
						+ "AND coursenum=? "
						+ "AND coursetype=? "
						+ "AND pending=1 ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	public void close() throws SQLException {}

}