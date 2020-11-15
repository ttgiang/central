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
import com.ase.aseutil.SQL;
import com.ase.aseutil.SQLUtil;
import com.ase.aseutil.WebSite;
import com.ase.aseutil.html.Html2Text;
import com.ase.aseutil.html.HtmlSanitizer;

public class ExportCSV {

	static Logger logger = Logger.getLogger(ExportCSV.class.getName());

	static final int adText 		= 1;
	static final int adDate 		= 2;
	static final int adNumber 		= 3;

	// header for csv processing
	static String[] header = null;

	// how CSV cells are created
	static CellProcessor[] processor = null;

	// database columns
	static String[] dataColumns = null;

	/*
	* ExportCSV
	*<p>
	* @param	conn		Connection
	* @param	report	String
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static String ExportCSV(Connection conn,String report,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		String outputFileName = "";

		String temp = "";

		boolean append = false;

		boolean hasData = true;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			header = getHeader(report);

			processor = getCellProcessor(report);

			dataColumns = getDataColumns(report);

			// make sure number of columns are similar before processing

			if((header.length == processor.length) && (processor.length == dataColumns.length)){

				String writeDir = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ outputFileName;

				String fileName = writeDir + ".out";

				String outputFile = writeDir + ".csv";

				writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);
				writer.writeHeader(header);

				String sql = SLO(report,campus,"CUR");

				final HashMap<String, ? super Object> data = new HashMap<String, Object>();

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					for(int counter = 0; counter < dataColumns.length; counter++){
						data.put(header[counter], AseUtil.nullToBlank("" + rs.getString(dataColumns[counter])));
					}
					writer.write(data, header, processor);

				}
				rs.close();
				ps.close();
			}

		} catch (IOException e) {
			logger.fatal("ExportCSV - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("ExportCSV - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ExportCSV - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("ExportCSV - " + e.toString());
			}
		}

		return outputFileName;
	} // ExportCSV

	/*
	*
	* getCellProcessor
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static CellProcessor[] getCellProcessor(String report) {

		CellProcessor[] cellProcessor = null;

		try{
			if (report.equals(Constant.COURSE_COREQ)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_OBJECTIVES)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_PREREQ)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_COMPETENCIES)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_CONTENT)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_CROSSLISTED)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_PROGRAM_SLO) || report.equals(Constant.IMPORT_PLO)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_TEXTMATERIAL)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_RECPREP)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_GESLO)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_INSTITUTION_LO)){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
			else if (report.equals(Constant.COURSE_METHODEVALUATION)){
				// not yet
			}


		}
		catch(Exception e){
			logger.fatal("ExportCSV.getCellProcessor: " + e.toString());
		}

		return cellProcessor;

	}

	/*
	*
	* getHeader
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static String[] getHeader(String report) {

		String[] header = null;

		try{
			if (report.equals(Constant.COURSE_COREQ)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "CoReq-Alpha","CoReq-Num","Comment" };
			}
			else if (report.equals(Constant.COURSE_OBJECTIVES)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "SLO" };
			}
			else if (report.equals(Constant.COURSE_PREREQ)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "PreReq-Alpha","PreReq-Num","Comments" };
			}
			else if (report.equals(Constant.COURSE_COMPETENCIES)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Content" };
			}
			else if (report.equals(Constant.COURSE_CONTENT)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "ShortContent","LongContent" };
			}
			else if (report.equals(Constant.COURSE_CROSSLISTED)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "CourseAlphaX","CourseNumX" };
			}
			else if (report.equals(Constant.COURSE_PROGRAM_SLO) || report.equals(Constant.IMPORT_PLO)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Comments" };
			}
			else if (report.equals(Constant.COURSE_TEXTMATERIAL)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Title","Edition","Author","Publisher","Year","ISBN" };
			}
			else if (report.equals(Constant.COURSE_RECPREP)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "AlphaX", "NumX", "Comments" };
			}
			else if (report.equals(Constant.COURSE_GESLO)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Comments" };
			}
			else if (report.equals(Constant.COURSE_INSTITUTION_LO)){
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Comments" };
			}
			else if (report.equals(Constant.COURSE_METHODEVALUATION)){
				// not yet
			}
		}
		catch(Exception e){
			logger.fatal("ExportCSV.getHeader: " + e.toString());
		}

		return header;

	}

	/*
	*
	* getDataColumns
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static String[] getDataColumns(String report) {

		String[] columns = null;

		try{
			if (report.equals(Constant.COURSE_COREQ)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "CoreqAlpha", "CoreqNum", "Grading" };
			}
			else if (report.equals(Constant.COURSE_OBJECTIVES)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "Comp" };
			}
			else if (report.equals(Constant.COURSE_PREREQ)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "prereqAlpha", "prereqNum", "Grading" };
			}
			else if (report.equals(Constant.COURSE_COMPETENCIES)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "content"};
			}
			else if (report.equals(Constant.COURSE_CONTENT)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "shortcontent", "longcontent" };
			}
			else if (report.equals(Constant.COURSE_CROSSLISTED)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "CourseAlphax","CourseNumX" };
			}
			else if (report.equals(Constant.COURSE_PROGRAM_SLO) || report.equals(Constant.IMPORT_PLO)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "comments"};
			}
			else if (report.equals(Constant.COURSE_TEXTMATERIAL)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "title", "edition","author","publisher","yeer","isbn", };
			}
			else if (report.equals(Constant.COURSE_RECPREP)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "Alphax", "Numx","grading" };
			}
			else if (report.equals(Constant.COURSE_GESLO)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "Comments" };
			}
			else if (report.equals(Constant.COURSE_INSTITUTION_LO)){
				columns = new String[] { "CourseAlpha", "CourseNum", "coursetitle", "Comments" };
			}
			else if (report.equals(Constant.COURSE_METHODEVALUATION)){
				// not yet
			}

		}
		catch(Exception e){
			logger.fatal("ExportCSV.getDataColumns: " + e.toString());
		}

		return columns;

	}

	/*
	*
	* SLO
	*<p>
	* @param	sql	String
	*<p>
	*
	*/
	public static String SLO(String report,String campus,String type) {

		String sql = "";
		String src2 = "";

		try{
			AseUtil aseUtil = new AseUtil();

			String select = "SELECT c.CourseAlpha, c.CourseNum, c.coursetitle, ";
			String from = " FROM tblCourse AS c INNER JOIN [FROM] AS cc ON c.historyid = cc.historyid ";
			String where = " WHERE c.campus=" + aseUtil.toSQL(campus,adText) + " "
							+ " AND c.CourseType=" + aseUtil.toSQL(type,adText) + " ";
			String order = " ORDER BY c.CourseAlpha,c.CourseNum";

			String selectX = "";
			String fromX = "";
			String whereX = "";
			String orderX = "";

			if (report.equals(Constant.COURSE_COREQ)){
				selectX = "cc.CoreqAlpha, cc.CoreqNum, cc.Grading";
				fromX = "tblCoReq";
				orderX = ",cc.id";
			}
			else if (report.equals(Constant.COURSE_OBJECTIVES)){
				selectX = "cc.Comp";
				fromX = "tblCourseComp";
				orderX = ",cc.CompID";
			}
			else if (report.equals(Constant.COURSE_PREREQ)){
				selectX = "cc.prereqAlpha, cc.prereqNum, cc.Grading";
				fromX = "tblPreReq";
				orderX = ",cc.id";
			}
			else if (report.equals(Constant.COURSE_COMPETENCIES)){
				selectX = "cc.[content]";
				fromX = "tblCourseCompetency";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_CONTENT)){
				selectX = "cc.shortcontent, cc.longcontent";
				fromX = "tblCourseContent";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_CROSSLISTED)){
				selectX = "cc.CourseAlphax, cc.CourseNumX";
				fromX = "tblXRef";
				orderX = ",cc.id";
			}
			else if (report.equals(Constant.COURSE_PROGRAM_SLO) || report.equals(Constant.IMPORT_PLO)){
				selectX = "cc.comments";
				fromX = "tblGenericContent";
				whereX = "AND cc.src=" + aseUtil.toSQL(report,adText) + " ";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_TEXTMATERIAL)){
				selectX = "cc.title, cc.edition, cc.author, cc.publisher, cc.yeer, cc.isbn";
				fromX = "tblText";
				orderX = ",cc.seq";
			}
			else if (report.equals(Constant.COURSE_RECPREP)){
				selectX = "cc.coursealpha as alphax,cc.coursenum as numx,cc.grading";
				fromX = "tblExtra";
				whereX = "AND cc.src=" + aseUtil.toSQL(report,adText) + " ";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_GESLO)){
				src2 = Constant.getAlternateName(report);
				selectX = "cc.comments";
				fromX = "tblGenericContent";
				whereX = "AND (cc.src=" + aseUtil.toSQL(report,adText) + " OR cc.src=" + aseUtil.toSQL(src2,adText) + ") ";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_INSTITUTION_LO)){
				src2 = Constant.getAlternateName(report);
				selectX = "cc.comments";
				fromX = "tblGenericContent";
				whereX = "AND (cc.src=" + aseUtil.toSQL(report,adText) + " OR cc.src=" + aseUtil.toSQL(src2,adText) + ") ";
				orderX = ",cc.rdr";
			}
			else if (report.equals(Constant.COURSE_METHODEVALUATION)){
				//
			}

			sql = select + selectX + from.replace("[FROM]",fromX) + where + whereX + order + orderX;

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("ExportCSV.SLOL: " + e.toString());
		}

		return sql;

	}

	/*
	*
	* removeHTML
	*<p>
	* @param	html	String
	*<p>
	*
	*/
	public static String removeHTML(String html) {

		if (html != null){
			html = html.replaceAll("\\<.*?\\>", "");

			html = html.replaceAll("\r", "\n");
			html = html.replaceAll("&nbsp;", " ");
			html = html.replaceAll("&amp;", "&");
			html = html.replaceAll("<br/>", "\n");
			html = html.replaceAll("&#39;", "\'");
			html = html.replaceAll("&quot;", "\"");
			html = html.replaceAll("&lt;", "<");
			html = html.replaceAll("&gt;", ">");
		}

		return html;

	}

}