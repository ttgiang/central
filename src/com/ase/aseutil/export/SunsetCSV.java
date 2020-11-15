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

public class SunsetCSV {

	static Logger logger = Logger.getLogger(SunsetCSV.class.getName());

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
	* SunsetCSV
	*<p>
	* @param	conn		Connection
	* @param	report	String
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static String SunsetCSV(Connection conn,String report,String campus,String user) {

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

				String sql = getSQL(report,campus);

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
			logger.fatal("SunsetCSV - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("SunsetCSV - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SunsetCSV - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("SunsetCSV - " + e.toString());
			}
		}

		return outputFileName;
	} // SunsetCSV

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
			if (report.equals("kau_x18") || report.equals("kau_x71") || report.equals("kau_x72")){
				cellProcessor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\""),
																	new ConvertNullTo("\"\"") };
			}
		}
		catch(Exception e){
			logger.fatal("SunsetCSV.getCellProcessor: " + e.toString());
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
			if (report.equals("kau_x18") || report.equals("kau_x71") || report.equals("kau_x72")){
				header = new String[] { "Key", "CrsAlpha", "CrsNo", "Proposer", "CrsTitle", "DataType", "Data" };
			}
		}
		catch(Exception e){
			logger.fatal("SunsetCSV.getHeader: " + e.toString());
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
			if (report.equals("kau_x18") || report.equals("kau_x71") || report.equals("kau_x72")){
				columns = new String[] { "historyid", "CourseAlpha", "CourseNum", "proposer", "coursetitle", "datatype", "data" };
			}
		}
		catch(Exception e){
			logger.fatal("SunsetCSV.getDataColumns: " + e.toString());
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
	public static String getSQL(String report,String campus) {

		String sql = "";
		String src2 = "";

		try{
			AseUtil aseUtil = new AseUtil();

			if (report.equals("kau_x18")){
				sql = "select * from vw_kau_x18 order by c.CourseAlpha, c.CourseNum, datatype";
			}
			else if (report.equals("kau_x71")){
				sql = "select * from vw_kau_x71 order by c.CourseAlpha, c.CourseNum, datatype";
			}
			else if (report.equals("kau_x72")){
				sql = "select * from vw_kau_x72 order by c.CourseAlpha, c.CourseNum, datatype";
			}

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("SunsetCSV.SLOL: " + e.toString());
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