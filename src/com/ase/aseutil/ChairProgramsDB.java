/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static int approvalPendingCount(Connection conn,String campus,String user){
 *	public static String getBannerAlphas(Connection conn,String campus,int programid) throws Exception {
 *	public static String getChairName(Connection conn,String campus,String alpha) {
 *	public static String getDelegatedName(Connection conn,String campus,String alpha) {
 *	public static String getSelectAlphas(Connection conn,String campus,int programid) throws Exception {
 * public static String getSelectAlphasX(Connection conn,String campus,int programid) throws Exception {
 *	public static String requestPacketApproval(Connection conn,String campus,String user,int route){
 *	public static Msg setCourseApprovalPacket(Connection conn,String kix) throws Exception {
 *	public static int setProgramAlphs(Connection conn,int programid,String alphas) throws Exception {
 *
 * @author ttgiang
 */

//
// ChairProgramsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ChairProgramsDB {

	static Logger logger = Logger.getLogger(ChairProgramsDB.class.getName());

	public ChairProgramsDB() throws Exception {}

	/**
	 * getChairName
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	alpha
	 * <p>
	 * @return	String
	 */
	public static String getChairName(Connection conn,String campus,String alpha) {

		String chairName = "";

		try {
			String sql = "SELECT chairname FROM vw_ProgramDepartmentChairs WHERE campus=? AND coursealpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				chairName = AseUtil.nullToBlank(rs.getString("chairname"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ChairProgramsDB: getChairName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ChairProgramsDB: getChairName - " + ex.toString());
		}

		return chairName;
	}

	/**
	 * getDelegatedName
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	alpha
	 * <p>
	 * @return	String
	 */
	public static String getDelegatedName(Connection conn,String campus,String alpha) {

		String delegated = "";

		try {
			String sql = "SELECT delegated FROM vw_ProgramDepartmentChairs WHERE campus=? AND coursealpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ChairProgramsDB: getDelegatedName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ChairProgramsDB: getDelegatedName - " + ex.toString());
		}

		return delegated;
	}

	/*
	 * setCourseApprovalPacket
	 *	<p>
	 *	@param	conn
	 * @param	kix
	 *	<p>
	 *	@return Msg
	 */
	public static Msg setCourseApprovalPacket(Connection conn,String kix) throws Exception {

		return setCourseApprovalPacket(conn,kix,Constant.COURSE_APPROVAL_TEXT,"","");

	}

	public static Msg setCourseApprovalPacket(Connection conn,String kix,String mode) throws Exception {

		return setCourseApprovalPacket(conn,kix,mode,"","");

	}

	public static Msg setCourseApprovalPacket(Connection conn,String kix,String mode,String user,String comments) throws Exception {

		Msg msg = new Msg();

		boolean debug = false;

		int rowsAffected = 0;

		try{

			debug = DebugDB.getDebug(conn,"ChairProgramsDB");

			if (debug) logger.info("----------------------- setCourseApprovalPacket - START");

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];
			String proposer = info[Constant.KIX_PROPOSER];
			String campus = info[Constant.KIX_CAMPUS];
			String historyid = info[Constant.KIX_HISTORYID];
			info = null;

			if(debug){
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("proposer: " + proposer);
				logger.info("historyid: " + historyid);
			}

			String chairName = getChairName(conn,campus,alpha);
			if (chairName == null || chairName.length() == 0){
				msg.setMsg("ApprovalChairNameNotAvailable");
				logger.info("ChairProgramsDB: setCourseApprovalPacket - ApprovalChairNameNotAvailable");
			}
			else{

				// we only want a single task created for approval pending for each alpha/num
				if(mode.equals(Constant.COURSE_DELETE_TEXT)){

					proposer = user;

// modifyoutlinex is called from here also but route is not available for this call
//msg = CourseDelete.setCourseForDelete(conn,kix,user,0,comments);

msg = CourseModify.modifyOutlineX(conn,campus,alpha,num,user,Constant.COURSE_DELETE_TEXT,comments);

// get the kix for the newly created course in PRE
kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					if (!TaskDB.isMatch(conn,chairName,alpha,num,Constant.DELETE_APPROVAL_PENDING_TEXT,campus)){
						rowsAffected = TaskDB.logTask(conn,
																chairName,
																proposer,
																alpha,
																num,
																Constant.DELETE_APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																"ADD",
																type);
						if (debug) logger.info("delete approval pending added - rowsAffected " + rowsAffected);
					}

// initial code was written to accommodate approvals as packet
// to accommodate deletes as packet, we have to include mode to make
// proper adjustments. adjustment must be after task is created
rowsAffected = CourseDB.adjustCourseForDelete(conn,campus,kix,alpha,num);
if (debug) logger.info("adjustCourseForDelete data " + rowsAffected + " rows");

				}
				else{

					String sql = "UPDATE tblCourse SET edit=0,edit0='',progress=? WHERE campus=? AND historyid=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,Constant.COURSE_APPROVAL_PENDING_TEXT);
					ps.setString(2,campus);
					ps.setString(3,historyid);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("course set for packet approval");

					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,Constant.MODIFY_TEXT,campus,"","REMOVE",type);
					if (debug) logger.info("modify task removed - rowsAffected " + rowsAffected);

					if (debug) logger.info("approval mode");

					if (!TaskDB.isMatch(conn,chairName,alpha,num,Constant.APPROVAL_PENDING_TEXT,campus)){
						rowsAffected = TaskDB.logTask(conn,
																chairName,
																proposer,
																alpha,
																num,
																Constant.APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																"ADD",
																type);
						if (debug) logger.info("approval pending added - rowsAffected " + rowsAffected);
					}
				}

				Outlines.trackItemChanges(conn,campus,kix,proposer);

				AseUtil.logAction(conn,
										proposer,
										"ACTION",
										"Approval Pending for " + chairName,alpha,num,campus,kix);

				MailerDB mailerDB = new MailerDB(conn,
															proposer,
															chairName,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalPacketRequest",
															kix,
															proposer);
				if (debug) logger.info("mail sent");
			}

			if (debug) logger.info("----------------------- setCourseApprovalPacket - END");

		}
		catch(SQLException e){
			logger.fatal("ChairProgramsDB - setCourseApprovalPacket: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ChairProgramsDB - setCourseApprovalPacket: " + e.toString());
		}

		return msg;
	}

	/*
	 * approvalPendingCount
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static int approvalPendingCount(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		int tasks = 0;

		try{
			String sql = "SELECT COUNT(historyid) AS counter "
				+ "FROM tblCourse "
				+ "WHERE CourseAlpha IN "
				+ "( "
				+ "SELECT DISTINCT coursealpha "
				+ "FROM vw_ProgramDepartmentChairs "
				+ "WHERE chairname=?) "
				+ "AND Progress='PENDING' "
				+ "AND campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				tasks = rs.getInt(1);
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ChairProgramsDB: approvalPendingCount - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ChairProgramsDB: approvalPendingCount - " + ex.toString());
		}

		return tasks;
	}

	/*
	 * requestPacketApproval
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	route		int
	 *	<p>
	 * @return int
	 */
	public static Msg requestPacketApproval(Connection conn,String campus,String user,int route){

		//Logger logger = Logger.getLogger("test");

		String coursetitle = "";
		String proposer = "";
		String kix = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String subprogress = "";

		int outlinesAvailable = 0;
		int outlineSubmitted = 0;
		Msg msg = new Msg();

		String messageException = "";
		String messageURL = "";
		String messageCode = "";
		String message = "";

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"ChairProgramsDB");

			if (debug) logger.info("------------------- requestPacketApproval - START");

			String sql = "SELECT coursealpha,coursenum,historyid,proposer,coursetitle,progress,subprogress "
				+ "FROM tblCourse "
				+ "WHERE CourseAlpha IN "
				+ "( "
				+ "SELECT DISTINCT coursealpha "
				+ "FROM vw_ProgramDepartmentChairs "
				+ "WHERE chairname=?) "
				+ "AND Progress='PENDING' "
				+ "AND campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				++outlinesAvailable;

				if (debug) logger.info("Outline: " + alpha + " " + num);

				msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,proposer,Constant.COURSE_APPROVAL_TEXT,route,user);

				if (debug) logger.info("Outline submitted");

				// collect and save for sending back
				if ("Exception".equals(msg.getMsg())){
					messageException = "Exception";
					if (debug) logger.info("Exception");
				}
				else if ("forwardURL".equals(msg.getMsg()) ){
					messageURL = "forwardURL";
					if (debug) logger.info("forwardURL");
				}
				else if (!"".equals(msg.getMsg())){
					message = msg.getMsg();
					if (debug) logger.info(message);
				}
				else if ("".equals(msg.getMsg())){
					++outlineSubmitted;

					if (debug) logger.info("Outline submitted by packet approval " + alpha + " " + num);

					AseUtil.logAction(conn,
											proposer,
											"ACTION",
											"Outline submitted for approval by " + user,
											alpha,
											num,
											campus,
											kix);
				}
			}
			rs.close();
			ps.close();

			// cleaning up
			int rowsAffected = 0;
			if(progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT) && subprogress.equals(Constant.COURSE_DELETE_TEXT) ){
				rowsAffected = TaskDB.logTask(conn,user,proposer,"","",Constant.DELETE_APPROVAL_PENDING_TEXT,campus,"","REMOVE","PRE");
			}
			else{
				rowsAffected = TaskDB.logTask(conn,user,proposer,"","",Constant.APPROVAL_PENDING_TEXT,campus,"","REMOVE","PRE");
			}

			if (rowsAffected > 0){
				if (debug) logger.info("task removed");
			}
			else{
				if (debug) logger.info("task not removed");
			}

			// saved data sent back
			if ("Exception".equals(messageException)){
				msg.setMsg("Exception");
			}
			else if ("forwardURL".equals(messageURL)){
				msg.setMsg("Exception");
			}
			else if (!"".equals(msg.getMsg())){
				message = msg.getMsg();
			}
			else if ("".equals(msg.getMsg())){
				//
			}

			progress = "Processed " + outlinesAvailable + " outlines and sent " + outlineSubmitted + " for approval";

			msg.setUserLog(progress);

			if (debug) logger.info("------------------- requestPacketApproval - END");
		}
		catch(SQLException sx){
			logger.fatal("ChairProgramsDB: requestPacketApproval - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("ChairProgramsDB: requestPacketApproval - " + ex.toString());
		}

		return msg;
	}


	/*
	 * getBannerAlphas
	 * <p>
	 * @param conn			Connection
	 * @param campus 		String
	 * @param programid	int
	 * <p>
	 * @return String
	 */
	public static String getBannerAlphas(Connection conn,String campus,int programid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer programs = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String junk = "";

		String alpha = "";
		String descr = "";

		String sql = "";

		try {
			temp.append("\'0\'");

			// get list of names ready set as programs
			junk = getSelectAlphas(conn,campus,programid);

			// use the list of names and make sure we don't include in the
			// list of users from the selectedCampus
			if (junk != null && junk.length() > 0) {
				String[] s = new String[100];
				s = junk.split(",");
				for (int i = 0; i < s.length; i++) {
					temp.append(",\'" + s[i] + "\'");
				}
			}

			sql = "SELECT course_alpha,COURSE_ALPHA + ' - ' + ALPHA_DESCRIPTION "
					+ "FROM BannerAlpha "
					+ "WHERE course_alpha NOT IN (" + temp.toString() + ") ORDER BY course_alpha";

			programs.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'20\' id=\'fromList\'>");

			if (sql != null && sql.length() > 0){
				junk = "";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					alpha = AseUtil.nullToBlank(rs.getString(1));
					descr = AseUtil.nullToBlank(rs.getString(2));
					programs.append("<option value=\"" + alpha + "\">" + descr + "</option>");
				}
				rs.close();
				ps.close();
			}
			programs.append("</select></td></tr></table>");

			junk = programs.toString();
		} catch (Exception e) {
			logger.fatal("ChairProgramsDB: getBannerAlphas - " + e.toString());
		}

		return junk;
	}

	/*
	 * getSelectAlphasX
	 * <p>
	 * @param conn			Connection
	 * @param campus 		String
	 * @param programid	int
	 * <p>
	 * @return String
	 */
	public static String getSelectAlphasX(Connection conn,String campus,int programid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer programs = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String junk = "";

		String alpha = "";
		String descr = "";

		try {
			programs.append("<table border=\"0\"><tr><td><select class=\'smalltext\' name=\'toList\' size=\'20\' id=\'toList\'>");

			String sql = "SELECT tc.coursealpha AS alphas, tc.coursealpha + ' - ' + ba.ALPHA_DESCRIPTION "
				+ "FROM tblDivision tcp INNER JOIN "
				+ "tblChairs tc ON tcp.divid = tc.programid INNER JOIN "
				+ "BannerAlpha ba ON tc.coursealpha = ba.COURSE_ALPHA "
				+ "WHERE tcp.campus=? AND tcp.divid=? "
				+ "ORDER BY tc.coursealpha";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,programid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alpha = AseUtil.nullToBlank(rs.getString(1));
				descr = AseUtil.nullToBlank(rs.getString(2));
				programs.append("<option value=\"" + alpha + "\">" + descr + "</option>");
			}
			rs.close();
			ps.close();

			programs.append("</select></td></tr></table>");

			junk = programs.toString();
		} catch (Exception e) {
			logger.fatal("ChairProgramsDB: getSelectAlphasX - " + e.toString());
		}

		return junk;
	}

	/*
	 * Returns a list of selected alphas
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	programid	int
	 * <p>
	 * @return String
	 */
	public static String getSelectAlphas(Connection conn,String campus,int programid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer alphas = new StringBuffer();
		String temp = "";
		try {
			String sql = "SELECT coursealpha AS alphas "
				+ "FROM tblDivision INNER JOIN "
				+ "tblChairs ON tblDivision.divid = tblChairs.programid "
				+ "WHERE tblDivision.campus=? "
				+ "AND tblDivision.divid=? "
				+ "ORDER BY coursealpha";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,programid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				alphas.append(rs.getString(1) + ",");
			}
			temp = alphas.toString();

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ChairProgramsDB: getSelectAlphas - " + e.toString());
		}

		return temp;
	}

	/*
	 * Returns a list of selected alphas
	 * <p>
	 * @param	conn			Connection
	 * @param	programid	int
	 * @param	alphas		String
	 * <p>
	 * @return String
	 */
	public static int setProgramAlphs(Connection conn,int programid,String alphas) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "DELETE FROM tblchairs WHERE programid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,programid);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (alphas != null){
				String[] aAlphas = alphas.split(",");
				for(int i=0; i<aAlphas.length; i++){
					sql = "INSERT INTO tblChairs (programid,coursealpha) VALUES(?,?)";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,programid);
					ps.setString(2,aAlphas[i]);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}

		} catch (Exception e) {
			logger.fatal("ChairProgramsDB: setProgramAlphs - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * Returns a single division based on an alpha which the division belongs to.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * <p>
	 * @return String
	 */
	public static String getDivisionFromCampusAlpha(Connection conn,String campus,String alpha) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String div = "";

		try {
			String sql = "SELECT d.divisioncode "
				+ "FROM tblChairs c INNER JOIN tblDivision d  "
				+ "ON c.programid = d.divid "
				+ "WHERE d.campus=? "
				+ "AND c.coursealpha=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				div = AseUtil.nullToBlank(rs.getString(1));
			}

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ChairProgramsDB: getDivisionFromCampusAlpha - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ChairProgramsDB: getDivisionFromCampusAlpha - " + e.toString());
		}

		return div;
	}

	public void close() throws SQLException {}

}