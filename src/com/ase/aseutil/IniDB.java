/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static int deleteIni(Connection connection, String id)
 *	public static boolean doesRoutingIDExists(Connection conn,String campus,int id)
 *	public static Ini getINI(Connection connection, int id)
 *	public static int getDefaultRoutingID(Connection conn,String campus) {
 *	public static int getIDByCampusCategoryKid(Connection connection,String campus,String category,String kid)
 *	public static String getIniByCampusCategory(Connection connection,String campus,String category)
 *	public static ArrayList getIniByCampusCategoryLinker(Connection conn,String campus,String category) {
 *	public static Ini getIniByCampusCategoryKid(Connection connection,String campus,String category,String kid)
 *	public static String getIniByCategory(Connection conn,String category,String value,boolean bullets)
 *	public static String getIniByCategory(Connection conn,String campus,String category,String value,boolean bullets)
 *	public static Ini getIniByCategoryKid(Connection connection,String category,String kid)
 *	public static String getIniByCampusCategoryKidKey1(Connection connection,String campus,String category,String kid)
 *	public static String getIniByCampusCategoryKidKey2(Connection connection,String campus,String category,String kid)
 *	public static String getIniByCampusCategoryKidKey3(Connection connection,String campus,String category,String kid)
 *	public static String getIniByCampusCategoryKidKDescr(Connection connection,String campus,String category,String kid) {
 *	public static ArrayList getLinkedByMethodEval(Connection conn,String campus,String kix) {
 *	public static String getNote(Connection conn,int id) {
 *	public static String getWhereToStartOnOutlineRejection(Connection conn,String campus) {
 *	public static int insertIni(Connection connection, Ini ini,String campusWide)
 *	public static boolean isCategoryEditable(Connection conn,String campus,String category) throws Exception {
 *	public static boolean isMatch(Connection connection,String category,String kid) throws SQLException
 *	public static String listSystemSummary(Connection conn,String campus,String category,String editable)
 *	public static boolean showItemAsDropDownListRange(Connection conn,String campus,String systemKey) throws Exception {
 *	public static int updateIni(Connection connection, Ini ini)
 *	public static int updateNote(Connection conn,int id,String note,String user) {
 *
 */

//
// IniDB.java
//
package com.ase.aseutil;

import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.Generic;

import com.ase.exception.CentralException;

public class IniDB {

	static Logger logger = Logger.getLogger(IniDB.class.getName());

	public IniDB() throws Exception {}

	/*
	 * isMatch
	 *	<p>
	 *	@param	connection	Connection
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection connection,String category,String kid) throws SQLException {
		String query = "SELECT kid FROM tblIni " + "WHERE category = '"
				+ SQLUtil.encode(category) + "' AND " + "kid = '"
				+ SQLUtil.encode(kid) + "'";
		Statement statement = connection.createStatement();
		ResultSet results = statement.executeQuery(query);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn			Connection
	 * @param	category		String
	 * @param	campus		String
	 * @param	kid			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String category,String campus,String kid) throws SQLException {
		String sql = "SELECT kid FROM tblIni WHERE category=? AND campus=? AND kid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,category);
		ps.setString(2,campus);
		ps.setString(3,kid);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * insertIni
	 *	<p>
	 *	@param	connection	Connection
	 * @param	ini			Ini
	 * @param	campusWide	String
	 *	<p>
	 *	@return int
	 */
	public static int insertIni(Connection connection, Ini ini,String campusWide) {

		int i = 0;
		int rowsAffected = 0;
		int campusCount = 1;

		String[] campuses = null;

		/*
			when campusWide is 'Y', add the same entry throughout. If not, add only to that campus.

			The if 'Y' block collects count of campuses, then the names of campuses to set up
			the array of campuses to add. If not, the only campus is the one that is being added.
		*/
		try {
			if (campusWide.equals("Y")){
				AseUtil aseUtil = new AseUtil();
				campusCount = (int)aseUtil.countRecords(connection,"tblcampus","WHERE campus>''");
				String temp = CampusDB.getCampusNames(connection) + ",TTG";
				campuses = temp.split(",");
			}
			else{
				campuses = new String[1];
				campuses[0] = ini.getCampus();
			}

			String sql = "INSERT INTO tblIni (category,kid,kdesc,kval1,kval2,kval3,kval4,kval5,klanid,campus,kedit) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = connection.prepareStatement(sql);

			for (i=0;i<campusCount;i++){
				if (!IniDB.isMatch(connection,ini.getCategory(),campuses[i],ini.getKid())){
					ps.setString(1, ini.getCategory());
					ps.setString(2, ini.getKid());
					ps.setString(3, ini.getKdesc());
					ps.setString(4, ini.getKval1());
					ps.setString(5, ini.getKval2());
					ps.setString(6, ini.getKval3());
					ps.setString(7, ini.getKval4());
					ps.setString(8, ini.getKval5());
					ps.setString(9, ini.getKlanid());
					ps.setString(10, campuses[i]);
					ps.setString(11, ini.getKedit());
					rowsAffected = ps.executeUpdate();
				}
			}
			ps.close();
		} catch (SQLException se) {
			logger.fatal("IniDB: insertIni - " + se.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: insertIni - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * deleteIni
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				String
	 *	<p>
	 *	@return int
	 */
	public static int deleteIni(Connection connection, String id) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblIni WHERE id = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, id);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * updateIni
	 *	<p>
	 *	@param	connection	Connection
	 * @param	ini			Ini
	 *	<p>
	 *	@return int
	 */
	public static int updateIni(Connection connection, Ini ini) {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblIni " +
				"SET category=?,kid=?,kdesc=?,kval1=?,kval2=?,kval3=?,kval4=?,kval5=?,klanid=?,kdate=?,kedit=? " +
				"WHERE id =? AND campus=?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, ini.getCategory());
			preparedStatement.setString(2, ini.getKid());
			preparedStatement.setString(3, ini.getKdesc());
			preparedStatement.setString(4, ini.getKval1());
			preparedStatement.setString(5, ini.getKval2());
			preparedStatement.setString(6, ini.getKval3());
			preparedStatement.setString(7, ini.getKval4());
			preparedStatement.setString(8, ini.getKval5());
			preparedStatement.setString(9, ini.getKlanid());
			preparedStatement.setString(10, ini.getKdate());
			preparedStatement.setString(11, ini.getKedit());
			preparedStatement.setString(12, ini.getId());
			preparedStatement.setString(13, ini.getCampus());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * updateIni
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		int
	 * @param	val	String
	 *	<p>
	 *	@return int
	 */
	public static int updateIni(Connection conn,int id,String val,String user) {

		int rowsAffected = 0;
		try {

			String sql = "UPDATE tblIni SET kval1=?,klanid=?,kdate=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,val);
			ps.setString(2,user);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setInt(4,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			return 0;
		} catch (Exception e) {
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * getINI
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				int
	 *	<p>
	 *	@return Ini
	 */
	public static Ini getINI(Connection connection, int id) {
		Ini ini = new Ini();

		try {
			String sql = "SELECT id,category,kid,kdesc,kval1,kval2,kval3,kval4,kval5,klanid,kdate,kedit,note FROM tblIni WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				ini.setId(aseUtil.nullToBlank(rs.getString("id")));
				ini.setCategory(aseUtil.nullToBlank(rs.getString("category")));
				ini.setKid(aseUtil.nullToBlank(rs.getString("kid")));
				ini.setKdesc(aseUtil.nullToBlank(rs.getString("kdesc")));
				ini.setKval1(aseUtil.nullToBlank(rs.getString("kval1")));
				ini.setKval2(aseUtil.nullToBlank(rs.getString("kval2")));
				ini.setKval3(aseUtil.nullToBlank(rs.getString("kval3")));
				ini.setKval4(aseUtil.nullToBlank(rs.getString("kval4")));
				ini.setKval5(aseUtil.nullToBlank(rs.getString("kval5")));
				ini.setKlanid(aseUtil.nullToBlank(rs.getString("klanid")));
				ini.setKdate(aseUtil.ASE_FormatDateTime(aseUtil.nullToBlank(rs.getString("kdate")),Constant.DATE_DATETIME));
				ini.setKedit(aseUtil.nullToBlank(rs.getString("kedit")));
				ini.setNote(aseUtil.nullToBlank(rs.getString("note")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("IniDB: getINI - " + e.toString());
			ini = null;
		}

		return ini;
	}

	/*
	 * getIniByCategory
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCategory(Connection conn,String category,String value,boolean bullets) {

		StringBuffer ini = new StringBuffer();
		String temp = null;
		String junk = null;
		String id = null;
		String[] selected = new String[100];

		boolean found = false;

		int numberOfSelections = 0;
		int selectedIndex = 0;
		int i = 0;

		try {
			String sql = "SELECT id, kdesc FROM tblIni WHERE category=? ORDER BY kdesc ASC";

			selected = value.split(",");
			numberOfSelections = selected.length;
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, category);
			ResultSet resultSet = preparedStatement.executeQuery();
			i = 0;
			while (resultSet.next()) {
				id = resultSet.getString(1);
				junk = resultSet.getString(2);

				selectedIndex = 0;
				found = false;
				while (!found && selectedIndex < numberOfSelections){
					if (id.equals(selected[selectedIndex++])){
						if (bullets)
							ini.append("<li>" + junk + "</li>");
						else
							ini.append(junk + "<br>");
					}
				}
			}
			resultSet.close();
			preparedStatement.close();

			temp = ini.toString();

			if (bullets)
				temp = "<ul>" + temp + "</ul>";
		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCategory - " + e.toString());
			temp = null;
		}

		return temp;
	}

	/*
	 * getIniByCategory
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCategory(Connection conn,String campus,String category,String value,boolean bullets) {

		StringBuffer ini = new StringBuffer();
		String temp = null;
		String junk = null;
		String id = null;
		String[] selected = new String[100];

		boolean found = false;

		int numberOfSelections = 0;
		int selectedIndex = 0;
		int i = 0;

		try {
			String sql = "SELECT id, kdesc FROM tblIni WHERE campus=? AND category=? ORDER BY kdesc ASC";
			selected = value.split(",");
			numberOfSelections = selected.length;
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, category);
			ResultSet resultSet = preparedStatement.executeQuery();
			i = 0;
			while (resultSet.next()) {
				id = resultSet.getString(1);
				junk = resultSet.getString(2);

				selectedIndex = 0;
				found = false;
				while (!found && selectedIndex < numberOfSelections){
					if (id.equals(selected[selectedIndex++])){
						if (bullets)
							ini.append("<li>" + junk + "</li>");
						else
							ini.append(junk + "<br>");
					}
				}
			}
			resultSet.close();
			preparedStatement.close();

			temp = ini.toString();

			if (bullets)
				temp = "<ul>" + temp + "</ul>";
		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCategory - " + e.toString());
			temp = null;
		}

		return temp;
	}

	/*
	 * getIniByCampusCategory
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCampusCategory(Connection connection,String campus,String category) {

		StringBuffer ini = new StringBuffer();
		boolean first = true;

		try {
			String sql = "SELECT kdesc FROM tblIni WHERE campus=? AND category=? ORDER BY kdesc ASC";

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, category);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				if (!first){
					ini.append(","+resultSet.getString(1));
				}
				else{
					ini.append(resultSet.getString(1));
					first = false;
				}
			}
			resultSet.close();
			preparedStatement.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategory - " + e.toString());
			ini.append("");
		}

		return ini.toString();
	}

	/*
	 * getIniByCampusCategoryLinker
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	category	String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getIniByCampusCategoryLinker(Connection conn,String campus,String category) {

		ArrayList<Ini> list = new ArrayList<Ini>();
		Ini ini;

		try {
			String sql = "SELECT id,kdesc FROM tblIni WHERE campus=? AND category=? ORDER BY kdesc ASC";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ini = new Ini();
				ini.setId(rs.getString(1).trim());
				ini.setKdesc(rs.getString(2).trim());
				list.add(ini);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryLinker - " + e.toString());
			return null;
		}

		return list;
	}

	/*
	 * getLinkedByMethodEval
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getLinkedByMethodEval(Connection conn,String campus,String kix) {

		String sql = "";
		String methodEvaluation = "";

		ArrayList<Ini> list = new ArrayList<Ini>();
		Ini ini;

		try {
			AseUtil aseUtil = new AseUtil();

			// if method of evaluation has been selected, limit this list to only what was selected;
			// otherwise, show the entire list.
			sql = "historyid=" + aseUtil.toSQL(kix,1);

			methodEvaluation = aseUtil.lookUp(conn,"tblCourse",Constant.COURSE_METHODEVALUATION,sql);

			methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

			if (methodEvaluation != null && methodEvaluation.length() > 0){
				sql = "SELECT id,kdesc FROM tblIni "
					+ "WHERE campus=? AND category='MethodEval' AND id IN ("+methodEvaluation+") "
					+ "ORDER BY seq, kdesc";
			}
			else{
				sql = "SELECT id,kdesc FROM tblIni "
					+ "WHERE campus=? AND category='MethodEval' "
					+ "ORDER BY seq, kdesc";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ini = new Ini();
				ini.setId(rs.getString(1).trim());
				ini.setKdesc(rs.getString(2).trim());
				list.add(ini);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("IniDB: getLinkedByMethodEval - " + e.toString() + "\n kix: " + kix);
			return null;
		}

		return list;
	}

	/*
	 * getIniByCategoryKid
	 *	<p>
	 *	@param	connection	Connection
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return Ini
	 */
	public static Ini getIniByCategoryKid(Connection connection,String category,String kid) {

		Ini ini = new Ini();

		try {
			String sql = "SELECT * FROM tblIni WHERE category=? AND kid=?";

			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1,category);
			preparedStatement.setString(2,kid);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				AseUtil aseUtil = new AseUtil();
				ini.setId(aseUtil.nullToBlank(resultSet.getString("id")).trim());
				ini.setCategory(aseUtil.nullToBlank(resultSet.getString("category")).trim());
				ini.setKid(aseUtil.nullToBlank(resultSet.getString("kid")).trim());
				ini.setKdesc(aseUtil.nullToBlank(resultSet.getString("kdesc")).trim());
				ini.setKval1(aseUtil.nullToBlank(resultSet.getString("kval1")).trim());
				ini.setKval2(aseUtil.nullToBlank(resultSet.getString("kval2")).trim());
				ini.setKval3(aseUtil.nullToBlank(resultSet.getString("kval3")).trim());
				ini.setKval4(aseUtil.nullToBlank(resultSet.getString("kval4")).trim());
				ini.setKval5(aseUtil.nullToBlank(resultSet.getString("kval5")).trim());
				ini.setKlanid(aseUtil.nullToBlank(resultSet.getString("klanid")).trim());
				ini.setKdate(aseUtil.nullToBlank(resultSet.getString("kdate")).trim());
				ini.setKedit(aseUtil.nullToBlank(resultSet.getString("kedit")).trim());
			}
			resultSet.close();
			preparedStatement.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCategoryKid - " + e.toString());
			return null;
		}

		return ini;
	}

	/*
	 * getIDByCampusCategoryKid
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return int
	 */
	public static int getIDByCampusCategoryKid(Connection connection,String campus,String category,String kid) {

		int id = 0;

		try {
			String sql = "SELECT id FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("id");
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIDByCampusCategoryKid - " + e.toString());
		}

		return id;
	}

	/*
	 * getIniByCampusCategoryKid
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return Ini
	 */
	public static Ini getIniByCampusCategoryKid(Connection connection,
																String campus,
																String category,
																String kid) {

		Ini ini = new Ini();

		try {
			String sql = "SELECT * FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				AseUtil aseUtil = new AseUtil();
				ini.setId(aseUtil.nullToBlank(resultSet.getString("id")).trim());
				ini.setCategory(aseUtil.nullToBlank(resultSet.getString("category")).trim());
				ini.setKid(aseUtil.nullToBlank(resultSet.getString("kid")).trim());
				ini.setKdesc(aseUtil.nullToBlank(resultSet.getString("kdesc")).trim());
				ini.setKval1(aseUtil.nullToBlank(resultSet.getString("kval1")).trim());
				ini.setKval2(aseUtil.nullToBlank(resultSet.getString("kval2")).trim());
				ini.setKval3(aseUtil.nullToBlank(resultSet.getString("kval3")).trim());
				ini.setKval4(aseUtil.nullToBlank(resultSet.getString("kval4")).trim());
				ini.setKval5(aseUtil.nullToBlank(resultSet.getString("kval5")).trim());
				ini.setKlanid(aseUtil.nullToBlank(resultSet.getString("klanid")).trim());
				ini.setKdate(aseUtil.nullToBlank(resultSet.getString("kdate")).trim());
				ini.setKedit(aseUtil.nullToBlank(resultSet.getString("kedit")).trim());
			}
			resultSet.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryKid - " + e.toString());
			return null;
		}

		return ini;
	}

	/*
	 * doesRoutingIDExists
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	route		int
	 *	<p>
	 *	@return boolean
	 */
	public static boolean doesRoutingIDExists(Connection conn,
															String campus,
															int route) {

		boolean exists = false;

		try {
			String sql = "SELECT id "
				+ "FROM tblIni "
				+ "WHERE campus=? "
				+ "AND category='ApprovalRouting' "
				+ "AND id=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: doesRoutingIDExists - " + e.toString());
		}

		return exists;
	}

	/*
	 * getDefaultRoutingID
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 *	@return int
	 */
	public static int getDefaultRoutingID(Connection conn,String campus) {

		int route = 0;

		try {
			String sql = "SELECT min(id) as minID "
				+ "FROM tblIni "
				+ "WHERE campus=? "
				+ "AND category='ApprovalRouting'";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				route = rs.getInt(1);
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getDefaultRoutingID - " + e.toString());
		}

		return route;
	}

	/*
	 * getIniByCampusCategoryKidKey1
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	category		String
	 * @param	kid			String
	 *	<p>
	 *	@return Ini
	 */
	public static String getIniByCampusCategoryKidKey1(Connection connection,
																		String campus,
																		String category,
																		String kid) {

		String kval1 = "";

		try {
			String sql = "SELECT kval1 FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				kval1 = AseUtil.nullToBlank(resultSet.getString("kval1"));
			}
			resultSet.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryKidKey1 - " + e.toString());
		}

		return kval1;
	}

	/*
	 * getIniByCampusCategoryKidKey2
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	caegory		String
	 * @param	kid			String
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCampusCategoryKidKey2(Connection connection,
																		String campus,
																		String category,
																		String kid) {

		String kval2 = "";

		try {
			String sql = "SELECT kval2 FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				kval2 = AseUtil.nullToBlank(resultSet.getString("kval2"));
			}
			resultSet.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryKidKey2 - " + e.toString());
		}

		return kval2;
	}

	/*
	 * getIniByCampusCategoryKidKey3
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	caegory		String
	 * @param	kid			String
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCampusCategoryKidKey3(Connection connection,
																		String campus,
																		String category,
																		String kid) {

		String kval3 = "";

		try {
			String sql = "SELECT kval3 FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				kval3 = AseUtil.nullToBlank(resultSet.getString("kval3"));
			}
			resultSet.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryKidKey3 - " + e.toString());
		}

		return kval3;
	}

	/*
	 * getIniByCampusCategoryKidKDescr
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	caegory		String
	 * @param	kid			String
	 *	<p>
	 *	@return String
	 */
	public static String getIniByCampusCategoryKidKDescr(Connection connection,String campus,String category,String kid) {

		String kdesc = "";

		try {
			String sql = "SELECT kdesc FROM tblIni WHERE campus=? AND category=? AND kid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ps.setString(3, kid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				kdesc = AseUtil.nullToBlank(resultSet.getString("kdesc"));
			}
			resultSet.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("IniDB: getIniByCampusCategoryKidKDescr - " + e.toString());
		}

		return kdesc;
	}

	/**
	 * listSystemSummary
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	category	String
	 * @param	editable	String
	 * <p>
	 * @return	String
	 */
	public static String listSystemSummary(Connection conn,String campus,String category,String editable){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String rowColor = "";
		String key = "";
		String descr = "";
		String value1 = "";
		String value2 = "";
		int j = 0;
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT kid,kdesc,kval1,kval2 "
				+ "FROM tblINI "
				+ "WHERE campus=? AND "
				+ "category=? AND "
				+ "kedit=? "
				+ "ORDER BY kid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,editable);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				key = aseUtil.nullToBlank(rs.getString("kid"));
				descr = aseUtil.nullToBlank(rs.getString("kdesc"));
				value1 = aseUtil.nullToBlank(rs.getString("kval1"));
				value2 = aseUtil.nullToBlank(rs.getString("kval2"));

				if (!"".equals(value2))
					value1 = value1 + " - " + value2;
				else{
					if ("1".equals(value1))
						value1 = "YES";
					else if ("0".equals(value1))
						value1 = "NO";
				}

				if (j++ % 2 == 0)
					rowColor = "#FFFFFF";
				else
					rowColor = "#e5f1f4";

				listings.append("<tr class=\""+campus+"BGColorRow\" height=\"30\" bgcolor=\"" + rowColor + "\">"
					+ "<td class=\"datacolumn\" width=\"20%\">" + key + "</td>"
					+ "<td class=\"datacolumn\" width=\"01%\">&nbsp;</td>"
					+ "<td class=\"datacolumn\" width=\"48%\">" + descr + "</td>"
					+ "<td class=\"datacolumn\" width=\"01%\">&nbsp;</td>"
					+ "<td class=\"datacolumn\" width=\"30%\">" + value1 + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
				+ "<tr height=\"30\" class=\"" + campus + "BGColor\">"
				+ "<td width=\"20%\">Key</td>"
				+ "<td width=\"01%\">&nbsp;</td>"
				+ "<td width=\"48%\">Description</td>"
				+ "<td width=\"01%\">&nbsp;</td>"
				+ "<td width=\"30%\">Value</td>"
				+ "</tr>"
				+ listings.toString()
				+ "</table>";
			}
			else{
				listing = "System summary not available";
			}
		}
		catch( SQLException e ){
			logger.fatal("IniDB: listSystemSummary - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("IniDB: listSystemSummary\n" + ex.toString());
		}

		return listing;
	}

	/*
	 * mumberOfItems of a given category
	 * <p>
	 *	returns the number of items found for a given campus and category
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String 		campus
	 *	@param	String 		category
	 * <p>
	 *	@return int
	 */
	public static int mumberOfItems(Connection connection,String campus,String category) throws Exception {

		int counter = 0;
		String sql = "SELECT count(id) FROM tblINI WHERE campus=? AND category=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				counter = NumericUtil.nullToZero(rs.getInt(1));
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("IniDB: mumberOfItems - " + e.toString());
		}

		return counter;
	}

	/**
	 * drawResequenceForm
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	category	String
	 * <p>
	 * @return	String
	 */
	public static String drawResequenceForm(Connection conn,String campus,String category){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String rowColor = "";
		String kdesc = "";
		String kid = "";
		String dropDownList = "";
		String temp = "";
		String controls = "";
		int j = 0;
		int id = 0;
		int seq = 0;
		int numberOfRecords = 0;
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;

			// determine the number of available entries to draw the drop down list box
			sql = "WHERE campus='" + SQLUtil.encode(campus) + "' AND " + "category='" + SQLUtil.encode(category) + "'";
			numberOfRecords = (int)AseUtil.countRecords(conn,"tblIni",sql);

			for (j=1;j<=numberOfRecords;j++){
				if (j==1)
					dropDownList = "" + j;
				else
					dropDownList = dropDownList + "," + j;
			}

			j = 0;

			if (numberOfRecords>0){
				sql = "SELECT id,seq,kid,kdesc FROM tblini WHERE campus=? AND category=? ORDER BY seq";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,category);
					rs = ps.executeQuery();
				while ( rs.next() ){
					id = NumericUtil.nullToZero(rs.getInt("id"));
					seq = NumericUtil.nullToZero(rs.getInt("seq"));
					kid = aseUtil.nullToBlank(rs.getString("kid"));
					kdesc = aseUtil.nullToBlank(rs.getString("kdesc"));

					if (j==0)
						controls = "" + id;
					else
						controls = controls + "," + id;

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					temp = aseUtil.createStaticSelectionBox(dropDownList,dropDownList,"controlName_"+id,(""+seq),"","","BLANK","");
					listings.append("<td class=\"datacolumn\">" + temp + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + kid + "</td>");
					listings.append("<td class=\"datacolumn\">" + kdesc + "</a></td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();
			}

			if (found){
				listing = "<form name=\"aseForm\" action=\"/central/servlet/ase\" method=\"post\">" +
					"<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"12%\">Sequence</td>" +
					"<td class=\"textblackth\" width=\"28%\">Key</td>" +
					"<td class=\"textblackth\" width=\"60%\">Description</td>" +
					"</tr>" +
					listings.toString() +
					"<tr><td width=\"100%\" colspan=\"3\"><br/>" +
					"<input name=\"act\" value=\"reseq\" type=\"hidden\">" +
					"<input name=\"controls\" value=\""+controls+"\" type=\"hidden\">" +
					"<input name=\"category\" value=\""+category+"\" type=\"hidden\">" +
					"<input name=\"aseSave\" value=\"Save\" type=\"submit\" class=\"inputsmallgray\" title=\"continue requested operation\">&nbsp;" +
					"<input name=\"aseAutoSave\" value=\"AutoSave\" type=\"submit\" class=\"inputsmallgray\" title=\"continue requested operation\">&nbsp;" +
					"<input name=\"aseCancel\" value=\"Cancel\" type=\"submit\" class=\"inputsmallgray\" title=\"end requested operation\">" +
					"</td></tr>" +
					"</table>" +
					"</form>";
			}
			else{
				listing = "Select category does not have any settings";
			}
		}
		catch( SQLException e ){
			logger.fatal("IniDB: drawResequenceForm - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("IniDB: drawResequenceForm - " + ex.toString());
		}

		return listing;
	}

	/*
	 * isCategoryEditable - determine whethere a specific category is editable
	 * <p>
	 *	returns true if the category allows edit
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String 		campus
	 *	@param	String 		category
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCategoryEditable(Connection conn,String campus,String category) throws Exception {

		// all kedit flags should be set to either Y or N for a single category
		// if the counter comes back as 1 and kedit = N, then not editable
		// anything else means editable
		int counter = 0;
		String kedit = "";
		boolean isEditable = true;

		String sql = "SELECT COUNT(DISTINCT kedit) AS counter, kedit "
			+ "FROM tblINI WHERE campus=? AND category=? GROUP BY kedit";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, category);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				counter = NumericUtil.nullToZero(rs.getInt(1));
				kedit = AseUtil.nullToBlank(rs.getString("kedit"));
			}

			if (counter == 1 && "N".equals(kedit))
				isEditable = false;

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("IniDB: isCategoryEditable - " + e.toString());
		}

		return isEditable;
	}

	/*
	 * updateNote
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		int
	 * @param	note	String
	 * @param	user	String
	 *	<p>
	 *	@return int
	 */
	public static int updateNote(Connection conn,int id,String note,String user) {

		int rowsAffected = 0;

		try {
			AseUtil aseUtil = new AseUtil();
			String sql = "UPDATE tblIni " +
				"SET note=?,klanid=?,kdate=? " +
				"WHERE id =?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,note);
			ps.setString(2,user);
			ps.setString(3,aseUtil.getCurrentDateTimeString());
			ps.setInt(4,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch(SQLException e) {
			logger.fatal("IniDB: updateNote - " + e.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: updateNote - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNote
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return int
	 */
	public static String getNote(Connection conn,int id) {

		String note = "";

		try {
			String sql = "SELECT note " +
				"FROM tblIni " +
				"WHERE id =?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				note = AseUtil.nullToBlank(rs.getString("note"));
			}
			rs.close();
			ps.close();
		} catch(SQLException e) {
			logger.fatal("IniDB: getNote - " + e.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: getNote - " + ex.toString());
		}

		return note;
	}

	/*
	 * getKdesc
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		String
	 *	<p>
	 *	@return int
	 */
	public static String getKdesc(Connection conn,String id) {

		String kdesc = "";

		try {
			if (id != null && NumericUtil.isInteger(id)){
				String sql = "SELECT kdesc FROM tblIni WHERE id =?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,Integer.parseInt(id));
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					kdesc = AseUtil.nullToBlank(rs.getString("kdesc"));
				}
				rs.close();
				ps.close();
			}
		} catch(SQLException ex) {
			logger.fatal("IniDB: getKdesc - " + ex.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: getKdesc - " + ex.toString());
		}

		return kdesc;
	}

	/*
	 * getWhereToStartOnOutlineRejection
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 *	@return String
	 */
	public static String getWhereToStartOnOutlineRejection(Connection conn,String campus) {

		String returnToStartOnOutlineRejection = "";

		try {
			returnToStartOnOutlineRejection =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ReturnToStartOnOutlineRejection");
		} catch(Exception ex){
			logger.fatal("IniDB: getWhereToStartOnOutlineRejection - " + ex.toString());
		}

		return returnToStartOnOutlineRejection;
	}

	/**
	 * listSystemValues
	 * <p>
	 * @param	conn		Connection
	 * @param	category	String
	 * @param	props		String
	 * @param	request	HttpServletRequest
	 * <p>
	 * @return	String
	 */
	public static String listSystemValues(Connection conn,
														String category,
														String props,
														HttpServletRequest request){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String kid = "";
		String kdesc = "";
		String rowColor = "";
		String link = "";
		String formValue = "";

		int id = 0;
		int j = 0;

		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			HttpSession session = request.getSession(true);

			String sql = aseUtil.getPropertySQL(session,props);
			sql = aseUtil.replace(sql, "_cat_", category);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				found = true;

				id = rs.getInt("id");
				kid = aseUtil.nullToBlank(rs.getString("kid"));
				kdesc = aseUtil.nullToBlank(rs.getString("kdesc"));

				if ("".equals(formValue))
					formValue = "" + id;
				else
					formValue += "," + id;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><input type=\"checkbox\" name=\"chk_"+id+"\" value=\""+id+"\"></td>");
				listings.append("<td class=\"datacolumn\">" + kid + "</td>");
				listings.append("<td class=\"datacolumn\">" + kdesc + "</td>");
				listings.append("</tr>");
			}

			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"05%\">&nbsp;</td>" +
					"<td class=\"textblackth\" width=\"20%\">Key</td>" +
					"<td class=\"textblackth\" width=\"75%\">Description</td>" +
					"</tr>" +
					listings.toString() +
					"</table>" +
					"<input type=\"hidden\" value=\""+formValue+"\" name=\"formValue\">";
			}
			else{
				listing = "";
			}
		}
		catch( SQLException e ){
			logger.fatal("IniDB: listSystemValues - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("IniDB: listSystemValues - " + ex.toString());
		}

		return listing;
	}

	/**
	 * systemListUsage
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	request	HttpServletRequest
	 * <p>
	 * @return	String
	 */
	public static String systemListUsage(Connection conn,String campus,HttpServletRequest request){

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String tempValues = "";
		String selectValues = "";
		String QuestionFriendly = "";

		String rowColor = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String kix = "";
		String type = "";
		String link = "";
		String coursetitle = "";
		String listing = "";

		boolean found = false;

		StringBuffer listings = new StringBuffer();

		int loopCounter = 0;
		int j = 0;

		try{

			AseUtil aseUtil = new AseUtil();
			WebSite website = new WebSite();

			String category = website.getRequestParameter(request,"category", "");
			String formValues = website.getRequestParameter(request,"formValue","");

			if (formValues != null && formValues.length() > 0){
				String[] aFormValues = formValues.split(",");

				QuestionFriendly = aseUtil.lookUp(conn, "CCCM6100", "Question_Friendly", "campus='SYS' AND type='Course' AND Question_Ini='"+category+"'" );

				for (loopCounter=0; loopCounter<aFormValues.length; loopCounter++){

					temp = website.getRequestParameter(request,"chk_"+aFormValues[loopCounter],"");

					if (temp != null && temp.length() > 0){

						if (tempValues.equals(Constant.BLANK))
							tempValues = aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);
						else
							tempValues += "," + aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);

						if (selectValues.equals(Constant.BLANK))
							selectValues = QuestionFriendly + " LIKE '%"+temp+"%'";
						else
							selectValues += " OR " + QuestionFriendly + " LIKE '%"+temp+"%'";
					}	// if temp
				}	// for

				if (selectValues != null && selectValues.length() > 0){

					String sql = "SELECT historyid,coursealpha,coursenum,progress,coursetitle,coursetype "
						+ "FROM tblCourse WHERE campus='"+campus+"' AND ("+selectValues+") "
						+ "ORDER BY coursealpha,coursenum,coursetype";

					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while (rs.next()){
						found = true;

						alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
						num = aseUtil.nullToBlank(rs.getString("coursenum"));
						type = aseUtil.nullToBlank(rs.getString("coursetype"));
						progress = aseUtil.nullToBlank(rs.getString("progress"));
						kix = aseUtil.nullToBlank(rs.getString("historyid"));
						coursetitle = aseUtil.nullToBlank(rs.getString("coursetitle"));

						if (j++ % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						//link = "vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=" + type;
						link = "vwcrsy.jsp?pf=1&kix="+kix+"&comp=0";

						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
							.append("<td class=\"datacolumn\"><a href=\""+link+"\" class=\"linkcolumn\" target=\"_blank\" title=\"view outline\">" + alpha + " " + num + "</a></td>")
							.append("<td class=\"datacolumn\">" + progress + "</td>")
							.append("<td class=\"datacolumn\">" + coursetitle + "</td>")
							.append("</tr>");
					}

					rs.close();
					ps.close();

					if (found){
						listing = "<p align=\"left\"><font class=\"textblackth\">Select values:</font>"
							+ "<font class=\"datacolumn\"> " + tempValues + "</font></p>"
							+ "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
							+ "<tr height=\"30\" bgcolor=\"#e1e1e1\">"
							+ "<td class=\"textblackth\" width=\"10%\">Outline</td>"
							+ "<td class=\"textblackth\" width=\"10%\">Progress</td>"
							+ "<td class=\"textblackth\" width=\"80%\">Title</td>"
							+ "</tr>"
							+ listings.toString()
							+ "</table>";
					}
					else
						listing = "Outline not found for the requested system value.";

				}

			}	// formvalues
		}
		catch( SQLException e ){
			logger.fatal("IniDB: systemListUsage - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("IniDB: systemListUsage - " + ex.toString());
		}

		return listing;
	}

	/**
	 * systemListUsage
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	category		String
	 * @param	formValues	String
	 * @param	request		HttpServletRequest
	 * <p>
	 * @return	String
	 */
	public static List<Generic> systemListUsage(Connection conn,String campus,String category,String formValues,HttpServletRequest request){

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String tempValues = "";
		String selectValues = "";
		String QuestionFriendly = "";

		String alpha = "";
		String num = "";
		String type = "";

		List<Generic> genericData = null;

		int loopCounter = 0;
		int j = 0;

		try{

			AseUtil aseUtil = new AseUtil();
			WebSite website = new WebSite();

			if (formValues != null && formValues.length() > 0){
				String[] aFormValues = formValues.split(",");

				QuestionFriendly = aseUtil.lookUp(conn, "CCCM6100", "Question_Friendly", "campus='SYS' AND type='Course' AND Question_Ini='"+category+"'" );

				for (loopCounter=0; loopCounter<aFormValues.length; loopCounter++){

					temp = website.getRequestParameter(request,"chk_"+aFormValues[loopCounter],"");

					if (temp != null && temp.length() > 0){

						if (tempValues.equals(Constant.BLANK))
							tempValues = aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);
						else
							tempValues += "," + aseUtil.lookUp(conn, "tblINI", "kid", "campus='"+campus+"' AND id="+temp);

						if (selectValues.equals(Constant.BLANK))
							selectValues = QuestionFriendly + " LIKE '%"+temp+"%'";
						else
							selectValues += " OR " + QuestionFriendly + " LIKE '%"+temp+"%'";
					}	// if temp
				}	// for

				if (selectValues != null && selectValues.length() > 0){

	            genericData = new LinkedList<Generic>();

					String sql = "SELECT historyid,coursealpha,coursenum,progress,coursetitle,coursetype "
						+ "FROM tblCourse WHERE campus='"+campus+"' AND ("+selectValues+") "
						+ "ORDER BY coursealpha,coursenum,coursetype";

					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while (rs.next()){
						alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
						num = aseUtil.nullToBlank(rs.getString("coursenum"));

						genericData.add(new Generic(
												alpha + " " + num,
												aseUtil.nullToBlank(rs.getString("progress")),
												aseUtil.nullToBlank(rs.getString("coursetitle")),
												aseUtil.nullToBlank(rs.getString("historyid")),
												"",
												"",
												"",
												"",
												"",
												""
											));

					}

					rs.close();
					ps.close();

				}

				aseUtil = null;
				website = null;

			}	// formvalues
		}
		catch( SQLException e ){
			logger.fatal("IniDB: systemListUsage - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("IniDB: systemListUsage - " + ex.toString());
		}

		return genericData;
	}

	/*
	 * addSystemSettings
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return	void
	 */
	public static void addSystemSettings(Connection conn)  throws CentralException {

		/*
			add missing system settings to campus
		*/

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;

		try{
			String kid;
			String kdesc;

			logger.info("INIDB: ADDSYSTEMSETTINGS - START");

			String campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");
			if (campus!=null && campus.length()>0){
				String[] aCampus = campus.split(",");
				String sql = "SELECT distinct kid,kdesc "
								+ "FROM tblini "
								+ "WHERE category = 'System' AND kedit='Y'";
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					kid = rs.getString("kid");
					kdesc = rs.getString("kdesc");
					for(int i=0; i<aCampus.length; i++){
						if (!IniDB.isMatch(conn,"System",aCampus[i],kid)){
							sql = "INSERT INTO tblIni (category,kid,kdesc,kval1,kval2,kval3,kval4,kval5,klanid,campus,kedit) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,"System");
							ps2.setString(2,kid);
							ps2.setString(3,kdesc);
							ps2.setString(4,"0");
							ps2.setString(5,"");
							ps2.setString(6,"");
							ps2.setString(7,"");
							ps2.setString(8,"");
							ps2.setString(9,"System");
							ps2.setString(10,aCampus[i]);
							ps2.setString(11,"Y");
							rowsAffected = ps2.executeUpdate();
							ps2.close();
							logger.info("IniDB - addSystemSettings: " + aCampus[i] + " - " + kid);
						}
					}
				}	// while
				rs.close();
				ps.close();

			logger.info("INIDB: ADDSYSTEMSETTINGS - END");

			}
		} catch (SQLException se) {
			logger.fatal("IniDB: addSystemSettings - " + se.toString());
			throw new CentralException("IniDB: addSystemSettings - " + se.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: addSystemSettings - " + e.toString());
			throw new CentralException("IniDB: addSystemSettings - " + e.toString());
		}
	}

	/*
	 * showItemAsDropDownListRange
	 * <p>
	 *	@param	connection
	 *	@param	campus
	 *	@param	systemKey
	 * <p>
	 *	@return boolean
	 */
	public static boolean showItemAsDropDownListRange(Connection conn,String campus,String systemKey) throws Exception {

		boolean includeRange = false;

		try {
			AseUtil aseUtil = new AseUtil();

			String listRangeSQL = "category='System' AND campus='"+campus+"' AND kid='"+systemKey+"'";
			String[] listRange = aseUtil.lookUpX(conn,"tblIni","kval1,kval2",listRangeSQL);
			if (listRange != null){
				if (	NumericUtil.isInteger(listRange[0]) &&
						NumericUtil.isInteger(listRange[1]) &&
						Integer.parseInt(listRange[1]) > 0){
					includeRange = true;
				}
			} // listRange != null
		} catch (Exception e) {
			logger.fatal("IniDB: showItemAsDropDownListRange - " + e.toString());
		}

		return includeRange;
	}

	/*
	 * updateApprovalByDate
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	update	String
	 *	<p>
	 *	@return int
	 */
	public static int updateApprovalByDate(Connection conn,String campus,String update) {

		int rowsAffected = 0;
		try {
			String sql = "UPDATE tblIni " +
				"SET kval1=? " +
				"WHERE category=? " +
				"AND campus=? " +
				"AND kid=?";
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1,update);
			preparedStatement.setString(2,"System");
			preparedStatement.setString(3,campus);
			preparedStatement.setString(4,"EnableApprovalByDates");
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			return 0;
		} catch (Exception e) {
			logger.fatal("IniDB: showItemAsDropDownListRange - " + e.toString());
		}
		return rowsAffected;
	}


	/**
	 * getSystemSettingsCount
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int getSystemSettingsCount(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		int count = 0;

		String sql = "SELECT count(id) as counter FROM tblINI WHERE campus=? AND category='System'";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				count = rs.getInt("counter");
			} // if rs
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("IniDB: getSystemSettingsCount - " + e.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: getSystemSettingsCount - " + e.toString());
		}

		return count;
	}

	/**
	 * createMissingSettingForCampus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int createMissingSettingForCampus(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String baseCampus = "TTG";

			// system setting
			String category = "System";

			// campus wide setting
			String campusWide = "N";

			// read all settings for TTG or base
			String sql = "select * from tblini where campus=? AND category=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,baseCampus);
			ps.setString(2,category);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kid = AseUtil.nullToBlank(rs.getString("kid"));
				String kdesc = AseUtil.nullToBlank(rs.getString("kdesc"));
				String kval1 = AseUtil.nullToBlank(rs.getString("kval1"));
				String kval2 = AseUtil.nullToBlank(rs.getString("kval2"));
				String kval3 = AseUtil.nullToBlank(rs.getString("kval3"));
				String kedit = AseUtil.nullToBlank(rs.getString("kedit"));

				kval1 = kval1.replaceAll(baseCampus,campus);

				Ini ini = new Ini("0",category,kid,kdesc,kval1,kval2,kval3,null,null,user,AseUtil.getCurrentDateTimeString(),campus,kedit);

 				rowsAffected += IniDB.insertIni(conn,ini,campusWide);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("IniDB: createMissingSettingForCampus - " + e.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: createMissingSettingForCampus - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * editSystemINI
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String editSystemINI(Connection conn,String campus,String category) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		int i = 0;

		String rowClass = "";

		int rowCounter = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			sb.append("<div id=\"aseEdit\" class=\"base-container ase-table-layer\">");

			sb.append("<div class=\"ase-table-row-header\">"
						+ "<div class=\"left-layer25\">Setting</div>"
						+ "<div class=\"left-layer35\">Description</div>"
						+ "<div class=\"left-layer20\">Value&nbsp;<img src=\"../images/edit.gif\" boder=\"0\" title=\"editable column\" alt=\"editable column\"></div>"
						+ "<div class=\"left-layer10\">Audit By</div>"
						+ "<div class=\"left-layer10\">Audit Date</div>"
						+ "<div id=\"ras\" class=\"space-line\"></div>"
						+ "</div>");

			String sql = "SELECT id,kid,kdesc,kval1,klanid,kdate "
							+ "FROM tblini "
							+ "WHERE campus=? "
							+ "AND category like 'System' "
							+ "AND kedit='Y' "
							+ "AND NOT kval1 like 'SELECT%' "
							+ "ORDER BY kid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				int id = rs.getInt("id");
				String kid = rs.getString("kid");
				String descr = rs.getString("kdesc");
				String value = rs.getString("kval1");
				String auditby = rs.getString("klanid");
				String auditdate = aseUtil.ASE_FormatDateTime(rs.getString("kdate"),Constant.DATE_DATE_MDY);

				if (++rowCounter % 2 == 0){
					rowClass = "ase-table-row-detail-alt";
				}
				else{
					rowClass = "ase-table-row-detail";
				}

				sb.append("<div id=\"record-"+i+"\" class=\""+rowClass+"\">"
					+ "<div class=\"left-layer25\"><p class=\"ase-text\"><a class=\"linkcolumn\" href=\"inimod.jsp?c="+category+"&lid="+id+"\">"+kid+"</a></div>"
					+ "<div class=\"left-layer35\"><p class=\"ase-text\">"+descr+"</div>"
					+ "<div class=\"edit-sys-settings left-layer20Edit\" id=\""+id+"\">"+value+"</div>"
					+ "<div class=\"left-layer10\"><p class=\"ase-text\">"+auditby+"</div>"
					+ "<div class=\"left-layer10\"><p class=\"ase-text\">"+auditdate+"</div>"
					+ "<div id=\"ras\" class=\"space-line\"></div>"
					+ "</div>");

				++i;
			}

			rs.close();
			ps.close();

			sb.append("</div>");

			aseUtil = null;
		} catch (SQLException e) {
			logger.fatal("IniDB: editSystemINI - " + e.toString());
		} catch (Exception e) {
			logger.fatal("IniDB: editSystemINI - " + e.toString());
		}

		return sb.toString();

	}

	/*
	 * getSysSettings
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getSysSettings(Connection conn,String campus,String category) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id,kid,kdesc,kval1,klanid,kdate "
							+ "FROM tblini "
							+ "WHERE campus=? "
							+ "AND category=? "
							+ "AND kedit='Y' "
							+ "ORDER BY seq";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,category);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											""+rs.getInt("id"),
											AseUtil.nullToBlank(rs.getString("kid")),
											AseUtil.nullToBlank(rs.getString("kdesc")),
											AseUtil.nullToBlank(rs.getString("kval1")),
											AseUtil.nullToBlank(rs.getString("klanid")),
											ae.ASE_FormatDateTime(rs.getString("kdate"),Constant.DATE_DATETIME),
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
			logger.fatal("IniDB - getSysSettings: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("IniDB - getSysSettings: " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * getKid
	 *	<p>
	 *	@param	conn	Connection
	 * @param	id		String
	 *	<p>
	 *	@return int
	 */
	public static String getKid(Connection conn,String id) {

		String kid = "";

		try {
			if (id != null && NumericUtil.isInteger(id)){
				String sql = "SELECT kid FROM tblIni WHERE id =?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,Integer.parseInt(id));
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					kid = AseUtil.nullToBlank(rs.getString("kid"));
				}
				rs.close();
				ps.close();
			}
		} catch(SQLException ex) {
			logger.fatal("IniDB: getKid - " + ex.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: getKid - " + ex.toString());
		}

		return kid;
	}

	/*
	 * isValidCategory
	 *	<p>
	 *	@param	conn			Connection
	 * @param	campus		String
	 * @param	category		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isValidCategory(Connection conn,String campus,String category) throws SQLException {
		String sql = "SELECT id FROM tblIni WHERE campus=? AND category=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,category);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * getScript
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	category String
	 * @param	kid		String
	 *	<p>
	 *	@return String
	 */
	public static String getScript(Connection conn,String campus,String category,String kid) {

		String script = "";

		try {
			String sql = "SELECT script FROM tblIni WHERE campus=? AND category=? AND kid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,kid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				script = AseUtil.nullToBlank(rs.getString("script"));
			}
			rs.close();
			ps.close();
		} catch(SQLException ex) {
			logger.fatal("IniDB: getScript - " + ex.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: getScript - " + ex.toString());
		}

		return script;
	}

	/*
	 * setScript
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	category String
	 * @param	kid		String
	 *	<p>
	 *	@return int
	 */
	public static int setScript(Connection conn,String campus,String category,String kid) {

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblIni SET kval1='1',script='' WHERE campus=? AND category=? AND kid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,category);
			ps.setString(3,kid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch(SQLException ex) {
			logger.fatal("IniDB: setScript - " + ex.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: setScript - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateRouting
	 *	<p>
	 *	@param	conn		Connection
	 * @param	college	String
	 * @param	dept		String
	 * @param	level		String
	 *	<p>
	 *	@return int
	 */
	public static int updateRouting(Connection conn,int id,String college,String dept,String level,String user) {

		int rowsAffected = 0;
		try {
			String sql = "UPDATE tblIni SET kval1=?,kval2=?,kval3=?,klanid=?,kdate=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,college);
			ps.setString(2,dept);
			ps.setString(3,level);
			ps.setString(4,user);
			ps.setString(5,AseUtil.getCurrentDateTimeString());
			ps.setInt(6,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch(SQLException e) {
			logger.fatal("IniDB: updateRouting - " + e.toString());
		} catch(Exception e){
			logger.fatal("IniDB: updateRouting - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getKval
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kid		String
	 * @param	kval		String
	 *	<p>
	 *	@return int
	 */
	public static String getKval(Connection conn,String campus,String kid,String kval) {

		String value = "";

		try {
			String sql = "SELECT " + kval + " FROM tblIni WHERE campus=? AND category='System' AND kid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				value = AseUtil.nullToBlank(rs.getString(kval));
			}
			rs.close();
			ps.close();
		} catch(SQLException ex) {
			logger.fatal("IniDB: getKval - " + ex.toString());
		} catch(Exception ex){
			logger.fatal("IniDB: getKval - " + ex.toString());
		}

		return value;
	}

	/*
	 * getItem
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kid		String
	 * @param	column	String
	 *	<p>
	 *	@return String
	 */
	public static String getItem(Connection conn,String campus,String kid,String column) {

		String item = "";

		try {
			String sql = "SELECT "+column+" FROM tblIni WHERE campus=? AND category='System' AND kid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			}
			rs.close();
			ps.close();
		} catch(SQLException e) {
			logger.fatal("IniDB: getItem - " + e.toString());
		} catch(Exception e){
			logger.fatal("IniDB: getItem - " + e.toString());
		}

		return item;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}