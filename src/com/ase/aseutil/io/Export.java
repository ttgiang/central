/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.io;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.html.Html2Text;

import java.io.*;
import java.sql.*;
import java.util.HashMap;

import org.supercsv.io.*;
import org.supercsv.cellprocessor.ConvertNullTo;
import org.supercsv.cellprocessor.ift.*;
import org.supercsv.prefs.CsvPreference;

import org.apache.log4j.Logger;

public class Export {

	static Logger logger = Logger.getLogger(Export.class.getName());

	/*
	* exportPLO
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static int exportPLO(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String writeDir = AseUtil.getCurrentDrive()
								+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
								+ user;

		String fileName = writeDir + ".out";

		String outputFile = writeDir + ".csv";

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		com.ase.aseutil.util.FileUtils fu = null;

		try{
			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			final String[] header = new String[] { "Progress", "Degree", "Division", "Title", "EffectiveDate", "LastModified", "Outcomes" };

    		CellProcessor[] processor = new CellProcessor[] { new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\"") };

			final HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer.writeHeader(header);

			html2Text = new Html2Text();

			fu = new com.ase.aseutil.util.FileUtils();

			// step 1 - delete old data
			String sql = "DELETE FROM tempExportPLO WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// step 2 - insert new data
			sql = "INSERT INTO tempExportPLO "
				+ "SELECT '"+campus+"',p.progress, deg.degree_title + ' - ' + deg.degree_alpha AS degree, div.divisionname + ' - ' + div.divisioncode AS division, "
				+ "p.title, p.effectivedate,CONVERT(varchar, p.auditdate, 103) AS LastModified, p.outcomes "
				+ "FROM tblPrograms AS p INNER JOIN "
				+ "tblDegree AS deg ON p.degreeid = deg.degree_id LEFT OUTER JOIN "
				+ "tblDivision AS div ON p.campus = div.campus AND p.divisionid = div.divid "
				+ "WHERE p.campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			// step 3 - select and process new data
			sql = "SELECT progress,degree,division,title,effectivedate,LastModified,outcomes "
				+ "FROM tempExportPLO "
				+ "WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String degree = AseUtil.nullToBlank(rs.getString("degree"));
				String division = AseUtil.nullToBlank(rs.getString("division"));
				String title = AseUtil.nullToBlank(rs.getString("Title"));
				String effectiveDate = AseUtil.nullToBlank(rs.getString("EffectiveDate"));
				String lastModified = AseUtil.nullToBlank(rs.getString("LastModified"));
				String outcomes = AseUtil.nullToBlank(rs.getString("Outcomes"));

				fu.writeToFile(user,outcomes);

				fileName = writeDir + ".out";

				outcomes = html2Text.HTML2Text(fileName);

				data.put(header[0], progress);
				data.put(header[1], degree);
				data.put(header[2], division);
				data.put(header[3], title);
				data.put(header[4], effectiveDate);
				data.put(header[5], lastModified);
				data.put(header[6], removeHTMLTags(outcomes));

				writer.write(data, header, processor);

			}
			rs.close();
			ps.close();

		} catch (IOException e) {
			logger.fatal("exportPLO - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportPLO - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportPLO - " + e.toString());
		} finally {

			fu = null;

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportPLO - " + e.toString());
			}
		}

		return rowsAffected;
	} // exportPLO

	/*
	* exportCCCM6100
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	*<p>
	*
	*/
	public static int exportCCCM6100(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String writeDir = AseUtil.getCurrentDrive()
								+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
								+ user;

		String fileName = writeDir + ".out";

		String outputFile = writeDir + ".csv";

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		com.ase.aseutil.util.FileUtils fu = null;

		try{
			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			final String[] header = new String[] { "Progress", "Degree", "Division", "Title", "EffectiveDate", "LastModified", "Outcomes" };

    		CellProcessor[] processor = new CellProcessor[] { new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\"") };

			final HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer.writeHeader(header);

			html2Text = new Html2Text();

			fu = new com.ase.aseutil.util.FileUtils();

			String sql = "SELECT question_number,cccm6100,question_friendly,question_type "
				+ "FROM CCCM6100 "
				+ "WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String progress = AseUtil.nullToBlank(rs.getString("progress"));
				String degree = AseUtil.nullToBlank(rs.getString("degree"));
				String division = AseUtil.nullToBlank(rs.getString("division"));
				String title = AseUtil.nullToBlank(rs.getString("Title"));
				String effectiveDate = AseUtil.nullToBlank(rs.getString("EffectiveDate"));
				String lastModified = AseUtil.nullToBlank(rs.getString("LastModified"));
				String outcomes = AseUtil.nullToBlank(rs.getString("Outcomes"));

				fu.writeToFile(user,outcomes);

				fileName = writeDir + ".out";

				outcomes = html2Text.HTML2Text(fileName);

				data.put(header[0], progress);
				data.put(header[1], degree);
				data.put(header[2], division);
				data.put(header[3], title);
				data.put(header[4], effectiveDate);
				data.put(header[5], lastModified);
				data.put(header[6], removeHTMLTags(outcomes));

				writer.write(data, header, processor);

			}
			rs.close();
			ps.close();

		} catch (IOException e) {
			logger.fatal("exportCCCM6100 - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportCCCM6100 - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportCCCM6100 - " + e.toString());
		} finally {

			fu = null;

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportCCCM6100 - " + e.toString());
			}
		}

		return rowsAffected;
	} // exportCCCM6100

	/*
	*
	* removeHTMLTags
	*<p>
	* @param	html	String
	*<p>
	*
	*/
	public static String removeHTMLTags(String html) {

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