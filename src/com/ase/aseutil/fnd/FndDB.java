/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 */

//
// FndDB.java
//
package com.ase.aseutil.fnd;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ase.aseutil.ApproverDB;
import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.CampusDB;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Comp;
import com.ase.aseutil.CompDB;
import com.ase.aseutil.CourseApproval;
import com.ase.aseutil.CourseDB;
import com.ase.aseutil.DateUtility;
import com.ase.aseutil.DebugDB;
import com.ase.aseutil.DistributionDB;
import com.ase.aseutil.ForumDB;
import com.ase.aseutil.Generic;
import com.ase.aseutil.Html;
import com.ase.aseutil.Helper;
import com.ase.aseutil.HistoryDB;
import com.ase.aseutil.IniDB;
import com.ase.aseutil.MailerDB;
import com.ase.aseutil.MiscDB;
import com.ase.aseutil.Msg;
import com.ase.aseutil.NumericUtil;
import com.ase.aseutil.ReviewerDB;
import com.ase.aseutil.SQLUtil;
import com.ase.aseutil.SysDB;
import com.ase.aseutil.TaskDB;
import com.ase.aseutil.Util;
import com.ase.aseutil.WebSite;

public class FndDB {

	static Logger logger = Logger.getLogger(FndDB.class.getName());

	public FndDB() throws Exception {}

	/*
	 *
	 */
	public static int insertFnd(Connection conn, Fnd Fnd) {
		int rowsAffected = 0;
		try {
			String sql = "INSERT INTO tblfnditems (seq,en,qn,type,hallmark,explanatory,question,campus,auditby,fld) VALUES (?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Fnd.getSeq());
			ps.setInt(2, Fnd.getEn());
			ps.setInt(3, Fnd.getQn());
			ps.setString(4, Fnd.getType());
			ps.setString(5, Fnd.getHallmark());
			ps.setString(6, Fnd.getExplanatory());
			ps.setString(7, Fnd.getQuestion());
			ps.setString(8, Fnd.getCampus());
			ps.setString(9, Fnd.getAuditBy());
			ps.setString(10, Fnd.getType()+"_"+Fnd.getSeq()+"_"+Fnd.getEn()+"_"+Fnd.getQn());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 *
	 */
	public static int deleteFnd(Connection conn,String id) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblfnditems WHERE id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 *
	 */
	public static int updateFnd(Connection conn, Fnd Fnd) {
		int rowsAffected = 0;
		try {
			String sql = "UPDATE tblfnditems SET seq=?, en=?, qn=?, Type=?, hallmark=?, explanatory=?, question=?, campus=?, auditby=?, auditdate=?, fld=? WHERE id =?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Fnd.getSeq());
			ps.setInt(2, Fnd.getEn());
			ps.setInt(3, Fnd.getQn());
			ps.setString(4, Fnd.getType());
			ps.setString(5, Fnd.getHallmark());
			ps.setString(6, Fnd.getExplanatory());
			ps.setString(7, Fnd.getQuestion());
			ps.setString(8, Fnd.getCampus());
			ps.setString(9, Fnd.getAuditBy());
			ps.setString(10, Fnd.getAuditDate());
			ps.setString(11, Fnd.getType()+"_"+Fnd.getSeq()+"_"+Fnd.getEn()+"_"+Fnd.getQn());
			ps.setString(12, Fnd.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Fnd.insertFnd - " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * gethallmark
	 * <p>
	 * @return Fnd
	 */
	public static Fnd getHallmark(Connection conn,int id) throws Exception {

		String sql = "SELECT id,fld,seq,en,qn,type,campus,hallmark,explanatory,question,auditby,auditdate FROM tblfnditems WHERE id=?";
		Fnd Fnd = new Fnd();
		AseUtil aseUtil = new AseUtil();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, String.valueOf(id));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Fnd.setId(rs.getString("id").trim());
				Fnd.setFld(AseUtil.nullToBlank(rs.getString("fld")));
				Fnd.setSeq(rs.getInt("seq"));
				Fnd.setEn(rs.getInt("en"));
				Fnd.setQn(rs.getInt("qn"));
				Fnd.setType(AseUtil.nullToBlank(rs.getString("type")));
				Fnd.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				Fnd.setHallmark(AseUtil.nullToBlank(rs.getString("hallmark")));
				Fnd.setExplanatory(AseUtil.nullToBlank(rs.getString("explanatory")));
				Fnd.setQuestion(AseUtil.nullToBlank(rs.getString("question")));
				Fnd.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				Fnd.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.getHallmark\n" + e.toString());
			Fnd = null;
		} catch (Exception e) {
			logger.fatal("FndDB.getHallmark\n" + e.toString());
			Fnd = null;
		}

		return Fnd;
	}

	/*
	 * hallmarkExists
	 * <p>
	 * @return boolean
	 */
	public static boolean hallmarkExists(Connection conn,String Fnd) throws Exception {

		boolean exists = false;

		try {
			String sql = "SELECT id FROM tblfnditems WHERE type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Fnd);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.hallmarkExists - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.hallmarkExists - " + e.toString());
		}

		return exists;
	}

	/*
	 * isCancellable
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * @param	id			int
	 *	<p>
	 *	@return Msg
	 */
	public static boolean isCancellable(Connection conn,String campus,String user,String kix,int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean cancellable = false;
		String proposer = "";
		String progress = "";

		try {
			String sql = "SELECT edit,proposer,progress FROM tblfnd WHERE campus=? AND id=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,id);
			ps.setString(3,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cancellable = rs.getBoolean("edit");
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
			}

			// only the proposer may cancel a pending foundation course. Not even coproposers allowed
			if (cancellable && user.equals(proposer) &&
				(	progress.equals(Constant.FND_MODIFY_PROGRESS) ||
					progress.equals(Constant.FND_DELETE_PROGRESS) ||
					progress.equals(Constant.FND_REVISE_PROGRESS)
				)){
				cancellable = true;
			}
			else{
				cancellable = false;
			}

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.isCancellable\n" + kix + "\n" + e.toString());
			cancellable = false;
		} catch (Exception e) {
			logger.fatal("FndDB.isCancellable\n" + kix + "\n" + e.toString());
			cancellable = false;
		}

		return cancellable;
	}

	/*
	 * getFndItem
	 *	<p>
	 *	@return String
	 */
	public static String getFndItem(Connection conn,int id,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String item = "";

		try {
			String sql = "SELECT " + column + " FROM tblfnd WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.getFndItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFndItem - " + e.toString());
		}

		return item;
	}

	/*
	 * getFndItem
	 *	<p>
	 *	@return String
	 */
	public static String getFndItem(Connection conn,String kix,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String item = "";

		try {
			String sql = "SELECT " + column + " FROM tblfnd WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));

				if (item != null && item.length() > 0){
					if (DateUtility.isDate(item)){
						item = DateUtility.formatDateAsString(item);
					}
				}

			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.getFndItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFndItem - " + e.toString());
		}

		return item;
	}

	/*
	 * getFoundationDescr
	 *	<p>
	 *	@return String
	 */
	public static String getFoundationDescr(Connection conn,int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String descr = "";

		try {
			descr = getFoundationDescr(getFndItem(conn,id,"fndtype"));
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationDescr - " + e.toString());
		}

		return descr;
	}

	/*
	 * getFoundationDescr
	 *	<p>
	 *	@return String
	 */
	public static String getFoundationDescr(String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String descr = "";

		try {
			if(type.equals("FG")){
				descr = "Global and Multicultural Perspectives";
			}
			else if(type.equals("FS")){
				descr = "Symbolic Reasoning";
			}
			else if(type.equals("FW")){
				descr = "Written Communication";
			}
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationDescr - " + e.toString());
		}

		return descr;
	}

	/*
	 * setItem
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	@param	column
	 *	@param	data
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int setItem(Connection conn,int id,String fld,String data,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "";
			PreparedStatement ps = null;

			if(isMatch(conn,id,fld)){
				sql = "UPDATE tblfnddata SET data=?,auditby=?,auditdate=? WHERE id=? AND fld=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,data);
				ps.setString(2,user);
				ps.setString(3,AseUtil.getCurrentDateTimeString());
				ps.setInt(4,id);
				ps.setString(5,fld);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				sql = "INSERT INTO tblfnddata(id,fld,data,auditby,auditdate) values(?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ps.setString(2,fld);
				ps.setString(3,data);
				ps.setString(4,user);
				ps.setString(5,AseUtil.getCurrentDateTimeString());
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			sql = "UPDATE tblfnd SET auditby=?,auditdate=? WHERE id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setString(2,AseUtil.getCurrentDateTimeString());
			ps.setInt(3,id);
			rowsAffected = ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.setItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.setItem - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * isMatch
	 * <p>
	 * @param conn		Connection
	 * @param id		int
	 * @param fld		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,int id,String fld) throws SQLException {

		String sql = "SELECT id FROM tblfnddata WHERE id=? AND fld=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1,id);
		ps.setString(2,fld);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * isMatch
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try {
			String sql = "SELECT id FROM tblfnd WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.isMatch - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.isMatch - " + e.toString());
		}

		return exists;
	}

	/*
	 * isMatch
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	fndtype	String
	 * @param	type	String
	 * <p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String alpha,String num,String fndtype,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try {
			String sql = "SELECT id FROM tblfnd WHERE campus=? AND coursealpha=? AND coursenum=? AND fndtype=? AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,fndtype);
			ps.setString(5,type);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.isMatch - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.isMatch - " + e.toString());
		}

		return exists;
	}

	/*
	 * getFoundations
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getFoundations(Connection conn,String type) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id, type, fld, seq, en, qn, hallmark, explanatory, question, campus, AuditBy, AuditDate FROM tblfnditems order by type, seq, en, qn";
				if(!type.equals("")){
					sql = "SELECT id, type, fld, seq, en, qn, hallmark, explanatory, question, campus, AuditBy, AuditDate FROM tblfnditems where type=? order by type, seq, en, qn";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				if(!type.equals("")){
					ps.setString(1,type);
				}
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					String fld = AseUtil.nullToBlank(rs.getString("fld"));
					String hallmark = AseUtil.nullToBlank(rs.getString("hallmark"));
					String explanatory = AseUtil.nullToBlank(rs.getString("explanatory"));
					String question = AseUtil.nullToBlank(rs.getString("question"));

					int en = NumericUtil.getInt(rs.getInt("en"),0);
					int qn = NumericUtil.getInt(rs.getInt("qn"),0);

					String data = "";

					if(en == 0 && qn == 0){
						data = hallmark;
					}
					else if(en > 0 && qn == 0){
						data = explanatory;
					}
					else if(en > 0 && qn > 0){
						data = question;
					}

					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("id")),
											AseUtil.nullToBlank(rs.getString("type")),
											AseUtil.nullToBlank(rs.getString("seq")),
											AseUtil.nullToBlank(rs.getString("en")),
											AseUtil.nullToBlank(rs.getString("qn")),
											AseUtil.nullToBlank(data),
											AseUtil.nullToBlank(rs.getString("campus")),
											AseUtil.nullToBlank(rs.getString("AuditBy")),
											ae.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME),
											fld
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * getCourseFoundation
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getCourseFoundation(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {

			int id = NumericUtil.getInt(getFndItem(conn,kix,"id"),0);

			if(id > 0){
				genericData = getCourseFoundation(conn,id);
			}

		} catch (SQLException e) {
			logger.fatal("FndDB.getCourseFoundation - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getCourseFoundation - " + e.toString());
		}

		return genericData;
	}

	/*
	 * getCourseFoundation
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getCourseFoundation(Connection conn,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT d.fld, i.hallmark, i.explanatory, i.question, d.data, i.seq, i.en, i.qn "
					+ "FROM tblfnddata as d RIGHT OUTER JOIN tblfnditems i ON d.fld = i.fld "
					+ "WHERE (d.id = ?) ORDER BY d.fld";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					String fld = AseUtil.nullToBlank(rs.getString("fld"));
					String hallmark = AseUtil.nullToBlank(rs.getString("hallmark"));
					String explanatory = AseUtil.nullToBlank(rs.getString("explanatory"));
					String question = AseUtil.nullToBlank(rs.getString("question"));
					String data = AseUtil.nullToBlank(rs.getString("data"));

					int en = NumericUtil.getInt(rs.getInt("en"),0);
					int qn = NumericUtil.getInt(rs.getInt("qn"),0);

					if(en == 0 && qn == 0){
						question = hallmark;
					}
					else if(en > 0 && qn == 0){
						question = explanatory;
					}
					else if(en > 0 && qn > 0){
						//question = question;
					}

					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("seq")),
											AseUtil.nullToBlank(rs.getString("en")),
											AseUtil.nullToBlank(rs.getString("qn")),
											AseUtil.nullToBlank(question),
											AseUtil.nullToBlank(data),
											fld,
											"",
											"",
											"",
											""
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getCourseFoundation - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getCourseFoundation - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * createFoundationCourse
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	user			String
	 * @param	kix			String
	 * @param	foundation	String
	 * @param	authors		String
	 * @param	assessment	String
	 * <p>
	 * @return 	int
	 */
	public static int createFoundationCourse(Connection conn,
															String campus,
															String user,
															String kix,
															String foundation,
															String authors,
															String assessment) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int id = 0;

		try {

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String coursetitle = info[Constant.KIX_COURSETITLE];

			String type = "PRE";

			if(!isMatch(conn,campus,alpha,num,foundation,type)){

				String fndKix = SQLUtil.createHistoryID(1);

				AseUtil.logAction(conn, user, "ACTION","Foundation course created ("+ alpha + " " + num + ")",alpha,num,campus,fndKix);

				//
				// insert into main table (tlbfndf
				//
				String sql = "INSERT INTO tblfnd(campus,historyid,fndtype,created,coursealpha,"
								+ "coursenum,coursedate,coursetitle,coursedescr,proposer,"
								+ "coproposer,auditby,auditdate,type,progress,"
								+ "edit,edit0,edit1,edit2,assessment) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,'','1','1',?)";
				PreparedStatement ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
				ps.setString(1,campus);
				ps.setString(2,fndKix);
				ps.setString(3,foundation);
				ps.setString(4,AseUtil.getCurrentDateTimeString());
				ps.setString(5,alpha);
				ps.setString(6,num);
				ps.setString(7,CourseDB.getCourseItem(conn,kix,"coursedate"));
				ps.setString(8,coursetitle);
				ps.setString(9,CourseDB.getCourseItem(conn,kix,"coursedescr"));
				ps.setString(10,user);
				ps.setString(11,authors);
				ps.setString(12,user);
				ps.setString(13,AseUtil.getCurrentDateTimeString());
				ps.setString(14,type);
				ps.setString(15,"MODIFY");
				ps.setString(16,assessment);
				ps.executeUpdate();

				//
				// get the id just added for use here
				//
				ResultSet rs = null;
				try{
					rs = ps.getGeneratedKeys();
					if(rs.next()){
						id = rs.getInt(1);
					}
					rs.close();
					ps.close();
				} catch (Exception e){
					logger.fatal("FndDB.createFoundationCourse - " + e.toString());
					rs.close();
					ps.close();
				}

				//
				// use created key to insert into data table (fnddata)
				//
				if(id > 0){
					sql = "SELECT fld,seq, en, qn FROM tblfnditems where type=? order by seq, en, qn";
					ps = conn.prepareStatement(sql);
					ps.setString(1,foundation);
					rs = ps.executeQuery();
					while (rs.next()) {
						String fld = AseUtil.nullToBlank(rs.getString("fld"));
						int sq = rs.getInt("seq");
						int en = rs.getInt("en");
						int qn = rs.getInt("qn");
						sql = "insert into tblfnddata (id,fld,data,sq,en,qn,fndtype) values(?,?,?,?,?,?,?);";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setInt(1,id);
						ps2.setString(2,fld);
						ps2.setString(3,"");
						ps2.setInt(4,sq);
						ps2.setInt(5,en);
						ps2.setInt(6,qn);
						ps2.setString(7,fld.substring(0,2));
						ps2.executeUpdate();
						ps2.close();

					} // while
					rs.close();
					ps.close();

					//
					//
					//
					int rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															Constant.FND_CREATE_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.TASK_PROPOSER,
															Constant.TASK_PROPOSER,
															fndKix,
															Constant.FOUNDATION,
															"NEW");

					//
					// update foundation outline
					//
					updateFndOutline(conn,fndKix,campus,alpha,num,type);

				} // valid id

			} // not match


		} catch (SQLException e) {
			logger.fatal("FndDB.createFoundationCourse - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.createFoundationCourse - " + e.toString());
		}

		return id;

	}

    /**
     * <p>
     * updateFndOutline
     * </p>
     * <p>
     * updates <code>campus outline</code> with each action perform on a KIX.
     * this helps speed up the retrieval process because all KIX by campuses
     * are always available.
     * </p>
     *
     * @param conn
     *          A <code>Connection</code> object
     * @param kix
     *          The <code>HistoryID</code>
     * @param campus
     */
	public static void updateFndOutline(Connection conn,String kix,String campus,String alpha,String num,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		try {

			boolean debug = false;

			if(debug){
				logger.info("kix: " + kix);
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha+ "<br>");
				logger.info("num: " + num);
				logger.info("type: " + type);
			}

			String sql = "UPDATE tblfndoutlines SET " + campus + "=? "
						+ "WHERE category=? AND coursealpha=? AND coursenum=? AND coursetype=? ";

			if(debug) logger.info("sql: " + sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,"Outline");
			ps.setString(3,alpha);
			ps.setString(4,num);
			ps.setString(5,type);
			int rowsAffected = ps.executeUpdate();

			if(debug) logger.info("rowsAffected: " + rowsAffected);

			// if == 0, row does not exist for update. add new row
			if (rowsAffected == 0){
				sql = "INSERT INTO tblfndoutlines "
					+ "(category,coursealpha,coursenum,coursetype,"+campus+") "
					+ "VALUES('Outline',?,?,?,?)";

				if(debug) logger.info("sql: " + sql);

				ps = conn.prepareStatement(sql);
				ps.setString(1,alpha);
				ps.setString(2,num);
				ps.setString(3,type);
				ps.setString(4,kix);
				rowsAffected = ps.executeUpdate();
			}

			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.updateFndOutline - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.updateFndOutline - " + e.toString());
		}

		return;
	}

	/*
	 * listOutlinesForFoundations
	 * <p>
	 * @param	conn			Connection
	 * @param	alpha			String
	 * @param	campus		String
	 * <p>
	 * @return 	String
	 */
	public static String listOutlinesForFoundations(Connection conn,String alpha,String campus,String user){

		//Logger logger = Logger.getLogger("test");

		String listing = "";

		int j = 0;
		String rowColor = "";
		StringBuffer listings = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT historyid, CourseNum, coursetitle, effectiveterm, coursedate "
				+ "FROM tblcourse WHERE campus=? AND CourseAlpha=? AND CourseType='CUR' AND "
				+ "(NOT (effectiveterm IS NULL)) AND (effectiveterm > '') ORDER BY CourseNum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String coursetitle = AseUtil.nullToBlank(rs.getString("coursetitle"));
				String effectiveterm = AseUtil.nullToBlank(rs.getString("effectiveterm"));
				String coursedate = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_SHORT);

				int id = 0;
				String proposer = "";
				String coproposer = "";
				String fndtype = "";
				String progress = "";

				sql = "SELECT id, proposer, coproposer, fndtype, progress FROM tblfnd "
					+ "WHERE (id = (SELECT MAX(id) AS maxid FROM tblfnd AS tblfnd_1 "
					+ "WHERE campus=? AND coursealpha=? AND coursenum=?))";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ps2.setString(2,alpha);
				ps2.setString(3,num);
				ResultSet rs2 = ps2.executeQuery();
				if(rs2.next()){
					id = rs2.getInt("id");
					proposer = AseUtil.nullToBlank(rs2.getString("proposer"));
					coproposer = AseUtil.nullToBlank(rs2.getString("coproposer"));
					fndtype = AseUtil.nullToBlank(rs2.getString("fndtype"));
					progress = AseUtil.nullToBlank(rs2.getString("progress"));
				}
				rs2.close();
				ps2.close();

				//
				// row colors
				//
				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				//
				// if fndtype is not there, allow to create. otherwise, edit.
				// if editing, must be author; otherwise view.
				//
				String link = alpha + " " + num;
				if(fndtype.equals(Constant.BLANK) || progress.equals(Constant.FND_CANCEL_PROGRESS)){
					link = "<a href=\"fndcrtw.jsp?kix="+historyid+"\" class=\"linkcolumn\"><img src=\"../images/add.gif\" alt=\"create foundation course\" title=\"create foundation course\"></a>";
				}
				else if(!fndtype.equals(Constant.BLANK) && (user.equals(proposer) || coproposer.contains(user))){
					link = "<a href=\"fndedit.jsp?id="+id+"\" class=\"linkcolumn\"><img src=\"../images/edit.gif\" alt=\"edit foundation course\" title=\"edit foundation course\"></a>";
				}
				else {
					link = "<a href=\"fndvw.jsp?id="+id+"\" class=\"linkcolumn\"><img src=\"../images/view.gif\" alt=\"edit foundation course\" title=\"edit foundation course\"></a>";
				}

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + link + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + alpha + " " + num + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + coursetitle + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + effectiveterm + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + coursedate + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + proposer + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + coproposer + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + fndtype + "&nbsp;" + "</td>"
									+ "<td class=\"datacolumn\" valign=\"middle\">" + progress + "&nbsp;" + "</td>"
									+ "</tr>");
			}

			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinesForFoundations - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Helper: listOutlinesForFoundations - " + e.toString());
		}

		listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
				+ "<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
				+ "<td colspan=\"5\" bgcolor=\"#e0e0e0\" align=\"center\" valign=\"middle\">Course Information</td>"
				+ "<td colspan=\"4\" bgcolor=\"#EAF2D3\" align=\"center\" width=\"30%\" valign=\"middle\">Foundation Information</td>"
				+ "</tr>"
				+ "<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
				+ "<td class=\"textblackth\" width=\"05%\" valign=\"middle\">Action</td>"
				+ "<td class=\"textblackth\" width=\"10%\" valign=\"middle\">Outline</td>"
				+ "<td class=\"textblackth\" width=\"25%\" valign=\"middle\">Title</td>"
				+ "<td class=\"textblackth\" width=\"10%\" valign=\"middle\">Effective Term</td>"
				+ "<td class=\"textblackth\" width=\"10%\" valign=\"middle\">Approval Date</td>"
				+ "<td class=\"textblackth\" width=\"10%\" valign=\"middle\">Proposer</td>"
				+ "<td class=\"textblackth\" width=\"15%\" valign=\"middle\">Co-Proposer</td>"
				+ "<td class=\"textblackth\" width=\"05%\" valign=\"middle\">Type</td>"
				+ "<td class=\"textblackth\" width=\"10%\" valign=\"middle\">Progress</td>"
				+ "</tr>"
				+ listings.toString()
				+ "</table>";

		return listing;
	}

	/*
	 * A course is cancallable only if: edit flag = true and progress = modify
	 * and canceller = proposer
	 * <p>
	 *	@param	Connection	connection
	 *	@param	String		kix
	 *	@param	String		user
	 * <p>
	 *	@return boolean
	 */
	public static boolean isCourseCancellable(Connection conn,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean cancellable = false;
		String proposer = "";
		String progress = "";

		try {
			String[] info = getKixInfo(conn,kix);
			String alpha = info[0];
			String num = info[1];
			String campus = info[4];

			String sql = "SELECT edit,proposer,progress FROM tblfnd WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				cancellable = rs.getBoolean(1);
				proposer = rs.getString(2);
				progress = rs.getString(3);
			}

			// only the proposer may cancel a pending course
			if (cancellable && user.equals(proposer) &&
				(	progress.equals(Constant.FND_MODIFY_TEXT) ||
					progress.equals(Constant.FND_DELETE_TEXT) ||
					progress.equals(Constant.FND_REVISE_TEXT)
				)){
				cancellable = true;
			}
			else{
				cancellable = false;
			}

			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.isCourseCancellable - " + e.toString());
			cancellable = false;
		} catch (Exception e) {
			logger.fatal("FndDB.isCourseCancellable - " + e.toString());
			cancellable = false;
		}

		return cancellable;
	}

	/**
	 * getKixInfo
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfo(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int counter = 10;
		String sql = "SELECT coursealpha,coursenum,type,proposer,campus,historyid,fndtype,progress,subprogress,coursetitle "
						+ "FROM tblfnd WHERE historyid=?";
		String[] info = new String[counter];

		try{
			for (i=0;i<counter;i++){
				info[i] = "";
			}

			String dataType[] = {"s","s","s","s","s","s","s","s","s","s"};

			if (kix != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					info = SQLUtil.resultSetToArray(rs,dataType);
				}
				rs.close();
				ps.close();
			} // kix
		}
		catch(Exception ex){
			logger.fatal("FndDB.getKixInfo - " + ex.toString());
			info[0] = "";
		}

		return info;
	}

	/*
	 * getFoundationForEditDisplay
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getFoundationForEditDisplay(Connection conn,String campus,String type,String fndtype) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil aseUtil = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id,historyid,created,coursealpha,coursenum,coursetitle,Proposer,Progress, auditby, auditdate,coproposer "
					+ "FROM tblfnd WHERE campus=? AND type=? AND fndtype=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				ps.setString(3,fndtype);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("id")),
											aseUtil.ASE_FormatDateTime(rs.getString("created"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")),
											AseUtil.nullToBlank(rs.getString("coursetitle")),
											AseUtil.nullToBlank(rs.getString("Proposer")),
											AseUtil.nullToBlank(rs.getString("Progress")),
											AseUtil.nullToBlank(rs.getString("auditby")),
											aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coproposer")),
											AseUtil.nullToBlank(rs.getString("historyid"))
										));
				} // while
				rs.close();
				ps.close();

				aseUtil = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundationForEditDisplay - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationForEditDisplay - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * getFoundationForEdit
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getFoundationForEdit(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil aseUtil = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id,historyid,created,coursealpha,coursenum,coursetitle,Proposer,Progress,auditby,auditdate,coproposer,fndtype "
					+ "FROM tblfnd WHERE campus=? AND type='PRE' AND (proposer=? OR coproposer like '%"+user+"%')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("id")),
											aseUtil.ASE_FormatDateTime(rs.getString("created"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")),
											AseUtil.nullToBlank(rs.getString("fndtype")) + " - " + AseUtil.nullToBlank(rs.getString("coursetitle")),
											AseUtil.nullToBlank(rs.getString("Proposer")),
											AseUtil.nullToBlank(rs.getString("Progress")),
											AseUtil.nullToBlank(rs.getString("auditby")),
											aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coproposer")),
											AseUtil.nullToBlank(rs.getString("historyid"))
										));
				} // while
				rs.close();
				ps.close();

				aseUtil = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundationForEdit - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationForEdit - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * getFoundationToCancel
	 * <p>
	 * @param	conn	Connection
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getFoundationToCancel(Connection conn,String campus,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil aseUtil = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT id,fndtype,created,coursealpha,coursenum,coursetitle,Proposer,Progress, auditby, auditdate,coproposer "
					+ "FROM tblfnd WHERE campus=? AND type='PRE' AND proposer=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("id")),
											aseUtil.ASE_FormatDateTime(rs.getString("created"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")),
											AseUtil.nullToBlank(rs.getString("coursetitle")),
											AseUtil.nullToBlank(rs.getString("Proposer")),
											AseUtil.nullToBlank(rs.getString("Progress")),
											AseUtil.nullToBlank(rs.getString("auditby")),
											aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("coproposer")),
											AseUtil.nullToBlank(rs.getString("fndtype"))
										));
				} // while
				rs.close();
				ps.close();

				aseUtil = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundationToCancel - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationToCancel - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * addFile
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	@param	original
	 *	@param	fn
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int addFile(Connection conn,String campus,String user,int id,String fn,String original,int en,int sq,int qn) throws SQLException {

		return addFile(conn,campus,user,id,fn,original,en,sq,qn,1);

	}

	public static int addFile(Connection conn,String campus,String user,int id,String fn,String original,
										int en,
										int sq,
										int qn,
										int version) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "INSERT INTO tblfndfiles(id,originalname,filename,auditby,auditdate,campus,en,sq,qn,version) values(?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1,id);
			ps.setString(2,original);
			ps.setString(3,fn);
			ps.setString(4,user);
			ps.setString(5,AseUtil.getCurrentDateTimeString());
			ps.setString(6,campus);
			ps.setInt(7,en);
			ps.setInt(8,sq);
			ps.setInt(9,qn);
			ps.setInt(10,version);
			rowsAffected = ps.executeUpdate();

			//
			// retrieve and return max id
			//
			if(rowsAffected > 0){
				//
				// get the id just added for use here
				//
				ResultSet rs = null;
				try{
					rs = ps.getGeneratedKeys();
					if(rs.next()){
						rowsAffected = rs.getInt(1);
					}
					rs.close();
					ps.close();
				} catch (Exception e){
					logger.fatal("addFile - " + e.toString());
					rs.close();
					ps.close();
				}

			}
			else{
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("FndDB.addFile - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.addFile - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getUserBoards
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			int
	 * @param	sort		String
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getAttachmentsMaster(Connection conn,String campus,int id) throws Exception {

		return getAttachmentsMaster(conn,campus,id,"");

	}

	public static List<Generic> getAttachmentsMaster(Connection conn,String campus,int id,String sort) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		// retrieve all active forums a user has access to.
		// active is where the user is actively participating in (message_author)
		// the historyid is valid because the coursetype is PRE
		// and messages are in forum only at review process
		try{
			genericData = new LinkedList<Generic>();

			AseUtil aseUtil = new AseUtil();

			//
			// default sort is filename
			//
			if(sort == null || sort.equals("")){
				sort = "fn";
			}

			String sql = "SELECT vw.seq, vw.originalname, tb.auditby, tb.auditdate, tb.filename, tb.sq, tb.en, tb.qn "
				+ "FROM vw_fndfilesmaster vw INNER JOIN tblfndfiles tb ON vw.seq = tb.seq WHERE tb.id = ? and tb.campus=? ";

			if(sort.equals("fn")){
				sql = sql + " ORDER BY vw.originalname";
			}
			else{
				sql = sql + " ORDER BY tb.sq, tb.en, tb.qn";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				int seq = rs.getInt("seq");

				genericData.add(new Generic(
										"" + seq,
										AseUtil.nullToBlank(rs.getString("originalname")),
										AseUtil.nullToBlank(rs.getString("auditby")),
										aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("filename")),
										"" + rs.getInt("sq"),
										"" + rs.getInt("en"),
										"" + rs.getInt("qn"),
										"",
										""
									));
			} // rs
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("FndDB - getAttachments: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("FndDB - getAttachments: " + e.toString());
			return null;
		}

		return genericData;
	} // ForumDB - getUserBoards

	/*
	 * getUserBoards
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			int
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getAttachmentsDetail(Connection conn,String campus,int id,int seq,String originalname) throws Exception {

		return getAttachmentsDetail(conn,campus,id,seq,originalname,"");

	}

	public static List<Generic> getAttachmentsDetail(Connection conn,String campus,int id,int seq,String originalname,String sort) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		// retrieve all active forums a user has access to.
		// active is where the user is actively participating in (message_author)
		// the historyid is valid because the coursetype is PRE
		// and messages are in forum only at review process
		try{
			genericData = new LinkedList<Generic>();

			AseUtil aseUtil = new AseUtil();

			//
			// default sort is filename
			//
			if(sort == null || sort.equals("")){
				sort = "fn";
			}

			String sql = "SELECT seq, auditby, filename, auditdate, sq, en, qn FROM tblfndfiles "
				+ "WHERE id=? AND campus=? AND originalname=? AND seq <> ? ";

			if(sort.equals("fn")){
				sql = sql + " ORDER BY originalname, seq ";
			}
			else{
				sql = sql + " ORDER BY sq, en, qn";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ps.setString(2,campus);
			ps.setString(3,originalname);
			ps.setInt(4,seq);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				genericData.add(new Generic(
										"" + rs.getInt("seq"),
										originalname,
										AseUtil.nullToBlank(rs.getString("auditby")),
										aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME),
										AseUtil.nullToBlank(rs.getString("filename")),
										"" + rs.getInt("sq"),
										"" + rs.getInt("en"),
										"" + rs.getInt("qn"),
										"",
										""
									));
			} // rs
			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("FndDB - getAttachments: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("FndDB - getAttachments: " + e.toString());
			return null;
		}

		return genericData;
	} // ForumDB - getUserBoards

	/*
	 * testData
	 * <p>
	 * @param	conn		Connection
	 * @param	control	String
	 * @param	value		String
	 * <p>
	 * @return 	String
	 */
	public static String drawFndRadio(Connection conn,String control,String value) {

		//Logger logger = Logger.getLogger("test");

		String temp = "";

		try {

			String[] fndtype = "FG,FS,FW".split(",");
			String[] fndname = "Global and Multicultural Perspectives,Symbolic Reasoning,Written Communication".split(",");

			for(int i=0; i<fndtype.length; i++){

				String selected = "";

				if(fndtype[i].equals(value)){
					selected = "checked";
				}

				temp += "<input type=\"radio\" value=\"" + fndtype[i] +"\" name=\"" + control +"\" " + selected + ">" + fndtype[i] + " - " + fndname[i] + "<br/>";
			}


		} catch (Exception e) {
			logger.fatal("drawFndRadio - " + e.toString());
		}

		return temp;
	}


	/*
	 * isFoundation
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * <p>
	 * @return 	Generic
	 */
	public static boolean isFoundation(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isFoundation = false;

		try {
			String sql = "SELECT id FROM tblfnd WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			isFoundation = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.isFoundation - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.isFoundation - " + e.toString());
		}

		return isFoundation;
	}

	/*
	 * viewFoundation
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * @param	kix	String
	 * <p>
	 * @return 	String
	 */
	public static String viewFoundation(Connection conn,String kix) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		StringBuffer output = new StringBuffer();

		try{

			String[] info = getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String courseTitle = info[Constant.KIX_COURSETITLE];
			String fndType = info[Constant.KIX_ROUTE];

			String title = alpha + " " + num + " - " + courseTitle + "<br/>" + getFoundationDescr(fndType);

			output.append("<table width=\"100%\">")
					.append("<tbody><tr>")
					.append("<td valign=\"top\" width=\"03%\">&nbsp;</td>")
					.append("<td valign=\"top\"><p class=\"outputTitleCenter\">"+title+"</p>")
					.append("<table summary=\"xyz\" id=\"tableViewOutline\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">")
					.append("<tbody>");

			for(com.ase.aseutil.Generic fd: getCourseFoundation(conn,kix)){

				String fld = fd.getString6();

				int sq = NumericUtil.getInt(fd.getString1(),0);
				int en = NumericUtil.getInt(fd.getString2(),0);
				int qn = NumericUtil.getInt(fd.getString3(),0);

				if(en > 0 || qn > 0){
					output.append("<tr>")
							.append("<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>")
							.append("<td class=\"textblackTH\" valign=\"top\">"+fd.getString4()+"<br /><br /></td>")
							.append("</tr>")
							.append("<tr>")
							.append("<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>")
							.append("<td class=\"datacolumn\" valign=\"top\">"+fd.getString5()+"<br /><br /></td>")
							.append("</tr>");
				}
				else{
					output.append("<tr>")
							.append("<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">"+sq+".&nbsp;</td>")
							.append("<td class=\"textblackTH\" valign=\"top\">"+fd.getString4()+"<br /><br /></td>")
							.append("</tr>");
				} // if - else

			} // for

			output.append("</tbody></table></td></tr></tbody></table>");
		}
		catch(Exception e){
			logger.fatal("FndDB.viewFoundation\n" + kix + e.toString());
		}

		return output.toString();

	}

	/*
	 * createFoundation - when campus is not null, we create outline for that campus, alpha, num
	 *	combination only.
	 *	<p>
	 *	@param	campus
	 *	@param	kix
	 *	<p>
	 */
	public static void createFoundation(String campus,String kix) throws Exception {

		createFoundation(campus,"",kix);

	}

	public static void createFoundation(String campus,String user,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

boolean debug = true;

		boolean compressed = true;

		FileWriter fstream = null;
		BufferedWriter output = null;

      Connection conn = null;

		String type = "PRE";
		String sql = "";
		String documents = "";
		String fileName = "";

		String alpha = "";
		String num = "";
		String courseTitle = "";
		String fndType = "";

		int rowsAffected = 0;

		PreparedStatement ps = null;

		boolean htmlCreated = false;

		String currentDrive = AseUtil.getCurrentDrive();

		try {
			conn = AsePool.createLongConnection();

			if (conn != null){

				String[] info = getKixInfo(conn,kix);
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
				courseTitle = info[Constant.KIX_COURSETITLE];
				fndType = info[Constant.KIX_ROUTE];
				type = info[Constant.KIX_TYPE];

				info = Helper.getKixRoute(conn,campus,alpha,num,"CUR");
				String courseKix = info[0];

				int id = NumericUtil.getInt(getFndItem(conn,kix,"id"),0);

				if (debug) {
					logger.info("campus: " + campus);
					logger.info("kix: " + kix);
					logger.info("alpha: " + alpha);
					logger.info("num: " + num);
					logger.info("courseTitle: " + courseTitle);
					logger.info("fndType: " + fndType);
					logger.info("type: " + type);
				}

				String htmlHeader = Util.getResourceString("fndheader.ase");
				String htmlFooter = Util.getResourceString("fndfooter.ase");
				if (debug) logger.info("resource HTML");

				documents = SysDB.getSys(conn,"documents");
				if (debug) logger.info("obtained document folder");

				try {
					fileName = currentDrive
									+ ":"
									+ documents
									+ "fnd\\"
									+ campus
									+ "\\"
									+ kix
									+ ".html";

					if (debug) logger.info(fileName);

					fstream = new FileWriter(fileName);

					output = new BufferedWriter(fstream);

					output.write(htmlHeader);

					htmlCreated = false;

					try{
						String junk = viewFoundation(conn,kix);

						if(CompDB.hasSLOs(conn,courseKix)){
							junk += "<hr size=\"1\" noshade=\"\"><br/><br/>" + getLinkedItems(conn,campus,user,id,kix,Constant.COURSE_OBJECTIVES,true);
						}

						junk = junk.replace("<br>","<br/>");

						output.write(junk);

						Html.updateHtml(conn,Constant.FOUNDATION,kix);

						htmlCreated = true;
					}
					catch(Exception e){
						logger.fatal("FndDB.createFoundation - fail to create foundation - "
							+ campus + " - " + kix  + "\n" + e.toString());
					}

					Calendar calendar = Calendar.getInstance();
					String copyRight = "" + calendar.get(Calendar.YEAR);

					htmlFooter = htmlFooter.replace("[FOOTER_COPYRIGHT]","Copyright ©1999-"+copyRight+" All rights reserved.")
								.replace("[FOOTER_STATUS_DATE]",footerStatus(conn,kix,type));

					if (debug) logger.info("obtained document folder");

					output.write(htmlFooter);

					if (debug) logger.info("HTML created");
				}
				catch(Exception e){
					logger.fatal("FndDB.createFoundation - fail to open/create file - "
							+ campus + " - " + kix  + " - " + "\n" + e.toString());
				} finally {
					output.close();
				}

				conn.close();
				conn = null;

				if (debug) logger.info("connection closed");

			} // if conn != null

		} catch (Exception e) {
			logger.fatal("FndDB.createFoundation FAILED3 - "
					+ campus + " - " + kix  + " - " + "\n" + e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("FndDB.createFoundation\n" + kix + "\n" + e.toString());
			}
		}

		return;
	}

	/*
	 * updateFndItem
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	@param	column
	 *	@param	data
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int updateFndItem(Connection conn,int id,String column,String data,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblfnd SET "+column+"=?,auditby=?,auditdate=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,data);
			ps.setString(2,user);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setInt(4,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.updateFndItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.updateFndItem - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateFndItem
	 *	<p>
	 *	@param	conn
	 *	@param	kix
	 *	@param	column
	 *	@param	data
	 *	@param	user
	 *	<p>
	 *	@return int
	 */
	public static int updateFndItem(Connection conn,String kix,String column,String data,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblfnd SET "+column+"=?,auditby=?,auditdate=? WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,data);
			ps.setString(2,user);
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.updateFndItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.updateFndItem - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * updateFndSettings
	 *	<p>
	 *	@param	conn
	 *	@param	id
	 *	@param	user
	 *	@param	coproposer
	 *	@param	assessment
	 *	<p>
	 *	@return int
	 */
	public static int updateFndSettings(Connection conn,int id,String user,String coproposer,String assessment) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "UPDATE tblfnd SET coproposer=?,assessment=?,auditby=?,auditdate=? WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,coproposer);
			ps.setString(2,assessment);
			ps.setString(3,user);
			ps.setString(4,AseUtil.getCurrentDateTimeString());
			ps.setInt(5,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.updateFndSettings - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.updateFndSettings - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * showByProposer
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	user
	 * @param	caller
	 * <p>
	 * @return	String
	 */
	public static String showByProposer(Connection conn,String campus,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			String sql = "SELECT distinct historyid, coursetitle, coursealpha, coursenum " +
				"FROM tblFnd WHERE campus=? AND proposer=? AND (progress=? OR progress=?) ORDER BY coursealpha, coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.FND_MODIFY_PROGRESS);
			ps.setString(4,Constant.FND_APPROVAL_PROGRESS);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("FndDB.showByProposer - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Foundation course does not exist for this request</li></ul>";
	}

	/*
	 * endReviewerTask
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	user		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg endReviewerTask(Connection conn,String campus,String kix,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		String currentApprover = "";
		String sql = "";
		String mode = "APPROVAL";

		int rowsAffected = 0;
		int numberOfReviewers = 0;

		PreparedStatement ps = null;

		boolean reviewInApproval = false;
		boolean debug = false;

		try {
			debug = DebugDB.getDebug(conn,"FndDB");

			if (debug) logger.info("------------------------ endReviewerTask - START");

			String[] info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String proposer = info[Constant.KIX_PROPOSER];
			String progress = info[Constant.KIX_PROGRESS];
			String subprogress = info[Constant.KIX_SUBPROGRESS];

			if (subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL) ||
					subprogress.equals(Constant.FND_REVIEW_IN_DELETE)){

				reviewInApproval = true;

				if (subprogress.equals(Constant.FND_REVIEW_IN_DELETE)){
					mode = "DELETE";
				}
			} // mode

			msg.setMsg("");

			// end user's review task. If this is the proposer and it was
			// intended to remove users from review, then SQL is different.
			sql = "DELETE FROM tblReviewers WHERE campus=? AND historyid=? AND userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,user);
			rowsAffected = ps.executeUpdate();

			currentApprover = TaskDB.getInviter(conn,campus,kix,user);

			if (debug){
				logger.info("kix - " + kix);
				logger.info("currentApprover - " + currentApprover);
				logger.info("user - " + user);
				logger.info("alpha - " + alpha);
				logger.info("num - " + num);
				logger.info("proposer - " + proposer);
				logger.info("progress - " + progress);
				logger.info("subprogress - " + subprogress);
				logger.info("reviewInApproval: " + reviewInApproval);
				logger.info("mode: " + mode);
				logger.info("review completed - " + rowsAffected + " row");
			}

			rowsAffected = TaskDB.logTask(conn,
													user,
													user,
													alpha,
													num,
													Constant.COURSE_REVIEW_TEXT,
													campus,
													Constant.BLANK,
													Constant.TASK_REMOVE,
													Constant.PRE,"","",kix,Constant.FOUNDATION);
			if (debug) logger.info("review task removed - " + rowsAffected + " row");

			//
			// it's possible that no reviewer added comments. If so, rowsAffected is still 0
			//
			if (rowsAffected >= 0) {
				// if all reviewers have completed their task, let's reset the
				// course and get back to modify mode. also, backup history
				sql = "WHERE historyid = '" + SQLUtil.encode(kix)
						+ "' AND " + "campus = '" + SQLUtil.encode(campus)
						+ "'";

				numberOfReviewers = (int)AseUtil.countRecords(conn,"tblReviewers",sql);

				if (numberOfReviewers == 0) {

					if (subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL)){
						reviewInApproval = true;
					}

					if (reviewInApproval){
						sql = "UPDATE tblfnd "
							+ "SET edit=0,edit0='',progress='APPROVAL',subprogress='' "
							+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("reset to program approval - " + rowsAffected + " row");
					}
					else{
						sql = "UPDATE tblfnd SET edit=1,edit0='',edit1=?,edit2=?,progress='MODIFY' "
							+ "WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
						ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
						ps.setString(3,campus);
						ps.setString(4,kix);
						rowsAffected = ps.executeUpdate();
						if (debug) logger.info("reset to program modify - " + rowsAffected + " row");
					}

					// move review history to backup table then clear the active table
					sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					if (debug) logger.info("move history data - " + rowsAffected + " row");

					sql = "DELETE FROM tblReviewHist WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// if reviews were done during the approval process, put the task back to Approve outline for the
					// currentApprover kicking off the review. Task and message should be directed to currentApprover and not proposer
					// it's possible that the currentApprover is not known so we send null to the function to at least determine
					// if the approval process is in flight.

					// because the review process within approval removed the task for the person kicking off the review
					// then send back to the person requesting the review to start approving.
					MailerDB mailerDB = null;

					if (debug) logger.info("reviewInApproval - " + reviewInApproval);

					if (reviewInApproval){

						if (currentApprover != null && currentApprover.length() > 0)
							mailerDB = new MailerDB(conn,
															user,
															currentApprover,
															Constant.BLANK,
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailFndReviewCompleted",
															kix,
															user);

						rowsAffected = TaskDB.logTask(conn,
																currentApprover,
																user,
																alpha,
																num,
																Constant.FND_APPROVAL_TEXT,
																campus,
																"Approve process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.FOUNDATION);
						if (debug){
							logger.info("reviewInApproval - mail sent to - " + currentApprover);
							logger.info("reviewInApproval - task created for - " + currentApprover);
						}
					}
					else{
						rowsAffected = TaskDB.logTask(conn,
																proposer,
																proposer,
																alpha,
																num,
																Constant.FND_MODIFY_TEXT,
																campus,
																"Review process",
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_REVIEWER,
																kix,
																Constant.FOUNDATION);
						mailerDB = new MailerDB(conn,
														user,
														proposer,
														Constant.BLANK,
														Constant.BLANK,
														alpha,
														num,
														campus,
														"emailFndReviewCompleted",
														kix,
														user);

						if (debug){
							logger.info("reviewInApproval - mail sent to - " + proposer);
							logger.info("reviewInApproval - task created for - " + proposer);
						}
					}
				} // endTask

			} // rowsAffected

			if (debug) logger.info("------------------------ endReviewerTask - END");

		} catch (SQLException e) {
			logger.fatal("FndDB.endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		} catch (Exception e) {
			logger.fatal("FndDB.endReviewerTask - " + e.toString());
			msg.setMsg("Exception");
		}

		return msg;
	}

	/**
	 * showByUserProgress - show outlines by user and outline progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	progress	String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showByUserProgress(Connection conn,
																	String campus,
																	String user,
																	String progress,
																	String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String subprogress = "";

		boolean found = false;
		boolean showLink = false;

		try{
			String sql = "";
			PreparedStatement ps = null;

			if (user == null || user.length() == 0){
				// as administrators, show all modify/approval progress
				// so they may edit enabled items.
				sql = "SELECT distinct historyid, CourseAlpha, CourseNum, coursetitle, subprogress " +
					"FROM tblfnd WHERE campus=? AND (progress=? OR progress=?) " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.FND_MODIFY_TEXT);
				ps.setString(3,Constant.FND_APPROVAL_TEXT);
			}
			else{
				// when in review, make sure to include review in approval (SQL is different)
				// when in review in approval, don't include proposer's name
				if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					sql = "SELECT distinct historyid, CourseAlpha, CourseNum, coursetitle, subprogress " +
						"FROM tblfnd WHERE campus=? AND proposer=? " +
						"AND progress=? ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
				}
				else if (progress.equals(Constant.FND_REVIEW_IN_APPROVAL)){
					sql = "SELECT distinct historyid, CourseAlpha, CourseNum, coursetitle, subprogress " +
							"FROM tblfnd WHERE campus=? " +
							"AND (progress=? AND subprogress=?) ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,Constant.FND_APPROVAL_TEXT);
					ps.setString(3,Constant.FND_REVIEW_IN_APPROVAL);
				}
				else{
					sql = "SELECT distinct historyid, CourseAlpha, CourseNum, coursetitle, subprogress " +
						"FROM tblfnd WHERE campus=? " +
						"AND proposer=? AND Progress=? ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
				}
			}
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				showLink = true;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				// prevent proposer from cancelling reviews kicked off by approver
				if (subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL) || subprogress.equals(Constant.FND_REVIEW_IN_DELETE)){
					String currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					if (currentApprover != null && !currentApprover.equals(user))
						showLink = false;
				}

				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;

				if (showLink){
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showByUserProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Outline does not exist for this request</li></ul>";
	} // showByUserProgress

	/*
	 * Returns true if the program exists in a particular type and campus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	type		String
	 * <p>
	 */
	public static boolean existByTypeCampus(Connection conn,String campus,String kix,String type) throws SQLException {

		boolean found = false;
		boolean debug = false;

		try {
			// unlike courses, programs are based on titles, degrees, and divisions

			String[] info = getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			if(info != null){

				if (debug){
					logger.info("campus: " + campus);
					logger.info("kix: " + kix);
					logger.info("alpha: " + alpha);
					logger.info("num: " + num);
					logger.info("type: " + type);
				}

				String sql = "SELECT type FROM tblfnd WHERE campus=? AND coursealpha=? AND coursenum=? AND type=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,alpha);
				ps.setString(3,num);
				ps.setString(4,type);
				ResultSet rs = ps.executeQuery();
				found = rs.next();
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("Fnd.programExistByTypeCampus - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Fnd.programExistByTypeCampus - " + e.toString());
		}

		return found;
	}

	/*
	 * cancelReview
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	user		String
	 * @param	level		int
	 * <p>
	 */

	public static Msg cancelReview(Connection conn,String campus,String kix,String user,int level) throws Exception {

		//Logger logger = Logger.getLogger("test");

		/*
		 * Cancellation requires the following:
		 *
		 * 0) Must be in review process
		 * 1) Must be proposer or approver sending out review in approval
		 * 2) Cannot have any comments in the system (tblReviewHist)
		 * 3) Remove tasks
		 * 4) Notify reviewers
		 */

		int rowsAffected = 0;
		int i = 0;
		Msg msg = new Msg();
		String SQL = "";

		String alpha = "";
		String num = "";

		PreparedStatement ps;
		StringBuffer errorLog = new StringBuffer();

		String proposer = null;
		String progress = null;
		String subprogress = null;
		String currentApprover = null;
		String cancelReviewAnyTime = null;

		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"FndDB");

			if (debug) logger.info("------------------- cancelReview - START");

			String[] info = getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			proposer = info[Constant.KIX_PROPOSER];
			progress = info[Constant.KIX_PROGRESS];
			subprogress = info[Constant.KIX_SUBPROGRESS];

			//
			// REVIEW_IN_REVIEW
			//
			if(level==0){
				level = 1;
			}

			if (debug){
				logger.info("campus: " + campus);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("user: " + user);
				logger.info("proposer: " + proposer);
				logger.info("progress: " + progress);
				logger.info("subprogress: " + subprogress);
				logger.info("level: " + level);
			}

			// 0
			if (progress.equals(Constant.FND_REVIEW_PROGRESS) || subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL)){

				currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
				cancelReviewAnyTime = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","CancelReviewAnyTime");

				if (debug){
					logger.info("currentApprover: " + currentApprover);
					logger.info("cancelReviewAnyTime: " + cancelReviewAnyTime);
				}

				// 1
				String allowReviewInReview = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowReviewInReview");
				if (proposer.equals(user) || currentApprover.equals(user) || (level > 1 && allowReviewInReview.equals(Constant.ON))){

					if(debug) logger.info("step 1 checked");

					// 2
					if (cancelReviewAnyTime.equals(Constant.ON) || !HistoryDB.reviewStarted(conn,campus,alpha,num,user)){

						if(debug) logger.info("step 2 checked");

						//
						// when level is > 1, we have REVIEW_IN_REVIEW and so don't update course
						//
						if(level == 1){

							if(debug) logger.info("level 1 = proposer");

							if (progress.equals(Constant.FND_REVIEW_PROGRESS)){

								if(debug)  logger.info("level 1 review");

								SQL = "UPDATE tblfnd SET edit=1,progress='MODIFY',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
									"WHERE campus=? AND coursealpha=? AND coursenum=? AND type='PRE'";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
								ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
								ps.setString(3,campus);
								ps.setString(4,alpha);
								ps.setString(5,num);
								rowsAffected = ps.executeUpdate();
							}
							else if (subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL)){

								if(debug)  logger.info("level 1 review in approval");

								SQL = "UPDATE tblfnd SET edit=0,progress='APPROVAL',reviewdate=null,edit1=?,edit2=?,subprogress='' " +
									"WHERE campus=? AND coursealpha=? AND coursenum=? AND type='PRE'";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,MiscDB.getProgramEdit1(conn,kix));
								ps.setString(2,MiscDB.getProgramEdit2(conn,kix));
								ps.setString(3,campus);
								ps.setString(4,alpha);
								ps.setString(5,num);
								rowsAffected = ps.executeUpdate();
							} // update
							if (debug) logger.info("reset course to modify status - " + rowsAffected + " rows");
						} // level == 1

						//
						// remove reviewer task
						// first, determine who is attempting to cancel. if level == 1, then proposer, or approver.
						// if so, remove all. only level above 1 requires limited removal
						//
						int reviewLevel = level;
						if(reviewLevel == 1){
							reviewLevel = Constant.ALL_REVIEWERS;
						}

						String reviewers = ReviewerDB.getReviewerNames(conn,campus,alpha,num,user,reviewLevel,kix);
						if (debug) logger.info("reviewers: " + reviewers);
						if (reviewers != null && !(Constant.BLANK).equals(reviewers)){
							String[] tasks = new String[100];
							tasks = reviewers.split(",");
							for (i=0; i<tasks.length; i++) {

								rowsAffected = TaskDB.logTask(conn,
																		tasks[i],
																		tasks[i],
																		alpha,
																		num,
																		Constant.COURSE_REVIEW_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_REVIEWER,
																		kix,
																		Constant.FOUNDATION);

								rowsAffected = TaskDB.logTask(conn,
																		tasks[i],
																		tasks[i],
																		alpha,
																		num,
																		Constant.FND_REVIEW_TEXT_NEW,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_REVIEWER,
																		kix,
																		Constant.FOUNDATION);

								rowsAffected = TaskDB.logTask(conn,
																		tasks[i],
																		tasks[i],
																		alpha,
																		num,
																		Constant.FND_REVIEW_TEXT_EXISTING,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_REVIEWER,
																		kix,
																		Constant.FOUNDATION);

								SQL = "DELETE FROM tblReviewers WHERE campus=? AND coursealpha=? AND coursenum=? AND userid=?";
								ps = conn.prepareStatement(SQL);
								ps.setString(1,campus);
								ps.setString(2,alpha);
								ps.setString(3,num);
								ps.setString(4,tasks[i]);
								rowsAffected = ps.executeUpdate();

								AseUtil.logAction(conn,tasks[i],"REMOVE","Review task removed",alpha,num,campus,kix);

								if (debug) logger.info("remove task for reviewer: " + tasks[i] + " - " + rowsAffected + " rows");
							}

							// notify reviewers
							DistributionDB.notifyDistribution(conn,campus,alpha,num,"",user,reviewers,"","emailOutlineCancelReview","",user);

						} // !(Constant.BLANK).equals(reviewers)

						//
						// update review history
						//
						if(level == 1){
							SQL = "INSERT INTO tblReviewHist2 "
									+ "(id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled ) "
									+ "SELECT id, historyid, campus, coursealpha, coursenum,item, dte, reviewer, comments, source, acktion,enabled "
									+ "FROM tblReviewHist "
									+ "WHERE campus=? AND "
									+ "CourseAlpha=? AND "
									+ "CourseNum=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							rowsAffected = ps.executeUpdate();
							if (debug) logger.info("moved review to backup history - " + rowsAffected + " rows");

							SQL = "DELETE FROM tblReviewHist WHERE campus=? AND coursealpha=? AND coursenum=?";
							ps = conn.prepareStatement(SQL);
							ps.setString(1,campus);
							ps.setString(2,alpha);
							ps.setString(3,num);
							rowsAffected = ps.executeUpdate();
							if (debug) logger.info("delete reviews from active table - " + rowsAffected + " rows");

							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	num,
																	Constant.COURSE_REVIEW_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	"REMOVE",
																	Constant.PRE);
							if (debug) logger.info("remove review task - " + rowsAffected + " rows");

							if (progress.equals(Constant.FND_REVIEW_PROGRESS))
								rowsAffected = TaskDB.logTask(conn,
																		user,
																		user,
																		alpha,
																		num,
																		Constant.FND_MODIFY_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_REVIEWER,
																		kix,
																		Constant.FOUNDATION);
							else
								rowsAffected = TaskDB.logTask(conn,
																		user,
																		user,
																		alpha,
																		num,
																		Constant.FND_APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_ADD,
																		Constant.PRE,
																		proposer,
																		Constant.TASK_REVIEWER,
																		kix,
																		Constant.FOUNDATION);


							if (debug) logger.info("recreate task for proposer - " + rowsAffected + " rows");

							AseUtil.logAction(conn,user,"ACTION","Course review cancelled",alpha,num,campus,kix);

						}
						else{
							AseUtil.logAction(conn,user,"ACTION","Course review in review cancelled",alpha,num,campus,kix);
						}
						// level 1


					}
					else{
						msg.setMsg("OutlineReviewStarted");
						if (debug) logger.info("Review started by reviewers.");
					}  // 2
				}
				else{
					msg.setMsg("OutlineProposerCanCancel");
					if (debug) logger.info("Attempting to cancel when not proposer of outline.");
				}  // 1
			}
			else{
				msg.setMsg("OutlineNotInReviewStatus");
				if (debug) logger.info("Attempting to cancel outline review that is not cancellable.");
			} // 0

		} catch (SQLException ex) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("FndDB.cancelReview - " + ex.toString() + " - " + errorLog.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			msg.setErrorLog(errorLog.toString());
			logger.fatal("FndDB.cancelReview - " + e.toString() + " - " + errorLog.toString());
		}

		if (debug) logger.info("------------------- cancelReview - END");

		return msg;
	}

	/*
	 * Is this program reviewable? If so, is this the proposer? Only proposer can invite.
	 * progress = review or modify or review in approval
	 * review requested = proposer
	 * <p>
	 * @param	connection
	 * @param	campus
	 * @param	kix
	 * @param	user
	 * <p>
	 * @return boolean
	 */
	public static boolean reviewable(Connection conn,String campus,String kix,String user) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean reviewable = false;
		String proposer = "";
		String progress = "";
		String subprogress = "";

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"FndDB");

			if (debug){
				logger.info("---------->");
				logger.info("reviewable");
				logger.info("---------->");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("user: " + user);
			}

			String sql = "SELECT proposer,progress,subprogress FROM tblfnd WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				proposer = AseUtil.nullToBlank(rs.getString(1));
				progress = AseUtil.nullToBlank(rs.getString(2));
				subprogress = AseUtil.nullToBlank(rs.getString(3));
			}
			rs.close();
			ps.close();

			String coproposer = getFndItem(conn,kix,"coproposer");

			String currentApprover = ApproverDB.getCurrentFndApprover(conn,campus,kix);
			if (currentApprover == null){
				currentApprover = Constant.BLANK;
			}

			// if the proposer and modify or review or review in approval
			// else if current approver and approval or delete
			if ((user.equals(proposer) || coproposer.contains(user))
					&& (		progress.equals(Constant.FND_MODIFY_PROGRESS)
							|| progress.equals(Constant.FND_REVIEW_PROGRESS)
							|| subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL))){
				reviewable = true;
			}
			else if (	(	progress.equals(Constant.FND_APPROVAL_PROGRESS) || progress.equals(Constant.FND_DELETE_PROGRESS))
						||
						user.equals(currentApprover)
				){
				reviewable = true;
			}
			else{
				reviewable = false;
			}

			if (debug){
				logger.info("<----------");
				logger.info("reviewable");
				logger.info("<----------");
				logger.info("reviewable: " + reviewable);
				logger.info("proposer: " + proposer);
				logger.info("coproposer: " + coproposer);
				logger.info("progress: " + progress);
				logger.info("subprogress: " + subprogress);
				logger.info("currentApprover: " + currentApprover);
			}

		} catch (SQLException e) {
			logger.fatal("FndDB.reviewable - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.reviewable - " + e.toString());
		}

		return reviewable;
	}

	/*
	 * getKix
	 *	<p>
	 *	@return String
	 */
	public static String getKix(Connection conn,String campus,String alpha,String num,String type) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String kix = "";

		try {
			String sql = "SELECT historyid FROM tblfnd WHERE campus=? AND coursealpha=? AND coursenum=? AND type=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.getKix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getKix - " + e.toString());
		}

		return kix;
	}

	/*
	 * Determines if user is allowed to review a course and that it is not yet expired
	 * <p>
	 *	@param conn		Connection
	 *	@param campus	String
	 *	@param alpha	String
	 *	@param num		String
	 *	@param user		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isReviewer(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean reviewer = false;
		boolean debug = false;

		int counter = 0;

		try {

			debug = DebugDB.getDebug(conn,"FndDB");

			if (debug){
				logger.info("--------->");
				logger.info("isReviewer");
				logger.info("--------->");
			}

			String table = "tblReviewers tbr INNER JOIN tblfnd tc ON "
					+ "(tbr.campus = tc.campus) AND "
					+ "(tbr.coursenum = tc.CourseNum) AND "
					+ "(tbr.coursealpha = tc.CourseAlpha) ";

			String where = "GROUP BY tbr.coursealpha,tbr.coursenum,tc.type,tbr.userid,tc.reviewdate "
					+ "HAVING (tbr.coursealpha='"
					+ alpha
					+ "' AND  "
					+ "tbr.coursenum='"
					+ num
					+ "' AND  "
					+ "tc.type='PRE' AND  "
					+ "tbr.userid='"
					+ user
					+ "' AND "
					+ "tc.reviewdate >= " + DateUtility.getSystemDateSQL("yyyy-MM-dd") + ")";

			counter = (int) AseUtil.countRecords(conn,table,where);

			if (debug) logger.info("counter: " + counter);

			if (counter > 0)
				reviewer = true;

			if (debug){
				logger.info("<---------");
				logger.info("isReviewer");
				logger.info("<---------");
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: isReviewer - " + e.toString());
		}

		return reviewer;
	}

	/*
	 * getFoundations
	 * <p>
	 * @param	conn		Connection
	 * @param	fndtype	String
	 * @param	sq			int
	 * @param	en			int
	 * @param	qn			int
	 * <p>
	 * @return 	String
	 */
	public static String getFoundations(Connection conn,String fndtype,int sq,int en,int qn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String rtn = "";

		try {
			String sql = "SELECT hallmark, explanatory, question FROM tblfnditems WHERE type=? AND seq=? AND en=? AND qn=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,fndtype);
			ps.setInt(2,sq);
			ps.setInt(3,en);
			ps.setInt(4,qn);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				String hallmark = AseUtil.nullToBlank(rs.getString("hallmark"));
				String explanatory = AseUtil.nullToBlank(rs.getString("explanatory"));
				String question = AseUtil.nullToBlank(rs.getString("question"));

				if(en == 0 && qn == 0){
					rtn = hallmark;
				}
				else if(en > 0 && qn == 0){
					rtn = explanatory;
				}
				else if(en > 0 && qn > 0){
					rtn = question;
				}
			} // while
			rs.close();
			ps.close();


		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundations - " + e.toString());
		}

		return rtn;
	}

	/*
	 * getFoundations
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	kix		String
	 * @param	mode		int
	 * @param	user		String
	 * <p>
	 * @return 	Msg
	 */
	public static Msg reviewFnd(Connection conn,
												String campus,
												String alpha,
												String num,
												String kix,
												int mode,
												String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer outline = new StringBuffer();

		Msg msg = new Msg();

		int fid = 0;
		int mid = 0;
		long reviewerComments = 0;

		String caller = "fndrvwer";
		String bookmark = "";
		String linkedKey = "";

		try{

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			String fndtype = fnd.getFndItem(conn,kix,"fndtype");

			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");

			if (enableMessageBoard.equals(Constant.ON)){
				fid = ForumDB.getForumID(conn,campus,kix);
			}

			int j = 0;

			int savedSQ = 1;
			String question = "";
			String data = "";

			for(com.ase.aseutil.Generic fd: fnd.getCourseFoundation(conn,kix)){

				String fld = fd.getString6();

				int sq = NumericUtil.getInt(fd.getString1(),0);
				int en = NumericUtil.getInt(fd.getString2(),0);
				int qn = NumericUtil.getInt(fd.getString3(),0);

				//
				// underscore separates for data for break apart in JS during popup
				// dashes for use as bookmarks
				//
				String linkRef = fd.getString1() + "_" + fd.getString2() + "_" + fd.getString3();
				String bookmarkRef = fd.getString1() + "-" + fd.getString2() + "-" + fd.getString3();

				if(en > 0 || qn > 0){
					if (enableMessageBoard.equals(Constant.OFF)){
						reviewerComments = ReviewerDB.countFndComments(conn,kix,sq,en,qn,0);
					}
					else{
						mid = ForumDB.getTopLevelPostingMessage(conn,fid,j+1);
						reviewerComments = ForumDB.countPostsToForum(conn,kix,sq,en,qn);
					}
				}

				bookmark = "c"+Constant.TAB_FOUNDATION+"-" + bookmarkRef;

				//
				// create links
				//
				String temp = "";

				if (enableMessageBoard.equals(Constant.OFF)){
					temp += "<a href=\"fndcmnt.jsp?c="+Constant.TAB_FOUNDATION+"&md=" + mode + "&kix=" + kix + "&sq=" + sq + "&en=" + en + "&qn=" + qn  + "&fndtype=" + fndtype + "\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;";
				}
				else{
					temp += "<a href=\"forum/post.jsp?src=USR&rtn="+caller+"&tab="+Constant.TAB_FOUNDATION+"&fid="+fid+"&mid="+mid+"&item="+sq+"&kix="+kix+"&level=2&bookmark="+bookmark+"\"><img src=\"../images/comment.gif\" title=\"add/edit comments\" alt=\"add/edit comments\" id=\"add_comments\" /></a>&nbsp;";
				}

				linkedKey = Constant.TAB_FOUNDATION + "_" + linkRef + "_" + bookmark;
				temp += "<a class=\"popupItem\" id=\""+linkedKey+"\" href='##'><img src=\"../images/flash.gif\" title=\"quick comments\" alt=\"quick comments\" id=\"quick_comments\" /></a>&nbsp;";

				if (reviewerComments > 0){
					if (enableMessageBoard.equals(Constant.OFF)){
						temp += "<a href=\"crsrvwcmnts.jsp?c="+Constant.TAB_FOUNDATION+"&md=0&kix=" + kix + "&sq=" + sq + "&en=" + en  + "&qn=" + qn + "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;"
							+ "(<a name=\""+bookmark+"\" class=\"bookmark\">" + reviewerComments + "</a>" + ")";
					}
					else{
						temp += "<a href=\"./forum/prt.jsp?fid="+fid+"&mid=0&itm="+sq + "&sq=" + sq + "&en=" + en + "&qn=" + qn + "\" onclick=\"asePopUpWindow(this.href,'aseWinCrsrvwcmnts','800','600','yes','center');return false\" onfocus=\"this.blur()\"><img src=\"images/comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" /></a>&nbsp;"
							+ "(<a name=\""+bookmark+"\" class=\"bookmark\">" + reviewerComments + "</a>" + ")";
					}
				}
				else{
					temp += "<img src=\"images/no-comment.gif\" title=\"view comments\" alt=\"view comments\" id=\"review_comments\" />&nbsp;("
						+ "<a name=\""+bookmark+"\" class=\"bookmark\">" + reviewerComments + "</a>" + ")";
				}

				//
				// show data
				//
				if(en > 0 || qn > 0){
					question = ""
						+ "						<div class=\"panel-body alignleft\">"
						+ "							<div id=\"questionDiv\">"
						+ "								<div id=\"questionDivLeft\">&nbsp;</div>"
						+ "								<div id=\"questionDivRight\">"
						+ 										temp + " " + fd.getString4()
						+ "								</div>"
						+ "							</div>"
						+ "							<div class=\"new_line_padded\">"
						+ "						</div>";

					data = ""
						+ "						<div class=\"alignleft\">"
						+ "							<div>"
						+ "								<div>"+fd.getString5()+"</div>"
						+ "								<div class=\"new_line_padded\"></div>"
						+ "							</div>"
						+ "						</div>"
						+ "						</div>"
						+ "						<div class=\"new_line_padded\"></div>";

				}
				else{
					if(savedSQ != sq){
						savedSQ = sq;

						question = "   </div>"
								+ " </div>";

						outline.append(question);
					}

					question = "<div class=\"bs-example\">"
							+ "   <div class=\"panel panel-primary\">"
							+ "    <div class=\"panel-heading alignleft\">"
							+ "       <h3 class=\"panel-title\">" + sq + ". " + fd.getString4() + "</h3>"
							+ "     </div>";
				}

				outline.append("<div id=\""+fld+"\">" + question + "</div> ");

				if(en > 0 || qn > 0){
					outline.append("<div id=\""+fld+"\">" + data + "</div> ");
				}

				j++;

			} // for

			outline.append("<div class=\"alignleft\"><br/><button name=\"cmdViewComments\" id=\"cmdViewComments\" title=\"view comments\" type=\"button\" class=\"btn btn-primary btn-sm\">View Comments</button>&nbsp;&nbsp;");

			//
			// for REVIEW_IN_REVIEW, show appropriate buttons
			//
			int reviewerLevel = 0;
			int inviterLevel = 0;
			String allowReviewInReview = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowReviewInReview");
			if(allowReviewInReview.equals(Constant.ON)){
				reviewerLevel = ReviewerDB.getReviewerLevel(conn,kix,user);
				inviterLevel = ReviewerDB.getInviterLevel(conn,kix,user);
			}

			// during proposer requested review, we only display link to say finish.
			// during approver requested review, we have buttons for voting only if the system setting is on.
			String subProgress = fnd.getFndItem(conn,kix,"subprogress");
			String reviewerWithinApprovalCanVote = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ReviewerWithinApprovalCanVote");
			if (	(mode==Constant.REVIEW && !(Constant.FND_REVIEW_IN_APPROVAL).equals(subProgress))
					||
					(	mode==Constant.REVIEW_IN_APPROVAL
						&& (Constant.FND_REVIEW_IN_APPROVAL).equals(subProgress)
						&& (Constant.OFF).equals(reviewerWithinApprovalCanVote)
					)
			){

				//
				// if this is REVIEW_IN_REVIEW and there are reviews remaining, don't allow the inviter to finish
				//
				if(allowReviewInReview.equals(Constant.ON) && inviterLevel > 1){
					//outline.append("&nbsp;&nbsp;<a href=\'fndrvwerx.jsp?f=1&kix=" + kix + "\' disabled class=\'buttonDisabled\'><span>I'm finished</span></a>");
					outline.append("<button disabled name=\"cmdFinish\" id=\"cmdFinish\" title=\"attach/upload documents\" type=\"button\" class=\"btn btn-success btn-sm\">I'm finished</button>");
				}
				else{
					//outline.append("&nbsp;&nbsp;<a href=\'fndrvwerx.jsp?f=1&kix=" + kix + "\' class=\'button\'><span>I'm finished</span></a>");
					outline.append("<button name=\"cmdFinish\" id=\"cmdFinish\" title=\"attach/upload documents\" type=\"button\" class=\"btn btn-success btn-sm\">I'm finished</button>");

				}

			}

			//
			// if this is REVIEW_IN_REVIEW turn on invite button for reviewers only.
			// proposer must use the menu option
			//
			String proposer = fnd.getFndItem(conn,kix,"proposer");

			if(allowReviewInReview.equals(Constant.ON) && !user.equals(proposer)){

				String originalReviewByDate = fnd.getFndItem(conn,kix,"reviewdate");

				// add 1 to indicate this is the next level up for reviewers inviting people to review
				//outline.append("&nbsp;&nbsp;<a href=\'crsrvw.jsp?kix=" + kix + "&rl="+(reviewerLevel+1)+"\' class=\'button\'><span>Invite reviewers</span></a>")

				outline.append("&nbsp;&nbsp;<button name=\"cmdInviteReviewers\" id=\"cmdInviteReviewers\" title=\"Invice reviewers\" type=\"button\" class=\"btn btn-primary btn-sm\">Invite reviewers</button>")
					.append("<br><br><br>The following is applicable to review within review:<br>")
					.append("<ul>")
					.append("<li>Proposers may not invite reviewers from this screen</li>")
					.append("<li>'I'm finished' is availalbe only after all your reviewers have completed their reviews</li>")
					.append("<li>Review due date may not be later than " + originalReviewByDate + " </li>")
					.append("<ul>");
			}


			//
			// close the button div
			//
			outline.append("</div>");

			outline.append("</p>");

			fnd = null;

		}
		catch( SQLException e ){
			msg.setMsg("Exception");
			logger.fatal("FndDB.reviewFnd ("+kix+"): " + e.toString());
		}
		catch( Exception e ){
			msg.setMsg("Exception");
			logger.fatal("FndDB.reviewFnd ("+kix+"): " + e.toString());
		}

		msg.setErrorLog(outline.toString());

		return msg;

	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String footerStatus(Connection conn,String kix,String type) {

		String footerStatus = "";

		try{
			if(type.equals("ARC")){
				footerStatus = "Archived on " + getFndItem(conn,kix,"dateapproved");
			}
			else if(type.equals("CUR")){
				footerStatus = "Approved on " + getFndItem(conn,kix,"dateapproved");
			}
			else if(type.equals("PRE")){
				footerStatus = "Last modified on " + getFndItem(conn,kix,"auditdate");
			}
		}
		catch(Exception e){
			logger.fatal("footerStatus ("+kix+"/"+type+"): " + e.toString());
		}

		return footerStatus;
	}

	/*
	 * approveReview
	 *	<p>
	 *	@param	Connection	connection
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		user
	 * @param	bollean		approval
	 * @param	String		comments
	 * @param	int			voteFor
	 * @param	int			voteAgainst
	 * @param	int			voteAbstain
	 *	<p>
	 *	@return int
	 */
	public static int approveReview(Connection conn,
														String campus,
														String kix,
														String alpha,
														String num,
														String user,
														String comments,
														int voteFor,
														int voteAgainst,
														int voteAbstain) throws Exception {
		int rowsAffected = 0;

		try{
			// because this is reviews within an approval, we don't have the ability to approve
			// so set the approved flag to FALSE.

			int sequence = ApproverDB.getSequenceNotApproved(conn,campus,kix);

			String inviter = TaskDB.getInviter(conn,campus,alpha,num,user);

			if (!HistoryDB.isMatch(conn,campus,kix,user,inviter)){
				rowsAffected = HistoryDB.addHistory(conn,
													alpha,
													num,
													campus,
													user,
													CourseApproval.getNextSequenceNumber(conn),
													false,
													comments,
													kix,
													sequence,
													voteFor,
													voteAgainst,
													voteAbstain,
													inviter,
													Constant.TASK_REVIEWER,
													Constant.COURSE_REVIEW_TEXT);
			}
			else{
				rowsAffected = HistoryDB.updateHistory(conn,campus,user,comments,kix,voteFor,voteAgainst,voteAbstain,inviter);
			}

		}
		catch(Exception e){
			logger.fatal("FndDB.approveReview - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getHallmarks
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getHallmarks(Connection conn,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT d.fld, i.hallmark "
					+ "FROM tblfnddata as d RIGHT OUTER JOIN tblfnditems i ON d.fld = i.fld "
					+ "WHERE (d.id = ?) and i.en = 0 and i.qn = 0 ORDER BY d.fld";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					String fld = AseUtil.nullToBlank(rs.getString("fld"));
					String hallmark = AseUtil.nullToBlank(rs.getString("hallmark"));

					genericData.add(new Generic(
											fld,
											hallmark,
											"",
											"",
											"",
											"",
											"",
											"",
											"",
											""
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getHallmarks - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getHallmarks - " + e.toString());
			return null;
		}

		return genericData;
	}

	/**
	 * getLinkedItems - returns sql for linked src
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	id			int
	 * @param	kix		String
	 * @param	src		String
	 * @param	print		boolean
	 * <p>
	 * @return	String
	 */
	public static String getLinkedItems(Connection conn,String campus,String user,int id,String kix,String src,boolean print) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		String temp = "";
		String sql = "";
		StringBuffer buf = new StringBuffer();
		StringBuffer legend = new StringBuffer();

		String rowColor = "";

		String checked = "";
		String field = "";
		String xiAxis = "";
		String yiAxis = "";

		int iHallmarks = 0;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"LinkedUtil");

			if (debug) logger.info("getLinkedItems - START");

			String server = SysDB.getSys(conn,"server");

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			//
			// for legend
			//
			legend.append("<hr size=\"1\" noshade=\"\"><br>LEGEND<br/><ol>");
			for(com.ase.aseutil.Generic fd: fnd.getHallmarks(conn,id)){
				legend.append("<li class=\"normaltext\">"+fd.getString2()+"</li>");
				++iHallmarks;
			}
			legend.append("</ol>");

			//
			// display header line (items for linking)
			//
			if(!print){
				buf.append("<form name=\"aseForm\" method=\"post\" action=\"/central/servlet/linker?arg=fnd\">");
			}

			buf.append("<table summary=\"\" id=\"tableLinkedFoundationItems\" border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"8\"><tbody>"
					+ "<tr bgcolor=\"#E1E1E1\">"
					+ "<td class=\"textblackTH\" valign=\"top\">&nbsp;SLO / Hallmarks</td>");

			for (int j = 0; j < iHallmarks; j++){
				buf.append("<td class=\"textblackTH\" valign=\"top\" width=\"03%\">"+(j+1)+"</td>");
				if(j > 0){
					xiAxis += ",";
				}
				xiAxis += "" + (j+1);
			} // next j

			buf.append("</tr>");

			//
			// show matrix. keep in mind the kix we need for SLOs is the course kix and not the
			// the foundation kix
			//
			String[] info = getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			info = Helper.getKixRoute(conn,campus,alpha,num,"CUR");
			String courseKix = info[0];

			ArrayList list = CompDB.getCompsByKix(conn,courseKix);
			if ( list != null ){
				Comp comp;
				for (int i = 0; i<list.size(); i++){
					comp = (Comp)list.get(i);

					if(i > 0){
						yiAxis += ",";
					}
					yiAxis += "" + comp.getID();

					// alternating
					if (i % 2 == 0){
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					}
					else{
						rowColor = Constant.ODD_ROW_BGCOLOR;
					}

					// data row
					buf.append("<tr bgcolor=\""+rowColor+"\">"
						+ "<td class=\"datacolumn\" valign=\"top\">"+comp.getComp()+"</td>");

					for (int j = 0; j < iHallmarks; j++){

						checked = "";
						if(isChecked(conn,campus,id,NumericUtil.getInt(comp.getID(),0),(j+1))){
							checked = "checked";
						}

						field = comp.getID() + "_" + (j+1);

						if(!print){
							buf.append("<td valign=\"top\" width=\"03%\">"
								+ "<input type=\"checkbox\" "+checked+" name=\""+field+"\" value=\"1\">"
								+ "</td>");
						}
						else{
							if(checked.equals("")){
								buf.append("<td valign=\"top\" width=\"03%\">"
									+ "&nbsp;"
									+ "</td>");
							}
							else{
								buf.append("<td valign=\"top\" width=\"03%\">"
									+ "<img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" />"
									+ "</td>");
							}
						}

					} // next j

					buf.append("</tr>");

				} // for comp

			} // list not null


			buf.append("</tbody></table>");

			if(!print){
				buf.append("<input type=\"hidden\" value=\""+id+"\" name=\"id\" id=\"id\">"
				+ "<input type=\"hidden\" value=\""+kix+"\" name=\"kix\" id=\"kix\">"
				+ "<input type=\"hidden\" value=\""+src+"\" name=\"src\" id=\"src\">"
				+ "<input type=\"hidden\" value=\""+xiAxis+"\" name=\"xiAxis\" id=\"xiAxis\">"
				+ "<input type=\"hidden\" value=\""+yiAxis+"\" name=\"yiAxis\" id=\"yiAxis\">"
				+ "<hr size=\"1\" noshade><p align=\"right\">"
				+ "<input type=\"submit\" class=\"input\" name=\"aseSubmit\" value=\"Submit\" title=\"save data\">&nbsp;&nbsp;"
				+ "<input type=\"submit\" class=\"input\" name=\"aseCancel\" value=\"Cancel\" title=\"abort selected operation\" onClick=\"return cancelMatrixForm()\">"
				+ "</p>"
				+ "</form>");
			}

			temp = buf.toString() + legend.toString();

			fnd = null;

			if (debug) logger.info("getLinkedItems - END");

		} catch (Exception e) {
			logger.fatal("FndDB.getLinkedItems - " + e.toString());
		}

		return temp;
	}

	/**
	 * isChecked
	 * <p>
	 * @param conn		Connection
	 * @param campus	String
	 * @param id		int
	 * @param srcid	int
	 * @param fndid	int
	 * <p>
	 * @return boolean
	 */
	public static boolean isChecked(Connection conn,String campus,int id,int srcid,int fndid) throws SQLException {

		boolean checked = false;

		try {

			String sql = "SELECT id FROM tblfndlinked WHERE campus=? AND id=? AND srcid=? AND fndid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,id);
			ps.setInt(3,srcid);
			ps.setInt(4,fndid);
			ResultSet rs = ps.executeQuery();
			checked = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.isChecked - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.isChecked - " + e.toString());
		}

		return checked;
	}

	/*
	 * isAuthor
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	kix		String
	 * @param	id			int
	 *	<p>
	 *	@return Msg
	 */
	public static boolean isAuthor(Connection conn,String campus,String user,String kix,int id) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		boolean isAuthor = false;

		if(user != null && !user.equals(Constant.BLANK)){
			try {
				String sql = "SELECT proposer,coproposer FROM tblfnd WHERE campus=? AND id=? AND historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,id);
				ps.setString(3,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
					String coproposer = AseUtil.nullToBlank(rs.getString("coproposer"));

					if(user.equals(proposer) || coproposer.contains(user)){
						isAuthor = true;
					}

				}
				rs.close();
				ps.close();
			} catch (SQLException e) {
				logger.fatal("FndDB.isAuthor\n" + kix + "\n" + e.toString());
			} catch (Exception e) {
				logger.fatal("FndDB.isAuthor\n" + kix + "\n" + e.toString());
			}
		}

		return isAuthor;
	}

	/*
	 * deleteFile
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	id			int
	 * @param	seq		int
	 *	<p>
	 *	@return int
	 */
	public static int deleteFile(Connection conn,String campus,String user,int id,int seq) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		if(user != null && !user.equals(Constant.BLANK)){
			try {
				String kix = getFndItem(conn,id,"historyid");

				String[] info = getKixInfo(conn,kix);

				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];

				String filename = getFndFilesItem(conn,id,seq,"originalname");

				String sql = "DELETE FROM tblfndfiles WHERE campus=? AND id=? AND seq=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,id);
				ps.setInt(3,seq);
				rowsAffected = ps.executeUpdate();
				ps.close();

				if(rowsAffected > 0){
					AseUtil.logAction(conn,
								user, "ACTION","Foundation attachment deleted ("+ filename + ")",
								alpha,
								num,
								campus,
								kix);
				}

			} catch (SQLException e) {
				logger.fatal("FndDB.deleteFile\n" + id + "\n" + e.toString());
			} catch (Exception e) {
				logger.fatal("FndDB.deleteFile\n" + id + "\n" + e.toString());
			}
		}

		return rowsAffected;
	}

	/*
	 * getFndFilesItem
	 *	<p>
	 *	@return String
	 */
	public static String getFndFilesItem(Connection conn,int id,int seq,String column) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String item = "";

		try {
			String sql = "SELECT " + column + " FROM tblfndfiles WHERE id=? and seq=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = AseUtil.nullToBlank(rs.getString(column));
			} // rs
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB.getFndFilesItem - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFndFilesItem - " + e.toString());
		}

		return item;
	}

	/*
	 * getNextVersionNumber
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	fid		int
	 * @param	fullName	String
	 *	<p>
	 *	@return int
	 */
	public static int getNextVersionNumber(Connection conn,String campus,int fid,String fullName,int sq,int en,int qn) throws SQLException {

		int version = 0;

		try {
			String sql = "SELECT MAX(version) + 1 AS maxid FROM tblfndfiles "
					+ "WHERE campus=? AND id=? AND originalname=? AND sq=? AND en=? AND qn=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,fid);
			ps.setString(3,fullName);
			ps.setInt(4,sq);
			ps.setInt(5,en);
			ps.setInt(6,qn);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				version = rs.getInt("maxid");

			if (version==0)
				version = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("FndDB: getNextVersionNumber - " + e.toString());
		}

		return version;
	}


	/*
	 * getFoundationSQ
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return 	ArrayList
	 */
	public static ArrayList getFoundationSQ(Connection conn,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		ArrayList<Integer> list = new ArrayList<Integer>();

		try {
			String sql = "SELECT DISTINCT i.seq "
				+ "FROM tblfnddata as d RIGHT OUTER JOIN tblfnditems i ON d.fld = i.fld "
				+ "WHERE (d.id = ?) ORDER BY i.seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(NumericUtil.getInt(rs.getInt("seq"),0));
			} // while
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("FndDB.getFoundationSQ - " + e.toString());
		} catch (Exception e) {
			logger.fatal("FndDB.getFoundationSQ - " + e.toString());
		}

		return list;
	}

	/*
	 * getCourseFoundationBySQ
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getCourseFoundationBySQ(Connection conn,int id,int sqID) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT d.fld, i.hallmark, i.explanatory, i.question, d.data, i.seq, i.en, i.qn "
					+ "FROM tblfnddata as d RIGHT OUTER JOIN tblfnditems i ON d.fld = i.fld "
					+ "WHERE (d.id = ? AND i.seq = ?) ORDER BY d.fld";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ps.setInt(2,sqID);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {

					String fld = AseUtil.nullToBlank(rs.getString("fld"));
					String hallmark = AseUtil.nullToBlank(rs.getString("hallmark"));
					String explanatory = AseUtil.nullToBlank(rs.getString("explanatory"));
					String question = AseUtil.nullToBlank(rs.getString("question"));
					String data = AseUtil.nullToBlank(rs.getString("data"));

					int en = NumericUtil.getInt(rs.getInt("en"),0);
					int qn = NumericUtil.getInt(rs.getInt("qn"),0);

					if(en == 0 && qn == 0){
						question = hallmark;
					}
					else if(en > 0 && qn == 0){
						question = explanatory;
					}
					else if(en > 0 && qn > 0){
						//question = question;
					}

					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("seq")),
											AseUtil.nullToBlank(rs.getString("en")),
											AseUtil.nullToBlank(rs.getString("qn")),
											AseUtil.nullToBlank(question),
											AseUtil.nullToBlank(data),
											fld,
											"",
											"",
											"",
											""
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if

		} catch (SQLException e) {
			logger.fatal("FndDB.getCourseFoundationBySQ - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FndDB.getCourseFoundationBySQ - " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}