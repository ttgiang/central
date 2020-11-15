/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 *	public static String reorderList(Connection conn,int list,String kix)
 *
 * @author ttgiang
 */

//
// Reorder.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class Reorder {

	static Logger logger = Logger.getLogger(Reorder.class.getName());

	public Reorder() throws Exception {}

	/**
	 * insertText
	 * <p>
	 * @param	conn	Connection
	 * @param	list	int
	 * @param	kix	String
	 * @param	src	String
	 * @param	dst	String
	 * <p>
	 * @return	int
	 */
	public static String reorderList(Connection conn,int list,String kix,String src,String dst) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int id = 0;
		long numberOfEntries = 0;
		int numberOfFields = 0;
		String sql = "";
		String alpha = "";
		String num = "";
		String type = "";
		String grading = "";
		String temp = "";
		String campus = "";
		String fields = "";
		String order = "";
		String table = "";
		String[] columns;
		String[] header;
		String[] data;
		String title = "";
		String hiddenIds = "";
		String hiddenRDR = "";

		if (!kix.equals(Constant.BLANK)){
			String[] info = Helper.getKixInfo(conn,kix);
			type = info[Constant.KIX_TYPE];
			campus = info[Constant.KIX_CAMPUS];
		}

		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuffer buf = new StringBuffer();
		StringBuffer sel = new StringBuffer();

		int parm3 = 0;

		switch(list){
			case Constant.COURSE_ITEM_PREREQ:
				fields = "id,rdr,prereqalpha,prereqnum,grading";
				title = "id,Sequence,Alpha,Number,Comment";
				order = "id";
				table = "tblPrereq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_COREQ:
				fields = "id,rdr,coreqalpha,coreqnum,grading";
				title = "id,Sequence,Alpha,Number,Comment";
				order = "id";
				table = "tblcoreq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_SLO:
				fields = "compid,rdr,comp";
				title = "compid,Sequence,SLO";
				order = "compid";
				table = "tblcoursecomp";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_CONTENT:
				fields = "contentid,rdr,longcontent";
				title = "contentid,Sequence,Content";
				order = "contentid";
				table = "tblcoursecontent";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_COMPETENCIES:
				fields = "seq,rdr,content";
				title = "seq,Sequence,Content";
				order = "seq";
				table = "tblCourseCompetency";
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_COURSE_RECPREP:
				fields = "id,rdr,coursealpha,coursenum,grading";
				title = "id,Sequence,Alpha,Number,Grading";
				order = "id";
				table = "tblExtra";
				parm3 = 1;
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "historyid=? AND "
					+ "src=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_PROGRAM_SLO:
				fields = "id,rdr,comments";
				title = "id,rdr,comments";
				order = "id";
				table = "tblGenericContent";
				parm3 = 1;
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? AND "
					+ "src=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_ILO:
				fields = "id,rdr,comments";
				title = "id,rdr,comments";
				order = "id";
				table = "tblGenericContent";
				parm3 = 1;
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? AND "
					+ "src=? "
					+ "ORDER BY rdr";
				break;
			case Constant.COURSE_ITEM_GESLO:
				fields = "id,rdr,comments";
				title = "id,rdr,comments";
				order = "id";
				table = "tblGenericContent";
				parm3 = 1;
				sql = "SELECT " + fields + " "
					+ "FROM " + table + " "
					+ "WHERE campus=? AND "
					+ "coursetype='" + type + "' AND "
					+ "historyid=? AND "
					+ "src=? "
					+ "ORDER BY rdr";
				break;
		}

		try {
			AseUtil au = new AseUtil();
			numberOfEntries = au.countRecords(conn,table,"WHERE historyid='"+kix+"'");
			if (numberOfEntries > 0){

				buf.append("<form name=\"aseForm\" method=\"post\" action=\"/central/servlet/r2\">");
				buf.append("<table border=\"0\" width=\"80%\" id=\"table1\" cellspacing=2 cellpadding=8>");
				buf.append("<tr class=\"textblackTRTheme\"><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>&nbsp;</td>");

				// how many fields are we working with
				columns = fields.split(",");
				header = title.split(",");
				numberOfFields = columns.length;
				data = new String[numberOfFields];

				// create column header
				for(i=1;i<numberOfFields;i++){
					buf.append("<td valign=\"top\" class=\"textblackTH\">" + header[i] + "</td>");
				}

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);

				if (parm3==1)
					ps.setString(3,src);

				rs = ps.executeQuery();
				while (rs.next()) {
					// collect data from result
					for(i=0;i<numberOfFields;i++){
						data[i] = au.nullToBlank(rs.getString(columns[i]));
					}

					// hidden keys for form submission
					if ("".equals(hiddenIds))
						hiddenIds = data[0];
					else
						hiddenIds += "," + data[0];

					// hidden keys with current sequence
					if ("".equals(hiddenRDR))
						hiddenRDR = data[1];
					else
						hiddenRDR += "," + data[1];

					// create count of entries in drop down for selection.
					// clear list and start with each loop.
					sel.setLength(0);
					for(i=1;i<=numberOfEntries;i++){
						if (i==Integer.parseInt(data[1]))
							sel.append("<option selected value=\""+i+"\">"+i+"</option>");
						else
							sel.append("<option value=\""+i+"\">"+i+"</option>");
					}

					// add list box to first column
					temp = "<select name=\"order_"+data[0]+"\" class=\"smalltext\">"
						+ "<option value=\"\"></option>"
						+ sel.toString()
						+ "</select>";

					// create data row
					buf.append("<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>"
						+ temp
						+ "</td>");

					for(i=1;i<numberOfFields;i++){
						buf.append("<td valign=\"top\" class=\"datacolumn\">" + data[i] + "</td>");
					}
				}

				rs.close();
				ps.close();

				buf.append("<tr><td align=\"left\" colspan=\""+numberOfFields+"\">");
				buf.append("<input type=\"hidden\" name=\"kix\" value=\""+kix+"\">");
				buf.append("<input type=\"hidden\" name=\"campus\" value=\""+campus+"\">");
				buf.append("<input type=\"hidden\" name=\"list\" value=\""+list+"\">");
				buf.append("<input type=\"hidden\" name=\"ids\" value=\""+hiddenIds+"\">");
				buf.append("<input type=\"hidden\" name=\"rdrs\" value=\""+hiddenRDR+"\">");

				// SLO
				buf.append("<input type=\"hidden\" name=\"s\" value=\"c\">");

				// Competency
				buf.append("<input type=\"hidden\" name=\"src\" value=\""+src+"\">");
				buf.append("<input type=\"hidden\" name=\"dst\" value=\""+dst+"\">");

				buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Update\" class=\"inputsmallgray\">&nbsp;");
				buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\">");
				buf.append("</tr></table>");
				buf.append("</form>");
			}
		} catch (SQLException se) {
			logger.fatal("Reorder: reorderList\n" + se.toString());
			buf.setLength(0);
		} catch (Exception e) {
			logger.fatal("Reorder: reorderList\n" + e.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	public void close() throws SQLException {}

}