/*
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static int deleteList(Connection connection, int lid)
 *	public static Distribution getDistribution(Connection connection, int did)
 *	public static Distribution getDistributions(Connection connection, String campus)
 *	public static String getDistributionMembers(Connection connection, int did)
 *	public static String getDistributionMembers(Connection connection,String campus,String dist)
 *	public static String getDistributionMembersDDL(Connection conn,String campus,String dist) throws Exception {
 *	public static String getDistributionName(Connection connection, int did)
 *	public static boolean hasMember(Connection connection,String campus,String dist,String member)
 *	public static int insertList(Connection connection,Distribution distribution)
 *	public static boolean isDistributionList(Connection conn,String campus,String dist) throws Exception {
 *	public static int membersInDistribution(String dist) throws Exception {
 *	public static boolean notifyDistribution(Connection conn,String campus,String alpha,String num,String type,String from,String cc,String bcc,String msg,String dist)
 *	public static String removeBracketsFromList(String dist)
 *	public static int updateList(Connection connection,Distribution distribution)
 *
 */

//
// DistributionDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class DistributionDB {

	static Logger logger = Logger.getLogger(DistributionDB.class.getName());

	public DistributionDB() throws Exception {}

	/**
	 * deleteList
	 */
	public static int deleteList(Connection connection, int lid) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblDistribution WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, lid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: deleteList - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertList
	 */
	public static int insertList(Connection connection,Distribution distribution) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		try {
			logger.info("--------------------------- DistributionDB - insertList - START");

			String insertSQL = "INSERT INTO tblDistribution(title,campus,members,auditby) VALUES(?,?,?,?)";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, distribution.getTitle());
			ps.setString(2, distribution.getCampus());

			String members = Util.stringToArrayToString(distribution.getMembers(),",",true);
			ps.setString(3, members);

			ps.setString(4, distribution.getAuditBy());
			rowsAffected = ps.executeUpdate();
			ps.close();

			logger.info("\n" + distribution);

			logger.info("--------------------------- DistributionDB - insertList - END");

		} catch (SQLException e) {
			logger.fatal("DistributionDB: insertList - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("DistributionDB: insertList - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateList
	 */
	public static int updateList(Connection connection,Distribution distribution) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			logger.info("--------------------------- DistributionDB - updateList - START");

			String insertSQL = "UPDATE tblDistribution SET title=?,members=?,auditby=? WHERE campus=? AND seq=?";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1,distribution.getTitle());

			String members = Util.stringToArrayToString(distribution.getMembers(),",",true);
			ps.setString(2,members);
			ps.setString(3,distribution.getAuditBy());
			ps.setString(4,distribution.getCampus());
			ps.setInt(5, distribution.getListID());
			rowsAffected = ps.executeUpdate();
			ps.close();

			logger.info("\n" + distribution);

			logger.info("--------------------------- DistributionDB - updateList - END");

		} catch (SQLException e) {
			logger.fatal("DistributionDB: updateList - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getDistributionMembers - list members by list id (index)
	 *	<p>
	 *	@param	connection	Connection
	 * @param	did			int
	 *	<p>
	 *	@return String
	 */
	public static String getDistributionMembers(Connection connection, int did) {

		String distributionMembers = null;
		try {
			String sql = "SELECT members FROM tblDistribution WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,did);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				distributionMembers = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getDistributionMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return distributionMembers;
	}

	/*
	 * getDistributionMembers - list members by list name
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	dist			String
	 *	<p>
	 *	@return String
	 */
	public static String getDistributionMembers(Connection connection,String campus,String dist) {

		String distributionMembers = "";

		try {
			String sql = "SELECT members "
				+ "FROM tblDistribution "
				+ "WHERE campus=? AND title=?";

			String[] members = dist.split(",");

			for (int i=0;i<members.length;i++){
				dist = removeBracketsFromList(members[i]);
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,dist);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					if (!(Constant.BLANK).equals(distributionMembers))
						distributionMembers = distributionMembers + "," + rs.getString(1);
					else
						distributionMembers = rs.getString(1);
				}
				else{
					if (!"".equals(distributionMembers))
						distributionMembers = distributionMembers + "," + dist;
					else
						distributionMembers = dist;
				}

				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getDistributionMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: getDistributionMembers - " + ex.toString());
		}

		return distributionMembers;
	}

	/*
	 * getDistributionName - the list name <p> @return String
	 */
	public static String getDistributionName(Connection connection, int did) {
		String distributionListName = null;
		try {
			String sql = "SELECT title FROM tblDistribution WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, did);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				distributionListName = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getDistributionListName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return distributionListName;
	}

	/*
	 * getDistribution - returns the entire record
	 *	<p>
	 *	@return Distribution
	 */
	public static Distribution getDistribution(Connection connection, int did) {
		Distribution distribution = new Distribution();
		try {
			String sql = "SELECT title,members,auditby,auditdate FROM tblDistribution WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, did);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				distribution.setTitle(rs.getString(1));
				distribution.setMembers(rs.getString(2));
				distribution.setAuditBy(rs.getString(3));
				AseUtil aseUtil = new AseUtil();
				distribution.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString(4),Constant.DATE_DATETIME));
				aseUtil = null;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getDistributionListName - " + e.toString());
			distribution = null;
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return distribution;
	}

	/*
	 * getDistributions - returns all distribution names
	 *	<p>
	 *	@param	Connection	conn
	 *	@param	String		campus
	 *	<p>
	 *	@return 	String
	 */
	public static String getDistributions(Connection conn,String campus) {

		String distributions = "";
		String temp = "";
		try {
			String sql = "SELECT title FROM tblDistribution WHERE campus=? ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				temp = AseUtil.nullToBlank(rs.getString(1));
				if (distributions.length() == 0)
					distributions = temp;
				else
					distributions = distributions + "," + temp;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getDistributions - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: getDistributions - " + ex.toString());
		}

		return distributions;
	}

	/*
	 * hasMember - returns true/false whether the distribution contains certain member
	 *	<p>
	 *	@param	Connection	connection
	 * @param	String		campus
	 * @param	String		dist
	 * @param	String		member
	 *	<p>
	 *	@return boolean
	 */
	public static boolean hasMember(Connection connection,
												String campus,
												String dist,
												String member) {

		boolean found = false;
		String members = "";

		try {
			String sql = "SELECT members FROM tblDistribution WHERE campus=? AND title=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, dist);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				members = resultSet.getString(1);
				if (members.indexOf(member) >= 0)
					found = true;
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: hasMember - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: hasMember - " + ex.toString());
		}

		return found;
	}


	/*
	 * notifyDistribution
	 *	<p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param alpha	String
	 *	@param num		String
	 *	@param type		String
	 *	@param from		String
	 *	@param cc		String
	 *	@param bcc		String
	 *	@param msg		String
	 *	@param dist		String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean notifyDistribution(Connection conn,
															String campus,
															String alpha,
															String num,
															String type,
															String from,
															String cc,
															String bcc,
															String msg,
															String dist) {

		return notifyDistribution(conn,campus,alpha,num,type,from,cc,bcc,msg,dist,"");
	}

	public static boolean notifyDistribution(Connection conn,
															String campus,
															String alpha,
															String num,
															String type,
															String from,
															String cc,
															String bcc,
															String msg,
															String dist,
															String user) {

		String notified = "";

		try{
			AseUtil aseUtil = new AseUtil();

			// either a distribution list name is sent or a list of names is sent
			if (!dist.equals(Constant.BLANK))
				notified = aseUtil.lookUp(conn, "tblDistribution", "members", "campus='" + campus + "' AND title='" + dist + "'");
			else{
				notified = cc;
				cc = "";
			}

			if (!notified.equals(Constant.BLANK)){
				String kix = Helper.getKix(conn,campus,alpha,num,type);
				MailerDB mailerDB = new MailerDB(conn,from,notified,cc,bcc,alpha,num,campus,msg,kix,user);
			}
		}
		catch(Exception ex){
			logger.fatal("DistributionDB: notifyDistribution - " + ex.toString());
			return false;
		}

		return true;
	}


	/*
	 * isDistributionList
	 * <p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param dist		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isDistributionList(Connection conn,String campus,String dist) throws Exception {

		boolean list = false;

		try {
			if (dist != null && dist.length() > 0){

				String sql = "SELECT title "
						+ "FROM tblDistribution "
						+ "WHERE campus=? "
						+ "AND title=? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, removeBracketsFromList(dist));
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					list = true;
				}

				rs.close();
				ps.close();
			}
		} catch (Exception e) {
			logger.fatal("DistributionDB: isDistributionList - " + e.toString());
		}

		return list;
	}

	/*
	 * removeBracketsFromList
	 * <p>
	 *	@param dist String
	 * <p>
	 * @return String
	 */
	public static String removeBracketsFromList(String dist) throws Exception {

		try {
			dist = dist.replace("[","");
			dist = dist.replace("]","");
		} catch (Exception e) {
			logger.fatal("DistributionDB: removeBracketsFromList - " + e.toString());
		}

		return dist;
	}

	/*
	 * removeBracketsFromList
	 * <p>
	 *	@param conn		Connection
	 *	@param campus 	String
	 *	@param dist 	String
	 * <p>
	 * @return String
	 */
	public static int membersInDistribution(Connection conn,String campus,String dist) throws Exception {

		String comma = ",";
		int members = 0;

		/*
			get the members of the distribution then from there, count how many of them
			there are.
		*/
		try{
			String OutlineDistributionMembers = getDistributionMembers(conn,campus,dist);

			if (!"".equals(OutlineDistributionMembers)){
				int len = OutlineDistributionMembers.length();

				if (len > 0) {
					int start = OutlineDistributionMembers.indexOf(comma);
					while (start != -1) {
						members++;
						start = OutlineDistributionMembers.indexOf(comma, start+1);
					}

					++members;
				}
			}
		}catch(Exception e){
			logger.fatal("Distribution - membersInDistribution - " + e.toString());
		}

		return members;
	}

	/*
	 * getAllDistributionMembers - returns a listing of all dist on all campuses
	 *	<p>
	 *	@param	connection	Connection
	 * @param	dist			String
	 *	<p>
	 *	@return String
	 */
	public static String getAllDistributionMembers(Connection conn,String dist) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = null;
		String[] campuses = new String[20];

		try {
			String contacts = "";

			// retrieve listing of campuses
			String campus = CampusDB.getCampusNames(conn);

			// breaking into array
			if (campus != null && !"".equals(campus)){
				campuses = campus.split(",");

				String sql = "SELECT members "
					+ "FROM tblDistribution "
					+ "WHERE campus=? AND title=?";

				buf = new StringBuffer();

				PreparedStatement ps;
				ResultSet rs;

				// cycle through each campus and get the list of names
				for (int i=0;i<campuses.length;i++){
					ps = conn.prepareStatement(sql);
					ps.setString(1,campuses[i]);
					ps.setString(2,dist);
					rs = ps.executeQuery();
					if (rs.next()) {
						contacts = AseUtil.nullToBlank(rs.getString(1)) + ",";
						contacts = contacts.toLowerCase().replace(",","@hawaii.edu<br>");

						buf.append("<ul>");
						buf.append("<li>"+campuses[i]+"</li>");
						buf.append("<ul>");
						buf.append("<li>"+contacts+"</li>");
						buf.append("</ul>");
						buf.append("</ul>");
					}
					rs.close();
					ps.close();
				}
			} // if campus != null
		} catch (SQLException e) {
			logger.fatal("DistributionDB: getAllDistributionMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: getAllDistributionMembers - " + ex.toString());
		}

		return buf.toString();
	}

	/*
	 * Returns a drop down list box of members in a distribution list
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String getDistributionMembersDDL(Connection conn,String campus,String dist) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		try {
			sql =  getDistributionMembers(conn,campus,dist);

			sql = "'" + sql.replace(",","','") + "'";

			sql = "SELECT userid, lastname + ', ' + firstname + ' (' + userid + ')' AS fullname "
					+ "FROM tblUsers "
					+ "WHERE campus='"+campus+"' "
					+ "AND userid IN ("+sql+") "
					+ "ORDER BY lastname,firstname";

			AseUtil au = new AseUtil();
			sql = au.createSelectionBox(conn, sql, "toList", "", "", "10", false, "" );
			au = null;

		} catch (Exception e) {
			logger.fatal("DistributionDB: getDistributionMembersDDL - " + e.toString());
		}

		return sql;
	}

	/*
	 * Takes a list of names and expand it by removing any occurance of distribution list names
	 * <p>
	 * @param	conn		Connection
	 * @param	campus		String
	 * @param	names		String
	 * @param	allowDups	boolean
	 * <p>
	 * @return String
	 */
	public static String expandNameList(Connection conn,String campus,String names) throws Exception {

		boolean allowDups = false;

		return expandNameList(conn,campus,names,allowDups);
	}

	public static String expandNameList(Connection conn,String campus,String names,boolean allowDups) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {
			if (names != null && names.length() > 0){

				names = names.replace(Constant.SPACE,"");

				String temp = "";
				String[] junk = names.split(",");
				names = "";
				for (int iJunk = 0; iJunk < junk.length; iJunk++){

					temp = junk[iJunk];

					boolean isDistributionList = DistributionDB.isDistributionList(conn,campus,junk[iJunk]);
					if (isDistributionList){
						temp = DistributionDB.getDistributionMembers(conn,campus,temp);
					} // if

					if (names.equals(Constant.BLANK)){
						names = temp;
					}
					else{
						names = names + "," + temp;
					}

				} // for

				// are dups permitted?
				if (!allowDups && names != null && names.length() > 0){
					names = Util.removeDuplicateFromString(names);
				}

			} // if

		} catch (Exception e) {
			logger.fatal("DistributionDB: expandNameList - " + e.toString());
		}

		return names;
	}

	/**
	 * getDistributionCount
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int getDistributionCount(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		int count = 0;

		String sql = "SELECT count(seq) as counter FROM tblDistribution WHERE campus=?";
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
			logger.fatal("DistributionDB: getDistributionCount - " + e.toString());
		}

		return count;
	}

	/**
	 * updateMembersList
	 */
	public static int updateMembersList(Connection conn,String campus,String title,String members) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblDistribution SET members=? WHERE campus=? AND title=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,members);
			ps.setString(2,campus);
			ps.setString(3,title);
			rowsAffected = ps.executeUpdate();
		} catch (SQLException e) {
			logger.fatal("DistributionDB: updateMembersList - " + e.toString());
		} catch (Exception e) {
			logger.fatal("DistributionDB: updateMembersList - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateMembers
	 */
	public static int updateMembers(Connection connection,int id,String members,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			logger.info("--------------------------- DistributionDB - updateMembers - START");

			String insertSQL = "UPDATE tblDistribution SET members=?,auditby=? WHERE campus=? AND seq=?";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1,Util.stringToArrayToString(members,",",true));
			ps.setString(2,user);
			ps.setString(3,campus);
			ps.setInt(4,id);
			rowsAffected = ps.executeUpdate();
			ps.close();

			logger.info("--------------------------- DistributionDB - updateMembers - END");

		} catch (SQLException e) {
			logger.fatal("DistributionDB: updateMembers - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("DistributionDB: updateMembers - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * drawSysEditTable
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String drawEditTable(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		int i = 0;

		String rowClass = "";

		int rowCounter = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			sb.append("<div id=\"aseEdit\" class=\"base-container ase-table-layer\">");

			sb.append("<div class=\"ase-table-row-header\">"
						+ "<div class=\"left-layer20\">Title</div>"
						+ "<div class=\"left-layer40\">Members&nbsp;&nbsp;<img src=\"../images/edit.gif\" boder=\"0\" title=\"editable column\" alt=\"editable column\"></div>"
						+ "<div class=\"left-layer20\">Updated By</div>"
						+ "<div class=\"left-layer20\">Updated Date</div>"
						+ "<div id=\"ras\" class=\"space-line\"></div>"
						+ "</div>");

			String sql = "SELECT seq,Title,Members,auditby,auditdate FROM tbldistribution WHERE campus=? ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				int seq = rs.getInt("seq");
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String members = AseUtil.nullToBlank(rs.getString("members"));
				if (members != null){
					members = members.replace(",",", ");
				}
				String auditby = AseUtil.nullToBlank(rs.getString("auditby"));
				String auditdate = aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME);

				if (++rowCounter % 2 == 0){
					rowClass = "ase-table-row-detail-alt";
				}
				else{
					rowClass = "ase-table-row-detail";
				}

				sb.append("<div id=\"record-"+i+"\" class=\""+rowClass+"\">"
					+ "<div class=\"left-layer20\"><a href=\"dstlst.jsp?lid="+seq+"\" class=\"linkcolumn\">"+title+"</a></div>"
					+ "<div class=\"edit-distribution left-layer40Edit\" id=\""+seq+"\">"+members+"</div>"
					+ "<div class=\"left-layer20\">"+auditby+"</div>"
					+ "<div class=\"left-layer20\">"+auditdate+"</div>"
					+ "<div id=\"ras\" class=\"space-line\"></div>"
					+ "</div>");

				++i;
			}

			rs.close();
			ps.close();

			sb.append("</div>");

			aseUtil = null;

		} catch (SQLException e) {
				logger.fatal("DistributionDB: createMissingSettingForCampus - " + e.toString());
		} catch (Exception e) {
				logger.fatal("DistributionDB: createMissingSettingForCampus - " + e.toString());
		}

		return sb.toString();

	}

	/*
	 * Returns a list of users by campus <p> @return String
	 *	<p>
	 * @param	connection			Connection
	 * @param	selectedCampus		String
	 *	<p>
	 * @return String
	 */
	public static String getCampusUsersNotInListDDL(Connection conn,String campus,int listID) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer users = new StringBuffer();

		try {
			String sql = "";

			// with list returned as comma between values, isolate to avoid
			// including in returned list box
			String members = "";
			if(listID > 0){
				members = EmailListsDB.getEmailListMembers(conn,listID);
			}

			if(!members.equals(Constant.BLANK)){
				members = "'" + members.replace(",","','") + "'";
				sql = "SELECT userid, lastname + ', ' + firstname AS fullname FROM tblUsers "
					+ "WHERE campus=? AND userid NOT IN ("+members+") ORDER BY lastname,firstname";
			}
			else{
				sql = "SELECT userid, lastname + ', ' + firstname AS fullname FROM tblUsers WHERE campus=? ORDER BY lastname,firstname";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			users.append("<table id=\"tableGetCampusUsers\" border=\"0\"><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			while (rs.next()) {
				String userid = AseUtil.nullToBlank(rs.getString("userid"));
				String name = AseUtil.nullToBlank(rs.getString("fullname"));
				users.append("<option value=\"" + userid + "\">" + name + "</option>");
			}

			users.append("</select></td></tr></table>");

			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("DistributionDB: getCampusUsersNotInListDDL - " + e.toString());
		}

		return users.toString();
	}


	/*
	 * Returns a list of users by campus <p> @return String
	 *	<p>
	 * @param	connection			Connection
	 * @param	selectedCampus		String
	 *	<p>
	 * @return String
	 */
	public static String getEmailListMembersDDL(Connection conn,String campus,int listID) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer users = new StringBuffer();

		try {

			String sql = "";
			String members = "";
			if(listID > 0){
				members = EmailListsDB.getEmailListMembers(conn,listID);

				if(!members.equals(Constant.BLANK)){
					members = "'" + members.replace(",","','") + "'";

					sql = "SELECT userid, lastname + ', ' + firstname AS fullname FROM tblUsers "
							+ "WHERE campus=? AND userid IN ('',"+members+") ORDER BY lastname,firstname";

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ResultSet rs = ps.executeQuery();
					users.append("<table id=\"tableGetCampusUsers\" border=\"0\"><tr><td><select class=\'smalltext\' name=\'toList\' size=\'10\' id=\'toList\'>");
					while (rs.next()) {
						String userid = AseUtil.nullToBlank(rs.getString("userid"));
						String name = AseUtil.nullToBlank(rs.getString("fullname"));
						users.append("<option value=\"" + userid + "\">" + name + "</option>");
					}

					users.append("</select></td></tr></table>");

					rs.close();
					ps.close();

				}
			}
			else{
				users.append("<table id=\"tableGetCampusUsers\" border=\"0\"><tr><td><select class=\'smalltext\' name=\'toList\' size=\'10\' id=\'toList\'>");
				users.append("</select></td></tr></table>");
			}

		} catch (Exception e) {
			logger.fatal("DistributionDB: getEmailListMembersDDL - " + e.toString());
		}

		return users.toString();
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}