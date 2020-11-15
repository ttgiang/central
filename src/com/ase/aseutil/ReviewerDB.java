/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
**/

//
// ReviewerDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class ReviewerDB {
	static Logger logger = Logger.getLogger(ReviewerDB.class.getName());

	public ReviewerDB() throws Exception {}

	/*
	 * getReviewHistory
	 *	<p>
	 *	@param connection	Connection
	 *	@param kix			String
	 *	@param item			int
	 *	@param campus		String
	 *	@param source		int
	 *	@param acktion		int
	 *	<p>
	 *	@return String
	 */
	public static String getReviewHistory(Connection conn,String kix,int item,String campus,int source,int acktion) throws Exception {

		StringBuffer buf = new StringBuffer();

		buf.append(getReviewHistory2(conn,kix,item,campus,source,Constant.REVIEW,"h0","c0")
				+ getReviewHistory2(conn,kix,item,campus,source,Constant.APPROVAL,"h1","c1")
				+ getReviewHistory2(conn,kix,item,campus,source,Constant.REVIEW_IN_APPROVAL,"h2","c2"));

		return buf.toString();
	}

	public static String getReviewHistory2(Connection conn,String hid,int item,String campus,int source,int acktion) throws Exception {

		return getReviewHistory2(conn,hid,item,campus,source,acktion,"","");
	}

	public static String getReviewHistory2(Connection conn,
														String hid,
														int item,
														String campus,
														int source,
														int acktion,
														String Headerindex,
														String contentIndex) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String sql = "";
		String qn = "";
		String src = "";
		String commentType = "";
		StringBuffer review = new StringBuffer();

		int counter = 0;
		int seq = 0;
		int pid = 0;
		int savedSeq = -1;
		int courseItemCounter = 0;

		PreparedStatement ps = null;

		AseUtil aseUtil = new AseUtil();

		try {

			boolean isAProgram = ProgramsDB.isAProgram(conn,campus,hid);

			if (!isAProgram){
				// this number is added to the sequence number to adjust for campus questions
				courseItemCounter = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			}

			review.append("<table border=\"0\" cellpadding=\"1\" width=\"98%\">");

			sql = "SELECT reviewer, dte, source, comments, seq, question ";
			sql = createSQL(sql,item,source,acktion);
			sql = sql + "ORDER BY source, seq, dte";
			ps = conn.prepareStatement(sql);
			ps.setString(++pid,hid);

			if (item > 0)
				ps.setInt(++pid,item);

			if (source > 0)
				ps.setInt(++pid,source);

			if (acktion > 0)
				ps.setInt(++pid,acktion);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("seq");
				src = AseUtil.nullToBlank(rs.getString("source"));
				qn = AseUtil.nullToBlank(rs.getString("question"));

				if (seq != savedSeq){
					savedSeq = seq;

					if (src.equals("2"))
						seq = seq + courseItemCounter;

					review.append( "<tr class=\"fieldhighlight\"><td valign=top class=textblackth>" + seq + ". " + qn + "</td></tr>" );
				}

				review.append( "<tr class=\"rowhighlight\"><td valign=top class=datacolumn>"
					+ rs.getString("reviewer").trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				review.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString("comments").trim()
					+ "</td></tr>" );

				++counter;
			}

			if (savedSeq==-1)
				review.append( "<tr><td valign=top>Data not found</td></tr>" );

			rs.close();
			ps.close();

			review.append("</table>");

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewHistory - " + e.toString());
		}

		if (acktion==Constant.REVIEW)
			commentType = "Reviewer comments";
		else if (acktion==Constant.APPROVAL)
			commentType = "Approval comments";
		else if (acktion==Constant.REVIEW_IN_APPROVAL)
			commentType = "Review within approval comments";

		temp = "<div class=\"technology closedlanguage\" headerindex=\"0h\">  " + commentType + " (" + counter + ")</div>"
				+ "<div class=\"thelanguage\" contentindex=\"0c\" style=\"display: none; \">  " + review.toString() + "</div>";

		return temp;
	}

	public static String getReviewHistory2JQuery(Connection conn,
														String hid,
														int item,
														String campus,
														int source,
														int acktion,
														String Headerindex,
														String contentIndex) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String sql = "";
		String qn = "";
		String src = "";
		String commentType = "";
		StringBuffer review = new StringBuffer();

		int counter = 0;
		int seq = 0;
		int pid = 0;
		int savedSeq = -1;
		int courseItemCounter = 0;

		PreparedStatement ps = null;

		AseUtil aseUtil = new AseUtil();

		try {

			boolean isAProgram = ProgramsDB.isAProgram(conn,campus,hid);

			if (!isAProgram){
				// this number is added to the sequence number to adjust for campus questions
				courseItemCounter = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			}

			review.append("<table border=\"0\" cellpadding=\"1\" width=\"98%\">");

			sql = "SELECT reviewer, dte, source, comments, seq, question ";
			sql = createSQL(sql,item,source,acktion);
			sql = sql + "ORDER BY source, seq, dte";
			ps = conn.prepareStatement(sql);
			ps.setString(++pid,hid);

			if (item > 0)
				ps.setInt(++pid,item);

			if (source > 0)
				ps.setInt(++pid,source);

			if (acktion > 0)
				ps.setInt(++pid,acktion);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("seq");
				src = AseUtil.nullToBlank(rs.getString("source"));
				qn = AseUtil.nullToBlank(rs.getString("question"));

				if (seq != savedSeq){
					savedSeq = seq;

					if (src.equals("2"))
						seq = seq + courseItemCounter;

					review.append( "<tr class=\"fieldhighlight\"><td valign=top class=textblackth>" + seq + ". " + qn + "</td></tr>" );
				}

				review.append( "<tr class=\"rowhighlight\"><td valign=top class=datacolumn>"
					+ rs.getString("reviewer").trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				review.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString("comments").trim()
					+ "</td></tr>" );

				++counter;
			}

			if (savedSeq==-1)
				review.append( "<tr><td valign=top>Data not found</td></tr>" );

			rs.close();
			ps.close();

			review.append("</table>");

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewHistory - " + e.toString());
		}

		if (acktion==Constant.REVIEW)
			commentType = "<h3><a href=\"#\">Reviewer comments "+" (" + counter + ")"+"</a></h3>";
		else if (acktion==Constant.APPROVAL)
			commentType =  "<h3><a href=\"#\">Approval comments "+" (" + counter + ")"+"</a></h3>";
		else if (acktion==Constant.REVIEW_IN_APPROVAL)
			commentType =  "<h3><a href=\"#\">Review within approval comments "+" (" + counter + ")"+"</a></h3>";

		temp = commentType + "<div>" + review.toString() + "</div>";

		return temp;
	}

	/**
	 * Count active reviews
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * <p>
	 * @return long
	 */
	public static long countActiveReviews(Connection conn,String kix) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;

		try {
			String sql = "SELECT count(historyid) FROM tblReviewHist WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = rs.getLong(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ReviewerDB: countActiveReviews - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: countActiveReviews - " + e.toString());
		}

		return lRecords;
	}

	/**
	 * Count number of reviewer comments for each item
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * @param item		int
	 * @param source	int	(tab is course or campus)
	 * @param acktion	int
	 * <p>
	 * @return long
	 */
	public static long countComments(Connection conn,String kix,int item,int source,int acktion) throws java.sql.SQLException {

		return countReviewerComments(conn,kix,item,source,acktion);
	}

	/**
	 * Count number of reviewer comments for each item
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * @param item		int
	 * @param source	int	(tab is course or campus)
	 * @param acktion	int
	 * <p>
	 * @return long
	 */
	public static long countReviewerComments(Connection conn,String kix,int item,int source,int acktion) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;
		int pid = 0;
		String sql = "";
		PreparedStatement ps = null;

		try {
			sql = "SELECT count(historyid) ";
			sql = createSQL(sql,item,source,acktion);
			ps = conn.prepareStatement(sql);
			ps.setString(++pid,kix);

			if (item > 0){
				ps.setInt(++pid,item);
			}

			if (source > 0){
				ps.setInt(++pid,source);
			}

			if (acktion > 0){
				ps.setInt(++pid,acktion);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = NumericUtil.getLong(rs.getLong(1),0);
			}

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ReviewerDB: countReviewerComments - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: countReviewerComments - " + e.toString());
		}

		return lRecords;
	}

	public static long countReviewerComments2(Connection conn,String kix,int item,int source,int acktion)
		throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		/*
			this is another way to get the count we need. the problem with the above approach
			is the way UNION workds. By design, UNION does a SELECT DISINCT. During test,
			when identical input comments are used, a select distinct would only return 1 of all
			identical records. This is misleading since that's not what we want.

			However, it is not likely that identical comments are entered so we'll rely on the above
			version. This version is another way to do it.
		*/

		long lRecords = 0;
		String where = "";
		String sql = "";
		String action = " AND acktion="+acktion;

		try {
			sql = "WHERE historyid='"+kix+"' AND item="+item;

			if (acktion > 0)
				sql = sql + " AND acktion="+acktion;

			sql = sql + " AND source=";

			where = sql + source;
			lRecords = AseUtil.countRecords(conn,"tblReviewHist",where);

			where = sql + source;
			lRecords += AseUtil.countRecords(conn,"tblReviewHist2",where);
		} catch (SQLException se) {
			logger.fatal("ReviewerDB: countReviewerComments - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: countReviewerComments - " + e.toString());
		}

		return lRecords;
	}

	/**
	 * Count number of reviewer comments for entire kix
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * <p>
	 * @return long
	 */
	public static long countComments(Connection conn,String kix) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT count(historyid) FROM vw_ReviewerHistory WHERE historyid=?");
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = rs.getLong(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ReviewerDB: countComments - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: countComments - " + e.toString());
		}

		return lRecords;
	}

	/**
	 * Count number of reviewer comments for each item
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * @param seq		int
	 * @param source	int
	 * @param acktion	int
	 * <p>
	 * @return long
	 */
	public static long countReviewerCommentsBySeq(Connection conn,String kix,int seq,int source,int acktion) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;
		int pid = 0;
		String sql = "";

		try {
			sql = "SELECT count(historyid) FROM vw_ReviewerHistory WHERE historyid=? AND seq=? ";

			if (source > 0){
				sql = sql + "AND source=? ";
			}

			if (acktion > 0){
				sql = sql + "AND acktion=? ";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(++pid,kix);
			ps.setInt(++pid,seq);

			if (source > 0){
				ps.setInt(++pid,source);
			}

			if (acktion > 0){
				ps.setInt(++pid,acktion);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = rs.getLong(1);
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			kix = "kix: " + kix + "; seq: " + seq + "; " + source + "; " + acktion;
			logger.fatal("ReviewerDB: countReviewerCommentsBySeq ("+kix+"): " + e.toString());
		} catch (Exception e) {
			kix = "kix: " + kix + "; seq: " + seq + "; " + source + "; " + acktion;
			logger.fatal("ReviewerDB: countReviewerCommentsBySeq ("+kix+"): " + e.toString());
		}

		return lRecords;
	}

	/**
	 * createSQL - used for countReviewerComments and getReviewHistory
	 *					to keep SQL statement consistent
	 * <p>
	 * @param sql		String
	 * @param item		int
	 * @param source	int
	 * @param acktion	int
	 * <p>
	 * @return String
	 */
	public static String createSQL(String sql,int item,int source,int acktion) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		try {
			sql = sql + "FROM vw_ReviewerHistory WHERE historyid=? ";

			if (item > 0)
				sql = sql + "AND item=? ";

			if (source > 0)
				sql = sql + "AND source=? ";

			if (acktion > 0)
				sql = sql + "AND acktion=? ";

		} catch (Exception e) {
			logger.fatal("ReviewerDB: countReviewerComments - " + e.toString());
		}

		return sql;
	}

	/*
	 * getReviewerNames
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return String
	 */
	public static String getReviewerNames(Connection conn,String campus,String alpha,String num) throws Exception {

		return getReviewerNames(conn,campus,alpha,num,"",1);

	}

	public static String getReviewerNames(Connection conn,String campus,String alpha,String num,String inviter,int level) throws Exception {

		return getReviewerNames(conn,campus,alpha,num,"",1,"");

	}

	public static String getReviewerNames(Connection conn,String campus,String alpha,String num,String inviter,int level,String kix) throws Exception {

		// REVIEW_DEBUG_01

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();

		String junk = "";

		boolean debug = false;

		int first = 0;

		try {

			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("----------------------------------");
				logger.info("getReviewerNames - REVIEW_DEBUG_01");
				logger.info("----------------------------------");
			}

			boolean foundation = false;

			//
			//
			//
			if(kix.equals(Constant.BLANK)){
				kix = Helper.getKix(conn,campus,alpha,num,"PRE");
			}

			//
			// still blank?
			//
			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();
			if(kix.equals(Constant.BLANK)){
				kix = fnd.getKix(conn,campus,alpha,num,"PRE");
				if(!kix.equals(Constant.BLANK)){
					foundation = true;
				}
			}

			if(debug){
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("level: " + level);
				logger.info("inviter: " + inviter);
				logger.info("junk: " + junk);
				logger.info("foundation: " + foundation);
			}

			String sql = "";
			PreparedStatement ps = null;

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means to get all
			//
			if(level == 0){
				level = 1;
			}

			//
			// we don't have the name of the inviter when reviewing in approval so
			// we return them all
			//
			boolean includeInviter = true;

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else{
					inviter = ReviewerDB.getReviewInviter(conn,campus,kix);

					if(inviter == null || inviter.equals(Constant.BLANK)){
						includeInviter = false;
					}

				}
			}
			else if(inviter == null || inviter.equals(Constant.BLANK)){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else{
					inviter = "";
					includeInviter = false;
				}
			}

			if(level==99){
				sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? ORDER BY userid";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
			}
			else{
				if(includeInviter){
					sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND level=? AND inviter=? ORDER BY userid";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setInt(3,level);
					ps.setString(4,inviter);
				}
				else{
					if(level > 1){
						sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND level=? ORDER BY userid";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setInt(3,level);
					}
					else{
						sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? ORDER BY userid";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
				}
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (first==0){
					reviewers.append(AseUtil.nullToBlank(rs.getString(1)));
				}
				else{
					reviewers.append("," + AseUtil.nullToBlank(rs.getString(1)));
				}

				++first;
			}
			rs.close();
			ps.close();

			junk = reviewers.toString();
			if(junk != null && junk.length() > 0){
				junk = Util.removeDuplicateFromString(reviewers.toString());
			}

			fnd = null;

		} catch (SQLException se) {
			logger.fatal("ReviewerDB: getReviewerNames: " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewerNames: " + e.toString());
		}

		return junk;
	}

	/*
	 * getReviewerNames
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String
	 */
	public static String getReviewerNames(Connection conn,String campus,String kix) throws Exception {

		// REVIEW_DEBUG_02

		String proposer = "";

		if(com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix)){
			proposer = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
		}
		else{
			proposer = getReviewInviter(conn,campus,kix);
		}

		return getReviewerNames(conn,campus,kix,proposer,1);

	}

	public static String getReviewerNames(Connection conn,String campus,String kix,String inviter,int level) throws Exception {

		// REVIEW_DEBUG_03

		String temp = "";

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("----------------------------------");
				logger.info("getReviewerNames - REVIEW_DEBUG_03");
				logger.info("----------------------------------");
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means to get all
			//
			if(level == 0){
				level = 1;
			}

			boolean foundation = false;

			boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);
			if(!isAProgram){
				foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){

				if(foundation){
					inviter = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
				}
				else if(isAProgram){
					inviter = ProgramsDB.getItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			if(debug){
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("level: " + level);
				logger.info("inviter: " + inviter);
				logger.info("foundation: " + foundation);
				logger.info("isAProgram: " + isAProgram);
			}

			String[] info = null;
			String alpha = "";
			String num = "";

			if(foundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
			}
			else if(isAProgram){
				info = Helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_PROGRAM_TITLE];
			}
			else{
				info = Helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
			}

			temp = getReviewerNames(conn,campus,alpha,num,inviter,level,kix);

		} catch (SQLException se) {
			logger.fatal("ReviewerDB: getReviewerNames: " + se.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewerNames: " + e.toString());
			return null;
		}

		return temp;
	}

	/*
	 * getReviewerNames
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 *	<p>
	 * @return String
	 */
	public static String getReviewerNames(Connection conn,String kix) throws Exception {

		// REVIEW_DEBUG_04

		boolean foundation = false;

		boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
		if(!isAProgram){
			foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
		}

		String[] info = null;
		String campus = "";

		if(foundation){
			info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
		}
		else if(isAProgram){
			info = Helper.getKixInfo(conn,kix);
		}
		else{
			info = Helper.getKixInfo(conn,kix);
		}

		if(info != null){
			campus = info[Constant.KIX_CAMPUS];
		}

		return getReviewerNames(conn,kix,getReviewInviter(conn,campus,kix),1);

	}

	/*
	 * getReviewerNames
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	inviter	String
	 * @param	level		int
	 *	<p>
	 * @return String
	 */
	public static String getReviewerNames(Connection conn,String kix,String inviter,int level) throws Exception {

		// REVIEW_DEBUG_05

		String temp;

		try {

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means to get all
			//
			if(level == 0){
				level = 1;
			}

			boolean foundation = false;

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			if(!isAProgram){
				foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
			}

			String[] info = null;
			String alpha = "";
			String num = "";
			String campus = "";

			if(foundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
				campus = info[Constant.KIX_CAMPUS];
			}
			else if(isAProgram){
				info = Helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_PROGRAM_TITLE];
				campus = info[Constant.KIX_CAMPUS];
			}
			else{
				info = Helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
				campus = info[Constant.KIX_CAMPUS];
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
				}
				else if(isAProgram){
					inviter = ProgramsDB.getItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			temp = getReviewerNames(conn,campus,alpha,num,inviter,level,kix);

		} catch (SQLException se) {
			logger.fatal("ReviewerDB: getReviewerNames: " + se.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewerNames: " + e.toString());
			return null;
		}

		return temp;
	}

	/*
	 * getAllReviewHistory
	 *	<p>
	 * @param	connection	Connection
	 * @param	hid			String
	 * @param	campus		String
	 * @param	acktion		int
	 *	<p>
	 * @return String
	 */
	public static String getAllReviewHistory(Connection connection,String hid,String campus,int acktion) throws Exception {

		String review = "";

		if (acktion==0)
			acktion = Constant.REVIEW;

		review = getAllReviewHistory(connection,hid,campus,"1",acktion);

		if (review == null || review.length() == 0 || "Data not found".equals(review))
			review = getAllReviewHistory(connection,hid,campus,"2",acktion);

		return review;
	}

	public static String getAllReviewHistory(Connection connection,String kix,String campus,String tbl,int acktion) throws Exception {

		//Logger logger = Logger.getLogger("test");

		if (acktion==0)
			acktion = Constant.REVIEW;

		String temp = "";
		String sql = "";
		int item = 0;
		int itemSaved = -1;
		int seq = 0;
		String qn = "";
		StringBuffer review = new StringBuffer();

		AseUtil aseUtil = new AseUtil();

		// ignoring this logic. when displaying history, we want to pull in
		// history as long as the KIX matches
		if ("1".equals(tbl))
			tbl = "tblReviewHist";
		else if ("2".equals(tbl))
			tbl = "tblReviewHist2";

		sql = "SELECT reviewer, dte, CAST(comments AS varchar(500)) AS comments, item "
			+ "FROM tblReviewHist "
			+ "WHERE historyid=? AND source=1 AND acktion=? "
			+ "UNION "
			+ "SELECT reviewer, dte, CAST(comments AS varchar(500)) AS comments, item "
			+ "FROM tblReviewHist2 "
			+ "WHERE historyid=? AND source=1 AND acktion=? "
			+ "ORDER BY item, dte";
		ArrayList<Reviewer> list = new ArrayList<Reviewer>();
		try {
			review.append("<table border=\"0\" cellpadding=\"1\" width=\"100%\">");
			Reviewer reviewer;
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,acktion);
			ps.setString(3,kix);
			ps.setInt(4,acktion);
			// part 1 - get course items
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				item = rs.getInt(4);
				if ( item != itemSaved ){
					qn = QuestionDB.getCourseQuestionByNumber(connection,campus,1,item);
					seq = QuestionDB.getCourseSequenceByNumber(connection,campus,"1",item);
					review.append( "<tr class=\"fieldhighlight\"><td valign=top class=textblackth>" + seq + ". " + qn + "</td></tr>" );
					itemSaved = item;
				}
				review.append( "<tr class=\"rowhighlight\"><td valign=top colspan=2 class=datacolumn>"
					+ rs.getString(1).trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString(2),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				review.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString(3).trim()
					+ "</td></tr>" );
			}
			rs.close();
			ps.close();

			// part 2 - get campus items
			sql = "SELECT r.reviewer,r.dte,r.comments,r.item "
				+ "FROM " + tbl + " AS r INNER JOIN "
				+ "tblCampusQuestions c ON r.campus = c.campus AND r.item = c.questionnumber "
				+ "WHERE historyid=? AND source=? AND acktion=? "
				+ " ORDER BY r.item, r.dte ";
			ps = connection.prepareStatement(sql);
			ps.setString(1, kix);
			ps.setString(2, "2");
			ps.setInt(3,acktion);

			int counter = 1;
			int courseItemCounter = CourseDB.countCourseQuestions(connection,campus,"Y","",Constant.TAB_COURSE);
			rs = ps.executeQuery();
			while (rs.next()) {
				item = rs.getInt(4);
				if ( item != itemSaved ){
					qn = QuestionDB.getCourseQuestionByNumber(connection,campus,2,item);
					review.append( "<tr class=\"fieldhighlight\"><td valign=top class=textblackth>" + (counter+courseItemCounter) + ". " + qn + "</td></tr>" );
					itemSaved = item;
					++counter;
				}
				review.append( "<tr class=\"rowhighlight\"><td valign=top class=datacolumn>"
					+ rs.getString(1).trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString(2),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				review.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString(3).trim()
					+ "</td></tr>" );
			}
			rs.close();
			ps.close();

			review.append("</table>");

			if (itemSaved==-1)
				temp = "Data not found" ;
			else
				temp = review.toString();

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getAllReviewHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewerDB: getAllReviewHistory - " + ex.toString());
		}

		return temp;
	}

	/*
	 * Returns a list of users selected reviewers by campus
	 * <p>
	 * @param connection			Connection
	 * @param usercampus			String
	 * @param selectedCampus	String
	 * @param alpha				String
	 * @param num					String
	 * @param user					String
	 * <p>
	 * @return String
	 */
	public static String getCampusReviewUsers(Connection connection,
															String userCampus,
															String selectedCampus,
															String alpha,
															String num,
															String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String junk = "";

		PreparedStatement ps;
		ResultSet rs;

		try {

			String proposer = CourseDB.getCourseProposer(connection,userCampus,alpha,num,"PRE");

			// default query is to get all users from a campus
			String sql = "SELECT userid FROM tblUsers WHERE campus=? ORDER BY userid";

			/*
				make sure not to include the proposer as part of the reviewer list name

				of course, if sys admin, permit since we have to test.

				ttgiang - 2010.06.22 - per s.pope
			*/
			boolean isSysAdm = SQLUtil.isSysAdmin(connection,user);

			if (proposer != null && proposer.length() > 0 && !isSysAdm)
				sql = "SELECT userid FROM tblUsers WHERE campus=? AND userid<>'"+proposer+"' ORDER BY userid";

			// get list of names ready set as reviewers
			junk = getCourseReviewers(connection,userCampus,alpha,num);

			// use the list of names and make sure we don't include in the
			// list of users from the selectedCampus
			if (junk != null && junk.length() > 0) {
				String[] s = new String[100];
				s = junk.split(",");
				temp.append("");
				for (int i = 0; i < s.length; i++) {
					if (temp.length() == 0)
						temp.append("\'" + s[i] + "\'");
					else
						temp.append(",\'" + s[i] + "\'");
				}

				// if temp is available, then make sure to exclude users from selectedCampus
				sql = "SELECT userid FROM tblUsers WHERE campus=? AND userid NOT IN (" + temp.toString() + ") ORDER BY userid";
			}

			reviewers.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			junk = "";
			ps = connection.prepareStatement(sql);
			ps.setString(1, selectedCampus);
			rs = ps.executeQuery();
			while (rs.next()) {
				junk = rs.getString(1);
				reviewers.append("<option value=\"" + junk + "\">" + junk + "</option>");
			}
			rs.close();

			// add user email list to selection
			if (user != null && user.length() > 0){
				sql = "SELECT title FROM tblEmailList WHERE campus=? AND auditby=? ORDER BY title";
				ps = connection.prepareStatement(sql);
				ps.setString(1,userCampus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				while (rs.next()) {
					junk = rs.getString(1);
					reviewers.append("<option value=\"[" + junk + "]\">[" + junk + "]</option>");
				}
				rs.close();
			}

			reviewers.append("</select></td></tr></table>");

			junk = reviewers.toString();

			ps.close();
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCampusReviewUsers - " + e.toString());
			junk = "";
		}

		return junk;
	}

	public static String getCampusReviewUsers2(Connection connection,
															String userCampus,
															String selectedCampus,
															String alpha,
															String num,
															String user) throws Exception {

		return getCampusReviewUsers2(connection,userCampus,selectedCampus,alpha,num,user,"");
	}

	public static String getCampusReviewUsers2(Connection conn,
															String userCampus,
															String selectedCampus,
															String alpha,
															String num,
															String user,
															String kix) throws Exception {

		//
		// REVIEW_DEBUG_08
		//

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String userID = "";
		String fullName = "";

		PreparedStatement ps;
		ResultSet rs;

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------------");
				logger.info("getCampusReviewUsers2 - REVIEW_DEBUG_08");
				logger.info("---------------------------------------");
				logger.info("userCampus: " + userCampus);
			}

			boolean isFoundation = false;

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

			if(!isAProgram){
				isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
			}

			String proposer = "";

			if(isFoundation){
				proposer = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
			}
			else{
				proposer = CourseDB.getCourseProposer(conn,userCampus,alpha,num,"PRE");
			}

			if(debug){
				logger.info("selectedCampus: " + selectedCampus);
				logger.info("kix: " + kix);
				logger.info("isAProgram: " + isAProgram);
				logger.info("isFoundation: " + isFoundation);
				logger.info("proposer: " + proposer);
			}

			String select = "SELECT userid, lastname + ', ' + firstname AS fullname ";
			String orderBy = "ORDER BY lastname,firstname";

			// default query is to get all users from a campus
			String sql = select + "FROM tblUsers WHERE campus=? " + orderBy;

			/*
				make sure not to include the proposer as part of the reviewer list name

				of course, if sys admin, permit since we have to test.

				ttgiang - 2010.06.22 - per s.pope
			*/
			boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

			if (proposer != null && proposer.length() > 0 && !isSysAdm){
				sql = select + "FROM tblUsers WHERE campus=? AND userid<>'"+proposer+"' " + orderBy;
			}

			// get list of names set as reviewers
			if (isAProgram){
				userID = getCourseReviewers(conn,userCampus,kix,proposer,Constant.ALL_REVIEWERS);
			}
			else{
				proposer = getReviewInviter(conn,userCampus,kix);
				if(debug) logger.info("getReviewInviter: " + proposer);
				if(debug) logger.info("userCampus: " + userCampus);

				userID = getCourseReviewers(conn,userCampus,alpha,num,proposer,Constant.ALL_REVIEWERS);
				if(debug) logger.info("getCourseReviewers: " + userID);
			}

			// use the list of names and make sure we don't include in the
			// list of users from the selectedCampus
			if (userID != null && userID.length() > 0) {
				String[] s = new String[100];
				s = userID.split(",");
				temp.append("");
				for (int i = 0; i < s.length; i++) {
					if (temp.length() == 0)
						temp.append("\'" + s[i] + "\'");
					else
						temp.append(",\'" + s[i] + "\'");
				}

				// if temp is available, then make sure to exclude users from selectedCampus
				sql = select + "FROM tblUsers WHERE campus=? AND userid NOT IN (" + temp.toString() + ") " + orderBy;
			}

			reviewers.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			userID = "";
			ps = conn.prepareStatement(sql);
			ps.setString(1, selectedCampus);
			rs = ps.executeQuery();
			while (rs.next()) {
				userID = AseUtil.nullToBlank(rs.getString(1));
				fullName = AseUtil.nullToBlank(rs.getString(2));
				reviewers.append("<option value=\"" + userID + "\">" + fullName + " (" + userID + ")</option>");
			}
			rs.close();

			// add user email list to selection
			if (user != null && user.length() > 0){
				sql = "SELECT title FROM tblEmailList WHERE campus=? AND auditby=? ORDER BY title";
				ps = conn.prepareStatement(sql);
				ps.setString(1,userCampus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				while (rs.next()) {
					userID = rs.getString(1);
					reviewers.append("<option value=\"[" + userID + "]\">[" + userID + "]</option>");
				}
				rs.close();
			}

			reviewers.append("</select></td></tr></table>");

			userID = reviewers.toString();

			ps.close();
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCampusReviewUsers - " + e.toString());
			userID = "";
		}

		return userID;
	}

	/*
	 * Returns a list of reviewers by campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getCourseReviewers(Connection conn,String campus,String alpha,String num) {

		return getCourseReviewers(conn,campus,alpha,num,"",1);

	}

	public static String getCourseReviewers(Connection conn,String campus,String alpha,String num,String inviter,int level) {

		// REVIEW_DEBUG_06

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		String temp = "";
		int counter = 0;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------------");
				logger.info("getCourseReviewers - REVIEW_DEBUG_06");
				logger.info("---------------------------------------");
				logger.info("campus: " + campus);
			}

			String sql = "";

			PreparedStatement ps = null;

			boolean foundation = false;

			//
			// this is for courses or foundations only.
			// if not course, then must be foundation
			//
			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
			if(kix.equals(Constant.BLANK)){
				kix = com.ase.aseutil.fnd.FndDB.getKix(conn,campus,alpha,num,"PRE");
				if(!kix.equals(Constant.BLANK)){
					foundation = true;
				}
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 (Constant.ALL_REVIEWERS) means to get all
			//
			if(level == 0){
				level = 1;
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = com.ase.aseutil.fnd.FndDB.getFndItem(conn,kix,"proposer");
				}
				else{
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			if(level==Constant.ALL_REVIEWERS){
				sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? ORDER BY userid";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, kix);
			}
			else{

				if(inviter == null || inviter.equals(Constant.BLANK)){
					sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND level=? ORDER BY userid";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, kix);
					ps.setInt(3, level);
				}
				else{
					sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND level=? AND inviter=? ORDER BY userid";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, kix);
					ps.setInt(3, level);
					ps.setString(4, inviter);
				}

			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (counter == 0)
					reviewers.append(AseUtil.nullToBlank(rs.getString(1)));
				else
					reviewers.append("," + AseUtil.nullToBlank(rs.getString(1)));

				++counter;
			}
			temp = reviewers.toString();

			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCourseReviewers01 - " + e.toString());
		}

		return temp;
	}

	/*
	 * Returns a list of reviewers by campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String getCourseReviewers(Connection conn,String campus,String kix) {

		return getCourseReviewers(conn,campus,kix,"",1);

	}

	public static String getCourseReviewers(Connection conn,String campus,String kix,String inviter,int level) {

		// REVIEW_DEBUG_07

		String temp = "";

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------------");
				logger.info("getCourseReviewers - REVIEW_DEBUG_07");
				logger.info("---------------------------------------");
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means to get all
			//
			if(level == 0){
				level = 1;
			}

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			boolean foundation = fnd.isFoundation(conn,kix);

			String[] info = null;
			String alpha = "";
			String num = "";

			if(foundation){
				info = fnd.getKixInfo(conn,kix);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
			}

			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			campus = info[Constant.KIX_CAMPUS];

			if(debug){
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			temp = getCourseReviewers(conn,campus,alpha,num,inviter,level);

			fnd = null;

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCourseReviewers02 - " + e.toString());
		}

		return temp;
	}

	/*
	 * Returns a list of reviewers by campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getCourseReviewers2(Connection conn,String campus,String alpha,String num) throws Exception {

		String sql = "";

		try {

			// alpha = kix when num is empty
			if (alpha.length() > 0 && num.length() == 0)
				sql = getCourseReviewers(conn,campus,alpha);
			else
				sql = getCourseReviewers(conn,campus,alpha,num);

			// properly quote sql for use below
			sql = "'" + sql.replace(",","','") + "'";

			sql = "SELECT userid, lastname + ', ' + firstname + ' (' + userid + ')' AS fullname "
					+ "FROM tblUsers WHERE campus='"+campus+"' "
					+ "AND userid IN ("+sql+") ORDER BY lastname,firstname";

			AseUtil au = new AseUtil();
			sql = au.createSelectionBox(conn, sql, "toList", "", "", "10", false, "" );
			au = null;

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCourseReviewers2 - " + e.toString());
		}

		return sql;
	}

	/*
	 * Saves the list of reviewers
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	reviewers	String
	 * @param	reviewDate	String
	 * @param	comments		String
	 *	<p>
	 * @return boolean
	 */
	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate) throws Exception {

		return setCourseReviewers(conn,campus,alpha,num,user,reviewers,reviewDate,"","");
	}

	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate,
															String comments) throws Exception {

		return setCourseReviewers(conn,campus,alpha,num,user,reviewers,reviewDate,comments,"");
	}

	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate,
															String comments,
															String kix) throws Exception {

		return setCourseReviewers(conn,campus,alpha,num,user,reviewers,reviewDate,comments,kix,1);

	}

	public static boolean setCourseReviewers(Connection conn,
															String campus,
															String alpha,
															String num,
															String user,
															String reviewers,
															String reviewDate,
															String comments,
															String kix,
															int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;
		boolean rtrn = false;
		boolean isAProgram = false;
		boolean foundation = false;
		boolean mayKickOffReview = false;

		String temp = "";
		String dist = "";
		String type = "PRE";

		PreparedStatement ps;
		String sql = "";
		String toEmail = "";
		String inviter = "";
		String currentReviewers = "";
		String progress = "REVIEW";
		String approvalText = "";

		String modifyText = "";
		String modifyProposedText = "";
		String modifyApprovedText = "";

		String deleteText = "";
		String deleteProposedText = "";
		String deleteApprovedText = "";

		String reviewText = "";
		String reviewDescr = "";
		String createTaskText = "";
		String reviewTaskText = "";
		String category = "";

		String taskCategory = "";

		int rowsAffected;
		int i = 0;
		Msg msg = null;

		String thisProgress = "";		// progress of the outline or program

		// review within review
		if(level == 0){
			level = 1;
		}

		String reviewerProgress = Constant.COURSE_REVIEW_TEXT;

		String mailBundle = "emailReviewerInvite";

		com.ase.aseutil.fnd.FndDB fnd = null;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if (debug){
				logger.info("------------------");
				logger.info("setCourseReviewers");
				logger.info("------------------");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("user: " + user);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
			}

			if (kix == null || kix.length() == 0){
				kix = Helper.getKix(conn,campus,alpha,num,type);
			}

			//
			// what are we working with
			//
			isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

			if(!isAProgram){
				fnd = new com.ase.aseutil.fnd.FndDB();
				foundation = fnd.isFoundation(conn,kix);
			}

			//
			// set up messages
			//
			if (foundation){
				mailBundle = "emailReviewerFndInvite";

				category = Constant.FOUNDATION;
				taskCategory = Constant.FOUNDATION;

				createTaskText = Constant.FND_CREATE_TEXT;

				modifyText = Constant.FND_MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_FND;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_FND;

				approvalText = Constant.FND_APPROVAL_TEXT;

				deleteText = Constant.FND_DELETE_TEXT;
				deleteProposedText = Constant.TASK_DELETE_PROPOSED_FND;
				deleteApprovedText = Constant.TASK_DELETE_APPROVED_FND;

				reviewText = Constant.FND_REVIEW_PROGRESS;
				reviewDescr = Constant.FND_MODIFICATION;
				reviewTaskText = Constant.FND_REVIEW_TEXT;

				thisProgress = fnd.getFndItem(conn,kix,"progress");

				currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,kix,user,level);

				reviewerProgress = Constant.FND_REVIEW_PROGRESS;
			}
			else if (isAProgram){
				category = Constant.PROGRAM;
				taskCategory = Constant.PROGRAM;

				createTaskText = Constant.PROGRAM_CREATE_TEXT;

				modifyText = Constant.PROGRAM_MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_PROGRAM;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_PROGRAM;

				approvalText = Constant.PROGRAM_APPROVAL_TEXT;

				deleteText = Constant.PROGRAM_DELETE_TEXT;
				deleteProposedText = Constant.TASK_DELETE_PROPOSED_PROGRAM;
				deleteApprovedText = Constant.TASK_DELETE_APPROVED_PROGRAM;

				reviewText = Constant.PROGRAM_REVIEW_PROGRESS;
				reviewDescr = Constant.PROGRAM_MODIFICATION;
				reviewTaskText = Constant.PROGRAM_REVIEW_TEXT;

				thisProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,kix,user,level);

				reviewerProgress = Constant.PROGRAM_REVIEW_PROGRESS;
			}
			else{
				category = Constant.COURSE;
				taskCategory = "";

				createTaskText = "";

				modifyText = Constant.MODIFY_TEXT;
				modifyProposedText = Constant.TASK_MODIFY_PROPOSED_OUTLINE;
				modifyApprovedText = Constant.TASK_MODIFY_APPROVED_OUTLINE;

				approvalText = Constant.APPROVAL_TEXT;

				deleteText = Constant.DELETE_TEXT;
				deleteProposedText = Constant.TASK_DELETE_PROPOSED_OUTLINE;
				deleteApprovedText = Constant.TASK_DELETE_APPROVED_OUTLINE;

				reviewText = Constant.COURSE_REVIEW_TEXT;
				reviewDescr = Constant.OUTLINE_MODIFICATION;
				reviewTaskText = Constant.REVIEW_TEXT;

				thisProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);
				currentReviewers = ReviewerDB.getCourseReviewers(conn,campus,alpha,num,user,level);

				reviewerProgress = Constant.COURSE_REVIEW_TEXT;
			}

			String proposer = "";

			//
			// proposer
			//
			if(foundation){
				proposer = fnd.getFndItem(conn,kix,"proposer");
			}
			else if(isAProgram){
				proposer = ProgramsDB.getItem(conn,kix,"proposer");
			}
			else{
				proposer = CourseDB.getCourseItem(conn,kix,"proposer");
			}

			//
			// debug
			//
			if (debug){
				logger.info("proposer: " + proposer);
				logger.info("isAProgram: " + isAProgram);
				logger.info("foundation: " + foundation);

				logger.info("modifyText: " + modifyText);
				logger.info("modifyProposedText: " + modifyProposedText);
				logger.info("modifyApprovedText: " + modifyApprovedText);

				logger.info("deleteText: " + deleteText);
				logger.info("deleteProposedText: " + deleteProposedText);
				logger.info("deleteApprovedText: " + deleteApprovedText);

				logger.info("approvalText: " + approvalText);

				logger.info("reviewText: " + reviewText);
				logger.info("reviewDescr: " + reviewDescr);
				logger.info("reviewTaskText: " + reviewTaskText);

				logger.info("thisProgress: " + thisProgress);
				logger.info("reviewers: " + reviewers);
				logger.info("reviewDate: " + reviewDate);

				logger.info("level: " + level);
				logger.info("progress: " + progress);
			}

			// when arriving here with no data for reviewers and date, this means that
			// the user have removed all remaining reviewers from the list to review.
			// being so, this means there is no one left to review so we should
			// clear the table and reset the course to modify state. This would
			// be the same as someone clicking 'I'm finished' and completing the process.
			if (reviewers.equals(Constant.BLANK) && reviewDate.equals(Constant.BLANK)){
				deleteReviewers(conn,campus,alpha,num,true,user,level);

				if (foundation){
					msg = fnd.endReviewerTask(conn,campus,kix,user);
				}
				else if (isAProgram){
					msg = ProgramsDB.endReviewerTask(conn,campus,kix,user);
				}
				else{
					msg = CourseDB.endReviewerTask(conn,campus,alpha,num,user);
				}

				rtrn = true;

				AseUtil.loggerInfo("ReviewerDB: setCourseReviewers ",campus,user,alpha, num);
			}
			else{
				//
				//	assign task and add users
				//
				//	1) Get list of current users
				//	2) Don't send to anyone already on the list
				//	3) Delete names removed from list
				//	4) Remove modify outline task from proposer
				//
				inviter = user;

				//
				// remove existing reviewers at level 1 only. these are reviewers invited by the proposer (level = 1)
				//
				if (currentReviewers != null && !currentReviewers.equals(Constant.BLANK)){
					sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND historyid=? AND userid=? and level=?";
					String[] removal = new String[100];
					removal = currentReviewers.split(",");
					for (i=0; i<removal.length; i++) {
						rowsAffected = TaskDB.logTask(conn,
																removal[i],
																user,
																alpha,
																num,
																reviewTaskText,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,kix);
						ps.setString(5,removal[i]);
						ps.setInt(6,level);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("task removed for: " + removal[i]);

						AseUtil.logAction(conn,
												user,
												Constant.TASK_REMOVE,
												"review task removed for: " + removal[i],
												alpha,
												num,
												campus,
												kix);
					} // for
				}	// if currentReviewers
				if (debug) logger.info("current reviewers removed: " + currentReviewers);

				//--------------------------------------------------
				// progress must be APPROVAL for next check
				//--------------------------------------------------
				if (thisProgress != null &&
						(	thisProgress.equals(Constant.COURSE_APPROVAL_TEXT) ||
							thisProgress.equals(Constant.COURSE_DELETE_TEXT) ||
							thisProgress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) ||
							thisProgress.equals(Constant.FND_APPROVAL_PROGRESS)
						)
					){
					mayKickOffReview = reviewDuringApprovalAllowed(conn,kix,null);
				}
				if (debug) logger.info("mayKickOffReview: " + mayKickOffReview);

				if(mayKickOffReview){
					if (thisProgress.equals(Constant.COURSE_DELETE_TEXT)){
						progress = Constant.COURSE_DELETE_TEXT;
					}
					else{
						progress = Constant.COURSE_APPROVAL_TEXT;
					}
				}

				//--------------------------------------------------
				// if there are reviewers to add, process here
				//--------------------------------------------------
				if (reviewers != null && reviewers.length() > 0) {

					// distribution list? If yes, go through each item and get the list
					// of names. use substring to extract value without starting and ending
					// characters of []. combine the list into 'dist' to get a new list
					// for processing
					String[] tasks = new String[100];
					tasks = reviewers.split(",");
					for (i=0; i<tasks.length; i++) {
						temp = tasks[i];
						temp = temp.replace("[","");
						temp = temp.replace("]","");
						temp = EmailListsDB.getEmailListMembers(conn,campus,user,temp);

						if (temp != null && temp.length() > 0){
							if (dist.equals(""))
								dist = temp;
							else
								dist = dist + "," + temp;
						}
					}	// for

					// dist contains all reviewers just entered and currentReviewers are those
					// already saved in the system. combine for a complete list.
					reviewers = dist;
					if (debug) logger.info("distribution: " + dist);

					reviewers = Util.removeDuplicateFromString(reviewers);

					// after cleaning up duplicate names, remove extra commas in the middle,
					// the comma in the front and the one at the end
					while(reviewers.indexOf(",,") > -1){
						reviewers = reviewers.replaceAll(",,",",");
					}

					if (debug) logger.info("non duplicates: " + reviewers);

					//
					// set progress for review table. default is REVIEW for proposer
					//
					reviewerProgress = Constant.COURSE_REVIEW_TEXT;

					if(thisProgress.equals(Constant.COURSE_APPROVAL_TEXT) ||
						thisProgress.equals(Constant.COURSE_DELETE_TEXT) ||
						thisProgress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) ||
						thisProgress.equals(Constant.FND_APPROVAL_PROGRESS)
					){

						//
						// if review is requested by approver, then we are review in approval
						//
						reviewerProgress = Constant.COURSE_REVIEW_IN_APPROVAL;

					}

					//
					// set the review progress properly for REVIEW_IN_REVIEW
					//
					if(level > 1){
						reviewerProgress = Constant.COURSE_REVIEW_IN_REVIEW;
					}

					//
					// insert into task table
					//
					sql = "INSERT INTO tblReviewers (coursealpha,coursenum,userid,campus,historyid,inviter,level,progress,duedate) VALUES(?,?,?,?,?,?,?,?,?)";
					tasks = reviewers.split(",");
					for (i=0; i<tasks.length; i++) {
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
						ps.setString(3,tasks[i]);
						ps.setString(4,campus);
						ps.setString(5,kix);
						ps.setString(6,user);
						ps.setInt(7,level);
						ps.setString(8,reviewerProgress);
						ps.setString(9,reviewDate);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("creating task for " + tasks[i] + " by " + user);

						rowsAffected = TaskDB.logTask(conn,
																tasks[i],
																user,
																alpha,
																num,
																reviewTaskText,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																inviter,
																Constant.TASK_REVIEWER,
																kix,
																category);

						AseUtil.logAction(conn,user,"ACTION","review task added for: " + tasks[i],alpha,num,campus,kix);

					} // for
					if (debug){
						logger.info("tasks created");
						logger.info("reviewers.length: " + reviewers.length());
					}

					// greater than 2 because it's possible to have a single comma after removing dups
					if (!reviewers.equals(Constant.BLANK) && reviewers.length() > 2 && user.equals(proposer)){
						// park this entry temporarily so that we can grab the content for mailing to reviewers
						String reason = "Proposer comments:<br/><br/>"
											+ comments
											+ ". <br/><br/>Review requested by: "
											+ reviewDate;

						rowsAffected = MiscDB.insertMisc(conn,campus,kix,alpha,num,Constant.PRE,"emailReviewerInvite",reason,user);

						MailerDB mailerDB = new MailerDB(conn,
																	user,
																	reviewers,
																	Constant.BLANK,
																	Constant.BLANK,
																	alpha,
																	num,
																	campus,
																	mailBundle,
																	kix,
																	user);
						if (debug) logger.info("sending mail using emailReviewerInvite bundle for " + kix);
					} // reviewers.length() > 2

				} // if reviewers

				//----------------------------------------------------------------------------
				// FORUM
				//----------------------------------------------------------------------------
				String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
				if (enableMessageBoard.equals(Constant.ON)){

					if (debug) logger.info("enableMessageBoard: " + enableMessageBoard);

					if(ForumDB.getForumID(conn,campus,kix) == 0){

						// create the new forum and add proposer to access
						int fid = ForumDB.createMessageBoard(conn,campus,user,kix);
						if (debug) logger.info("fid: " + fid);
						if(fid > 0){
							Board.addBoardMember(conn,fid,user);
							if (debug) logger.info("addBoardMember: " + user);
						}

					}
					else{
						//
						// ER18 - if the forum was previoused closed and review is starting
						ForumDB.openForum(conn,campus,user,kix);

						// ER18 - end any pending notification to proposer
						ForumDB.setNotified(conn,user,ForumDB.getForumID(conn,kix),Constant.ON);

						// ER18 - end any open editing started by proposer
						Board.endReviewProcess(conn,campus,kix,user);
					} // forum
				} // board is enabled

				//----------------------------------------------------------------------------
				// set course to review only status. only for proposer
				//----------------------------------------------------------------------------
				if(user.equals(proposer) || level == 1){

					if (foundation){
						sql = "UPDATE tblfnd SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
								+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,progress);
						ps.setString(2,reviewDate);
						ps.setString(3,campus);
						ps.setString(4,kix);
					}
					else if (isAProgram){
						sql = "UPDATE tblPrograms SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
								+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,progress);
						ps.setString(2,reviewDate);
						ps.setString(3,campus);
						ps.setString(4,kix);
					}
					else{
						if (thisProgress.equals(Constant.COURSE_DELETE_TEXT)){
							sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=?,subprogress=? "
									+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
							ps = conn.prepareStatement(sql);
							ps.setString(1,progress);
							ps.setString(2,reviewDate);
							ps.setString(3,Constant.COURSE_REVIEW_IN_DELETE);
							ps.setString(4,campus);
							ps.setString(5,alpha);
							ps.setString(6,num);
						}
						else{
							sql = "UPDATE tblCourse SET edit=0,edit0='',edit1='2',edit2='2',progress=?,reviewdate=? "
									+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
							ps = conn.prepareStatement(sql);
							ps.setString(1,progress);
							ps.setString(2,reviewDate);
							ps.setString(3,campus);
							ps.setString(4,alpha);
							ps.setString(5,num);
						}
					}
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("update status to " + progress);
				} // user == proposer

				// update comments to show review information
				// String reason = "Outline review sent to " + reviewers + ". Review requested by: " + reviewDate;
				// Outlines.updateReason(conn,kix,reason,user);

				//
				// set appropriate outline progress and remove tasks for current approvers
				// only level 1 may do review in approval. there are the approvers
				//
				if(mayKickOffReview && level == 1){

					if (foundation){
						fnd.updateFndItem(conn,kix,"subprogress",Constant.FND_REVIEW_IN_APPROVAL,user);
					}
					else if (isAProgram){
						ProgramsDB.setSubProgress(conn,kix,Constant.PROGRAM_REVIEW_IN_APPROVAL);
					}
					else{
						Outlines.setSubProgress(conn,kix,Constant.COURSE_REVIEW_IN_APPROVAL);
					}

					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															approvalText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("approver approval task removed " + rowsAffected + " row");

					// also remove the delegate
					String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
					int route = Integer.parseInt(info[1]);
					String delegateName = ApproverDB.getDelegateByApproverName(conn,campus,user,route);
					rowsAffected = TaskDB.logTask(conn,
															delegateName,
															delegateName,
															alpha,
															num,
															approvalText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("delegate approval task removed " + rowsAffected + " row");

					if (debug) AseUtil.loggerInfo("ReviewerDB: Outlines.setSubProgress ",campus,user,alpha, num);
				} // mayKickOffReview

				//
				// remove task from proposer. for REVIEW_IN_REVIEW, we don't bother with this section
				//
				if(user.equals(proposer)){
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);
					if (debug) logger.info("proposer task removed ("+modifyText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyProposedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("proposed task removed ("+modifyProposedText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,modifyApprovedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("approved task removed ("+modifyApprovedText+") " + rowsAffected + " row");

					// remove create task
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,createTaskText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("approved task removed ("+createTaskText+") " + rowsAffected + " row");

					// remove delete task
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("proposer task removed ("+deleteText+") " + rowsAffected + " row");

					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteProposedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("proposed task removed ("+deleteProposedText+") " + rowsAffected + " row");

					// remove task from proposer
					rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,deleteApprovedText,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE,"","",kix,taskCategory);;
					if (debug) logger.info("approved task removed ("+deleteApprovedText+") " + rowsAffected + " row");

				} // remove task from proposer

				rtrn = true;

				if(foundation){
					AseUtil.logAction(conn,user,"ADD","Request foundation course review ("+ reviewers + ")",alpha,num,campus,kix);
				}
				else{
					AseUtil.logAction(conn,user,"ADD","Request outline review ("+ reviewers + ")",alpha,num,campus,kix);
				}

			} // else blank reviewers

			fnd = null;

			if (debug) logger.info("------------------- setCourseReviewers - END");

		} catch (Exception e) {
			logger.fatal(" " + e.toString());
			rtrn = false;
		}

		return rtrn;
	} // setCourseReviewers

	/*
	 * addCourseReviewer - Saves the list of reviewers
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	reviewer	String
	 * @param	inviter	String
	 *	<p>
	 * @return int
	 */
	public static int addCourseReviewer(Connection conn,
															String campus,
															String alpha,
															String num,
															String reviewer) throws Exception {

		return addCourseReviewer(conn,campus,alpha,num,reviewer,"");

	}

	public static int addCourseReviewer(Connection conn,
															String campus,
															String alpha,
															String num,
															String reviewer,
															String inviter) throws Exception {

		return addCourseReviewer(conn,campus,alpha,num,reviewer,inviter,1);

	}

	public static int addCourseReviewer(Connection conn,
															String campus,
															String alpha,
															String num,
															String reviewer,
															String inviter,
															int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
			String sql = "";

			//
			// REVIEW_IN_REVIEW.
			//
			if(level == 0){
				level = 1;
			}

			if (reviewer != null && reviewer.length() > 0) {

				//
				// set up the progress of the current review. we may have review in reviews
				//
				String reviewerProgress = Constant.COURSE_REVIEW_TEXT;

				boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

				boolean isFoundation = false;

				if(!isAProgram){
					isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
				}

				if(isAProgram){
					reviewerProgress = Constant.PROGRAM_REVIEW_PROGRESS;
				}
				else if(isFoundation){
					reviewerProgress = Constant.FND_REVIEW_PROGRESS;
				}

				//
				// inviter is the proposer when empty
				//
				if(inviter == null || inviter.equals(Constant.BLANK)){
					//inviter = CourseDB.getCourseProposer(conn,kix);
					inviter = getReviewInviter(conn,campus,kix);
				}

				String duedate = CourseDB.getCourseItem(conn,kix,"reviewdate");

				sql = "INSERT INTO tblReviewers (coursealpha,coursenum,userid,campus,historyid,level,progress,inviter,duedate) VALUES(?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				ps.setString(3,reviewer);
				ps.setString(4,campus);
				ps.setString(5,kix);
				ps.setInt(6,level);
				ps.setString(7,reviewerProgress);
				ps.setString(8,inviter);
				ps.setString(9,duedate);
				rowsAffected = ps.executeUpdate();

				MailerDB mailerDB = new MailerDB(conn,inviter,reviewer,"","",alpha,num,campus,"emailReviewerInvite",kix,reviewer);
				AseUtil.loggerInfo("ReviewerDB: addCourseReviewer ",campus,reviewer,alpha, num);
			}
		} catch (Exception e) {
			logger.fatal("ReviewerDB: addCourseReviewer - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * reviewerCommentsExists for a particular item
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	seq		int
	 * @param	acktion	int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean reviewerCommentsExists(Connection conn,String campus,String kix,int seq,int acktion) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		if (acktion==0)
			acktion = Constant.REVIEW;

		try{
			String sql = "SELECT historyid FROM vw_ReviewerComments WHERE historyid=? AND campus=? AND questionseq=? AND acktion=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,campus);
			ps.setInt(3,seq);
			ps.setInt(4,acktion);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ReviewerDB: reviewerCommentsExists - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ReviewerDB: reviewerCommentsExists - " + e.toString());
		}

		return exists;
	}

	/*
	 * getReviewsForEdit - return all reviews
	 *	<p>
	 *	@param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 * @param	item		int
	 * @param	source	int
	 * @param	acktion	int
	 *	<p>
	 *	@return String
	 */
	public static String getReviewsForEdit(Connection conn,String kix,String user,int item,int source,int acktion) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String commentType = "";

		/*
			when going from review 2 approval and reverse, should same person have
			access to edit their comments? NO
		*/

		boolean approvalEdit = false;
		boolean reviewEdit = false;

		if (acktion==Constant.REVIEW){
			commentType = "Reviewer";
			reviewEdit = true;
		}
		else if (acktion==Constant.APPROVAL){
			commentType = "Approver";
			approvalEdit = true;
		}
		else if (acktion==Constant.REVIEW_IN_APPROVAL){
			commentType = "Reviewer";
			approvalEdit = true;
		}

		temp = "<fieldset class=\"FIELDSET100\">"
			+ "<legend>In Progress</legend>"
			+ "<font class=\"textblackth\">Reviewer Comments</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.REVIEW,true,reviewEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Approver Comments</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.APPROVAL,true,approvalEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Reviewer Comments within Approval</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.REVIEW_IN_APPROVAL,true,approvalEdit)
			+	"</fieldset>"
			+	Html.BR()
			+	"<fieldset class=\"FIELDSET100\">"
			+ "<legend>Completed</legend>"
			+ "<font class=\"textblackth\">Reviewer Comments</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.REVIEW,false,reviewEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Approver Comments</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.APPROVAL,false,approvalEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Reviewer Comments within Approval</font>" + Html.BR()
			+	ReviewerDB.getReviewsForEdit2(conn,kix,user,item,source,Constant.REVIEW_IN_APPROVAL,false,approvalEdit)
			+	"</fieldset>";

		return temp;

	}

	public static String getReviewsForEdit2(Connection conn,
														String kix,
														String user,
														int item,
														int source,
														int acktion,
														boolean active,
														boolean edit) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// active is when reviews are in progress where as inactive are reviews
		// sent to the backup table. this happens when user complets a round of review.

		// allow user to edit comments as long as they have not finalized their own review sessions
		// in the case of editing reviewer comments, we only get data from the active table.
		// once finalized, data moves to tblReviewHist2 and is no longer editable.

		if (acktion==0){
			acktion = Constant.REVIEW;
		}

		String sql = "";
		String comments = "";
		String temp = "";
		String dte = "";
		String reviewer = "";
		int id = 0;
		int i = 0;
		int pid = 0;
		boolean found = false;
		StringBuffer review = new StringBuffer();
		String rowColor = "";

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String campus = info[4];

		String table = "tblReviewHist";

		try {
			AseUtil aseUtil = new AseUtil();

			if (active)
				table = "tblReviewHist";
			else
				table = "tblReviewHist2";

			sql = "SELECT id, dte, CAST(comments AS varchar(500)) AS comments, reviewer "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND item=? AND source=? AND acktion=? ";

 			sql += "ORDER BY dte";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(++pid,kix);
			ps.setInt(++pid,item);
			ps.setInt(++pid,source);
			ps.setInt(++pid,acktion);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME);
				comments = aseUtil.nullToBlank(rs.getString("comments"));
				reviewer = aseUtil.nullToBlank(rs.getString("reviewer"));

				if (i % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				review.append( "<tr bgcolor=\"" + rowColor + "\">"
					+ "<td class=datacolumn width=\"08%\">");

				if (active){
					if (	ReviewDB.isReviewAllowed(conn,campus,alpha,num,user,Constant.REVIEW_TEXT) ||
							ReviewDB.isReviewAllowed(conn,campus,alpha,num,user,Constant.APPROVAL_TEXT)	){
						if (user.equals(reviewer) && edit){
							review.append("<img src=\"../images/edit.gif\" alt=\"edit comment\" onclick=\"return aseSubmitClick0('"+kix+"',"+item+","+source+","+acktion+","+id+");\">&nbsp;&nbsp;"
								+ "<img src=\"../images/del.gif\" alt=\"delete comment\" onclick=\"return aseSubmitClick1('"+kix+"',"+item+","+source+","+acktion+","+id+");\">");
						}
					}
				}

				review.append("&nbsp;</td>"
					+ "<td class=datacolumn width=\"62%\" valign=\"top\">" + comments + "</td>"
					+ "<td class=datacolumn width=\"15%\" nowrap valign=\"top\">" + reviewer + "</td>"
					+ "<td class=datacolumn width=\"15%\" nowrap valign=\"top\">" + dte + "</td>"
					+ "</tr>" );

				++i;
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" cellpadding=\"1\" width=\"100%\">"
					+ "<tr bgcolor=\"#E1E1E1\">"
					+ "<td class=textblackth>&nbsp;</td>"
					+ "<td class=textblackth>Comments</td>"
					+ "<td class=textblackth>UserID</td>"
					+ "<td class=textblackth>Date</td>"
					+ "</tr>"
					+ review.toString()
					+ "</table>";
			}
			else
				temp = "data not found";

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewsForEdit - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewerDB: getReviewsForEdit - " + ex.toString());
		}

		return temp;
	}

	/*
	 * reviewDuringApprovalAllowed
	 *	<p>
	 *	@param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean reviewDuringApprovalAllowed(Connection conn,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");


		boolean mayReviewDuringApproval = false;
		boolean approvalHistoryFound = false;
		boolean taskExists = false;

		String alpha = "";
		String num = "";
		String type = "";
		String proposer = "";
		String progress = "";
		String campus = "";

		boolean debug = false;
		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			boolean isFoundation = false;

			boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

			if(!isAProgram){
				isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
			}

			String[] info = null;

			if(isFoundation){
				info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
			}

			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			campus = info[Constant.KIX_CAMPUS];

			if(debug){
				logger.info("---------------------------");
				logger.info("reviewDuringApprovalAllowed");
				logger.info("---------------------------");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("proposer: " + proposer);
				logger.info("progress: " + progress);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("isAProgram: " + isAProgram);
				logger.info("isAProgram: " + isAProgram);
			}

			// when there are entries in the approval history (approvalHistoryFound) OR progress is APPROVAL
			// AND a task exists for this user to approve and outline, then user may kick off
			// a review process built within the approval process.
			if (ApproverDB.countApprovalHistory(conn,kix) > 0){
				approvalHistoryFound = true;
			}
			if (debug) logger.info("approvalHistoryFound: " + approvalHistoryFound);

			if (isAProgram){
				taskExists = TaskDB.isMatch(conn,user,kix,Constant.PROGRAM_APPROVAL_TEXT,campus);
			}
			else{
				taskExists = TaskDB.isMatch(conn,user,alpha,num,Constant.APPROVAL_TEXT,campus);
			}
			if (debug) logger.info("taskExists: " + taskExists);

			if (!taskExists){
				if (isAProgram){
					taskExists = TaskDB.isMatchNoUserName(conn,kix,Constant.PROGRAM_APPROVAL_TEXT,campus);
				}
				else{
					taskExists = TaskDB.isMatchNoUserName(conn,alpha,num,Constant.APPROVAL_TEXT,campus);
				}
			} // !taskExists

			if ((	approvalHistoryFound ||
					progress.equals(Constant.COURSE_APPROVAL_TEXT) ||
					progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)) && taskExists){
				mayReviewDuringApproval = true;
			}
			else if (user != null && user.equals(proposer)){
				mayReviewDuringApproval = true;
			}
		}
		catch(Exception e){
			logger.fatal("ReviewerDB: reviewDuringApprovalAllowed - " + e.toString());
		}

		if(debug) logger.info("mayReviewDuringApproval: " + mayReviewDuringApproval);

		return mayReviewDuringApproval;
	}

	/*
	 * getComment
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	item		int
	 *	<p>
	 *	@return 	String
	 */
	public static String getComment(Connection conn,String campus,String kix,int item) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String comment = "";

		try{
			String sql = "SELECT comments FROM tblReviewHist WHERE campus=? AND historyid=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				comment = rs.getString("comments");

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ReviewerDB: getComment - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ReviewerDB: getComment - " + e.toString());
		}

		return comment;
	}

	/*
	 * getReview
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	item		int
	 *	<p>
	 *	@return 	Review
	 */
	public static Review getReview(Connection conn,String campus,String kix,int item) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		Review review = null;

		try{
			String sql = "SELECT comments,dte,reviewer FROM tblReviewHist WHERE campus=? AND historyid=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setInt(3,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				review = new Review();
				AseUtil aseUtil = new AseUtil();
				review.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				review.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME));
				review.setUser(AseUtil.nullToBlank(rs.getString("reviewer")));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ReviewerDB: getReview - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("ReviewerDB: getReview - " + e.toString());
		}

		return review;
	}

	/*
	 * isReviewer - is the user allowed to comment on an outline
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isReviewer(Connection conn,String kix,String user) throws Exception {

		// REVIEW_DEBUG_06A

		//Logger logger = Logger.getLogger("test");

		boolean isAReviewer = false;

		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("-----------------------------");
				logger.info("isReviewer - REVIEW_DEBUG_06A");
				logger.info("-----------------------------");
			}

			String reviewers = "";

			boolean isFoundation = false;

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

			if(!isAProgram){
				isFoundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
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
			String campus = info[Constant.KIX_CAMPUS];

			String inviter = getReviewInviter(conn,campus,kix);

			if(debug){
				logger.info("isAProgram: " + isAProgram);
				logger.info("isFoundation: " + isFoundation);
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("user: " + user);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("inviter: " + inviter);
			}

			if(isAProgram){
				reviewers = getReviewerNames(conn,campus,kix,inviter,Constant.ALL_REVIEWERS);
			}
			else{
				reviewers = getReviewerNames(conn,campus,alpha,num,inviter,Constant.ALL_REVIEWERS);
			}

			if (reviewers != null && reviewers.length() > 0 && reviewers.indexOf(user) > -1){
				isAReviewer = true;
			}

			if(debug){
				logger.info("-----------------------------");
				logger.info("isReviewer - REVIEW_DEBUG_06A");
				logger.info("-----------------------------");
				logger.info("reviewers: " + reviewers);
				logger.info("isAReviewer: " + isAReviewer);
			}

		}
		catch( SQLException e ){
			logger.fatal("ReviewerDB: isReviewer - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ReviewerDB: isReviewer - " + ex.toString());
		}

		return isAReviewer;
	}

	/*
	 * deleteReviewers
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	alpha
	 *	@param	num
	 * @param	log
	 * @param	level
	 *	<p>
	 *	@return int
	 */
	public static int deleteReviewers(Connection conn,String campus,String alpha,String num,boolean log) throws Exception {

		return deleteReviewers(conn,campus,alpha,num,log,"",1);

	}

	public static int deleteReviewers(Connection conn,String campus,String alpha,String num,boolean log,String inviter,int level) throws Exception {

		//
		// REVIEW_DEBUG_09
		//

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String currentReviewers = "";

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------");
				logger.info("deleteReviewers - REVIEW_DEBUG_09");
				logger.info("---------------------------------");
				logger.info("campus: " + campus);
			}

			String sql = "";

			PreparedStatement ps = null;

			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			//
			// foundation?
			//
			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			boolean foundation = fnd.isFoundation(conn,kix);

			//
			// program
			//
			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			if((kix == null || kix.equals(Constant.BLANK)) && !isAProgram){
				kix = fnd.getKix(conn,campus,alpha,num,"PRE");
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means all reviewers
			//

			if(level == 0){
				level = 1;
			}

			//
			// who invited to the party
			//
			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else if(isAProgram){
					inviter = ProgramsDB.getItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			//
			// who are reviewers
			//
			if (isAProgram){
				currentReviewers = getCourseReviewers(conn,campus,kix,inviter,level);
			}
			else{
				currentReviewers = getCourseReviewers(conn,campus,alpha,num,inviter,level);
			}

			if (log){
				if (currentReviewers != null && currentReviewers.length() > 0){

					// ER18. need to also remove board invite
					String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");

					sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND historyid=? AND userid=?";
					String[] removal = currentReviewers.split(",");
					for (int i=0; i<removal.length; i++) {
						rowsAffected = TaskDB.logTask(conn,
																removal[i],
																"",
																alpha,
																num,
																Constant.REVIEW_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE");
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,kix);
						ps.setString(5,removal[i]);
						rowsAffected = ps.executeUpdate();
						logger.info("ReviewerDB: deleteReviewers - " + removal[i]);

						AseUtil.logAction(conn,
												removal[i],
												"REMOVE",
												"review task removed for: " + removal[i],
												alpha,
												num,
												campus,
												kix);

						if (enableMessageBoard.equals(Constant.ON)){
							Board.endReviewProcess(conn,campus,kix,removal[i]);
						} // message board

					} // for

					rowsAffected = TaskDB.logTask(conn,"ALL","",alpha,num,Constant.REVIEW_TEXT,campus,"","REMOVE","PRE");
				} // currentReviewers
			}
			else{
				sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();

				if (rowsAffected > 0){

					AseUtil.logAction(conn,
											"SYSTEM",
											"REMOVE",
											"review task removed for " + currentReviewers,
											alpha,
											num,
											campus,
											kix);
				} // if rowsAffected

			} // if log

			// are there lost or strays where the course is CUR and shouldn't have reviewers
			String type = "CUR";
			if (ReviewerDB.hasReviewer(conn,campus,alpha,num,type)){
				kix = Helper.getKix(conn,campus,alpha,num,type);
				sql = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
			}

			fnd = null;

		}
		catch( SQLException e ){
			logger.fatal("ReviewerDB: deleteReviewers - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ReviewerDB: deleteReviewers - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * hasReviewer - is the user allowed to comment on an outline
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	alpha
	 * @param	num
	 * @param	level
	 *	<p>
	 *	@return boolean
	 */
	public static boolean hasReviewer(Connection conn,String campus,String alpha,String num) throws Exception {

		return hasReviewer(conn,campus,alpha,num,"",1);

	}

	public static boolean hasReviewer(Connection conn,String campus,String alpha,String num,String inviter,int level) throws Exception {

		//
		// REVIEW_DEBUG_11
		//

		//Logger logger = Logger.getLogger("test");

		boolean hasReviewerNames = false;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------------");
				logger.info("hasReviewer - REVIEW_DEBUG_11");
				logger.info("---------------------------------------");
				logger.info("campus: " + campus);
			}

			String kix = "";

			boolean foundation = false;

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			kix = fnd.getKix(conn,campus,alpha,num,"PRE");
			if(!kix.equals(Constant.BLANK)){
				foundation = true;
			}
			else{
				kix = Helper.getKix(conn,campus,alpha,num,"PRE");
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means all reviewers
			//

			if(level == 0){
				level = 1;
			}

			if(debug){
				logger.info("foundation: " + foundation);
				logger.info("kix: " + kix);
				logger.info("level: " + level);
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			String table = "tblReviewers";
			String where = "WHERE campus='"+campus+"' AND historyid='"+kix+"' ";

			if(inviter != null && inviter.length() > 0){
				where += " AND inviter='"+inviter+"' ";
			}

			if(level > 0){
				where += " AND level="+level+" ";
			}

			int rowsAffected = (int)AseUtil.countRecords(conn,table,where);
			if (rowsAffected>0){
				hasReviewerNames = true;
			}

			fnd = null;


		}
		catch( SQLException e ){
			logger.fatal("ReviewerDB: hasReviewer - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ReviewerDB: hasReviewer - " + ex.toString());
		}

		return hasReviewerNames;
	}

	/*
	 * hasReviewer - is the user allowed to comment on an outline
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	alpha
	 * @param	num
	 * @param	type
	 * @param	level
	 *	<p>
	 *	@return boolean
	 */
	public static boolean hasReviewer(Connection conn,String campus,String alpha,String num,String type) throws Exception {

		return hasReviewer(conn,campus,alpha,num,type,"",1);

	}

	public static boolean hasReviewer(Connection conn,String campus,String alpha,String num,String type,String inviter,int level) throws Exception {

		//
		// REVIEW_DEBUG_12
		//

		//Logger logger = Logger.getLogger("test");

		boolean hasReviewerNames = false;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			if(debug){
				logger.info("---------------------------------------");
				logger.info("hasReviewer - REVIEW_DEBUG_12");
				logger.info("---------------------------------------");
				logger.info("campus: " + campus);
			}

			String kix = "";

			boolean foundation = false;

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			kix = fnd.getKix(conn,campus,alpha,num,type);
			if(!kix.equals(Constant.BLANK)){
				foundation = true;
			}
			else{
				kix = Helper.getKix(conn,campus,alpha,num,type);
			}

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means all reviewers
			//

			if(level == 0){
				level = 1;
			}

			if(debug){
				logger.info("foundation: " + foundation);
				logger.info("kix: " + kix);
				logger.info("level: " + level);
			}

			if(level == 1 && (inviter == null || inviter.equals(Constant.BLANK))){
				if(foundation){
					inviter = fnd.getFndItem(conn,kix,"proposer");
				}
				else{
					//inviter = CourseDB.getCourseItem(conn,kix,"proposer");
					inviter = getReviewInviter(conn,campus,kix);
				}
			}

			String table = "tblReviewers";
			String where = "WHERE campus='"+campus+"' AND historyid='"+kix+"' AND inviter='"+inviter+"' AND level="+level;

			if(inviter == null || inviter.equals(Constant.BLANK)){
				where = "WHERE campus='"+campus+"' AND historyid='"+kix+"' ";
			}

			int rowsAffected = (int)AseUtil.countRecords(conn,table,where);
			if (rowsAffected>0){
				hasReviewerNames = true;
			}

			fnd = null;
		}
		catch( SQLException e ){
			logger.fatal("ReviewerDB: hasReviewer - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ReviewerDB: hasReviewer - " + ex.toString());
		}

		return hasReviewerNames;
	}

	/*
	 * removeReviewers
	 *	<p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param kix		String
	 *	@param alpha	String
	 *	@param num		String
	 *	@param remover	String
	 *	@param level	int
	 *	<p>
	 *	@return msg
	 */
	public static int removeReviewers(Connection conn,String campus,String kix,String alpha,String num,String remover){

		return removeReviewers(conn,campus,kix,alpha,num,remover,1);
	}

	public static int removeReviewers(Connection conn,String campus,String kix,String alpha,String num,String remover,int level){

		//
		// REVIEW_DEBUG_10
		//

		int rowsAffected = 0;
		int i = 0;
		String sql = "";
		String namesToRemove = "";

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ReviewerDB");

			boolean foundation = false;

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

			//
			//	process removes reviewers and tasks as long as reviewers exists.
			//
			//	If reviewers are gone and tasks exists, it will be picked up
			//	after.
			//

			//
			// REVIEW_IN_REVIEW.
			//
			//
			// for REVIEW_IN_REVIEW, level 99 means all reviewers
			//

			if(level == 0){
				level = 1;
			}

			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

			if(debug){
				logger.info("---------------------------------------");
				logger.info("removeReviewers - REVIEW_DEBUG_10");
				logger.info("---------------------------------------");
				logger.info("campus: " + campus);
				logger.info("foundation: " + foundation);
				logger.info("isAProgram: " + isAProgram);
			}

			//
			// proposer
			//
			if(level == 1 && (remover == null || remover.equals(Constant.BLANK))){
				if(foundation){
					remover = fnd.getFndItem(conn,kix,"proposer");
				}
				else if(foundation){
					remover = ProgramsDB.getItem(conn,kix,"proposer");
				}
				else{
					//remover = CourseDB.getCourseItem(conn,kix,"proposer");
					remover = getReviewInviter(conn,campus,kix);
				}
			}

			//
			// names to remove
			//
			if (foundation){
				namesToRemove = getCourseReviewers(conn,campus,kix,remover,level);
			}
			else if (isAProgram){
				namesToRemove = getCourseReviewers(conn,campus,kix,remover,level);
			}
			else{
				namesToRemove = getCourseReviewers(conn,campus,alpha,num,remover,level);
			}

			if (debug){
				logger.info("---------------------------------------");
				logger.info("removeReviewers - REVIEW_DEBUG_10");
				logger.info("---------------------------------------");
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("namesToRemove: " + namesToRemove);
				logger.info("level: " + level);
			}

			if (namesToRemove != null && namesToRemove.length() > 0){
				PreparedStatement ps = null;
				String[] tasks = new String[100];
				tasks = namesToRemove.split(",");

				for (i=0; i<tasks.length; i++) {

					if (foundation){
						sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=? AND level=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,tasks[i]);
						ps.setInt(4,level);
						rowsAffected = ps.executeUpdate();

						rowsAffected += TaskDB.logTask(conn,
																tasks[i],
																tasks[i],
																alpha,
																"divisionDescr",
																Constant.FND_REVIEW_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE,"","",kix,Constant.FOUNDATION);
					}
					else if (isAProgram){
						sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=? AND level=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,tasks[i]);
						ps.setInt(4,level);
						rowsAffected = ps.executeUpdate();

						rowsAffected += TaskDB.logTask(conn,
																tasks[i],
																tasks[i],
																alpha,
																"divisionDescr",
																Constant.PROGRAM_REVIEW_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE,"","",kix,Constant.PROGRAM);
					}
					else{
						sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND coursealpha=? AND coursenum=? AND userid=? AND level=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						ps.setString(3,alpha);
						ps.setString(4,num);
						ps.setString(5,tasks[i]);
						ps.setInt(6,level);
						rowsAffected = ps.executeUpdate();

						rowsAffected += TaskDB.logTask(conn,
																tasks[i],
																tasks[i],
																alpha,
																num,
																Constant.REVIEW_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}

					AseUtil.logAction(conn,tasks[i],"ACTION","Reviewer task removed",alpha,num,campus,kix);

				}
			} // namesToRemove != null
			else{

				if (isAProgram){
					rowsAffected += TaskDB.logTask(conn,
															"ALL",
															remover,
															alpha,
															"divisionDescr",
															Constant.PROGRAM_REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
				}
				else{
					rowsAffected += TaskDB.logTask(conn,
											"ALL",
											remover,
											alpha,
											num,
											Constant.REVIEW_TEXT,
											campus,
											Constant.BLANK,
											Constant.TASK_REMOVE,
											Constant.PRE);
				}

			}

			fnd = null;

			if (debug) logger.info("------------------- removeReviewers END");

		} catch (SQLException ex) {
			logger.fatal("ReviewerDB: removeReviewers - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: removeReviewers - " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * getColumn
	 *	<p>
	 *	@return String
	 */
	public static String getColumn(Connection conn,String kix,String column,String userid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String columnData = "";

		try {
			String sql = "SELECT "+column+" FROM tblreviewers WHERE historyid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,userid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				columnData = AseUtil.nullToBlank(rs.getString(column));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getColumn - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getColumn - " + e.toString());
		}

		return columnData;
	}

	/*
	 * getListOfUsersForReview
	 * <p>
	 * @param	conn				Connection
	 * @param	userCampus		String
	 * @param	selectedCampus	String
	 * @param	user				String
	 * @param	kix				String
	 * @param	level				int
	 * <p>
	 * @return String
	 */
	public static String getListOfUsersForReview(Connection conn,
															String userCampus,
															String selectedCampus,
															String user,
															String kix,
															int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String userID = "";
		String fullName = "";

		PreparedStatement ps;
		ResultSet rs;

		try {
			String proposer = CourseDB.getCourseItem(conn,kix,"proposer");

			String sql = "";

			sql = "SELECT u.userid, u.lastname + ', ' + u.firstname AS fullname "
				+ "FROM tblUsers AS u LEFT OUTER JOIN tblReviewers AS r ON u.userid = r.userid "
				+ "WHERE r.userid IS NULL AND u.campus=? AND u.userid<>? "
				+ "ORDER BY u.lastname,u.firstname";

			// get list of names already set as reviewers
			userID = getReviewersByLevel(conn,userCampus,kix,user,level);

			reviewers.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			ps = conn.prepareStatement(sql);
			ps.setString(1, selectedCampus);
			ps.setString(2,proposer);
			rs = ps.executeQuery();
			while (rs.next()) {
				userID = AseUtil.nullToBlank(rs.getString(1));
				fullName = AseUtil.nullToBlank(rs.getString(2));
				reviewers.append("<option value=\"" + userID + "\">" + fullName + " (" + userID + ")</option>");
			}
			rs.close();

			// add user email list to selection
			if (user != null && user.length() > 0){
				sql = "SELECT title FROM tblEmailList WHERE campus=? AND auditby=? ORDER BY title";
				ps = conn.prepareStatement(sql);
				ps.setString(1,userCampus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				while (rs.next()) {
					userID = rs.getString(1);
					reviewers.append("<option value=\"[" + userID + "]\">[" + userID + "]</option>");
				}
				rs.close();
			}

			reviewers.append("</select></td></tr></table>");

			userID = reviewers.toString();

			ps.close();
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getCampusReviewUsers - " + e.toString());
			userID = "";
		}

		return userID;
	}

	/*
	 * Returns a list of reviewers by campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * @param	level		int
	 * <p>
	 * @return String
	 */
	public static String getReviewersByLevel(Connection conn,String campus,String kix,String user,int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();

		try {
			int i = 0;

			String sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND inviter=? AND level=? ORDER BY userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			ps.setInt(4,level);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if(i==0){
					reviewers.append(rs.getString(1));
					i = 1;
				}
				else{
					reviewers.append("," + rs.getString(1));
				}
			}

			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewersByLevel - " + e.toString());
		}

		return reviewers.toString();
	}

	/*
	 * Returns a list of reviewers by campus and level
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	level		int
	 * <p>
	 * @return String
	 */
	public static String getReviewersByLevel(Connection conn,String campus,String kix,int level) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		int counter = 0;

		try {
			String sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND level=? ORDER BY userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ps.setInt(3, level);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (counter == 0)
					reviewers.append(AseUtil.nullToBlank(rs.getString(1)));
				else
					reviewers.append("," + AseUtil.nullToBlank(rs.getString(1)));

				++counter;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewersByLevel - " + e.toString());
		}

		return reviewers.toString();
	}

	/*
	 * Returns a list of reviewers by campus and inviter
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	inviter	String
	 * <p>
	 * @return String
	 */
	public static String getReviewersByInviter(Connection conn,String campus,String kix,String inviter) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();
		int counter = 0;

		try {
			String sql = "SELECT userid FROM tblReviewers WHERE campus=? AND historyid=? AND inviter=? ORDER BY userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,inviter);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (counter == 0)
					reviewers.append(AseUtil.nullToBlank(rs.getString(1)));
				else
					reviewers.append("," + AseUtil.nullToBlank(rs.getString(1)));

				++counter;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewersByInviter - " + e.toString());
		}

		return reviewers.toString();
	}

	/*
	 * getMyReviewers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * @param	level		int
	 * <p>
	 * @return String
	 */
	public static String getMyReviewers(Connection conn,String campus,String user,String kix,int level) throws Exception {

		//
		// these are reviewers user invited as an invitee to do reviews
		//

		//Logger logger = Logger.getLogger("test");

		StringBuffer reviewers = new StringBuffer();

		try {
			String sql = "SELECT u.userid, u.lastname + ', ' + u.firstname AS fullname "
					+ "FROM tblUsers AS u INNER JOIN tblReviewers AS r ON u.userid = r.userid "
					+ "WHERE u.campus=? AND r.historyid=? AND r.inviter=? AND r.level=? ORDER BY u.userid";
			reviewers.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'toList\' size=\'10\' id=\'toList\'>");
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			ps.setInt(4,level);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String userID = AseUtil.nullToBlank(rs.getString(1));
				String fullName = AseUtil.nullToBlank(rs.getString(2));
				reviewers.append("<option value=\"" + userID + "\">" + fullName + " (" + userID + ")</option>");
			}
			rs.close();
			ps.close();

			reviewers.append("</select></td></tr></table>");

		} catch (Exception e) {
			logger.fatal("ReviewerDB: getMyReviewers - " + e.toString());
		}

		return reviewers.toString();
	}

	/*
	 * getInviterLevel - returns the level this inviter starts at
	 *	<p>
	 *	@return String
	 */
	public static int getInviterLevel(Connection conn,String kix,String inviter) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int level = 0;

		try {
			String sql = "SELECT DISTINCT level FROM tblreviewers WHERE historyid=? AND inviter=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,inviter);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				level = NumericUtil.getInt(rs.getInt("level"),0);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getInviterLevel - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getInviterLevel - " + e.toString());
		}

		return level;
	}

	/*
	 * getReviewerLevel - returns the level this inviter starts at
	 *	<p>
	 *	@return String
	 */
	public static int getReviewerLevel(Connection conn,String kix,String userid) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int level = 0;

		try {
			String sql = "SELECT level FROM tblreviewers WHERE historyid=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,userid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				level = NumericUtil.getInt(rs.getInt("level"),0);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewerLevel - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getReviewerLevel - " + e.toString());
		}

		return level;
	}

	/*
	 * getMaxDueDate - the latest due date for this outline
	 *	<p>
	 *	@return String
	 */
	public static String getMaxDueDate(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String maxDate = "";

		try {
			String sql = "SELECT CONVERT(varchar, Max(duedate), 101) as duedate FROM tblreviewers WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				maxDate = AseUtil.nullToBlank(rs.getString("duedate"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getMaxDueDate - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: getMaxDueDate - " + e.toString());
		}

		return maxDate;
	}

	/*
	 * hasReviewInReview - returns true if there are levels above 1
	 *	<p>
	 *	@return boolean
	 */
	public static boolean hasReviewInReview(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean hasReviewInReview = false;

		try {
			String sql = "SELECT id FROM tblreviewers WHERE historyid=? AND level>1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			hasReviewInReview = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB: hasReviewInReview - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: hasReviewInReview - " + e.toString());
		}

		return hasReviewInReview;
	}

	/*
	 * deleteReviewer
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	userid	String
	 * @param	level		int
	 * <p>
	 * @return	int
	 */
	public static int deleteReviewer(Connection conn,String campus,String kix,String alpha,String num,String userid,int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

			rowsAffected = TaskDB.logTask(conn,
													userid,
													userid,
													alpha,
													num,
													Constant.REVIEW_TEXT,
													campus,
													"",
													"REMOVE",
													"PRE");

			String sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=? AND [level]=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,userid);
			ps.setInt(4,level);
			rowsAffected = ps.executeUpdate();
			logger.info("ReviewerDB: deleteReviewer - " + userid);

			AseUtil.logAction(conn,
									userid,
									"REMOVE",
									"review task removed for: " + userid,
									alpha,
									num,
									campus,
									kix);

			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				Board.endReviewProcess(conn,campus,kix,userid);
			}
		}
		catch( SQLException e ){
			logger.fatal("ReviewerDB: deleteReviewer - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ReviewerDB: deleteReviewer - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * Count number of reviewer comments for each item
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * @param sq		int
	 * @param en		int
	 * @param qn		int
	 * @param acktion	int
	 * <p>
	 * @return long
	 */
	public static long countFndComments(Connection conn,String kix,int sq,int en,int qn,int acktion) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;

		try {
			String sql = "SELECT count(historyid) FROM vw_ReviewerHistory WHERE historyid=? AND sq=? AND en=? AND qn=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,sq);
			ps.setInt(3,en);
			ps.setInt(4,qn);
			if (acktion > 0){
				ps.setInt(5,acktion);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = NumericUtil.getLong(rs.getLong(1),0);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewerDB.countFndComments - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB.countFndComments - " + e.toString());
		}

		return lRecords;
	}

	/*
	 * getReviewHistory
	 *	<p>
	 *	@param connection	Connection
	 *	@param kix			String
	 *	@param item			int
	 *	@param campus		String
	 *	@param source		int
	 *	@param acktion		int
	 *	<p>
	 *	@return String
	 */
	public static String getReviewHistory(Connection conn,String kix,int sq,int en,int qn,int acktion) throws Exception {

		StringBuffer buf = new StringBuffer();

		buf.append(getReviewHistory2(conn,kix,sq,en,qn,Constant.REVIEW,"h0","c0")
				+ getReviewHistory2(conn,kix,sq,en,qn,Constant.APPROVAL,"h1","c1")
				+ getReviewHistory2(conn,kix,sq,en,qn,Constant.REVIEW_IN_APPROVAL,"h2","c2"));

		return buf.toString();
	}

	public static String getReviewHistory2(Connection conn,String kix,int sq,int en, int qn,int acktion) throws Exception {

		return getReviewHistory2(conn,kix,sq,en,qn,acktion,"","");
	}

	public static String getReviewHistory2(Connection conn,
														String kix,
														int sq,
														int en,
														int qn,
														int acktion,
														String Headerindex,
														String contentIndex) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String sql = "";
		String question = "";
		String commentType = "";
		StringBuffer review = new StringBuffer();

		int counter = 0;
		int seq = 0;
		int pid = 0;
		int courseItemCounter = 0;

		PreparedStatement ps = null;

		AseUtil aseUtil = new AseUtil();

		boolean debug = false;

		boolean showAll = false;

		String savedSeq = "";

		try {

			debug = DebugDB.getDebug(conn,"ReviewerDB");

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			String fndtype = fnd.getFndItem(conn,kix,"fndtype");

			String showAllSQL = " AND sq=? AND en=? AND qn=? ";
			if(sq==0 && en==0 && qn==0){
				showAll = true;
				showAllSQL = "";
			}

			if(debug){
				logger.info("---------------------------");
				logger.info("getReviewHistory2");
				logger.info("---------------------------");
				logger.info("kix: " + kix);
				logger.info("sq: " + sq);
				logger.info("en: " + en);
				logger.info("qn: " + qn);
				logger.info("acktion: " + acktion);
				logger.info("fndtype: " + fndtype);
				logger.info("showAll: " + showAll);
			}

			review.append("<table border=\"0\" cellpadding=\"1\" width=\"98%\">");

			sql = "SELECT reviewer, dte, comments, seq, question, sq, en, qn FROM vw_ReviewerHistory ";
			sql += "WHERE historyid=? AND acktion=? " + showAllSQL + " ORDER BY sq,en,qn,dte";

			if(debug){
				logger.info("sql: " + sql);
			}

			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,acktion);

			if(!showAll){
				ps.setInt(3,sq);
				ps.setInt(4,en);
				ps.setInt(5,qn);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("seq");

				int iSq = rs.getInt("sq");
				int iEn = rs.getInt("en");
				int iQn = rs.getInt("qn");

				String junk = ""+iSq+"-"+iEn+"-"+iQn;

				if (!savedSeq.equals(junk)){

					question = fnd.getFoundations(conn,fndtype,iSq,iEn,iQn);

					savedSeq = junk;

					review.append( "<tr class=\"fieldhighlight\"><td valign=top class=textblackth>" + iSq + "." + iEn + "." + iQn + ". " + question + "</td></tr>" );
				}

				review.append( "<tr class=\"rowhighlight\"><td valign=top class=datacolumn>"
					+ rs.getString("reviewer").trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				review.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString("comments").trim()
					+ "</td></tr>" );

				++counter;
			}

			if (savedSeq.equals("")){
				review.append( "<tr><td valign=top>Data not found</td></tr>" );
			}

			rs.close();
			ps.close();

			fnd = null;

			review.append("</table>");

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewHistory - " + e.toString());
		}

		if (acktion==Constant.REVIEW)
			commentType = "Reviewer comments";
		else if (acktion==Constant.APPROVAL)
			commentType = "Approval comments";
		else if (acktion==Constant.REVIEW_IN_APPROVAL)
			commentType = "Review within approval comments";

		temp = "<div class=\"technology closedlanguage\" headerindex=\"0h\">  " + commentType + " (" + counter + ")</div>"
				+ "<div class=\"thelanguage\" contentindex=\"0c\" style=\"display: none; \">  " + review.toString() + "</div>";

		return temp;
	}

	/*
	 * getReviewsForEdit - return all reviews
	 *	<p>
	 *	@param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 * @param	item		int
	 * @param	source	int
	 * @param	acktion	int
	 *	<p>
	 *	@return String
	 */
	public static String getReviewsForEdit(Connection conn,String kix,String user,int sq,int en,int qn,int acktion) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String commentType = "";

		/*
			when going from review 2 approval and reverse, should same person have
			access to edit their comments? NO
		*/

		boolean approvalEdit = false;
		boolean reviewEdit = false;

		if (acktion==Constant.REVIEW){
			commentType = "Reviewer";
			reviewEdit = true;
		}
		else if (acktion==Constant.APPROVAL){
			commentType = "Approver";
			approvalEdit = true;
		}
		else if (acktion==Constant.REVIEW_IN_APPROVAL){
			commentType = "Reviewer";
			approvalEdit = true;
		}

		temp = "<fieldset class=\"FIELDSET100\">"
			+ "<legend>In Progress</legend>"
			+ "<font class=\"textblackth\">Reviewer Comments</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.REVIEW,true,reviewEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Approver Comments</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.APPROVAL,true,approvalEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Reviewer Comments within Approval</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.REVIEW_IN_APPROVAL,true,approvalEdit)
			+	"</fieldset>"
			+	Html.BR()
			+	"<fieldset class=\"FIELDSET100\">"
			+ "<legend>Completed</legend>"
			+ "<font class=\"textblackth\">Reviewer Comments</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.REVIEW,false,reviewEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Approver Comments</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.APPROVAL,false,approvalEdit)
			+	Html.BR()
			+	Html.BR()
			+ "<font class=\"textblackth\">Reviewer Comments within Approval</font>" + Html.BR()
			+	getReviewsForEdit2(conn,kix,user,sq,en,qn,Constant.REVIEW_IN_APPROVAL,false,approvalEdit)
			+	"</fieldset>";

		return temp;

	}

	public static String getReviewsForEdit2(Connection conn,
														String kix,
														String user,
														int sq,
														int en,
														int qn,
														int acktion,
														boolean active,
														boolean edit) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// active is when reviews are in progress where as inactive are reviews
		// sent to the backup table. this happens when user complets a round of review.

		// allow user to edit comments as long as they have not finalized their own review sessions
		// in the case of editing reviewer comments, we only get data from the active table.
		// once finalized, data moves to tblReviewHist2 and is no longer editable.

		if (acktion==0){
			acktion = Constant.REVIEW;
		}

		String sql = "";
		String comments = "";
		String temp = "";
		String dte = "";
		String reviewer = "";
		int id = 0;
		int i = 0;
		int pid = 0;
		boolean found = false;
		StringBuffer review = new StringBuffer();
		String rowColor = "";

		String[] info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];
		String campus = info[Constant.KIX_CAMPUS];

		String table = "tblReviewHist";

		try {
			AseUtil aseUtil = new AseUtil();

			if (active){
				table = "tblReviewHist";
			}
			else{
				table = "tblReviewHist2";
			}

			sql = "SELECT id, dte, CAST(comments AS varchar(500)) AS comments, reviewer "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND sq=? AND en=? AND qn=? AND acktion=? ORDER BY dte";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,sq);
			ps.setInt(3,en);
			ps.setInt(4,qn);
			ps.setInt(5,acktion);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME);
				comments = aseUtil.nullToBlank(rs.getString("comments"));
				reviewer = aseUtil.nullToBlank(rs.getString("reviewer"));

				if (i % 2 == 0){
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				}
				else{
					rowColor = Constant.ODD_ROW_BGCOLOR;
				}

				review.append( "<tr bgcolor=\"" + rowColor + "\">"
					+ "<td class=datacolumn width=\"08%\">");

				if (active){
					if (	ReviewDB.isReviewAllowed(conn,campus,alpha,num,user,Constant.FND_REVIEW_TEXT) ||
							ReviewDB.isReviewAllowed(conn,campus,alpha,num,user,Constant.FND_APPROVAL_TEXT)	){
						if (user.equals(reviewer) && edit){
							review.append("<img src=\"../images/edit.gif\" alt=\"edit comment\" onclick=\"return aseSubmitClick0('"+kix+"',"+sq+","+en+","+qn+","+acktion+","+id+");\">&nbsp;&nbsp;"
								+ "<img src=\"../images/del.gif\" alt=\"delete comment\" onclick=\"return aseSubmitClick1('"+kix+"',"+sq+","+en+","+qn+","+acktion+","+id+");\">");
						}
					}
				}

				review.append("&nbsp;</td>"
					+ "<td class=datacolumn width=\"62%\" valign=\"top\">" + comments + "</td>"
					+ "<td class=datacolumn width=\"15%\" nowrap valign=\"top\">" + reviewer + "</td>"
					+ "<td class=datacolumn width=\"15%\" nowrap valign=\"top\">" + dte + "</td>"
					+ "</tr>" );

				++i;
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" cellpadding=\"1\" width=\"100%\">"
					+ "<tr bgcolor=\"#E1E1E1\">"
					+ "<td class=textblackth>&nbsp;</td>"
					+ "<td class=textblackth>Comments</td>"
					+ "<td class=textblackth>UserID</td>"
					+ "<td class=textblackth>Date</td>"
					+ "</tr>"
					+ review.toString()
					+ "</table>";
			}
			else
				temp = "data not found";

		} catch (SQLException e) {
			logger.fatal("ReviewerDB: getReviewsForEdit - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewerDB: getReviewsForEdit - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getReviewerNames
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String
	 */
	public static String getReviewInviter(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String inviter = "";

		try {

			String progress = CourseDB.getCourseItem(conn,kix,"progress");
			String subprogress = CourseDB.getCourseItem(conn,kix,"subprogress");

			//
			// during proposal, reviews are kicked off by proposer. For review within approval, it's anyone
			// involved in review.
			//

			if(progress.equals("APPROVAL") && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
				//
				// for review in approval, multiple people may send out review requests so
				// having an inviter would not work because it wont' pull in reviewers for all
				// reviewers. set to blank to force caller to get all names
				//

				/*
				String sql = "select distinct inviter from tblreviewers where campus=? and progress=? and historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_REVIEW_IN_APPROVAL);
				ps.setString(3,kix);
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					inviter = rs.getString("inviter");
				}
				rs.close();
				ps.close();
				*/

				inviter = "";
			}
			else{
				inviter = CourseDB.getCourseItem(conn,kix,"proposer");
			}


		} catch (SQLException se) {
			logger.fatal("ReviewerDB.getReviewInviter: " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB.getReviewInviter: " + e.toString());
		}

		return inviter;
	}

	/**
	 * Count number of reviewer comments for each item
	 * <p>
	 * @param conn 	Connection
	 * @param kix		String
	 * @param sq		int
	 * @param en		int
	 * @param qn		int
	 * @param source	int	(tab is foundation)
	 * @param acktion	int
	 * <p>
	 * @return long
	 */
	public static long countReviewerComments(Connection conn,String kix,int sq,int en,int qn,int source,int acktion) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lRecords = 0;
		int pid = 0;
		String sql = "";
		PreparedStatement ps = null;

		try {

			if(sq == 0 && en == 0 && qn == 0){
				sql = "SELECT count(historyid) FROM vw_ReviewerHistory WHERE historyid=? ";
			}
			else{
				sql = "SELECT count(historyid) FROM vw_ReviewerHistory WHERE historyid=? AND sq=? AND en=? AND qn=? ";
			}

			if (source > 0){
				sql = sql + " AND source=? ";
			}

			if (acktion > 0){
				sql = sql + " AND acktion=? ";
			}

			ps = conn.prepareStatement(sql);
			ps.setString(++pid,kix);

			if(sq == 0 && en == 0 && qn == 0){
				//
			}
			else{
				ps.setInt(++pid,sq);
				ps.setInt(++pid,en);
				ps.setInt(++pid,qn);
			}

			if (source > 0){
				ps.setInt(++pid,source);
			}

			if (acktion > 0){
				ps.setInt(++pid,acktion);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				lRecords = NumericUtil.getLong(rs.getLong(1),0);
			}

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ReviewerDB: countReviewerComments - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ReviewerDB: countReviewerComments - " + e.toString());
		}

		return lRecords;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}