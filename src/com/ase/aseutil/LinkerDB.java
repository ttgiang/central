/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static int deleteLinkedItems(Connection conn,String campus,String kix,String src,int id) throws SQLException {
 *	public static String[] getLinkedData(Connection conn,String campus,String src,String dst,String kix,int seq)
 *	public static int getLinkedID(Connection conn,String campus,String kix,String src,String dst,int seq)
 *	public static int getLinkedItemCount(Connection conn,String campus,String kix,String src,String dst,int seq)
 *	public static String getSelectedLinkedItem(Connection conn,String kix,String src,int seq) throws Exception {
 *	public static boolean isDeletable(Connection conn,String campus,String kix,String src,String dst,int id) throws SQLException {
 * String listConnectedOutlineItems(Connection conn,String campus,String type,int idx,
 *													HttpServletRequest request,HttpServletResponse response)
 * void close () throws SQLException{}
 *
 */

//
// LinkerDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.paging.Paging;

public class LinkerDB {
	static Logger logger = Logger.getLogger(LinkerDB.class.getName());

	public LinkerDB() throws Exception {}

	/*
	 * getLinkedData	- array of values to work with
	 *						- index 0 contains the number of check list entries
	 *						- index 1 contains the individual indices
	 *						- index 2 the check boxes
	 *
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	dst		String
	 * @param	kix		String
	 * @param	seq		int
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getLinkedData(Connection conn,String campus,String src,String dst,String kix,int seq) {


		boolean showInput = true;		// display check box for form selection
		boolean reporting = false;		// if true, display only selected items without check marks

		String[] rtn = getLinkedData(conn,campus,src,dst,kix,seq,showInput,reporting);

		return rtn;
	}

	/*
	 * getLinkedData	- duplicate of above with the ability to show or hide check boxes
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	dst			String
	 * @param	kix			String
	 * @param	seq			int
	 * @param	showInput	boolean
	 * @param	reporting	boolean
	 *	<p>
	 *	@return String[]
	 */
	public static String[] getLinkedData(Connection conn,
														String campus,
														String src,
														String dst,
														String kix,
														int seq,
														boolean showInput,
														boolean reporting) {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String checked = "";
		String temp = "";
		String selected = null;
		StringBuffer buf = new StringBuffer();
		String allKeys = "";

		int TOTALCOLUMNS = 3;
		String[] rtn = new String[TOTALCOLUMNS];

		String thisKey = "";
		String thisDescr = "";

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			// retrieve values saved to db
			if (dst.equals("Objectives") || dst.equals("SLO")){
				if ((Constant.COURSE_COMPETENCIES).equals(src)){
					selected = CompetencyDB.getSelectedSLOs(conn,kix,""+seq);
				}
				else if ((Constant.COURSE_CONTENT).equals(src)){
					selected = "," + ContentDB.getSelectedSLOs(conn,kix,""+seq);
				}
				else{
					selected = "," + getSelectedLinkedItem(conn,kix,src,dst,seq);
				}
			}
			else{
				selected = getSelectedLinkedItem(conn,kix,src,dst,seq);
			}

			// retrieve all assessed items. put in CSV here
			selected = selected + ",";

			// retrieve array of items to show on screen
			ArrayList list = LinkedUtil.GetLinkedListByDst(conn,campus,kix,src,dst);

			// with items returned, put into array list that we can work with
			if (list != null){

				Assess assess;
				Competency competency;
				Comp comp;
				Content content;
				GenericContent gc;
				GESLO geslo;
				Ini ini;

				for (int i = 0; i<list.size(); i++){
					if (dst.equalsIgnoreCase("Assess")){
						assess = (Assess)list.get(i);
						thisKey = assess.getId();
						thisDescr = assess.getAssessment();
					}
					else if (dst.equalsIgnoreCase("Competency")){
						competency = (Competency)list.get(i);
						thisKey = "" + competency.getSeq();
						thisDescr = competency.getContent();
					}
					else if (dst.equalsIgnoreCase("Content")){
						content = (Content)list.get(i);
						thisKey = "" + content.getContentID();
						thisDescr = content.getLongContent();
					}
					else if (dst.equalsIgnoreCase("GESLO")){
						geslo = (GESLO)list.get(i);
						thisKey = "" + geslo.getID();
						thisDescr = geslo.getSloEvals();
					}
					else if (dst.equalsIgnoreCase("MethodEval")){
						ini = (Ini)list.get(i);
						thisKey = ini.getId();
						thisDescr = ini.getKdesc();
					}
					else if (dst.equalsIgnoreCase("Objectives")){
						comp = (Comp)list.get(i);
						thisKey = "" + comp.getID();
						thisDescr = comp.getComp();
					}
					else if (dst.equalsIgnoreCase("PSLO")){
						gc = (GenericContent)list.get(i);
						thisKey = "" + gc.getId();
						thisDescr = gc.getComments();
					}

					checked = "";
					temp = thisKey + ",";

					// in the list of seleted items, is this one of them. if so, place check on form
					if (selected.indexOf(temp) > -1)
						checked = "checked";

					// if we are reporting linked items, no point in printing non selected items
					if (reporting){
						if ("checked".equals(checked)){
							buf.append("<tr>");
							buf.append("<td width=\"95%\" valign=\"top\" class=\"class=\"datacolumn\"\">"+ thisDescr + "<br/><br/></td>");
							buf.append("</tr>");
						}
					}
					else{
						buf.append("<tr>");

						if (showInput)
							buf.append("<td width=\"05%\" valign=\"top\"><input type=\"checkbox\" name=\"link_"+ thisKey + "\" value=\""+ thisKey + "\" " + checked + "></td>");
						else
							buf.append("<td width=\"05%\" valign=\"top\">&nbsp;</td>");

						buf.append("<td width=\"95%\" valign=\"top\" class=\"class=\"datacolumn\"\">"+ thisDescr + "<br/><br/></td>");
						buf.append("</tr>");
					}

					if (allKeys.length() == 0 )
						allKeys = thisKey;
					else
						allKeys = allKeys + "," + thisKey;
				}	// for

				temp = "<table id=\"tableGetLinkedData_\"" + src + "_" + dst + " width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ buf.toString()
					+ "</table>";

				rtn[0] = "" + list.size();
				rtn[1] = allKeys;
				rtn[2] = temp;
			}	// if
			else{
				rtn[0] = "";
				rtn[1] = "";
				rtn[2] = "";
			}	// if

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedData\n" + e.toString());
			temp = "";
		}

		return rtn;
	}

	/*
	 * getLinkedID
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	dst		String
	 * @param	kix		String
	 * @param	seq		int
	 *	<p>
	 *	@return int
	 */
	public static int getLinkedID(Connection conn,String campus,String kix,String src,String dst,int seq) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT id "
				+ " FROM tblCourseLinked "
				+ " WHERE campus=? "
				+ " AND historyid=? "
				+ " AND src=? "
				+ " AND dst=? "
				+ " AND seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			ps.setString(4,dst);
			ps.setInt(5,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("id");
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("LinkerDB: getLinkedID\n" + e.toString());
		}

		return id;
	}

	/*
	 * getLinkedItemCount
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	src		String
	 * @param	dst		String
	 * @param	kix		String
	 * @param	seq		int
	 *	<p>
	 *	@return int
	 */
	public static int getLinkedItemCount(Connection conn,String campus,String kix,String src,String dst,int seq) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT counter "
				+ " FROM vw_LinkedCountItems "
				+ " WHERE campus=? AND "
				+ " historyid=? AND "
				+ " src=? AND "
				+ " dst=? AND "
				+ " seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			ps.setString(4,dst);
			ps.setInt(5,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("counter");
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("LinkerDB: getLinkedItemCount\n" + e.toString());
		}

		return id;
	}

	/*
	 * listConnectedOutlineItems
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	idx		int
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return String
	 */
	public static String listConnectedOutlineItems(Connection conn,
														String campus,
														String type,
														int idx,
														HttpServletRequest request,
														HttpServletResponse response,
														String alpha,
														String num) throws Exception {

		String temp = "";
		String sql = "";

		if (idx > 0 || alpha.length() >0){
			AseUtil aseUtil = new AseUtil();
			HttpSession session = request.getSession(true);

			if (alpha.length() > 0 && num.length() > 0){
				sql = "SELECT historyid,CourseAlpha AS [Alpha],CourseNum AS [Number],coursetitle AS [Title],coursedate AS [Course Date],"
					+ "assessmentdate AS [Course Assessment Date],reviewdate As [Review Date] "
					+ "FROM tblCourse "
					+ "WHERE campus='"+ campus + "' AND "
					+ "CourseType='" + type + "' AND "
					+ "coursealpha='" + alpha + "' AND "
					+ "coursenum='" + num + "' "
					+ "ORDER BY CourseAlpha, CourseNum";
			}
			else if (alpha.length() > 0){
				sql = "SELECT historyid,CourseAlpha AS [Alpha],CourseNum AS [Number],coursetitle AS [Title],coursedate AS [Course Date],"
					+ "assessmentdate AS [Course Assessment Date],reviewdate As [Review Date] "
					+ "FROM tblCourse "
					+ "WHERE campus='"+ campus + "' AND "
					+ "CourseType='" + type + "' AND "
					+ "coursealpha='" + alpha + "' "
					+ "ORDER BY CourseAlpha, CourseNum";
			}
			else{
				sql = "SELECT historyid,CourseAlpha AS [Alpha],CourseNum AS [Number],coursetitle AS [Title],coursedate AS [Course Date],"
					+ "assessmentdate AS [Course Assessment Date],reviewdate As [Review Date] "
					+ "FROM tblCourse "
					+ "WHERE campus='"+ campus + "' AND "
					+ "CourseType='" + type + "' AND coursealpha like '" + (char)idx + "%' "
					+ "ORDER BY CourseAlpha, CourseNum";
			}

			Paging paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setScriptName("/central/core/crsconz.jsp");
			paging.setDetailLink("/central/core/crsconz.jsp?x=yda");
			paging.setUrlKeyName("kix");
			paging.setRecordsPerPage(999);
			paging.setAlphaIndex(idx);
			paging.setNavigation(false);
			temp = paging.showRecords(conn, request, response);
			paging = null;
		}

		return temp;
	}

	/*
	 * STARTS HERE
	 *
	 * getLinkedOutlineContent
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	 public static String getLinkedOutlineContent(Connection conn,String kix)throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";

		ResultSet rs = null;
		PreparedStatement ps = null;

		StringBuffer contents = new StringBuffer();
		String content = "";
		boolean found = false;
		int seq = 0;

		try {
			sql = "SELECT contentid,longcontent "
				+ "FROM tblCourseContent "
				+ "WHERE historyid=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("contentid");
				content = rs.getString("longcontent");
				contents.append(
					"<li class=\"class=\"datacolumn\"\">"
					+ 	"<strong>" + content + "</strong>"
					+ 		"<ul>" + getLinkedOutlineSLO(conn,kix,seq) + "</ul>"
					+ 		"<ul>" + getLinkedOutlineCompentency(conn,kix,seq) + "</ul>"
					+ "</li>");

				found = true;
			}
			rs.close();
			ps.close();


		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineContent - " + e.toString());
		}

		if (found)
			temp = "<ul>" + contents.toString() + "</ul>";

		return temp;
	}

	/*
	 * getLinkedOutlineSLO
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	contentid	int
	 * <p>
	 * @return String
	 */
	public static String getLinkedOutlineSLO(Connection conn,String kix,int contentid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String slo = "";
		String campus = "";
		String linkedSLO2Evaluation = "";
		String linkedSLO2GESLO = "";
		String linkedSLO2PSLO = "";

		boolean found = false;
		int seq = 0;

		StringBuffer contents = new StringBuffer();
		try {
			sql = "SELECT tc.campus,tc.Comp,tc.CompID "
				+ "FROM tblCourseContentSLO ts INNER JOIN "
				+ "tblCourseComp tc ON ts.historyid=tc.historyid AND ts.sloid = tc.CompID "
				+ "WHERE ts.historyid=? "
				+ "AND ts.contentid=? "
				+ "ORDER BY tc.Comp";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,contentid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				campus = rs.getString("campus");
				seq = rs.getInt("compid");
				slo = rs.getString("comp");

				if (seq>0){
					contents.append(
						"<li class=\"class=\"datacolumn\"\">"
						+ "<i>" + slo + "</i>");

					linkedSLO2Evaluation = getLinkedSLO2Evaluation(conn,kix,seq);
					linkedSLO2GESLO = getLinkedSLO2GESLO(conn,kix,seq);
					linkedSLO2PSLO = getLinked2PSLO(conn,Constant.COURSE_OBJECTIVES,kix,seq);

					contents.append("<ul>");

					// TODO - hard coding
					if (!(Constant.CAMPUS_UHMC).equals(campus)){
						if (!"".equals(linkedSLO2Evaluation))
								contents.append("	<li class=\"class=\"datacolumn\"\">Method of Evaluation"
									+ "		<ul>" + linkedSLO2Evaluation + "</ul>"
									+ "	</li>");
					}

					if (!"".equals(linkedSLO2GESLO))
							contents.append( "	<li class=\"class=\"datacolumn\"\">GenED SLO"
							+ "		<ul>" + linkedSLO2GESLO + "</ul>"
							+ "	</li>");

					if (!"".equals(linkedSLO2PSLO))
							contents.append( "	<li class=\"class=\"datacolumn\"\">Program SLO"
							+ "		<ul>" + linkedSLO2PSLO + "</ul>"
							+ "	</li>");

					contents.append("</ul>");
					contents.append("</li>");

					found = true;
				}
			} // while
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedOutlineCompentency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	seq		int
	 * <p>
	 * @return String
	 */

	public static String getLinkedOutlineCompentency(Connection conn,String kix,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String dst = "";
		String temp = "";
		String campus = "";
		String linked2GESLO = "";
		String linked2MethodEval = "";
		String linked2PSLO = "";
		String linked2SLO = "";
		String competency = "";

		int keyGESLO = 0;
		int keyMethodEval = 0;

		ResultSet rsOuter = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		int keyid = 0;

		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT DISTINCT vw.Linked2Item,tc.content,tc.campus "
				+ "FROM vw_LinkedContent2Compentency vw INNER JOIN "
				+ "tblCourseCompetency tc ON vw.historyid = tc.historyid AND "
				+ "vw.Linked2Item = tc.seq "
				+ "WHERE vw.historyid=? AND vw.contentid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			rsOuter = ps.executeQuery();
			while (rsOuter.next()) {
				seq = NumericUtil.nullToZero(rsOuter.getInt("linked2item"));
				competency = AseUtil.nullToBlank(rsOuter.getString("content"));
				campus = AseUtil.nullToBlank(rsOuter.getString("campus"));

				contents.append(
					"<li class=\"class=\"datacolumn\"\">"
					+ "<i>" + competency + "</i>");

				found = true;

				sql = "SELECT geslo,methodeval "
					+ "FROM vw_LinkedCompetency2 "
					+ "WHERE historyid=? AND seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,seq);
				rs = ps.executeQuery();
				while (rs.next()) {
					keyGESLO = rs.getInt("geslo");
					keyMethodEval = rs.getInt("methodeval");

					contents.append("<ul>");

					// TODO - hard coding
					if ((Constant.CAMPUS_KAP).equals(campus)){
						if (keyGESLO>0){
							linked2GESLO = getLinked2Competency(conn,kix,"GESLO",seq,keyGESLO);
							if (!"".equals(linked2GESLO))
									contents.append( "	<li class=\"class=\"datacolumn\"\">GenED SLO"
									+ "		<ul>" + linked2GESLO + "</ul>"
									+ "	</li>");
						}
					}

					if (keyMethodEval>0){
						linked2MethodEval = getLinked2Competency(conn,kix,"MethodEval",seq,keyMethodEval);
						if (!"".equals(linked2MethodEval)){
								contents.append( "	<li class=\"class=\"datacolumn\"\">Method of Evaluation"
								+ "		<ul>" + linked2MethodEval + "</ul>"
								+ "	</li>");
						}
					}

					// TODO - hard coding
					if ((Constant.CAMPUS_KAP).equals(campus)){
						linked2PSLO = getLinked2PSLO(conn,Constant.COURSE_COMPETENCIES,kix,seq);
						if (!"".equals(linked2PSLO)){
								contents.append( "	<li class=\"class=\"datacolumn\"\">Program SLO"
								+ "		<ul>" + linked2PSLO + "</ul>"
								+ "	</li>");
						}
					}

					if ((Constant.CAMPUS_UHMC).equals(campus)){
						linked2SLO = getLinked2SLO(conn,Constant.COURSE_COMPETENCIES,kix,seq);
						if (!"".equals(linked2SLO)){
								contents.append( "	<li class=\"class=\"datacolumn\"\">Course SLO"
								+ "		<ul>" + linked2SLO + "</ul>"
								+ "	</li>");
						}
					}

					contents.append("</ul>");

				} // while
				rs.close();
			}	// rsOuter
			rsOuter.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineCompentency - " + e.toString());
		}

		if (found){
			contents.append("</li>");
			temp = contents.toString();
		}

		return temp;
	}

	/*
	 * getLinkedSLO2Evaluation
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2Evaluation(Connection conn,String kix,int keyid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		sql = "SELECT tcc.Comp, vw.content "
			+ "FROM tblCourseComp tcc, vw_LinkedSLO2MethodEval vw "
			+ "WHERE tcc.historyid=vw.historyid "
			+ "AND tcc.compid=vw.seq "
			+ "AND vw.historyid=? "
			+ "AND vw.seq=? ";

		String methodEvals = CourseDB.getCourseItem(conn,kix,Constant.COURSE_METHODEVALUATION);
		if (methodEvals != null && methodEvals.length() > 0)
			sql += "AND vw.iniID in ("+methodEvals+") ";

		sql += "ORDER BY tcc.compid,content";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"class=\"datacolumn\"\">" + rs.getString("content") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2Evaluation - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedSLO2GESLO
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2GESLO(Connection conn,String kix,int keyid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_LinkedSLO2GESLO";

		try {
			sql = "SELECT content "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "seq=? "
				+ "ORDER BY content";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"class=\"datacolumn\"\">" + rs.getString("content") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2GESLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinked2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2PSLO(Connection conn,String src,String kix,int keyid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_Linked2PSLO";

		try {
			sql = "SELECT comments "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "src=? AND "
				+ "dst=? AND "
				+ "seq=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setString(3,"PSLO");
			ps.setInt(4,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"class=\"datacolumn\"\">" + rs.getString("comments") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2PSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinked2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2SLO(Connection conn,String src,String kix,int keyid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_Linked2SLO";

		try {
			sql = "SELECT comp "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "linkedseq=? "
				+ "ORDER BY comprdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"class=\"datacolumn\"\">" + rs.getString("comp") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2SLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinked2Competency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	dst		String
	 * @param	se			int
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2Competency(Connection conn,String kix,String dst,int seq,int keyid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		if (dst.equals("Assess"))
			table = "vw_LinkedCompetency2Assessment";
		else if (dst.equals("Content"))
			table = "vw_LinkedCompetency2Content";
		else if (dst.equals("GESLO"))
			table = "vw_LinkedCompetency2GESLO";
		else if (dst.equals("MethodEval"))
			table = "vw_LinkedCompetency2MethodEval";

		try {
			sql = "SELECT content "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "keyid=? "
				+ "AND seq=? ";

			if (dst.equals("MethodEval")){
				String methodEvals = CourseDB.getCourseItem(conn,kix,Constant.COURSE_METHODEVALUATION);
				if (methodEvals != null && methodEvals.length() > 0){
					sql += "AND iniID IN ("+methodEvals+") ";
				}
			}

			sql += "ORDER BY content";

			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ps.setInt(3,seq);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"class=\"datacolumn\"\">" + rs.getString("content") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2Competency -" + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedCompKey
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	seq		int
	 * <p>
	 * @return String
	 */
	public static int getLinkedCompKey(Connection conn,String kix,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		StringBuffer contents = new StringBuffer();
		try {
			sql = "SELECT linked2item "
				+ "FROM vw_LinkedContent2Compentency "
				+ "WHERE historyid=? AND contentid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				seq = rs.getInt("linked2item");
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedCompKey - " + e.toString());
		}

		return seq;
	}

	/*
	* ENDS HERE
	*/

	/*
	 * isDeletable
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	src		String
	 *	@param	dst		String
	 *	@param	id			int
	 * <p>
	 *	@return boolean
	 */
	public static boolean isDeletable(Connection conn,String campus,String kix,String src,String dst,int id) throws SQLException {

		/*
		Competency (X43)
				GESLO (X71)
				MethodEval (X23)

		SLO (X18)
				GESLO (X71)
				MethodEval (X23)

		Program SLO (X72)
				Competency (X43)

		Content (X19)
				SLO (X18)
				Competency (X43)
		*/

		//Logger logger = Logger.getLogger("test");

		boolean deletable = false;

		String sql = "";
		String table = "";
		String where = "";
		String where2 = "";
		PreparedStatement ps = null;
		ResultSet rs = null;

		try{
			if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
				table = "tblCourseLinked";
				where = "seq";
				where2 = "(dst='GESLO' OR dst='MethodEval')";

				sql = "SELECT historyid "
					+ "FROM " + table + " "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND " + where2 + " "
					+ "AND " + where + "=?";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,id);
				rs = ps.executeQuery();
				deletable = rs.next();
			}
			else if ((Constant.COURSE_OBJECTIVES).equalsIgnoreCase(src)){
				table = "tblCourseLinked";
				where = "seq";
				where2 = "(dst='GESLO' OR dst='MethodEval')";

				sql = "SELECT historyid "
					+ "FROM " + table + " "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND " + where2 + " "
					+ "AND " + where + "=?";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,id);
				rs = ps.executeQuery();
				deletable = rs.next();
			}
			else if ((Constant.COURSE_PROGRAM_SLO).equalsIgnoreCase(src)){
				table = "tblCourseLinked";
				where = "seq";
				where2 = "dst='Competency'";

				sql = "SELECT historyid "
					+ "FROM " + table + " "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND " + where2 + " "
					+ "AND " + where + "=?";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,src);
				ps.setInt(4,id);
				rs = ps.executeQuery();
				deletable = rs.next();
			}
			else if ((Constant.COURSE_CONTENT).equalsIgnoreCase(src)){

				//Constant.COURSE_OBJECTIVES
				table = "tblCourseContentSLO";
				where = "contentid";

				sql = "SELECT historyid "
					+ "FROM " + table + " "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND " + where + "=?";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setInt(3,id);
				rs = ps.executeQuery();
				deletable = rs.next();
				rs.close();
				ps.close();

				// if data not found in the above, check the next table.
				// for content, we have data in 2 different ways
				if (!deletable){
					///Constant.COURSE_COMPETENCIES
					table = "tblCourseLinked";
					where = "seq";
					where2 = "dst='Competency'";

					sql = "SELECT historyid "
						+ "FROM " + table + " "
						+ "WHERE campus=? "
						+ "AND historyid=? "
						+ "AND src=? "
						+ "AND " + where2 + " "
						+ "AND " + where + "=?";

					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,src);
					ps.setInt(4,id);
					rs = ps.executeQuery();
					deletable = rs.next();
				}
			}

			rs.close();
			ps.close();
		}
		catch( Exception ex ){
			logger.fatal("LinkerDB: isDeletable\n" + ex.toString());
		}

		// in above code, deletable is set to resultset. if result set is true, there is data
		// and when there is data, can't not delete. return negation to make this case.
		return !deletable;

	}

	/*
	 * deleteLinkedItems
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	src		String
	 *	@param	dst		String
	 *	@param	id			int
	 * <p>
	 *	@return boolean
	 */
	public static boolean deleteLinkedItems(Connection conn,String campus,String kix,String src,String dst,int id) throws SQLException {

		/*
		Competency (X43)
				GESLO (X71)
				MethodEval (X23)

		SLO (X18)
				GESLO (X71)
				MethodEval (X23)

		Program SLO (X72)
				Competency (X43)

		Content (X19)
				SLO (X18)
				Competency (X43)
		*/

		//Logger logger = Logger.getLogger("test");

		boolean deletable = false;

		String sql = "";
		String table = "";
		String where = "";
		String where2 = "";

		try{
			if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
				table = "tblCourseLinked";
				where = "seq";

				if (dst.equalsIgnoreCase("ALL")){
					where2 = "(dst='GESLO' OR dst='MethodEval')";
				}
				if (dst.equalsIgnoreCase(Constant.COURSE_GESLO)){
					where2 = "GESLO";
				}
				else if (dst.equalsIgnoreCase(Constant.COURSE_METHODEVALUATION)){
					where2 = "MethodEval";
				}
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
				table = "tblCourseLinked";
				where = "seq";

				if (dst.equalsIgnoreCase("ALL")){
					where2 = "(dst='GESLO' OR dst='MethodEval')";
				}
				if (dst.equalsIgnoreCase(Constant.COURSE_GESLO)){
					where2 = "GESLO";
				}
				else if (dst.equalsIgnoreCase(Constant.COURSE_METHODEVALUATION)){
					where2 = "MethodEval";
				}
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO)){
				table = "tblCourseLinked";
				where = "seq";

				if (dst.equalsIgnoreCase("ALL")){
					where2 = "dst='Competency'";
				}
				else if (dst.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
					where2 = "Competency";
				}
			}
			else if (src.equalsIgnoreCase(Constant.COURSE_CONTENT)){
				if (dst.equalsIgnoreCase(Constant.COURSE_OBJECTIVES)){
					table = "tblCourseContentSLO";
					where = "contentid";
				}
				else if (dst.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
					table = "tblCourseLinked";
					where = "seq";
					where2 = "Competency";
				}
			}

			if (table.equals("tblCourseLinked")){
				if ("ALL".equalsIgnoreCase(dst)){
					sql = "SELECT historyid "
						+ "FROM " + table + " "
						+ "WHERE campus=? "
						+ "AND historyid=? "
						+ "AND src=? "
						+ "AND " + where2 + " "
						+ "AND " + where + "=?";
				}
				else{
					sql = "SELECT historyid "
						+ "FROM " + table + " "
						+ "WHERE campus=? "
						+ "AND historyid=? "
						+ "AND src=? "
						+ "AND dst=? "
						+ "AND " + where + "=?";
				}
			}
			else{
				sql = "SELECT historyid "
					+ "FROM " + table + " "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND " + where + "=?";
			}

			PreparedStatement ps = conn.prepareStatement(sql);

			if (table.equals("tblCourseLinked")){
				if ("ALL".equalsIgnoreCase(dst)){
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,src);
					ps.setInt(4,id);
				}
				else{
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,src);
					ps.setString(4,where2);
					ps.setInt(5,id);
				}
			}
			else{
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setInt(3,id);
			}

			ResultSet rs = ps.executeQuery();
			deletable = rs.next();
			rs.close();
			ps.close();
		}
		catch( Exception ex ){
			logger.fatal("LinkerDB: isDeletable\n" + ex.toString());
		}

		// in above code, deletable is set to resultset. if result set is true, there is data
		// and when there is data, can't not delete. return negation to make this case.
		return !deletable;

	}

	/*
	 * getNextID
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 *	<p>
	 *	@return int
	 */
	public static int getNextID(Connection connection,String kix) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(id) + 1 AS maxid FROM tblCourseLinked "
				+ " WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");
			else
				id = 1;
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("LinkerServlet: getNextID\n" + e.toString());
		}

		return id;
	}

	/*
	 * synchronizeRefs
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 *	@return int
	 */
	public static boolean synchronizeRefs(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean success = false;

		// during mod and approval or where CUR goes to PRE and vice versa,
		// linked data is created but linked2 entries are not created correctly.
		// run this routine to preserve the reference to the ID field so
		// that it can be used to tie back to the original data

		try{
			int id = 0;
			int ref = 0;
			int rowsAffected = 0;

			String sql = "SELECT id,ref "
				+ "FROM tblCourseLinked "
				+ "WHERE campus=? "
				+ " AND historyid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				ref = NumericUtil.nullToZero(rs.getInt(2));

				sql = "UPDATE tblCourseLinked "
					+ "SET ref=? "
					+ "WHERE historyid=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ps.setString(2,kix);
				ps.setInt(3,id);
				rowsAffected = ps.executeUpdate();
				logger.info("LinkerDB: synchronizeRefs - " + rowsAffected + " rows set from Linked to Linked2");
			}
			rs.close();
			ps.close();

			success = true;

		} catch (SQLException ex) {
			success = false;
			logger.fatal("LinkerDB: synchronizeRefs (ex) - " + ex.toString());
		} catch (Exception e) {
			success = false;
			logger.fatal("LinkerDB: synchronizeRefs (e) - " + e.toString());
		}

		return success;
	}

	/*
	 * synchronizeLinkedItems
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 *	@return int
	 */
	public static boolean synchronizeLinkedItems(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean success = false;

		// after running synchronizeRefs, this routine
		// updates keys between the linked and linked2 table.
		try{
			int id = 0;
			int ref = 0;
			int rowsAffected = 0;

			String sql = "SELECT id,ref "
				+ "FROM tblCourseLinked "
				+ "WHERE campus=? "
				+ " AND historyid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt(1);
				ref = rs.getInt(2);

				sql = "UPDATE tblCourseLinked2 "
					+ "SET id=? "
					+ "WHERE historyid=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ps.setString(2,kix);
				ps.setInt(3,ref);
				rowsAffected = ps.executeUpdate();
				logger.info("LinkerDB: synchronizeLinkedItems - " + rowsAffected + " rows updated");
			}
			rs.close();
			ps.close();

			success = true;

		} catch (SQLException ex) {
			success = false;
			logger.fatal("LinkerDB: synchronizeLinkedItems (ex) - " + ex.toString());
		} catch (Exception e) {
			success = false;
			logger.fatal("LinkerDB: synchronizeLinkedItems (e) - " + e.toString());
		}

		return success;
	}

	/*
	* ENDS HERE
	*/

	/*
	 * getSelectedLinkedItem
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	src	String
	 *	@param	seq	int
	 *	<p>
	 * @return String
	 */
	public static String getSelectedLinkedItem(Connection conn,String kix,String src,String dst,int seq) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String selected = "";
		String dst2 = "";
		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"LinkerDB");

			if (debug) logger.info("LinkerDB.getSelectedLinkedItem - ENTER");

			if (dst != null && dst.length() > 0){
				if (dst.equals(Constant.COURSE_GESLO))
					dst2 = "GESLO";
				else if (dst.equals(Constant.COURSE_PROGRAM_SLO))
					dst2 = "PSLO";
				else if (dst.equals(Constant.COURSE_OBJECTIVES))
					dst2 = "Objectives";
				else if (dst.equals(Constant.COURSE_COMPETENCIES))
					dst2 = "Competency";
				else if (dst.equals(Constant.COURSE_CONTENT))
					dst2 = "Content";
				else if (dst.equals(Constant.COURSE_METHODEVALUATION))
					dst2 = "MethodEval";
			}

			String sql = "SELECT tl2.item AS item "
				+ "FROM tblCourseLinked tl, tblCourseLinked2 tl2 "
				+ "WHERE tl.historyid=tl2.historyid "
				+ "AND tl.id = tl2.id "
				+ "AND tl.historyid=? "
				+ "AND tl.src=? "
				+ "AND tl.dst=? "
				+ "AND tl.seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setString(3,dst);
			//ps.setString(4,dst2);
			ps.setInt(4,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (selected == null)
					selected = rs.getString("item");
				else
					selected = selected + "," + rs.getString("item");
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("LinkerDB: getSelectedLinkedItem - " + e.toString());
		}

		if (debug) logger.info("src: " + src);
		if (debug) logger.info("dst: " + dst);
		if (debug) logger.info("seq: " + seq);
		if (debug) logger.info("selected: " + selected);
		if (debug) logger.info("LinkerDB.getSelectedLinkedItem - EXIT");

		return selected;
	}

	/*
	 * isMaxtrixItemDeletable
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	src		String
	 *	@param	dst		String
	 *	@param	id			int
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMaxtrixItemDeletable(Connection conn,String campus,String kix,String src,int id) throws SQLException {

		/*
		Competency (X43)
				GESLO (X71)
				MethodEval (X23)

		SLO (X18)
				GESLO (X71)
				MethodEval (X23)

		Program SLO (X72)
				Competency (X43)

		Content (X19)
				SLO (X18)
				Competency (X43)
		*/

		//Logger logger = Logger.getLogger("test");

		boolean deletable = true;

		try{
			String sql = "SELECT historyid "
							+ "FROM vw_LinkedMatrix "
							+ "WHERE campus=? "
							+ "AND historyid=? "
							+ "AND src=? "
							+ "AND seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,src);
			ps.setInt(4,id);
			ResultSet rs = ps.executeQuery();
			deletable = rs.next();
			rs.close();
			ps.close();
		}
		catch(SQLException ex ){
			logger.fatal("LinkerDB: isMaxtrixItemDeletable - " + ex.toString());
		}
		catch(Exception ex ){
			logger.fatal("LinkerDB: isMaxtrixItemDeletable - " + ex.toString());
		}

		// in above code, deletable is set to resultset. if result set is true, there is data
		// and when there is data, can't not delete. return negation to make this case.
		return !deletable;

	}

	/*
	 * deleteLinkedItems
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	src		String
	 *	@param	id			int
	 * <p>
	 *	@return int
	 */
	public static int deleteLinkedItems(Connection conn,String campus,String kix,String src,int seq) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{
			String sql = "SELECT id,item "
						+ "FROM vw_LinkedMatrix "
						+ "WHERE historyid=? "
						+ "AND src=? "
						+ "AND seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setInt(3,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("id");
				int item = rs.getInt("item");

				sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND id=? AND item=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.setInt(2,id);
				ps2.setInt(3,item);
				ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM tblCourseLinked WHERE historyid=? AND src=? AND id=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.setString(2,src);
				ps2.setInt(3,id);
				ps2.executeUpdate();
				ps2.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex ){
			logger.fatal("LinkerDB: deleteLinkedItems - " + ex.toString());
		}
		catch(Exception ex ){
			logger.fatal("LinkerDB: deleteLinkedItems - " + ex.toString());
		}

		return rowsAffected;

	}

	public void close() throws SQLException {}

}
