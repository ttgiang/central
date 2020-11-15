/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * public static int addRemoveRequisites
 *	public static int addRemoveRequisitesX
 *	public static int getNextRequisiteNumber
 *	public static String getRequisites
 *	public static int getRequisiteCount
 *	public static String getRequisitesForEdit
 *	public static String listRequisitesToApprove(Connection conn,String kix,String user) throws Exception {
 *	public static int requisitesRequiringApproval(Connection conn,String kix,int requisite) throws Exception {
 *
 * void close () throws SQLException{}
 *
 */

//
// RequisiteDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class RequisiteDB {
	static Logger logger = Logger.getLogger(RequisiteDB.class.getName());

	public RequisiteDB() throws Exception {}

	/*
	 * addRemoveRequisites
	 *
	 * work on data from either pre or co-req depending on the type received
	 *
	 * <p> @return int
	 */
	public static int addRemoveRequisites(Connection connection,
													String kix,
													String action,
													String campus,
													String alpha, String num,
													String alphax, String numx,
													String grading,
													String reqType,
													String user,
													int reqID,
													boolean consent) throws SQLException {

		int rowsAffected = 0;

		String fields = "";
		String fields2 = "";
		String fields3 = "";
		String table = "";
		boolean added = true;

		String[] info = Helper.getKixInfo(connection,kix);
		String type = info[2];

		// which table is being worked on. pre or co reqs
		if (reqType.equals("1")) {
			fields = "PrereqAlpha,PrereqNum";
			fields2 = "PrereqAlpha=? AND PrereqNum=?";
			fields3 = "PrereqAlpha=?,PrereqNum=?,grading=?,auditby=?";
			table = "tblPreReq";
		} else if (reqType.equals("2")) {
			fields = "CoreqAlpha,CoreqNum";
			fields2 = "CoreqAlpha=? AND CoreqNum=?";
			fields3 = "CoreqAlpha=?,CoreqNum=?,grading=?,auditby=?";
			table = "tblCoReq";
		}

		// when adding, make sure it's not already in there
		if ("a".equals(action) && reqID <= 0){
			String sql = "SELECT " + fields +
								" FROM " + table +
								" WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND " + fields2;
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, alphax);
			ps.setString(6, numx);
			ResultSet results = ps.executeQuery();
			if (results.next()){
				added = false;
				rowsAffected = -1;
			}
			ps.close();
		}

		if (added){
			rowsAffected = addRemoveRequisitesX(connection,
															kix,
															action,
															campus,
															alpha,
															num,
															alphax,
															numx,
															grading,
															reqType,
															user,
															reqID,
															consent);
		}

		return rowsAffected;
	}

	/*
	 * addRemoveRequisitesX
	 *
	 * work on data from either pre or co-req depending on the reqType received
	 *	<p>
	 *	@param	 connection	Connection
	 *	@param	 kix			String
	 *	@param	 action		String
	 *	@param	 campus		String
	 *	@param	 alpha		String
	 *	@param	 num			String
	 *	@param	 alphax		String
	 *	@param	 numx			String
	 *	@param	 grading		String
	 *	@param	 reqType		String
	 *	@param	 user			String
	 *	@param	 reqID		int
	 * @param	 consent		boolean
	 * <p> @return int
	 */
	public static int addRemoveRequisitesX(Connection connection,
														String kix,
														String action,
														String campus,
														String alpha,
														String num,
														String alphax,
														String numx,
														String grading,
														String reqType,
														String user,
														int reqID,
														boolean consent) throws SQLException {

		boolean debug = false;

		int rowsAffected = 0;

		String insertUpdateSQL = "";
		String removeSQL = "";
		String fields = "";
		String fields2 = "";
		String fields3 = "";
		String table = "";

		String[] info = Helper.getKixInfo(connection,kix);
		String type = info[2];

		boolean pending = false;

		String requisiteRequiresApproval = "";

		try {
			debug = DebugDB.getDebug(connection,"RequisiteDB");

			// which tabld is being worked on. pre or co reqs
			if (reqType.equals("1")) {
				fields = "historyid,PrereqAlpha,PrereqNum";
				fields2 = "PrereqAlpha=? AND PrereqNum=?";
				fields3 = "historyid=?,PrereqAlpha=?,PrereqNum=?,grading=?,auditby=?,consent=?";
				table = "tblPreReq";

				requisiteRequiresApproval =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","PreReqRequiresApproval");

			} else if (reqType.equals("2")) {
				fields = "historyid,CoreqAlpha,CoreqNum";
				fields2 = "CoreqAlpha=? AND CoreqNum=?";
				fields3 = "historyid=?,CoreqAlpha=?,CoreqNum=?,grading=?,auditby=?,consent=?";
				table = "tblCoReq";

				requisiteRequiresApproval =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CoReqRequiresApproval");
			}

			if (debug) logger.info("addRemoveRequisitesX - requisiteRequiresApproval: " + requisiteRequiresApproval);

			// are we adding or updating
			if (action.equals("a")){
				if (reqID > 0)
					insertUpdateSQL = "UPDATE " + table
							+ " SET " + fields3
							+ " WHERE id=?";
				else
					insertUpdateSQL = "INSERT INTO " + table
							+ " (coursealpha,coursenum,campus,coursetype," + fields
							+ ",grading,auditby,consent,id,pending) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			}

			removeSQL = "DELETE FROM "
					+ table
					+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND "
					+ fields2;

			String sql = "";
			PreparedStatement ps;

			if (action.equals("a")) {
				sql = insertUpdateSQL;
				ps = connection.prepareStatement(sql);

				if (reqID > 0){
					ps.setString(1, kix);
					ps.setString(2, alphax);
					ps.setString(3, numx);
					ps.setString(4, grading);
					ps.setString(5, user);
					ps.setBoolean(6, consent);
					ps.setInt(7, reqID);
				}
				else{
					if ((Constant.ON).equals(requisiteRequiresApproval))
						pending = true;

					ps.setString(1, alpha);
					ps.setString(2, num);
					ps.setString(3, campus);
					ps.setString(4, type);
					ps.setString(5, kix);
					ps.setString(6, alphax);
					ps.setString(7, numx);
					ps.setString(8, grading);
					ps.setString(9, user);
					ps.setBoolean(10, consent);
					ps.setInt(11, getNextRequisiteNumber(connection,reqType));
					ps.setBoolean(12, pending);
				}
			} else {
				sql = removeSQL;
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
				ps.setString(5, alphax);
				ps.setString(6, numx);
			}
			rowsAffected = ps.executeUpdate();
			ps.close();

			String divisionChairName = ChairProgramsDB.getChairName(connection,campus,alphax);
			String proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,"PRE");

			// if enabled, notify division chair when added. this helps in the planning of sections to add
			if (action.equals(Constant.ADD) && reqID <= 0 && !type.equals(Constant.CUR)) {

				String properties = "";

				String NotifyDivisionChairOnPrereqAdd =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","NotifyDivisionChairOnPrereqAdd");

				String NotifyDivisionChairOnCoreqAdd =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","NotifyDivisionChairOnCoreqAdd");

				if (debug) logger.info("addRemoveRequisitesX - NotifyDivisionChairOnPrereqAdd: " + NotifyDivisionChairOnPrereqAdd);
				if (debug) logger.info("addRemoveRequisitesX - NotifyDivisionChairOnCoreqAdd: " + NotifyDivisionChairOnCoreqAdd);

				if (NotifyDivisionChairOnPrereqAdd.equals(Constant.ON) || NotifyDivisionChairOnCoreqAdd.equals(Constant.ON)){

					/*
						division chair message differs. If it's only a message about the use of pre/coreq,
						go to else. If it requires approval, go to if
					*/

					if (!divisionChairName.equals(Constant.BLANK)){

						MailerDB mailerDB = null;

						if (requisiteRequiresApproval.equals(Constant.ON)){

							if (debug) logger.info("addRemoveRequisitesX - proposer: " + proposer);

							// create approval task
							rowsAffected = TaskDB.logTask(connection,
																	divisionChairName,
																	proposer,
																	alpha,
																	num,
																	Constant.APPROVE_REQUISITE_TEXT,
																	campus,
																	Constant.BLANK,
																	"ADD",
																	"PRE");
							if (debug) logger.info("addRemoveRequisitesX - added task for " + divisionChairName);

							mailerDB = new MailerDB(connection,
															proposer,
															divisionChairName,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailRequisiteApproval",
															kix,
															user);
							if (debug) logger.info("addRemoveRequisitesX - mail sent to " + divisionChairName);

						}
						else{
							if (reqType.equals(Constant.ON))
								properties = "emailPrereqAdded";
							else if (reqType.equals("2"))
								properties = "emailCoreqAdded";

							mailerDB = new MailerDB(connection,
															user,
															divisionChairName,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															properties,
															kix,
															user);
						}	// if ((Constant.ON).equals(requisiteRequiresApproval)){

						AseUtil.logAction(connection,
												user,
												"ACTION",
												"Request requisite approval ("+ alphax + " " + numx + ")",alpha,num,campus,kix);

					}	// divisionChair
					else{
						logger.info("Chair name not found for requisite approval - ("+ alpha + " " + num + ")");
					}
				}	// pre/co requisite ON

			}	// action = a
			else if ((Constant.REMOVE).equals(action) && reqID <= 0) {
				rowsAffected = TaskDB.logTask(connection,
														divisionChairName,
														proposer,
														alpha,
														num,
														Constant.APPROVE_REQUISITE_TEXT,
														campus,
														Constant.BLANK,
														"REMOVE",
														"PRE");

				AseUtil.logAction(connection,
										user,
										"ACTION",
										"Cancelled requisite approval ("+ alphax + " " + numx + ")",alpha,num,campus,kix);
			}

			//AseUtil.loggerInfo("RequisiteDB: addRemoveRequisitesX ",campus,user,alpha,num);

		} catch (SQLException e) {
			logger.fatal("RequisiteDB: addRemoveRequisitesX - "
								+ alpha + " - "
								+ num + " - "
								+ alphax + " - "
								+ numx + " - "
								+ e.toString());
		} catch (Exception ex) {
			logger.fatal("RequisiteDB: addRemoveRequisitesX - "
								+ alpha + " - "
								+ num + " - "
								+ alphax + " - "
								+ numx + " - "
								+ ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getNextRequisiteNumber
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	reqType	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRequisiteNumber(Connection conn,String reqType) throws SQLException {

		int id = 0;
		String table = Constant.BLANK;

		if ("1".equals(reqType))
			table = "tblPreReq";
		else
			table = "tblCoReq";

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM " + table;
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("RequisiteDB: getNextRequisiteNumber - " + e.toString());
		}

		return id;
	}

	/*
	 * getRequisitesForEdit
	 *	<p>
	 *	@parm	currentTab	tab to return to edit
	 *	@parm	currentNo	number or item to return to
	 *	@parm	showImages	whether or not we show the edit/delete images
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getRequisitesForEdit(Connection conn,
															String campus,
															String alpha,
															String num,
															String type,
															String table) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = Constant.BLANK;
		int id = 0;
		String prereqalpha = Constant.BLANK;
		String prereqnum = Constant.BLANK;
		String grading = Constant.BLANK;

		boolean consent = false;
		String sConsent = Constant.BLANK;

		boolean pending = false;
		String sPending = Constant.BLANK;

		StringBuffer buf = new StringBuffer();

		String displayOrConsentForPreReqs =
			IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");

		String requisiteRequiresApproval = Constant.BLANK;

		if (table.equals(Constant.ON)){
			sql = "SELECT id,prereqalpha,prereqnum,grading,consent,pending, historyid " +
					"FROM tblPrereq " +
					"WHERE campus=? AND Coursealpha=? AND Coursenum=? AND coursetype=? " +
					"ORDER BY prereqalpha,prereqnum";

			 requisiteRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","PreReqRequiresApproval");
		}
		else if (table.equals("2")){
			sql = "SELECT id,coreqalpha,coreqnum,grading,consent,pending, historyid " +
					"FROM tblCoreq " +
					"WHERE campus=? AND Coursealpha=? AND Coursenum=? AND coursetype=? " +
					"ORDER BY coreqalpha,coreqnum";

			requisiteRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CoReqRequiresApproval");
		}

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table id=\"tableGetRequisitesForEdit\" border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\">Alpha</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Number</td>" +
				"<td width=\"61%\" valign=\"top\" class=\"textblackTH\">Comment</td>");

			if (displayOrConsentForPreReqs.equals(Constant.ON)){
				buf.append("<td width=\"15%\" valign=\"top\" class=\"textblackTH\">or Consent</td>");
			}

			if (requisiteRequiresApproval.equals(Constant.ON)){
				buf.append("<td width=\"15%\" valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>");
			}

			buf.append("</tr>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				prereqalpha = aseUtil.nullToBlank(rs.getString(2));
				prereqnum = aseUtil.nullToBlank(rs.getString(3));
				grading = aseUtil.nullToBlank(rs.getString(4));
				consent = rs.getBoolean("consent");
				pending = rs.getBoolean("pending");
				String historyid = aseUtil.nullToBlank(rs.getString("historyid"));

				if (consent)
					sConsent = "YES";
				else
					sConsent = "NO";

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<a href=\"crsreq.jsp?e=1&kix="+historyid+"&a="+prereqalpha+"&n="+prereqnum+"&i="+id+"\" alt=\"edit entry\"><img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\"></a>&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + prereqalpha + "\',\'" + prereqnum + "\');\">" +
					"</td><td valign=\"top\" class=\"datacolumn\">" + prereqalpha + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + prereqnum + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + grading + "</td>");

				if ((Constant.ON).equals(displayOrConsentForPreReqs))
					buf.append("<td valign=\"top\" class=\"datacolumn\">" + sConsent + "</td>");

				if ((Constant.ON).equals(requisiteRequiresApproval))
					buf.append("<td valign=\"top\" class=\"datacolumn\">" + sPending + "</td>");

				buf.append("</tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("RequisiteDB: getRequisitesForEdit - " + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("RequisiteDB: getRequisitesForEdit - " + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	} // RequisiteDB: getRequisitesForEdit

	public static String getRequisitesForEditOBSOLETE(Connection connection,
															String campus,
															String alpha,
															String num,
															String type,
															String table) throws Exception {

		String sql = Constant.BLANK;
		int id = 0;
		String prereqalpha = Constant.BLANK;
		String prereqnum = Constant.BLANK;
		String grading = Constant.BLANK;

		boolean consent = false;
		String sConsent = Constant.BLANK;

		boolean pending = false;
		String sPending = Constant.BLANK;

		StringBuffer buf = new StringBuffer();

		String displayOrConsentForPreReqs =
			IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","DisplayOrConsentForPreReqs");

		String requisiteRequiresApproval = Constant.BLANK;

		if (table.equals(Constant.ON)){
			sql = "SELECT id,prereqalpha,prereqnum,grading,consent,pending " +
					"FROM tblPrereq " +
					"WHERE campus=? AND Coursealpha=? AND Coursenum=? AND coursetype=? " +
					"ORDER BY prereqalpha,prereqnum";

			 requisiteRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","PreReqRequiresApproval");
		}
		else if (table.equals("2")){
			sql = "SELECT id,coreqalpha,coreqnum,grading,consent,pending " +
					"FROM tblCoreq " +
					"WHERE campus=? AND Coursealpha=? AND Coursenum=? AND coursetype=? " +
					"ORDER BY coreqalpha,coreqnum";

			requisiteRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CoReqRequiresApproval");
		}

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table id=\"tableGetRequisitesForEdit\" border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\">Alpha</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Number</td>" +
				"<td width=\"61%\" valign=\"top\" class=\"textblackTH\">Comment</td>");

			if (displayOrConsentForPreReqs.equals(Constant.ON)){
				buf.append("<td width=\"15%\" valign=\"top\" class=\"textblackTH\">or Consent</td>");
			}

			if (requisiteRequiresApproval.equals(Constant.ON)){
				buf.append("<td width=\"15%\" valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>");
			}

			buf.append("</tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				prereqalpha = aseUtil.nullToBlank(rs.getString(2));
				prereqnum = aseUtil.nullToBlank(rs.getString(3));
				grading = aseUtil.nullToBlank(rs.getString(4));
				consent = rs.getBoolean("consent");
				pending = rs.getBoolean("pending");

				if (consent)
					sConsent = "YES";
				else
					sConsent = "NO";

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\" onclick=\"return aseSubmitClick3(\'" + id + "\',\'" + prereqalpha + "\',\'" + prereqnum + "\',\'" + grading + "\'," + consent + "); \">&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + prereqalpha + "\',\'" + prereqnum + "\');\">" +
					"</td><td valign=\"top\" class=\"datacolumn\">" + prereqalpha + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + prereqnum + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + grading + "</td>");

				if ((Constant.ON).equals(displayOrConsentForPreReqs))
					buf.append("<td valign=\"top\" class=\"datacolumn\">" + sConsent + "</td>");

				if ((Constant.ON).equals(requisiteRequiresApproval))
					buf.append("<td valign=\"top\" class=\"datacolumn\">" + sPending + "</td>");

				buf.append("</tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("RequisiteDB: getRequisitesForEdit - " + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("RequisiteDB: getRequisitesForEdit - " + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/*
	 * getRequisites
	 *	<p>
	 *	@param	 connection	Connection
	 *	@param	 campus		String
	 *	@param	 alpha		String
	 *	@param	 num			String
	 *	@param	 type			String
	 *	@param	 tableToUse	int
	 *	@param	 hid			String
	 *	<p>
	 *	@return String
	 */
	public static String getRequisites(Connection connection,
													String campus,
													String alpha,
													String num,
													String type,
													int tableToUse,
													String hid) throws SQLException {

		StringBuilder requisites = new StringBuilder();
		String fields = Constant.BLANK;
		String table = Constant.BLANK;
		String temp = Constant.BLANK;
		String sql = Constant.BLANK;
		boolean found = false;

		PreparedStatement ps;

		String displayOrConsentForPreReqs =
			IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","DisplayOrConsentForPreReqs");

		boolean consent = false;
		boolean pending = false;

		String requisiteRequiresApproval = Constant.BLANK;

		try {
			if (tableToUse == Constant.REQUISITES_PREREQ) {
				fields = "PrereqAlpha,PrereqNum";
				table = "tblPreReq";

				 requisiteRequiresApproval =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","PreReqRequiresApproval");

			} else if (tableToUse == Constant.REQUISITES_COREQ) {
				fields = "CoreqAlpha,CoreqNum";
				table = "tblCoReq";

				 requisiteRequiresApproval =
					IniDB.getIniByCampusCategoryKidKey1(connection,campus,"System","CoReqRequiresApproval");
			}

			AseUtil aseUtil = new AseUtil();

			if (type.equals("ARC")) {
				sql = "SELECT " + fields + ",grading,consent,pending FROM " + table + " WHERE historyid=? ORDER BY " + fields;
				ps = connection.prepareStatement(sql);
				ps.setString(1, hid);
			} else {
				sql = "SELECT "
						+ fields
						+ ",grading,consent,pending FROM "
						+ table
						+ " WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=? ORDER BY " + fields;
				ps = connection.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ps.setString(4, type);
			}

			ResultSet results = ps.executeQuery();
			while (results.next()) {
				found = true;
				alpha = aseUtil.nullToBlank(results.getString(1));
				num = aseUtil.nullToBlank(results.getString(2));
				consent = results.getBoolean("consent");
				temp = aseUtil.nullToBlank(results.getString("grading"));
				pending = results.getBoolean("pending");

				if (Constant.BLANK.equals(temp)){
					temp = " ";
				}
				else				{
					temp = " (" + temp + ")";
				}

				if (displayOrConsentForPreReqs.equals(Constant.ON) && consent){
					temp += "; OR consent";
				}

				if (requisiteRequiresApproval.equals(Constant.ON) && pending){
					temp += " (PENDING APPROVAL)";
				}

				requisites.append("<tr><td valign=\"top\" width=\"15%\" class=\"datacolumn\">" + alpha + " " + num + "</td>"
						+ "<td class=\"datacolumn\">" + CourseDB.getCourseDescription(connection, alpha, num, campus)
						+ temp
						+ "</td></tr>");
			}

			results.close();
			ps.close();

			if (found)
				temp = "<br/>" + "<table id=\"tableGetRequisites\" border=\"0\" width=\"100%\">" + requisites.toString() + "</table>";
			else
				temp = Constant.BLANK;

		} catch (SQLException e) {
			logger.fatal("RequisiteDB: getRequisites - e: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("RequisiteDB: getRequisites - ex: " + ex.toString());
		}

		return temp;
	}

	/*
	 * Count requisites for an alpha and number
	 * <p>
	 *	@param	 connection	Connection
	 *	@param	 campus		String
	 *	@param	 alpha		String
	 *	@param	 num			String
	 * <p>
	 * @return int
	 */
	public static int getRequisiteCount(Connection conn,
														String campus,
														String alpha,
														String num) throws Exception {

		int count = 0;

		try {

			AseUtil aseUtil = new AseUtil();

			String where = "WHERE " +
					"campus=" + aseUtil.toSQL(campus, 1) + " AND " +
					"prereqalpha=" + aseUtil.toSQL(alpha, 1) + " AND " +
					"prereqnum=" + aseUtil.toSQL(num, 1);

			count = (int) AseUtil.countRecords(conn,"tblPrereq",where);

		} catch (Exception e) {
			logger.fatal("RequisiteDB: getRequisiteCount - " + e.toString());
		}

		return count;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn
	 * @param	reqType
	 * @param	kix
	 * @param	reqAlpha
	 * @param	reqNum
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isMatch(Connection conn,
											int reqType,
											String campus,
											String alpha,
											String num,
											String type,
											String reqAlpha,
											String reqNum) throws SQLException {

		int id = 0;
		String table = Constant.BLANK;
		String field1 = Constant.BLANK;
		String field2 = Constant.BLANK;

		if (Constant.REQUISITES_PREREQ == reqType){
			table = "tblPreReq";
			field1 = "PrereqAlpha";
			field2 = "PrereqNum";
		}
		else{
			table = "tblCoReq";
			field1 = "CoreqAlpha";
			field2 = "CoreqNum";
		}

		String sql = "SELECT id FROM "
						+ table
						+ " WHERE campus=? "
						+ "AND coursealpha=? "
						+ "AND coursenum=? "
						+ "AND coursetype=? "
						+ "AND " + field1 + "=? "
						+ "AND " + field2 + "=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		ps.setString(5,reqAlpha);
		ps.setString(6,reqNum);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * listRequisitesToApprove
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	user	String
	 * <p>
	 * @return String
	 */
	/*
	 * listRequisitesToApprove
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	user	String
	 * <p>
	 * @return String
	 */
	public static String listRequisitesToApprove(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//NOTE: see AseUtil.drawHTMLFieldX for explanation of hidden fields

		int rowsAffected = 0;

		String listing = Constant.BLANK;
		StringBuffer listings = new StringBuffer();
		StringBuffer buf = new StringBuffer();
		String title = Constant.BLANK;
		String rowColor = Constant.BLANK;
		int j = 0;
		boolean found = false;

		String campus = Constant.BLANK;

		String taskAlpha = Constant.BLANK;
		String taskNum = Constant.BLANK;

		String alpha = Constant.BLANK;
		String num = Constant.BLANK;
		String degreeTitle = Constant.BLANK;
		String proposer = Constant.BLANK;

		String type = Constant.BLANK;
		String sql = Constant.BLANK;

		String requisite = Constant.BLANK;
		String fieldName = Constant.BLANK;
		String controlName = Constant.BLANK;
		String hiddenFields = Constant.BLANK;

		int totalRequestedApprovals = 0;

		int typesOfApprovals = 4;

		final int PREREQS		= 0;
		final int COREQS		= 1;
		final int XLIST		= 2;
		final int PROGRAMS	= 3;

		boolean debug = false;

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			if (info != null){
				taskAlpha = info[Constant.KIX_ALPHA];
				taskNum = info[Constant.KIX_NUM];
				campus = info[Constant.KIX_CAMPUS];

				if (debug) logger.info("RequisiteDB - listRequisitesToApprove");

				if (debug) {
					logger.info("kix: " + kix);
					logger.info("campus: " + campus);
					logger.info("taskAlpha: " + taskAlpha);
					logger.info("taskNum: " + taskNum);
				}

				// for loop to take care of pre and co reqs; pre first then co
				for(int req=0; req<typesOfApprovals; req++){

					found = false;

					if (req==PREREQS){
						sql = "SELECT tp.historyid, tp.PrereqAlpha AS [Alpha], tp.PrereqNum AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblPreReq tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.PrereqAlpha = tc.CourseAlpha "
							+ "AND tp.PrereqNum = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.PrereqAlpha, tp.PrereqNum";

						requisite = "Pre-Requisites";
						fieldName = "preReq";
					}
					else if (req==COREQS){
						sql = "SELECT tp.historyid, tp.coreqAlpha AS [Alpha], tp.coreqNum AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblCoReq tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.coreqAlpha = tc.CourseAlpha "
							+ "AND tp.coreqNum = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.coreqAlpha, tp.coreqNum";

						requisite = "Co-Requisites";
						fieldName = "coReq";
					}
					else if (req==XLIST){
						sql = "SELECT tp.historyid, tp.coursealphaX AS [Alpha], tp.coursenumX AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblXRef tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.coursealphaX = tc.CourseAlpha "
							+ "AND tp.coursenumX = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.coursealphaX, tp.coursenumX";

						requisite = "Cross Listing";
						fieldName = "xref";
					}
					else if (req==PROGRAMS){
						sql = "SELECT tp.historyid, tp.Grading AS [Alpha], vw.divisionname AS [num], vw.degreeTitle, vw.title AS title, vw.proposer "
							+ "FROM tblExtra tp LEFT OUTER JOIN "
							+ "vw_ProgramForViewing vw ON tp.Campus = vw.campus "
							+ "AND tp.Grading = vw.historyid "
							+ "WHERE tp.Campus=? "
							+ "AND tp.historyid=? "
							+ "AND tp.pending=1 "
							+ "ORDER BY vw.divisionname, vw.degreeTitle, vw.title ";

						requisite = "Programs";
						fieldName = "program";
					}

					j = 0;

					PreparedStatement ps = conn.prepareStatement(sql);
					if (req != PROGRAMS){
						ps.setString(1,campus);
						ps.setString(2,taskAlpha);
						ps.setString(3,taskNum);
					}
					else{
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
					ResultSet rs = ps.executeQuery();
					while ( rs.next() ){
						kix = AseUtil.nullToBlank(rs.getString("historyid"));
						alpha = AseUtil.nullToBlank(rs.getString("alpha"));
						num = AseUtil.nullToBlank(rs.getString("num"));
						title = AseUtil.nullToBlank(rs.getString("title"));
						proposer = AseUtil.nullToBlank(rs.getString("proposer"));

						if (req == PROGRAMS){
							degreeTitle = AseUtil.nullToBlank(rs.getString("degreeTitle"));

							if (j==0)
								hiddenFields = alpha + Constant.SEPARATOR + alpha;
							else
								hiddenFields = hiddenFields + "," + alpha + Constant.SEPARATOR + alpha;

							controlName = fieldName+"_"+alpha+"_"+alpha;

						}
						else{
							if (j==0)
								hiddenFields = alpha + Constant.SEPARATOR + num;
							else
								hiddenFields = hiddenFields + "," + alpha + Constant.SEPARATOR + num;

							controlName = fieldName+"_"+alpha+"_"+num;
						}

						if (j++ % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
						listings.append(
							"<td class=\"datacolumn\"><input type=\"radio\" name=\""+controlName+"\" value=\"1\"></td>"
							+ "<td class=\"datacolumn\"><input type=\"radio\" name=\""+controlName+"\" value=\"0\"></td>"
						);

						listings.append("<td class=\"datacolumn\">" + proposer + "</td>");

						if (req == PROGRAMS){
							listings.append("<td colspan=\"2\" class=\"datacolumn\">" + num + "</td>");
						}
						else{

							String htmlName = com.ase.aseutil.io.Util.getHtmlNameIfExists(conn,campus,Constant.COURSE,kix,taskAlpha,taskNum);

							if(htmlName.equals(Constant.BLANK)){
								listings.append("<td class=\"datacolumn\">" + taskAlpha + " " + taskNum + "</td>");
							}
							else{
								listings.append("<td class=\"datacolumn\"><a href=\""+htmlName+"\" class=\"linkcolumn\" target=\"_blank\">" + taskAlpha + " " + taskNum + "</a></td>");
							}

							// get the kix of the course needing approval
							// start with CUR and if not there, get PRE
							String approvalKix = Helper.getKix(conn,campus,alpha,num,"CUR");
							if(approvalKix.equals(Constant.BLANK)){
								approvalKix = Helper.getKix(conn,campus,alpha,num,"PRE");
							}

							// create the HTML outline for easy and fast access
							if(!com.ase.aseutil.io.Util.doesHtmlExist(conn,campus,Constant.COURSE,approvalKix)){
								Tables.createOutlines(campus,approvalKix,alpha,num);
							}

							htmlName = com.ase.aseutil.io.Util.getHtmlName(conn,campus,Constant.COURSE,approvalKix);

							if(htmlName.equals(Constant.BLANK)){
								listings.append("<td class=\"datacolumn\">" + alpha + " " + num + "</td>");
							}
							else{
								listings.append("<td class=\"datacolumn\"><a href=\""+htmlName+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a></td>");
							}

						}

						listings.append("<td class=\"datacolumn\">" + title + "</td>"
								+ "</tr>");

						found = true;

						++totalRequestedApprovals;
					}
					rs.close();
					ps.close();

					if (found){
						buf.append("<h3 class=\"subheader\"><b>"+requisite+"</b></h3><table id=\"tableListRequisitesToApprove\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"20\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"10%\">Approve</td>" +
							"<td class=\"textblackth\" width=\"10%\">Disapprove</td>"+
							"<td class=\"textblackth\" width=\"15%\">Proposer</td>");

						if (req == PROGRAMS){
							buf.append("<td colspan=\"2\" class=\"textblackth\" width=\"30%\">Department/Division</td>");
						}
						else{
							buf.append("<td class=\"textblackth\" width=\"15%\">Requesting<br/>Outline</td>"
								+ "<td class=\"textblackth\" width=\"15%\">"+requisite+"<br/>Outline</td>");
						}

						buf.append("<td class=\"textblackth\" width=\"35%\">Title</td>"
							+ "<input type=\"hidden\" name=\""+fieldName+"\" value=\""+hiddenFields+"\">"
							+ "</tr>"
							+ listings.toString()
							+ "</table>");

						listings.setLength(0);
					}
				} // for

				listing = buf.toString();

				/*
					if there are no requests for approval, it's likely we got here due to bad task
				*/
				if (debug) logger.info("totalRequestedApprovals: " + totalRequestedApprovals);

				if (totalRequestedApprovals == 0){
					int preReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_PREREQ);
					int coReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_COREQ);
					if (preReqs + coReqs == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_REQUISITE_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.COURSE);
						if (debug) logger.info("Requisites approval request task removed for " + user);
					}

					int xref = XRefDB.crossListingRequiringApproval(conn,kix);
					if (xref == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_CROSS_LISTING_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.COURSE);
						if (debug) logger.info("Cross listing approval request task removed for " + user);
					}

					int programs = ProgramsDB.programsRequiringApproval(conn,kix);
					if (programs == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_PROGRAM_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.PROGRAM);
						if (debug) logger.info("Program approval request task removed for " + user);
					}
				} // if (totalRequestedApprovals == 0){

			} // info != null
		}
		catch( SQLException e){
			logger.fatal("RequisiteDB: listRequisitesToApprove - " + e.toString());
		}
		catch( Exception e){
			logger.fatal("RequisiteDB: listRequisitesToApprove - " + e.toString());
		}

		return listing;
	}

	public static String listRequisitesToApproveOBSOLETE(Connection conn,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		//NOTE: see AseUtil.drawHTMLFieldX for explanation of hidden fields

		int rowsAffected = 0;

		String listing = Constant.BLANK;
		StringBuffer listings = new StringBuffer();
		StringBuffer buf = new StringBuffer();
		String title = Constant.BLANK;
		String rowColor = Constant.BLANK;
		int j = 0;
		boolean found = false;

		String campus = Constant.BLANK;

		String taskAlpha = Constant.BLANK;
		String taskNum = Constant.BLANK;

		String alpha = Constant.BLANK;
		String num = Constant.BLANK;
		String degreeTitle = Constant.BLANK;
		String proposer = Constant.BLANK;

		String type = Constant.BLANK;
		String sql = Constant.BLANK;

		String requisite = Constant.BLANK;
		String fieldName = Constant.BLANK;
		String controlName = Constant.BLANK;
		String hiddenFields = Constant.BLANK;

		int totalRequestedApprovals = 0;

		int typesOfApprovals = 4;

		final int PREREQS		= 0;
		final int COREQS		= 1;
		final int XLIST		= 2;
		final int PROGRAMS	= 3;

		boolean debug = false;

		try{
			String[] info = Helper.getKixInfo(conn,kix);
			if (info != null){
				taskAlpha = info[Constant.KIX_ALPHA];
				taskNum = info[Constant.KIX_NUM];
				campus = info[Constant.KIX_CAMPUS];

				if (debug) logger.info("RequisiteDB - listRequisitesToApprove");

				if (debug) {
					logger.info("kix: " + kix);
					logger.info("campus: " + campus);
					logger.info("taskAlpha: " + taskAlpha);
					logger.info("taskNum: " + taskNum);
				}

				// for loop to take care of pre and co reqs; pre first then co
				for(int req=0; req<typesOfApprovals; req++){

					found = false;

					if (req==PREREQS){
						sql = "SELECT tp.historyid, tp.PrereqAlpha AS [Alpha], tp.PrereqNum AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblPreReq tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.PrereqAlpha = tc.CourseAlpha "
							+ "AND tp.PrereqNum = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.PrereqAlpha, tp.PrereqNum";

						requisite = "Pre-Requisites";
						fieldName = "preReq";
					}
					else if (req==COREQS){
						sql = "SELECT tp.historyid, tp.coreqAlpha AS [Alpha], tp.coreqNum AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblCoReq tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.coreqAlpha = tc.CourseAlpha "
							+ "AND tp.coreqNum = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.coreqAlpha, tp.coreqNum";

						requisite = "Co-Requisites";
						fieldName = "coReq";
					}
					else if (req==XLIST){
						sql = "SELECT tp.historyid, tp.coursealphaX AS [Alpha], tp.coursenumX AS [num], tc.coursetitle AS [title], tc.proposer "
							+ "FROM tblXRef tp LEFT OUTER JOIN "
							+ "tblCourse tc ON tp.coursealphaX = tc.CourseAlpha "
							+ "AND tp.coursenumX = tc.CourseNum "
							+ "AND tp.Campus = tc.campus "
							+ "WHERE tp.Campus=? "
							+ "AND tp.coursealpha=? "
							+ "AND tp.coursenum=? "
							+ "AND tp.coursetype='PRE' "
							+ "AND tp.pending=1 "
							+ "ORDER BY tp.coursealphaX, tp.coursenumX";

						requisite = "Cross Listing";
						fieldName = "xref";
					}
					else if (req==PROGRAMS){
						sql = "SELECT tp.historyid, tp.Grading AS [Alpha], vw.divisionname AS [num], vw.degreeTitle, vw.title AS title, vw.proposer "
							+ "FROM tblExtra tp LEFT OUTER JOIN "
							+ "vw_ProgramForViewing vw ON tp.Campus = vw.campus "
							+ "AND tp.Grading = vw.historyid "
							+ "WHERE tp.Campus=? "
							+ "AND tp.historyid=? "
							+ "AND tp.pending=1 "
							+ "ORDER BY vw.divisionname, vw.degreeTitle, vw.title ";

						requisite = "Programs";
						fieldName = "program";
					}

					j = 0;

					PreparedStatement ps = conn.prepareStatement(sql);
					if (req != PROGRAMS){
						ps.setString(1,campus);
						ps.setString(2,taskAlpha);
						ps.setString(3,taskNum);
					}
					else{
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
					ResultSet rs = ps.executeQuery();
					while ( rs.next() ){
						kix = AseUtil.nullToBlank(rs.getString("historyid"));
						alpha = AseUtil.nullToBlank(rs.getString("alpha"));
						num = AseUtil.nullToBlank(rs.getString("num"));
						title = AseUtil.nullToBlank(rs.getString("title"));
						proposer = AseUtil.nullToBlank(rs.getString("proposer"));

						if (req == PROGRAMS){
							degreeTitle = AseUtil.nullToBlank(rs.getString("degreeTitle"));

							if (j==0)
								hiddenFields = alpha + Constant.SEPARATOR + alpha;
							else
								hiddenFields = hiddenFields + "," + alpha + Constant.SEPARATOR + alpha;

							controlName = fieldName+"_"+alpha+"_"+alpha;

						}
						else{
							if (j==0)
								hiddenFields = alpha + Constant.SEPARATOR + num;
							else
								hiddenFields = hiddenFields + "," + alpha + Constant.SEPARATOR + num;

							controlName = fieldName+"_"+alpha+"_"+num;
						}

						if (j++ % 2 == 0){
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						}
						else{
							rowColor = Constant.ODD_ROW_BGCOLOR;
						}

						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
						listings.append(
							"<td class=\"datacolumn\"><input type=\"radio\" name=\""+controlName+"\" value=\"1\"></td>"
							+ "<td class=\"datacolumn\"><input type=\"radio\" name=\""+controlName+"\" value=\"0\"></td>"
						);

						if (req == PROGRAMS){
							listings.append("<td class=\"datacolumn\">" + num + "</td>");
						}
						else{

							// get the kix of the course needing approval
							// start with CUR and if not there, get PRE
							String xRefKix = Helper.getKix(conn,campus,alpha,num,"CUR");
							if(xRefKix.equals(Constant.BLANK)){
								xRefKix = Helper.getKix(conn,campus,alpha,num,"PRE");
							}

							// create the HTML outline for easy and fast access
							if(!com.ase.aseutil.io.Util.doesHtmlExist(conn,campus,Constant.COURSE,xRefKix)){
								Tables.createOutlines(campus,xRefKix,alpha,num);
							}

							String htmlName = com.ase.aseutil.io.Util.getHtmlName(conn,campus,Constant.COURSE,xRefKix);
							if(htmlName.equals(Constant.BLANK)){
								listings.append("<td class=\"datacolumn\">" + alpha + " " + num + "</td>");
							}
							else{
								listings.append("<td class=\"datacolumn\"><a href=\""+htmlName+"\" class=\"linkcolumn\" target=\"_blank\">" + alpha + " " + num + "</a></td>");
							}
						}

						listings.append("<td class=\"datacolumn\">" + proposer + "</td>"
								+ "<td class=\"datacolumn\">" + title + "</td>"
								+ "</tr>");

						found = true;

						++totalRequestedApprovals;
					}
					rs.close();
					ps.close();

					if (found){
						buf.append("<h3 class=\"subheader\"><b>"+requisite+"</b></h3><table id=\"tableListRequisitesToApprove\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"20\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"10%\">Approve</td>" +
							"<td class=\"textblackth\" width=\"10%\">Disapprove</td>");

						if (req == PROGRAMS){
							buf.append("<td class=\"textblackth\" width=\"20%\">Department/Division</td>");
						}
						else{
							buf.append("<td class=\"textblackth\" width=\"20%\">Outline</td>");
						}

						buf.append("<td class=\"textblackth\" width=\"20%\">Proposer</td>"
							+ "<td class=\"textblackth\" width=\"40%\">Title</td>"
							+ "<input type=\"hidden\" name=\""+fieldName+"\" value=\""+hiddenFields+"\">"
							+ "</tr>"
							+ listings.toString()
							+ "</table>");

						listings.setLength(0);
					}
				} // for

				listing = buf.toString();

				/*
					if there are no requests for approval, it's likely we got here due to bad task
				*/
				if (debug) logger.info("totalRequestedApprovals: " + totalRequestedApprovals);

				if (totalRequestedApprovals == 0){
					int preReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_PREREQ);
					int coReqs = RequisiteDB.requisitesRequiringApproval(conn,kix,Constant.REQUISITES_COREQ);
					if (preReqs + coReqs == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_REQUISITE_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.COURSE);
						if (debug) logger.info("Requisites approval request task removed for " + user);
					}

					int xref = XRefDB.crossListingRequiringApproval(conn,kix);
					if (xref == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_CROSS_LISTING_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.COURSE);
						if (debug) logger.info("Cross listing approval request task removed for " + user);
					}

					int programs = ProgramsDB.programsRequiringApproval(conn,kix);
					if (programs == 0){
						rowsAffected = TaskDB.logTask(conn,
																user,
																user,
																taskAlpha,
																taskNum,
																Constant.APPROVE_PROGRAM_TEXT,
																campus,
																"",
																"REMOVE",
																"PRE",
																"",
																"",
																kix,
																Constant.PROGRAM);
						if (debug) logger.info("Program approval request task removed for " + user);
					}
				} // if (totalRequestedApprovals == 0){

			} // info != null
		}
		catch( SQLException e){
			logger.fatal("RequisiteDB: listRequisitesToApprove - " + e.toString());
		}
		catch( Exception e){
			logger.fatal("RequisiteDB: listRequisitesToApprove - " + e.toString());
		}

		return listing;
	}

	/*
	 * requisitesRequiringApproval
	 *	<p>
	 * @param	conn			Connection
	 * @param	kix			String
	 *	@param	requisite	int
	 *	<p>
	 * @return	int
	 */
	public static int requisitesRequiringApproval(Connection conn,String kix,int requisite) throws Exception {

		int count = 0;
		String table = "";

		try{
			if (requisite == Constant.REQUISITES_PREREQ)
				table = "tblPreReq";
			else
				table = "tblCoReq";

			String sql = "SELECT COUNT(pending) AS counter "
					+ "FROM " + table + " "
					+ "WHERE historyid=? "
					+ "and coursetype='PRE' "
					+ "AND pending=1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				count = rs.getInt("counter");
			}
			rs.close();
			ps.close();

		}catch(Exception e){
			logger.fatal("RequisiteDB - requisitesRequiringApproval: " + e.toString());
		}

		return count;
	}

	/*
	 * isPendingApproval - returns true if course is pending approval
	 *	<p>
	 *	@param	conn
	 * @param	reqType
	 * @param	campus
	 * @param	alpha
	 * @param	num
	 * @param	type
	 *	<p>
	 *	@return	boolean
	 */
	public static boolean isPendingApproval(Connection conn,
														int reqType,
														String campus,
														String alpha,
														String num,
														String type) throws SQLException {

		String table = Constant.BLANK;

		if (Constant.REQUISITES_PREREQ == reqType){
			table = "tblPreReq";
		}
		else{
			table = "tblCoReq";
		}

		String sql = "SELECT id FROM "
						+ table
						+ " WHERE campus=? "
						+ "AND coursealpha=? "
						+ "AND coursenum=? "
						+ "AND coursetype=? "
						+ "AND pending=1 ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * listOutlineRequisites - list courses using alpha num as requisites
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	requisite	String
	 * <p>
	 * @return String
	 */
	public static String listOutlineRequisites(Connection conn,String campus,String alpha,String num,String requisite) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String link = "";
		String sql = "";
		String rowColor = "";

		boolean found = false;

		StringBuffer sb = new StringBuffer();

		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			if (requisite.equals(Constant.IMPORT_PREREQ)){
				sql = "SELECT DISTINCT CourseAlpha, CourseNum, substring(Grading,1,2000) as Grading FROM tblPreReq "
					+ "WHERE campus=? AND coursetype=? AND prereqalpha=? AND prereqnum=? "
					+ "ORDER BY CourseAlpha, CourseNum";
			}
			else{
				sql = "SELECT DISTINCT CourseAlpha, CourseNum, substring(Grading,1,2000) as Grading FROM tblCoReq "
					+ "WHERE campus=? AND coursetype=? AND coreqalpha=? AND coreqnum=? "
					+ "ORDER BY CourseAlpha, CourseNum";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"CUR");
			ps.setString(3,alpha);
			ps.setString(4,num);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String courseAlpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
				String courseNum = AseUtil.nullToBlank(rs.getString("CourseNum"));
				String outline = courseAlpha + " " + courseNum;
				String grading = AseUtil.nullToBlank(rs.getString("Grading"));

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				link = "vwcrsx.jsp?cps="+campus+"&alpha="+courseAlpha+"&num="+courseNum+"&t=CUR";
				sb.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
					+ "<td class=\"linkcolumn\" width=\"20%\"><a href=\"" + link + "\" class=\"linkcolumn\">" + outline + "</a></td>"
					+ "<td class=\"datacolumn\" width=\"80%\">" + grading + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table id=\"asePager\" width=\"60%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr height=\"30\" bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
					+ "<td class=\"textblackth\" width=\"20%\">Course Outline</td>"
					+ "<td class=\"textblackth\" width=\"80%\">Grading</td>"
					+ "</tr>"
					+ sb.toString()
					+ "</table>";
			} // found

		}
		catch(SQLException e){
			logger.fatal("RequisiteDB - listOutlineRequisites: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("RequisiteDB - listOutlineRequisites: " + e.toString());
		}

		return temp;
	}

	/*
	 * getEditData - editing only grading and consent
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	id				int
	 * @param	requisite	String
	 * <p>
	 * @return String[]
	 */
	public static String[] getEditData(Connection conn,String campus,String kix,String alpha,String num,int id,String requisite) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String[] rtn = null;

		try{
			String sql = "";
			if (requisite.equals(Constant.IMPORT_PREREQ)){
				sql = "SELECT grading,consent "
					+ "FROM tblPreReq "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND prereqalpha=? "
					+ "AND prereqnum=? "
					+ "AND id=?";
			}
			else{
				sql = "SELECT grading,consent "
					+ "FROM tblCoReq "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND coreqalpha=? "
					+ "AND coreqnum=? "
					+ "AND id=?";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setInt(5,id);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				rtn = new String[2];
				rtn[0] = AseUtil.nullToBlank(rs.getString("grading"));
				rtn[1] = AseUtil.nullToBlank(rs.getString("consent"));
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("RequisiteDB - getEditData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("RequisiteDB - getEditData: " + e.toString());
		}

		return rtn;
	}

	/*
	 */
	public void close() throws SQLException {}

}