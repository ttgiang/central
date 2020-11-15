/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// ModeDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class ModeDB {

	static Logger logger = Logger.getLogger(ModeDB.class.getName());

	public ModeDB() throws Exception {}

	/**
	 * getProcessStep1
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		String
	 * <p>
	 * @return	String
	 */
	public static String getProcessStep1(Connection conn,String campus,String process,String item,boolean override) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String sql = "";
		String rowColor = "";
		String checked = "";
		String fieldName = "";

		int i = 0;

		try {
			sql = "SELECT Seq,question,Field_Name "
				+ "FROM vw_CourseItems "
				+ "WHERE campus=? "
				+ "AND include='Y' "
				+ "ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				checked = "";

				fieldName = rs.getString("Field_Name");

				if (fieldName.equals(item))
					checked = "checked";

				if (i % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">" + rs.getInt("seq") + ".&nbsp;</td>"
					+ "<td valign=\"top\" height=\"30\" width=\"08%\"><input "+checked+" type=\"radio\" name=\"item\" value=\"" + fieldName + "\"></td>"
					+ "<td valign=top class=\"datacolumn\">" + rs.getString("question") + "</td></tr>";

				buf.append( temp );

				++i;
			}	// while
			rs.close();
			ps.close();

			String sOverride = "";
			if (override)
				sOverride = "YES";
			else
				sOverride = "No";

			temp = "<table width=\"90%\" cellspacing='1' cellpadding='4' border=\"0\">"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Process:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + process + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Allow additions:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + sOverride + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top colspan=\"3\" class=\"datacolumn\">&nbsp;</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top colspan=\"3\" class=\"datacolumn\">&nbsp;"
				+ "NOTE: Select the item where change is permitted during outline " + process + " process"
				+ "</td></tr>"
				+ buf.toString()
				+ "</table>";


		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessStep1 - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessStep1 - " + e.toString());
		}

		return temp;
	}

	/**
	 * getProcessStep2
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		String
	 * @param	id			int
	 * <p>
	 * @return	String
	 */
	public static String getProcessStep2(Connection conn,String campus,String process,String item,int id,boolean override) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String sql = "";
		String rowColor = "";
		String fieldName = "";
		String checked = "";
		String items = "";

		int i = 0;
		int rowsAffected = 0;

		PreparedStatement ps = null;

		try {
			if (id > 0){
				// although the id is valid, there is a chance the item was changed
				boolean exists = doesProcessItemExist(conn,campus,process,item);
				if (exists){
					sql = "UPDATE tblMode SET item=?,override=? WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,item);
					ps.setBoolean(2,override);
					ps.setInt(3,id);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}

				sql = "SELECT item FROM tblMode2 WHERE id=?";
				items = SQLUtil.resultSetToCSV(conn,sql,""+id);
			}

			sql = "SELECT Seq,question,Field_Name "
				+ "FROM vw_CourseItems "
				+ "WHERE campus=? "
				+ "AND include='Y' "
				+ "ORDER BY seq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				checked = "";

				fieldName = rs.getString("Field_Name");

				if (id > 0 && items.indexOf(fieldName) > -1)
					checked = "checked";

				if (i % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				temp = "<tr bgcolor=\"" + rowColor + "\"><td width=\"08%\" valign=top align=\"right\" class=\"textblackth\">" + rs.getInt("seq") + ".&nbsp;</td>"
					+ "<td valign=\"top\" height=\"30\" width=\"08%\"><input "+checked+" type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\"></td>"
					+ "<td valign=top class=\"datacolumn\">" + rs.getString("question") + "</td></tr>";

				buf.append( temp );

				++i;
			}	// while
			rs.close();
			ps.close();

			String sOverride = "";
			if (override)
				sOverride = "YES";
			else
				sOverride = "No";

			String question = QuestionDB.getCourseQuestionByFriendlyName(conn,campus,item,Constant.TAB_COURSE);

			temp = "<table width=\"90%\" cellspacing='1' cellpadding='4' border=\"0\">"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Process:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + process + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Allow additions:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + sOverride + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top align=\"right\" class=\"textblackth\" width=\"08%\">Item:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + question + " (" + item + ")</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top colspan=\"3\" class=\"datacolumn\">&nbsp;</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top colspan=\"3\" class=\"datacolumn\">&nbsp;"
				+ "NOTE: Select the question that are required during outline " + process + " process for the selected item"
				+ "</td></tr>"
				+ buf.toString()
				+ "</table>";


		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessStep2 - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessStep2 - " + e.toString());
		}

		return temp;
	}

	/**
	 * getProcessStep3
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		String
	 * @param	request	HttpServletRequest
	 * @param	id			int
	 * <p>
	 * @return	String
	 */
	public static String getProcessStep3(Connection conn,
														String campus,
														String process,
														String item,
														HttpServletRequest request,
														int id,
														boolean override) throws Exception {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String sql = "";
		String field = "";
		String fieldName = "";
		String rowColor = "";

		int i = 0;
		int rowsAffected = -1;

		PreparedStatement ps = null;

		try {
			// new addition
			if (id == 0 && process != null && item != null){
				sql = "INSERT INTO tblMode(campus,mode,item,override) VALUES (?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,process);
				ps.setString(3,item);
				ps.setBoolean(4,override);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			sql = "SELECT Seq,question,Field_Name "
				+ "FROM vw_CourseItems "
				+ "WHERE campus=? "
				+ "AND include='Y' "
				+ "ORDER BY seq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				fieldName = rs.getString("Field_Name");
				field = website.getRequestParameter(request,fieldName,"");

				if (field != null && field.length() > 0){
					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td width=\"08%\" valign=top align=\"right\" class=\"textblackth\">" + rs.getInt("seq") + ".&nbsp;</td>"
						+ "<td valign=top class=\"datacolumn\"><input type=\"hidden\" value=\""+fieldName+"\" name=\""+fieldName+"\">" + rs.getString("question") + "</td></tr>";

					buf.append( temp );

					++i;
				}

				field = "";
			}	// while
			rs.close();
			ps.close();

			String sOverride = "";
			if (override)
				sOverride = "YES";
			else
				sOverride = "No";

			String question = QuestionDB.getCourseQuestionByFriendlyName(conn,campus,item,Constant.TAB_COURSE);

			temp = "<table width=\"90%\" cellspacing='1' cellpadding='4' border=\"0\">"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Process:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + process + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Allow additions:&nbsp;</td>"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + sOverride + "</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top align=\"right\" class=\"textblackth\" width=\"08%\">Item:&nbsp;</td>"
				+ "<td valign=top class=\"datacolumn\">" + question + " (" + item + ")</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top colspan=\"2\" class=\"datacolumn\">&nbsp;</td></tr>"
				+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
				+ "<td valign=top colspan=\"2\" class=\"datacolumn\">&nbsp;"
				+ "NOTE: Confirm the selected items for the " + process + " process"
				+ "</td></tr>"
				+ buf.toString()
				+ "</table>";


		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessStep3 - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessStep3 - " + e.toString());
		}

		return temp;
	}

	/**
	 * getProcessStep3a
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			String
	 * <p>
	 * @return	String
	 */
	public static String getProcessStep3a(Connection conn,String campus,String id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String sql = "";
		String seq = "";
		String question = "";
		String rowColor = "";

		int i = 0;
		int rowsAffected = -1;
		try {

			String additionalItems = additionalSeqAsCSV(conn,campus,id);

			if (additionalItems != null && additionalItems.length() > 0){
				sql = "SELECT Seq,question "
					+ "FROM vw_CourseItems "
					+ "WHERE campus=? "
					+ "AND include='Y' "
					+ "AND seq IN ("+additionalItems+") "
					+ "ORDER BY seq";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){

					seq = rs.getString("Seq");
					question = rs.getString("question");

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td width=\"08%\" valign=top align=\"right\" class=\"textblackth\">" + seq + ".&nbsp;</td>"
						+ "<td valign=top class=\"datacolumn\">" + question + "</td></tr>";

					buf.append( temp );

					++i;
				}	// while
				rs.close();
				ps.close();

				temp = "<table width=\"90%\" cellspacing='1' cellpadding='4' border=\"0\">"
					+ "<tr>"
					+ "<td colspan=\"2\" valign=top align=\"right\" class=\"textblackth\" width=\"100%\">Required Items<br><br></td></tr>"
					+ buf.toString()
					+ "</table>";
			}

		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessStep3a - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessStep3a - " + e.toString());
		}

		return temp;
	}

	/**
	 * getProcessStep4
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		String
	 * @param	request	HttpServletRequest
	 * <p>
	 * @return	String
	 */
	public static String getProcessStep4(Connection conn,
														String campus,
														String process,
														String item,
														HttpServletRequest request,
														boolean override) throws Exception {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();

		StringBuffer buf = new StringBuffer();
		String temp = "";
		String sql = "";
		String field = "";
		String fieldName = "";
		String rowColor = "";

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		int i = 0;
		int id = 0;
		int rowsAffected = -1;

		try {
			// does this item already exist?
			sql = "SELECT id FROM tblMode WHERE campus=? AND mode LIKE '"+process+"%' AND item LIKE '"+item+"%'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("id");
				if (id==0){
					// add initial row when not already there.
					sql = "INSERT INTO tblMode(campus,mode,item,override) VALUES (?,?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,process);
					ps.setString(3,item);
					ps.setBoolean(4,override);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// get id to use for below
					sql = "SELECT MAX(id) AS maxid FROM tblMode";
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					if (rs.next())
						id = rs.getInt("maxid");

					if (id==0)
						id = 1;

					rs.close();
					ps.close();
				}
			}
			rs.close();
			ps.close();

			// if the id was found and can be worked with, add required items here
			if (id > 0){

				// start by deleting existing required items before adding replacements
				rowsAffected = deleteSelectedItems(conn,id);

				// add the questions
				sql = "SELECT Seq,question,Field_Name "
					+ "FROM vw_CourseItems "
					+ "WHERE campus=? "
					+ "AND include='Y' "
					+ "ORDER BY seq";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				rs = ps.executeQuery();
				while (rs.next()){

					fieldName = rs.getString("Field_Name");
					field = website.getRequestParameter(request,fieldName,"");

					if (field != null && field.length() > 0){
						sql = "INSERT INTO tblMode2(id,item,questionnumber) VALUES (?,?,?)";
						ps2 = conn.prepareStatement(sql);
						ps2.setInt(1,id);
						ps2.setString(2,fieldName);
						ps2.setInt(3,QuestionDB.getQuestionNumberByColumn(conn,campus,fieldName));
						rowsAffected = ps2.executeUpdate();
						ps2.close();

						if (i % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						temp = "<tr bgcolor=\"" + rowColor + "\"><td width=\"08%\" valign=top align=\"right\" class=\"textblackth\">" + rs.getInt("seq") + ".&nbsp;</td>"
							+ "<td valign=top class=\"datacolumn\"><input type=\"hidden\" value=\""+fieldName+"\" name=\""+fieldName+"\">" + rs.getString("question") + "</td></tr>";

						buf.append( temp );

						++i;
					}

					field = "";
				}	// while
				rs.close();
				ps.close();


				String sOverride = "";
				if (override)
					sOverride = "YES";
				else
					sOverride = "No";

				String question = QuestionDB.getCourseQuestionByFriendlyName(conn,campus,item,Constant.TAB_COURSE);

				temp = "<table width=\"90%\" cellspacing='1' cellpadding='4' border=\"0\">"
					+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
					+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Process:&nbsp;</td>"
					+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + process + "</td></tr>"
					+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
					+ "<td valign=top align=\"right\" class=\"textblackth\" width=\"15%\">Allow additions:&nbsp;</td>"
					+ "<td valign=top colspan=\"2\" class=\"datacolumn\">" + sOverride + "</td></tr>"
					+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top align=\"right\" class=\"textblackth\" width=\"08%\">Item:&nbsp;</td>"
					+ "<td valign=top class=\"datacolumn\">" + question + " (" + item + ")</td></tr>"
					+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\"><td valign=top colspan=\"2\" class=\"datacolumn\">&nbsp;</td></tr>"
					+ "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
					+ "<td valign=top colspan=\"2\" class=\"datacolumn\">&nbsp;"
					+ "NOTE: The following questions are required during outline " + process + " process"
					+ "</td></tr>"
					+ buf.toString()
					+ "</table>";
			}
			else
				temp = "";

		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessStep4 - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessStep4 - " + e.toString());
		}

		return temp;
	}

	/**
	 * deleteSelectedItems
	 * <p>
	 * @param	conn		Connection
	 * @param	id			int
	 * <p>
	 * @return	int
	 */
	public static int deleteSelectedItems(Connection conn,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {
			String sql = "DELETE FROM tblMode2 WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ModeDB: deleteSelectedItems - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: deleteSelectedItems - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * getProcessByID
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			int
	 * <p>
	 * @return	Mode
	 */
	public static Mode getProcessByID(Connection conn,String campus,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		Mode mode = null;

		try {
			String sql = "SELECT * FROM tblMode WHERE campus=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				mode = new Mode();
				mode.setMode(rs.getString("mode"));
				mode.setCampus(rs.getString("campus"));
				mode.setItem(rs.getString("item"));
				mode.setOverride(rs.getBoolean("override"));
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ModeDB: getProcessByID - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getProcessByID - " + e.toString());
		}

		return mode;
	}

	/**
	 * getItemByID
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	id			int
	 * <p>
	 * @return	String
	 */
	public static String getItemByID(Connection conn,String campus,int id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String item = "";

		try {
			String sql = "SELECT item FROM tblMode WHERE campus=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				item = rs.getString("item");
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ModeDB: getItemByID - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getItemByID - " + e.toString());
		}

		return item;
	}

	/**
	 * doesProcessItemExist
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		int
	 * <p>
	 * @return	boolean
	 */
	public static boolean doesProcessItemExist(Connection conn,String campus,String process,String item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean exist = false;

		try {
			String sql = "SELECT id FROM tblMode WHERE campus=? AND mode=? AND item=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,process);
			ps.setString(3,item);
			ResultSet rs = ps.executeQuery();
			exist = rs.next();
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ModeDB: doesProcessItemExist - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: doesProcessItemExist - " + e.toString());
		}

		return exist;
	}


	/**
	 * listModes
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	String
	 */
	public static String listModes(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";

		String id = "";
		String mode = "";
		String seq = "";
		String additions = "";
		String question = "";

		String link = "";
		String linkItems = "";
		String rowColor = "";

		boolean found = false;
		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();
 			String sql = "SELECT id,mode,questionseq,CASE override WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE 'No' END AS [additions], question "
				+ " FROM vw_mode  "
				+ "WHERE campus=? "
				+ "ORDER BY mode,item";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				id = aseUtil.nullToBlank(rs.getString("id"));
				mode = aseUtil.nullToBlank(rs.getString("mode"));
				seq = aseUtil.nullToBlank(rs.getString("questionseq"));
				additions = aseUtil.nullToBlank(rs.getString("additions"));
				question = aseUtil.nullToBlank(rs.getString("question"));

				if (j++ % 2 == 0)
					rowColor = "#ffffff";
				else
					rowColor = "#e5f1f4";

				link = "crsmodew.jsp?lid=" + id;
				linkItems = "crsmodep.jsp?lid=" + id;

				listings.append("<tr class=\""+campus+"BGColorRow\" height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" class=\"linkcolumn\">" + mode + "</a></td>");
				listings.append("<td class=\"datacolumn\">" + seq + "</td>");
				listings.append("<td class=\"datacolumn\">" + additions + "</td>");
				listings.append("<td class=\"datacolumn\"><a href=\""
										+ linkItems
										+ "\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseListModes','800','600','no','center');return false\" onfocus=\"this.blur()\">"
										+ question + "</a></td>");
				sql = "SELECT seq FROM tblMode2 WHERE id=? ORDER BY seq";
				listings.append("<td class=\"datacolumn\">" + additionalSeqAsCSV(conn,campus,id) + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table class=\""+campus+"BGColor\" width=\"98%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">" +
					"<tr class=\""+campus+"BGColor\">" +
					"<td width=\"10%\">Process</td>" +
					"<td width=\"10%\">Sequence</td>" +
					"<td width=\"10%\">Allow Additions</td>" +
					"<td width=\"20%\">Outline Item</td>" +
					"<td width=\"50%\">Required Items</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
			else{
				listing = "data not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("ModeDB: listModes - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("ModeDB: listModes - " + ex.toString());
		}

		return listing;
	}

	/*
	 * additionalSeqAsCSV
	 *	<p>
	 * @param	conn
	 * @param	campus
	 * @param	id
	 *	<p>
	 * @return String
	 */
	public static String additionalSeqAsCSV(Connection conn,String campus,String id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";

		try {
			String sql = "SELECT v.questionseq "
							+ "FROM tblMode2 m INNER JOIN vw_CourseQuestionsYN v ON m.item = v.Question_Friendly "
							+ "WHERE v.campus=? "
							+ "AND m.id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,Integer.parseInt(id));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if ("".equals(csv))
					csv = AseUtil.nullToBlank(rs.getString(1));
				else
					csv = csv + ", " + AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("ModeDB: additionalSeqAsCSV - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: additionalSeqAsCSV - " + e.toString());
		}

		return csv;
	}

	/*
	 * additionalQuestionAsCSV
	 *	<p>
	 * @param	conn
	 * @param	campus
	 * @param	id
	 *	<p>
	 * @return String
	 */
	public static String additionalQuestionAsCSV(Connection conn,String campus,String id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";

		try {
			String sql = "SELECT item "
							+ "FROM tblMode2 "
							+ "WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,Integer.parseInt(id));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if ("".equals(csv))
					csv = AseUtil.nullToBlank(rs.getString(1));
				else
					csv = csv + ", " + AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("ModeDB: additionalQuestionAsCSV - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: additionalQuestionAsCSV - " + e.toString());
		}

		return csv;
	}

	/*
	 * additionalQuestionNumberAsCSV
	 *	<p>
	 * @param	conn
	 * @param	campus
	 * @param	id
	 *	<p>
	 * @return String
	 */
	public static String additionalQuestionNumberAsCSV(Connection conn,String campus,String id) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";

		try {
			String sql = "SELECT questionnumber "
							+ "FROM tblMode2 "
							+ "WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,Integer.parseInt(id));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if ("".equals(csv))
					csv = AseUtil.nullToBlank(rs.getString(1));
				else
					csv = csv + ", " + AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("ModeDB: additionalQuestionNumberAsCSV - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: additionalQuestionNumberAsCSV - " + e.toString());
		}

		return csv;
	}

	/**
	 * getIDByProcessAndItem
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	process	String
	 * @param	item		String
	 * <p>
	 * @return	int
	 */
	public static int getIDByProcessAndItem(Connection conn,String campus,String process,String item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int id = 0;

		try {
			String sql = "SELECT id FROM tblMode WHERE campus=? AND mode=? AND item=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,process);
			ps.setString(3,item);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				id = rs.getInt("id");
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ModeDB: getIDByProcessAndItem - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ModeDB: getIDByProcessAndItem - " + e.toString());
		}

		return id;
	}

	public void close() throws SQLException {}

}