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
import com.ase.aseutil.CompDB;
import com.ase.aseutil.CompetencyDB;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Helper;
import com.ase.aseutil.NumericUtil;
import com.ase.aseutil.QuestionDB;
import com.ase.aseutil.SQL;
import com.ase.aseutil.SQLUtil;
import com.ase.aseutil.WebSite;
import com.ase.aseutil.html.Html2Text;
import com.ase.aseutil.html.HtmlSanitizer;

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
	public static String exportPLO(Connection conn,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		//Html2Text html2Text = null;

		//com.ase.aseutil.util.FileUtils fu = null;

		String outputFileName = "";

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

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

			//html2Text = new Html2Text();

			//fu = new com.ase.aseutil.util.FileUtils();

			// step 1 - delete old data
			String sql = "DELETE FROM tempExportPLO WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			AseUtil ae = new AseUtil();

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
				String effectiveDate = ae.ASE_FormatDateTime(rs.getString("EffectiveDate"),Constant.DATE_SHORT);
				String lastModified = ae.ASE_FormatDateTime(rs.getString("LastModified"),Constant.DATE_SHORT);
				String outcomes = AseUtil.nullToBlank(rs.getString("Outcomes"));

				// write out to a file before cleaning up unwanted codes
				//fu.writeToFile(user,outcomes);
				//fileName = writeDir + ".out";
				//outcomes = html2Text.HTML2Text(fileName);
				outcomes = HtmlSanitizer.sanitize(outcomes);

				data.put(header[0], progress);
				data.put(header[1], degree);
				data.put(header[2], division);
				data.put(header[3], title);
				data.put(header[4], effectiveDate);
				data.put(header[5], lastModified);
				data.put(header[6], removeHTML(outcomes));

				writer.write(data, header, processor);

			}
			rs.close();
			ps.close();

			ae = null;

		} catch (IOException e) {
			logger.fatal("exportPLO - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportPLO - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportPLO - " + e.toString());
		} finally {

			//fu = null;

			//html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportPLO - " + e.toString());
			}
		}

		return outputFileName;
	} // exportPLO

	/*
	* exportSLOs - export where X18 or objectives are not null. this is the original version of the report
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	* @param	report	String
	*<p>
	*
	*/
	public static String exportSLOs(Connection conn,String campus,String user,String report) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		//Html2Text html2Text = null;

		//com.ase.aseutil.util.FileUtils fu = null;

		String outputFileName = "";

		String temp = "";

		boolean append = false;

		boolean hasData = true;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			final String[] header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "EffectiveTerm", "AuditDate", "AuditBy", "SLO" };

    		CellProcessor[] processor = new CellProcessor[] { new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\"") };

			final HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer.writeHeader(header);

			//html2Text = new Html2Text();

			//fu = new com.ase.aseutil.util.FileUtils();

			String sql = "";

			if (report.equals("ApprovedOutlinesSLO")){
				hasData = true;
			}
			else if (report.equals("ApprovedOutlinesNoSLO")){
				hasData = false;
			}

			sql = SQL.showSLOs(hasData);

			boolean courseObjectives = QuestionDB.isItemIncluded(conn,campus,Constant.COURSE_OBJECTIVES);

			AseUtil ae = new AseUtil();

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"APPROVED");
			if(hasData){
				ps.setString(3,campus);
			}
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String courseAlpha = AseUtil.nullToBlank(rs.getString("courseAlpha"));
				String courseNum = AseUtil.nullToBlank(rs.getString("courseNum"));
				String courseTitle = AseUtil.nullToBlank(rs.getString("courseTitle"));
				String effectiveTerm = AseUtil.nullToBlank(rs.getString("effectiveTerm"));
				String auditDate = ae.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_SHORT);
				String auditBy = AseUtil.nullToBlank(rs.getString("proposer"));
				String x18 = AseUtil.nullToBlank(rs.getString("x18"));

				String kix = Helper.getKix(conn,campus,courseAlpha,courseNum,"CUR");

				String getCompsAsHTMLList = CompDB.getCompsAsHTMLList(conn,courseAlpha,courseNum,campus,"CUR",kix,false,Constant.COURSE_OBJECTIVES,false);

				x18 = x18 + "\n" + getCompsAsHTMLList;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = x18.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");
				}

				if (append){
					// write out to a file before cleaning up unwanted codes
					//fu.writeToFile(user,x18);
					//fileName = writeDir + ".out";
					//x18 = html2Text.HTML2Text(fileName);

					x18 = HtmlSanitizer.sanitize(x18);

					data.put(header[0], courseAlpha);
					data.put(header[1], courseNum);
					data.put(header[2], courseTitle);
					data.put(header[3], effectiveTerm);
					data.put(header[4], auditDate);
					data.put(header[5], auditBy);
					data.put(header[6], removeHTML(x18));

					writer.write(data, header, processor);
				} // append

			}
			rs.close();
			ps.close();

			ae = null;

		} catch (IOException e) {
			logger.fatal("exportSLOs - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportSLOs - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportSLOs - " + e.toString());
		} finally {

			//fu = null;

			//html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportSLOs - " + e.toString());
			}
		}

		return outputFileName;
	} // exportSLOs

	/*
	* exportCompetencies - export where X43 not null. this is the original version of the report
	*<p>
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	* @param	report	String
	*<p>
	*
	*/
	public static String exportCompetencies(Connection conn,String campus,String user,String report) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		//Html2Text html2Text = null;

		//com.ase.aseutil.util.FileUtils fu = null;

		String outputFileName = "";

		String temp = "";

		boolean append = false;

		boolean hasData = true;

		try{
			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			final String[] header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "EffectiveTerm", "AuditDate", "AuditBy", "Competencies" };

    		CellProcessor[] processor = new CellProcessor[] { new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\""),
    																			new ConvertNullTo("\"\"") };

			final HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer.writeHeader(header);

			//html2Text = new Html2Text();

			//fu = new com.ase.aseutil.util.FileUtils();

			String sql = "";

			if (report.equals("ApprovedOutlinesComp")){
				hasData = true;
			}
			else if (report.equals("ApprovedOutlinesNoComp")){
				hasData = false;
			}

			sql = SQL.showCompetencies(hasData);

			AseUtil ae = new AseUtil();

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"APPROVED");
			if(hasData){
				ps.setString(3,campus);
			}
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String courseAlpha = AseUtil.nullToBlank(rs.getString("courseAlpha"));
				String courseNum = AseUtil.nullToBlank(rs.getString("courseNum"));
				String courseTitle = AseUtil.nullToBlank(rs.getString("courseTitle"));
				String effectiveTerm = AseUtil.nullToBlank(rs.getString("effectiveTerm"));
				String auditDate = ae.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_SHORT);
				String auditBy = AseUtil.nullToBlank(rs.getString("proposer"));
				String x43 = AseUtil.nullToBlank(rs.getString("x43"));

				String kix = Helper.getKix(conn,campus,courseAlpha,courseNum,"CUR");

				String getCompetenciesAsHTMLList = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false,false);

				x43 = x43 + "\n" + getCompetenciesAsHTMLList;

				append = true;

				// this code removes all tags from the string. if nothing is left,
				// then the string is empty. if there is data, then it contains something other than html.
				if (hasData){
					temp = x43.replaceAll("\\<.*?>","");
					temp = temp.replaceAll(" ","");
					temp = temp.replaceAll("&nbsp;","");
					temp = temp.replaceAll("<br>","");
					temp = temp.replaceAll("</br>","");
					temp = temp.replaceAll("<br/>","");
					temp = temp.replaceAll("<p>","");
					temp = temp.replaceAll("</p>","");
					temp = temp.replaceAll("\n", "");
					temp = temp.replaceAll("\r", "");
				}

				if (append){
					// write out to a file before cleaning up unwanted codes
					//fu.writeToFile(user,x18);
					//fileName = writeDir + ".out";
					//x18 = html2Text.HTML2Text(fileName);

					x43 = HtmlSanitizer.sanitize(x43);

					data.put(header[0], courseAlpha);
					data.put(header[1], courseNum);
					data.put(header[2], courseTitle);
					data.put(header[3], effectiveTerm);
					data.put(header[4], auditDate);
					data.put(header[5], auditBy);
					data.put(header[6], removeHTML(x43));

					writer.write(data, header, processor);
				} // append

			}
			rs.close();
			ps.close();

			ae = null;

		} catch (IOException e) {
			logger.fatal("exportCompetencies - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportCompetencies - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportCompetencies - " + e.toString());
		} finally {

			//fu = null;

			//html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportCompetencies - " + e.toString());
			}
		}

		return outputFileName;
	} // exportCompetencies

	/*
	* exportGeneric - export other types of data
	*<p>
	* @param	request	HttpServletRequest
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	* @param	report	String
	*<p>
	*
	*/
	public static String exportGeneric(HttpServletRequest request,Connection conn,String campus,String user,String report) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		String outputFileName = "";

		String sql = "";

		PreparedStatement ps = null;

		WebSite website = null;

		HttpSession session = request.getSession(true);

		try{
			website = new WebSite();

			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

			String[] header = null;

			String[] column = null;

    		CellProcessor[] processor = null;

			HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			html2Text = new Html2Text();

			if (	report.equals("ApprovedAcademicYear") ||
					report.equals("DeletedAcademicYear") ||
					report.equals("ModifiedAcademicYear")){

				String dateField = "";

				if (report.equals("ApprovedAcademicYear")){
					dateField = "coursedate";
				}
				else if (report.equals("DeletedAcademicYear")){
					dateField = "coursedate";
				}
				else if (report.equals("ModifiedAcademicYear")){
					dateField = "auditdate";
				}
				else{
					dateField = "auditdate";
				}

				String fromDate = (String)session.getAttribute("aseParm2");
				String toDate = (String)session.getAttribute("aseParm3");
				String progress = (String)session.getAttribute("aseParm5");
				String semester = (String)session.getAttribute("aseParm6");
				sql = SQL.showOutlinesModifiedByAcademicYear(progress,semester);
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,fromDate);
				ps.setString(3,toDate);

				if(semester != null && semester.length() > 0){
					ps.setString(4,semester);
				}

				processor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Date", "Proposer", "Progress", "Term" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle", dateField, "proposer", "progress", "TERM_DESCRIPTION" };
			}
			else if (report.equals("ApprovedOutlines")){
				sql = SQL.outlinesShowOutlines;
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,"APPROVED");
				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle" };
			}
			else if (report.equals("ApprovedOutlines2")){
				sql = SQL.outlinesShowOutlines;
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,"APPROVED");
				processor = new CellProcessor[] {	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle" };
			}
			else if (report.equals("ApprovedOutlinesSLO")){
				sql = SQL.showSLOs(true);
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,"APPROVED");
				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle" };
			}
			else if (report.equals("ApprovedOutlinesNoSLO")){
				sql = SQL.showSLOs(false);
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,"APPROVED");
				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle" };
			}
			else if (report.equals("EffectiveTerms")){
				String terms = (String)session.getAttribute("aseParm2");
				sql =  SQL.EffectiveTerms;
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,terms);
				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle" };
			}
			else if (	report.toLowerCase().equals("enddate") ||
							report.toLowerCase().equals("experimentaldate") ||
							report.toLowerCase().equals("reviewdate")
					) {

				String rptYear = (String)session.getAttribute("aseParm2");
				String rptMonth = (String)session.getAttribute("aseParm3");

				String dateColumn = "";

				// default SQL includes year and month
				if(report.toLowerCase().equals("enddate")){
					sql = SQL.endDate;
					dateColumn = "enddate";
				}
				else if(report.toLowerCase().equals("experimentaldate")){
					sql = SQL.experimentalDate;
					dateColumn = "experimentaldate";
				}
				else if(report.toLowerCase().equals("reviewdate")){
					sql = SQL.reviewDate;
					dateColumn = "reviewdate";
				}

				// when month is not used
				if(rptMonth == null || rptMonth.length() == 0){

					if(report.toLowerCase().equals("enddate")){
						sql = SQL.endDateYY;
					}
					else if(report.toLowerCase().equals("experimentaldate")){
						sql = SQL.experimentalDateYY;
					}
					else if(report.toLowerCase().equals("reviewdate")){
						sql = SQL.reviewDateYY;
					}

				}

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,NumericUtil.getInt(rptYear,0));

				if(rptMonth != null && rptMonth.length() > 0){
					ps.setInt(3,NumericUtil.getInt(rptMonth,0));
				}

				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "Date" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle", dateColumn };
			}
			else if (report.equals("TextMaterials")){
				String type = (String)session.getAttribute("aseParm2");
				String term = (String)session.getAttribute("aseParm3");
				sql = SQL.textMaterials;
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				ps.setString(3,term);
				processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\""),
																new ConvertNullTo("\"\"") };
				header = new String[] { "CrsAlpha", "CrsNo", "CrsTitle", "BookAuthor", "BookTitle" };
				column = new String[] { "courseAlpha", "courseNum", "courseTitle", "author", "title" };
			}

			writer.writeHeader(header);

			int columnCounter = header.length;

			AseUtil aseUtil = new AseUtil();

			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				for(int i=0; i<columnCounter; i++){

					if(header[i].toLowerCase().contains("date")){
						data.put(header[i], aseUtil.ASE_FormatDateTime(rs.getString(column[i]),Constant.DATE_SHORT));
					}
					else{
						data.put(header[i], AseUtil.nullToBlank(rs.getString(column[i])));
					}

				} // for

				writer.write(data, header, processor);

			} // while
			rs.close();
			ps.close();

			aseUtil = null;

		} catch (IOException e) {
			logger.fatal("exportGeneric - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportGeneric - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportGeneric - " + e.toString());
		} finally {

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportGeneric - " + e.toString());
			}
		}

		return outputFileName;
	} // exportGeneric

	/*
	* exportApprovalStatus - export other types of data
	*<p>
	* @param	request	HttpServletRequest
	* @param	conn		Connection
	* @param	campus	String
	* @param	user		String
	* @param	report	String
	*<p>
	*
	*/
	public static String exportApprovalStatus(HttpServletRequest request,Connection conn,String campus,String user,String report) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		ICsvMapWriter writer = null;

		Html2Text html2Text = null;

		String outputFileName = "";

		WebSite website = null;

		HttpSession session = request.getSession(true);

		try{
			website = new WebSite();

			outputFileName = user + "_" + SQLUtil.createHistoryID(1);

			String writeDir = AseUtil.getCurrentDrive()
									+ ":\\tomcat\\webapps\\centraldocs\\docs\\temp\\"
									+ outputFileName;

			String fileName = writeDir + ".out";

			String outputFile = writeDir + ".csv";

			String[] header = null;

			String[] column = null;

    		CellProcessor[] processor = null;

			HashMap<String, ? super Object> data = new HashMap<String, Object>();

			writer = new CsvMapWriter(new FileWriter(outputFile),CsvPreference.EXCEL_PREFERENCE);

			html2Text = new Html2Text();

			processor = new CellProcessor[] { 	new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\""),
															new ConvertNullTo("\"\"") };
			header = new String[] { "Outline", "Progress", "Proposer", "CurrentApprover", "NextApprover", "DateProposed", "LastUpdated", "RoutingSequence" };

			writer.writeHeader(header);

			int columnCounter = header.length;

			for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.COURSE,user)){

				data.put(header[0], HtmlSanitizer.sanitize(AseUtil.nullToBlank(o.getOutline())));
				data.put(header[1], AseUtil.nullToBlank(o.getProgress()));
				data.put(header[2], AseUtil.nullToBlank(o.getProposer()));
				data.put(header[3], AseUtil.nullToBlank(o.getCurrent()));
				data.put(header[4], AseUtil.nullToBlank(o.getNext()));
				data.put(header[5], AseUtil.nullToBlank(o.getDateProposed()));
				data.put(header[6], AseUtil.nullToBlank(o.getLastUpdated()));
				data.put(header[7], AseUtil.nullToBlank(o.getRoute()));

				writer.write(data, header, processor);
			} // for

		} catch (IOException e) {
			logger.fatal("exportApprovalStatus - " + e.toString());
		} catch (SQLException e) {
			logger.fatal("exportApprovalStatus - " + e.toString());
		} catch (Exception e) {
			logger.fatal("exportApprovalStatus - " + e.toString());
		} finally {

			html2Text = null;

			try{
				writer.close();
			} catch (IOException e) {
				logger.fatal("exportApprovalStatus - " + e.toString());
			}
		}

		return outputFileName;
	} // exportApprovalStatus

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