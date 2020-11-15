/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *	public static Msg authenticateUser(Connection,String,String,HttpServletRequest,HttpServletResponse,ServletContext)
 *	public static Msg authenticateUserX(Connection,String,HttpServletRequest,HttpServletResponse,ServletContext,String)
 *	public static boolean checked(Connection connection,String userid,String campus)
 *	public static int deleteUser(Connection connection, String id)
 * public static String getCampusUsersAndDistribution(Connection connection,String campus,String user)
 *	public static User getUserByID(Connection connection, int userid)
 *	public static User getUserByName(Connection connection, String userid)
 *	public static String getUserCampus(Connection connection, String user) {
 *	public static String getUserDepartment(Connection connection, String user)
 *	public static String getUserDepartment(Connection conn,String user,String dept,HttpServletRequest request) {
 *	public static String getUserDepartments(Connection conn,String user) {
 *	public static String getUserEmail(Connection connection, String user)
 *	public static boolean getSendNow(Connection connection, String user)
 *	public static String getUserFullname(Connection connection, String userid)
 *	public static int insertUser(Connection connection, User user)
 *	public static boolean isMatch(Connection connection,String userid,String campus)
 *	public static int updateProfile(Connection connection, User user,HttpServletRequest request,HttpServletResponse response)
 *	public static int updateUser(Connection connection, User user,HttpServletRequest request,HttpServletResponse response)
 *	public static int updateUserDepartment(Connection conn,String usr,String dept,HttpServletRequest request) {
 *	public static int setLastUsedDate(Connection connection,String user)
 *	public static int setUserDepartment(Connection conn,String user,String dept) {
 *	public static void updateCheck(Connection connection,String campus,String userid,String check)
 *
 * @author ttgiang
 */

//
// UserDB.java
//
package com.ase.aseutil;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.log4j.Logger;

import com.ase.exception.UserNotAuthorizedException;

public class UserDB implements HttpSessionBindingListener {

	static Logger logger = Logger.getLogger(UserDB.class.getName());

	public UserDB() throws Exception {}

	/**
	 * valueBound
	 * <p>
	 * @param event HttpSessionBindingEvent
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		logger.info("The value bound is " + event.getName());
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		logger.info("The value unbound is " + event.getName());
	}

	/**
	 * isMatch
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection connection,String userid,String campus) throws SQLException {

		String sql = "SELECT userid FROM tblUsers WHERE userid=? AND campus=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,userid);
		ps.setString(2,campus);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * isMatch
	 * <p>
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(String userid,String campus) throws SQLException {

		AsePool connectionPool;
		connectionPool = AsePool.getInstance();
		Connection connection = connectionPool.getConnection();

		return isMatch(connection,userid,campus);
	}

	/**
	 * checked
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean checked(Connection connection,String userid,String campus) throws SQLException {

		boolean isChecked = true;
		String sql = "SELECT check FROM tblUsers WHERE campus=? AND userid=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,userid);
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			try{
				AseUtil aseUtil = new AseUtil();
				if (!"1".equals(aseUtil.getValue(rs,"check")))
					isChecked = false;
			}
			catch(Exception e){
				logger.fatal("userDB: checked - " + e.toString());
			}
		}

		rs.close();
		ps.close();

		return isChecked;
	}

	/**
	 * updateCheck
	 * <p>
	 * @param connection	Connection
	 * @param campus		String
	 * @param userid		String
	 * @param check		String
	 * <p>
	 */
	public static void updateCheck(Connection connection,
												String campus,
												String userid,
												String check) throws SQLException {

		String sql = "UPDATE tblUsers SET check=? WHERE campus=? AND userid=?";

		try{
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,check);
			ps.setString(2,campus);
			ps.setString(3,userid);
			int rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("userDB: updateCheck\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("userDB: updateCheck - " + e.toString());
		}
	}

	/**
	 * getUserByID
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * <p>
	 * @return User
	 */
	public static User getUserByID(Connection connection, int userid) {

		User userDB = new User();
		String sql = "SELECT * from tblUsers WHERE id = ?";
		String temp = "";

		try {
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				userDB.setUserid(aseUtil.getValue(rs, "userid"));
				userDB.setPassword(aseUtil.getValue(rs, "password"));
				userDB.setFullname(aseUtil.getValue(rs, "fullname"));
				userDB.setFirstname(aseUtil.getValue(rs, "firstname"));
				userDB.setLastname(aseUtil.getValue(rs, "lastname"));
				userDB.setPosition(aseUtil.getValue(rs, "position").trim());
				userDB.setStatus(aseUtil.getValue(rs, "status").trim());

				temp = aseUtil.getValue(rs, "division").trim().toUpperCase();
				userDB.setDivision(temp);

				temp = aseUtil.getValue(rs, "department").trim().toUpperCase();
				userDB.setDepartment(temp);

				userDB.setAlphas(aseUtil.getValue(rs, "alphas").trim());

				userDB.setEmail(aseUtil.getValue(rs, "email").trim());
				userDB.setTitle(aseUtil.getValue(rs, "title"));
				userDB.setSalutation(aseUtil.getValue(rs, "salutation"));
				userDB.setLocation(aseUtil.getValue(rs, "location"));
				userDB.setHours(aseUtil.getValue(rs, "hours"));
				userDB.setPhone(aseUtil.getValue(rs, "phone"));
				userDB.setCampus(aseUtil.getValue(rs, "campus"));
				userDB.setAuditBy(aseUtil.getValue(rs, "auditby"));
				userDB.setAuditDate(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "auditdate"), 6));
				userDB.setUserLevel(Integer.parseInt(aseUtil.getValue(rs,"userlevel")));
				userDB.setUH(Integer.parseInt(aseUtil.getValue(rs,"uh")));
				userDB.setAttachment(Integer.parseInt(aseUtil.getValue(rs,"attachment")));

				userDB.setWebsite(aseUtil.getValue(rs, "website"));
				userDB.setWeburl(aseUtil.getValue(rs, "weburl"));
				userDB.setCollege(aseUtil.getValue(rs, "college"));
			}

			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("userDB: getUserByID - " + e.toString());
			return null;
		}

		return userDB;
	}

	/**
	 * getUserFullname
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * <p>
	 * @return String
	 */
	public static String getUserFullname(Connection connection, String userid) {

		String fullName = "";

		try {
			String sql = "SELECT fullname from tblUsers WHERE userid=?";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				fullName = aseUtil.getValue(rs, "fullname");
				aseUtil = null;
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("userDB: getUserFullname - " + e.toString());
		}

		return fullName;
	}

	/**
	 * getUserByName
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * <p>
	 * @return User
	 */
	public static User getUserByName(Connection connection, String userid) {

		User userDB = null;

		String temp = "";

		try {
			String sql = "SELECT * from tblUsers WHERE userid=?";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				userDB = new User();
				AseUtil aseUtil = new AseUtil();
				userDB.setUserid(aseUtil.getValue(rs, "userid"));
				userDB.setPassword(aseUtil.getValue(rs, "password"));
				userDB.setFullname(aseUtil.getValue(rs, "fullname"));
				userDB.setFirstname(aseUtil.getValue(rs, "firstname"));
				userDB.setLastname(aseUtil.getValue(rs, "lastname"));
				userDB.setPosition(aseUtil.getValue(rs, "position").trim());
				userDB.setStatus(aseUtil.getValue(rs, "status").trim());

				temp = aseUtil.getValue(rs, "division").trim().toUpperCase();
				userDB.setDivision(temp);

				temp = aseUtil.getValue(rs, "department").trim().toUpperCase();
				userDB.setDepartment(temp);

				userDB.setAlphas(aseUtil.getValue(rs, "alphas").trim());

				userDB.setEmail(aseUtil.getValue(rs, "email").trim());
				userDB.setTitle(aseUtil.getValue(rs, "title"));
				userDB.setSalutation(aseUtil.getValue(rs, "salutation"));
				userDB.setLocation(aseUtil.getValue(rs, "location"));
				userDB.setHours(aseUtil.getValue(rs, "hours"));
				userDB.setPhone(aseUtil.getValue(rs, "phone"));
				userDB.setCampus(aseUtil.getValue(rs, "campus"));
				userDB.setAuditBy(aseUtil.getValue(rs, "auditby"));

				userDB.setLastUsed(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "lastused"),Constant.DATE_DATETIME));
				userDB.setAuditDate(aseUtil.ASE_FormatDateTime(aseUtil.getValue(rs, "auditdate"),Constant.DATE_DATETIME));

				userDB.setUserLevel(NumericUtil.nullToZero(rs.getInt("userlevel")));
				userDB.setUH(NumericUtil.nullToZero(rs.getInt("uh")));
				userDB.setAttachment(NumericUtil.nullToZero(rs.getInt("attachment")));
				userDB.setSendNow(NumericUtil.nullToZero(rs.getInt("sendnow")));

				userDB.setWebsite(aseUtil.getValue(rs, "website"));
				userDB.setWeburl(aseUtil.getValue(rs, "weburl"));
				userDB.setCollege(aseUtil.getValue(rs, "college"));

				aseUtil = null;
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("userDB: getUserByName - " + e.toString());
			userDB = null;
		}

		return userDB;
	}


	/**
	 * insertUser
	 * <p>
	 * @param connection	Connection
	 * @param user			User
	 * <p>
	 * @return int
	 */
	public static int insertUser(Connection connection, User user) {

		int rowsAffected = 0;
		int i = 0;
		int attachment = 0;

		String sql = "INSERT INTO tblUsers (userid,password,uh,fullname,firstname,lastname,position,status,division,"
			+ "department,email,title,salutation,location,hours,phone,campus,userlevel,auditby,alphas,attachment,website,weburl,college) "
			+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {

			if (!isMatch(connection,user.getUserid().toUpperCase(),user.getCampus())){
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(++i, user.getUserid().toUpperCase());
				ps.setString(++i, user.getPassword());
				ps.setInt(++i, user.getUH());
				ps.setString(++i, user.getFullname().toUpperCase());
				ps.setString(++i, user.getFirstname().toUpperCase());
				ps.setString(++i, user.getLastname().toUpperCase());
				ps.setString(++i, user.getPosition());
				ps.setString(++i, user.getStatus());
				ps.setString(++i, user.getDivision());
				ps.setString(++i, user.getDepartment());
				ps.setString(++i, user.getEmail());
				ps.setString(++i, user.getTitle());
				ps.setString(++i, user.getSalutation());
				ps.setString(++i, user.getLocation());
				ps.setString(++i, user.getHours());
				ps.setString(++i, user.getPhone());
				ps.setString(++i, user.getCampus());
				ps.setInt(++i, user.getUserLevel());
				ps.setString(++i, user.getAuditBy());
				ps.setString(++i, user.getAlphas());
				ps.setInt(++i, user.getAttachment());
				ps.setString(++i, user.getWebsite());
				ps.setString(++i, user.getWeburl());
				ps.setString(++i, user.getCollege());
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("userDB: insertUser - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * deleteUser
	 * <p>
	 * @param connection	Connection
	 * @param id			String
	 * <p>
	 * @return int
	 */
	public static String deleteUser(Connection conn,String campus,String id) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		StringBuffer sb = new StringBuffer();

		boolean workInProgress = false;

		String rtn = "";

		try {
			rtn = showWorkInProgress(conn,campus,id);

			if(!rtn.equals(Constant.BLANK)){
				workInProgress = true;
			}

			sb.append("<table width=\"100%\" border=\"0\">"
						+ "<tr>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "<td width=\"60%\" valign=\"top%\">"
						)
				.append(rtn)
				.append("</td>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "</tr>"
						);

			// delete the user only if all conditions have been met
			if (!workInProgress){
				String sql = "DELETE FROM tblUsers WHERE userid=? AND campus=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,id);
				ps.setString(2,campus);
				rowsAffected = ps.executeUpdate();
				ps.close();

				// tblReviewers
				sql = "DELETE FROM tblReviewers WHERE campus=? AND userid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,id);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				sb.append("<tr><td width=\"20%\">&nbsp;</td>"
						+ "<td><br><br><img src=\"../images/warning.gif\" border=\"0\">&nbsp;&nbsp;You must resolve open issues before delete is permitted."
						+ "<br><br>Either reassign pending tasks to another faculty or remove the pending task from Curriculum Central (CC).</td>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "</tr>"
						);
			}

			if (!workInProgress){
				sb.append("<tr><td colspan=\"3\" align=\"center\">"
						+ "<br>"
						+ "</td></tr>"
						)
				  .append("<tr><td colspan=\"3\" align=\"center\">"
						+ "User <b>" + id + "</b> deleted successfully"
						+ "</td></tr>"
						);
			}

			sb.append("</table>");

			rtn = sb.toString();

		} catch (SQLException e) {
			logger.fatal("userDB: deleteUser - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: deleteUser - " + e.toString());
		}

		return rtn;
	} // UserDB: deleteUser

	/**
	 * deleteUser
	 * <p>
	 * @param connection	Connection
	 * @param id			String
	 * <p>
	 * @return int
	 */
	public static String deleteUserOBSOLETE(Connection conn,String campus,String id) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		StringBuffer sb = new StringBuffer();

		PreparedStatement ps = null;

		ResultSet rs = null;

		boolean incomplete = false;

		String rtn = "";

		try {
			String title = "";
			String members = "";

			sb.append("<table width=\"100%\" border=\"0\">"
						+ "<tr>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "<td width=\"60%\" valign=\"top%\">"
						+ "<ul>"
						);

			// remove from distribution listing
			String sql = "SELECT title,members FROM tbldistribution WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
				members = AseUtil.nullToBlank(rs.getString("members"));
				if (members.indexOf(id) > -1){
					sb.append("<li>"+id+" exists in distribution list " +title+" and must be removed manually.</li>");
				}
			} //while
			rs.close();
			ps.close();

			// remove from email list
			sql = "SELECT title,members FROM tblEmailList WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
				members = AseUtil.nullToBlank(rs.getString("members"));
				if (members.indexOf(id) > -1){
					sb.append("<li>CC did not delete '"+id+"' from meail list " +title+". This is a manual process.</li>");
				}
			} //while
			rs.close();
			ps.close();

			// approvers
			sql = "SELECT approver FROM tblApprover WHERE campus=? AND (approver=? OR delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			if(rs.next()){
				sb.append("<li>CC did not delete '"+id+"' from approval routing. This is a manual process.</li>");
				incomplete = true;
			} //if
			rs.close();
			ps.close();

			// tblauthority
			sql = "SELECT chair FROM tblauthority WHERE campus=? AND (chair=? OR delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			if(rs.next()){
				sb.append("<li>CC did not delete '"+id+"' from authority table. This is a manual process.</li>");
				incomplete = true;
			} //if
			rs.close();
			ps.close();

			// tblDivision
			sql = "SELECT chairname FROM tblDivision WHERE campus=? AND (chairname=? OR delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			if(rs.next()){
				sb.append("<li>CC did not delete '"+id+"' from divisions. This is a manual process.</li>");
				incomplete = true;
			} //if
			rs.close();
			ps.close();

			// tblReviewers
			sql = "DELETE FROM tblReviewers WHERE campus=? AND userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// tblTasks
			sql = "SELECT submittedfor FROM tblTasks WHERE campus=? AND submittedfor=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			rs = ps.executeQuery();
			if(rs.next()){
				sb.append("<li>CC did not delete tasks for '"+id+"'. Consider reassigning pending tasks.</li>");
				incomplete = true;
			} //if
			rs.close();
			ps.close();

			sb.append("</ul>"
						+ "</td>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "</tr>"
						);

			// delete the user only if all conditions have been met
			if (!incomplete){
				sql = "DELETE FROM tblUsers WHERE userid=? AND campus=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, campus);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				sb.append("<tr><td width=\"20%\">&nbsp;</td>"
						+ "<td><br><br><img src=\"../images/warning.gif\" border=\"0\">&nbsp;&nbsp;You must resolve open issues before delete is permitted."
						+ "<br><br>Either reassign pending tasks to another faculty or remove the pending task from Curriculum Central (CC).</td>"
						+ "<td width=\"20%\">&nbsp;</td>"
						+ "</tr>"
						);
			}

			sb.append("<tr><td colspan=\"3\" align=\"center\">"
					+ "<br>"
					+ "</td></tr>"
					);

			if (!incomplete){
				sb.append("<tr><td colspan=\"3\" align=\"center\">"
						+ "User <b>" + id + "</b> deleted successfully"
						+ "</td></tr>"
						);
			}

			sb.append("</table>");

			rtn = sb.toString();

		} catch (SQLException e) {
			logger.fatal("userDB: deleteUser - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: deleteUser - " + e.toString());
		}

		return rtn;
	} // UserDB: deleteUser

	/**
	 * showWorkInProgress
	 * <p>
	 * @param connection	Connection
	 * @param id			String
	 * <p>
	 * @return int
	 */
	public static String showWorkInProgress(Connection conn,String campus,String id) {

		//Logger logger = Logger.getLogger("test");

		//
		// THIS CODE IS IDENTICAL to hasWorkInProgress. differenec is no string appends of
		// messages for notification
		//

		int rowsAffected = 0;

		PreparedStatement ps = null;
		ResultSet rs = null;

		boolean workInProgress = false;

		String rtn = "";
		StringBuffer sb = new StringBuffer();

		try {
			String title = "";
			String members = "";

			// remove from distribution listing
			String sql = "SELECT title,members FROM tbldistribution WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
				members = AseUtil.nullToBlank(rs.getString("members"));
				if (members.indexOf(id) > -1){
					sb.append("<li>"+id+" exists in distribution list <font class=\"datacolumn\">"+title+"</font>.</li>");
					workInProgress = true;
				}
			} //while
			rs.close();
			ps.close();

			// remove from email list
			sql = "SELECT title,members FROM tblEmailList WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
				members = AseUtil.nullToBlank(rs.getString("members"));
				if (members.indexOf(id) > -1){
					sb.append("<li>"+id+" exists in email list <font class=\"datacolumn\">"+title+"</font>.</li>");
					workInProgress = true;
				}
			} //while
			rs.close();
			ps.close();

			// remove as approver
			sql = "SELECT i.kid FROM tblApprover a "
				+ "INNER JOIN tblINI i ON a.campus = i.campus AND a.route = i.id "
				+ "WHERE a.campus=? AND (a.approver=? OR a.delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("kid"));
				sb.append("<li>"+id+" belongs to approval sequence <font class=\"datacolumn\">"+title+"</font>.</li>");
				workInProgress = true;
			} //while
			rs.close();
			ps.close();

			// tblauthority
			sql = "SELECT chair FROM tblauthority WHERE campus=? AND (chair=? OR delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			if(rs.next()){
				sb.append("<li>"+id+" exists int authority table.</li>");
				workInProgress = true;
			} //if
			rs.close();
			ps.close();

			// remove as chair
			sql = "SELECT divisionname FROM tblDivision WHERE campus=? AND (chairname=? OR delegated=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			ps.setString(3,id);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("divisionname"));
				sb.append("<li>"+id+" is chair of <font class=\"datacolumn\">"+title+"</font>.</li>");
				workInProgress = true;
			} //while
			rs.close();
			ps.close();

			// tblTasks
			sql = "SELECT COUNT(submittedfor) AS counter FROM tblTasks WHERE campus=? AND submittedfor=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			rs = ps.executeQuery();
			if(rs.next() && rs.getInt("counter") > 0){
				int counter = rs.getInt("counter");
				sb.append("<li>"+id+" has "+counter+" pending tasks.</li>");
				workInProgress = true;
			} //if
			rs.close();
			ps.close();

			// remove as reviewer
			sql = "SELECT DISTINCT coursealpha, coursenum FROM tblReviewers WHERE campus=? AND userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,id);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum"));
				sb.append("<li>"+id+" has not completed reviewing <font class=\"datacolumn\">"+title+"</font>.</li>");
				workInProgress = true;
			} //while
			rs.close();
			ps.close();

			// delete the user only if all conditions have been met
			if (workInProgress){
				rtn = "<ul>" + sb.toString() + "</ul>";
			}

		} catch (SQLException e) {
			logger.fatal("userDB: showWorkInProgress - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: showWorkInProgress - " + e.toString());
		}

		return rtn;

	} // UserDB: showWorkInProgress

	/**
	 * hasWorkInProgress
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param user		String
	 * <p>
	 * @return boolean
	 */
	public static Boolean hasWorkInProgress(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		PreparedStatement ps = null;
		ResultSet rs = null;

		boolean workInProgress = false;

		try {

			String title = "";
			String members = "";

			boolean debug = false;

			//
			// THIS CODE IS IDENTICAL to delete users. differenec is no string appends of
			// messages for notification
			//

			if(debug) System.out.println("user: " + user);

			//
			// check distribution listing
			//
			String sql = "SELECT title,members FROM tbldistribution WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while(rs.next()){
				title = AseUtil.nullToBlank(rs.getString("title"));
				members = AseUtil.nullToBlank(rs.getString("members"));
				if (members.indexOf(user) > -1){
					workInProgress = true;
				}
			} //while
			rs.close();
			ps.close();
			if(debug) System.out.println("1: " + workInProgress);

			//
			// remove from email list
			//
			if(!workInProgress){
				sql = "SELECT title,members FROM tblEmailList WHERE campus=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				rs = ps.executeQuery();
				while(rs.next()){
					title = AseUtil.nullToBlank(rs.getString("title"));
					members = AseUtil.nullToBlank(rs.getString("members"));
					if (members.indexOf(user) > -1){
						workInProgress = true;
					}
				} //while
				rs.close();
				ps.close();
				if(debug) System.out.println("2: " + workInProgress);
			}

			//
			// approvers
			//
			if(!workInProgress){
				sql = "SELECT approver FROM tblApprover WHERE campus=? AND (approver=? OR delegated=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ps.setString(3,user);
				rs = ps.executeQuery();
				if(rs.next()){
					workInProgress = true;
				}
				rs.close();
				ps.close();
				if(debug) System.out.println("3: " + workInProgress);
			}

			//
			// tblauthority
			//
			if(!workInProgress){
				sql = "SELECT chair FROM tblauthority WHERE campus=? AND (chair=? OR delegated=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ps.setString(3,user);
				rs = ps.executeQuery();
				if(rs.next()){
					workInProgress = true;
				}
				rs.close();
				ps.close();
				if(debug) System.out.println("4: " + workInProgress);
			}

			//
			// tblDivision
			//
			if(!workInProgress){
				sql = "SELECT chairname FROM tblDivision WHERE campus=? AND (chairname=? OR delegated=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ps.setString(3,user);
				rs = ps.executeQuery();
				if(rs.next()){
					workInProgress = true;
				}
				rs.close();
				ps.close();
				if(debug) System.out.println("5: " + workInProgress);
			}

			//
			// tblTasks
			//
			if(!workInProgress){
				sql = "SELECT submittedfor FROM tblTasks WHERE campus=? AND submittedfor=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				if(rs.next()){
					workInProgress = true;
				}
				rs.close();
				ps.close();
				if(debug) System.out.println("6: " + workInProgress);
			}

			//
			// tblreviews
			//
			if(!workInProgress){
				sql = "SELECT distinct userid FROM tblReviewers WHERE campus=? AND userid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				if(rs.next()){
					workInProgress = true;
				}
				rs.close();
				ps.close();
				if(debug) System.out.println("7: " + workInProgress);
			}

		} catch (SQLException e) {
			logger.fatal("userDB: hasWorkInProgress - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: hasWorkInProgress - " + e.toString());
		}

		return workInProgress;

	} // UserDB: hasWorkInProgress

	/**
	 * security updateProfile
	 * <p>
	 * @param	connection	Connection
	 * @param	usr			User
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public static int updateProfile(Connection connection,
												User usr,
												HttpServletRequest request,
												HttpServletResponse response) {
		int rowsAffected = 0;
		int i = 0;
		String sql = "UPDATE tblUsers "
			+ "SET position=?,division=?,department=?,email=?,title=?,location=?,hours=?,phone=?,"
			+ "auditby=?,auditdate=?,salutation=?,alphas=?,sendnow=?,attachment=?,website=?,weburl=?,college=? "
			+ "WHERE userid=?";
		try {

			String user = usr.getUserid();

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(++i, usr.getPosition().toUpperCase());
			ps.setString(++i, usr.getDivision());
			ps.setString(++i, usr.getDepartment());
			ps.setString(++i, usr.getEmail());
			ps.setString(++i, usr.getTitle().toUpperCase());
			ps.setString(++i, usr.getLocation());
			ps.setString(++i, usr.getHours());
			ps.setString(++i, usr.getPhone());
			ps.setString(++i, usr.getAuditBy());
			ps.setString(++i, usr.getAuditDate());
			ps.setString(++i, usr.getSalutation());
			ps.setString(++i, usr.getAlphas());
			ps.setInt(++i, usr.getSendNow());
			ps.setInt(++i, usr.getAttachment());
			ps.setString(++i, usr.getWebsite());
			ps.setString(++i, usr.getWeburl());
			ps.setString(++i, usr.getCollege());
			ps.setString(++i, user);
			rowsAffected = ps.executeUpdate();
			ps.close();

			processProfileImage(connection,user,usr.getWeburl(),request,response);

			AseUtil.logAction(connection,
									user,
									"ACTION",
									"Profile updated",
									"",
									"",
									"",
									"");

		} catch (SQLException e) {
			logger.fatal("userDB: updateProfile - " + e.toString());
			return 0;
		}

		return rowsAffected;
	}

	/**
	 * security updateUserDepartment
	 * <p>
	 * @param	conn			Connection
	 * @param	user			String
	 * @param	dept			String
	 * @param	departments	String
	 * @param	request		HttpServletRequest
	 * <p>
	 * @return	int
	 */
	public static int updateUserDepartment(Connection conn,
														String user,
														String dept,
														String departments,
														HttpServletRequest request) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String sql = "UPDATE tblUsers SET department=?,alphas=? WHERE userid=?";
		try {

			if (departments != null && departments.length() > 0){

				departments = Util.removeDuplicateFromString(departments);
				departments = Util.stringToArrayToString(departments.toUpperCase(),",",false);

			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,dept);
			ps.setString(2,departments);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// update session data
			HttpSession session = request.getSession(true);

			session.setAttribute("aseDept",dept);

		} catch (SQLException e) {
			logger.fatal("userDB.updateUserDepartment - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * security updateUser
	 * <p>
	 * @param	connection	Connection
	 * @param	usr			User
	 * @param	request		HttpServletRequest
	 * @param	response		HttpServletResponse
	 * <p>
	 * @return	int
	 */
	public static int updateUser(Connection connection,
											User usr,
											HttpServletRequest request,
											HttpServletResponse response) {
		int rowsAffected = 0;
		int i = 0;

		try {

			String campus = usr.getCampus();
			String user = usr.getUserid();

			String sql = "UPDATE tblUsers "
				+ "SET fullname=?,firstname=?,lastname=?,position=?,status=?,division=?,department=?,email=?,title=?,"
				+ "salutation=?,location=?,hours=?,phone=?,campus=?,userlevel=?,auditby=?,auditdate=?,alphas=?,attachment=?,website=?,weburl=?,college=? "
				+ "WHERE userid =?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(++i, usr.getFullname().toUpperCase());
			ps.setString(++i, usr.getFirstname().toUpperCase());
			ps.setString(++i, usr.getLastname().toUpperCase());
			ps.setString(++i, usr.getPosition().toUpperCase());
			ps.setString(++i, usr.getStatus());
			ps.setString(++i, usr.getDivision());
			ps.setString(++i, usr.getDepartment());
			ps.setString(++i, usr.getEmail());
			ps.setString(++i, usr.getTitle().toUpperCase());
			ps.setString(++i, usr.getSalutation());
			ps.setString(++i, usr.getLocation());
			ps.setString(++i, usr.getHours());
			ps.setString(++i, usr.getPhone());
			ps.setString(++i, campus);
			ps.setInt(++i, usr.getUserLevel());
			ps.setString(++i, usr.getAuditBy());
			ps.setString(++i, usr.getAuditDate());
			ps.setString(++i, usr.getAlphas());
			ps.setInt(++i, usr.getAttachment());
			ps.setString(++i, usr.getWebsite());
			ps.setString(++i, usr.getWeburl());
			ps.setString(++i, usr.getCollege());
			ps.setString(++i, user);
			rowsAffected = ps.executeUpdate();
			ps.close();

			String userLevel = "" + usr.getUserLevel();
			String department = usr.getDepartment();
			String division = usr.getDivision();
			String email = usr.getEmail();
			String fullname = usr.getFullname().toUpperCase();

			// update session values only if the user is updating his own
			HttpSession session = request.getSession(true);

			String currentUser = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			if (user.equals(currentUser)){
				updateSessionData(request,
										response,
										connection,
										user,
										campus,
										userLevel,
										department,
										division,
										email,
										fullname);
			} // update profile if same person doing maintenance

			processProfileImage(connection,user,usr.getWeburl(),request,response);

		} catch (SQLException e) {
			logger.fatal("userDB.updateUser - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * processProfileImage
	 * <p>
	 * @param conn			Connection
	 * @param user			String
	 * @param filename	String
	 * @param request		HttpServletRequest
	 * @param response	HttpServletResponse
	 * <p>
	 * @return int
	 */
	public static int processProfileImage(Connection conn,
														String user,
														String filename,
														HttpServletRequest request,
														HttpServletResponse response) {

		try {

			//
			// if an image is uploaded for profile, resize accordingly
			//
			//
			// for users with image in profile, the following is done
			//
			// 1) save the image as the user's name
			// 2) image format is png
			//
			// process only if we have data and it's not the same filename
			//

			WebSite website = new WebSite();

			String fileUpload = website.getRequestParameter(request, "FileUpload", "0");

			if(fileUpload.equals(Constant.ON)){

				String format = "png";

				//
				// file location
				//
				String dirName = AseUtil.getCurrentDrive()
									+ ":"
									+ com.ase.aseutil.SysDB.getSys(conn,"documents")
									+ "profiles\\";

				String oldFileName = dirName + filename;

				//
				// find the name of the file and replace with user name
				//
				int pos = filename.lastIndexOf(".");
				if(pos > 0){

					String fileNameNoExtension = filename.substring(0,pos);
					String fileExtension = filename.substring(pos+1);

					//
					// establishing old and new name
					//
					String newFileName = dirName + user + "." + format;

					//
					// can we find old file?
					//
					File oldFile = new File(oldFileName);
					if(oldFile.exists()){

						//
						// resize the file and give new name
						//
						try{
							com.ase.aseutil.io.ImageResize ir = new com.ase.aseutil.io.ImageResize();
							ir.resize(oldFileName,newFileName,format,100,100);
							ir = null;

							//
							// if resize and new file exists, delete old file
							//
							try{
								File newFile = new File(newFileName);
								if(newFile.exists()){
									if(oldFile.delete()){

										//
										// with successful resize/rename, update user profile
										//
										String sql = "UPDATE tblUsers SET weburl=? WHERE userid =?";
										PreparedStatement ps = conn.prepareStatement(sql);
										ps.setString(1,user+"."+format);
										ps.setString(2,user);
										int rowsAffected = ps.executeUpdate();
										ps.close();
									} // file renamed

								} // new file created
							}
							catch(Exception e){
								logger.fatal("userDB.processProfileImage - " + e.toString());
							}
						}
						catch(Exception e){
							logger.fatal("userDB.processProfileImage - " + e.toString());
						}

					} // file exists

				} // valid file with extension found

			} // image file found

		} catch (Exception e) {
			logger.fatal("userDB.processProfileImage - " + e.toString());
		}

		return 0;
	}

	/**
	 * setLastUsedDate
	 * <p>
	 * @param connection	Connection
	 * @param user			String
	 * <p>
	 * @return int
	 */
	public static int setLastUsedDate(Connection connection,String user) {

		int rowsAffected = 0;
		String sql = "UPDATE tblUsers SET lastused=? WHERE userid =?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,AseUtil.getCurrentDateTimeString());
			ps.setString(2,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: setLastUsedDate - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * getUserDepartment
	 * <p>
	 * @param connection	Connection
	 * @param user			String
	 * <p>
	 * @return String
	 */
	public static String getUserDepartment(Connection connection,String user) {
		String department = "";
		try {
			String sql = "SELECT department FROM tblUsers WHERE userid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				department = AseUtil.nullToBlank(results.getString(1)).trim();
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserDepartment - " + e.toString());
			department = null;
		}
		return department;
	}

	/**
	 * getUserDepartment
	 * <p>
	 * @param conn	Connection
	 * @param user	String
	 * @param dept	String
	 * <p>
	 * @return String
	 */
	public static String getUserDepartment(Connection conn,String user,String dept) {
		String department = "";
		try {
			String sql = "SELECT department,alphas FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				department = AseUtil.nullToBlank(rs.getString("department"));
				String alphas = AseUtil.nullToBlank(rs.getString("alphas"));

				// if access is *ALL, set and return the department that was sent in
				if(alphas.toUpperCase().indexOf("*ALL") > -1){
					department = dept;
				}

			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserDepartment - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: getUserDepartment - " + e.toString());
		}

		return department;
	}

	/**
	 * getUserDepartment - compare user department to list of allowable departments
	 * <p>
	 * @param conn		Connection
	 * @param user		String
	 * @param dept		String
	 * @param request	HttpServletRequest
	 * <p>
	 * @return String
	 */
	public static String getUserDepartment(Connection conn,String user,String dept,HttpServletRequest request) {

		//Logger logger = Logger.getLogger("test");

		String department = "";
		String alphas = "";

		try {
			String sql = "SELECT department,alphas FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				department = AseUtil.nullToBlank(rs.getString("department"));
				alphas = AseUtil.nullToBlank(rs.getString("alphas"));

				// if access is *ALL, set and return the department that was sent in
				if(alphas.toUpperCase().indexOf("*ALL") > -1){
					department = dept;
				}
				else{
					// at the vey least, user should have a deparment
					if (department != null && department.length() > 0){
						if (alphas != null && alphas.length() > 0)
							department = department + "," + alphas;
					}

					// if the requested dept is found within the list of allowed departments,
					// then return the dept name and permit user to move on.
					if (department.indexOf(dept) > -1){
						updateUserDepartment(conn,user,dept,department,request);
						department = dept;
					}
				} // alphas

			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserDepartment - " + e.toString());
		}

		return department;
	}

	/**
	 * getUserDepartments - returns user departments
	 * <p>
	 * @param conn	Connection
	 * @param user	String
	 * <p>
	 * @return String
	 */
	public static String getUserDepartments(Connection conn,String user) {

		//Logger logger = Logger.getLogger("test");

		String department = "";
		String alphas = "";

		try {
			String sql = "SELECT department,alphas FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				department = AseUtil.nullToBlank(rs.getString("department"));
				alphas = AseUtil.nullToBlank(rs.getString("alphas"));

				// at the vey least, user should have a deparment
				if (department != null && department.length() > 0){
					if (alphas != null && alphas.length() > 0)
						department = department + "," + alphas;

					department = Util.stringToArrayToString(department,",",false);
				}
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserDepartments - " + e.toString());
		}

		return department;
	}

	/**
	 * getUserEmail
	 * <p>
	 * @param connection	Connection
	 * @param user			String
	 * <p>
	 * @return String
	 */
	public static String getUserEmail(Connection connection, String user) {
		String email = "";
		try {
			String sql = "SELECT email FROM tblUsers WHERE userid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				email = results.getString(1);
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserEmail - " + e.toString());
			email = null;
		}
		return email;
	}

	/**
	 * getUserCampus
	 * <p>
	 * @param connection	Connection
	 * @param user			String
	 * <p>
	 * @return String
	 */
	public static String getUserCampus(Connection connection, String user) {
		String campus = "";
		try {
			String sql = "SELECT campus FROM tblUsers WHERE userid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				campus = results.getString(1);
			}
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserCampus - " + e.toString());
		}
		return campus;
	}

	/**
	 * Authenticate user
	 * <p>
	 * @param conn			Connection
	 * @param uid			String
	 * @param pw			String
	 * @param request		HttpServletRequest
	 * @param response	HttpServletResponse
	 * @param context		ServletContext
	 * <p>
	 * @return Msg
	 */
	public static synchronized Msg authenticateUser(Connection conn,
																	String uid,
																	String pw,
																	HttpServletRequest request,
																	HttpServletResponse response,
																	ServletContext context) throws UserNotAuthorizedException {

		//
		//	use this authentication with password when one is provided (lgn.jsp)
		//

		Msg msg = new Msg();

		String user = "";
		String campus = "";
		String userLevel = "";
		String department = "";
		String division = "";
		String email = "";
		String fullname = "";
		String college = "";
		String authenticated = "";

		try {
			HttpSession session = request.getSession(true);

			String sql = "SELECT userid,userlevel,campus,department,division,email,fullname,status,college "
						+ "FROM tblUsers WHERE userid=? AND password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,uid);
			ps.setString(2,pw);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				String status = AseUtil.nullToBlank(aseUtil.getValue(rs, "status"));
				if (status.toLowerCase().equals("inactive")) {
					msg.setMsg("InactiveAccount");
					session.setAttribute("aseUserName", "");
					session.setAttribute("aseCampus", "");
					CookieManager.setCookie(response,"CC_User",null,0);
					CookieManager.setCookie(response,"CC_Campus",null,0);
					authenticated = "not authenticated (LGN)";
				}
				else {
					user = aseUtil.getValue(rs,"userid");
					campus = aseUtil.getValue(rs,"campus");
					userLevel = aseUtil.getValue(rs,"userlevel");
					department = aseUtil.getValue(rs,"department");
					division = aseUtil.getValue(rs,"division");
					email = aseUtil.getValue(rs,"email");
					fullname = aseUtil.getValue(rs,"fullname");
					college = aseUtil.getValue(rs,"college");

					updateSessionData(request,response,conn,user,campus,userLevel,department,division,email,fullname,context,college);

					setLastUsedDate(conn,user);

					JSIDDB.insertJSID(conn,session.getId(),campus,user,"","","");

					aseUtil.logAction(conn,user,"LOGIN","Log in (LGN)",session.getId(),"",campus,"");

					authenticated = "authenticated (LGN)";

					session.setAttribute("aseAuthenticationAttempts",0);
				}

				// clear previously created temp data
				com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);

				aseUtil = null;
			} else {

				int aseAuthenticationAttempts = 0;

				try{
					aseAuthenticationAttempts = (Integer)session.getAttribute("aseAuthenticationAttempts");
				}
				catch(Exception e){
					aseAuthenticationAttempts = 0;
				}

				aseAuthenticationAttempts = NumericUtil.getInt(aseAuthenticationAttempts,0);
				++aseAuthenticationAttempts;
				session.setAttribute("aseAuthenticationAttempts",aseAuthenticationAttempts);

				authenticated = "not authenticated (LGN)";
				msg.setErrorLog(authenticated);
				msg.setMsg("Exception");
			}
			rs.close();
			rs = null;
			ps.close();
			ps = null;

		} catch (Exception e) {
			logger.fatal("userDB.authenticateUser ("+uid+"): " + e.toString());
		}

		logger.info(uid + " " + authenticated);

		return msg;
	}

	/**
	 * AuthenticateX user
	 * <p>
	 * @param conn			Connection
	 * @param uid			String
	 * @param request		HttpServletRequest
	 * @param response	HttpServletResponse
	 * @param context		ServletContext
	 * @param jsid			String
	 * <p>
	 * @return Msg
	 */
	public static synchronized Msg authenticateUserX(Connection conn,
																	String uid,
																	HttpServletRequest request,
																	HttpServletResponse response,
																	ServletContext context,
																	String jsid) throws UserNotAuthorizedException {
		Msg msg = new Msg();

		String user = "";
		String campus = "";
		String userLevel = "";
		String department = "";
		String division = "";
		String email = "";
		String fullname = "";
		String college = "";
		String authenticated = "";

		try {
			String sql = "SELECT userid,userlevel,campus,department,division,email,fullname,status,college FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,uid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				HttpSession session = request.getSession(true);

				String status = aseUtil.getValue(rs, "status");
				if (status.toLowerCase().equals("inactive")) {
					msg.setMsg("InactiveAccount");
					session.setAttribute("aseUserName", "");
					session.setAttribute("aseCampus", "");
					CookieManager.setCookie(response,"CC_User",null,0);
					CookieManager.setCookie(response,"CC_Campus",null,0);
					authenticated = "not authenticated (CAS)";
				}
				else {
					user = aseUtil.getValue(rs,"userid");
					campus = aseUtil.getValue(rs,"campus");
					userLevel = aseUtil.getValue(rs,"userlevel");
					department = aseUtil.getValue(rs,"department");
					division = aseUtil.getValue(rs,"division");
					email = aseUtil.getValue(rs,"email");
					fullname = aseUtil.getValue(rs,"fullname");
					college = aseUtil.getValue(rs,"college");

					updateSessionData(request,response,conn,user,campus,userLevel,department,division,email,fullname,context,college);

					setLastUsedDate(conn,user);
					JSIDDB.insertJSID(conn,jsid,campus,user,"","","");
					aseUtil.logAction(conn,user,"LOGIN","Log in (CAS)",jsid,"",campus,"");

					authenticated = "authenticated (CAS)";
				}

				// clear previously created temp data
				com.ase.aseutil.report.ReportingStatusDB.delete(conn,user);

				aseUtil = null;
			} else {
				authenticated = "not authenticated (CAS)";
				msg.setErrorLog(authenticated);
				msg.setMsg("Exception");
			}

			rs.close();
			rs = null;
			ps.close();
			ps = null;
		} catch (Exception e) {
			authenticated = "not authenticated (CAS)";
			msg.setErrorLog(authenticated);
			msg.setMsg("Exception");
			logger.fatal("userDB.authenticateUserX ("+uid+"): " + e.toString());
		}

		logger.info(uid + " " + authenticated);

		return msg;
	}

	/**
	 * updateSessionData
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response HttpServletResponse
	 */
	@SuppressWarnings("unchecked")
	public static void updateSessionData(HttpServletRequest request,
													HttpServletResponse response,
													Connection conn,
													String user,
													String campus,
													String userLevel,
													String department,
													String division,
													String email,
													String fullname) {

		updateSessionData(request,response,conn,user,campus,userLevel,department,division,email,fullname,null);

	}

	/**
	 * updateSessionData
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response HttpServletResponse
	 */
	@SuppressWarnings("unchecked")
	public static void updateSessionData(HttpServletRequest request,
													HttpServletResponse response,
													Connection conn,
													String user,
													String campus,
													String userLevel,
													String department,
													String division,
													String email,
													String fullname,
													ServletContext context) {

		updateSessionData(request,response,conn,user,campus,userLevel,department,division,email,fullname,context,null);

	}

	/**
	 * updateSessionData
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response HttpServletResponse
	 */
	@SuppressWarnings("unchecked")
	public static void updateSessionData(HttpServletRequest request,
													HttpServletResponse response,
													Connection conn,
													String user,
													String campus,
													String userLevel,
													String department,
													String division,
													String email,
													String fullname,
													ServletContext context,
													String college) {

		//Logger logger = Logger.getLogger("test");

		try {

			boolean debug = DebugDB.getDebug(conn,"UserDB");

			if(college == null){
				college = Constant.BLANK;
			}

			if (debug){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("userLevel: " + userLevel);
				logger.info("department: " + department);
				logger.info("division: " + division);
				logger.info("email: " + email);
				logger.info("fullname: " + fullname);
				logger.info("college: " + college);
			}

			HttpSession session = request.getSession(true);

			// application information
			if (context != null){
				session.setAttribute("aseApplicationTitle", context.getInitParameter("aseApplicationTitle"));
				session.setAttribute("aseRichEdit", context.getInitParameter("aseRichEdit"));
				session.setAttribute("aseApplicationMessage", "");
				session.setAttribute("aseTableWidth", context.getInitParameter("aseTableWidth"));
				session.setAttribute("aseTheme", Integer.parseInt(context.getInitParameter("aseTheme")));
				session.setAttribute("aseRecordsPerPage", Integer.parseInt(context.getInitParameter("aseRecordsPerPage")));
				session.setAttribute("aseApplicationDebug", Integer.parseInt(context.getInitParameter("aseApplicationDebug")));
				session.setAttribute("aseWorkInProgress", "0");
			} // context

			if (conn != null){
				String renameRenumber = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","FacultyCanRenameRenumber");
				session.setAttribute("aseMenuCourseRenameRenumber", renameRenumber);

				String deleteOutline = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowFacultyToDeleteOutline");
				session.setAttribute("aseMenuCourseDelete", deleteOutline);

				String reactivateOutline = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowFacultyToReactiveOutline");
				session.setAttribute("aseMenuCourseReactivate", reactivateOutline);

				String menuEnableSLO = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","menuEnableSLO");
				session.setAttribute("aseMenuEnableSLO", menuEnableSLO);

				String menuEnableProgram = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","menuEnableProgram");
				session.setAttribute("aseMenuEnableProgram", menuEnableProgram);

				String menuEnableFoundation = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","menuEnableFoundation");
				session.setAttribute("aseMenuEnableFoundation", menuEnableFoundation);

				String menuMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
				session.setAttribute("aseMenuMessageBoard", menuMessageBoard);

				if (debug){
					logger.info("renameRenumber: " + renameRenumber);
					logger.info("deleteOutline: " + deleteOutline);
					logger.info("reactivateOutline: " + reactivateOutline);
					logger.info("menuEnableSLO: " + menuEnableSLO);
					logger.info("menuEnableProgram: " + menuEnableProgram);
					logger.info("menuMessageBoard: " + menuMessageBoard);
				}

			} // conn

			String webDomain = "";

			String webServer = javax.servlet.http.HttpUtils.getRequestURL(request).toString();
			String testSystem = SysDB.getSys(conn,"testSystem");

			if (!webServer.equals(Constant.BLANK)){
				webDomain = webServer.replace("http://","");

				// looking for :8080 to separate domain from port
				// when using port 8080, the URL looks like this: http://localhost:8080/
				// without the port, it looks like this: http://localhost/
				if (webDomain.indexOf(":") > -1)
					webDomain = webDomain.substring(0,webDomain.indexOf(":"));
				else if (webDomain.indexOf("/") > -1)
					webDomain = webDomain.substring(0,webDomain.indexOf("/"));

				session.setAttribute("aseServer", webDomain);

				if (webServer.indexOf("cctest") > -1 ||
					webServer.indexOf("localhost") > -1 ||
					webServer.indexOf(testSystem) > -1) {
					session.setAttribute("aseSystem",">>>> THIS IS A TEST SYSTEM <<<<");
				}
				else{
					session.setAttribute("aseSystem", "");
				}
			} // webServer != blank

			session.setAttribute("aseUserFullName",fullname);
			session.setAttribute("aseUserRights", userLevel);
			session.setAttribute("aseDept",department);
			session.setAttribute("aseDivision",division);
			session.setAttribute("aseEmail",email);
			session.setAttribute("aseCollege",college);

			session.setAttribute("aseUserName", Encrypter.encrypter(user));
			session.setAttribute("aseCampus", Encrypter.encrypter(campus));
			session.setAttribute("aseApplicationMessage", "");

			HashMap sessionMap = new HashMap();
			sessionMap.put("aseUserFullName",new String(Encrypter.encrypter(fullname)));
			sessionMap.put("aseUserRights",new String(Encrypter.encrypter(userLevel)));
			sessionMap.put("aseDept",new String(Encrypter.encrypter(department)));
			sessionMap.put("aseDivision",new String(Encrypter.encrypter(division)));
			sessionMap.put("aseEmail",new String(Encrypter.encrypter(email)));
			sessionMap.put("aseCollege",new String(Encrypter.encrypter(college)));
			sessionMap.put("aseUserName",new String(Encrypter.encrypter(user)));
			sessionMap.put("aseCampus",new String(Encrypter.encrypter(campus)));
			sessionMap.put("aseApplicationMessage",new String(""));
			sessionMap.put("aseWorkInProgress",new String("0"));

			if (debug){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("userLevel: " + userLevel);
				logger.info("department: " + department);
				logger.info("division: " + division);
				logger.info("email: " + email);
				logger.info("fullname: " + fullname);
				logger.info("college: " + college);
			}

			// save campus spefic CC settings to session for quick access
			String sql = "SELECT kid,kval1 FROM tblini WHERE campus=? AND category='System' AND kedit='Y'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);

			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				sessionMap.put(rs.getString("kid"),new String(Encrypter.encrypter(rs.getString("kval1"))));
			}
			rs.close();
			ps.close();

			session.setAttribute("aseSessionMap", (HashMap)sessionMap);

			CookieManager.setCookie(response,"CC_User",user,CookieManager.MAX_COOKIE_AGE);
			CookieManager.setCookie(response,"CC_Campus",campus,CookieManager.MAX_COOKIE_AGE);

			//logger.info("userDB: updateSessionData - " + user);
		} catch (SQLException e) {
			logger.info("userDB: updateSessionData - " + e.toString());
		} catch (Exception e) {
			logger.info("userDB: updateSessionData - " + e.toString());
		}
	}

	/*
	 * Returns a list of users and distribution list from getCampusUsersAndDistribution
	 * <p>
	 * @param connection	Connection
	 * @param campus		String
	 * @param user			String
	 * <p>
	 * @return String
	 */
	 public static String getCampusUsersAndDistribution(Connection connection,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer users = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String junk = "";
		String fullName = "";

		PreparedStatement ps;
		ResultSet rs;

		try {
			String sql = "SELECT userid, lastname + ', ' + firstname AS fullname FROM tblUsers WHERE campus=? ORDER BY lastname, firstname";
			users.append("<select class=\'smalltext\' name=\'campusUser\' size=\'1\' id=\'campusUser\'>");
			users.append("<option value=\"\">- select -</option>");
			ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while (rs.next()) {
				junk = AseUtil.nullToBlank(rs.getString("userid"));
				fullName = AseUtil.nullToBlank(rs.getString("fullName"));

				if (!user.equals(Constant.BLANK) && junk.equals(user)){
					users.append("<option selected value=\"" + junk + "\">" + fullName + "</option>");
				}
				else{
					users.append("<option value=\"" + junk + "\">" + fullName + "</option>");
				}
			}
			rs.close();

			// determine if distrubition level approval has been set before including list
			Ini ini = IniDB.getIniByCampusCategoryKid(connection,campus,"System","OutlineDistributionApproval");
			String outlineDistributionApproval = ini.getKval1();
			if (outlineDistributionApproval != null && outlineDistributionApproval.length() > 0){
				sql = "SELECT title FROM tblDistribution WHERE campus=? ORDER BY title";
				ps = connection.prepareStatement(sql);
				ps.setString(1,campus);
				rs = ps.executeQuery();
				while (rs.next()) {
					junk = "[" + rs.getString(1).trim() + "]";

					if (!user.equals(user) && junk.equalsIgnoreCase(Constant.BLANK)){
						users.append("<option selected value=\"" + junk + "\">" + junk + "</option>");
					}
					else{
						users.append("<option value=\"" + junk + "\">" + junk + "</option>");
					}
				}
				rs.close();
				ps.close();
			} // distribution

			users.append("</select>");
			junk = users.toString();
		} catch (Exception e) {
			logger.fatal("UserDB: getCampusUsersAndDistribution - " + e.toString());
			junk = "";
		}

		return junk;
	}

	/**
	 * getSendNow
	 * <p>
	 * @param conn	Connection
	 * @param user	String
	 * <p>
	 * @return boolean
	 */
	public static boolean getSendNow(Connection conn,String user) {

		boolean sendNow = true;
		int sendnow = 0;

		try {
			String sql = "SELECT sendnow FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				sendnow = NumericUtil.nullToZero(rs.getInt(1));

				if (sendnow==1)
					sendNow = true;
				else
					sendNow = false;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getSendNow - " + e.toString());
		}
		return sendNow;
	}

	/**
	 * getSendNowWithEmail
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param email	String
	 * <p>
	 * @return boolean
	 */
	public static boolean getSendNowWithEmail(Connection conn,String campus,String email) {

		//Logger logger = Logger.getLogger("test");

		boolean sendNow = false;

		try {

			// when using this routing, it is expecting an email address. however, if the
			// email was saved without the domain, we will use userid as a backup check
			String sql = "SELECT sendnow FROM tblUsers WHERE campus=? AND (email like '%"+email+"%' OR userid=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (NumericUtil.getInt(rs.getInt("sendnow"),0)==1){
					sendNow = true;
				}
				else{
					sendNow = false;
				}
			}
			else{
				sendNow = false;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getSendNowWithEmail - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: getSendNowWithEmail - " + e.toString());
		}

		return sendNow;
	}

	public static boolean getSendNowWithEmailOBSOLETE(Connection conn,String campus,String email) {

		//Logger logger = Logger.getLogger("test");

		boolean sendNow = false;

		try {

			// when using this routing, it is expecting an email address. however, if the
			// email was saved without the domain, we will use userid as a backup check
			String sql = "SELECT sendnow FROM tblUsers WHERE campus=? AND (email like '%"+email+"%' OR userid=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (NumericUtil.getInt(rs.getInt("sendnow"),0)==1){
					sendNow = true;
				}
				else{
					sendNow = false;
				}
			}
			else{
				sendNow = false;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getSendNowWithEmail - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: getSendNowWithEmail - " + e.toString());
		}

		return sendNow;
	}

	/**
	 * setUserDepartment
	 * <p>
	 * @param	conn			Connection
	 * @param	user			String
	 * @param	dept			String
	 * <p>
	 * @return	int
	 */
	public static int setUserDepartment(Connection conn,String user,String dept) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblUsers SET department=? WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,dept);
			ps.setString(2,user);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: setUserDepartment - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: setUserDepartment - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getUserAlphas
	 * <p>
	 * @param	conn		Connection
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String getUserAlphas(Connection conn,String user) {

		//Logger logger = Logger.getLogger("test");

		String alphas = null;

		String sql = "SELECT alphas FROM tblUsers WHERE userid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				alphas = AseUtil.nullToBlank(rs.getString("alphas"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getUserAlphas - " + e.toString());
		}

		return alphas;
	}

	/**
	 * security updateUserAlphas
	 * <p>
	 * @param	conn		Connection
	 * @param	user		String
	 * @param	alphas	String
	 * <p>
	 * @return	int
	 */
	public static int updateUserAlphas(Connection conn,String user,String newAlphas) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			// get existing alphas and combine
			String alphas = getUserAlphas(conn,user);

			if (newAlphas != null){

				if (alphas != null){
					newAlphas = newAlphas + "," + alphas;
				}

				newAlphas = Util.removeDuplicateFromString(newAlphas);

				String sql = "UPDATE tblUsers SET alphas=? WHERE userid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,newAlphas);
				ps.setString(2,user);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("userDB.updateUserAlphas - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getUserAttachment
	 * <p>
	 * @param	conn		Connection
	 * @param	user		String
	 * <p>
	 * @return	boolean
	 */
	public static boolean getUserAttachment(Connection conn,String user) {

		//Logger logger = Logger.getLogger("test");

		boolean attachment = false;

		String sql = "SELECT attachment FROM tblUsers WHERE userid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){

				int attach = 0;

				try{
					attach = rs.getInt("attachment");
				}
				catch(Exception e){
					attach = 0;
				} // try-catch

				if (attach==1){
					attachment = true;
				}
				else{
					attachment = false;
				} // attach

			} // if rs

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("userDB: getUserAlphas - " + e.toString());
		}

		return attachment;
	}

	/*
	 * getUsers
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * <p>
	 * @return Banner
	 */
	public static List<User> getUsers(Connection conn,String campus,int idx) {

		List<User> UserData = null;

		try {
			if (UserData == null){

            UserData = new LinkedList<User>();

				String sql = "SELECT * FROM tblUsers WHERE campus=? ";

				if (idx > 0){
					sql += "AND userid like '"+(char)idx+"%' ";
				}

				sql += " ORDER BY userid";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	UserData.add(new User(
										AseUtil.nullToBlank(rs.getString("userid")),
										AseUtil.nullToBlank(rs.getString("firstname")),
										AseUtil.nullToBlank(rs.getString("lastname")),
										AseUtil.nullToBlank(rs.getString("position")),
										AseUtil.nullToBlank(rs.getString("status")),
										AseUtil.nullToBlank(rs.getString("division")),
										AseUtil.nullToBlank(rs.getString("department")),
										AseUtil.nullToBlank(rs.getString("title")),
										AseUtil.nullToBlank(rs.getString("campus")),
										NumericUtil. nullToZero(rs.getString("userlevel")),
										AseUtil.nullToBlank(rs.getString("college"))
									));
				} // while
				rs.close();
				ps.close();
			} // if
		} catch (SQLException e) {
			logger.fatal("UserDB: getUsers\n" + e.toString());
			return null;
		}

		return UserData;
	}

	/**
	 * getUserCount
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	level		int
	 * <p>
	 * @return	int
	 */
	public static int getUserCount(Connection conn,String campus,int level) {

		//Logger logger = Logger.getLogger("test");

		int count = 0;

		String sql = "SELECT count(userid) as counter FROM tblUsers WHERE campus=? AND userlevel=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,level);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				count = rs.getInt("counter");
			} // if rs
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("userDB: getUserCount - " + e.toString());
		}

		return count;
	}

	/**
	 * getCollegeCode
	 * <p>
	 * @param	conn		Connection
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String getCollegeCode(Connection conn,String user) {

		//Logger logger = Logger.getLogger("test");

		String collegeCode = null;

		String sql = "SELECT college FROM tblUsers WHERE userid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				collegeCode = AseUtil.nullToBlank(rs.getString("college"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getCollegeCode - " + e.toString());
		} catch (Exception e) {
			logger.fatal("userDB: getCollegeCode - " + e.toString());
		}

		return collegeCode;
	}

	/*
	 * getItem
	 *	<p>
	 *	@return String
	 */
	public static String getItem(Connection conn,String key,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String item = "";

		try {
			String sql = "SELECT " + column + " FROM tblusers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,key);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		}
		catch (SQLException e) {
			logger.fatal("userDB.getItem: " + e.toString());
		}
		catch (Exception e) {
			logger.fatal("userDB.getItem: " + e.toString());
		}

		return item;
	}

	/**
	 * getLastFirstName
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * <p>
	 * @return String
	 */
	public static String getLastFirstName(Connection conn, String userid) {

		String fullName = "";

		try {
			String sql = "SELECT lastname + ', ' + firstname as fullname from tblUsers WHERE userid=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				fullName = aseUtil.getValue(rs, "fullname");
				aseUtil = null;
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("userDB: getLastFirstName - " + e.toString());
		}

		return fullName;
	}

	/**
	 * getUserFriendlyName
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * <p>
	 * @return String
	 */
	public static String getUserFriendlyName(Connection conn, String userid) {

		String fullName = "";

		try {
			String sql = "SELECT lastname + ', ' + firstname as fullname from tblUsers WHERE userid=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userid);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				fullName = aseUtil.getValue(rs, "fullname") + " (" + userid + ")";
				aseUtil = null;
			}
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
		} catch (Exception e) {
			logger.fatal("userDB: getUserFriendlyName - " + e.toString());
		}

		return fullName;
	}

	/**
	 * getProfileImage
	 * <p>
	 * @param conn	Connection
	 * @param user	String
	 * <p>
	 * @return String
	 */
	public static String getProfileImage(Connection conn,String user) {
		String profileImage = "";
		try {
			String sql = "SELECT weburl FROM tblUsers WHERE userid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				profileImage = AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("userDB: getProfileImage - " + e.toString());
		}
		return profileImage;
	}

	/*
	 * changeUserId
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	fromID	String
	 * @param	toID		String
	 *	<p>
	 * @return String
	 */
	public static String changeUserId(Connection conn,String campus,String fromID,String toID) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer progress = new StringBuffer();

		String table = "";

		try {

			progress.append("Campus: " + campus + "<br>").append("From ID: " + fromID + "<br>").append("To ID: " + toID + "<br>");

			//
			//	tblapproval
			//
			table = "tblapproval";
			String sql = "UPDATE tblapproval SET approved_by=? WHERE campus=? AND approved_by=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			int rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblapproval - approved_by<br>");
			ps.close();

			//
			//	tblApprovalhist
			//
			table = "tblApprovalhist - approver";
			sql = "UPDATE tblApprovalhist SET approver=? WHERE campus=? AND approver=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblApprovalhist - approver<br>");
			ps.close();

			table = "tblApprovalhist - inviter";
			sql = "UPDATE tblApprovalhist SET inviter=? WHERE campus=? AND inviter=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblApprovalhist - inviter<br>");
			ps.close();

			//
			//	tblApprovalhist2
			//
			table = "tblApprovalhist2 - approver";
			sql = "UPDATE tblApprovalhist2 SET approver=? WHERE campus=? AND approver=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblApprovalhist2 - approver<br>");
			ps.close();

			table = "tblApprovalhist2 - inviter";
			sql = "UPDATE tblApprovalhist2 SET inviter=? WHERE campus=? AND inviter=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblApprovalhist2 - inviter<br>");
			ps.close();

			//
			//	tblapprover
			//
			table = "tblapprover - approver";
			sql = "UPDATE tblapprover SET approver=? WHERE campus=? AND approver=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblapprover - approver<br>");
			ps.close();

			table = "tblapprover - delegated";
			sql = "UPDATE tblapprover SET delegated=? WHERE campus=? AND delegated=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblapprover - delegated<br>");
			ps.close();

			//
			//	tblauthority
			//
			table = "tblauthority - delegated";
			sql = "UPDATE tblauthority SET delegated=? WHERE campus=? AND delegated=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblauthority - delegated<br>");
			ps.close();

			table = "tblauthority - chair";
			sql = "UPDATE tblauthority SET chair=? WHERE campus=? AND chair=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblauthority - chair<br>");
			ps.close();

			//
			//	tblcourse
			//
			table = "tblcourse - proposer";
			sql = "UPDATE tblcourse SET proposer=? WHERE campus=? AND coursetype='PRE' AND proposer=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblcourse - prooser<br>");
			ps.close();

			//
			//	tbldivision
			//
			table = "tbldivision - chairname";
			sql = "UPDATE tbldivision SET chairname=? WHERE campus=? AND chairname=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tbldivision - chairname<br>");
			ps.close();

			table = "tbldivision - delegated";
			sql = "UPDATE tbldivision SET delegated=? WHERE campus=? AND delegated=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tbldivision - delegated<br>");
			ps.close();

			//
			//	tblreviewers
			//
			table = "tblreviewers - userid";
			sql = "UPDATE tblreviewers SET userid=? WHERE campus=? AND userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tblreviewers - userid<br>");
			ps.close();

			//
			//	tbltasks
			//
			table = "tbltasks - submittedby";
			sql = "UPDATE tbltasks SET submittedby=? WHERE campus=? AND submittedby=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tbltasks - submittedby<br>");
			ps.close();

			table = "tbltasks - submittedfor";
			sql = "UPDATE tbltasks SET submittedfor=? WHERE campus=? AND submittedfor=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tbltasks - submittedfor<br>");
			ps.close();

			table = "tbltasks - inviter";
			sql = "UPDATE tbltasks SET inviter=? WHERE campus=? AND inviter=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toID);
			ps.setString(2,campus);
			ps.setString(3,fromID);
			rowsAffected =  ps.executeUpdate();
			progress.append("Updated " + rowsAffected + " rows from tbltasks - inviter<br>");
			ps.close();

			//
			//	tbldistribution
			//
			int seq = 0;
			String members = "";
			table = "tbldistribution - members";
			sql = "SELECT seq, members FROM tbldistribution WHERE campus=? AND members like '%"+fromID+"%'";
			PreparedStatement ps2 = conn.prepareStatement(sql);
			ps2.setString(1,campus);
			ResultSet rs =  ps2.executeQuery();
			while(rs.next()){
				seq = rs.getInt("seq");
				members = rs.getString("members");
				members = members.replace(fromID,toID);

				sql = "UPDATE tbldistribution SET members=? WHERE campus=? AND seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,members);
				ps.setString(2,campus);
				ps.setInt(3,seq);
				rowsAffected =  ps.executeUpdate();
				progress.append("Updated " + rowsAffected + " rows from tbldistribution - members<br>");
				ps.close();
			}
			rs.close();
			ps2.close();

			//
			//	tblemaillist
			//
			table = "tblemaillist - members";
			sql = "SELECT seq, members FROM tblemaillist WHERE campus=? AND members like '%"+fromID+"%'";
			ps2 = conn.prepareStatement(sql);
			ps2.setString(1,campus);
			rs =  ps2.executeQuery();
			while(rs.next()){
				seq = rs.getInt("seq");
				members = rs.getString("members");
				members = members.replace(fromID,toID);

				sql = "UPDATE tblemaillist SET members=? WHERE campus=? AND seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,members);
				ps.setString(2,campus);
				ps.setInt(3,seq);
				rowsAffected =  ps.executeUpdate();
				progress.append("Updated " + rowsAffected + " rows from tblemaillist - members<br>");
				ps.close();
			}
			rs.close();
			ps2.close();


		} catch (SQLException e) {
			logger.fatal("TSql.changeUserId: " + e.toString() + "\n" + table);
		} catch (Exception e) {
			logger.fatal("TSql.changeUserId: " + e.toString() + "\n" + table);
		}

		return progress.toString();
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}