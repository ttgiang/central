/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 *	public static Msg addRemoveCourseComp(Connection connection,String action,String campus,String alpha,
 *											String num,String comp,int compID,String user,String kix)
 *	public static void deleteObjectives(Connection conn,String campus, String kix)
 *	public static String getComp(Connection,String,String,String,String)
 *	public static ArrayList getCompByID(Connection,String,String id,Constant.COURSE_OBJECTIVES)
 *	public static ArrayList getCompsByKix(Connection connection,String kix)
 *	public static ArrayList getComps(Connection,String,String,String)
 *	public static ArrayList getCompsByAlphaNum(Connection,String,String,String,String)
 *	public static ArrayList getCompsByAlphaNumID(Connection,String,String,String,String)
 *	public static ArrayList getCompsByTypeCampusID(Connection,String,String id)
 *	public static ArrayList getCompsByID(Connection,String,String id)
 *	public static String getCompsAsHTMLList(Connection,String,String,String,String,String,boolean)
 *	public static StringBuffer getCompsAsHTMLOptions(Connection,String,String,String,String)
 *	public static String getCompsAsHTMLOptionsByKix(Connection,String)
 *	public static String getCompsByType(Connection,String,String,String,String,String,String,String,boolean,String)
 *	public static ArrayList getCompsByTypeX(Connection,String,String,String,String)
 *	public static String getCompsToReview(Connection,String,String,String,String,String,String,String,boolean)
 *	public static int getNextCompID(Connection connection,String campus,String alpha,String num)
 *	public static String getObjective(Connection connection,String kix,int compID)
 *	public static String getObjectives(Connection connection,String kix)
 *	public static boolean hasSLOsToReview(Connection, kix);
 *	public static boolean isCompAdded(Connection connection,String campus,String alpha,String num,String comp)
 *	public static int setCompApproval(Connection,String,String,String,String,String,String,String,int)
 *	public static int updateObjective(Connection conn,String kix,String objective)
 *
 * void close () throws SQLException{}
 *
 */

//
// CompDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class CompDB {
	static Logger logger = Logger.getLogger(CompDB.class.getName());

	public CompDB() throws Exception {}

	/*
	 * getComps
	 *	<p>
	 *	@return String
	 */
	public static String getComp(Connection connection,String alpha,String num,String compid,String campus) throws Exception {

		String table = "tblCourseComp";
		String comp = null;
		String getSQL = "SELECT comp "
			+ "FROM " + table + " "
			+ "WHERE campus=? AND courseAlpha=? AND courseNum=? AND compid=?";

		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, compid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				comp = resultSet.getString(1);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getComp - " + e.toString());
			comp = null;
		}

		return comp;
	}

	/*
	 * getCompByID
	 *	<p>
	 *	@param	Connection	connection
	 * @param	int			compid
	 * @param	String		sloType
	 *	<p>
	 *	@return Comp
	 */
	public static Comp getCompByID(Connection connection,int compid,String sloType) throws Exception {

		Comp comp = new Comp();
		String table = "tblCourseComp";

		try {
			if (sloType.equals(Constant.COURSE_OBJECTIVES))
				table = "tblCourseComp";
			else if (sloType.equals(Constant.COURSE_COMPETENCIES))
				table = "tblCourseComp";

			String sql = "SELECT * FROM " + table + " WHERE compid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,compid);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				AseUtil aseUtil = new AseUtil();
				comp.setCampus(aseUtil.nullToBlank(resultSet.getString("campus")).trim());
				comp.setAlpha(aseUtil.nullToBlank(resultSet.getString("CourseAlpha")).trim());
				comp.setNum(aseUtil.nullToBlank(resultSet.getString("Coursenum")).trim());
				comp.setComp(aseUtil.nullToBlank(resultSet.getString("comp")).trim());
				comp.setComments(aseUtil.nullToBlank(resultSet.getString("comments")).trim());
				comp.setApprovedBy(aseUtil.nullToBlank(resultSet.getString("ApprovedBy")).trim());
				comp.setApprovedDate(aseUtil.nullToBlank(resultSet.getString("approveddate")).trim());
				comp.setAuditDate(aseUtil.nullToBlank(resultSet.getString("AuditDate")).trim());
				comp.setAuditBy(aseUtil.nullToBlank(resultSet.getString("AuditBy")).trim());
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompByID - " + e.toString());
			comp = null;
		}

		return comp;
	}

	/*
	 * getComps
	 *	<p>
	 * @return ArrayList
	 */
	public static ArrayList getComps(Connection connection,String alpha,String num,String campus) throws Exception {

		String table = "tblCourseComp";
		String getSQL = "SELECT compid, comp "
			+ "FROM " + table + " "
			+ "WHERE campus=? AND courseAlpha=? AND courseNum=?";
		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setID(resultSet.getString(1));
				comp.setComp(resultSet.getString(2));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getComps - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsByKix
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		kix
	 *	<p>
	 * @return ArrayList
	 */
	public static ArrayList getCompsByKix(Connection connection,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "SELECT compid, comp FROM tblCourseComp WHERE historyid=? ORDER BY rdr";
		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setID(resultSet.getString(1));
				comp.setComp(resultSet.getString(2));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByKix - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsAsHTMLOptions
	 *	<p>
	 * @return StringBuffer
	 */
	public static StringBuffer getCompsAsHTMLOptions(Connection connection,String alpha,String num,String campus,String type) throws Exception {

		String table = "tblCourseComp";
		String getSQL = "SELECT compid, comp FROM " + table + " "
			+ "WHERE campus=? AND courseAlpha=? AND courseNum=? and coursetype=?";
		StringBuffer buf = new StringBuffer();

		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				buf.append("<option value=\"" + resultSet.getInt(1) + "\">" + resultSet.getString(2).trim() + "</option>");
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsAsHTMLOptions - " + e.toString());
			buf = null;
		}

		return buf;
	}

	/*
	 * getCompsAsHTMLOptionsByKix
	 *	<p>
	 * @return String
	 */
	public static String getCompsAsHTMLOptionsByKix(Connection connection,String kix) throws Exception {

		String getSQL = "SELECT compid, comp FROM tblCourseComp WHERE historyid=?";
		StringBuffer buf = new StringBuffer();
		String temp = "";

		boolean found = false;

		try {
			PreparedStatement ps = connection.prepareStatement(getSQL);
			ps.setString(1, kix);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				buf.append("<tr><td valign=\"top\"><input type=\"radio\" name=\"compGroup\" value=\"" + resultSet.getInt(1) + "\"></td>" +
					"<td>&nbsp;&nbsp;</td>" +
					"<td valign=\"top\">" + resultSet.getString(2).trim() + "<br/><br/></td></tr>");
				found = true;
			}
			resultSet.close();
			ps.close();

			temp = buf.toString();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsAsHTMLOptionsByKix - " + e.toString());
			buf = null;
		}

		if (found)
			temp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + temp + "</table>";

		return temp;
	}

	/*
	 * getCompsToReview
	 *	<p>
	 *	@parm	connection	Connection
	 *	@parm	alpha			String
	 *	@parm	num			String
	 *	@parm	campus		String
	 *	@parm	type			String
	 *	@parm	user			String
	 *	@parm	currentTab	String
	 *	@parm	currentNo	String
	 *	@parm	showImages	boolean
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getCompsToReview(Connection conn,
														String alpha,
														String num,
														String campus,
														String type,
														String user,
														String currentTab,
														String currentNo,
														boolean showImages) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String reviewed = "";
		String revieweddate = "";
		String comments = "";
		int counter = 0;
		String comp = "";
		String kix = "";
		String temp = "";
		boolean firstRow = true;
		int compID;
		String image = "";
		String allRadios = "";
		AseUtil aseUtil = new AseUtil();

		try {
			kix = Helper.getKix(conn,campus,alpha,num,type);

			// does this person have approval access?
			boolean isReviewer = DistributionDB.hasMember(conn,campus,"SLOReviewer",user);
			boolean isReviewing = SLODB.sloProgress(conn,campus,alpha,num,"PRE","REVIEW");

			buf.append("<form name=\"aseApprovalForm\" method=\"post\" action=\"crscmpy.jsp\">");
			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>" +
				"<td width=\"77%\" valign=\"top\" class=\"textblackTH\">SLO</td>" +
				"<td width=\"10%\" valign=\"top\" class=\"textblackTH\" nowrap>Reviewed</td>" +
				"<td width=\"10%\" valign=\"top\" align=\"right\" class=\"textblackTH\" nowrap>Date</td></tr>");

			//
			// SLO reviewers sees Y/N for approval and not delete image.
			//
			// Proposer cannot see Y/N but allowed to delete.
			//
			// Once approved, delete not allowed.
			//
			String getSQL = "SELECT compid,comp,reviewed,reviewedby,revieweddate,comments FROM tblCourseComp WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(getSQL);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				compID = rs.getInt(1);
				comp = (++counter) + ". " + rs.getString("comp");
				if (AssessDB.hasAssessment(conn,campus,alpha,num,type,compID))
					image = "reviews";
				else
					image = "reviews_off";

				reviewed = aseUtil.nullToBlank(rs.getString("reviewed"));
				comments = aseUtil.nullToBlank(rs.getString("comments"));
				revieweddate = aseUtil.ASE_FormatDateTime(rs.getString("revieweddate"),Constant.DATE_DATETIME);

				if (reviewed.equals("Y")){
					buf.append("<tr>");

					if (showImages)
						buf.append("<td align=\"left\" valign=\"top\" nowrap><a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/" + image + ".gif\" border=\"0\" alt=\"add assessment\" id=\"assessment\"></a></td>");
					else
						buf.append("<td align=\"left\" valign=\"top\" nowrap>&nbsp;</td>");

					buf.append("<td valign=\"top\" class=\"datacolumn\">" + comp + "</td>" +
						"<td valign=\"top\" class=\"datacolumn\">" + aseUtil.nullToBlank(rs.getString("reviewedby")) + "</td>" +
						"<td valign=\"top\" align=\"right\" class=\"datacolumn\" nowrap>" + revieweddate + "</td></tr>");

					buf.append("<tr><td>&nbsp;</td><td align=\"left\" valign=\"top\" colspan=\"3\">" +
						"<font class=\"textblackTH\">Reviewer comments:</font><br><font class=\"datacolumn\">" + comments + "</font></td></tr>");
				}
				else{
					if (allRadios.equals(""))
						allRadios = String.valueOf(compID);
					else
						allRadios = allRadios + "," + String.valueOf(compID);

					buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>");

					if (showImages){
						buf.append("<a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/" + image + ".gif\" border=\"0\" alt=\"assessment\" id=\"assessment\"></a>&nbsp;");

						if (!isReviewer && !isReviewing)
							buf.append("<a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + compID + "\"><img src=\"../images/del.gif\" border=\"0\" alt=\"delete\" id=\"delete\" onclick=\"aseSubmitClick2("+compID+"); return false;\"></a>");
					}
					else
						buf.append("&nbsp;");

					buf.append("</td><td valign=\"top\" class=\"datacolumn\">"
								+ comp
								+ "</td>"
								+ "<td valign=\"top\" class=\"datacolumn\" nowrap>");

					if (isReviewer){
						/*
							drawHTMLField includes numberOfControls as a hidden field to indicate the number of controls
							drawn when called. unfortunately, it draws the same control name for every call causing
							repeated field names.

							we need to clean that up here to avoid having identical names.
						*/
						temp = aseUtil.drawHTMLField(conn,"radio","YN","radio_"+compID,reviewed,0,0,false,campus,false);

						if (firstRow){
							temp = temp.replace("value='1'","value='HOLDFORNOW'");
							firstRow = false;
						}
						else{
							temp = temp.replace("value='1' name='numberOfControls'","value='v_" + compID + "' name='numberOfControls_" + compID + "'");
						}

						buf.append(temp);
					}

					buf.append("</td>" +
						"<td valign=\"top\" align=\"right\" class=\"datacolumn\" nowrap>" + revieweddate + "</td></tr>");

					if (isReviewer)
						buf.append("<tr><td>&nbsp;</td><td align=\"left\" valign=\"top\" colspan=\"3\">" +
							"<font class=\"textblackTH\">Reviewer comments:</font><br><textarea cols=\'80\' class=\'input\' name=\'slo" + compID + "\' rows=\'4\'></textarea>" +
							"</td></tr>");
				}
			}

			buf.append("<tr><td align=\"right\" valign=\"top\" colspan=\"4\">");
			buf.append("<input type=\'hidden\' name=\'allRadios\' value=\'" + allRadios + "\'>");
			buf.append("<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>");

			// when there are no selections, hide save button
			if (isReviewer && !allRadios.equals("")){
				buf.append("<input title=\"save review\" type=\'submit\' name=\'aseSubmit\' value=\'Save\' class=\'input\' onClick=\"return checkForm(\'a\');\">&nbsp;&nbsp;");
			}

			// when there are no selections, notify the proposer that we are done
			if (allRadios.equals("")){
				buf.append("<input title=\"notify proposer of completed review\" type=\'submit\' name=\'aseReturnToProposer\' value=\'Return to Proposer\' class=\'input\' onClick=\"returnToProposer();\">&nbsp;&nbsp;");
			}

			buf.append("<input title=\"end requested operation\" type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'input\' onClick=\"return cancelForm('"+alpha+"','"+num+"','"+currentTab+"','"+currentNo+"')\">" );

			buf.append("&nbsp;&nbsp;</td></tr>");
			buf.append("</table>");
			buf.append("</form>");

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getCompsToReview - " + e.toString());
			temp = null;
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsToReview - " + e.toString());
			temp = null;
		}

		// if all reviews have been completed, then we shouldn't have any radio buttons. If that's the case
		// we should consider removing the user's task in case one exists
		if (temp != null){
			if (allRadios.equals("")){
				TaskDB.logTask(conn,user,user,alpha,num,"Review SLO",campus,"","REMOVE",type);
			}

			// set the the correct number of controls
			temp = buf.toString().replace("HOLDFORNOW",""+counter);
		} // temp is not null

		return temp;
	} // CompDB: getCompsToReview

	/*
	 * getCompsByType
	 *	<p>
	 *	@parm	Connection	conn
	 *	@parm	String		alpha
	 *	@parm	String		num
	 *	@parm	String		campus
	 *	@parm	String		type
	 *	@parm	String		user
	 *	@parm	String		currentTab	tab to return to edit
	 *	@parm	String		currentNo	number or item to return to
	 *	@parm	boolean		showImages	whether or not we show the edit/delete images
	 *	@parm	String		edit			should edit/delete be allowed
	 *	@parm	String		sloType
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getCompsByType(Connection connection,
												String alpha,
												String num,
												String campus,
												String type,
												String user,
												String currentTab,
												String currentNo,
												boolean showComments,
												String edit,
												String sloType) throws Exception {

		String table = "tblCourseComp";
		StringBuffer buf = new StringBuffer();
		String approved = "";
		String reviewed = "";
		String comments = "";
		String approvalDate = "";
		String reviewedDate = "";
		String kix = "";
		String sql = "";

		String image1 = "reviews";
		String image2 = "reviews2";
		String image3 = "reviews3";

		try {
			int compID;
			AseUtil aseUtil = new AseUtil();

			kix = Helper.getKix(connection,campus,alpha,num,type);

			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
				+ "&nbsp;<a href=\"crsrdr.jsp?s=c&ci="+Constant.COURSE_ITEM_SLO+"&kix="+kix+"&\"><img src=\"../images/ed_list_num.gif\" border=\"0\" alt=\"reorder list\" title=\"reorder list\"></a>&nbsp;</td>"
				+ "<td width=\"60%\" valign=\"top\" class=\"textblackTH\">SLO</td>"
				+ "<td width=\"15%\" valign=\"top\" class=\"textblackTH\" nowrap>Reviewed</td>"
				+ "<td width=\"20%\" valign=\"top\" class=\"textblackTH\" nowrap>Approved</td></tr>");

			sql = "SELECT compid,comp,comments,reviewed,reviewedby,revieweddate,approved,approvedby,approveddate " +
				"FROM " + table + " " +
				"WHERE historyid=? " +
				"ORDER BY rdr";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				compID = rs.getInt(1);
				approved = aseUtil.nullToBlank(rs.getString("approved"));
				approvalDate = aseUtil.ASE_FormatDateTime(rs.getString("approveddate"),Constant.DATE_DATETIME);

				reviewed = aseUtil.nullToBlank(rs.getString("reviewed"));
				reviewedDate = aseUtil.ASE_FormatDateTime(rs.getString("revieweddate"),Constant.DATE_DATETIME);

				if (approved.equals("Y") || reviewed.equals("Y") || edit.equals("off")){
					buf.append("<tr>"+
						"<td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
						"<a href=\"crsasslnk.jsp?kix=" + kix + "&comp=" + compID + "\"><img src=\"../images/" + image1 + ".gif\" border=\"0\" title=\"link assessment\" alt=\"link assessment\" id=\"assessment\"></a>" +
						"</td>" +
						"<td width=\"75%\" valign=\"top\" class=\"datacolumn\">" + rs.getString("comp") + "</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"datacolumn\" nowrap>" + aseUtil.nullToBlank(rs.getString("reviewedby")) + "<br/>" + reviewedDate + "</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"datacolumn\" nowrap>" + aseUtil.nullToBlank(rs.getString("approvedby")) + "<br/>" + approvalDate + "</td></tr>");

					if (showComments)
						buf.append("<tr><td>&nbsp;</td><td align=\"left\" colspan=\"03\" valign=\"top\"><font class=\"textblackTH\">Reviewer Comments:</font>&nbsp;&nbsp;<font class=\"datacolumn\">" + aseUtil.nullToBlank(rs.getString("comments")) + "</font></td></tr>");
				}
				else{
					buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
						"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit SLO\" alt=\"edit SLO\" id=\"editSLO\" onclick=\"return aseSubmitClick3("+compID+");\">&nbsp;&nbsp;" +
						"<img src=\"../images/del.gif\" border=\"0\" title=\"delete SLO\" alt=\"delete SLO\" id=\"deleteSLO\" onclick=\"return aseSubmitClick2("+compID+");\">" +
						"</td><td width=\"75%\" valign=\"top\" class=\"datacolumn\">" + rs.getString("comp") + "</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"datacolumn\" nowrap>&nbsp;</td>" +
						"<td width=\"10%\" valign=\"top\" class=\"datacolumn\" nowrap>&nbsp;</td></tr>");

						//"<img src=\"../images/"+image1+".gif\" border=\"0\" title=\"link GenED\" alt=\"link GenED\" id=\"linkGenED\" onclick=\"return aseSubmitClick0('"+kix+"','"+Constant.COURSE_OBJECTIVES+"','GESLO',"+compID+");\">&nbsp;&nbsp;" +
						//"<img src=\"../images/"+image2+".gif\" border=\"0\" title=\"link evaluation\" alt=\"link evaluation\" id=\"linkEvaluation\" onclick=\"return aseSubmitClick0('"+kix+"','"+Constant.COURSE_OBJECTIVES+"','MethodEval',"+compID+");\">&nbsp;&nbsp;" +
						//"<img src=\"../images/"+image3+".gif\" border=\"0\" title=\"link PSLO\" alt=\"link PSLO\" id=\"linkPSLO\" onclick=\"return aseSubmitClick0('"+kix+"','"+Constant.COURSE_OBJECTIVES+"','PSLO',"+compID+");\">&nbsp;&nbsp;" +

						// this would be used for popup showing linked items. not good at this time since
						// the popup would expand to much to be useful for long lists
						//"<img src=\"../images/"+image1+".gif\" border=\"0\" id=\"linkGenED\" onmouseover=\"ajax_showTooltip('tooltip2.jsp?kix=&src=&dst=&kid&=',this);return false;\" onmouseout=\"ajax_hideTooltip()\" onclick=\"return aseSubmitClick0('"+kix+"','"+Constant.COURSE_OBJECTIVES+"','GESLO',"+compID+");\">&nbsp;&nbsp;" +
				}
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByType - " + e.toString());
			return null;
		}

		return buf.toString();
	}

	/*
	 * getCompsByTypeX
	 *	<p>
	 *	@return ArrayList
	 *	<p>
	 */
	public static ArrayList getCompsByTypeX(Connection conn,String kix) throws Exception {

		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			String getSQL = "SELECT compid,comp,auditby,auditdate FROM tblCourseComp WHERE historyid=? ORDER BY compid";
			PreparedStatement ps = conn.prepareStatement(getSQL);
			ps.setString(1,kix);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setID(resultSet.getString(1));
				comp.setComp(resultSet.getString(2));
				comp.setAuditBy(resultSet.getString(3));
				comp.setAuditDate(resultSet.getString(4));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByTypeX - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsAsHTMLList - Identical to getComps except returning string with
	 * HTML table for display
	 *	<p>
	 * @param	conn		Connection
	 * @param	alpha		String
	 * @param	num		String
	 * @param	campus	String
	 * @param	type		String
	 * @param	hid		String
	 * @param	detail	boolean
	 * @param	sloType	String
	 * @param	useTable	boolean
	 *	<p>
	 * @return String
	 */
	public static String getCompsAsHTMLList(Connection conn,
															String alpha,
															String num,
															String campus,
															String type,
															String hid,
															boolean detail,
															String sloType) {

		boolean useTable = true;

		return getCompsAsHTMLList(conn,alpha,num,campus,type,hid,detail,sloType,useTable);
	}

	public static String getCompsAsHTMLList(Connection conn,
															String alpha,
															String num,
															String campus,
															String type,
															String hid,
															boolean detail,
															String sloType,
															boolean useTable) {

		//Logger logger = Logger.getLogger("test");

		String sql;
		StringBuffer comps = new StringBuffer();
		boolean found = false;
		String temp = "";
		String content = "";
		int id = 0;
		int seq = 0;

		try {
			sql = "SELECT Comp,Compid "
				+ "FROM tblCourseComp "
				+ "WHERE historyid=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,hid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				content = rs.getString("comp");
				seq = rs.getInt("compid");
				if (detail){
					comps.append(
						"<li class=\"datacolumn\">"
						+ "<i>" + content + "</i>"
						+ "<ul>"
						+ "	<li class=\"datacolumn\">Method of Evaluation"
						+ "		<ul>" + LinkerDB.getLinkedSLO2Evaluation(conn,hid,seq) + "</ul>"
						+ "	</li>"
						+ "	<li class=\"datacolumn\">GenED SLO"
						+ "		<ul>" + LinkerDB.getLinkedSLO2GESLO(conn,hid,seq) + "</ul>"
						+ "	</li>"
						+ "</ul>"
						+ "</li>");
				}
				else{
					/*
//LINKED ITEM
					comps.append("<li class=\"datacolumn\">"
						+ content
						+ "&nbsp;<a href=\"crslnkdxw.jsp?src="
						+Constant.COURSE_OBJECTIVES
						+"&kix="+hid
						+"&level1="+seq+"\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, {objectType: \'ajax\',width: 800} )\"><img src=\"../images/ed_link2.gif\" alt=\"\" border=\"0\"></a>"
						+ "</li>");
					*/
					comps.append("<li class=\"datacolumn\">"
						+ content
						+ "</li>");
				}
			}
			rs.close();
			ps.close();

			if (found){
				if (useTable){
					temp = "<table border=\"0\" width=\"98%\">" +
						"<tr><td><ul>" +
						comps.toString() +
						"</ul></td></tr></table>";
				}
				else{
					temp = "<ul>" + comps.toString() + "</ul>";
				} // useTable

			} // found

		} catch (Exception e) {
			logger.fatal("CompDB: getCompsAsHTMLList - " + e.toString());
		}

		return temp;
	}

	/*
	 * getCompsByID
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	id				String
	 * <p>
	 * @return ArrayList
	 */
	public static ArrayList getCompsByID(Connection connection,String campus,String id) throws Exception {

		String sql = "SELECT outline "
			+ "FROM vw_CompsByID "
			+ "WHERE campus=? AND assessmentid=?";

		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, id);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setAlpha(resultSet.getString(1));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByID - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsByAlphaNum
	 * <p>
	 * @param	connection	Connection
	 * @param	campus		String
	 *	@param	alpha			String
	 *	@param	num			String
	 *	@param	assessID		String
	 * <p>
	 * @return ArrayList
	 */
	public static ArrayList getCompsByAlphaNum(Connection connection,
															String campus,
															String alpha,
															String num,
															String assessID) throws Exception {

		String sql = "SELECT comp "
			+ "FROM vw_CompsByAlphaNum "
			+ "WHERE campus=? AND coursealpha=? AND coursenum=?";

		if (!"0".equals(assessID))
			sql = sql + " AND assessmentid=?";

		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);

			if (!"0".equals(assessID))
				ps.setString(4, assessID);

			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setComp(resultSet.getString(1));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByAlphaNum - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsByAlphaNumID <p> @return ArrayList
	 */
	public static ArrayList getCompsByAlphaNumID(Connection connection,String alpha,String num,String campus,String id) throws Exception {

		String sql = "SELECT compid,comp "
			+ "FROM vw_CompsByAlphaNumID "
			+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND assessmentid=?";

		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, alpha);
			ps.setString(2, num);
			ps.setString(3, campus);
			ps.setString(4, id);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setID(resultSet.getString(1));
				comp.setComp(resultSet.getString(2));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByAlphaNumID - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * getCompsByTypeCampusID <p> @return ArrayList
	 */
	public static ArrayList getCompsByTypeCampusID(Connection connection,String campus,String id) throws Exception {

		String sql = "SELECT coursealpha,coursenum "
			+ "FROM tblCourse "
			+ "WHERE coursetype='CUR' AND campus=? AND dispid=? "
			+ "ORDER BY coursealpha, coursenum";

		ArrayList<Comp> list = new ArrayList<Comp>();

		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, id);
			ResultSet resultSet = ps.executeQuery();
			Comp comp;
			while (resultSet.next()) {
				comp = new Comp();
				comp.setAlpha(resultSet.getString(1));
				comp.setNum(resultSet.getString(2));
				list.add(comp);
			}
			resultSet.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getCompsByTypeCampusID - " + e.toString());
			list = null;
		}

		return list;
	}

	/*
	 * setCompApproval
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	@param	comments	String
	 *	@param	aproval	String
	 *	@param	user		String
	 *	@param	lid		int
	 * <p>
	 *	@return int
	 */
	public static int setCompApproval(Connection conn,
											String campus,
											String alpha,
											String num,
											String type,
											String comments,
											String approval,
											String user,
											int lid) {

		logger.info("CompDB: SETCOMPAPPROVAL - START");

		String table = "tblCourseComp";
		int rowsAffected = 0;
		try {
			String sql = "UPDATE " + table + " " +
				"SET comments=?,ApprovedDate=?,ApprovedBy=?,approved=? " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND compid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, comments);
			ps.setString(2, AseUtil.getCurrentDateTimeString());
			ps.setString(3, user);
			ps.setString(4, approval);
			ps.setString(5, campus);
			ps.setString(6, alpha);
			ps.setString(7, num);
			ps.setString(8, type);
			ps.setInt(9, lid);
			rowsAffected = ps.executeUpdate();
			logger.info("setCompApproval - updated review - " + rowsAffected + " row");

			/*
				if all SLO review completed, notify proposer and release record lock.

				1) get the kix to use for counting records
				2) with result set, check counter. if == 0, then nothing left to review
					so we send notification to proposer.
			*/
			String kix = Helper.getKix(conn,campus,alpha,num,type);
			if (!hasSLOsToReview(conn,kix)){
				String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);
				rowsAffected = SLODB.reviewCompleted(conn,kix,user,proposer);
				logger.info("setCompApproval - all reviews completed; notifying proposer - " + rowsAffected + " row");
			}

			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB: setCompApproval - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("CompDB: setCompApproval\n" + ex.toString());
			return 0;
		}

		logger.info("CompDB: SETCOMPAPPROVAL - END");

		return rowsAffected;
	}

	/*
	 * setCompReview
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	type		String
	 *	@param	comments	String
	 *	@param	aproval	String
	 *	@param	user		String
	 *	@param	lid		int
	 * <p>
	 *	@return int
	 */
	public static int setCompReview(Connection conn,
											String campus,
											String alpha,
											String num,
											String type,
											String comments,
											String approval,
											String user,
											int lid) {

		int rowsAffected = 0;
		try {
			String sql = "UPDATE tblCourseComp " +
				"SET comments=?,ReviewedDate=?,ReviewedBy=?,Reviewed=? " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND compid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, comments);
			ps.setString(2, AseUtil.getCurrentDateTimeString());
			ps.setString(3, user);
			ps.setString(4, approval);
			ps.setString(5, campus);
			ps.setString(6, alpha);
			ps.setString(7, num);
			ps.setString(8, type);
			ps.setInt(9, lid);
			rowsAffected = ps.executeUpdate();
			/*
				if all SLO review completed, notify proposer and release record lock.

				1) get the kix to use for counting records
				2) with result set, check counter. if == 0, then nothing left to review
					so we send notification to proposer.
			*/
			String kix = Helper.getKix(conn,campus,alpha,num,type);
			if (!hasSLOsToReview(conn,kix)){
				String proposer = CourseDB.getCourseProposer(conn,campus,alpha,num,type);
				rowsAffected = SLODB.reviewCompleted(conn,kix,user,proposer);
			}

			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB: setCompReview - " + e.toString());
			rowsAffected = 0;
		} catch (Exception ex) {
			logger.fatal("CompDB: setCompReview\n" + ex.toString());
			rowsAffected = 0;
		}

		return rowsAffected;
	}

	/*
	 * hasSLOsToReview
	 * <p>
	 *	@param	Connection	conn
	 *	@param	String		kix
	 * <p>
	 *	@return boolean
	 */
	public static boolean hasSLOsToReview(Connection conn,String kix) {

		int counter = 0;
		boolean sloToReview = false;

		try {
			String sql = "SELECT COUNT(*) AS counter " +
				"FROM tblCourseComp WHERE historyid=? AND (Approved IS NULL OR Approved=\'\')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				counter = rs.getInt(1);
				if (counter>0)
					sloToReview = true;
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB: hasSLOsToReview - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompDB: hasSLOsToReview\n" + ex.toString());
		}

		return sloToReview;
	}

	/*
	 * addRemoveCourseComp
	 * <p>
	 * @param	connection	Connection
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	comp			String
	 * @param	compID		int
	 * @param	user			String
	 * @param	kix			String
	 * <p>
	 * @return Msg
	 */
	public static Msg addRemoveCourseComp(Connection connection,
														String action,
														String campus,
														String alpha,
														String num,
														String comp,
														int compID,
														String user,
														String kix) throws SQLException {

		String table = "tblCourseComp";
		int rowsAffected = 0;
		Msg msg = new Msg();
		String insertSQL = "INSERT INTO tblCourseComp(campus,coursealpha,coursenum,coursetype,comp,AuditBy,historyid,compid,rdr) VALUES(?,?,?,?,?,?,?,?,?)";
		String removeSQL = "DELETE FROM tblCourseComp WHERE compid=?";
		String updateSQL = "UPDATE tblCourseComp SET comp=?,AuditBy=?,AuditDate=? WHERE compid=?";
		PreparedStatement ps;
		int accjcID = 0;
		String type = "";
		int compNextID = 0;
		int rdrNextID = 0;

		try {
			String sql = "";
			boolean nextStep = true;

			/*
			 * for add mode, don't add if already there. for remove, just proceed
			 * during edit, always course type of PRE
			 */
			if ("a".equals(action)) {
				if (compID>0)
					sql = updateSQL;
				else
					sql = insertSQL;
			} else
				sql = removeSQL;

			if (!"".equals(kix)){
				String[] info = Helper.getKixInfo(connection,kix);
				type = info[2];
			}

			if (nextStep) {
				if ("r".equals(action)) {
					if (compID>0){
						Comp thisComp = CompDB.getCompByID(connection,compID,Constant.COURSE_OBJECTIVES);
						if (thisComp!=null){
							campus = thisComp.getCampus();
							alpha = thisComp.getAlpha();
							num = thisComp.getNum();

 							accjcID = CourseACCJCDB.getID(connection,compID);

							removeSQL = "DELETE FROM tblAssessedData WHERE accjcid=?";
							ps = connection.prepareStatement(removeSQL);
							ps.setInt(1, accjcID);
							rowsAffected = ps.executeUpdate();

							removeSQL = "DELETE FROM tblCourseCompAss WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
							ps = connection.prepareStatement(removeSQL);
							ps.setString(1, campus);
							ps.setString(2, alpha);
							ps.setString(3, num);
							ps.setString(4, "PRE");
							rowsAffected = ps.executeUpdate();

							removeSQL = "DELETE FROM tblCourseACCJC WHERE compid=?";
							ps = connection.prepareStatement(removeSQL);
							ps.setInt(1, compID);
							rowsAffected = ps.executeUpdate();

							ps.close();
						}	// thisComp
					}	// compID > 0
				}	// r

				ps = connection.prepareStatement(sql);
				if ("a".equals(action)){
					if (compID>0){
						ps.setString(1, comp);
						ps.setString(2, user);
						ps.setString(3, AseUtil.getCurrentDateTimeString());
						ps.setInt(4, compID);
					}
					else{
						compNextID = getNextCompID(connection);
						rdrNextID = getNextRDR(connection,kix);
						ps.setString(1, campus);
						ps.setString(2, alpha);
						ps.setString(3, num);
						ps.setString(4, type);
						ps.setString(5, comp);
						ps.setString(6, user);
						ps.setString(7, kix);
						ps.setInt(8, compNextID);
						ps.setInt(9, rdrNextID);
					}
				}
				else if ("r".equals(action)){
					ps.setInt(1, compID);
				}

				rowsAffected = ps.executeUpdate();
				ps.close();

				// returning compNextID for use by splitting of SLO
				msg.setMsg("Successful");
				if ("a".equals(action))
					msg.setCode(compNextID);
				else
					msg.setCode(0);
			}

		} catch (SQLException e) {
			kix = "action: " + action + "; campus: " + campus + "; kix: " + kix + "; alpha: " + alpha + "; num: " + num + "; comp: " + comp;
			msg.setMsg("Exception");
			logger.fatal("CompDB: addRemoveCourseComp ("+kix+") " + e.toString());
		} catch (Exception e) {
			kix = "action: " + action + "; campus: " + campus + "; kix: " + kix + "; alpha: " + alpha + "; num: " + num + "; comp: " + comp;
			msg.setMsg("Exception");
			logger.fatal("CompDB: addRemoveCourseComp ("+kix+") " + e.toString());
		}

		return msg;
	}

	/*
	 * has comp been added
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		campus
	 *	@param	String		alpha
	 *	@param	String		num
	 *	@param	String		comp
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCompAdded(Connection connection,String campus,String alpha,String num,String comp) throws SQLException {

		boolean added = false;
		String table = "tblCourseComp";

		try {
			/*
				in edit/add mode, we are always checking on PRE
			*/
			String sql = "SELECT coursealpha " +
				"FROM " + table + " " +
				"WHERE campus=? AND " +
				"courseAlpha=? AND " +
				"coursenum=? AND " +
				"coursetype=? AND " +
				"comp=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, "PRE");
			ps.setString(5, comp);
			ResultSet results = ps.executeQuery();
			added = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: isCompAdded - " + e.toString());
		}

		return added;
	}

	/*
	 * has comp been added
	 *	<p>
	 *	@param	Connection	connection
	 *	@param	String		kix
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isCompAdded(Connection connection,String kix) throws SQLException {

		boolean added = false;
		String table = "tblCourseComp";

		try {
			/*
				in edit/add mode, we are always checking on PRE
			*/
			String sql = "SELECT coursealpha " +
				"FROM " + table + " " +
				"WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet results = ps.executeQuery();
			added = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: isCompAdded - " + e.toString());
		}

		return added;
	}

	/*
	 * getNextCompID
	 *	<p>
	 *	@return int
	 */
	public static int getNextCompID(Connection connection) throws SQLException {

		int id = 0;
		String table = "tblCourseComp";

		try {
			String sql = "SELECT MAX(CompID) + 1 AS maxid FROM " + table;
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getNextCompID - " + e.toString());
		}

		return id;
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection connection,String kix) throws SQLException {

		int id = 0;
		String table = "tblCourseComp";

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid FROM "
				+ table
				+ " WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getNextRDR - " + e.toString());
		}

		return id;
	}

	/*
	 * getObjectives
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	<p>
	 *	@return String
	 */
	public static String getObjectives(Connection conn,String kix) throws SQLException {

		String objectives = "";

		String sql = "SELECT " + Constant.COURSE_OBJECTIVES +
			" FROM tblCourse " +
			" WHERE historyid=?";

		try{
			if (!"".equals(kix)){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					objectives = AseUtil.nullToBlank(rs.getString(Constant.COURSE_OBJECTIVES));
					objectives = SQLUtil.removeJavaScriptTags(objectives);
				}
				rs.close();
				ps.close();
			}
		} catch (Exception e) {
			logger.fatal("CompDB: getObjectives - " + e.toString());
		}

		return objectives;
	}

	/*
	 * getObjective
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kix		String
	 *	@param	compID	int
	 *	<p>
	 *	@return String
	 */
	public static String getObjective(Connection conn,String kix,int compID) throws SQLException {

		String objective = "";

		String sql = "SELECT comp " +
			"FROM tblCourseComp " +
			"WHERE historyid=? AND " +
			"compid=?";

		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,compID);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				objective = AseUtil.nullToBlank(results.getString("comp")).trim();
			}
			results.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: getObjective - " + e.toString());
		}

		return objective;
	}

	/*
	 * updateObjective
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	kix			String
	 *	@param	objective	String
	 *	<p>
	 *	@return int
	 */
	public static int updateObjective(Connection conn,String kix,String objective) throws SQLException {

		int rowsAffected = -1;
		String sql = "UPDATE tblCourse "
			+ "SET " + Constant.COURSE_OBJECTIVES + "=? "
			+ "WHERE historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,objective);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompDB: updateObjective - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * deleteObjectives
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	kix			String
	 * <p>
	 */
	public static void deleteObjectives(Connection conn,String campus,String kix) throws SQLException {

		int rowsAffected = 0;
		PreparedStatement ps;

		try {
			ps = conn.prepareStatement("DELETE FROM tblCourseComp WHERE campus=? AND historyid=?");
			ps.setString(1,campus);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
		} catch (SQLException e) {
			logger.fatal("CompDB: deleteObjectives - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompDB: deleteObjectives - " + ex.toString());
		}
	}

	/*
	 * getCompByKixID
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	compid
	 * <p>
	 * @return	Comp
	 */
	public static Comp getCompByKixID(Connection conn,String kix,int compid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Comp comp = null;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"CompDB");

			String sql = "SELECT * FROM tblCourseComp WHERE historyid=? AND compid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,compid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (debug) logger.info(kix + " - comp found");

				comp = new Comp();
				comp.setCompID(rs.getInt("compid"));
				comp.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				comp.setAlpha(AseUtil.nullToBlank(rs.getString("CourseAlpha")));
				comp.setNum(AseUtil.nullToBlank(rs.getString("Coursenum")));
				comp.setComp(AseUtil.nullToBlank(rs.getString("comp")));
				comp.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				comp.setApprovedBy(AseUtil.nullToBlank(rs.getString("ApprovedBy")));
				comp.setApprovedDate(AseUtil.nullToBlank(rs.getString("approveddate")));
				comp.setAuditDate(AseUtil.nullToBlank(rs.getString("AuditDate")));
				comp.setAuditBy(AseUtil.nullToBlank(rs.getString("AuditBy")));
			}
			else{
				if (debug) logger.info(kix + " - comp not found");
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB: getCompByKixID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompDB: getCompByKixID - " + ex.toString());
		}

		return comp;
	}

	/*
	 * insertComp
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	user
	 * @param	compID
	 * <p>
	 * @return	int
	 */
	public static int copyComp(Connection conn,
											String kixOld,
											String kixNew,
											String alpha,
											String num,
											String user,
											int compID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean debug = false;

		String src = Constant.COURSE_OBJECTIVES;
		String campus = "";

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"CompDB");

			if (debug) logger.info("COMPDB INSERTCOMP - STARTS");

			String sql = "INSERT INTO tblCourseComp(campus,coursealpha,coursenum,coursetype,comp,AuditBy,historyid,compid,rdr) "
				+ "VALUES(?,?,?,?,?,?,?,?,?)";

			Comp comp = getCompByKixID(conn,kixOld,compID);

			if (comp != null){

				int rdrNextID = CompDB.getNextRDR(conn,kixNew);

				campus = comp.getCampus();

				String[] info2 = Helper.getKixInfo(conn,kixNew);
				String toCampus = info2[Constant.KIX_CAMPUS];

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,toCampus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,type);
				ps.setString(5,comp.getComp());
				ps.setString(6,user);
				ps.setString(7,kixNew);
				ps.setInt(8, compID);
				ps.setInt(9, rdrNextID);
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug) logger.info(kixNew + " - course comp copied");

				rowsAffected = LinkedUtil.copyLinked(conn,campus,user,type,kixOld,kixNew,src,compID,compID);
			}

			if (debug) logger.info("COMPDB INSERTCOMP - ENDS");

		} catch (SQLException e) {
			logger.fatal("CompDB: insertComp - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompDB: insertComp - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getLastUpdated
	 * <p>
	 * @param	conn
	 * @param	kix
	 * <p>
	 * @return	String
	 */
	public static String getLastUpdated(Connection conn,String kix) throws SQLException {

		String lastDate = "";

		try {
			String sql = "SELECT MAX(AuditDate) AS auditdate "
						+ "FROM tblCourseComp "
						+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				AseUtil aseUtil = new AseUtil();

				lastDate = AseUtil.nullToBlank(rs.getString(1));

				if (lastDate != null && lastDate.length()>0)
					lastDate = aseUtil.ASE_FormatDateTime(lastDate,Constant.DATE_DATETIME);

				aseUtil = null;

			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getLastUpdated - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompDB: getLastUpdated - " + ex.toString());
		}

		return lastDate;
	}

	/**
	 * insertListFromSrc
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	subtopic		String
	 * <p>
	 * @return	int
	 */
	public static int insertListFromSrc(Connection conn,
														String campus,
														String kix,
														String user,
														String src,
														String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String list = "";

		int rowsAffected  = 0;

		try {
			GenericContent gc = null;

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			String sql = "SELECT shortdescr FROM tblValues WHERE campus=? AND src=? AND subtopic=? ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ps.setString(3,subtopic);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list = AseUtil.nullToBlank(rs.getString("shortdescr"));
				addRemoveCourseComp(conn,"a",campus,alpha,num,list,0,user,kix);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB: insertListFromSrc - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CompDB: insertListFromSrc - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * hasSLOs
	 * <p>
	 *	@param	Connection	conn
	 *	@param	String		kix
	 * <p>
	 *	@return boolean
	 */
	public static boolean hasSLOs(Connection conn,String kix) {

		int counter = 0;
		boolean slo = false;

		try {
			String sql = "SELECT COUNT(*) AS counter FROM tblCourseComp WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				counter = rs.getInt(1);
				if (counter>0) {
					slo = true;
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("CompDB.hasSLOs ("+kix+") " + e.toString());
		} catch (Exception e) {
			logger.fatal("CompDB.hasSLOs ("+kix+") " + e.toString());
		}

		return slo;
	}

	public void close() throws SQLException {}

}