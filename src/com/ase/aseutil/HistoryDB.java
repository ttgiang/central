/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int addHistory(Connection conn,String alpha,String num,String campus,String user,
 *											int getNextSequenceNumber,boolean approval,String comments,String historyID,
 *											int seq)
 *
 * public static int approvalBySequence(Connection conn,String kix,int seq) throws Exception {
 *	public static boolean approvalStarted(Connection connection,String campus,String alpha,String num,String user)
 *	public static int deleteHistory(Connection conn,String kix,int id) throws Exception {
 *	public static String getCompletedApproverBySequence(Connection conn,String kix,int sequence) throws Exception {
 *	public static History getGroupVotes(Connection conn,String campus,String kix,String user){
 *	public static History getHistory(Connection conn,String campus,String kix,String user) throws Exception {
 *	public static History getHistory(Connection conn,String campus,String kix,String user,String inviter) throws Exception {
 * public static History getHistoryById(Connection conn,String kix,int id) throws Exception {
 *	public static ArrayList getHistories(Connection connection, String hid, String type)
 *	public static History getLastApproverByRole(Connection conn,String kix,String role) throws Exception {
 *	public static int getNextSequenceNumber(Connection conn) throws SQLException {
 *	public static boolean recalledApprovalHistory(Connection conn,String kix,String alpha,String num,String user) throws Exception {
 *	public static boolean reviewStarted(Connection connection,String campus,String alpha,String num,String user)
 *	public static int updateHistory(Connection conn,String comments,String kix,int id,int voteFor,int voteAgainst,int voteAbstain){
 *	public static int updateHistory(Connection conn,String campus,String user,String comments,String kix,
 *											int votesFor,int votesAgainst,int voteAbstain){
 *
 */

//
// HistoryDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import org.apache.log4j.Logger;

public class HistoryDB {
	static Logger logger = Logger.getLogger(HistoryDB.class.getName());

	public HistoryDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param kix		String
	 * @param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String kix,String user,String inviter) throws SQLException {

		String sql = "SELECT id "
			+ "FROM tblApprovalHist "
			+ "WHERE campus=? "
			+ "AND historyid=? "
			+ "AND approver=? "
			+ "AND inviter=? ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,kix);
		ps.setString(3,user);
		ps.setString(4,inviter);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * getHistories - not correct in spelling,but it's for plurality
	 *	<p>
	 * @param	connection	Connection
	 * @param	hid			String
	 *	@param	type			String
	 *	<p>
	 * @return ArrayList
	 */
	public static ArrayList getHistories(Connection connection,String hid,String type) {

		return getHistories(connection,hid,type,"");
	}

	public static ArrayList getHistories(Connection connection,String hid,String type,String inviter) {

		int i = 0;
		int voteFor = 0;
		int voteAgainst = 0;
		int voteAbstain = 0;
		int id = 0;
		String temp = "";
		String enableVotingButtons = "";
		ArrayList<History> list = new ArrayList<History>();

		try {
			String sql = "";
			String table = "";

			if (type.equals("PRE"))
				table = "tblApprovalHist";
			else
				table = "tblApprovalHist2";

			sql = "SELECT id, approver, dte, comments, approved, votesfor, votesagainst, votesabstain, progress "
				+ "FROM " + table + " WHERE historyid=? ";

			if (inviter != null && inviter.length() > 0){
				sql = sql + " AND inviter='"+inviter+"' ";
			}

			sql = sql + " ORDER BY dte";

			History history;
			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(connection,hid);
			String campus = info[4];
			enableVotingButtons = IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","EnableVotingButtons");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, hid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				history = new History();
				history.setID(NumericUtil.nullToZero(resultSet.getString("id")));
				history.setApprover(AseUtil.nullToBlank(resultSet.getString("approver")));
				history.setDte(AseUtil.nullToBlank(aseUtil.ASE_FormatDateTime(resultSet.getString("dte"),Constant.DATE_DATE_MDY)).trim());

				temp = aseUtil.nullToBlank(resultSet.getString("comments"));

				// for the first time through, append voting results to comments if voting is enable at campus
				if ((Constant.ON).equals(enableVotingButtons)){
					voteFor = NumericUtil.nullToZero(resultSet.getString("votesfor"));
					voteAgainst = NumericUtil.nullToZero(resultSet.getString("votesagainst"));
					voteAbstain = NumericUtil.nullToZero(resultSet.getString("votesabstain"));
					temp = temp + " (Vote for: " + voteFor + "; Vote against: " + voteAgainst + "; Vote abstain: " + voteAbstain + ")";
				}

				history.setComments(temp);
				history.setProgress(AseUtil.nullToBlank(resultSet.getString("progress")));
				history.setApproved(resultSet.getBoolean("approved"));
				list.add(history);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: getHistories - " + e.toString());
			list = null;
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getHistories - " + ex.toString());
			list = null;
		}

		return list;
	}

	/*
	 * approvalStarted - returns true if the approval has started for an outline.
	 *							approval started means there is a comment in the history table.
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	alpha			String
	 *	@param	num			String
	 *	@param	user			String
	 *	<p>
	 * @return	boolean
	 */
	public static boolean approvalStarted(Connection connection,
														String campus,
														String alpha,
														String num,
														String user) {

		boolean started = false;

		//TODO: what about tblApprovalHist2? is that a table to check also. This condition is necessary
		// because of rejection causing the process to start again.
		try {
			String sql = "SELECT coursealpha FROM tblApprovalHist WHERE campus=? AND courseAlpha=? AND coursenum=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			started = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: approvalStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: approvalStarted - " + ex.toString());
		}

		return started;
	}

	/*
	 * approvalStarted - returns true if the approval has started for an outline.
	 *							approval started means there is a comment in the history table.
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	kix			String
	 *	@param	user			String
	 *	<p>
	 * @return	boolean
	 */
	public static boolean approvalStarted(Connection connection,String campus,String kix,String user) {

		boolean started = false;

		//TODO: what about tblApprovalHist2? is that a table to check also. This condition is necessary
		// because of rejection causing the process to start again.
		try {
			String sql = "SELECT id FROM tblApprovalHist WHERE campus=? AND historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet results = ps.executeQuery();
			started = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: approvalStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: approvalStarted - " + ex.toString());
		}

		return started;
	}

	/*
	 * reviewStarted - returns true if the review has started for an outline.
	 *							review started means there is a comment in the history table.
	 *							approval started means there is a comment in the history table.
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	alpha			String
	 *	@param	num			String
	 *	@param	user			String
	 *	<p>
	 * @return	boolean
	 */
	public static boolean reviewStarted(Connection connection,
														String campus,
														String alpha,
														String num,
														String user) {

		boolean started = false;

		//TODO: what about tblApprovalHist2? is that a table to check also. This condition is necessary
		// because of rejection causing the process to start again.
		try {
			String sql = "SELECT coursealpha FROM tblReviewHist WHERE campus=? AND courseAlpha=? AND coursenum=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			started = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: reviewStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: reviewStarted - " + ex.toString());
		}

		return started;
	}


	/*
	 * reviewStarted - returns true if the review has started for an outline.
	 *							review started means there is a comment in the history table.
	 *							approval started means there is a comment in the history table.
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	kix			String
	 *	<p>
	 * @return	boolean
	 */
	public static boolean reviewStarted(Connection connection,String campus,String kix) {

		boolean started = false;

		//TODO: what about tblApprovalHist2? is that a table to check also. This condition is necessary
		// because of rejection causing the process to start again.
		try {
			String sql = "SELECT coursealpha FROM tblReviewHist WHERE campus=? AND historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet results = ps.executeQuery();
			started = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: reviewStarted - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: reviewStarted - " + ex.toString());
		}

		return started;
	}

	/*
	 * addHistory
	 *	<p>
	 * @param	conn							Connection
	 * @param	alpha							String
	 *	@param	num							String
	 *	@param	campus						String
	 *	@param	user							String
	 *	@param	getNextSequenceNumber	int
	 *	@param	approval						boolean
	 *	@param	comments						String
	 *	@param	historyID					String
	 *	<p>
	 * @return	boolean
	 */
	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq){

		int rowsAffected = addHistory(conn,alpha,num,campus,user,getNextSequenceNumber,approval,comments,historyID,seq,"");

		return rowsAffected;
	}

	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq,
											String progress){

		int rowsAffected  = 0;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"HistoryDB");
			String role = TaskDB.getRole(conn,campus,alpha,num,user);
			String sql = "INSERT INTO tblApprovalHist(coursealpha,coursenum,dte,campus,approver,seq,approved,comments,historyid,approver_seq,role,progress) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, AseUtil.getCurrentDateTimeString());
			ps.setString(4, campus);
			ps.setString(5, user);
			ps.setInt(6, getNextSequenceNumber);
			ps.setBoolean(7, approval);
			ps.setString(8, comments);
			ps.setString(9, historyID);
			ps.setInt(10, seq);
			ps.setString(11, role);
			ps.setString(12, progress);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (debug) logger.info(historyID + " - HistoryDB - addHistory - insert to history - " + user);

		} catch (SQLException e) {
			logger.fatal(historyID + " - HistoryDB: addHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal(historyID + " - HistoryDB: addHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * addHistory
	 *	<p>
	 * @param	conn							Connection
	 * @param	alpha							String
	 *	@param	num							String
	 *	@param	campus						String
	 *	@param	user							String
	 *	@param	getNextSequenceNumber	int
	 *	@param	approval						boolean
	 *	@param	comments						String
	 *	@param	historyID					String
	 * @param	voteFor						int
	 * @param	voteAgainst					int
	 * @param	voteAbstain					int
	 *	<p>
	 * @return	boolean
	 */
	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq,
											int voteFor,
											int voteAgainst,
											int voteAbstain){

		return addHistory(conn,
								alpha,
								num,
								campus,
								user,
								getNextSequenceNumber,
								approval,
								comments,
								historyID,
								seq,
								voteFor,
								voteAgainst,
								voteAbstain,
								"",
								"",
								"");
	}

	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq,
											int voteFor,
											int voteAgainst,
											int voteAbstain,
											String inviter){

		int rowsAffected  = 0;

		try {
			String role = TaskDB.getRole(conn,campus,alpha,num,user);
			rowsAffected = addHistory(conn,
												alpha,
												num,
												campus,
												user,
												getNextSequenceNumber,
												approval,
												comments,
												historyID,
												seq,
												voteFor,
												voteAgainst,
												voteAbstain,
												inviter,
												role,
												"");
		} catch (Exception ex) {
			logger.fatal("HistoryDB: addHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq,
											int voteFor,
											int voteAgainst,
											int voteAbstain,
											String inviter,
											String role){

		int rowsAffected = addHistory(conn,
												alpha,
												num,
												campus,
												user,
												getNextSequenceNumber,
												approval,
												comments,
												historyID,
												seq,
												voteFor,
												voteAgainst,
												voteAbstain,
												inviter,
												role,
												"");
		return rowsAffected;
	}

	public static int addHistory(Connection conn,
											String alpha,
											String num,
											String campus,
											String user,
											int getNextSequenceNumber,
											boolean approval,
											String comments,
											String historyID,
											int seq,
											int voteFor,
											int voteAgainst,
											int voteAbstain,
											String inviter,
											String role,
											String progress){

		int rowsAffected  = 0;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"HistoryDB");

			String sql = "INSERT INTO tblApprovalHist(coursealpha,coursenum,dte,campus,approver,"
				+ "seq,approved,comments,historyid,approver_seq,votesfor,votesagainst,votesabstain,inviter,role,progress) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, AseUtil.getCurrentDateTimeString());
			ps.setString(4, campus);
			ps.setString(5, user);
			ps.setInt(6, getNextSequenceNumber);
			ps.setBoolean(7, approval);
			ps.setString(8, comments);
			ps.setString(9, historyID);
			ps.setInt(10, seq);
			ps.setInt(11, voteFor);
			ps.setInt(12, voteAgainst);
			ps.setInt(13, voteAbstain);
			ps.setString(14, inviter);
			ps.setString(15, role);
			ps.setString(16, progress);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (debug) logger.info("HistoryDB - addHistory - insert to history");
		} catch (SQLException e) {
			logger.fatal("HistoryDB: addHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: addHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * approvalBySequence
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	@param	seq	String
	 *	<p>
	 * @return	int
	 */
	public static int approvalBySequence(Connection conn,String kix,int seq) throws Exception {

		int approvers = 0;

		try{
			String sql = "SELECT COUNT(id) AS counter "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? AND approver_seq=? AND approved='1'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approvers = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		}catch(Exception e){
			logger.fatal("HistoryDB - approvalBySequence: " + e.toString());
		}

		return approvers;
	}

	/*
	 * getHistory
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	@param	user		String
	 *	<p>
	 * @return	History
	 */
	public static History getHistory(Connection conn,String campus,String kix,String user) throws Exception {

		History h = null;

		try{
			String sql = "SELECT * "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? "
					+ "AND campus=? "
					+ "AND approver=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,campus);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setApprover(rs.getString("approver"));
				h.setApproved(rs.getBoolean("approved"));
				h.setComments(rs.getString("comments"));
				h.setVoteFor(rs.getInt("votesfor"));
				h.setVoteAgainst(rs.getInt("VotesAgainst"));
				h.setVoteAbstain(rs.getInt("VotesAbstain"));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getHistory - " + ex.toString());
		}

		return h;
	}

	/*
	 * getHistory
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	@param	user		String
	 *	@param	inviter	String
	 *	<p>
	 * @return	History
	 */
	public static History getHistory(Connection conn,String campus,String kix,String user,String inviter) throws Exception {

		History h = null;

		try{
			String sql = "SELECT * "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? "
					+ "AND campus=? "
					+ "AND approver=? "
					+ "AND inviter=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,campus);
			ps.setString(3,user);
			ps.setString(4,inviter);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setApprover(rs.getString("approver"));
				h.setApproved(rs.getBoolean("approved"));
				h.setComments(rs.getString("comments"));
				h.setVoteFor(rs.getInt("votesfor"));
				h.setVoteAgainst(rs.getInt("VotesAgainst"));
				h.setVoteAbstain(rs.getInt("VotesAbstain"));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getHistory - " + ex.toString());
		}

		return h;
	}

	/*
	 * getHistoryById
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	@param	id		int
	 *	<p>
	 * @return	History
	 */
	public static History getHistoryById(Connection conn,String kix,int id) throws Exception {

		History h = null;

		try{
			String sql = "SELECT * "
					+ "FROM tblApprovalHist "
					+ "WHERE historyid=? "
					+ "AND id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setApprover(rs.getString("approver"));
				h.setApproved(rs.getBoolean("approved"));
				h.setComments(rs.getString("comments"));
				h.setVoteFor(rs.getInt("votesfor"));
				h.setVoteAgainst(rs.getInt("VotesAgainst"));
				h.setVoteAbstain(rs.getInt("VotesAbstain"));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getHistoryById - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getHistoryById - " + ex.toString());
		}

		return h;
	}

	/*
	 * updateHistory
	 *	<p>
	 * @param	conn			Connection
	 *	@param	campus		String
	 *	@param	user			String
	 *	@param	comments		String
	 *	@param	kix			String
	 *	<p>
	 * @return	boolean
	 */
	public static int updateHistory(Connection conn,
											String campus,
											String user,
											String comments,
											String kix,
											int votesFor,
											int votesAgainst,
											int voteAbstain,
											String inviter){

		int rowsAffected  = 0;

		try {
			String sql = "UPDATE tblApprovalHist SET comments=?,votesfor=?,votesAgainst=?,votesAbstain=? "
				+ "WHERE campus=? AND historyid=? AND approver=? AND inviter=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,comments);
			ps.setInt(2,votesFor);
			ps.setInt(3,votesAgainst);
			ps.setInt(4,voteAbstain);
			ps.setString(5,campus);
			ps.setString(6,kix);
			ps.setString(7,user);
			ps.setString(8,inviter);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: updateHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: updateHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateHistory
	 *	<p>
	 * @param	conn				Connection
	 *	@param	comments			String
	 *	@param	kix				String
	 *	@param	id					int
	 *	@param	voteFor			int
	 *	@param	voteAgainst		int
	 *	@param	voteAbstain		int

	 *	<p>
	 * @return	boolean
	 */
	public static int updateHistory(Connection conn,String comments,String kix,int id,int voteFor,int voteAgainst,int voteAbstain){

		int rowsAffected  = 0;

		try {
			String sql = "UPDATE tblApprovalHist SET comments=?,votesfor=?,VotesAgainst=?,VotesAbstain=? "
				+ "WHERE historyid=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,comments);
			ps.setInt(2,voteFor);
			ps.setInt(3,voteAgainst);
			ps.setInt(4,voteAbstain);
			ps.setString(5,kix);
			ps.setInt(6,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: updateHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: updateHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getGroupVotes - sum up votes for entire group based on inviter
	 *	<p>
	 * @param	conn			Connection
	 *	@param	campus		String
	 *	@param	kix			String
	 *	@param	user			String
	 *	<p>
	 * @return	boolean
	 */
	public static History getGroupVotes(Connection conn,String campus,String kix,String user){

		History h = null;

		try {
			String sql = "SELECT SUM(votesfor) AS votesfor, SUM(votesagainst) AS votesagainst, SUM(votesabstain) AS votesabstain "
				+ "FROM tblApprovalHist "
				+ "WHERE campus=? "
				+ "AND historyid=? ";

			if (user != null && user.length() > 0)
				sql += "AND inviter=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);

			if (user != null && user.length() > 0)
				ps.setString(3,user);

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setVoteFor(NumericUtil.nullToZero(rs.getInt("votesfor")));
				h.setVoteAgainst(NumericUtil.nullToZero(rs.getInt("VotesAgainst")));
				h.setVoteAbstain(NumericUtil.nullToZero(rs.getInt("VotesAbstain")));
			}
			rs.close();
			ps.close();

			// summation returns data even if 0. in doing so, the return data
			// is not necessarily for the inviter. it may be for others
			// setting to null does not mean nothing came back. just to prevent
			// caller from getting false return values.
			if ((h.getVoteFor() + h.getVoteAgainst() + h.getVoteAbstain()) == 0)
				h = null;

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getGroupVotes - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getGroupVotes - " + ex.toString());
		}

		return h;
	}

	/*
	 * getLastApproverVoteHistory
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 * @return	History
	 */
	public static History getLastApproverVoteHistory(Connection conn,String kix) throws Exception {

		History h = null;

		try{

			String sql = "SELECT * FROM tblApprovalHist "
					+ "WHERE id=(SELECT MAX(id) AS maxID FROM tblApprovalHist WHERE historyid=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setHistoryID(kix);
				h.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				h.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				h.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				h.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
				h.setApproved(rs.getBoolean("approved"));
				h.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				h.setVoteFor(NumericUtil.nullToZero(rs.getInt("votesfor")));
				h.setVoteAgainst(NumericUtil.nullToZero(rs.getInt("VotesAgainst")));
				h.setVoteAbstain(NumericUtil.nullToZero(rs.getInt("VotesAbstain")));
				h.setInviter(AseUtil.nullToBlank(rs.getString("inviter")));
				h.setSeq(NumericUtil.nullToZero(rs.getInt("seq")));
				h.setApproverSeq(NumericUtil.nullToZero(rs.getInt("approver_seq")));
				h.setDte(AseUtil.nullToBlank(rs.getString("dte")));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getLastApproverVoteHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getLastApproverVoteHistory - " + ex.toString());
		}

		return h;
	}

	/*
	 * getLastApproverByRole
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 * @return	History
	 */
	public static History getLastApproverByRole(Connection conn,String kix,String role) throws Exception {

		History h = null;

		try{

			String sql = "SELECT * FROM tblApprovalHist "
					+ "WHERE id=("
					+ "SELECT MAX(id) AS maxID FROM tblApprovalHist WHERE historyid=? AND role=? "
					+ ")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,role);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				h = new History();
				h.setHistoryID(kix);
				h.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				h.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				h.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				h.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
				h.setApproved(rs.getBoolean("approved"));
				h.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				h.setVoteFor(NumericUtil.nullToZero(rs.getInt("votesfor")));
				h.setVoteAgainst(NumericUtil.nullToZero(rs.getInt("VotesAgainst")));
				h.setVoteAbstain(NumericUtil.nullToZero(rs.getInt("VotesAbstain")));
				h.setInviter(AseUtil.nullToBlank(rs.getString("inviter")));
				h.setSeq(NumericUtil.nullToZero(rs.getInt("seq")));
				h.setApproverSeq(NumericUtil.nullToZero(rs.getInt("approver_seq")));
				h.setDte(AseUtil.nullToBlank(rs.getString("dte")));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getLastApproverByRole - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getLastApproverByRole - " + ex.toString());
		}

		return h;
	}

	/*
	 * getCompletedApprovalBySequence - return the approver name from history by sequence number
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	sequence	int
	 *	<p>
	 * @return	String
	 */
	public static String getCompletedApproverBySequence(Connection conn,String kix,int sequence) throws Exception {

		String approver = "";

		try{

			String sql = "SELECT approver FROM tblApprovalHist WHERE historyid=? AND approver_seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,sequence);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				approver = AseUtil.nullToBlank(rs.getString(1));
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: getCompletedApprovalBySequence - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: getCompletedApprovalBySequence - " + ex.toString());
		}

		return approver;
	}

	/*
	 * deleteHistory
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 *	<p>
	 * @return	int
	 */
	public static int deleteHistory(Connection conn,String kix,int id) throws Exception {

		int rowsAffected = 0;

		try{

			String sql = "DELETE FROM tblApprovalHist WHERE historyid=? AND ID=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: deleteHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: deleteHistory - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * recalledApprovalHistory - return the progress from approval history for a user
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 *	<p>
	 * @return	boolean
	 */
	public static boolean recalledApprovalHistory(Connection conn,String kix,String alpha,String num,String user) throws Exception {

		boolean recalled = false;

		try{

			String sql = "SELECT progress FROM tblApprovalHist WHERE historyid=? AND approver=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,user);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				recalled = true;
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("HistoryDB: recalledApprovalHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HistoryDB: recalledApprovalHistory - " + ex.toString());
		}

		return recalled;
	}

	/*
	 * getNextSequenceNumber
	 *	<p>
	 *	@return int
	 */
	public static int getNextSequenceNumber(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(seq) + 1 AS maxid FROM tblApprovalHist";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HistoryDB: getNextSequenceNumber - " + e.toString());
		}

		return id;
	}

	/*
	 * displayVotingHistory
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	<p>
	 *	@return String
	 */
	public static String displayVotingHistory(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String sql = "";
		String rowColor = "";
		String approver = "";

		String temp = "";

		int seq = 0;
		int i = 0;

		boolean foundGroup = false;

		try{
			int voteFor = 0;
			int voteAgainst = 0;
			int voteAbstain = 0;

			int sumVoteFor = 0;
			int sumVoteAgainst = 0;
			int sumVoteAbstain = 0;

			sql = "SELECT votesfor, votesagainst, votesabstain, approver_seq, inviter, approver, comments, progress "
					+ "FROM tblApprovalHist WHERE historyid=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				approver = AseUtil.nullToBlank(rs.getString("approver"));;

				seq = rs.getInt("approver_seq");

				voteFor = NumericUtil.nullToZero(rs.getString("votesfor"));
				voteAgainst = NumericUtil.nullToZero(rs.getString("votesagainst"));
				voteAbstain = NumericUtil.nullToZero(rs.getString("votesabstain"));

				String comments = AseUtil.nullToBlank(rs.getString("comments"));
				String progress = AseUtil.nullToBlank(rs.getString("progress"));

				sumVoteFor += voteFor;
				sumVoteAgainst += voteAgainst;
				sumVoteAbstain += voteAbstain;

				if (i++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append( "<tr height=\"20\" bgcolor=\"" + rowColor + "\">")
					.append("<td class=\"datacolumn\" width=\"10%\">" + seq + "</td>")
					.append("<td class=\"datacolumn\" width=\"20%\">" + approver + "</td>")
					.append("<td class=\"dataColumnRight\" width=\"18%\">" + voteFor + "&nbsp;&nbsp;</td>")
					.append("<td class=\"dataColumnRight\" width=\"18%\">" + voteAgainst + "&nbsp;&nbsp;</td>")
					.append("<td class=\"dataColumnRight\" width=\"18%\">" + voteAbstain + "&nbsp;&nbsp;</td>")
					.append("<td class=\"dataColumnRight\" width=\"16%\">" + progress + "&nbsp;&nbsp;</td>")
					.append("</tr>")
					.append("<tr height=\"20\" bgcolor=\"" + rowColor + "\">")
					.append("<td class=\"textblackth\" width=\"10%\"></td>")
					.append("<td class=\"datacolumn\" colspan=\"5\"><br><font class=\"textblackth\">Comments</font><br>" + comments+ "<br><br></td>")
					.append("</tr>");

				foundGroup = true;

			} // while
			rs.close();
			ps.close();

			rs = null;
			ps = null;

			if (i++ % 2 == 0)
				rowColor = Constant.EVEN_ROW_BGCOLOR;
			else
				rowColor = Constant.ODD_ROW_BGCOLOR;

			if (foundGroup){
				temp = "<fieldset class=\"FIELDSET90\"><legend>Vote Summary</legend>"
						+ "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">"
						+ "<tr height=\"20\" bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
						+ "<td class=\"textblackth\" width=\"10%\">Seq</td>"
						+ "<td class=\"textblackth\" width=\"20%\">Approver</td>"
						+ "<td class=\"textblackTHRight\" width=\"18%\">Votes For&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackTHRight\" width=\"18%\">Votes Against&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackTHRight\" width=\"18%\">Votes Abstain&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackTHRight\" width=\"16%\">Progress</td>"
						+ "</tr>"
						+ buf.toString()
						+ "<tr height=\"20\" bgcolor=\"" + rowColor + "\">"
						+ "<td class=\"datacolumn\" width=\"10%\">&nbsp;</td>"
						+ "<td class=\"textblackth\" width=\"20%\">TOTAL:</td>"
						+ "<td class=\"textblackthRight\" width=\"18%\">" + sumVoteFor + "&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackthRight\" width=\"18%\">" + sumVoteAgainst + "&nbsp;&nbsp;</td>"
						+ "<td class=\"textblackthRight\" width=\"18%\">" + sumVoteAbstain + "&nbsp;&nbsp;</td>"
						+ "<td class=\"datacolumn\" width=\"16%\">&nbsp;</td>"
						+ "</tr>"
						+ "</table>"
						+ "</fieldset>";
			}

		}
		catch(SQLException ce){
			logger.fatal("HistoryDB - displayVotingHistory: " + ce.toString());
		}
		catch(Exception ce){
			logger.fatal("HistoryDB - displayVotingHistory: " + ce.toString());
		}

		if (!foundGroup){
			temp = "<br/><br/><p align=\"center\"><font class=\"textblack\">History data does not exist</font></p>";
		}

		return temp;
	}

	/**
	 * hasHistory - returns true if approval history contains data for kix
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param kix		String
	 * <p>
	 * @return boolean
	 */
	public static boolean hasHistory(Connection conn,String campus,String kix) throws SQLException {

		boolean exists = false;

		try{
			String sql = "SELECT count(id) as counter FROM tblApprovalHist WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && NumericUtil.getInt(rs.getInt("counter"),0) > 0){
				exists = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("HistoryDB - hasHistory: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("HistoryDB - hasHistory: " + e.toString());
		}

		return exists;
	}

	/**
	 * getHistoryIDs - returns CSV of history id(s) from requested table
	 * <p>
	 * @param	cnn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 */
	public static String getHistoryIDs(Connection conn,String campus,String alpha,String num,String type){

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		try{

			String table = "";

			if(type.equals(Constant.ARC)){
				table = "tblCoursearc";
			}
			else if(type.equals(Constant.CAN)){
				table = "tblCoursecan";
			}
			else if(type.equals(Constant.CUR)){
				table = "tblCourse";
			}
			else if(type.equals(Constant.PRE)){
				table = "tblCourse";
			}

			if(!table.equals(Constant.BLANK)){
				if(table.equals("tblCourse")){
					sql = "SELECT historyid FROM "+table+" WHERE campus=? AND coursealpha='_alpha_' AND coursenum='_num_' AND coursetype='_type_'";
				}
				else{
					sql = "SELECT historyid FROM "+table+" WHERE campus=? AND coursealpha='_alpha_' AND coursenum='_num_' ORDER BY coursedate DESC";
				}

				sql = sql.replace("_alpha_",alpha).replace("_num_",num).replace("_type_",type);

				sql = SQLUtil.resultSetToCSV(conn,sql,campus);
			} // valid table and type

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return sql;
	}

	/*
	 */
	public void close() throws SQLException {}

}