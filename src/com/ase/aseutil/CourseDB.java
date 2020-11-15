/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * Msg approveOutline
 * Msg approveOutlineReview
 * Msg cancelOutline
 * Msg cancelOutlineApproval
 * Msg cancelOutlineReview
 * Msg copyOutline
 * int countCourseQuestions
 *	public static int countSimilarOutlines(Connection conn,String campus,String alpha,String num) throws Exception {
 * Msg courseACCJC
 * boolean courseExist
 *	public static boolean courseExistByProposer(Connection connection,String campus,String proposer,String alpha,String num,String type)
 * boolean courseExistByType
 * boolean courseExistByTypeCampus
 * boolean courseSLOExistByTypeCampus
 * boolean createOutline
 * Msg deleteOutline
 * public static boolean enableOutlineItems(Connection connection,String campus,String alpha,String num,String user)
 * boolean endReviewerTask
 * String getCampusUsers String
 * String[] getCourseDates
 * String[] getCourseDatesByType
 * String getCourseDescription
 * String getCourseDescriptionByType
 * int getCourseEdit
 * String getCourseEdit0
 * String getCourseEdit1
 * String getCourseEdit2
 * String getCourseEdits
 * String getCourseItem
 * String getCourseReason
 * String getCourseProgress
 * String getCourseProposer
 * String getCrossListing
 * public String getFieldsForNewOutlines
 * public static int getNextRequisiteNumber(Connection conn,String reqType)
 * String getRequisites
 * int getRequisiteCount
 * String getXListForEdit
 * String getSyllabusData
 * int getHistoryID
 * int getLastSequence (getLastSequenceToApprove)
 * boolean isACCJCAdded
 * boolean isCourseApprovalCancellable
 *	public static Msg isCourseDeleteCancellable(Connection conn,String campus,String alpha,String num,String user){
 * boolean isCourseCancellable
 * boolean isCourseCopyable
 * boolean isCourseDeletable
 * boolean isCourseRenamable
 * boolean isCourseRestorable
 * boolean isCourseReviewable
 * boolean isCourseReviewer
 * boolean isCourseXReffed
 * boolean isEditable
 * boolean isMatch
 * boolean isNextApprover
 * String[] lookUpQuestion
 * Msg modifyOutline
 * Msg moveCurrentToArchived
 * int notifyOutlineMonitors
 * boolean renameOutline
 * Msg setCourseForApproval
 *	public static int setCourseEdit1(Connection connection,String campus,String alpha,String num,
 *												String type,String edits)
 *	public static int setCourseEdit2(Connection connection,String campus,String alpha,String num,
 *												String type,String edits)
 *	public static int setCourseProgress(Connection conn,String kix,String progress,String user) {
 * String setPageTitle
 * String showCourseProgress
 * Msg updateCourse
 * Msg updateCourseRaw
 * int xListCourse
 *
 * void close () throws SQLException{}
 *
 */

//
// CourseDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class CourseDB {
	static Logger logger = Logger.getLogger(CourseDB.class.getName());

	public CourseDB() throws Exception{}

	final static int LAST_APPROVER 	= 2;
	final static int ERROR_CODE 		= 3;
	static boolean debug = false;

	/*
	 * isMatch
	 *
	 * @return boolean
	 */
	public static boolean isMatch(Connection connection,String hid) throws SQLException {
		String sql = "SELECT id FROM tblCourse WHERE id=?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, hid);
		ResultSet results = preparedStatement.executeQuery();
		boolean exists = results.next();
		results.close();
		preparedStatement.close();
		return exists;
	}

	/*
	 * updateCourse
	 * <p>
	 * @param	connection			Connection
	 * @param	currentNo			String
	 * @param	campus				String
	 * @param	alpha					String
	 * @param	num					String
	 * @param	column				String
	 * @param	question				String
	 * @param	explain				String
	 * @param	question_explain	String
	 * @param	mode					String
	 * @param	tab					int
	 *	@param	user					String
	 * <p>
	 * @return Msg
	 */
	public static Msg updateCourse(Connection conn,
											String currentNo,
											String campus,
											String alpha,
											String num,
											String column,
											String data,
											String explain,
											String question_explain,
											String mode,
											int tab,
											String user) {

		int rowsAffected = 0;
		Msg msg = new Msg();
		String sql = "";
		PreparedStatement ps;
		String kix = "";
		String table = "";

		try {

			kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("COURSEDB UPDATECOURSE - STARTS");

			if (debug){
				logger.info("tab: " + tab);
				logger.info("column: " + column);
				logger.info("data: " + data);
				logger.info("explain: " + explain);
				logger.info("question_explain: " + question_explain);
			}

			if (tab==Constant.TAB_COURSE || tab==Constant.TAB_FORMS){
				table = "tblCourse";
			}
			else{
				table = "tblCampusData";
			}

			if (debug) logger.info("tab: " + tab);

			// save for use after update
			// for method of eval, when items are removed, we also want to delete linked items
			String methodEvalOld = "";
			if (column.equals(Constant.COURSE_METHODEVALUATION)){
				methodEvalOld = getCourseItem(conn,kix,Constant.COURSE_METHODEVALUATION);
			}
			if (debug) logger.info("methodEvalOld: " + methodEvalOld);

			sql = "UPDATE "
				+ table
				+ " SET "
				+ column
				+ "=?,auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			ps = conn.prepareStatement(sql);

			if (column.indexOf("date")>=0){
				SimpleDateFormat dteFormat = new SimpleDateFormat("MM/dd/yy");
				java.util.Date date = dteFormat.parse(data);
				ps.setDate(1, new java.sql.Date(date.getTime()));
			}
			else{
				ps.setString(1,data);
			}

			ps.setString(2, AseUtil.getCurrentDateTimeString());
			ps.setString(3, campus);
			ps.setString(4, alpha);
			ps.setString(5, num);
			rowsAffected = ps.executeUpdate();

			if (debug){
				logger.info("column: " + column);
				logger.info("rowsAffected: " + rowsAffected);
			}

			//	this question has an explanation
			if (question_explain!=null && question_explain.length()>0){
				table = "tblCampusData";
				sql = "UPDATE "
						+ table
						+ " SET "
						+ question_explain
						+ "=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				ps = conn.prepareStatement(sql);
				ps.setString(1, explain);
				ps.setString(2, campus);
				ps.setString(3, alpha);
				ps.setString(4, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("rowsAffected: " + rowsAffected);
			}

			ps.close();

			// for method of eval, when items are removed, we also want to delete linked items
			if (methodEvalOld != null && methodEvalOld.length() > 0){
				cleanUpCourseLinked2(conn,kix,methodEvalOld,data,Constant.METHODEVAL_TEXT);
				if (debug) logger.info("cleanUpCourseLinked2");
			}

			AseUtil.logAction(conn, user, "Outline update","Outline update ("+ alpha + " " + num + "; item # "  + currentNo + " )",alpha,num,campus,kix);

			if (debug) logger.info("COURSEDB UPDATECOURSE - ENDS");

		} catch (SQLException e) {
			logger.fatal("CourseDB: updateCourse (" + kix + ") - " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: updateCourse (" + kix + ") - " + ex.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/*
	 * cleanUpCourseLinked2 - for now, only when linked to method of eval
	 * <p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	oldValue		String
	 * @param	newValue		String
	 * @param	dst			String
	 * <p>
	 * @return Msg
	 */
	@SuppressWarnings("unchecked")
	public static int cleanUpCourseLinked2(Connection conn,String kix,String oldValue,String newValue,String dst) {


		//Logger logger = Logger.getLogger("test");

		int id = 0;
		int item = 0;
		int rowsAffected = 0;

		// 1) retrieve all existing method evals in oldValue
		// 2) put new list in hash map so we can go through and check what is and is not there
		// 3) run through old and check against new.
		// 4) if not found in new method eval list delete
		// 5) if we delete all from courselinked2, circle back and delete the place holder in courselinked

		// 1
		String[] aOldValue = oldValue.split(",");
		String[] aNewValue = newValue.split(",");
		String where = "";
		String sql = "";

		PreparedStatement ps2 = null;
		HashMap hashMap = null;

		try {
			// 2
			hashMap = new HashMap();
			for(int z=0;z<aNewValue.length;z++){
				if (!"0".equals(aNewValue[z]))
					hashMap.put(aNewValue[z],new String(aNewValue[z]));
			}

			// 3
			if(hashMap != null){
				for(int j=0;j<aOldValue.length; j++) {
					if (!hashMap.containsValue(aOldValue[j])){

						String temp = aOldValue[j].replace("~~","");

						item = NumericUtil.getInt(temp,0);

						// 4
						sql = "SELECT id FROM tblCourseLinked WHERE historyid=? AND dst=?";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,kix);
						ps.setString(2,dst);
						ResultSet rs = ps.executeQuery();
						while(rs.next()){
							id = rs.getInt("id");
							sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND id=? AND item=? ";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,kix);
							ps2.setInt(2,id);
							ps2.setInt(3,item);
							rowsAffected = ps2.executeUpdate();
							ps2.close();

							// 5
							// if count in tblCourseLinked2 is 0 then delete
							where = "WHERE historyid='"+kix+"' AND id=" + id;
							rowsAffected = (int)AseUtil.countRecords(conn,"tblCourseLinked2",where);
							if (rowsAffected == 0){
								sql = "DELETE FROM tblCourseLinked WHERE historyid=? AND dst=? AND id=?";
								ps2 = conn.prepareStatement(sql);
								ps2.setString(1,kix);
								ps2.setString(2,dst);
								ps2.setInt(3,id);
								rowsAffected = ps2.executeUpdate();
								ps2.close();
							}
						}
						rs.close();
						ps.close();
					} // !hashMap
				}	// for j
			} // if hashMap

		} catch (SQLException e) {
			logger.fatal("CourseDB: cleanUpCourseLinked2 - " + kix + "\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: cleanUpCourseLinked2 - " + kix + "\n" + e.toString());
		}
		hashMap = null;

		return rowsAffected;
	}

	/*
	 * updateCourseRaw
	 * <p>
	 * @param	conn					Connection
	 * @param	kix					String
	 * @param	question				String
	 * @param	explain				String
	 * @param	user					String
	 * @param	explain				String
	 * @param	question_explain	String
	 *	@param	table					int
	 * <p>
	 * @return Msg
	 */
	public static Msg updateCourseRaw(Connection conn,
											String kix,
											String column,
											String question,
											String user,
											String explain,
											String question_explain,
											int table) {

		int rowsAffected = 0;
		Msg msg = new Msg();

		String sql = "";
		PreparedStatement ps = null;

		try {
			if (table==1){
				sql = "UPDATE tblCourse SET " + column + "=? WHERE id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);
				ps.setString(2, kix);
				rowsAffected = ps.executeUpdate();

				if (question_explain!=null && question_explain.length()>0){
					sql = "UPDATE tblCampusData SET " + question_explain + "=? WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, explain);
					ps.setString(2, kix);
					rowsAffected = ps.executeUpdate();
				}
			}
			else{
				sql = "UPDATE tblCampusData SET " + column + "=? WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);
				ps.setString(2, kix);
				rowsAffected = ps.executeUpdate();
			}
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CourseDB: updateCourseRaw - " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: updateCourseRaw - " + ex.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(ex.toString());
		}

		return msg;
	}

	/*
	 * A course is editable only if: edit flag=true,progress=modify,user=proposer and no approval history found
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	@param	String		user
	 *	@param	String		mode
	 * editor = proposer
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isEditable(Connection connection,
												String campus,
												String alpha,
												String num,
												String user,
												String mode) {

		boolean editable = false;
		String proposer = "";
		String progress = "";

		try {
			String kix = Helper.getKix(connection,campus,alpha,num,"PRE");

			String sql = "SELECT edit,proposer,progress FROM tblCourse " +
				"WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype='PRE'";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				editable = results.getBoolean(1);
				proposer = results.getString(2);
				progress = results.getString(3);
			}
			results.close();
			ps.close();

			//if (editable && user.equals(proposer) && "MODIFY".equals(progress) & countApprovalHistory == 0)
			long countApprovalHistory = ApproverDB.countApprovalHistory(connection,kix);

			// course is editable in following ways:
			// 1) when modifying, it has to be the proposer of the outline
			// 2) for delete, it is automatically editable
			if (editable && user.equals(proposer) && progress.equals(Constant.COURSE_MODIFY_TEXT)){
				editable = true;
			}
			else if (progress.equals(Constant.COURSE_REVISE_TEXT)){
				editable = true;
			}
			else if (progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)){
				editable = true;
			}
			else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
				editable = true;
			}
			else{
				editable = false;
			}

		} catch (SQLException e) {
			logger.fatal("CourseDB: isEditable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: isEditable - " + ex.toString());
		}

		return editable;
	}

	/*
	 * enableOutlineItems - ability to enable outline items
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	@param	String		user
	 *	<p>
	 *	@return boolean
	 */
	public static boolean enableOutlineItems(Connection connection,
															String campus,
															String alpha,
															String num,
															String user) {

		boolean editable = false;
		boolean enable = false;
		String proposer = "";
		String progress = "";
		String type = "PRE";

		String kix = Helper.getKix(connection,campus,alpha,num,type);

		try {
			long countApprovalHistory = ApproverDB.countApprovalHistory(connection,kix);

			editable = isEditable(connection,campus,alpha,num,user,"");
			proposer = getCourseProposer(connection,campus,alpha,num,type);
			progress = getCourseProgress(connection,campus,alpha,num,type);

			if (editable && user.equals(proposer) && "MODIFY".equals(progress) & countApprovalHistory == 0)
				enable = true;
			else
				enable = false;

		} catch (SQLException e) {
			logger.fatal(kix + " - CourseDB: enableOutlineItems - " + e.toString());
		} catch (Exception ex) {
			logger.fatal(kix + " - CourseDB: enableOutlineItems - " + ex.toString());
		}

		return enable;
	}

	/*
	 * getCourseProgress
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	@param	String		type
	 *	<p>
	 *	@return String
	 */
	public static String getCourseProgress(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		String progress = "";

		try {
			String query = "SELECT progress FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				progress = rs.getString(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseProgress - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseProgress - " + ex.toString());
		}

		return progress;
	}


	/*
	 * getCourseProgress
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseProgress(Connection conn,String kix) throws SQLException {

		String progress = "";

		try {
			String query = "SELECT progress FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				progress = rs.getString(1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseProgress - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseProgress - " + ex.toString());
		}

		return progress;
	}

	/*
	 * getCourseItem
	 *	<p>
	 *	@return String
	 */
	public static String getCourseItem(Connection conn,String kix,String column) throws SQLException {

		String courseItem = "";
		String sql = "";

		try {
			String table = getCourseTableFromKix(conn,kix);
			sql = "SELECT " + column + " FROM "+table+" WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				courseItem = AseUtil.nullToBlank(rs.getString(column));

				if (courseItem != null && courseItem.length() > 0){
					if (DateUtility.isDate(courseItem)){
						courseItem = DateUtility.formatDateAsString(courseItem);
					}
				}

			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {

			// in case we sent in a column belonging to campus table
			try{
				courseItem = getCampusItem(conn,kix,column);
				if (courseItem != null && courseItem.length() > 0){
					if (DateUtility.isDate(courseItem)){
						courseItem = DateUtility.formatDateAsString(courseItem);
					}
				}
			} catch (SQLException ex) {
				logger.fatal("CourseDB: getCourseItem1 - " + ex.toString());
			} catch (Exception ex) {
				logger.fatal("CourseDB: getCourseItem1 - " + ex.toString());
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: getCourseItem1 - " + e.toString());
		}

		return courseItem;
	}

	/*
	 * getCampusItem
	 *	<p>
	 *	@return String
	 */
	public static String getCampusItem(Connection conn,String kix,String column) throws SQLException {

		String campusItem = "";
		String sql = "";

		try {
			sql = "SELECT " + column + " FROM tblcampusdata WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				campusItem = AseUtil.nullToBlank(rs.getString(column));
				if (campusItem != null && campusItem.length() > 0){
					if (DateUtility.isDate(campusItem)){
						campusItem = DateUtility.formatDateAsString(campusItem);
					}
				}
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {

			try{
				campusItem = getCourseItem(conn,kix,column);
				if (campusItem != null && campusItem.length() > 0){
					if (DateUtility.isDate(campusItem)){
						campusItem = DateUtility.formatDateAsString(campusItem);
					}
				}

			} catch (SQLException ex) {
				logger.fatal("CourseDB: getCampusItem2 - " + ex.toString());
			} catch (Exception ex) {
				logger.fatal("CourseDB: getCampusItem2 - " + ex.toString());
			}


		} catch (Exception e) {
			logger.fatal("CourseDB: getCampusItem1 - " + e.toString());
		}

		return campusItem;
	}

	/*
	 * getCourseItemByTable
	 *	<p>
	 *	@return String
	 */
	public static String getCourseItemByTable(Connection conn,String kix,String column,String type) throws SQLException {

		String courseItem = "";
		String table = "";

		try {
			if ("ARC".equals(type))
				table = "tblCourseARC";
			else if ("CAN".equals(type))
				table = "tblCourseCAN";
			else if ("CUR".equals(type))
				table = "tblCourse";
			else if ("PRE".equals(type))
				table = "tblCourse";

			String sql = "SELECT " + column + " FROM " + table + " WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				courseItem = AseUtil.nullToBlank(rs.getString(column));

				if (courseItem != null && courseItem.length() > 0){
					if (DateUtility.isDate(courseItem)){
						courseItem = DateUtility.formatDateAsString(courseItem);
					}
				}
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseItemByTable - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseItemByTable - " + ex.toString());
		}

		return courseItem;
	}

	/*
	 * setCourseItem
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	column
	 *	@param	data
	 *	@param	dataType (s or i)
	 *	<p>
	 *	@return int
	 */
	public static int setCourseItem(Connection conn,String kix,String column,String data,String dataType) throws SQLException {

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblCourse SET " + column + "=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			if (dataType.equals("s"))
				ps.setString(1,data);
			else
				ps.setInt(1,Integer.parseInt(data));

			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: setCourseItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: setCourseItem - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * setCampusItem
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	column
	 *	@param	data
	 *	@param	dataType (s or i)
	 *	<p>
	 *	@return int
	 */
	public static int setCampusItem(Connection conn,String kix,String column,String data,String dataType) throws SQLException {

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblCampusdata SET " + column + "=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			if ("s".equals(dataType))
				ps.setString(1,data);
			else
				ps.setInt(1,Integer.parseInt(data));

			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: setCampusItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: setCampusItem - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getCourseEdits
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getCourseEdits(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		String[] edits = null;

		try {
			String query = "SELECT edit0,edit1,edit2 FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				edits = new String[3];
				edits[0] = AseUtil.nullToBlank(results.getString(1));
				edits[1] = AseUtil.nullToBlank(results.getString(2));
				edits[2] = AseUtil.nullToBlank(results.getString(3));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseEdits - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseEdits - " + ex.toString());
		}

		return edits;
	}


	/*
	 * getCourseReason
	 *	<p>
	 *	@param connection	Connection
	 * @param campus		String
	 * @param alpha		String
	 * @param num			String
	 * @param type			String
	 * @param kix			String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseReason(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		return getCourseReason(connection,campus,alpha,num,type,"");
	}

	public static String getCourseReason(Connection connection,
														String campus,
														String alpha,
														String num,
														String type,
														String kix) throws SQLException {

		String reason = "";

		try {
			String sql = "";
			PreparedStatement ps = null;

			if(type.equals("ARC")){
				if(!kix.equals("")){
					sql = "SELECT "+Constant.COURSE_REASON+" FROM tblcoursearc WHERE campus=? AND historyid=?";
					ps = connection.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, kix);
				}
				else{
					sql = "SELECT "+Constant.COURSE_REASON+" FROM tblcoursearc WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
					ps = connection.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					ps.setString(4, type);
				}
			}
			else{
				sql = "SELECT "+Constant.COURSE_REASON+" FROM tblcourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
			}
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				reason = AseUtil.nullToBlank(results.getString(1));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseReason - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseReason - " + ex.toString());
		}

		return reason;
	}

	/*
	 * getCourseProposer
	 *	<p>
	 *	@param conn	Connection
	 * @param kix	String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseProposer(Connection conn,String kix) throws SQLException {

		String proposer = "";

		try {
			String sql = "SELECT proposer FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				proposer = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseProposer - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseProposer - " + ex.toString());
		}

		return proposer;
	}

	/*
	 * getCourseProposer
	 *	<p>
	 *	@param connection	Connection
	 * @param campus		String
	 * @param alpha		String
	 * @param num			String
	 * @param type			String
	 *	<p>
	 *	@return String
	 */
	public static String getCourseProposer(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		String proposer = "";

		try {
			String kix = Helper.getKix(connection,campus,alpha,num,type);
			String query = "SELECT proposer FROM tblCourse WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				proposer = AseUtil.nullToBlank(results.getString(1));
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseProposer - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseProposer - " + ex.toString());
		}

		return proposer;
	}

	/*
	 * getCrossListing
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	<p>
	 *	@return String
	 */
	public static String getCrossListing(Connection connection,String kix) throws SQLException {

		StringBuffer crossListing = new StringBuffer();

		String alpha = "";
		String num = "";
		String campus= "";

		String temp = "";

		boolean pending = false;

		boolean found = false;

		String[] info = Helper.getKixInfo(connection,kix);
		campus = info[4];

		try {
			String crossListingRequiresApproval = IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CrossListingRequiresApproval");

			String sql = "SELECT coursealphax,coursenumx,pending FROM tblXRef WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				found = true;
				alpha = results.getString(1);
				num = results.getString(2);
				pending = results.getBoolean("pending");
				crossListing.append(alpha + " " + num + " - " + getCourseDescription(connection, alpha, num, campus));

				if (crossListingRequiresApproval.equals(Constant.ON) && pending){
					crossListing.append(" (PENDING APPROVAL)");
				}

				crossListing.append("<br>");
			}
			results.close();
			ps.close();

			if (found)
				temp = crossListing.toString();

		} catch (SQLException e) {
			logger.fatal("CourseDB: getCrossListing - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCrossListing - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getFieldsForNewOutlines
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	campus		String
	 * <p>
	 *	@return String
	 */
	public static String getFieldsForNewOutlines(Connection conn,String campus) throws Exception {

		String temp = "";
		String field = "";

		try {
			String sql = "SELECT Field_Name FROM vw_CourseItems WHERE campus=? AND include='Y' AND change='N' ORDER BY Seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				field = rs.getString(1);
				if (temp.length()==0)
					temp = field;
				else
					temp = temp + "," + field;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getFieldsForNewOutlines - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getFieldsForNewOutlines - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getXListForEdit
	 *	<p>
	 *	@parm	currentTab	tab to return to edit
	 *	@parm	currentNo	number or item to return to
	 *	@parm	showImages	whether or not we show the edit/delete images
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getXListForEdit(Connection connection,
															String campus,
															String alpha,
															String num,
															String type) throws Exception {

		String sql = "";
		int id = 0;
		String alphax = "";
		String numx = "";
		boolean pending = false;
		String sPending = "";

		StringBuffer buf = new StringBuffer();

		String crossListingRequiresApproval =
			IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CrossListingRequiresApproval");

		String kix = Helper.getKix(connection,campus,alpha,num,"PRE");

		sql = "SELECT id,coursealphax,coursenumx,pending " +
				"FROM tblxref " +
				"WHERE campus=? AND historyid=? " +
				"ORDER BY coursealphax,coursenumx";

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table id=\"tableGetXListForEdit\" border=\"0\" width=\"100%\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\">Alpha</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Number</td>");

			if ((Constant.ON).equals(crossListingRequiresApproval))
				buf.append("<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Pending Approval</td>");

			buf.append("</tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				alphax = aseUtil.nullToBlank(rs.getString(2));
				numx = aseUtil.nullToBlank(rs.getString(3));
				pending = rs.getBoolean("pending");

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\" onclick=\"return aseSubmitClick3(\'" + id + "\',\'" + alphax + "\',\'" + numx + "\'); \">&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + alphax + "\',\'" + numx + "\');\">" +
					"</td><td valign=\"top\" class=\"datacolumn\">" + alphax + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + numx + "</td>");

				if ((Constant.ON).equals(crossListingRequiresApproval))
					buf.append("<td valign=\"top\" class=\"datacolumn\">" + sPending + "</td>");

				buf.append("</tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("CompDB: getXListForEdit - " + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("CompDB: getXListForEdit - " + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/*
	 * getLastSequence In table approval history, there are entries indicating
	 * when someone took their turns. If found in that table for a course and
	 * campus, that means user approval took place.
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 * @return int
	 */
	public static int getLastSequence(Connection connection,
												String campus,
												String alpha,
												String num) throws SQLException {

		return getLastSequenceToApprove(connection,campus,alpha,num);
	}

	/*
	 * getLastSequenceToApprove In table approval history, there are entries indicating
	 * when someone took their turns. If found in that table for a course and
	 * campus, that means user approval took place.
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 * @return int
	 */
	public static int getLastSequenceToApprove(Connection connection,
												String campus,
												String alpha,
												String num) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int sequence = 0;

		// returns the sequence number of the last approver for this outline
		try {
			String kix = Helper.getKix(connection,campus,alpha,num,"PRE");
			String sql = "SELECT approver_seq AS lastSeq, approved  "
				+ "FROM tblApprovalHist "
				+ "WHERE id = ("
				+ "SELECT max(id) "
				+ "FROM tblApprovalHist "
				+ "WHERE historyid=? "
				+ "AND approved=1)";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				boolean approved = rs.getBoolean("approved");
				sequence = rs.getInt("lastSeq");

				// if the last person rejected, set back by one to get system to go resend
				// accordingly.
				if (!approved)
					sequence = sequence - 1;
			}
			else
				sequence = 0;

			rs.close();
			ps.close();

			// logger.info(kix + " CourseDB: getLastSequenceToApprove (" + sequence + ")");
		} catch (SQLException e) {
			logger.fatal("CourseDB: getLastSequenceToApprove - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getLastSequenceToApprove - " + ex.toString());
		}

		return sequence;
	}

	/*
	 * isNextApprover
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isNextApprover(Connection conn,String campus,String alpha,String num,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;

		boolean nextApprover = false;
		boolean multiLevel = false;
		int userSequence = 0;
		int lastSequenceToApprove = 0;
		int nextSequence = 0;

		boolean lastApproverVotedNO = false;

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);

		try {
			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("----------------- isNextApprover - STARTS");

			if (debug) logger.info("kix: " + kix);

			/*
			 * if a recall took place, allow the person trying to approve and having a task to continue
			 * a recall constitute non-approval
			 *
			 * if the last voter voted NO, then the ideal way is to have it kicked off from the start. That
			 * means the last sequence is 0 or just like no vote yet.
			 *
			 * what is this user's approval sequence (userSequence). if not
			 * found, then the user is not authorize to approve. returns error.
			 * if is part of approval sequence, then determine where in line the
			 * last approver was (lastSequenceToApprove). the last sequence + 1 should be
			 * this user's sequence in order to move on.
			 * if the user is not on the list of approver sequence, are they on a distribution list?
			 * if so, confirm that there is more or less to approve
			 */

			String taskAssignedToApprover = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);
			boolean recalledApprovalHistory = HistoryDB.recalledApprovalHistory(conn,kix,alpha,num,user);
			if (taskAssignedToApprover != null
				&& taskAssignedToApprover.length() > 0
				&& taskAssignedToApprover.equals(user)
				&& recalledApprovalHistory){
				return true;
			}

			// was this kicked back for revision? we know it was if the last approved vote was no in history
			// look at the reject system setting to determine when it was kicked back, who it should go to
			lastApproverVotedNO = ApproverDB.lastApproverVotedNO(conn,campus,kix);
			if (lastApproverVotedNO){
				if (debug) logger.info("last approver rejected outline");

				String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
				if ((Constant.REJECT_START_FROM_BEGINNING).equals(whereToStartOnOutlineRejection)){
					lastSequenceToApprove = 0;
					if (debug) logger.info("REJECT_START_FROM_BEGINNING");
				}
				else if ((Constant.REJECT_START_WITH_REJECTER).equals(whereToStartOnOutlineRejection)){
					// get highest id from history of rejected items
					// that's the person to send to. however, minus one from the sequence so
					// that lastSequenceToApprove + 1 = the correct person
					lastSequenceToApprove = ApproverDB.getLastApproverSequence(conn,campus,kix);

					if (debug) logger.info("REJECT_START_WITH_REJECTER");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-1));

					lastSequenceToApprove = lastSequenceToApprove - 1;
				}
				else if ((Constant.REJECT_STEP_BACK_ONE).equals(whereToStartOnOutlineRejection)){
					// figure out who was last to disapprove. get that sequence and subtract 2.
					// subtract 1 to accommodate going back by one step.
					// however, nextSequence is lastSequenceToApprove + 1 so subtract another for that
					lastSequenceToApprove = ApproverDB.lastApproverVotedNOSequence(conn,campus,kix);

					if (debug) logger.info("REJECT_STEP_BACK_ONE");
					if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);
					if (debug) logger.info("lastSequenceToApprove adjusted: " + (lastSequenceToApprove-2));

					lastSequenceToApprove = lastSequenceToApprove - 2;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
				else if ((Constant.REJECT_APPROVER_SELECTS).equals(whereToStartOnOutlineRejection)){

					// look for the task to see who approver selected to restart. with the name,
					// get the sequence and subtract to get the process rolling
					if (taskAssignedToApprover != null && taskAssignedToApprover.length() > 0)
						lastSequenceToApprove = ApproverDB.getApproverSequence(conn,taskAssignedToApprover,route);

					if (debug) logger.info("REJECT_APPROVER_SELECTS");
					if (debug) logger.info("taskAssignedToApprover: " + taskAssignedToApprover);

					lastSequenceToApprove = lastSequenceToApprove - 1;

					// if lastSequenceToApprove is less than 0, then the next approver is the first
					if (lastSequenceToApprove < 0)
						lastSequenceToApprove = 0;
				}
			} // lastApproverVotedNO
			else
				lastSequenceToApprove = CourseDB.getLastSequenceToApprove(conn,campus,alpha,num);

			if (debug) logger.info("lastSequenceToApprove: " + lastSequenceToApprove);

			// was lastSequenceToApprove a distribution list? if yes, is approval for distribution completed?
			boolean isDistributionList = false;
			boolean distributionApprovalCompleted = true;

			String distributionList = ApproverDB.getApproversBySeq(conn,campus,lastSequenceToApprove,route);

			if (distributionList != null && distributionList.length() > 0)
				isDistributionList = DistributionDB.isDistributionList(conn,campus,distributionList);

			if (isDistributionList)
				distributionApprovalCompleted = ApproverDB.distributionApprovalCompleted(conn,campus,kix,distributionList,lastSequenceToApprove);

			if (debug) logger.info("distributionList: " + distributionList);
			if (debug) logger.info("isDistributionList: " + isDistributionList);
			if (debug) logger.info("distributionApprovalCompleted: " + distributionApprovalCompleted);

			// if is a distribution list and the distribution approval not completed, then sequence is last sequence
			if (isDistributionList && !distributionApprovalCompleted)
				nextSequence = lastSequenceToApprove;
			else
				nextSequence = lastSequenceToApprove + 1;

			if (debug) logger.info("nextSequence: " + nextSequence);

			/*
				retrieve approver info (structure of first/last/next)
				without route number, nothing works at this point
			*/
			if (route > 0){
				if (debug) logger.info("route: " + route);

				Approver approver = ApproverDB.getApproverByNameAndSequence(conn,campus,alpha,num,user,route,nextSequence);
				if (approver != null) {
					if (debug) logger.info("approver: " + approver);

					if (approver.getSeq() != null && approver.getSeq().length() > 0){
						userSequence = Integer.parseInt(approver.getSeq());
						if (debug) logger.info("userSequence: " + userSequence);
					}

					// make sure the next approver is set appropriately when not distribution list
					if (userSequence == 0) {
						nextApprover = false;
					} else {
						if (isDistributionList && !distributionApprovalCompleted)
							nextApprover = true;
						else{
							if ((lastSequenceToApprove + 1) == userSequence)
								nextApprover = true;
							else
								nextApprover = false;
						}
					}

					if (debug) logger.info("nextApprover: " + nextApprover);
					if (debug) logger.info("multiLevel: " + multiLevel);

					/*
					 * if is next approver and is multilevel (divisional approver),
					 * make sure the user's department is the same as the alpha.
					 */
					if (nextApprover && multiLevel) {
						if (alpha.equals(UserDB.getUserDepartment(conn, user,alpha))) {
							nextApprover = true;
						} else {
							nextApprover = false;
						}
					}

					if (debug) logger.info("nextApprover: " + nextApprover);

				} else {
					if (debug) logger.info("approver sequence not found");

					nextApprover = false;
				} // approver = null
			}	// route > 0
			else
				nextApprover = false;

			if (debug) logger.info("----------------- isNextApprover - END");

		} catch (SQLException e) {
			logger.fatal("CourseDB: isNextApprover - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: isNextApprover - " + ex.toString());
		}

		return nextApprover;
	} // nextApprover

	/*
	 * setPageTitle
	 * <p>
	 * @param	conn		Connection
	 * @param	title		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public String setPageTitle(Connection conn,String title,String alpha,String num,String campus) throws Exception {

		String pageTitle = "";

		try {
			pageTitle = title + " " + alpha + " " + num + " - " + getCourseDescription(conn,alpha,num,campus) + "";
		} catch (Exception e) {
			logger.fatal("CourseDB: setPageTitle - " + e.toString());
		}

		return pageTitle;
	}

	/*
	 * setLinkedPageTitle
	 * <p>
	 * @param	conn		Connection
	 * @param	title		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public String setLinkedPageTitle(Connection conn,String title,String alpha,String num,String campus,String kix) throws Exception {

		String pageTitle = "";

		try {
			pageTitle = title + " " + alpha + " " + num + " - " + getCourseDescription(conn,alpha,num,campus) + "";

			if(kix != null && kix.length() > 0){
				pageTitle = "<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" class=\"coursetitle\" target=\"_blank\">" + pageTitle + "</a>";
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: setLinkedPageTitle - " + e.toString());
		}

		return pageTitle;
	}

	/*
	 * showCourseProgress
	 *	<p>
	 * @return String
	 */
	public static String showCourseProgress(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws Exception {

		String progress = "";

		try {
			String query = "SELECT tc.coursetitle, tc.Progress, td.ALPHA_DESCRIPTION, tc.proposer, tc.reviewdate "
					+ "FROM tblCourse as tc, BannerAlpha AS td "
					+ "WHERE tc.coursealpha = td.COURSE_ALPHA AND "
					+ "tc.CourseAlpha=? AND tc.CourseNum=? AND tc.campus=? AND tc.CourseType='PRE'";
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, campus);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				String progressStatus = results.getString(2);

				if (progressStatus.equals(Constant.COURSE_REVIEW_TEXT)) {
					AseUtil aseUtil = new AseUtil();
					progressStatus = "REVIEW (review by date: " + aseUtil.ASE_FormatDateTime(results.getString(5),Constant.DATE_DATETIME) + ")";
				}

				progress = "<table id=\"tableShowCourseProgress\" border=\"0\" width=\"50%\">"
						+ "<tr><td colspan=2 align=\"center\"><strong>Outline Details</strong></td></tr>"
						+ "<tr><td width=\"30%\">Course:</td><td>" + alpha
						+ " " + num + "</td></tr>"
						+ "<tr><td width=\"30%\">Title:</td><td>"
						+ results.getString(1) + "</td></tr>"
						+ "<tr><td width=\"30%\">Progress:</td><td>"
						+ progressStatus + "</td></tr>"
						+ "<tr><td width=\"30%\">Discipline:</td><td>"
						+ results.getString(3) + "</td></tr>"
						+ "<tr><td width=\"30%\">Proposer:</td><td>"
						+ results.getString(4) + "</td></tr></table>";
			}

			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: showCourseProgress - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: showCourseProgress - " + ex.toString());
		}

		return progress;
	}

	/*
	 * setCourseForApproval
	 *	<p>
	 *	@param	Connection	conn
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		proposer
	 * @param	String		mode
	 * @param	route			int
	 *	<p>
	 *	@return Msg
	 */
	public static Msg setCourseForApproval(Connection conn,
														String campus,
														String alpha,
														String num,
														String proposer,
														String mode,
														int route,
														String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		/*
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * editable means a coures is in modify mode and the proposer is the
		 * current user
		 *
		 * setting the approval routing determines who we sent requests to
		 * current user
		 */
		Msg msg = new Msg();

		if (isEditable(conn,campus,alpha,num,proposer,mode)) {

			if (!IniDB.doesRoutingIDExists(conn,campus,route)){
				route = 0;
			}

			ApproverDB.setApprovalRouting(conn,campus,alpha,num,route);

			msg = setCourseForApprovalX(conn,campus,alpha,num,proposer,mode,user);

			msg.setUserLog("");

		} else {

			msg.setMsg("NotAuthorizeToApproval");

		}

		return msg;
	}

	private static Msg setCourseForApprovalX(Connection conn,
														String campus,
														String alpha,
														String num,
														String proposer,
														String mode,
														String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		int lastSequence = 0;
		int nextSequence = 1;
		int numberOfApproversThisSequence = 0;

		String lastApprover = "";
		String nextApprover = "";

		String lastDelegate = "";
		String nextDelegate = "";

		String completeList = "";

		String sql = "";

		boolean approvalCompleted = false;

		Approver approver = new Approver();
		boolean approved = false;
		boolean experimental = false;
		PreparedStatement ps = null;

		long count = 0;

		String packetApproval = "";

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);
		info = null;

		boolean debug = DebugDB.getDebug(conn,"CourseDB");

		boolean deleteApproval = false;

		//debug = false;

		if (debug) logger.info("-------------------- CourseDB - setCourseForApproval START");

		try {

			packetApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

			// for courses going through deletion as packets, we need to adjust
			// data before moving on here. data for the course was adjusted when
			// the approval process began
			if(kix != null && packetApproval.equals(Constant.ON)){

				info = Helper.getKixInfo(conn,kix);
				String progress = info[Constant.KIX_PROGRESS];
				String subprogress = info[Constant.KIX_SUBPROGRESS];
				info = null;

				if(progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT) && subprogress.equals(Constant.COURSE_DELETE_TEXT) ){

					deleteApproval = true;

					sql = "UPDATE tblcourse SET progress=?,subprogress='' WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,Constant.COURSE_DELETE_TEXT);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					mode = Constant.COURSE_DELETE_TEXT;
				}

				progress = "";
				subprogress = "";
				sql = "";

			} // kix and packetApproval

			String taskText = "";
			if (mode.equals(Constant.COURSE_DELETE_TEXT)){
				taskText = Constant.DELETE_TEXT;
			}
			else{
				taskText = Constant.APPROVAL_TEXT;
			}

			experimental = Outlines.isExperimental(num);

			//----------------------------------------------------------------------------
			// FORUM
			//----------------------------------------------------------------------------
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				if(ForumDB.getForumID(conn,campus,kix) == 0){
					// create the new forum and add proposer to access
					int fid = ForumDB.createMessageBoard(conn,campus,user,kix);
					if(fid > 0){
						Board.addBoardMember(conn,fid,user);
					}
				}
			} // board is enabled

			// get list of names. if approved, find next, else resend
			approver = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
			if (debug){
				logger.info("experimental: " + experimental);
				logger.info("route: " + route);
				logger.info("packetApproval: " + packetApproval);
				logger.info("approver: " + approver);
			} // debug

			if (approver != null){
				// break into array
				String[] approvers = new String[20];
				approvers = approver.getAllApprovers().split(",");

				String[] delegates = new String[20];
				delegates = approver.getAllDelegates().split(",");

				completeList = approver.getAllCompleteList();

				if (debug){
					logger.info("approvers: " + approver.getAllApprovers());
					logger.info("delegates: " + approver.getAllDelegates());
					logger.info("completeList: " + approver.getAllCompleteList());
				}

				// if nothing is in history, send mail to first up else who's next
				// get max sequence and determine who was last
				// if last approved, send to next; if last reject, resend
				count = ApproverDB.countApprovalHistory(conn,kix);
				if (count == 0){
					if (debug) logger.info("countApprovalHistory count is 0 or no one started");

					lastSequence = 1;
					nextSequence = 1;
					approved = false;

					numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,lastSequence,route);
					String ApprovalSubmissionAsPackets = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

					// when only a single approver at sequence 1, use it
					if (numberOfApproversThisSequence == 1){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("only 1 approver this sequence");
					}
					else if (numberOfApproversThisSequence > 1 && ApprovalSubmissionAsPackets.equals(Constant.ON)){
						// at start up, if this is the first person then check for department chair
						// if the chair is there, then get the delegate
						nextApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
						if (nextApprover != null && nextApprover.length() > 0){
							nextDelegate = ChairProgramsDB.getDelegatedName(conn,campus,alpha);
							if (debug) logger.info("department chair found - " + nextApprover + "/" + nextDelegate);
						}
					} // numberOfApproversThisSequence

					// however, if department chair not set up, use approver sequence
					if (nextApprover == null || nextApprover.length() == 0){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("department chair not found");
					}

					lastApprover = nextApprover;
					lastDelegate = nextDelegate;

					// TrackItemChanges
					Outlines.trackItemChanges(conn,campus,kix,user);
				}
				else{
					sql = "SELECT approver,approved " +
						"FROM tblApprovalHist WHERE seq IN " +
						"(SELECT MAX(seq) AS Expr1 FROM tblApprovalHist WHERE historyid=?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						lastApprover = AseUtil.nullToBlank(rs.getString("approver"));
						approved = rs.getBoolean("approved");
						lastSequence = ApproverDB.getApproverSequence(conn,lastApprover,route);
						if (debug) logger.info("lastSequence: " + lastSequence);
					}
					rs.close();
					ps.close();
				}	// if count

				numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);

				// if approved and not the last person, get next; else where do we go back to
				if (approved){
					if (debug) logger.info("approved");

					if (!lastApprover.equals(approvers[approvers.length-1])){
						nextSequence = lastSequence + 1;

						// adjust for 0th based array
						nextApprover = approvers[--nextSequence];

						approvalCompleted = false;
					}
					else
						approvalCompleted = true;
				}
				else{
					if (debug) logger.info("not approved");

					String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
					if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_WITH_REJECTER)){
						if (debug) logger.info("Constant.REJECT_START_WITH_REJECTER");
						nextApprover = lastApprover;
						nextDelegate = lastDelegate;
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_FROM_BEGINNING)){
						if (debug) logger.info("Constant.REJECT_START_FROM_BEGINNING");
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_STEP_BACK_ONE)){
						if (debug) logger.info("Constant.REJECT_STEP_BACK_ONE");
						// a step back would be the last person to approve this outline in history.
						// since this is rejection, we have to look for the last person to approve
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else {
						// in case whereToStartOnOutlineRejection was not set
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}

					approvalCompleted = false;
				}	// if approved

				if (debug){
					logger.info("taskText " + taskText);
					logger.info("lastApprover: " + lastApprover);
					logger.info("nextApprover: " + nextApprover);
					logger.info("nextDelegate: " + nextDelegate);
					logger.info("nextSequence: " + nextSequence);
					logger.info("completeList: " + completeList);
					logger.info("numberOfApproversThisSequence: " + numberOfApproversThisSequence);
				}

				if (!approvalCompleted){
					sql = "UPDATE tblCourse "
							+ "SET edit=0,edit0='',edit1='3',edit2='3',progress=?,reviewdate=null "
							+ "WHERE campus=? "
							+ "AND coursealpha=? "
							+ "AND coursenum=? "
							+ "AND coursetype='PRE'";
					ps = conn.prepareStatement(sql);
					ps.setString(1,mode);
					ps.setString(2,campus);
					ps.setString(3,alpha);
					ps.setString(4,num);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("course set for approval");

					// delete modify or revise task for author
					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.MODIFY_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("modify task removed - rowsAffected " + rowsAffected);

					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.REVISE_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("revise task removed - rowsAffected " + rowsAffected);

					// delete review tasks for all in this outline
					rowsAffected = TaskDB.logTask(conn,"ALL",proposer,alpha,num,
															Constant.REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("review tasks removed - rowsAffected " + rowsAffected);

					// delete approval pending for user who is likely to be the DC
					if(deleteApproval){
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.DELETE_APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}
					else{
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}

					if (debug) logger.info("approval pending tasks removed - rowsAffected " + rowsAffected);

					//	if the approver list is not complete and there is no approval yet, it's because the division
					//	chair was not decided or known.
					//	if numberOfApproversThisSequence = 1, then there is only one person this sequence
					//	so just send it. If more than one, show a list.
					//
					//	above is overridden by packetApproval is ON. In which case, the chair of the department is first up

					if (	completeList.equals(Constant.OFF) &&
							count== 0 &&
							numberOfApproversThisSequence > 1 &&
							packetApproval.equals(Constant.OFF)){
						msg.setCode(1);
						msg.setMsg("forwardURL");
					}
					else{

						rowsAffected = TaskDB.logTask(conn,
																nextApprover,
																proposer,
																alpha,
																num,
																taskText,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_APPROVER);

						if (nextDelegate != null && nextDelegate.length() > 0){
							rowsAffected = TaskDB.logTask(conn,
																	nextDelegate,
																	proposer,
																	alpha,
																	num,
																	taskText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER);
						}

						if (debug) logger.info("approval task created - rowsAffected " + rowsAffected);

						MailerDB mailerDB = new MailerDB(conn,
																	proposer,
																	nextApprover,
																	nextDelegate,
																	Constant.BLANK,
																	alpha,
																	num,
																	campus,
																	"emailOutlineApprovalRequest",
																	kix,
																	proposer);

						if (debug) logger.info("mail sent");
					}
				}
			} // if (approver != null){

		} catch (SQLException ex) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + ex.toString());
			msg.setMsg("CourseApprovalError");
		} catch (Exception e) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + e.toString());
		}

		if (debug) logger.info("-------------------- CourseDB - setCourseForApproval END");

		return msg;
	} // CourseDB: setCourseForApprovalX

	/*
	 * Cancelling a outline means to move it to cancelled table and not delete.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 * @return Msg
	 */
	public static Msg cancelOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user) throws Exception {

		Msg msg = new Msg();

		try{
			CourseCancel cc = new CourseCancel();
			msg = cc.cancelOutline(conn,campus,alpha,num,user);
		}
		catch(Exception e){
			logger.fatal("CourseDB: cancelOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * isCourseApprovalCancellable
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isCourseApprovalCancellable(Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String user){
		/*
			cancelling an outline takes the following steps

			1) Is the outline in APPROVAL status
			2) Is this the proposer
			3) If cancel anytime is true or not history yet
		*/

		int rowsAffected = 0;
		Msg msg = new Msg();
		boolean courseApprovalCancellable = false;
		boolean cancelApprovalAnyTime = false;

		try{
			String progress = getCourseProgress(conn,campus,alpha,num,"PRE");
			if ((Constant.COURSE_APPROVAL_TEXT).equals(progress) || (Constant.COURSE_APPROVAL_PENDING_TEXT).equals(progress) ){
				//logger.info("CourseDB: isCourseApprovalCancellable - IS APPROVAL PROCESS");
				String proposer = getCourseProposer(conn,campus,alpha,num,"PRE");
				if (proposer.equals(user)){
					//logger.info("CourseDB: isCourseApprovalCancellable - IS PROPOSER");
					String temp = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelApprovalAnyTime");
					if (temp.equals(Constant.ON))
						cancelApprovalAnyTime = true;

					boolean approvalStarted = HistoryDB.approvalStarted(conn,campus,alpha,num,user);

					if (cancelApprovalAnyTime || !approvalStarted){
						//logger.info("CourseDB: isCourseApprovalCancellable - OK TO CANCEL");
						msg.setResult(true);
					}
					else{
						msg.setMsg("OutlineApprovalStarted");
						//logger.info("CourseDB: isCourseApprovalCancellable - Approval started by approvers.");
					} // history
				}	// proposer
				else{
					msg.setMsg("OutlineProposerCanCancel");
					//logger.info("CourseDB: isCourseApprovalCancellable - Attempting to cancel when not proposer of outline.");
				}	// proposer
			} // approval
			else{
				msg.setMsg("OutlineNotInApprovalStatus");
				//logger.info("CourseDB: isCourseApprovalCancellable - Attempting to cancel outline approval that is not cancellable.");
			}	// approval
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: isCourseApprovalCancellable - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: isCourseApprovalCancellable - " + e.toString());
		}

		return msg;
	}

	/*
	 * cancelOutlineApproval
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelOutlineApproval(Connection conn,
														String campus,
														String alpha,
														String num,
														String user) throws Exception {

		int rowsAffected = 0;
		String type = "PRE";
		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);
		info = null;

		String progressText = "";

		boolean debug = false;

		/*
			cancelling approval takes the following steps:

			1) Make sure it's in the correct progress and isCourseApprovalCancellable
			2) update the course record
			3) send notification to all
			4) clear history
		*/

		Msg msg = isCourseApprovalCancellable(conn,campus,alpha,num,user);
		if (msg.getResult()){

			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info(kix + " - COURSEDB - CANCELOUTLINEAPPROVAL - START");

			try{
				String progress = getCourseProgress(conn,campus,alpha,num,"PRE");
				if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
					progressText = Constant.APPROVAL_TEXT;
				}
				else if (progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)){

					info = Helper.getKixInfo(conn,kix);
					String subprogress = info[Constant.KIX_SUBPROGRESS];
					info = null;

					if(subprogress.equals(Constant.COURSE_DELETE_TEXT) ){
						progressText = Constant.DELETE_APPROVAL_PENDING_TEXT;
					}
					else{
						progressText = Constant.APPROVAL_PENDING_TEXT;
					}
				} // progress

				String sql = "UPDATE tblCourse SET edit=1,progress='MODIFY',edit1=?,edit2=?,route=0,subprogress='' " +
					"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,MiscDB.getCourseEditFlags(conn,campus,kix,Constant.TAB_COURSE));
				ps.setString(2,MiscDB.getCourseEditFlags(conn,campus,kix,Constant.TAB_CAMPUS));
				ps.setString(3,campus);
				ps.setString(4,alpha);
				ps.setString(5,num);
				ps.setString(6,type);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("updated course (" + rowsAffected + " rows)");

				// when cancelling, find names of all who have approved/revised as well as the person
				// with the task to approve
				sql = "SELECT DISTINCT approver FROM tblApprovalHist WHERE historyid=?";
				String approvers = SQLUtil.resultSetToCSV(conn,sql,kix);
				String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,progressText);

				if (approvers != null && approvers.length() > 0)
					approvers = approvers + "," + submittedFor;
				else
					approvers = submittedFor;

				if (approvers != null && approvers.length() > 0){
					DistributionDB.notifyDistribution(conn,campus,alpha,num,type,user,approvers,"","emailOutlineCancelApproval","",user);
					if (debug) logger.info("distribution list sent to - " + approvers);
				}

				// remove all tasks from approvers, then put task back for modifying outline
				rowsAffected = TaskDB.logTask(conn,"ALL",user,alpha,num,progressText,campus,"","REMOVE","PRE");
				if (debug) logger.info("remove approve outline task (" + rowsAffected + " rows)");

				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.MODIFY_TEXT,campus,"crsappr.jsp","ADD","PRE");
				if (debug) logger.info("add modify outline task ("+rowsAffected+" rows)");

				//----------------------------------------------------------------------------
				// FORUM
				//----------------------------------------------------------------------------
				String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
				if (enableMessageBoard.equals(Constant.ON)){
					int fid = ForumDB.getForumID(conn,campus,kix);
					if(fid > 0){
						ForumDB.deleteForum(conn,fid);
					}
				}

				// keeping code to clean up anything left behind
				sql = "DELETE FROM tblApprovalHist WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("deleted approval hist ("+rowsAffected+" rows)");

				sql = "DELETE FROM tblApprovalHist2 WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("deleted approval hist ("+rowsAffected+" rows)");

				// delete review history and reviewers if any
				sql = "DELETE FROM tblReviewHist WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("deleted review hist ("+rowsAffected+" rows)");

				sql = "DELETE FROM tblReviewHist2 WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
				if (debug) logger.info("deleted review hist ("+rowsAffected+" rows)");

				// refractor ReviewerDB.removeReviewers
				// this line replaces commented out below
				rowsAffected = ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user);
				if (debug) logger.info("remove reviewers ("+rowsAffected+" rows)");

				if (debug) logger.info(kix + " - COURSEDB: CANCELOUTLINEAPPROVAL - END");

			}
			catch(SQLException se){
				logger.fatal(kix + " - CourseDB: cancelOutlineApproval - " + se.toString());
			}
			catch(Exception e){
				logger.fatal(kix + " - CourseDB: cancelOutlineApproval - " + e.toString());
			}
		}
		else{
			logger.info(msg.getMsg());
		}

		return msg;
	}

	/*
	 * cancelOutlineReview - cancels the review process after requesting to start.
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg cancelOutlineReview(Connection conn,
														String campus,
														String alpha,
														String num,
														String user) throws Exception {

		return cancelOutlineReview(conn,campus,alpha,num,user,1);

	}

	public static Msg cancelOutlineReview(Connection conn,
														String campus,
														String alpha,
														String num,
														String user,
														int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in review process
		 * 1) Must be proposer or approver sending out review in approval
		 * 2) Cannot have any comments in the system (tblReviewHist)
		 * 3) Remove tasks
		 * 4) Notify reviewers
		 */

		int rowsAffected = 0;
		int i = 0;
		Msg msg = new Msg();
		String SQL = "";
		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
		PreparedStatement ps;
		StringBuffer errorLog = new StringBuffer();

		String proposer = null;
		String progress = null;
		String subprogress = null;
		String currentApprover = null;
		String cancelReviewAnyTime = null;

		try{

			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("------------------- canceloutlinereview - START");

			//
			// REVIEW_IN_REVIEW
			//
			if(level==0){
				level = 1;
			}

			String[] info = Helper.getKixInfo(conn,kix);
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			subprogress = info[Constant.KIX_SUBPROGRESS];

			if (debug){
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("user: " + user);
				logger.info("proposer: " + proposer);
				logger.info("progress: " + progress);
				logger.info("subprogress: " + subprogress);
				logger.info("level: " + level);
			}

			// 0
			if (progress.equals(Constant.COURSE_REVIEW_TEXT) || subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

				currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
				cancelReviewAnyTime = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelReviewAnyTime");

				if (debug){
					logger.info("currentApprover: " + currentApprover);
					logger.info("cancelReviewAnyTime: " + cancelReviewAnyTime);
				}

				// 1
				String allowReviewInReview = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowReviewInReview");
				if (proposer.equals(user) || currentApprover.equals(user) || (level > 1 && allowReviewInReview.equals(Constant.ON))){

					if(debug) logger.info("step 1 checked");

					// 2
					if (cancelReviewAnyTime.equals(Constant.ON) || !HistoryDB.reviewStarted(conn,campus,alpha,num,user)){

						if(debug) logger.info("step 2 checked");

						//
						// when level is > 1, we have REVIEW_IN_REVIEW and so don't update course
						//
						if(level == 1){

							if(debug) logger.info("level 1 = proposer");

							if (progress.equals(Constant.COURSE_REVIEW_TEXT)){

								if(debug)  logger.info("level 1 review");

								SQL = "UPDATE tblCourse SET edit=1,progress='MODIFY',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
									"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,MiscDB.getCourseEditFromMiscEdit(conn,campus,kix,Constant.TAB_COURSE));
								ps.setString(2,MiscDB.getCourseEditFromMiscEdit(conn,campus,kix,Constant.TAB_CAMPUS));
								ps.setString(3,campus);
								ps.setString(4,alpha);
								ps.setString(5,num);
								rowsAffected = ps.executeUpdate();
							}
							else if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){

								if(debug)  logger.info("level 1 review in approval");

								SQL = "UPDATE tblCourse SET edit=0,progress='APPROVAL',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
									"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,MiscDB.getCourseEditFromMiscEdit(conn,campus,kix,Constant.TAB_COURSE));
								ps.setString(2,MiscDB.getCourseEditFromMiscEdit(conn,campus,kix,Constant.TAB_CAMPUS));
								ps.setString(3,campus);
								ps.setString(4,alpha);
								ps.setString(5,num);
								rowsAffected = ps.executeUpdate();
							} // update
							if (debug) logger.info("reset course to modify status - " + rowsAffected + " rows");
						} // level == 1

						//
						// remove reviewer task
						// first, determine who is attempting to cancel. if level == 1, then proposer, or approver.
						// if so, remove all. only level above 1 requires limited removal
						//
						int reviewLevel = level;
						if(reviewLevel == 1){
							reviewLevel = Constant.ALL_REVIEWERS;
						}

						String reviewers = ReviewerDB.getReviewerNames(conn,campus,alpha,num,user,reviewLevel);
						if (debug) logger.info("reviewers: " + reviewers);
						if (reviewers != null && !(Constant.BLANK).equals(reviewers)){
							String[] tasks = new String[100];
							tasks = reviewers.split(",");
							for (i=0; i<tasks.length; i++) {
								rowsAffected = TaskDB.logTask(conn,
																		tasks[i],
																		tasks[i],
																		alpha,
																		num,
																		Constant.REVIEW_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		Constant.PRE);
								SQL = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND userid=?";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,campus);
								ps.setString(2,alpha);
								ps.setString(3,num);
								ps.setString(4,tasks[i]);
								rowsAffected = ps.executeUpdate();
								AseUtil.logAction(conn,tasks[i],"REMOVE","Review task removed",alpha,num,campus,kix);
								if (debug) logger.info("remove task for reviewer: " + tasks[i] + " - " + rowsAffected + " rows");
							}

							// notify reviewers
							DistributionDB.notifyDistribution(conn,campus,alpha,num,"",user,reviewers,"","emailOutlineCancelReview","",user);

						} // !(Constant.BLANK).equals(reviewers)

						//
						// update review history
						//
						if(level == 1){
							SQL = "INSERT INTO tblReviewHist2 "
									+ "(id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled ) "
									+ "SELECT id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled "
									+ "FROM tblReviewHist "
									+ "WHERE campus=? AND "
									+ "CourseAlpha=? AND "
									+ "CourseNum=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							rowsAffected = ps.executeUpdate();
							if (debug) logger.info("moved review to backup history - " + rowsAffected + " rows");

							SQL = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							rowsAffected = ps.executeUpdate();
							if (debug) logger.info("delete reviews from active table - " + rowsAffected + " rows");

							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	num,
																	Constant.REVIEW_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	Constant.PRE);
							if (debug) logger.info("remove review task - " + rowsAffected + " rows");

							if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
								rowsAffected = TaskDB.logTask(conn,
																		user,
																		user,
																		alpha,
																		num,
																		Constant.MODIFY_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE);
							}
							else{
								rowsAffected = TaskDB.logTask(conn,
																		user,
																		user,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE);
							}

							if (debug) logger.info("recreate task for proposer - " + rowsAffected + " rows");

							AseUtil.logAction(conn,user,"ACTION","Course review cancelled",alpha,num,campus,kix);

						}
						else{
							AseUtil.logAction(conn,user,"ACTION","Course review in review cancelled",alpha,num,campus,kix);
						}
						// level 1


					}
					else{
						msg.setMsg("OutlineReviewStarted");
						if (debug) logger.info("Review started by reviewers.");
					}  // 2
				}
				else{
					msg.setMsg("OutlineProposerCanCancel");
					if (debug) logger.info("Attempting to cancel when not proposer of outline.");
				}  // 1
			}
			else{
				msg.setMsg("OutlineNotInReviewStatus");
				if (debug) logger.info("Attempting to cancel outline review that is not cancellable.");
			} // 0

		} catch (SQLException ex) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("CourseDB: cancelOutlineReview - " + ex.toString() + " - " + errorLog.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("CourseDB: cancelOutlineReview - " + e.toString() + " - " + errorLog.toString());
		}

		if (debug) logger.info("------------------- canceloutlinereview - END");

		return msg;
	}

	/*
	 * moveCurrentToArchived
	 *	<p>
	 * @param connection
	 * @param campus
	 * @param alpha
	 * @param num
	 *	@param user
	 *	<p>
	 *	@return Msg
	 */
	public static Msg moveCurrentToArchived(Connection conn,
														String campus,
														String alpha,
														String num,
														String user) throws Exception {

		Msg msg = new Msg();

		try{
			CourseCurrentToArchive cm = new CourseCurrentToArchive();
			msg = cm.moveCurrentToArchived(conn,campus,alpha,num,user);
		}
		catch(Exception e){
			logger.fatal("CourseDB: moveCurrentToArchived - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * deleteOutline
	 * <p>
	 *	@param conn			Connection
	 * @param campus		String
	 * @param alpha		String
	 *	@param num			String
	 *	@param type			String
	 * @param user			String
	 * @param comments	String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg deleteOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String type,
												String user,
												String comments) throws Exception {

		Msg msg = new Msg();

		try{
			CourseDelete cd = new CourseDelete();
			msg = cd.deleteOutline(conn,campus,alpha,num,type,user,comments);
		}
		catch(Exception e){
			logger.fatal("CourseDB: deleteOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * Is this course reviewable? If so, is this the proposer? Only proposer can invite.
	 * progress = review or modify or review in approval
	 * review requested = proposer
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	alpha
	 * @param	num
	 * @param	user
	 * <p>
	 * @return boolean
	 */
	public static boolean isCourseReviewable(Connection connection,
															String campus,
															String alpha,
															String num,
															String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean reviewable = false;
		String proposer = "";
		String progress = "";
		String subprogress = "";
		String currentApprover = "";
		String kix = "";

		try {
			kix = Helper.getKix(connection,campus,alpha,num,"PRE");

			String[] info = Helper.getKixInfo(connection,kix);
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			subprogress = info[Constant.KIX_SUBPROGRESS];

			currentApprover = ApproverDB.getCurrentApprover(connection,campus,alpha,num);
			if (currentApprover == null){
				currentApprover = Constant.BLANK;
			}

			// only the proposer may invite for reviews
			if ((progress.equals(Constant.COURSE_MODIFY_TEXT) || progress.equals(Constant.COURSE_REVIEW_TEXT))
						&& user.equals(proposer)
				){
				reviewable = true;
			}
			else if ((progress.equals(Constant.COURSE_APPROVAL_TEXT) && user.equals(currentApprover))
						||
						(progress.equals(Constant.COURSE_DELETE_TEXT) && user.equals(currentApprover))
				){
				reviewable = true;
			}
			else{
				reviewable = false;
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseReviewable - " + e.toString());
		}

		return reviewable;
	} // isCourseReviewable

	/*
	 * has this course been crossed ref? <p> @return boolean
	 */
	public static boolean isCourseXReffed(Connection connection,
														String campus,
														String alpha,
														String num) throws SQLException {

		boolean xreffed = false;

		try {
			String sql = "SELECT coursealpha FROM tblXref WHERE courseAlphax=? AND coursenumx=? AND campus=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, campus);
			ResultSet results = ps.executeQuery();
			xreffed = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: isCourseXReffed - " + e.toString());
		}

		return xreffed;
	}

	/*
	 * Returns true if the course exists
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return boolean
	 */
	public static boolean courseExist(Connection conn,String kix) throws SQLException {

		boolean exists = false;

		try {
			String sql = "SELECT id FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExist - " + e.toString());
		}

		return exists;
	}

	/*
	 * Returns true if the course exists
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 * @return boolean
	 */
	public static boolean courseExist(Connection connection,
												String campus,
												String alpha,
												String num) throws SQLException {

		boolean exists = false;

		try {
			String sql = "SELECT coursetype FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
			//AseUtil.loggerInfo("CourseDB: courseExist ", "", campus, alpha, num);
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExist - " + e.toString());
			exists = false;
		}

		return exists;
	}

	/*
	 * Returns true if the course exists in a particular type
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * <p>
	 * @return boolean
	*/
	public static boolean courseExistByType(Connection connection,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		boolean courseType = false;

		try {
			String sql = "SELECT coursetype FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			courseType = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExistByType - " + e.toString());
			courseType = false;
		}

		return courseType;
	}

	/*
	 * Returns true if the course exists by history
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	type			String
	 * <p>
	 * @return boolean
	*/
	public static boolean courseExistByTypeKix(Connection conn,String campus,String kix,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		String table = "tblcourse";

		try {
			if (type.equals("ARC")){
				table = "tblcoursearc";
			}

			String sql = "SELECT coursetype FROM "+table+" WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExistByTypeKix - " + e.toString());
		}

		return exists;
	}

	/*
	 * Returns true if the course exists in a particular type and user
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	proposer		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * <p>
	 */
	public static boolean courseExistByProposer(Connection connection,
																String campus,
																String proposer,
																String alpha,
																String num,
																String type) throws SQLException {

		boolean exists = false;
		String sql = "";

		try {
			sql = "SELECT historyid "
				+ "FROM tblCourse "
				+ "WHERE campus=? "
				+ "AND proposer=? "
				+ "AND courseAlpha=? "
				+ "AND coursenum=? "
				+ "AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,proposer);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			ResultSet results = ps.executeQuery();
			exists = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExistByProposer - n" + e.toString());
		}

		return exists;
	}

	/*
	 * Returns true if the course exists by historyid
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 */
	public static boolean courseExistByHistoryid(Connection conn,String kix) throws SQLException {

		boolean exists = false;
		String sql = "";

		try {
			sql = "SELECT historyid FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExistByHistoryid - n" + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: courseExistByHistoryid - n" + e.toString());
		}

		return exists;
	}

	/*
	 * Returns true if the course exists in a particular type and campus
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * <p>
	 */
	public static boolean courseExistByTypeCampus(Connection conn,String campus,String alpha,String num,String type) throws SQLException {

		boolean courseType = false;
		String sql = "";

		try {
			if (type.equals("ARC"))
				sql = "SELECT coursetype FROM tblCourseARC WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=? GROUP BY CourseType";
			else
				sql = "SELECT coursetype FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			courseType = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseExistByTypeCampus - " + e.toString());
		}

		return courseType;
	}

	/*
	 * Returns true if the course SLO exists in a particular type and campus
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * <p>
	 */
	public static boolean courseSLOExistByTypeCampus(Connection connection,
																String campus,
																String alpha,
																String num,
																String type) throws SQLException {

		boolean courseType = false;
		String sql = "";

		try {
			if ("ARC".equals(type))
				sql = "SELECT coursetype FROM tblCourseARC WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=? GROUP BY CourseType";
			else
				sql = "SELECT coursetype FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			courseType = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: courseSLOExistByTypeCampus - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: courseSLOExistByTypeCampus - " + ex.toString());
		}

		return courseType;
	}

	/*
	 * Removes reviewer from review task
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	@param	String		user
	 *	<p>
	 *	@return boolean
	 */
	public static Msg endReviewerTask(Connection conn,
													String campus,
													String alpha,
													String num,
													String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;

		boolean reviewInApproval = false;

		boolean debug = false;

		int numberOfReviewers = 0;

		String progress = "";
		String proposer = "";
		String subprogress = "";

		String mode = "APPROVAL";

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		try {
			msg.setMsg("");

			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("------------------- coursedb - endreviewertask - START");

			String[] info = Helper.getKixInfo(conn,kix);
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			subprogress = info[Constant.KIX_SUBPROGRESS];

			if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL) || subprogress.equals(Constant.COURSE_REVIEW_IN_DELETE)){
				reviewInApproval = true;

				if (subprogress.equals(Constant.COURSE_REVIEW_IN_DELETE)){
					mode = "DELETE";
				}
			}

			String approver = ApproverDB.getCurrentApprover(conn,campus,alpha,num);

			if (debug){
				logger.info("proposer - " + proposer);
				logger.info("progress: " + progress);
				logger.info("approver: " + approver);
				logger.info("subprogress: " + subprogress);
				logger.info("reviewInApproval: " + reviewInApproval);
				logger.info("mode: " + mode);
			}

			// end user's review task
			String sql = "DELETE FROM tblReviewers WHERE campus=? AND courseAlpha=? AND coursenum=? AND userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, user);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("review completed - " + rowsAffected + " row");

			rowsAffected = TaskDB.logTask(conn,
													user,
													user,
													alpha,
													num,
													Constant.REVIEW_TEXT,
													campus,
													"crsrvwer.jsp",
													Constant.TASK_REMOVE,
													Constant.PRE);

			// ER18. need to also remove board invite
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				Board.endReviewProcess(conn,campus,kix,user);
			} // message board

			/*
			 * it's possible that no reviewer added comments. If so, rowsAffected is still 0
			 */
			if (rowsAffected >= 0) {
				// if all reviewers have completed their task, let's reset the
				// course and get back to modify/approval mode. also, backup history
				sql = "WHERE courseAlpha = '" + SQLUtil.encode(alpha)
						+ "' AND " + "coursenum = '" + SQLUtil.encode(num)
						+ "' AND " + "campus = '" + SQLUtil.encode(campus)
						+ "'";

				numberOfReviewers = (int)AseUtil.countRecords(conn,"tblReviewers",sql);
				if (debug) logger.info("numberOfReviewers: " + numberOfReviewers);

				// if all reivewers completed, then reset back to modify or approval
				if (numberOfReviewers == 0) {

					// reset course from review to modify or approve
					if (reviewInApproval){
						if (mode.equals("DELETE")){
							sql = "UPDATE tblCourse "
								+ "SET edit=0,edit0='',progress='DELETE',subprogress='"+Constant.COURSE_REVIEW_IN_DELETE+"',reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
						}
						else{
							sql = "UPDATE tblCourse "
								+ "SET edit=0,edit0='',progress='APPROVAL',subprogress='',reviewdate=null "
								+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
						}

						ps = conn.prepareStatement(sql);
						ps.setString(1, campus);
						ps.setString(2, alpha);
						ps.setString(3, num);
						rowsAffected = ps.executeUpdate();

					}
					else{
						// restore edit flags after review completes. data stored in misc edit1/edit2
						// edit1 and 2 contains values in CSV and is based on correct sequence numbering
						// edit1 and 2 in course contains CSV but by question numbering based on CM6100
						sql = "UPDATE tblCourse "
							+ "SET edit=1,edit0='',edit1=?,edit2=?,progress='MODIFY',reviewdate=null "
							+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";

						ps = conn.prepareStatement(sql);
						ps.setString(1,MiscDB.getCourseEditFlags(conn,campus,kix,Constant.TAB_COURSE));
						ps.setString(2,MiscDB.getCourseEditFlags(conn,campus,kix,Constant.TAB_CAMPUS));
						ps.setString(3,campus);
						ps.setString(4,alpha);
						ps.setString(5,num);
						rowsAffected = ps.executeUpdate();
					}

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("move history data - " + rowsAffected + " row");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, campus);
					ps.setString(2, alpha);
					ps.setString(3, num);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// if reviews were done during the approval process, put the task back to Approve outline for the
					// approver kicking off the review. Task and message should be directed to approver and not proposer
					// it's possible that the approver is not known so we send null to the function to at least determine
					// if the approval process is in flight.

					// because the review process within approval removed the task for the person kicking off the review
					// then send back to the person requesting the review to start approving.
					MailerDB mailerDB = null;

					if (reviewInApproval){

						if (approver != null && approver.length() > 0){
							mailerDB = new MailerDB(conn,user,approver,"","",alpha,num,campus,"emailOutlineReviewCompleted",kix,user);
							if (debug) logger.info("reviewInApproval - mail sent to - " + approver);

							if (mode.equals("DELETE")){
								rowsAffected = TaskDB.logTask(conn,
																		approver,
																		user,
																		alpha,
																		num,
																		Constant.DELETE_TEXT,
																		campus,
																		"Approve process",
																		Constant.TASK_ADD,
																		Constant.PRE,
																		Constant.BLANK,
																		Constant.TASK_APPROVER);
							}
							else{
								rowsAffected = TaskDB.logTask(conn,
																		approver,
																		user,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		"Approve process",
																		Constant.TASK_ADD,
																		Constant.PRE,
																		Constant.BLANK,
																		Constant.TASK_APPROVER);
							}

							if (debug) logger.info("reviewInApproval - task created for - " + approver);
						} // approver != null

					}
					else{
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																proposer,
																alpha,
																num,
																Constant.MODIFY_TEXT,
																campus,
																"Review process",
																Constant.TASK_ADD,
																Constant.PRE);
						if (debug) logger.info("reviewInApproval - task created for - " + proposer);

						mailerDB = new MailerDB(conn,user,proposer,"","",alpha,num,campus,"emailOutlineReviewCompleted",kix,user);
						if (debug) logger.info("reviewInApproval - mail sent to - " + proposer);
					} // reviewInApproval
				} // numberOfReviewers > 0
			} // rowsAffected

			AseUtil.logAction(conn,
									user,
									"ACTION",
									"Review completed ",
									alpha,
									num,
									campus,
									kix);

			if (debug) logger.info("------------------- coursedb - endreviewertask - END");

		} catch (SQLException e) {
			logger.fatal("CourseDB - endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		} catch (Exception e) {
			logger.fatal("CourseDB - endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		}


		return msg;
	} // endReviewerTask

	/*
	 * getHistoryID
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	type		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getHistoryID(Connection conn,
												String campus,
												String alpha,
												String num,
												String type) throws Exception {
		String historyID = "";

		try {
			String sql = "SELECT historyID " +
					"FROM tblCourse  " +
					"WHERE campus=? AND courseAlpha=? AND courseNum=? AND CourseType=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			if (results.next())
				historyID = AseUtil.nullToBlank(results.getString(1));

			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CourseDB: getHistoryID - " + e.toString());
		}

		return historyID;
	}

	/*
	 * getHistoryIDByTable
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	type		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getHistoryIDByTable(Connection conn,
															String campus,
															String alpha,
															String num,
															String type) throws Exception {

		String historyID = "";
		String table = "";

		try {
			if (type.equals("ARC"))
				table = "tblCourseARC";
			else if (type.equals("CAN"))
				table = "tblCourseCAN";
			else if (type.equals("CUR"))
				table = "tblCourse";
			else if (type.equals("PRE"))
				table = "tblCourse";

			String sql = "SELECT historyID "
							+ "FROM " + table + " "
							+ "WHERE campus=? "
							+ "AND courseAlpha=? "
							+ "AND courseNum=? "
							+ "AND CourseType=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				historyID = AseUtil.nullToBlank(rs.getString(1));

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CourseDB: getHistoryIDByTable - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: getHistoryIDByTable - " + e.toString());
		}

		return historyID;
	}

	/*
	 * approveOutline
	 *	<p>
	 *	@param	Connection	connection
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		user
	 * @param	bollean		approval
	 * @param	String		comments
	 * @param	int			voteFor
	 * @param	int			voteAgainst
	 * @param	int			voteAbstain
	 *	<p>
	 *	@return int
	 */
	public static Msg approveOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments,
												int voteFor,
												int voteAgainst,
												int voteAbstain) throws Exception {
		Msg msg = new Msg();

		try{
			msg = CourseApproval.approveOutline(conn,
												campus,
												alpha,
												num,
												user,
												approval,
												comments,
												voteFor,
												voteAgainst,
												voteAbstain);
		}
		catch(Exception e){
			logger.fatal("CourseDB: approveOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * approveOutlineReview
	 *	<p>
	 *	@param	Connection	connection
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		user
	 * @param	bollean		approval
	 * @param	String		comments
	 * @param	int			voteFor
	 * @param	int			voteAgainst
	 * @param	int			voteAbstain
	 *	<p>
	 *	@return int
	 */
	public static int approveOutlineReview(Connection conn,
														String campus,
														String kix,
														String alpha,
														String num,
														String user,
														String comments,
														int voteFor,
														int voteAgainst,
														int voteAbstain) throws Exception {
		int rowsAffected = 0;

		try{
			// because this is reviews within an approval, we don't have the ability to approve
			// so set the approved flag to FALSE.

			int sequence = ApproverDB.getSequenceNotApproved(conn,campus,kix);
			String inviter = TaskDB.getInviter(conn,campus,alpha,num,user);

			if (!HistoryDB.isMatch(conn,campus,kix,user,inviter)){
				rowsAffected = HistoryDB.addHistory(conn,
													alpha,
													num,
													campus,
													user,
													CourseApproval.getNextSequenceNumber(conn),
													false,
													comments,
													kix,
													sequence,
													voteFor,
													voteAgainst,
													voteAbstain,
													inviter,
													Constant.TASK_REVIEWER,
													Constant.COURSE_REVIEW_TEXT);
			}
			else{
				rowsAffected = HistoryDB.updateHistory(conn,campus,user,comments,kix,voteFor,voteAgainst,voteAbstain,inviter);
			}

		}
		catch(Exception e){
			logger.fatal("CourseDB: approveOutlineReview - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * A course is deletable only if: noting in PRE
	 *	<p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param alpha	String
	 *	@param num		String
	 *	@param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isCourseDeletable(Connection connection,
															String campus,
															String alpha,
															String num,
															String user) throws SQLException {

		boolean deletable = false;

		try {
			// a course can be deleted only if no PREs exist. If a pre is
			// available, that means we are doing modifications.
			// courseExistByTypeCampus returns true if PRE exists. If true, then
			// deletable should be false (!).
			deletable = !courseExistByTypeCampus(connection,campus,alpha,num,"PRE");
			AseUtil.loggerInfo("CourseDB: isCourseDeletable ",campus,user,alpha,num);
		} catch (SQLException e) {
			logger.fatal("CourseDB: isCourseDeletable - " + e.toString());
			deletable = false;
		}

		return deletable;
	}

	/*
	 * Determines if user is allowed to review a course and that it is not yet expired
	 * <p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param alpha	String
	 *	@param num		String
	 *	@param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isCourseReviewer(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean reviewer = false;
		boolean debug = false;

		int counter = 0;

		try {
			if (debug) logger.info("--------------------- START");

			String table = "tblReviewers tbr INNER JOIN tblCourse tc ON "
					+ "(tbr.campus = tc.campus) AND "
					+ "(tbr.coursenum = tc.CourseNum) AND "
					+ "(tbr.coursealpha = tc.CourseAlpha) ";

			String where = "GROUP BY tbr.coursealpha,tbr.coursenum,tc.CourseType,tbr.userid,tc.reviewdate "
					+ "HAVING (tbr.coursealpha='"
					+ alpha
					+ "' AND  "
					+ "tbr.coursenum='"
					+ num
					+ "' AND  "
					+ "tc.CourseType='PRE' AND  "
					+ "tbr.userid='"
					+ user
					+ "' AND "
					+ "tc.reviewdate >= " + DateUtility.getSystemDateSQL("yyyy-MM-dd") + ")";

			counter = (int) AseUtil.countRecords(conn,table,where);

			if (debug) logger.info("counter: " + counter);

			if (counter > 0)
				reviewer = true;

			if (debug) logger.info("--------------------- END");

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseReviewer - " + e.toString());
		}

		return reviewer;
	}

	/*
	 * Cross Listing courses <p> @return int
	 */
	public static int xListCourse(Connection connection,
											String action,
											String campus,
											String alpha,
											String num,
											String alphax,
											String numx) throws SQLException {

		int rowsAffected = 0;

		String insertXListSQL;
		String removeXListSQL;

		insertXListSQL = "INSERT INTO tblXRef(coursealpha,coursenum,coursealphax,coursenumx,campus,coursetype) VALUES(?,?,?,?,?,?)";
		removeXListSQL = "DELETE FROM tblXRef WHERE coursealpha=? AND coursenum=? AND coursealphax=? AND coursenumx=? AND campus=?";

		try {
			String sql = "";
			boolean nextStep = true;

			/*
			 * for add mode, don't add if already there. for remove, just
			 * proceed
			 */
			if ("a".equals(action)) {
				sql = insertXListSQL;
				if (isCourseXReffed(connection, campus, alphax, numx)) {
					nextStep = false;
				}
			} else
				sql = removeXListSQL;

			if (nextStep) {
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1, alpha);
				ps.setString(2, num);
				ps.setString(3, alphax);
				ps.setString(4, numx);
				ps.setString(5, campus);
				ps.setString(6, "PRE");
				rowsAffected = ps.executeUpdate();
				ps.close();
				AseUtil.loggerInfo("CourseDB: xListCourse ",campus,action,alpha + " " + num, alphax + " " + numx);
			}
		} catch (SQLException e) {
			logger.fatal("CourseDB: xListCourse - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: xListCourse - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * Initialize key fields for approved outline modifications <p> @return
	 * Msg
	 */
	public static Msg modifyOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												String mode) throws SQLException {

		Msg msg = new Msg();

		try{
			CourseModify cm = new CourseModify();
			msg = cm.modifyOutline(conn,campus,alpha,num,user,mode);
		}
		catch(Exception e){
			logger.fatal("CourseDB: modifyOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * Count number of course questions
	 *	<p>
	 *	@return int
	 */
	public static int countCourseQuestions(Connection conn,String campus,String include,String change,int tab) throws Exception {

		int count = 0;
		String table = "";

		try {
			if (tab == Constant.TAB_COURSE)
				table = "vw_CourseItems";
			else if (tab == Constant.TAB_CAMPUS)
				table = "vw_CampusItems";
			else if (tab == Constant.TAB_PROGRAM)
				table = "vw_programitems";

			AseUtil aseUtil = new AseUtil();
			String sql = "WHERE campus=" + aseUtil.toSQL(campus, 1) +
					" AND include=" + aseUtil.toSQL(include, 1);

			if (!change.equals(Constant.BLANK)){
				sql = sql + " AND change=" + aseUtil.toSQL(change, 1);
			}

			count = (int)AseUtil.countRecords(conn, table, sql);
		} catch (Exception e) {
			logger.fatal("CourseDB: countCourseQuestions - " + e.toString());
		}

		return count;
	}

	/*
	 * lookUpRecords
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	@param	question_friendly	String
	 *	@param	tab		int
	 *	<p>
	 *	@return String[]
	 */
	public static String[] lookUpQuestion(Connection conn,
													String campus,
													String alpha,
													String num,
													String type,
													String question_friendly,
													int tab) throws Exception {

		int count = 0;
		String table = "";
		String sql = "";
		String questionData[] = new String[2];

		try {

			if (question_friendly == null || question_friendly.length() == 0){
				questionData[0] = "";
				questionData[1] = "";
			} // question_friendly
			else{
				AseUtil aseUtil = new AseUtil();

				sql = "campus=" + aseUtil.toSQL(campus, 1) + " AND " +
						"coursealpha=" + aseUtil.toSQL(alpha, 1) + " AND " +
						"coursenum=" + aseUtil.toSQL(num, 1) + " AND " +
						"coursetype=" + aseUtil.toSQL(type, 1);

				if (tab==Constant.TAB_COURSE){
					table = "tblCourse";
					questionData = aseUtil.lookUpX(conn,table,question_friendly + ",edit" + tab, sql);
				}
				else if (tab==Constant.TAB_FORMS){
					// id is a wash. just using it to keep with the lookUpX call
					table = "tblCourse";
					questionData = aseUtil.lookUpX(conn,table,question_friendly + ",id", sql);
				}
				else{
					table = "tblCampusData";
					questionData[0] = aseUtil.lookUp(conn,table,question_friendly, sql);
					table = "tblCourse";
					questionData[1] = aseUtil.lookUp(conn,table,"edit" + tab, sql);
				}
			}// question_friendly

		} catch (Exception e) {
			logger.fatal("CourseDB: countCourseQuestions - " + e.toString());
		}

		return questionData;
	}

	/*
	 * Copy one course to another
	 *	<p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	fromAlpha	String
	 * @param	fromNum		String
	 * @param	toAlpha		String
	 * @param	toNum			String
	 * @param	user			String
	 * @param	comments		String
	 *	<p>
	 *	@return Msg
	 */
	public static Msg copyOutline(Connection conn,
											String campus,
											String fromAlpha,
											String fromNum,
											String toAlpha,
											String toNum,
											String user,
											String comments) throws Exception {

		Msg msg = new Msg();

		try{
			msg = CourseCopy.copyOutline(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,comments);
		}
		catch(Exception e){
			logger.fatal("CourseDB: copyOutline - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/*
	 * createOutline
	 *	<p>
	 * @param	conn		Connection
	 * @param	alpha		String
	 * @param	num		String
	 * @param	title		String
	 * @param	user		String
	 * @param	campus	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean createOutline(Connection conn,
													String alpha,
													String num,
													String title,
													String comments,
													String user,
													String campus) throws Exception {

		return CourseCreate.createOutline(conn,alpha,num,title,comments,user,campus);

	}

	/*
	 * Returns a list of users by campus <p> @return String
	 *	<p>
	 * @param	connection			Connection
	 * @param	selectedCampus		String
	 *	<p>
	 * @return String
	 */
	public static String getCampusUsers(Connection connection,String selectedCampus) throws Exception {

		String users = "";
		String temp;

		try {
			// default query is to get all users from a campus
			String query = "SELECT userid FROM tblUsers " + "WHERE campus = '"
					+ SQLUtil.encode(selectedCampus) + "' " + "ORDER BY userid";
			Statement statement = connection.createStatement();
			ResultSet results = statement.executeQuery(query);
			users = "<table id=\"tableGetCampusUsers\" border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>";
			temp = "";
			while (results.next()) {
				temp = results.getString(1);
				users += "<option value=\"" + temp + "\">" + temp + "</option>";
			}
			users += "</select></td></tr></table>";

			results.close();
			statement.close();
			AseUtil.loggerInfo("CourseDB: getCampusUsers ", selectedCampus,
					selectedCampus, selectedCampus, selectedCampus);
		} catch (Exception e) {
			logger.fatal("CourseDB: getCampusUsers - " + e.toString());
			users = "";
		}

		return users;
	}

	/*
	 * getCourseDates
	 *	<p>
	 * @return String[]
	 */
	public static String[] getCourseDates(Connection connection,String hid) throws SQLException {

		final int TOTALCOLUMNS = 9;
		int i = 0;
		String sql = "";
		String[] temp = new String[TOTALCOLUMNS];
		PreparedStatement ps = null;

		try {
			AseUtil aseUtil = new AseUtil();
			String[] info = Helper.getKixInfo(connection,hid);
			String alpha = info[0];
			String num = info[1];
			String type = info[2];
			String campus = info[4];
			String junk = "";
			boolean bannerExists = false;

			//
			//	when creating new, it's possible that banner does not have the alpha and number
			//
			if (BannerDB.bannerExists(connection,campus,alpha,num)){
				sql = "SELECT U.fullname,C.Progress,C.dateproposed,B.TERM_DESCRIPTION," +
					"C.reviewdate,C.assessmentdate,C.coursedate,C.auditdate,C."+Constant.COURSE_REASON+" " +
					"FROM (tblCourse C LEFT OUTER JOIN tblUsers U ON C.proposer = U.userid) " +
					"LEFT OUTER JOIN BannerTerms B ON C.effectiveterm = B.TERM_CODE " +
					"WHERE C.historyid=?";
			}
			else{
				sql = "SELECT U.fullname,C.Progress,C.dateproposed,'' AS description," +
					"C.reviewdate,C.assessmentdate,C.coursedate,C.auditdate,C."+Constant.COURSE_REASON+" " +
					"FROM (tblCourse C LEFT OUTER JOIN tblUsers U ON C.proposer = U.userid) " +
					"WHERE C.historyid=?";
			}
			ps = connection.prepareStatement(sql);
			ps.setString(1, hid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp[0] = aseUtil.nullToBlank(rs.getString(1));
				temp[1] = aseUtil.nullToBlank(rs.getString(2));

				// temp[2] = aseUtil.ASE_FormatDateTime(rs.getString(3),Constant.DATE_DATETIME);
				junk = aseUtil.nullToBlank(rs.getString("dateproposed"));
				if (junk != null && junk.length() > 0)
					temp[2] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[2] = "";

				temp[3] = aseUtil.nullToBlank(rs.getString(4));

				//temp[4] = aseUtil.ASE_FormatDateTime(rs.getString(5),Constant.DATE_DATETIME);
				junk = aseUtil.nullToBlank(rs.getString("reviewdate"));
				if (junk != null && junk.length() > 0)
					temp[4] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[4] = "";

				//temp[5] = aseUtil.ASE_FormatDateTime(rs.getString(6),Constant.DATE_DATETIME);
				junk = aseUtil.nullToBlank(rs.getString("assessmentdate"));
				if (junk != null && junk.length() > 0)
					temp[5] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[5] = "";

				//temp[6] = aseUtil.ASE_FormatDateTime(rs.getString(7),Constant.DATE_DATETIME);
				junk = aseUtil.nullToBlank(rs.getString("coursedate"));
				if (junk != null && junk.length() > 0)
					temp[6] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[6] = "";

				//temp[7] = aseUtil.ASE_FormatDateTime(rs.getString(8),Constant.DATE_DATETIME);
				junk = aseUtil.nullToBlank(rs.getString("auditdate"));
				if (junk != null && junk.length() > 0)
					temp[7] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[7] = "";

				temp[8] = aseUtil.nullToBlank(rs.getString(9));
			}
			else{
				for (i=0;i<TOTALCOLUMNS;i++)
					temp[i] = "";
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseDates - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDates - " + ex.toString());
		}

		return temp;
	}

	/*
	 * getCourseDatesByType
	 *	<p>
	 *	@param	connection	Connection
	 * @param	hid			String
	 * @param	type			String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getCourseDatesByType(Connection connection,String hid,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		final int TOTALCOLUMNS = 4;
		int i = 0;
		String sql = "";
		String junk = "";
		String table = "tblCourse";
		String[] temp = new String[TOTALCOLUMNS];

		try {
			if ("ARC".equals(type))
				table = "tblCourseARC";
			else if ("CAN".equals(type))
				table = "tblCourseCAN";

			AseUtil aseUtil = new AseUtil();

			sql = "SELECT U.fullname,C.Progress,C.auditdate,C.coursedate " +
				"FROM (" + table + " C INNER JOIN tblUsers U ON C.proposer = U.userid) " +
				"WHERE C.historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, hid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp[0] = aseUtil.nullToBlank(rs.getString("fullname"));
				temp[1] = aseUtil.nullToBlank(rs.getString("Progress"));

				junk = aseUtil.nullToBlank(rs.getString("auditdate"));
				if (junk != null && junk.length() > 0)
					temp[2] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[2] = "";

				junk = aseUtil.nullToBlank(rs.getString("coursedate"));
				if (junk != null && junk.length() > 0)
					temp[3] = aseUtil.ASE_FormatDateTime(junk,Constant.DATE_DATETIME);
				else
					temp[3] = "";
			}
			else{
				for (i=0;i<TOTALCOLUMNS;i++)
					temp[i] = "";
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseDatesByType - " + hid + " - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDatesByType - " + hid + " - " + ex.toString());
		}

		return temp;
	}

	/*
	 *
	 * getCourseDescription from Banner table since all outlines start there. If it doesn't
	 *
	 *	<p>
	 *	@param conn connection
	 *	@param kix	campus
	 *	<p>
	 *	@return String
	 */
	public static String getCourseDescription(Connection connection,String kix) {

		String descr = "";

		try {
			String[] info = Helper.getKixInfo(connection,kix);
			String campus = info[Constant.KIX_CAMPUS];
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			descr = getCourseDescriptionByType(connection,campus,alpha,num,type);
		}
		catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDescription - " + ex.toString());
		}

		return descr;
	}

	/*
	 * ttg - 2010.09.22
	 * We start with title as it is in CC and not BANNER. If not found in CC, go to BANNER
	 *
	 * getCourseDescription from Banner table since all outlines start there. If it doesn't
	 * exists, chances are it's a newly created outline that has not made to Banner.
	 *
	 *	<p>
	 *	@param conn connection
	 *	@param alpha course alpha
	 * @param num course num
	 *	@param campus campus
	 *	<p>
	 *	@return String
	 */
	public static String getCourseDescription(Connection connection,String alpha,String num,String campus) {

		String descr = "";
		String sql = "";
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			//
			// X79 is banner title. use it when coursetitle is not present
			//
			sql = "SELECT coursetitle,"+Constant.COURSE_BANNER_TITLE+" FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			rs = ps.executeQuery();
			if (rs.next()) {
				descr = AseUtil.nullToBlank(rs.getString("coursetitle"));
				if(descr == null || descr.equals(Constant.BLANK)){
					descr = AseUtil.nullToBlank(rs.getString(Constant.COURSE_BANNER_TITLE));
				}
			}
			else{
				rs.close();
				sql = "SELECT CRSE_TITLE FROM Banner WHERE INSTITUTION=? AND CRSE_ALPHA=? AND CRSE_NUMBER=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rs = ps.executeQuery();
				if (rs.next()) {
					descr = AseUtil.nullToBlank(rs.getString(1));
				}
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseDescription - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDescription - " + ex.toString());
		}

		return descr;
	}

	/*
	 * getCourseDescriptionByType 	if PRE get from tblCourse, if not, tblBanner
	 *	<p>
	 *	@param conn connection
	 *	@param campus string
	 *	@param alpha string
	 * @param num string
	 * @param type string
	 *	<p>
	 *	@return String
	 */
	public static String getCourseDescriptionByType(Connection connection,
																	String campus,
																	String alpha,
																	String num,
																	String type) {

		String descr = "";
		String sql = "";
		String table = "tblCourse";

		try {
			if (type.equals("ARC") || type.equals("PRE")){

				if (type.equals("ARC")){
					table = "tblCourseARC";
				}
				else if (type.equals("PRE")){
					table = "tblCourse";
				}

				//
				// X79 is banner title. use it when coursetitle is not present
				//
				sql = "SELECT coursetitle,"+Constant.COURSE_BANNER_TITLE+" FROM " + table + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					descr = AseUtil.nullToBlank(rs.getString("coursetitle"));
					if(descr == null || descr.equals(Constant.BLANK)){
						descr = AseUtil.nullToBlank(rs.getString(Constant.COURSE_BANNER_TITLE));
					}
				}
				rs.close();
				ps.close();
			}
			else{
				descr = getCourseDescription(connection,alpha,num,campus);
			}
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseDescriptionByType - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseDescriptionByType - " + ex.toString());
		}

		return descr;
	}

	/*
	 * getCourseDescriptionByTypePlus
	 *	<p>
	 *	@param conn connection
	 *	@param campus string
	 *	@param alpha string
	 * @param num string
	 * @param type string
	 *	<p>
	 *	@return String
	 */
	public static String getCourseDescriptionByTypePlus(Connection connection,
																	String campus,
																	String alpha,
																	String num,
																	String type) {

		return alpha + " " + num + " - " + getCourseDescriptionByType(connection,campus,alpha,num,type);

	}

	/*
	 * renameOutline checks for existence before renaming
	 *	<p>
	 *	@return boolean
	 */
	public static Msg renameOutline(Connection conn,
												String campus,
												String fromAlpha,
												String fromNum,
												String toAlpha,
												String toNum,
												String user,
												String type) throws Exception {

		Msg msg = new Msg();

		try {
			msg = CourseRename.renameOutline(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type);
		} catch (Exception e) {
			logger.fatal("CourseDB: renameOutline\n" + msg.getErrorLog());
		}

		return msg;
	}

	/*
	 * A course is cancallable only if: edit flag = true and progress = modify
	 * and canceller = proposer
	 * <p>
	 *	@param	Connection	connection
	 *	@param	String		kix
	 *	@param	String		user
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCourseCancellable(Connection connection,
															String kix,
															String user) throws SQLException {
		boolean cancellable = false;
		String proposer = "";
		String progress = "";

		try {
			String[] info = Helper.getKixInfo(connection,kix);
			String alpha = info[0];
			String num = info[1];
			String campus = info[4];

			String sql = "SELECT edit,proposer,progress FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				cancellable = results.getBoolean(1);
				proposer = results.getString(2);
				progress = results.getString(3);
			}

			// only the proposer may cancel a pending course
			if (cancellable && user.equals(proposer) &&
				(	progress.equals(Constant.COURSE_MODIFY_TEXT) ||
					progress.equals(Constant.COURSE_DELETE_TEXT) ||
					progress.equals(Constant.COURSE_REVISE_TEXT)
				)){
				cancellable = true;
			}
			else{
				cancellable = false;
			}

			results.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CourseDB: isCourseCancellable - " + e.toString());
			cancellable = false;
		}

		return cancellable;
	}

	/*
	 * A course isCourseRestorable only if there is no other course in PRE progress
	 * <p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	@param	user			String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCourseRestorable(Connection connection,String kix,String user) throws SQLException {

		boolean restorable = false;

		try {
			String[] info = Helper.getKixInfo(connection,kix);
			String alpha = info[0];
			String num = info[1];
			String campus = info[4];

			if (CourseDB.courseExistByTypeCampus(connection,campus,alpha,num,"PRE"))
				restorable = false;
			else
				restorable = true;

		} catch (SQLException e) {
			logger.fatal("CourseDB: isCourseRestorable - " + e.toString());
		}

		return restorable;
	}

	/*
	 * A course is copyable if it's in the right progress
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	toAlpha	String
	 *	@param	toNum		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isCourseCopyable(Connection conn,
													String campus,
													String toAlpha,
													String toNum) throws SQLException {
		Msg msg = new Msg();

		/*
			to copy, the following must be true

			1) user belonging to same discipline
			2) from/to alpha and number may not be the same
			3) TO outline may not be in existence at the campus
			4) FROM outline may not be going through modifications
		*/

		boolean debug = false;
		try {
			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("CourseDB - isCourseCopyable: " + campus + " - " + toAlpha + " - " + toNum);

			if (	!courseExistByTypeCampus(conn,campus,toAlpha,toNum,"PRE") &&
					!courseExistByTypeCampus(conn,campus,toAlpha,toNum,"CUR")) {
				msg.setMsg("");
			}
			else{
				msg.setMsg("NotAllowToCopyOutline");
				logger.info("CourseDB - isCourseCopyable NOT at this time: " + campus + " - " + toAlpha + " - " + toNum);
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseCopyable - " + e.toString());
		}

		return msg;
	}

	/*
	 * A course is renamable under the following conditions:
	 * <p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * @param	String		fromAlpha
	 * @param	String		fromNum
	 * @param	String		toAlpha
	 * @param	String		toNum
	 * @param	String		user
	 * <p>
	 *	@return Msg
	 */
	public static Msg isCourseRenamable(Connection conn,
													String campus,
													String fromAlpha,
													String fromNum,
													String toAlpha,
													String toNum,
													String user,
													String type) throws SQLException {
		Msg msg = new Msg();

		/*
			to rename, the following must be true

			1) from/to alpha and number may not be the same
			2) TO outline may not be going through modifications
		*/

		try {
			if (fromAlpha.equals(toAlpha) && fromNum.equals(toNum))
				msg.setMsg("InvalidRenameSelection");
			else{
				boolean exists = courseExistByType(conn,campus,toAlpha,toNum,type);
				if (exists){
					msg.setMsg("CourseModificationInProgress");
					logger.info("CourseDB: isCourseRenamable - CourseModificationInProgress");
				}
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseRenamable - " + e.toString());
		}

		return msg;
	}

	/*
	 * countSimilarOutlines - count number of similar outlines with same alpha and number
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 *	<p>
	 * @return int
	 */
	public static int countSimilarOutlines(Connection conn,String campus,String alpha,String num) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int counter = 0;

		try{
			String sql = "SELECT COUNT(historyid) AS counter "
				+ "FROM tblCourse "
				+ "WHERE campus=? "
				+ "AND coursealpha=? "
				+ "AND coursenum=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				counter = NumericUtil.nullToZero(rs.getInt("counter"));
			}
			rs.close();
			ps.close();
		}catch(SQLException se){
			logger.fatal("CourseDB - countSimilarOutlines - " + se.toString());
		}catch(Exception e){
			logger.fatal("CourseDB - countSimilarOutlines - " + e.toString());
		}

		return counter;
	}

	/*
	 * setCourseProgress
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	progress	String
	 *	@param	user					String
	 * <p>
	 * @return int
	 */
	public static int setCourseProgress(Connection conn,String kix,String progress,String user) {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET progress=?,proposer=?,auditdate=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,progress);
			ps.setString(2,user);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: setCourseProgress (" + user + ") - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: setCourseProgress (" + user + ") - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * setCourseForDelete
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 *	@param	user		String
	 * <p>
	 * @return Msg
	 */
	public static Msg setCourseForDelete(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String[] info = Helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];
		String proposer = info[3];
		String campus = info[4];
		int route = NumericUtil.nullToZero(info[6]);

		/*
			there can only be a single outline and it has to be in APPROVED status before deleting.
			if OK to delete,
				1) use code from modifyOutlineAccess to place outline in PRE status
				2) obtain the KIX of the outline just placed in modify status
				3) create task
				4) set progress to DELETE
		*/
		if (CourseDB.countSimilarOutlines(conn,campus,alpha,num)>1){
			msg.setMsg("NotAllowToDelete");
			logger.info("CourseDB: setCourseForDelete - Attempting to delete outline failed (" + user + ").");
		}
		else{
			msg = CourseModify.modifyOutlineX(conn,campus,alpha,num,user,"");
			if (!"Exception".equals(msg.getMsg())){
				logger.info("no error");
				kix = Helper.getKix(conn,campus,alpha,num,"PRE");
				setCourseProgress(conn,kix,Constant.COURSE_DELETE_TEXT,user);
				int rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.DELETE_TEXT,campus,"","ADD","PRE");
			}
		}

		return msg;
	}

	/*
	 * adjustCourseForDelete
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @param	int
	 */
	public static int adjustCourseForDelete(Connection conn,String campus,String kix,String alpha,String num) throws Exception {

		// Logger logger = Logger.getLogger("test");

		// during delete as packets, data for delete adjusted so it flows through the
		// packet approval with division chairs. once the chair approval the delete requests,
		// coursedb resets data so it is set on track as a delete again
		// approval as packets works fine. it's delete requires adjust so it flows through the
		// approval process

		int rowsAffected = 0;

		try{
			String sql = "UPDATE tblcourse SET progress=?,Subprogress=?,coursetype='PRE' WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Constant.COURSE_APPROVAL_PENDING_TEXT);
			ps.setString(2,Constant.COURSE_DELETE_TEXT);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if(rowsAffected > 0){
				sql = "UPDATE tbltasks SET coursetype='PRE' WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("CourseDB: adjustCourseForDelete - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: adjustCourseForDelete - " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * isCourseDeleteCancellable
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isCourseDeleteCancellable(Connection conn,
																		String campus,
																		String alpha,
																		String num,
																		String user){
		// Logger logger = Logger.getLogger("test");

		/*
			cancelling an outline takes the following steps

			1) Is the outline in DELETE status
			2) Is this the proposer
			3) If cancel anytime is true or not history yet
		*/

		int rowsAffected = 0;
		Msg msg = new Msg();
		boolean courseDeleteCancellable = false;
		boolean cancelApprovalAnyTime = false;
		boolean approvalStarted = false;
		String proposer = "";

		try{
			if ((Constant.COURSE_DELETE_TEXT).equals(getCourseProgress(conn,campus,alpha,num,"PRE")) ){
				proposer = getCourseProposer(conn,campus,alpha,num,"PRE");
				if (proposer.equals(user)){
					String temp = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelApprovalAnyTime");
					if ("1".equals(temp))
						cancelApprovalAnyTime = true;

					approvalStarted = HistoryDB.approvalStarted(conn,campus,alpha,num,user);

					if (cancelApprovalAnyTime || !approvalStarted){
						msg.setResult(true);
					}
					else{
						msg.setMsg("OutlineApprovalStarted");
					} // history
				}	// proposer
				else{
					msg.setMsg("OutlineProposerCanCancel");
				}	// proposer
			} // approval
			else{
				msg.setMsg("OutlineNotInDeleteStatus");
			}	// approval
		} catch (SQLException ex) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: isCourseDeleteCancellable - " + ex.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: isCourseDeleteCancellable - " + e.toString());
		}

		return msg;
	}

	/*
	 * setCourseEdit1
	 *	<p>
	 *	@return int
	 */
	public static int setCourseEdit1(Connection connection,
												String campus,
												String alpha,
												String num,
												String type,
												String edits) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET edit=1,edit1=? WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,edits);
			ps.setString(2,campus);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: setCourseEdit1 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: setCourseEdit1 - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * setCourseEdit2
	 *	<p>
	 *	@return int
	 */
	public static int setCourseEdit2(Connection connection,
												String campus,
												String alpha,
												String num,
												String type,
												String edits) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET edit=1,edit2=? WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,edits);
			ps.setString(2,campus);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: setCourseEdit2 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: setCourseEdit2 - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getCourseEdit
	 *	<p>
	 *	@return int
	 */
	public static int getCourseEdit(Connection connection,
												String campus,
												String alpha,
												String num,
												String type) throws SQLException {

		int edit = 0;

		try {
			String sql = "SELECT edit FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = NumericUtil.nullToZero(rs.getInt(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseEdit - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseEdit - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getCourseEdit0
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEdit0(Connection connection,
												String campus,
												String alpha,
												String num,
												String type) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit1 FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseEdit0 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseEdit0 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getCourseEdit1
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEdit1(Connection connection,
												String campus,
												String alpha,
												String num,
												String type) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit1 FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseEdit1 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseEdit1 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getCourseEdit2
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEdit2(Connection connection,
												String campus,
												String alpha,
												String num,
												String type) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit2 FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseEdit2 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseEdit2 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * resetOutlineToApproval
	 *	<p>
	 *	@return int
	 */
	public static int resetOutlineToApproval(Connection conn,String campus,String alpha,String num) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET edit1=3,edit2=3,subprogress='' "
							+ "WHERE campus=? "
							+ "AND courseAlpha=? "
							+ "AND coursenum=? "
							+ "AND coursetype='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: resetOutlineToApproval - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: resetOutlineToApproval - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateCourseItem
	 *	<p>
	 *	@return int
	 */
	public static int updateCourseItem(Connection conn,String courseItem,String data,String kix) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCourse SET "+courseItem+"=? WHERE historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,data);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: updateCourseItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: updateCourseItem - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * methodEvaluation
	 *	<p>
	 *	remove double commas from methodEvaluation. If nothing is left, place a 0 in it to prevent SQL error
	 *	<p>
	 * @param	str	String
	 *	<p>
	 * @return	String
	 */
	public static String methodEvaluationSQL(String temp) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {

			// methodEvaluationSQL is used for SQL IN clause and if this
			// is cleaned of all commas and nothing is left, put a 0 to avoid sql error.
			if (temp != null && temp.indexOf(",,") > -1){

				temp = com.ase.aseutil.util.CCUtil.removeDoubleCommas(temp);

				if (temp != null && temp.length() == 0){
					temp = "0";
				}

			}

		} catch (Exception e) {
			logger.fatal("methodEvaluationSQL - " + e.toString());
		}

		return temp;

	} // removeDoubleCommas

	/*
	 * getCourseItemBySeq - returns the course data column given the seq
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	seq		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseItemBySeq(Connection conn,String campus,String kix,int seq) throws SQLException {

		String courseItem = "";

		try {
			String sql = "SELECT CCCM6100.Question_Friendly "
				+ "FROM tblCourseQuestions INNER JOIN "
				+ "CCCM6100 ON tblCourseQuestions.questionnumber = CCCM6100.Question_Number "
				+ "WHERE tblCourseQuestions.campus=? "
				+ "AND tblCourseQuestions.questionseq > 0 "
				+ "AND tblCourseQuestions.include = 'Y' "
				+ "AND CCCM6100.campus = 'Sys' "
				+ "AND CCCM6100.type = 'Course' "
				+ "AND tblCourseQuestions.questionseq=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){

				courseItem = AseUtil.nullToBlank(rs.getString("Question_Friendly"));

				if (courseItem != null && courseItem.length() > 0){

					rs.close();
					ps.close();

					sql = "SELECT " + courseItem + " FROM tblCourse WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					if (rs.next()){
						courseItem = AseUtil.nullToBlank(rs.getString(courseItem));
					} // found the data

				} // valid column

			} // found the column we are looking for
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getCourseItemBySeq - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: getCourseItemBySeq - " + ex.toString());
		}

		return courseItem;
	}

	/*
	 * isMatchARC - does this historyid exists in ARC
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	<p>
	 * @return boolean
	 */
	public static boolean isMatchARC(Connection conn,String kix) throws SQLException {
		String sql = "SELECT id FROM tblCourseARC WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * updateCampusItem
	 *	<p>
	 *	@return int
	 */
	public static int updateCampusItem(Connection conn,String campusItem,String data,String kix) throws SQLException {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblCampusdata SET "+campusItem+"=? WHERE historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,data);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: updateCampusItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CourseDB: updateCampusItem - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * Count number of question on course and campus tabs
	 *	<p>
	 *	@return int
	 */
	public static int totalQuestionsUsed(Connection conn,String campus) throws Exception {

		int total = 0;

		try {

			int courseCount = countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
			int campusCount = countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);

			total = courseCount + campusCount;

		} catch (Exception e) {
			logger.fatal("CourseDB: totalQuestionsUsed - " + e.toString());
		}

		return total;
	}


	/*
	 * decline outline packet approval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	user		String
	 * @param	proposer	String
	 * @param	content	String
	 * @param	subject	String
	 * <p>
	 * @return int
	 */
	public static int declineOutlinePacketApproval(Connection conn,
																	String campus,
																	String alpha,
																	String num,
																	String user,
																	String proposer,
																	String content,
																	String subject) throws Exception {
		int rowsAffected  = 0;

		try{
			// reset course for modification
			String sql = "UPDATE tblCourse SET progress=?,edit=1 WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Constant.COURSE_MODIFY_TEXT);
			ps.setString(2,campus);
			ps.setString(3,alpha);
			ps.setString(4,num);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if(rowsAffected > 0){

				// let proposer know the approval request was declined
				Mailer mailer = new Mailer();
				mailer.setCampus(campus);
				mailer.setAlpha(alpha);
				mailer.setNum(num);
				mailer.setFrom(user);
				mailer.setTo(proposer);
				mailer.setContent(content);
				mailer.setSubject(subject);
				mailer.setPersonalizedMail(true);
				MailerDB mailerDB = new MailerDB(conn,mailer);
				mailerDB = null;

				// recreate a task for the proposer
				rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,Constant.MODIFY_TEXT,campus,"","ADD","PRE");
			}

		}
		catch (SQLException e) {
			logger.fatal("CourseDB: declineOutlinePacketApproval - " + e.toString());
		}
		catch (Exception e) {
			logger.fatal("CourseDB: declineOutlinePacketApproval - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getCourseDate - returns course date based on type
	 * <p>
	 * @param	cnn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 */
	public static String getCourseDate(Connection conn,String campus,String kix,String type){

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		String courseDate = "";

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
				sql = "SELECT coursedate FROM "+table+" WHERE campus=? AND historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					AseUtil aseUtil = new AseUtil();
					courseDate = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_SHORT);
					aseUtil = null;
				}
				rs.close();
				ps.close();
			} // valid table and type

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return courseDate;
	}

	/**
	 * getCourseTableFromKix - returns table to use when given kix
	 * <p>
	 * @param	cnn		Connection
	 * @param	kix		String
	 * <p>
	 */
	public static String getCourseTableFromKix(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		String table = "tblcourse";

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			String type = info[Constant.KIX_TYPE];
			if(type.toLowerCase().equals("arc")){
				table = "tblcoursearc";
			}
			else if(type.toLowerCase().equals("can")){
				table = "tblcoursecan";
			}
		}
		catch(Exception e){
			logger.fatal("CourseDB.getCourseTableFromKix ("+kix+"): " + e.toString());
		}

		return table;
	}

	/*
	 * getArchivedCourseItem
	 *	<p>
	 *	@return String
	 */
	public static String getArchivedCourseItem(Connection conn,String campus,String alpha,String num,String term,String column){

		//Logger logger = Logger.getLogger("test");

		String courseItem = "";

		try {
			String sql = "SELECT " + column + " FROM tblcoursearc WHERE campus=? AND coursealpha=? and coursenum=? and effectiveterm=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,term);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				courseItem = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseDB: getArchivedCourseItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: getArchivedCourseItem - " + e.toString());
		}

		return courseItem;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}