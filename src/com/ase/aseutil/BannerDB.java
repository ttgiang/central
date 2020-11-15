/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// BannerDB.java
//
package com.ase.aseutil;

import java.io.*;
import java.sql.*;
import java.net.URLConnection;
import java.net.URL;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class BannerDB {

	static Logger logger = Logger.getLogger(BannerDB.class.getName());

	public BannerDB() throws Exception {}

	/*
	 * getBanners
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBanners(Connection conn,String campus,int idx) throws Exception {

		List<Banner> BannerData = null;

		try {
			if (BannerData == null){

            BannerData = new LinkedList<Banner>();

				String sql = "SELECT * FROM banner WHERE INSTITUTION=? ORDER BY crse_alpha,crse_number";

				if (idx > 0){
					sql = "SELECT * FROM banner WHERE INSTITUTION=? AND CRSE_ALPHA like '"+(char)idx+"%' ORDER BY crse_alpha,crse_number";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerData.add(new Banner(
										AseUtil.nullToBlank(rs.getString("CRSE_ALPHA")),
										AseUtil.nullToBlank(rs.getString("CRSE_NUMBER")),
										AseUtil.nullToBlank(rs.getString("CRSE_TITLE")),
										AseUtil.nullToBlank(rs.getString("EFFECTIVE_TERM")),
										AseUtil.nullToBlank(rs.getString("CRSE_DIVISION")),
										AseUtil.nullToBlank(rs.getString("CRSE_DEPT")),
										AseUtil.nullToBlank(rs.getString("MAX_RPT_UNITS")),
										AseUtil.nullToBlank(rs.getString("REPEAT_LIMIT"))
									));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBanners\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBanners\n" + e.toString());
			return null;
		}

		return BannerData;
	}

	/*
	 * getBannerAlphas
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerAlphas(Connection conn,int idx) throws IOException {

		List<Banner> BannerAlphas = null;

		try {
			if (BannerAlphas == null){

            BannerAlphas = new LinkedList<Banner>();

				String sql = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION FROM BannerAlpha ORDER BY COURSE_ALPHA";

				if (idx > 0){
					sql = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION FROM BannerAlpha WHERE COURSE_ALPHA like '"+(char)idx+"%' ORDER BY COURSE_ALPHA";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerAlphas.add(new Banner(
														AseUtil.nullToBlank(rs.getString("COURSE_ALPHA")),
														"",
														AseUtil.nullToBlank(rs.getString("ALPHA_DESCRIPTION")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerAlphas\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerAlphas\n" + e.toString());
			return null;
		}

		return BannerAlphas;
	}

	/*
	 * getBannerColleges
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerColleges(Connection conn,int idx) throws IOException {

		List<Banner> BannerColleges = null;

		try {
			if (BannerColleges == null){

            BannerColleges = new LinkedList<Banner>();

				String sql = "SELECT COLLEGE_CODE,COLL_DESCRIPTION FROM BannerCollege ORDER BY COLLEGE_CODE";

				if (idx > 0){
					sql = "SELECT COLLEGE_CODE,COLL_DESCRIPTION FROM BannerCollege WHERE COLLEGE_CODE like '"+(char)idx+"%' ORDER BY COLLEGE_CODE";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerColleges.add(new Banner(
														AseUtil.nullToBlank(rs.getString("COLLEGE_CODE")),
														"",
														AseUtil.nullToBlank(rs.getString("COLL_DESCRIPTION")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerColleges\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerColleges\n" + e.toString());
			return null;
		}

		return BannerColleges;
	}

	/*
	 * getBannerLevels
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerLevels(Connection conn,int idx) throws IOException {

		List<Banner> BannerColleges = null;

		try {
			if (BannerColleges == null){

            BannerColleges = new LinkedList<Banner>();

				String sql = "SELECT level_code,level_descr FROM BannerLevel ORDER BY level_code";

				if (idx > 0){
					sql = "SELECT level_code,level_descr FROM BannerLevel WHERE level_code like '"+(char)idx+"%' ORDER BY level_code";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerColleges.add(new Banner(
														AseUtil.nullToBlank(rs.getString("level_code")),
														"",
														AseUtil.nullToBlank(rs.getString("level_descr")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerLevels\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerLevels\n" + e.toString());
			return null;
		}

		return BannerColleges;
	}

	/*
	 * getBannerDepartments
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerDepartments(Connection conn,int idx) throws IOException {

		List<Banner> BannerDepartments = null;

		try {
			if (BannerDepartments == null){

            BannerDepartments = new LinkedList<Banner>();

				String sql = "SELECT DEPT_CODE,DEPT_DESCRIPTION FROM BannerDept ORDER BY DEPT_CODE";

				if (idx > 0){
					sql = "SELECT DEPT_CODE,DEPT_DESCRIPTION FROM BannerDept WHERE DEPT_CODE like '"+(char)idx+"%' ORDER BY DEPT_CODE";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerDepartments.add(new Banner(
														AseUtil.nullToBlank(rs.getString("DEPT_CODE")),
														"",
														AseUtil.nullToBlank(rs.getString("DEPT_DESCRIPTION")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerDepartments\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerDepartments\n" + e.toString());
			return null;
		}

		return BannerDepartments;
	}

	/*
	 * getBannerDivision
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerDivision(Connection conn,int idx) throws IOException {

		List<Banner> BannerDivisions = null;

		try {
			if (BannerDivisions == null){

            BannerDivisions = new LinkedList<Banner>();

				String sql = "SELECT DIVISION_CODE,DIVS_DESCRIPTION FROM BannerDivision ORDER BY DIVISION_CODE";

				if (idx > 0){
					sql = "SELECT DIVISION_CODE,DIVS_DESCRIPTION FROM BannerDivision WHERE DIVISION_CODE like '"+(char)idx+"%' ORDER BY DIVISION_CODE";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerDivisions.add(new Banner(
														AseUtil.nullToBlank(rs.getString("DIVISION_CODE")),
														"",
														AseUtil.nullToBlank(rs.getString("DIVS_DESCRIPTION")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerDivision\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerDivision\n" + e.toString());
			return null;
		}

		return BannerDivisions;
	}

	/*
	 * getBannerTerms
	 * <p>
	 * @return Banner
	 */
	public static List<Banner> getBannerTerms(Connection conn,int idx) throws IOException {

		List<Banner> BannerTerms = null;

		try {
			if (BannerTerms == null){

            BannerTerms = new LinkedList<Banner>();

				String sql = "SELECT TERM_CODE,TERM_DESCRIPTION FROM BannerTerms ORDER BY TERM_CODE";

				if (idx > 0){
					sql = "SELECT TERM_CODE,TERM_DESCRIPTION FROM BannerTerms WHERE TERM_CODE like '"+(char)idx+"%' ORDER BY TERM_CODE";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	BannerTerms.add(new Banner(
														AseUtil.nullToBlank(rs.getString("TERM_CODE")),
														"",
														AseUtil.nullToBlank(rs.getString("TERM_DESCRIPTION")),
														"",
														"",
														"",
														"",
														""
													));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBannerTerms\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("BannerDB: getBannerTerms\n" + e.toString());
			return null;
		}

		return BannerTerms;
	}

	/*
	 * getBanner
	 * <p>
	 * @return Banner
	 */
	public static Banner getBanner(Connection conn,String campus) throws IOException {

		Banner banner = new Banner();
		int i = 1;
		try {
			String sql = "SELECT * FROM banner WHERE INSTITUTION=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				banner.setId(rs.getInt(i++));
				banner.setINSTITUTION(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_ALPHA(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_NUMBER(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setEFFECTIVE_TERM(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_TITLE(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_LONG_TITLE(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_DIVISION(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_DEPT(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCRSE_COLLEGE(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setMAX_RPT_UNITS(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setREPEAT_LIMIT(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCREDIT_HIGH(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCREDIT_LOW(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCREDIT_IND(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCONT_HIGH(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCONT_LOW(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setCONT_IND(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLAB_HIGH(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLAB_LOW(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLAB_IND(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLECT_HIGH(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLECT_LOW(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setLECT_IND(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setOTH_HIGH(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setOTH_LOW(AseUtil.nullToBlank(rs.getString(i++)));
				banner.setOTH_IND(AseUtil.nullToBlank(rs.getString(i++)));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBanner\n" + e.toString());
			return null;
		}

		return banner;
	}

	/*
	 * getBanner
	 * <p>
	 * @return Banner
	 */
	public static Banner getBanner(Connection connection,
											String subj,
											String crsno,
											String campus) throws IOException {

		Banner banner = new Banner();
		int i = 1;
		try {
			String sql = "SELECT * FROM banner WHERE INSTITUTION=? AND CRSE_ALPHA=? AND CRSE_NUMBER=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, subj);
			ps.setString(3, crsno);
			ResultSet result = ps.executeQuery();
			if (result.next()) {
				banner.setId(result.getInt(i++));
				banner.setINSTITUTION(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_ALPHA(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_NUMBER(AseUtil.nullToBlank(result.getString(i++)));
				banner.setEFFECTIVE_TERM(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_TITLE(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_LONG_TITLE(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_DIVISION(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_DEPT(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCRSE_COLLEGE(AseUtil.nullToBlank(result.getString(i++)));
				banner.setMAX_RPT_UNITS(AseUtil.nullToBlank(result.getString(i++)));
				banner.setREPEAT_LIMIT(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCREDIT_HIGH(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCREDIT_LOW(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCREDIT_IND(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCONT_HIGH(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCONT_LOW(AseUtil.nullToBlank(result.getString(i++)));
				banner.setCONT_IND(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLAB_HIGH(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLAB_LOW(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLAB_IND(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLECT_HIGH(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLECT_LOW(AseUtil.nullToBlank(result.getString(i++)));
				banner.setLECT_IND(AseUtil.nullToBlank(result.getString(i++)));
				banner.setOTH_HIGH(AseUtil.nullToBlank(result.getString(i++)));
				banner.setOTH_LOW(AseUtil.nullToBlank(result.getString(i++)));
				banner.setOTH_IND(AseUtil.nullToBlank(result.getString(i++)));
			}
			result.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("BannerDB: getBanner\n" + e.toString());
			return null;
		}

		return banner;
	}

	/*
	 * bannerExists
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * <p>
	 * @return boolean
	 */
	public static boolean bannerExists(Connection connection,
													String campus,
													String alpha,
													String num) throws IOException {

		boolean exists = false;

		try {
			String sql = "SELECT * FROM banner WHERE INSTITUTION=? AND CRSE_ALPHA=? AND CRSE_NUMBER=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet result = ps.executeQuery();
			exists = result.next();
			result.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("BannerDB: exists\n" + e.toString());
		}

		return exists;
	}


	/*
	 *	processAlpha
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processAlpha(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "banneralpha";
		String toTable = "zzzalpha";
		String columns = "COURSE_ALPHA,ALPHA_DESCRIPTION";
		String where = "COURSE_ALPHA=? AND ALPHA_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{
			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("COURSE_ALPHA");
				num = rs.getString("ALPHA_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processAlpha: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processAlpha: " + ex.toString());
		}

		return "Alpha: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	processBanner
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processBanner(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String campus = "";
		String alpha = "";
		String num = "";
		String term = "";

		// if the course is not in the new table, delete it
		try{
			String sql = "SELECT ID,INSTITUTION, CRSE_ALPHA, CRSE_NUMBER, EFFECTIVE_TERM "
					+ "FROM banner ORDER BY INSTITUTION, CRSE_ALPHA, CRSE_NUMBER";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()){
				id = rs.getInt("id");
				campus = rs.getString("INSTITUTION");
				alpha = rs.getString("CRSE_ALPHA");
				num = rs.getString("CRSE_NUMBER");
				term = rs.getString("EFFECTIVE_TERM");

				sql = "SELECT ID FROM zzzbanner "
					+ "WHERE INSTITUTION=? AND CRSE_ALPHA=? AND CRSE_NUMBER=? AND EFFECTIVE_TERM=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,term);
				rs2 = ps.executeQuery();
				if (rs2.next()){
					sql = "DELETE FROM banner WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,id);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();
			}
			rs.close();

			sql = "INSERT INTO banner SELECT * FROM zzzbanner";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("processBanner: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processBanner: " + ex.toString());
		}

		return "Banner: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	processCollege
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processCollege(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerCollege";
		String toTable = "zzzcollege";
		String columns = "COLLEGE_CODE,COLL_DESCRIPTION";
		String where = "COLLEGE_CODE=? AND COLL_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("COLLEGE_CODE");
				num = rs.getString("COLL_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processCollege: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processCollege: " + ex.toString());
		}

		return "College: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	processDept
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processDept(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerDept";
		String toTable = "zzzdept";
		String columns = "DEPT_CODE,DEPT_DESCRIPTION";
		String where = "DEPT_CODE=? AND DEPT_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("DEPT_CODE");
				num = rs.getString("DEPT_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processDept: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processDept: " + ex.toString());
		}

		return "Dept: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	processDivision
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processDivision(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerDivision";
		String toTable = "zzzdivision";
		String columns = "DIVISION_CODE,DIVS_DESCRIPTION";
		String where = "DIVISION_CODE=? AND DIVS_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("DIVISION_CODE");
				num = rs.getString("DIVS_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processDivision: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processDivision: " + ex.toString());
		}

		return "Division: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	processTerm
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return String
	*/
	public static String processTerm(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int id = 0;
		int deleted = 0;
		int rowsAffected = 0;
		int loopCounter = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement ps = null;
		String alpha = "";
		String num = "";

		String fromTable = "BannerTerms";
		String toTable = "zzzterm";
		String columns = "TERM_CODE,TERM_DESCRIPTION";
		String where = "TERM_CODE=? AND TERM_DESCRIPTION=?";

		// if the course is not in the new table, delete it
		try{


			String sql = "SELECT " + columns
					+ " FROM " + fromTable
					+ " ORDER BY " + columns;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()){
				alpha = rs.getString("TERM_CODE");
				num = rs.getString("TERM_DESCRIPTION");

				sql = "SELECT " + columns
					+ " FROM " + toTable
					+ " WHERE " + where;
				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				rs2 = ps.executeQuery();

				if (rs2.next()){
					sql = "DELETE FROM " + fromTable
						+ " WHERE " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					rowsAffected = ps.executeUpdate();
					++deleted;
				}
				rs2.close();

			}
			rs.close();
			ps.close();

			sql = "INSERT INTO " + fromTable + " ("+columns+") SELECT "+columns+" FROM " + toTable;
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();


		}
		catch(SQLException sx){
			logger.fatal("processTerm: " + sx.toString());
		} catch(Exception ex){
			logger.fatal("processTerm: " + ex.toString());
		}

		return "Terms: deleted " + deleted + "; inserted " + rowsAffected + " rows";
	}

	/*
	 *	addBannerToCourse
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return String
	*/
	public static String addBannerToCourse(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		String campus = "";
		String sql = "";

		logger.info("------------- BannerDB.addBannerToCourse - START");

		try{
			sql = "SELECT campus FROM tblCampus ORDER BY campus";
			PreparedStatement	ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				campus = AseUtil.nullToBlank(rs.getString("campus"));
				if (campus != null && campus.length()>0){
					rowsAffected = addBannerToCourseX(conn,campus);
					logger.info(campus + " - added " + rowsAffected + " rows");
				}
			}
			rs.close();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("BannerDB.addBannerToCourse: " + se.toString());
		}
		catch(Exception e){
			logger.fatal("BannerDB.addBannerToCourse: " + e.toString());
		}

		logger.info("------------- BannerDB.addBannerToCourse - END");

		return "Outlines: appended " + rowsAffected + " rows";
	}

	public static int addBannerToCourseX(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String sqlBanner = "";

		// there are the minimal fields required to create tblCourse entry
		String id = "";
		String kix = "";
		String alpha = "";
		String num = "";
		String type = "CUR";
		String edit = "1";
		String progress = "APPROVED";
		String edit1 = "1";
		String edit2 = "1";
		String dept = "";			// banner - crse_dept
		String div = "";			// banner - crse_division
		String title = "";		// banner - crse_title
		String credits = "";		// banner - credit_low
		String terms = "";		// banner - effective_term

		int i = 1012;				// to help create random history id
		int rowsAffected = 0;

		PreparedStatement	ps = null;
		PreparedStatement	psBanner = null;
		PreparedStatement	psCourse = null;

		ResultSet rs = null;
		ResultSet rsBanner = null;
		ResultSet rsCourse = null;

		try{
			AseUtil aseUtil = new AseUtil();

			// select banner alpha and number that is not already in the course table
			// for every outline found in banner and not in course, add to course and campus
			sql = "SELECT "
				+ "	CRSE_ALPHA, CRSE_NUMBER "
				+ "FROM  "
				+ "	( "
				+ "		SELECT  "
				+ "			DISTINCT CRSE_ALPHA, CRSE_NUMBER, CRSE_ALPHA + '-' + CRSE_NUMBER AS cn "
				+ "		FROM  "
				+ "			BANNER "
				+ "		WHERE  "
				+ "			INSTITUTION=? "
				+ "		) t1 "
				+ "WHERE ( "
				+ "		cn NOT IN "
				+ "		( "
				+ "			SELECT  "
				+ "				DISTINCT CourseAlpha + '-' + CourseNum AS CN "
				+ "			FROM   "
				+ "				tblCourse "
				+ "			WHERE  "
				+ "				campus=? "
				+ "		) "
				+ "	) "
				+ "ORDER BY cn ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = rs.getString(1);
				num = rs.getString(2);

				// update course only if not yet done
				sqlBanner = "SELECT id FROM tblCourse "
					+ "WHERE campus=? AND CourseAlpha=? AND CourseNum=?";
				psCourse = conn.prepareStatement(sqlBanner);
				psCourse.setString(1,campus);
				psCourse.setString(2,alpha);
				psCourse.setString(3,num);
				rsCourse = psCourse.executeQuery();
				if (!rsCourse.next()){

					++rowsAffected;

					// history id
					++i;
					kix = SQLUtil.createHistoryID(1) + i;
					id = kix;

					// retrieve banner data
					sqlBanner = "SELECT crse_dept,crse_division,crse_title,credit_low,effective_term "
						+ "FROM banner "
						+ "WHERE institution=? AND crse_alpha=? AND crse_number=?";
					psBanner = conn.prepareStatement(sqlBanner);
					psBanner.setString(1,campus);
					psBanner.setString(2,alpha);
					psBanner.setString(3,num);
					rsBanner = psBanner.executeQuery();
					if (rsBanner.next()){
						dept = aseUtil.nullToBlank(rsBanner.getString("crse_dept"));
						div = aseUtil.nullToBlank(rsBanner.getString("crse_division"));
						title = aseUtil.nullToBlank(rsBanner.getString("crse_title"));
						credits = aseUtil.nullToBlank(rsBanner.getString("credit_low"));
						terms = aseUtil.nullToBlank(rsBanner.getString("effective_term"));
					}
					rsBanner.close();
					psBanner.close();

					// add to course
					sqlBanner = "INSERT INTO tblCourse (id,historyid,campus,CourseAlpha,CourseNum,"
						+ "CourseType,edit,Progress,edit1,edit2,dispID,Division,coursetitle,"
						+ "credits,effectiveterm,auditdate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					psCourse = conn.prepareStatement(sqlBanner);
					psCourse.setString(1,id);
					psCourse.setString(2,kix);
					psCourse.setString(3,campus);
					psCourse.setString(4,alpha);
					psCourse.setString(5,num);
					psCourse.setString(6,type);
					psCourse.setString(7,edit);
					psCourse.setString(8,progress);
					psCourse.setString(9,edit1);
					psCourse.setString(10,edit2);
					psCourse.setString(11,dept);
					psCourse.setString(12,div);
					psCourse.setString(13,title);
					psCourse.setString(14,credits);
					psCourse.setString(15,terms);
					psCourse.setString(16,aseUtil.getCurrentDateTimeString());
					psCourse.executeUpdate();

					// update campus data
					sqlBanner = "INSERT INTO tblCampusdata (id,historyid,campus,CourseAlpha,CourseNum,CourseType,auditby,auditdate) VALUES(?,?,?,?,?,?,?,?)";
					psCourse = conn.prepareStatement(sqlBanner);
					psCourse.setInt(1,CampusDB.getNextCampusDataID(conn));
					psCourse.setString(2,kix);
					psCourse.setString(3,campus);
					psCourse.setString(4,alpha);
					psCourse.setString(5,num);
					psCourse.setString(6,type);
					psCourse.setString(7,Constant.SYSADM_NAME);
					psCourse.setString(8,aseUtil.getCurrentDateTimeString());
					psCourse.executeUpdate();

					logger.info(campus + " - " + kix + " - " + alpha + " - " + num + " - " + title);
				}
				rsCourse.close();
				psCourse.close();
			}
			rs.close();
			ps.close();
		}
		catch( SQLException e ){
			logger.fatal("BannerDB: addBannerToCourse - " + e.toString() + " (" + campus + " - " + alpha + " - " + num + ")");
		}
		catch( Exception ex ){
			logger.fatal("BannerDB: addBannerToCourse - " + ex.toString() + " (" + campus + " - " + alpha + " - " + num + ")");
		}

		return rowsAffected;
	}

	/*
	 * getBannerContent
	 * <p>
	 * @param	campus	String
	 * @param	term		String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return getBannerContent
	 */
	public static String getBannerContent(String campus,String term,String alpha,String num) throws IOException {

		//Logger logger = Logger.getLogger("test");

		String link = "https://www.sis.hawaii.edu/uhdad/bwckctlg.p_disp_course_detail?";
		String parmTerm = "cat_term_in=";
		String parmCampus = "inst_in=";
		String parmAlpha = "subj_code_in=";
		String parmNum = "crse_numb_in=";

		String banner = "";

		link = link + parmTerm + term + "&" + parmCampus + campus + "&" + parmAlpha + alpha + "&" + parmNum + num;

		try{
			URL url = new URL(link);

			URLConnection conn = url.openConnection();

			String encoding = conn.getContentEncoding();

			if (encoding == null) {
				encoding = "ISO-8859-1";
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), encoding));

			StringBuilder sb = new StringBuilder(16384);

			try {
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line);
					sb.append('\n');
				}
			} finally {
				br.close();
			}

			int end = 0;
			int start = 0;

			boolean dataFound = false;

			String bannerTag = "<TABLE  CLASS=\"datadisplaytable\" SUMMARY=\"This table lists the course detail for the selected term.\" WIDTH=\"100%\">";

			try{
				if (sb != null){
					String temp = sb.toString();

					// looking for the banner
					start = temp.indexOf(bannerTag);
					if (start > -1){
						end = temp.indexOf("</TABLE>",start);
						if (end > start){
							banner = temp.substring(start,end+8);
						}

						dataFound = true;
					}

					if (dataFound){
						banner = banner.replace("nttitle","textblackth");
						banner = banner.replace("ntdefault","datacolumn");
						banner = banner.replace("fieldlabeltext","textblackth");
						banner = banner.replace("HREF=\"/uhdad/bwckctlg","target=\"_blank\" HREF=\"https://www.sis.hawaii.edu/uhdad/bwckctlg");
					}
					else{
						banner = "<p>Banner data not available for selected course alpha and number.</p>";
					}
				}
			}
			catch(Exception e){
				logger.fatal("" + e.toString());
			}
		}
		catch(Exception e){
			banner = "<p>Curriculum Central was not able to retrieve Banner data for this course outline.</p>";
			logger.fatal("" + e.toString());
		}

		return banner;
	}

	/*
	 * getBannerSubject
	 * <p>
	 * @param	cn			Connection
	 * @param	update	boolean
	 * <p>
	 * @return String
	 */
	public static String getBannerSubject(Connection cn,boolean update) throws IOException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		StringBuffer buf = new StringBuffer();

		String banner = "";

		String link = "https://www.sis.hawaii.edu/uhdad/bwckctlg.p_disp_cat_term_date?cat_term_in=201210";

		try{
			URL url = new URL(link);

			URLConnection conn = url.openConnection();

			String encoding = conn.getContentEncoding();

			if (encoding == null) {
				encoding = "ISO-8859-1";
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), encoding));

			StringBuilder sb = new StringBuilder(16384);

			try {
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line);
					sb.append('\n');
				}
			} finally {
				br.close();
			}

			int end = 0;
			int start = 0;

			boolean dataFound = false;

			// with the page found, take out onoy the subject section
			String bannerStartTag = "<SELECT NAME=\"sel_subj\" SIZE=\"3\" MULTIPLE ID=\"subj_id\">";
			String bannerEndTag = "</SELECT>";

			try{
				if (sb != null){
					String temp = sb.toString();

					// looking for the banner
					start = temp.indexOf(bannerStartTag);

					if (start > -1){
						end = temp.indexOf(bannerEndTag,start);
						if (end > start){
							banner = temp.substring(start,end+bannerEndTag.length());
						}

						dataFound = true;
					}

					if (dataFound){

						String junk = "";

						String[] subject = new String[2];

						// data coming back is HTML <SELECT> tag with alpha and description
						// the steps below replaces HTML and create commas separating each for
						// extract being done in while loop below.
						banner = banner.replace(bannerStartTag,"");
						banner = banner.replace(bannerEndTag,"");
						banner = banner.replace("<OPTION VALUE=\"","~~");
						banner = banner.replace("\">",",");
						banner = banner.substring(3);

						// make sure we capture the last subject
						temp = banner + "~~";

						end = temp.indexOf("~~");
						while (end > -1){
							// here's a subject
							junk = temp.substring(0,end);
							subject = junk.split(",");

							if (!AlphaDB.isMatch(cn,subject[0])){

								// message header
								if (rowsAffected == 0){
									if (update){
										buf.append("Write" + Html.BR() + Html.BR());
									}
									else{
										buf.append("Test Run" + Html.BR() + Html.BR());
									}
								}

								// only if we are going to update
								if (update){
									AlphaDB.insertAlpha(cn,subject[0],subject[1]);
								}

								++rowsAffected;

								buf.append(rowsAffected + ". " + subject[0] + " - " + subject[1] + Html.BR());
							}

							// reset to next subject
							temp = temp.substring(end+2);

							// start again
							end = temp.indexOf("~~");
						}

						// when nothing is found, show message as well
						if (rowsAffected == 0){
							if (update){
								buf.append("Write: Banner data is up to date");
							}
							else{
								buf.append("Test: Banner data is up to date");
							}
						}

					}
					else{
						buf.append("Banner data not available for selected course alpha and number.");
					}
				}
			}
			catch(Exception e){
				logger.fatal("" + e.toString());
			}
		}
		catch(java.net.ConnectException e){
			buf.append("Unable to extract Banner subjects.");
			logger.fatal("" + e.toString());
		}
		catch(Exception e){
			buf.append("Unable to extract Banner subjects.");
			logger.fatal("" + e.toString());
		}

		return buf.toString();
	}

	/**
	 * isMatchingCode
	 * <p>
	 * @param conn			Connection
	 * @param code			String
	 * @param codeValue	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchingCode(Connection conn,String table,String code,String codeValue) throws SQLException {

		// check whether the banner code exists

		String sql = "SELECT "+code+" FROM "+table+" WHERE "+code+"=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,codeValue);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * isMatchingCodeDescr
	 * <p>
	 * @param conn			Connection
	 * @param code			String
	 * @param descr		String
	 * @param codeValue	String
	 * @param descrValue	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchingCodeDescr(Connection conn,String table,String code,String descr,String codeValue,String descrValue) throws SQLException {

		// check whether the banner code and description exists

		String sql = "SELECT "+code+" FROM "+table+" WHERE "+code+"=? AND "+descr+"=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,codeValue);
		ps.setString(2,descrValue);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 *	updateBannerData
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return String
	*/
	public static String updateBannerData(Connection conn,String type){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int updated = 0;
		int inserted = 0;

		String fromTable = "";
		String toTable = "";
		String columns = "";
		String alias = "";
		String where = "";
		String codeColumn = "";
		String descrColumn = "";

		String codeValue = "";
		String descrValue = "";

		// we only append to exiting tables since it may be used by CC
		try{

			int i = 0;

			if(type.toLowerCase().equals("alpha")){
				fromTable = "zzzalpha";
				toTable = "BannerAlpha";
				columns = "COURSE_ALPHA,ALPHA_DESCRIPTION";
				codeColumn = "COURSE_ALPHA";
				descrColumn = "ALPHA_DESCRIPTION";
			}
			else if(type.toLowerCase().equals("college")){
				fromTable = "zzzcollege";
				toTable = "BannerCollege";
				columns = "COLLEGE_CODE,COLL_DESCRIPTION";
				codeColumn = "COLLEGE_CODE";
				descrColumn = "COLL_DESCRIPTION";
			}
			else if(type.toLowerCase().equals("dept")){
				fromTable = "zzzdept";
				toTable = "BannerDept";
				columns = "dept_code,dept_description";
				codeColumn = "dept_code";
				descrColumn = "dept_description";
			}
			else if(type.toLowerCase().equals("division")){
				fromTable = "zzzDivision";
				toTable = "BannerDivision";
				columns = "DIVISION_CODE,DIVS_DESCRIPTION";
				codeColumn = "DIVISION_CODE";
				descrColumn = "DIVS_DESCRIPTION";
			}
			else if(type.toLowerCase().equals("level")){
				fromTable = "zzzLevel";
				toTable = "BannerLevel";
				columns = "level_code,level_descr";
				codeColumn = "level_code";
				descrColumn = "level_descr";
			}
			else if(type.toLowerCase().equals("terms")){
				fromTable = "zzzTerms";
				toTable = "BannerTerms";
				columns = "term_code,term_description";
				codeColumn = "term_code";
				descrColumn = "term_description";
			}

			boolean debug = false;

			String sql = "SELECT " + columns + " FROM " + fromTable;

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				codeValue = rs.getString(codeColumn);
				descrValue = rs.getString(descrColumn);

				// if the code exists, update the description
				// else if neither, add
				if (BannerDB.isMatchingCode(conn,toTable,codeColumn,codeValue)){

					if(!debug){
						sql = "UPDATE " + toTable + " SET "+descrColumn+"=? WHERE "+codeColumn+"=?" ;
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,descrValue);
						ps2.setString(2,codeValue);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						if (rowsAffected > 0){
							++updated;
						}
					}

				} // match
				else {

					if(!debug){
						sql = "INSERT INTO " + toTable + " ("+columns+") VALUES('"+codeValue+"','"+descrValue+"')";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						rowsAffected = ps2.executeUpdate();
						ps2.close();
						if (rowsAffected > 0){
							++inserted;
						}
					}

				}

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("updateBannerData: " + e.toString() + " - " +  codeValue + " - " + descrValue);
		} catch(Exception e){
			logger.fatal("updateBannerData: " + e.toString() + " - " +  codeValue + " - " + descrValue);
		}

		return type + " - updated: " + updated + "; inserted: " + inserted;

	}

	public void close() throws Exception {}

}