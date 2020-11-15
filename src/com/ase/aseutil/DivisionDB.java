/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *	public static Division getCampusDivision(Connection conn,int id) {
 *	public static String getChairName(Connection conn,String campus,String division) {
 * public static String getDivision(Connection conn,String campus,String division)
 *	public static String getDivisionDDL(Connection conn,String campus,String division,String controlName){
 *	public static String getDivisonCodeFromID(Connection conn,String campus,int divid) {
 *	public static String getDivisonNameFromID(Connection conn,String campus,int divid) {
 *	public static boolean isChair(Connection conn,String campus,String division,String user) {
 *
 * @author ttgiang
 */

//
// DivisionDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class DivisionDB {
	static Logger logger = Logger.getLogger(DivisionDB.class.getName());

	public DivisionDB() throws Exception {}

	/*
	 * getDivision - returns the discipline name
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		campus
	 *	@param	String		division
	 *	<p>
	 *	@return 	String
	 */
	public static String getDivision(Connection conn,String campus,String division) {

		String div = "";
		String sql = "SELECT DIVS_DESCRIPTION from BannerDivision WHERE DIVISION_CODE=?";

		// we want rely on banner for most data but in the past, campuses have created
		// their own so when necessary, go back to the campus for data
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, division);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				div = AseUtil.nullToBlank(resultSet.getString(1)).trim();
			}
			else{
				resultSet.close();
				sql = "SELECT divisionname from tblDivision WHERE campus=? AND divisioncode=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,division);
				resultSet = ps.executeQuery();
				if (resultSet.next()) {
					div = AseUtil.nullToBlank(resultSet.getString(1)).trim();
				}
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivision\n" + e.toString());
		}

		return div;
	}

	/*
	 * getCampusDivision
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	<p>
	 *	@return 	Division
	 */
	public static Division getCampusDivision(Connection conn,int id) {

		Division division = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * from tblDivision WHERE divid=?");
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				division = new Division();
				division.setDivisionCode(AseUtil.nullToBlank(rs.getString("divisionCode")));
				division.setDivisionName(AseUtil.nullToBlank(rs.getString("divisionName")));
				division.setChairName(AseUtil.nullToBlank(rs.getString("chairName")));
				division.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
				division.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: getCampusDivision - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DivisionDB: getCampusDivision - " + e.toString());
		}

		return division;
	}

	/*
	 * getDivisionByCampusCode
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 * @param	code
	 *	<p>
	 *	@return 	Division
	 */
	public static Division getDivisionByCampusCode(Connection conn,String campus,String code) {

		Division division = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM tblDivision WHERE campus=? AND divisioncode=?");
			ps.setString(1,campus);
			ps.setString(2,code);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				division = new Division();
				division.setDivid(rs.getInt("divid"));
				division.setDivisionCode(AseUtil.nullToBlank(rs.getString("divisionCode")));
				division.setDivisionName(AseUtil.nullToBlank(rs.getString("divisionName")));
				division.setChairName(AseUtil.nullToBlank(rs.getString("chairName")));
				division.setDelegated(AseUtil.nullToBlank(rs.getString("delegated")));
				division.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: getDivisionByCampusCode - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisionByCampusCode - " + e.toString());
		}

		return division;
	}

	/*
	 * deleteDivision
	 *	<p>
	 *	@param	conn
	 * @param	id
	 *	<p>
	 *	@return	int
	 */
	public static int deleteDivision(Connection conn,int id) {
		int rowsAffected = 0;
		String sql = "DELETE FROM tblDivision WHERE divid=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB - deleteDivision: " + e.toString());
		}
		return rowsAffected;
	}


	/*
	 * insertDivision
	 *	<p>
	 *	@param	conn	Connection
	 * @param	alpha	Alpha
	 *	<p>
	 *	@return	boolean
	 */
	public static int insertDivision(Connection conn, Division division) {
		int rowsAffected = 0;
		String sql = "INSERT INTO tblDivision (divisioncode,divisionname,campus,chairname,delegated) VALUES (?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,division.getDivisionCode());
			ps.setString(2,division.getDivisionName());
			ps.setString(3,division.getCampus());
			ps.setString(4,division.getChairName());
			ps.setString(5,division.getDelegated());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB - insertDivision: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn				Connection
	 * @param	campus			String
	 * @param	divisionCode	String
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String divisionCode) throws SQLException {
		String sql = "SELECT divisioncode FROM tblDivision WHERE campus=? AND divisioncode=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,divisionCode);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * updateDivision
	 *	<p>
	 *	@param	conn
	 * @param	Division
	 *	<p>
	 *	@return	int
	 */
	public static int updateDivision(Connection conn, Division division) {
		int rowsAffected = 0;
		String sql = "UPDATE tblDivision SET divisioncode=?,divisionname=?,chairname=?,delegated=? WHERE divid=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,division.getDivisionCode());
			ps.setString(2,division.getDivisionName());
			ps.setString(3,division.getChairName());
			ps.setString(4,division.getDelegated());
			ps.setInt(5,division.getDivid());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB - updateDivision: " + e.toString());
		}
		return rowsAffected;
	}

	/**
	 * getChairName
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	division
	 * <p>
	 * @return	String
	 */
	public static String getChairName(Connection conn,String campus,String division) {

		//Logger logger = Logger.getLogger("test");

		String chairName = "";

		try {
			String sql = "SELECT chairname FROM tbldivision WHERE campus=? AND divisioncode=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				chairName = AseUtil.nullToBlank(rs.getString("chairname"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: getChairName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DivisionDB: getChairName - " + ex.toString());
		}

		return chairName;
	}

	/**
	 * getDelegated
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	division
	 * <p>
	 * @return	String
	 */
	public static String getDelegated(Connection conn,String campus,String division) {

		//Logger logger = Logger.getLogger("test");

		String delegated = "";

		try {
			String sql = "SELECT delegated FROM tbldivision WHERE campus=? AND divisioncode=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,division);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: getDelegated - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DivisionDB: getDelegated - " + ex.toString());
		}

		return delegated;
	}

	/**
	 * isChair
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	division
	 * @param	user
	 * <p>
	 * @return	boolean
	 */
	public static boolean isChair(Connection conn,String campus,String division,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean chair = false;

		try {
			String sql = "SELECT chairname FROM tbldivision WHERE campus=? AND divisioncode=? AND chairname=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,division);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			chair = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: isChair - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DivisionDB: isChair - " + ex.toString());
		}

		return chair;
	}

	/**
	 * isChair
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	alpha
	 * @param	user
	 * <p>
	 * @return	boolean
	 */
	public static boolean isChairByAlpha(Connection conn,String campus,String alpha,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean chair = false;

		try {
			String sql = "SELECT chairname "
							+ "FROM vw_ProgramDepartmentChairs "
							+ "WHERE campus=? "
							+ "AND coursealpha=? "
							+ "AND chairname=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			chair = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: isChairByAlpha - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DivisionDB: isChairByAlpha - " + ex.toString());
		}

		return chair;
	}

	/**
	 * isDelegated
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	division
	 * @param	user
	 * <p>
	 * @return	boolean
	 */
	public static boolean isDelegated(Connection conn,String campus,String division,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean delegated = false;

		try {
			String sql = "SELECT delegated FROM tbldivision WHERE campus=? AND divisioncode=? AND delegated=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,division);
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			delegated = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DivisionDB: isDelegated - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DivisionDB: isDelegated - " + ex.toString());
		}

		return delegated;
	}

	/*
	 * getDivisonNameFromID - returns the discipline name
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	divid
	 *	<p>
	 *	@return 	String
	 */
	public static String getDivisonNameFromID(Connection conn,String campus,int divid) {

		String div = "";
		String sql = "SELECT divisionname from tblDivision WHERE campus=? AND divid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,divid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				div = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisonNameFromID\n" + e.toString());
		}

		return div;
	}

	/*
	 * getDivisonCodeFromID - returns the discipline name
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	divid
	 *	<p>
	 *	@return 	String
	 */
	public static String getDivisonCodeFromID(Connection conn,String campus,int divid) {

		String div = "";
		String sql = "SELECT divisioncode from tblDivision WHERE campus=? AND divid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,divid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				div = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisonCodeFromID\n" + e.toString());
		}

		return div;
	}

	/*
	 * getDivisionNameFromCode - returns the discipline name
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	divid
	 *	<p>
	 *	@return 	String
	 */
	public static String getDivisionNameFromCode(Connection conn,String campus,String code) {

		String div = "";
		String sql = "";

		try {
			sql = "SELECT divisionname from tblDivision WHERE campus=? AND divisioncode=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,code);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				div = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisionNameFromCode - " + e.toString());
		}

		return div;
	}

	/**
	 * getDivisionDDL
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	division		String
	 * @param	controlName	String
	 * <p>
	 * @return	String
	 */
	public static String getDivisionDDL(Connection conn,String campus,String division,String controlName){

		String output = "";

		try{
			String sql = "SELECT divisioncode,divisionname + ' (' + divisioncode + ')' "
							+ "FROM tbldivision "
							+ "WHERE campus='"+campus+"' "
							+ "ORDER BY divisionname";

			AseUtil aseUtil = new AseUtil();

			output = aseUtil.createSelectionBox(conn,sql,controlName,division,"","1",false,"");

			aseUtil = null;
		}
		catch(Exception ex){
			logger.fatal("DivisionDB: getDivisionDDL - " + ex.toString());
		}

		return output;
	}

	/**
	 * getDepartmentCount
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	level		int
	 * <p>
	 * @return	int
	 */
	public static int getDepartmentCount(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		int count = 0;

		String sql = "SELECT count(divid) as counter FROM tblDivision WHERE campus=?";
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
			logger.fatal("DivisionDB: getDepartmentCount - " + e.toString());
		}

		return count;
	}

	/*
	 * getChairs
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return Banner
	 */
	public static List<Division> getChairs(Connection conn,String campus) throws Exception {

		List<Division> DivisionData = null;

		try {
			if (DivisionData == null){

            DivisionData = new LinkedList<Division>();

				String sql = "SELECT divid,divisioncode,divisionname,chairname,delegated,campus "
							+ "FROM tblDivision WHERE campus=? ORDER BY divisioncode";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	DivisionData.add(new Division(
										rs.getInt("divid"),
										AseUtil.nullToBlank(rs.getString("divisionCode")),
										AseUtil.nullToBlank(rs.getString("divisionName")),
										AseUtil.nullToBlank(rs.getString("campus")),
										AseUtil.nullToBlank(rs.getString("chairName")),
										AseUtil.nullToBlank(rs.getString("delegated"))
									));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("DivisionDB: getChairs\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("DivisionDB: getChairs\n" + e.toString());
			return null;
		}

		return DivisionData;
	}

	/*
	 * saveDivisionToRouting - associate divisions to a particular routing sequence
	 * <p>
	 * @param	conn		Connection
	 * @param	route		int
	 * @param	divs		String
	 * <p>
	 * @return int
	 */
	public static int saveDivisionToRouting(Connection conn,int route,String divs) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblDivRoutes WHERE route=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (divs != null){
				String[] adivs = divs.split(",");
				for(int i=0; i<adivs.length; i++){
					int divid = NumericUtil.stringToInt(adivs[i]);
					if (divid>0){
						sql = "INSERT INTO tblDivRoutes (route,divid) VALUES(?,?)";
						ps = conn.prepareStatement(sql);
						ps.setInt(1,route);
						ps.setInt(2,NumericUtil.stringToInt(adivs[i]));
						rowsAffected = ps.executeUpdate();
						ps.close();
					} // divid
				}
			}

		} catch (Exception e) {
			logger.fatal("DivisionDB: saveDivisionToRouting - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getDivisionsDDL - a listing of all divisions
	 * <p>
	 * @param conn			Connection
	 * @param campus 		String
	 * <p>
	 * @return String
	 */
	public static String getDivisionsDDL(Connection conn,String campus) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer divisions = new StringBuffer();

		try {
			String sql = "SELECT divid, divisioncode + ' ('+chairname+')' AS descr "
							+ "FROM tbldivision "
							+ "WHERE campus=? "
							+ "ORDER BY divisioncode";

			divisions.append("<select class=\'smalltext\' name=\'fromList\' size=\'20\' id=\'fromList\'>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("divid");
				String descr = AseUtil.nullToBlank(rs.getString("descr"));
				divisions.append("<option value=\"" + id  + "\">" + descr + "</option>");
			}
			rs.close();
			ps.close();

			divisions.append("</select>");

		} catch (SQLException e) {
			logger.fatal("DivisionDB: getDivisionsDDL - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisionsDDL - " + e.toString());
		}

		return divisions.toString();
	}

	/*
	 * getDivisionsForRouting - a listing of all divisions without routes already selected
	 * <p>
	 * @param conn		Connection
	 * @param campus 	String
	 * @param route	int
	 * <p>
	 * @return String
	 */
	public static String getDivisionsForRouting(Connection conn,String campus,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer divisions = new StringBuffer();

		try {
			String sql = "SELECT divid, divisioncode + ' ('+chairname+')' AS descr "
							+ "FROM tbldivision "
							+ "WHERE campus=? "
							+ "AND divid NOT IN "
							+ "( "
							+ "SELECT divid "
							+ "FROM tbldivroutes "
							+ "WHERE route=? "
							+ ") "
							+ "ORDER BY divisioncode";

			divisions.append("<select class=\'smalltext\' name=\'fromList\' size=\'20\' id=\'fromList\'>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("divid");
				String descr = AseUtil.nullToBlank(rs.getString("descr"));
				divisions.append("<option value=\"" + id  + "\">" + descr + "</option>");
			}
			rs.close();
			ps.close();

			divisions.append("</select>");

		} catch (SQLException e) {
			logger.fatal("DivisionDB: getDivisionsForRouting - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisionsForRouting - " + e.toString());
		}

		return divisions.toString();
	}

	/*
	 * getDivisionToRouting - associate divisions to a particular routing sequence
	 * <p>
	 * @param	conn		Connection
	 * @param	route		int
	 * <p>
	 * @return int
	 */
	public static String getDivisionToRouting(Connection conn,int route) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer divisions = new StringBuffer();

		try {
			String sql = "SELECT dr.divid, td.divisioncode + ' (' + td.chairname + ')' AS descr "
							+ "FROM tblDivRoutes dr INNER JOIN "
							+ "tblDivision td ON dr.divid = td.divid "
							+ "WHERE dr.route=? "
							+ "ORDER BY td.divisioncode";

			divisions.append("<select class=\'smalltext\' name=\'toList\' size=\'20\' id=\'toList\'>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("divid");
				String descr = AseUtil.nullToBlank(rs.getString("descr"));
				divisions.append("<option value=\"" + id  + "\">" + descr + "</option>");
			}
			rs.close();
			ps.close();

			divisions.append("</select>");

		} catch (SQLException e) {
			logger.fatal("DivisionDB: getDivisionToRouting - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DivisionDB: getDivisionToRouting - " + e.toString());
		}

		return divisions.toString();
	}

	public void close() throws SQLException {}

}