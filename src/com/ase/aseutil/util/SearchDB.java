/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 *	public void createSearchData() throws Exception {
 *	public static int deleteSearch(Connection conn,String kix) {
 *	public static boolean isMatch(Connection conn,String kix) throws SQLException {
 *	public static int insertSearch(Connection conn,Search search) {
 *	public static String searchCC(Connection conn,String campus,String cps,String type,String txt1,String txt2,String txt3)
 *	public static int updateSearch(Connection conn, Search search) {
 *
 * @author ttgiang
 */

//
// SearchDB.java
//
package com.ase.aseutil.util;

import org.apache.log4j.Logger;

import java.sql.*;
import java.util.*;

import com.ase.aseutil.*;
import com.ase.aseutil.bundle.*;
import com.ase.aseutil.html.Html2Text;
import com.ase.aseutil.jobs.*;

public class SearchDB {

	static Logger logger = Logger.getLogger(SearchDB.class.getName());

	public SearchDB() throws Exception {}

	/**
	 * isMatch
	 * <p>
	 * @param conn	Connection
	 * @param kix	String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String kix) throws SQLException {

		String sql = "SELECT id FROM tblSearch WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/**
	 * insertSearch
	 * <p>
	 * @param	conn	Connection
	 * @param	search	Search
	 * <p>
	 * @return	int
	 */
	public static int insertSearch(Connection conn,Search search) {

		String sql = "INSERT INTO tblSearch(campus,historyid,src,auditdate,auditby) VALUES(?,?,?,?,?)";
		int rowsAffected = 0;
		try {
			if (!isMatch(conn,search.getHistoryid())){

				if (search.getAuditBy() == null || search.getAuditBy().length() == 0){
					search.setAuditBy("SYSADM");
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,search.getCampus());
				ps.setString(2,search.getHistoryid());
				ps.setString(3,search.getSrc());
				ps.setString(4,AseUtil.getCurrentDateTimeString());
				ps.setString(5,search.getAuditBy());
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				updateSearch(conn,search);
			}
		} catch (SQLException e) {
			logger.fatal("SearchDB: insertSearch - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * deleteSearch
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * @param	id		int
	 * <p>
	 * @return	int
	 */
	public static int deleteSearch(Connection conn,String kix) {

		String sql = "DELETE FROM tblSearch WHERE historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SearchDB: deleteSearch - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateSearch
	 * <p>
	 * @param	conn	Connection
	 * @param	search	Search
	 * <p>
	 * @return	int
	 */
	public static int updateSearch(Connection conn, Search search) {

		String sql = "UPDATE tblSearch SET src=?,auditdate=?,auditby=? WHERE historyid=?";
		int rowsAffected = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,search.getSrc());
			ps.setString(2,search.getHistoryid());
			ps.setString(3,AseUtil.getCurrentDateTimeString());
			ps.setString(4,search.getAuditBy());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SearchDB: updateSearch - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * searchCC
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String		// user campus
	 * @param	cps		String		// selected campus
	 * @param	txt1		String
	 * @param	txt2		String
	 * @param	txt3		String
	 * @param	radio1	String
	 * @param	radio2	String
	 *	<p>
	 * @return	String
	 */
	public static String searchCC(Connection conn,
												String campus,
												String cps,
												String type,
												String txt1,
												String txt2,
												String txt3,
												String radio1,
												String radio2,
												String term,
												String prefix,
												int bnrTitle,
												int catTitle,
												int crsTitle) throws Exception {

		//Logger logger = Logger.getLogger("test");

/*

SELECT t1.campus, t1.historyid, t1.CourseAlpha, t1.CourseNum, t1.coursetitle, t1.CourseType, t1.coursedescr, t1.effectiveterm, t1.TERM_DESCRIPTION
FROM (
SELECT c.campus, c.historyid, c.CourseAlpha, c.CourseNum, c.coursetitle, c.CourseType, CAST(c.coursedescr AS varchar(1000))
AS coursedescr, c.effectiveterm, b.TERM_DESCRIPTION
FROM tblCourse AS c
LEFT OUTER JOIN BannerTerms AS b ON c.effectiveterm = b.TERM_CODE
LEFT OUTER JOIN tblApprovalHist AS a ON c.historyid = a.historyid
LEFT OUTER JOIN tblApprovalHist2 AS a2 ON c.historyid = a2.historyid
LEFT OUTER JOIN tblReviewHist AS r ON c.historyid = r.historyid
LEFT OUTER JOIN tblReviewHist2 AS r2 ON c.historyid = r2.historyid
WHERE      (c.historyid <> '') AND (c.coursedescr LIKE '%%') AND (c.coursedescr LIKE '%%')
) AS tbl1
INNER JOIN
(
SELECT messages.message_body, forums.historyid
FROM forums INNER JOIN
messages ON forums.forum_id = messages.forum_id
) AS t2 ON t1.historyid = t2.historyid

sql = "SELECT  c.campus, c.historyid, c.coursealpha, c.coursenum, c.coursetitle, c.coursetype, cast(c.coursedescr as varchar("+textSize+")) as coursedescr, c.effectiveterm, b.term_description "
	+ "FROM " + table + " c LEFT OUTER JOIN BannerTerms b ON c.effectiveterm = b.TERM_CODE "
	+ "LEFT OUTER JOIN tblReviewHist r ON c.historyid = r.historyid "
	+ "LEFT OUTER JOIN tblReviewHist2 r2 ON c.historyid = r2.historyid "
	+ "LEFT OUTER JOIN tblApprovalHist a ON c.historyid = a.historyid "
	+ "LEFT OUTER JOIN tblApprovalHist2 a2 ON c.historyid = a2.historyid "
	+ "WHERE c.historyid <> '' ";
*/

		//
		// X87 is manoa's catalog description for alpha courses
		//
		boolean x87 = true;						// course description for alpha courses

		StringBuffer result = new StringBuffer();

		String junk = "";
		int parms = 0;

		String brnCol = "c.x79";			// banner title
		String catCol = "c.x89";			// catalog title 2
		String crsCol = "c.coursetitle";

		boolean multiWordSearch = false;

		//
		// search text
		//
		if (!txt2.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		if (!txt3.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		//
		// operators
		//
		if (radio1.equals(Constant.BLANK)){
			radio1 = " AND ";
		}

		if (radio2.equals(Constant.BLANK)){
			radio2 = " AND ";
		}

		//
		// help refine simple search
		// when simple search is selected and we have multiple words,
		// break apart and set up as if we were doing AND search
		//
		if(!multiWordSearch && txt1.contains(Constant.SPACE)){
			String[] aText = txt1.trim().split(Constant.SPACE);
			txt1 = aText[0];

			if(aText.length > 1)	txt2 = aText[1];
			if(aText.length > 2)	txt3 = aText[2];
		}

		//
		// sql statement
		//
		try {
			AseUtil aseUtil = new AseUtil();

			int textSize = 1000;

			String select = " c.campus, c.historyid, c.coursealpha, c.coursenum, c.coursetitle, c.coursetype, cast(c.coursedescr as varchar("+textSize+")) as coursedescr, c.effectiveterm, b.term_description ";
			String adHocSql = "";
			String searchInSql = "";

			//
			// form input parameters
			//
			if (!cps.equals(Constant.BLANK)){
				adHocSql += " AND c.campus=? ";
			}

			if (!type.equals(Constant.BLANK)){
				adHocSql += " AND c.coursetype like '%"+aseUtil.toSQL(type,1,false)+"%' ";
			}

			if (!term.equals(Constant.BLANK)){
				adHocSql += " AND b.term_description like '%"+aseUtil.toSQL(term,1,false)+"%' ";
			}

			if (!prefix.equals(Constant.BLANK)){
				adHocSql += " AND c.coursealpha like '%"+aseUtil.toSQL(prefix,1,false)+"%' ";
			}

			//
			// combine for text with logical operators
			//
			int ctr = 0;
			String srchText = "";
			String dataCol = "c.coursedescr,c.x87";

			if(bnrTitle == 1){
				dataCol += "," + brnCol;				// banner title
				select += ",cast("+brnCol+" as varchar("+textSize+")) as bannertitle ";
			}

			if(catTitle == 1){
				dataCol += "," + catCol;
				select += ",cast("+brnCol+" as varchar("+textSize+")) as catalogtitle ";
			}

			if(crsTitle == 1){
				dataCol += "," + crsCol;
				select += ",cast("+crsCol+" as varchar("+textSize+")) as coursetitle ";
			}

			String[] dataCols = dataCol.split(",");
			String[] srchCols = new String[dataCols.length];

			if (!txt1.equals(Constant.BLANK)){

				srchText = txt1;
				for(ctr=0;ctr<dataCols.length;ctr++){
					srchCols[ctr] = " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
				}

				if (!txt2.equals(Constant.BLANK)){

					srchText = txt2;
					for(ctr=0;ctr<dataCols.length;ctr++){
						srchCols[ctr] += " " + radio1 + " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
					}

					if (!txt3.equals(Constant.BLANK)){

						srchText = txt3;
						for(ctr=0;ctr<dataCols.length;ctr++){
							srchCols[ctr] += " " + radio2 + " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
						}

					} // txt3

				} // txt2

				//
				// combine search components
				//
				searchInSql += " AND ((" + srchCols[0] + ") ";
				for(ctr=1;ctr<dataCols.length;ctr++){
					searchInSql += " OR (" + srchCols[ctr] + ") ";
				}
				searchInSql += " ) ";

			} // txt1

			//
			// isolate by correct table type
			//
			String table = "tblcourse";
			if(type.equals("ARC")){
				table = "tblcoursearc";
			}

			String sql = "SELECT " + select + " "
						+ "FROM " + table + " c LEFT OUTER JOIN BannerTerms b ON c.effectiveterm = b.TERM_CODE "
						+ "WHERE c.historyid <> '' ";

			sql += " " + adHocSql + " " + searchInSql;

			//
			// using this to break for screen print of sql
			//
			boolean debug = false;

			if(debug){
				result.append(sql + Html.BR());
			}
			else{

				//
				// combine based on the need to get all data
				//
				if(type.equals("ALL") || type.equals(Constant.BLANK)){
					sql += " union " + sql.replace("tblcourse","tblcoursearc");
				}
				else{
					sql += " ORDER BY c.campus, c.coursealpha, c.coursenum";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps = conn.prepareStatement(sql);

				if (!cps.equals(Constant.BLANK)){
					ps.setString(++parms,cps);

					if(type.equals("ALL") || type.equals(Constant.BLANK)){
						ps.setString(++parms,cps);
					}
				}

				ResultSet rs = ps.executeQuery();
				if(rs.next()){

					String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");
					do{
						campus = AseUtil.nullToBlank(rs.getString("campus"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));
						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));
						String title = AseUtil.nullToBlank(rs.getString("coursetitle"));
						String typeStatus = AseUtil.nullToBlank(rs.getString("coursetype"));

						String termDescription = AseUtil.nullToBlank(rs.getString("TERM_DESCRIPTION"));
						term = AseUtil.nullToBlank(rs.getString("effectiveterm"));

						String descr = AseUtil.nullToBlank(rs.getString("coursedescr"));
						descr = org.jsoup.Jsoup.parse(descr).text();

						String bnrText = "";
						if(bnrTitle == 1){
							bnrText = AseUtil.nullToBlank(rs.getString("bannertitle"));
							bnrText = org.jsoup.Jsoup.parse(bnrText).text();
						}

						String catText = "";
						if(catTitle == 1){
							catText = AseUtil.nullToBlank(rs.getString("catalogtitle"));
							catText = org.jsoup.Jsoup.parse(catText).text();
						}

						String crsText = "";
						if(crsTitle == 1){
							crsText = AseUtil.nullToBlank(rs.getString("coursetitle"));
							crsText = org.jsoup.Jsoup.parse(crsText).text();
						}

						//
						// course status
						//
						if(typeStatus.equals(Constant.CUR)){
							typeStatus = "<img src=\"../images/fastrack.gif\" alt=\"this is an approved outline\" title=\"this is an approved outline\">&nbsp;&nbsp;";
						}
						else if(typeStatus.equals(Constant.PRE)){
							typeStatus = "<img src=\"../images/edit.gif\" alt=\"this outline is being modified/proposed\" title=\"this outline is being modified/proposed\">&nbsp;&nbsp;";
						}
						else if(typeStatus.equals(Constant.ARC)){
							typeStatus = "<img src=\"../images/ext/zip.gif\" alt=\"this is an archived outline\" title=\"this is an archived outline\">&nbsp;&nbsp;";
						}

						//
						// type
						//
						result.append(typeStatus);

						//
						// progress
						//
						result.append("<a href=\"##\" onClick=\"return showProgress('"+kix+"');\" alt=\"view outline status\" class=\"linkcolumn\">"
										+ "<img src=\"../images/insert_table.gif\" alt=\"view outline status\" title=\"view outline status\">"
										+ "</a>&nbsp;&nbsp;");

						//
						// pdf
						//
						if (enableCCLab.equals(Constant.ON)){
							result.append("<a href=\"/central/core/vwpdf.jsp?kix="+kix+"\" alt=\"view in html format\" class=\"linkcolumn\" target=\"_blank\">"
											+ "<img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\">"
											+ "</a>&nbsp;&nbsp;");
						}

						result.append("<br>"
										+ "<a href=\"/central/core/vwcrsy.jsp?pf=1&kix="+kix+"&comp=1\" class=\"linkcolumn\" target=\"_blank\">"
										+ campus + " - " + title + " ("+alpha + " " + num +") - " + termDescription
										+ "</a>"
										+ Html.BR()
										);

						/*

						this is the older version for highlighting. we now
						have jquery doing the work in srch.jsp

						junk = descr.replace(txt1,"<span class=\"highlights1\">" + txt1 + "</span>");

						if (!txt2.equals(Constant.BLANK)){
							junk = junk.replace(txt2,"<span class=\"highlights2\">" + txt2 + "</span>");
						}

						if (!txt3.equals(Constant.BLANK)){
							junk = junk.replace(txt3,"<span class=\"highlights3\">" + txt3 + "</span>");
						}

						*/

						junk = descr;

						result.append(junk + Html.BR() + Html.BR());

						//
						// additional search within columns
						//
						if(bnrTitle == 1 && !bnrText.equals(Constant.BLANK)){
							result.append("[<font class=\"textblackth\">Banner Title</font>] " + bnrText + Html.BR() + Html.BR());
						}

						if(catTitle == 1 && !catText.equals(Constant.BLANK)){
							result.append("[<font class=\"textblackth\">Catalog Title</font>] " + catText + Html.BR() + Html.BR());
						}

						if(crsTitle == 1 && !crsText.equals(Constant.BLANK)){
							result.append("[<font class=\"textblackth\">Course Title</font>] " + crsText + Html.BR() + Html.BR());
						}

					} while (rs.next());

				}
				else{
					result.append("<br>no record found matching the requested search data.<br><br>");
				} // if

				rs.close();
				ps.close();

			} // not debuging

			aseUtil = null;

		} catch (SQLException se) {
			logger.fatal("SearchDB: searchCC - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SearchDB: searchCC - " + e.toString());
		}

		return result.toString();
	} // searchCC

	/*
	 * createSearchData - only CUR entries are counted
	 *	<p>
	 */
	public void createSearchData(JobName job,String campus,String runner,String kix) throws Exception {

		logger.info("----------------------------");

		Connection conn = null;

		String jobName = "SearchData";

		try{
			conn = AsePool.createLongConnection();

			if (conn != null){

				String alpha = null;
				String num = null;
				String user = null;
				String sql = null;
				String content = null;

				String[] info = null;

				String fileName = null;

				String currentDrive = AseUtil.getCurrentDrive();

				String documents = SysDB.getSys(conn,"documents");

				Msg msg = null;

				Html2Text html2Text = new Html2Text();

				Search search = new Search();

				PreparedStatement ps = null;
				PreparedStatement ps2 = null;
				PreparedStatement ps3 = null;

				int rowsAffected = 0;

				int i = 0;

				int numberOfRecords = 100;

				com.ase.aseutil.jobs.JobNameDB jobNameDB = new com.ase.aseutil.jobs.JobNameDB();

				// determine the lat time this job ran. use this time to get only courses
				// that were last modified by this date.
				String lastFireTime = jobNameDB.getFireTime(conn,jobName);

				// how many records are we working with and save it to the job table
				String table = "tblCourse";
				String where = "WHERE coursetype='CUR' AND auditdate > '"+lastFireTime+"'";
				rowsAffected = (int)AseUtil.countRecords(conn,table,where);

				sql = "SELECT historyid FROM tblCourse WHERE coursetype='CUR' AND auditdate > '"+lastFireTime+"'";
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					kix = AseUtil.nullToBlank(rs.getString("historyid"));

					info = Helper.getKixInfo(conn,kix);

					if (info != null && !info[0].equals(Constant.BLANK)){
						campus = info[Constant.KIX_CAMPUS];
						alpha = info[Constant.KIX_ALPHA];
						num = info[Constant.KIX_NUM];
						user = info[Constant.KIX_PROPOSER];

						// createOutlines writes a file to the campus folder. the file is
						// picked up here and used as input to be cleaned for search text
						Tables.createOutlines(conn,campus,kix,alpha,num,null,null,null,false,true,false);

						fileName = currentDrive
										+ ":"
										+ documents
										+ "outlines\\"
										+ campus
										+ "\\"
										+ kix + ".html";

						content = html2Text.HTML2Text(fileName);

						search.setCampus(campus);
						search.setid(0);
						search.setHistoryid(kix);
						search.setSrc(content);
						search.setAuditBy(runner);

						SearchDB.insertSearch(conn,search);

						++i;

					} // info

				} // while rs

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				job.setTotal(rowsAffected);
				job.setCounter(i);
				job.setEndTime(AseUtil.getCurrentDateTimeString());

				// keep this here beccause of the connection object
				jobNameDB.writeLogFile(conn,job);

				jobNameDB = null;

			} // conn != null

		}
		catch(Exception e){
			logger.fatal(e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("SearchDB: createSearchData - " + e.toString());
			}
		}

		logger.info("----------------------------");

	} // createSearchData

	/*
	 * main
	 *	<p>
	 */
	public static void main(String[] args) {

		System.out.println("----------------------------- START");

		if (args.length > 0){

			String campus = "";
			String kix = "";
			String user = "";

			System.out.println("Method to execute: " + args[0] + "\n");

			if (args[0].equals("createSearchData")){

				System.out.println("executing: " + args[0] + "\n");

				if (args.length > 1){
					campus = args[1];
					System.out.println("campus: " + args[1] + "\n");
				}

				if (args.length > 2){
					campus = args[2];
					System.out.println("kix: " + args[2] + "\n");
				}

				try{
					SearchDB s = new SearchDB();
					s.createSearchData(new JobName(),campus,user,kix);
				}
				catch(Exception e){
					logger.fatal("SearchDB - main: " + e.toString());
				}
			}
		} // if args
		else{
			System.out.println("missing method to execute");
		}

		System.out.println("----------------------------- END");
	}

	/*
	 * searchPrograms
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String		// user campus
	 * @param	cps		String		// selected campus
	 * @param	txt1		String
	 * @param	txt2		String
	 * @param	txt3		String
	 * @param	radio1	String
	 * @param	radio2	String
	 * @param	term		String
	 *	<p>
	 * @return	String
	 */
	public static String searchPrograms(Connection conn,
												String campus,
												String cps,
												String type,
												String txt1,
												String txt2,
												String txt3,
												String radio1,
												String radio2,
												String term) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer result = new StringBuffer();

		String junk = "";
		String sql = "";

		int parms = 0;

		boolean multiWordSearch = false;

		//
		// search text
		//
		if (!txt2.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		if (!txt3.equals(Constant.BLANK)){
			multiWordSearch = true;
		}

		//
		// operators
		//
		if (radio1.equals(Constant.BLANK)){
			radio1 = " AND ";
		}

		if (radio2.equals(Constant.BLANK)){
			radio2 = " AND ";
		}

		//
		// help refine simple search
		// when simple search is selected and we have multiple words,
		// break apart and set up as if we were doing AND search
		//
		if(!multiWordSearch && txt1.contains(Constant.SPACE)){
			String[] aText = txt1.trim().split(Constant.SPACE);
			txt1 = aText[0];

			if(aText.length > 1)	txt2 = aText[1];
			if(aText.length > 2)	txt3 = aText[2];
		}

		//
		// sql statement
		//
		try {
			AseUtil aseUtil = new AseUtil();

			int textSize = 1000;

			String select = " campus,historyid,type,seq,progress,effectivedate,title,descr,datedeleted ";
			String adHocSql = "";
			String searchInSql = "";

			//
			// form input parameters
			//
			if (!cps.equals(Constant.BLANK)){
				adHocSql += " AND campus='"+campus+"' ";
			}

			if (!type.equals(Constant.BLANK)){
				adHocSql += " AND type like '%"+aseUtil.toSQL(type,1,false)+"%' ";
			}

			if (!term.equals(Constant.BLANK)){
				adHocSql += " AND effectivedate like '%"+aseUtil.toSQL(term,1,false)+"%' ";
			}

			//
			// combine for text with logical operators
			//
			int ctr = 0;
			String srchText = "";
			String dataCol = "descr,title";

			String[] dataCols = dataCol.split(",");
			String[] srchCols = new String[dataCols.length];

			if (!txt1.equals(Constant.BLANK)){

				srchText = txt1;
				for(ctr=0;ctr<dataCols.length;ctr++){
					srchCols[ctr] = " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
				}

				if (!txt2.equals(Constant.BLANK)){

					srchText = txt2;
					for(ctr=0;ctr<dataCols.length;ctr++){
						srchCols[ctr] += " " + radio1 + " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
					}

					if (!txt3.equals(Constant.BLANK)){

						srchText = txt3;
						for(ctr=0;ctr<dataCols.length;ctr++){
							srchCols[ctr] += " " + radio2 + " " + dataCols[ctr] + " LIKE '%"+aseUtil.toSQL(srchText,1,false)+"%' ";
						}

					} // txt3

				} // txt2

				//
				// combine search components
				//
				searchInSql += " AND ((" + srchCols[0] + ") ";
				for(ctr=1;ctr<dataCols.length;ctr++){
					searchInSql += " OR (" + srchCols[ctr] + ") ";
				}
				searchInSql += " ) ";

			} // txt1

			//
			// isolate by correct table type
			//
			sql = "SELECT " + select + " FROM tblprograms WHERE campus not like 'TTG%' and campus not like 'CAN%' and historyid <> '' ";
			sql += " " + adHocSql + " " + searchInSql;
			sql += " ORDER BY campus,title";

			//
			// using this to break for screen print of sql
			//
			boolean debug = false;

			if(debug){
				result.append(sql + Html.BR());
			}
			else{

				PreparedStatement ps = conn.prepareStatement(sql);
				ps = conn.prepareStatement(sql);

				ResultSet rs = ps.executeQuery();
				if(rs.next()){

					String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");
					do{
						campus = AseUtil.nullToBlank(rs.getString("campus"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));
						String title = AseUtil.nullToBlank(rs.getString("title"));
						String typeStatus = AseUtil.nullToBlank(rs.getString("type"));
						String descr = AseUtil.nullToBlank(rs.getString("descr"));
						String effectivedate = AseUtil.nullToBlank(rs.getString("effectivedate"));
						descr = org.jsoup.Jsoup.parse(descr).text();

						String datedeleted = AseUtil.nullToBlank(rs.getString("datedeleted"));

						//
						// course status
						//
						if(typeStatus.equals(Constant.CUR)){
							typeStatus = "<img src=\"../images/fastrack.gif\" alt=\"this is an approved program\" title=\"this is an approved program\">&nbsp;&nbsp;";
						}
						else if(typeStatus.equals(Constant.PRE)){
							typeStatus = "<img src=\"../images/edit.gif\" alt=\"this program is being modified/proposed\" title=\"this program is being modified/proposed\">&nbsp;&nbsp;";
						}
						else if(typeStatus.equals(Constant.ARC)){
							if(!datedeleted.equals(Constant.BLANK)){
								typeStatus = "<img src=\"../images/del.gif\" alt=\"this is a deleted program\" title=\"this is a deleted program\">&nbsp;&nbsp;";
							}
							else{
								typeStatus = "<img src=\"../images/ext/zip.gif\" alt=\"this is an archived program\" title=\"this is an archived program\">&nbsp;&nbsp;";
							}
						}

						//
						// type
						//
						result.append(typeStatus);

						//
						// progress
						//
						result.append("<a href=\"##\" onClick=\"return showProgress('"+kix+"');\" alt=\"view program status\" class=\"linkcolumn\">"
										+ "<img src=\"../images/insert_table.gif\" alt=\"view program status\" title=\"view program status\">"
										+ "</a>&nbsp;&nbsp;");

						//
						// pdf
						//
						if (enableCCLab.equals(Constant.ON)){
							result.append("<a href=\"/central/core/vwpdf.jsp?kix="+kix+"\" alt=\"view in html format\" class=\"linkcolumn\" target=\"_blank\">"
											+ "<img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\">"
											+ "</a>&nbsp;&nbsp;");
						}

						result.append("<br>"
										+ "<a href=\"/central/core/vwhtml.jsp?cps="+campus+"&kix="+kix+"\" class=\"linkcolumn\" target=\"_blank\">"
										+ campus + " - " + title + " (effective: " + effectivedate + ")"
										+ "</a>"
										+ Html.BR()
										);

						result.append(descr + Html.BR() + Html.BR());

					} while (rs.next());

				}
				else{
					result.append("<br>no record found matching the requested search data.<br><br>");
				} // if

				rs.close();
				ps.close();

			} // not debuging

			aseUtil = null;

		} catch (SQLException e) {
			logger.fatal("SearchDB: searchPrograms ("+sql+") " + e.toString());
		} catch (Exception e) {
			logger.fatal("SearchDB: searchPrograms ("+sql+") " + e.toString());
		}

		return result.toString();
	} // searchPrograms


	public void close() throws SQLException {}

}