/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * public static String getFieldMeta(Connection connection,String campus,String alpha,String num,String type,int access)
 *
 * @author ttgiang
 */

//
// CourseFieldsDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ase.aseutil.html.HtmlSanitizer;

public class CourseFieldsDB {
	static Logger logger = Logger.getLogger(CourseFieldsDB.class.getName());

	public CourseFieldsDB() throws Exception {}

	/*
	 * getFieldMeta
	 *	<p>
	 *	@return String
	 */
	public static String getFieldMeta(Connection conn,String kix,int access,String user) {

		//Logger logger = Logger.getLogger("test");

		int j;
		int counter = 0;
		String content = "";
		String temp = "";
		Question question = new Question();
		String fieldType = "";
		String fieldName = "";

		String alpha = "";
		String num = "";
		String type = "";
		String campus = "";
		String link = "";

		String sql = "";
		String thisQuestion = "";
		String thisSeq = "";
		String thatSeq = "";
		String explain = "";

		StringBuffer buf = new StringBuffer();
		boolean found = false;

		String questionType = "";
		String iniText = "";

		// ER26 - ttgiang 2012-04-10

		/*
		 * 1) get data record from table
		 * 2) get meta for the record
		 * 3) loop and display the data
		 *		for items where there is edits, add a link. for example, we don't like ID key
		 */

		boolean debug = false;

		try {

			com.ase.aseutil.html.HtmlSanitizer sanitizer = new com.ase.aseutil.html.HtmlSanitizer();
			Outlines outlines = new Outlines();

			PreparedStatement ps = null;
			ResultSet rs = null;
			java.util.Hashtable rsHash = null;
			String[] aFieldNames;
			ResultSetMetaData metaData = null;

			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
			campus = info[4];

			String courseItems = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
			if (access == Constant.SYSADM){
				courseItems = "*";
			}

			//------------------------------------------------------------
			// courses
			//------------------------------------------------------------
			sql = "SELECT " + courseItems + " FROM tblCourse WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			if (rs.next()) {
				found = true;

				rsHash = new java.util.Hashtable();
				aFieldNames = aseUtil.getFieldNames(rs);
				aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
				metaData = rs.getMetaData();

				for (j=0; j<aFieldNames.length; j++) {
					fieldType = metaData.getColumnTypeName(j+1);
					fieldName = aFieldNames[j];

					thisQuestion = "";
					thisSeq = "";
					thatSeq = "";
					question = QuestionDB.getCourseQuestionByColumn(conn,campus,fieldName);

					questionType = QuestionDB.getCourseQuestionTypeByFriendlyName(conn,campus,fieldName,1);

					// get explain data
					explain = QuestionDB.getExplainColumnName(conn,fieldName);
					if (!explain.equals(Constant.BLANK)){
						explain = "<br/><br/>" + QuestionDB.getExplainData(conn,campus,alpha,num,type,explain);
					} // explain

					if (question!=null){
						thisQuestion = question.getQuestion();
						thisSeq = question.getSeq();
					}

					// if a question was found or an SYS admin, show the question
					if ((!thisQuestion.equals(Constant.BLANK) && !thisSeq.equals(Constant.OFF)) || (access == Constant.SYSADM)){

						if (thisQuestion.equals(Constant.BLANK) && (access == Constant.SYSADM)){
							thisQuestion = CCCM6100DB.getCCCM6100ByColumn(conn,fieldName);
							thatSeq = fieldName;
						}

						thisQuestion = sanitizer.sanitize(thisQuestion);

						content = (String)rsHash.get(fieldName);
						content = sanitizer.sanitize(content);
						content = outlines.cleansData(fieldName,content);

						++counter;

						link = "<a name=\""+counter+"\" href=\"crsfldz.jsp?t=1&kix=" + kix + "&no=" + thisSeq + "&nox=" + thatSeq + "\" class=\"linkcolumn\">" + counter + "</a>";

						content = outlines.formatOutline(conn,fieldName,campus,alpha,num,type,kix,content,true,user);

						buf.append("<tr><td height=\"20\" width=\"5%\" class=\"textblackth\">"
								+ link
								+ ": </td><td width=\"95%\" class=\"textblackth\">"
								+ thisQuestion
								+ " (" + fieldType + ") " + "</td></tr>"
								+ "<tr><td height=\"20\" width=\"5%\" class=\"datacolumn\">&nbsp;</td><td width=\"95%\" class=\"datacolumn\">"
								+ content
								+ "<br/><br/></td></tr>");
					}

				} // for
				rs.close();
				ps.close();

				//------------------------------------------------------------
				// campus
				//------------------------------------------------------------
				String campusItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
				sql = "SELECT " + campusItems + " FROM tblCampusData WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()) {
					rsHash = new java.util.Hashtable();
					aFieldNames = aseUtil.getFieldNames(rs);
					aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
					metaData = rs.getMetaData();

					for (j=0; j<aFieldNames.length; j++) {
						fieldType = metaData.getColumnTypeName(j+1);
						fieldName = aFieldNames[j];

						thisQuestion = "";
						thisSeq = "";
						thatSeq = "";
						question = QuestionDB.getCourseQuestionByColumn(conn,campus,fieldName);

						questionType = QuestionDB.getCourseQuestionTypeByFriendlyName(conn,campus,fieldName,2);

						explain = QuestionDB.getExplainColumnName(conn,fieldName);
						if (question!=null){
							thisQuestion = question.getQuestion();
							thisSeq = question.getSeq();
						}

						if ((!thisQuestion.equals(Constant.BLANK) && !thisSeq.equals(Constant.OFF)) || (access == Constant.SYSADM)){

							if (thisQuestion.equals(Constant.BLANK) && (access == Constant.SYSADM)){
								thisQuestion = CCCM6100DB.getCCCM6100ByColumn(conn,fieldName);
								thatSeq = fieldName;
							}

							thisQuestion = sanitizer.sanitize(thisQuestion);

							content = (String)rsHash.get(fieldName);
							content = sanitizer.sanitize(content);

							++counter;

							link = "<a name=\""+counter+"\" href=\"crsfldz.jsp?t=2&kix=" + kix + "&no=" + thisSeq + "&nox=" + thatSeq + "\" class=\"linkcolumn\">" + counter + "</a>";

							content = outlines.formatOutline(conn,fieldName,campus,alpha,num,type,kix,content,true,user);

							buf.append("<tr><td height=\"20\" width=\"5%\" class=\"textblackth\">"
										+ link
										+ ": </td><td width=\"95%\" class=\"textblackth\">"
										+ thisQuestion
										+ " (" + fieldType + ") "
										+ "</td></tr>"
										+ "<tr><td height=\"20\" width=\"5%\" class=\"datacolumn\">&nbsp;</td><td width=\"95%\" class=\"datacolumn\">"
										+ content
										+ "<br/><br/></td></tr>");
						}
					} // for
					rs.close();
					ps.close();

				}
			}
			rs.close();
			ps.close();

			if (found){

				link = "<a name=\"linkeditems\" name=\""+counter+"\" href=\"crslnkdxx.jsp?kix="+kix+"&src=rawedit\" class=\"linkcolumn\"><img src=\"../images/ed_link.gif\" border=\"0\" title=\"link outline items\" alt=\"link outline items\"></a>";

				temp = "<table border=\"0\" width=\"98%\">"
					+ buf.append("<tr><td height=\"20\" width=\"5%\" class=\"textblackth\">"
										+ link
										+ "</td><td width=\"95%\" class=\"textblackth\">"
										+ "Linked outline items"
										+ "</td></tr>"
										+ "<tr><td height=\"20\" width=\"5%\" class=\"datacolumn\">&nbsp;</td><td width=\"95%\" class=\"datacolumn\">"
										+ "&nbsp;"
										+ "<br/><br/></td></tr>")
					+ "</table>";
			}
			else{
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td height=\"20\" class=\"datacolumn\">Requested outline does not exist</td></tr>" +
					"</table>";
			}

			sanitizer = null;
			outlines = null;

			MiscDB.deleteStickyMisc(conn,kix);

		} catch (SQLException e) {
			logger.fatal("CourseFieldsDB.getFieldMeta - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseFieldsDB.getFieldMeta - " + e.toString());
		}

		return temp;
	}

	/*
	 * getCatalogDesigner - returns data stored in explain field for course
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return String
	 */
	public static String getCatalogDesigner(Connection conn,String kix) {

		//Logger logger = Logger.getLogger("test");

		int j;
		int counter = 0;
		String content = "";
		String temp = "";
		Question question = new Question();
		String fieldType = "";
		String fieldName = "";

		String alpha = "";
		String num = "";
		String type = "";
		String campus = "";
		String link = "";

		String sql = "";
		String thisQuestion = "";
		String thisSeq = "";
		String thatSeq = "";
		String explain = "";

		StringBuffer buf = new StringBuffer();
		boolean found = false;

		/*
		 * 1) get data record from table
		 * 2) get meta for the record
		 * 3) loop and display the data
		 *		for items where there is edits, add a link. for example, we don't like ID key
		 */

		try {
			PreparedStatement ps = null;
			ResultSet rs = null;
			java.util.Hashtable rsHash = null;
			String[] aFieldNames;
			ResultSetMetaData metaData = null;

			AseUtil aseUtil = new AseUtil();

			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			type = info[Constant.KIX_TYPE];
			campus = info[Constant.KIX_CAMPUS];

			String courseItems = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );

			sql = "SELECT " + courseItems + " FROM tblCourse WHERE historyid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			if (rs.next()) {
				found = true;

				rsHash = new java.util.Hashtable();
				aFieldNames = aseUtil.getFieldNames(rs);
				aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
				metaData = rs.getMetaData();

				for (j=0; j<aFieldNames.length; j++) {
					fieldType = metaData.getColumnTypeName(j+1);
					fieldName = aFieldNames[j];

					thisQuestion = "";
					thisSeq = "";
					thatSeq = "";
					question = QuestionDB.getCourseQuestionByColumn(conn,campus,fieldName);

					if (question!=null){
						thisQuestion = question.getQuestion();
						thisSeq = question.getSeq();
					}

					// if a question was found or an SYS admin, show the question
					if ((!thisQuestion.equals(Constant.BLANK) && !thisSeq.equals(Constant.OFF))){

						if (thisQuestion.equals(Constant.BLANK)){
							thisQuestion = CCCM6100DB.getCCCM6100ByColumn(conn,fieldName);
							thatSeq = fieldName;
						}

						thisQuestion = HtmlSanitizer.sanitize(thisQuestion);

						content = (String)rsHash.get(fieldName);
						content = HtmlSanitizer.sanitize(content);
						explain = "c." + fieldName;

						link = "<a href=\"crsfldz.jsp?t=1&kix=" + kix + "&no=" + thisSeq + "&nox=" + thatSeq + "\" class=\"linkcolumn\">" + (++counter) + "</a>";

						if (fieldType.equals("DATETIME")) {
							Object x = content;
							content = aseUtil.ASE_FormatDateTime(x,6);
						}
						else{
							content = content + "<br>" + QuestionDB.getColumnData(conn,fieldName,kix);
						}

						buf.append("<tr><td height=\"20\" width=\"5%\" class=\"textblackth\">" + link + ": </td><td width=\"95%\" class=\"textblackth\">" + thisQuestion + " (" + fieldType + " [<span class=\"goldhighlights\">" + explain + "</span>]) " + "</td></tr>"
							+ "<tr><td height=\"20\" width=\"5%\" class=\"datacolumn\">&nbsp;</td><td width=\"95%\" class=\"datacolumn\">" + content + "<br/><br/></td></tr>");
					}

				} // for
				rs.close();
				ps.close();

				String campusItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
				sql = "SELECT " + campusItems + " FROM tblCampusData WHERE historyid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()) {
					rsHash = new java.util.Hashtable();
					aFieldNames = aseUtil.getFieldNames(rs);
					aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
					metaData = rs.getMetaData();

					for (j=0; j<aFieldNames.length; j++) {
						fieldType = metaData.getColumnTypeName(j+1);
						fieldName = aFieldNames[j];

						thisQuestion = "";
						thisSeq = "";
						thatSeq = "";
						question = QuestionDB.getCourseQuestionByColumn(conn,campus,fieldName);
						if (question!=null){
							thisQuestion = question.getQuestion();
							thisSeq = question.getSeq();
						}

						if ((!thisQuestion.equals(Constant.BLANK) && !thisSeq.equals(Constant.OFF))){

							if (thisQuestion.equals(Constant.BLANK)){
								thisQuestion = CCCM6100DB.getCCCM6100ByColumn(conn,fieldName);
								thatSeq = fieldName;
							}

							thisQuestion = HtmlSanitizer.sanitize(thisQuestion);

							content = (String)rsHash.get(fieldName);
							content = HtmlSanitizer.sanitize(content);
							explain = "cd." + fieldName;

							link = "<a href=\"crsfldz.jsp?t=2&kix=" + kix + "&no=" + thisSeq + "&nox=" + thatSeq + "\" class=\"linkcolumn\">" + (++counter) + "</a>";

							if (fieldType.equals("DATETIME")) {
								Object x = content;
								content = aseUtil.ASE_FormatDateTime(x, 6);
							}

							buf.append("<tr><td height=\"20\" width=\"5%\" class=\"textblackth\">" + link + ": </td><td width=\"95%\" class=\"textblackth\">" + thisQuestion + " (" + fieldType + " [<span class=\"goldhighlights\">" + explain + "</span>]) " + "</td></tr>"
								+ "<tr><td height=\"20\" width=\"5%\" class=\"datacolumn\">&nbsp;</td><td width=\"95%\" class=\"datacolumn\">" + content + "<br/><br/></td></tr>");
						}
					} // for
					rs.close();
					ps.close();

				}
			}
			rs.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					buf.toString() +
					"</table>";
			}
			else{
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td height=\"20\" class=\"datacolumn\">Requested outline does not exist</td></tr>" +
					"</table>";
			}
		} catch (SQLException e) {
			logger.fatal("CourseFieldsDB: getCatalogDesigner - " + e.toString());
		} catch (Exception e) {
			logger.fatal("CourseFieldsDB: getCatalogDesigner - " + e.toString());
		}

		return temp;
	} // CourseFieldsDB: getCatalogDesigner

	/**
	 * drawRawEditIndex
	 * <p>
	 * @param	conn	Connection
	 * @param	idx	int
	 * @param	min	int
	 * @param	max	int
	 * @param	forceSingleRowDisplay	boolean
	 * @param	kis	String
	 * <p>
	 * @return	String
	 */
	public static String drawRawEditIndex(int idx,int min,int max,boolean forceSingleRowDisplay,String kix){

		return drawRawEditIndex(null,null,idx,min,max,forceSingleRowDisplay,kix);

	}

	public static String drawRawEditIndex(Connection conn,String campus,int idx,int min,int max,boolean forceSingleRowDisplay,String kix){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		// 30 per line is a good count
		int lineMax = 30;

		int j = 0;

		try{

			// add 1 for the linked item icon
			++max;

			if(max > lineMax){

				// when we have an even number of items, divide evenly by 2;
				// for odd, we want to top row to have 1 more than the bottom row
				if (max % 2 == 0){
					lineMax = ((int)max / 2);
				}
				else{
					lineMax = ((int)max / 2) + 1;
				}
			}

			String si = "";

			buf.append("<div class=\"pagination\">");

			// do not include the linked item icon in this loop. it's handled after
			for(int i=min; i<max; i++){

				if (i<10){
					si = "0" + i;
				}
				else{
					si = "" + i;
				}

				buf.append("<a class=\"spanlink\" href=\"#" + i + "\">" + si + "</a>&nbsp;");

				++j;

				// drop to next line only if not forceSingleRowDisplay
				if (j == lineMax && !forceSingleRowDisplay){
					buf.append("<br/><br/>");
					j = 0;
				} // line break

			}

			buf.append("<a class=\"spanlink\" href=\"#linkeditems\"><img src=\"../images/ed_link.gif\" border=\"0\" title=\"link outline items\" alt=\"link outline items\"></a>&nbsp;")
				.append("<a class=\"spanlink\" href=\"#upload\"><img src=\"../images/attachment.gif\" border=\"0\" title=\"upload documents\" alt=\"upload documents\"></a>&nbsp;")
				.append("<a class=\"spanlink\" href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" title=\"view outline\" alt=\"view outline\"></a>&nbsp;");

			if(conn != null && campus != null){
				String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");
				if (enableCCLab.equals(Constant.ON)){
					buf.append("<a class=\"spanlink\" href=\"vwpdf.jsp?kix="+kix+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" border=\"0\" title=\"view in pdf format\" alt=\"view in pdf format\"></a>&nbsp;");
				}
			}

			buf.append("<br><br>").append("</div>");
		}
		catch(Exception ex){
			logger.fatal("CourseFieldsDB: drawRawEditIndex - " + ex.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	public void close() throws SQLException {}

}