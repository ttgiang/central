/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 *	public static String drawCowiqDB(Connection conn,String campus,String input,boolean view){
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class CowiqDB {

	static Logger logger = Logger.getLogger(CowiqDB.class.getName());

	public CowiqDB(){}

	/**
	 * drawCowiq
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	view		boolean
	 * <p>
	 * @return	String
	 */
	public static String drawCowiq(Connection conn,String campus,String kix,boolean view){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String temp = "";
		int numberOfControls = 0;
		int i = 0;
		int id = 0;
		int seq = 0;
		int topic = 0;
		int index = 0;
		int saveTopic = 0;
		String sid = "";
		String header = "";
		String descr = "";
		String bgColor = "";

		int oldID = 0;

		String sql = "";
		String[] dataItem = null;
		String[] dataItem2 = null;
		int[] dI2 = null;

		PreparedStatement ps = null;
		ResultSet rs = null;

		String item = "";
		String item2 = "";

		String defaultValue = "0";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			// get the ID holding the values of any saved COWIQ
			// when oldID > 0, we have data saved. If not, we never
			// saved data for this KIX
			oldID = LinkerDB.getLinkedID(conn,campus,kix,Constant.COURSE_CCOWIQ,Constant.COURSE_CCOWIQ,0);

			// if the id exists, fill up the array with data for use to populate form
			if (oldID>0){
				sql = "SELECT item,item2 "
					+ "FROM tblCourseLinked2 "
					+ "WHERE historyid=? "
					+ "AND id=? "
					+ "ORDER BY item2 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,oldID);
				rs = ps.executeQuery();
				while(rs.next()){
					found = true;
					if ("".equals(item)){
						item = "" + rs.getInt("item");
						item2 = "" + rs.getInt("item2");
					}
					else{
						item = item + "," + rs.getInt("item");
						item2 = item2 + "," + rs.getInt("item2");
					}
				}
				rs.close();

				if (found){
					dataItem = item.split(",");
					dataItem2 = item2.split(",");

					// binary search function does not seem to work out as well as
					// using integer. converting to Integer array works better
					dI2 = new int[dataItem2.length];
					for(i=0;i<dataItem2.length;i++){
						dI2[i] = Integer.parseInt(dataItem2[i]);
					}
				}
			}

			buf.append("<table id=\"tableDrawCowiq\" width=\"100%\" border=\"3\" cellpadding=\"2\" cellspacing=\"0\">");

			sql = "SELECT id,topic,header,descr,seq "
				+ "FROM tblccowiq "
				+ "WHERE campus=? "
				+ "ORDER BY topic,seq ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				topic = rs.getInt("topic");
				seq = rs.getInt("seq");
				header = rs.getString("header");
				descr = rs.getString("descr");

				if (seq==0)
					bgColor = "#e0e0e0";
				else
					if (numberOfControls%2==0)
						bgColor = Constant.ODD_ROW_BGCOLOR;
					else
						bgColor = Constant.EVEN_ROW_BGCOLOR;

				buf.append("<tr height=\"40\" bgcolor=\"" + bgColor + "\">");
				buf.append("<td class=\"textblackth\" valign=\"top\">");

				if (seq==0)
					buf.append(header + "<br/>" + descr);
				else
					buf.append(header);

				buf.append("</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\" width=\"05%\">&nbsp;</td>");

				buf.append("<td class=\"datacolumn\" valign=\"top\" width=\"05%\">");

				if (seq==0)
					buf.append("&nbsp;");
				else{
					if (!view){

						// locate the ID of the current COWIQ in the array and if found,
						// set the defaultValue to the index element of the array. if
						// not, default = 0
						defaultValue = "0";
						if (oldID>0 && found){
							index = Arrays.binarySearch(dI2,id);
							if (index>-1)
								defaultValue = dataItem[index];
						}

						buf.append(aseUtil.createStaticSelectionBox("0,1,2,3","0,1,2,3",
										"Control_"+String.valueOf(id),defaultValue,"",""," ","1"));

						if ("".equals(sid))
							sid = String.valueOf(id);
						else
							sid = sid + "," + String.valueOf(id);
					}
					else{
						if (oldID>0 && found){
							defaultValue = "0";
							index = Arrays.binarySearch(dI2,id);
							if (index>-1)
								defaultValue = dataItem[index];

							buf.append(defaultValue);
						}
						else
							buf.append("&nbsp;");
					}
				}

				++numberOfControls;

				buf.append("</td>");
				buf.append(Constant.TABLE_ROW_END);
			}
			rs.close();
			ps.close();

			if (!view)
				buf.append("<tr><td colspan=\"3\"><input type=\"hidden\" id=\"sid\" name=\"sid\" value=\""+sid+"\"></td></tr>");

			buf.append(Constant.TABLE_END);

			temp = buf.toString();
		}catch(SQLException se){
			System.out.println("Cowiq: drawCowiq - " + se.toString());
		}catch(Exception ex){
			System.out.println("Cowiq: drawCowiq - " + ex.toString());
		}

		return temp;
	}

	/**
	 * updateCowiq
	 * <p>
	 * @param	conn		Connection
	 * @param	request	HttpServletRequest
	 * @param	campus	String
	 * @param	kix		String
	 * @param	column	String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String updateCowiq(Connection conn,
												HttpServletRequest request,
												String campus,
												String kix,
												String column,
												String user){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";

		PreparedStatement ps = null;

		boolean found = true;

		int i = 0;
		int oldID = 0;
		int rowsAffected = 0;

		try{
			WebSite website = new WebSite();

			// sid is string containing all IDs listing on the form.
			// split sid into an array and process each form element to retrieve values
			String sid = website.getRequestParameter(request,"sid","",false);
			String[] aSid = sid.split(",");
			int c = aSid.length;

			// with each save of COWIQ, figure out what the key id is between linked and linked2
			// if oldID (the key) exists, use it to delete existing linked data before adding (Step 1b).
			// if oldID does not exist, create it. (Step 1a)

			// after taking care of oldID, insert form entries (Step 2)
			oldID = LinkerDB.getLinkedID(conn,campus,kix,column,column,0);
			if (oldID == 0){
				// Step 1a
				sql = "INSERT INTO tblCourseLinked (campus,historyid,src,seq,dst,auditby,auditdate,coursetype) VALUES(?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,column);
				ps.setInt(4,0);
				ps.setString(5,column);
				ps.setString(6,user);
				ps.setString(7,AseUtil.getCurrentDateTimeString());
				ps.setString(8,"PRE");
				ps.executeUpdate();
				ps.close();
				oldID = LinkerDB.getLinkedID(conn,campus,kix,column,column,0);
			}
			else{
				// Step 1b
				sql = "DELETE FROM tblCourseLinked2 WHERE historyid=? AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,oldID);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			// Step 2
			sql = "INSERT INTO tblCourseLinked2(historyid,id,item,auditby,item2) VALUES(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			for (i=0; i<c; i++) {
				temp = website.getRequestParameter(request,"Control_"+aSid[i], "0");
				if (temp != null && !"".equals(temp)) {
					ps.setString(1,kix);
					ps.setInt(2,oldID);
					ps.setString(3,temp);
					ps.setString(4,user);
					ps.setInt(5,NumericUtil.nullToZero(aSid[i]));
					rowsAffected = ps.executeUpdate();
					found = true;
				}
			}
			ps.close();

			// if nothing was saved, delete from the link table
			if (!found){
				sql = "DELETE FROM tblCourseLinked "
					+ "WHERE campus=? "
					+ "AND historyid=? "
					+ "AND src=? "
					+ "AND id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,kix);
				ps.setString(3,column);
				ps.setInt(4,oldID);
				rowsAffected = ps.executeUpdate();
			}

		}catch(SQLException se){
			logger.fatal("Cowiq: updateCowiq - " + se.toString());
		}catch(Exception ex){
			logger.fatal("Cowiq: updateCowiq - " + ex.toString());
		}

		return temp;
	}

}