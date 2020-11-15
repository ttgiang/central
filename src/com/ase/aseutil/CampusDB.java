/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * public static boolean courseExistByCampus(Connection connection,String campus,String alpha,String num)
 * public static boolean courseExistByCampus(Connection connection,String campus,String alpha,String num,String type)
 * public static String getCampusName(Connection conn, String campus)
 *	public static String getCampusNameOkina(Connection conn,String campus)
 * public static String getCampusNames(Connection conn)
 * public static String getFaculties(Connection conn,String campus,String user)
 *	public static int getNextCampusDataID(Connection conn) throws SQLException {
 *	public static int removeCampusOutline(Connection conn,long id) throws SQLException {
 *	public static void updateCampusOutline(Connection conn,String kix,String campus) throws SQLException {
 *
 * @author ttgiang
 */

//
// CampusDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CampusDB {

	static Logger logger = Logger.getLogger(CampusDB.class.getName());

	public CampusDB() throws Exception {}

	/*
	 * getCampusName
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public static String getCampusName(Connection conn, String campus) throws Exception {

		String campusName = "";
		String sql = "SELECT campusdescr FROM tblCampus WHERE campus=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				campusName = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CampusDB: getCampusName\n" + e.toString());
		}

		return campusName;
	}

	/*
	 * getCampusNameOkina
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public static String getCampusNameOkina(Connection conn,String campus) throws Exception {

		String campusName = getCampusName(conn,campus);

		if (campusName.indexOf("Kapiolani")>-1)
			campusName = campusName.replace("Kapiolani","Kapi\'olani");

		return campusName;
	}

	/*
	 * getCampusNames
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return String
	 */
	public static String getCampusNames(Connection conn){

		String campus = "";
		int i = 0;

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT campus FROM tblCampus WHERE (campus<>'TTG' AND campus<>'') ORDER BY campus";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				if (i++==0)
					campus = aseUtil.nullToBlank(rs.getString("campus")).trim();
				else
					campus = campus + "," + aseUtil.nullToBlank(rs.getString("campus")).trim();
			}
			rs.close();
			ps.close();
		}
		catch( SQLException e ){
			logger.fatal("CampusDB: getCampusNames\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("CampusDB: getCampusNames\n" + ex.toString());
		}

		return campus;
	}

	/*
	 * Returns true if the course exists in a particular type and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return boolean
	 */
	public static boolean courseExistByCampus(Connection connection,
																String campus,
																String alpha,
																String num,
																String type) throws SQLException {

		boolean courseType = false;

		try {
			String sql = "SELECT coursetype FROM tblCampusData WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
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
			logger.fatal("CampusDB: courseExistByCampus\n" + e.toString());
		}

		return courseType;
	}

	/*
	 * Returns true if the course exists in a particular campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return boolean
	 */
	public static boolean courseExistByCampus(Connection connection,
																String campus,
																String alpha,
																String num) throws SQLException {

		boolean courseType = false;

		try {
			String sql = "SELECT coursetype FROM tblCampusData WHERE campus=? AND courseAlpha=? AND coursenum=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			courseType = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: courseExistByCampus\n" + e.toString());
		}

		return courseType;
	}

	/*
	 * getFaculties
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return String
	 */
	public static String getFaculties(Connection conn,String campus,String user){

		StringBuffer faculties = new StringBuffer();
		String userid = "";
		String sql = "";

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT userid "
				+ "FROM tblUsers "
				+ "WHERE campus=? ";

			if (!"".equals(user))
				sql = sql + "AND userid<>? ";

			sql = sql + "ORDER BY userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);

			if (!"".equals(user))
				ps.setString(2,user);

			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				userid = aseUtil.nullToBlank(rs.getString("userid")).trim();
				faculties.append("<option value=\""+userid+"\">"+userid+"</option>");
			}
			rs.close();
			ps.close();
		}
		catch( SQLException e ){
			logger.fatal("CampusDB: getFaculties\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("CampusDB: getFaculties\n" + ex.toString());
		}

		String temp = "<select name=\"approver\" class=\"smalltext\">"
			+ "<option value=\"\"></option>"
			+ faculties.toString()
			+ "</select>";

		return temp;
	}

	/*
	 * getNextCampusDataID
	 *	<p>
	 *	@param	conn	Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextCampusDataID(Connection conn) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid "
				+ " FROM tblCampusdata ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid");
			}

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: getNextCampusDataID - " + e.toString());
		}

		return id;
	}

	/*
	 * getCampusItem
	 *	<p>
	 *	@return String
	 */
	public static String getCampusItem(Connection conn,String kix,String column) throws SQLException {

		String campusItem = "";

		try {
			String sql = "SELECT " + column + " FROM tblCampusData WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				campusItem = AseUtil.nullToBlank(rs.getString(column));
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: getCampusItem - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: getCampusItem - " + ex.toString());
		}

		return campusItem;
	}

	/*
	 * getCampusItems
	 *	<p>
	 *	@return String
	 */
	public static String getCampusItems(Connection conn,String campus) throws SQLException {

		String items = "";

		try {
			String sql = "SELECT campusitems FROM tblCampus WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				items = AseUtil.nullToBlank(rs.getString("campusitems"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: getCampusItems - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: getCampusItems - " + ex.toString());
		}

		return items;
	}

	/*
	 * getCourseItems
	 *	<p>
	 *	@return String
	 */
	public static String getCourseItems(Connection conn,String campus) throws SQLException {

		String items = "";

		try {
			String sql = "SELECT courseitems FROM tblCampus WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				items = AseUtil.nullToBlank(rs.getString("courseitems"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: getCourseItems - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: getCourseItems - " + ex.toString());
		}

		return items;
	}

    /**
     * <p>
     * updateCampusOutline
     * </p>
     * <p>
     * updates <code>campus outline</code> with each action perform on a KIX.
     * this helps speed up the retrieval process because all KIX by campuses
     * are always available.
     * </p>
     *
     * @param conn
     *          A <code>Connection</code> object
     * @param kix
     *          The <code>HistoryID</code>
     * @param campus
     */
	public static void updateCampusOutline(Connection conn,String kix,String campus) throws SQLException {

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			String sql = "UPDATE tblCampusOutlines SET " + campus + "=? "
						+ "WHERE category=? AND coursealpha=? AND coursenum=? AND coursetype=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,"Outline");
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			int rowsAffected = ps.executeUpdate();

			// if == 0, row does not exist for update. add new row
			if (rowsAffected < 1){
				sql = "INSERT INTO tblCampusOutlines "
					+ "(category,coursealpha,coursenum,coursetype,"+campus+") "
					+ "VALUES('Outline',?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				ps.setString(3,type);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
			}

			ps.close();

		} catch (SQLException e) {
			logger.fatal("CampusDB: updateCampusOutline - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: updateCampusOutline - " + ex.toString());
		}

		return;
	}

    /**
     * <p>
     * createCampusDataRow
     * </p>
     * <p>
     * Add a row to <code>campus data</code> if one does not exist.
     * </p>
     *
     * @param conn
     *          A <code>Connection</code> object
     * @param kix
     *          The <code>HistoryID</code>
     * @return int
     */
	public static int createCampusDataRow(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try{
			if (kix != null && kix.length() > 0){
				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];
				String proposer = info[Constant.KIX_PROPOSER];
				String campus = info[Constant.KIX_CAMPUS];

				rowsAffected = 0;

				if (!CampusDB.courseExistByCampus(conn,campus,alpha,num,type)){
					String sql = "INSERT INTO tblCampusData(historyid,CourseAlpha,CourseNum,CourseType,auditby,campus) VALUES(?,?,?,?,?,?)";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					ps.setString(5,proposer);
					ps.setString(6,campus);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}
		}
		catch(Exception ex){
			logger.fatal("CampusDB: createCampusDataRow - " + ex.toString());
		}

		return rowsAffected;
	}

    /**
     * <p>
     * removeCampusOutline
     * </p>
     * <p>
     * updates <code>campus outline</code> with each action perform on a KIX.
     * this helps speed up the retrieval process because all KIX by campuses
     * are always available.
     * </p>
     *
     * @param conn
     *          A <code>Connection</code> object
     * @param kix
     *          The <code>HistoryID</code>
     * @param campus
     */
	public static void removeCampusOutline(Connection conn,String kix,String campus) throws SQLException {

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			String sql = "UPDATE tblCampusOutlines SET " + campus + "=? "
							+ "WHERE category=? AND coursealpha=? AND coursenum=? AND coursetype=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Constant.BLANK);
			ps.setString(2,"Outline");
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			int rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CampusDB: removeCampusOutline - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: removeCampusOutline - " + ex.toString());
		}

		return;
	}

    /**
     * <p>
     * removeCampusOutline
     * </p>
     * <p>
     * updates <code>campus outline</code> with each action perform on a KIX.
     * this helps speed up the retrieval process because all KIX by campuses
     * are always available.
     * </p>
     *
     * @param conn
     *          A <code>Connection</code> object
     * @param kix
     *          The <code>HistoryID</code>
     * @param campus
     */
	public static void removeCampusOutline(Connection conn,String campus,String alpha,String num,String type) throws SQLException {

		try {
			String sql = "UPDATE tblCampusOutlines SET " + campus + "=? "
							+ "WHERE category=? AND coursealpha=? AND coursenum=? AND coursetype=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Constant.BLANK);
			ps.setString(2,"Outline");
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			int rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CampusDB: removeCampusOutline - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: removeCampusOutline - " + ex.toString());
		}

		return;
	}

    /**
     * <p>
     * removeCampusOutline
     *
     * @param conn
     *          A <code>Connection</code> object
	  *
     */
	public static int removeCampusOutline(Connection conn,long id) throws SQLException {

		int rowsAffected = -1;

		try {
			String sql = "DELETE FROM tblCampusOutlines "
							+ "WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setLong(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CampusDB: removeCampusOutline - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CampusDB: removeCampusOutline - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * Returns a list of users by campus <p> @return String
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	members	String
	 *	<p>
	 * @return String
	 */
	public static String getCampusUsers(Connection conn,String campus,String members) throws Exception {

		StringBuffer users = new StringBuffer();

		String userID = "";

		String fullName = "";

		try {

			if (members != null)
				members = "'" + members.replace(",","','") + "'";
			else
				members = "''";

			String sql = "SELECT userid, lastname + ', ' + firstname AS fullname "
							+ "FROM tblUsers "
							+ "WHERE campus=? "
							+ "AND userid NOT IN (" + members + ") "
							+ "ORDER BY lastname,firstname";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			users.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			while (rs.next()) {
				userID = AseUtil.nullToBlank(rs.getString(1));
				fullName = AseUtil.nullToBlank(rs.getString(2));
				users.append("<option value=\"" + userID + "\">" + fullName + " (" + userID + ")</option>");
			}
			users.append("</select></td></tr></table>");
			rs.close();
			ps.close();

			userID = users.toString();

		} catch (Exception e) {
			logger.fatal("CampusDB: getCampusUsers - " + e.toString());
		}

		return userID;
	}

	/*
	 * hasKix - returns CSV of campuses with outline we seek
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	<p>
	 * @return String
	 */
	public static String hasKix(Connection conn,String alpha,String num,String type) {

		Logger logger = Logger.getLogger("test");

		String kixes = "";

		try{

			//
			// look through and return CSV of campuses with the outline we seek
			//
			String campuses = CampusDB.getCampusNames(conn);

			String sql = "SELECT HAW, HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN, WOA FROM tblCampusOutlines "
				+ "WHERE category='Outline' AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ps.setString(3,type);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				String[] aCampuses = campuses.split(",");

				for(int i = 0; i < aCampuses.length; i++){

					String kix = AseUtil.nullToBlank(rs.getString(aCampuses[i]));
					if(kix != null && kix.length() > 0){
						if(kixes.equals(Constant.BLANK)){
							kixes = aCampuses[i];
						}
						else{
							kixes = kixes + "," + aCampuses[i];
						}
					} // has kix

				} // i

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CampusDB.hasKix: " + e.toString());
		} catch (Exception e) {
			logger.fatal("CampusDB.hasKix: " + e.toString());
		}

		return kixes;

	}

	/*
	 * hasKixLinked - returns CSV of campuses with links to kix for outlines we seek
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	<p>
	 * @return String
	 */
	public static String hasKixLinked(Connection conn,String alpha,String num,String type) {

		Logger logger = Logger.getLogger("test");

		String kixes = "";

		try{

			//
			// return campuses with the outline we seek
			// with the campuses in CSV, put HREF around them for link
			//

			String hasKix = hasKix(conn,alpha,num,type);
			if(hasKix != null && hasKix.length() > 0){

				String[] aCampuses = hasKix.split(",");

				for(int i = 0; i < aCampuses.length; i++){

					String kix = getOutlineHistoryID(conn,aCampuses[i],alpha,num,type);
					String linked = "<a href=\"?[LINKHERE]"+kix+"\" class=\"linkcolumn\">" + aCampuses[i] + "</a>";

					if(kixes.equals(Constant.BLANK)){
						kixes = linked;
					}
					else{
						kixes = kixes + "," + linked;
					}
				} // i
			} // has data to work with

		} catch (Exception e) {
			logger.fatal("CampusDB.hasKixLinked: " + e.toString());
		}

		return kixes;

	}

	/*
	 * getOutlineHistoryID - returns kix of outline we seek
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	<p>
	 * @return String
	 */
	public static String getOutlineHistoryID(Connection conn,String campus,String alpha,String num,String type) {

		Logger logger = Logger.getLogger("test");

		String kix = "";

		try{
			String sql = "SELECT " +campus+ " FROM tblCampusOutlines WHERE category='Outline' AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,num);
			ps.setString(3,type);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				kix = AseUtil.nullToBlank(rs.getString(campus));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CampusDB.getOutlineHistoryID: " + e.toString());
		} catch (Exception e) {
			logger.fatal("CampusDB.getOutlineHistoryID: " + e.toString());
		}

		return kix;

	}

	/**
	 * campusDropDownWithKix - create a drop down of campuses with kix as key
	 * <p>
	 * @param	conn		Connection
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	control	String
	 * @param	defalt	String
	 * <p>
	 * @return	String
	 */
	public static String campusDropDownWithKix(Connection conn,String alpha,String num,String type,String control,String defalt){

		StringBuilder campusDropDown = new StringBuilder();

		campusDropDown.append("<select name=\""+control+"\" id=\""+control+"\" size=\"1\" class=\"smalltext\">")
							.append("<option value=\"\"></option>");

		String campuses = CampusDB.getCampusNames(conn);
		if(campuses != null && campuses.length() > 0){

			String[] aCampuses = campuses.split(",");

			for(int i=0; i<aCampuses.length; i++){

				String selected = "";

				String kix = CampusDB.getOutlineHistoryID(conn,aCampuses[i],alpha,num,type);

				if(kix != null && kix.length() > 0){

					if(aCampuses[i].equals(defalt)){
						selected = "selected";
					}

					campusDropDown.append("<option value=\""+kix+"\" "+selected+">"+aCampuses[i]+"</option>");
				} // valid kix

			} // for i

		} // valid campuses

		campusDropDown.append("</select>");

		return campusDropDown.toString();

	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}