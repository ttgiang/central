/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *	public static String drawFunctionDesignation(Connection conn,String campus,String input,boolean view){
 *	public static String getFunctionDesignation(Connection conn,String campus,String table,String program,String def){
 *	public static String getFunctionDesignationList(Connection conn,String campus,String table,String program,String def){
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class FunctionDesignation {

	static Logger logger = Logger.getLogger(FunctionDesignation.class.getName());

	public FunctionDesignation(){}

	/**
	 * drawFunctionDesignation
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	input		String
	 * @param	view		boolean
	 * <p>
	 * @return	String
	 */
	public static String drawFunctionDesignation(Connection conn,String campus,String input,boolean view){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();
		String temp = "";
		int i = 0;

		int maxFD = 10;

		String[] cat = "AA,AS,AAS,BAS,XX".split(",");

		try{

			String[] data = new String[maxFD];
			for (i=0;i<maxFD;i++){
				data[i] = "0";
			}

			// make sure that we have maxFD elements
			if (input != null && !"".equals(input)){
				String[] junk = input.split(",");

				for (i=0;i<junk.length;i++){
					data[i] = junk[i];
				}
			}

			buf.append("<table width=\"100%\" border=\"3\" cellpadding=\"2\" cellspacing=\"0\">");

			// Title
			buf.append("<tr height=\"40\" bgcolor=\"#e0e0e0\">")
				.append("<td class=\"textblackth\" valign=\"top\" width=\"12%\">Degree</td>")
				.append("<td class=\"textblackth\" valign=\"top\" width=\"44%\">Program</td>")
				.append("<td class=\"textblackth\" valign=\"top\" width=\"44%\">Category</td>")
				.append(Constant.TABLE_ROW_END);

			// LA
			buf.append("<tr height=\"40\">")
				.append("<td class=\"textblackth\" valign=\"top\">Associate in Arts:</td>");
			if (!view){
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Program","LA","LA",data[0]) + "</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Category","CA1",cat[0],data[1])
					+ "<br/><br/>"
					+ getFunctionDesignationList(conn,campus,"Category","CA2",cat[0],data[2])
					+ "</td>");
			}
			else{
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Program","LA",data[0]) + "</td>");
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Category",cat[0],data[1])
					+ "<br/><br/>"
					+ getFunctionDesignation(conn,campus,"Category",cat[0],data[2])
					+ "</td>");
			}
			buf.append(Constant.TABLE_ROW_END);

			// AS
			buf.append("<tr height=\"40\" bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\">");
			buf.append("<td class=\"textblackth\" valign=\"top\">AS:</td>");
			if (!view){
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Program",cat[1],cat[1],data[3]) + "</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Category",cat[1],cat[1],data[4]) + "</td>");
			}
			else{
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Program",cat[1],data[3]) + "</td>");
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Category",cat[1],data[4])
					+ "</td>");
			}
			buf.append(Constant.TABLE_ROW_END);

			// AAS
			buf.append("<tr height=\"40\">");
			buf.append("<td class=\"textblackth\" valign=\"top\">AAS:</td>");
			if (!view){
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Program",cat[2],cat[2],data[5]) + "</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Category",cat[2],cat[2],data[6]) + "</td>");
			}
			else{
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Program",cat[2],data[5]) + "</td>");
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Category",cat[2],data[6])
					+ "</td>");
			}
			buf.append(Constant.TABLE_ROW_END);

			// BAS
			buf.append("<tr height=\"40\" bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\">");
			buf.append("<td class=\"textblackth\" valign=\"top\">BAS:</td>");
			if (!view){
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Program",cat[3],cat[3],data[7]) + "</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Category",cat[3],cat[3],data[8]) + "</td>");
			}
			else{
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Program",cat[3],data[7]) + "</td>");
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Category",cat[3],data[8])
					+ "</td>");
			}
			buf.append(Constant.TABLE_ROW_END);

			// XX
			buf.append("<tr height=\"40\" bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\">");
			buf.append("<td class=\"textblackth\" valign=\"top\">Developmental/<br/>Remedial:</td>");
			if (!view){
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ getFunctionDesignationList(conn,campus,"Program",cat[4],cat[4],data[9]) + "</td>");
				buf.append("<td class=\"textblackth\" valign=\"top\">"
					+ "&nbsp;</td>");
			}
			else{
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ getFunctionDesignation(conn,campus,"Program",cat[4],data[9]) + "</td>");
				buf.append("<td class=\"datacolumn\" valign=\"top\">"
					+ "&nbsp;"
					+ "</td>");
			}
			buf.append(Constant.TABLE_ROW_END);

			buf.append(Constant.TABLE_END);

			temp = buf.toString();
		}catch(Exception ex){
			logger.fatal("FunctionDesignation: drawFunctionDesignation - " + ex.toString());
		}

		return temp;
	}

	public static String getFunctionDesignationList(Connection conn,
																	String campus,
																	String table,
																	String nme,
																	String program,
																	String def){

		//Logger logger = Logger.getLogger("test");

		String temp = "";

		String key = table.toLowerCase();

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT id, shortdescr "
				+ " FROM tblValues "
				+ " WHERE campus=" + aseUtil.toSQL(campus,1)
				+ " AND topic=" + aseUtil.toSQL("FD"+table+"-"+program,1)
				+ " AND subtopic=" + aseUtil.toSQL(program,1)
				+ " ORDER BY seq";
			temp = aseUtil.createSelectionBox(conn,sql,nme+key,def,false);
			aseUtil = null;
		}catch(Exception ex){
			logger.fatal("FunctionDesignation: getFunctionDesignationList - " + ex.toString());
		}

		return temp;
	}

	/**
	 * getFunctionDesignation
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	table		String
	 * @param	program	String
	 * @param	def		String
	 * <p>
	 * @return	String
	 */
	public static String getFunctionDesignation(Connection conn,String campus,String table,String program,String def){

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String key = "";

		try{
			String sql = "SELECT shortdescr FROM tblValues WHERE campus=? AND topic=? AND subtopic=? AND id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"FD"+table+"-"+program);
			ps.setString(3,program);
			ps.setInt(4,NumericUtil.nullToZero(def));
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				temp = rs.getString(1);
			else
				temp = "&nbsp;";

		}catch(SQLException ex){
			logger.fatal("FunctionDesignation: getFunctionDesignation - " + ex.toString());
		}catch(Exception ex){
			logger.fatal("FunctionDesignation: getFunctionDesignation - " + ex.toString());
		}

		return temp;
	}

}