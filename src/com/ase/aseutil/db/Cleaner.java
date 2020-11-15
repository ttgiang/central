/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// Cleaner.java
//
package com.ase.aseutil.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.ase.aseutil.AntiSpamy;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.ProgramsDB;
import com.ase.aseutil.Tables;

public class Cleaner {

	static Logger logger = Logger.getLogger(Cleaner.class.getName());

	/*
	 * cleanData
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	<p>
	 * @return int
	 */
	public static String cleaner(Connection conn,String campus,String kix) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer log = new StringBuffer();

		int rowsAffected = 0;

		try {

			log.append("campus: " + campus + "<br>");
			log.append("kix: " + kix + "<br>");

			String columns = "outcomes,functions,organized,enroll,resources,efficient,effectiveness,proposed,rationale,substantive,articulated,additionalstaff,requiredhours";

			String sql = "SELECT historyid, title, degreeid, divisionid, " + columns + " FROM tblPrograms WHERE historyid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){

				log.append("title: " + AseUtil.nullToBlank(rs.getString("title")) + "<br>");

				int degreeid = rs.getInt("degreeid");
				int divisionid = rs.getInt("divisionid");

				String[] aColumns = columns.split(",");

				boolean found = false;

				for(int i=0; i<aColumns.length; i++){
					String column = aColumns[i];

					String data = AseUtil.nullToBlank(rs.getString(column));

					if(hasScriptTag(data)){
						found = true;
						log.append("fixing " + column + "<br>");
						data = AntiSpamy.spamy(kix,column,data);
						ProgramsDB.setItem(conn,campus,kix,column,data,"s");
					} // if

				} // i

				if(found){
					Tables.createPrograms(campus,kix,""+degreeid,""+divisionid);
					log.append("creating <a href=\"/centraldocs/docs/programs/"+campus+"/"+kix+".html\" target=\"_blank\" class=\"linkcolumn\">html</a><br>");
				}
			}
			else{
				log.append("invalid cps & kix<br>");
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TaskDB.cleanData - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TaskDB.cleanData - " + e.toString());
		}

		return log.toString();
	}

	/*
	 * hasScriptTag
	 *	<p>
	 *	@return	boolean
	 *	<p>
	 */
	public static boolean hasScriptTag(String content) throws Exception {

		content = content.replace("<SCRIPT","<script").replace("</SCRIPT","</script");

		boolean found = false;

		found = false;

		Pattern script = Pattern.compile("<script.*?>.*?</script>");

		Matcher mscript = script.matcher(content);

		while (mscript.find() && !found){
			found = true;
		}

		return found;

	}

	/*
	 * removeJavaScriptTags - remove script tags from content
	 *	<p>
	 * @param	content	String
	 *	<p>
	 * @return String
	 */
	public static String removeJavaScriptTags(String content) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int start = 0;
		int end = 0;
		String left = null;
		String right = null;

		try{
			// script tags come following format:
			// &lt;SCRIPT src="some-crappy-site"&gt;&lt;/SCRIPT&gt;

			// remove the start and up to the first &gt; symbol.
			// repeat until all gone the do the same for the end tag

			if (content==null || content.length() == 0)
				content = "";

			start = content.toLowerCase().indexOf("<script");
			while (start != - 1){
				end = content.toLowerCase().indexOf(">",start)+1;
				left = content.substring(0,start-1);
				right = content.substring(end,content.length());
				content = left + right;
				start = content.toLowerCase().indexOf("<script");
			}

			start = content.toLowerCase().indexOf("</script");
			while (start != - 1){
				end = content.toLowerCase().indexOf(">",start)+1;
				left = content.substring(0,start-1);
				right = content.substring(end,content.length());
				content = left + right;
				start = content.toLowerCase().indexOf("</script");
			}
		} catch (Exception e) {
			logger.fatal("SQLUtil: removeJavaScriptTags - " + e.toString());
		}

		return content;
	}

	public static void main(String[] args) {

	} // main

} // DBOjects

