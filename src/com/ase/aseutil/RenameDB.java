/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// RenameDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class RenameDB {

	static Logger logger = Logger.getLogger(RenameDB.class.getName());

	public RenameDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param conn			Connection
	 * @param campus		String
	 * @param fromAlpha	String
	 * @param fromNum		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String fromAlpha,String fromNum) throws SQLException {

		String sql = "SELECT historyid FROM tblrename WHERE campus=? AND fromAlpha=? AND fromNum=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,fromAlpha);
		ps.setString(3,fromNum);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * isMatchToOutline
	 * <p>
	 * @param conn			Connection
	 * @param campus		String
	 * @param toAlpha		String
	 * @param toNum		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatchToOutline(Connection conn,String campus,String toAlpha,String toNum) throws SQLException {

		String sql = "SELECT historyid FROM tblrename WHERE campus=? AND toAlpha=? AND toNum=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,toAlpha);
		ps.setString(3,toNum);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

   /**
   * insert
   *
   * @param conn connection
   * @param Rename rename
   *
   * @return int
   *
   */
   public int insert(Connection conn,Rename rename){
      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO tblRename(campus,historyid,proposer,fromAlpha,fromNum,toAlpha,toNum,progress,justification,approvers) VALUES(?,?,?,?,?,?,?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,rename.getCampus());
         ps.setString(2,rename.getHistoryid());
         ps.setString(3,rename.getProposer());
         ps.setString(4,rename.getFromAlpha());
         ps.setString(5,rename.getFromNum());
         ps.setString(6,rename.getToAlpha());
         ps.setString(7,rename.getToNum());
         ps.setString(8,Constant.COURSE_PENDING_TEXT);
         ps.setString(9,rename.getJustification());
         ps.setString(10,rename.getApprovers());
         rowsAffected = ps.executeUpdate();
         ps.close();

			// add justification
			rowsAffected = Outlines.updateReason(conn,
															rename.getHistoryid(),
															"<font class=\"textblackth\">Justification for Rename/Renumber"
															+ "&nbsp;("
															+ rename.getFromAlpha() + " "
															+ rename.getFromNum() + " ==> "
															+ rename.getToAlpha() + " "
															+ rename.getToNum()
															+ ")</font><br/>"
															+ rename.getJustification(),
															rename.getProposer());
      }
      catch(Exception e){
         logger.fatal("Rename.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * update
   *
   * @param conn connection
   * @param Rename rename
   *
   * @return int
   */
   public int update(Connection conn,Rename rename,int id){
      int rowsAffected = 0;

      try{
         String sql = "UPDATE tblRename SET campus=?,historyid=?,proposer=?,fromAlpha=?,fromNum=?,toAlpha=?,toNum=? WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,rename.getCampus());
         ps.setString(2,rename.getHistoryid());
         ps.setString(3,rename.getProposer());
         ps.setString(4,rename.getFromAlpha());
         ps.setString(5,rename.getFromNum());
         ps.setString(6,rename.getToAlpha());
         ps.setString(7,rename.getToNum());
         ps.setInt(8,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.update: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * setProgressToApproval
   *
   * @param conn 	connection
   * @param kix	String
   *
   * @return int
   */
   public static int setProgressToApproval(Connection conn,String kix){

      int rowsAffected = 0;

      try{
         String sql = "UPDATE tblRename SET progress=? WHERE historyid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,Constant.COURSE_APPROVAL_TEXT);
         ps.setString(2,kix);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.setProgressToApproval: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete
   *
   * @param conn connection
   * @param id int
   *
   * @return int
   */
   public int delete(Connection conn,int id){
      int rowsAffected = 0;

      try{
         String sql = "DELETE FROM tblRename WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete
   *
   * @param conn 			connection
   * @param campus		String
   * @param fromAlpha	String
   * @param fromNum		String
   *
   * @return int
   */
   public int delete(Connection conn,String campus,String fromAlpha,String fromNum){
      int rowsAffected = 0;

      try{
         String sql = "DELETE FROM tblRename WHERE campus=? AND fromAlpha=? AND fromNum=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,fromAlpha);
         ps.setString(3,fromNum);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete
   *
   * @param conn 		connection
   * @param campus	String
   * @param kix		String
   *
   * @return int
   */
   public int delete(Connection conn,String campus,String kix){
      int rowsAffected = 0;

      try{
         String sql = "DELETE FROM tblRenamex WHERE historyid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,kix);
         rowsAffected = ps.executeUpdate();
         ps.close();

         sql = "DELETE FROM tblRename WHERE campus=? AND historyid=?";
         ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,kix);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * getRename
   *
   * @param conn 	connection
   * @param kix	String
   *
   * @return Rename
   */
   public Rename getRename(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

      Rename rename = null ;

      try{
         String sql = "SELECT * FROM tblRename WHERE historyid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,kix);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
      		rename = new Rename();
            rename.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
            rename.setHistoryid(kix);
            rename.setProposer(AseUtil.nullToBlank(rs.getString("proposer")));
            rename.setFromAlpha(AseUtil.nullToBlank(rs.getString("fromAlpha")));
            rename.setFromNum(AseUtil.nullToBlank(rs.getString("fromNum")));
            rename.setToAlpha(AseUtil.nullToBlank(rs.getString("toAlpha")));
            rename.setToNum(AseUtil.nullToBlank(rs.getString("toNum")));
            rename.setJustification(AseUtil.nullToBlank(rs.getString("justification")));
            rename.setApprovers(AseUtil.nullToBlank(rs.getString("approvers")));
         }
         rs.close();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.getRename: " + e.toString());
      }

      return rename;

   }

   /**
   * getProposer
   *
   * @param conn 		connection
   * @param campus	String
   * @param kix		String
   *
   * @return String
   */
   public String getProposer(Connection conn,String campus,String kix){

      String proposer = "";

      try{
         String sql = "SELECT proposer FROM tblRename WHERE campus=? AND historyid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,kix);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            proposer = AseUtil.nullToBlank(rs.getString("proposer"));
         }
         rs.close();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.getProposer: " + e.toString());
      }

      return proposer;

   }

   /**
   * getKix - returns the historyid of the course being renamed
   *
   * @param conn		connection
   * @param campus	String
   * @param toAlpha	String
   * @param toNum		String
   *
   * @return String
   */
   public String getKix(Connection conn,String campus,String toAlpha,String toNum){

      String kix = "";

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT historyid FROM tblRename WHERE campus=? AND toAlpha=? AND toNum=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,toAlpha);
         ps.setString(3,toNum);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            kix = AseUtil.nullToBlank(rs.getString("historyid"));
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("Rename.getKix: " + e.toString());
      }

      return kix;

   }

   /**
   * getRenameToOutline - returns the outline rename to
   *
   * @param conn		connection
   * @param campus	String
   * @param kix		String
   *
   * @return String
   */
   public String getRenameToOutline(Connection conn,String campus,String kix){

      String getRenameToOutline = "";

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT toalpha,tonum FROM tblRename WHERE campus=? AND historyid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,kix);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            getRenameToOutline = " <font class=\"goldhighlights\">==> "
            						+ AseUtil.nullToBlank(rs.getString("toalpha"))
            						+ " "
            						+ AseUtil.nullToBlank(rs.getString("tonum"))
            						+ " </font>"
            						+ "&nbsp;&nbsp;<a href=\"rnmav.jsp?kix="+kix+"\" class=\"linkcolumnx\" onClick=\"asePopUpWindowX(this.href,800,400);return false;\" onfocus=\"this.blur()\"><img src=\"../images/reviews.gif\" border=\"0\" title=\"view rename progress\" alt=\"view rename progress\"></a>";
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("Rename.getRenameToOutline: " + e.toString());
      }

      return getRenameToOutline;

   }

   /**
   * setApprovers - set approvers name and kick off approval
   *
   * @param conn			connection
   * @param campus		String
   * @param kix			String
   * @param approvers	String
   * @param approvlDate	String
   * @param comments		String
   *
   * @return boolean
   */
	public static boolean setApprovers(Connection conn,String campus,String user,String kix,String approvers) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;
		boolean success = false;

		int rowsAffected;

		try {
			debug = DebugDB.getDebug(conn,"RenameDB");

			//--------------------------------------------------
			// if there are reviewers to add, process here
			//--------------------------------------------------
			if (approvers != null && approvers.length() > 0) {

				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];

				rowsAffected = updateApprovers(conn,campus,kix,approvers);

				if(rowsAffected > 0){

					String[] aApprover = approvers.split(",");

					// create empty entries in renamex as place holder
					RenameXDB renameX = new RenameXDB();
					for(int i=0; i<aApprover.length; i++){
						rowsAffected = renameX.insert(conn,kix,aApprover[i]);
					} // for i
					renameX = null;

					String approver = aApprover[0];

					// create task and send mail to first approver
					rowsAffected = TaskDB.logTask(conn,
															approver,
															user,
															alpha,
															num,
															Constant.RENAME_APPROVAL_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															user,
															Constant.TASK_APPROVER,
															Constant.BLANK,
															Constant.BLANK);

					MailerDB mailerDB = new MailerDB(conn,
																user,
																approver,
																Constant.BLANK,
																Constant.BLANK,
																alpha,
																num,
																campus,
																"emailRenameRenumberApprovers",
																kix,
																user);

					// log action
					AseUtil.logAction(conn,
											user,
											"ACTION",
											"rename/renumber approval task added for: " + approver,
											alpha,
											num,
											campus,
											kix);

					// remove task from rename/renumber authority
					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															Constant.RENAME_REQUEST_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);

					// set working table status to APPROVAL
					setProgressToApproval(conn,kix);

				} // update approvers

			} // if approvers

			success = true;

		} catch (Exception e) {
         logger.fatal("Rename.setApprovers: " + e.toString());
		}

		return success;

	} // setApprovers

   /**
   * updateApprovers
   *
   * @param conn			connection
   * @param campus		String
   * @param kix			String
   * @param approvers	String
   *
   * @return int
   */
	public static int updateApprovers(Connection conn,String campus,String kix,String approvers) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (approvers != null && approvers.length() > 0) {

				// update approvers in table rename
				String sql = "UPDATE tblRename SET approvers=? WHERE campus=? AND historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,approvers);
				ps.setString(2,campus);
				ps.setString(3,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();

			} // if approvers

		} catch (Exception e) {
         logger.fatal("Rename.updateApprovers: " + e.toString());
		}

		return rowsAffected;

	} // updateApprovers

	/*
	 * getRenameProgress
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	progress	String
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getRenameProgress(Connection conn,String campus,String progress) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				genericData = new LinkedList<Generic>();

				String sql = "SELECT r.historyid, r.proposer, r.fromalpha + ' ' + r.fromnum AS fromOutline, r.toalpha + ' ' + r.tonum AS toOutline, c.coursetitle "
						+ "FROM tblRename r INNER JOIN tblCourse c ON r.historyid = c.historyid "
						+ "WHERE r.campus=? AND r.progress=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,progress);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("historyid")),
											AseUtil.nullToBlank(rs.getString("proposer")),
											AseUtil.nullToBlank(rs.getString("fromOutline")),
											AseUtil.nullToBlank(rs.getString("toOutline")),
											AseUtil.nullToBlank(rs.getString("coursetitle")),
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("Rename.getRenameProgress: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("Rename.getRenameProgress: " + e.toString());
			return null;
		}

		return genericData;
	}

   /**
   * getNextApprover
   *
   * @param conn 		connection
   * @param kix		String
   *
   * @return String
   */
   public static String getNextApprover(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

      String nextApprover = "";

      try{
			// the next person is the one without an approved value
			// if empty, there's no one left

			String sql = "SELECT approver FROM tblrenamex WHERE id=(SELECT MIN(id) FROM tblrenamex WHERE historyid=? AND approved is null)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				nextApprover = AseUtil.nullToBlank(rs.getString("approver"));
			}

      }
      catch(Exception e){
         logger.fatal("Rename.getNextApprover: " + e.toString());
      }

      return nextApprover;

   }

	/*
	 * getRenameProgress
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getRenameProgress(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil ae = new AseUtil();

				genericData = new LinkedList<Generic>();

				String sql = "SELECT id,approver,approved,comments,auditdate FROM tblrenamex WHERE historyid=? ORDER BY id";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String approved = AseUtil.nullToBlank(rs.getString("approved"));
					if(approved.equals("1")){
						approved = "YES";
					}
					else if(approved.equals("0")){
						approved = "NO";
					}
					else {
						approved = "";
					}

					genericData.add(new Generic(
											"" + rs.getInt("id"),
											AseUtil.nullToBlank(rs.getString("approver")),
											approved,
											AseUtil.nullToBlank(rs.getString("comments")),
											ae.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_SHORT),
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("Rename.getRenameProgress: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("Rename.getRenameProgress: " + e.toString());
			return null;
		}

		return genericData;
	}

	/*
	 * showCompletedProgress
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> showCompletedProgress(Connection conn,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil ae = new AseUtil();

				genericData = new LinkedList<Generic>();

				String sql = "SELECT * FROM tblRenameX WHERE historyid=? AND NOT approved IS NULL ORDER BY id";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("approver")),
											AseUtil.nullToBlank(rs.getString("comments")),
											ae.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_SHORT),
											AseUtil.nullToBlank(rs.getString("approved")),
											"",
											"",
											"",
											"",
											""
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("Rename.showCompletedProgress: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("Rename.showCompletedProgress: " + e.toString());
			return null;
		}

		return genericData;
	}

   /**
   * processComments
   *
   * @param conn 		connection
   * @param kix		String
   *
   * @return String
   */
   public static String processComments(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

      StringBuilder comments = new StringBuilder();

      try{
			List<Generic> genericData = RenameDB.showCompletedProgress(conn,kix);

			if(genericData != null){

				comments.append("<table width=\"90%\" border=\"0\" style=\"border: 1px solid #c0c0c0\">")
							.append("<tr><td width=\"15%\" class=\"textblackth\">Approver</td>")
							.append("<td width=\"15%\" class=\"textblackth\">Approved</td>")
							.append("<td width=\"15%\" class=\"textblackth\">Date</td>")
							.append("<td width=\"55%\" class=\"textblackth\">Comments</td></tr>");

				for(com.ase.aseutil.Generic g: genericData){

					String approved = "NO";
					if(g.getString4().equals("1")){
						approved = "YES";
					}

					comments.append("<tr><td class=\"datacolumn\">" + g.getString1() + "</td>")
							.append("<td class=\"datacolumn\">" + approved + "</td>")
							.append("<td class=\"datacolumn\">" + g.getString3() + "</td>")
							.append("<td class=\"datacolumn\">" + g.getString2() + "</td></tr>");
				}

				comments.append("</table>");

			} // genericData

			genericData = null;
      }
      catch(Exception e){
         logger.fatal("Rename.processComments: " + e.toString());
      }

		return comments.toString();
   }

   /**
   * getApprovers
   *
   * @param conn 		connection
   * @param kix		String
   *
   * @return String
   */
   public static String getApprovers(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

      String approvers = "";

      try{
         String sql = "SELECT approver FROM tblRenamex WHERE historyid=? ORDER BY ID";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,kix);
         approvers = SQLUtil.resultSetToCSV(ps.executeQuery());
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Rename.getApprovers: " + e.toString());
      }

      return approvers;

   }

   /**
   * isLastApprover
   *
   * @param conn 		connection
   * @param user		String
   * @param kix		String
   *
   * @return boolean
   */
   public static boolean isLastApprover(Connection conn,String user,String kix){

		//Logger logger = Logger.getLogger("test");

      boolean isLastApprover = false;

      try{
			// last person is the one with the max ID
			String sql = "SELECT approver FROM tblrenamex WHERE id=(SELECT MAX(id) FROM tblrenamex WHERE historyid=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				if(AseUtil.nullToBlank(rs.getString("approver")).equals(user)){
					isLastApprover = true;
				}
			}

      }
      catch(Exception e){
         logger.fatal("Rename.isLastApprover: " + e.toString());
      }

      return isLastApprover;

   }

   /**
   * processApproval - set approvers name
   *
   * @param conn			connection
   * @param user			String
   * @param kix			String
   * @param approved		String
   * @param comments		String
   *
   * @return int
   */
	public static int processApproval(Connection conn,String campus,String user,String kix,String approved,String comments) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		int rowsAffected = 0;

		try {
			debug = DebugDB.getDebug(conn,"RenameDB");

			String type = "";
			String fromAlpha = "";
			String fromNum = "";
			String toAlpha = "";
			String toNum = "";
			String proposer = "";
			String justification = "";

			boolean renameApproved = false;
			if(approved.equals("1")){
				renameApproved = true;
			}

			// rename if approved
			RenameDB renameDB = new RenameDB();
			Rename rename = renameDB.getRename(conn,kix);
			if(rename != null){

				String[] info = Helper.getKixInfo(conn,kix);
				type = info[Constant.KIX_TYPE];

				fromAlpha = rename.getFromAlpha();
				fromNum = rename.getFromNum();
				toAlpha = rename.getToAlpha();
				toNum = rename.getToNum();
				proposer = rename.getProposer();
				justification = rename.getJustification();

				//
				// 1) update approval - updates because rows were created for each during select
				// 2) remove task from current approver
				// 3) find next approver; if found, create task, send mail;
				//		if not found, end of process;
				//

				// 1 - remove task from current approver
				RenameXDB renameX = new RenameXDB();
				rowsAffected = renameX.update(conn,user,kix,approved,comments);
				renameX = null;
				if(debug) logger.info("updated comments - " + rowsAffected + " rows");

				// 2 - remove task from current approver
				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														fromAlpha,
														fromNum,
														Constant.RENAME_APPROVAL_TEXT,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);
				if(debug) logger.info("removed approval task - " + rowsAffected + " rows");

				// 3- get next approver before approver list is updated
				String nextApprover = getNextApprover(conn,kix);

				//
				// process next or is it the end. When approvers is blank, we're done
				//
				if(nextApprover.equals(Constant.BLANK)){

					String emailBundle = "emailRenameRenumberDenied";
					if(renameApproved){
						emailBundle = "emailRenameRenumberApproved";
					}

					// notify proposer of approval or not
					MailerDB mailerDB = new MailerDB(conn,
																user,
																proposer,
																Constant.BLANK,
																Constant.BLANK,
																fromAlpha,
																fromNum,
																campus,
																emailBundle,
																kix,
																user);
					if(debug) logger.info("mail sent - " + nextApprover);

					// rename if approved
					if(renameApproved){
						CourseRename.renameOutline(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user,type,justification);
						if(debug) logger.info("renameOutline");
					} // renamed was approved

// create correct task for proposer

					// clean up
					Outlines.updateReason(conn,kix,
									"<font class=\"textblackth\">Rename/Renumber Approval Process"
									+ "&nbsp;("
									+ fromAlpha + " " + fromNum + " ==> " + toAlpha + " " + toNum
									+ ")</font><br/>"
									+ processComments(conn,kix),user);
					renameDB.delete(conn,campus,kix);
					if(debug) logger.info("cleaned up");

				}
				else{

					// create task for next approver
					rowsAffected = TaskDB.logTask(conn,
															nextApprover,
															user,
															fromAlpha,
															fromNum,
															Constant.RENAME_APPROVAL_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															user,
															Constant.TASK_APPROVER,
															Constant.BLANK,
															Constant.BLANK);
					if(debug) logger.info("task created - " + nextApprover);

					// send mail to next approver
					MailerDB mailerDB = new MailerDB(conn,
																user,
																nextApprover,
																Constant.BLANK,
																Constant.BLANK,
																fromAlpha,
																fromNum,
																campus,
																"emailRenameRenumberApprovers",
																kix,
																user);
					if(debug) logger.info("mail sent - " + nextApprover);

					// log action
					AseUtil.logAction(conn,
											user,
											"ACTION",
											"rename/renumber approval task added for: " + nextApprover,
											fromAlpha,
											fromNum,
											campus,
											kix);
					if(debug) logger.info("action logged - " + nextApprover);

				} // nextApprover

			} // rename not null

			renameDB = null;

		} catch (Exception e) {
         logger.fatal("Rename.processApproval: " + e.toString());
		}

		return rowsAffected;

	} // processApproval

   /**
   * cancel - cancel rename request
   *
   * @param conn		connection
   * @param campus	String
   * @param user		String
   * @param kix		String
   *
   * @return int
   */
	public static int cancel(Connection conn,String campus,String user,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		int rowsAffected = 0;

		String fromAlpha = "";
		String fromNum = "";
		String toAlpha = "";
		String toNum = "";

		try {
			debug = DebugDB.getDebug(conn,"RenameDB");

			if(debug) logger.info("RenameDB.cancel - START");

			RenameDB renameDB = new RenameDB();
			Rename rename = renameDB.getRename(conn,kix);
			if(rename != null){
				fromAlpha = rename.getFromAlpha();
				fromNum = rename.getFromNum();
				toAlpha = rename.getToAlpha();
				toNum = rename.getToNum();
			} // rename

			// update outline comments
			Outlines.updateReason(conn,kix,
							"<font class=\"textblackth\">Rename/Renumber Cancelled"
							+ "&nbsp;("
							+ fromAlpha + " " + fromNum + " ==> " + toAlpha + " " + toNum
							+ ")</font>",user);
			if(debug) logger.info("update reason");

			// remove task from authority
			String authority = IniDB.getKval(conn,campus,"RenameRenumberAuthority","kval2");
			rowsAffected = TaskDB.logTask(conn,
													authority,
													user,
													fromAlpha,
													fromNum,
													Constant.RENAME_REQUEST_TEXT,
													campus,
													Constant.BLANK,
													Constant.TASK_REMOVE,
													Constant.PRE);
			if(debug) logger.info("remove authority task");

			// notify authority
			MailerDB mailerDB = new MailerDB(conn,
														user,
														authority,
														Constant.BLANK,
														Constant.BLANK,
														fromAlpha,
														fromNum,
														campus,
														"emailCancelRenameRenumber",
														kix,
														user);
			if(debug) logger.info("notify authority");

			// delete from rename table
			renameDB.delete(conn,campus,kix);
			if(debug) logger.info("data removed");

			renameDB = null;
			rename = null;

			if(debug) logger.info("RenameDB.cancel - END");

		} catch (Exception e) {
         logger.fatal("Rename.cancel: " + e.toString());
		}

		return rowsAffected;

	} // cancel

   /**
   * close
   */
	public void close() throws Exception {}

}

