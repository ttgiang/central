/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * public static String addDays(java.util.Date day, int days) throws Exception {
 * public static String addMonths(java.util.Date day, int months) throws Exception {
 *	public static int countBoardMessages(Connection conn,String campus,String kix,int item) throws java.sql.SQLException {
 *	public static String display(Connection conn,String kix,int activeForum) throws Exception {
 *	public static String displayMessage(Connection conn,int mid) throws Exception {
 *	public static String displayUserForum(Connection conn,String campus,String user) throws Exception {
 * public static String formatDate(java.util.Date day) throws Exception {
 *	public static int getForumID(Connection conn,String campus,String kix) throws SQLException {
 *	public static String getKix(Connection conn,int fid) throws SQLException {
 *	public static String getKixFromMid(Connection conn,int mid) throws SQLException {
 *	public static int getLastMessageID(Connection conn) throws SQLException {
 *	public static int getLastForumID(Connection conn) throws SQLException {
 * public static String getMonthName(java.util.Date day) throws Exception {
 * public static String getMonthName(String day) throws Exception {
 *	public static String getNextForumID(Connection conn,String src) throws SQLException {
 * public static String getSearchSQL(String searchType,
 *   												String author,
 *   												String aType,
 *   												String subject,
 *   												String sType,
 *   												String body,
 *   												String bType,
 *   												String startDate,
 *   												String endDate,
 *   												String keyword) throws Exception {
 *	public static int insertForum(Connection conn,Forum forum,int table,boolean createMessage) {
 *	public synchronized static int insertMessage(Connection conn,Messages messages) {
 *	public static boolean isMatch(Connection conn,String campus,String kix) throws SQLException {
 * public static int monthDiff(java.util.Date d1, java.util.Date d2) throws Exception {
 *	public static String search() throws Exception {
 *	public static String showForumLine(int iId,String sFolderStatus,String sName,String sDescription,long iMessageCount,String campus,boolenan tableHeader) throws Exception {
 *	public static String showPeriodLine(int forumID,String periodType,int iPeriodsAgo, int iMessageCount) throws Exception {
 *	public static String showMessageLine(int iDepth,int iId,int item,String sSubject, String sAuthor,String sTime, int replyCount, String pageType, int iActiveMessageId,int forumID) throws Exception {
 * public static void showChildren(Connection conn,int forumID,int parentID,int iPreviousFilter,int iCurrentLevel,int mid,HttpSession session) throws Exception {
 *	public static String showSearchFormAdvanced(int fid,String author,String aType,String subject,String sType,String body,String bType,String startDate,String endDate) throws Exception {
 *
 * @author ttgiang
 */

//
// ForumDB.java
//
package com.ase.aseutil;

import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;

public class ForumDB {

	static Logger logger = Logger.getLogger(ForumDB.class.getName());

	public static final String FORUM_CLOSED = "closed";

	public ForumDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String kix) throws SQLException {

		boolean exists = false;

		try{
			String sql = "SELECT historyid " +
				"FROM forums " +
				"WHERE campus=? " +
				"AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return exists;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	tp
	 * @param	tl
	 * @param	author
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatch(Connection conn,int fid,int mid,int tp,int tl,String author) throws SQLException {

		boolean exists = false;

		try{
			String sql = "SELECT fid FROM messagesX WHERE fid=? AND mid=? AND tp=? AND tl=? AND author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setInt(3,tp);
			ps.setInt(4,tl);
			ps.setString(5,author);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return exists;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * @param	item
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatchingMessage(Connection conn,int forumID,int item) throws SQLException {

		boolean exists = false;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND item=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ps.setInt(2,item);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isMatchingMessage: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatchingMessage: " + e.toString());
		}

		return exists;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * @param	sq
	 * @param	en
	 * @param	qn
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatchingMessage(Connection conn,int forumID,int sq,int en,int qn) throws SQLException {

		boolean exists = false;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND sq=? AND en=? AND qn=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ps.setInt(2,sq);
			ps.setInt(3,en);
			ps.setInt(4,qn);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isMatchingMessage: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatchingMessage: " + e.toString());
		}

		return exists;
	}

	/**
	 * getTopLevelPost
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * @param	item
	 * <p>
	 * @return	int
	 */
	public static int getTopLevelPostingMessage(Connection conn,int forumID,int item) throws SQLException {

		int post = 0;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND item=? AND thread_parent=0";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				post = NumericUtil.getInt(rs.getInt("message_id"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getTopLevelPostingMessage: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getTopLevelPostingMessage: " + e.toString());
		}

		return post;
	}

	/**
	 * getTopLevelPost
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * @param	sq
	 * @param	en
	 * @param	qn
	 * <p>
	 * @return	int
	 */
	public static int getTopLevelPostingMessage(Connection conn,int forumID,int sq,int en,int qn) throws SQLException {

		int post = 0;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND sq=? AND en=? AND qn=? AND thread_parent=0";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ps.setInt(2,sq);
			ps.setInt(3,en);
			ps.setInt(4,qn);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				post = NumericUtil.getInt(rs.getInt("message_id"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getTopLevelPostingMessage: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getTopLevelPostingMessage: " + e.toString());
		}

		return post;
	}

	/**
	 * getForum
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * <p>
	 * @return	Forum
	 */
	public static Forum getForum(Connection conn,int forumID) throws SQLException {

		Forum forum = null;

		try{
			String sql = "SELECT * FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				forum = new Forum();
				forum.setForumID(rs.getInt("forum_id"));
				forum.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				forum.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
				forum.setCreator(AseUtil.nullToBlank(rs.getString("creator")));
				forum.setRequestor(AseUtil.nullToBlank(rs.getString("requestor")));
				forum.setForum(AseUtil.nullToBlank(rs.getString("forum_name")));
				forum.setDescr(AseUtil.nullToBlank(rs.getString("forum_description")));
				forum.setStartDate(AseUtil.nullToBlank(rs.getString("forum_start_date")));
				forum.setGrouping(AseUtil.nullToBlank(rs.getString("forum_grouping")));
				forum.setSrc(AseUtil.nullToBlank(rs.getString("src")));
				forum.setCounter(rs.getInt("counter"));
				forum.setPriority(rs.getInt("priority"));
				forum.setStatus(AseUtil.nullToBlank(rs.getString("status")));
				forum.setXref(AseUtil.nullToBlank(rs.getString("xref")));

				AseUtil aseUtil = new AseUtil();
				forum.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_SHORT));
				forum.setCreatedDate(aseUtil.ASE_FormatDateTime(rs.getString("createdDate"),Constant.DATE_SHORT));
				aseUtil = null;

				forum.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));

				forum.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				forum.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				forum.setProgram(AseUtil.nullToBlank(rs.getString("program")));

				forum.setViews(rs.getInt("views"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForum: " + e.toString());
		}

		return forum;
	}

	/**
	 * getForumSrc
	 * <p>
	 * @param	conn
	 * @param	forumID
	 * <p>
	 * @return	String
	 */
	public static String getForumSrc(Connection conn,int forumID) throws SQLException {

		String src = null;

		try{
			String sql = "SELECT src FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				src = AseUtil.nullToBlank(rs.getString("src"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumSrc: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumSrc: " + e.toString());
		}

		return src;
	}

	/**
	 * getForumItem
	 * <p>
	 * @param	conn		Connection
	 * @param	forumID	int
	 * @param	column	String
	 * <p>
	 * @return	String
	 */
	public static String getForumItem(Connection conn,int forumID,String column) throws SQLException {

		String forumItem = "";

		try{
			String sql = "SELECT "+column+" FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				forumItem = AseUtil.nullToBlank(rs.getString(column));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumItem: " + e.toString());
		}

		return forumItem;
	}

	/**
	 * getForumID
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * <p>
	 * @return	int
	 */
	public static int getForumID(Connection conn,String campus,String kix) throws SQLException {

		int forumID = 0;

		try{
			String sql = "SELECT forum_id FROM forums WHERE campus=? AND historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()){
				forumID = results.getInt("forum_id");
			}
			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumID: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumID: " + e.toString());
		}

		return forumID;
	}

	/**
	 * getForumID
	 * <p>
	 * @param	conn
	 * @param	kix
	 * <p>
	 * @return	int
	 */
	public static int getForumID(Connection conn,String kix) throws SQLException {

		int forumID = 0;

		try{
			String sql = "SELECT forum_id FROM forums WHERE historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()){
				forumID = results.getInt("forum_id");
			}
			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumID: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumID: " + e.toString());
		}

		return forumID;
	}

	/**
	 * getForumIDFromMid
	 * <p>
	 * @param	conn
	 * @param	mid
	 * <p>
	 * @return	int
	 */
	public static int getForumIDFromMid(Connection conn,int mid) throws SQLException {

		int forumID = 0;

		try{
			String sql = "SELECT forum_id FROM messages WHERE messsage_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet results = ps.executeQuery();
			if (results.next())
				forumID = results.getInt("forum_id");

			results.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumIDFromMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumIDFromMid: " + e.toString());
		}

		return forumID;
	}

	/**
	 * getKix
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	String
	 */
	public static String getKix(Connection conn,int fid) throws SQLException {

		String kix = "";

		try{
			String sql = "SELECT historyid FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				kix = rs.getString("historyid");

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getKix: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getKix: " + e.toString());
		}

		return kix;
	}

	/**
	 * getSubjectFromFid
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	String
	 */
	public static String getSubjectFromFid(Connection conn,int fid) throws SQLException {

		String forum_name = "";

		try{
			String sql = "SELECT forum_name FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				forum_name = rs.getString("forum_name");

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getSubjectFromFid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getSubjectFromFid: " + e.toString());
		}

		return forum_name;
	}

	/**
	 * getCreator
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	String
	 */
	public static String getCreator(Connection conn,int fid) throws SQLException {

		String creator = "";

		try{
			String sql = "SELECT creator FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				creator = AseUtil.nullToBlank(rs.getString("creator"));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getCreator: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getCreator: " + e.toString());
		}

		return creator;
	}

	/**
	 * getCreator
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getCreator(Connection conn,int fid,int mid) throws SQLException {

		String creator = "";

		try{
			String sql = "SELECT message_author FROM messages WHERE forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				creator = AseUtil.nullToBlank(rs.getString("message_author"));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getCreator: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getCreator: " + e.toString());
		}

		return creator;
	}

	/**
	 * getStatus
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	String
	 */
	public static String getStatus(Connection conn,int fid) throws SQLException {

		String status = "";

		try{
			String sql = "SELECT status FROM forums WHERE forum_id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				status = AseUtil.nullToBlank(rs.getString("status"));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getStatus: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getStatus: " + e.toString());
		}

		return status;
	}

	/**
	 * getKixFromMid
	 * <p>
	 * @param	conn
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getKixFromMid(Connection conn,int mid) throws SQLException {

		String kix = "";

		try{
			String sql = "SELECT forums.historyid "
						+ "FROM forums INNER JOIN "
						+ "messages ON forums.forum_id = messages.forum_id "
						+ "WHERE messages.message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				kix = rs.getString("historyid");

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getKixFromMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getKixFromMid: " + e.toString());
		}

		return kix;
	}

	/**
	 * getKixInfo
	 * <p>
	 * @param	conn
	 * @param	kix
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfo(Connection conn,String kix) throws SQLException {

		int i = 0;
		int counter = 11;
		String sql = "SELECT forum_name, priority, src, creator, campus, historyid, forum_id, status, forum_grouping,forum_name,xref "
						+ "FROM forums "
						+ "WHERE historyid=?";
		String[] info = new String[counter];

		try{
			for (i=0;i<counter;i++)
				info[i] = "";

			String dataType[] = {"s","s","s","s","s","s","i","s","s","s","s"};

			if (kix != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next())
					info = SQLUtil.resultSetToArray(rs,dataType);
				rs.close();
				ps.close();
			} // kix
		}
		catch(Exception ex){
			logger.fatal("ForumDB: getKixInfo - " + ex.toString());
			info[0] = "";
		}

		return info;

	}

	/**
	 * getCampusFromKix
	 * <p>
	 * @param	conn
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getCampusFromKix(Connection conn,String kix) throws SQLException {

		String campus = "";

		try{
			String sql = "SELECT campus FROM forums WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				campus = AseUtil.nullToBlank(rs.getString("campus"));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getCampusFromKix: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getCampusFromKix: " + e.toString());
		}

		return campus;
	}

	/**
	 * getCampusFromFid
	 * <p>
	 * @param	conn
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getCampusFromFid(Connection conn,int fid) throws SQLException {

		String campus = "";

		try{
			String sql = "SELECT campus FROM forums WHERE fid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				campus = rs.getString("campus");

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getCampusFromFid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getCampusFromFid: " + e.toString());
		}

		return campus;
	}

	/**
	 * getCampusFromMid
	 * <p>
	 * @param	conn
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getCampusFromMid(Connection conn,int mid) throws SQLException {

		String campus = "";

		try{
			String sql = "SELECT forums.campus "
						+ "FROM forums INNER JOIN "
						+ "messages ON forums.forum_id = messages.forum_id "
						+ "WHERE messages.message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				campus = rs.getString("campus");

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getCampusFromMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getCampusFromMid: " + e.toString());
		}

		return campus;
	}

	/**
	 * insertForum
	 * <p>
	 * @param	conn
	 * @param	forum
	 * @param	createMessage
	 * <p>
	 * @return	int
	 */
	public static int insertForum(Connection conn,Forum forum,int table,boolean createMessage) {

		return insertForum(conn,forum,table,createMessage,"",0);

	}

	public static int insertForum(Connection conn,Forum forum,int table,boolean createMessage,String txt,int mode) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		int lastForumID = 0;

		String timeStamp = AseUtil.getCurrentDateTimeString();

		String kix = forum.getHistoryid();
		String src = forum.getSrc();
		String user = forum.getCreator();
		String temp = "";
		String proposer = forum.getCreator();

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"ForumDB");

			// if we get here and historyID is not available, create it.otherwise
			// it was sent in from elsewhere.
			if (kix == null || kix.length() == 0 || kix.equals("TBD")){

				// kix is in format of 2 characters and 5 digits
				kix = ForumDB.getNextForumKix(conn,src,user);

				// remove the letters and keep 5 digits. For user name, remove the number
				// of characters from the name
				if (src.equals(Constant.FORUM_USERNAME)){
					temp = kix.replace(user,"");
				}
				else if (src.equals(Constant.TODO)){
					temp = kix.replace(Constant.TODO,"");
				}
				else{
					temp = kix.substring(2);
				}
			}
			else{
				temp = "1";
			}

			// when source is course, make the proposer owner of the forum
			if(src.equals(Constant.COURSE)){
				proposer = CourseDB.getCourseProposer(conn,kix);
			}

			if(debug){
				logger.info("src: " + src);
				logger.info("table: " + table);
				logger.info("createMessage: " + createMessage);
				logger.info("txt: " + txt);
				logger.info("mode: " + mode);
				logger.info("proposer: " + proposer);
			}

			// only 1 forum per outline
			if (!ForumDB.isMatch(conn,forum.getCampus(),kix)){

				int counter = 0;

				// convert 5 digits into a number for saving
				try{
					counter = NumericUtil.stringToInt(temp);
				}
				catch(Exception e){
					System.out.println(e.toString());
				}

				if(debug) logger.info("counter: " + counter);

				String sql = "INSERT INTO forums(forum_id,forum_name,forum_description,forum_start_date,campus,historyid,creator,"
								+ "requestor,src,counter,createddate,auditdate,status,priority,forum_grouping,auditby,xref,coursealpha,coursenum,program) "
								+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,ForumDB.getNextForumID(conn));
				ps.setString(2,forum.getForum());
				ps.setString(3,forum.getDescr());
				ps.setString(4,forum.getStartDate());
				ps.setString(5,forum.getCampus());
				ps.setString(6,kix);
				ps.setString(7,proposer);
				ps.setString(8,proposer);
				ps.setString(9,src);
				ps.setInt(10,counter);
				ps.setString(11,forum.getStartDate());
				ps.setString(12,forum.getStartDate());
				ps.setString(13,"Requirements");
				ps.setInt(14,0);
				ps.setString(15,src);
				ps.setString(16,forum.getCreator());
				ps.setString(17,forum.getXref());
				ps.setString(18,forum.getCourseAlpha());
				ps.setString(19,forum.getCourseNum());
				ps.setString(20,forum.getProgram());
				rowsAffected = ps.executeUpdate();
				ps.close();

				rowsAffected = ForumDB.getLastForumID(conn);

				lastForumID = rowsAffected;

				// when source is a defect, send it directly to programmer
				if(src.equals(Constant.DEFECT)){

					AseUtil.logAction(conn,
											forum.getCreator(),
											"ACTION",
											"Defect added - " + forum.getForum(),
											ForumDB.getShortForumCode(src) + ForumDB.padKix(""+lastForumID),
											Constant.BLANK,
											forum.getCampus(),
											kix);

					MailerDB mailerDB = new MailerDB(conn,
																forum.getCampus(),
																""+lastForumID,
																forum.getCreator(),
																forum.getDescr(),
																"Defect Reported - " + lastForumID);

				}
				else{
					AseUtil.logAction(conn,
											forum.getCreator(),
											"ACTION",
											"Message Forum added " + forum.getDescr(),
											ForumDB.getShortForumCode(src) + ForumDB.padKix(""+lastForumID),
											Constant.BLANK,
											forum.getCampus(),
											kix);
				}

			} // not match
			else{
				lastForumID = ForumDB.getForumID(conn,forum.getCampus(),kix);
			}

		} catch (SQLException e) {
			logger.fatal("ForumDB: insertForum - " + e.toString());
			lastForumID = -1;
		}
		catch(Exception e){
			logger.fatal("ForumDB: insertForum - " + e.toString());
			lastForumID = -1;
		}

		// returning the last forumID to help position the message id to display
		return lastForumID;
	}

	/*
	 * getLastForumID
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int getLastForumID(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(forum_id) AS maxid FROM forums";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		}

		return id;
	}

	/*
	 * getNextSrcCounter - counter is a value created for each grouping of forum category
	 *	<p>
	 *	@param	conn	Connection
	 * @param	src	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextSrcCounter(Connection conn,String shortForumCode) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(counter)+1 AS maxid FROM forums WHERE historyid like '"+shortForumCode+"%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid");
			}
			else{
				id = 1;
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getNextSrcCounter - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: getNextSrcCounter - " + e.toString());
		}

		return id;
	}

	/*
	 * getNextForumKix
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	src	String
	 *	@param	user	String
	 *	<p>
	 *	@return String
	 */
	public static String getNextForumKix(Connection conn,String src,String user) throws SQLException {

		String nextForumKix = "";

		try {
			// convert lengthy names to shortname version
			// when not found, it stays as src (ie... user)

			// however if the user's name is desired, then use it as the key
			// IE: THANHG00001 and on. This is easier to display user boards
			if (src.equals(Constant.FORUM_USERNAME)){
				src = user;
			}
			else{
				src = getShortForumCode(src);
			}

			nextForumKix = src + "" + padKix("" + getNextSrcCounter(conn,src));

		} catch (Exception e) {
			logger.fatal("ForumDB: getNextForumKix - " + e.toString());
		}

		return nextForumKix;
	}

	/*
	 * padKix
	 *	<p>
	 *	@param	id		String
	 *	<p>
	 *	@return String
	 */
	public static String padKix(String id) throws SQLException {

		String paddedKix = "";

		try {
			if (id != null){
				if (id.length()==1)
					paddedKix = "0000" + id;
				else if (id.length()==2)
					paddedKix = "000" + id;
				else if (id.length()==3)
					paddedKix = "00" + id;
				else if (id.length()==4)
					paddedKix = "0" + id;
				else
					paddedKix = "" + id;
			}

		} catch (Exception e) {
			logger.fatal("ForumDB: padKix - " + e.toString());
		}

		return paddedKix;
	}

	/*
	 * getShortForumCode
	 *	<p>
	 *	@param	src		String
	 *	<p>
	 *	@return String
	 */
	public static String getShortForumCode(String src) throws SQLException {

		try {
			if (src.equals(Constant.COURSE))
				src = Constant.FORUM_COURSE;
			else if (src.equals(Constant.DEFECT))
				src = Constant.FORUM_DEFECT;
			else if (src.equals(Constant.ENHANCEMENT))
				src = Constant.FORUM_ENHANCEMENT;
			else if (src.equals(Constant.PROGRAM))
				src = Constant.FORUM_PROGRAM;
			else if (src.equals(Constant.TODO))
				src = Constant.TODO;
			else
				src = "USER";

		} catch (Exception e) {
			logger.fatal("ForumDB: getShortForumCode - " + e.toString());
		}

		return src ;
	}

	/**
	 * insertMessage - returns last id added
	 * <p>
	 * @param	conn
	 * @param	message
	 * <p>
	 * @return	int
	 */
	public synchronized static int insertMessage(Connection conn,Messages messages) {

		int rowsAffected = 0;
		int lastMessageID = 0;

		int forumID = 0;
		int item = 0;
		boolean debug = false;

		String body = "";
		String subject = "";
		String messageAuthor = "";
		String messageCampus = "";

		try {
			body = messages.getBody();
			subject = messages.getSubject();
			forumID = messages.getForumID();
			item = messages.getItem();
			messageAuthor = messages.getAuthor();

			if (messageAuthor != null){
				messageCampus = UserDB.getUserCampus(conn,messageAuthor);
			}

			int newMid = getNextMessageID(conn);

			String sql = "INSERT INTO messages(message_id,message_timestamp,"
														+ "forum_id,"
														+ "item,"
														+ "thread_id,"
														+ "thread_parent,"
														+ "thread_level,"
														+ "message_author,"
														+ "message_author_notify,"
														+ "message_subject,"
														+ "message_body,"
														+ "processed,"
														+ "acktion,"
														+ "notified,sq,en,qn) "
														+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,newMid);
			ps.setString(2,messages.getTimeStamp());
			ps.setInt(3,forumID);
			ps.setInt(4,item);
			ps.setInt(5,messages.getThreadID());
			ps.setInt(6,messages.getThreadParent());
			ps.setInt(7,messages.getThreadLevel());
			ps.setString(8,messageAuthor);
			ps.setBoolean(9,messages.getNotify());
			ps.setString(10,subject);
			ps.setString(11,body);
			ps.setInt(12,0);
			ps.setInt(13,messages.getAcktion());
			ps.setInt(14,messages.getNotified());
			ps.setInt(15,messages.getSq());
			ps.setInt(16,messages.getEn());
			ps.setInt(17,messages.getQn());
			rowsAffected = ps.executeUpdate();
			ps.close();

			// if a successful record was saved, get the last added message ID,
			// use it to set the thread id
			if (rowsAffected > 0){

				//
				// change creator/owner when reopening
				//
				if(isPostClosedFidItem(conn,forumID,item)){
					setCreator(conn,forumID,item,messageAuthor);
				}

				lastMessageID = getLastMessageID(conn,forumID);

				// set notify flag on to indicate a new message is available
				setNotifyFlag(conn,
									forumID,
									newMid,
									messages.getThreadParent(),
									messages.getThreadLevel(),
									forumID,
									messages.getThreadParent(),
									messages.getThreadLevel(),
									messageCampus,
									messageAuthor);

				if (messages.getThreadID() == 0){
					sql = "UPDATE messages SET thread_id=? WHERE message_id=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,lastMessageID);
					ps.setInt(2,lastMessageID);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
				else{
					//
					// send notification email to anyone requesting a message when someone posts
					// exclude sending to this last person posting
					//
					String[] info = Helper.getKixInfoFromForumID(conn,forumID);
					if (info != null){

						String alpha = info[Constant.KIX_ALPHA];
						String num = info[Constant.KIX_NUM];

						String kix = "";
						String forumName = "";

						Forum forum = getForum(conn,forumID);
						if (forum != null){

							kix = forum.getHistoryid();
							forumName = forum.getForum();

							AseUtil.logAction(conn,
											messageAuthor,
											"ACTION",
											"New message posted: " + forumName + " - " + subject,
											Constant.BLANK,
											Constant.BLANK,
											messageCampus,
											kix);
						}

						// send the message to anyone but the author
						sql = "SELECT DISTINCT message_author, message_id "
								+ "FROM messages "
								+ "WHERE message_id != ? "
								+ "AND thread_id = ? "
								+ "AND message_author_notify = 1 "
								+ "AND message_author != '' "
								+ "AND message_author != ?";
						ps = conn.prepareStatement(sql);
						ps.setInt(1,lastMessageID);
						ps.setInt(2,messages.getThreadID());
						ps.setString(3,messages.getAuthor());
						ResultSet rs = ps.executeQuery();
						while(rs.next()){
							String forumAuthor = AseUtil.nullToBlank(rs.getString("message_author"));
							int mid = rs.getInt("message_id");

							try{
								new MailerDB(conn,
											messageAuthor,
											forumAuthor,
											Constant.BLANK,
											Constant.BLANK,
											alpha,
											num,
											messageCampus,
											"emailMessagePosted",
											kix,
											messageAuthor);

							} catch (Exception e) {
								logger.fatal("ForumDB: insertMessage - send mail - " + e.toString());
							}

							setNotified(conn,forumID,mid,Constant.ON);

						} // while

						rs.close();
						ps.close();

					} // info != null
				} // if (messages.getThreadID()
			} // if rowsAffected > 0

		} catch (SQLException e) {
			logger.fatal("ForumDB: insertMessage - " + e.toString());
			lastMessageID = -1;
		} catch (Exception e) {
			logger.fatal("ForumDB: insertMessage - " + e.toString());
			lastMessageID = -1;
		}

		return lastMessageID;
	}

	/*
	 * setNotified - set notified flag to on or off
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	fid	int
	 *	@param	mid	int
	 *	@param	flag	String
	 *	<p>
	 *	@return int
	 */
	public static int setNotified(Connection conn,int fid,int mid,String flag) throws SQLException {

		int rowsAffected = 0;
		int notified = 0;

		try {
			if (flag.equals(Constant.ON)){
				notified = 1;
			}

			String sql = "UPDATE messages SET notified=? WHERE forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,notified);
			ps.setInt(2,fid);
			ps.setInt(3,mid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: setNotified - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: setNotified - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * setNotified - set notified flag to on or off
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	user	String
	 *	@param	fid	int
	 *	@param	flag	String
	 *	<p>
	 *	@return int
	 */
	public static int setNotified(Connection conn,String user,int fid,String flag) throws SQLException {

		int rowsAffected = 0;
		int notified = 0;

		try {
			if (flag.equals(Constant.ON)){
				notified = 1;
			}

			String sql = "UPDATE messages SET notified=? WHERE forum_id=? AND message_author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,notified);
			ps.setInt(2,fid);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: setNotified - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: setNotified - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getLastMessageID
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getLastMessageID(Connection conn,int forumID) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(message_id) AS maxid FROM messages WHERE forum_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getLastMessageID - " + e.toString());
		}

		return id;
	}

	/*
	 * formatDate
	 *	<p>
	 *	@param	day
	 *	<p>
	 *	@return String
	 */
   public static String formatDate(java.util.Date day) throws Exception {

		try{
			String DATE_FORMAT = Constant.CC_DATE_FORMAT;

			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat(DATE_FORMAT);

			Calendar calendar = Calendar.getInstance();

			calendar.setTime(day);

			return sdf.format(calendar.getTime());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return "";
	}

	/**
	 * addDays
	 * <p>
	 * @return	String
	*/
   public static String addDays(java.util.Date day, int days) throws Exception {

		try{
			String DATE_FORMAT = Constant.CC_DATE_FORMAT;

			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat(DATE_FORMAT);

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(day);
			calendar.add(Calendar.DATE,days);

			return sdf.format(calendar.getTime());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return "";
	}

	/**
	 * addMonths
	 * <p>
	 * @return	String
	*/
   public static String addMonths(java.util.Date day, int months) throws Exception {

		try{
			String DATE_FORMAT = Constant.CC_DATE_FORMAT;

			java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat(DATE_FORMAT);

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(day);
			calendar.add(Calendar.MONTH,months);

			return sdf.format(calendar.getTime());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return "";
	}

	/**
	 * monthDiff
	 * <p>
	 * @param	d1 	java.util.Date
	 * @param	d2 	java.util.Date
	 * <p>
	 * @return	int
	*/
   public static int monthDiff(java.util.Date d1, java.util.Date d2) throws Exception {

		int monthsDiff = 0;

		try{
			//Months d = Months.monthsBetween(new DateTime(d1), new DateTime(d2));
			//monthsDiff = d.getMonths();

			Calendar date1 = Calendar.getInstance();
			date1.setTime(d1);

			Calendar date2 = Calendar.getInstance();
			date2.setTime(d2);

			monthsDiff = monthsBetween(date1,date2);

		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return monthsDiff;
	}

	/**
	 * monthsBetween
	 * <p>
	 * @param date1	Calendar
	 * @param date2	Calendar
	 * <p>
	 * @return	int
	*/
	public static int monthsBetween(Calendar date1, Calendar date2){

		double monthsBetween = 0;

		//difference in month for years
		monthsBetween = (date1.get(Calendar.YEAR)-date2.get(Calendar.YEAR))*12;

		//difference in month for months
		monthsBetween += date1.get(Calendar.MONTH)-date2.get(Calendar.MONTH);

		//difference in month for days
		if(date1.get(Calendar.DAY_OF_MONTH)!=date1.getActualMaximum(Calendar.DAY_OF_MONTH)
			&& date1.get(Calendar.DAY_OF_MONTH)!=date1.getActualMaximum(Calendar.DAY_OF_MONTH) ){
			monthsBetween += ((date1.get(Calendar.DAY_OF_MONTH)-date2.get(Calendar.DAY_OF_MONTH))/31d);
		}

		int months = 0;

		if(monthsBetween > 0){
			months = (int)monthsBetween;
		}

		return months;
	}

	/**
	 * getMonthName
	 * <p>
	 * @return	String
	*/
   public static String getMonthName(java.util.Date day) throws Exception {

		String monthName = "";

		try{
			String[] months = {"January","February","March",
										"April","May","June",
										"July","August","September",
										"October","November","December"};

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(day);
			monthName = months[calendar.get(Calendar.MONTH)];
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return monthName;
	}

	/**
	 * getMonthName
	 * <p>
	 * @return	String
	*/
	@SuppressWarnings("unchecked")
   public static String getMonthName(String day) throws Exception {

		String monthName = "";

		try{
			java.util.Date date = new java.util.Date(day);
			monthName = getMonthName(date);
		}
		catch(Exception e){
			logger.fatal("ForumDB - isMatch: " + e.toString());
		}

		return monthName;
	}

	/**
	 * showForumLine
	 * <p>
	 * @return	String
	*/
	public static String showForumLine(int iId,
													String sFolderStatus,
													String sName,
													String sDescription,
													long iMessageCount,
													String kix,
													String campus,
													boolean tableHeader,
													String xref) throws Exception {

		StringBuffer output = new StringBuffer();

		int attachments = 0;

		try{
			if (!kix.equals(Constant.BLANK)){
				attachments = getAttachments(kix,"","","Forum",campus);
			}

			if (tableHeader){

				Connection conn = null;

				String created = null;
				String updated = null;
				int priority = 0;

				try{
					conn = AsePool.createLongConnection();
					Forum forum = null;

					// at the main or root node, no alpha or num available
					if (conn != null){
						forum = getForum(conn,iId);

						if (forum != null){
							created = forum.getCreatedDate();
							updated = forum.getAuditDate();
							priority = forum.getPriority();
						}

						forum = null;
					}
				}
				catch(Exception e){
					logger.fatal("ForumDB: showForumLine - " + e.toString());
				}
				finally{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}

				output.append("<tr>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
						+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
						+ "</a></td>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + kix + "</A></td>"
						+ "<td>"+campus+"</td>"
						+ "<td align=\"right\">"+created+"</td>"
						+ "<td align=\"center\">"+priority+"</td>"
						+ "<td>"+sName+"</td>"
						+ "<td align=\"right\">"+updated+"</td>"
						+ "<td align=\"center\">"+iMessageCount+"</td>"
						+ "<td align=\"center\">"+attachments+"</td>"
						+ "<td align=\"center\">"+xref+"</td>"
						+ "</tr>");
			}
			else{
				if (!kix.equals(Constant.BLANK)){
					output.append("<A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
									+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
									+ "</a>"
									+ "&nbsp;"
									+ "<A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + sName + "</A>"
									+ "&nbsp;");
				}
				else{
					output.append("<A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
									+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
									+ "</a>"
									+ "&nbsp;"
									+ "<A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + kix + "</A>"
									+ "&nbsp;("+campus+")&nbsp;"
									+ "&nbsp;--&nbsp;"
									+ sName);
				} // kix

				if (sDescription != null && sDescription.length() > 0){
					output.append("&nbsp;--&nbsp;");
					output.append(sDescription);
				}

				if (iMessageCount > 0 || attachments > 0) {

					output.append("&nbsp;(");

					if (iMessageCount > 0) {
						output.append(iMessageCount);
						output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"messages\" alt=\"messages\" border=\"0\">;");
					}

					if (attachments > 0) {
						output.append("&nbsp;");
						output.append(attachments);
						output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					}

					output.append(")" + Html.BR());
				} // iMessageCount

			} // tableHeader
		}
		catch(Exception e){
			logger.fatal("ForumDB - showForumLine: " + e.toString());
		}

		return output.toString();
	}

	public static String showForumLineJQ(int iId,
													String sFolderStatus,
													String sName,
													String sDescription,
													long iMessageCount,
													String kix,
													String campus,
													boolean tableHeader,
													String xref) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();

		int attachments = 0;

		try{
			if (!kix.equals(Constant.BLANK)){
				attachments = getAttachments(kix,"","","Forum",campus);
			}

			if (tableHeader){

				Connection conn = null;

				String created = null;
				String updated = null;
				int priority = 0;

				try{
					conn = AsePool.createLongConnection();
					Forum forum = null;

					// at the main or root node, no alpha or num available
					if (conn != null){
						forum = ForumDB.getForum(conn,iId);

						if (forum != null){
							created = forum.getCreatedDate();
							updated = forum.getAuditDate();
							priority = forum.getPriority();
						}

						forum = null;
					}
				}
				catch(Exception e){
					logger.fatal("ForumDB: showForumLine - " + e.toString());
				}
				finally{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}

				output.append("<tr>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
						+ "<IMG SRC=\"../../images/edit.gif\" BORDER=\"0\">"
						+ "</a></td>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + kix + "</A></td>"
						+ "<td>"+campus+"</td>"
						+ "<td align=\"right\">"+created+"</td>"
						+ "<td align=\"right\">"+priority+"</td>"
						+ "<td>"+sName+"</td>"
						+ "<td align=\"right\">"+updated+"</td>"
						+ "<td align=\"right\">"+iMessageCount+"</td>"
						+ "<td align=\"right\">"+attachments+"</td>"
						+ "<td align=\"right\">"+xref+"</td>"
						+ "</tr>");

			}
			else{
				if (!kix.equals(Constant.BLANK)){
					output.append("<A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
									+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
									+ "</a>"
									+ "&nbsp;"
									+ "<A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + sName + "</A>"
									+ "&nbsp;");
				}
				else{
					output.append("<A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
									+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
									+ "</a>"
									+ "&nbsp;"
									+ "<A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + kix + "</A>"
									+ "&nbsp;("+campus+")&nbsp;"
									+ "&nbsp;--&nbsp;"
									+ sName);
				} // kix

				if (sDescription != null && sDescription.length() > 0){
					output.append("&nbsp;--&nbsp;");
					output.append(sDescription);
				}

				if (iMessageCount > 0 || attachments > 0) {

					output.append("&nbsp;(");

					if (iMessageCount > 0) {
						output.append(iMessageCount);
						output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"messages\" alt=\"messages\" border=\"0\">;");
					}

					if (attachments > 0) {
						output.append("&nbsp;");
						output.append(attachments);
						output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					}

					output.append(")" + Html.BR());
				} // iMessageCount

			} // tableHeader
		}
		catch(Exception e){
			logger.fatal("ForumDB - showForumLineJQ: " + e.toString());
		}

		return output.toString();
	} // ForumDB.showForumLineJQ

	/**
	*
	*/
	public static String showPeriodLine(int forumID,String periodType,int iPeriodsAgo, int iMessageCount) throws Exception {

		StringBuffer output = new StringBuffer();

		try{
			output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
			output.append("<A class=\"linkcolumn\" HREF=\"./display.jsp?fid=" + forumID + "&pts=" + iPeriodsAgo + "\">");

			java.util.Date today = new java.util.Date();

			if(periodType.equals("7days")){
				if (iPeriodsAgo==0)
					output.append("<B>Last 7 Days</B></A>");
				else if (iPeriodsAgo==1)
					output.append("<B>8 to 14 Days Ago</B></A>");
				else if (iPeriodsAgo==2)
					output.append("<B>15 to 21 Days Ago</B></A>");
				else{
					output.append("<B>" + getMonthName(addMonths(today,-(iPeriodsAgo - 3))) + "'s Posts</B></A>");
				}
			}
			else{
				output.append("<B>" + getMonthName(addMonths(today,-iPeriodsAgo)) + "'s Posts</B></A>");
			}

			if (iMessageCount > 0){
				output.append("&nbsp;(");
				output.append(iMessageCount);
				output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"replies\" alt=\"replies\" border=\"0\">;");
			}
		}
		catch(Exception e){
			logger.fatal("ForumDB - showPeriodLine: " + e.toString());
		}

		return output.toString();
	}

	/**
	*
	*/
	public static String showMessageLine(int iDepth,
														int iId,
														int item,
														String sSubject,
														String sAuthor,
														String sTime,
														int replyCount,
														String pageType,
														int iActiveMessageId,
														int forumID,
														int processed) throws Exception {

		StringBuffer output = new StringBuffer();

		int attachments = 0;

		String boldStart = "";
		String boldEnd = "";

		try{
			for(int i = 0; i <iDepth; i++){
				output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
			}

			if (pageType.equals("message")) {
				if (iActiveMessageId==iId) {
					output.append("<IMG SRC=\"./images/check.gif\" BORDER=\"0\">");
				} else {
					output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
				}
			} else {
				output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
			}

			// bold the name to indicate unread message
			if (processed == 0){
				boldStart = "<b>";
				boldEnd = "</b>";
			}

			output.append("<IMG SRC=\"../images/message"+iDepth+".gif\" BORDER=\"0\" ALIGN=\"absmiddle\">");
			output.append("&nbsp;");
			output.append("<A  class=\"linkcolumn\" HREF=\"./displaymsg.jsp?fid=" + forumID + "&mid=" + iId + "&item="+item+"\">" + sSubject.replace(" ","&nbsp;") + "</A>");
			output.append("&nbsp;by&nbsp;");
			output.append("<I>" + boldStart + sAuthor.replace(" ","&nbsp;") + boldEnd + "</I>");

			output.append("&nbsp;at&nbsp;");
			output.append(sTime.replace(" ", "&nbsp;"));

			// messages has forum key of KIX_MID_ITEM
			String forumKix = "";
			Connection conn = null;

			try{
				conn = AsePool.createLongConnection();

				// at the main or root node, no alpha or num available
				if (conn != null)
					forumKix = ForumDB.getKix(conn,forumID);
			}
			catch(Exception e){
				logger.fatal("ForumDB: showMessageLine - " + e.toString());
			}
			finally{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}

			if (forumKix == null || forumKix.length() == 0)
				forumKix = "";

			forumKix = forumKix + "_" + iId;
			attachments = getAttachments(forumKix,"","","Forum");
			if (pageType.equals("forum")) {

				if (replyCount > 0 || attachments > 0){
					output.append("&nbsp;(");

					if (replyCount > 0){
						output.append(replyCount);
						output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"replies\" alt=\"replies\" border=\"0\">;");
					}

					if (attachments > 0) {
						output.append("&nbsp;");
						output.append(attachments);
						output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					}

					output.append(")");
				}

			}
			else{
				if (attachments > 0) {
					output.append("&nbsp;(");
					output.append(attachments);
					output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					output.append(")");
				}
			}

			output.append("");
		}
		catch(Exception e){
			logger.fatal("ForumDB - showMessageLine: " + e.toString());
		}

		return output.toString() + Html.BR();
	}

	/**
	*
	*/
	public static String search() throws Exception {

		StringBuffer buf = new StringBuffer();

		try{
			buf.append("<br/><br/><br/><br/>");
			buf.append("<div id=\"forum_footer\">");
			buf.append("<TABLE BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
			buf.append("<TR height=\"20\">");
			buf.append("<TD width=\"100%\" valign=\"top\" align=\"left\">");
			buf.append("<FORM ACTION=\"./search.jsp\" METHOD=\"get\">");
			buf.append("<INPUT class=\"input\" TYPE=\"text\" NAME=\"keyword\"></INPUT>&nbsp;&nbsp;");
			buf.append("<INPUT TYPE=\"submit\" VALUE=\"Search\" class=\"input\"></INPUT>");
			buf.append("&nbsp;&nbsp;<A HREF=\"search.jsp\" class=\"bluelinkcolumn\">advance search</A>");
			buf.append("</FORM>");
			buf.append("</td>");
			buf.append("</tr>");
			buf.append("</table>");
			buf.append("</div>");
		}
		catch(Exception e){
			logger.fatal("ForumDB - search: " + e.toString());
		}

		return buf.toString();

	}

	/**
	*
	*/
	public static String showSearchFormAdvanced(int fid,
																String author,
																String aType,
																String subject,
																String sType,
																String body,
																String bType,
																String startDate,
																String endDate) throws Exception {

		StringBuffer buf = new StringBuffer();

		String aTypeSelected = "";
		String bTypeSelected = "";
		String sTypeSelected = "";

		if ("is exactly".equals(aType))
			aTypeSelected = "selected";

		if ("all words".equals(bType))
			bTypeSelected = "selected";

		if ("is exactly".equals(sType))
			sTypeSelected = "selected";

		buf.append("<form action=\"./search.jsp\" method=\"post\" id=\"aseForm\" name=\"aseForm\">");
		buf.append("<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" width=\"700\" align=\"left\">");
		buf.append("<tr>");
		buf.append("<td width=\"10%\" class=\"textblackth\">Author:</td>");
		buf.append("<td width=\"15%\"><select class=\"input\" name=\"aType\"><option>contains</option><option "+ sTypeSelected +">is exactly</option></select></td>");
		buf.append("<td width=\"75%\"><input class=\"input\" type=\"text\" name=\"author\" value=\"" + author + "\"></input></td>");
		buf.append("</tr>");
		buf.append("<tr>");
		buf.append("<td width=\"10%\" class=\"textblackth\">Subject:</td>");
		buf.append("<td width=\"15%\"><select class=\"input\" name=\"sType\"><option>contains</option><option "+ sTypeSelected +">is exactly</option></select></td>");
		buf.append("<td width=\"75%\"><input class=\"input\" type=\"text\" name=\"subject\" value=\"" + subject + "\"></input></td>");
		buf.append("</tr>");
		buf.append("<tr>");
		buf.append("<td width=\"10%\" class=\"textblackth\">Body:</td>");
		buf.append("<td width=\"15%\"><select class=\"input\" name=\"bType\"><option>contains</option><option "+ sTypeSelected +">all words</option></select></td>");
		buf.append("<td width=\"75%\"><input class=\"input\" type=\"text\" name=\"body\" value=\"" + body + "\"></input></td>");
		buf.append("</tr>");
		buf.append("<tr>");
		buf.append("<td colspan=\"2\" class=\"textblackth\">Posted between</td>");
		buf.append("<td><input class=\"input\" type=\"text\" name=\"startDate\" size=\"10\" value=\"" + startDate + "\" title=\"mm/dd/yy\"></input>&nbsp;and&nbsp;<input class=\"input\" type=\"text\" name=\"endDate\" size=\"10\" value=\"" + endDate + "\" title=\"mm/dd/yy\"></input></td>");
		buf.append("</tr>");
		buf.append("<tr height=\"60\">");
		buf.append("<td></td>");
		buf.append("<td></td>");
		buf.append("<td><input class=\"input\" type=\"submit\" value=\"search\">&nbsp;<input class=\"input\" type=\"reset\" value=\"reset form\"></input></input></td>");
		buf.append("</tr>");
		buf.append("<tr height=\"60\">");
		buf.append("<td colspan=\"3\"><a class=\"linkcolumn\" href=\"./dsplst.jsp?fid=" + fid + "\"><img src=\"./images/document.gif\" border=\"0\">&nbsp;return to message board</a></td>");
		buf.append("</tr>");
		buf.append("</table>");
		buf.append("</form>");
		buf.append("<br>");

		return buf.toString();
	}

	/**
	*	display - ignorePeriod forces routine to not include date range as part of select statement.
	*
	*@param	conn				Connection
	*@param	user				String
	*@param	kix				String
	*@param	activeForum		int
	*@param	sort				String
	*@param	ignorePeriod	boolean
	*
	*/
	public static String display(Connection conn,String user,String kix,int activeForum) throws Exception {

		boolean ignorePeriod = false;

		return display(conn,user,kix,activeForum,"",ignorePeriod);
	}

	public static String display(Connection conn,String user,String kix,int activeForum,String sort) throws Exception {

		boolean ignorePeriod = false;

		return display(conn,user,kix,activeForum,sort,ignorePeriod);
	}

	public static String display(Connection conn,String user,String kix,int activeForum,String sort,boolean ignorePeriod) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String forumBreakdownType = "";
		String MESSAGE_GROUPING = "";

		String activeForumName = "";
		String activeKix = "";
		String forumName = "";
		String forumDescr;
		String threadList;
		String dateStart = "";
		String dateEnd = "";
		String sql = "";
		String campus = "";
		String creator = "";
		String xref = "";

		java.util.Date startDate;

		long numberOfPostings = 0;
		int mid = 0;
		int forumID = 0;
		int iPeriodsToGoBack = 0;
		int iPeriodToShow = 0;
		int iPeriodLooper = 0;

		java.util.Date today = new java.util.Date();

		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;

		AseUtil aseUtil = new AseUtil();

		boolean debug = false;

		try{
			if (debug) logger.info("-------------------------- START");

			if (activeForum >= 0 && (kix == null || kix.length() == 0)){
				kix = ForumDB.getKix(conn,activeForum);
			}

			PreparedStatement ps = conn.prepareStatement("SELECT * FROM forums WHERE historyid=?;");
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				forumBreakdownType = AseUtil.nullToBlank(rs.getString("forum_grouping"));
				forumID = rs.getInt("forum_id");
				forumName = AseUtil.nullToBlank(rs.getString("forum_name"));
				forumDescr = AseUtil.nullToBlank(rs.getString("forum_description"));
				startDate = rs.getDate("forum_start_date");
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				creator = AseUtil.nullToBlank(rs.getString("creator"));
				xref = AseUtil.nullToBlank(rs.getString("xref"));

				numberOfPostings = AseUtil.countRecords(conn,"messages","WHERE forum_id="+forumID);

				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];

				buf.append(displayHeader(conn,
												kix,
												creator,
												aseUtil.ASE_FormatDateTime(rs.getString("forum_start_date"),Constant.DATE_DATETIME),
												forumName,
												forumDescr,
												forumID,
												Constant.BLANK,
												0,
												0));

				if (forumID == activeForum){

					buf.append(showForumLine(forumID,"open",forumName,"",numberOfPostings,kix,campus,false,xref));

					iPeriodsToGoBack = monthDiff(startDate, today);

					if (debug) logger.info("iPeriodsToGoBack: " + iPeriodsToGoBack);

					if (forumBreakdownType.equals("7days")){
						iPeriodsToGoBack = iPeriodsToGoBack + 3;
					}
					else if (forumBreakdownType.equals("monthly")){
						//Nothing to do!
					}
					else{
						iPeriodsToGoBack = 0;
						iPeriodToShow = 0;
					}

					if (debug) logger.info("forumBreakdownType: " + forumBreakdownType);

					for(iPeriodLooper=0;iPeriodLooper<=iPeriodsToGoBack;iPeriodLooper++){
						if(forumBreakdownType.equals("7days") || forumBreakdownType.equals("monthly")){
							ForumDB.showPeriodLine(forumID,forumBreakdownType,iPeriodLooper,0);
						}

						if (debug) logger.info("iPeriodLooper: " + iPeriodLooper);

						if(iPeriodLooper == iPeriodToShow){

							if(forumBreakdownType.equals("7days")){
								if(iPeriodToShow <= 2){
									dateStart = ForumDB.addDays(today,(7 * (iPeriodToShow + 1)) + 1);
									dateEnd = ForumDB.addDays(today,- (7 * iPeriodToShow) + 1);
								}
								else{
									dateStart = ForumDB.addMonths(today,iPeriodToShow - 3);
									dateEnd = ForumDB.addMonths(today,iPeriodToShow - 4);
								}
							}
							else if(forumBreakdownType.equals("7days")){
								dateStart = ForumDB.addMonths(today,iPeriodToShow);
								dateEnd = ForumDB.addMonths(today,iPeriodToShow - 1);
							}
							else{
								dateStart = ForumDB.formatDate(startDate);
								dateEnd = ForumDB.addDays(today,1);
							}

							if (debug){
								logger.info("forumBreakdownType: " + forumBreakdownType);
								logger.info("dateStart: " + dateStart);
								logger.info("dateEnd: " + dateEnd);
							}

							threadList = "";
							if (ignorePeriod){
								sql = "SELECT * FROM messages WHERE forum_id=? ORDER BY thread_id";
							}
							else{
								sql = "SELECT * "
									+ "FROM messages "
									+ "WHERE forum_id=? "
									+ "AND thread_parent=0 "
									+ "AND '"+dateStart+"' < message_timestamp "
									+ "AND message_timestamp < '"+dateEnd+"' "
									+ "ORDER BY thread_id;";
							}
							ps2 = conn.prepareStatement(sql);
							ps2.setInt(1,activeForum);
							rs2 = ps2.executeQuery();

							while(rs2.next()){
								if (threadList.equals(Constant.BLANK))
									threadList = "" + rs2.getInt("thread_id");
								else
									threadList = threadList + "," + rs2.getInt("thread_id");
							}
							rs2.close();
							ps2.close();

							if (debug) logger.info("threadList: " + threadList);

							// prevent SQL IN clause error
							if (threadList.equals(Constant.BLANK)){
								threadList = "0";
							}

							if (ignorePeriod){
								sql = "SELECT * FROM messages WHERE forum_id=? AND thread_parent=0 ORDER BY thread_id DESC;";
							}
							else{
								sql = "SELECT * "
									+ "FROM messages "
									+ "WHERE forum_id=? "
									+ "AND thread_parent=0 "
									+ "AND '"+dateStart+"' < message_timestamp "
									+ "AND message_timestamp < '"+dateEnd+"' "
									+ "ORDER BY thread_id;";
							}
							ps2 = conn.prepareStatement(sql);
							ps2.setInt(1,activeForum);
							rs2 = ps2.executeQuery();

							sql = "SELECT thread_id, COUNT(*) "
								+ "FROM messages "
								+ "WHERE thread_id IN (" + threadList + ") "
								+ "GROUP BY thread_id "
								+ "ORDER BY thread_id;";
							ps3 = conn.prepareStatement(sql);
							rs3 = ps3.executeQuery();

							while(rs2.next() && rs3.next()){
								mid = rs2.getInt("message_id");
								buf.append(ForumDB.showMessageLine(1,
													mid,
													rs2.getInt("item"),
													AseUtil.nullToBlank(rs2.getString("message_subject")),
													AseUtil.nullToBlank(rs2.getString("message_author")),
													aseUtil.ASE_FormatDateTime(rs2.getString("message_timestamp"),Constant.DATE_DATETIME),
													rs3.getInt(2) - 1,
													"forum",
													0,
													activeForum,
													rs2.getInt("processed")));
							}

							rs3.close();
							ps3.close();

							rs2.close();
							ps2.close();

							activeForumName = forumName;
							activeKix = kix;

						} //if(iPeriodLooper == iPeriodToShow)

					} // for
				}
				else{
					buf.append(ForumDB.showForumLine(forumID,"closed",forumName,"",numberOfPostings,kix,campus,false,xref));
				} // if (forumID == activeForum){

			} // if rs
			rs.close();
			ps.close();

			if (debug) logger.info("-------------------------- END");
		}
		catch(SQLException e){
			logger.fatal("ForumDB - display: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - display: " + e.toString());
		}

		buf.append("<br/><br/>");

		// check to see if this is an actual KIX or one created for forum use
		// KIX_PROGRAM_TITLE is the 0 element of the info array
		String[] info = Helper.getKixInfo(conn,activeKix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String proposer = info[Constant.KIX_PROPOSER];

		if (!activeKix.equals(Constant.BLANK)){
			buf.append(AttachDB.listAttachmentsByCategoryKix(conn,campus,Constant.FORUM,kix,sort) + Html.BR());

			if (!alpha.equals(Constant.BLANK) && activeKix.indexOf(proposer)==-1 && CourseDB.courseExistByHistoryid(conn,kix) && user.equals(proposer)){
				buf.append("<img src=\"../../images/viewcourse.gif\" border=\"0\" alt=\"Return to outline\" title=\"Return to outline\">&nbsp;<A class=\"linkcolumn\" HREF=\"../crsedt.jsp?z=1&kix="+kix+"\">Return to outline<i></i></A>");
			}
			else{
				buf.append("<img src=\"../../images/ed_list_num.gif\" border=\"0\" alt=\"go to post listing\" title=\"go to post listing\">&nbsp;<A class=\"linkcolumn\" HREF=\"../msgbrd.jsp\">return to message board<i></i></A>");
			}
		}
		else{
			buf.append(Html.BR());
			buf.append(Html.BR());
		}

		if (activeForum != 0 && isEditable(conn,kix)){
			buf.append("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"./images/document.gif\" border=\"0\" alt=\"Post a Reply\" title=\"Post a Reply\">&nbsp;<A class=\"linkcolumn\" HREF=\"./post.jsp?fid="+activeForum+"\">Post a New Message</A>");
			buf.append("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"/central/images/attachment.gif\" border=\"0\" alt=\"Attach document\" title=\"Attach document\">&nbsp;<A class=\"linkcolumn\" HREF=\"../gnrcmprt.jsp?fid="+activeForum+"&mid=0&src=thisPage&kix=hasValue\">Attach document</A>");
		} // activeForum

		// when dealing with a particular outline, we permit adding messages but not forum
		if (kix.equals(Constant.OFF)) {
			buf.append("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<A class=\"linkcolumn\" HREF=\"./add.jsp\"><img src=\"../../images/add2.gif\" border=\"0\" alt=\"Add a New Message\" title=\"Add a New Message\">&nbsp;Add a New Message</A><BR><BR>");
		}

		return buf.toString();
	}

	/**
	*
	*/
   public static String getSearchSQL(String searchType,
   												String author,
   												String aType,
   												String subject,
   												String sType,
   												String body,
   												String bType,
   												String startDate,
   												String endDate,
   												String keyword) throws Exception {


		String sql = "";
		String temp = "";
		int i = 0;

		// construct SQL
		if ("basic".equals(searchType)){
			temp = keyword.replace("'", "''");

			sql = "SELECT message_id,message_author AS [Author], message_timestamp AS [Time], message_subject AS [Subject] "
					+ "FROM messages WHERE "
					+ "message_author LIKE '%"+temp+"%' OR "
					+ "message_subject LIKE '%"+temp+"%' OR "
					+ "message_body LIKE '%"+temp+"%' "
					+ "ORDER BY message_timestamp DESC";
		}
		else if ("advanced".equals(searchType)){
			sql = "SELECT message_id,message_author AS [Author], message_timestamp AS [Time], message_subject AS [Subject] "
					+ "FROM messages WHERE ";

			if (!"".equals(author)){
				if (aType.indexOf("contains") > -1){
					sql = sql + "message_author LIKE '%" + author.replace("'","''") + "%' AND ";
				}
				else{
					sql = sql + "message_author = '" + author.replace("'","''") + "' AND ";
				}
			}

			if (!"".equals(subject)){
				if (sType.indexOf("contains") > -1){
					sql = sql + "message_subject LIKE '%" + subject.replace("'","''") + "%' AND ";
				}
				else{
					sql = sql + "message_subject = '" + subject.replace("'","''") + "' AND ";
				}
			}

			if (!"".equals(body)){
				if (bType.indexOf("contains") > -1){
					sql = sql + "message_body LIKE '%" + body.replace("'","''") + "%' AND ";
				}
				else{
					temp = body.replace("'", "''");
					temp = temp.replace(", ", " ");

					String[] atemp = temp.split(" ");

					for(i=0;i<atemp.length; i++){
						sql = sql + "message_body LIKE '%" + atemp[i] + "%' AND ";
					}
				}
			}

			if (!"".equals(startDate))
				sql = sql + "message_timestamp >= '" + startDate + "' AND ";

			if (!"".equals(endDate))
				sql = sql + "message_timestamp <= '" + endDate + "' AND ";

			// remove the last "AND "
			sql = sql.substring(0,sql.lastIndexOf("AND"));

			sql = sql + "ORDER BY message_timestamp DESC;";
		}
		else{
			sql = "";
		} // if searchType

		return sql;

	}

	/**
	 * displayMessage
	 * <p>
	 * @param	conn
	 * @param	user
	 * @param	mid
	 * @param	item
	 * <p>
	 * @return	String
	 */
	public static String displayMessage(Connection conn,String user,int mid,int item) throws Exception {

		return displayMessage(conn,user,mid,item,"",0);
	}

	public static String displayMessage(Connection conn,String user,int mid,int item,String sort) throws Exception {

		return displayMessage(conn,user,mid,item,sort,0);

	}

	public static String displayMessageX(Connection conn,String user,int mid,int item) throws Exception {

		StringBuffer buf = new StringBuffer();

		buf.append(displayMessage(conn,user,mid,item,Constant.BLANK,1));
		buf.append(displayMessage(conn,user,mid,item,Constant.BLANK,2));
		buf.append(displayMessage(conn,user,mid,item,Constant.BLANK,3));

		return buf.toString();

	}

	public static String displayMessage(Connection conn,String user,int mid,int item,String sort,int acktion) throws Exception {

		StringBuffer buf = new StringBuffer();

		AseUtil aseUtil = new AseUtil();

		PreparedStatement ps = conn.prepareStatement("SELECT * FROM messages WHERE message_id=?");
		ps.setInt(1,mid);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			int forumID = rs.getInt("forum_id");
			int threadID = rs.getInt("thread_id");
			int threadLevel = rs.getInt("thread_level") + 1;
			int processed = rs.getInt("processed");

			String author = rs.getString("message_author");

			if (processed == 0 && !user.equals(author)){
				setMessageToProcessed(conn,forumID,mid,item);
			}

			String kix = getKix(conn,forumID);
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];

			buf.append(displayHeader(conn,
								kix,
								author,
								aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME),
								rs.getString("message_subject"),
								rs.getString("message_body"),
								forumID,
								aseUtil.ASE_FormatDateTime(rs.getString("processeddate"),Constant.DATE_DATETIME),
								mid,
								item));

			buf.append(Html.BR()
						+ AttachDB.listAttachmentsByCategoryKix(conn,campus,Constant.FORUM,kix+"_"+mid,sort)
						+ Html.BR());

			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM forums WHERE forum_id=?");
			ps2.setInt(1,forumID);
			ResultSet rs2 = ps2.executeQuery();
			if(rs2.next()){
				buf.append(showForumLine(forumID,
													"open",
													rs2.getString("forum_name"),
													"",
													0,
													rs2.getString("historyid"),
													getCampusFromMid(conn,mid),
													false,
													""));
			}
			rs2.close();
			ps2.close();

			buf.append(Html.BR());

			buf.append(showChildren(conn,forumID,item,0,0,mid));

			if (CourseDB.courseExistByHistoryid(conn,kix) && user.equals(proposer)){
				buf.append(	Html.BR() + Html.BR() );
				buf.append("<img src=\"../../images/viewcourse.gif\" border=\"0\" alt=\"Return to outline\" title=\"Return to outline\">&nbsp;<A class=\"linkcolumn\" HREF=\"../crsedt.jsp?z=1&kix="+kix+"\">Return to outline<i></i></A>");
			}
			else{
				buf.append(Html.BR());
				buf.append(Html.BR());
			}

			buf.append(	"&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"./images/document.gif\" border=\"0\" alt=\"Post a Reply\" title=\"Post a Reply\">&nbsp;<A class=\"linkcolumn\" HREF=\"./post.jsp?fid="
							+ forumID
							+ "&mid="
							+ mid
							+ "&item="
							+ item
							+ "&tid="
							+ rs.getInt("thread_id")
							+ "&pid="
							+  rs.getInt("message_id")
							+ "&level="
							+  threadLevel
							+ "\">Post a Reply</A>");

			buf.append( "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"/central/images/attachment.gif\" border=\"0\" alt=\"Attach document\" title=\"Attach document\">&nbsp;<A class=\"linkcolumn\" HREF=\"../gnrcmprt.jsp?fid="+forumID+"&mid="+mid+"&src=thisPage&kix=hasValue\">Attach document</A>");

		} // rs
		rs.close();
		ps.close();

		aseUtil = null;

		return buf.toString();
	}

	/**
	 * displayHeader
	 * <p>
	 * @param	conn
	 * @param	user
	 * @param	mid
	 * @param	item
	 * <p>
	 * @return	String
	 */
	public static String displayHeader(Connection conn,
													String kix,
													String author,
													String dte,
													String subject,
													String body,
													int fid,
													String processedDate,
													int mid,
													int item) throws Exception {

		StringBuffer buf = new StringBuffer();

		// set page title if course or program
		String columnHeader = "";
		String alpha = "";
		String num = "";
		String proposer = "";
		String title = "";
		String campus = "";

		boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
		boolean isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

		String[] info = null;
		if(isFoundation){
			info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
		}
		else{
			info = Helper.getKixInfo(conn,kix);
		}

		if (isAProgram){
			columnHeader = "Program";

			title = info[Constant.KIX_PROGRAM_TITLE];
			proposer = info[Constant.KIX_PROPOSER];
		}
		else if (isFoundation){
			columnHeader = "Foundation";

			title = info[Constant.KIX_PROGRAM_TITLE];
			proposer = info[Constant.KIX_PROPOSER];
		}
		else{
			columnHeader = "Course";

			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			proposer = info[Constant.KIX_PROPOSER];
			title = info[Constant.KIX_COURSETITLE];

			title = alpha + " " + num + " - " + title;
		}

		campus = info[Constant.KIX_CAMPUS];

		buf.append("<BR>");
		buf.append("<TABLE BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\" width=\"700\">");

		// course or program will have this
		if (!title.equals(Constant.BLANK)){
			buf.append("<TR height=\"20\">");
			buf.append("<TD width=\"20%\" class=\"textblackth\">"+columnHeader+":&nbsp;</td>");
			buf.append("<TD width=\"80%\" class=\"datacolumn\">"+title+"</td>");
			buf.append("</TR>");

			buf.append("<TR height=\"20\">");
			buf.append("<TD width=\"20%\" class=\"textblackth\">Proposer:&nbsp;</td>");
			buf.append("<TD width=\"80%\" class=\"datacolumn\">"+proposer+"</td>");
			buf.append("</TR>");

			if (mid > 0 && item > 0){
				String question = QuestionDB.getCourseQuestionBySequence(conn,campus,Constant.TAB_COURSE,item);
				buf.append("<TR height=\"20\">");
				buf.append("<TD width=\"20%\" class=\"textblackth\">Question:&nbsp;</td>");
				buf.append("<TD width=\"80%\" class=\"datacolumn\">"+question+"</td>");
				buf.append("</TR>");
			}

			buf.append("<TR height=\"20\">");
			buf.append("<TD width=\"20%\" class=\"textblackth\">Subject:&nbsp;</td>");
			buf.append("<TD width=\"80%\" class=\"datacolumn\">"+subject+"</td>");
			buf.append("</TR>");

			if (processedDate != null && processedDate.length() > 0){
				buf.append("<TR height=\"20\">");
				buf.append("<TD width=\"20%\" class=\"textblackth\">Viewed date:&nbsp;</td>");
				buf.append("<TD width=\"80%\" class=\"datacolumn\">"+processedDate+"</td>");
				buf.append("</TR>");
			} // processedDate

			buf.append("<TR height=\"20\">");
			buf.append("<TD width=\"20%\" class=\"textblackth\">Message:&nbsp;</td>");
			buf.append("<TD width=\"80%\" class=\"datacolumn\">"+body+"</td>");
			buf.append("</TR>");

		} // title

		buf.append("</TABLE>");

		return buf.toString();
	}

	/**
	*
	*/
   public static String showChildren(Connection conn,
   											int forumID,
   											int item,
   											int parentID,
   											int iCurrentLevel,
   											int mid) throws Exception {

		/*
			this is a recursive function call. with each turn, it goes to the next level
			of data. the next level reaches the end when the last reply to a post is found.
			saving data to the session is the only way to collect data continually since
			with each return, the data is lost.
		*/

		StringBuffer buf = new StringBuffer();
		String subject = "";
		String author = "";

		int threadID = 0;
		int processed = 0;
		int message_id = 0;

		int mainParentID = parentID;

		AseUtil aseUtil = new AseUtil();

		String src = getForumSrc(conn,forumID);

		String sql = "SELECT message_id,thread_id,message_subject,message_author,message_timestamp,processed "
						+ "FROM messages "
						+ "WHERE forum_id=? "
						+ "AND thread_parent=? "
						+ "AND item=? "
						+ "ORDER BY thread_id DESC";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1,forumID);
		ps.setInt(2,parentID);
		ps.setInt(3,item);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			parentID = rs.getInt("message_id");
			message_id = parentID;
			threadID = rs.getInt("thread_id");
			processed = rs.getInt("processed");
			subject = AseUtil.nullToBlank(rs.getString("message_subject"));
			author = AseUtil.nullToBlank(rs.getString("message_author"));

			if (src.equals(Constant.FORUM_USERNAME)){
				buf.append(showUserMessageLineX(conn,
														forumID,
														mainParentID,
														mid,
														threadID,
														message_id,
														iCurrentLevel,
														item,
														0,
														"message"));
			}
			else{
				buf.append(showMessageLine(iCurrentLevel,
													parentID,
													item,
													subject,
													author,
													aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME),
													0,
													"message",
													mid,
													forumID,
													processed));
			}

			buf.append(showChildren(conn,forumID,item,parentID,iCurrentLevel + 1,mid));
		}
		rs.close();
		ps.close();

		aseUtil = null;

		return buf.toString();

	}

	/*
	 * showUserMessageLineX
	 *	<p>
	 *	@return String
	 */
	public static String showUserMessageLineX(Connection conn,
															int forumID,
															int parentID,
															int mid,
															int threadID,
															int message_id,
															int iCurrentLevel,
															int item,
															int replyCount,
															String pageType) throws Exception {

		StringBuffer output = new StringBuffer();

		int processed = 0;
		String subject = "";
		String author = "";
		String tme = "";
		String message = "";

		String boldStart = "";
		String boldEnd = "";

		int i = 0;

		String temp = "";

		try{

			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT message_subject,message_author,message_timestamp,processed,message_body "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND thread_parent=? "
							+ "AND message_id=? "
							+ "AND thread_id=? "
							+ "AND item=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,forumID);
			ps.setInt(2,parentID);
			ps.setInt(3,message_id);
			ps.setInt(4,threadID);
			ps.setInt(5,item);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				processed = rs.getInt("processed");
				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
				message = AseUtil.nullToBlank(rs.getString("message_body"));
				author = AseUtil.nullToBlank(rs.getString("message_author"));
				tme = aseUtil.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME);
			}
			rs.close();
			ps.close();

			aseUtil = null;

			// bold the name to indicate unread message
			if (processed == 0){
				boldStart = "<b>";
				boldEnd = "</b>";
			}

			temp = "<IMG SRC=\"../images/message"+iCurrentLevel+".gif\" BORDER=\"0\" ALIGN=\"absmiddle\">"
						+ "&nbsp;"
						+ "<A  class=\"linkcolumn\" HREF=\"./displayusrmsg.jsp?fid=" + forumID + "&mid=" + message_id + "&item="+item+"\">" + subject.replace(" ","&nbsp;") + "</A>"
						+ "&nbsp;by&nbsp;"
						+ "<I>" + boldStart + author.replace(" ","&nbsp;") + boldEnd + "</I>"
						+ "&nbsp;at&nbsp;"
						+ tme.replace(" ", "&nbsp;");

			// new line then message
			output.append("<div id=\"record-"+mid+"\" class=\"ase-table-row-detail\">"
							+ "<div class=\"col"+iCurrentLevel+"\">&nbsp;</div>"
							+ "<div class=\"col"+(100-iCurrentLevel)+"\">"+temp+"</div>"
							+ "<div id=\"ras\" class=\"space-line\"></div>"
							+ "</div>");

			// new line then message
			output.append("<div id=\"record-"+mid+"\" class=\"ase-table-row-detail\">"
							+ "<div class=\"col"+iCurrentLevel+"\">&nbsp;</div>"
							+ "<div class=\"col"+(100-iCurrentLevel)+"\">"+message+"</div>"
							+ "<div id=\"ras\" class=\"space-line\"></div>"
							+ "</div>");
		}
		catch(Exception e){
			logger.fatal("ForumDB - showUserMessageLine: " + e.toString());
		}

		return output.toString();
	}

	/*
	 * showUserMessageLine
	 *	<p>
	 *	@return String
	 */
	public static String showUserMessageLine(Connection conn,
															int iCurrentLevel,
															int parentID,
															int item,
															String subject,
															String author,
															String tme,
															int replyCount,
															String pageType,
															int mid,
															int forumID,
															int processed) throws Exception {

		StringBuffer output = new StringBuffer();

		int attachments = 0;

		String boldStart = "";
		String boldEnd = "";

		try{
			for(int i = 0; i <iCurrentLevel; i++){
				output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
			}

			if (pageType.equals("message")) {
				if (mid==parentID) {
					output.append("<IMG SRC=\"./images/check.gif\" BORDER=\"0\">");
				} else {
					output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
				}
			} else {
				output.append("<IMG SRC=\"../images/blank.gif\" BORDER=\"0\">");
			}

			// bold the name to indicate unread message
			if (processed == 0){
				boldStart = "<b>";
				boldEnd = "</b>";
			}

			output.append("<IMG SRC=\"../images/message"+iCurrentLevel+".gif\" BORDER=\"0\" ALIGN=\"absmiddle\">");
			output.append("&nbsp;");
			output.append("<A  class=\"linkcolumn\" HREF=\"./displayusrmsg.jsp?fid=" + forumID + "&mid=" + parentID + "&item="+item+"\">" + subject.replace(" ","&nbsp;") + "</A>");
			output.append("&nbsp;by&nbsp;");
			output.append("<I>" + boldStart + author.replace(" ","&nbsp;") + boldEnd + "</I>");

			output.append("&nbsp;at&nbsp;");
			output.append(tme.replace(" ", "&nbsp;"));

			// messages has forum key of KIX_MID_ITEM
			String forumKix = ForumDB.getKix(conn,forumID);
			if (forumKix == null || forumKix.length() == 0){
				forumKix = "";
			}

			forumKix = forumKix + "_" + parentID;
			attachments = getAttachments(forumKix,"","","Forum");
			if (pageType.equals("forum")) {

				if (replyCount > 0 || attachments > 0){
					output.append("&nbsp;(");

					if (replyCount > 0){
						output.append(replyCount);
						output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"replies\" alt=\"replies\" border=\"0\">;");
					}

					if (attachments > 0) {
						output.append("&nbsp;");
						output.append(attachments);
						output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					}

					output.append(")");
				}

			}
			else{
				if (attachments > 0) {
					output.append("&nbsp;(");
					output.append(attachments);
					output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					output.append(")");
				}
			}

			output.append("");
		}
		catch(Exception e){
			logger.fatal("ForumDB - showUserMessageLine: " + e.toString());
		}

		return output.toString() + Html.BR();
	}

	/**
	 * countApprovalHistory - Count number of approver comments for each item
	 * <p>
	 * @param conn
	 * @param campus
	 * @param kix
	 * @param item
	 * <p>
	 * @return int
	 *
	 */
	public static int countBoardMessages(Connection conn,String campus,String kix,int item) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		int records = 0;

		try {
			String sql = "SELECT COUNT(forums.forum_id) AS CountOfid "
						+ "FROM  forums INNER JOIN messages ON forums.forum_id = messages.forum_id "
						+ "WHERE forums.campus=? "
						+ "AND forums.historyid=? "
						+ "AND messages.item=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				records = rs.getInt(1);
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ForumDB: countBoardMessages - " + e.toString());
		}

		return records;
	}

	/**
	 * countApprovalHistory - Count number of approver comments for each item
	 * <p>
	 * @param conn
	 * @param campus
	 * @param kix
	 * @param item
	 * <p>
	 * @return int
	 *
	 */
	public static int countBoardMessages(Connection conn,String campus,String kix,int sq,int en,int qn) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		int records = 0;

		try {
			String sql = "SELECT COUNT(forums.forum_id) AS CountOfid "
						+ "FROM  forums INNER JOIN messages ON forums.forum_id = messages.forum_id "
						+ "WHERE forums.campus=? AND forums.historyid=? AND messages.sq=? AND messages.en=? AND messages.qn=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,sq);
			ps.setInt(4,en);
			ps.setInt(5,qn);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				records = rs.getInt(1);
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ForumDB: countBoardMessages - " + e.toString());
		}

		return records;
	}

	/**
	*
	* @param	conn
	* @param	campus
	* @param	user
	*
	*/
	public static String displayUserForum(Connection conn,String campus,String user) throws Exception {

		// Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String forumBreakdownType = "";
		String forumName = "";
		String forumDescr;
		String kix = "";
		String xref = "";

		long numberOfPostings = 0;
		int forumID = 0;

		boolean debug = false;

		try{
			if (debug) logger.info("-------------------------- START");

			String sql = "SELECT historyid,forum_id,forum_name,forum_name,campus,xref "
							+ "FROM forums "
							+ "WHERE campus=? "
							+ "AND historyid like '"+user+"%' "
							+ "ORDER BY forum_start_date";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();

			buf.append(tableHeader());

			while(rs.next()){
				forumID = rs.getInt("forum_id");
				forumName = AseUtil.nullToBlank(rs.getString("forum_name"));
				forumDescr = AseUtil.nullToBlank(rs.getString("forum_name"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				xref = AseUtil.nullToBlank(rs.getString("xref"));

				numberOfPostings = AseUtil.countRecords(conn,"messages","WHERE forum_id="+forumID);

				buf.append(showForumLine(forumID,"closed",forumName,"",numberOfPostings,kix,campus,true,xref));

			} // while rs
			rs.close();
			ps.close();

			buf.append(tableFooter());

			if (debug) logger.info("-------------------------- END");
		}
		catch(SQLException e){
			logger.fatal("ForumDB - displayUserForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - displayUserForum: " + e.toString());
		}

		buf.append("<br/><br/>");

		return buf.toString();
	}

	/**
	*
	* @param	conn
	* @param	campus
	* @param	src
	*
	*/
	public static String displayForum(Connection conn,String campus,String src) throws Exception {

		return displayForum(conn,campus,src,null);
	}

	public static String displayForum(Connection conn,String campus,String src,String status) throws Exception {

		return displayForum(conn,campus,src,status,"");

	}

	public static String displayForum(Connection conn,String campus,String src,String status,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String forumBreakdownType = "";
		String forumName = "";
		String forumDescr;
		String kix = "";
		String sql = "";
		String xref = "";

		long numberOfPostings = 0;
		int forumID = 0;

		boolean debug = false;

		PreparedStatement ps = null;

		try{
			if (debug) logger.info("-------------------------- START");

			if (status != null && status.length() > 0){

				buf.append(tableHeader());

				if(SQLUtil.isSysAdmin(conn,user)){
					sql = "SELECT historyid,forum_id,forum_name,forum_name,campus,xref "
						+ "FROM forums WHERE src=? AND status=? ORDER BY forum_start_date";
					ps = conn.prepareStatement(sql);
					ps.setString(1,src);
					ps.setString(2,status);
				}
				else{
					sql = "SELECT historyid,forum_id,forum_name,forum_name,campus,xref "
						+ "FROM forums WHERE campus=? AND src=? AND status=? ORDER BY forum_start_date";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,src);
					ps.setString(3,status);
				}
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					forumID = rs.getInt("forum_id");
					forumName = AseUtil.nullToBlank(rs.getString("forum_name"));
					forumDescr = AseUtil.nullToBlank(rs.getString("forum_name"));
					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					xref = AseUtil.nullToBlank(rs.getString("xref"));

					numberOfPostings = AseUtil.countRecords(conn,"messages","WHERE forum_id="+forumID);

					buf.append(showForumLineJQ(forumID,"closed",forumName,"",numberOfPostings,kix,campus,true,xref));

				} // while rs
				rs.close();
				ps.close();

				buf.append(tableFooter());
			} // src

			if (debug) logger.info("-------------------------- END");
		}
		catch(SQLException e){
			logger.fatal("ForumDB - displayForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - displayForum: " + e.toString());
		}

		buf.append("<br/><br/>");

		return buf.toString();
	}

	/**
	 * tableHeader
	 * <p>
	 * @return	String
	 */
	public static String tableHeader() {

		return "<div id=\"container90\">"
			+ "<div id=\"demo_jui\">"
			+ "<table id=\"dsplst\" class=\"display\">"
			+ "<thead>"
			+ "<tr>"
			+ "<th align=\"left\">Edit</th>"
			+ "<th align=\"left\">ID</th>"
			+ "<th align=\"left\">Campus</th>"
			+ "<th align=\"right\">Created</th>"
			+ "<th align=\"right\">Priority</th>"
			+ "<th align=\"left\">Description</th>"
			+ "<th align=\"right\">Updated</th>"
			+ "<th align=\"right\">Messages</th>"
			+ "<th align=\"right\">Attachments</th>"
			+ "<th align=\"right\">X-ref</th>"
			+ "</tr>"
			+ "</thead>"
			+ "<tbody>";

	}

	/**
	 * tableFooter
	 * <p>
	 * @return	String
	 */
	public static String tableFooter() {

		return "</tbody></table></div></div>";

	}

	/**
	 * showStatusDDL
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * <p>
	 * @return	String
	 */
	public static String showStatusDDL(Connection conn,String status){

		String output = "";

		try{
			String sql = SQLUtil.resultSetToCSV(conn,"select distinct status from forums","");

			AseUtil aseUtil = new AseUtil();

			output = aseUtil.createStaticSelectionBox(sql,sql,"status",status,"",""," ","");

			aseUtil = null;
		}
		catch(Exception ex){
			logger.fatal("ForumDB: showStatusDDL - " + ex.toString());
		}

		return output;
	}

	/**
	 * getAttachments
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * <p>
	 * @return	int
	 */
	public static int getAttachments(String kix,String alpha,String num,String category){

		return getAttachments(kix,alpha,num,category,"");

	}

	public static int getAttachments(String kix,String alpha,String num,String category,String campus){

		int attachments = 0;

		try{

			Connection conn = null;

			try{
				conn = AsePool.createLongConnection();

				// at the main or root node, no alpha or num available
				if (conn != null){
					attachments = AttachDB.countAttachments(conn,kix,alpha,num,category,campus);
				}
			}
			catch(Exception e){
				logger.fatal("ForumDB: showForumLine - " + e.toString());
			}
			finally{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}

		}
		catch(Exception ex){
			logger.fatal("ForumDB: getAttachments - " + ex.toString());
		}

		return attachments;
	}

	/**
	 * showSubMenu
	 * <p>
	 * @param	conn		Connection
	 * @param	menu		String
	 * @param	selected	String
	 * <p>
	 * @return	int
	 */
	public static String showSubMenu(Connection conn,String campus,String user,String src,String selectedStatus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer subMenu = new StringBuffer();

		String status = "";

		boolean found = false;

		int counter = 0;

		try{
			String sql = "";
			PreparedStatement ps = null;

			if(!SQLUtil.isSysAdmin(conn,user)){
				sql = "SELECT DISTINCT status, COUNT(forum_id) AS counter FROM forums WHERE campus=? AND src=? GROUP BY status";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,src);
			}
			else{
				sql = "SELECT DISTINCT status, COUNT(forum_id) AS counter FROM forums WHERE src=? GROUP BY status";
				ps = conn.prepareStatement(sql);
				ps.setString(1,src);
			}

			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				status = AseUtil.nullToBlank(rs.getString("status"));

				if (!status.equals(Constant.BLANK)){
					counter = rs.getInt("counter");

					if (!found){
						subMenu.append("::&nbsp;&nbsp;&nbsp;");
						found = true;
					}
					else{
						subMenu.append("<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>");
					}

					if (status.equals(selectedStatus)){
						subMenu.append("<font class=\"copyrightdark\">"+status+" ("+counter+") "+"</font>");
					}
					else{
						subMenu.append("<a href=\"?src="+src+"&status="+status+"\" class=\"bluelinkcolumn\">"+status+" ("+counter+") "+"</a>");
					}
				}

			} // while rs
			rs.close();
			ps.close();

			if (found){
				// show the menu only if there is more than the ::
				if (subMenu.length() > 5){
					subMenu.append("<font class=\"copyright\">&nbsp;&nbsp;&nbsp;&nbsp;</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::&nbsp;");

					if (selectedStatus != null && selectedStatus.length() > 0){
						subMenu.append("<a href=\"/central/servlet/progress?src="+src+"&status="+selectedStatus+"\" target=\"_blank\" class=\"linkcolumn\">print this page</a>");
					}

					subMenu.append("<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
										+ "<a href=\"/central/servlet/progress?src="+src+"&status=\" target=\"_blank\" class=\"linkcolumn\">print ALL statuses report</a>"
										);
				}
			}
		}
		catch(SQLException ex){
			logger.fatal("ForumDB: showSubMenu - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("ForumDB: showSubMenu - " + ex.toString());
		}

		return subMenu.toString();
	}

	/**
	 * isEditable
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return	boolean
	 */
	public static boolean isEditable(Connection conn,String kix) {

		boolean editable = true;

		try {
			if (kix != null){
				String sql = "SELECT edit FROM forums WHERE historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					if ( AseUtil.nullToBlank(rs.getString(1)).equals(Constant.OFF)){
						editable = false;
					}
				}
				rs.close();
				ps.close();

			}
		} catch (SQLException e) {
			logger.fatal("ForumDB: isEditable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ForumDB: isEditable - " + ex.toString());
		}

		return editable;
	}

	/**
	 * updateForum
	 * <p>
	 * @param	conn
	 * @param	forum
	 * <p>
	 * @return	int
	 */
	public static int updateForum(Connection conn,Forum forum) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String timeStamp = AseUtil.getCurrentDateTimeString();

		try {
			String sql = "UPDATE forums SET forum_name=?,forum_description=?,campus=?, "
							+ "src=?,auditdate=?,status=?,forum_grouping=?,priority=?,auditby=?,xref=? "
							+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,forum.getForum());
			ps.setString(2,forum.getDescr());
			ps.setString(3,forum.getCampus());
			ps.setString(4,forum.getSrc());
			ps.setString(5,forum.getStartDate());
			ps.setString(6,forum.getStatus());
			ps.setString(7,forum.getSrc());
			ps.setInt(8,forum.getPriority());
			ps.setString(9,forum.getCreator());
			ps.setString(10,forum.getXref());
			ps.setString(11,forum.getHistoryid());
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ForumDB: updateForum - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: updateForum - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * displayReport
	 * <p>
	 * @return	String
	 */
	public static String displayReport(Connection conn,String src,String category) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String forumDescr;
		String kix = "";
		String sql = "";
		String savedStatus = "";

		try{

			AseUtil aseUtil = new AseUtil();

			sql = "SELECT historyid,priority,forum_name,forum_description,campus,status,createddate,xref "
				+ "FROM forums "
				+ "WHERE src=? "
				+ "ORDER BY status,historyid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,src);
			ResultSet rs = ps.executeQuery();

			buf.append("<table id=\"asetable\" width=\"100%\">"
						+ "<tr>"
						+ "<th width=\"12%\">Status</td>"
						+ "<th width=\"08%\">ID</td>"
						+ "<th width=\"08%\">Campus</td>"
						+ "<th width=\"10%\" align=\"right\">Created</td>"
						+ "<th width=\"08%\" align=\"center\">Priority</td>"
						+ "<th width=\"08%\" align=\"center\">X-ref</td>"
						+ "<th width=\"36%\">Description</td>"
						+ "<th width=\"10%\" align=\"right\">Updated</td>"
						+ "</tr>");

			while(rs.next()){
				int priority = rs.getInt("priority");
				forumDescr = AseUtil.nullToBlank(rs.getString("forum_description"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String status = AseUtil.nullToBlank(rs.getString("status"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String createddate = aseUtil.ASE_FormatDateTime(rs.getString("createddate"),Constant.DATE_DATE_MDY);
				String auditdate = aseUtil.ASE_FormatDateTime(rs.getString("createddate"),Constant.DATE_DATE_MDY);
				String xref = AseUtil.nullToBlank(rs.getString("xref"));

				if (!savedStatus.equals(status)){
					buf.append(
								"<tr bgcolor=\""+Constant.ODD_ROW_BGCOLOR+"\">"
								+ "<td colspan=\"7\">" + status.toUpperCase() + "</td>"
								+ "</tr>");

					savedStatus = status;
				}

				buf.append(
							"<tr>"
							+ "<td>&nbsp;</td>"
							+ "<td>" + kix + "</td>"
							+ "<td>" + campus + "</td>"
							+ "<td align=\"right\">" + createddate + "</td>"
							+ "<td align=\"center\">" + priority + "</td>"
							+ "<td>" + xref + "</td>"
							+ "<td>" + forumDescr + AttachDB.getAttachmentAsHTMLList(conn,kix,"forum") + "<br></td>"
							+ "<td align=\"right\">" + auditdate + "</td>"
							+ "</tr>");

			} // while rs
			rs.close();
			ps.close();

			buf.append("</table>");

			aseUtil = null;

		}
		catch(SQLException e){
			logger.fatal("ForumDB - displayReport: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - displayReport: " + e.toString());
		}

		buf.append("<br/><br/>");

		return buf.toString();
	}

	/*
	 * getNextForumID
	 *	<p>
	 * @param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextForumID(Connection conn) {

		int nextID = 0;

		try {
			String sql = "SELECT MAX(forum_id) AS MaxOfseq FROM forums";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				nextID = rs.getInt(1) + 1;
			}
			else{
				nextID = 1;
			}

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ForumDB: getNextForumID - " + e.toString());
		}

		return nextID;
	}

	/*
	 * getNextMessageID
	 *	<p>
	 * @param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextMessageID(Connection conn) {

		int nextID = 0;

		try {
			String sql = "SELECT MAX(message_id) AS MaxOfseq FROM messages";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				nextID = rs.getInt(1) + 1;
			}
			else{
				nextID = 1;
			}

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ForumDB: getNextMessageID - " + e.toString());
		}

		return nextID;
	}

	/*
	 * getMessageID
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	item	int
	 *	<p>
	 *	@return int
	 */
	public static int getMessageID(Connection conn,String kix,int item) {

		int mid = 0;

		try {

			// first time through, the message ID is inserted for each course
			// question after the forum id is obtained. from that point on,
			// the key message id is the first for each item or the minimum id

			String sql = "SELECT MIN(message_id) AS mid "
							+ "FROM messages "
							+ "WHERE (forum_id = "
							+ "(SELECT DISTINCT forum_id FROM forums WHERE historyid=?)) AND (item=?) ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				mid = rs.getInt(1);
			}

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ForumDB: getMessageID - " + e.toString());
		}

		return mid;
	}

	/*
	 * getMessageSubject
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	item	int
	 *	<p>
	 *	@return int
	 */
	public static String getMessageSubject(Connection conn,int mid) throws Exception {

		String subject = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT message_subject FROM messages WHERE message_id=?");
			ps.setInt(1,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				subject = AseUtil.nullToBlank(rs.getString("message_subject"));
			} // rs
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getMessageSubject: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getMessageSubject: " + e.toString());
		}


		return subject;
	}

	/*
	 * setMessageToProcessed
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	item	int
	 *	<p>
	 *	@return int
	 */
	public static void setMessageToProcessed(Connection conn,int fid,int mid,int item) throws Exception {

		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE messages SET processed=1,processeddate=? WHERE forum_id=? AND message_id=? AND item=?");
			ps.setString(1,AseUtil.getCurrentDateTimeString());
			ps.setInt(2,fid);
			ps.setInt(3,mid);
			ps.setInt(4,item);
			int rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - setMessageToProcessed: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - setMessageToProcessed: " + e.toString());
		}

	}

	/*
	 * insertReview
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	item	int
	 *	<p>
	 *	@return int
	 */
	public static void insertReview(Connection conn,Review review,String tb,int mode) throws Exception {

		int item = 0;
		int sq = 0;
		int en = 0;
		int qn = 0;
		int rowsAffected = 0;
		int table = 0;
		int mid = 0;

		String src = "";

		boolean debug = true;

		try{
			String kix = review.getHistory();
			String campus = review.getCampus();
			String user = review.getUser();

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			boolean isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

			// translate course question number to proper question sequence
			// do so only if asked to do. default would be false
			item = NumericUtil.nullToZero(review.getItem());
			item = QuestionDB.getCourseSequenceByNumber(conn,campus,tb,item);
			review.setItem(item);

			if(isFoundation){
				sq = NumericUtil.nullToZero(review.getSq());
				item = sq;
				en = NumericUtil.nullToZero(review.getEn());
				qn = NumericUtil.nullToZero(review.getQn());
			}

			if(debug){
				logger.info("isAProgram: " + isAProgram);
				logger.info("isFoundation: " + isFoundation);
				logger.info("item before: " + item);
				logger.info("sq: " + sq);
				logger.info("en: " + en);
				logger.info("qn: " + qn);
				logger.info("campus: " + campus);
				logger.info("user: " + user);
			}

			if(debug) logger.info("item after sequence adjustment: " + item);

			//
			// figure out the correct item number based on the tab this data is coming from
			//
			if (isAProgram){
				src = Constant.PROGRAM;
			}
			else if (isFoundation){
				src = Constant.FOUNDATION;
			}
			else{
				src = Constant.COURSE;
				if (tb.equals("2")){
					int maxNo = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
					item = item + maxNo;
				}
			}

			if(debug) logger.info("item adjusted for tab: " + item);

			// only create forum once
			int fid = ForumDB.getForumID(conn,campus,kix);
			if(debug) logger.info("fid: " + fid);

			String[] info = null;
			if(isFoundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
			}

			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String forumName = alpha + " " + num;

			String forumDescr = "";
			if(isFoundation){
				forumDescr = info[Constant.KIX_COURSETITLE];
			}
			else{
				forumDescr = CourseDB.getCourseDescription(conn,alpha,num,campus);
			}

			if(debug){
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("forumName: " + forumName);
				logger.info("forumDescr: " + forumDescr);
			}

			if (fid == 0){
				fid = insertForum(conn,new Forum(0,campus,
															kix,
															item,
															user,
															user,
															forumName,
															forumDescr,
															AseUtil.getCurrentDateTimeString(),
															"",
															src,
															"",
															0,
															"",
															alpha),
															table,
															true,
															review.getComments(),
															mode);

				if(debug) logger.info("fid was zero: " + fid);
			}

			createFirstMessage(conn,user,
									new Forum(fid,
												campus,
												kix,
												item,
												user,
												user,
												forumName,
												forumDescr,
												AseUtil.getCurrentDateTimeString(),
												"",
												src),
									review.getComments(),
									review.getSubject(),
									mode,
									sq,
									en,
									qn);

			if(debug) logger.info("message created");

			//
			// change creator/owner when reopening
			//
			if(isPostClosedFidItem(conn,fid,item)){
				setCreator(conn,fid,item,user);
			}

		}
		catch(SQLException e){
			logger.fatal("ForumDB - insertReview: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - insertReview: " + e.toString());
		}

	}

	/*
	 * createFirstMessage
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int createFirstMessage(Connection conn,String user,Forum forum,String comments,int mode) throws SQLException {

		return createFirstMessage(conn,user,forum,comments,"",mode);

	}

	/*
	 * createFirstMessage
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int createFirstMessage(Connection conn,String user,Forum forum,String comments,String subject,int mode) throws SQLException {

		return createFirstMessage(conn,user,forum,comments,subject,mode,0,0,0);

	}

	public static int createFirstMessage(Connection conn,String user,Forum forum,String comments,String subject,int mode,int sq,int en,int qn) throws SQLException {

		int rowsAffected = 0;

		try{

			int fid = forum.getForumID();
			int item = forum.getItem();
			String kix = forum.getHistoryid();

			int topLevelPostingMessageID = 0;

			if(sq == 0 && en == 0 && qn == 0){
				topLevelPostingMessageID = getTopLevelPostingMessage(conn,fid,item);
			}
			else{
				topLevelPostingMessageID = getTopLevelPostingMessage(conn,fid,sq,en,qn);
			}

			String sql = "";
			PreparedStatement ps = null;

			// was the post closed? if yes, open for this item
			if (isPostClosed(conn,fid,topLevelPostingMessageID)){
				sql = "UPDATE messages SET closed=0 WHERE forum_id=? AND thread_id=? AND thread_parent=0 AND closed=1";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setInt(2,topLevelPostingMessageID);
				rowsAffected = ps.executeUpdate();
				ps.close();

			}

			if(subject == null || subject.equals(Constant.BLANK)){
				if(sq > 0){
					subject = "ITEM: " + sq + "; EN: " + en;
					if (qn > 0){
						subject += "; QN: " + qn;
					}
				}
				else{
					subject = "Item No. " + item;
				}
			}

			// once the top level post has been created, all additional
			// postings with the same item number will be a reply to
			// top level post is thread_id = 0
			Messages messages = new Messages();
			if (topLevelPostingMessageID > 0){
				messages.setTimeStamp(AseUtil.getCurrentDateTimeString());
				messages.setForumID(fid);
				messages.setItem(item);
				messages.setSq(item);
				messages.setEn(en);
				messages.setQn(qn);
				messages.setThreadID(topLevelPostingMessageID);
				messages.setThreadParent(topLevelPostingMessageID);
				messages.setThreadLevel(2);
				messages.setAuthor(user);
				messages.setNotify(false);
				messages.setSubject(subject);
				messages.setBody(comments);
				messages.setAcktion(mode);
				rowsAffected = insertMessage(conn,messages);
			}
			else{
				// when first adding reviewer comments, there should be a 0 level thread
				messages.setTimeStamp(AseUtil.getCurrentDateTimeString());
				messages.setForumID(fid);
				messages.setItem(item);
				messages.setSq(item);
				messages.setEn(en);
				messages.setQn(qn);
				messages.setThreadID(0);
				messages.setThreadParent(0);
				messages.setThreadLevel(1);
				messages.setAuthor(user);
				messages.setNotify(false);
				messages.setSubject(subject);
				messages.setBody("");
				messages.setNotified(0);
				messages.setAcktion(mode);
				rowsAffected = insertMessage(conn,messages);

				// this is the review to add. in doing this, all first time
				// additions to this review item falls under the main
				// however, don't add if the comment is empty. this happens when
				// adding for the first time and arriving from course screen
				if (comments != null && comments.length() > 0){

					if(sq == 0 && en == 0 && qn == 0){
						topLevelPostingMessageID = getTopLevelPostingMessage(conn,fid,item);
					}
					else{
						topLevelPostingMessageID = getTopLevelPostingMessage(conn,fid,sq,en,qn);
					}

					messages.setTimeStamp(AseUtil.getCurrentDateTimeString());
					messages.setForumID(fid);
					messages.setItem(item);
					messages.setSq(item);
					messages.setEn(en);
					messages.setQn(qn);
					messages.setThreadID(topLevelPostingMessageID);
					messages.setThreadParent(topLevelPostingMessageID);
					messages.setThreadLevel(2);
					messages.setAuthor(user);
					messages.setNotify(false);
					messages.setSubject(subject);
					messages.setBody(comments);
					messages.setAcktion(mode);
					rowsAffected = insertMessage(conn,messages);
				}

			}

			messages = null;

		} catch (SQLException e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * createFirstMessageX
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int createFirstMessageXNOT_USED(Connection conn,Forum forum,int table,int lastForumID,String txt,int mode) throws SQLException {

		return createFirstMessageXNOT_USED(conn,forum,table,lastForumID,txt,mode,0,0);

	}

	public static int createFirstMessageXNOT_USED(Connection conn,Forum forum,int table,int lastForumID,String txt,int mode,int en,int qn) throws SQLException {

		int rowsAffected = 0;

		try {

			if (!isMatchingMessage(conn,lastForumID,forum.getItem())){

				String timeStamp = AseUtil.getCurrentDateTimeString();

				if (txt.equals(Constant.BLANK)){
					txt = QuestionDB.getCourseQuestion(conn,forum.getCampus(),table,forum.getItem());
				}

				String subject = "";

				if(en > 0){
					subject = "ITEM: " + forum.getItem() + "; EN: " + en;
					if (qn > 0){
						subject += "; QN: " + qn;
					}
				}
				else{
					subject = "Item No. " + forum.getItem();
				}

				Messages messages = new Messages();
				messages.setTimeStamp(timeStamp);
				messages.setForumID(lastForumID);
				messages.setItem(forum.getItem());
				messages.setSq(forum.getItem());
				messages.setEn(en);
				messages.setQn(qn);
				messages.setThreadID(0);
				messages.setThreadParent(0);
				messages.setThreadLevel(1);
				messages.setAuthor(forum.getCreator());
				messages.setNotify(false);
				messages.setSubject(subject);
				messages.setBody(txt);
				messages.setAcktion(mode);
				rowsAffected = insertMessage(conn,messages);

				if (rowsAffected > 0){
					rowsAffected = getLastMessageID(conn,lastForumID);
				}

				lastForumID = rowsAffected;

			} // not matching


		} catch (SQLException e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: getLastForumID - " + e.toString());
		}

		return lastForumID;
	}

	/*
	 * getUserBoards
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getUserBoards(Connection conn,String campus,String user,String aseBoardsToShow) throws Exception {

		//Logger logger = Logger.getLogger("test");

		getUserBoards(conn,campus,user,aseBoardsToShow,"course");
		getUserBoards(conn,campus,user,aseBoardsToShow,"foundation");

		List<Generic> genericData = new LinkedList<Generic>();

		try{
			String sql = "SELECT * FROM tbljunkdata WHERE campus=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("string1")),
										AseUtil.nullToBlank(rs.getString("string2")),
										AseUtil.nullToBlank(rs.getString("string3")),
										AseUtil.nullToBlank(rs.getString("string4")),
										AseUtil.nullToBlank(rs.getString("string5")),
										AseUtil.nullToBlank(rs.getString("string6")),
										AseUtil.nullToBlank(rs.getString("string7")),
										AseUtil.nullToBlank(rs.getString("string8")),
										AseUtil.nullToBlank(rs.getString("string9")),
										AseUtil.nullToBlank(rs.getString("string0"))
									));
			}
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
		}


		return genericData;

	}

	public static int getUserBoards(Connection conn,String campus,String user,String aseBoardsToShow,String src) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// retrieve all active forums a user has access to.
		// active is where the user is actively participating in (message_author)
		// the historyid is valid because the coursetype is PRE
		// and messages are in forum only at review process
		try{

			JunkDataDB.delete(conn,src,user);

			String srcType = "Course";
			String table = "tblcourse";
			String columnType = "coursetype";

			if(src.equals("foundation")){
				srcType = "Foundation";
				table = "tblfnd";
				columnType = "type";
			}

			String showSQL = " AND src='"+srcType+"' AND (status<>'Closed' AND status<>'Completed') ";

			if(aseBoardsToShow.equals("0")){
				// close
				showSQL = " WHERE src='"+srcType+"' AND (f.status='Closed' OR f.status='Completed') ";
			}
			else if(aseBoardsToShow.equals("1")){
				// active
				showSQL = " WHERE src='"+srcType+"' AND (f.status<>'Closed' AND f.status<>'Completed') ";
			}
			else if(aseBoardsToShow.equals("2")){
				// all
				showSQL = " WHERE src='"+srcType+"' AND (f.status like '%%') ";
			}

			// proposer should have access
			String sqlProposer = " "
				+ "SELECT DISTINCT historyid,coursealpha + ' ' + coursenum as boardname, proposer as creator, '"+srcType+"' as src  "
				+ "FROM " + table + " "
				+ "WHERE campus='"+campus+"' AND  " + columnType + " ='PRE' and proposer='"+user+"' ";

			// active participant of a post
			String sqlMemberOf = " UNION "
				+ "SELECT DISTINCT f.historyid,f.forum_name as boardname,f.creator, f.src "
				+ "FROM messages m INNER JOIN "
				+ "forums f ON m.forum_id = f.forum_id "
				+ "WHERE (m.message_author='"+user+"') AND (f.campus='"+campus+"') AND (f.src='"+srcType+"') ";

			// part of the approver list
			String sqlApprovers = "UNION "
				+ "SELECT DISTINCT c.historyid,c.coursealpha + ' ' + c.coursenum as boardname, c.proposer as creator, '"+srcType+"' as src "
				+ "FROM " + table + "  AS c INNER JOIN "
				+ "tblApprover AS a ON c.campus = a.campus AND c.route = a.route "
				+ "WHERE (c.campus='"+campus+"') AND (c.route > 0) AND (a.approver='"+user+"') ";

			// part of the reviewer group
			String sqlReviewers = "UNION "
				+ "SELECT DISTINCT c.historyid,c.coursealpha + ' ' + c.coursenum as boardname, c.proposer as creator, '"+srcType+"' as src "
				+ "FROM " + table + "  AS c INNER JOIN "
				+ "tblReviewers AS r ON c.campus = r.campus AND c.historyid = r.historyid "
				+ "WHERE (c.campus='"+campus+"' AND r.userid='"+user+"') ";

			// invited members to a discussion
			String sqlForums = "UNION "
				+ "SELECT DISTINCT f.historyid,f.forum_name as boardname,f.creator, f.src "
				+ "FROM forumsx fx INNER JOIN forums f "
				+ "ON fx.fid = f.forum_id AND f.campus='"+campus+"' AND fx.userid='"+user+"' ";

			// personal or user created boards
			String sqlUserBoards = "UNION "
				+ "SELECT DISTINCT historyid,forum_name as boardname,creator, src FROM forums WHERE campus='"+campus+"' AND historyid like '"+user+"%' ";

			// table 'u' combines all different areas a person can be included
			// combine u with course to pull in any valid course alpha, number as a result of
			// review or other connection to course.
			String sql = "SELECT f.forum_id, f.historyid, c.CourseAlpha, c.CourseNum, f.boardname, f.creator, f.status, f.views, f.campus, f.src "
				+ "FROM "
				+ "( "
				+ "	SELECT f.forum_id, u.historyid, f.status, f.views, u.boardname, u.creator, f.campus, f.src "
				+ "	FROM ( "
				+ sqlProposer
				+ sqlMemberOf
				+ sqlApprovers
				+ sqlReviewers
				+ sqlForums
				+ sqlUserBoards
				+ "	) AS u INNER JOIN forums f ON u.historyid = f.historyid "
				+ ") as f LEFT OUTER JOIN " + table + "  c "
				+ "ON f.historyid = c.historyid "
				+ showSQL;

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				int fid = NumericUtil.getInt(rs.getInt("forum_id"),0);

				int posts = countPostsToForum(conn,fid);
				int members = countMembersInForum(conn,fid);

				String status = AseUtil.nullToBlank(rs.getString("status"));
				if (!status.toLowerCase().equals(ForumDB.FORUM_CLOSED)){
					status = "Active";
				}

				int views = NumericUtil.getInt(rs.getInt("views"),0);

				JunkDataDB.insertStringsWithKeys(conn, new JunkData(
										campus,
										user,
										src,
										"",
										"",
										"",
										src,
										"" + fid,
										status,
										AseUtil.nullToBlank(rs.getString("historyid")),
										AseUtil.nullToBlank(rs.getString("historyid")),
										AseUtil.nullToBlank(rs.getString("boardname")),
										AseUtil.nullToBlank(rs.getString("creator")),
										ForumDB.getLastPost(conn,fid),
										""+posts,
										""+members,
										""+views)
					);

				++rowsAffected;

			} // rs
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
		}

		return rowsAffected;

	} // ForumDB - getUserBoards

	public static List<Generic> getUserBoardsOBSOLETE(Connection conn,String campus,String user,String aseBoardsToShow) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		// retrieve all active forums a user has access to.
		// active is where the user is actively participating in (message_author)
		// the historyid is valid because the coursetype is PRE
		// and messages are in forum only at review process
		try{
			if (genericData == null){

            String showSQL = " AND src='Course' AND (status<>'Closed' AND status<>'Completed') ";

            if(aseBoardsToShow.equals("0")){
					// close
					showSQL = " WHERE src='Course' AND (f.status='Closed' OR f.status='Completed') ";
				}
            else if(aseBoardsToShow.equals("1")){
					// active
					showSQL = " WHERE src='Course' AND (f.status<>'Closed' AND f.status<>'Completed') ";
				}
            else if(aseBoardsToShow.equals("2")){
					// all
					showSQL = " WHERE src='Course' AND (f.status like '%%') ";
				}

            genericData = new LinkedList<Generic>();

				// proposer should have access
				String sqlProposer = " "
					+ "SELECT DISTINCT historyid,coursealpha + ' ' + coursenum as boardname, proposer as creator, 'Course' as src  "
					+ "FROM tblCourse  "
					+ "WHERE campus='"+campus+"' AND coursetype='PRE' and proposer='"+user+"' ";

				// active participant of a post
				String sqlMemberOf = " UNION "
					+ "SELECT DISTINCT f.historyid,f.forum_name as boardname,f.creator, f.src "
					+ "FROM messages m INNER JOIN "
					+ "forums f ON m.forum_id = f.forum_id "
					+ "WHERE (m.message_author='"+user+"') AND (f.campus='"+campus+"') AND (f.src='Course') ";

				// part of the approver list
				String sqlApprovers = "UNION "
					+ "SELECT DISTINCT c.historyid,c.coursealpha + ' ' + c.coursenum as boardname, c.proposer as creator, 'Course' as src "
					+ "FROM tblCourse AS c INNER JOIN "
					+ "tblApprover AS a ON c.campus = a.campus AND c.route = a.route "
					+ "WHERE (c.campus='"+campus+"') AND (c.route > 0) AND (a.approver='"+user+"') ";

				// part of the reviewer group
				String sqlReviewers = "UNION "
					+ "SELECT DISTINCT c.historyid,c.coursealpha + ' ' + c.coursenum as boardname, c.proposer as creator, 'Course' as src "
					+ "FROM  tblCourse AS c INNER JOIN "
					+ "tblReviewers AS r ON c.campus = r.campus AND c.historyid = r.historyid "
					+ "WHERE (c.campus='"+campus+"' AND r.userid='"+user+"') ";

				// invited members to a discussion
				String sqlForums = "UNION "
					+ "SELECT DISTINCT f.historyid,f.forum_name as boardname,f.creator, f.src "
					+ "FROM forumsx fx INNER JOIN forums f "
					+ "ON fx.fid = f.forum_id AND f.campus='"+campus+"' AND fx.userid='"+user+"' ";

				// personal or user created boards
				String sqlUserBoards = "UNION "
					+ "SELECT DISTINCT historyid,forum_name as boardname,creator, src FROM forums WHERE campus='"+campus+"' AND historyid like '"+user+"%' ";

				// table 'u' combines all different areas a person can be included
				// combine u with course to pull in any valid course alpha, number as a result of
				// review or other connection to course.
				String sql = "SELECT f.forum_id, f.historyid, c.CourseAlpha, c.CourseNum, f.boardname, f.creator, f.status, f.views, f.campus, f.src "
					+ "FROM "
					+ "( "
					+ "	SELECT f.forum_id, u.historyid, f.status, f.views, u.boardname, u.creator, f.campus, f.src "
					+ "	FROM ( "
					+ sqlProposer
					+ sqlMemberOf
					+ sqlApprovers
					+ sqlReviewers
					+ sqlForums
					+ sqlUserBoards
					+ "	) AS u INNER JOIN forums f ON u.historyid = f.historyid "
					+ ") as f LEFT OUTER JOIN tblCourse c "
					+ "ON f.historyid = c.historyid "
					+ showSQL;

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					int fid = NumericUtil.getInt(rs.getInt("forum_id"),0);

					int posts = countPostsToForum(conn,fid);
					int members = countMembersInForum(conn,fid);

					String status = AseUtil.nullToBlank(rs.getString("status"));
					if (!status.toLowerCase().equals(ForumDB.FORUM_CLOSED)){
						status = "Active";
					}

					int views = NumericUtil.getInt(rs.getInt("views"),0);

					genericData.add(new Generic(
											"" + fid,
											status,
											AseUtil.nullToBlank(rs.getString("historyid")),
											AseUtil.nullToBlank(rs.getString("historyid")),
											AseUtil.nullToBlank(rs.getString("boardname")),
											AseUtil.nullToBlank(rs.getString("creator")),
											ForumDB.getLastPost(conn,fid),
											""+posts,
											""+members,
											""+views
										));
				} // rs
				rs.close();
				ps.close();
			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserBoards: " + e.toString());
			return null;
		}

		return genericData;
	} // ForumDB - getUserBoards

	/*
	 * getUserMessages
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	show		String
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getUserMessages(Connection conn,String campus,String user,String show) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		// retrieve all active forums with this user's name as part of KIX
		try{
			if (genericData == null){

            genericData = new LinkedList<Generic>();

            AseUtil ae = new AseUtil();

            String showSQL1 = " AND status<>'Closed' ";
            String showSQL2 = " AND f.status<>'Closed' ";
				String history = " AND historyid like '"+user+"%' ";

            if(show.equals("0")){
					// close
					showSQL1 = " AND status='Closed' ";
					showSQL2 = " AND f.status='Closed' ";

					// every sees closed data
					history = "";
				}
            else if(show.equals("1")){
					// active
					showSQL1 = " AND status<>'Closed' ";
					showSQL2 = " AND f.status<>'Closed' ";
				}
            else if(show.equals("2")){
					// all
					showSQL1 = "";
					showSQL2 = "";
				}

				// allow current user to see what's his/her and for non owners,
				// allow to see by invitation only.
				String sql = "SELECT forum_id,historyid,forum_name,createddate,creator,status,views "
					+ "FROM forums  "
					+ "WHERE campus=? "
					+ showSQL1
					+ history
					+ "UNION "
					+ "SELECT f.forum_id, f.historyid, f.forum_name, f.createddate, f.creator, f.status, f.views "
					+ "FROM forums AS f INNER JOIN "
					+ "forumsx AS x ON f.forum_id = x.fid "
					+ "WHERE f.campus=? "
					+ showSQL2;
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					int posts = countPostsToForum(conn,rs.getInt("forum_id"));
					int members = countMembersInForum(conn,rs.getInt("forum_id"));

					int fid = rs.getInt("forum_id");

					String status = AseUtil.nullToBlank(rs.getString("status"));
					if (!status.toLowerCase().equals(FORUM_CLOSED)){
						status = "Active";
					}

					int views = NumericUtil.getInt(rs.getInt("views"),0);

					genericData.add(new Generic(
											"" + fid,
											AseUtil.nullToBlank(rs.getString("historyid")),
											AseUtil.nullToBlank(rs.getString("forum_name")),
											AseUtil.nullToBlank(rs.getString("creator"))
												+ " - "
												+ ae.ASE_FormatDateTime(rs.getString("createddate"),Constant.DATE_SHORT),
											"" + posts,
											"" + members,
											getLastPost(conn,fid),
											"" + views,
											"" + getReplies(conn,user,fid),
											status
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserMessages: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserMessages: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * displayUserHeader
	 * <p>
	 * @param	subject
	 * @param	body
	 * <p>
	 * @return	String
	 */
	public static String displayUserHeader(String subject,String body) throws Exception {

		StringBuffer buf = new StringBuffer();

		buf.append("<BR>");
		buf.append("<TABLE BORDER=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\" width=\"700\">");

		buf.append("<TR height=\"20\">");
		buf.append("<TD width=\"20%\" class=\"textblackth\">Subject:&nbsp;</td>");
		buf.append("<TD width=\"80%\" class=\"datacolumn\">"+subject+"</td>");
		buf.append("</TR>");

		buf.append("<TR height=\"20\">");
		buf.append("<TD width=\"20%\" class=\"textblackth\">Message:&nbsp;</td>");
		buf.append("<TD width=\"80%\" class=\"datacolumn\">"+body+"</td>");
		buf.append("</TR>");
		buf.append("</TABLE>");

		return buf.toString();
	}

	/*
	 * displayUserMessage
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 *	@return int
	 */
	public static String displayUserMessage(Connection conn,String user,int mid,int item,String sort) throws Exception {

		StringBuffer buf = new StringBuffer();

		PreparedStatement ps = conn.prepareStatement("SELECT * FROM messages WHERE message_id=?");
		ps.setInt(1,mid);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			int forumID = rs.getInt("forum_id");
			int threadLevel = rs.getInt("thread_level") + 1;
			int processed = rs.getInt("processed");

			String author = rs.getString("message_author");

			if (processed == 0 && !user.equals(author)){
				setMessageToProcessed(conn,forumID,mid,item);
			}

			String kix = getKix(conn,forumID);

			String temp = "";
			String campus= "";

			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM forums WHERE forum_id=?");
			ps2.setInt(1,forumID);
			ResultSet rs2 = ps2.executeQuery();
			if(rs2.next()){

				campus = rs2.getString("campus");

				temp = showUserForumLine(forumID,
													"open",
													rs2.getString("forum_name"),
													"",
													0,
													rs2.getString("historyid"),
													getCampusFromMid(conn,mid),
													false,
													"");
			}
			rs2.close();
			ps2.close();

			//
			// list attachments requires campus which was retrieved from above
			//
			String junk = AttachDB.listAttachmentsByCategoryKix(conn,campus,Constant.FORUM,kix+"_"+mid,sort);
			if (junk != null && junk.length() > 0){
				buf.append(Html.BR()
							+ junk
							+ Html.BR());
			}

			//
			// result from showUserForumLine is placed here because we want this after attachments.
			// however, we took this approach because we had to get campus for use with attachment
			// and it was possible only if we put showUserForumLine the above attachment retrieval
			//
			buf.append(temp);

			buf.append(	Html.BR()
							+ showChildren(conn,forumID,item,0,0,mid)
							+ Html.BR()
							+ Html.BR()
							+ "<img src=\"../../images/ed_list_num.gif\" border=\"0\" alt=\"go to post listing\" title=\"go to post listing\">&nbsp;<A class=\"linkcolumn\" HREF=\"../usrbrd.jsp\">return to my messages<i></i></A>"
							+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"./images/document.gif\" border=\"0\" alt=\"Post a Reply\" title=\"Post a Reply\">&nbsp;<A class=\"linkcolumn\" HREF=\"./post.jsp?fid="
							+ forumID
							+ "&src="
							+ Constant.FORUM_USERNAME
							+ "&mid="
							+ mid
							+ "&item="
							+ item
							+ "&tid="
							+ rs.getInt("thread_id")
							+ "&pid="
							+  rs.getInt("message_id")
							+ "&level="
							+  threadLevel
							+ "\">Post a Reply</A>"
							+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"/central/images/attachment.gif\" border=\"0\" alt=\"Attach document\" title=\"Attach document\">&nbsp;<A class=\"linkcolumn\" HREF=\"../gnrcmprt.jsp?fid="+forumID+"&mid="+mid+"&src=thisPage&kix=hasValue\">Attach document</A>");

		} // rs
		rs.close();
		ps.close();

		return buf.toString();
	}

	/**
	 * showUserForumLine
	 * <p>
	 * @return	String
	*/
	public static String showUserForumLine(int iId,
													String sFolderStatus,
													String sName,
													String sDescription,
													long iMessageCount,
													String kix,
													String campus,
													boolean tableHeader,
													String xref) throws Exception {

		StringBuffer output = new StringBuffer();

		int attachments = 0;

		try{
			if (!kix.equals(Constant.BLANK)){
				attachments = getAttachments(kix,"","","Forum",campus);
			}

			if (tableHeader){

				Connection conn = null;

				String created = null;
				String updated = null;
				int priority = 0;

				try{
					conn = AsePool.createLongConnection();
					Forum forum = null;

					// at the main or root node, no alpha or num available
					if (conn != null){
						forum = getForum(conn,iId);

						if (forum != null){
							created = forum.getCreatedDate();
							updated = forum.getAuditDate();
							priority = forum.getPriority();
						}

						forum = null;
					}
				}
				catch(Exception e){
					logger.fatal("ForumDB: showMessageLine - " + e.toString());
				}
				finally{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}

				output.append("<tr>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
						+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
						+ "</a></td>"
						+ "<td><A class=\"linkcolumn\" HREF=\"./usrbrd.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + kix + "</A></td>"
						+ "<td>"+campus+"</td>"
						+ "<td align=\"right\">"+created+"</td>"
						+ "<td align=\"center\">"+priority+"</td>"
						+ "<td>"+sName+"</td>"
						+ "<td align=\"right\">"+updated+"</td>"
						+ "<td align=\"center\">"+iMessageCount+"</td>"
						+ "<td align=\"center\">"+attachments+"</td>"
						+ "<td align=\"center\">"+xref+"</td>"
						+ "</tr>");
			}
			else{
				output.append("<A class=\"linkcolumn\" HREF=\"./edt.jsp?fid=" + iId + "\" title=\"edit forum\" alt=\"edit forum\">"
								+ "<IMG SRC=\"../images/folder_" + sFolderStatus + ".gif\" BORDER=\"0\">"
								+ "</a>"
								+ "&nbsp;"
								+ "<A class=\"linkcolumn\" HREF=\"./usrbrd.jsp?fid=" + iId + "\" title=\"go to message board\" alt=\"go to message board\">" + sName + "</A>"
								+ "&nbsp;");

				if (sDescription != null && sDescription.length() > 0){
					output.append("&nbsp;--&nbsp;");
					output.append(sDescription);
				}

				if (iMessageCount > 0 || attachments > 0) {

					output.append("&nbsp;(");

					if (iMessageCount > 0) {
						output.append(iMessageCount);
						output.append("&nbsp;<img src=\"/central/images/email.gif\" title=\"messages\" alt=\"messages\" border=\"0\">;");
					}

					if (attachments > 0) {
						output.append("&nbsp;");
						output.append(attachments);
						output.append("&nbsp;<img src=\"/central/images/attachment.gif\" title=\"attachment\" alt=\"attachment\" border=\"0\">");
					}

					output.append(")" + Html.BR());
				} // iMessageCount

			} // tableHeader
		}
		catch(Exception e){
			logger.fatal("ForumDB - showUserForumLine: " + e.toString());
		}

		return output.toString();
	} // ForumDB: showUserForumLine

	/**
	 * displayUserBoard
	 * <p>
	 * @return	String
	*/
	public static String displayUserBoard(Connection conn,String user,String kix,int activeForum,String sort) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String forumName = "";
		String forumDescr;
		String threadList;
		String sql = "";
		String campus = "";
		String xref = "";

		java.util.Date startDate;

		long numberOfPostings = 0;
		int mid = 0;
		int forumID = 0;
		int iPeriodsToGoBack = 0;
		int iPeriodToShow = 0;
		int iPeriodLooper = 0;

		java.util.Date today = new java.util.Date();

		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;

		AseUtil aseUtil = new AseUtil();

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM forums WHERE historyid=?;");
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				forumID = rs.getInt("forum_id");
				forumName = AseUtil.nullToBlank(rs.getString("forum_name"));
				forumDescr = AseUtil.nullToBlank(rs.getString("forum_description"));
				startDate = rs.getDate("forum_start_date");
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				xref = AseUtil.nullToBlank(rs.getString("xref"));

				numberOfPostings = AseUtil.countRecords(conn,"messages","WHERE forum_id="+forumID);

				buf.append(displayUserHeader(forumName,forumDescr));

				if (forumID == activeForum){

					buf.append(showUserForumLine(forumID,"open",forumName,"",numberOfPostings,kix,campus,false,xref));

					iPeriodsToGoBack = ForumDB.monthDiff(startDate, today);

					iPeriodsToGoBack = 0;
					iPeriodToShow = 0;

					for(iPeriodLooper=0;iPeriodLooper<=iPeriodsToGoBack;iPeriodLooper++){

						if(iPeriodLooper == iPeriodToShow){

							threadList = "";
							sql = "SELECT * FROM messages WHERE forum_id=? ORDER BY thread_id DESC";
							ps2 = conn.prepareStatement(sql);
							ps2.setInt(1,activeForum);
							rs2 = ps2.executeQuery();

							while(rs2.next()){
								if (threadList.equals(Constant.BLANK))
									threadList = "" + rs2.getInt("thread_id");
								else
									threadList = threadList + "," + rs2.getInt("thread_id");
							}
							rs2.close();
							ps2.close();

							// prevent SQL IN clause error
							if (threadList.equals(Constant.BLANK)){
								threadList = "0";
							}

							sql = "SELECT * FROM messages WHERE forum_id=? AND thread_parent=0 ORDER BY thread_id DESC;";
							ps2 = conn.prepareStatement(sql);
							ps2.setInt(1,activeForum);
							rs2 = ps2.executeQuery();

							sql = "SELECT thread_id, COUNT(*) "
								+ "FROM messages "
								+ "WHERE thread_id IN (" + threadList + ") "
								+ "GROUP BY thread_id "
								+ "ORDER BY thread_id DESC;";
							ps3 = conn.prepareStatement(sql);
							rs3 = ps3.executeQuery();

							while(rs2.next() && rs3.next()){
								mid = rs2.getInt("message_id");
								buf.append(showUserMessageLine(conn,
																		1,
																		mid,
																		rs2.getInt("item"),
																		AseUtil.nullToBlank(rs2.getString("message_subject")),
																		AseUtil.nullToBlank(rs2.getString("message_author")),
																		aseUtil.ASE_FormatDateTime(rs2.getString("message_timestamp"),Constant.DATE_DATETIME),
																		rs3.getInt(2) - 1,
																		"forum",
																		0,
																		activeForum,
																		rs2.getInt("processed")));
							}

							rs3.close();
							ps3.close();

							rs2.close();
							ps2.close();

						} //if(iPeriodLooper == iPeriodToShow)

					} // for
				}
				else{
					buf.append(ForumDB.showForumLine(forumID,"closed",forumName,"",numberOfPostings,kix,campus,false,xref));
				} // if (forumID == activeForum){

			} // if rs
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("ForumDB - display: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - display: " + e.toString());
		}

		buf.append("<br/><br/>");

		buf.append(AttachDB.listAttachmentsByCategoryKix(conn,campus,Constant.FORUM,kix,sort) + Html.BR());
		buf.append("<img src=\"../../images/ed_list_num.gif\" border=\"0\" alt=\"go to post listing\" title=\"go to post listing\">&nbsp;<A class=\"linkcolumn\" HREF=\"../usrbrd.jsp\">return to my messages<i></i></A>");
		buf.append("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"./images/document.gif\" border=\"0\" alt=\"Post a Reply\" title=\"Post a Reply\">&nbsp;<A class=\"linkcolumn\" HREF=\"./post.jsp?src="+Constant.FORUM_USERNAME+"&fid="+activeForum+"\">Post a New Message</A>");
		buf.append("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"/central/images/attachment.gif\" border=\"0\" alt=\"Attach document\" title=\"Attach document\">&nbsp;<A class=\"linkcolumn\" HREF=\"../gnrcmprt.jsp?fid="+activeForum+"&mid=0&src=thisPage&kix=hasValue\">Attach document</A>");

		return buf.toString();
	}

	/*
	 * getUserPosts
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	hide		boolean
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getUserPosts(Connection conn,int fid) throws Exception {

		return getUserPosts(conn,fid,0,false);

	}

	public static List<Generic> getUserPosts(Connection conn,int fid,boolean hide) throws Exception {

		return getUserPosts(conn,fid,0,hide);

	}

	public static List<Generic> getUserPosts(Connection conn,int fid,int mid) throws Exception {

		return getUserPosts(conn,fid,mid,false);

	}

	public static List<Generic> getUserPosts(Connection conn,int fid,int mid,boolean hide) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				String kix = getKix(conn,fid);

				//
				// determine whether we are showing all or only enabled items
				//
				String enabledItems = "";
				if(hide){
					String edited1 = MiscDB.getColumn(conn,kix,"edited1");
					String edited2 = MiscDB.getColumn(conn,kix,"edited2");

					enabledItems = edited1;

					if(!edited2.equals(Constant.BLANK)){
						enabledItems = enabledItems + "," + edited2;
					}

					enabledItems = "," + enabledItems + ",";
				}

            genericData = new LinkedList<Generic>();

            AseUtil ae = new AseUtil();

            String sql = "";

            PreparedStatement ps = null;

				// thread_parent = 0 is the main or top level post (first post)
				if (mid > 0){
					sql = "select thread_id,message_subject,message_author, message_timestamp,closed,item "
						+ "from messages  "
						+ "where forum_id=? and thread_id=? and thread_parent=0 "
						+ "order by item";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,fid);
					ps.setInt(2,mid);
				}
				else{
					sql = "select thread_id,message_subject,message_author, message_timestamp,closed,item "
						+ "from messages  "
						+ "where forum_id=? and thread_parent=0 "
						+ "order by item";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,fid);
				}
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					mid = rs.getInt("thread_id");
					int item = NumericUtil.getInt(rs.getInt("item"),0);

					boolean show = false;

					if(hide){
						if(enabledItems.contains(","+item+",")){
							show = true;
						}
					}
					else{
						show = true;
					}

					if(show){
						String status = "Active";

						if (NumericUtil.isInteger(rs.getInt("closed"))){
							if(rs.getInt("closed")==1){
								status = "Closed";
							}
							else{
								status = "Active";
							}
						}
						else{
							status = "Active";
						}

						genericData.add(new Generic(
												AseUtil.nullToBlank(rs.getString("message_subject")),
												AseUtil.nullToBlank(rs.getString("message_author")),
												ae.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME),
												"" + countPostsToForumMid(conn,fid,mid),
												"" + countMembersInForumMid(conn,fid,mid),
												"" + mid,
												getLastPostAuthor(conn,fid,mid) + " - " + getLastPostedDate(conn,fid,mid),
												status,
												"" + item
											));
					} // show

				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserPosts: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserPosts: " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * getUserPostedItem - returns data based on a valid forum id and item
	 *	<p>
	 * @param	conn	Connection
	 * @param	fid	int
	 * @param	itm	int
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getUserPostedItem(Connection conn,int fid,int itm) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

            genericData = new LinkedList<Generic>();

            AseUtil ae = new AseUtil();

				 String sql = "select thread_id,message_subject,message_author, message_timestamp,closed "
					+ "from messages  "
					+ "where forum_id=? and item=? and thread_parent=0";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setInt(2,itm);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					int mid = rs.getInt("thread_id");

					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("message_subject")),
											AseUtil.nullToBlank(rs.getString("message_author")),
											ae.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_DATETIME),
											""+mid,
											"",
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getUserPosts: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ForumDB - getUserPosts: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * countPostsToForum - count of direct posts to top level forum
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int countPostsToForum(Connection conn,int fid) throws SQLException {

		int posts = 0;

		try{
			String sql = "SELECT count(forum_id) AS counter FROM messages WHERE forum_id=? and thread_parent>0";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				posts = NumericUtil.getInt(rs.getInt("counter"),0);
			} // if next
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}

		return posts;
	}

	/**
	 * countPostsToForum - count of direct posts to top level forum
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	item
	 * <p>
	 * @return	int
	 */
	public static int countPostsToForum(Connection conn,String kix,int item) throws SQLException {

		int posts = 0;

		try{
			String sql =
						"SELECT SUM(counter) AS sum_counter "
						+ "FROM( "
						+ "SELECT COUNT(messages.item) AS counter "
						+ "FROM messages INNER JOIN "
						+ "forums ON messages.forum_id = forums.forum_id "
						+ "GROUP BY messages.item, forums.historyid, messages.thread_parent "
						+ "HAVING messages.item=? AND forums.historyid=? AND messages.thread_parent >= 0 "
						+ ") AS Test";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,item);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				posts = rs.getInt("sum_counter");

				// when working with outlines, the first post is not counted. the root or thread = 0
				// is designated as the post created by the proposer to maintain level consistency
				if (getForumSource(conn,getForumID(conn,kix)).equals(Constant.COURSE) && posts > 0){
					--posts;
				}

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}

		return posts;
	}

	/**
	 * countPostsToForumMid - count of direct posts messages
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int countPostsToForumMid(Connection conn,int fid,int mid) throws SQLException {

		int posts = 0;

		try{
			String sql = "SELECT count(forum_id) AS counter FROM messages WHERE forum_id=? and thread_id=? and thread_parent > 0";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				posts = rs.getInt("counter");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countPostsToForumMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countPostsToForumMid: " + e.toString());
		}

		return posts;
	}

	/**
	 * countMembersInForum
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int countMembersInForum(Connection conn,int fid) throws SQLException {

		int members = 0;

		try{
			String sql = "select count(distinct message_author) AS counter FROM messages WHERE forum_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				members = rs.getInt("counter");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countMembersInForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countMembersInForum: " + e.toString());
		}

		return members;
	}

	/**
	 * countMembersInForumMid
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int countMembersInForumMid(Connection conn,int fid,int mid) throws SQLException {

		int members = 0;

		try{
			String sql = "select count(distinct message_author) AS counter FROM messages WHERE forum_id=? AND thread_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				members = rs.getInt("counter");
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countMembersInForumMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countMembersInForumMid: " + e.toString());
		}

		return members;
	}

	/**
	 * openForum
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int openForum(Connection conn,String campus,String user,String kix) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (kix != null){
				int fid = getForumID(conn,campus,kix);
				if (isForumClosed(conn,fid)){
					String sql = "UPDATE forums SET status='Requirements',auditdate=?,auditby=? WHERE forum_id=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,user);
					ps.setInt(3,fid);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			} // kix
		}
		catch(Exception e){
			logger.fatal("ForumDB: openForum - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * closeForum
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int closeForum(Connection conn,String campus,String user,String kix) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (kix != null){
				rowsAffected = closeForum(conn,user,getForumID(conn,campus,kix));
			} // kix
		}
		catch(Exception e){
			logger.fatal("ForumDB: closeForum - " + e.toString());
		}

		return rowsAffected;
	}

	public static int closeForum(Connection conn,String user,int fid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (fid > 0){
				// closing the main board closes all postings as well.
				String sql = "UPDATE messages SET closed=1 WHERE forum_id=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// closing the main board also deletes pending messages
				sql = "DELETE FROM messagesx WHERE fid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//
				// closing the main board also deletes members
				//
				// no.. leave them for historical records
				//
				//sql = "DELETE FROM forumsx WHERE fid=?";
				//ps = conn.prepareStatement(sql);
				//ps.setInt(1,fid);
				//rowsAffected = ps.executeUpdate();
				//ps.close();

				// must be last thing done
				sql = "UPDATE forums SET status='Closed',auditdate=?,auditby=? WHERE forum_id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setString(2,user);
				ps.setInt(3,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

			} // fid
		} catch (SQLException e) {
			logger.fatal("ForumDB: closeForum - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: closeForum - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * closeForum
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	kix
	 * @param	kixCan
	 * <p>
	 * @return	int
	 */
	public static int closeForum(Connection conn,String campus,String user,String kix,String kixCan) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "UPDATE forums SET status='Closed',historyid=?,auditdate=?,auditby=? WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kixCan);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setString(3,user);
			ps.setString(4,campus);
			ps.setString(5,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// closing the main board closes all postings as well.
			int fid = getForumID(conn,campus,kixCan);
			if (fid > 0){
				sql = "UPDATE messages SET closed=1 WHERE forum_id=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// closing the main board also deletes pending messages
				sql = "DELETE FROM messagesx WHERE fid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();
			} // fid
		} catch (SQLException e) {
			logger.fatal("ForumDB: closeForum - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: closeForum - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * closePost
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	kix
	 * <p>
	 * @return	int
	 */
	public static int closePost(Connection conn,String campus,String kix) {

		int rowsAffected = 0;

		try{
			rowsAffected = closePost(conn,getForumID(conn,campus,kix));
		}
		catch(Exception e){
			logger.fatal("ForumDB: closePost - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * closePost
	 * <p>
	 * @param	conn
	 * @param	forum
	 * <p>
	 * @return	int
	 */
	public static int closePost(Connection conn,int fid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM messagesx WHERE fid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "UPDATE messages SET closed=1,notified=1 WHERE forum_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: closePost - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: closePost - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * closePost
	 * <p>
	 * @param	conn
	 * @param	forum
	 * @param	post
	 * <p>
	 * @return	int
	 */
	public static int closePost(Connection conn,int fid,int mid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			// delete all unprocessed messages before closing
			String sql = "DELETE FROM messagesx WHERE fid=? AND tp=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "UPDATE messages SET closed=1,notified=1 WHERE forum_id=? AND thread_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: closePost - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: closePost - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getLastPostedDate
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getLastPostedDate(Connection conn,int fid,int mid) throws SQLException {

		String lastPostedDate = "";

		try{
			String sql = "SELECT max(message_timestamp) as lastposteddate FROM messages WHERE forum_id=? AND thread_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				AseUtil ae = new AseUtil();
				lastPostedDate = ae.ASE_FormatDateTime(rs.getString("lastposteddate"),Constant.DATE_SHORT);
				ae = null;
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getLastPostedDate: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getLastPostedDate: " + e.toString());
		}

		return lastPostedDate;
	}

	/**
	 * getLastPostAuthor
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * <p>
	 * @return	String
	 */
	public static String getLastPostAuthor(Connection conn,int fid,int mid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String author = "";

		try{
			String sql = "SELECT message_author "
					+ "FROM messages "
					+ "WHERE forum_id=? "
 					+ "AND thread_id=? "
					+ "AND message_id = "
					+ "( "
					+ "SELECT max(message_id) "
					+ "FROM messages "
					+ "WHERE forum_id=? "
 					+ "AND thread_id=? "
					+ ") ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setInt(3,fid);
			ps.setInt(4,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				author =rs.getString("message_author");
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getLastPostAuthor: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getLastPostAuthor: " + e.toString());
		}

		return author;
	}

	/**
	 * getViewCount
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int getViewCount(Connection conn,int fid) throws SQLException {

		int views = 0;

		try{
			String sql = "SELECT views FROM forums WHERE forum_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				views = NumericUtil.getInt(rs.getInt("views"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getViewCount: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getViewCount: " + e.toString());
		}

		return views;
	}

	/**
	 * updateViewCount
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	void
	 */
	public static void updateViewCount(Connection conn,int fid) throws SQLException {

		try{
			int views = getViewCount(conn,fid) + 1;

			String sql = "UPDATE forums SET views=? WHERE forum_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,views);
			ps.setInt(2,fid);
			ps.executeUpdate();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - updateViewCount: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - updateViewCount: " + e.toString());
		}

	}

	/**
	 * getReplies
	 * <p>
	 * @param	conn		Connection
	 * @param	author	String
	 * @param	fid		int
	 * <p>
	 * @return	int
	 */
	public static int getReplies(Connection conn,String author,int fid) throws SQLException {

		int replies = 0;

		try{
			String sql = "SELECT count(fid) AS counter "
					+ "FROM  messagesX "
					+ "WHERE fid=? "
					+ "and author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setString(2,author);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				replies = NumericUtil.getInt(rs.getInt("counter"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getReplies: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getReplies: " + e.toString());
		}

		return replies;
	}

	/**
	 * getLastPost
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * <p>
	 * @return	String
	 */
	public static String getLastPost(Connection conn,int fid) throws SQLException {

		String lastPost = "";

		try{
			String sql = "SELECT  message_author, message_timestamp "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND message_id= "
							+ "( "
							+ "SELECT MAX(message_id) "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ ") ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				AseUtil ae = new AseUtil();
				lastPost =  AseUtil.nullToBlank(rs.getString("message_author"))
								+ " - "
								+ ae.ASE_FormatDateTime(rs.getString("message_timestamp"),Constant.DATE_SHORT);
				ae = null;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getLastPost: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getLastPost: " + e.toString());
		}

		return lastPost;
	}

	/**
	 * getReplies
	 * <p>
	 * @param	conn		Connection
	 * @param	author	String
	 * @param	fid		int
	 * @param	mid		int
	 * <p>
	 * @return	int
	 */
	public static int getReplies(Connection conn,String author,int fid,int mid) throws SQLException {

		int replies = 0;

		try{
			String sql = "SELECT count(message_id) AS counter "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND thread_id=? "
							+ "AND message_author=? "
							+ "AND notified=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setString(3,author);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				replies = NumericUtil.getInt(rs.getInt("counter"),0);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getReplies: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getReplies: " + e.toString());
		}

		return replies;
	}

	/**
	 * isNotificationAvailable
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * <p>
	 * @return	boolean
	 */
	public static boolean isNotificationAvailable(Connection conn,int fid) throws SQLException {

		boolean messages = false;

		try{
			String sql = "SELECT count(message_id) AS counter "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND notified=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				if (rs.getInt("counter") > 0){
					messages = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isNotificationAvailable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isNotificationAvailable: " + e.toString());
		}

		return messages;
	}

	/**
	 * isNotificationAvailable
	 * <p>
	 * @param	conn		Connection
	 * @param	author	String
	 * @param	fid		int
	 * @param	mid		int
	 * <p>
	 * @return	boolean
	 */
	public static boolean isNotificationAvailable(Connection conn,String author,int fid,int mid) throws SQLException {

		boolean messages = false;

		try{
			String sql = "SELECT count(message_id) AS counter "
							+ "FROM messages "
							+ "WHERE forum_id=? "
							+ "AND thread_id=? "
							+ "AND message_author=? "
							+ "AND notified=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setString(3,author);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				if (rs.getInt("counter") > 0){
					messages = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isNotificationAvailable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isNotificationAvailable: " + e.toString());
		}

		return messages;
	}

	/**
	 * isReplyAvailable
	 * <p>
	 * @param	conn		Connection
	 * @param	author	String
	 * @param	fid		int
	 * @param	tp			int
	 * <p>
	 * @return	boolean
	 */
	public static boolean isReplyAvailable(Connection conn,String author,int fid,int tp) throws SQLException {

		boolean reply = false;

		try{
			// with the main or parent thread, figure out who
			// wrote and received notifications
			String sql = "SELECT count(fid) AS counter "
					+ "FROM  messagesX "
					+ "WHERE (fid=?) "
					+ "AND tp IN "
					+ "( "
					+ "select message_id "
					+ "from messages "
					+ "where thread_id=? "
					+ "and message_author=? "
					+ ") "
					+ "and author=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,tp);
			ps.setString(3,author);
			ps.setString(4,author);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				if (rs.getInt("counter") > 0){
					reply = true;
				}
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isReplyAvailable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isReplyAvailable: " + e.toString());
		}

		return reply;
	}

	/**
	 * setNotifyFlag
	 * <p>
	 * @param	conn				Connection
	 * @param	fid				int
	 * @param	mid				int
	 * @param	tp					int
	 * @param	tl					int
	 * @param	sfid				int
	 * @param	stp				int
	 * @param	stl				int
	 * @param	messageCampus	String
	 * <p>
	 */
	public static void setNotifyFlag(Connection conn,int fid,int mid,int tp,int tl,int sfid,int stp,int stl,String campus) throws Exception {

		// recursively read from the sent in fid, parent and level down until
		// we hit level 0. these are the messages with authors we have to
		// add to the table to notify them that new messages are available.

		// fid, tp and tl are altered going through recursively, while
		// sfid, stp, and stl are values passed along to be saved to the db
		// the s values are the ones we know indicate the new message id

		try{

			String sql = "select thread_parent, thread_level, message_author "
							+ "from messages WHERE forum_id=? AND message_id=? AND thread_level=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,tp);
			ps.setInt(3,tl-1);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				tp = NumericUtil.getInt(rs.getInt("thread_parent"),0);
				tl = NumericUtil.getInt(rs.getInt("thread_level"),0);
				String author = AseUtil.nullToBlank(rs.getString("message_author"));

				// there is an author
				if (!author.equals(Constant.BLANK) && !isMatch(conn,sfid,mid,stp,stl,author)){
					sql = "insert into messagesx values(?,?,?,?,?)";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,sfid);
					ps2.setInt(2,stp);
					ps2.setInt(3,mid);
					ps2.setInt(4,stl);
					ps2.setString(5,author);
					ps2.executeUpdate();
					ps2.close();

					/*
					create task - ER18
					*/
					String createTaskForMessageBoard =
							IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CreateTaskForMessageBoard");

					if (createTaskForMessageBoard.equals(Constant.ON)){

						if (author.equals("THANHG")){
							Forum forum = getForum(conn,sfid);
							if (forum != null){

								TaskDB.logTask(conn,"THANHG","THANHG","","",
													Constant.MESSAGE_BOARD_REPLY_TEXT,
													campus,
													"",
													Constant.TASK_ADD,
													"PRE",
													"",
													"",
													forum.getHistoryid(),
													"");

							} // forums
						} // task for THANHG

					} // createTaskForMessageBoard

				} // if author

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB: setNotifyFlag - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: setNotifyFlag - " + e.toString());
		}

	} // ForumDB: setNotifyFlag

	/**
	 * setNotifyFlag
	 * <p>
	 * @param	conn				Connection
	 * @param	fid				int
	 * @param	mid				int
	 * @param	tp					int
	 * @param	tl					int
	 * @param	sfid				int
	 * @param	stp				int
	 * @param	stl				int
	 * @param	messageCampus	String
	 * @param	user				String
	 * <p>
	 */
	public static void setNotifyFlag(Connection conn,int fid,int mid,int tp,int tl,int sfid,int stp,int stl,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try{

			// backtrack from this message until we reach level 1 of this post.
			// we want to let each person in this post know that a message was
			// just added.

			String sql = "select thread_parent,thread_level,message_author from messages "
							+ "WHERE forum_id=? AND message_id=? AND thread_level=? AND message_author<>? ";

			// subtract 1 because we are only checking on the previous level and back
			tl = tl-1;

			// do as long as level is valid
			if (tl > 0){

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setInt(2,tp);
				ps.setInt(3,tl);
				ps.setString(4,user);
				ResultSet rs = ps.executeQuery();

				while (rs.next()){
					tp = NumericUtil.getInt(rs.getInt("thread_parent"),0);
					String author = AseUtil.nullToBlank(rs.getString("message_author"));

					// there is an author
					if (!author.equals(Constant.BLANK) && !ForumDB.isMatch(conn,sfid,mid,stp,stl,author)){
						sql = "insert into messagesx values(?,?,?,?,?)";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setInt(1,sfid);
						ps2.setInt(2,stp);
						ps2.setInt(3,mid);
						ps2.setInt(4,stl);
						ps2.setString(5,author);
						ps2.executeUpdate();
						ps2.close();

					} // if author

				} // while

				rs.close();
				ps.close();

				setNotifyFlag(conn,fid,mid,tp,tl,sfid,stp,stl,campus,user);
			} // if tl

		}
		catch(SQLException e){
			logger.fatal("ForumDB: setNotifyFlag - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: setNotifyFlag - " + e.toString());
		}

	} // ForumDB: setNotifyFlag

	/*
	 * setProcessed - set notified flag to on or off
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	fid	int
	 *	@param	tp		int
	 *	@param	mid	int
	 *	@param	tl		int
	 *	@param	user	String
	 *	<p>
	 *	@return int
	 */
	public static int setProcessed(Connection conn,int fid,int tp,int mid,int tl,String user) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM messagesX WHERE fid=? AND tp=? AND mid=? AND tl=? AND author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,tp);
			ps.setInt(3,mid);
			ps.setInt(4,tl);
			ps.setString(5,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: setProcessed - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB: setProcessed - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getLegend
	 *	<p>
	 *	<p>
	 *	@return String
	 */
	public static String getLegend() throws SQLException {

		return ("<p>&nbsp;</p>"
				+ "<p align=\"left\">"
				+ "<h3 class=\"goldhighlightsbold\">Icon Legend</h3>"
				+ "<table width=\"100%\" cellspacing=\"1\" cellpadding=\"4\">"
				+ "<tbody>"
				+ "<tr>"
				+ "<td width=\"06%\"><img src=\"./images/legend.png\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">go to board listing</td>"
				+ "<td width=\"06%\"><img src=\"../../images/ed_list_num.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">go to post listing</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td><img src=\"./images/icon_post_message.png\" border=\"0\" alt=\"new post\" title=\"new post\"></td>"
				+ "<td width=\"44%\" align=\"left\">new post</td>"
				+ "<td><img src=\"../../images/viewcourse.gif\" border=\"0\" alt=\"view replies\" title=\"view replies\"></td>"
				+ "<td width=\"44%\" align=\"left\">view replies</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td><img src=\"../images/message1.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">posted message</td>"
				+ "<td><img src=\"./images/new.png\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">new replies</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td><img src=\"./images/reply.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">reply to a post</td>"
				+ "<td><img src=\"./images/close_door.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">close post or board</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td><img src=\"../../images/printer.jpg\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">printer friendly</td>"
				+ "<td width=\"06%\"><img src=\"../../images/ed_list_bullet.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">view item index</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td width=\"06%\"><img src=\"../../images/compare.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">view content</td>"
				+ "<td width=\"06%\"><img src=\"../../images/back.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">resume work</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td width=\"06%\"><img src=\"../../images/edit.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">edit post</td>"
				+ "<td width=\"06%\"><img src=\"./images/dd_arrow.gif\" border=\"0\">&nbsp;&nbsp;<img src=\"./images/du_arrow.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">hide/show posts</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td width=\"06%\"><img src=\"../../images/del.gif\" border=\"0\"></td>"
				+ "<td width=\"44%\" align=\"left\">delete post</td>"
				+ "<td width=\"06%\">&nbsp;</td>"
				+ "<td width=\"44%\" align=\"left\">&nbsp;</td>"
				+ "</tr>"
				+ "</tbody>"
				+ "</table>"
				+ "</p>");

	}

	/*
	 * getBoardMembers
	 *	<p>
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getBoardMembers(Connection conn,int fid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

            genericData = new LinkedList<Generic>();

				String sql = "SELECT userid FROM forumsx WHERE fid=? ORDER BY user";

				//
				// connect forumsx to messages table by user id and count number of
				// messages posted by authors
				//
				sql = "SELECT fx.userid, tbl.postings "
					+ "FROM forumsx fx LEFT OUTER JOIN "
					+ "("
					+ "SELECT message_author, COUNT(message_id) AS postings FROM messages m "
					+ "WHERE thread_parent > 0 "
					+ "GROUP BY message_author, forum_id "
					+ "HAVING forum_id=?"
					+ ") AS tbl ON fx.userid = tbl.message_author "
					+ "WHERE fx.fid=? ORDER BY USER";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setInt(2,fid);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("userid")),
											AseUtil.nullToBlank(rs.getString("postings")),
											"",
											"",
											"",
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getBoardMembers: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("ForumDB - getBoardMembers: " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * isForumClosed
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	boolean
	 */
	public static boolean isForumClosed(Connection conn,int fid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean closed = false;

		try{
			String sql = "SELECT forum_id FROM forums WHERE forum_id=? AND status='Closed'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				closed = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isForumClosed: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isForumClosed: " + e.toString());
		}

		return closed;
	}

	/**
	 * isPostClosedFidMidItem
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * @param	item
	 * <p>
	 * @return	boolean
	 */
	public static boolean isPostClosedFidMidItem(Connection conn,int fid,int mid,int item) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean closed = false;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND message_id=? AND item=? AND closed=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ps.setInt(3,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				closed = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isPostClosedFidMidItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isPostClosedFidMidItem: " + e.toString());
		}

		return closed;
	}

	/**
	 * isPostClosedFidItem
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	item
	 * <p>
	 * @return	boolean
	 */
	public static boolean isPostClosedFidItem(Connection conn,int fid,int item) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean closed = false;

		try{
			String sql = "SELECT message_id FROM messages WHERE forum_id=? AND item=? AND thread_parent=0 AND closed=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				closed = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isPostClosedFidItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isPostClosedFidItem: " + e.toString());
		}

		return closed;
	}

	/**
	 * isPostClosed
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * <p>
	 * @return	boolean
	 */
	public static boolean isPostClosed(Connection conn,int fid,int mid) throws SQLException {

		boolean closed = false;

		try{
			String sql = "SELECT closed FROM messages WHERE forum_id=? AND thread_id=? AND thread_parent=0 AND closed=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				closed = true;
			}

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - isPostClosed: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - isPostClosed: " + e.toString());
		}

		return closed;
	}

	/**
	 * getReplyCount - returns the count of replies from other users
	 * <p>
	 * @param	conn
	 * @param	user
	 * <p>
	 * @return	int
	 */
	public static int getReplyCount(Connection conn,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "SELECT COUNT(fid) FROM messagesx WHERE author=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				rowsAffected = rs.getInt(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getReplyCount - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: getReplyCount - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getReplyCount - returns the count of replies from other users
	 * <p>
	 * @param	conn
	 * @param	user
	 * @param	fid
	 * <p>
	 * @return	int
	 */
	public static int getReplyCount(Connection conn,String user,int fid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "SELECT COUNT(fid) FROM messagesx WHERE author=? AND fid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setInt(2,fid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				rowsAffected = rs.getInt(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getReplyCount - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: getReplyCount - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getForumSource - count of direct posts to top level forum
	 * <p>
	 * @param	conn
	 * @param	fid
	 * <p>
	 * @return	String
	 */
	public static String getForumSource(Connection conn,int fid) throws SQLException {

		String src = "";

		try{
			String sql = "SELECT src FROM forums WHERE forum_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				src = AseUtil.nullToBlank(rs.getString("src"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getForumSource: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getForumSource: " + e.toString());
		}

		return src;
	}

	/**
	 * canUserEditPost - is this post editable
	 * <p>
	 * @param	conn			Connection
	 * @param	user			String
	 * @param	author		String
	 * @param	kix			String
	 * @param	processed	int
	 * @param	notified		int
	 * @param	mid			int
	 * <p>
	 * @return	boolean
	 * <p>
	 */
	public static boolean canUserEditPost(Connection conn,
															String user,
															String author,
															String kix,
															int processed,
															int notified,
															int fid,
															int mid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean canEdit = true;

		try{

			String proposer = "";
			String progress = "";

			String[] info = Helper.getKixInfo(conn,kix);
			if (info != null){
				proposer = info[Constant.KIX_PROPOSER];
				progress = info[Constant.KIX_PROGRESS];
			}

			boolean canUserReply = Board.isMatchMessagesX(conn,fid,mid,user);

			// if -- users are allowed to post as long as the proposer is not modifying
			// if/else -- once processed, don't allow posting by author
			if (progress.equals(Constant.COURSE_MODIFY_TEXT) || progress.equals(Constant.COURSE_APPROVAL_TEXT)){

				if (!user.equals(proposer)){
					canEdit = false;
				}
				else if (user.equals(proposer) && processed > 0 && notified > 0 && !canUserReply){
					canEdit = false;
				}

			}
			else if (processed > 0){
				canEdit = false;
			}

		}
		catch(Exception e){
			logger.fatal("ForumDB: canUserEditPost - " + e.toString());
		}

		return canEdit;

	} // ForumDB: canUserEditPost

	/*
	 * insertReviewNoFid
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * @param	tab		String
	 * @param	mode		int
	 * @param	item		int
	 *	<p>
	 *	@return int[]
	 */
	public static int[] insertReviewNoFid(Connection conn,String campus,String user,String kix,String tab,int mode,int item) throws Exception {

		int rowsAffected = 0;

		int fid = 0;
		int mid = 0;

		int[] forum = new int[2];
		forum[0] = fid;
		forum[1] = mid;

		try{

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			boolean isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

			fid = ForumDB.getForumID(conn,campus,kix);
			if (fid == 0){

				String[] info = null;
				if(isFoundation){
					info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
				}
				else{
					info = Helper.getKixInfo(conn,kix);
				}

				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];

				String forumName = alpha + " " + num;

				String forumDescr = "";
				if(isFoundation){
					forumDescr = info[Constant.KIX_COURSETITLE];
				}
				else{
					forumDescr = CourseDB.getCourseDescription(conn,alpha,num,campus);
				}

				Review reviewDB = new Review();
				reviewDB.setId(0);
				reviewDB.setUser(user);
				reviewDB.setAlpha(alpha);
				reviewDB.setNum(num);
				reviewDB.setHistory(kix);
				reviewDB.setComments("");

				if (isAProgram){
					reviewDB.setItem(item);
				}
				else if (isFoundation){
					reviewDB.setItem(item);
				}
				else{
					reviewDB.setItem(QuestionDB.getQuestionNumber(conn,campus,NumericUtil.getInt(tab,0),item));
				}

				reviewDB.setCampus(campus);
				reviewDB.setEnable(true);
				reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
				rowsAffected = ReviewDB.insertReview(conn,reviewDB,tab,mode);
				reviewDB = null;

				fid = ForumDB.getForumID(conn,campus,kix);
				mid = ForumDB.getTopLevelPostingMessage(conn,fid,item);

				forum[0] = fid;
				forum[1] = mid;
			}
		}
		catch(SQLException e){
			logger.fatal("ForumDB - insertReviewNoFid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - insertReviewNoFid: " + e.toString());
		}

		return forum;

	}

	/*
	 * insertReviewNoMid
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * @param	fid		int
	 * @param	mode		int
	 * @param	item		int
	 *	<p>
	 *	@return int
	 */
	public static int insertReviewNoMid(Connection conn,
														String campus,
														String user,
														String kix,
														int fid,
														int mode,
														int item) throws Exception {

		int mid = 0;

		try{

			String src = Constant.COURSE;

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			boolean isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

			if (isAProgram){
				src = Constant.PROGRAM;
			}
			else if (isFoundation){
				src = Constant.FOUNDATION;
			}

			String[] info = null;
			if(isFoundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
			}

			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			ForumDB.createFirstMessage(conn,user,
												new Forum(fid,
															campus,
															kix,
															item,
															user,
															user,
															alpha + " " + num,
															CourseDB.getCourseDescription(conn,alpha,num,campus),
															AseUtil.getCurrentDateTimeString(),
															"",
															src),
												"",
												mode);

			mid = ForumDB.getTopLevelPostingMessage(conn,fid,item);

		}
		catch(SQLException e){
			logger.fatal("ForumDB - insertReviewNoMid: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - insertReviewNoMid: " + e.toString());
		}

		return mid;

	}

	/*
	 * createMessageBoard
	 *	<p>
	 * @param	conn	Connection
	 * @param	campus	String
	 * @param	user	String
	 * @param	kix	String
	 */
	public static int createMessageBoard(Connection conn,String campus,String user,String kix){

		//Logger logger = Logger.getLogger("test");

		int forumID = 0;

		try{

			String grouping = "course";

			String sql = "SELECT campus,proposer,coursealpha,coursenum,coursetitle,dateproposed "
							+ "FROM tblCourse WHERE historyid=?";

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();
			boolean foundation = fnd.isFoundation(conn,kix);
			fnd = null;

			if(foundation){
				sql = "SELECT campus,proposer,coursealpha,coursenum,coursetitle, '' as dateproposed "
						+ "FROM tblfnd WHERE historyid=?";
				grouping = "foundation";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				forumID = ForumDB.getNextForumID(conn);

				PreparedStatement ps2 = null;

				int rowsAffected = 0;

				if (!ForumDB.isMatch(conn,campus,kix)){
					sql = "INSERT INTO forums(forum_id,campus, historyid, creator, requestor, forum_name, forum_description, forum_start_date, forum_grouping, src, counter, status, priority, auditdate, createddate, auditby) "
						+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,forumID);
					ps2.setString(2,campus);
					ps2.setString(3,kix);
					ps2.setString(4,user);
					ps2.setString(5,user);
					ps2.setString(6,AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")));
					ps2.setString(7,AseUtil.nullToBlank(rs.getString("coursetitle")));
					ps2.setString(8,AseUtil.getCurrentDateTimeString());
					ps2.setString(9,grouping);
					ps2.setString(10,grouping);
					ps2.setInt(11,1);
					ps2.setString(12,"Requirements");
					ps2.setInt(13,0);
					ps2.setString(14,AseUtil.getCurrentDateTimeString());
					ps2.setString(15,AseUtil.getCurrentDateTimeString());
					ps2.setString(16,user);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				} // match

			} // if

			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - createMessageBoard: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - createMessageBoard: " + e.toString());
		}

		return forumID;

	}

	/**
	 * deleteForum
	 * <p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * <p>
	 * @return	int
	 */
	public static int deleteForum(Connection conn,int fid) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (fid > 0){
				// closing the main board also deletes pending messages
				String sql = "DELETE FROM messagesx WHERE fid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// closing the main board closes all postings as well.
				sql = "DELETE FROM messages WHERE forum_id=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// closing the main board also deletes members
				sql = "DELETE FROM forumsx WHERE fid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// delete forum
				sql = "DELETE FROM forums WHERE forum_id=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				rowsAffected = ps.executeUpdate();
				ps.close();

			} // fid
		} catch (SQLException e) {
			logger.fatal("ForumDB: deleteForum - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: deleteForum - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getMessageThreadParent
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * <p>
	 * @return	int
	 */
	public static int getMessageThreadParent(Connection conn,int fid,int mid) {

		//Logger logger = Logger.getLogger("test");

		int threadParent = 0;

		try {
			String sql = "SELECT thread_parent FROM messages WHERE forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				threadParent = rs.getInt(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ForumDB: getMessageThreadParent - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: getMessageThreadParent - " + e.toString());
		}

		return threadParent;
	}

	/**
	 * setCreator
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	item
	 * @param	user
	 * <p>
	 * @return	int
	 */
	public static int setCreator(Connection conn,int fid,int item,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "UPDATE messages SET message_author=?,closed=0 WHERE forum_id=? AND item=? AND thread_parent=0";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setInt(2,fid);
			ps.setInt(3,item);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - setCreator: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - setCreator: " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * countPostsToForum - count of direct posts to top level forum
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	user
	 * <p>
	 * @return	int
	 */
	public static int countPostsToForumByUser(Connection conn,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int posts = 0;

		try{
			String sql = "SELECT COUNT(f.forum_id) AS counter "
							+ "FROM forums AS f INNER JOIN messages AS m ON f.forum_id = m.forum_id "
							+ "WHERE f.historyid=? AND m.message_author=? AND m.acktion=3 AND m.thread_parent > 0";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				posts = NumericUtil.getInt(rs.getInt("counter"),0);
			} // if next
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countPostsToForumByUser: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countPostsToForumByUser: " + e.toString());
		}

		return posts;
	}

	/*
	 * getMessageItem
	 *	<p>
	 * @param	conn		Connection
	 * @param	fid		int
	 * @param	mid		int
	 * @param	column	int
	 *	<p>
	 *	@return int
	 */
	public static String getMessageItem(Connection conn,int fid, int mid, String column) throws Exception {

		String item = "";

		try{
			PreparedStatement ps = conn.prepareStatement("SELECT " + column + " FROM messages WHERE forum_id=? AND message_id=?");
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - getMessageItem: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - getMessageItem: " + e.toString());
		}


		return item;
	}

	/**
	 * deletePost
	 * <p>
	 * @param	conn
	 * @param	fid
	 * @param	mid
	 * @param	itm
	 * <p>
	 * @return	int
	 */
	public static int deletePost(Connection conn,int fid,int mid,int itm) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if(fid > 0 && mid > 0 && itm > 0){
				String sql = "DELETE FROM messages WHERE forum_id=? and message_id=? and item=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,fid);
				ps.setInt(2,mid);
				ps.setInt(3,itm);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("ForumDB: deletePost - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB: deletePost - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * countPostsToForum - count of direct posts to top level forum
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	item
	 * <p>
	 * @return	int
	 */
	public static int countPostsToForum(Connection conn,String kix,int sq,int en,int qn) throws SQLException {

		int posts = 0;

		try{
			String sql = "";

			if(sq == 0 && en == 0 && qn == 0){
				sql = "SELECT SUM(counter) AS sum_counter "
							+ "FROM( "
							+ "SELECT COUNT(messages.item) AS counter "
							+ "FROM messages INNER JOIN "
							+ "forums ON messages.forum_id = forums.forum_id "
							+ "GROUP BY messages.item, forums.historyid, messages.thread_parent "
							+ "HAVING forums.historyid=? AND messages.thread_parent > 0 "
							+ ") AS Test";
			}
			else{
				sql = "SELECT SUM(counter) AS sum_counter "
							+ "FROM( "
							+ "SELECT COUNT(messages.item) AS counter, messages.sq, messages.en, messages.qn "
							+ "FROM messages INNER JOIN "
							+ "forums ON messages.forum_id = forums.forum_id "
							+ "GROUP BY messages.item, forums.historyid, messages.thread_parent, messages.sq, messages.en, messages.qn "
							+ "HAVING forums.historyid=? AND messages.thread_parent > 0 AND (messages.sq = ?) AND (messages.en = ?) AND (messages.qn = ?) "
							+ ") AS Test";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);

			if(sq == 0 && en == 0 && qn == 0){
				//
			}
			else{
				ps.setInt(2,sq);
				ps.setInt(3,en);
				ps.setInt(4,qn);
			}

			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				posts = rs.getInt("sum_counter");

				// when working with outlines, the first post is not counted. the root or thread = 0
				// is designated as the post created by the proposer to maintain level consistency
				if (getForumSource(conn,getForumID(conn,kix)).equals(Constant.COURSE) && posts > 0){
					--posts;
				}

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ForumDB - countPostsToForum: " + e.toString());
		}

		return posts;
	}


	/*
	 * getQuestionFromMid
	 * <p>
	 * @param	conn		Connection
	 * @param	mid		int
	 * <p>
	 * @return 	String
	 */
	public static String getQuestionFromMid(Connection conn,String fndType,int fid,int mid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String rtn = "";

		try {
			String sql = "SELECT sq,en,qn FROM messages WHERE forum_id=? AND message_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,fid);
			ps.setInt(2,mid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				int sq = rs.getInt("sq");
				int en = rs.getInt("en");
				int qn = rs.getInt("qn");

				rtn = com.ase.aseutil.fnd.FndDB.getFoundations(conn,fndType,sq,en,qn);
			} // if
			rs.close();
			ps.close();


		} catch (SQLException e) {
			logger.fatal("ForumDB.getQuestionFromMid - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ForumDB.getQuestionFromMid - " + e.toString());
		}

		return rtn;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}
