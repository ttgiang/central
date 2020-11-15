/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static boolean approvalAlreadyInProgress(Connection conn,String kix) {
 *	public static int addApprovalRouting(Connection conn,String campus,String user,String shortName,String longName){
 *	public static int copyApprovalRouting(Connection conn,String campus,String user,String shortName,String longName,int oldRoute){
 *	public static long countApprovalsByRoute(Connection conn,String campus,int route){
 *	public static long countApprovalHistory(Connection,String)
 *	public static int deleteApprover(Connection,String id)
 *	public static int deleteApprovalRouting(Connection conn,String campus,int route){
 * public static String displayApproversBySeq(Connection conn,String campus,int seq)
 * public static String displayFastTrackApprovers(Connection conn,String campus,String kix)
 * public static boolean distributionApprovalCompleted(Connection conn,String campus,String kix,String dist)
 *	public static int fastTrackApprovers(Connection conn,String campus,String kix,int seq,int lastSeq){
 * public static String getApprovalHistory(Connection connection,String kix) throws Exception
 * public static int getApprovalRouting(Connection connection,String campus,String kix)
 *	public static Approver getApprover(Connection,String aid)
 * public static Approver getApprover(Connection conn, int id)
 *	public static Approver getApprovers(Connection,String,String,String,boolean) throws Exception
 *	public static Approver getApprovers(Connection,String,String,String,String,boolean) throws Exception
 *	public static int getApproverCount(Connection,String campus,int sequence)
 *	public static int getApproverSequence(Connection,String aid,int route)
 *	public static String getApproverByDelegateName(Connection,String,String campus,String approver) throws Exception
 *	public static Approver getApproverByName(Connection,String,String,String) throws Exception
 *	public static Approver getApproverByNameAndSequence(Connection conn,String campus,String alpha,String num,String user,int route,int sequence) throws Exception {
 * public static String getApproversByRoute(Connection conn,String campus,int route)
 * public static String getApproverBySeq(Connection conn,String campus,int seq,int route)
 * public static String getApproversBySeq(Connection conn,String campus,int seq,int route)
 *	public static String getApproverNames(Connection,String,String,String) throws Exception
 *	public static String getApproverNamesByAlpha(Connection,String,String alpha) throws Exception
 * public static String getApproverWhoKickedOffReview(Connection conn,String campus,String kix) throws Exception {
 *	public static String getCurrentApprover(Connection conn,String campus,String alpha,String num) throws Exception {
 *	public static String getDelegateByApproverName(Connection,String,String campus,String approver) throws Exception
 * public static String getDivisionChairApprover(Connection conn,String campus,String alpha) throws SQLException
 *	public static String getHistoryApproverBySeq(Connection conn,String campus,String alpha,String num,int seq){
 *	public static int getLastApproverSequence(Connection conn,String campus,String kix){
 *	public static String getLastPersonToApprove(Connection,String,String,String,int)
 *	public static int getLastPersonToApproveSeq(Connection conn,String campus,String alpha,String num){
 *	public static String getNextPersonToApprove(Connection,String,String,String)
 *	public static int getNumberOfRoutes(Connection conn,String campus) throws Exception {
 *	public static String getRoutingFullNameByID(Connection conn,String campus,int route) throws Exception {
 *	public static int getRoutingIDByName(Connection conn,String campus,String approval) throws Exception {
 *	public static String getRoutingInUse(Connection conn,String campus,int route){
 *	public static String getRoutingNameByID(Connection conn,String campus,int route) throws Exception {
 * public static int getSequenceNotApproved(Connection conn,String campus,String kix) throws Exception {
 *	public static boolean hasApprovalTask(Connection conn,String campus,String alpha,String num,String user) throws Exception {
 *	public static boolean isLastApprover(Connection conn,String campus,String user,int route){
 *	public static boolean isRoutingOutOfSequence(Connection conn,String campus,int route) {
 *	public static int insertApprover(Connection,Approver)
 *	public static boolean isMatch(Connection,String,String,String) throws SQLException
 *	public static boolean lastApproverVotedNO(Connection conn,String campus,String kix) throws Exception {
 *	public static int maxApproverSeqID(Connection,String)
 *	public static String showApprovers(Connection conn,String campus)
 *	public static String showApproversByDivisions(Connection conn,String campus)
 *	public static String showApproversDateInput(Connection conn,String campus,int route){
 *	public static String showApprovalProgress(Connection,String,String,int)
 *	public static String showApprovalRouting(Connection conn,String campus,int idx){
 *	public static String showCompletedApprovals(Connection conn,String campus,String alpha,String num)
 *	public static String showPendingApprovals(Connection conn,String campus,String alpha,String completed,int route)
 *	public static String showRejectedApprovalSelection(Connection conn,String campus){
 *	public static int updateApprover(Connection,Approver)
 *	public static Msg updateApprovalDates(Connection conn,HttpServletRequest request,String campus,int route){
 *	public static int updateRouting(Connection conn,String kix,String user,int route){
 *
 */

//
// ApproverDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class ApproverDB {

	static Logger logger = Logger.getLogger(ApproverDB.class.getName());

	static boolean debug = false;

	/*
	 * ApproverDB
	 *	<p>
	 */
	public ApproverDB() throws Exception {}

	/*
	 * isMatch
	 *	<p>
	 * @param	connection	Connection
	 * @param	seq			String
	 * @param	user			String
	 * @param	campus		String
	 * @param	route			int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection connection,String seq,String user,String campus,int route) throws SQLException {

		boolean exists = false;

		try {
			String sql = "SELECT approverid "
				+ "FROM tblApprover "
				+ "WHERE approver_seq=? AND "
				+ "approver=? AND "
				+ "route=? AND "
				+ "campus=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,seq);
			ps.setString(2,user);
			ps.setInt(3,route);
			ps.setString(4,campus);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: isMatch - " + e.toString());
			exists = false;
		}

		return exists;
	}

	/*
	 * isMatch
	 *	<p>
	 * @param	connection	Connection
	 * @param	seq			String
	 * @param	user			String
	 * @param	campus		String
	 * @param	route			int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection connection,String user,String campus,int route) throws SQLException {

		boolean exists = false;

		// do we already have an approver by this name (user) for this route

		try {
			String sql = "SELECT approverid "
				+ "FROM tblApprover "
				+ "WHERE approver=? "
				+ "AND route=? "
				+ "AND campus=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,user);
			ps.setInt(2,route);
			ps.setString(3,campus);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: isMatch - " + e.toString());
			exists = false;
		}

		return exists;
	}

	/*
	 * maxApproverSeqID
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	<p>
	 *	@return int
	 */
	public static int maxApproverSeqID(Connection connection, String campus) {
		int maxId = 0;
		try {
			AseUtil aseUtil = new AseUtil();
			maxId = aseUtil.dbMaxValue(connection, "tblApprover", "approver_seq", campus);
			aseUtil = null;
			AseUtil.loggerInfo("ApproverDB: maxApproverSeqID (" + maxId + ")",campus,"","","");
		} catch (Exception e) {
			logger.fatal("ApproverDB: maxApproverSeqID - " + e.toString());
			return 0;
		}

		return maxId;
	}

	/*
	 * maxApproverSeqID
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 *	@return int
	 */
	public static int maxApproverSeqID(Connection conn,String campus,int route) {
		int maxId = 0;
		try {
			String sql = "SELECT MAX(approver_seq) AS MaxOfseq FROM tblApprover WHERE campus=? AND route=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				maxId = rs.getInt(1);

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: maxApproverSeqID - " + e.toString());
		}

		return maxId;
	}

	/*
	 * insertApprover
	 *	<p>
	 * @param	connection	Connection
	 * @param	approver		Approver
	 * @param	applyDate	int
	 *	<p>
	 *	@return int
	 */
	public static int insertApprover(Connection conn, Approver approver) {

		return insertApprover(conn,approver,0);
	}

	public static int insertApprover(Connection conn,Approver approver,int applyDate) {

		int rowsAffected = 0;

		String sql = "";

		PreparedStatement ps = null;

		try {
			if (!isMatch(conn,approver.getSeq(),approver.getApprover(),approver.getCampus(),approver.getRoute())){
				sql = "INSERT INTO tblApprover "
					+ "(approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,campus,route,availabledate,startdate,enddate) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, approver.getSeq());
				ps.setString(2, approver.getApprover());
				ps.setString(3, approver.getDelegated());
				ps.setBoolean(4, approver.getMultiLevel());
				ps.setBoolean(5, approver.getExcludeFromExperimental());
				ps.setString(6, approver.getLanid());
				ps.setString(7, approver.getDte());
				ps.setString(8, approver.getCampus());
				ps.setInt(9, approver.getRoute());
				ps.setString(10,approver.getAvailableDate());
				ps.setString(11,approver.getStartDate());
				ps.setString(12,approver.getEndDate());
				rowsAffected = ps.executeUpdate();
				ps.close();

				/*
					coming from appr.jsp, thie flag tells CC to apply this endDate to all approvals
					by this user
				*/
				if (applyDate == 1){
					sql = "UPDATE tblApprover SET enddate=? WHERE campus=? AND approver=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,approver.getEndDate());
					ps.setString(2,approver.getCampus());
					ps.setString(3,approver.getApprover());
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}
		} catch (SQLException e) {
			logger.fatal("ApproverDB: insertApprover - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * deleteApprover
	 * <p>
	 * @param	connection	Connection
	 * @param	id				String
	 * @param	route			int
	 * <p>
	 * @return int
	 */
	public static int deleteApprover(Connection connection,String id,int route) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblApprover "
				+ "WHERE approverid=? AND route=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,id);
			ps.setInt(2,route);
			rowsAffected = ps.executeUpdate();
			AseUtil.loggerInfo("ApproverDB: deleteApprover (" + rowsAffected + ")",id,"","","");
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB: deleteApprover - " + e.toString());
			return 0;
		}

		return rowsAffected;
	}

	/*
	 * updateApprover
	 *	<p>
	 * @return int
	 */
	public static int updateApprover(Connection connection, Approver approver) {

		return updateApprover(connection,approver,0);

	}

	public static int updateApprover(Connection connection,Approver appr,int applyDate) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String sql = "";

		PreparedStatement ps = null;

		String approver = Constant.BLANK;
		String delegated = Constant.BLANK;
		String campus = Constant.BLANK;
		int route = 0;
		int seq = 0;

		String currentDelegate = "";

		try {
			approver = appr.getApprover();
			delegated = appr.getDelegated();
			campus = appr.getCampus();
			route = appr.getRoute();
			seq = Integer.parseInt(appr.getSeq());

			// set dates appropriately
			if (appr.getEndDate() == null || appr.getEndDate().length() == 0)
				appr.setEndDate(null);

			if (appr.getStartDate() == null || appr.getStartDate().length() == 0)
				appr.setStartDate(null);

			// who is the current approver at this sequence. if there is a name change,
			// let's make notifications
			String currentApprover = getApproverBySeq(connection,campus,seq,route);

			try{
				currentDelegate = getDelegateByApproverName(connection,campus,currentApprover,route);
			}
			catch(Exception e){
				logger.fatal("ApproverDB: updateApprover - " + e.toString());
			}

			//System.out.println("------------------------");
			//System.out.println("approver: " + approver);
			//System.out.println("delegated: " + delegated);
			//System.out.println("currentApprover: " + currentApprover);
			//System.out.println("currentDelegate: " + currentDelegate);

			sql = "UPDATE tblApprover "
				+ "SET approver_seq=?,approver=?,delegated=?,multilevel=?,experimental=?,addedby=?,addeddate=?,route=?, "
				+ "availabledate=?,startdate=?,enddate=? "
				+ "WHERE approverid=?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, appr.getSeq());
			ps.setString(2, approver);
			ps.setString(3, delegated);
			ps.setBoolean(4, appr.getMultiLevel());
			ps.setBoolean(5, appr.getExcludeFromExperimental());
			ps.setString(6, appr.getLanid());
			ps.setString(7, appr.getDte());
			ps.setInt(8, route);
			ps.setString(9,appr.getAvailableDate());
			ps.setString(10,appr.getStartDate());
			ps.setString(11,appr.getEndDate());
			ps.setString(12, appr.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();

			// coming from appr.jsp, this flag tells CC to apply this endDate to all approvals
			//	by this user
			if (applyDate == 1){
				sql = "UPDATE tblApprover SET enddate=? WHERE campus=? AND approver=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,appr.getEndDate());
				ps.setString(2,campus);
				ps.setString(3,approver);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			if (!currentApprover.equals(approver)){

				// include the delegate only if a change is needed. Also, make sure delegate new and old are
				// not the same. If yes, send in blanks to avoid recreate.
				if (currentDelegate.equals(delegated)){
					currentDelegate = Constant.BLANK;
					delegated = Constant.BLANK;
				}

				renameApprover(connection,campus,currentApprover,approver,currentDelegate,delegated,route);
			}

		} catch (SQLException e) {
			logger.fatal("ApproverDB: updateApprover - " + e.toString());
			return 0;
		}

		return rowsAffected;
	}

	/*
	 * renameApprover (ER00001)
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	oldApprover
	 * @param	newApprover
	 * @param	oldDelegate
	 * @param	newDelegate
	 * @param	route
	 * <p>
	 * @return int
	 */
	public static int renameApprover(Connection conn,
												String campus,
												String oldApprover,
												String newApprover,
												String oldDelegate,
												String newDelegate,
												int route){

		//Logger logger = Logger.getLogger("test");

		String kix = null;
		String alpha = null;
		String num = null;
		String submittedby = null;
		String title = null;
		String proposer = null;
		String taskMsg = Constant.APPROVAL_TEXT;

		String alphas = null;

		int rowsAffected = 0;
		int rowsRenamed = 0;

		try{
			// select all outlines where the task for approval is created for person in question (oldApprover)
			// qualifying outlines are PRE types and progress may be APPROVAL or DELETE.
			// this impact is by route that is being changed only
			String sql = "SELECT c.historyid,c.CourseAlpha,c.CourseNum,c.coursetitle,c.proposer,t.submittedby "
							+ "FROM tblTasks t INNER JOIN tblCourse c ON t.campus = c.campus "
							+ "AND t.coursealpha = c.CourseAlpha "
							+ "AND t.coursenum = c.CourseNum "
							+ "WHERE c.campus=? "
							+ "AND t.message=? "
							+ "AND c.CourseType='PRE' "
							+ "AND c.route=? "
							+ "AND t.submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,taskMsg);
			ps.setInt(3,route);
			ps.setString(4,oldApprover);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				// get all tasks for current user
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				// collect to make this additiona alphas
				if (alphas == null){
					alphas = alpha;
				}
				else{
					alphas = alphas + "," + alpha;
				}

				// remove from current user
				rowsAffected = TaskDB.logTask(conn,
														oldApprover,
														oldApprover,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);

				AseUtil.logAction(conn,
										oldApprover,
										"REMOVE",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// if new and old delegates are not same, do
				if (oldDelegate != null && oldDelegate.length() > 0 && !oldDelegate.equals(newDelegate)){
					rowsAffected = TaskDB.logTask(conn,
															oldDelegate,
															oldDelegate,
															alpha,
															num,
															taskMsg,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);

					AseUtil.logAction(conn,
											oldDelegate,
											"REMOVE",
											"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
											alpha,
											num,
											campus,
											kix);

				}// old delegate

				// add for new user
				rowsAffected = TaskDB.logTask(conn,
														newApprover,
														submittedby,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.BLANK,
														Constant.TASK_APPROVER,
														kix,
														Constant.COURSE);

				AseUtil.logAction(conn,
										newApprover,
										"ADD",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// if new and old delegates are not same, do
				if (newDelegate != null && newDelegate.length() > 0 && !newDelegate.equals(oldDelegate)){
					rowsAffected = TaskDB.logTask(conn,
															newDelegate,
															submittedby,
															alpha,
															num,
															taskMsg,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.BLANK,
															Constant.TASK_APPROVER,
															kix,
															Constant.COURSE);

					AseUtil.logAction(conn,
											newDelegate,
											"ADD",
											"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
											alpha,
											num,
											campus,
											kix);
				}

				// send notification
				MailerDB mailerDB = new MailerDB(conn,
															proposer,
															newApprover,
															newDelegate,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalRequest",
															kix,
															newApprover);

				++rowsRenamed;

			} // while
			rs.close();
			ps.close();

			// add these alphas to the user's profile
			if (alphas != null){
				int profiles = UserDB.updateUserAlphas(conn,newApprover,alphas);

				AseUtil.logAction(conn,
										newApprover,
										"ADD",
										"Added to user list of alphas",
										Util.removeDuplicateFromString(alphas),
										"",
										campus,
										kix);
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: renameApprover - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: renameApprover - " + ex.toString());
		}

		return rowsRenamed;

	} // renameApprover

	/*
	 * getApprover by approver id. Use by approver sequence
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * @param	route	int
	 * <p>
	 * @return Approver
	 */
	public static Approver getApprover(Connection conn,int id,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Approver approver = null;

		// default route is undergraduate
		if (route==0)
			route = -1;

		try {
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,route,availableDate,startdate,enddate "
				+ "FROM tblApprover WHERE approverid=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,String.valueOf(id));
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				approver = new Approver();
				approver.setApprover(AseUtil.nullToBlank(rs.getString("approver")).toUpperCase());
				approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")).toUpperCase());
				approver.setSeq(rs.getString("approver_seq"));
				approver.setMultiLevel(rs.getBoolean("multilevel"));
				approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
				approver.setLanid(rs.getString("addedby").toUpperCase());
				approver.setDte(aseUtil.ASE_FormatDateTime(rs.getString("addeddate"),Constant.DATE_DATETIME));
				approver.setRoute(rs.getInt("route"));
				approver.setAvailableDate(aseUtil.ASE_FormatDateTime(rs.getString("availableDate"),Constant.DATE_DATETIME));
				approver.setStartDate(aseUtil.ASE_FormatDateTime(rs.getString("startDate"),Constant.DATE_DATETIME));
				approver.setEndDate(aseUtil.ASE_FormatDateTime(rs.getString("endDate"),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("ApproverDB: getApprover - " + e.toString());
		}

		return approver;
	}

	/*
	 * getApprover by approver id. Use by approver sequence
	 * <p>
	 * @param	conn	Connection
	 * @param	aid	String
	 * @param	route	int
	 * <p>
	 * @return Approver
	 */
	public static Approver getApprover(Connection conn,String aid,int route) throws Exception {

		Approver approver = new Approver();

		try {
			String sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,route,availableDate,startdate,enddate "
				+ "FROM tblApprover "
				+ "WHERE approver=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,aid);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				approver.setApprover(AseUtil.nullToBlank(rs.getString("approver")).toUpperCase());
				approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")).toUpperCase());
				approver.setSeq(rs.getString("approver_seq"));
				approver.setMultiLevel(rs.getBoolean("multilevel"));
				approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
				approver.setLanid(rs.getString("addedby").toUpperCase());
				approver.setDte(rs.getString("addeddate"));
				approver.setRoute(rs.getInt("route"));

				AseUtil aseUtil = new AseUtil();

				approver.setAvailableDate(aseUtil.ASE_FormatDateTime(rs.getString("availableDate"),Constant.DATE_DATETIME));
				approver.setStartDate(aseUtil.ASE_FormatDateTime(rs.getString("startDate"),Constant.DATE_DATETIME));
				approver.setEndDate(aseUtil.ASE_FormatDateTime(rs.getString("endDate"),Constant.DATE_DATETIME));

				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: getApprover - " + e.toString());
			approver = null;
		}

		return approver;
	}

	/*
	 * getApproverCount - how many approvers for this seq
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	sequence	int
	 * @param	route		int
	 * <p>
	 * @return int
	 */

	public static int getApproverCount(Connection conn,String campus,int sequence,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// collect all approvers by this sequence. determine if distribution or not. keep count of people

		int count = 0;

		String[] names = null;

		try {
			String sql = "SELECT approver FROM tblApprover WHERE campus=? AND approver_seq=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,sequence);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String approver = AseUtil.nullToBlank(rs.getString("approver"));
				if (approver != null){
					approver = DistributionDB.expandNameList(conn,campus,approver);
					approver = approver.replace(Constant.SPACE,Constant.BLANK);
					names = approver.split(",");
					count += names.length;
				}
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: getApproverCount - " + e.toString());
		}

		return count;
	}

	/*
	 * getApproverSequence
	 * <p>
	 * @param	conn	Connection
	 * @param	aid	String
	 * @param	route	int
	 * <p>
	 * @return int
	 */
	public static int getApproverSequence(Connection conn,String aid,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int seq = 0;

		try {
			String sql = "SELECT approver_seq FROM tblApprover WHERE (approver=? OR delegated=?) AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,aid);
			ps.setString(2,aid);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				seq = NumericUtil.getInt(rs.getInt("approver_seq"),0);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB.getApproverSequence ("+aid+"/"+route+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getApproverSequence ("+aid+"/"+route+"): " + e.toString());
		}

		return seq;
	}

	/*
	 * getDelegateByApproverName
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	approver	String
	 * @param	route		int
	 * <p>
	 * @return	String
	 */
	public static String getDelegateByApproverName(Connection conn,String campus,String approver,int route) throws Exception {

		String delegated = "";

		try {
			String sql = "SELECT delegated FROM tblApprover WHERE approver=? AND route=?"				;
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,approver);
			ps.setInt(2,route);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				delegated = AseUtil.nullToBlank(results.getString("delegated"));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB.getDelegateByApproverName ("+approver+"/"+route+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getDelegateByApproverName ("+approver+"/"+route+"): " + e.toString());
		}

		return delegated;
	}

	/*
	 * getApproverByDelegateName
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	delegated	String
	 * @param	route			int
	 * <p>
	 * @return	String
	 */
	public static String getApproverByDelegateName(Connection conn,String campus,String delegated,int route) throws Exception {

		String approver = "";

		try {
			String sql = "SELECT approver FROM tblApprover WHERE delegated=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,delegated);
			ps.setInt(2,route);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				approver = AseUtil.nullToBlank(results.getString("approver"));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB.getApproverByDelegateName ("+delegated+"/"+route+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getApproverByDelegateName ("+delegated+"/"+route+"): " + e.toString());
		}

		return approver;
	}

	/*
	 * getApproverByName
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * @param	route		int
	 * <p>
	 * @return Approver
	 */
	public static Approver getApproverByName(Connection conn,String campus,String alpha,String num,String user,int route) throws Exception {

		Approver approver = null;
		boolean found = false;

		/*
			if we can't find the name, check to see if this person
			is a division chair. if so, find based on alpha/department

			1) Check by actual name. if found then true.
			2) If not found, check if it's division chair's turn.
				if yes, get the name of division and set up all values
		*/

		try {

			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate "
				+ "FROM tblApprover "
				+ "WHERE (approver=? OR delegated=?) AND route=? "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,user);
			ps.setInt(3,route);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				approver = new Approver();
				approver.setApprover(AseUtil.nullToBlank(results.getString("approver")));
				approver.setDelegated(AseUtil.nullToBlank(results.getString("delegated")));
				approver.setSeq(results.getString("approver_seq"));
				approver.setMultiLevel(results.getBoolean("multilevel"));
				approver.setExcludeFromExperimental(results.getBoolean("experimental"));
				approver.setLanid(results.getString("addedby"));
				approver.setDte(results.getString("addeddate"));

				approver.setAvailableDate(results.getString("availableDate"));
				approver.setStartDate(results.getString("startDate"));
				approver.setEndDate(results.getString("endDate"));

				found = true;
			}
			results.close();
			ps.close();

			if (!found){
				/*
					figure out who is next and if division chair, get that name and
					set as our next approver.
				*/
				approver = ApproverDB.getNextPersonToApprove(conn,campus,alpha,num,route);
				if ("DIVISIONCHAIR".equals(approver.getApprover())){
					sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate " +
						"FROM tblApprover " +
						"WHERE (approver=? OR delegated=?) AND route=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,"DIVISIONCHAIR");
					ps.setString(2,"DIVISIONCHAIR");
					ps.setInt(3,route);
					results = ps.executeQuery();
					if (results.next()) {
						String divisionChair = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
						if (divisionChair.equals(user)){
							approver = new Approver();
							approver.setApprover(divisionChair);
							approver.setDelegated(AseUtil.nullToBlank(results.getString("delegated")));
							approver.setSeq(results.getString("approver_seq"));
							approver.setMultiLevel(results.getBoolean("multilevel"));
							approver.setExcludeFromExperimental(results.getBoolean("experimental"));
							approver.setLanid(results.getString("addedby"));
							approver.setDte(results.getString("addeddate"));
							found = true;

							approver.setAvailableDate(results.getString("availableDate"));
							approver.setStartDate(results.getString("startDate"));
							approver.setEndDate(results.getString("endDate"));
						}
					}

					results.close();
					ps.close();

				} // !found
			}
		} catch (SQLException e) {
			logger.fatal("ApproverDB.getApproverByName ("+campus+"/"+alpha+"/"+num+"/"+user+"/"+route+"): " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getApproverByName ("+campus+"/"+alpha+"/"+num+"/"+user+"/"+route+"): " + e.toString());
		}

		if (!found)
			approver = null;

		return approver;
	}

	/*
	 * getApproverByNameAndSequence
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * @param	route		int
	 * @param	sequence	int
	 * <p>
	 * @return Approver
	 */
	public static Approver getApproverByNameAndSequence(Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String user,
																		int route,
																		int sequence) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Approver approver = null;

		boolean found = false;
		boolean debug = false;

		/*
			if we can't find the name in approver list, check to see if this person
			is a division chair. if so, find based on alpha/department

			1) Check by actual name. if found then true.
			2) If not found, check if it's division chair's turn.
				if yes, get the name of division and set up all values
		*/

		try {
			debug = DebugDB.getDebug(conn,"ApproverDB");

			if (debug) logger.info("----------------- getApproverByNameAndSequence - STARTS");

			if (debug){
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("user: " + user);
				logger.info("route: " + route);
				logger.info("sequence: " + sequence);
			}

			AseUtil aseUtil = new AseUtil();

			// find the person. this person may not be in the correct alpha, but is a DC so we'll let through
			String sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND (approver=? OR delegated=?) AND route=? AND approver_seq=? "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,user);
			ps.setInt(4,route);
			ps.setInt(5,sequence);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				// not needing this check because we are hitting the name right on.
				//if (user.equals(ChairProgramsDB.getChairName(conn,campus,alpha))){
					approver = new Approver();
					approver.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
					approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
					approver.setSeq(rs.getString("approver_seq"));
					approver.setMultiLevel(rs.getBoolean("multilevel"));
					approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
					approver.setLanid(rs.getString("addedby"));
					approver.setDte(rs.getString("addeddate"));

					approver.setAvailableDate(rs.getString("availableDate"));
					approver.setStartDate(rs.getString("startDate"));
					approver.setEndDate(rs.getString("endDate"));

					found = true;
				//}
			}
			rs.close();
			ps.close();

			if (!found && debug) logger.info("approver not found in sequence " + route);

			// person not found in the list at the requested sequence above.
			// is this person a DC?
			if (!found){
				/*
					figure out who is next and if division chair, get that name and
					set as our next approver.
				*/
				approver = ApproverDB.getNextPersonToApprove(conn,campus,alpha,num,route);

				if ("DIVISIONCHAIR".equals(approver.getApprover())){
					sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate " +
						"FROM tblApprover " +
						"WHERE (approver=? OR delegated=?) AND route=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,"DIVISIONCHAIR");
					ps.setString(2,"DIVISIONCHAIR");
					ps.setInt(3,route);
					rs = ps.executeQuery();
					if (rs.next()) {
						String divisionChair = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
						if (divisionChair.equals(user)){
							approver = new Approver();
							approver.setApprover(divisionChair);
							approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
							approver.setSeq(rs.getString("approver_seq"));
							approver.setMultiLevel(rs.getBoolean("multilevel"));
							approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
							approver.setLanid(rs.getString("addedby"));
							approver.setDte(rs.getString("addeddate"));

							approver.setAvailableDate(rs.getString("availableDate"));
							approver.setStartDate(rs.getString("startDate"));
							approver.setEndDate(rs.getString("endDate"));

							found = true;
						}
					}

					rs.close();
					ps.close();
				} // !found
			}

			if (!found && debug) logger.info("approver not found as DIVISIONCHAIR");

			// if still not found, possible case is program and if so, check division table
			if (!found && DivisionDB.isChair(conn,campus,num,user)){
				approver = new Approver();
				approver.setApprover(user);
				approver.setSeq("1");
				approver.setMultiLevel(false);
				found = true;
			}

			if (!found && debug) logger.info("approver not in division chair");

			// if still not found, possible case is program and if so, check division table
			if (!found && DivisionDB.isChairByAlpha(conn,campus,alpha,user)){
				approver = new Approver();
				approver.setApprover(user);
				approver.setSeq("1");
				approver.setMultiLevel(false);
				found = true;
			}

			if (!found && debug) logger.info("approver not in division chair by alpha");

			// if not found as individual, perhaps a distribution member
			if (!found){
				sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate,availableDate,startdate,enddate "
					+ "FROM tblApprover "
					+ "WHERE campus=? AND route=? AND approver_seq=? "
					+ "ORDER BY approver_seq";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				ps.setInt(3,sequence);
				rs = ps.executeQuery();
				if (rs.next()) {
					approver = new Approver();
					String temp = AseUtil.nullToBlank(rs.getString("approver"));
					approver.setApprover(temp);
					approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
					approver.setSeq(rs.getString("approver_seq"));
					approver.setMultiLevel(rs.getBoolean("multilevel"));
					approver.setExcludeFromExperimental(rs.getBoolean("experimental"));
					approver.setLanid(rs.getString("addedby"));
					approver.setDte(rs.getString("addeddate"));
					approver.setDistributionList(true);
					approver.setDistributionName(temp);

					String distributionMembers = DistributionDB.getDistributionMembers(conn,campus,approver.getApprover());
					if (distributionMembers != null && distributionMembers.length() > 0){
						if (distributionMembers.indexOf(user)>-1)
							found = true;
					}

					approver.setAvailableDate(rs.getString("availableDate"));
					approver.setStartDate(rs.getString("startDate"));
					approver.setEndDate(rs.getString("endDate"));
				}
				rs.close();
				ps.close();
			}

			if (!found && debug) logger.info("approver not in distribution list");

			// if still not found, check to see if this person has a task to approve the outline
			if (!found && ApproverDB.hasApprovalTask(conn,campus,alpha,num,user)){
				approver = ApproverDB.getApprover(conn,user,route);
				found = true;
			}

			if (!found && debug) logger.info("approver not assigned to a task");

			if (debug) logger.info("----------------- getApproverByNameAndSequence - END");

		} catch (Exception e) {
			logger.fatal("ApproverDB: getApproverByNameAndSequence - " + e.toString());
		}

		if (!found)
			approver = null;

		return approver;
	}

	/*
	 * getApprovers all approvers by campus
	 *	<p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	alpha				String
	 * @param	user				String
	 * @param	experimental	boolean
	 * @param	route				int
	 *	<p>
	 * @return Approver
	 */
	public static Approver getApprovers(Connection conn,
													String campus,
													String alpha,
													String user,
													boolean experimental,
													int route) throws Exception {

		return getApprovers(conn,campus,alpha,"",user,experimental,route);
	}

	public static Approver getApprovers(Connection conn,
													String campus,
													String alpha,
													String num,
													String user,
													boolean experimental,
													int route) throws Exception {

		return getApprovers(conn,campus,alpha,num,user,experimental,route,"");

	}

	public static Approver getApprovers(Connection conn,
													String kix,
													String user,
													boolean experimental,
													int route) throws Exception {

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[Constant.KIX_PROGRAM_TITLE];
		String num = info[Constant.KIX_PROGRAM_DIVISION];
		String campus = info[Constant.KIX_CAMPUS];

		return getApprovers(conn,campus,alpha,num,user,experimental,route,kix);
	}

	public static Approver getApprovers(Connection conn,
													String campus,
													String alpha,
													String num,
													String user,
													boolean experimental,
													int route,
													String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Approver approver = new Approver();

		int maxSeq = 0;
		int junkSeq = 0;
		int maxApproverSeqID = 0;

		String[] aApprovers = null;
		String[] aDelegates = null;
		String[] aExperiments =  null;
		String[] aSequences =  null;
		String[] aCmpleteList =  null;

		StringBuffer allApprovers = new StringBuffer();
		StringBuffer allDelegates = new StringBuffer();
		StringBuffer allExperiments = new StringBuffer();
		StringBuffer allSequences = new StringBuffer();
		StringBuffer allCompleteList = new StringBuffer();

		int arrayIndex = 0;
		int currentSeq = 0;
		int startSeq = 0;
		int nextSeq = 0;
		int prevSeq = 0;
		int lastSeq = 0;

		String temp = "";
		String thisApprover = "";
		String thisDelegated = "";
		String thisExperimental = "";
		String distName = "";
		String currentApprover = "";
		String currentDelegate = "";
		String firstApprover = "";
		String dcApprover = "";

		boolean isDistributionList = false;
		boolean approverFound = false;
		boolean isAProgram = false;
		boolean debug = false;

		String delegateAtSequence1 = "";
		String approverAtSequence1 = "";

		try{

			debug = DebugDB.getDebug(conn,"ApproverDB");

			if (debug) logger.info("--------------------------- getApprovers - START");

			user = user.toUpperCase().trim();

			// does the routing exist? It's possible that the route was deleted
			// after assignment. Yes, I should make sure it can't be deleted. :)
			if (!IniDB.doesRoutingIDExists(conn,campus,route)){
				route = IniDB.getDefaultRoutingID(conn,campus);
			}

			//
			// must have valid route number
			//
			if(route > 0){

				maxApproverSeqID = ApproverDB.maxApproverSeqID(conn,campus,route);

				user = user.toUpperCase().trim();

				maxSeq = ApproverDB.getMaxApproverSeq(conn,campus,route);

				aApprovers = new String[maxSeq];
				aDelegates = new String[maxSeq];
				aExperiments =  new String[maxSeq];
				aSequences =  new String[maxSeq];
				aCmpleteList =  new String[maxSeq];

				// is this a program?
				if (kix != null && kix.length() > 0){
					isAProgram = ProgramsDB.isAProgram(conn,kix);
				}
				else{
					kix = Helper.getKix(conn,campus,alpha,num,"PRE");
					if (kix == null || kix.length() == 0){
						isAProgram = true;
						kix = ProgramsDB.getHistoryIDFromTitle(conn,campus,alpha,"PRE");
					}
				} // kix

				if (debug){
					logger.info("campus: " + campus);
					logger.info("user: " + user);
					logger.info("kix: " + kix);
					logger.info("outline/program: " + alpha + " " + num);
					logger.info("route: " + route);
					logger.info("maxSeq: " + maxSeq);
					logger.info("maxApproverSeqID: " + maxApproverSeqID);
					logger.info("isAProgram: " + isAProgram);
				}

				//
				// course or program
				//
				if (isAProgram){

					int numberOfApproversSequenceOne = ApproverDB.getApproverCount(conn,campus,1,route);

					if (numberOfApproversSequenceOne==1){
						approverAtSequence1 = ApproverDB.getApproverBySeq(conn,campus,1,route);
						aApprovers[0] = approverAtSequence1;

						delegateAtSequence1 = ApproverDB.getDelegateBySeq(conn,campus,1,route);
						if (delegateAtSequence1 == null || delegateAtSequence1.length() == 0){
							delegateAtSequence1 = approverAtSequence1;
						}
						aDelegates[0] = delegateAtSequence1;

						currentSeq = 0;
						currentApprover = approverAtSequence1;
					}
					else{
						approverAtSequence1 = DivisionDB.getChairName(conn,campus,num);
						if (approverAtSequence1 != null && approverAtSequence1.length() > 0){
							currentSeq = 0;
							currentApprover = approverAtSequence1;
							aApprovers[0] = approverAtSequence1;

							delegateAtSequence1 = DivisionDB.getDelegated(conn,campus,num);
							if (delegateAtSequence1 == null || delegateAtSequence1.length() == 0){
								delegateAtSequence1 = approverAtSequence1;
							}

							aDelegates[0] = delegateAtSequence1;
						}
					} // numberOfApproversSequenceOne

				}
				else{

					// number of sequence handled by this next call as well
					approverAtSequence1 = ApproverDB.getFirstPersonToApprove(conn,campus,alpha,num,route);

					if (approverAtSequence1 == null || approverAtSequence1.length() == 0){
						approverAtSequence1 = ApproverDB.approverAtSequenceOne(conn,campus,alpha,num);
					} // approverAtSequence1 == null

					if (approverAtSequence1 != null && approverAtSequence1.length() > 0){
						currentSeq = 0;
						currentApprover = approverAtSequence1;
						aApprovers[0] = approverAtSequence1;

						// with approver at sequence 1, it's easier now to find delegate
						delegateAtSequence1 = ApproverDB.getDelegateByApproverName(conn,campus,approverAtSequence1,route);
						if (delegateAtSequence1 != null && delegateAtSequence1.length() > 0){
							aDelegates[0] = delegateAtSequence1;
						}
						else{
							delegateAtSequence1 = approverAtSequence1;
							aDelegates[0] = delegateAtSequence1;
						}
					}

				} // is a program

				// where to base our start of finding approvers.
				// if 1 is found, let's start with 2 or the next up
				// DO NOT change this section.
				if (aApprovers[0] != null && aApprovers[0].length() > 0){
					startSeq = 1;
					allCompleteList.append("1");
				}

				// the last sequence to approve in history;
				int getLastApproverSequence = ApproverDB.getLastApproverSequence(conn,campus,kix);

				if (debug) {
					logger.info("startSeq: " + startSeq);
					logger.info("approverAtSequence1: " + approverAtSequence1);
					logger.info("currentApprover: " + currentApprover);
					logger.info("aApprovers[0]: " + aApprovers[0]);
					logger.info("aDelegates[0]: " + aDelegates[0]);
					logger.info("getLastApproverSequence: " + getLastApproverSequence);
					logger.info("approverAtSequence1: " + approverAtSequence1);
					logger.info("delegateAtSequence1: " + delegateAtSequence1);
					logger.info("allCompleteList: " + allCompleteList);
					logger.info("currentSeq: " + currentSeq);
				}

				if (debug) logger.info("-------------------");

				// gather approvers for all sequences and create CSV
				String sql = "SELECT Approver, delegated, approver_seq, [Position], experimental "
								+ "FROM vw_Approvers2 WHERE route=? AND approver_seq>? ORDER BY approver_seq, approver";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,route);
				ps.setInt(2,startSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){

					approverFound = false;

					// subtract 1 for proper array alignment
					arrayIndex = rs.getInt("approver_seq") - 1;

					// approver
					thisApprover = AseUtil.nullToBlank(rs.getString("Approver"));
					if (debug) logger.info("thisApprover: " + thisApprover);

					if (aApprovers[arrayIndex] == null || aApprovers[arrayIndex].length() == 0)
						aApprovers[arrayIndex] = thisApprover;
					else
						aApprovers[arrayIndex] = aApprovers[arrayIndex] + "," + thisApprover;

					// delegate - default empty delegates to the approver
					thisDelegated = AseUtil.nullToBlank(rs.getString("delegated"));
					if (thisDelegated.equals(Constant.BLANK))
						thisDelegated = thisApprover;

					if (debug) logger.info("arrayIndex: " + arrayIndex + " - " + thisApprover + "/" + thisDelegated);

					if (aDelegates[arrayIndex] == null || aDelegates[arrayIndex].length() == 0)
						aDelegates[arrayIndex] = thisDelegated;
					else
						aDelegates[arrayIndex] = aDelegates[arrayIndex] + "," + thisDelegated;

					// experiment
					thisExperimental = AseUtil.nullToBlank(rs.getString("experimental"));
					if (aExperiments[arrayIndex] == null || aExperiments[arrayIndex].length() == 0)
						aExperiments[arrayIndex] = thisExperimental;
					else
						aExperiments[arrayIndex] = aExperiments[arrayIndex] + "," + thisExperimental;

					// sequence
					if (aSequences[arrayIndex] == null || aSequences[arrayIndex].length() == 0)
						aSequences[arrayIndex] = AseUtil.nullToBlank(rs.getString("approver_seq"));
					else
						aSequences[arrayIndex] = aSequences[arrayIndex] + "," + AseUtil.nullToBlank(rs.getString("approver_seq"));

					// distribution
					isDistributionList = DistributionDB.isDistributionList(conn,campus,thisApprover);
					if (isDistributionList){
						if (debug) logger.info("isDistributionList: " + isDistributionList);

						// get list of members in distribution
						distName = thisApprover;
						if (debug) logger.info("distName: " + distName);

						thisApprover = DistributionDB.getDistributionMembers(conn,campus,distName);
						if (debug) logger.info("thisApprover: " + thisApprover);

						// is user part of list
						if (thisApprover.indexOf(user)>-1 || thisDelegated.indexOf(user)>-1) {
							thisApprover = user;
							approver.setDistributionList(true);
							approver.setDistributionName(distName);
						}
					} // isDistributionList
					else{
						if (debug) logger.info("not distributionList: " + thisApprover);
					}

				}	// while
				if (debug) logger.info("-------------------");

				//
				// determine current approver
				//
				// 1) no one yet so make the first person go
				// 2) if already started, figure out who was last. If last said no, set to that person. If not, go on.
				//
				int idx = 0;
				if (getLastApproverSequence==0){
					// 1
					currentSeq = 0;
					approverFound = true;
					currentApprover = aApprovers[0];
					currentDelegate = aDelegates[0];
				}
				else if (getLastApproverSequence>0){
					// 2

					int lastApproverVotedNOSequence = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);
					if (lastApproverVotedNOSequence > 0){
						idx = lastApproverVotedNOSequence-1;
					}
					else{
						idx = getLastApproverSequence;
					}

					// there is a chance that routing list was modified leaving
					// more in the approval history than there are approvers
					// set the index to the last person in line
					if(idx >= maxApproverSeqID){
						idx = aApprovers.length-1;
					}

					currentSeq = idx;
					approverFound = true;
					currentApprover = aApprovers[idx];
					currentDelegate = aDelegates[idx];
				}
				// at this point, the user coming here must match current approver
				// or else this is not the person to approve next.
				if (!user.equals(currentApprover)){
					currentApprover = "";
				}

				if (!user.equals(currentDelegate)){
					currentDelegate = "";
				}

				if (debug){
					logger.info("idx: " + idx);
					logger.info("currentSeq: " + currentSeq);
					logger.info("getLastApproverSequence: " + getLastApproverSequence);
					logger.info("currentApprover: " + currentApprover);
					logger.info("currentDelegate: " + currentDelegate);
				}

				//
				// in case we are still not able to locate the approver
				// if we couldn't find the current approver, then use
				// current approver as the person with the task to approve
				//
				if ((currentApprover == null || currentApprover.length() == 0) && currentSeq == 0){
					currentApprover = ApproverDB.getFirstPersonToApprove(conn,campus,alpha,num,route);
				}
				else if (currentApprover == null || currentApprover.length() == 0){

					// if next sequence has more than 1, look for correct person
					// this check only happens if the sequence is less than 3 because
					// chairs are at 1 or 2
					junkSeq = currentSeq+1;
					if(ApproverDB.getApproverCount(conn,campus,junkSeq,route) > 1 && junkSeq < 3){
						currentApprover = ApproverDB.getPersonToApprove(conn,campus,alpha,num,route,junkSeq);
					}
					else{
						currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					}

				}
				if (debug) logger.info("currentApprover: " + currentApprover);

				// if the current approver exists and is part of the first set of approvers,
				// set accordingly. This is applicable only if this is the first person to approve
				if (currentApprover != null && currentApprover.length() > 0 && currentSeq == 0){
					if (aApprovers[0].indexOf(currentApprover) > -1){
						currentSeq = 0;
						aApprovers[0] = currentApprover;

						currentDelegate = ApproverDB.getDelegateByApproverName(conn,campus,currentApprover,route);
						if (currentDelegate != null && currentDelegate.length() > 0)
							aDelegates[0] = currentDelegate;
						else{
							currentDelegate = currentApprover;
							aDelegates[0] = currentDelegate;
						}
					}
				}
				if (debug) logger.info("currentSeq: " + currentSeq);

				//
				// combine to make a list of all different types; programs don't need complete list
				// or experimental
				//
				allApprovers.append(aApprovers[0]);
				allDelegates.append(aDelegates[0]);

				if (isAProgram){
					allExperiments.append("0");
				}
				else{
					allExperiments.append(aExperiments[0]);
				}

				allSequences.append(1);

				for(int i=1; i<maxSeq; i++){
					allApprovers.append("," + aApprovers[i]);
					allDelegates.append("," + aDelegates[i]);

					if (isAProgram)
						allExperiments.append(",0");
					else
						allExperiments.append("," + aExperiments[i]);

					allSequences.append("," + (i+1));
				}

				//
				// fill up approver structure with all names
				//
				lastSeq = maxSeq - 1;

				nextSeq = currentSeq + 1;
				if (nextSeq > lastSeq){
					nextSeq = lastSeq;
				}

				prevSeq = currentSeq - 1;
				if (prevSeq < 0){
					prevSeq = 0;
				}

				if (debug){
					logger.info("lastSeq: " + lastSeq);
					logger.info("nextSeq: " + nextSeq);
					logger.info("prevSeq: " + prevSeq);
					logger.info("currentSeq: " + currentSeq);
				}

				//
				// the current approver
				//
				approver.setApprover(currentApprover);
				approver.setDelegated(currentDelegate);

				if ((Constant.ON).equals(aExperiments[currentSeq])){
					approver.setExcludeFromExperimental(true);
				}
				else{
					approver.setExcludeFromExperimental(false);
				}

				// actual sequence is 1 more than array based index.
				approver.setSeq(Integer.toString(currentSeq+1));

				//
				//	for programs, chair name replaces first approver
				//
				if (isAProgram){
					String chair = ChairProgramsDB.getChairName(conn,campus,alpha);
					if (chair != null && chair.length() > 0){
						aApprovers[0] = chair;
						aDelegates[0] = ChairProgramsDB.getDelegatedName(conn,campus,alpha);
					}
				}

				approver.setCampus(campus);

				approver.setFirstApprover(aApprovers[0]);
				approver.setFirstDelegate(aDelegates[0]);
				approver.setFirstExperiment(aExperiments[0]);
				approver.setFirstSequence(Integer.toString(1));

				approver.setPreviousApprover(aApprovers[prevSeq]);
				approver.setPreviousDelegate(aDelegates[prevSeq]);
				approver.setPreviousExperiment(aExperiments[prevSeq]);
				approver.setPreviousSequence(Integer.toString(++prevSeq));

				approver.setNextApprover(aApprovers[nextSeq]);
				approver.setNextDelegate(aDelegates[nextSeq]);
				approver.setNextExperiment(aExperiments[nextSeq]);
				approver.setNextSequence(Integer.toString(++nextSeq));

				approver.setLastApprover(aApprovers[lastSeq]);
				approver.setLastDelegate(aDelegates[lastSeq]);
				approver.setLastExperiment(aExperiments[lastSeq]);
				approver.setLastSequence(Integer.toString(maxSeq));

				temp = allApprovers.toString();
				approver.setAllApprovers(temp);

				approver.setAllExperiments(allExperiments.toString());
				approver.setAllDelegates(allDelegates.toString());
				approver.setAllSequences(allSequences.toString());
				approver.setAllCompleteList(allCompleteList.toString());

				approver.setCompleteList(approverFound);
				approver.setRoute(route);

				rs.close();
				ps.close();

			}
			else{
				approver = null;
			} // got a valid route number

			if (debug) logger.info("--------------------------- getApprovers - END");

		} catch (SQLException e) {
			temp = campus + " / " + alpha + " / " + num + " / " + user + " / " + route;
			logger.fatal("ApproverDB.getApprovers ("+temp+"): " + e.toString());
			approver = null;
		} catch (Exception e) {
			temp = campus + " / " + alpha + " / " + num + " / " + user + " / " + route;
			logger.fatal("ApproverDB.getApprovers ("+temp+"): " + e.toString());
			approver = null;
		}

		return approver;

	} // ApproverDB: getApprovers

	/*
	 * getApproverNames
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getApproverNames(Connection conn,String campus,String alpha,int route) throws Exception {

		StringBuffer approvers = new StringBuffer();
		String approver = null;
		int first = 0;

		try {

			String query = "SELECT approver FROM tblApprover WHERE campus=? AND route=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				if (first==0)
					approvers.append(AseUtil.nullToBlank(results.getString(1)).trim());
				else
					approvers.append("," + AseUtil.nullToBlank(results.getString(1)).trim());

				++first;
			} // while
			results.close();
			ps.close();

			approver = approvers.toString();
			if (approver!=null){
				if (approver.indexOf("DIVISION") >= 0){
					String divisionChair = getDivisionChairApprover(conn,campus,alpha);
					String temp = approver;
					temp = temp.replace("DIVISION",divisionChair);
					approver = temp;
				}
			}

		} catch (SQLException e) {
			logger.fatal("ApproverDB.getApproverNames: " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getApproverNames: " + e.toString());
		}

		return approver;
	}

	/*
	 * getApproverNames
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 * @return String
	 */
	public static String getApproverNames(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer approvers = new StringBuffer();

		try {
			int route = NumericUtil.getInt(CourseDB.getCourseItem(conn,kix,"route"),0);

			if(route > 0){

				boolean first = false;

				String query = "SELECT approver FROM tblApprover WHERE route=? ORDER BY approver_seq";
				PreparedStatement ps = conn.prepareStatement(query);
				ps.setInt(1,route);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					if (!first){
						approvers.append(AseUtil.nullToBlank(rs.getString(1)));
						first = true;
					}
					else{
						approvers.append("," + AseUtil.nullToBlank(rs.getString(1)));
					}

				} // while

				rs.close();
				ps.close();
			} // got route

		} catch (SQLException e) {
			logger.fatal("ApproverDB.getApproverNames: " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB.getApproverNames: " + e.toString());
		}

		return approvers.toString();
	}

	/*
	 * getApproverNamesByAlpha - collect names as CSV for a certain alpha. Key or non-departmental
	 *									approvers are selected + the approvers for the department (alpha)
	 *	<p>
	 * @param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getApproverNamesByAlpha(Connection conn,String campus,String alpha,int route) throws Exception {

		StringBuffer listing = new StringBuffer();
		String approver = "";
		String delegated = "";
		String progress = "";
		String link = "";
		boolean found = false;
		String temp = "";

		/*
			this list contains names of people set as approvers. The left of UNION selects
			non-department approvers and the right of UNION selects departmental.

			The list is sortedb by sequence in CSV with order of approvers
		*/
		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT approver_seq,approver,delegated,department " +
				"FROM tblApprover " +
				"WHERE (department Is Null OR department='') AND campus=? AND route=? " +
				"UNION " +
				"SELECT approver_seq, approver, delegated, department " +
				"FROM tblApprover " +
				"WHERE campus=? AND department=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setString(3,campus);
			ps.setString(4,alpha);
			ps.setInt(5,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				approver = aseUtil.nullToBlank(rs.getString("approver")).trim();
				delegated = aseUtil.nullToBlank(rs.getString("delegated")).trim();
				listing.append(approver+",");
				found = true;
			}
			rs.close();
			ps.close();

			temp = listing.toString();

			// get rid comma append at the end of list
			if (found && temp.endsWith(",")){
				temp = temp.substring(0,temp.length()-1);
			}

		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showOutlinesNeedingReview - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getLastPersonToApprove - the last person (if any) to approve the outline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getLastPersonToApprove(Connection conn,String campus,String alpha,String num,int route){

		// determine the last person to approve the outline

		String approver = "";
		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT approver " +
				"FROM tblApprovalHist " +
				"WHERE seq = (" +
				"	SELECT Max(seq) AS MaxOfseq FROM tblApprovalHist GROUP BY campus, coursealpha, coursenum" +
				"	HAVING campus=? AND coursealpha=? AND coursenum=?" +
				") AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setInt(4,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				approver = aseUtil.nullToBlank(rs.getString("approver"));
			rs.close();
			ps.close();

			AseUtil.loggerInfo("ApproverDB: getLastPersonToApprove (" + approver + ")",campus,alpha,num,"");
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getLastPersonToApprove - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getLastPersonToApprove - " + ex.toString());
		}

		return approver;
	}

	/*
	 * getMaxApproverSeq - sequence number of last approver
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	@param	route		int
	 *	<p>
	 * @return int
	 */
	public static int getMaxApproverSeq(Connection conn,String campus,int route){

		/*
			determine the last person to approve the outline by seq
		*/

		//Logger logger = Logger.getLogger("test");

		int maxSeq = 0;
		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT max(approver_seq) AS maxID " +
				"FROM tblApprover " +
				"WHERE campus=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				maxSeq = rs.getInt("maxID");
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getMaxApproverSeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getMaxApproverSeq - " + ex.toString());
		}

		return maxSeq;
	}

	/*
	 * getNextPersonToApprove
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static Approver getNextPersonToApprove(Connection conn,String campus,String alpha,String num,int route){

		//Logger logger = Logger.getLogger("test");

		boolean found = false;
		boolean experimental = false;
		String sql = "";
		Approver approver = new Approver();
		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		try{
			experimental = Outlines.isExperimental(num);

			// what was the last sequence approving the outline (highest in history table)
			int lastSequence = CourseDB.getLastSequenceToApprove(conn,campus,alpha,num);
			String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
			approver = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);

			// break into array
			String[] approvers = new String[20];
			approvers = approver.getAllApprovers().split(",");

			// loop through all remaining approvers. if this is an experimental and this person
			// should be excluded, then find next in line.
			if (lastSequence > 0){
				sql = "SELECT approver_seq,approver,delegated,multilevel,experimental,addedby,addeddate " +
					"FROM tblApprover " +
					"WHERE campus=? AND approver_seq>? AND route=? " +
					"ORDER BY approver_seq";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,lastSequence);
				ps.setInt(3,route);
				ResultSet rs = ps.executeQuery();
				while (rs.next() && !found) {
					approver.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
					approver.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
					approver.setSeq(rs.getString("approver_seq"));
					approver.setMultiLevel(rs.getBoolean("multilevel"));
					approver.setExcludeFromExperimental(rs.getBoolean("experimental"));

					if (experimental && approver.getExcludeFromExperimental()){
						HistoryDB.addHistory(conn,
													alpha,num,campus,
													approver.getApprover(),
													CourseApproval.getNextSequenceNumber(conn),
													true,
													"Skipped due to experimental outline",
													kix,
													Integer.parseInt(approver.getSeq()),Constant.COURSE_APPROVED_TEXT);
						found = false;
					}
					else
						found = true;

					approver.setLanid(rs.getString("addedby"));
					approver.setDte(rs.getString("addeddate"));
				}
				rs.close();
				ps.close();

				// if distribution list, get names
				if (found){
					String temp = approver.getApprover();
					if (temp.indexOf('[')==0){
						temp = DistributionDB.removeBracketsFromList(temp);
						temp = DistributionDB.getDistributionMembers(conn,campus,temp);
						approver.setApprover(temp);
						approver.setDistributionList(true);
					}
				}	// found
			}
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getNextPersonToApprove - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getNextPersonToApprove - " + ex.toString());
		}

		return approver;
	}

	/*
	 * showApprovalProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showApprovalProgress(Connection conn,String campus,String user,int idx){

		//Logger logger = Logger.getLogger("test");

		//
		// READ ME
		//
		// indentical to showApprovalProgressJQuery with the exception that there is output
		// in the old fashion way.

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int j = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";

		PreparedStatement ps = null;

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			if (debug) logger.info("------------------- showApprovalProgress START");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String select = " campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid ";

			boolean testing = false;

			if (testing){
				sql = "SELECT "
						+ select
						+ " FROM vw_ApprovalStatus "
						+ "WHERE campus=? "
						+ "AND coursealpha='BURM' "
						+ "AND coursenum='998'";

				debug = true;

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}
			else{
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? ";
			}

			// connect pending outlines
			sql += " UNION "
				+ "SELECT campus, id, CourseAlpha, CourseNum, proposer, Progress, dateproposed, auditdate, 0 as [route], subprogress, '0' as [kid] "
				+ "FROM tblCourse WHERE campus=? AND CourseType='PRE' AND CourseAlpha<>'' AND progress='PENDING'";

			// because of the union, we have to do the final select of the combined tables
			// and apply a sort
			sql = "SELECT " + select + " FROM (" + sql + ") AS selectedTables ";

			if (idx>0){
				sql += "WHERE coursealpha like '" + (char)idx + "%' ";
			}

			sql += "ORDER BY CourseAlpha, CourseNum";

			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				route = rs.getInt("route");
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				//
				//	when progress is modify, and it shows up on the approval status list, that means it has a route number.
				//	with a route number, there should be approval history as well. This means it was sent back for revision.
				//	if no approval history exists, then the outline should not be on this report. Route must be left
				//	from some time in the past programming.
				//
				//	for review progress, it happens when the subprogress is COURSE_REVIEW_IN_APPROVAL, and there is
				//	a reviewer or reviewers pending. if not, it should be in approval progress
				//
				processOutline = true;

				// if APPROVAL and REVIEW_IN_APPROVAL
				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) &&
					subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

					progress = Constant.COURSE_REVIEW_TEXT; // "REVIEW";

					//
					//	resetting to approval progress when no reviewer remains
					//	also need to reset task. At this point, we don't know who
					//	has the task so we have to get the name from the list
					//
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = Constant.COURSE_APPROVAL_TEXT; // "APPROVAL";
					}

				} // Constant.COURSE_APPROVAL_TEXT
				else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){

					if (ApproverDB.countApprovalHistory(conn,kix)<1){
						processOutline = false;
					}
					else{
						progress = Constant.COURSE_REVISE_TEXT; // "REVISE";
					}

				} // COURSE_MODIFY_TEXT
				else if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
					progress = "APPROVE";
				} // COURSE_APPROVAL_TEXT
				else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
					progress = "DELETE";
				} // COURSE_DELETE_TEXT

				if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR")){
					progress = "NEW";
				}

				if (debug){
					logger.info("0. kix: " + kix);
					logger.info("0. progress: " + progress);
					logger.info("0. subprogress: " + subprogress);
					logger.info("0. processOutline: " + processOutline);
				}

				if (processOutline){

					if (j++ % 2 == 0){
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					}
					else{
						rowColor = Constant.ODD_ROW_BGCOLOR;
					}

					experimental = Outlines.isExperimental(num);

					link = "vwcrsy.jsp?pf=1&kix=" + kix;
					fastTrack = "crsfstrk.jsp?kix=" + kix;
					linkOutline = link;
					divID = alpha + "_" + num;
					linkHistory = "?kix=" + kix;
					linkComments = "?c=0&md=0&kix="+kix+"&qn=0";
					linkDetails = "?h=1&cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";

					if (!dateproposed.equals(Constant.BLANK)){
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);
					}

					if (!auditdate.equals(Constant.BLANK))
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

					if (debug){
						logger.info("1. outline: " + alpha + " - " + num);
						logger.info("2. route: " + route);
					}

					// get all approvers
					if (route > 0){
						ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
					}

					if (ap == null){

						if (progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)){
							lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
						}

						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td>"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin5','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin6','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>");

						if(isSysAdmin || isCampusAdmin){
							listing.append("&nbsp;&nbsp;<a href=\"rte.jsp?rtn=rpt&route=0&kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/routing.gif\" title=\"change approval routing\" alt=\"change approval routing\"></a>");
						}

						listing.append("</td>");

						if((isSysAdmin || isCampusAdmin) && (Constant.COURSE_APPROVAL_TEXT).equals(progress)){
							listing.append("<td class=\"datacolumn\"><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" target=\"_blank\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						}
						else{
							listing.append("<td class=\"datacolumn\">" + alpha + " " + num + "</td>");
						}

						listing.append("<td class=\"datacolumn\">" + progress + "</td>"
							+ "<td class=\"datacolumn\">" + proposer + "</td>"
							+ "<td class=\"datacolumn\">" + lastApprover + "</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "<td class=\"datacolumn\" nowrap>" + dateproposed + "</td>"
							+ "<td class=\"datacolumn\" nowrap>" + auditdate + "</td>"
							+ "<td class=\"datacolumn\">&nbsp;</td>"
							+ "</tr>");
					}
					else{
						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						//
						//	get the last person approving from history
						//
						lastApproverSeq = 0;
						lastApprover = "";
						approved = false;
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();

							if (debug) {
								logger.info("4. lastApprover: " + lastApprover);
								logger.info("4. lastApproverSeq: " + lastApproverSeq);
								logger.info("4. approved: " + approved);
							}
						} // (h != null){

						//
						//	if nothing comes from history, the we are at the beginning. however,
						//	if there is something, figure out who should be up
						//
						//	if approved was the last from history, the add one to the sequence to get the
						//	next person.
						//
						//	array is 0th but we built the approver sequence starting from 1;
						//
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;

							lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
							if (lastApprover == null || lastApprover.length() == 0){
								lastApprover = arr[lastApproverSeq];
							}

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];
						}
						else{
							//
							//	who is next to approve. if the last person approved, then
							//	increase by 1 to get to the next person.
							//
							if (approved)
								++lastApproverSeq;

							if (lastApproverSeq == 1){
								lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
								if (lastApprover == null || lastApprover.length() == 0){
									lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
									if (lastApprover.indexOf(",") > -1)
										lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
								}
							}
							else{
								// check for comma to remove delegate from showing on report
								lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
								if (lastApprover.indexOf(",") > -1)
									lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
							}

							// check for comma to remove delegate from showing on reporet
							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

						} // lastApproverSeq == 0

						//
						//	is the task assigned to the right person? If not, remove the task.
						//
						String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													alpha,
																													num,
																													Constant.APPROVAL_TEXT);
						if (	!taskAssignedToApprover.equals(Constant.BLANK) &&
								!taskAssignedToApprover.equals(lastApprover) &&
								!taskAssignedToApprover.equals(proposer)){

							// delete task
							rowsAffected = TaskDB.logTask(conn,
																	taskAssignedToApprover,
																	taskAssignedToApprover,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type);

							if (debug) logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);
						}

						if (debug) {
							logger.info("6. lastApprover: " + lastApprover);
							logger.info("7. nextApprover: " + nextApprover);
						}

						// output
						listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
							+ "<td class=\"dataColumnTopLeft\">"
							+ "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
							+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>");

						// change routing link
						if(isSysAdmin || isCampusAdmin){
							listing.append("&nbsp;&nbsp;<a href=\"rte.jsp?rtn=rpt&route="+route+"&kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/routing.gif\" title=\"change approval routing\" alt=\"change approval routing\"></a>");
						}

						// determine fast track link
						if((isSysAdmin || isCampusAdmin) &&
							(progress.equals(Constant.TASK_APPROVE) || progress.equals(Constant.TASK_NEW) || progress.equals(Constant.TASK_DELETE)))
						{
							listing.append("&nbsp;&nbsp;<a href=\"" + fastTrack + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>");
						}

						listing.append("</td>");

						if(isSysAdmin || isCampusAdmin){
							listing.append("<td class=\"dataColumnTopLeft\" nowrap><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
						}
						else{
							listing.append("<td class=\"dataColumnTopLeft\" nowrap>" + alpha + " " + num + "</td>");
						}

						lastApprover = DistributionDB.expandNameList(conn,campus,lastApprover);
						if (lastApprover != null){
							lastApprover = lastApprover.replace(",",",<br>");
						}

						nextApprover = DistributionDB.expandNameList(conn,campus,nextApprover);
						if (nextApprover != null){
							nextApprover = nextApprover.replace(",",",<br>");
						}

						listing.append("<td class=\"dataColumnTopLeft\">" + progress + "</td>" +
							"<td class=\"dataColumnTopLeft\">" + proposer + "</td>" +
							"<td class=\"dataColumnTopLeft\">" + lastApprover + "</td>" +
							"<td class=\"dataColumnTopLeft\">" + nextApprover + "</td>" +
							"<td class=\"dataColumnTopLeft\" nowrap>" + dateproposed + "</td>" +
							"<td class=\"dataColumnTopLeft\" nowrap>" + auditdate + "</td>" +
							"<td class=\"dataColumnTopLeft\">" + routingSequence + "</td>" +
							"</tr>");
					} // if ap != null

					ap = null;

				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------- showApprovalProgress END");

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showApprovalProgress - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showApprovalProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table class=\""+campus+"BGColor\" width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
						"<tr class=\""+campus+"BGColor\" height=\"30\"><td>&nbsp;</td>" +
						"<td valign=\"bottom\">Outline</td>" +
						"<td valign=\"bottom\">Progress</td>" +
						"<td valign=\"bottom\">Proposer</td>" +
						"<td valign=\"bottom\">Current<br/>Approver</td>" +
						"<td valign=\"bottom\">Next<br/>Approver</td>" +
						"<td valign=\"bottom\">Date<br/>Proposed</td>" +
						"<td valign=\"bottom\">Last<br/>Updated</td>" +
						"<td valign=\"bottom\">Routing<br/>Sequence</td></tr>" +
						listing.toString() +
						"</table>";
		else
			temp = "<p align=\"center\">Outline not found</p>";

		return temp;
	} // showApproverProgress

	/*
	 * showApprovalProgressJQuery
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	idx		int
	 *	<p>
	 */
	public static void showApprovalProgressJQuery(Connection conn,String campus,String user,int idx){

		//Logger logger = Logger.getLogger("test");

		//
		// READ ME
		//
		// indentical to showApprovalProgress with the exception that there is no building
		// of a returned string for output. Data is saved to a table for jquery like output

		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";
		String linksAll = "";
		String linksOutline = "";

		PreparedStatement ps = null;

		int junkSeq = 0;

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			//debug = false;

			if (debug) logger.info("------------------- showApprovalProgress START");

			// clear out existing data for user
			rowsAffected = com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);
			if (debug) logger.info("cleared " + rowsAffected + " from table");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String select = " campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid ";

			boolean test = false;

			if (test){
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? "
						+ "AND CourseType='PRE' AND CourseAlpha='KES' AND coursenum='340' ";
			}
			else{
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? ";
			}

			// connect pending outlines
			sql += " UNION "
				+ "SELECT campus, id, CourseAlpha, CourseNum, proposer, Progress, dateproposed, auditdate, 0 as [route], subprogress, '0' as [kid] "
				+ "FROM tblCourse WHERE campus=? AND CourseType='PRE' AND CourseAlpha<>'' AND progress='PENDING'";

			// because of the union, we have to do the final select of the combined tables
			// and apply a sort
			sql = "SELECT " + select + " FROM (" + sql + ") AS selectedTables ";

			if (idx>0){
				sql += "WHERE coursealpha like '" + (char)idx + "%' ";
			}

			sql += "ORDER BY CourseAlpha, CourseNum";

			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				route = rs.getInt("route");
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				//
				//	when progress is modify, and it shows up on the approval status list, that means it has a route number.
				//	with a route number, there should be approval history as well. This means it was sent back for revision.
				//	if no approval history exists, then the outline should not be on this report. Route must be left
				//	from some time in the past programming.
				//
				//	for review progress, it happens when the subprogress is COURSE_REVIEW_IN_APPROVAL, and there is
				//	a reviewer or reviewers pending. if not, it should be in approval progress
				//
				processOutline = true;

				// if APPROVAL and REVIEW_IN_APPROVAL
				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

					progress = Constant.COURSE_REVIEW_TEXT; // "REVIEW";

					//
					//	resetting to approval progress when no reviewer remains
					//	also need to reset task. At this point, we don't know who
					//	has the task so we have to get the name from the list
					//
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = Constant.COURSE_APPROVAL_TEXT;
					}

				}
				else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){

					if (ApproverDB.countApprovalHistory(conn,kix)<1){
						processOutline = false;
					}
					else{
						progress = Constant.COURSE_REVISE_TEXT;
					}

				}
				else if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
					progress = "APPROVE";
				}
				else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
					progress = "DELETE";
				}
				else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
					progress = "REVISE";
				}
				else if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR")){

					// not sure why this IF logic was placed here. it messess up progress displaying when
					// a course is going through revision and it shows up as new

					progress = "NEW";
				}

				if (debug){
					logger.info("0. kix: " + kix);
					logger.info("0. progress: " + progress);
					logger.info("0. subprogress: " + subprogress);
					logger.info("0. processOutline: " + processOutline);
				}

				//
				// outline is valid and should be processed
				//
				if (processOutline){

					experimental = Outlines.isExperimental(num);

					link = "vwcrsy.jsp?pf=1&kix=" + kix;
					fastTrack = "crsfstrk.jsp?kix=" + kix;
					linkOutline = link;
					divID = alpha + "_" + num;
					linkHistory = "?kix=" + kix;
					linkComments = "?c=0&md=0&kix="+kix+"&qn=0";
					linkDetails = "?h=1&cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";

					if (!dateproposed.equals(Constant.BLANK)){
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);
					}

					if (!auditdate.equals(Constant.BLANK)){
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);
					}

					if (debug){
						logger.info("1. outline: " + alpha + " - " + num);
						logger.info("2. route: " + route);
					}

					// get all approvers
					if (route > 0){
						ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
					}

					if (ap != null){
						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						//
						//	get the last person approving from history
						//
						lastApproverSeq = -1;
						lastApprover = "";
						approved = false;
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();
						} // (h != null){

						// nothing done yet
						if (lastApproverSeq == -1){
							lastApproverSeq = 0;
						}

						//
						//	if nothing comes from history, the we are at the beginning. however,
						//	if there is something, figure out who should be up
						//
						//	if approved was the last from history, the add one to the sequence to get the
						//	next person.
						//
						//	array is 0th but we built the approver sequence starting from 1;
						//
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;
							lastApprover = arr[lastApproverSeq];

							if(lastApprover == null){
								lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
								if (lastApprover == null || lastApprover.length() == 0){
									lastApprover = arr[lastApproverSeq];
								}
							}

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];

							if (debug) {
								logger.info("4. lastApprover: " + lastApprover);
								logger.info("4. lastApproverSeq: " + lastApproverSeq);
								logger.info("4. approved: " + approved);
							}

						}
						else{

							//
							//	who is next to approve. if the last person approved, then
							//	increase by 1 to get to the next person.
							//
							if (approved){
								++lastApproverSeq;
							}
							if (debug) logger.info("41. lastApproverSeq: " + lastApproverSeq);

							if (lastApproverSeq == 1){
								//
								// if the lastApproverSeq disapproves, we want to make that person
								// the lastApprover and not go to look for chair
								//
								int sequenceNotApproved = getSequenceNotApproved(conn,campus,kix);
								if(sequenceNotApproved != lastApproverSeq){
									lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
									if (lastApprover == null || lastApprover.length() == 0){
										lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
										if (lastApprover.indexOf(",") > -1)
											lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
									}
								} // getSequenceNotApproved != lastApproverSeq
							}
							else{
								if(ApproverDB.getApproverCount(conn,campus,lastApproverSeq,route) > 1 && lastApproverSeq < 3){
									lastApprover = ApproverDB.getPersonToApprove(conn,campus,alpha,num,route,lastApproverSeq);

									if(lastApprover == null || lastApprover.length() == 0){
										// check for comma to remove delegate from showing on report
										lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
										if (lastApprover.indexOf(",") > -1){
											lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
										}
									}

								}
								else{
									// check for comma to remove delegate from showing on report
									lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
									if (lastApprover.indexOf(",") > -1){
										lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
									}
								}
							}

							junkSeq = lastApproverSeq+1;
							if(ApproverDB.getApproverCount(conn,campus,junkSeq,route) > 1 && junkSeq < 3){
								nextApprover = ApproverDB.getPersonToApprove(conn,campus,alpha,num,route,junkSeq);

								if(nextApprover == null || nextApprover.length() == 0){
									// check for comma to remove delegate from showing on report
									nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
									if (nextApprover.indexOf(",") > -1){
										nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));
									}
								}
							}
							else{
								// check for comma to remove delegate from showing on report
								nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
								if (nextApprover.indexOf(",") > -1){
									nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));
								}
							}

							if (debug) {
								logger.info("41. lastApprover: " + lastApprover);
								logger.info("41. approved: " + approved);
							}


						} // lastApproverSeq == 0

						//
						//	is the task assigned to the right person? If not, remove the task.
						//
						String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													alpha,
																													num,
																													Constant.APPROVAL_TEXT);
						if (	!taskAssignedToApprover.equals(Constant.BLANK) &&
								!taskAssignedToApprover.equals(lastApprover) &&
								!taskAssignedToApprover.equals(proposer)){

							// delete task
							rowsAffected = TaskDB.logTask(conn,
																	taskAssignedToApprover,
																	taskAssignedToApprover,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type);
						}

						if (debug) {
							logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);
							logger.info("6. lastApprover: " + lastApprover);
							logger.info("7. nextApprover: " + nextApprover);
						}

						// output
						linksAll = "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>";

						// change routing link
						if(isSysAdmin || isCampusAdmin){
							linksAll += "&nbsp;&nbsp;<a href=\"rte.jsp?rtn=rpt&route="+route+"&kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/routing.gif\" title=\"change approval routing\" alt=\"change approval routing\"></a>";
						}

						// determine fast track link
						if((isSysAdmin || isCampusAdmin) &&
							(progress.equals(Constant.TASK_APPROVE) || progress.equals(Constant.TASK_NEW) || progress.equals(Constant.TASK_DELETE)))
						{
							linksAll += "&nbsp;&nbsp;<a href=\"" + fastTrack + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>";
						}

						if(isSysAdmin || isCampusAdmin){
							linksOutline = "<a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a>";
						}
						else{
							linksOutline = alpha + " " + num;
						}

						lastApprover = DistributionDB.expandNameList(conn,campus,lastApprover);
						if (lastApprover != null){
							lastApprover = lastApprover.replace(",",",<br>");
						}

						nextApprover = DistributionDB.expandNameList(conn,campus,nextApprover);
						if (nextApprover != null){
							nextApprover = nextApprover.replace(",",",<br>");
						}

						com.ase.aseutil.report.ReportingStatusDB.insert(conn,
										new com.ase.aseutil.report.ReportingStatus(user,
																								linksAll,
																								linksOutline,
																								progress,
																								proposer,
																								lastApprover,
																								nextApprover,
																								dateproposed,
																								auditdate,
																								routingSequence,
																								Constant.COURSE,
																								kix));

						// we have an approver but is there a task? this happens when approval sequence
						// and history are out of sync causing things to not show properly.
						// based on the progress, we should create a task to get this back on track
						if (!lastApprover.equals(Constant.BLANK) && !TaskDB.isMatch(conn,campus,alpha,num)){

							String taskText = "";

							if (progress.equals(Constant.COURSE_APPROVE_TEXT)){
								taskText = Constant.APPROVAL_TEXT;
							}
							else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
								taskText = Constant.DELETE_TEXT;
							}
							else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
								taskText = Constant.MODIFY_TEXT;
							}
							else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
								taskText = Constant.REVISE_TEXT;
							}
							else if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
								taskText = Constant.REVIEW_TEXT;
							}

							rowsAffected = TaskDB.logTask(conn,
																	lastApprover,
																	proposer,
																	alpha,
																	num,
																	taskText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	type,
																	proposer,
																	Constant.BLANK);

						} // lastApprover

					} // if ap != null

					ap = null;

				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------- showApprovalProgress END");

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showApprovalProgressJQuery - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showApprovalProgressJQuery - " + ex.toString());
		}

	} // showApprovalProgressJQuery

	public static void showApprovalProgressJQueryOBSOLETE(Connection conn,String campus,String user,int idx){

		//Logger logger = Logger.getLogger("test");

		//
		// READ ME
		//
		// indentical to showApprovalProgress with the exception that there is no building
		// of a returned string for output. Data is saved to a table for jquery like output

		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";
		String linksAll = "";
		String linksOutline = "";

		PreparedStatement ps = null;

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			//debug = true;

			if (debug) logger.info("------------------- showApprovalProgress START");

			// clear out existing data for user
			rowsAffected = com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);
			if (debug) logger.info("cleared " + rowsAffected + " from table");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			String select = " campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid ";

			boolean test = false;

			if (test){
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? "
						+ "AND CourseType='PRE' AND CourseAlpha='COM' AND coursenum='125' ";
			}
			else{
				sql = "SELECT " + select + " FROM vw_ApprovalStatus WHERE campus=? ";
			}

			// connect pending outlines
			sql += " UNION "
				+ "SELECT campus, id, CourseAlpha, CourseNum, proposer, Progress, dateproposed, auditdate, 0 as [route], subprogress, '0' as [kid] "
				+ "FROM tblCourse WHERE campus=? AND CourseType='PRE' AND CourseAlpha<>'' AND progress='PENDING'";

			// because of the union, we have to do the final select of the combined tables
			// and apply a sort
			sql = "SELECT " + select + " FROM (" + sql + ") AS selectedTables ";

			if (idx>0){
				sql += "WHERE coursealpha like '" + (char)idx + "%' ";
			}

			sql += "ORDER BY CourseAlpha, CourseNum";

			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				route = rs.getInt("route");
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));

				lastApprover = "";
				nextApprover = "";
				lastApproverSeq = 0;

				//
				//	when progress is modify, and it shows up on the approval status list, that means it has a route number.
				//	with a route number, there should be approval history as well. This means it was sent back for revision.
				//	if no approval history exists, then the outline should not be on this report. Route must be left
				//	from some time in the past programming.
				//
				//	for review progress, it happens when the subprogress is COURSE_REVIEW_IN_APPROVAL, and there is
				//	a reviewer or reviewers pending. if not, it should be in approval progress
				//
				processOutline = true;

				// if APPROVAL and REVIEW_IN_APPROVAL
				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) && subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

					progress = Constant.COURSE_REVIEW_TEXT; // "REVIEW";

					//
					//	resetting to approval progress when no reviewer remains
					//	also need to reset task. At this point, we don't know who
					//	has the task so we have to get the name from the list
					//
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = Constant.COURSE_APPROVAL_TEXT;
					}

				}
				else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){

					if (ApproverDB.countApprovalHistory(conn,kix)<1){
						processOutline = false;
					}
					else{
						progress = Constant.COURSE_REVISE_TEXT;
					}

				}
				else if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
					progress = "APPROVE";
				}
				else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
					progress = "DELETE";
				}
				else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
					progress = "REVISE";
				}
				else if (!CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR")){

					// not sure why this IF logic was placed here. it messess up progress displaying when
					// a course is going through revision and it shows up as new

					progress = "NEW";
				}

				if (debug){
					logger.info("0. kix: " + kix);
					logger.info("0. progress: " + progress);
					logger.info("0. subprogress: " + subprogress);
					logger.info("0. processOutline: " + processOutline);
				}

				//
				// outline is valid and should be processed
				//
				if (processOutline){

					experimental = Outlines.isExperimental(num);

					link = "vwcrsy.jsp?pf=1&kix=" + kix;
					fastTrack = "crsfstrk.jsp?kix=" + kix;
					linkOutline = link;
					divID = alpha + "_" + num;
					linkHistory = "?kix=" + kix;
					linkComments = "?c=0&md=0&kix="+kix+"&qn=0";
					linkDetails = "?h=1&cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";

					if (!dateproposed.equals(Constant.BLANK)){
						dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);
					}

					if (!auditdate.equals(Constant.BLANK)){
						auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);
					}

					if (debug){
						logger.info("1. outline: " + alpha + " - " + num);
						logger.info("2. route: " + route);
					}

					// get all approvers
					if (route > 0){
						ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
					}

					if (ap != null){
						// split approvers into array to help determine who's up next
						// adding the extra comma out front to adjust array elements so we can work with base 1
						String allApprovers = "," + ap.getAllApprovers();
						arr = allApprovers.split(",");
						if (debug) logger.info("3. ap.getAllApprovers(): " + ap.getAllApprovers());

						//
						//	get the last person approving from history
						//
						lastApproverSeq = -1;
						lastApprover = "";
						approved = false;
						History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
						if (h != null){
							lastApproverSeq = h.getApproverSeq();
							lastApprover = h.getApprover();
							approved = h.getApproved();
						} // (h != null){

						// nothing done yet
						if (lastApproverSeq == -1){
							lastApproverSeq = 0;
						}

						//
						//	if nothing comes from history, the we are at the beginning. however,
						//	if there is something, figure out who should be up
						//
						//	if approved was the last from history, the add one to the sequence to get the
						//	next person.
						//
						//	array is 0th but we built the approver sequence starting from 1;
						//
						if (lastApproverSeq == 0){

							lastApproverSeq = 1;
							lastApprover = arr[lastApproverSeq];

							if(lastApprover == null){
								lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
								if (lastApprover == null || lastApprover.length() == 0){
									lastApprover = arr[lastApproverSeq];
								}
							}

							if (lastApproverSeq+1 >= arr.length)
								nextApprover = "";
							else
								nextApprover = arr[lastApproverSeq+1];

							if (debug) {
								logger.info("4. lastApprover: " + lastApprover);
								logger.info("4. lastApproverSeq: " + lastApproverSeq);
								logger.info("4. approved: " + approved);
							}
						}
						else{

							//
							//	who is next to approve. if the last person approved, then
							//	increase by 1 to get to the next person.
							//
							if (approved){
								++lastApproverSeq;
							}

							if (lastApproverSeq == 1){
								lastApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
								if (lastApprover == null || lastApprover.length() == 0){
									lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
									if (lastApprover.indexOf(",") > -1)
										lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
								}
							}
							else{
								// check for comma to remove delegate from showing on report
								lastApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq,route);
								if (lastApprover.indexOf(",") > -1)
									lastApprover = lastApprover.substring(0,lastApprover.indexOf(","));
							}

							// check for comma to remove delegate from showing on report
							nextApprover = ApproverDB.getApproversBySeq(conn,campus,lastApproverSeq+1,route);
							if (nextApprover.indexOf(",") > -1)
								nextApprover = nextApprover.substring(0,nextApprover.indexOf(","));

							if (debug) {
								logger.info("41. lastApprover: " + lastApprover);
								logger.info("41. lastApproverSeq: " + lastApproverSeq);
								logger.info("41. approved: " + approved);
							}


						} // lastApproverSeq == 0

						//
						//	is the task assigned to the right person? If not, remove the task.
						//
						String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,
																													campus,
																													alpha,
																													num,
																													Constant.APPROVAL_TEXT);
						if (	!taskAssignedToApprover.equals(Constant.BLANK) &&
								!taskAssignedToApprover.equals(lastApprover) &&
								!taskAssignedToApprover.equals(proposer)){

							// delete task
							rowsAffected = TaskDB.logTask(conn,
																	taskAssignedToApprover,
																	taskAssignedToApprover,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type);
						}

						if (debug) {
							logger.info("5. taskAssignedToApprover: " + taskAssignedToApprover);
							logger.info("6. lastApprover: " + lastApprover);
							logger.info("7. nextApprover: " + nextApprover);
						}

						// output
						linksAll = "<a href=\"" + linkOutline + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsstsh.jsp" + linkHistory + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\" title=\"view approval history\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsrvwcmnts.jsp" + linkComments + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/core/images/comment.gif\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>&nbsp;&nbsp;"
								+ "<a href=\"crsinfy.jsp" + linkDetails + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin3','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"/central/images/details.gif\" border=\"0\" alt=\"view outline detail\" title=\"view outline detail\"></a>";

						// change routing link
						if(isSysAdmin || isCampusAdmin){
							linksAll += "&nbsp;&nbsp;<a href=\"rte.jsp?rtn=rpt&route="+route+"&kix="+kix+"\" class=\"linkcolumn\"><img src=\"../images/routing.gif\" title=\"change approval routing\" alt=\"change approval routing\"></a>";
						}

						// determine fast track link
						if((isSysAdmin || isCampusAdmin) &&
							(progress.equals(Constant.TASK_APPROVE) || progress.equals(Constant.TASK_NEW) || progress.equals(Constant.TASK_DELETE)))
						{
							linksAll += "&nbsp;&nbsp;<a href=\"" + fastTrack + "\" class=\"linkcolumn\"><img src=\"../images/fastrack.gif\" border=\"0\" alt=\"fast track approval\" title=\"fast track approval\"></a>";
						}

						if(isSysAdmin || isCampusAdmin){
							linksOutline = "<a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a>";
						}
						else{
							linksOutline = alpha + " " + num;
						}

						lastApprover = DistributionDB.expandNameList(conn,campus,lastApprover);
						if (lastApprover != null){
							lastApprover = lastApprover.replace(",",",<br>");
						}

						nextApprover = DistributionDB.expandNameList(conn,campus,nextApprover);
						if (nextApprover != null){
							nextApprover = nextApprover.replace(",",",<br>");
						}

						com.ase.aseutil.report.ReportingStatusDB.insert(conn,
										new com.ase.aseutil.report.ReportingStatus(user,
																								linksAll,
																								linksOutline,
																								progress,
																								proposer,
																								lastApprover,
																								nextApprover,
																								dateproposed,
																								auditdate,
																								routingSequence,
																								Constant.COURSE));

						// we have an approver but is there a task? this happens when approval sequence
						// and history are out of sync causing things to not show properly.
						// based on the progress, we should create a task to get this back on track
						if (!lastApprover.equals(Constant.BLANK) && !TaskDB.isMatch(conn,campus,alpha,num)){

							String taskText = "";

							if (progress.equals(Constant.COURSE_APPROVE_TEXT)){
								taskText = Constant.APPROVAL_TEXT;
							}
							else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
								taskText = Constant.DELETE_TEXT;
							}
							else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
								taskText = Constant.MODIFY_TEXT;
							}
							else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
								taskText = Constant.REVISE_TEXT;
							}
							else if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
								taskText = Constant.REVIEW_TEXT;
							}

							rowsAffected = TaskDB.logTask(conn,
																	lastApprover,
																	proposer,
																	alpha,
																	num,
																	taskText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	type,
																	proposer,
																	Constant.BLANK);

						} // lastApprover

					} // if ap != null

					ap = null;

				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();

			if (debug) logger.info("------------------- showApprovalProgress END");

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showApprovalProgressJQuery - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showApprovalProgressJQuery - " + ex.toString());
		}

	} // showApprovalProgressJQuery

	/**
	 * showApprovers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 * @param	college	String
	 * @param	dept		String
	 * @param	level		String
	 * <p>
	 * @return	String
	 */
	public static String showApprovers(Connection conn,String campus,int route,String college,String dept,String level){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String link = "";

		String approverid = "";
		String seq = "";
		String approver = "";
		String title = "";
		String position = "";
		String department = "";
		String division = "";
		String delegated = "";
		String endDate = "";

		try{

			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"jqueryShowApprovers\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">Sequence</th>"
				+ "<th align=\"left\">Approver</th>"
				+ "<th align=\"left\">Title</th>"
				+ "<th align=\"left\">Position</th>"
				+ "<th align=\"left\">Department</th>"
				+ "<th align=\"left\">Division</th>"
				+ "<th align=\"left\">Delegate</th>"
				+ "<th align=\"left\">Approved By</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT * FROM vw_Approvers2 WHERE campus=? AND route=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				approverid = aseUtil.nullToBlank(rs.getString("approverid"));
				seq = aseUtil.nullToBlank(rs.getString("approver_seq"));
				approver = aseUtil.nullToBlank(rs.getString("approver"));
				title = aseUtil.nullToBlank(rs.getString("title"));
				position = aseUtil.nullToBlank(rs.getString("position"));
				department = aseUtil.nullToBlank(rs.getString("department"));
				division = aseUtil.nullToBlank(rs.getString("division"));
				delegated = aseUtil.nullToBlank(rs.getString("delegated"));
				endDate = aseUtil.ASE_FormatDateTime(rs.getString("endDate"),Constant.DATE_DATETIME);

				buf.append("<tr>" +
					"<td align=\"left\"><a href=\"appr.jsp?rte="+route+"&college="+college+"&dept="+dept+"&level="+level+"&lid=" + approverid + "\" class=\"linkcolumn\">" + seq + "</a></td>" +
					"<td align=\"left\">" + approver + "</td>" +
					"<td align=\"left\">" + title + "</td>" +
					"<td align=\"left\">" + position + "</td>" +
					"<td align=\"left\">" + department + "</td>" +
					"<td align=\"left\">" + division + "</td>" +
					"<td align=\"left\">" + delegated + "</td>" +
					"<td align=\"left\">" + endDate + "</td>" +
					"</tr>");

				if (approver.equals("DIVISIONCHAIR")){
					buf.append("<tr>" +
						"<td align=\"left\">&nbsp;</td>" +
						"<td class=\"datacolumn\" colspan=\"5\"><p align=\"center\">" + showApproversByDivisions(conn,campus) + "</p></td>" +
						"</tr>");
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showApprovers\n" + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showApprovers - " + ex.toString());
			buf.setLength(0);
		}

		buf.append("</tbody></table></div></div>");

		return buf.toString();
	}

	/**
	 * showApproversByDivisions
	 * <p>
	 * @param	conn		Connection
	 * @param	campus 	String
	 * <p>
	 * @return	String
	 */
	public static String showApproversByDivisions(Connection conn,String campus){

		//logger.info("ApproverDB - showApproversByDivisions");

		StringBuffer buf = new StringBuffer();
		String rtn = "";
		String link = "";

		String userid = "";
		String division = "";
		String department = "";

		String rowColor = "";
		int j = 0;

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT userid, division, department " +
				"FROM tblUsers " +
				"WHERE userid<>? AND position=? AND campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,"DIVISIONCHAIR");
			ps.setString(2,"DIVISION CHAIR");
			ps.setString(3,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				userid = aseUtil.nullToBlank(rs.getString("userid")).trim();
				division = aseUtil.nullToBlank(rs.getString("division")).trim();
				department = aseUtil.nullToBlank(rs.getString("department")).trim();

				buf.append("<tr bgcolor=\"" + rowColor + "\">" +
					"<td class=\"datacolumn\">" + userid + "</td>" +
					"<td class=\"datacolumn\">" + division + "</td>" +
					"<td class=\"datacolumn\">" + department + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showApproversByDivisions\n" + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showApproversByDivisions - " + ex.toString());
			buf.setLength(0);
		}

		if (found){
			rtn = "<table class=\"" + campus + "BGColor\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr class=\"" + campus + "BGColor\">" +
					"<td>Approver</td>" +
					"<td>Division</td>" +
					"<td>Department</td>" +
					"</tr>" +
					buf.toString() +
					"</table>";
		}
		else
			rtn = "Division Chairs not set up for campus";

		return rtn;
	}

	/*
	 * getDivisionChairApprover
	 *	<p>
	 *	@param	Connection	conn
	 * @param	String		campus
	 * @param	String		alpha
	 *	<p>
	 *	@return String
	 */
	public static String getDivisionChairApprover(Connection conn,String campus,String alpha) throws SQLException {

		return getDivisionChairApprover(conn,campus,alpha,"");
	}

	public static String getDivisionChairApprover(Connection conn,String campus,String alpha,String division) throws SQLException {

		String divisionChair = "";

		/*
			if we can't find the chair as a person's title, then go to the division table
		*/

		try {
			String sql = "SELECT userid FROM tblUsers WHERE campus=? AND department=? AND position LIKE 'DIVISION%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				divisionChair = AseUtil.nullToBlank(rs.getString(1));
			}

			rs.close();
			ps.close();

			if (divisionChair == null || (Constant.BLANK).equals(divisionChair))
				divisionChair = DivisionDB.getChairName(conn,campus,division);

		} catch (SQLException e) {
			logger.fatal("ApproverDB: getDivisionChairApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ApproverDB: getDivisionChairApprover - " + ex.toString());
		}

		return divisionChair;
	}

	/**
	 * showCompletedApprovals
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static Msg showCompletedApprovals(Connection conn,String campus,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String rtn = "";

		int seq = 0;
		String approvers = "";
		String title = "";
		String dte = "";
		String approved = "";
		String position = "";
		String role = "";
		String progress = "";

		int j = 0;

		Msg msg = new Msg();
		String approver = "";

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			// vw_ApprovalHistory
			String sql = "SELECT ta.campus,ta.coursealpha,ta.coursenum,ta.seq,ta.historyid,ta.approver,tu.title,tu.[position],ta.dte,ta.approved,tu.department,ta.inviter,ta.role,ta.approver_seq,ta.progress "
				+ "FROM tblApprovalHist ta,tblUsers tu "
				+ "WHERE ta.approver = tu.userid AND progress <> 'RECALLED' "
				+ "UNION "
				+ "SELECT campus,coursealpha,coursenum,seq,historyid,approver,'DISTRIBUTION LIST','DISTRIBUTION LIST',dte,approved,'','','',0,0 "
				+ "FROM tblApprovalHist ta "
				+ "WHERE approver LIKE '%]'";

			sql = "SELECT seq, approver_seq, approver, title, position, dte, approved, role, progress "
				+ "FROM vw_ApprovalHistory "
				+ "WHERE campus=? AND "
				+ "Coursealpha=? AND "
				+ "Coursenum=? "
				+ "ORDER BY dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				seq = rs.getInt("approver_seq");
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				position = AseUtil.nullToBlank(rs.getString("position"));
				dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),6);
				role = AseUtil.nullToBlank(rs.getString("role"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));

				if ("REVIEW".equals(progress))
					progress = "REVIEWED";

				approved = AseUtil.nullToBlank(rs.getString("approved"));
				if ("1".equals(approved))
					approved = "YES";
				else
					approved = "NO";

				// only approvers get a yes/no vote
				if (!(Constant.TASK_APPROVER).equals(role))
					approved = "";

				if (j==1)
					approvers = approver;
				else
					approvers = approvers + "," + approver;

				buf.append("<tr>" +
					"<td align=\"left\">" + seq + "</td>" +
					"<td align=\"left\">" + approver + "</td>" +
					"<td align=\"left\">" + title + "</td>" +
					"<td align=\"left\">" + position + "</td>" +
					"<td align=\"right\">" + dte + "</td>" +
					"<td align=\"left\">" + role + "</td>" +
					"<td align=\"left\">" + approved + "</td>" +
					"<td align=\"left\">" + progress + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showCompletedApprovals - " + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showCompletedApprovals - " + ex.toString());
			buf.setLength(0);
		}

		rtn = "<div id=\"container90\"><div id=\"demo_jui\"><table class=\"display\" id=\"showCompletedApprovals\">" +
				"<thead><tr>" +
				"<th align=\"left\">Sequence</th>" +
				"<th align=\"left\">Approver</th>" +
				"<th align=\"left\">Title</th>" +
				"<th align=\"left\">Position</th>" +
				"<th align=\"right\">Date</th>" +
				"<th align=\"left\">Role</th>" +
				"<th align=\"left\">Approved</th>" +
				"<th align=\"left\">Progress</th>" +
				"</tr></thead><tbody>" +
				buf.toString() +
				"</tbody></table></div> </div>";

		msg.setMsg(approvers);
		msg.setErrorLog(rtn);

		return msg;
	}

	/**
	 * showPendingApprovals
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	completed	String
	 * @param	route			int
	 * <p>
	 * @return	String
	 */
	public static String showPendingApprovals(Connection conn,String campus,String alpha,String num,String completed,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String approver = "";
		String delegated = "";
		String pendingApprovers = "";
		String position = "";
		String title = "";
		String rtn = "";

		String distributionList = "";
		String distributionListMembers = "";
		String[] aDistributionList = null;
		boolean distributionApprovalCompleted = false;

		int j = 0;
		int sequence = 0;
		int lastSequenceToApprove = 0;

		boolean found = false;
		boolean firstSequenceExists = false;

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		try{
			completed = "'" + completed.replace(",","','") + "'";

			// take care of complete distribution list if any. list starts and ends with [].
			// if the list members have approved 100%, then remove the list from listing.
			String sql = "SELECT approver FROM tblApprover WHERE route=? AND approver LIKE '[[]%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				// get the list name
				distributionList = AseUtil.nullToBlank(rs.getString(1));
				if (distributionList != null && distributionList.length() > 0){
					// get list members
					distributionListMembers = DistributionDB.getDistributionMembers(conn,campus,distributionList);
					if (distributionListMembers != null && distributionListMembers.length() > 0){

						// split members into array. for loop checks to verify that members have/have not approved
						// if all approved, then this list is no longer listed
						// start with list being completed by default. If a name is not found in the for-loop, then
						// set distributionApprovalCompleted = false;

						distributionApprovalCompleted = true;

						aDistributionList = distributionListMembers.split(",");

						for(int z=0;z<aDistributionList.length;z++){
							if (completed.indexOf(aDistributionList[z])==-1){
								distributionApprovalCompleted = false;
							}
						} // for

						// if completed, add to excluded (completed) list
						if (distributionApprovalCompleted)
							completed += ",'" + distributionList + "'";

					} // if distributionListMembers
				} // if distributionList
			} // while
			rs.close();
			ps.close();

			lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);

			sql = "SELECT ta.approver_seq AS Sequence,ta.approver,ta.delegated,tu.title,tu.[position],tu.department,tu.campus,ta.route "
				+ "FROM tblApprover ta INNER JOIN "
				+ "tblUsers tu ON ta.approver = tu.userid "
				+ "WHERE ta.campus=? AND route=? AND approver_seq>? "
				+ "UNION "
				+ "SELECT approver_seq AS Sequence,approver,delegated,'DISTRIBUTION LIST','DISTRIBUTION LIST','',campus,route "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND route=? AND approver LIKE '%]' AND approver_seq>?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,lastSequenceToApprove);
			ps.setString(4,campus);
			ps.setInt(5,route);
			ps.setInt(6,lastSequenceToApprove);
			rs = ps.executeQuery();
			while ( rs.next() ){
				// name of first approver at DC level is not always available since
				// CC does not know who is DC for all alphas. When that happens,
				// sequence 1 or first person will not be found here.
				// firstSequenceExists = true means we found the DC otherwise we did not.
				// if not, we want to get that name from the task assignment and include
				// in the data returned.
				sequence = NumericUtil.nullToZero(rs.getInt("sequence"));

				if (sequence==1){
					firstSequenceExists = true;
				}

				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				position = AseUtil.nullToBlank(rs.getString("position"));

				// list of pending approvers for use later
				if (j== 0){
					pendingApprovers = approver;
				}
				else{
					pendingApprovers = pendingApprovers + "," + approver;
				}


				buf.append("<tr>" +
					"<td align=\"left\">" + sequence + "</td>" +
					"<td align=\"left\">" + approver + "</td>" +
					"<td align=\"left\">" + title + "</td>" +
					"<td align=\"left\">" + position + "</td>" +
					"<td align=\"left\">" + delegated + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				rtn = buf.toString();
			}
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showPendingApprovals - " + se.toString());
		}catch(Exception ex){
			logger.fatal("ApproverDB: showPendingApprovals - " + ex.toString());
		}

		if (found){
			rtn = "<div id=\"container90\"><div id=\"demo_jui\"><table class=\"display\" id=\"showPendingApprovals\">" +
				"<thead><tr>" +
				"<th align=\"left\">Sequence</th>" +
				"<th align=\"left\">Approver</th>" +
				"<th align=\"left\">Title</th>" +
				"<th align=\"left\">Position</th>" +
				"<th align=\"left\">Delegate</th>" +
				"</tr></thead><tbody>" +
				rtn +
				"</tbody></table></div> </div>";
		}
		else {
			rtn = "";
		}

		return rtn;
	} // ApproverDB.showPendingApprovals

	/**
	 * countApprovalHistory - Count number of approver comments for each item
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * <p>
	 * @return long
	 *
	 */
	public static long countApprovalHistory(Connection conn,String kix) throws java.sql.SQLException {

		long lRecords = 0;

		try {
			String sql = "SELECT Count(id) AS CountOfid FROM tblApprovalHist WHERE historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				lRecords = rs.getLong(1);
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: countApprovalHistory - " + e.toString());
		}

		return lRecords;
	}

	/*
	 * getApprovalHistory
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 *	<p>
	 *	@return String
	 */
	public static String getApprovalHistory(Connection connection,String kix) throws Exception {

		//logger.info("ApproverDB - getApprovalHistory - " + kix);

		boolean found = false;

		StringBuffer approval = new StringBuffer();
		String temp = "";
		String sql = "SELECT approver,dte,comments FROM tblApprovalHist WHERE historyid=? ORDER BY seq";

		try {
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, kix);
			ResultSet rs = preparedStatement.executeQuery();
			AseUtil aseUtil = new AseUtil();
			while (rs.next()) {
				approval.append( "<tr class=\"rowhighlight\"><td valign=top>" +
										aseUtil.ASE_FormatDateTime(rs.getString(2),6) + " - " +
										AseUtil.nullToBlank(rs.getString(1)).trim() +
										"</td></tr>" );
				approval.append( "<tr><td valign=top>" + AseUtil.nullToBlank(rs.getString(3)).trim() + "</td></tr>" );
				found = true;
			}
			rs.close();
			preparedStatement.close();

			approval.append("<table border=\"0\" cellpadding=\"1\" width=\"100%\">");
			approval.append("</table>");
		} catch (SQLException e) {
			logger.fatal("ApprovalDB: getApprovalHistory - " + e.toString());
		}

		if (found){
			temp = "<table border=\"0\" cellpadding=\"1\" width=\"100%\">" +
						approval.toString() +
						"</table>";
		}
		else{
			temp = "<table border=\"0\" cellpadding=\"1\" width=\"100%\">" +
						"<tr><td>History data not found</td></tr>" +
						"</table>";
		}

		return temp;
	}

	/*
	 * getApproverBySeq - returns 1 approver at this sequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String getApproverBySeq(Connection conn,String campus,int seq,int route){

		String approver = "";

		try{
			String sql = "SELECT approver FROM tblApprover WHERE campus=? AND approver_seq=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				approver = AseUtil.nullToBlank(rs.getString("approver"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getApproverBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getApproverBySeq - " + ex.toString());
		}

		return approver;
	}

	/*
	 * getDelegateBySeq - returns 1 approver at this sequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String getDelegateBySeq(Connection conn,String campus,int seq,int route){

		String delegated = "";

		try{
			String sql = "SELECT delegated FROM tblApprover WHERE campus=? AND approver_seq=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getDelegateBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getDelegateBySeq - " + ex.toString());
		}

		return delegated;
	}

	/*
	 * getApproversBySeq - collect all approvers for a particular sequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String getApproversBySeq(Connection conn,String campus,int seq,int route){

		StringBuffer approvers = new StringBuffer();
		String approver = "";
		String delegated = "";
		String temp = "";

		try{
			String sql = "SELECT approver,delegated FROM tblApprover WHERE campus=? AND approver_seq=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));

				if (approvers.toString().length()==0)
					approvers.append(approver);
				else{
					if (approvers.lastIndexOf(approver) < 0)
						approvers.append(","+approver);
				}

				if (!delegated.equals("")){
					if (approvers.lastIndexOf(delegated) < 0)
						approvers.append(","+delegated);
				}
			}

			temp = approvers.toString();
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getApproversBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getApproversBySeq - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getApproversByRoute - approvers set to a particular route
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */

	public static String getApproversByRoute(Connection conn,String campus,int route){

		StringBuffer approvers = new StringBuffer();
		String approver = "";
		String delegated = "";
		String temp = "";

		try{
			String sql = "SELECT approver,delegated FROM tblApprover WHERE campus=? AND route=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));

				if (approvers.toString().length()==0)
					approvers.append(approver);
				else{
					if (approvers.lastIndexOf(approver) < 0)
						approvers.append(","+approver);
				}

				if (!"".equals(delegated)){
					if (approvers.lastIndexOf(delegated) < 0)
						approvers.append(","+delegated);
				}
			}

			temp = approvers.toString();
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getApproversByRoute - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getApproversByRoute - " + ex.toString());
		}

		return temp;
	}

	/*
	 * displayFastTrackApprovers - collect all approvers for fast track
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String displayFastTrackApprovers(Connection conn,String campus,String kix,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer approvers = new StringBuffer();
		String approver = "";
		String delegated = "";
		String approverSeq = "";
		String temp = "";

		int counter = 0;
		int i = 0;
		int j = 0;
		int seq = 0;

		String[] list = new String[30];
		String[] approvalSeq = new String[30];

		try{
			/*
				1) nested sql 3 deep
				2) 3rd - select the max id of the last approval
				3) 2nd - use id from 3rd SQL to find the approver's name
				4) 1st - use the approver's name in 2nd SQL to find the sequence number
 				5) use the sequence number to select all approvers not yet approved
			*/

			// steps 1-4
			String sql = "SELECT approver_seq "
				+ "FROM tblApprover "
				+ "WHERE route=? AND "
				+ "(approver = "
				+ "(SELECT approver "
				+ "FROM tblApprovalHist "
				+ "WHERE (seq = "
				+ "(SELECT MAX(seq) AS maxid "
				+ "FROM tblApprovalHist "
				+ "WHERE (campus=? AND historyid=? AND approved='1')))))";
			//PreparedStatement ps = conn.prepareStatement(sql);
			//ps.setInt(1,route);
			//ps.setString(2,campus);
			//ps.setString(3,kix);

			// not sure why steps 1-4 used when the approver_seq is in the history file
			sql = "SELECT MAX(approver_seq) AS approver_seq FROM tblApprovalHist "
				+ "WHERE (campus=? AND historyid=? AND approved='1')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				seq = rs.getInt("approver_seq");
			}
			else{
				seq = 0;
			}
			rs.close();
			ps.close();

			// steps 5
			sql = "SELECT approver_seq,approver,delegated "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND "
				+ "route=? AND "
				+ "approver_seq>? "
				+ "ORDER BY approver_seq,approver";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,seq);
			rs = ps.executeQuery();
			while (rs.next()) {
				approverSeq = AseUtil.nullToBlank(rs.getString("approver_seq"));
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));

				if (!"".equals(delegated) && !approver.equals(delegated)){
					approver = approver + "," + delegated;
				}

				list[counter] =  approver;
				approvalSeq[counter] = approverSeq;

				++counter;
			}
			rs.close();
			ps.close();

			// when total approvers is less than 10, list in a single column
			// when total approvers is 1, show as check mark
			if (counter == 1){
				approvers.append("<input type=\"checkbox\" value=\""
					+ approvalSeq[i]
					+ "\" name=\"appr\">"
					+ list[i]
					+ "<br/><br/>");
			}
			else if (counter<10){
				for(i=0;i<counter;i++){
					approvers.append("<input type=\"radio\" value=\""
						+ approvalSeq[i]
						+ "\" name=\"appr\">"
						+ list[i]
						+ "<br/><br/>");
				}
			}
			else{
				approvers.append("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td valign=\"top\">");

				j = (int)counter/2;
				for(i=0;i<j;i++){
					approvers.append("<input type=\"radio\" value=\""
						+ approvalSeq[i]
						+ "\" name=\"appr\">"
						+ list[i]
						+ "<br/><br/>");
				}

				approvers.append("</td><td valign=\"top\">");

				j = i;
				for(i=j;i<counter;i++){
					approvers.append("<input type=\"radio\" value=\""
						+ approvalSeq[i]
						+ "\" name=\"appr\">"
						+ list[i]
						+ "<br/><br/>");
				}

				approvers.append("</td></tr></table>");
			}

			approvers.append("<input type=\"hidden\" name=\"lastSeq\" value=\""+seq+"\">");
			temp = approvers.toString();

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: displayFastTrackApprovers - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: displayFastTrackApprovers - " + ex.toString());
		}

		return temp;
	}

	/*
	 * displayApproversBySeq - collect all approvers for a particular sequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String displayApproversBySeq(Connection conn,String campus,int seq,int route){

		StringBuffer approvers = new StringBuffer();
		String approverAndDelegate = "";
		String approver = "";
		String delegated = "";
		String div = "";
		String dept = "";
		String temp = "";

		try{
			String sql = "SELECT ta.approver, ta.delegated, tu.department, tu.division, "
				+ "BannerDept.DEPT_DESCRIPTION AS dept, BannerDivision.DIVS_DESCRIPTION AS div "
				+ "FROM BannerDivision LEFT OUTER JOIN "
				+ "tblUsers tu ON BannerDivision.DIVISION_CODE = tu.division RIGHT OUTER JOIN "
				+ "BannerDept ON tu.department = BannerDept.DEPT_CODE RIGHT OUTER JOIN "
				+ "tblApprover ta ON tu.campus = ta.campus AND tu.userid = ta.approver "
				+ "WHERE ta.campus=? "
				+ "AND ta.route=? "
				+ "AND ta.approver_seq=? "
				+ "ORDER BY ta.approver";

			sql = "SELECT ta.approver, ta.delegated, tu.department, tu.division, "
				+ "ba.ALPHA_DESCRIPTION AS dept, BannerDivision.DIVS_DESCRIPTION AS div "
				+ "FROM BannerDivision LEFT OUTER JOIN "
				+ "tblUsers tu ON BannerDivision.DIVISION_CODE = tu.division RIGHT OUTER JOIN "
				+ "BannerAlpha ba ON tu.department = ba.COURSE_ALPHA RIGHT OUTER JOIN "
				+ "tblApprover ta ON tu.campus = ta.campus AND tu.userid = ta.approver "
				+ "WHERE ta.campus=? "
				+ "AND ta.route=? "
				+ "AND ta.approver_seq=? "
				+ "ORDER BY ta.approver";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				approverAndDelegate = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				dept = AseUtil.nullToBlank(rs.getString("dept"));
				div = AseUtil.nullToBlank(rs.getString("div"));

				if (!"".equals(delegated)){
					approverAndDelegate = approverAndDelegate + "," + delegated;
				}

				temp = "";
				if (dept.length()>0 && div.length()>0)
					temp = "</font> (" + dept + "/" + div + ")";

				approvers.append("<input type=\"radio\" value=\""
					+ approverAndDelegate
					+ "\" name=\"appr\">"
					+ "<font class=\"datacolumn\">" + approverAndDelegate + temp
					+ "<br/><br/>");
			}

			temp = approvers.toString();
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: displayApproversBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: displayApproversBySeq - " + ex.toString());
		}

		return temp;
	}

	/*
	 * fastTrackApprovers
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	seq		int
	 * @param	lastSeq	int
	 * @param	route		int
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static int fastTrackApprovers(Connection conn,
														String campus,
														String kix,
														int seq,
														int lastSeq,
														int route,
														String user){

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String alpha = "";
		String num = "";
		String approver = "";
		String proposer = "";
		String delegated = "";
		boolean lastApprover = false;
		Msg msg = new Msg();

		int rowsAffected = -1;
		int approver_seq = 0;

		boolean fastTrack = true;
		boolean isAProgram = false;

		String junk = "";
		String taskText = Constant.APPROVAL_TEXT;

		boolean debug = true;

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			if (debug) logger.info("---------------------- FAST TRACK APPROVAL - STARTS");

			if (!kix.equals(Constant.BLANK)){
				String[] info = Helper.getKixInfo(conn,kix);
				alpha = info[0];
				num = info[1];
				proposer = info[3];
			}

			//
			// is this a program?
			//
			if (kix != null && kix.length() > 0){
				isAProgram = ProgramsDB.isAProgram(conn,kix);
			}

			if(isAProgram){
				taskText = Constant.PROGRAM_APPROVAL_TEXT;
			}

			//
			// is this the last approver?
			//
			if (seq == ApproverDB.getMaxApproverSeq(conn,campus,route)){
				lastApprover = true;
			}

			String approverAtSequence1 = ApproverDB.approverAtSequenceOne(conn,campus,alpha,num);
			if (debug){
				logger.info("kix: " + kix);
				logger.info("isAProgram: " + isAProgram);
				logger.info("seq: " + seq);
				logger.info("lastSeq: " + lastSeq);
				logger.info("route: " + route);
				logger.info("user: " + user);
				logger.info("lastApprover: " + lastApprover);
				logger.info("approverAtSequence1: " + approverAtSequence1);
			}

			// get all approvers before this seq and fast track their approvals
			// this is where we simply by pass everyone who was not needed
			String sql = "SELECT approver,delegated,approver_seq FROM tblApprover "
				+ "WHERE campus=? AND route=? AND (approver_seq>=? AND approver_seq<=?) "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,lastSeq);
			ps.setInt(4,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				approver_seq = rs.getInt("approver_seq");

				boolean isDistributionList = DistributionDB.isDistributionList(conn,campus,approver);
				if (isDistributionList){
					junk = DistributionDB.expandNameList(conn,campus,approver);
				}
				else{
					junk = approver;
				}

				String[] names = junk.split(",");

				//
				// process approvers and anyone in distribution
				//
				for (int iJunk = 0; iJunk < names.length; iJunk++){

					approver = names[iJunk];

					rowsAffected = -1;

					// if it's the first approver and the name does not match the name found as approverAtSequence1,
					// or the person is not part of a distribution, don't log
					fastTrack = true;
					if (approver_seq == 1 && !isDistributionList){
						if (!approverAtSequence1.equals(approver) || junk.indexOf(approverAtSequence1) < 0){
							fastTrack = false;
						}
					}

					if (fastTrack){
						// if last approver, move to archive and make this real
						if (lastApprover){
							try{

								if(isAProgram){
									msg = ProgramApproval.approveProgram(conn,
																					campus,
																					kix,
																					approver,
																					true,
																					Constant.FAST_TRACK_TEXT,
																					0,
																					0,
																					0);
								}
								else{
									msg = CourseApproval.approveOutline(conn,
																					campus,
																					alpha,
																					num,
																					approver,
																					true,
																					Constant.FAST_TRACK_TEXT,
																					0,
																					0,
																					0);
								}

								if (msg.getCode() > 0){
									rowsAffected = 0;
								}

								if (debug) logger.info("processing last approver ("+approver+") - rowsAffected " + rowsAffected);

							}
							catch(Exception e){
								logger.fatal(kix + " - ApproverDB: fastTrackApprovers - " + e.toString());
								msg.setMsg("Exception");
								rowsAffected = -1;
							}
						}
						else{
							// add to history
							HistoryDB.addHistory(conn,
														alpha,
														num,
														campus,
														approver,
														CourseApproval.getNextSequenceNumber(conn),
														true,
														"Fast track approval",
														kix,
														approver_seq,
														0,
														0,
														0,
														Constant.BLANK,
														Constant.TASK_APPROVER,
														Constant.COURSE_FAST_TRACKED);

							rowsAffected = TaskDB.removeApprovalTask(conn,kix,approver,delegated);

							if (debug) logger.info(approver + " history added; " + rowsAffected + " task removed for ");

						}	// lastApprover

						if(isAProgram){
							AseUtil.logAction(conn,approver,"ACTION","Program fast tracked for "+ approver,alpha,num,campus,kix);
						}
						else{
							AseUtil.logAction(conn,approver,"ACTION","Outline fast tracked for "+ approver,alpha,num,campus,kix);
						}

					}	// if fast track

				} // for

			} // while
			rs.close();

			String sApprovers = "";
			String sDelegates = "";
			boolean found = false;

			// send request for approval to next person in line
			if (!lastApprover){
				seq = seq + 1;
				sql = "SELECT approver,delegated FROM tblApprover WHERE campus=? AND route=? AND approver_seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				ps.setInt(3,seq);
				rs = ps.executeQuery();
				while (rs.next()) {
					approver = AseUtil.nullToBlank(rs.getString("approver"));
					delegated = AseUtil.nullToBlank(rs.getString("delegated"));

					if(isAProgram){
						msg = TaskDB.addApprovalTask(conn,kix,approver,delegated);
					}
					else{
						msg = CourseApproval.addApprovalTask(conn,kix,approver,delegated);
					}
					if (debug) logger.info("fast track approval task created ("+approver+") - rowsAffected " + rowsAffected);

					//
					// collect email addresses
					//
					if (sApprovers.equals(Constant.BLANK)){
						sApprovers = approver;
					}
					else{
						sApprovers = sApprovers + "," + approver;
					}

					if (sDelegates.equals(Constant.BLANK)){
						sDelegates = delegated;
					}
					else{
						sDelegates = sDelegates + "," + delegated;
					}

					found = true;

				} // while
				rs.close();
				ps.close();

				// send mail if found
				if (found){

					String emailBundle = "emailOutlineApprovalRequest";

					if(isAProgram){
						emailBundle = "emailProgramApprovalRequest";
					}

					MailerDB mailerDB = new MailerDB(conn,
													proposer,
													sApprovers,sDelegates,"",
													alpha,
													num,
													campus,
													emailBundle,
													kix,
													user);
					if (debug) logger.info("fast track mail sent to " + sApprovers);
				}
			}	// !lastApprover

			if (debug) logger.info("---------------------- FAST TRACK APPROVAL - ENDS");
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: fastTrackApprovers - " + sx.toString());
			rowsAffected = -1;
		} catch(Exception ex){
			logger.fatal("ApproverDB: fastTrackApprovers - " + ex.toString());
			rowsAffected = -1;
		}

		return rowsAffected;
	}

	/*
	 * distributionApprovalCompleted
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	dist		String
	 *	<p>
	 * @return int
	 */
	public static boolean distributionApprovalCompleted(Connection conn,
															String campus,
															String kix,
															String dist,
															int sequence) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean continueApproval = false;

		try{

			if (dist != null && dist.length() > 0){

				int numbersAlreadyApproved = 0;
				float percent = 0;
				float percentApproved = 0;

				Ini ini = IniDB.getIniByCampusCategoryKid(conn,campus,"System","OutlineDistributionApproval");
				String outlineDistributionApproval = ini.getKval1();
				String percentDistributionApproval = ini.getKval2();

				// determine at what level does approval completes. One person, ALL, or a percentage.
				// if no value, ONE is default in that a distribution list is not used. Only valid
				// here if a distribution is in use.

				if (outlineDistributionApproval != null && !outlineDistributionApproval.equals(Constant.BLANK)){

					// if we cannot conver for any reason, set to false and force stop
					if (!percentDistributionApproval.equals(Constant.BLANK)){

						try{
							percent = Float.valueOf(percentDistributionApproval.trim()).floatValue();
							percent = (float)percent/100;
						}
						catch(NumberFormatException e){
							continueApproval = false;
							outlineDistributionApproval = "";
							logger.fatal("ApproverDB - distributionApprovalCompleted - " + e.toString());
						}

					} // percentDistributionApproval

					dist = DistributionDB.removeBracketsFromList(dist);
					int membersInDistribution = DistributionDB.membersInDistribution(conn,campus,dist);

					if (outlineDistributionApproval.equals("ONE")){
						continueApproval = true;
					}
					else if (outlineDistributionApproval.equals("ALL")){
						numbersAlreadyApproved = HistoryDB.approvalBySequence(conn,kix,sequence);
						if (numbersAlreadyApproved==membersInDistribution)
							continueApproval = true;
					}
					else if (outlineDistributionApproval.equals("PERCENT")){
						numbersAlreadyApproved = HistoryDB.approvalBySequence(conn,kix,sequence);
						if (membersInDistribution > 0)
							percentApproved = (float)numbersAlreadyApproved/membersInDistribution;
						else
							percentApproved = 0;

						if (percentApproved >= percent)
							continueApproval = true;
					}
				}
				else{
					continueApproval = true;
				} // outlineDistributionApproval

			}
			else{
				continueApproval = true;
			} // dist

		}catch(Exception e){
			logger.fatal("ApproverDB - distributionApprovalCompleted - " + e.toString());
		}

		return continueApproval;
	}

	/*
	 * getApprovalRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return int
	 */
	public static int getApprovalRouting(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int routing = 0;

		try{
			String sql = "SELECT route FROM tblCourse WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routing = NumericUtil.nullToZero(rs.getInt("route"));
			}
			rs.close();
			ps.close();

		}catch(SQLException se){
			logger.fatal("ApproverDB - getApprovalRouting - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getApprovalRouting - " + e.toString());
		}

		return routing;
	}

	/*
	 * getRoutingIDByName - returns the id of the approval routing by name
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	approval	String
	 *	<p>
	 * @return int
	 */
	public static int getRoutingIDByName(Connection conn,String campus,String approval) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int routing = 0;

		try{
			String sql = "SELECT MIN(id) AS route FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND kid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,approval);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routing = NumericUtil.nullToZero(rs.getInt("route"));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - getRoutingIDByName - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getRoutingIDByName - " + e.toString());
		}

		return routing;
	}

	/*
	 * getRoutingNameByID - returns the name of the approval routing by id
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return	String
	 */
	public static String getRoutingNameByID(Connection conn,String campus,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String routingName = "";

		try{
			String sql = "SELECT kid FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routingName = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - getRoutingNameByID - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getRoutingNameByID - " + e.toString());
		}

		return routingName;
	}

	/*
	 * getRoutingFullNameByID - returns the name of the approval routing by id
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return	String
	 */
	public static String getRoutingFullNameByID(Connection conn,String campus,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String routingName = "";

		try{
			String sql = "SELECT kdesc FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routingName = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - getRoutingFullNameByID - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getRoutingFullNameByID - " + e.toString());
		}

		return routingName;
	}

	/*
	 * getRoutingShortNameByID - returns the name of the approval routing by id
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return	String
	 */
	public static String getRoutingShortNameByID(Connection conn,String campus,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String routingName = "";

		try{
			String sql = "SELECT kid FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routingName = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - getRoutingShortNameByID - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getRoutingShortNameByID - " + e.toString());
		}

		return routingName;
	}

	/*
	 * setApprovalRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	route		int
	 *	<p>
	 * @return int
	 */
	public static int setApprovalRouting(Connection conn,String campus,String alpha,String num,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;
		String type = "PRE";

		try{
			String kix = Helper.getKix(conn,campus,alpha,num,type);

			if (route==0)
				route = getApprovalRouting(conn,campus,kix);

			String sql = "UPDATE tblCourse SET route=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - setApprovalRouting - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - setApprovalRouting - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNumberOfRoutes
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return int
	 */
	public static int getNumberOfRoutes(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int routes = 1;

		try{
			String sql = "SELECT COUNT(DISTINCT route) AS routes FROM tblApprover WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				routes = NumericUtil.nullToZero(rs.getInt("routes"));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("ApproverDB - getNumberOfRoutes - " + se.toString());
		}catch(Exception e){
			logger.fatal("ApproverDB - getNumberOfRoutes - " + e.toString());
		}

		return routes;
	}

	/*
	 * getLastPersonToApproveSeq - sequence of the last person (if any) to approve the outline.
	 *										 this is based on the person APPROVING the outline (approved = 1);
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return int
	 */
	public static int getLastPersonToApproveSeq(Connection conn,String campus,String alpha,String num){

		/*
			determine the seq of last person to approve the outline
		*/

		int seq = 0;
		try{
			String sql = "SELECT MAX(approver_seq) AS MaxOfseq FROM tblApprovalHist "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND approved='1'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				seq = NumericUtil.nullToZero(rs.getInt("MaxOfseq"));
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getLastPersonToApproveSeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getLastPersonToApproveSeq - " + ex.toString());
		}

		return seq;
	}

	/*
	 * getHistoryApproverBySeq - the person completing approval/reject at sequence X (if any)
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	seq		int
	 *	<p>
	 * @return String
	 */
	public static String getHistoryApproverBySeq(Connection conn,String campus,String alpha,String num,int seq){

		String approver = "";

		try{
			String sql = "SELECT approver FROM tblApprovalHist "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND approver_seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setInt(4,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				approver = rs.getString(1);
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getHistoryApproverBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getHistoryApproverBySeq - " + ex.toString());
		}

		return approver;
	}

	/*
	 * hasApprovalTask - does the user have a task to approve an outline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 *	<p>
	 * @return boolean
	 */
	public static boolean hasApprovalTask(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean hasApproval = false;

		try {
			String sql = "SELECT tt.id "
					+ "FROM tblTasks tt INNER JOIN tblCourse tc ON "
					+ "tt.campus=tc.campus "
					+ "AND tt.coursealpha=tc.CourseAlpha "
					+ "AND tt.coursenum=tc.CourseNum "
					+ "WHERE tt.campus=? "
					+ "AND tt.submittedfor=? "
					+ "AND tt.coursealpha=? "
					+ "AND tt.coursenum=? "
					+ "AND tt.message='Approve outline' "
					+ "AND tc.CourseType='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				hasApproval = true;

			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("ApproverDB: hasApprovalTask - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB: hasApprovalTask - " + e.toString());
		}

		return hasApproval;
	}

	/*
	 * getCurrentApprover - who is the current approver for this outline. The current approver is the
	 * 							named user with "Approve outline" task for the matching alpha, num by campus
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return	String
	 */
	public static String getCurrentApprover(Connection conn,String campus,String alpha,String num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String approver = null;

		try {
			String sql = "SELECT submittedfor "
					+ "FROM tblTasks tt INNER JOIN tblCourse tc ON tt.campus=tc.campus "
					+ "AND tt.coursealpha=tc.CourseAlpha AND tt.coursenum=tc.CourseNum "
					+ "WHERE tt.campus=? AND tt.coursealpha=? AND tt.coursenum=? "
					+ "AND (tt.message='Approve outline' OR tt.message='Approve New Outline' OR tt.message='Approve Outline Proposal') "
					+ "AND tc.CourseType='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approver = AseUtil.nullToBlank(rs.getString("submittedfor"));
			}
			rs.close();
			ps.close();

			if (approver == null || approver.length() == 0){
				String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
				approver = getCurrentApproverX(conn,campus,kix);
			}

		} catch (SQLException se) {
			logger.fatal("ApproverDB: getCurrentApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB: getCurrentApprover - " + e.toString());
		}

		return approver;
	} // getCurrentApprover

	/*
	 * getCurrentProgramApprover - who is the current approver for this program. The current approver is the
	 * 							named user with "Approve program" task
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return	String
	 */
	public static String getCurrentProgramApprover(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String approver = null;

		try {
			String sql = "SELECT t.submittedfor FROM tblTasks t INNER JOIN tblPrograms p ON t.historyid = p.historyid "
					+ "WHERE p.campus=? and t.historyid=? AND p.type='PRE' AND t.message LIKE 'Approve program%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approver = AseUtil.nullToBlank(rs.getString("submittedfor"));
			}
			rs.close();
			ps.close();

			if (approver == null || approver.length() == 0){
				approver = getCurrentApproverX(conn,campus,kix);
			}

		} catch (SQLException se) {
			logger.fatal("ApproverDB: getCurrentProgramApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB: getCurrentProgramApprover - " + e.toString());
		}

		return approver;
	} // getCurrentProgramApprover

	/*
	 * getCurrentApproverX - who is the current approver for this outline. The current approver is the
	 * 							named user with "Approve outline" task for the matching alpha, num by campus
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return	String
	 */
	public static String getCurrentApproverX(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean notCurrentlyApproved = false;

		String approver = "";

		try {
			//
			//	if approver is null, then it it's possible the task is missing,
			//		or the approver sent it on for review or back for revision.
			//
			//	to determine who it should be, check as follows...
			//
			//	1) is it in approval?
			//
			//	2) who last said NO in history? If that is found, then it's that person.
			//
			//	3) if we don't find #2, then the person is the last person to approve sequence + 1
			//
			//

			// 1
			String[] info = Helper.getKixInfo(conn,kix);
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
			String progress = info[Constant.KIX_PROGRESS];
			String subprogress = info[Constant.KIX_SUBPROGRESS];

			if (	progress.equals(Constant.COURSE_APPROVAL_TEXT) ||
					progress.equals(Constant.COURSE_DELETE_TEXT) ||
					subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)
				){

				// 2 - was there a NO vote?
				int approverSeq = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

				// 3 - not a NO vote
				if (approverSeq == 0){
					approverSeq = ApproverDB.getLastApproverSequence(conn,campus,kix);
					notCurrentlyApproved = false;
				}
				else{
					notCurrentlyApproved = true;
				}

				// if it's not currently approved, the sequence should not be adjusted
				// this is the case of someone rejecting a review or modification
				if (!notCurrentlyApproved){
					if (approverSeq == 0){
						approverSeq = 1;
					}
					else{
						approverSeq += 1;
					}
				} //notCurrentlyApproved

				approver = ApproverDB.getApproverBySeq(conn,campus,approverSeq,route);
			}

			if (approver!=null && approver.length()>0){
				approver = approver.toUpperCase();
			}
			else{
				approver = "";
			}

		} catch (Exception e) {
			logger.fatal("ApproverDB: getCurrentApproverX - " + e.toString());
		}

		return approver;
	} // getCurrentApproverX

	/*
	 * approvalAlreadyInProgress
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean approvalAlreadyInProgress(Connection conn,String kix) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String alpha = "";
		String num = "";
		String campus = "";

		boolean inProgress = false;

		try {
			// approval is in progress if review history has comments and has acktion = Constant.APPROVAL
			String table = "vw_ReviewerHistory";
			String where = "WHERE historyid='"+kix+"' AND acktion=" + Constant.APPROVAL;
			rowsAffected = (int)AseUtil.countRecords(conn,table,where);

			// approval is in progress if there are records in approval history
			table = "tblApprovalHist";
			where = "WHERE historyid='"+kix+"'";
			rowsAffected += (int)AseUtil.countRecords(conn,table,where);

			// approval is in progress if there are tasks
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			campus = info[4];

			table = "tblTasks";
			where = "WHERE campus='" + campus
				+ "' AND coursealpha='" + alpha
				+ "' AND coursenum='" + num
				+ "' AND message='" + Constant.APPROVAL_TEXT + "'";
			rowsAffected += (int)AseUtil.countRecords(conn,table,where);
		} catch (SQLException e) {
			logger.fatal("userDB: approvalAlreadyInProgress - " + e.toString());
		}

		if (rowsAffected > 0)
			inProgress = true;

		return inProgress;
	}

	/*
	 * isRoutingOutOfSequence
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isRoutingOutOfSequence(Connection conn,String campus,int route) {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int min = 1;
		int max = 0;
		int tempInt = 0;
		int[] seq = new int[100];
		boolean outOfSequence = false;

		try {
			// read all approver seq for a route
			// collect the smallest and highest values
			// the range between min and max should be consecutive
			String sql = "SELECT DISTINCT approver_seq "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND "
				+ "route=? "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				tempInt = rs.getInt(1);
				seq[i] = tempInt;

				// save smallest seq
				if (tempInt < min)
					min = tempInt;

				// save highest seq
				if (tempInt > max)
					max = tempInt;

				// total sequence
				++i;
			}

			// look through and figure out if the routine sequence is in order
			// i is counted from min to max
			// seq[i-1] is array element compared with i
			// if the counter of i is equal to the element in the array,
			// the values are good and outOfSequence = false;
			// however, if the values are not equals, then outOfSequence is true
			i = 1;
			while(i<=max && !outOfSequence){
				if (i != seq[i-1])
					outOfSequence = true;
				++i;
			}

		} catch (SQLException e) {
			logger.fatal("userDB: isRoutingOutOfSequence - " + e.toString());
		}

		return outOfSequence;
	}

	/*
	 * showApprovalRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showApprovalRouting(Connection conn,String campus,int idx){

		//Logger logger = Logger.getLogger("test");

		Approver ap = null;

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String proposer = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String approvalSequence = "";
		String rowColor = "";
		String temp = "";

		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean experimental = false;

		int i = 0;
		int j = 0;
		int route = 0;
		int lastApproverSeq = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT c.id,c.CourseAlpha,c.CourseNum,c.proposer,c.dateproposed,c.auditdate,c.route,i.kid "
				+ "FROM tblCourse c, tblini i "
				+ "WHERE c.route = i.id AND c.campus=? AND c.progress=? AND ";

			if (idx>0)
				sql += "c.coursealpha like '" + (char)idx + "%' AND ";

			sql += "c.CourseType='PRE' " +
				"ORDER BY c.coursealpha,c.coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"APPROVAL");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				experimental = Outlines.isExperimental(num);

				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				route = rs.getInt("route");
				approvalSequence = aseUtil.nullToBlank(rs.getString("kid"));
				kix = aseUtil.nullToBlank(rs.getString("id"));

				dateproposed = aseUtil.nullToBlank(rs.getString("dateproposed"));
				if (!"".equals(dateproposed))
					dateproposed = aseUtil.ASE_FormatDateTime(dateproposed,Constant.DATE_DATETIME);

				auditdate = aseUtil.nullToBlank(rs.getString("auditdate"));
				if (!"".equals(auditdate))
					auditdate = aseUtil.ASE_FormatDateTime(auditdate,Constant.DATE_DATETIME);

				//logger.info("------------------------------");
				//logger.info("1. outline: " + alpha + " - " + num + " - " + route);

				if (!IniDB.doesRoutingIDExists(conn,campus,route))
					route = IniDB.getDefaultRoutingID(conn,campus);

				//logger.info("2. route: " + route);

				//get all approvers
				ap = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);

				if (ap != null){
					//logger.info("3. got approvers");

					// who was last to approve
					lastApproverSeq = ApproverDB.getLastPersonToApproveSeq(conn,campus,alpha,num);

					//logger.info("4. lastApproverSeq: " + lastApproverSeq);

					// split approvers into array to help determine who's up next
					arr = ap.getAllApprovers().split(",");

					//logger.info("5. ap.getAllApprovers(): " + ap.getAllApprovers());

					if (lastApproverSeq==0){
						lastApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);

						if (lastApprover == null || lastApprover.length()==0)
							lastApprover = arr[lastApproverSeq];

						//logger.info("5a. lastApprover: " + lastApprover);
						//logger.info("5b. arr.length: " + arr.length);

						if (arr.length > 1)
							nextApprover = arr[1];
						else
							nextApprover = lastApprover;

						//logger.info("5c. lastApprover: " + lastApprover);

					}
					else{
						//logger.info("5d. lastApprover: " + lastApprover);

						if (arr.length > lastApproverSeq)
							lastApprover = arr[lastApproverSeq];

						//logger.info("5e. lastApprover: " + lastApprover);

						if (lastApproverSeq+1 < arr.length)
							nextApprover = arr[lastApproverSeq+1];
						else
							nextApprover = "";

						//logger.info("5f. lastApprover: " + lastApprover);
					} // lastApproverSeq==0

					//logger.info("6. lastApprover: " + lastApprover);
					//logger.info("7. nextApprover: " + nextApprover);
					//logger.info("8. auditdate: " + auditdate);

					listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
						+ "<td>"
						+ "<a href=\"crsstsh.jsp?kix=" + kix + "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWin5','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"../images/viewhistory.gif\" border=\"0\" alt=\"view approval history\"></a>&nbsp;&nbsp;"
						+ "</td>"
						+ "<td class=\"datacolumn\"><a href=\"/central/core/apprseqx.jsp?kix="+kix+"&r="+route+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>"
						+ "<td class=\"datacolumn\">" + proposer + "</td>"
						+ "<td class=\"datacolumn\">" + lastApprover + "</td>"
						+ "<td class=\"datacolumn\">" + nextApprover + "</td>"
						+ "<td class=\"datacolumn\">" + dateproposed + "</td>"
						+ "<td class=\"datacolumn\">" + auditdate + "</td>"
						+ "<td class=\"datacolumn\">" + approvalSequence + "</td>"
						+ "</tr>");

					found = true;
				}
				else{
					listing.append("<tr height=\"30\" bgcolor=\"" + Constant.COLOR_STAND_OUT + "\">"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"datacolumn\"><a href=\"/central/core/apprseqx.jsp?kix="+kix+"&r="+route+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>"
						+ "<td class=\"datacolumn\">" + proposer + "</td>"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "</tr>");
				}  // if ap != null
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: showApprovalRouting - " + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showApprovalRouting - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr bgcolor=\"#e1e1e1\" height=\"30\">"
						+ "<td class=\"datacolumn\">&nbsp;</td>"
						+ "<td class=\"textblackTH\">Outline</td>"
						+ "<td class=\"textblackTH\">Proposer</td>"
						+ "<td class=\"textblackTH\">Current Approver</td>"
						+ "<td class=\"textblackTH\">Next Approver</td>"
						+ "<td class=\"textblackTH\">Date Proposed</td>"
						+ "<td class=\"textblackTH\">Last Updated</td>"
						+ "<td class=\"textblackTH\">Approval Sequence</td>"
						+ "</tr>"
						+ listing.toString()
						+ "</table>";
		else
			temp = "Outline not found";

		return temp;
	}

	/*
	 * updateApproverRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	oldRoute	int
	 * @param	newRoute	int
	 *	<p>
	 * @return int
	 */
	public static int updateApproverRouting(Connection conn,String campus,String kix,int oldRoute,int newRoute) {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET route=? WHERE campus=? AND historyid=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,newRoute);
			ps.setString(2,campus);
			ps.setString(3,kix);
			ps.setInt(4,oldRoute);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB: updateApproverRouting - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getApproverWhoKickedOffReview
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 *	<p>
	 *	@return String
	 */
	public static String getApproverWhoKickedOffReview(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String approver = "";
		int approverSeq = 0;

		try{

			int route = Outlines.getRoute(conn,kix);

			String sql = "SELECT approver_seq "
				+ "FROM tblApprovalHist "
				+ "WHERE id = ( "
				+ "SELECT max(id) "
				+ "FROM tblApprovalHist "
				+ "WHERE historyid=? "
				+ "AND approved = 0)";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				approverSeq = rs.getInt(1);
			rs.close();
			ps.close();

			/*
				during approval, if approver kicked off review, then not approved (0) would be the
				last item if any found in data table.

				if no history added, then a 0 or nothing would be returned.

				when approverSeq = 0, then no one started so it is the first approver that
				kicked off the review. set approverSeq to 1 and get the name of the approver.

			*/
			if (approverSeq <= 0)
				approverSeq = 1;

			approver = ApproverDB.getApproverBySeq(conn,campus,approverSeq,route);
		}
		catch(SQLException e){
			logger.fatal("ApproverDB: getApproverWhoKickedOffReview - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ApproverDB: getApproverWhoKickedOffReview - " + e.toString());
		}

		return approver;
	}

	/*
	 * getSequenceNotApproved
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 *	<p>
	 *	@return String
	 */
	public static int getSequenceNotApproved(Connection conn,String campus,String kix) throws Exception {

		int sequence = 0;

		try{
			// get approval
			// approval is the approver who has not yet completed their approval
			// IE: on list of approvers for a particular route, the person that is
			// approving may send out for review. that person has not completed the
			// approval process and is waiting for reviewers to finish

			// sql statement to get all IDs of approvers not approving (approved=0)
			// from there, the highest ID is the last entry.
			// approver in that ID is the one kicking back for review in approval
			String sql = "SELECT approver_seq FROM tblApprovalHist "
				+ "WHERE id = (SELECT max(id) FROM tblApprovalHist WHERE historyid=? AND approved = 0)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				sequence = rs.getInt(1);
			}
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal("ApproverDB: getApproverWhoKickedOffReview - " + e.toString());
		}

		return sequence;
	}

	/*
	 * lastApproverVotedNO
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean lastApproverVotedNO(Connection conn,String campus,String kix) throws Exception {

		boolean approved = true;

		try{
			// get approval
			// approval is the approver who has not yet completed their approval
			// IE: on list of approvers for a particular route, the person that is
			// approving may send out for review. that person has not completed the
			// approval process and is waiting for reviewers to finish

			// sql statement to get all IDs of approvers not approving (approved=0)
			// from there, the highest ID is the last entry.
			// approver in that ID is the one kicking back for review in approval
			String sql = "SELECT approved FROM tblApprovalHist "
				+ "WHERE id = (SELECT max(id) FROM tblApprovalHist WHERE historyid=? AND role=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,Constant.TASK_APPROVER);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				approved = rs.getBoolean(1);
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal("ApproverDB: lastApproverVotedNO - " + e.toString());
		}

		// returns opposite since a no vote makes this routine true
		return !approved;
	}

	/*
	 * lastApproverVotedNOSequence
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 *	<p>
	 *	@return int
	 */
	public static int lastApproverVotedNOSequence(Connection conn,String campus,String kix) throws Exception {

		int sequence = 0;

		try{
			// determine whether the last approver said NO. If so, figure out the
			// sequence of the approver
			if (lastApproverVotedNO(conn,campus,kix)){
				sequence = getLastApproverSequence(conn,campus,kix);
			}
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: lastApproverVotedNOSequence - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: lastApproverVotedNOSequence - " + ex.toString());
		}

		return sequence;
	}

	/*
	 * getLastApproverSequence - sequence of the last person to attempt approving the outline.
	 * this is an attempt at approver where as getLastPersonToApproveSeq
	 * gets the actual person last to approve and outline (approved = 1)
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return int
	 */
	public static int getLastApproverSequence(Connection conn,String campus,String kix){

		int sequence = 0;
		try{
			String sql = "SELECT approver_seq FROM tblApprovalHist "
				+ "WHERE id = (SELECT max(id) FROM tblApprovalHist WHERE historyid=? AND role=? AND progress<>?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,Constant.TASK_APPROVER);
			ps.setString(3,Constant.COURSE_RECALLED);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				sequence = rs.getInt(1);
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getLastApproverSequence - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getLastApproverSequence - " + ex.toString());
		}

		return sequence;
	}

	/*
	 * showRejectedApprovalSelection - show how a campus wishes to have reject approvals treated
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String
	 */
	public static String showRejectedApprovalSelection(Connection conn,String campus){

		String message = "";

		try{
			String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
			if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection))
				message = campus + " has chosen to restart the approval process with the first approver after a request for revision.";
			else if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection))
				message = campus + " has chosen to restart the approval process at the point where it was sent back for revision as compared to restarting with the first approver.";
			else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection))
				message = campus + " has chosen to restart the approval process with the previous approver (one step back).";
			else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection))
				message = campus + " has decided that the approver should determine who to return the outline to for revision.";
		} catch(Exception ex){
			logger.fatal("ApproverDB: showRejectedApprovalSelection - " + ex.toString());
		}

		return message;
	}

	/*
	 * approverAtSequenceOne - when #1 is not obvious, look in areas where it may present who is first up
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return String
	 */
	public static String approverAtSequenceOne(Connection conn,String campus,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		String dcApprover = "";
		String firstApproverInHistory = "";
		String taskAssignedToApprover = "";
		String approverAtSequence1 = "";

		try{

			int route = 0;
			String[] info = null;

			// must find the first approver so that we are not adding all fast track for first approvers

			// is this the one and only person for the route
			// if not 1 and only person for route, first is the division/department chair OR
			// if not DC, then locate first approver in the history table
			// if not in history then first task assigned
			if(ProgramsDB.isAProgramByTitle(conn,campus,alpha)){
				String kix = ProgramsDB.getProgramItem(conn,campus,alpha,"historyid");
				info = Helper.getKixInfo(conn,kix);
				route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			}
			else{
				info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
				route = NumericUtil.nullToZero(info[1]);
			}

			int getApproverCount = ApproverDB.getApproverCount(conn,campus,1,route);

			if (getApproverCount==1){
				approverAtSequence1 = ApproverDB.getApproverBySeq(conn,campus,1,route);
			}
			else{
				dcApprover = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
				if (dcApprover == null || dcApprover.length() == 0){
					firstApproverInHistory = ApproverDB.getHistoryApproverBySeq(conn,campus,alpha,num,1);
					if (firstApproverInHistory == null || firstApproverInHistory.length() == 0){
						taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);
						if (taskAssignedToApprover != null && taskAssignedToApprover.length() > 0){
							approverAtSequence1 = taskAssignedToApprover;
						}
						else{
							approverAtSequence1 = "";
						}
					}
					else{
						firstApproverInHistory = firstApproverInHistory;
					}
				}
				else{
					approverAtSequence1 = dcApprover;
				}
			} // approverCount == 1

		} catch(Exception ex){
			logger.fatal("ApproverDB: approverAtSequenceOne - " + ex.toString());
		}

		return approverAtSequence1;
	}

	/*
	 * getRoutingInUse - display routing sequence in use by route
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getRoutingInUse(Connection conn,String campus,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();

		String listing = "";

		boolean found = false;

		try{
			listings.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"jqueryGetRoutingInUse\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">Proposer</th>"
				+ "<th align=\"left\">Alpha</th>"
				+ "<th align=\"left\">Number</th>"
				+ "<th align=\"left\">Title</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			String sql = "SELECT CourseAlpha, CourseNum, coursetitle, proposer, historyid "
							+ "FROM tblCourse WHERE campus=? AND route=? ORDER BY CourseAlpha, CourseNum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
				String num = AseUtil.nullToBlank(rs.getString("CourseNum"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				listings.append("<tr>"
					+ "<td align=\"left\"><a href=\"rte.jsp?t=outlines&route="+route+"&kix="+kix+"\" class=\"linkcolumn\">" + proposer + "</a></td>"
					+ "<td align=\"left\">" + alpha + "</td>"
					+ "<td align=\"left\">" + num + "</td>"
					+ "<td align=\"left\">" + title + "</td>"
					+ "</tr>");

				found = true;

			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr class=\"textblack\">"
						+ "<td width=\"50%\" align=\"left\">Approval routing is in process for the following <strong>OUTLINES</strong>.<br/>Click on the proposer's name to change the routing sequence.</td>"
						+ "<td width=\"50%\" align=\"right\" valign=\"bottom\"><a href=\"/central/servlet/progress?t=outlines&c="+campus+"&r="+route+"\" class=\"linkcolumn\" target=\"_blank\">Print report</a>&nbsp;&nbsp;&nbsp;</td>"
						+ "</tr>"
						+ "</table><br/>"
						+ listings.toString()
						+ "</tbody></table></div></div>";
			}
			else{
				listing = "";
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getRoutingInUse - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getRoutingInUse - " + ex.toString());
		}

		return listing;
	}

	/*
	 * addApprovalRouting
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	shortName	String
	 * @param	longName		String
	 * @param	divs			String
	 * @param	college		String
	 * @param	dept			String
	 * @param	level			String
	 *	<p>
	 * @return String
	 */

	public static int addApprovalRouting(Connection conn,String campus,String user,String shortName,String longName){

		return addApprovalRouting(conn,campus,user,shortName,longName,null);

	}

	public static int addApprovalRouting(Connection conn,String campus,String user,String shortName,String longName,String divs){

		return addApprovalRouting(conn,campus,user,shortName,longName,divs,null,null,null);

	}

	public static int addApprovalRouting(Connection conn,
														String campus,
														String user,
														String shortName,
														String longName,
														String divs,
														String college,
														String dept,
														String level){

		int rowsAffected = 0;

		try{
			// add the new routing name
			Ini ini = new Ini("0",
									Constant.APPROVAL_ROUTING,
									shortName,
									longName,college,dept,level,"", "",
									user,
									AseUtil.getCurrentDateTimeString(),
									campus,
									"Y");

			rowsAffected = IniDB.insertIni(conn,ini,"N");

			AseUtil.logAction(conn,user,"ACTION","Add approval routing - ("+ shortName + ")","","",campus,"");

			// ER00027 - MAN
			// connect these divisions to the routing just added
			if (divs != null && divs.length() > 0){
				int routeID = IniDB.getIDByCampusCategoryKid(conn,campus,Constant.APPROVAL_ROUTING,shortName);

				DivisionDB.saveDivisionToRouting(conn,routeID,divs);
			}

		} catch(Exception e){
			logger.fatal("ApproverDB: addApprovalRouting - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * copyApprovalRouting
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	shortName	String
	 * @param	longName		String
	 * @param	oldRoute		int
	 * @param	copyAssociatedDivs	int
	 * @param	college		String
	 * @param	dept			String
	 * @param	level			String
	 *	<p>
	 * @return String
	 */
	public static int copyApprovalRouting(Connection conn,
														String campus,
														String user,
														String shortName,
														String longName,
														int oldRoute,
														int copyAssociatedDivs){

		return copyApprovalRouting(conn,campus,user,shortName,longName,oldRoute,copyAssociatedDivs,"","","");

	}

	public static int copyApprovalRouting(Connection conn,
														String campus,
														String user,
														String shortName,
														String longName,
														int oldRoute,
														int copyAssociatedDivs,
														String college,
														String dept,
														String level){

		int rowsAffected = 0;
		int newRoute = 0;
		String seq = "";
		String approver = "";
		String delegated = "";
		String sql = "";

		Approver approverDB = null;

		try{
			// add the new routing name
			rowsAffected = addApprovalRouting(conn,campus,user,shortName,longName,"",college,dept,level);

			// if successful, add the approvers
			if (rowsAffected > 0){
				newRoute = IniDB.getIDByCampusCategoryKid(conn,campus,Constant.APPROVAL_ROUTING,shortName);

				sql = "SELECT approver_seq, approver, delegated FROM tblApprover "
					+ "WHERE campus=? AND route=? ORDER BY approver_seq, approver";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,oldRoute);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					seq = rs.getString("approver_seq");
					approver = AseUtil.nullToBlank(rs.getString("approver"));
					delegated = AseUtil.nullToBlank(rs.getString("delegated"));

					approverDB = new Approver(Constant.BLANK,
														seq,
														approver,
														delegated,
														false,
														false,
														user,
														AseUtil.getCurrentDateTimeString(),
														campus,
														newRoute);

					rowsAffected = ApproverDB.insertApprover(conn,approverDB);

				}
				rs.close();
				ps.close();

				// ER00027 - MAN
				if(copyAssociatedDivs==1){
					sql = "INSERT INTO tbldivroutes(route,divid) "
						+ "SELECT "+newRoute+",divid FROM tbldivroutes WHERE route=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,oldRoute);
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // copyAssociatedDivs

			}	// if

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: copyApprovalRouting - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: copyApprovalRouting - " + ex.toString());
		}

		return newRoute;
	}

	/*
	 * deleteApprovalRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static int deleteApprovalRouting(Connection conn,String campus,int route){

		int rowsAffected = 0;
		String sql = "";

		try{
			if (!isRoutingInUse(conn,campus,route)){

				String routeName = IniDB.getKid(conn,(""+route));

				// ER00027 - MAN
				// delete the routing associated divsx
				sql = "DELETE FROM tbldivroutes WHERE route=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,route);
				rowsAffected = ps.executeUpdate();
				AseUtil.logAction(conn, "CAMPADM", "ACTION","Delete approval routing - assoc divs ("+ routeName + ")","","",campus,"");
				ps.close();

				// delete the routing approvers
				sql = "DELETE "
					+ "FROM tblApprover "
					+ "WHERE campus=? "
					+ "AND route=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				rowsAffected = ps.executeUpdate();
				AseUtil.logAction(conn, "CAMPADM", "ACTION","Delete approval routing - approvers ("+ routeName + ")","","",campus,"");
				ps.close();

				// delete the routing name
				sql = "DELETE "
					+ "FROM tblIni "
					+ "WHERE campus=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				rowsAffected = ps.executeUpdate();
				AseUtil.logAction(conn, "CAMPADM", "ACTION","Delete approval routing - route ("+ routeName + ")","","",campus,"");
				ps.close();
			}
			else
				rowsAffected = 2;
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: deleteApprovalRouting - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: deleteApprovalRouting - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * isRoutingInUse - yes if there is a course with the route in use for approval
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isRoutingInUse(Connection conn,String campus,int route){

		boolean inUse = false;

		try{
			AseUtil aseUtil = new AseUtil();

			long countRecords = aseUtil.countRecords(conn,"tblCourse","WHERE campus='"+campus+"' "
				+ " AND (progress='" + Constant.COURSE_MODIFY_TEXT + "' OR progress='" + Constant.COURSE_APPROVAL_TEXT + "') "
				+ " AND route="+route);

			if (countRecords > 0)
				inUse = true;
			else
				inUse = false;

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: isRoutingInUse - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: isRoutingInUse - " + ex.toString());
		}

		return inUse;
	}

	/*
	 * isApprover - is the user allowed to comment on an outline
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isApprover(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean isAnApprover = false;

		try{

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			if(route > 0){
				Approver approver = ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);
				if (	approver != null
						&& approver.getAllApprovers() != null
						&& approver.getAllApprovers().length() > 0
						&& approver.getAllApprovers().indexOf(user) > -1){
					isAnApprover = true;
				}
			}

		}
		catch( SQLException e ){
			logger.fatal("ApproverDB: isApprover - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ApproverDB: isApprover - " + ex.toString());
		}

		return isAnApprover;
	}

	/*
	 * getApproverHistory
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	campus
	 *	<p>
	 *	@return String
	 */
	public static String getApproverHistory(Connection conn,String kix,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String sql = "";
		StringBuffer approval = new StringBuffer();

		int seq = 0;

		AseUtil aseUtil = new AseUtil();

		try {
			approval.append("<table border=\"0\" cellpadding=\"1\" width=\"100%\">");

			sql = "SELECT approver as reviewer, dte, comments, approver_seq as seq "
				+ "FROM vw_ApproverHistory WHERE historyid=? ORDER BY approver_seq, dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("seq");

				approval.append( "<tr class=\"rowhighlight\"><td valign=top class=datacolumn>"
					+ rs.getString("reviewer").trim()
					+ " - "
					+ aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME)
					+ "</td></tr>" );

				approval.append( "<tr><td valign=top class=datacolumn>"
					+ rs.getString("comments").trim()
					+ "</td></tr>" );
			}

			rs.close();
			ps.close();

			approval.append("</table>");

		} catch (SQLException e) {
			logger.fatal("ApproverDB: getApproverHistory - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ApproverDB: getApproverHistory - " + ex.toString());
		}

		temp = "<br/><fieldset class=\"FIELDSET700\">"
			+ "<legend>Approver comments</legend>"
			+ approval.toString()
			+ "</fieldset>";

		return temp;
	}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public static String showApproversDateInput(Connection conn,String campus,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String rtn = "";
		String link = "";

		String approverid = "";
		String seq = "";
		String approver = "";
		String title = "";
		String position = "";
		String department = "";
		String startDate = "";
		String endDate = "";

		String rowColor = "";
		int j = 0;

		boolean found = false;

		String fieldName = "";
		String hidden = "";
		String hiddenSeq = "";

		//logger.info("ApproverDB - showApprovers");

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT * FROM vw_Approvers2 WHERE campus=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				approverid = aseUtil.nullToBlank(rs.getString("approverid")).trim();
				seq = aseUtil.nullToBlank(rs.getString("approver_seq")).trim();
				approver = aseUtil.nullToBlank(rs.getString("approver")).trim();
				title = aseUtil.nullToBlank(rs.getString("title")).trim();
				position = aseUtil.nullToBlank(rs.getString("position")).trim();
				department = aseUtil.nullToBlank(rs.getString("department")).trim();
				//startDate = aseUtil.nullToBlank(rs.getString("startDate")).trim();
				endDate = aseUtil.nullToBlank(rs.getString("endDate")).trim();

				fieldName = approver+seq+"End";

				if (j==0){
					hidden = approver;
					hiddenSeq = "" + seq;
				}
				else{
					hidden = hidden + "," + approver;
					hiddenSeq = hiddenSeq + "," + seq;
				}

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				buf.append("<tr bgcolor=\"" + rowColor + "\">" +
					"<td class=\"datacolumn\"><a href=\"appr.jsp?rte="+route+"&lid=" + approverid + "\" class=\"linkcolumn\">" + seq + "</a></td>" +
					"<td class=\"datacolumn\">" + approver + "</td>" +
					"<td class=\"datacolumn\">" + title + "</td>" +
					"<td class=\"datacolumn\">" + position + "</td>" +
					"<td class=\"datacolumn\">" + department + "</td>" +
					"<td class=\"datacolumn\">" +
					"<input type=\"text\" class=\"input\" maxlength=\"10\" size=\"10\" value=\""+endDate+"\" name=\""+fieldName+"\">" +
					"&nbsp;<A HREF=\"#\" onClick=\"dateCal.select(document.aseForm2."+fieldName+",'anchorDate','MM/dd/yyyy'); return false;\" NAME=\"anchorDate\" ID=\"anchorDate\" class=\"linkcolumn\">" +
					"<img src=\"../images/images/calendar.gif\" border=\"0\" alt=\"\" title=\"\"></A>" +
					"</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: showApproversDateInput\n" + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: showApproversDateInput - " + ex.toString());
			buf.setLength(0);
		}

		if (found){
			rtn = "<table class=\"" + campus + "BGColor\" width=\"90%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr class=\"" + campus + "BGColor\">" +
					"<td>Sequence</td>" +
					"<td>Approver</td>" +
					"<td>Title</td>" +
					"<td>Position</td>" +
					"<td>Department</td>" +
					"<td>Approve By Date</td>" +
					"</tr>" +
					buf.toString() +
					"<input type=\"hidden\" value=\""+hidden+"\" name=\"hiddenFields\">" +
					"<input type=\"hidden\" value=\""+hiddenSeq+"\" name=\"hiddenSeqFields\">" +
					"<input type=\"hidden\" value=\""+route+"\" name=\"route\">" +
					"</table>";
		}
		else
			rtn = "Approvers not set up for campus";

		return rtn;
	}

	/*
	 * updateApprovalDates - yes if there is a course with the route in use for approval
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return boolean
	 */
	public static Msg updateApprovalDates(Connection conn,HttpServletRequest request,String campus,int route){

		Msg msg = new Msg();

		StringBuffer buf = new StringBuffer();

		boolean error = false;

		try{
			WebSite website = new WebSite();

			String hiddenFields = website.getRequestParameter(request,"hiddenFields", "");
			String hiddenSeqFields = website.getRequestParameter(request,"hiddenSeqFields", "");

			String[] aHiddenFields = hiddenFields.split(",");
			String[] aHiddenSeqFields = hiddenSeqFields.split(",");
			for(int i=0; i<aHiddenFields.length; i++){
				String endDate = website.getRequestParameter(request,aHiddenFields[i]+aHiddenSeqFields[i]+"End","");
				if (endDate.length() == 0 || DateUtility.isValidDate(endDate)){
					String sql = "UPDATE tblApprover SET enddate=? "
									+ "WHERE campus=? AND approver=? AND approver_seq=? AND route=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,endDate);
					ps.setString(2,campus);
					ps.setString(3,aHiddenFields[i]);
					ps.setString(4,aHiddenSeqFields[i]);
					ps.setInt(5,route);
					int rowsAffected = ps.executeUpdate();
				}
				else{
					error = true;
					buf.append("Invalid date format for " + aHiddenFields[i] + "<br>");
				}
			}

			if(error){
				msg.setMsg("Warning");
				msg.setErrorLog(buf.toString());
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: updateApprovalDates - " + sx.toString());
			msg.setMsg("Exception");
		} catch(Exception ex){
			logger.fatal("ApproverDB: updateApprovalDates - " + ex.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * countApprovalsByRoute - approvers set to a particular route
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 *	@return long
	 */
	public static long countApprovalsByRoute(Connection conn,String campus,int route){

		long countRecords = 0;

		try{
			countRecords = AseUtil.countRecords(conn,
														"tblCourse",
														"WHERE campus='"+campus+"' AND route="+route);
		} catch(Exception ex){
			logger.fatal("ApproverDB: countApprovalsByRoute - " + ex.toString());
		}

		return countRecords;
	}

	/*
	 * notifyApproverOfChangeInSequence
	 *	<p>
	 *	@param	conn
	 * @param	campus
	 * @param	currentApprover
	 * @param	approver
	 * @param	delegated
	 * @param	route
	 * @param	seq
	 *	<p>
	 *	@return long
	 */
	public static String notifyApproverOfChangeInSequence(Connection conn,
																			String campus,
																			String currentApprover,
																			String approver,
																			String delegated,
																			int route,
																			int seq){

		/*
			when changing names of approvers and there are courses already in motion,
			we want to notify the new approver if this is her/his turn up to approve

			the SQL statement retrieves all courses with the route in motion as well as
			the approver if this his/her turn

			IE: If a change to approver #2, then notify new approver for all courses
			that has max approver of 1 (2 - 1) so that only items ready for #2 are sent

		*/

		//Logger logger = Logger.getLogger("test");

		String kix = "";
		String temp = "";
		String[] info = null;
		String alpha = null;
		String num = null;
		String type = null;
		String proposer = null;

		int rowsAffected = 0;

		String sequenceName = "";

		try{
			logger.info("----------------------------> START");
			logger.info("notifyApproverOfChangeInSequence");

			sequenceName = ApproverDB.getRoutingFullNameByID(conn,campus,route);

			logger.info("campus: " + campus);
			logger.info("route: " + route);
			logger.info("sequenceName: " + sequenceName);
			logger.info("seq: " + seq);

			String sql = "SELECT historyid, approver_seq "
				+ "FROM  tblApprovalHist "
				+ "WHERE (seq IN "
				+ "( "
				+ "SELECT MAX(tblApprovalHist.seq) AS MAX_SEQ "
				+ "FROM tblCourse INNER JOIN "
				+ "tblApprovalHist ON tblCourse.historyid = tblApprovalHist.historyid "
				+ "WHERE tblCourse.campus = ? "
				+ "AND tblCourse.route = ? "
				+ "AND tblCourse.Progress = 'APPROVAL' "
				+ "GROUP BY tblCourse.campus, tblCourse.historyid))  "
				+ "AND approver_seq = ? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));

				logger.info("kix: " + kix);

				info = Helper.getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
				type = info[Constant.KIX_TYPE];
				proposer = info[Constant.KIX_PROPOSER];

				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("proposer: " + proposer);

				// who is the next approver and delegate to recieve notice
				// remove from the one there now
				if (approver != null && approver.length() > 0){

					if (currentApprover != null && currentApprover.length() > 0){
						rowsAffected = TaskDB.logTask(conn,
																currentApprover,
																currentApprover,
																alpha,
																num,
																Constant.APPROVAL_TEXT,
																campus,
																"",
																"REMOVE",
																type);

						logger.info("Remove task for current approver - " + currentApprover);
					} // if currentApprover

					rowsAffected = TaskDB.logTask(conn,
																approver,
																proposer,
																alpha,
																num,
																Constant.APPROVAL_TEXT,
																campus,
																"",
																"ADD",
																type,
																proposer,
																Constant.TASK_APPROVER,
																kix,
																Constant.COURSE);

					logger.info("Add task for approver - " + approver);

					if (delegated != null && delegated.length() > 0){
						rowsAffected = TaskDB.logTask(conn,
																	approver,
																	proposer,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	"",
																	"ADD",
																	type,
																	proposer,
																	Constant.TASK_APPROVER,
																	kix,
																	Constant.COURSE);

						logger.info("Add task for delegate - " + delegated);
					} // if delegated

					MailerDB mailerDB = new MailerDB(conn,
																proposer,
																approver,delegated,"",
																alpha,
																num,
																campus,
																"emailOutlineApprovalRequest",
																kix,
																proposer);

					logger.info("Approver sequence changed from " + currentApprover + " to " + approver);
					AseUtil.logAction(conn,approver,
											"ACTION","Approver sequence " + sequenceName + " changed from "
											+ currentApprover
											+ " to "
											+ approver,
											"",
											"",
											campus,
											kix);

				} // approver not null

			}
			rs.close();
			ps.close();

			logger.info("----------------------------> END");
		}
		catch(SQLException ex){
			logger.fatal("ApproverDB: showProgramsNeedingApproval - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: showProgramsNeedingApproval - " + ex.toString());
		}

		return temp;
	}

	/*
	 * isLastApprover - the last person on the list to approve
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	route		int
	 *	<p>
	 * @return boolean
	 */
	public static boolean isLastApprover(Connection conn,String campus,String user,int route){

		// determine the last person to approve the outline

		boolean approver = false;

		try{
			String sql = "SELECT approver "
						+ "FROM tblApprover "
						+ "WHERE campus=? "
						+ "AND route=? "
						+ "AND approver_seq = "
						+ "(SELECT MAX(approver_seq) AS max_approver "
						+ "FROM tblApprover "
						+ "WHERE campus=? AND route=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setString(3,campus);
			ps.setInt(4,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				if (user.equals(AseUtil.nullToBlank(rs.getString("approver"))))
					approver = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: isLastApprover - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: isLastApprover - " + ex.toString());
		}

		return approver;
	}

	/*
	 * updateRouting
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 * @param	route		int
	 *	<p>
	 * @return int
	 */
	public static int updateRouting(Connection conn,String kix,String user,int routeX){

		int rowsAffected = 0;
		int route = 0;

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
			String campus = info[Constant.KIX_CAMPUS];

			String oldRouting = ApproverDB.getRoutingFullNameByID(conn,campus,route);
			String newRouting = ApproverDB.getRoutingFullNameByID(conn,campus,routeX);

			rowsAffected = CourseDB.setCourseItem(conn,kix,"route",""+routeX,"i");

			if (oldRouting == null || oldRouting.length() == 0)
				oldRouting = "BLANK";

			AseUtil.logAction(conn,
									user,
									"ACTION",
									"Outline approval routing changed from " + oldRouting + " to " + newRouting,
									alpha,
									num,
									campus,
									kix);

		} catch(Exception ex){
			logger.fatal("ApproverDB: updateRouting - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getFirstPersonToApprove - the first person (if any) to approve the outline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getFirstPersonToApprove(Connection conn,String campus,int route){

		//Logger logger = Logger.getLogger("test");

		String approver = null;

		try{
			String sql = "SELECT approver FROM tblApprover WHERE campus=? AND route=? AND approver_seq=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approver = AseUtil.nullToBlank(rs.getString("approver"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getFirstPersonToApprove - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getFirstPersonToApprove - " + ex.toString());
		}

		return approver;
	}

	/*
	 * getFirstPersonToApprove - the first person (if any) to approve the outline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getFirstPersonToApprove(Connection conn,String campus,String alpha,int route){

		//Logger logger = Logger.getLogger("test");

		String approver = "";

		try{
			approver = getPersonToApprove(conn,campus,alpha,"",route,1);
		} catch(Exception e){
			logger.fatal("ApproverDB: getFirstPersonToApprove - " + e.toString());
		}

		return approver;
	}

	public static String getFirstPersonToApprove(Connection conn,String campus,String alpha,String num,int route){

		//Logger logger = Logger.getLogger("test");

		String approver = "";

		try{
			approver = getPersonToApprove(conn,campus,alpha,num,route,1);
		} catch(Exception e){
			logger.fatal("ApproverDB: getFirstPersonToApprove - " + e.toString());
		}

		return approver;
	}

	/*
	 * getPersonToApprove - the first person (if any) to approve the outline
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	route		int
	 * @param	seq		int
	 *	<p>
	 * @return String
	 */
	public static String getPersonToApprove(Connection conn,String campus,String alpha,String num,int route,int seq){

		//Logger logger = Logger.getLogger("test");

		String approver = "";

		try{
			int getApproverCount = ApproverDB.getApproverCount(conn,campus,seq,route);
			if (getApproverCount > 1){
				approver = ChairProgramsDB.getChairName(conn,campus,alpha);

				if(approver == null || approver.length() == 0){
					approver = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
				}

			}
			else{
				approver = ApproverDB.getApproverBySeq(conn,campus,seq,route);
			}
		}
		catch(SQLException e){
			logger.fatal("ApproverDB: getPersonToApprove - " + e.toString());
		} catch(Exception e){
			logger.fatal("ApproverDB: getPersonToApprove - " + e.toString());
		}

		return approver;
	}

	/*
	 * drawApprovalRoutingList
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	alpha		String
	 * @param	control	String
	 *	<p>
	 * @return String
	 */
	public static String drawApprovalRoutingList(Connection conn,String campus,String user,String alpha,String control) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String html = "";
		String routes = "0";		// include a value here to prevent SQL IN error
		String v1 = null;
		String v2 = null;

		int routeCounter = 0;

		boolean found = false;

		try {
			// retrieve routes that is associated with this alpha for the user
			String sql = "SELECT dr.route "
				+ "FROM tblDivRoutes dr INNER JOIN "
				+ "tblDivision d ON dr.divid = d.divid INNER JOIN "
				+ "tblChairs c ON d.divid = c.programid "
				+ "WHERE d.campus=? AND d.chairname=? AND coursealpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,alpha);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				routes = routes + "," + rs.getInt("route");
				++routeCounter;
				//
			} // while
			rs.close();
			ps.close();

			sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category=? ";

			// if an alpha was not associated or not a valid alpha, we
			// show all routes
			if (!routes.equals("0")){
				sql += "AND id IN ("+routes+") ";
			}

			sql += "ORDER BY kdesc";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"ApprovalRouting");
			rs = ps.executeQuery();
			while (rs.next()) {
				v1 = AseUtil.nullToBlank(rs.getString(1));
				v2 = AseUtil.nullToBlank(rs.getString(2));

				if(ApproverDB.countApproversForRoute(conn,campus,NumericUtil.getInt(v1,0)) > 0){

					// a single route is a checkbox
					if (routeCounter == 1){
						temp.append("<input type=\"checkbox\" "
							+ "value=\"" + v1 + "\" "
							+ "name=\"" + control +"\">" + v2 + "<br>");
					}
					else{
						temp.append("<input type=\"radio\" "
							+ "value=\"" + v1 + "\" "
							+ "name=\"" + control +"\">" + v2 + "<br>");
					}

					found = true;

				} // must have approvers to be included in list

			}

			// save a hidden view to tell JS how to validate
			temp.append("<input type=\"hidden\" "
				+ "value=\"" + routeCounter + "\" "
				+ "name=\"routeCounter\">");

			rs.close();
			ps.close();

			if(found){
				html = temp.toString();
			}

		} catch (SQLException e) {
			logger.fatal("ApproverDB - drawApprovalRoutingList - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB - drawApprovalRoutingList - " + e.toString());
		}

		return html;
	} // ApproverDB.drawApprovalRoutingList

	/*
	 * routingExists
	 *	<p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	route			int
	 *	<p>
	 * @return boolean
	 */
	public static boolean routingExists(Connection connection,String campus,int route) throws SQLException {

		boolean exists = false;

		try {
			String sql = "SELECT id FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ApproverDB - routingExists - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB - routingExists - " + e.toString());
		}

		return exists;
	}

	/**
	 * countApproversForRoute - Count number of approver comments for each item
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param route	int
	 * <p>
	 * @return int
	 *
	 */
	public static int countApproversForRoute(Connection conn,String campus,int route) throws java.sql.SQLException {

		int count = 0;

		try {
			String sql = "SELECT COUNT(route) AS counter FROM tblapprover WHERE campus=? AND route=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt("counter");
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: countApproversForRoute - " + e.toString());
		}

		return count;
	}


	/**
	 * drawApprovalSequence
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param user		String
	 * @param alpha	String
	 * <p>
	 * @return String
	 * <p>
	 */
	public static String drawApprovalSequence(Connection conn,String campus,String user,String alpha) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		boolean found = false;
		String html = "";

		try {
			PreparedStatement ps = null;

			// default select for approval routing not needing packets
			String sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category='ApprovalRouting' ORDER BY kdesc";

			long allRoutes = AseUtil.countRecords(conn,"tblINI","WHERE campus='"+campus +"' AND category='ApprovalRouting'");

			String enableCollegeCodes = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCollegeCodes");
			String approvalSubmissionAsPackets = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

			if(enableCollegeCodes.equals(Constant.ON) || approvalSubmissionAsPackets.equals(Constant.ON)){

				// when college code is enabled, we check to see the level of display. from college to dept to level
				String college = UserDB.getCollegeCode(conn,user);

				long collegeCount = 0;
				long deptCount = 0;

				// see if we have valid approval setting configured; if not, we'll list all routes
				if(!college.equals(Constant.BLANK)){
					collegeCount = AseUtil.countRecords(conn,"tblINI","WHERE campus='"+campus
																			+"' AND category='ApprovalRouting' AND kval1='"+college
																			+"' AND kval2='"+alpha+"'");
				}
				else{
					deptCount = AseUtil.countRecords(conn,"tblINI","WHERE campus='"+campus
																			+"' AND category='ApprovalRouting' AND kval2='"+alpha+"'");
				}

				// get approval sequence based on college or department setup
				if(!college.equals(Constant.BLANK) && collegeCount > 0){

					allRoutes = collegeCount;

					sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND kval1=? AND kval2=? ORDER BY kdesc";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,college);
					ps.setString(3,alpha);
				}
				else if (!alpha.equals(Constant.BLANK) && deptCount > 0){

					allRoutes = deptCount;

					sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category='ApprovalRouting' AND kval2=? ORDER BY kdesc";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
				}
				else {
					sql = "SELECT id,kdesc FROM tblINI WHERE campus=? AND category='ApprovalRouting' ORDER BY kdesc";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
				}

			}
			else{
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				if (allRoutes == 1){
					temp.append("<input type=\"checkbox\" "
						+ "value=\"" + NumericUtil.getInt(rs.getString(1),0) + "\" "
						+ "name=\"route\">" + AseUtil.nullToBlank(rs.getString(2)) + "<br>");
				}
				else{
					temp.append("<input type=\"radio\" "
						+ "value=\"" + NumericUtil.getInt(rs.getString(1),0) + "\" "
						+ "name=\"route\">" + AseUtil.nullToBlank(rs.getString(2)) + "<br>");
				}

				found = true;
			}
			rs.close();
			ps.close();

			// save a hidden view to tell JS how to validate
			temp.append("<input type=\"hidden\" "
				+ "value=\"" + allRoutes + "\" "
				+ "name=\"routeCounter\">");

			if(found){
				html = temp.toString();
			}

		} catch (SQLException e) {
			logger.fatal("ApproverDB - drawApprovalSequence - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB - drawApprovalSequence - " + e.toString());
		}

		return html;

	}

	/*
	 * showPendingApprovals
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	chair		String
	 *	<p>
	 *	@return String
	 */
	public static String showPendingApprovals(Connection conn,String campus,String chair) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		try{

			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"crsapprpnd\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">&nbsp;</th>"
				+ "<th align=\"left\">Outline</th>"
				+ "<th align=\"left\">Proposer</th>"
				+ "<th align=\"left\">Title</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			String sql = "SELECT historyid, CourseAlpha, CourseNum, Proposer, coursetitle "
							+ "FROM tblCourse WHERE campus=? AND Progress='PENDING' AND coursealpha "
							+ "IN (SELECT DISTINCT coursealpha FROM vw_ProgramDepartmentChairs WHERE chairname=?) ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,chair);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String proposer = AseUtil.nullToBlank(rs.getString("Proposer"));
				String title = AseUtil.nullToBlank(rs.getString("coursetitle"));

				buf.append("<tr>"
					+ "<td align=\"left\"><a href=\"vwcrsy.jsp?pf=1&comp=0&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" title=\"view outline\"></a></td>"
					+ "<td align=\"left\"><a href=\"crsapprpndx.jsp?kix="+kix+"\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>"
					+ "<td align=\"left\">" + proposer + "</td>"
					+ "<td align=\"left\">" + title + "</td>"
					+ "</tr>");
			}
			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException e){
			logger.fatal("ApproverDB - showPendingApprovals: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ApproverDB - showPendingApprovals: " + e.toString());
		}

		return buf.toString() + "</tbody></table></div></div>";
	}

	/**
	 * resequenceApprovers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 * <p>
	 * @return	String
	 */
	public static String resequenceApprovers(Connection conn,String campus,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		String controls = "";

		try{

			buf.append("<div id=\"container90\">")
				.append("<div id=\"demo_jui\">")
				.append("<table id=\"jqueryShowApprovers\" class=\"display\">")
				.append("<thead>")
				.append("<tr>")
				.append("<th align=\"left\">Sequence</th>")
				.append("<th align=\"left\">Approver</th>")
				.append("<th align=\"left\">Title</th>")
				.append("<th align=\"left\">Position</th>")
				.append("<th align=\"left\">Department</th>")
				.append("<th align=\"left\">Division</th>")
				.append("<th align=\"left\">Delegate</th>")
				.append("<th align=\"left\">Approved By</th>")
				.append("</tr>")
				.append("</thead>")
				.append("<tbody>");

			// create list of available sequences
			String dropDownList = "";
			int maxSeq = ApproverDB.countApproversForRoute(conn,campus,route);
			for(int i=1; i<maxSeq+1; i++){
				if(i==1){
					dropDownList = "" + i;
				}
				else{
					dropDownList = dropDownList + "," + i;
				}
			} // for i

			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT * FROM vw_Approvers2 WHERE campus=? AND route=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				String endDate = aseUtil.ASE_FormatDateTime(rs.getString("endDate"),Constant.DATE_DATETIME);
				int id = NumericUtil.getInt(rs.getInt("approverid"),0);
				int seq = NumericUtil.getInt(rs.getInt("approver_seq"),0);

				if (controls.equals(Constant.BLANK)){
					controls = "" + id;
				}
				else{
					controls = controls + "," + id;
				}

				buf.append("<tr>")
					.append("<td align=\"left\">")
					.append(aseUtil.createStaticSelectionBox(dropDownList,dropDownList,"controlName_"+id,(""+seq),"","","BLANK",""))
					.append("</a></td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("approver")) + "</td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("title")) + "</td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("position")) + "</td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("department")) + "</td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("division")) + "</td>")
					.append("<td align=\"left\">" + aseUtil.nullToBlank(rs.getString("delegated")) + "</td>")
					.append("<td align=\"left\">" + endDate + "</td>")
					.append("</tr>");
			}
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException se){
			logger.fatal("ApproverDB: resequenceApprovers - " + se.toString());
			buf.setLength(0);
		}catch(Exception ex){
			logger.fatal("ApproverDB: resequenceApprovers - " + ex.toString());
			buf.setLength(0);
		}

		buf.append("</tbody></table></div></div>")
			.append("<input name=\"act\" value=\"reseqApprovers\" type=\"hidden\">")
			.append("<input name=\"route\" value=\""+route+"\" type=\"hidden\">")
			.append("<input name=\"controls\" value=\""+controls+"\" type=\"hidden\">");

		return buf.toString();
	}

	/*
	 * approvalInProgress
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean approvalInProgress(Connection conn,String kix) throws SQLException {

		boolean inProgress = false;

		try {
			// check progress in case no one started the approval after it was submitted

			if (	countApprovalHistory(conn,kix)>0 ||
					CourseDB.getCourseProgress(conn,kix).equals(Constant.COURSE_APPROVAL_TEXT)){

				inProgress = true;

			}
		} catch (Exception e) {
			logger.fatal("ApproverDB: approvalInProgress - " + e.toString());
		}

		return inProgress;
	}

	/*
	 * getApproversOnlyBySeq - collect all approvers for a particular sequence
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	seq		int
	 * @param	route		int
	 *	<p>
	 *	@return String
	 */
	public static String getApproversOnlyBySeq(Connection conn,String campus,int seq,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer approvers = new StringBuffer();
		String approver = "";
		String temp = "";

		try{
			String sql = "SELECT approver,delegated FROM tblApprover WHERE campus=? AND approver_seq=? AND route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				approver = AseUtil.nullToBlank(rs.getString("approver"));

				if (approvers.toString().length()==0)
					approvers.append(approver);
				else{
					if (approvers.lastIndexOf(approver) < 0)
						approvers.append(","+approver);
				}
			}

			temp = approvers.toString();
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getApproversOnlyBySeq - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getApproversOnlyBySeq - " + ex.toString());
		}

		return temp;
	}

	/*
	 * show all routes approvers have access to
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 * <p>
	 *	@return String
	 */
	public static String approverRoutes(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		sb.append("<table id=\"report\" width=\"600px\"><tr><th width=\"05%\"></th><th>Approver</th></tr>");

		try{

			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT DISTINCT a.approver, u.lastname, u.firstname "
					+ "FROM tblApprover a INNER JOIN tblUsers u ON a.campus = u.campus AND a.approver = u.userid "
					+ "WHERE a.campus=? ORDER BY u.lastname, u.firstname";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String approver = aseUtil.nullToBlank(rs.getString("approver"));
				String name = aseUtil.nullToBlank(rs.getString("lastname"))
					+ ", " + aseUtil.nullToBlank(rs.getString("firstname"))
					+ " (" + approver + ")";

				sb.append("<tr><td><div class=\"arrow\"></div></td><td>"+name+"</td></tr>");

				String routes = "";
				sql = "SELECT DISTINCT i.kdesc,i.id FROM tblApprover a INNER JOIN tblINI i ON a.route = i.id "
					+ "WHERE a.campus=? AND a.approver=? AND i.category = 'ApprovalRouting' ORDER BY kdesc";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ps2.setString(2,approver);
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next()){

					int id = rs2.getInt("id");

					if(!routes.equals(Constant.BLANK)){
						routes += "<br>";
					}

					routes += "<a href=\"appridx.jsp?route="+id+"\" class=\"linkcolumn\">" + aseUtil.nullToBlank(rs2.getString("kdesc")) + "</a>";

				} // while ps2
				rs2.close();
				ps2.close();

				sb.append("<tr><td colspan=\"2\">"+routes+"</td></tr>");

			} // while ps
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("CourseDB: isCourseCopyable - " + e.toString());
		}

    	sb.append("</table>");

		return sb.toString();
	}

	/*
	 * getCurrentFndApprover - who is the current approver for this program. The current approver is the
	 * 							named user with "Approve program" task
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return	String
	 */
	public static String getCurrentFndApprover(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String approver = null;

		try {
			String sql = "SELECT t.submittedfor FROM tblTasks t INNER JOIN "
					+ "tblfnd p ON t.historyid = p.historyid "
					+ "WHERE p.campus=? and t.historyid=? AND p.type='PRE' AND t.message LIKE 'Approve foundation%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				approver = AseUtil.nullToBlank(rs.getString("submittedfor"));
			}
			rs.close();
			ps.close();

			if (approver == null || approver.length() == 0){
				approver = getCurrentApproverX(conn,campus,kix);
			}

		} catch (SQLException se) {
			logger.fatal("ApproverDB: getCurrentFndApprover - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ApproverDB: getCurrentFndApprover - " + e.toString());
		}

		return approver;
	} // getCurrentFndApprover

	/*
	 * send email notification during approval
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 *	@param	kix		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean notifiedDuringApproval(Connection conn,String campus,String user,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		//
		// notifiedDuringApproval allows system to determine whether messages are sent out during approval.
		// when value2 = 0, send notification at every sequence of approval
		// when value2 = a sequence number, only send at that point
		// value3 contains CSV of names to send
		//

		boolean send = false;
		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"ApproverDB");

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			if(debug){
				System.out.println("kix: " + kix);
				System.out.println("alpha: " + alpha);
				System.out.println("num: " + num);
				System.out.println("route: " + route);
			}

			if(route > 0){

				String notifiedDuringApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","NotifiedDuringApproval");

				if(debug) System.out.println("notifiedDuringApproval: " + notifiedDuringApproval);

				if(notifiedDuringApproval.equals(Constant.ON)){

					String seq = IniDB.getItem(conn,campus,"NotifiedDuringApproval","kval2");

					if(debug) System.out.println("seq: " + seq);

					if(seq != null && !seq.equals("")){

						int iSeq = NumericUtil.getInt(seq,0);

						String userlist = IniDB.getItem(conn,campus,"NotifiedDuringApproval","kval3");

						if(debug) System.out.println("userlist: " + userlist);

						if(userlist != null){

							userlist = userlist.replace(" ","");

							int currentSeq = ApproverDB.getApproverSequence(conn,user,route);

							if(debug) System.out.println("currentSeq: " + currentSeq);

							if(iSeq == 0){
								send = true;
							}
							else if (iSeq == currentSeq){
								send = true;
							}

							if (send){
								MailerDB mailerDB = new MailerDB(conn,user,userlist,"","",alpha,num,campus,"notifiedDuringApproval",kix,user);
								if(debug) System.out.println("sent: " + send);
							}
						}
						else{
							logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid user list in value3 - " + userlist);
						}  // got a valid user list

					}
					else{
						logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid sequence in value2 - " + seq);
					}
					// got a valid sequence

				} // notify is on

			}
			else{
				logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + " - invalid route - " + route);
			} // got a valid route

		} catch (Exception e) {
			logger.fatal("ApproverDB.notifiedDuringApproval: " + kix + "\n" + e.toString());
		}

		return send;
	}

	/*
	 * getRoutingInUseForPrograms - display routing sequence in use by route
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 * @return String
	 */
	public static String getRoutingInUseForPrograms(Connection conn,String campus,int route){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();

		String listing = "";

		boolean found = false;

		try{
			listings.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\"jqueryGetRoutingInUseForPrograms\" class=\"display\">"
				+ "<thead>"
				+ "<tr>"
				+ "<th align=\"left\">Proposer</th>"
				+ "<th align=\"left\">Division</th>"
				+ "<th align=\"left\">Degree</th>"
				+ "<th align=\"left\">Title</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>");

			String sql = "SELECT p.historyid, p.effectivedate, p.title, p.proposer, pd.title AS degreedescr, d.divisionname "
							+ "FROM tblPrograms p INNER JOIN "
							+ "tblprogramdegree pd ON p.degreeid = pd.degreeid AND p.campus = pd.campus INNER JOIN "
							+ "tblDivision d ON p.campus = d.campus AND p.divisionid = d.divid "
							+ "WHERE p.campus=? AND p.route = ? ORDER BY p.title, p.effectivedate";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String num = AseUtil.nullToBlank(rs.getString("effectivedate"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String degreedescr = AseUtil.nullToBlank(rs.getString("degreedescr"));
				String divisionname = AseUtil.nullToBlank(rs.getString("divisionname"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				listings.append("<tr>"
					+ "<td align=\"left\"><a href=\"rte.jsp?t=programs&route="+route+"&kix="+kix+"\" class=\"linkcolumn\">" + proposer + "</a></td>"
					+ "<td align=\"left\">" + divisionname + "</td>"
					+ "<td align=\"left\">" + degreedescr + "</td>"
					+ "<td align=\"left\">" + title + "</td>"
					+ "</tr>");

				found = true;

			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
						+ "<tr class=\"textblack\">"
						+ "<td width=\"50%\" align=\"left\">Approval routing is in process for the following <strong>PROGRAMS</strong>.<br/>Click on the proposer's name to change the routing sequence.</td>"
						+ "<td width=\"50%\" align=\"right\" valign=\"bottom\"><a href=\"/central/servlet/progress?t=programs&c="+campus+"&r="+route+"\" class=\"linkcolumn\" target=\"_blank\">Print report</a>&nbsp;&nbsp;&nbsp;</td>"
						+ "</tr>"
						+ "</table><br/>"
						+ listings.toString()
						+ "</tbody></table></div></div>";
			}
			else{
				listing = "";
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: getRoutingInUseForPrograms - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ApproverDB: getRoutingInUseForPrograms - " + ex.toString());
		}

		return listing;
	}

	/*
	 * updateRoutingForProgram
	 *	<p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	user		String
	 * @param	route		int
	 *	<p>
	 * @return int
	 */
	public static int updateRoutingForProgram(Connection conn,String campus,String kix,String user,int routeX){

		int rowsAffected = 0;

		try{

			String[] info = Helper.getKixInfo(conn,kix);

			String proposer = info[Constant.KIX_PROPOSER];
			String title = info[Constant.KIX_PROGRAM_TITLE];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			String oldRouting = ApproverDB.getRoutingFullNameByID(conn,campus,route);
			String newRouting = ApproverDB.getRoutingFullNameByID(conn,campus,routeX);

			rowsAffected = ProgramsDB.setItem(conn,campus,kix,"route",""+routeX,"i");

			if (oldRouting == null || oldRouting.length() == 0){
				oldRouting = "BLANK";
			}

			AseUtil.logAction(conn,
									user,
									"ACTION",
									"Program approval routing changed from " + oldRouting + " to " + newRouting,
									title,
									proposer,
									campus,
									kix);

		} catch(Exception ex){
			logger.fatal("ApproverDB: updateRoutingForProgram - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}