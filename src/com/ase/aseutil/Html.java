/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 *	public static String drawRadio(Connection conn,String fieldRef,String fieldName,String fieldValue,String campus,boolean required)
 *	public static String drawListBox(Connection conn,String fieldRef,String fieldName,String fieldValue,String campus,boolean required)
 *	public static String fixSpaceEncoding(String html)
 *	public static boolean isMatch(Connection conn,String kix) throws SQLException {
 *	public static int updateHtml(Connection conn,String category,String kix) {
 *
 */

//
// Html.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.htmlcleaner.CleanerProperties;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.HtmlCleanerException;
import org.htmlcleaner.TagNode;

public class Html {

	static Logger logger = Logger.getLogger(Html.class.getName());

	public Html() throws Exception {}

	/**
	 * drawRadio - create outline template
	 * <p>
	 * @param	conn			Connection
	 * @param	fieldRef		String
	 * @param	fieldName	String
	 * @param	fieldValue	String
	 * @param	campus		String
	 * @param	required		boolean
	 * @param	forceHorizontalPrint
	 * <p>
	 * @return String
	 */
	public static String drawRadio(Connection conn,
											String fieldRef,
											String fieldName,
											String fieldValue,
											String campus,
											boolean required) {

		return drawRadio(conn,fieldRef,"",fieldName,fieldValue,campus,required,false);

	}

	public static String drawRadio(Connection conn,
											String fieldRef,
											String fieldName,
											String fieldValue,
											String campus,
											boolean required,
											boolean forceHorizontalPrint) {

		return drawRadio(conn,fieldRef,"",fieldName,fieldValue,campus,required,forceHorizontalPrint);

	}

	public static String drawRadio(Connection conn,
											String fieldRef,
											String fieldOptions,
											String fieldName,
											String fieldValue,
											String campus,
											boolean required) {

		return drawRadio(conn,fieldRef,fieldOptions,fieldName,fieldValue,campus,required,false);

	}

	public static String drawRadio(Connection conn,
											String fieldRef,
											String fieldOptions,
											String fieldName,
											String fieldValue,
											String campus,
											boolean required,
											boolean forceHorizontalPrint) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String[] selectedValue;
		String[] selectedName;
		String[] iniValues;
		String[] inputValues;
		String[] userValue;
		String selected = "";
		String sql;
		String junk = "";
		String requiredInput = "input";
		String html = "";
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

		String v1 = null;
		String v2 = null;

		boolean printMultipleLines = false;

		int i = 0;

		try {
			if (fieldRef.indexOf(",") > -1){
				String[] aFieldRef = fieldRef.split(",");
				String[] aFieldOptions = fieldOptions.split(",");

				for (i=0; i<aFieldRef.length; i++){
					if (i > 0) {
						s1.append("~");
						s2.append("~");
					}
					s1.append(aFieldOptions[i]);
					s2.append(aFieldRef[i]);
				}
			}
			else if (fieldRef.equals("YN")){
				s1.append("1~0");
				s2.append("Y~N");
			}
			else if (fieldRef.equals("YESNO")){
				s1.append("1~0");
				s2.append("Yes~No");
			}
			else{
				sql = "SELECT id,kdesc "
					+ "FROM tblINI "
					+ "WHERE campus=? AND "
					+ "category=? "
					+ "ORDER BY kdesc";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,fieldRef);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					v1 = AseUtil.nullToBlank(rs.getString(1));
					v2 = AseUtil.nullToBlank(rs.getString(2));

					if (i > 0) {
						s1.append("~");
						s2.append("~");
					}
					s1.append(v1);
					s2.append(v2);
					i = 1;
				}
				rs.close();
				ps.close();
			}

			selectedValue = s1.toString().split("~");
			selectedName = s2.toString().split("~");

			if (selectedValue.length > 2 && !forceHorizontalPrint)
				printMultipleLines = true;

			for (i=0;i<selectedValue.length; i++) {

				if (fieldValue.equals(selectedValue[i]))
					selected = "checked";
				else
					selected = "";

				temp.append("<input type=\"radio\" "
					+ "value=\"" + selectedValue[i] + "\" "
					+ "name=\"" + fieldName +"\" " + selected + ">" + selectedName[i] + "&nbsp;&nbsp;");

				if (printMultipleLines)
					temp.append("<br>");
			}

			html = temp.toString();

		} catch (Exception pe) {
			logger.fatal("Html - drawRadio - " + pe.toString());
		}

		return html;
	}

	/**
	 * drawANDORRadio
	 * <p>
	 * @param	fieldName	String
	 * <p>
	 * @return String
	 */
	public static String drawANDORRadio(String fieldName,String defalt) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String[] selectedValue;
		String[] selectedName;
		String html = "";
		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

		String selected = "";

		int i = 0;

		try {
			s1.append("AND~OR");
			s2.append("AND~OR");

			selectedValue = s1.toString().split("~");
			selectedName = s2.toString().split("~");

			for (i=0;i<selectedValue.length; i++) {

				if (defalt.equals(selectedValue[i]))
					selected = "checked";
				else
					selected = "";

				temp.append("<input type=\"radio\" "
					+ "value=\"" + selectedValue[i] + "\" "
					+ "name=\"" + fieldName +"\" " + selected + ">" + selectedName[i] + "&nbsp;&nbsp;");
			}

			html = temp.toString();

		} catch (Exception pe) {
			logger.fatal("Html - drawANDORRadio - " + pe.toString());
		}

		return html;
	}

	/**
	 * drawListBox
	 * <p>
	 * @param	conn			Connection
	 * @param	fieldRef		String
	 * @param	fieldName	String
	 * @param	fieldValue	String
	 * @param	campus		String
	 * @param	required		boolean
	 * <p>
	 * @return String
	 */
	public static String drawListBox(Connection conn,
												String fieldRef,
												String fieldName,
												String fieldValue,
												String campus,
												boolean required) {

		return drawListBox(conn,fieldRef,fieldName,fieldValue,campus,required,true);

	}

	public static String drawListBox(Connection conn,
											String fieldRef,
											String fieldName,
											String fieldValue,
											String campus,
											boolean required,
											boolean defult) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String selected = "";
		String sql;
		String requiredInput = "input";
		String html = "";
		String id = "";
		boolean found = false;

		try {
			sql = "SELECT id,kid "
				+ "FROM tblINI "
				+ "WHERE campus=? AND "
				+ "category=? "
				+ "ORDER BY kid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,fieldRef);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getString(1);

				if (fieldValue.equals(id))
					selected = "selected";
				else
					selected = "";

				temp.append("<option " + selected + " value=\"" + id + "\">" + rs.getString(2) + "</option>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				html = "<select name=\'" + fieldName + "\' class=\'" + requiredInput + "\'>";

				if (!defult)
					html += "<option value=\"\">-select routing-</option>";

				html += temp.toString()
					+ "</select>";
			}

		} catch (Exception pe) {
			logger.fatal("Html - drawListBox - " + pe.toString());
		}

		return html;
	}

	/**
	 * fixSpaceEncoding
	 * <p>
	 * @param	html	String
	 * <p>
	 * @return 	String
	 */
	public static String fixSpaceEncoding(String html) {

		// some where along the saving of data, we lost the ;
		if (html != null && html.length() > 0){
			html = html.replace("@amp;nbsp;","@amp;n--bsp;");
			html = html.replace("&amp;nbsp","");
			html = html.replace("@amp;n--bsp;","@amp;nbsp;");
		}

		return html;
	}

	/**
	 * fixHTMLEncoding
	 * <p>
	 * @param	html	String
	 * <p>
	 * @return 	String
	 */
	public static String fixHTMLEncoding(String html) {

		// some where along the saving of data, we lost the ;

		// start by saving the correctly encoding sequence using the --
		// replace all malformed sequence with correct sequences
		// put back the saved encoding

		if (html != null && html.length() > 0){

			// space
			html = html.replace("@amp;nbsp;","@amp;n--bsp;");
			html = html.replace("&amp;nbsp","&nbsp;");
			html = html.replace("@amp;n--bsp;","@amp;nbsp;");

			// quotes
			html = html.replace("&amp;quot;","&amp;qu--ot;");
			html = html.replace("&amp;quot","&quot;");
			html = html.replace("&amp;qu--ot;","&amp;quot;");

		}

		return html;
	}

	/**
	 * HTML_BR
	 */
	public static String BR(){

		return "<br>";

	}

	/**
	 * NewLine
	 */
	public static String NewLine(){

		return "\n";

	}

	/**
	 * Cleaner
	 *
	 * <p>
	 * @param	html2Clean
	 * <p>
	 */
	public static String Cleaner(String html2Clean){

		if (html2Clean != null){

			try{
				// create an instance of HtmlCleaner
				HtmlCleaner cleaner = new HtmlCleaner();

				// take default cleaner properties
				CleanerProperties props = cleaner.getProperties();

				TagNode node = cleaner.clean(html2Clean);

				html2Clean = node.getText().toString();
			}
			catch(HtmlCleanerException e){
				html2Clean = "";
			}
			catch(Exception e){
				html2Clean = "";
			}
		}
		else
			html2Clean = "";

		return html2Clean;

	}

	/**
	 * drawYearListBox
	 *
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	progress
	 * <p>
	 */
	public static String drawYearListBox(Connection conn,
														String campus,
														String progress,
														String controlName,
														String selectedValue,
														String future1){
		//Logger logger = Logger.getLogger("test");

		String years = "";

		try{

			String dateField = "";
			String coursetype = "PRE";

			if (progress.equals("APPROVED")){
				dateField = "coursedate";
				coursetype = "CUR";
			}
			else if (progress.equals("MODIFY")){
				dateField = "auditdate";
				coursetype = "PRE";
			}
			else{
				progress = "MODIFY";
				dateField = "auditdate";
				coursetype = "PRE";
			}

			String sql = "SELECT distinct year("+dateField+") AS [yeer] "
				+ "FROM tblCourse WHERE campus=? AND coursetype=? AND not "+dateField+" is null "
				+ "ORDER BY year("+dateField+")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,coursetype);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (years.equals(Constant.BLANK))
					years = rs.getString("yeer");
				else
					years = years + "," + rs.getString("yeer");
			}
			rs.close();
			ps.close();

			AseUtil aseUtil = new AseUtil();

			years = aseUtil.createStaticSelectionBox(years,
																	years,
																	controlName,
																	selectedValue,
																	"",
																	"",
																	future1,
																	"");

			aseUtil = null;

		} catch (SQLException pe) {
			logger.fatal("Html - drawYearListBox - " + pe.toString());
		} catch (Exception pe) {
			logger.fatal("Html - drawYearListBox - " + pe.toString());
		}

		return years;

	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	int
	 */
	public static boolean isMatch(Connection conn,String kix) throws SQLException {

		String sql = "SELECT historyid FROM tblHtml WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/**
	 * updateHtml
	 * <p>
	 * @param	conn		Connection
	 * @param	category	String
	 * @param	kix		String
	 * <p>
	 * @return	int
	 */
	public static int updateHtml(Connection conn,String category,String kix) {

		String sql = "";
		String table = "";

		int rowsAffected = 0;
		PreparedStatement ps = null;

		try {
			if (!isMatch(conn,kix)){
				if (category.equals(Constant.COURSE))
					table = "tblCourse";
				else
					table = "tblPrograms";

				sql = "INSERT INTO tblHtml (campus,historyid,category,html) "
						+ "SELECT campus, historyid, '"+category+"' as category, getdate() "
						+ "FROM " + table + " "
						+ "WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				sql = "UPDATE tblHtml SET html=? WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setString(2,kix);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("Html: updateHtml - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Html: updateHtml - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * drawOutlineDateListBox
	 *
	 * <p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	controlName		String
	 * @param	selectedValue	String
	 * @param	future			String
	 * @param	dateColumn		String
	 * <p>
	 */
	public static String drawOutlineDateListBox(Connection conn,
														String campus,
														String controlName,
														String selectedValue,
														String future,
														String dateColumn){

		//Logger logger = Logger.getLogger("test");

		String years = "";

		try{

			String sql = "SELECT distinct year("+dateColumn+") AS [yeer] "
				+ "FROM tblCourse WHERE campus=? AND coursetype='CUR' AND not "+dateColumn+" is null "
				+ "ORDER BY year("+dateColumn+")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (years.equals(Constant.BLANK))
					years = rs.getString("yeer");
				else
					years = years + "," + rs.getString("yeer");
			}
			rs.close();
			ps.close();

			AseUtil aseUtil = new AseUtil();

			years = aseUtil.createStaticSelectionBox(years,
																	years,
																	controlName,
																	selectedValue,
																	"",
																	"",
																	future,
																	"");

			aseUtil = null;

		} catch (SQLException pe) {
			logger.fatal("Html - drawOutlineDateListBox - " + pe.toString());
		} catch (Exception pe) {
			logger.fatal("Html - drawOutlineDateListBox - " + pe.toString());
		}

		return years;

	}

	/**
	 * drawSemesterList
	 *
	 * <p>
	 * @param	conn				Connection
	 * @param	campus			String
	 * @param	progress			String
	 * @param	control			String
	 * @param	fromYear			String
	 * @param	toYear			String
	 * @param	selectedValue 	String
	 * @param	future1			String
	 * <p>
	 */
	public static String drawSemesterList(Connection conn,
														String campus,
														String progress,
														String control,
														String fromYear,
														String toYear,
														String selectedValue,
														String future1){

		//Logger logger = Logger.getLogger("test");

		//
		// returns terms within date range
		//

		String terms = "";
		String codes = "";

		try{

			String dateField = "";
			String coursetype = "PRE";

			if (progress.equals("APPROVED")){
				dateField = "coursedate";
				coursetype = "CUR";
			}
			else if (progress.equals("MODIFY")){
				dateField = "auditdate";
				coursetype = "PRE";
			}
			else{
				progress = "MODIFY";
				dateField = "auditdate";
				coursetype = "PRE";
			}

			String sql = "SELECT distinct year("+dateField+") AS [yeer] "
				+ "FROM tblCourse WHERE campus=? AND coursetype=? AND not "+dateField+" is null "
				+ "ORDER BY year("+dateField+")";

			sql = "SELECT DISTINCT c.effectiveterm, b.TERM_DESCRIPTION "
				+ "FROM tblCourse c INNER JOIN BannerTerms b ON c.effectiveterm = b.TERM_CODE "
				+ "WHERE c.campus=? AND c.CourseType=?  "
				+ "AND (YEAR(c."+dateField+") >= ? AND YEAR(c."+dateField+") <= ?) "
				+ "ORDER BY b.TERM_DESCRIPTION";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,coursetype);
			ps.setString(3,fromYear);
			ps.setString(4,toYear);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (terms.equals(Constant.BLANK)){
					terms = rs.getString("effectiveterm");
					codes = rs.getString("TERM_DESCRIPTION");
				}
				else{
					terms = terms + "," + rs.getString("effectiveterm");
					codes = codes + "," + rs.getString("TERM_DESCRIPTION");
				}
			}
			rs.close();
			ps.close();

			AseUtil aseUtil = new AseUtil();

			terms = aseUtil.createStaticSelectionBox(codes,
																	terms,
																	control,
																	selectedValue,
																	"",
																	"",
																	future1,
																	"");

			aseUtil = null;

		} catch (SQLException pe) {
			logger.fatal("Html - drawSemesterList - " + pe.toString());
		} catch (Exception pe) {
			logger.fatal("Html - drawSemesterList - " + pe.toString());
		}

		return terms;

	}

	/**
	 * close
	 * <p>
	 */
	public void close() throws SQLException {}

}
