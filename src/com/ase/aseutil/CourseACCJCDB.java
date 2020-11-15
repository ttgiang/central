/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static int appendComps(Connection,String,String,String,String)
 *	public static Msg courseACCJC(Connection,String,String,String,String,String,String,int,int,int)
 *	public static CourseACCJC getACCJC(Connection,String,int,boolean)
 *	public static float getACCJCID(Connection,String,String,String,String,int,int,int)
 *	public static boolean isACCJCAdded(Connection,String,String,String,int,int,int)
 *	public static int getCompID(Connection,int lid) throws Exception {
 *	public static int getID(Connection,int compID) throws Exception {
 *	public static int setCompletedAssessedTime(Connection,String user,int lid)
 *
 */

//
// CourseACCJCDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class CourseACCJCDB {

	static Logger logger = Logger.getLogger(CourseACCJCDB.class.getName());

	public CourseACCJCDB() throws Exception {}

	/*
	 * getACCJC
	 *	<p>
	 * @param	Connection conn
	 * @param	String		campus
	 * @param	int			lid
	 * @param	String		kix
	 * @param	boolean		descr
	 *	<p>
	 *	@return CourseACCJC
	 */
	public static CourseACCJC getACCJC(Connection conn,
													String campus,
													int lid,
													String kix,
													boolean descr) {

		CourseACCJC accjc = new CourseACCJC();
		String sql;

		if (descr)
			sql = "SELECT * FROM vw_ACCJCDescription WHERE campus=? AND id=? AND historyid=?";
		else
			sql = "SELECT * FROM tblCourseACCJC WHERE campus=? AND id=? AND historyid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,lid);
			ps.setString(3,kix);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				accjc.setID(lid);
				accjc.setCampus(AseUtil.nullToBlank(results.getString("campus")));
				accjc.setCourseAlpha(AseUtil.nullToBlank(results.getString("coursealpha")));
				accjc.setCourseNum(AseUtil.nullToBlank(results.getString("coursenum")));
				accjc.setCourseType(AseUtil.nullToBlank(results.getString("coursetype")));
				accjc.setContentID(results.getInt("contentid"));
				accjc.setCompID(results.getInt("compid"));
				accjc.setAssessmentid(results.getInt("assessmentid"));
				accjc.setAuditDate(AseUtil.nullToBlank(results.getString("auditdate")));
				accjc.setAuditBy(AseUtil.nullToBlank(results.getString("auditby")));

				if (descr){
					accjc.setContent(AseUtil.nullToBlank(results.getString("shortcontent")));
					accjc.setComp(AseUtil.nullToBlank(results.getString("comp")));
					accjc.setAssessment(AseUtil.nullToBlank(results.getString("assessment")));
				}
				else{
					accjc.setContent("");
					accjc.setComp("");
					accjc.setAssessment("");
				}
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseACCJCDB: getACCJC\n" + e.toString());
			return null;
		}

		return accjc;
	}

	/*
	 * getACCJCID
	 *
	 *	<p>
	 *
	 * @param	lid	accjc id
	 * @param	descr	description
	 *
	 *	@return float
	 */
	public static float getACCJCID(Connection conn,
												String campus,
												String alpha,
												String num,
												String type,
												int l1,
												int l2,
												int l3) throws SQLException {

		float accjc = 0;
		String sql;

		sql = "SELECT id " +
			"FROM tblCourseACCJC " +
			"WHERE campus=? AND  " +
			"coursealpha=? AND  " +
			"coursenum=? AND  " +
			"CourseType=? AND  " +
			"ContentID=? AND  " +
			"CompID=? AND  " +
			"Assessmentid=?";
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			preparedStatement.setInt(5, l1);
			preparedStatement.setInt(6, l2);
			preparedStatement.setInt(7, l3);

			ResultSet results = preparedStatement.executeQuery();
			if (results.next()) {
				accjc = results.getInt("id");
			}
			results.close();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("CourseACCJCDB: getACCJCID\n" + e.toString());
		}

		return accjc;
	}

	/*
	 * has ACCJC content been added
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isACCJCAdded(
			Connection connection,
			String campus,
			String alpha,
			String num,
			int l1,
			int l2,
			int l3) throws SQLException {

		boolean added = false;

		try {
			String sql = "SELECT coursealpha FROM tblCourseACCJC WHERE campus=? AND courseAlpha=? AND coursenum=? AND ContentID=? AND CompID=? AND Assessmentid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setInt(4, l1);
			ps.setInt(5, l2);
			ps.setInt(6, l3);
			ResultSet results = ps.executeQuery();
			added = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CourseACCJCDB: isACCJCAdded\n" + e.toString());
		}

		return added;
	}

	/*
	 * Course ACCJC
	 *	<p>
	 *	@return Msg
	 */
	public static Msg courseACCJC(Connection connection,
											String action,
											String user,
											String campus,
											String alpha,
											String num,
											String type,
											int l1,
											int l2,
											int l3) throws SQLException {

		Msg msg = new Msg();

		int rowsAffected = 0;

		try {
			String sql = "";
			PreparedStatement ps = null;

			String kix = Helper.getKix(connection,campus,alpha,num,type);

			/*
			 * for add mode, don't add if already there. for remove, just
			 * proceed
			 */

			// change to assess to avoid further edits
			if (!SLODB.sloProgress(connection,kix,"ASSESS")){
				sql = "UPDATE tblSLO SET progress=?,auditby=?,auditdate=? WHERE hid=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,"ASSESS");
				ps.setString(2,user);
				ps.setString(3,AseUtil.getCurrentDateTimeString());
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			if ("a".equals(action)) {
				if (isACCJCAdded(connection, campus, alpha, num, l1, l2, l3)) {
					msg.setMsg("DuplicateEntry");
					msg.setCode(-1);
				}
				else{
					sql = "INSERT INTO tblCourseACCJC(campus,coursealpha,coursenum,coursetype,ContentID,CompID,Assessmentid,auditby,historyid) " +
						"VALUES(?,?,?,?,?,?,?,?,?)";
					ps = connection.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					ps.setInt(5,l1);
					ps.setInt(6,l2);
					ps.setInt(7,l3);
					ps.setString(8,user);
					ps.setString(9,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
					AseUtil.loggerInfo("CourseACCJCDB: courseACCJC ",campus,action,alpha + " " + num,"");
					msg.setCode(rowsAffected);
					msg.setMsg("Successful");
				}
			}
			else if ("r".equals(action)) {
				float accjcid = 0;

				accjcid = getACCJCID(connection,campus,alpha,num,type,l1,l2,l3);
				if (accjcid > 0){
					try{
						connection.setAutoCommit(false);

						sql = "DELETE FROM tblCourseACCJC WHERE id=?";
						ps = connection.prepareStatement(sql);
						ps.setFloat(1,accjcid);
						rowsAffected = ps.executeUpdate();

						sql = "DELETE FROM tblAssessedData WHERE accjcid=?";
						ps.clearParameters();
						ps = connection.prepareStatement(sql);
						ps.setFloat(1,accjcid);
						rowsAffected = ps.executeUpdate();

						ps.close();

						connection.commit();

						msg.setCode(rowsAffected);
						msg.setMsg("Successful");
						AseUtil.loggerInfo("CourseACCJCDB: courseACCJC ",campus,action,alpha + " " + num,"");

					} catch (SQLException e) {
						msg.setMsg("Exception");
						msg.setCode(-1);
						connection.rollback();
						logger.fatal("CourseACCJCDB: courseACCJC\n" + e.toString());
					} catch (Exception ex) {
						msg.setMsg("Exception");
						msg.setCode(-1);
						connection.rollback();
						logger.fatal("CourseACCJCDB: courseACCJC\n" + ex.toString());
					}
				}
				connection.setAutoCommit(true);
			}
		} catch (SQLException e) {
			msg.setMsg("Exception");
			msg.setCode(-1);
			logger.fatal("CourseACCJCDB: courseACCJC\n" + e.toString());
		} catch (Exception ex) {
			msg.setMsg("Exception");
			msg.setCode(-1);
			logger.fatal("CourseACCJCDB: courseACCJC\n" + ex.toString());
		}

		return msg;
	}

	/*
	 * getCompID
	 *	<p>
	 * @return int
	 */
	public static int getCompID(Connection conn,int lid) throws Exception {

		int compID = 0;

		try{
			String query = "SELECT compid FROM tblCourseACCJC WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, lid);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				compID = results.getInt(1);
			}
			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CourseACCJCDB: getCompID\n" + e.toString());
		}

		return compID;
	}

	/*
	 * getID
	 *	<p>
	 * @return int
	 */
	public static int getID(Connection conn,int compID) throws Exception {

		int id = 0;

		try{
			String query = "SELECT id FROM tblCourseACCJC WHERE compid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, compID);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				id = results.getInt(1);
			}
			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CourseACCJCDB: getID\n" + e.toString());
		}

		return id;
	}

	/*
	 * appendComps add to accjc table any comps not already there
	 *	<p>
	 * @return int
	 */
	public static int appendComps(Connection conn,
											String campus,
											String alpha,
											String num,
											String type) throws Exception {

		int rowsAffected = 0;

		try{
			String sql = "INSERT INTO tblCourseACCJC ( Campus, CourseAlpha, CourseNum, CourseType, CompID, AuditBy ) " +
				"SELECT cc.Campus, cc.CourseAlpha, cc.CourseNum, cc.CourseType, cc.CompID, cc.AuditBy " +
				"FROM tblCourseComp cc " +
				"WHERE cc.Campus=? AND cc.CourseAlpha=? AND cc.CourseNum=? AND cc.CourseType=? AND cc.CompID Not In " +
				"( " +
				"SELECT ac.CompID " +
				"FROM tblCourseACCJC ac " +
				"WHERE ac.Campus=? AND ac.CourseAlpha=? AND ac.CourseNum=? AND ac.CourseType=? " +
				") ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ps.setString(5,campus);
			ps.setString(6,alpha);
			ps.setString(7,num);
			ps.setString(8,type);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("CourseACCJCDB: appendComps\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("CourseACCJCDB: appendComps\n" + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * setCompletedAssessedTime	when all assessments have been approved, update the date and user
	 *	<p>
	 * @return int
	 */
	public static int setCompletedAssessedTime(Connection conn,String user,int lid) throws Exception {

		int rowsAffected = 0;

		try{
			String sql = "UPDATE tblCourseACCJC SET AssessedDate=?, AssessedBy=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,AseUtil.getCurrentDateTimeString());
			ps.setString(2,user);
			ps.setInt(3,lid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("CourseACCJCDB: setCompletedAssessedTime\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("CourseACCJCDB: setCompletedAssessedTime\n" + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}