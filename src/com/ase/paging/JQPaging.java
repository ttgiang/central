/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.ase.paging;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;

public class JQPaging {

	boolean shortDate = false;

	/**
	 * when not null, there is a detail record to display so create link
	 */
	private String detailLink;
	private String linkedKey;

	/**
	 * column width
	 */
	private String[] columnWidth;
	private String tableColumnWidth;

	/**
	 * A string representing an onClick ID to display data.
	 */
	private String onClick = "";

	/**
	 *
	 */
	private String sql;

	/**
	 *
	 */
	private String urlKeyName = "lid";

	/**
	 *
	 */
	private String target = "0";

	/**
	 * @param arg
	 */
	public void setShortDate(boolean arg) {
		shortDate = arg;
	}

	public boolean getShortDate() {
		return shortDate;
	}

	/**
	 * @param arg
	 */
	public void setUrlKeyName(String arg) {
		urlKeyName = arg;
	}

	public String getUrlKeyName() {
		return urlKeyName;
	}

	/**
	 * @param arg
	 */
	public void setTarget(String arg) {
		target = arg;
	}

	public String getTarget() {
		return target;
	}

	/**
	 * Whether or not to enable auto column width
	 * <p>
	 *
	 * @param arg
	 *            true or false (default is true)
	 */
	public void setTableColumnWidth(String arg) {
		tableColumnWidth = arg;
	}

	public String getTableColumnWidth() {
		return tableColumnWidth;
	}

	/**
	 * @param arg
	 */
	public void setOnClick(String arg) {

		if(arg != null && arg.length() > 0){
			onClick = " onClick=\""+arg+"\" ";
		}
	}

	public String getOnClick() {
		return onClick;
	}

	/**
	 * @param arg
	 */
	public void setSql(String arg) {
		sql = arg;
	}

	public String getSql() {
		return sql;
	}

	/**
	 * Detail refers to the page that is linked to from the paging page. This
	 * page is normally tied to a key returned from the resultset.
	 * <p>
	 *
	 * @param arg
	 *            Formatted URL
	 */
	public void setDetailLink(String arg) {
		detailLink = arg;

		// when detail linking is available, make sure to
		// create linked page properly. If no key and just
		// a page is sent in, then the URL argument starts
		// with a question mark. However, if an argument
		// is provided along with the linked page, then
		// a question mark is there. So, in linking the key
		// field, start with apersand.
		if (detailLink != null) {
			if (detailLink.indexOf("?") > 0)
				linkedKey = "&";
			else
				linkedKey = "?";
		}
	}

	public String getDetailLink() {
		return detailLink;
	}

	//
	// these are the values to use should we not have valid data
	//
	static Logger logger = Logger.getLogger(JQPaging.class.getName());

	/**
	 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
	 * You may not modify, use, reproduce, or distribute this software except in
	 * compliance with the terms of the License made with Applied Software
	 * Engineernig.
	 * <p>
	 * $Id: Paging.java,v 1.00 2007/07/15 23:32:30 ttgiang Exp $
	 * <p>
	 * Paging class constructor. Sets up how table, rows, columns are rendered.
	 * Most important is the key filed must be the first field in the select
	 * statement.
	 */
	public JQPaging() throws IOException {}

	public String showTable(Connection conn,String sql,String detail) {

		return showTable(conn,sql,detail,"jqpaging");

	}

	public String showTable(Connection conn,String sql,String detail,String tableID) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

// these are used in JSP
//String target = "0";
//String urlKeyName = "";
//String onClick = "onClick=\"return hs.htmlExpand(this, { objectType: \'ajax\',width:600} )\"";

		String alignmentString = "integerdatetimedecimaldoublesmalldatetime";
		String align = "left";

		int i = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			buf.append("<div id=\"container90\">"
				+ "<div id=\"demo_jui\">"
				+ "<table id=\""+tableID+"\" class=\"display\">"
				+ "<thead>"
				+ "<tr>");

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			if(rsmd != null){

				// number of columns to work with
				int columnCount = rsmd.getColumnCount();

				// column names
				String[] columnName = new String[columnCount];

				// data type
				String[] columnDataType = new String[columnCount];


				for(i=0; i<columnCount; i++){
					columnName[i] = rsmd.getColumnLabel(i+1);
					columnDataType[i] = rsmd.getColumnTypeName(i + 1).toLowerCase();
				}

				// draw column header
				for(i=0; i<columnCount; i++){

					align = "left";

					if (alignmentString.indexOf(columnDataType[i]) > -1){
						align = "right";
					}

					buf.append("<th align=\""+align+"\">"+columnName[i]+"</th>");
				}

				// close header row and start table body
				buf.append("</tr></thead><tbody>");

				String junk = "";
				String linkKeyName = "lid";
				String connector = "?";

				// set target window
				if(target.equals("1")){
					target = " target=\"_blank\" ";
				}
				else{
					target = "";
				}

				// primary key for linking
				if(!urlKeyName.equals(Constant.BLANK)){
					linkKeyName = urlKeyName;
				}

				// what's the start of our arg list
				if(detail.indexOf("?") > -1){
					connector = "&";
				}

				// process data
				while (rs.next()){

					String key = "";

					// draw data by row
					buf.append("<tr>");
					for(i=0; i<columnCount; i++){

						align = "left";
						if (alignmentString.indexOf(columnDataType[i]) > -1){
							align = "right";
						}

						// hold on to the key for linking
						if(i==0){
							key = AseUtil.nullToBlank(rs.getString(columnName[0]));
						}

						if(columnName[i].toLowerCase().indexOf("date") > -1 || columnName[i].toLowerCase().indexOf("dte") > -1){
							if(shortDate){
								junk = aseUtil.ASE_FormatDateTime(rs.getString(columnName[i]),Constant.DATE_SHORT);
							}
							else{
								junk = aseUtil.ASE_FormatDateTime(rs.getString(columnName[i]),Constant.DATE_DATETIME);
							}
						}
						else{
							junk = AseUtil.nullToBlank(rs.getString(columnName[i]));
						}

						// first column is hidden so linked is on 2
						if(i==1 && !detail.equals(Constant.BLANK)){
							junk = "<a href=\""+detail+connector+linkKeyName+"="+key+"\" class=\"linkcolumn\" "+target + " " + onClick +">" + junk + "</a>";
						}

						buf.append("<td align=\""+align+"\">" + junk + "</td>");
					}
					buf.append("</tr>");

				} // while

				buf.append("</tbody></table></div></div>");

			} // valid rsmd

			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException e){
			logger.fatal("JQPaging - showTable: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("JQPaging - showTable: " + e.toString());
		}

		return buf.toString();

	}

}