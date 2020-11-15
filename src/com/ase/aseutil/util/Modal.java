/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// Modal.java
//
package com.ase.aseutil.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ase.aseutil.AseUtil;

public class Modal {

	static Logger logger = Logger.getLogger(Modal.class.getName());

	public Modal() throws Exception {}

	/**
	 * writeModalDivs
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	sql		String
	 * <p>
	 * @return	String
	 */
	public static String writeModalDivs(Connection conn,String campus,String user,String sql){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();

			listings.append("<div id=\"boxes\">");

			//sql = "SELECT id,'Curriculum Central Meeting Mintues<br>' + convert(varchar,dte,101) as title,minutes as contents FROM tblMinutes ORDER BY dte DESC";

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				int i = rs.getInt("id");
				String title = AseUtil.nullToBlank(rs.getString("title"));
				String contents = AseUtil.nullToBlank(rs.getString("contents"));

				listings.append("<div id=\"dialog"+i+"\" class=\"window ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable\">"
					+ "<table width=\"100%\">"
					+ "<tr>"
					+ "<td width=\"10%\">&nbsp;</td>"
					+ "<td width=\"80%\" class=\"textblackthcenter\">" + title + "</td>"
					+ "<td width=\"10%\" align=\"right\">"
					+ "<a href=\"#\"class=\"close\"/><img src=\"../images/cancel.png\" border=\"0\" width=\"24\" height=\"24\" title=\"close\"></a>"
					+ "</td>"
					+ "</tr>"
					+ "<tr>"
					+ "<td colspan=\"3\"><hr size=\"1\">"
					+ "</td>"
					+ "</tr>"
					+ "</table>"
					+ "<p align=\"left\">"
					+ contents
					+ "</p>"
					+ "<table width=\"100%\">"
					+ "<tr><td colspan=\"3\"><hr size=\"1\"></td></tr>"
					+ "<tr>"
					+ "<td colspan=\"3\" align=\"right\">"
					+ "<a href=\"#\"class=\"close\"/><img src=\"../images/cancel.png\" border=\"0\" width=\"24\" height=\"24\" title=\"close\"></a>"
					+ "</td>"
					+ "</tr>"
					+ "</table>"
					+ "</div>");

			}
			rs.close();
			ps.close();

			listings.append("<!-- Mask to cover the whole screen -->");
			listings.append("<div id=\"mask\"></div>");
			listings.append("</div>");
		}
		catch( SQLException e ){
			logger.fatal("Modal: writeModalDivs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Modal: writeModalDivs - " + ex.toString());
		}

		return listings.toString();

	}

	/**
	 * close
	 */
	public void close() throws SQLException {}

}