/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.export;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.supercsv.cellprocessor.ConvertNullTo;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvMapWriter;
import org.supercsv.io.ICsvMapWriter;
import org.supercsv.prefs.CsvPreference;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.DateUtility;
import com.ase.aseutil.SQL;
import com.ase.aseutil.SQLUtil;
import com.ase.aseutil.WebSite;
import com.ase.aseutil.html.Html2Text;
import com.ase.aseutil.html.HtmlSanitizer;

import org.jsoup.*;

public class KualiExport {

	static Logger logger = Logger.getLogger(KualiExport.class.getName());

	static final int adText 		= 1;
	static final int adDate 		= 2;
	static final int adNumber 		= 3;

	/*
	* KualiExport
	*<p>
	* @param	conn		Connection
	* @param	report	String
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static String KualiExport(Connection conn,String report,String campus,String user) {

		Logger logger = Logger.getLogger("test");

		// header for csv processing
		String[] header = null;

		// header for csv processing
		String[] dataType = null;

		// how CSV cells are created
		CellProcessor[] processor = null;

		// database columns
		String[] dataColumns = null;

		ICsvMapWriter writer = null;

		int rowsAffected = 0;

		String outputFileName = "";
		String temp = "";
		String junk = "";

		boolean append = false;
		boolean hasData = true;

		try{
			AseUtil aseUtil = new AseUtil();

			outputFileName = user + "_" + report + "_" + SQLUtil.createHistoryID(1);

			String columns = getColumns(conn,report);
			header =  getHeader(columns);

			String dataTypes = getDataType(conn,report,columns);
			dataType = dataTypes.split(",");

			dataColumns = getHeader(columns);

			processor = getCellProcessor(dataColumns.length);

			// make sure number of columns are similar before processing

			if((header.length == processor.length) && (processor.length == dataColumns.length)){

				String writeDir = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ outputFileName;

				String fileName = writeDir + ".out";

				String outputFile = writeDir + ".csv";

				writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);
				writer.writeHeader(header);

				String sql = getSql(columns, report);

				if(sql != null && !sql.equals("")){

					logger.fatal("sql:" + sql);

					final HashMap<String, ? super Object> data = new HashMap<String, Object>();
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while(rs.next()){

						for(int counter = 0; counter < dataColumns.length; counter++){

							junk = AseUtil.nullToBlank("" + rs.getString(dataColumns[counter]));

							//
							// explain and course share a single view and explain is all text data type
							//

							temp = "";

							if(report.equals("course")){
								if(dataType[counter].indexOf("smalldatetime") >= 0){
									if(junk.length() > 1){
										try{
											temp = DateUtility.formatDateAsString(junk);
										}
										catch(Exception ex){
											System.out.println(dataType[counter]);
										}
									}
								}
								else{
									temp = Jsoup.parse(junk).text();
								}
							}
							else{
								temp = Jsoup.parse(junk).text();
							}

							data.put(header[counter], temp);
						}
						writer.write(data, header, processor);

					}
					rs.close();
					ps.close();

				} // if sql

			} // matching lengths

			aseUtil = null;

		} catch (IOException e) {
			logger.fatal("KualiExport IOException - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("KualiExport SQLException - " + e.toString());
		} catch (Exception e) {
			logger.fatal("KualiExport Exception - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("KualiExport - " + e.toString());
			}
		}

		return outputFileName;
	} // KualiExport

	/*
	*
	* getCellProcessor
	*
	*/
	public static CellProcessor[] getCellProcessor(int len) {

		Logger logger = Logger.getLogger("test");

		CellProcessor[] cellProcessor = new CellProcessor[len];

		try{
			for(int i = 0; i < len; i++){
				cellProcessor[i] = new ConvertNullTo("\"\"");
			}
		}
		catch(Exception e){
			logger.fatal("KualiExport - getCellProcessor: " + e.toString());
		}

		return cellProcessor;

	}

	/*
	*
	* getHeader
	*
	*/
	public static String[] getHeader(String columns) {

		Logger logger = Logger.getLogger("test");

		String[] aColumns = columns.split(",");

		String[] header = new String[aColumns.length];

		try{
			for(int i = 0; i < aColumns.length; i++){
				header[i] = aColumns[i];
			}
		}
		catch(Exception e){
			logger.fatal("KualiExport - etHeader: " + e.toString());
		}

		return header;

	}

	/*
	*
	* getColumns
	*
	*/
	public static String getColumns(Connection conn, String report) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String columns = "";

		try{

			PreparedStatement ps = null;
			ResultSet rs = null;

			if(report.equals("apphist")){
				columns = "campus,historyid,coursealpha,coursenum,seq,dte,approver,approved,comments,approver_seq,votesfor,votesagainst,votesabstain";
			}
			else if(report.equals("comp")){
				columns = "campus,historyid,coursealpha,coursenum,content,seq";
			}
			else if(report.equals("content")){
				columns = "campus,historyid,coursealpha,coursenum,shortcontent,longcontent,contentid";
			}
			else if(report.equals("coreq")){
				columns = "campus,historyid,CourseAlpha,CourseNum,coreqalpha,coreqnum,Grading,id";
			}
			else if(report.equals("course")){
				sql = "select col from vw_course_schema_in_use order by id";
				columns = "campus,historyid";
			}
			else if(report.equals("explain")){
				sql = "select explain as col from vw_course_schema_in_use where not explain is null AND explain <> '' order by id";
				columns = "campus,historyid,coursealpha,coursenum";
			}
			else if(report.equals("ini")){
				columns = "campus,category,kdesc,kid,kval1,seq";
			}
			else if(report.equals("los")){
				columns = "Campus,CourseAlpha,CourseNum,datatype,seq,data";
			}
			else if(report.equals("prereq")){
				columns = "campus,historyid,CourseAlpha,CourseNum,prereqalpha,prereqnum,Grading,id";
			}
			else if(report.equals("recprep")){
				columns = "campus,historyid,CourseAlpha,CourseNum,Grading,id";
			}
			else if(report.equals("revhist")){
				columns = "campus,historyid,coursealpha,coursenum,item,dte,reviewer,comments,source,acktion,enabled,sq,en,qn";
			}
			else if(report.equals("text")){
				columns = "campus,historyid,CourseAlpha,CourseNum,title,edition,author,publisher,yeer,isbn,seq";
			}
			else if(report.equals("xref")){
				columns = "campus,historyid,CourseAlpha,CourseNum,CourseAlphaX,CourseNumX,Id";
			}

			if(report.equals("course") || report.equals("explain")){
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){
					if(columns.length() > 0){
						columns = columns + ",";
					}
					columns += AseUtil.nullToBlank(rs.getString("col"));
				}

				rs.close();
				rs = null;
				ps.close();
				ps = null;
			}

		}
		catch(Exception e){
			logger.fatal("KualiExport - getColumns: " + e.toString());
		}

		logger.info("getColumns: " + columns);

		return columns;

	} // getColumns

	/*
	*
	* getDataType
	*
	*/
	public static String getDataType(Connection conn, String report, String columns) {

		Logger logger = Logger.getLogger("test");

		//
		// add 2 text items for historyid and campus
		//
		String dataType = "";
		String tbl = "";

		try{
			PreparedStatement ps = null;
			ResultSet rs = null;

			if(report.equals("apphist")){
				tbl = "tblApprovalHist";
			}
			else if(report.equals("comp")){
				tbl = "tblCourseCompetency";
			}
			else if(report.equals("content")){
				tbl = "tblCourseContent";
			}
			else if(report.equals("coreq")){
				tbl = "tblcoreq";
			}
			else if(report.equals("course")){
				tbl = "tblcourse";
			}
			else if(report.equals("explain")){
				tbl = "tblcampusdata";
			}
			else if(report.equals("ini")){
				tbl = "tblini";
			}
			else if(report.equals("los")){
				tbl = " vw_all_campus_list";
			}
			else if(report.equals("prereq")){
				tbl = "tblprereq";
			}
			else if(report.equals("recprep")){
				tbl = "tblextra";
			}
			else if(report.equals("revhist")){
				tbl = "tblReviewHist";
			}
			else if(report.equals("text")){
				tbl = "tbltext";
			}
			else if(report.equals("xref")){
				tbl = "tblxref";
			}

			if(report.equals("los")){
				dataType = "varchar,varchar,varchar,varchar,text,int,text";
			}
			else if(report.equals("text")){
				dataType = "varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,int";
			}
			else{
				String[] aColumns = columns.split(",");

				for(int i = 0; i < aColumns.length; i++){

					if(dataType.length() > 0){
						dataType += ",";
					}

					dataType += getColumnDataType(conn, tbl, aColumns[i]);
				}
			}

		}
		catch(Exception e){
			logger.fatal("Export: " + e.toString());
		}

		logger.info("getDataType: " + dataType);

		return dataType;

	} // getDataType

	/*
	*
	* getColumnDataType
	*
	*/
	public static String getColumnDataType(Connection conn, String tbl, String col) {

		Logger logger = Logger.getLogger("test");

		String columnDataType = "";

		try{
			PreparedStatement ps = conn.prepareStatement("select dt from vw_course_column_schema where tbl = ? and col = ?");
			ps.setString(1, tbl);
			ps.setString(2, col);
			ResultSet rs = ps.executeQuery();

			if(rs.next()){
				columnDataType = AseUtil.nullToBlank(rs.getString("dt"));
			}

			//System.out.println(tbl + " - " + col + " - " + columnDataType);

			rs.close();
			rs = null;
			ps.close();
			ps = null;
		}
		catch(Exception e){
			logger.fatal("KualiExport - getColumnDataType: " + e.toString());
		}

		logger.info("getColumnDataType: " + columnDataType);

		return columnDataType;

	} // getColumnDataType

	/*
	*
	* getSql
	*
	*/
	public static String getSql(String columns, String report) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String table = "";
		String where = " where coursetype='CUR'";
		String orderby = " order by campus ";

		try{

			if(report.equals("apphist")){
				table = "tblApprovalHist";
				where = " where (NOT (coursealpha IS NULL)) AND (coursealpha <> '') ";
				orderby = " order by campus, coursealpha, coursenum, approver_seq";
			}
			else if(report.equals("comp")){
				table = "tblCourseCompetency";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("content")){
				table = "tblCourseContent";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("coreq")){
				table = " tblcoreq ";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("course")){
				table = " tblcourse ";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("explain")){
				table = " tblcampusdata ";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("ini")){
				table = " tblini ";
				where = "";
				orderby = " order by campus, category ";
			}
			else if(report.equals("los")){
				table = " vw_all_campus_list ";
				where = "";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("prereq")){
				table = " tblprereq ";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("recprep")){
				table = " tblextra ";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("revhist")){
				table = "tblReviewHist";
				where = " where (NOT (coursealpha IS NULL)) AND (coursealpha <> '') ";
				orderby = " order by campus, coursealpha, coursenum";
			}
			else if(report.equals("text")){
				table = " vw_course_schema_text ";
				where = "";
				orderby = " order by campus, coursealpha, coursenum ";
			}
			else if(report.equals("xref")){
				table = " tblXRef ";
				orderby = " order by campus, coursealpha, coursenum ";
			}

			sql = "select " + columns + " from " + table + " " + where + " " + orderby;

		}
		catch(Exception e){
			logger.fatal("KualiExport - getSql: " + e.toString());
		}

		logger.info("getSql: " + sql);

		return sql;

	}

	/*


	What degree certificate (x27)
	-------
		SELECT     historyid, Campus, Src, id, coursealpha, coursenum, Grading
		FROM         vw_course_schema_extra
		WHERE     (Src = 'X27')

	is course required (x29)
	-------
		SELECT     historyid, Campus, Src, id, coursealpha, coursenum, Grading
		FROM         vw_course_schema_extra
		WHERE     (Src = 'X29')

select *
from vw_course_column_schema
WHERE tbl = 'tblextra' and col in ('CourseAlpha','CourseNum','Grading','Id')

	*/



}