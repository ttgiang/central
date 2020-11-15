/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 *	public static String getExtraAsHTMLList(Connection conn,String kix,String src)
 *	public static int getNextExtraNumber(Connection conn)
 *	public static int getNextRDR(Connection connection,String kix,String src) throws SQLException {
 *
 * void close () throws SQLException{}
 *
 */

//
// MiscDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.log4j.Logger;

public class MiscDB {
	static Logger logger = Logger.getLogger(MiscDB.class.getName());

	public MiscDB() throws Exception {}

	/**
	 * security isMatch
	 */
	public static boolean isMatch(Connection conn,String kix,String descr) throws SQLException {
		String sql = "SELECT id FROM tblMisc WHERE historyid=? AND descr=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ps.setString(2,descr);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * insertMisc
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	descr 	String
	 * @param	val		String
	 * @param	user		String
	 * <p>
	 * @return int
	 */
	public static int insertMisc(Connection conn,
										String campus,
										String kix,
										String alpha,
										String num,
										String type,
										String descr,
										String val) throws SQLException {

		String edit1 = getProgramEdit1(conn,kix);
		String edit2 = getProgramEdit2(conn,kix);

		return insertMisc(conn,campus,kix,alpha,num,type,descr,val,"",edit1,edit2);
	}

	public static int insertMisc(Connection conn,
										String campus,
										String kix,
										String alpha,
										String num,
										String type,
										String descr,
										String val,
										String user) throws SQLException {


		String edit1 = getProgramEdit1(conn,kix);
		String edit2 = getProgramEdit2(conn,kix);

		return insertMisc(conn,campus,kix,alpha,num,type,descr,val,user,edit1,edit2);
	}

	public static int insertMisc(Connection conn,
										String campus,
										String kix,
										String alpha,
										String num,
										String type,
										String descr,
										String val,
										String user,
										String edit1,
										String edit2) throws SQLException {

		int rowsAffected = 0;

		try{
			PreparedStatement ps;
			String sql = "";

			//
			// edited1 and 2 are only set once. Do not update
			//

			if (isMatch(conn,kix,descr)){
				sql = "UPDATE tblMisc "
					+ "SET historyid=?,val=?,userid=?,auditdate=?,edit1=?,edit2=? "
					+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,val);
				ps.setString(3,user);
				ps.setString(4,AseUtil.getCurrentDateTimeString());
				ps.setString(5,edit1);
				ps.setString(6,edit2);
				ps.setString(7,kix);
				rowsAffected = ps.executeUpdate();
			}
			else{
				sql = "INSERT INTO tblMisc(campus,historyid,coursealpha,coursenum,coursetype,descr,val,userid,auditdate,edit1,edit2,edited1,edited2) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,alpha);
				ps.setString(4,num);
				ps.setString(5,type);
				ps.setString(6,descr);
				ps.setString(7,val);
				ps.setString(8,user);
				ps.setString(9,AseUtil.getCurrentDateTimeString());
				ps.setString(10,edit1);
				ps.setString(11,edit2);
				ps.setString(12,edit1);
				ps.setString(13,edit2);
				rowsAffected = ps.executeUpdate();
			}
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("MiscDB: insertMisc - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("MiscDB: insertMisc - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getMisc
	 * <p>
	 * @param conn		Connection
	 * @param user		String
	 * <p>
	 * @return String
	 */
	public static Misc getMisc(Connection conn,String userid) {

		String sql = "SELECT * FROM tblMisc WHERE userid=?";
		Misc misc = null;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,userid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				misc = new Misc();
				misc.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				misc.setHistoryId(AseUtil.nullToBlank(rs.getString("historyId")));
				misc.setCourseAlpha(AseUtil.nullToBlank(rs.getString("courseAlpha")));
				misc.setCourseNum(AseUtil.nullToBlank(rs.getString("courseNum")));
				misc.setCourseType(AseUtil.nullToBlank(rs.getString("courseType")));
				misc.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
				misc.setVal(AseUtil.nullToBlank(rs.getString("val")));
				misc.setUserId(AseUtil.nullToBlank(userid));
				misc.setEdited1(AseUtil.nullToBlank(rs.getString("edited1")));
				misc.setEdited2(AseUtil.nullToBlank(rs.getString("edited2")));
			}

			rs.close();
			rs = null;

			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: getMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getMisc - " + e.toString());
		}

		return misc;
	}

	/**
	 * getReviewMisc
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * <p>
	 * @return String
	 */
	public static String getReviewMisc(Connection conn,String kix) {

		String sql = "SELECT val from tblMisc WHERE historyid=? AND descr=?";
		String temp = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,"REVIEW");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp = AseUtil.nullToBlank(rs.getString("val"));
			}

			rs.close();
			rs = null;
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: getReviewMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getReviewMisc - " + e.toString());
		}

		return temp;
	}

	/**
	 * deleteMisc
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * <p>
	 * @return int
	 */
	public static int deleteMisc(Connection conn,String kix) {

		String sql = "DELETE FROM tblMisc WHERE historyid=?";

		int rowsAffected = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteMisc - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteReviewMisc
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * <p>
	 * @return int
	 */
	public static int deleteReviewMisc(Connection conn,String kix) {

		String sql = "DELETE FROM tblMisc WHERE historyid=? AND descr=?";

		int rowsAffected = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,"REVIEW");
			rowsAffected = ps.executeUpdate();
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteReviewMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteReviewMisc - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteStickyMisc
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * <p>
	 * @return int
	 */
	public static int deleteStickyMisc(Connection conn,String kix) {

		String sql = "DELETE FROM tblMisc WHERE historyid=? AND descr=?";

		int rowsAffected = 0;

		try {
			if (kix != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,"STICKY");
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps= null;
			}
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteStickyMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteStickyMisc - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteStickyMisc
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * <p>
	 * @return int
	 */
	public static int deleteStickyMisc(Connection conn,String kix,String user) {

		String sql = "DELETE FROM tblMisc WHERE historyid=? AND descr=? AND userid=?";

		int rowsAffected = 0;

		try {
			if (kix != null && user != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,"STICKY");
				ps.setString(3,user);
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps= null;
			}
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteStickyMisc - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteStickyMisc - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertSitckyNotes
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param user		String
	 * @param val		String
	 * <p>
	 * @return int
	 */
	public static int insertSitckyNotes(Connection conn,String kix,String user,String val) {

		int rowsAffected = 0;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String campus = info[Constant.KIX_CAMPUS];

			String sql = "INSERT INTO tblMisc(campus,historyid,coursealpha,coursenum,coursetype,descr,val,userid,auditdate) VALUES(?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			ps.setString(6,"STICKY");
			ps.setString(7,val);
			ps.setString(8,user);
			ps.setString(9,AseUtil.getCurrentDateTimeString());
			rowsAffected = ps.executeUpdate();
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: insertSitckyNotes - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: insertSitckyNotes - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getStickyNotes
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param user		String
	 * <p>
	 * @return String
	 */
	public static String getStickyNotes(Connection conn,String kix,String user) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		boolean found = false;

		try {
			if (kix != null && user != null){
				String sql = "SELECT val FROM tblMisc WHERE historyid=? AND descr=? AND userid=? ORDER BY id";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setString(2,"STICKY");
				ps.setString(3,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					buf.append(AseUtil.nullToBlank(rs.getString("val")));
					found = true;
				}
				rs.close();
				rs = null;
				ps.close();
				ps= null;
			}
		} catch (SQLException se) {
			logger.fatal("MiscDB: getStickyNotes - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getStickyNotes - " + e.toString());
		}

		if (found)
			temp = "<div id=\"mystickytooltip\" class=\"stickytooltip\">"
				+ "<div style=\"padding:5px\">"
				+ buf.toString()
				+ "</div>"
				+ "<div class=\"stickystatus\"></div>"
				+ "</div>";

		return temp;
	}

	/**
	 * getMiscByHistoryUserID
	 * <p>
	 * @param conn			Connection
	 * @param campus		String
	 * @param historyid	String
	 * @param userid		String
	 * <p>
	 * @return String
	 */
	public static Misc getMiscByHistoryUserID(Connection conn,String campus,String historyid,String userid) {

		String sql = "SELECT * FROM tblMisc WHERE campus=? AND historyid=? AND userid=?";

		Misc misc = null;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,historyid);
			ps.setString(3,userid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				misc = new Misc();
				misc.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				misc.setHistoryId(AseUtil.nullToBlank(rs.getString("historyId")));
				misc.setCourseAlpha(AseUtil.nullToBlank(rs.getString("courseAlpha")));
				misc.setCourseNum(AseUtil.nullToBlank(rs.getString("courseNum")));
				misc.setCourseType(AseUtil.nullToBlank(rs.getString("courseType")));
				misc.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
				misc.setVal(AseUtil.nullToBlank(rs.getString("val")));
				misc.setUserId(AseUtil.nullToBlank(userid));
			}

			rs.close();
			rs = null;

			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: getMiscByHistoryUserID - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getMiscByHistoryUserID - " + e.toString());
		}

		return misc;
	}

	/*
	 * getEdit1
	 *	<p>
	 *	@return String
	 */
	public static String getEdit1(Connection conn,String kix) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit1 FROM tblMisc WHERE historyid=? AND descr='Outline Modification'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("MiscDB: getEdit1 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("MiscDB: getEdit1 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getEdit2
	 *	<p>
	 *	@return String
	 */
	public static String getEdit2(Connection conn,String kix) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit2 FROM tblMisc WHERE historyid=? AND descr='Outline Modification'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("MiscDB: getEdit2 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("MiscDB: getEdit2 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getEnabledItems - returns hashmap of enabled items (outlines only)
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	tab	int
	 *	<p>
	 *	@return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap getEnabledItems(Connection conn,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// replaces version used by QuestionDB.enabledEditItems because
		// values are stored with MiscDB

		HashMap hashMap = null;

		try {
			String items = "";

			// place enabled items in hashmap for use
			if (tab == 1){
				items = getEdit1(conn,kix);
			}
			else{
				items = getEdit2(conn,kix);
			}

			// when there is a comma, we are in enabled mode.
			if (items != null && items.length() > 0){
				hashMap = new HashMap();
				String[] aitems = items.split(",");
				for(int z=0;z<aitems.length;z++){
					if (!aitems[z].equals("0"))
						hashMap.put(aitems[z],new String(aitems[z]));
				}
			}
		} catch (SQLException ex) {
			logger.fatal("MiscDB: getEnabledItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getEnabledItems - " + e.toString());
		}

		return hashMap;
	}

	/*
	 * getEnabledEditedItems - returns hashmap of enabled items and edited items (outlines only)
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	tab	int
	 *	<p>
	 *	@return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap getEnabledEditedItems(Connection conn,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// replaces version used by QuestionDB.enabledEditItems because
		// values are stored with MiscDB

		//
		// DF00107 - created edited1 and edited2 to preserve orginal selections
		//

		HashMap hashMap = null;

		try {
			String items = "";
			String edited = "";

			// place enabled items in hashmap for use
			if (tab == 1){
				items = getEdit1(conn,kix);
				edited = getColumn(conn,kix,"edited1");
			}
			else{
				items = getEdit2(conn,kix);
				edited = getColumn(conn,kix,"edited2");
			}

			// when there is a comma, we are in enabled mode.
			if (items != null && items.length() > 0){

				if (edited != null && edited.length() > 0){
					items = items + "," + edited;
				}

				hashMap = new HashMap();
				String[] aitems = items.split(",");
				for(int z=0;z<aitems.length;z++){
					if (!aitems[z].equals("0"))
						hashMap.put(aitems[z],new String(aitems[z]));
				}
			}
		} catch (SQLException ex) {
			logger.fatal("MiscDB: getEnabledEditedItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getEnabledEditedItems - " + e.toString());
		}

		return hashMap;
	}

	/*
	 * getEnabledItemsCSV - returns hashmap of enabled items
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	tab	int
	 *	<p>
	 *	@return String
	 */
	public static String getEnabledItemsCSV(Connection conn,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// replaces version used by QuestionDB.enabledEditItems because
		// values are stored with MiscDB

		String enabledItems = "";

		try {
			String items = "";

			if (tab == 1)
				items = getEdit1(conn,kix);
			else
				items = getEdit2(conn,kix);

			// when there is a comma, we are in enabled mode.
			if (items != null && items.length() > 0){
				String[] aitems = items.split(",");
				for(int z=0;z<aitems.length;z++){
					if (!aitems[z].equals("0")){

						if (enabledItems.equals("")){
							enabledItems = aitems[z];
						}
						else{
							enabledItems = enabledItems + "," + aitems[z];
						}

					} // if not 0
				}
			}
		} catch (SQLException ex) {
			logger.fatal("MiscDB: getEnabledItemsCSV - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getEnabledItemsCSV - " + e.toString());
		}

		return enabledItems;
	}

	/*
	 * getCourseEditFromMiscEdit
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	tab		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEditFromMiscEdit(Connection conn,String campus,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String courseItems = "";

		try {
			int columnCount = 0;
			StringBuffer items = new StringBuffer();
			int[] qnItems = null;
			HashMap hashMap = null;

			if(tab==Constant.TAB_COURSE){
				qnItems = QuestionDB.getCourseEditableItems(conn,campus);
				hashMap = MiscDB.getEnabledItems(conn,kix,Constant.TAB_COURSE);
				columnCount = 0;
			}
			else{
				qnItems = QuestionDB.getCampusEditableItems(conn,campus);
				hashMap = MiscDB.getEnabledItems(conn,kix,Constant.TAB_CAMPUS);
				columnCount = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);;
			}

			// rescontruct editable items for course
			if (hashMap != null && qnItems != null){

				for(int i = 0; i < qnItems.length ; i++){

					if(hashMap.containsValue(""+(i+columnCount+1))){
						items.append(qnItems[i]+",");
					}
					else{
						items.append("0,");
					} // hashmap

				} // for

			} // not null

			// process and remove last comma
			courseItems = items.toString();
			if (courseItems.endsWith(",")){
				courseItems = courseItems.substring(0,courseItems.length()-1);
			}

		} catch (SQLException ex) {
			logger.fatal("MiscDB: getCourseEditFromMiscEdit - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getCourseEditFromMiscEdit - " + e.toString());
		}

		return courseItems;
	}

	/*
	 * getCourseEditFlags
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	tab		int
	 *	<p>
	 *	@return String
	 */
	public static String getCourseEditFlags(Connection conn,String campus,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String items = "";

		try {
			// restore edit flags after review completes. data stored in misc edit1/edit2
			// edit1 and 2 contains values in CSV and is based on correct sequence numbering
			// edit1 and 2 in course contains CSV but by question numbering based on CM6100

			items = getCourseEditFromMiscEdit(conn,campus,kix,tab);
			if(items.equals(Constant.BLANK)){
				items = "1";
			}

		} catch (SQLException ex) {
			logger.fatal("MiscDB: getCourseEditFlags - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getCourseEditFlags - " + e.toString());
		}

		return items;
	}

	/*
	 * getProgramEdit1
	 *	<p>
	 *	@return String
	 */
	public static String getProgramEdit1(Connection conn,String kix) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit1 FROM tblMisc WHERE historyid=? AND descr='Program Modification'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("MiscDB: getProgramEdit1 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("MiscDB: getProgramEdit1 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getProgramEdit2
	 *	<p>
	 *	@return String
	 */
	public static String getProgramEdit2(Connection conn,String kix) throws SQLException {

		String edit = "";

		try {
			String sql = "SELECT edit2 FROM tblMisc WHERE historyid=? AND descr='Program Modification'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				edit = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("MiscDB: getProgramEdit2 - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("MiscDB: getProgramEdit2 - " + ex.toString());
		}

		return edit;
	}

	/*
	 * getProgramEnabledItems - returns hashmap of enabled items (outlines only)
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	tab	int
	 *	<p>
	 *	@return HashMap
	 */
	@SuppressWarnings("unchecked")
	public static HashMap getProgramEnabledItems(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// replaces version used by QuestionDB.enabledEditItems because
		// values are stored with MiscDB

		HashMap hashMap = null;

		try {
			String items = items = getProgramEdit1(conn,kix);

			// when there is a comma, we are in enabled mode.
			if (items != null && items.length() > 0){
				hashMap = new HashMap();
				String[] aitems = items.split(",");
				for(int z=0;z<aitems.length;z++){
					if (!aitems[z].equals("0"))
						hashMap.put(aitems[z],new String(aitems[z]));
				}
			}
		} catch (SQLException ex) {
			logger.fatal("MiscDB: getProgramEnabledItems - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getProgramEnabledItems - " + e.toString());
		}

		return hashMap;
	}

	/*
	 * getProgramEditFromMiscEdit
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	tab		int
	 *	<p>
	 *	@return String
	 */
	public static String getProgramEditFromMiscEdit(Connection conn,String campus,String kix,int tab) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String programItems = "";

		try {

			if(tab==1){
				programItems = getProgramEdit1(conn,kix);
			}
			else{
				programItems = getProgramEdit2(conn,kix);;
			}


		} catch (Exception e) {
			logger.fatal("MiscDB: getProgramEditFromMiscEdit - " + e.toString());
		}

		return programItems;
	}

	/**
	 * getMiscNote
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param descr	String
	 * <p>
	 * @return String
	 */
	public static String getMiscNote(Connection conn,String kix,String descr) {

		String sql = "SELECT val from tblMisc WHERE historyid=? AND descr=?";
		String temp = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,descr);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp = AseUtil.nullToBlank(rs.getString("val"));
			}

			rs.close();
			rs = null;
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: getMiscNote - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getMiscNote - " + e.toString());
		}

		return temp;
	}

	/**
	 * getMiscNote
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param alpha	String
	 * @param num		String
	 * @param type		String
	 * @param descr	String
	 * <p>
	 * @return String
	 */
	public static String getMiscNote(Connection conn,String campus,String alpha,String num,String type,String descr) {

		String sql = "SELECT val from tblMisc WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND descr=?";
		String temp = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ps.setString(5,descr);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				temp = AseUtil.nullToBlank(rs.getString("val"));
			}

			rs.close();
			rs = null;
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: getMiscNote - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: getMiscNote - " + e.toString());
		}

		return temp;
	}

	/**
	 * deleteMiscNote
	 * <p>
	 * @param conn		Connection
	 * @param kix		String
	 * @param descr	String
	 * <p>
	 * @return int
	 */
	public static int deleteMiscNote(Connection conn,String kix,String descr) {

		String sql = "DELETE FROM tblMisc WHERE historyid=? AND descr=?";

		int rowsAffected = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,descr);
			rowsAffected = ps.executeUpdate();
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteMiscNote - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteMiscNote - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteMiscNote
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param alpha	String
	 * @param num		String
	 * @param type		String
	 * @param descr	String
	 * <p>
	 * @return int
	 */
	public static int deleteMiscNote(Connection conn,String campus,String alpha,String num,String type,String descr) {

		String sql = "DELETE FROM tblMisc WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND descr=?";

		int rowsAffected = 0;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ps.setString(5,descr);
			rowsAffected = ps.executeUpdate();
			ps.close();
			ps= null;
		} catch (SQLException se) {
			logger.fatal("MiscDB: deleteMiscNote - " + se.toString());
		} catch (Exception e) {
			logger.fatal("MiscDB: deleteMiscNote - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getColumn
	 *	<p>
	 *	@return String
	 */
	public static String getColumn(Connection conn,String kix,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String columnData = "";

		try {
			String sql = "SELECT "+column+" FROM tblMisc WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				columnData = AseUtil.nullToBlank(rs.getString(column));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("MiscDB: getColumn - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("MiscDB: getColumn - " + ex.toString());
		}

		return columnData;
	}


	/**
	 * close
	 */
	public void close() throws SQLException {}

}