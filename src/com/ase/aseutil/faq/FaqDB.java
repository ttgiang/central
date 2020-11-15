/*
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

//
// FaqDB.java
//
package com.ase.aseutil.faq;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

import java.sql.*;
import java.util.*;

public class FaqDB {

	static Logger logger = Logger.getLogger(FaqDB.class.getName());

	public FaqDB() throws Exception {}

	/**
	 * delete
	 */
	public static int delete(int id) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					String sql = "DELETE FROM faq WHERE id=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setInt(1,id);
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("FaqDB: delete - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("FaqDB: delete - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"FaqDB.delete","SYSADM");

			}
			catch(Exception e){
				logger.fatal("FaqDB: delete - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * insert
	 */
	public static int insert(Faq faq) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){

					String user = faq.getAuditBy();

					//if (user.equals(Constant.SYSADM_NAME)){
					//	user = Constant.ANONYMOUS;
					//}

					String insertSQL = "INSERT INTO faq(campus,question,auditby,auditdate,category,answeredseq,notify,askedby) VALUES(?,?,?,?,?,?,?,?)";
					PreparedStatement ps = conn.prepareStatement(insertSQL);
					ps.setString(1,faq.getCampus());
					ps.setString(2,faq.getQuestion());
					ps.setString(3,user);
					ps.setString(4,faq.getAuditDate());
					ps.setString(5,faq.getCategory());
					ps.setInt(6,0);
					ps.setBoolean(7,faq.getNotify());
					ps.setString(8,user);
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("FaqDB: insert - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("FaqDB: insert - " + ex.toString());
		} finally{

			try{
				connectionPool.freeConnection(conn,"FaqDB.insert","SYSADM");
			}
			catch(Exception e){
				logger.fatal("FaqDB: insert - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * update
	 */
	public static int update(Faq faq) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					String insertSQL = "UPDATE faq SET question=?,auditdate=? WHERE id=?";
					PreparedStatement ps = conn.prepareStatement(insertSQL);
					ps.setString(1,faq.getQuestion());
					ps.setString(2,AseUtil.getCurrentDateTimeString());
					ps.setInt(3,faq.getId());
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("FaqDB: update - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("FaqDB: update - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"FaqDB.update","SYSADM");
			}
			catch(Exception e){
				logger.fatal("FaqDB: update - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/*
	 * getFaq
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return Faq
	 */
	public static Faq getFaq(Connection conn,int id) {

		Faq faq = null;

		try {
			String sql = "SELECT campus,question,auditDate,auditBy,answeredSeq,category,notify,askedby FROM faq WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();

				faq = new Faq();

				faq.setId(id);
				faq.setAnsweredSeq(rs.getInt("answeredSeq"));
				faq.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				faq.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				faq.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				faq.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				faq.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				faq.setNotify(rs.getBoolean("notify"));
				faq.setAskedby(AseUtil.nullToBlank(rs.getString("askedby")));

				aseUtil = null;
			}

			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("FaqDB: getFaq - " + e.toString());
		}

		return faq;
	}

	/*
	 * getFaqs
	 * <p>
	 * @param	conn		Connection
	 * @param	answered	boolean
	 * @param	category	String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getFaqs(Connection conn,boolean answered,String category) {

		String sql = "";

		// answerseq contains the sequence number from the answer table corresponding
		// to the best answer.
		if (answered){
			sql = "SELECT id,campus,question,auditDate,auditBy,category,answeredseq,askedby "
						+ "FROM faq "
						+ "WHERE answeredseq > 0 ";
		}
		else{
			sql = "SELECT id,campus,question,auditDate,auditBy,category,answeredseq,askedby "
						+ "FROM faq "
						+ "WHERE answeredseq < 1 ";
		}

		if (category != null && category.length() > 0){
			sql = sql + "AND category=?";
		}

		sql = sql + "ORDER BY auditdate DESC";

		ArrayList<Faq> list = null;

		Faq faq = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<Faq>();

			PreparedStatement ps = conn.prepareStatement(sql);
			if (category != null && category.length() > 0){
				ps.setString(1,category);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				faq = new Faq();

				faq.setId(rs.getInt("id"));
				faq.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				faq.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				faq.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				faq.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				faq.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				faq.setAnsweredSeq(rs.getInt("answeredseq"));
				faq.setAskedby(AseUtil.nullToBlank(rs.getString("askedby")));

				list.add(faq);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("FaqDB: getFaqs - " + e.toString());
		}

		return list;
	}

	/*
	 * searchFaqs
	 * <p>
	 * @param	conn	Connection
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList searchFaqs(Connection conn,String search) {

		// do a union to collect all matching questions and answers
		// from the union, weed out distinct IDs so we don't list dups
		// from the distinct IDs, select all FAQs to display

		search = "%" + search + "%";

		String sql = "SELECT id,campus,question,auditDate,auditBy,category,notify,askedby "
					+ "FROM faq "
					+ "WHERE ID IN "
					+ "( "
					+ "SELECT distinct ID  "
					+ "FROM ( "
					+ "SELECT id,campus,SUBSTRING(question, 1, 1000) AS question,auditDate,auditBy,askedby "
					+ "FROM faq "
					+ "WHERE (question LIKE ?) "
					+ "UNION "
					+ "SELECT id,'' as campus,SUBSTRING(answer, 1, 1000) AS question,auditDate,auditBy,'' as askedby "
					+ "FROM answers "
					+ "WHERE answer LIKE ? "
					+ ") AS tbl "
					+ ")";

		ArrayList<Faq> list = null;

		Faq faq = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<Faq>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,search);
			ps.setString(2,search);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				faq = new Faq();

				faq.setId(rs.getInt("id"));
				faq.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				faq.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				faq.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				faq.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				faq.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				faq.setNotify(rs.getBoolean("notify"));
				faq.setAskedby(AseUtil.nullToBlank(rs.getString("askedby")));

				list.add(faq);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("FaqDB: searchFaqs - " + e.toString());
		}

		return list;
	}

	/*
	 * searchFaqs
	 * <p>
	 * @param	conn	Connection
	 *	<p>
	 *	@return ArrayList
	 */
	public static String searchFaqs(Connection conn,String user,String srch,boolean mine) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer rtn = new StringBuffer();

		try {

			ArrayList list = null;

			String sql = "";
			if(mine){
				sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq WHERE askedby=? GROUP BY category";
			}
			else{
				sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq WHERE answeredseq>1 GROUP BY category";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			if(mine){
				ps.setString(1,user);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				String category = AseUtil.nullToBlank(rs.getString("category"));

				rtn.append("<h3><a href=\"#\">"
									+ category
									+ "</a></h3>"
									+ "<div>");

				list = getSearchFaqs(conn,category,srch);

				if (list != null){
					rtn.append(writeOutput(conn,user,list,srch));
				}

				rtn.append("</div>");

			} // while
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("FaqDB: getCategoryCountJQuery - " + e.toString());
		}

		return "<div id=\"accordion\">" + rtn.toString() + "</div>";

	}

	/*
	 * getSearchFaqs
	 * <p>
	 * @param	conn		Connection
	 * @param	answered	boolean
	 * @param	category	String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getSearchFaqs(Connection conn,String category,String srch) {

		//Logger logger = Logger.getLogger("test");

		// do a union to collect all matching questions and answers
		// from the union, weed out distinct IDs so we don't list dups
		// from the distinct IDs, select all FAQs to display

		srch = "%" + srch + "%";

		String sql = "SELECT faq.askedby, faq.id, faq.campus, faq.question, faq.auditdate, faq.auditby, faq.category, faq.notify, faq.answeredseq, tblUsers.weburl "
			+ "FROM faq LEFT OUTER JOIN tblUsers ON faq.auditby = tblUsers.userid "
			+ "WHERE (faq.id IN "
			+ "(SELECT DISTINCT id "
			+ "FROM (SELECT     id, campus, SUBSTRING(question, 1, 1000) AS question, auditdate, auditby, answeredseq "
			+ "FROM faq AS faq_1 "
			+ "WHERE (question LIKE '"+srch+"') "
			+ "UNION "
			+ "SELECT id, '' AS campus, SUBSTRING(answer, 1, 1000) AS question, auditdate, auditby, 0 AS answeredseq "
			+ "FROM answers "
			+ "WHERE (answer LIKE '"+srch+"')) AS tbl)) ";

		ArrayList<com.ase.aseutil.faq.Faq> list = null;

		com.ase.aseutil.faq.Faq faq = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<com.ase.aseutil.faq.Faq>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				faq = new com.ase.aseutil.faq.Faq();

				faq.setId(rs.getInt("id"));
				faq.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				faq.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				faq.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				faq.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				faq.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				faq.setAnsweredSeq(rs.getInt("answeredseq"));
				faq.setNotify(rs.getBoolean("notify"));
				faq.setProfile(AseUtil.nullToBlank(rs.getString("weburl")));
				faq.setAskedby(AseUtil.nullToBlank(rs.getString("askedby")));

				list.add(faq);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("FaqDB: getSearchFaqs - " + e.toString());
		}

		return list;
	}

	/*
	 * writeOutput
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return String
	 */
	public static String writeOutput(Connection conn,String user,ArrayList list) {

		return writeOutput(conn,user,list,"");
	}

	public static String writeOutput(Connection conn,String user,ArrayList list,String srch) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer rtn = new StringBuffer();

		int id = 0;
		int answers = 0;
		String clss= "";

		try {

			com.ase.aseutil.faq.Faq faq = null;

			boolean isCampAdm = SQLUtil.isCampusAdmin(conn,user);
			boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

			for (int i = 0; i<list.size(); i++){

				faq = (com.ase.aseutil.faq.Faq)list.get(i);

				id = faq.getId();
				String question = faq.getQuestion();
				String faqCampus = "logo" + faq.getCampus();
				String category = faq.getCategory();
				String faqCampusAlt = faqCampus;
				String auditDate = faq.getAuditDate();
				String auditBy = faq.getAuditBy();
				int answeredseq = faq.getAnsweredSeq();
				String profile = faq.getProfile();

				//
				// display appropriate image
				// uncomment if we don't want to show THANHG
				//
				/*
				if (auditBy.equals("ANONYMOUS") || SQLUtil.isSysAdmin(conn,auditBy)){
					faqCampus = "nocampus";
					faqCampusAlt = auditBy;
				}
				*/

				answers = com.ase.aseutil.faq.AnswerDB.countAnswers(conn,id);

				//
				// preview answers. returns best answer if available
				//
				String preview = "";
				if(answers>0){
					preview = com.ase.aseutil.faq.AnswerDB.getPreviewAnswer(conn,id);

					if(answeredseq > 0){
						if(preview.startsWith("<p>")){
							preview = "<p><img src=\"../../images/bestanswer.jpg\" width=\"20\" title=\"best answer\" alt=\"best answer\"></a>&nbsp;"
								+ preview.substring(3);
						}
						else{
							preview = "<img src=\"../../images/bestanswer.jpg\" width=\"20\" title=\"best answer\" alt=\"best answer\"></a>&nbsp;"
								+ preview;
						}
					}

					if(preview.startsWith("<p>")){
						preview = preview.replace("<p>","<p class=\"preview\">");
					}

				}

				//
				// profile
				//
				String profileImage = "";
				if(!profile.equals(Constant.BLANK)){
					profileImage = "\" src=\"/centraldocs/docs/profiles/" + profile + "\" width=\"48\" border=\"0\">";
				}
				else{
					profileImage = "\" src=\"../../images/logos/" + faqCampus + "" + ".jpg\" width=\"48\" border=\"0\">";
				}

				//
				// zebra output
				//
				if (i % 2 == 0){
					clss="even thread-even";
				}
				else{
					clss="odd thread-odd";
				}

				rtn.append("<div class=\"comment "
					+ clss
					+ " depth-1\" id=\""
					+ id
					+ "\">"
					+ "<div class=\"commentmet_data\" id=\""
					+ id
					+ "\">"
					+ "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">"
					+ "<tbody>"
					+ "<tr>"
					+ "<td colspan=\"2\">"
					+ "<div class=\"commentmetadata\">"
					+ "<span>"
					+ auditBy
					+ "</span> asked on "
					+ auditDate
					+ "."
					+ "</div>"
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td width=\"102\">"
					+ "<div class=\"commentmet_avatar\">"
					+ "<img class=\"avatar\" title=\""
					+ faqCampusAlt
					+ "\" alt=\""
					+ faqCampusAlt
					+ profileImage
					+ "</div>"
					+ "</td>"
					+ "<td width=\"90%\">"
					+ "<div class=\"commentmet_text\" id=\"comment\">"
					+ "<p class=\"question\">"
					+ question
					+ "</p>"
					+ "<p class=\"preview\">" + preview + "</p>"
					+ "<div class=\"commentmet_links\">"
					+ "<p>"
					+ "<a href=\"vwanswers.jsp?id=" + id + "&sr=" + srch + "&ba=0\" class=\"linkcolumn\">Provide an answer</a>"
					+ "&nbsp;&nbsp;<span class=\"copyright\">|</span>&nbsp;&nbsp;"
					+ "<a href=\"vwanswers.jsp?id=" + id + "&sr=" + srch + "&ba=0\" class=\"linkcolumn\">View all answers ("+ answers+ ")</a>");

				// delete only allowed to campus admin or above and when there is no best answer selected
				if ((isCampAdm || isSysAdm) && answeredseq < 1){
					rtn.append("&nbsp;&nbsp;<span class=\"copyright\">|</span>&nbsp;&nbsp;"
									+ "&nbsp;&nbsp;<a href=\"del.jsp?id="+id+"\" class=\"linkcolumn\">Delete Question</a>");
				}

				rtn.append("</p>"
					+ "</div>"
					+ "<div class=\"commentmet_replay\"></div>"
					+ "</div>"
					+ "</td>"
					+ "</tr>"
					+ "</tbody>"
					+ "</table>"
					+ "</div>"
					+ "</div><br>");

			} // for

		} catch (Exception e) {
			logger.fatal("FaqDB: getCategoryCountJQuery - " + e.toString());
		}

		return rtn.toString();
	}

	/*
	 * getCategoryCount
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return String
	 */
	public static String getCategoryCount(Connection conn,String answered) {

		StringBuffer rtn = new StringBuffer();
		String category = "";

		try {
			String sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq GROUP BY category";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				category = AseUtil.nullToBlank(rs.getString("category"));
				rtn.append("<li><a href=\"?cat="+category+"&a="+answered+"\" class=\"linkcolumn\">"
									+ category
									+ " ("+rs.getInt("counter")+")"
									+ "</a></li>");
			} // while
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("FaqDB: getCategoryCount - " + e.toString());
		}

		return "<ul>" + rtn.toString() + "</ul>";
	}

	/**
	 * getCreator
	 */
	public static String getCreator(Connection conn,int id) {

		String creator = "";

		try {
			String sql = "SELECT auditBy FROM faq WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				creator = AseUtil.nullToBlank(rs.getString("auditBy"));
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FaqDB: getCreator - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("FaqDB: getCreator - " + ex.toString());
		}

		return creator;
	}

	/*
	 * getCategoryCountJQuery
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return String
	 */
	public static String getCategoryCountJQuery(Connection conn,String user,String answered,boolean mine) {

		Logger logger = Logger.getLogger("test");

		StringBuffer rtn = new StringBuffer();

		try {

			ArrayList list = null;

			String sql = "";

			// when a question is pending, its answeredseq is 0; after an answer is given, the sequence is tied to
			// the answer seq.
			if(mine){
				sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq WHERE askedby=? GROUP BY category";
			}
			else{
				if (answered.equals(Constant.OFF)){
					sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq WHERE answeredseq=0 GROUP BY category";
				}
				else{
					sql = "SELECT DISTINCT category, COUNT(category) AS counter FROM faq WHERE answeredseq>1 GROUP BY category";
				}
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			if(mine){
				ps.setString(1,user);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				String category = AseUtil.nullToBlank(rs.getString("category"));

				rtn.append("<h3><a href=\"#\">"
									+ category
									+ " ("+rs.getInt("counter")+")"
									+ "</a></h3>"
									+ "<div>");

				list = getFaqsJQuery(conn,category,answered,mine,user);

				if (list != null){
					rtn.append(writeOutput(conn,user,list));
				}

				rtn.append("</div>");

			} // while
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("FaqDB: getCategoryCountJQuery - " + e.toString());
		}

		return "<div id=\"accordion\">" + rtn.toString() + "</div>";
	}

	/*
	 * getFaqsJQuery
	 * <p>
	 * @param	conn		Connection
	 * @param	answered	boolean
	 * @param	category	String
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getFaqsJQuery(Connection conn,String category,String answered,boolean mine,String  user) {

		String sql = "SELECT f.id, f.campus, f.question, f.auditdate, f.auditby, f.category, f.answeredseq, f.notify, u.weburl "
				+ "FROM faq f LEFT OUTER JOIN tblUsers u ON f.auditby = u.userid WHERE (f.category = ?)";

		if(mine){
			sql += "AND askedby=? ";
		}
		else{
			if (answered.equals(Constant.OFF)){
				sql += "AND answeredseq=0 ";
			}
			else{
				sql += "AND answeredseq>1 ";
			}
		}

		sql += "ORDER BY f.auditdate DESC";


		ArrayList<com.ase.aseutil.faq.Faq> list = null;

		Faq faq = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<Faq>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,category);
			if(mine){
				ps.setString(2,user);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				faq = new Faq();

				faq.setId(rs.getInt("id"));
				faq.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				faq.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				faq.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				faq.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				faq.setCategory(AseUtil.nullToBlank(rs.getString("category")));
				faq.setAnsweredSeq(rs.getInt("answeredseq"));
				faq.setNotify(rs.getBoolean("notify"));
				faq.setProfile(AseUtil.nullToBlank(rs.getString("weburl")));

				list.add(faq);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("FaqDB: getFaqsJQuery - " + e.toString());
		}

		return list;
	}

	public void close() throws SQLException {}

}