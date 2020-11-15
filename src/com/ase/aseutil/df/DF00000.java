/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *
 * @author ttgiang
 */

//
// DF00000.java
//
package com.ase.aseutil.df;

import com.ase.aseutil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class DF00000 {

	static Logger logger = Logger.getLogger(DF00000.class.getName());

	public DF00000() throws Exception {}

	/*
	 * reCreateOutlineHtml
	 * <p>
	 * @param	campus
	 * <p>
	 * @return int
	 */
	public static int reCreateOutlineHtml(String campus,String type,int count){

		int rowsAffected = reCreateOutlineHtml(campus,type,count,0);

		return rowsAffected;

	} // reCreateOutlineHtml

	public static int reCreateOutlineHtml(String campus,String type,int count,int history){

		int rowsAffected = 0;

		//
		// history == 1 means there has to be history before creating the outline
		// this impacts only CUR since after approval, html file is not easily generated
		//
		if(history==1){
			rowsAffected = generateOutlinesWithHistory(campus,count);
		}
		else{
			if(type.toLowerCase().equals("cur")){
				rowsAffected = generateApprovedOutlines(campus,count);
			}
			else{
				rowsAffected = generateProposedOutlines(campus,count);
			}
		}

		return rowsAffected;

	} // reCreateOutlineHtml

	/*
	 * generateOutlinesWithHistory
	 * <p>
	 * @param	campus	String
	 * @param	count		int
	 * <p>
	 * @return int
	 */
	public static int generateOutlinesWithHistory(String campus,int count){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();
			if (conn != null){

				String sql = "SELECT DISTINCT c.historyid, c.campus, c.CourseAlpha, c.CourseNum "
					+ "FROM tblCourse c INNER JOIN tblApprovalHist2 a ON c.historyid = a.historyid "
					+ "WHERE (c.campus=?) AND (c.CourseType = 'CUR') "
					+ "ORDER BY c.CourseAlpha, c.CourseNum";

				if(count==1){
					sql = "SELECT count(distinct c.historyid) as counter "
						+ "FROM tblCourse c INNER JOIN tblApprovalHist2 a ON c.historyid = a.historyid "
						+ "WHERE (c.campus = ?) AND (c.CourseType = 'CUR')";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();

				if(count==1){
					if (rs.next()){
						rowsAffected = rs.getInt("counter");
					} // while
				}
				else{
					while (rs.next()){
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));

						Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

						++rowsAffected;
					} // while
				}

				rs.close();
				ps.close();
			}

		}
		catch(SQLException sx){
			logger.fatal("DF00000: generateOutlinesWithHistory - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("DF00000: generateOutlinesWithHistory - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("DF00000: generateOutlinesWithHistory - " + e.toString());
			}
		}


		return rowsAffected;

	} // generateOutlinesWithHistory

	/*
	 * generateApprovedOutlines
	 * <p>
	 * @param	campus	String
	 * @param	count		int
	 * <p>
	 * @return int
	 */
	public static int generateApprovedOutlines(String campus,int count){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		String table = "( "
					+ "SELECT c.campus, c.CourseAlpha, c.CourseNum, c.historyid, c.coursedate, c.auditdate "
					+ "FROM  "
					+ "( "
					+ "	SELECT campus, CourseAlpha, CourseNum, historyid, coursedate, auditdate  "
					+ "	FROM tblCourse  "
					+ "	WHERE CourseType = 'CUR' and not coursedate is null and not auditdate is null "
					+ ") AS c LEFT OUTER JOIN "
					+ "( "
					+ "	SELECT campus, CourseAlpha, CourseNum, historyid, coursedate, auditdate  "
					+ "	FROM tblCourse  "
					+ "	WHERE CourseType = 'PRE' and not coursedate is null and not auditdate is null "
					+ ") AS p  "
					+ "ON c.campus = p.campus AND c.CourseAlpha = p.CourseAlpha AND c.CourseNum = p.CourseNum "
					+ "WHERE (p.historyid IS NULL) "
					+ ") as combined ";

		try{
			conn = AsePool.createLongConnection();
			if (conn != null){
				// sql selects courses in CUR without a matching course in PRE
				// we will create/recreate HTML for these only
				String sql = "select campus, CourseAlpha, CourseNum, historyid from "
					+ table
					+ "where campus=? "
					+ "order by campus, CourseAlpha, CourseNum, historyid ";

				if(count==1){
					sql = "select count(historyid) as counter from "
						+ table
						+ " group by campus having campus=?";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();

				if(count==1){
					if (rs.next()){
						rowsAffected = rs.getInt("counter");
					} // while
				}
				else{
					while (rs.next()){
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));

						Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

						++rowsAffected;
					} // while
				}

				rs.close();
				ps.close();
			}

		}
		catch(SQLException sx){
			logger.fatal("DF00000: generateApprovedOutlines - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("DF00000: generateApprovedOutlines - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("DF00000: generateApprovedOutlines - " + e.toString());
			}
		}


		return rowsAffected;

	} // generateApprovedOutlines

	/*
	 * generateProposedOutlines
	 * <p>
	 * @param	campus	String
	 * @param	count		int
	 * <p>
	 * @return int
	 */
	public static int generateProposedOutlines(String campus,int count){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();
			if (conn != null){
				String sql = "select campus, CourseAlpha, CourseNum, historyid from tblcourse "
					+ "where campus=? AND coursetype='PRE' order by campus, CourseAlpha, CourseNum, historyid ";

				if(count==1){
					sql = "select count(historyid) as counter from tblcourse group by campus, coursetype having campus=? AND coursetype='PRE'";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();

				if(count==1){
					if (rs.next()){
						rowsAffected = rs.getInt("counter");
					} // while
				}
				else{
					while (rs.next()){
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));

						Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

						++rowsAffected;
					} // while
				}

				rs.close();
				ps.close();
			}

		}
		catch(SQLException sx){
			logger.fatal("DF00000: generateProposedOutlines - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("DF00000: generateProposedOutlines - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("DF00000: generateProposedOutlines - " + e.toString());
			}
		}


		return rowsAffected;

	} // generateProposedOutlines

	/**
	*	close - returns current year
	*
	**/
	public void close() throws SQLException {}

}