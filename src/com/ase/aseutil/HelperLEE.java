/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class HelperLEE {

	static Logger logger = Logger.getLogger(HelperLEE.class.getName());

	public HelperLEE() throws IOException{}

	/**
	 * listOutlinesForSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesForSLO(Connection conn,int idx){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		StringBuffer listings = new StringBuffer();
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		String alpha = "";
		String num = "";
		String historyid = "";
		String link = "";
		String title = "";
		String rowColor = "";
		int j = 0;
		boolean found = false;

		try{
			if (idx>=LETTER_A && idx<=LETTER_Z){

				AseUtil aseUtil = new AseUtil();

				String sql = "SELECT DISTINCT historyid,coursealpha,coursenum,coursetitle "
					+ " FROM tblCourse "
					+ " WHERE campus='LEE' "
					+ " AND coursealpha like '" + (char)idx + "%' "
					+ " AND coursetype='CUR' "
					+ " ORDER BY coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					historyid = aseUtil.nullToBlank(rs.getString("historyid"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;


					link = "ccslox.jsp?kix=" + historyid + "&itm=X18";

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("<td class=\"datacolumn\" align=\"right\">" + getLastUpdated(conn,historyid) + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"20%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"60%\">Title</td>" +
						"<td class=\"textblackth\" width=\"20%\" align=\"right\">Last Updated</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Outline not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("HelperLEE: listOutlinesForSLO - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("HelperLEE: listOutlinesForSLO - " + ex.toString());
		}

		return listing;
	}

	/*
	 * getLastUpdated
	 *	<p>
	 *	@return String
	 */
	public static String getLastUpdated(Connection conn,String kix) throws SQLException {

		String lastDate = "";

		try {
			String sql = "SELECT MAX(AuditDate) AS auditdate "
						+ "FROM tblCourseComp "
						+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				AseUtil aseUtil = new AseUtil();

				lastDate = AseUtil.nullToBlank(rs.getString(1));

				if (lastDate != null && lastDate.length()>0)
					lastDate = aseUtil.ASE_FormatDateTime(lastDate,Constant.DATE_DATETIME);

				aseUtil = null;

			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("HelperLEE: getLastUpdated - " + e.toString());
		} catch (Exception ex) {
			logger.fatal("HelperLEE: getLastUpdated - " + ex.toString());
		}

		return lastDate;
	}

}
