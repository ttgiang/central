/*
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

//
// AnswerDB.java
//
package com.ase.aseutil.faq;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

import java.sql.*;
import java.util.*;

public class AnswerDB {

	static Logger logger = Logger.getLogger(AnswerDB.class.getName());

	public AnswerDB() throws Exception {}

	/**
	 * delete
	 */
	public static int delete(int lid) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					String sql = "DELETE FROM answers WHERE id=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setInt(1,lid);
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: delete - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: delete - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"AnswerDB.delete","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: delete - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * delete
	 */
	public static int delete(int lid,int seq) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					String sql = "DELETE FROM answers WHERE id=? AND seq=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setInt(1,lid);
					ps.setInt(2,seq);
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: delete - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: delete - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"AnswerDB.delete","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: delete - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * insert
	 */
	public static int insert(Answer answer) {

		int rowsAffected = 0;
		int score = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){

					// calculate score
					long daysBetween2Dates = DateUtility.daysBetween2Dates(new java.util.Date(answer.getAuditDate()),new java.util.Date());
					if (daysBetween2Dates <= 3)
						score = 3;
					else if (daysBetween2Dates <= 7)
						score = 2;
					else if (daysBetween2Dates <= 10)
						score = 1;
					else
						score = 0;

					String user = answer.getAuditBy();

					//
					// get faq information
					//
					String creator = "";
					boolean notify = false;
					Faq faq = FaqDB.getFaq(conn,answer.getId());
					if (faq != null){
						creator = faq.getAuditBy();
						notify = faq.getNotify();
					}

					//
					// answering your own question gets you 0
					//
					if(creator.equals(user)){
						score = 0;
					}

					//
					// sys admin is ananymous
					//

					//if (user.equals(Constant.SYSADM_NAME)){
					//	user = Constant.ANONYMOUS;
					//}

					String insertSQL = "INSERT INTO answers(id,answer,auditby,auditdate,score,campus,accepted) VALUES(?,?,?,?,?,?,?)";
					PreparedStatement ps = conn.prepareStatement(insertSQL);
					ps.setInt(1,answer.getId());
					ps.setString(2,answer.getAnswer());
					ps.setString(3,user);
					ps.setString(4,answer.getAuditDate());
					ps.setInt(5,score);
					ps.setString(6,answer.getCampus());
					ps.setInt(7,0);
					rowsAffected = ps.executeUpdate();
					ps.close();

					if (notify){
						String content = "Following are responses to your CC question. "
										+ Html.BR()
										+ "<h3><u>Question</u></h3>"
										+ faq.getQuestion()
										+ Html.BR()
										+ "<h3><u>Answer</u></h3>"
										+ answer.getAnswer();

						Mailer mailer = new Mailer();
						mailer.setCampus(answer.getCampus());
						mailer.setAlpha("CC Answer");
						mailer.setNum("");
						mailer.setFrom(answer.getAuditBy());
						mailer.setTo(creator);
						mailer.setContent(content);
						mailer.setSubject("CC Answer is available for review");
						mailer.setPersonalizedMail(true);
						MailerDB mailerDB = new MailerDB(conn,mailer);
					} // notify
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: insert - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: insert - " + ex.toString());
		} finally{

			try{
				connectionPool.freeConnection(conn,"AnswerDB.insert","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: insert - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/**
	 * update
	 */
	public static int update(Answer answer) {

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					String insertSQL = "UPDATE answers SET answer=?,auditdate=? WHERE id=? AND seq=?";
					PreparedStatement ps = conn.prepareStatement(insertSQL);
					ps.setString(1,answer.getAnswer());
					ps.setString(2,AseUtil.getCurrentDateTimeString());
					ps.setInt(3,answer.getId());
					ps.setInt(4,answer.getSeq());
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: update - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: update - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"AnswerDB.update","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: update - " + e.toString());
			}
		}

		return rowsAffected;
	}

	/*
	 * countAnswers - how many answers for a FAQ
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return int
	 */
	public static int countAnswers(Connection conn,int id) throws Exception {

		int answer = 0;

		try {
			String sql = "SELECT count(seq) AS counter FROM answers WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				answer = rs.getInt("counter");
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("AnswerDB: countAnswers - " + e.toString());
		}

		return answer;
	}

	/*
	 * getAnswers
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getAnswers(Connection conn,int id) {

		String sql = "SELECT a.id, a.seq, a.answer, a.score, a.accepted, a.auditdate, a.auditby, a.campus, u.webURL "
				+ "FROM answers AS a LEFT OUTER JOIN tblUsers u ON a.auditby = u.userid WHERE (a.id = ?) ORDER BY a.auditdate";


		ArrayList<Answer> list = null;

		Answer answer = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<Answer>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				answer = new Answer();

				answer.setId(rs.getInt("id"));
				answer.setSeq(rs.getInt("seq"));
				answer.setScore(rs.getInt("score"));
				answer.setAccepted(rs.getBoolean("accepted"));
				answer.setAnswer(AseUtil.nullToBlank(rs.getString("answer")));
				answer.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				answer.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				answer.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				answer.setProfile(AseUtil.nullToBlank(rs.getString("weburl")));

				list.add(answer);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("AnswerDB: getAnswers - " + e.toString());
		}

		return list;
	}

	/**
	 * bestAnswer
	 */
	public static int bestAnswer(Answer answer) {

		int rowsAffected = 0;
		int answeredSeq = -1;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){

				conn = connectionPool.getConnection();

				if (conn != null){
					String answeredBy = answer.getAuditBy();

					// set the accepted answer as true for the best answer
					String sql = "UPDATE answers SET accepted=1,auditdate=?,auditby=? WHERE id=? AND seq=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,AseUtil.getCurrentDateTimeString());
					ps.setString(2,answeredBy);
					ps.setInt(3,answer.getId());
					ps.setInt(4,answer.getSeq());
					rowsAffected = ps.executeUpdate();
					ps.close();

					answeredSeq = answer.getSeq();

					// set the FAQ to the answer seq that was accepted as best
					sql = "UPDATE faq SET answeredseq=?,auditdate=?,auditby=? WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,answeredSeq);
					ps.setString(2,AseUtil.getCurrentDateTimeString());
					ps.setString(3,answeredBy);
					ps.setInt(4,answer.getId());
					rowsAffected = ps.executeUpdate();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: bestAnswer - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: bestAnswer - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"AnswerDB.bestAnswer","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: bestAnswer - " + e.toString());
			}
		}

		return rowsAffected;
	}


	/**
	 * getScore
	 */
	public static int getScore(String user) {

		int score = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try {
			connectionPool = AsePool.getInstance();

			if (connectionPool != null){
				conn = connectionPool.getConnection();

				if (conn != null){
					// set the accepted answer as true for the best answer
					String sql = "SELECT auditby, SUM(score) AS totalScore FROM answers "
									+ "WHERE accepted=1 AND auditby=? GROUP BY auditby";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,user);
					ResultSet rs = ps.executeQuery();
					if (rs.next()){
						score = rs.getInt("totalScore");
					}
					rs.close();
					ps.close();
				} // conn != null
			} // connectionPool

		} catch (SQLException e) {
			logger.fatal("AnswerDB: getScore - " + e.toString());
			return 0;
		} catch (Exception ex) {
			logger.fatal("AnswerDB: getScore - " + ex.toString());
		} finally{
			try{
				connectionPool.freeConnection(conn,"AnswerDB.getScore","SYSADM");
			}
			catch(Exception e){
				logger.fatal("AnswerDB: getScore - " + e.toString());
			}
		}

		return score;
	}

	/*
	 * getScores
	 * <p>
	 * @param	conn	Connection
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getScores(Connection conn) {

		String sql = "SELECT auditby, SUM(score) AS totalScore FROM answers "
						+ "WHERE accepted=1 GROUP BY auditby ORDER BY sum(score)";

		ArrayList<Answer> list = null;

		Answer answer = null;

		try {
			list = new ArrayList<Answer>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				answer = new Answer();
				answer.setScore(rs.getInt("totalScore"));
				answer.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));
				list.add(answer);
			}

			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("AnswerDB: getScores - " + e.toString());
		}

		return list;
	}

	/*
	 * getBestAnswerSeq
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return 	int
	 */
	public static int getBestAnswerSeq(Connection conn,int id) {

		int seq = 0;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT answeredseq FROM faq WHERE id=? AND answeredseq > 0");
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				seq = rs.getInt("answeredseq");;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("AnswerDB: getBestAnswerSeq - " + e.toString());
		}

		return seq;
	}

	/*
	 * getPreviewAnswer
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 *	<p>
	 *	@return 	String
	 */
	public static String getPreviewAnswer(Connection conn,int id) {

		String answer = "";

		try {
			String sql = "";

			int answeredseq = getBestAnswerSeq(conn,id);

			if(answeredseq > 0){
				sql = "SELECT answer FROM answers WHERE id=? AND seq=?";
			}
			else{
				sql = "SELECT answer FROM answers WHERE id=? AND (seq = "
					+ "(SELECT MIN(seq) AS minseq FROM answers AS answers_1 WHERE id=?))";
			}

			AseUtil aseUtil = new AseUtil();

			PreparedStatement ps = conn.prepareStatement(sql);
			if(answeredseq > 0){
				ps.setInt(1,id);
				ps.setInt(2,answeredseq);
			}
			else{
				ps.setInt(1,id);
				ps.setInt(2,id);
			}
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				answer = AseUtil.nullToBlank(rs.getString("answer"));
				if(answer.length() > 200){
					answer = answer.substring(0,199) + "...";
				}
			}
			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("AnswerDB: getPreviewAnswer - " + e.toString());
		}

		return answer;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}