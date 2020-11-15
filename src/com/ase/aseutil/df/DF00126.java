/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// DF00126.java
//
package com.ase.aseutil.df;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Generic;
import com.ase.aseutil.Html;

import java.util.LinkedList;
import java.util.List;

/**
 *
 */
public class DF00126 {

	static Logger logger = Logger.getLogger(DF00126.class.getName());

	public DF00126() throws Exception {}

	/*
	 * df00126
	 * <p>
	 * @param	connection
	 * <p>
	 * @return int
	 */
	public static String df00126(Connection conn){

		// df00126 - collects data from tblcourse where approved courses are not
		// set to APPROVE progress. This process corrects the problem by
		// pulling together all occurences where TYPE='CUR' and PROGRESS <> 'APPROVED'

		StringBuffer buf = new StringBuffer();

		buf.append("<strong>DF00126</strong>" + Html.BR()
			+ "create table data: " + df00126_0(conn) + Html.BR()
			+ "remove good data: " + df00126_1(conn) + Html.BR());

		return buf.toString();

	}

	/*
	 * df00126
	 * <p>
	 * @param	connection
	 * <p>
	 * @return int
	 */
	public static int df00126_0(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// 1) find all courses where there are 2 of the same campus/alpha/number combination
		// put in table to work on

		try{
			String sql = "DELETE FROM zdf00126";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();

			sql = "INSERT INTO zDF00126 "
				+ "SELECT tbl.campus, tbl.CourseAlpha, tbl.CourseNum, tc.CourseType, tc.Progress, tc.auditdate, tc.coursedate, tc.historyid, tc.effectiveterm, tc.proposer "
				+ "FROM "
				+ "( "
				+ "SELECT campus, CourseAlpha, CourseNum, COUNT(campus) AS counter "
				+ "FROM tblCourse "
				+ "GROUP BY CourseAlpha, CourseNum, campus "
				+ "HAVING (COUNT(campus) > 1) "
				+ ") AS tbl INNER JOIN "
				+ "tblCourse AS tc ON tbl.campus = tc.campus AND tbl.CourseAlpha = tc.CourseAlpha AND "
				+ "tbl.CourseNum = tc.CourseNum "
				+ "ORDER BY tbl.campus, tbl.CourseAlpha, tbl.CourseNum ";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("df00126_0 - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("df00126_0 - " + ex.toString());
		}

		return rowsAffected;

	} // df00126

	/*
	 * df00126
	 * <p>
	 * @param	connection
	 * <p>
	 * @return int
	 */
	public static int df00126_1(Connection conn){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		// 2) run through and delete anything where type='CUR' and progress='APPROVED'
		// 2) run through and delete anything where type='PRE' and progress='APPROVAL'
		// 2) run through and delete anything where type='PRE' and progress='MODIFY'

		try{
			String sql = "delete from zDF00126 where coursetype='CUR' and progress='APPROVED'";
			PreparedStatement ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='APPROVAL'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='DELETE'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='DELETING'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='MODIFY'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='REVIEW'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

			sql = "delete from zDF00126 where coursetype='PRE' and progress='REVISE'";
			ps = conn.prepareStatement(sql);
			rowsAffected += ps.executeUpdate();
			ps.close();

		}
		catch(SQLException sx){
			logger.fatal("df00126_1 - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("df00126_1 - " + ex.toString());
		}

		return rowsAffected;

	} // df00126

	/*
	 * df00126_DeleteRow
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return int
	 */
	public static int df00126_DeleteRow(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		//
		int rowsAffected = 0;

		try{
			String sql = "delete from zDF00126 where historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(SQLException s){
			logger.fatal("df00126_DeleteRow - " + s.toString());
		}
		catch(Exception s){
			logger.fatal("df00126_DeleteRow - " + s.toString());
		}

		return rowsAffected;

	} // df00126_DeleteRow

	/**
	 * populateTables - get data in place for working
	 * @param	conn	Connection
	 * <p>
	 * @return int
	 * <p>
	 */
	 public static int populateTables(Connection conn){

		Logger logger = Logger.getLogger("test");

		boolean debug = false;

		int rowsAffected = 0;

		try{

			String sql = "";
			PreparedStatement ps = null;

			//
			// clear PRE
			//
			try{
				sql = "delete from tempPRE";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
			}
			catch(Exception e){
				//
			}

			//
			// clear CUR
			//
			try{
				sql = "delete from tempCUR";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
			}
			catch(Exception e){
				//
			}

			//
			// create PRE
			//
			sql = "insert into temppre(campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate) "
				+ "select campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate "
				+ "from tblcourse where coursetype='PRE'";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();

			//
			// create CUR
			//
			sql = "insert into tempcur(campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate) "
				+ "select campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate "
				+ "from tblcourse where coursetype='CUR'";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();

		}
		catch( SQLException e ){
			logger.fatal("DF00126.populateTables - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("DF00126.populateTables - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getData
	 *	<p>
	 *	<p>
	 *	@return List
	 */
	public static List<Generic> getData(Connection conn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil aseUtil = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "select c.Campus,c.coursealpha as Alpha,c.coursenum as Num,c.Progress as cProgress,c.CourseDate as cCourseDate,c.AuditDate as cAuditDate, "
					+ "p.Progress as pProgress,p.coursedate as pCourseDate,p.auditdate as pAuditDate,c.historyid as cKix, p.historyid as pKix "
					+ "from tempCUR c join tempPRE p on c.campus=p.campus and c.coursealpha=p.coursealpha  "
					+ "and c.coursenum=p.coursenum where c.progress <> 'APPROVED' order by c.campus,c.coursealpha,c.coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String cAuditDate = aseUtil.ASE_FormatDateTime(rs.getString("cAuditDate"),Constant.DATE_SHORT);
					String cCourseDate = aseUtil.ASE_FormatDateTime(rs.getString("cCourseDate"),Constant.DATE_SHORT);

					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("Campus")),
											AseUtil.nullToBlank(rs.getString("Alpha")),
											AseUtil.nullToBlank(rs.getString("Num")),
											AseUtil.nullToBlank(rs.getString("cProgress")),
											AseUtil.nullToBlank(rs.getString("pProgress")),
											cAuditDate,
											cCourseDate,
											AseUtil.nullToBlank(rs.getString("cKix")),
											AseUtil.nullToBlank(rs.getString("pKix"))
										));
				} // rs
				rs.close();
				ps.close();

				aseUtil = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("getData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("getData: " + e.toString());
		}

		return genericData;
	}


}
