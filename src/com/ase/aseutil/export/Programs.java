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
import com.ase.aseutil.QuestionDB;
import com.ase.aseutil.SQL;
import com.ase.aseutil.SQLUtil;
import com.ase.aseutil.WebSite;
import com.ase.aseutil.html.Html2Text;
import com.ase.aseutil.html.HtmlSanitizer;

import org.jsoup.*;

public class Programs {

	static Logger logger = Logger.getLogger(Programs.class.getName());

	static final int adText 		= 1;
	static final int adDate 		= 2;
	static final int adNumber 		= 3;

	// header for csv processing
	static String[] header = null;

	// how CSV cells are created
	static CellProcessor[] processor = null;

	// database columns
	static String[] dataColumns = null;

	static String programItems = null;

	static int arraySize = 0;

	/*
	* Programs
	*<p>
	* @param	conn		Connection
	* @param	report	String
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static String Programs(Connection conn,String campus,String user) {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		String outputFileName = "";

		String temp = "";

		boolean append = false;

		boolean hasData = true;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			// determine the campus question and number of questions to work with.
			// campus,progress,proposer,effectivedate,title,degree,divisionname
			// 15 HAW - proposed,requiredhours,P14,P20,P15,rationale,P17,outcomes
			// 17 HIL - outcomes,functions,organized,enroll,resources,effectiveness,additionalstaff,rationale,requiredhours,articulated
			// 20 LEE - functions,outcomes,organized,enroll,resources,efficient,effectiveness,proposed,rationale,substantive,articulated,additionalstaff,requiredhours
			QuestionDB qb = new QuestionDB();
			programItems = qb.getProgramColumns(conn,campus);
			qb = null;

			if(programItems != null && !programItems.equals("")){
				programItems = "campus,progress,proposer,effectivedate,title,degree,divisionname," + programItems + ",auditby,auditdate";
				String[] junk = programItems.split(",");
				arraySize = junk.length;
			}

			header = getHeader(campus);

			processor = getCellProcessor(campus);

			dataColumns = getDataColumns();

			// make sure number of columns are similar before processing
			if((header.length == processor.length) && (processor.length == dataColumns.length)){

				String writeDir = AseUtil.getCurrentDrive()
										+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
										+ outputFileName;

				String fileName = writeDir + ".out";

				String outputFile = writeDir + ".csv";

				writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);
				writer.writeHeader(header);

				String sql = Export(campus);

				if(sql != null && !sql.equals("")){
					final HashMap<String, ? super Object> data = new HashMap<String, Object>();
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while(rs.next()){

						for(int counter = 0; counter < dataColumns.length; counter++){
							temp = Jsoup.parse(AseUtil.nullToBlank("" + rs.getString(dataColumns[counter]))).text();
							data.put(header[counter], temp);
						}
						writer.write(data, header, processor);

					}
					rs.close();
					ps.close();
				}
			} // valid length

		} catch (IOException e) {
			logger.fatal("Programs - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("Programs - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Programs - " + e.toString());
		} finally {
			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("Programs - " + e.toString());
			}
		}

		return outputFileName;
	} // Programs

	/*
	*
	* getCellProcessor
	*<p>
	* @param	String[]
	*<p>
	*
	*/
	public static CellProcessor[] getCellProcessor(String campus) {

		Logger logger = Logger.getLogger("test");

		CellProcessor[] cellProcessor = null;

		try{
			String[] hdr = programItems.split(",");
			cellProcessor = new CellProcessor[hdr.length];
			for(int i=0; i < hdr.length; i++){
				cellProcessor[i] = new ConvertNullTo("\"\"");
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getCellProcessor: " + e.toString());
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
	public static String[] getHeader(String campus) {

		Logger logger = Logger.getLogger("test");

		String[] header = null;

		try{
			String[] hdr = programItems.split(",");
			header = new String[hdr.length];
			for(int i=0; i < hdr.length; i++){
				header[i] = hdr[i];
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getHeader: " + e.toString());
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
	public static String[] getDataColumns() {

		Logger logger = Logger.getLogger("test");

		String[] columns = null;

		try{
			String[] hdr = programItems.split(",");
			columns = new String[hdr.length];
			for(int i=0; i < hdr.length; i++){
				columns[i] = hdr[i];
			}
		}
		catch(Exception e){
			logger.fatal("Programs.getDataColumns: " + e.toString());
		}

		return columns;

	}

	/*
	*
	* Export
	*<p>
	* @param	sql	String
	*<p>
	*
	*/
	public static String Export(String campus) {

		Logger logger = Logger.getLogger("test");

		String sql = "";

		try{
			sql = "select " + programItems + " from vw_programs where campus = '" + campus+ "' order by progress";
		}
		catch(Exception e){
			logger.fatal("Programs: " + e.toString());
		}

		return sql;

	}

}