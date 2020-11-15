/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * public static int addRemoveExtra(Connection conn,String kix,String action,String src,String alpha,
 *														String num,String grading,String user,int reqID)
 *	public static int addRemoveExtraX(Connection conn,String kix,String action,String src,String alpha,
 *														String num,String grading,String user,int reqID)
 *	public static String getExtraAsHTMLList(Connection conn,String kix,String src)
 *	public static String getListBySRCTopicSubTopic(Connection conn,String campus,String alpha) throws SQLException {
 *	public static int getNextExtraNumber(Connection conn)
 *	public static int getNextRDR(Connection connection,String kix,String src) throws SQLException {
 *	public static String getOtherDepartments(Connection conn,
 *																		String src,
 *																		String campus,
 *																		String kix,
 *																		boolean enableDelete,
 *																		boolean showPending){
 *
 *
 * void close () throws SQLException{}
 *
 */

//
// ExtraDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class ExtraDB {
	static Logger logger = Logger.getLogger(ExtraDB.class.getName());

	public ExtraDB() throws Exception {}

	/*
	 * addRemoveExtra
	 *
	 * work on data from either pre or co-req depending on the type received
	 *
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	action	String
	 * @param	src		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	grading	String
	 * @param	user		String
	 * @param	int		reqID
	 * <p>
	 * @return int
	 */
	public static int addRemoveExtra(Connection conn,
														String kix,
														String action,
														String src,
														String alpha,
														String num,
														String grading,
														String user,
														int reqID) throws SQLException {

		int rowsAffected = 0;
		boolean added = true;

		// when adding, make sure it's not already in there
		if ("a".equals(action) && reqID <= 0){
			String sql = "SELECT coursealpha "
							+ " FROM tblExtra "
							+ " WHERE historyid=? AND src=? AND coursealpha=? AND coursenum=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setString(3,alpha);
			ps.setString(4,num);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				added = false;
				rowsAffected = -1;
			}
			rs.close();
			ps.close();
		}

		if (added){
			rowsAffected = addRemoveExtraX(conn,kix,action,src,alpha,num,grading,user,reqID);
		}

		return rowsAffected;
	}

	/*
	 * addRemoveExtraX
	 *
	 * work on data from either pre or co-req depending on the reqType received
	 *
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	action	String
	 * @param	src		String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	grading	String
	 * @param	user		String
	 * @param	int		reqID
	 * <p>
	 * @return int
	 */
	public static int addRemoveExtraX(Connection conn,
														String kix,
														String action,
														String src,
														String alpha,
														String num,
														String grading,
														String user,
														int reqID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int rtn = 0;

		String[] info = Helper.getKixInfo(conn,kix);
		String campus = info[4];

		String insertUpdateSQL = "";
		String removeSQL = "";

		// are we adding or updating
		if ("a".equals(action)){
			if (reqID > 0)
				insertUpdateSQL = "UPDATE tblExtra "
						+ " SET historyid=?,coursealpha=?,coursenum=?,grading=?,auditby=? "
						+ " WHERE id=?";
			else
				insertUpdateSQL = "INSERT INTO tblExtra "
						+ " (campus,historyid,coursealpha,coursenum,grading,auditby,id,src,rdr,pending,coursetype) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		}

		removeSQL = "DELETE FROM tblExtra WHERE historyid=? AND src=? AND id=?";

		boolean debug = false;
		boolean pending = false;
		boolean isProgram = false;

		String requiresApproval = "";
		String requiresApprovalKey = "";

		String notifyChair = "";
		String notifyChairKey = "";

		String emailApproval = "";
		String emailAdded = "";
		String divisionChairName = "";
		String proposer = "";

		String taskAlpha = "";
		String taskNum = "";
		String taskMessage = "";
		String logMessage = "";

		try {
			debug = DebugDB.getDebug(conn,"ExtraDB");

			if (debug) logger.info("------------------------- START");

			if (debug) logger.info("kix - " + kix);
			if (debug) logger.info("action - " + action);
			if (debug) logger.info("src - " + src);
			if (debug) logger.info("alpha - " + alpha);
			if (debug) logger.info("num - " + num);
			if (debug) logger.info("grading - " + grading);

			if ((Constant.COURSE_PROGRAM).equals(src)){
				requiresApprovalKey = "ProgramLinkedToOutlineRequiresApproval";
				notifyChairKey = "NotifyChairOnProgramToOutlineLink";
				emailApproval = "emailProgramApproval";
				emailAdded = "emailProgramAdded";
				isProgram = false;
				taskAlpha = alpha;
				taskNum = num;
				taskMessage = Constant.COURSE;
				logMessage = "Other department approval requested";
			}
			else if (
					(Constant.COURSE_OTHER_DEPARTMENTS).equals(src) ||
					(Constant.PROGRAM_RATIONALE).equals(src)
					){
				requiresApprovalKey = "OtherDepartmentsRequiresApproval";
				notifyChairKey = "NotifyChairOnOtherDepartments";
				emailApproval = "emailRequiredOrElectiveApproval";
				emailAdded = "emailRequiredElectiveAdded";
				isProgram = true;
				taskAlpha = grading;
				taskNum = "";
				taskMessage = Constant.PROGRAM;
				logMessage = "Other department approval requested";
			}

			if (debug) logger.info("requiresApprovalKey - " + requiresApprovalKey);
			if (debug) logger.info("notifyChairKey - " + notifyChairKey);
			if (debug) logger.info("emailApproval - " + emailApproval);
			if (debug) logger.info("emailAdded - " + emailAdded);

			requiresApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System",requiresApprovalKey);
			if (debug) logger.info("addRemoveExtraX - " + requiresApproval + ": " + requiresApprovalKey);

			notifyChair = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System",notifyChairKey);
			if (debug) logger.info("addRemoveExtraX - " + notifyChair + ": " + notifyChairKey);

			String sql = "";
			PreparedStatement ps;

			if ("a".equals(action)) {
				if ((Constant.ON).equals(requiresApproval))
					pending = true;

				sql = insertUpdateSQL;
				ps = conn.prepareStatement(sql);

				if (reqID > 0){
					ps.setString(1, kix);
					ps.setString(2, alpha);
					ps.setString(3, num);
					ps.setString(4, grading);
					ps.setString(5, user);
					ps.setInt(6, reqID);
				}
				else{
					ps.setString(1, campus);
					ps.setString(2, kix);
					ps.setString(3, alpha);
					ps.setString(4, num);
					ps.setString(5, grading);
					ps.setString(6, user);
					ps.setInt(7, getNextExtraNumber(conn));
					ps.setString(8, src);
					ps.setInt(9, getNextRDR(conn,kix,src));
					ps.setBoolean(10, pending);
					ps.setString(11,"PRE");
				}
			} else {
				sql = removeSQL;
				ps = conn.prepareStatement(sql);
				ps.setString(1, kix);
				ps.setString(2, src);
				ps.setInt(3, reqID);
			}

			rtn = ps.executeUpdate();
			ps.close();

			divisionChairName = ChairProgramsDB.getChairName(conn,campus,taskAlpha);

			if (isProgram)
				proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
			else
				proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,"PRE");

			if (debug) logger.info("addRemoveExtraX - proposer: " + proposer);

			// if enabled, notify division chair when added. this helps in the planning of sections to add
			if ((Constant.ADD).equals(action) && reqID <= 0) {

				if ((Constant.ON).equals(notifyChair)){

					if (!"".equals(divisionChairName)){

						MailerDB mailerDB = null;

						if (debug) logger.info("addRemoveExtraX - requiresApproval: " + requiresApproval);

						if ((Constant.ON).equals(requiresApproval)){

							// create approval task
							rowsAffected = TaskDB.logTask(conn,
																	divisionChairName,
																	proposer,
																	taskAlpha,
																	taskNum,
																	logMessage,
																	campus,
																	"",
																	"ADD",
																	"PRE",
																	"",
																	"",
																	kix,
																	taskMessage);
							if (debug) logger.info("addRemoveExtraX - added task for " + divisionChairName);

							mailerDB = new MailerDB(conn,
															proposer,
															divisionChairName,
															"",
															"",
															taskAlpha,
															taskNum,
															campus,
															emailApproval,
															kix,
															user);
							if (debug) logger.info("addRemoveExtraX - mail sent to " + divisionChairName);

						}
						else{
							mailerDB = new MailerDB(conn,
															user,
															divisionChairName,
															"",
															"",
															taskAlpha,
															taskNum,
															campus,
															emailAdded,
															kix,
															user);
						}	// if ((Constant.ON).equals(requiresApproval)){


						AseUtil.logAction(conn,
												user,
												"ACTION",
												"Request outline item approval ("+ taskAlpha + " " + taskNum + ")",
												taskAlpha,
												taskNum,
												campus,
												kix);

					} // if (!"".equals(divisionChairName)){

				} // if ((Constant.ON).equals(notifyChair)){

			} // if ("a".equals(action) && reqID <= 0)
			else if ((Constant.REMOVE).equals(action) && reqID <= 0) {
				rowsAffected = TaskDB.logTask(conn,
														divisionChairName,
														proposer,
														taskAlpha,
														taskNum,
														logMessage,
														campus,
														"",
														"REMOVE",
														"PRE",
														"",
														"",
														kix,
														taskMessage);

				AseUtil.logAction(conn,
										user,
										"ACTION",
										"Cancelled outline item approval ("+ taskAlpha + " " + taskNum + ")",
										taskAlpha,
										taskNum,
										campus,
										kix);
			}

			//AseUtil.loggerInfo("ExtraDB: addRemoveExtraX ",campus,user,alpha,num);

			if (debug) logger.info("------------------------- END");

		} catch (SQLException e) {
			logger.fatal("ExtraDB: addRemoveExtraX\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal("ExtraDB: addRemoveExtraX\n" + ex.toString());
		}

		return rtn;
	}

	/*
	 * getNextExtraNumber
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 *	@return int
	 */
	public static int getNextExtraNumber(Connection conn) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblExtra";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ExtraDB: getNextExtraNumber\n" + e.toString());
		}

		return id;
	}

	/*
	 * getExtraAsHTMLList - HTML table for display
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	src	String
	 *	<p>
	 * @return String
	 */
	public static String getExtraAsHTMLList(Connection conn,String kix,String src) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql;
		StringBuffer extra = new StringBuffer();
		boolean found = false;
		String temp = "";

		try {
			sql = "SELECT coursealpha,coursenum,grading "
				+ "FROM tblExtra WHERE historyid=? AND src=? ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				extra.append("<tr>"
					+ "<td class=\"datacolumn\" width=\"15%\">" + rs.getString("coursealpha")
					+ "&nbsp;"
					+ rs.getString("coursenum")
					+ "</td>"
					+ "<td class=\"datacolumn\">" + rs.getString("grading")
					+ "</td></tr>");

			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td>&nbsp;</td></tr>" +
					extra.toString() +
					"</table>";
			}

		} catch (Exception e) {
			logger.fatal("ExtraDB: getExtraAsHTMLList\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getExtraForEdit
	 *	<p>
	 *	@parm	conn	Connection
	 *	@parm	kix	String
	 *	@parm	src	String
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getExtraForEdit(Connection conn,String kix,String src) throws Exception {

		String sql = "";
		int id = 0;
		String alpha = "";
		String num = "";
		String grading = "";
		StringBuffer buf = new StringBuffer();

		int courseItem = 0;

		if ((Constant.COURSE_RECPREP).equals(src))
			courseItem = Constant.COURSE_ITEM_COURSE_RECPREP;
		else if ((Constant.COURSE_PROGRAM_SLO).equals(src))
			courseItem = Constant.COURSE_ITEM_PROGRAM_SLO;

		sql = "SELECT id,coursealpha,coursenum,grading "
			+ "FROM tblExtra WHERE historyid=? AND src=? ORDER BY rdr";

		try {
			AseUtil aseUtil = new AseUtil();
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\">"
				+ "<td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;"
				+ "&nbsp;<a href=\"crsrdr.jsp?src="+src+"&dst="+src+"&ci="+courseItem+"&kix="+kix+"\"><img src=\"../images/ed_list_num.gif\" border=\"0\" alt=\"reorder list\" title=\"reorder list\"></a>&nbsp;</td>"
				+ "<td width=\"10%\" valign=\"top\" class=\"textblackTH\">Alpha</td>"
				+ "<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Number</td>"
				+ "<td width=\"77%\" valign=\"top\" class=\"textblackTH\">Comment</td></tr>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				alpha = aseUtil.nullToBlank(rs.getString(2));
				num = aseUtil.nullToBlank(rs.getString(3));
				grading = aseUtil.nullToBlank(rs.getString(4));

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit entry\" alt=\"edit\" id=\"edit\" onclick=\"return aseSubmitClick3(\'" + id + "\',\'" + alpha + "\',\'" + num + "\',\'" + grading + "\'); \">&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete entry\" alt=\"delete\" id=\"delete\" onclick=\"return aseSubmitClick2(\'" + id + "\',\'" + alpha + "\',\'" + num + "\');\">" +
					"</td><td valign=\"top\" class=\"datacolumn\">" + alpha + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + num + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\">" + grading + "</td></tr>");
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ExtraDB: getExtraForEdit\n" + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("ExtraDB: getExtraForEdit\n" + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 * @param	src			String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection connection,String kix,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid "
				+ " FROM tblExtra "
				+ " WHERE historyid=? AND src=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("maxid");
			}

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ExtraDB: getNextRDR\n" + e.toString());
		}

		return id;
	}

	/**
	 * getOtherDepartments
	 * <p>
	 * @param	conn
	 * @param	src
	 * @param	campus
	 * @param	kix
	 * @param	enableDelete
	 * @param	showPending
	 * <p>
	 * @return	String
	 */
	public static String getOtherDepartments(Connection conn,
															String src,
															String campus,
															String kix,
															boolean enableDelete,
															boolean showPending){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String descr = "";
		String rowColor = "";

		String deleteColumn = "";
		String aHrefStart = "";
		String aHrefEnd = "";
		String link = "";

		boolean pending = false;
		String sPending = "";

		boolean found = false;
		boolean debug   = false;

		int j = 0;
		int id = 0;

		try{
			debug = DebugDB.getDebug(conn,"ExtraDB");

			if (debug) logger.info("-------------------------> START");
			if (debug) logger.info("src: " + src);
			if (debug) logger.info("kix: " + kix);
			if (debug) logger.info("enableDelete: " + enableDelete);
			if (debug) logger.info("showPending: " + showPending);

			String otherDepartmentsRequiresApproval =
				IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OtherDepartmentsRequiresApproval");

			if (debug) logger.info("otherDepartmentsRequiresApproval: " + otherDepartmentsRequiresApproval);

			if (enableDelete){
				deleteColumn = ",e.id ";
				aHrefStart = "<a href=\"crsX29idx.jsp?lid=_LINK_\" class=\"linkcolumn\">";
				aHrefEnd = "</a>";
			}

			String sql = "SELECT e.grading, e.pending, b.ALPHA_DESCRIPTION  " + deleteColumn +
					" FROM tblExtra e LEFT OUTER JOIN " +
					" BannerAlpha b ON e.grading = b.COURSE_ALPHA " +
					" WHERE e.campus=? " +
					" AND e.historyid=? " +
					" AND src=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				link = "";

				alpha = AseUtil.nullToBlank(rs.getString("grading"));
				descr = AseUtil.nullToBlank(rs.getString("ALPHA_DESCRIPTION"));
				pending = rs.getBoolean("pending");

				if (enableDelete){
					id = rs.getInt("id");
					link = aHrefStart.replace("_LINK_",id + "&ack=r&kix=" + kix + "&src=" + src);
				}

				if (pending)
					sPending = "YES";
				else
					sPending = "NO";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\">" + link + alpha + aHrefEnd + "</td>");
				listings.append("<td class=\"datacolumn\">" + descr + "</td>");

				if (showPending && (Constant.ON).equals(otherDepartmentsRequiresApproval))
					listings.append("<td class=\"datacolumn\">" + sPending + "</td>");

				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\" width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">" +
					"<tr height=\"30\" bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">" +
					"<td class=\"textblackTH\">Alpha</td>" +
					"<td class=\"textblackTH\">Description</td>";

				if (showPending && (Constant.ON).equals(otherDepartmentsRequiresApproval))
					listing += "<td valign=\"top\" class=\"textblackTH\">Pending<br/>Approval</td>";

				listing += "</tr>" +
								listings.toString() +
								"</table>";
			}
			else{
				listing = "";
			}

			if (debug) logger.info("-------------------------> END");
		}
		catch( SQLException e ){
			logger.fatal("ExtraDB: getOtherDepartments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ExtraDB: getOtherDepartments - " + ex.toString());
		}

		return listing;
	}

	/*
	 * getListBySRCTopicSubTopic
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	alpha
	 *	<p>
	 */
	public static String getListBySRCTopicSubTopic(Connection conn,String campus,String alpha) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String plo = "";
		boolean found = false;

		try {
			String sql = "SELECT shortdescr "
				+ "FROM tblValues  "
				+ "WHERE campus=? AND "
				+ "topic LIKE 'PLO - %' "
				+ "AND subtopic IN "
				+ "( "
				+ "SELECT tblDivision.divisioncode "
				+ "FROM tblChairs INNER JOIN "
				+ "tblDivision ON tblChairs.programid = tblDivision.divid "
				+ "WHERE tblChairs.coursealpha=? "
				+ "AND tblDivision.campus=? "
				+ ")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				plo += "<li>" + AseUtil.nullToBlank(rs.getString("shortdescr")) + "</li>";
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				plo = "<ul>" + plo + "</ul>";

		} catch (SQLException e) {
			logger.fatal("ExtraDB: getListBySRCTopicSubTopic - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ExtraDB: getListBySRCTopicSubTopic - " + e.toString());
		}

		return plo;
	}

	public void close() throws SQLException {}

}