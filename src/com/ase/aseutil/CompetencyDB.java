/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 *	public static Msg addRemoveCompetency(connection,action,campus,alpha,num,content,id,user,kix)
 *	public static int deleteCompetencies(Connection conn,String campus,String kix) throws SQLException {
 * public static String getCompetenciesAsHTMLList(Connection connection,String kix,boolean detail) throws Exception
 * public static String getCompetenciesForReview(Connection connection,String kix,String src,String dst)
 *	public static ArrayList getCompetencyListByKix(Connection connection,String kix)
 *	public static String getSelectedSLOs(Connection conn,String kix,String contentid) throws Exception {
 *	public static int updateCompetency(Connection conn,String campus,String kix,String comp) throws SQLException {
 *
 * void close () throws SQLException{}
 *
 */

//
// CompetencyDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class CompetencyDB {
	static Logger logger = Logger.getLogger(CompetencyDB.class.getName());

	public CompetencyDB() throws Exception {}

	/*
	 * addRemoveCompetency
	 * <p>
	 * @param	connection
	 * @param	action
	 * @param	campus
	 * @param	alpha
	 * @param	num
	 * @param	content
	 * @param	id
	 * @param	user
	 * @param	kix
	 * <p>
	 * @return Msg
	 */
	public static Msg addRemoveCompetency(Connection connection,
														String action,
														String campus,
														String alpha,
														String num,
														String content,
														int id,
														String user,
														String kix) throws SQLException {

		int rowsAffected = 0;
		Msg msg = new Msg();
		String insertSQL = "INSERT INTO tblCourseCompetency(campus,coursealpha,coursenum,coursetype,content,auditby,historyid,rdr,auditdate,seq) VALUES(?,?,?,?,?,?,?,?,?,?)";
		String removeSQL = "DELETE FROM tblCourseCompetency WHERE historyid=? AND seq=?";
		String updateSQL = "UPDATE tblCourseCompetency SET content=?,auditby=?,auditdate=? WHERE historyid=? AND seq=?";
		PreparedStatement ps;
		String type = "";
		int compNextID = 0;

		try {
			String sql = "";
			boolean nextStep = true;

			/*
			 * for add mode, don't add if already there. for remove, just
			 * proceed
			 * during edit, always course type of PRE
			 */
			if ("a".equals(action)) {
				if (id>0)
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
					if (id>0){
						//AseUtil.loggerInfo(kix + " - " + user + " - CompetencyDB: addRemoveCompetency - deleted assessments",campus,user,alpha,num);
					}	// thisComp
				}	// r

				ps = connection.prepareStatement(sql);
				if ("a".equals(action)){
					if (id>0){
						ps.setString(1,content);
						ps.setString(2,user);
						ps.setString(3,AseUtil.getCurrentDateTimeString());
						ps.setString(4,kix);
						ps.setInt(5,id);
					}
					else{
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
						ps.setString(5,content);
						ps.setString(6,user);
						ps.setString(7,kix);
						ps.setInt(8,getNextRDR(connection,kix));
						ps.setString(9,AseUtil.getCurrentDateTimeString());
						ps.setInt(10,getNextSeq(connection,kix));
					}
				}
				else if ("r".equals(action)){
					ps.setString(1,kix);
					ps.setInt(2,id);
				}

				rowsAffected = ps.executeUpdate();
				ps.close();

				//AseUtil.loggerInfo(kix + " - " + user + " - CompetencyDB: addRemoveCompetency ", campus,action,alpha + " " + num,user);

				msg.setMsg("Content saved successfully");
				if ("a".equals(action))
					msg.setCode(rowsAffected);
				else
					msg.setCode(0);
			}
		} catch (SQLException e) {
			msg.setMsg("Exception");
			logger.fatal(kix + " - " + user + " - CompetencyDB: addRemoveCompetency - " + e.toString());
		} catch (Exception ex) {
			msg.setMsg("Exception");
			logger.fatal(kix + " - " + user + " - CompetencyDB: addRemoveCompetency\n" + ex.toString());
		}

		return msg;
	}

	/*
	 * getCompetenciesAsHTMLList
	 *	<p>
	 * @param	connection	Connection
	 * @param	kix			String
	 * @param	detail		boolean
	 * @param	useTable		boolean
	 *	<p>
	 * @return String
	 */
	public static String getCompetenciesAsHTMLList(Connection conn,String kix,boolean detail)  {

		boolean useTable = true;

		return  getCompetenciesAsHTMLList(conn,kix,detail,useTable);
	}

	public static String getCompetenciesAsHTMLList(Connection conn,String kix,boolean detail,boolean useTable)  {

		//Logger logger = Logger.getLogger("test");

		String sql;
		StringBuffer comps = new StringBuffer();
		boolean found = false;
		String temp = "";
		String content = "";
		int seq = 0;

		sql = "SELECT seq, content FROM tblCourseCompetency WHERE historyid=? ORDER BY rdr";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				found = true;
				seq = rs.getInt("seq");

				if (detail){
					comps.append(LinkerDB.getLinkedOutlineCompentency(conn,kix,seq));
				}
				else{
					content = rs.getString("content");
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
						"<tr><td><ul>" + comps.toString() + "</ul></td></tr></table>";
				}
				else{
					temp = "<ul>" + comps.toString() + "</ul>";
				}

			} // found

		} catch (Exception e) {
			logger.fatal("CompetencyDB: getCompetenciesAsHTMLList - " + e.toString());
		}

		return temp;
	}

	/*
	 * getCompetenciesForReview
	 *	<p>
	 *	@parm	conn	Connection
	 *	@parm	kix	String
	 *	@parm	src	String
	 *	@parm	dst	String
	 *	<p>
	 *	@return String
	 *	<p>
	 */
	public static String getCompetenciesForReview(Connection connection,
																	String kix,
																	String src,
																	String dst) throws Exception {

		String sql = "SELECT campus,seq,auditby,auditdate,content " +
						"FROM tblCourseCompetency " +
						"WHERE historyid=? " +
						"ORDER BY rdr";

		StringBuffer buf = new StringBuffer();
		String addedBy = "";
		String addedDate = "";
		String content = "";
		String seq = "";
		String campus = "";

		String image1 = "reviews";
		String image2 = "reviews2";
		String image3 = "reviews3";
		String image4 = "reviews4";

		String alpha = "";
		String num = "";
		String type = "";

		int iSeq = 0;

		try {
			AseUtil aseUtil = new AseUtil();

			buf.append("<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>");
			buf.append("<tr class=\"textblackTRTheme\">"
				+ "<td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;"
				+ "&nbsp;<a href=\"crsrdr.jsp?src="+Constant.COURSE_COMPETENCIES+"&dst="+Constant.COURSE_COMPETENCIES+"&ci="+Constant.COURSE_ITEM_COMPETENCIES+"&kix="+kix+"\"><img src=\"../images/ed_list_num.gif\" border=\"0\" alt=\"reorder list\" title=\"reorder list\"></a>&nbsp;</td>"
				+ "<td width=\"65%\" valign=\"top\" class=\"textblackTH\">Competency</td>"
				+ "<td width=\"15%\" valign=\"top\" class=\"textblackTH\" nowrap>Added By</td>"
				+ "<td width=\"15%\" valign=\"top\" align=\"right\" class=\"textblackTH\">Added Date</td></tr>");

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				campus = aseUtil.nullToBlank(rs.getString("campus"));
				content = aseUtil.nullToBlank(rs.getString("content"));
				seq = aseUtil.nullToBlank(rs.getString("seq"));
				addedBy = aseUtil.nullToBlank(rs.getString("auditby"));
				addedDate = aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME);

				iSeq = Integer.parseInt(seq);

				buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
					"<img src=\"../images/edit.gif\" border=\"0\" title=\"edit competency\" alt=\"edit competency\" id=\"editCompetency\" onclick=\"return aseSubmitClick3('"+kix+"','"+src+"','"+dst+"',"+seq+");\">&nbsp;&nbsp;" +
					"<img src=\"../images/del.gif\" border=\"0\" title=\"delete competency\" alt=\"delete competency\" id=\"deleteCompetency\" onclick=\"return aseSubmitClick2('"+kix+"','"+src+"','"+dst+"',"+seq+");\">" +
					"</td><td valign=\"top\" class=\"datacolumn\">" + content + "</td>" +
					"<td valign=\"top\" class=\"datacolumn\" nowrap>" + addedBy + "</td>" +
					"<td valign=\"top\" align=\"right\" class=\"datacolumn\" nowrap>" + addedDate + "</td></tr>");

					//"<img src=\"../images/"+image1+".gif\" border=\"0\" title=\"link GenED\" alt=\"link GenED\" id=\"linkGenED\" onclick=\"return aseSubmitClick0('"+kix+"','"+src+"','GESLO',"+seq+");\">&nbsp;&nbsp;" +
					//"<img src=\"../images/"+image2+".gif\" border=\"0\" title=\"link evaluation\" alt=\"link evaluation\" id=\"linkEvaluation\" onclick=\"return aseSubmitClick0('"+kix+"','"+src+"','MethodEval',"+seq+");\">&nbsp;&nbsp;" +
					//"<img src=\"../images/"+image3+".gif\" border=\"0\" title=\"link Program SLO\" alt=\"link Program SLO\" id=\"linkPSLO\" onclick=\"return aseSubmitClick0('"+kix+"','"+src+"','PSLO',"+seq+");\">&nbsp;&nbsp;" +
					//"<img src=\"../images/"+image4+".gif\" border=\"0\" title=\"link Course SLO\" alt=\"link Course SLO\" id=\"linkSLO\" onclick=\"return aseSubmitClick4('"+kix+"','"+src+"','SLO',"+seq+");\">&nbsp;&nbsp;" +
			}

			buf.append("</table>");

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: getCompetenciesForReview - " + e.toString());
			return null;
		}

		return buf.toString();
	}

	/*
	 * getCompetencyByID
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 *	<p>
	 *	@return 	String
	 */
	public static String getCompetencyByID(Connection conn,String kix,int id) throws Exception {

		String content = "";

		try {
			String sql = "SELECT content "
				+ "FROM tblCourseCompetency "
				+ "WHERE historyid=? AND "
				+ "seq=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				content = aseUtil.nullToBlank(rs.getString("content")).trim();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: getCompetencyByID - " + e.toString());
		}

		return content;
	}


	/*
	 * getContentByID
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 *	<p>
	 *	@return 	String
	 */
	public static String getContentByID(Connection conn,String kix,int id) throws Exception {

		String content = "";

		try {
			String sql = "SELECT content "
				+ "FROM tblCourseCompetency "
				+ "WHERE historyid=? AND "
				+ "seq=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				content = aseUtil.nullToBlank(rs.getString("content")).trim();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: getContentByID - " + e.toString());
		}

		return content;
	}

	/*
	 * deleteCompetency
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 *	<p>
	 *	@return int
	 */
	public static int deleteCompetency(Connection connection,String kix,int id) {

		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblCourseCompetency WHERE historyid=? AND seq=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
			logger.info(kix + " - CompetencyDB: deleteCompetency - SEQ: " + id);
		} catch (SQLException e) {
			logger.fatal("CompetencyDB: deleteCompetency - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getCompetencyListByKix
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getCompetencyListByKix(Connection connection,String kix) {

		ArrayList<Competency> list = new ArrayList<Competency>();
		Competency competency;

		try {
			String sql = "SELECT seq,content FROM tblCourseCompetency WHERE historyid=?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				competency = new Competency();
				competency.setSeq(rs.getInt(1));
				competency.setContent(rs.getString(2).trim());
				list.add(competency);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: getCompetencyListByKix - " + e.toString());
			return null;
		}

		return list;
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid "
				+ " FROM tblCourseCompetency "
				+ " WHERE historyid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompetencyDB: getNextRDR - " + e.toString());
		}

		return id;
	}

	/*
	 * getNextSeq
	 *	<p>
	 *	@param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextSeq(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int id = 1;

		try {
			String sql = "SELECT MAX(seq) + 1 AS maxid "
				+ " FROM tblCourseCompetency "
				+ " WHERE historyid=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompetencyDB: getNextSeq - " + e.toString());
		}

		return id;
	}

	/*
	 * updateCompetency
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	kix			String
	 *	@param	comp			String
	 *	<p>
	 *	@return int
	 */
	public static int updateCompetency(Connection conn,String kix,String comp) throws SQLException {

		int rowsAffected = -1;
		String sql = "UPDATE tblCourse "
			+ "SET " + Constant.COURSE_COMPETENCIES + "=? "
			+ "WHERE historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,comp);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: updateCompetency - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * deleteCompetencies
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 *	@param	kix			String
	 */
	public static void deleteCompetencies(Connection conn,String campus,String kix) throws SQLException {

		int rowsAffected = 0;
		String sql = "DELETE FROM tblCourseCompetency "
			+ "WHERE campus=? AND "
			+ "historyid=?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: deleteCompetencies - " + e.toString());
		}
	}

	/*
	 * getSelectedSLOs
	 *	<p>
	 *	@param	connection	Connection
	 *	@param	kix			String
	 *	@param	contentid	String
	 *	<p>
	 * @return String
	 */
	public static String getSelectedSLOs(Connection conn,String kix,String contentid) throws Exception {

		String selected = "";

		String sql = "SELECT compid "
			+ "FROM vw_Linked2SLO "
			+ "WHERE historyid=? "
			+ "AND linkedseq=?";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,contentid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (selected == null)
					selected = rs.getString(1);
				else
					selected = selected + "," + rs.getString(1);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("CompetencyDB: getSelectedSLOs - " + e.toString());
		}

		return selected;
	}

	/**
	 * copyCompentency
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	alpha
	 * @param	num
	 * @param	user
	 * @param	id
	 * <p>
	 * @return	int
	 */
	public static int copyCompentency(Connection conn,
													String kixOld,
													String kixNew,
													String alpha,
													String num,
													String user,
													int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int nextID = 0;

		boolean debug = false;

		String src = Constant.COURSE_COMPETENCIES;
		String campus = "";

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"CompetencyDB");

			if (debug) logger.info(kixNew + " - COMPETENCYDB INSERTCOMP - STARTS");

			String sql = "INSERT INTO tblCourseCompetency(campus,coursealpha,coursenum,coursetype,content,auditby,historyid,rdr,auditdate,seq) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?)";

			Competency competency = getCompetencyByKixID(conn,kixOld,id);

			if (competency != null){

				// competency copy needs to reuse id.
				//nextID = CompetencyDB.getNextSeq(conn,kixNew);

				campus = competency.getCampus();

				String[] info2 = Helper.getKixInfo(conn,kixNew);
				String toCampus = info2[Constant.KIX_CAMPUS];

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,toCampus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,type);
				ps.setString(5,competency.getContent());
				ps.setString(6,user);
				ps.setString(7,kixNew);
				ps.setInt(8, CompetencyDB.getNextRDR(conn,kixNew));
				ps.setString(9,AseUtil.getCurrentDateTimeString());
				ps.setInt(10, id);
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug) logger.info(kixNew + " - competency copied");

				rowsAffected = LinkedUtil.copyLinked(conn,campus,user,type,kixOld,kixNew,src,id,id);
			}

			if (debug) logger.info(kixNew + " - COMPETENCYDB INSERTCOMP - ENDS");

		} catch (SQLException e) {
			logger.fatal("CompetencyDB: copyCompentency - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompetencyDB: copyCompentency - " + ex.toString());
		}

		return rowsAffected;
	}

	/*
	 * getCompetencyByKixID
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	compid
	 * <p>
	 * @return	Comp
	 */
	public static Competency getCompetencyByKixID(Connection conn,String kix,int compid) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Competency competency = null;

		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"CompetencyDB");

			if (debug) logger.info("COMPETENCYDB GETCOMPETENCYBYKIXID - STARTS");

			String sql = "SELECT * FROM tblCourseCompetency WHERE historyid=? AND seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,compid);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if (debug) logger.info(kix + " - competency found");

				competency = new Competency();
				competency.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
				competency.setSeq(compid);
				competency.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				competency.setCourseAlpha(AseUtil.nullToBlank(rs.getString("CourseAlpha")));
				competency.setCourseNum(AseUtil.nullToBlank(rs.getString("Coursenum")));
				competency.setCourseType(AseUtil.nullToBlank(rs.getString("Coursetype")));
				competency.setContent(AseUtil.nullToBlank(rs.getString("content")));
				competency.setRdr(rs.getInt("rdr"));
			}
			else{
				if (debug) logger.info(kix + " - comp not found");
			}
			rs.close();
			ps.close();

			if (debug) logger.info("COMPETENCYDB GETCOMPETENCYBYKIXID - ENDS");

		} catch (SQLException e) {
			logger.fatal("CompetencyDB: getCompetencyByKixID - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("CompetencyDB: getCompetencyByKixID - " + ex.toString());
		}

		return competency;
	}

	/*
	 * getCompetencyByKixID
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	compid
	 * <p>
	 * @return	Comp
	 */
	public static String showCompetencies(Connection conn,
														String campus,
														String user,
														String reportName,
														String progress,
														boolean hasData){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String alpha = "";
		String alphaIdx = "";
		String holdIdx = "";
		String holdAlpha = "";
		String num = "";
		String title = "";
		String type = "";
		String comp = "";
		String bookmark = "";
		String savedBookmark = "";
		String line = "";
		boolean found = false;

		boolean append = false;

		String temp = "";

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = SQL.showCompetencies(hasData);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			if(hasData){
				ps.setString(3,campus);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle")).toUpperCase();
				comp = AseUtil.nullToBlank(rs.getString(Constant.COURSE_COMPETENCIES));
				comp = AseUtil2.removeHTMLTags(comp,-1);

				temp = comp;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = comp.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");
				} // has data

				bookmark = "";
				line = "";

				alphaIdx = alpha.substring(0,1);

				// display letters for quick jump
				if (!holdIdx.equals(alphaIdx)){

					if (!holdIdx.equals(Constant.BLANK)){
						bookmark = "</ul>";
					}

					holdIdx = alphaIdx;

					bookmark += "<table width=\"50%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr bgcolor=#e1e1e1>"
						+ "<td width=\"50%\"><a id=\"" + alphaIdx + "\" name=\"" + alphaIdx + "\" class=\"linkcolumn\">[" + alphaIdx + "]</a></td>"
						+ "<td width=\"50%\" align=\"right\"><a href=\"#top\" class=\"linkcolumn\">back to top</a></td>"
						+ "</tr></table>";

					bookmark += "<ul>";

				}

				// put a blank line between different ALPHAs in the same letter
				if (!holdAlpha.equals(alpha)){
					holdAlpha = alpha;
				}

				// determine how much to print
				if (hasData)
					line = "<li><a href=\"crsrpt.jsp?src=showComp&kix="
							+ kix
							+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";
				else
					line = "<li><a href=\"vwcrsx.jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&t=" + type
						+ "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>";

				// do we print or not
				if (append){
					if (!savedBookmark.equals(Constant.BLANK)){
						bookmark = savedBookmark;
					}

					listing.append(bookmark + line);

					savedBookmark = "";
				}
				else{
					// when the index changes and we don't print, we save the content and
					// print the next time around.
					savedBookmark = bookmark;
				}

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				comp = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td align=\"center\">"
					+ Helper.drawAlphaIndexBookmark(0,reportName)
					+ "</td></tr>"
					+ "<tr><td>"
					+ listing.toString()
					+ "</td></tr>"
					+ "</table>";
			}
			else
				comp = "";
		}
		catch(Exception ex){
			logger.fatal("CompetencyDB: showCompetencies - " + ex.toString());
		}

		return comp;
	}

	/*
	 * getCompetencyByKixID
	 * <p>
	 * @param	conn
	 * @param	kix
	 * @param	compid
	 * <p>
	 * @return	Comp
	 */
	public void close() throws SQLException {}

}