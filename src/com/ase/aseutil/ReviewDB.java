/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * public static int insertReview(Connection connection,Review Review,String tb,int mode) {
 *	public static boolean isReviewAllowed(Connection conn,String campus,String alpha,String num,String user,String message) throws SQLException {
 *	public static String showReviews(Connection conn,String campus,String user,int idx){
 *	public static int updateReview(Connection conn,Review review) {
 *
 * @author ttgiang
 */

//
// ReviewDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class ReviewDB {

	static Logger logger = Logger.getLogger(ReviewDB.class.getName());

	public ReviewDB() throws Exception {}

	/**
	 * security insertReview
	 * <p>
	 * @param	connection	Connection
	 * @param	review		Review
	 * @param	tb				String
	 * @param	mode			int
	 * <p>
	 * @return int
	 */
	public static int insertReview(Connection connection,Review review,String tb,int mode) {

		int item = 0;
		int loggedItem = 0;
		int rowsAffected = 0;

		boolean debug = false;

		String kix = "";

		try {

			debug = DebugDB.getDebug(connection,"ReviewDB");

			if (debug) logger.info("--------------------- START");

			kix = review.getHistory();

			boolean isAProgram = ProgramsDB.isAProgram(connection,kix);
			boolean foundation = com.ase.aseutil.fnd.FndDB.isFoundation(connection,kix);

			String campus = review.getCampus();

			item = NumericUtil.nullToZero(review.getItem());
			loggedItem = NumericUtil.nullToZero(review.getItem());

			//
			// figure out the correct item number based on the tab this data is coming from
			//
			if (!isAProgram && !foundation){
				if (tb.equals("2")){
					int maxNo = CourseDB.countCourseQuestions(connection,campus,"Y","",Constant.TAB_COURSE);
					loggedItem = maxNo + loggedItem;
				}
			}

			//
			//	enable for reviewhist is different from enable for question.
			//	review history keeps track of who it is that enabled the item to prevent others from
			//	turning it off.
			//
			// question saves enable to edit1 in courses so we know what to enable for modifications.
			//

			// ER18 - add to message board or review history
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","EnableMessageBoard");

			if (debug){
				logger.info("kix: " + kix);
				logger.info("isAProgram: " + isAProgram);
				logger.info("foundation: " + foundation);
				logger.info("campus: " + campus);
				logger.info("item: " + item);
				logger.info("loggedItem: " + loggedItem);
				logger.info("enableMessageBoard: " + enableMessageBoard);
			}

			if (enableMessageBoard.equals(Constant.ON)){
				ForumDB.insertReview(connection,review,tb,mode);
			}
			else{
				String sql = "INSERT INTO "
					+ "tblReviewHist(historyid,coursealpha,coursenum,item,dte,campus,reviewer,comments,source,acktion,enabled,sq,en,qn) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1,kix);
				preparedStatement.setString(2,review.getAlpha());
				preparedStatement.setString(3,review.getNum());
				preparedStatement.setInt(4, item);
				preparedStatement.setString(5,review.getAuditDate());
				preparedStatement.setString(6,campus);
				preparedStatement.setString(7,review.getUser());
				preparedStatement.setString(8,review.getComments());
				preparedStatement.setString(9,tb);
				preparedStatement.setInt(10,mode);
				preparedStatement.setBoolean(11, review.getEnable());
				preparedStatement.setInt(12,review.getSq());
				preparedStatement.setInt(13,review.getEn());
				preparedStatement.setInt(14,review.getQn());
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();
			}

			if (debug) logger.info("inserted");

			if (foundation){
				AseUtil.logAction(connection,
										review.getUser(),
										"ACTION",
										"Review logged (item #" + review.getSq() + "_" + review.getEn() + "_" + review.getQn() + ") ",
										review.getAlpha(),
										review.getNum(),
										review.getCampus(),
										kix);
				if (debug) logger.info("logged foundation");
			}
			else if (isAProgram){
				AseUtil.logAction(connection,
										review.getUser(),
										"ACTION",
										"Review logged (" + review.getAlpha() + " " + review.getNum() + ") ",
										"#" + loggedItem,
										"",
										review.getCampus(),
										kix);
				if (debug) logger.info("logged program");
			}
			else{
				AseUtil.logAction(connection,
										review.getUser(),
										"ACTION",
										"Review logged (item #" + loggedItem + ") ",
										review.getAlpha(),
										review.getNum(),
										review.getCampus(),
										kix);
				if (debug) logger.info("logged course");
			}

			//
			//	0 is available when an item has been enabled but not by current user.
			//	send in 0 to prevent the clearing of enabled fields
			//
			//	NOT IN USE. Has errors
			//
			if (item > 0){
				if (foundation){
					//
				}
				else if (isAProgram){
					rowsAffected = QuestionDB.setProgramEnabledItems(connection,
																					review.getCampus(),
																					kix,
																					item,
																					review.getEnable(),
																					tb);
				}
				else{
					rowsAffected = QuestionDB.setCourseEnabledItems(connection,
																					review.getCampus(),
																					review.getAlpha(),
																					review.getNum(),
																					item,
																					review.getEnable(),
																					tb);
				}
			} // item > 0

			if (debug){
				logger.info("ReviewDB - insertReview: "
								+ kix
								+ " - "
								+ review.getUser()
								+ " - item # "
								+ item);
			}

			if (debug) logger.info("--------------------- END");

		} catch (SQLException e) {
			logger.fatal("ReviewDB.insertReview ("+kix+"): " + e.toString() + "\n" + review);
		} catch (Exception e) {
			logger.fatal("ReviewDB.insertReview ("+kix+"): " + e.toString() + "\n" + review);
		}
		return rowsAffected;
	}

	/*
	 * A course is cancallable only if: edit flag = true and progress = modify
	 * and canceller = proposer
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	user		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isReviewAllowed(Connection conn,
														String campus,
														String alpha,
														String num,
														String user,
														String message) throws SQLException {
		boolean reviewAllowed = false;

		reviewAllowed = TaskDB.isMatch(conn,user,alpha,num,message,campus);

		return reviewAllowed;
	}

	/*
	 * showReviews
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showReviews(Connection conn,String campus,String user,int idx){

		//Logger logger = Logger.getLogger("test");

		//
		// READ ME
		//
		// identical to above function with the exception of output going to a table
		// then ready in to FlexTable;
		//

		StringBuffer listing = new StringBuffer();
		String kix = null;
		String alpha = null;
		String num = null;
		String reviewDate = null;
		String proposer = null;
		String inviter = null;
		String progress = null;
		String subprogress = null;
		String linkOutline = null;
		String linkComments = null;
		String progressType = null;

		boolean found = false;

		String rowColor = "";
		String temp = "";

		int j = 0;

		try{
			AseUtil au = new AseUtil();

			String sql = "SELECT DISTINCT coursealpha,coursenum,reviewdate,proposer,historyid,inviter,progress,subprogress "
							+ "FROM "
							+ "("
							+ "SELECT r.campus, c.CourseAlpha, c.CourseNum, r.userid, c.reviewdate, c.proposer, c.historyid, r.inviter, c.Progress, c.subprogress "
							+ "FROM tblCourse AS c RIGHT OUTER JOIN "
							+ "tblReviewers AS r ON c.CourseAlpha = r.coursealpha AND c.CourseNum = r.coursenum AND c.campus = r.campus "
							+ "WHERE (c.CourseType = 'PRE' AND c.Progress = 'REVIEW') "
							+ "OR (c.CourseType = 'PRE' AND c.Progress = 'APPROVAL' AND c.subprogress = 'REVIEW_IN_APPROVAL') "
							+ ") AS vw_ReviewStatus "
							+ "WHERE campus=? ";

			if (idx>0)
				sql += "AND coursealpha like '" + (char)idx + "%' ";

			sql += "ORDER BY coursealpha,coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				inviter = AseUtil.nullToBlank(rs.getString("inviter"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				reviewDate = au.ASE_FormatDateTime(rs.getString("reviewdate"),Constant.DATE_SHORT);

				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL))
					progressType = "Review within Approval";
				else if (progress.equals(Constant.COURSE_REVIEW_TEXT))
					progressType = "Review";

				linkOutline = "vwcrsy.jsp?pf=1&kix=" + kix;
				linkComments = "?kix=" + kix;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td width=\"10%\">"
					+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
					+ "<a href=\"crsrvwstsh.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin100','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" border=\"0\" alt=\"view reviewer comments\"></a>&nbsp;&nbsp;"
					+ "<a href=\"crsrvwstsp.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin101','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/people.gif\" border=\"0\" alt=\"view reviewers\"></a>&nbsp;&nbsp;&nbsp;&nbsp;");
				listing.append("</td>");
				listing.append("<td class=\"datacolumn\">" + alpha + " " + num + "</td>"
									+ "<td class=\"datacolumn\">" + proposer + "</td>"
									+ "<td class=\"datacolumn\">" + progressType + "</td>"
									+ "<td class=\"datacolumn\">" + inviter + "</td>"
									+ "<td class=\"datacolumn\">" + reviewDate + "</td>"
									+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ReviewDB: showReviews - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ReviewDB: showReviews - " + ex.toString());
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\"><td class=\"textblackTH\" width=\"10%\">&nbsp;</td>" +
						"<td class=\"textblackTH\" width=\"15%\">Outline</td>" +
						"<td class=\"textblackTH\" width=\"15%\">Proposer</td>" +
						"<td class=\"textblackTH\" width=\"20%\">Progress</td>" +
						"<td class=\"textblackTH\" width=\"20%\">Initiated By</td>" +
						"<td class=\"textblackTH\" width=\"20%\">Review By Date</td>" +
						"</tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "Outline not found";

		return temp;
	}

	/*
	 * showReviewsJQuery
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 */
	public static void showReviewsJQuery(Connection conn,String campus,String user,int idx){

		showReviewsJQuery(conn,campus,user,idx,false);

	}

	public static void showReviewsJQuery(Connection conn,String campus,String user,int idx,boolean foundation){

		//Logger logger = Logger.getLogger("test");

		//
		// READ ME
		//
		// identical to above function with the exception of output going to a table
		// then ready in to FlexTable;

		String temp = "";
		int rowsAffected = 0;

		try{
			AseUtil au = new AseUtil();

			String table = "tblCourse";
			String type = "CourseType";
			String suffix = "crs";

			if(foundation){
				table = "tblfnd";
				type = "type";
				suffix = "fnd";
			}

			// clear out existing data for user
			com.ase.aseutil.report.ReportingStatusDB rsdb = new com.ase.aseutil.report.ReportingStatusDB();
			rowsAffected = rsdb.delete(conn,user);

			String sql = "SELECT DISTINCT coursealpha,coursenum,reviewdate,proposer,historyid,inviter,progress,subprogress, [level] "
							+ "FROM "
							+ "("
							+ "SELECT r.campus, c.CourseAlpha, c.CourseNum, r.userid, c.reviewdate, c.proposer, c.historyid, r.inviter, c.Progress, c.subprogress, r.level "
							+ "FROM "+table+" AS c RIGHT OUTER JOIN "
							+ "tblReviewers AS r ON c.CourseAlpha = r.coursealpha AND c.CourseNum = r.coursenum AND c.campus = r.campus "
							+ "WHERE (c."+type+" = 'PRE' AND c.Progress = 'REVIEW') "
							+ "OR (c."+type+" = 'PRE' AND c.Progress = 'APPROVAL' AND c.subprogress = 'REVIEW_IN_APPROVAL') "
							+ ") AS vw_ReviewStatus "
							+ "WHERE campus=? ";

			if (idx>0)
				sql += "AND coursealpha like '" + (char)idx + "%' ";

			sql += "ORDER BY coursealpha,coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String inviter = AseUtil.nullToBlank(rs.getString("inviter"));
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				int level = NumericUtil.getInt(rs.getInt("level"),1);

				String progressType = "";

				String reviewDate = au.ASE_FormatDateTime(rs.getString("reviewdate"),Constant.DATE_SHORT);

				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
					progressType = "Review within Approval";
				}
				else if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					progressType = "Review";
				}

				String linkOutline = "";

				if(foundation){
					linkOutline = "vwpdf.jsp?kix=" + kix;
				}
				else{
					linkOutline = "vwcrsy.jsp?pf=1&kix=" + kix;
				}

				String linkComments = "?kix=" + kix + "&lvl=" + level;

				String links = "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
						+ "<a href=\"crsrvwstsh.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin100','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" border=\"0\" alt=\"view reviewer comments\"></a>&nbsp;&nbsp;"
						+ "<a href=\""+suffix+"rvwstsp.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin101','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/people.gif\" border=\"0\" alt=\"view reviewers\"></a>&nbsp;&nbsp;&nbsp;&nbsp;";

				rowsAffected = rsdb.insert(conn,new com.ase.aseutil.report.ReportingStatus(user,
																													links,
																													alpha + " " + num,
																													progressType,
																													proposer,
																													inviter,
																													reviewDate,
																													"",
																													"",
																													""+level,
																													Constant.REVIEWS,
																													kix));


			}
			rs.close();
			ps.close();

			rsdb = null;
		}
		catch(SQLException sx){
			logger.fatal("ReviewDB: showReviewsJQuery - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ReviewDB: showReviewsJQuery - " + ex.toString());
		}
	}

	/*
	 * showReviewProgramJQuery
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 */
	public static void showReviewProgramJQuery(Connection conn,String campus,String user,int idx){

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		int rowsAffected = 0;

		try{
			AseUtil au = new AseUtil();

			// clear out existing data for user
			com.ase.aseutil.report.ReportingStatusDB rsdb = new com.ase.aseutil.report.ReportingStatusDB();
			rowsAffected = rsdb.delete(conn,user);

			String sql = "SELECT DISTINCT campus, title, reviewdate, proposer, historyid, inviter, progress, subprogress, divisioncode, degreecode "
				+ "FROM ("
				+ "SELECT DISTINCT c.campus, c.title, c.reviewdate, c.proposer, c.historyid, r.inviter, c.progress, c.subprogress, td.divisioncode, tp.alpha AS degreecode "
				+ "FROM tblPrograms AS c INNER JOIN "
				+ "tblDivision td ON c.divisionid = td.divid INNER JOIN "
				+ "tblprogramdegree tp ON c.degreeid = tp.degreeid RIGHT OUTER JOIN "
				+ "tblReviewers AS r ON c.campus = r.campus AND c.historyid = r.historyid "
				+ "WHERE (c.type = 'PRE' AND c.progress = 'REVIEW') OR "
				+ "(c.type = 'PRE' AND c.progress = 'APPROVAL' AND c.subprogress = 'REVIEW_IN_APPROVAL') "
				+ ") AS vw_ReviewStatus "
				+ "WHERE campus=? ";

			if (idx>0)
				sql += "AND title like '" + (char)idx + "%' ";

			sql += "ORDER BY title";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String inviter = AseUtil.nullToBlank(rs.getString("inviter"));
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				String divisioncode = AseUtil.nullToBlank(rs.getString("divisioncode"));
				String degreecode = AseUtil.nullToBlank(rs.getString("degreecode"));
				String reviewDate = au.ASE_FormatDateTime(rs.getString("reviewdate"),Constant.DATE_SHORT);

				String progressType = "";

				if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) && subprogress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){
					progressType = "Review within Approval";
				}
				else if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
					progressType = "Review";
				}

				String linkProgram = "/centraldocs/docs/programs/"+campus.toUpperCase()+"/"+kix+".html";
				String linkComments = "?kix=" + kix;

				String links = "<a href=\"" + linkProgram + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
						+ "<a href=\"prgrvwstsh.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin100','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" border=\"0\" alt=\"view reviewer comments\"></a>&nbsp;&nbsp;"
						+ "<a href=\"prgrvwstsp.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin101','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/people.gif\" border=\"0\" alt=\"view reviewers\"></a>&nbsp;&nbsp;&nbsp;&nbsp;";

				rowsAffected = rsdb.insert(conn,new com.ase.aseutil.report.ReportingStatus(user,
																													links,
																													title,
																													progressType,
																													proposer,
																													inviter,
																													"",
																													reviewDate,
																													divisioncode,
																													degreecode,
																													Constant.REVIEWS));


			}
			rs.close();
			ps.close();

			rsdb = null;
		}
		catch(SQLException sx){
			logger.fatal("ReviewDB: showReviewProgramJQuery - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ReviewDB: showReviewProgramJQuery - " + ex.toString());
		}
	}

	/**
	 * updateReview
	 * <p>
	 * @param	conn		Connection
	 * @param	review	Review
	 * <p>
	 * @return int
	 */
	public static int updateReview(Connection conn,Review review) {

		int rowsAffected = 0;

		try {
			AseUtil aseUtil = new AseUtil();
			String sql = "UPDATE tblReviewHist "
				+ "SET comments=?,reviewer=?,dte=?,enabled=? "
				+ "WHERE id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,review.getComments());
			ps.setString(2,review.getUser());
			ps.setString(3,aseUtil.getCurrentDateTimeString());
			ps.setBoolean(4, review.getEnable());
			ps.setInt(5,review.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
			aseUtil = null;
			logger.info("ReviewDB - updateReview: " + review.getHistory() + " - " + review.getUser());
		} catch (SQLException e) {
			logger.fatal("ReviewDB - updateReview: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewDB - deleteReview: " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteReview
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return int
	 */
	public static int deleteReview(Connection conn,int id) {

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblReviewHist WHERE id=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewDB - deleteReview: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewDB - deleteReview: " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getReviewItems - returns list of programs or outlines to review for user
	 * <p>
	 * @param	conn		Connection
	 * @param	item		String
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return List
	 */
	public static List<Generic> getReviewItems(Connection conn,String item,String campus,String user) {

		List<Generic> genericData = null;

		try {
			if (genericData == null){

				AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "";

				if(item.equals(Constant.COURSE)){
					sql = "SELECT tc.proposer, tc.coursetitle as title, tr.coursealpha as alpha, tr.coursenum as num, tr.historyid, tc.reviewdate, '' as degree, '' as divisioncode, '' as fndtype, '' as coproposer  "
							+ "FROM tblReviewers tr INNER JOIN tblCourse tc ON tr.historyid = tc.historyid "
							+ "WHERE (tc.campus=?) AND (tr.userid=?)";
				} // course
				else if(item.equals(Constant.PROGRAM)){
					sql = "SELECT tc.proposer, tc.title, tr.coursealpha as alpha, tr.coursenum as num, tr.historyid, tc.reviewdate, tp.alpha as degree, td.divisioncode, '' as fndtype, '' as coproposer "
							+ "FROM tblReviewers AS tr INNER JOIN "
							+ "tblPrograms AS tc ON tr.historyid = tc.historyid INNER JOIN "
							+ "tblprogramdegree tp ON tc.degreeid = tp.degreeid INNER JOIN "
							+ "tblDivision td ON tc.divisionid = td.divid "
							+ "WHERE (tc.campus=?) AND (tr.userid=?)";
				} // program
				else if(item.equals(Constant.FOUNDATION)){
					sql = "SELECT tc.proposer, tc.coursetitle as title, tr.coursealpha as alpha, tr.coursenum as num, tr.historyid, tc.reviewdate, '' as degree, '' as divisioncode, tc.fndtype, tc.coproposer  "
							+ "FROM tblReviewers tr INNER JOIN tblfnd tc ON tr.historyid = tc.historyid "
							+ "WHERE (tc.campus=?) AND (tr.userid=?)";
				} // foundation

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("historyid")),
											AseUtil.nullToBlank(rs.getString("proposer")),
											AseUtil.nullToBlank(rs.getString("title")),
											AseUtil.nullToBlank(rs.getString("alpha")),
											AseUtil.nullToBlank(rs.getString("num")),
											ae.ASE_FormatDateTime(rs.getString("reviewdate"),Constant.DATE_DATETIME),
											AseUtil.nullToBlank(rs.getString("degree")),
											AseUtil.nullToBlank(rs.getString("divisioncode")),
											AseUtil.nullToBlank(rs.getString("fndtype")),
											AseUtil.nullToBlank(rs.getString("coproposer"))
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getgenericData\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("BannerDB: getgenericData\n" + e.toString());
		}

		return genericData;
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
	public static ArrayList getHistories(Connection connection,String kix,String type) {

		return getHistories(connection,kix,type,"");
	}

	public static ArrayList getHistories(Connection connection,String kix,String type,String inviter) {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		ArrayList<Review> list = new ArrayList<Review>();

		try {
			String sql = "";
			String table = "";

			if (type.equals("PRE"))
				table = "tblReviewHist";
			else
				table = "tblReviewHist2";

			sql = "SELECT id, reviewer, dte, comments, item FROM " + table + " WHERE historyid=? ORDER BY dte, item";

			Review review;
			AseUtil aseUtil = new AseUtil();

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				review = new Review();
				review.setId(NumericUtil.nullToZero(rs.getString("id")));
				review.setUser(AseUtil.nullToBlank(rs.getString("reviewer")));
				review.setAuditDate(AseUtil.nullToBlank(aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_SHORT)));
				review.setComments(aseUtil.nullToBlank(rs.getString("comments")));
				review.setItem(NumericUtil.nullToZero(rs.getString("item")));
				list.add(review);
			}
			rs.close();
			ps.close();

			aseUtil = null;

		} catch (SQLException e) {
			logger.fatal("ReviewDB: getHistories - " + e.toString());
			list = null;
		} catch (Exception ex) {
			logger.fatal("ReviewDB: getHistories - " + ex.toString());
			list = null;
		}

		return list;
	}

	/**
	 * getReviewProgress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 * @return String
	 */
	public static String getReviewProgress(Connection conn,String campus,String kix,String user) {

		//Logger logger = Logger.getLogger("test");

		String progress = "REVIEW";

		try {
			String sql = "select distinct progress from tblreviewers where campus=? and historyid=? and inviter=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				progress = AseUtil.nullToBlank(rs.getString("progress"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewDB - getReviewProgress: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewDB - getReviewProgress: " + ex.toString());
		}

		return progress;
	}

	/**
	 * getReviewByDate
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * <p>
	 * @return String
	 */
	public static String getReviewByDate(Connection conn,String campus,String kix,String user) {

		//Logger logger = Logger.getLogger("test");

		String duedate = "";

		try {
			duedate = CourseDB.getCourseItem(conn,kix,"reviewdate");

			String sql = "select distinct duedate from tblreviewers where campus=? and historyid=? and inviter=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				AseUtil aseUtil = new AseUtil();
				duedate = aseUtil.ASE_FormatDateTime(rs.getString("duedate"),Constant.DATE_SHORT);
				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ReviewDB - getReviewByDate: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ReviewDB - getReviewByDate: " + ex.toString());
		}

		return duedate;
	}

	/**
	 *
	 */
	public void close() throws SQLException {}

}