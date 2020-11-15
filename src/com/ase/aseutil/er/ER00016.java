/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *
 * @author ttgiang
 */

//
// ER00016.java
//
package com.ase.aseutil.er;

import com.ase.aseutil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class ER00016 {

	static Logger logger = Logger.getLogger(ER00016.class.getName());

	public ER00016() throws Exception {}

	/**
	*  getCourseTitles - returns titles for summary report
	*
	**/
	public static String[] getCourseTitles() {

		int numberOfReports = 6;

		String[] titles = new String[numberOfReports];

		titles[0] = getCourseTitle(0);
		titles[1] = getCourseTitle(1);
		titles[2] = getCourseTitle(2);
		titles[3] = getCourseTitle(3);
		titles[4] = getCourseTitle(4);
		titles[5] = getCourseTitle(5);

		return titles;

	}

	/**
	*  getCourseTitle - returns title for current report
	*<p>
	*@param	report	int
	*<p>
	*@return	String
	**/
	public static String getCourseTitle(int report) {

		String str = "";

		switch(report){

			case 0 : str = "Final approval of modifications to existing courses"; break;
			case 1 : str = "Final approval of new courses"; break;
			case 2 : str = "Final approval of deletions of existing courses"; break;
			case 3 : str = "Modified-but-not-yet-approved courses still in the pipeline"; break;
			case 4 : str = "New-but-not-yet-approved courses still in the pipeline"; break;
			case 5 : str = "Deleted-but-not-yet-approved courses still in the pipeline"; break;

		}

		return str;
	}

	/**
	*  getProgramTitles - returns titles for summary report
	*
	**/
	public static String[] getProgramTitles() {

		int numberOfReports = 5;

		String[] titles = new String[numberOfReports];

		titles[0] = getProgramTitle(0);
		titles[1] = getProgramTitle(1);
		titles[2] = getProgramTitle(2);
		titles[3] = getProgramTitle(3);
		titles[4] = getProgramTitle(4);

		return titles;

	}

	/**
	*  getProgramTitle - returns title for current report
	*<p>
	*@param	report	int
	*<p>
	*@return	String
	**/
	public static String getProgramTitle(int report) {

		String str = "";

		switch(report){

			case 0 : str = "Final approval of modifications to existing programs"; break;
			case 1 : str = "Final approval of new programs"; break;
			case 2 : str = "Final approval of deletions of existing programs"; break;
			case 3 : str = "Modified-but-not-yet-approved programs still in the pipeline"; break;
			case 4 : str = "New-but-not-yet-approved programs still in the pipeline"; break;

		}

		return str;
	}

	/**
	*  getCourseDateColumn - returns the date column used for the requested report
	*<p>
	*@param	report	int
	*<p>
	*@return	String
	**/
	public static String getCourseDateColumn(int report) {

		String dateColumn = "";

		switch(report){

			case 0 : dateColumn = "coursedate"; break;
			case 1 : dateColumn = "coursedate"; break;
			case 2 : dateColumn = "coursedate"; break;
			case 3 : dateColumn = "auditdate"; break;
			case 4 : dateColumn = "auditdate"; break;
			case 5 : dateColumn = "auditdate"; break;

		}

		return dateColumn;
	}

	/**
	*  getProgramDateColumn - returns the date column used for the requested report
	*<p>
	*@param	report	int
	*<p>
	*@return	String
	**/
	public static String getProgramDateColumn(int report) {

		String dateColumn = "";

		switch(report){

			case 0 : dateColumn = "dateapproved"; break;
			case 1 : dateColumn = "dateapproved"; break;
			case 2 : dateColumn = "datedeleted"; break;
			case 3 : dateColumn = "auditdate"; break;
			case 4 : dateColumn = "auditdate"; break;

		}

		return dateColumn;
	}

	/**
	*	getCourseCounters - returns array of counts for summary report
	*<p>
	*@param	conn		Connection
	*@param	campus	String
	*@param	fromDate	String
	*@param	toDate	String
	*<p>
	*@return	int[]
	**/
	public static int[] getCourseCounters(Connection conn,String campus,String fromDate,String toDate) {

		//Logger logger = Logger.getLogger("test");

		int numberOfReports = 6;

		int[] counter = new int[numberOfReports];

		try{
			for(int i=0; i<numberOfReports; i++){

				// use sql for selection of course data and wrap a count around to figure out the
				// total number of rows for the summary page;
				String sql = "SELECT DISTINCT COUNT(kee) as counter "
								+ "FROM "
								+ "( "
								+ getCourseSQL(i)
								+ ") AS tbl";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,NumericUtil.getInt(fromDate,0));
				ps.setInt(3,NumericUtil.getInt(toDate,0));
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					counter[i] = NumericUtil.getInt(rs.getInt("counter"),0);
				}
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("ER00016: getCounters - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ER00016: getCounters - " + e.toString());
		}

		return counter;

	}

	/**
	*	getCourses - get outline data
	*<p>
	*@param	conn			Connection
	*@param	campus		String
	*@param	report		int
	*@param	fromDate		String
	*@param	toDate		String
	*@param	dateField	String
	*<p>
	*@return	List
	**/
	public static List<Generic> getCourses(Connection conn,String campus,int report,String fromDate,String toDate) {

		//Logger logger = Logger.getLogger("test");

		String dateColumn = getCourseDateColumn(report);

		List<Generic> genericData = null;

		try{
			AseUtil ae = new AseUtil();

			genericData = new LinkedList<Generic>();

			PreparedStatement ps = conn.prepareStatement(getCourseSQL(report));
			ps.setString(1,campus);
			ps.setInt(2,NumericUtil.getInt(fromDate,0));
			ps.setInt(3,NumericUtil.getInt(toDate,0));
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("historyid")),
										AseUtil.nullToBlank(rs.getString("CourseAlpha")) + " " + AseUtil.nullToBlank(rs.getString("CourseNum")),
										AseUtil.nullToBlank(rs.getString("coursetitle")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString(dateColumn),Constant.DATE_SHORT),
										AseUtil.nullToBlank(rs.getString("progress")),
										"",
										"",
										""
									));
			} // rs

			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("ER00016: getCourses - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ER00016: getCourses - " + e.toString());
		}

		return genericData;

	}


	/**
	*	getCourseSQL - get outline data
	*<p>
	*@param	report		int
	*<p>
	*@return	String
	**/
	public static String getCourseSQL(int report) {

		// CUR and ARC uses course date and PRE uses auditdate (course date not availble until after)

		String sql = "";

		String dateColumn = getCourseDateColumn(report);

		switch(report){

			//Final approval of modifications to existing courses
			case 0: sql = "SELECT DISTINCT vw_CUR.* FROM vw_ARC INNER JOIN vw_CUR ON vw_ARC.kee = vw_CUR.kee "
					+ "WHERE vw_CUR.campus=? AND vw_CUR.progress='APPROVED' "
					+ "AND (YEAR(vw_CUR."+dateColumn+") >= ?) AND (YEAR(vw_CUR."+dateColumn+") <= ?)";

					break;

			// Final approval of new courses
			case 1: sql = "SELECT DISTINCT vw_CUR.* "
					+ "FROM vw_CUR LEFT JOIN vw_ARC ON vw_CUR.kee = vw_ARC.kee "
					+ "WHERE vw_ARC.kee Is Null AND vw_CUR.campus = ? "
					+ "AND (YEAR(vw_CUR."+dateColumn+") >= ?) AND (YEAR(vw_CUR."+dateColumn+") <= ?)";

					break;

			// Final approval of deletions of existing courses
			case 2 :sql = "SELECT DISTINCT DT.* FROM "
					+ "(SELECT vw_ARC.* FROM vw_ARC LEFT JOIN vw_CUR ON vw_ARC.kee = vw_CUR.kee WHERE vw_CUR.kee Is Null) as DT "
					+ "LEFT JOIN vw_PRE ON DT.kee = vw_PRE.kee "
					+ "WHERE vw_PRE.kee Is Null AND DT.campus=? "
					+ "AND (YEAR(DT."+dateColumn+") >= ?) AND (YEAR(DT."+dateColumn+") <= ?)";

					break;

			// Modified-but-not-yet-approved courses still in the pipeline
			case 3: sql = "SELECT DISTINCT vw_PRE.* FROM vw_PRE INNER JOIN vw_CUR ON vw_PRE.kee = vw_CUR.kee "
					+ "WHERE vw_PRE.campus=? AND (YEAR(vw_PRE."+dateColumn+") >= ?) AND (YEAR(vw_PRE."+dateColumn+") <= ?) AND vw_PRE.progress <> 'DELETE'";

					break;

			// New-but-not-yet-approved courses still in the pipeline
			case 4: sql = "SELECT DISTINCT vw_PRE.* FROM vw_PRE LEFT JOIN vw_CUR ON vw_PRE.kee = vw_CUR.kee "
					+ "WHERE vw_CUR.kee Is Null AND vw_PRE.campus=? "
					+ "AND (YEAR(vw_PRE."+dateColumn+") >= ?) AND (YEAR(vw_PRE."+dateColumn+") <= ?)";

					break;

			// Deleted-but-not-yet-approved courses still in the pipeline
			case 5: sql = "SELECT DISTINCT vw_PRE.* FROM vw_PRE WHERE vw_PRE.Progress='DELETE' "
					+ "AND campus=? AND (YEAR("+dateColumn+") >= ?) AND (YEAR("+dateColumn+") <= ?)";

					break;

		} // switch

		return sql;

	}

	/**
	*	getProgramCounters - returns array of counts for summary report
	*<p>
	*@param	conn		Connection
	*@param	campus	String
	*@param	fromDate	String
	*@param	toDate	String
	*<p>
	*@return	int[]
	**/
	public static int[] getProgramCounters(Connection conn,String campus,String fromDate,String toDate) {

		//Logger logger = Logger.getLogger("test");

		int numberOfReports = 5;

		String[] sqlCounter = new String[numberOfReports];

		int[] counter = new int[numberOfReports];

		// CUR and ARC uses course date and PRE uses auditdate (course date not availble until after)

		//Final approval of modifications to existing programs
		sqlCounter[0] = "SELECT count(vw_CURp.kee) as counter FROM vw_CURp INNER JOIN vw_ARCp ON vw_CURp.kee = vw_ARCp.kee "
			+ "WHERE vw_CURp.campus=? AND (YEAR(vw_CURp."+getProgramDateColumn(0)+") >= ?) AND (YEAR(vw_CURp."+getProgramDateColumn(0)+") <= ?)";

		// Final approval of new programs
		sqlCounter[1] = "SELECT count(vw_CURp.kee) as counter FROM vw_CURp LEFT OUTER JOIN "
			+ "vw_ARCp ON vw_CURp.kee = vw_ARCp.kee WHERE vw_ARCp.kee IS NULL "
			+ "AND vw_CURp.campus = ? "
			+ "AND (YEAR(vw_CURp."+getProgramDateColumn(1)+") >= ?) AND (YEAR(vw_CURp."+getProgramDateColumn(1)+") <= ?)";

		// Final approval of deletions of existing courses
		sqlCounter[2] = "SELECT count(DT.kee) as counter FROM "
			+ "(SELECT vw_ARCp.* FROM vw_ARCp LEFT JOIN vw_CURp ON vw_ARCp.kee = vw_CURp.kee WHERE vw_CURp.kee Is Null) as DT "
			+ "LEFT JOIN vw_PREp ON DT.kee = vw_PREp.kee "
			+ "WHERE vw_PREp.kee Is Null AND DT.campus=? "
			+ "AND (YEAR(DT."+getProgramDateColumn(2)+") >= ?) AND (YEAR(DT."+getProgramDateColumn(2)+") <= ?)";

		// Modified-but-not-yet-approved programs still in the pipeline
		sqlCounter[3] = "SELECT count(vw_CURp.kee) as counter FROM vw_CURp INNER JOIN vw_PREp ON vw_CURp.kee = vw_PREp.kee "
			+ "WHERE vw_PREp.campus=? AND (YEAR(vw_PREp."+getProgramDateColumn(3)+") >= ?) AND (YEAR(vw_PREp."+getProgramDateColumn(3)+") <= ?)";

		// new-but-not-yet-approved programs still in the pipeline
		sqlCounter[4] = "SELECT count(vw_PREp.kee) as counter FROM vw_PREp LEFT JOIN vw_CURp ON vw_PREp.kee = vw_CURp.kee "
			+ "WHERE vw_CURp.kee Is Null AND vw_PREp.campus=? "
			+ "AND (YEAR(vw_PREp."+getProgramDateColumn(4)+") >= ?) AND (YEAR(vw_PREp."+getProgramDateColumn(4)+") <= ?)";

		try{
			for(int i=0; i<numberOfReports; i++){

				String sql = sqlCounter[i];
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,NumericUtil.getInt(fromDate,0));
				ps.setInt(3,NumericUtil.getInt(toDate,0));
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					counter[i] = NumericUtil.getInt(rs.getInt("counter"),0);
				}
				rs.close();
				ps.close();
			}

		} catch (SQLException e) {
			logger.fatal("ER00016: getProgramCounters - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ER00016: getProgramCounters - " + e.toString());
		}

		return counter;

	}

	/**
	*	getPrograms - get outline data
	*<p>
	*@param	conn			Connection
	*@param	campus		String
	*@param	report		int
	*@param	fromDate		String
	*@param	toDate		String
	*@param	dateField	String
	*<p>
	*@return	List
	**/
	public static List<Generic> getPrograms(Connection conn,String campus,int report,String fromDate,String toDate) {

		//Logger logger = Logger.getLogger("test");

		int numberOfReports = 5;

		String[] sql = new String[numberOfReports];

		String dateColumn = getProgramDateColumn(report);

		// CUR and ARC uses course date and PRE uses auditdate (course date not availble until after)

		//Final approval of modifications to existing programs
		sql[0] = "SELECT vw_CURp.* FROM vw_CURp INNER JOIN vw_ARCp ON vw_CURp.kee = vw_ARCp.kee "
			+ "WHERE vw_CURp.campus=? AND (YEAR(vw_CURp."+dateColumn+") >= ?) AND (YEAR(vw_CURp."+dateColumn+") <= ?)";

		// Final approval of new programs
		sql[1] = "SELECT vw_CURp.* FROM vw_CURp LEFT OUTER JOIN "
			+ "vw_ARCp ON vw_CURp.kee = vw_ARCp.kee WHERE vw_ARCp.kee IS NULL "
			+ "AND vw_CURp.campus = ? "
			+ "AND (YEAR(vw_CURp."+dateColumn+") >= ?) AND (YEAR(vw_CURp."+dateColumn+") <= ?)";

		// Final approval of deletions of existing courses
		sql[2] = "SELECT DT.* FROM "
			+ "(SELECT vw_ARCp.* FROM vw_ARCp LEFT JOIN vw_CURp ON vw_ARCp.kee = vw_CURp.kee WHERE vw_CURp.kee Is Null) as DT "
			+ "LEFT JOIN vw_PREp ON DT.kee = vw_PREp.kee "
			+ "WHERE vw_PREp.kee Is Null AND DT.campus=? "
			+ "AND (YEAR(DT."+getProgramDateColumn(2)+") >= ?) AND (YEAR(DT."+getProgramDateColumn(2)+") <= ?)";

		// Modified-but-not-yet-approved programs still in the pipeline
		sql[3] = "SELECT vw_CURp.* FROM vw_CURp INNER JOIN vw_PREp ON vw_CURp.kee = vw_PREp.kee "
			+ "WHERE vw_PREp.campus=? AND (YEAR(vw_PREp."+dateColumn+") >= ?) AND (YEAR(vw_PREp."+dateColumn+") <= ?)";

		// new-but-not-yet-approved programs still in the pipeline
		sql[4] = "SELECT vw_PREp.* FROM vw_PREp LEFT JOIN vw_CURp ON vw_PREp.kee = vw_CURp.kee "
			+ "WHERE vw_CURp.kee Is Null AND vw_PREp.campus=? "
			+ "AND (YEAR(vw_PREp."+dateColumn+") >= ?) AND (YEAR(vw_PREp."+dateColumn+") <= ?)";

		List<Generic> genericData = null;

		try{
			AseUtil ae = new AseUtil();

			genericData = new LinkedList<Generic>();

			PreparedStatement ps = conn.prepareStatement(sql[report]);
			ps.setString(1,campus);
			ps.setInt(2,NumericUtil.getInt(fromDate,0));
			ps.setInt(3,NumericUtil.getInt(toDate,0));
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("historyid")),
										AseUtil.nullToBlank(rs.getString("title")),
										AseUtil.nullToBlank(rs.getString("effectivedate")),
										AseUtil.nullToBlank(rs.getString("proposer")),
										ae.ASE_FormatDateTime(rs.getString(dateColumn),Constant.DATE_SHORT),
										AseUtil.nullToBlank(rs.getString("progress")),
										"",
										"",
										""
									));
			} // rs

			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("ER00016: getPrograms - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ER00016: getPrograms - " + e.toString());
		}

		return genericData;

	}

	/**
	*	close - returns current year
	*
	**/
	public void close() throws SQLException {}

}