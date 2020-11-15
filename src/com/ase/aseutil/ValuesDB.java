/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 *	public static String getListByCampusSrcSubTopic(Connection conn,String campus,String src,String subtopic) throws SQLException {
 *	public static String getSQL(String sqlType) throws SQLException {
 *
 */

//
// ValuesDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import java.util.LinkedList;
import java.util.List;

public class ValuesDB {

	static Logger logger = Logger.getLogger(ValuesDB.class.getName());

	public ValuesDB() throws Exception {}

	/*
	 * getSQL
	 *	<p>
	 *	@param	sqlType
	 *	<p>
	 *	@return String
	 */
	public static String getSQL(String sqlType) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		// this is SRC/DIV/SUBTOPIC
		if (sqlType.equals("listBySrcDivSubTopic")){
			sql = "SELECT shortdescr "
				+ "FROM tblValues  "
				+ "WHERE campus=? "
				+ "AND src=? "
				+ "AND subtopic IN "
				+ "( "
				+ "SELECT tblDivision.divisioncode "
				+ "FROM tblChairs INNER JOIN "
				+ "tblDivision ON tblChairs.programid = tblDivision.divid "
				+ "WHERE tblChairs.coursealpha=? "
				+ "AND tblDivision.campus=? "
				+ ") "
				+ "ORDER BY seq";
		}
		else if (sqlType.equals("listByCampusTopicSubTopic")){
			sql = "SELECT shortdescr "
				+ "FROM tblValues "
				+ "WHERE campus=? "
				+ "AND topic=? "
				+ "AND subtopic=? "
				+ "ORDER BY shortdescr";
		}
		else if (sqlType.equals("listByCampusSrcSubTopic")){
			sql = "SELECT shortdescr "
				+ "FROM tblValues "
				+ "WHERE campus=? "
				+ "AND (src=? OR src=?) "
				+ "AND subtopic=? "
				+ "ORDER BY seq";
		}

		return sql;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn		Connection
	 * @param	topic		String
	 * @param	subTopic String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String topic,String subTopic) throws SQLException {
		String sql = "SELECT id FROM tblValues "
				+ "WHERE campus = '" + SQLUtil.encode(campus)
				+ "' AND " + "topic = '" + SQLUtil.encode(topic)
				+ "' AND " + "subTopic = '" + SQLUtil.encode(subTopic) + "'";

		Statement statement = conn.createStatement();
		ResultSet results = statement.executeQuery(sql);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/*
	 * isMatch
	 *	<p>
	 *	@param	conn		Connection
	 * @param	topic		String
	 * @param	subTopic String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String topic,String subTopic,String shortDescr) throws SQLException {
		String sql = "SELECT id FROM tblValues "
				+ "WHERE campus = '" + SQLUtil.encode(campus)
				+ "' AND " + "topic = '" + SQLUtil.encode(topic)
				+ "' AND " + "subTopic = '" + SQLUtil.encode(subTopic)
				+ "' AND " + "shortdescr = '" + SQLUtil.encode(shortDescr)
				+ "'";

		Statement statement = conn.createStatement();
		ResultSet results = statement.executeQuery(sql);
		boolean exists = results.next();
		results.close();
		statement.close();
		return exists;
	}

	/*
	 * getValuesData
	 *	<p>
	 *	@param	connection
	 * @param	kix
	 * @param	id
	 *	<p>
	 *	@return ValuesData
	 */
	public static ValuesData getValuesData(Connection connection,String kix,int id) {
		ValuesData valuesData = null;

		try {
			String sql = "SELECT * FROM tblValuesData WHERE historyid=? AND id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				valuesData = new ValuesData();
				valuesData.setId(rs.getInt("id"));
				valuesData.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				valuesData.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
				valuesData.setCourseAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				valuesData.setCourseNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				valuesData.setCourseType(AseUtil.nullToBlank(rs.getString("coursetype")));
				valuesData.setX(AseUtil.nullToBlank(rs.getString("X")));
				valuesData.setXID(rs.getInt("XID"));
				valuesData.setY(AseUtil.nullToBlank(rs.getString("Y")));
				valuesData.setYID(rs.getInt("YID"));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ValuesDB: getValuesData - " + e.toString());
		}

		return valuesData;
	}

	/*
	 * getValues
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				int
	 *	<p>
	 *	@return Values
	 */
	public static Values getValues(Connection connection, int id) {
		Values values = null;

		try {
			String sql = "SELECT id,topic,subtopic,shortdescr,longdescr,auditby,auditdate,seq FROM tblValues WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				values = new Values();
				values.setId(rs.getInt("id"));
				values.setTopic(AseUtil.nullToBlank(rs.getString("topic")));
				values.setSubTopic(AseUtil.nullToBlank(rs.getString("subtopic")));
				values.setShortDescr(AseUtil.nullToBlank(rs.getString("shortdescr")));
				values.setLongDescr(AseUtil.nullToBlank(rs.getString("longdescr")));
				values.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
				values.setSeq(rs.getInt("seq"));
				AseUtil aseUtil = new AseUtil();
				values.setAuditDate(aseUtil.ASE_FormatDateTime(AseUtil.nullToBlank(rs.getString("auditdate")),Constant.DATE_DATETIME));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ValuesDB: getValues - " + e.toString());
			values = null;
		}

		return values;
	}

	/*
	 * insertValues
	 *	<p>
	 *	@param	connection	Connection
	 * @param	values		Values
	 *	<p>
	 *	@return int
	 */
	public static int insertValues(Connection connection,Values values) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			if (!isMatch(connection,values.getCampus(),values.getTopic(),values.getSubTopic(),values.getShortDescr())){
				String sql = "INSERT INTO tblValues(topic,subtopic,shortdescr,longdescr,auditby,auditdate,campus,src,seq) VALUES (?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setString(1, values.getTopic());
				ps.setString(2, values.getSubTopic());
				ps.setString(3, values.getShortDescr());
				ps.setString(4, values.getLongDescr());
				ps.setString(5, values.getAuditBy());
				ps.setString(6, AseUtil.getCurrentDateTimeString());
				ps.setString(7, values.getCampus());
				ps.setString(8, values.getSrc());
				ps.setInt(9, ValuesDB.getNextSequenceNumber(connection,values.getCampus(),values.getTopic(),values.getSubTopic()));
				rowsAffected = ps.executeUpdate();
				ps.close();
			} // is match
		} catch (SQLException e) {
			logger.fatal("ValuesDB.insertValues - " + e.toString() + "\n" + values);
		} catch (Exception e) {
			logger.fatal("ValuesDB.insertValues - " + e.toString() + "\n" + values);
		}

		return rowsAffected;
	}

	/*
	 * getNextSequenceNumber
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	topic
	 *	@param	subtopic
	 *	<p>
	 *	@return int
	 */
	public static int getNextSequenceNumber(Connection conn,String campus,String topic,String subtopic) throws SQLException {

		int id = 0;

		try {
			String sql = "SELECT MAX(seq) + 1 AS maxid FROM tblValues WHERE campus=? AND topic=? AND subtopic=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,topic);
			ps.setString(3,subtopic);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ValuesDB: getNextSequenceNumber\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getNextSequenceNumber\n" + e.toString());
		}

		return id;
	}

	/*
	 * deleteValues
	 *	<p>
	 *	@param	connection	Connection
	 * @param	id				String
	 *	<p>
	 *	@return int
	 */
	public static int deleteValues(Connection connection, int id) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblValues WHERE id = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1,id);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("ValuesDB - deleteValues: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * deleteValues
	 *	<p>
	 *	@param	conn		Connection
	 * @param	values	Values
	 *	<p>
	 *	@return int
	 */
	public static int deleteValues(Connection conn, Values values) {
		int rowsAffected = 0;
		try {
			String sql = "DELETE FROM tblValues WHERE campus=? AND topic=? AND subtopic=? AND shortdescr=?";
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1,values.getCampus());
			preparedStatement.setString(2,values.getTopic());
			preparedStatement.setString(3,values.getSubTopic());
			preparedStatement.setString(4,values.getShortDescr());
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			logger.fatal("ValuesDB - updadeleteValueseValues: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * updateValues
	 *	<p>
	 *	@param	connection	Connection
	 * @param	values		Values
	 *	<p>
	 *	@return int
	 */
	public static int updateValues(Connection connection, Values values) {
		int rowsAffected = 0;
		try {
			String sql = "UPDATE tblValues " +
				"SET topic=?,subtopic=?,shortdescr=?,longdescr=?,auditby=?,auditdate=?,seq=? " +
				"WHERE id =? " +
				"AND campus=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, values.getTopic());
			ps.setString(2, values.getSubTopic());
			ps.setString(3, values.getShortDescr());
			ps.setString(4, values.getLongDescr());
			ps.setString(5, values.getAuditBy());
			ps.setString(6, AseUtil.getCurrentDateTimeString());
			ps.setInt(7, values.getSeq());
			ps.setInt(8, values.getId());
			ps.setString(9, values.getCampus());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ValuesDB - updateValues: " + e.toString());
		}
		return rowsAffected;
	}

	/*
	 * getYID
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	X			String
	 * @param	Y			String
	 * @param	XID		String
	 *	<p>
	 *	@return yid
	 */
	public static int getYID(Connection conn,String campus,String kix,String X,String Y,int XID) {

		//Logger logger = Logger.getLogger("test");

		int yid = 0;

		try {
			String sql = "SELECT YID "
				+ "FROM tblValuesData "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND x=? "
				+ "AND y=? "
				+ "AND xid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,X);
			ps.setString(4,Y);
			ps.setInt(5,XID);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				yid = rs.getInt("yid");
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ValuesDB: getYID - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getYID - " + e.toString());
		}

		return yid;
	}

	/*
	 * getYIDs
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	X			String
	 * @param	Y			String
	 * @param	XID		String
	 *	<p>
	 *	@return String
	 */
	public static String getYIDs(Connection conn,String campus,String kix,String X,String Y,int XID) {

		//Logger logger = Logger.getLogger("test");

		String yids = "";

		try {
			String sql = "SELECT YID "
				+ "FROM tblValuesData "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND x=? "
				+ "AND y=? "
				+ "AND xid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,X);
			ps.setString(4,Y);
			ps.setInt(5,XID);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if ("".equals(yids))
					yids = "" + rs.getInt("yid");
				else
					yids = yids + "," + rs.getInt("yid");
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("ValuesDB: getYIDs - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getYIDs - " + e.toString());
		}

		return yids;
	}

	/*
	 * setYID
	 *	<p>
	 *	@param	conn
	 * @param	campus
	 * @param	kix
	 * @param	X
	 * @param	Y
	 * @param	XID
	 * @param	YID
	 *	<p>
	 *	@return int
	 */
	public static int setYID(Connection conn,String campus,String kix,String X,String Y,int XID,int YID) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "";
			PreparedStatement ps = null;

			// when null or empty, delete
			// if can't update, then must be insert

			if (YID == 0){
				sql = "DELETE FROM tblValuesData "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND x=? "
					+ "AND y=? "
					+ "AND xid=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,X);
				ps.setString(4,Y);
				ps.setInt(5,XID);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else{
				sql = "UPDATE tblValuesData "
					+ "SET YID=? "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND x=? "
					+ "AND y=? "
					+ "AND xid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,YID);
				ps.setString(2,campus);
				ps.setString(3,kix);
				ps.setString(4,X);
				ps.setString(5,Y);
				ps.setInt(6,XID);
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (rowsAffected < 1 && YID != 0){
					String[] info = Helper.getKixInfo(conn,kix);
					String alpha = info[Constant.KIX_ALPHA];
					String num = info[Constant.KIX_NUM];
					String type = info[Constant.KIX_TYPE];

					sql = "INSERT INTO tblValuesData(campus,historyid,coursealpha,coursenum,coursetype,X,XID,Y,YID) "
						+ "VALUES(?,?,?,?,?,?,?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,alpha);
					ps.setString(4,num);
					ps.setString(5,type);
					ps.setString(6,X);
					ps.setInt(7,XID);
					ps.setString(8,Y);
					ps.setInt(9,YID);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}

		} catch (SQLException se) {
			logger.fatal("ValuesDB: getYID - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getYID - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * setYIDs
	 *	<p>
	 *	@param	conn
	 * @param	campus
	 * @param	kix
	 * @param	X
	 * @param	Y
	 * @param	XID
	 * @param	YID
	 *	<p>
	 *	@return int
	 */
	public static int setYIDs(Connection conn,String campus,String kix,String X,String Y,int XID,String YID) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String sql = "";
			PreparedStatement ps = null;

			// when null or empty, delete
			// if can't update, then must be insert

			sql = "DELETE FROM tblValuesData "
				+ "WHERE campus=? "
				+ "AND historyid=? "
				+ "AND x=? "
				+ "AND y=? "
				+ "AND xid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ps.setString(3,X);
			ps.setString(4,Y);
			ps.setInt(5,XID);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (YID != null && YID.length() > 0){
				String[] info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];

				String[] aYID = YID.split(",");
				for (int i=0; i<aYID.length; i++){
					sql = "INSERT INTO tblValuesData(campus,historyid,coursealpha,coursenum,coursetype,X,XID,Y,YID) "
						+ "VALUES(?,?,?,?,?,?,?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
					ps.setString(3,alpha);
					ps.setString(4,num);
					ps.setString(5,type);
					ps.setString(6,X);
					ps.setInt(7,XID);
					ps.setString(8,Y);
					ps.setInt(9,Integer.parseInt(aYID[i]));
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			}
		} catch (SQLException se) {
			logger.fatal("ValuesDB: setYIDs - " + se.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: setYIDs - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * diversificationMatrix
	 * <p>
	 * @param conn			Connection
	 * @param kix			String
	 * @param topic		String
	 * @param subTopic	String
	 * @param dst			String
	 * @param compressed boolean
	 * @param print		boolean
	 * <p>
	 * @return String
	 */
	public static String diversificationMatrix(Connection conn,
																String kix,
																String topic,
																String subTopic,
																String src,
																String dst,
																boolean compressed,
																boolean print) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;
		int rowsAffected = 0;

		boolean found = false;
		boolean isConnected = false;

		String sql = "";
		String temp = "";
		String img = "";
		String longcontent = "";
		StringBuffer buffer = new StringBuffer();
		StringBuffer connected = new StringBuffer();
		String rowColor = "";
		String checked = "";

		String proposer = "";

		String columnTitle = "";
		String tempSticky = "";
		String stickyRow = null;
		StringBuilder stickyBuffer = new StringBuilder();
		String[] aALPHABETS = (Constant.ALPHABETS).split(",");

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String campus = info[Constant.KIX_CAMPUS];
			proposer = info[Constant.KIX_PROPOSER];

			// colect data for rows (going down the left most column)
			String[] xAxis = SQLValues.getTValues(conn,campus,topic,"descr");
			String[] xiAxis = SQLValues.getTValues(conn,campus,topic,"key");

			// colect data for columns
			String[] yAxis = null;
			String[] yiAxis = null;
			if ((Constant.COURSE_COMPETENCIES).equals(dst)){
				columnTitle = "Competency";
				yAxis = SQLValues.getTCompetency(conn,campus,kix,"descr");
				yiAxis = SQLValues.getTCompetency(conn,campus,kix,"key");
			}
			else if ((Constant.COURSE_OBJECTIVES).equals(dst)){
				columnTitle = "Course SLO";
				yAxis = SQLValues.getTComp(conn,campus,kix,"descr");
				yiAxis = SQLValues.getTComp(conn,campus,kix,"key");
			}

			String server = SysDB.getSys(conn,"server");

			// used for popup help
			stickyRow = "<div id=\"sticky"+dst+"<| STICKY |>\" class=\"atip\" style=\"width:200px\"><b><u>"+columnTitle+"</u></b><br/><| DESCR |></div>";

			// if we have adequate data, display
			if (xAxis!=null && yAxis!=null && yiAxis != null){

				buffer.append(Constant.TABLE_START);

				// print header row & column
				buffer.append(Constant.TABLE_ROW_START_HIGHLIGHT);
				buffer.append(Constant.TABLE_CELL_HEADER_COLUMN);
				buffer.append("&nbsp;"+topic+"&nbsp;/&nbsp;"+columnTitle);
				buffer.append(Constant.TABLE_CELL_END);
				for(i=0;i<yAxis.length;i++){

					found = true;

					if (compressed){
						if (i % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						buffer.append("<td class=\"dataColumnCenter\" valign=\"top\" width=\"03%\" bgcolor=\""+rowColor+"\" data-tooltip=\"sticky"+dst+""+i+"\"><font class=\"linkcolumn\">" + aALPHABETS[i] + "</font>" + Constant.TABLE_CELL_END);

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+i);
						stickyBuffer.append(tempSticky);
					}
					else
						buffer.append("<td class=\"datacolumn\" valign=\"top\" width=\"03%\">" + yAxis[i] + Constant.TABLE_CELL_END);
				}
				buffer.append(Constant.TABLE_ROW_END);

				// print detail row
				for(i=0;i<xAxis.length;i++){
					connected.setLength(0);
					isConnected = false;

					// select data that connects the X and Y grid of the table
					// add the comma at the end and beginning so that we know our compare
					// via indexOf will find the exact match only.
					String yGrid = ","
										+ getYIDs(conn,campus,kix,src,dst,Integer.parseInt(xiAxis[i]))
										+",";

					for(j=0;j<yAxis.length;j++){

						checked = "";
						if (yGrid.indexOf(","+yiAxis[j]+",")>-1)
							checked = "checked";

						if (!print)
							img = "<input type=\"checkbox\" "+checked+" name=\""+dst+"-"+yiAxis[j]+"-"+xiAxis[i]+"\" value=\""+yiAxis[j]+"\">";
						else
							if ("".equals(checked))
								img = "&nbsp;";
							else
								img = "<p align=\"center\"><img src=\"http://"+server+"/central/images/images/checkmarkG.gif\" alt=\"selected\" border=\"0\" data-tooltip=\"sticky"+dst+""+j+"_"+i+"\" /></p>";

						if (j % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						connected.append("<td valign=\"top\" align=\"center\" height=\"40\" bgcolor=\""+rowColor+"\">"
							+ img
							+ Constant.TABLE_CELL_END);

						tempSticky = stickyRow;
						tempSticky = tempSticky.replace("<| DESCR |>",yAxis[j] + "<br/><br/><b><u>"+topic+"</u></b><br/><br/>" + xAxis[i]);
						tempSticky = tempSticky.replace("<| STICKY |>",""+j+"_"+i);
						stickyBuffer.append(tempSticky);
					}

					buffer.append(Constant.TABLE_ROW_START);
					buffer.append(
								Constant.TABLE_CELL_DATA_COLUMN
							+ 	xAxis[i]
							+ 	Constant.TABLE_CELL_END);

					buffer.append(connected.toString());

					buffer.append(Constant.TABLE_ROW_END);
				}

				buffer.append(Constant.TABLE_END);

				if (compressed)
					buffer.append("<p align=\"left\" class=\"normaltext\">" + Outlines.showLegend(yAxis) + "</p>");

			}

		} catch (SQLException ex) {
			logger.fatal("Outlines: diversificationMatrix - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: diversificationMatrix - " + e.toString());
		}

		if (found){
			temp = buffer.toString();
			temp = temp.replace("border=\"0\"","border=\"1\"");
			MiscDB.insertSitckyNotes(conn,kix,proposer,stickyBuffer.toString());
		}

		return temp;
	}

	/*
	 * hasDiversification
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	X			String
	 *	<p>
	 *	@return boolean
	 */
	public static boolean hasDiversification(Connection conn,String campus,String kix,String X) throws SQLException {

		long countRecords = AseUtil.countRecords(conn,"tblValuesData",
										"WHERE campus='" + campus + "' "
									+ " AND historyid='"+ kix + "'"
									+ " AND X='"+ X + "'"
									);

		if (countRecords > 0)
			return true;
		else
			return false;
	}

	/*
	 * updateDiversification
	 *	<p>
	 *	@param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 *	@return int
	 */
	public static int updateDiversification(Connection conn,
														HttpServletRequest request,
														HttpServletResponse response,
														String campus,
														String kix) throws SQLException {


		String temp = "";
		String YID = "";
		String sql = "";

		int h = 0;		// dst values
		int i = 0;		// x
		int j = 0;		// y

		int rowsAffected = 0;

		try {

			HttpSession session = request.getSession(true);
			WebSite website = new WebSite();

			String topic = website.getRequestParameter(request,"topic", "");
			String dst = website.getRequestParameter(request,"dst", "");
			String src = (String)session.getAttribute("aseQuestionFriendly");

			// colect data for rows (going down the left most column)
			String[] xAxis		= SQLValues.getTValues(conn,campus,topic,"descr");
			String[] xiAxis	= SQLValues.getTValues(conn,campus,topic,"key");

			// colect data for cols (going across the top)
			String[] yAxis		= SQLValues.getTCompetency(conn,campus,kix,"descr");
			String[] yiAxis	= SQLValues.getTCompetency(conn,campus,kix,"key");

			String[] aDST = dst.split(",");

			// 3 FOR loops. The outer most controls the dst that we are working with.
			// in this case, we have competencies (X43) and course SLOs (X18) - h is counter
			// the next loop is i or the x-axis with is the diversification item
			// the inner most is j or the y-axis where the dst is applied
			// at the end of each h loop, there is a need to update the y-axis since
			// the dst is based on each y-axis

			for(h=0;h<aDST.length;h++){
				if (xAxis!=null && yAxis!=null){
					for(i=0;i<xAxis.length;i++){
						YID = "";
						for(j=0;j<yAxis.length;j++){
							temp = website.getRequestParameter(request,aDST[h]+"-"+yiAxis[j]+"-"+xiAxis[i],"");
							if (temp != null && temp.length() > 0){
								if (YID == null || YID.length()==0)
									YID = temp;
								else
									YID = YID + "," +temp;
							}
						} // j
						rowsAffected = setYIDs(conn,campus,kix,src,aDST[h],Integer.parseInt(xiAxis[i]),YID);
					} // i
				}
				yAxis		= SQLValues.getTComp(conn,campus,kix,"descr");
				yiAxis	= SQLValues.getTComp(conn,campus,kix,"key");
			}	// h

		} catch (SQLException ex) {
			logger.fatal("ValuesDB: updateDiversification - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: updateDiversification - " + e.toString());
		}

		return rowsAffected;

	}

	/**
	 * copyValues
	 * <p>
	 * @param	conn
	 * @param	kixOld
	 * @param	kixNew
	 * @param	alpha
	 * @param	num
	 * @param	user
	 * @param	thisID
	 * <p>
	 * @return	int
	 */
	public static int copyValues(Connection conn,
											String kixOld,
											String kixNew,
											String alpha,
											String num,
											String user,
											int thisID) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int nextID = 0;

		boolean debug = false;

		String src = Constant.COURSE_CONTENT;

		try {
			// a copy places the new copy (kixNew) in the system as PRE
			String[] info = Helper.getKixInfo(conn,kixNew);
			String type = info[Constant.KIX_TYPE];

			debug = DebugDB.getDebug(conn,"ValuesDB");

			if (debug) logger.info("CONTENTDB COPYVALUES - STARTS");

			String sql = "INSERT INTO tblValuesData(campus,historyid,coursealpha,coursenum,coursetype,X,XID,Y,YID) VALUES (?,?,?,?,?,?,?,?,?)";

			ValuesData valuesData = ValuesDB.getValuesData(conn,kixOld,thisID);

			String[] info2 = Helper.getKixInfo(conn,kixNew);
			String toCampus = info2[Constant.KIX_CAMPUS];

			if (valuesData != null){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, toCampus);
				ps.setString(2, kixNew);
				ps.setString(3, alpha);
				ps.setString(4, num);
				ps.setString(5, type);
				ps.setString(6, valuesData.getX());
				ps.setInt(7, valuesData.getXID());
				ps.setString(8, valuesData.getY());
				ps.setInt(9, valuesData.getYID());
				rowsAffected = ps.executeUpdate();
				ps.close();

				if (debug) logger.info(kixNew + " - valuesData copied");
			}

			if (debug) logger.info("CONTENTDB COPYVALUES - ENDS");

		} catch (SQLException e) {
			logger.fatal("ValuesDB: copyValues - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("ValuesDB: copyValues - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * addSrcToOutline - add PSLOs to a newly created outline or other creation
	 * <p>
	 * @param	conn			Connection
	 * @param	src			String
	 * @param	historyid	String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	type			String
	 * @param	user			String
	 * <p>
	 * @return	int
	 */
	public static int addSrcToOutline(Connection conn,
												String src,
												String kix,
												String campus,
												String alpha,
												String num,
												String type,
												String user){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String comment = "";
		String topic = "";
		int rowsAffected = 0;

		try{
			boolean debug = DebugDB.getDebug(conn,"ValuesDB");

			PreparedStatement ps = null;
			ResultSet rs = null;

			String sql = ValuesDB.getSQL("listByCampusSrcSubTopic");

			if (src.equals(Constant.IMPORT_GESLO)){
				if (sql != null && sql.length() > 0){
					//
					logger.info("Imported " + rowsAffected + " " + Constant.IMPORT_GESLO);
				} // sql != null
			}
			else if (src.equals(Constant.IMPORT_ILO)){
				if (sql != null && sql.length() > 0){
					topic = Constant.GetLinkedDestinationFullName(Constant.COURSE_INSTITUTION_LO);
					GenericContent gc = null;
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,topic);
					ps.setString(3,topic);
					ps.setString(4,alpha);
					rs = ps.executeQuery();
					while ( rs.next() ){
						comment = AseUtil.nullToBlank(rs.getString(1));
						gc = new GenericContent(0,kix,campus,alpha,num,type,Constant.COURSE_INSTITUTION_LO,comment,"",user,0);
						rowsAffected += GenericContentDB.insertContent(conn,gc);
					}
					rs.close();
					ps.close();

					logger.info("Imported " + rowsAffected + " " + topic);
				} // sql != null
			}
			else if (src.equals(Constant.IMPORT_PLO)){
				if (sql != null && sql.length() > 0){
					topic = Constant.GetLinkedDestinationFullName(Constant.IMPORT_PLO);
					GenericContent gc = null;
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,topic);
					ps.setString(3,topic);
					ps.setString(4,alpha);
					rs = ps.executeQuery();
					while ( rs.next() ){
						comment = AseUtil.nullToBlank(rs.getString(1));
						gc = new GenericContent(0,kix,campus,alpha,num,type,Constant.COURSE_PROGRAM_SLO,comment,"",user,0);
						rowsAffected += GenericContentDB.insertContent(conn,gc);
					}
					rs.close();
					ps.close();

					logger.info("Imported " + rowsAffected + " " + topic);
				} // sql != null
			}
			else if (src.equals(Constant.IMPORT_SLO)){
				if (sql != null && sql.length() > 0){
					GenericContent gc = null;
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,src);
					ps.setString(3,src);
					ps.setString(4,alpha);
					rs = ps.executeQuery();
					while ( rs.next() ){
						comment = AseUtil.nullToBlank(rs.getString(1));
						CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,comment,0,user,kix);
						++rowsAffected;
					}
					rs.close();
					ps.close();

					logger.info("Imported " + rowsAffected + " " + Constant.IMPORT_SLO);
				} // sql != null
			}
			else if (src.equals(Constant.IMPORT_GESLO)){
				if (sql != null && sql.length() > 0){
					GenericContent gc = null;
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,src);
					ps.setString(3,src);
					ps.setString(4,alpha);
					rs = ps.executeQuery();
					while ( rs.next() ){
						comment = AseUtil.nullToBlank(rs.getString(1));
						CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,comment,0,user,kix);
						++rowsAffected;
					}
					rs.close();
					ps.close();

					logger.info("Imported " + rowsAffected + " " + Constant.IMPORT_GESLO);
				} // sql != null
			}
		}
		catch(SQLException se){
			logger.fatal("ValuesDB: addSrcToOutline - " + se.toString());
		}
		catch(Exception ex){
			logger.fatal("ValuesDB: addSrcToOutline - " + ex.toString());
		}

		return rowsAffected;
	} // ValuesDB: addSrcToOutline

	/**
	 * getListBySrcSubTopic
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	subtopic		String
	 * <p>
	 * @return	String
	 */
	public static String getListBySrcSubTopic(Connection conn,String campus,String src,String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String listBySrcDivSubTopic = "";
		boolean found = false;

		try {
			String sql = ValuesDB.getSQL("listBySrcDivSubTopic");
			if (sql != null && sql.length() > 0){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,src);
				ps.setString(3,subtopic);
				ps.setString(4,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					listBySrcDivSubTopic += "<li>" + AseUtil.nullToBlank(rs.getString("shortdescr")) + "</li>";
					found = true;
				}
				rs.close();
				ps.close();

				if (found)
					listBySrcDivSubTopic = "<ul>" + listBySrcDivSubTopic + "</ul>";
			}

		} catch (SQLException e) {
			logger.fatal("ValuesDB: getListBySrcSubTopic - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getListBySrcSubTopic - " + e.toString());
		}

		return listBySrcDivSubTopic;
	}

	/**
	 * drawHTMLRadioListBySrc
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * <p>
	 * @return	String
	 */
	public static String drawHTMLRadioListBySrc(Connection conn,String campus,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String divisionCode = "";

		StringBuffer temp = new StringBuffer();

		boolean found = false;

		try {
			String sql = "SELECT DISTINCT subtopic FROM tblValues WHERE campus=? AND src=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				divisionCode = AseUtil.nullToBlank(rs.getString("subtopic"));

				temp.append("<input type=\"radio\" "
					+ "value=\"" + divisionCode + "\" "
					+ "onClick=\"return loadContent('"+src+"','"+divisionCode+"');\" "
					+ "name=\"list\">" + divisionCode + "<br/>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				divisionCode = temp.toString();
			}
			else{
				divisionCode = "";
			}

		} catch (SQLException e) {
			logger.fatal("ValuesDB: drawHTMLRadioListBySrc - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: drawHTMLRadioListBySrc - " + e.toString());
		}

		return divisionCode;
	}

	public static String drawHTMLRadioListBySrcOBSOLETE(Connection conn,String campus,String src) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String divisionCode = "";

		StringBuffer temp = new StringBuffer();

		boolean found = false;

		try {
			String sql = "SELECT DISTINCT subtopic FROM tblValues WHERE campus=? AND src=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,src);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				divisionCode = AseUtil.nullToBlank(rs.getString("subtopic"));

				temp.append("<input type=\"radio\" "
					+ "value=\"" + divisionCode + "\" "
					+ "name=\"list\">" + divisionCode + "<br/>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				divisionCode = temp.toString();
			}
			else{
				divisionCode = "";
			}

		} catch (SQLException e) {
			logger.fatal("ValuesDB: drawHTMLRadioListBySrc - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: drawHTMLRadioListBySrc - " + e.toString());
		}

		return divisionCode;
	}

	/**
	 * getListByCampusSrcSubTopic
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	subtopic		String
	 * <p>
	 * @return	String
	 */
	public static String getListByCampusSrcSubTopic(Connection conn,String campus,String src,String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String list = "";

		boolean found = false;

		try {

			// some src items started out with different names so we must accommodate
			String src2 = Constant.getAlternateName(src);

			String sql = getSQL("listByCampusSrcSubTopic");

			if (sql != null && sql.length() > 0){
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,src);
				ps.setString(3,src2);
				ps.setString(4,subtopic);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					list += "<li>" + AseUtil.nullToBlank(rs.getString("shortdescr")) + "</li>";
					found = true;
				}
				rs.close();
				ps.close();

				if (found)
					list = "<ul>" + list + "</ul>";
			}

		} catch (SQLException e) {
			logger.fatal("ValuesDB: getListByCampusSrcSubTopic - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getListByCampusSrcSubTopic - " + e.toString());
		}

		return list;
	}

	/**
	 * getListByCampusTopicSubTopic
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	topic			String
	 * @param	subtopic		String
	 * <p>
	 * @return	String
	 */
	public static String getListByCampusTopicSubTopic(Connection conn,String campus,String topic,String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String list = "";

		boolean found = false;

		try {
			String sql = getSQL("listByCampusTopicSubTopic");

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,topic);
			ps.setString(3,subtopic);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list += "<li>" + AseUtil.nullToBlank(rs.getString("shortdescr")) + "</li>";
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				list = "<ul>" + list + "</ul>";

		} catch (SQLException e) {
			logger.fatal("ValuesDB: getListByCampusTopicSubTopic - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: getListByCampusTopicSubTopic - " + e.toString());
		}

		return list;
	}

	/**
	 * insertListFromTopicSubtopic
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	src			String
	 * @param	subtopic		String
	 * <p>
	 * @return	int
	 */
	public static int insertListFromTopicSubtopic(Connection conn,
																String campus,
																String kix,
																String user,
																String src,
																String subtopic) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		String content = "";

		int rowsAffected  = 0;

		try {
			GenericContent gc = null;

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			String topic = Constant.GetLinkedDestinationFullName(src) + " - " + subtopic;

			String sql = "SELECT shortdescr FROM tblValues WHERE campus=? AND topic=? AND subtopic=? ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,topic);
			ps.setString(3,subtopic);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				content = AseUtil.nullToBlank(rs.getString("shortdescr"));
				gc = new GenericContent(0,kix,campus,alpha,num,type,src,content,Constant.BLANK,user,0);
				rowsAffected = GenericContentDB.insertContent(conn,gc);
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("ValuesDB: insertListFromTopicSubtopic - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ValuesDB: insertListFromTopicSubtopic - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getValues
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	topic		String
	 * <p>
	 * @return Banner
	 */
	public static List<Values> getValues(Connection conn,String campus,String topic) throws Exception {

		List<Values> ValuesData = null;

		try {
			if (ValuesData == null){

            ValuesData = new LinkedList<Values>();

            AseUtil aseUtil = new AseUtil();

				String sql = "SELECT id,campus,Topic,SubTopic,Seq,shortdescr,longDescr,auditby,auditdate "
						+ "FROM tblValues WHERE campus=? AND topic=? ORDER BY subtopic, seq";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,topic);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	ValuesData.add(new Values(
										rs.getInt("id"),
										NumericUtil.nullToZero(rs.getInt("seq")),
										AseUtil.nullToBlank(rs.getString("campus")),
										AseUtil.nullToBlank(rs.getString("Topic")),
										AseUtil.nullToBlank(rs.getString("SubTopic")),
										AseUtil.nullToBlank(rs.getString("shortdescr")),
										AseUtil.nullToBlank(rs.getString("longDescr")),
										AseUtil.nullToBlank(rs.getString("auditBy")),
										aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME)
									));
				} // while
				rs.close();
				ps.close();
				aseUtil = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("ValuesDB: getValues\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("ValuesDB: getValues\n" + e.toString());
			return null;
		}

		return ValuesData;
	}

	/*
	 * getValues
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	topic		String
	 * @param	subtopic	String
	 * <p>
	 * @return Banner
	 */
	public static List<Values> getValues(Connection conn,String campus,String topic,String subtopic) throws Exception {

		List<Values> ValuesData = null;

		try {
			if (ValuesData == null){

            ValuesData = new LinkedList<Values>();

            AseUtil aseUtil = new AseUtil();

				String sql = "SELECT id,campus,Topic,SubTopic,Seq,shortdescr,longDescr,auditby,auditdate "
						+ "FROM tblValues WHERE campus=? AND topic=? AND subtopic=? ORDER BY subtopic, seq";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,topic);
				ps.setString(3,subtopic);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	ValuesData.add(new Values(
										rs.getInt("id"),
										NumericUtil.nullToZero(rs.getInt("seq")),
										AseUtil.nullToBlank(rs.getString("campus")),
										AseUtil.nullToBlank(topic),
										AseUtil.nullToBlank(subtopic),
										AseUtil.nullToBlank(rs.getString("shortdescr")),
										AseUtil.nullToBlank(rs.getString("longDescr")),
										AseUtil.nullToBlank(rs.getString("auditBy")),
										aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME)
									));
				} // while
				rs.close();
				ps.close();
				aseUtil = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("ValuesDB: getValues\n" + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("ValuesDB: getValues\n" + e.toString());
			return null;
		}

		return ValuesData;
	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}