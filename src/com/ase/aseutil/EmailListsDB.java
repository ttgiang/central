/*
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int deleteList(Connection connection, int lid)
 *	public static String expandListNames(Connection conn,String campus,String user,String reviewers) throws Exception {
 *	public static EmailList getEmailList(Connection connection, int did)
 *	public static EmailList getEmailLists(Connection connection, String campus)
 *	public static String getEmailListMembers(Connection connection, int did)
 *	public static String getEmailListMembers(Connection connection,String user,String dist)
 *	public static String getEmailListMembers(Connection connection,String campus,String user,String dist)
 *	public static String getEmailListName(Connection connection, int did)
 *	public static boolean hasMember(Connection connection,String campus,String dist,String member)
 *	public static int insertList(Connection connection,EmailList distribution)
 *	public static boolean isEmailListList(Connection conn,String campus,String dist) throws Exception {
 *	public static int membersInEmailList(String dist) throws Exception {
 *	public static boolean notifyEmailList(Connection conn,String campus,String alpha,String num,String type,String from,String cc,String bcc,String msg,String dist)
 *	public static String removeBracketsFromList(String dist)
 *	public static int updateList(Connection connection,EmailList distribution)
 *
 */

//
// EmailListsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class EmailListsDB {

	static Logger logger = Logger.getLogger(EmailListsDB.class.getName());

	public EmailListsDB() throws Exception {}

	/**
	 * deleteList
	 */
	public static int deleteList(Connection connection, int lid) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblEmailList WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, lid);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: deleteList - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * insertList
	 */
	public static int insertList(Connection connection,EmailLists EmailList) {

		int rowsAffected = 0;
		try {
			String insertSQL = "INSERT INTO tblEmailList(title,campus,members,auditby) VALUES(?,?,?,?)";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, EmailList.getTitle());
			ps.setString(2, EmailList.getCampus());
			ps.setString(3, EmailList.getMembers());
			ps.setString(4, EmailList.getAuditBy());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: insertList - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateList
	 */
	public static int updateList(Connection connection,EmailLists EmailList) {
		int rowsAffected = 0;
		try {
			String insertSQL = "UPDATE tblEmailList SET title=?,members=?,auditby=? WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, EmailList.getTitle());
			ps.setString(2, EmailList.getMembers());
			ps.setString(3, EmailList.getAuditBy());
			ps.setInt(4, EmailList.getListID());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: updateList - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getEmailListMembers - list members by list id (index)
	 *	<p>
	 *	@param	connection	Connection
	 * @param	did			int
	 *	<p>
	 *	@return String
	 */
	public static String getEmailListMembers(Connection connection, int did) {

		String EmailListMembers = null;
		try {
			String sql = "SELECT members FROM tblEmailList WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,did);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				EmailListMembers = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailListMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return EmailListMembers;
	}

	/*
	 * getEmailListMembers - list members by list name
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	dist			String
	 *	<p>
	 *	@return String
	 */
	public static String getEmailListMembers(Connection connection,String user,String dist) {

		String EmailListMembers = "";

		try {
			String sql = "SELECT members "
				+ "FROM tblEmailList "
				+ "WHERE auditby=? AND title=?";

			String[] members = dist.split(",");

			PreparedStatement ps;
			ResultSet rs;

			for (int i=0;i<members.length;i++){
				dist = removeBracketsFromList(members[i]);
				ps = connection.prepareStatement(sql);
				ps.setString(1,user);
				ps.setString(2,dist);
				rs = ps.executeQuery();
				if (rs.next()) {
					if (!"".equals(EmailListMembers))
						EmailListMembers = EmailListMembers + "," + rs.getString(1);
					else
						EmailListMembers = rs.getString(1);
				}
				else{
					if (!"".equals(EmailListMembers))
						EmailListMembers = EmailListMembers + "," + dist;
					else
						EmailListMembers = dist;
				}

				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailListMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return EmailListMembers;
	}

	/*
	 * getEmailListMembers - list members by list name
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	user 			String
	 * @param	dist			String
	 *	<p>
	 *	@return String
	 */
	public static String getEmailListMembers(Connection connection,String campus,String user,String dist) {

		String EmailListMembers = "";

		try {
			String sql = "SELECT members "
				+ "FROM tblEmailList "
				+ "WHERE campus=? AND auditby=? AND title=?";

			String[] members = dist.split(",");

			PreparedStatement ps;
			ResultSet rs;

			for (int i=0;i<members.length;i++){
				dist = removeBracketsFromList(members[i]);
				ps = connection.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ps.setString(3,dist);
				rs = ps.executeQuery();
				if (rs.next()) {
					if (!"".equals(EmailListMembers))
						EmailListMembers = EmailListMembers + "," + rs.getString(1);
					else
						EmailListMembers = rs.getString(1);
				}
				else{
					if (!"".equals(EmailListMembers))
						EmailListMembers = EmailListMembers + "," + dist;
					else
						EmailListMembers = dist;
				}

				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailListMembers - "+ e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return EmailListMembers;
	}

	/*
	 * getEmailListName - the list name <p> @return String
	 */
	public static String getEmailListName(Connection connection, int did) {
		String EmailListName = null;
		try {
			String sql = "SELECT title FROM tblEmailList WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, did);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				EmailListName = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailListListName - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return EmailListName;
	}

	/*
	 * getEmailList - returns the entire record
	 *
	 *	<p>
	 * @param	connection	Connection
	 * @param	did			int
	 *	<p>
	 *	@return EmailLists
	 */
	public static EmailLists getEmailList(Connection connection, int did) {

		EmailLists EmailList = new EmailLists();
		try {
			String sql = "SELECT title,members,auditby,auditdate FROM tblEmailList WHERE seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, did);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				EmailList.setTitle(resultSet.getString(1));
				EmailList.setMembers(resultSet.getString(2));
				EmailList.setAuditBy(resultSet.getString(3));
				EmailList.setAuditDate(resultSet.getString(4));
			}
			resultSet.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailListListName - " + e.toString());
			EmailList = null;
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return EmailList;
	}

	/*
	 * getEmailLists - returns all EmailList names
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 *	@return 	String
	 */
	public static String getEmailLists(Connection conn,String campus) {

		String EmailLists = "";
		String temp = "";
		try {
			String sql = "SELECT title FROM tblEmailList WHERE campus=? ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				temp = AseUtil.nullToBlank(rs.getString(1));
				if (EmailLists.length() == 0)
					EmailLists = temp;
				else
					EmailLists = EmailLists + "," + temp;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("EmailListsDB: getEmailLists - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: getEmailLists - " + ex.toString());
		}

		return EmailLists;
	}

	/*
	 * hasMember - returns true/false whether the EmailList contains certain member
	 *	<p>
	 *	@param	connection	Connection
	 * @param	campus		String
	 * @param	dist			String
	 * @param	member		String
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
			String sql = "SELECT members FROM tblEmailList WHERE campus=? AND title=?";
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
			logger.fatal("EmailListsDB: hasMember - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("EmailListsDB: hasMember - " + ex.toString());
		}

		return found;
	}


	/*
	 * notifyEmailList
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
	public static boolean notifyEmailList(Connection conn,
															String campus,
															String alpha,
															String num,
															String type,
															String from,
															String cc,
															String bcc,
															String msg,
															String dist) {

		return  notifyEmailList(conn,campus,alpha,num,type,from,cc,bcc,msg,dist,"");
	}

	public static boolean notifyEmailList(Connection conn,
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

			// either a EmailList list name is sent or a list of names is sent
			if (!"".equals(dist))
				notified = aseUtil.lookUp(conn, "tblEmailList", "members", "campus='" + campus + "' AND title='" + dist + "'");
			else{
				notified = cc;
				cc = "";
			}

			if (!"".equals(notified)){
				String kix = Helper.getKix(conn,campus,alpha,num,type);
				MailerDB mailerDB = new MailerDB(conn,from,notified,cc,bcc,alpha,num,campus,msg,kix,user);
			}
		}
		catch(Exception ex){
			logger.fatal("CourseDB: notifyEmailList - " + ex.toString());
			return false;
		}

		return true;
	}

	/*
	 * isEmailListList
	 * <p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param dist		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isEmailListList(Connection conn,String campus,String dist) throws Exception {

		boolean list = false;

		try {

			dist = removeBracketsFromList(dist);

			String sql = "SELECT title "
					+ "FROM tblEmailList "
					+ "WHERE campus=? AND "
					+ "title=? ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, dist);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				list = true;

			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("EmailListsDB: isEmailListList - " + e.toString());
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
			logger.fatal("EmailListsDB: removeBracketsFromList - " + e.toString());
		}

		return dist;
	}

	/*
	 * removeBracketsFromList
	 * <p>
	 *	@param conn		Connection
	 *	@param user 	String
	 *	@param dist 	String
	 * <p>
	 * @return String
	 */
	public static int membersInEmailList(Connection conn,String user,String dist) throws Exception {

		String comma = ",";
		int members = 0;

		/*
			get the members of the EmailList then from there, count how many of them
			there are.
		*/
		try{
			String OutlineEmailListMembers = getEmailListMembers(conn,user,dist);

			if (!"".equals(OutlineEmailListMembers)){
				int len = OutlineEmailListMembers.length();

				if (len > 0) {
					int start = OutlineEmailListMembers.indexOf(comma);
					while (start != -1) {
						members++;
						start = OutlineEmailListMembers.indexOf(comma, start+1);
					}

					++members;
				}
			}
		}catch(Exception e){
			logger.fatal("EmailList - membersInEmailList - " + e.toString());
		}

		return members;
	}

	/*
	 * expandListNames - take a list of names (distribution and regular) and expand to show full.
	 *							ie: [MyList],THANHG,SHALLY = [MyList: name1,name2],THANHG,SHALLY
	 * <p>
	 *	@param conn			Connection
	 *	@param campus		String
	 *	@param user 		String
	 *	@param reviewers 	String
	 * <p>
	 * @return String
	 */
	public static String expandListNames(Connection conn,String campus,String user,String reviewers) throws Exception {

		String expandedListNames = ",";

		try{
			if (reviewers != null && reviewers.length() > 0){
				String[] aReviewers = reviewers.split(",");
				for(int i=0;i<aReviewers.length;i++){
					if (aReviewers[i] != null && aReviewers[i].length() > 0){
						if (aReviewers[i].indexOf("[") > -1){
							aReviewers[i] = "["
									+ aReviewers[i].replace("[","").replace("]","")
									+ " = "
									+ EmailListsDB.getEmailListMembers(conn,campus,user,aReviewers[i])
									+ "]";
						}

						if (i==0)
							expandedListNames = aReviewers[i];
						else
							expandedListNames = expandedListNames + ", " + aReviewers[i];
					}
				}
			}
		}catch(Exception e){
			logger.fatal("EmailList - expandListNames - " + e.toString());
		}

		return expandedListNames;
	}

	/**
	 * updateMembersList
	 */
	public static int updateMembersList(Connection conn,String campus,String title,String members) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "UPDATE tblEmailList SET members=? WHERE campus=? AND title=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,members);
			ps.setString(2,campus);
			ps.setString(3,title);
			rowsAffected = ps.executeUpdate();
		} catch (SQLException e) {
			logger.fatal("EmailListDB: updateMembersList - " + e.toString());
		} catch (Exception e) {
			logger.fatal("EmailListDB: updateMembersList - " + e.toString());
		}

		return rowsAffected;
	}

	public void close() throws SQLException {}

}