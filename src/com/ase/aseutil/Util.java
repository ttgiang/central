/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static String arrayToString(String[] a, String separator) {
 *	public static String configureCC(Connection conn,String campus){
 * public static String[] getINIKeyValues(Connection conn,String campus,String iniKey){
 *	public static String getSessionMappedKey(HttpSession session,String key){
 *	public static String removeDuplicateFromString(String str){
 *	public static String showSessionMappedKeys(HttpSession session){
 *	public static String stringToArrayToString(String str,String separator,boolean duplicate) {
 *
 */

package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Vector;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class Util {

	static Logger logger = Logger.getLogger(Util.class.getName());

	/**
	 * stringToArrayToStringInt (sort as numbers before sending back as string)
	 * <p>
	 * @param	str			String
	 * @param	separator	String
	 * @param	duplicate	boolean
	 * <p>
	 * @return	String
	 */
	public static String stringToArrayToStringInt(String str,String separator,boolean duplicate) {

		String result = "";

		try{
			if (str != null && str.length() > 0){
				int i = 0;

				if (!duplicate)
					str = Util.removeDuplicateFromString(str);

				String[] sa = str.split(separator);
				int[] ia = new int[sa.length];

				// move to integer array
				for (i=0; i < sa.length; i++)
					ia[i] = Integer.parseInt(sa[i]);

				Arrays.sort(ia);

				// move back to string array
				for (i=0; i < sa.length; i++)
					sa[i] = ia[i]+"";

				result = Util.arrayToString(sa,separator);
			}
		}
		catch(Exception e){
			logger.fatal("Util - stringToArrayToStringInt: " + e.toString());
		}

		return result;
	}

	/**
	 * stringToArrayToString
	 * <p>
	 * @param	str			String
	 * @param	separator	String
	 * @param	duplicate	boolean
	 * <p>
	 * @return	String
	 */
	public static String stringToArrayToString(String str,String separator,boolean duplicate) {

		String result = "";

		try{
			if (str != null && str.length() > 0){
				if (!duplicate)
					str = removeDuplicateFromString(str);

				String[] sa = str.split(separator);
				Arrays.sort(sa);
				result = arrayToString(sa,separator);
			}
		}
		catch(Exception e){
			logger.fatal("Util - stringToArrayToString: " + e.toString());
		}

		return result;
	}

	/**
	 * arrayToString
	 * <p>
	 * @param	a				String[]
	 * @param	separator	String
	 * <p>
	 * @return	String
	 */
	public static String arrayToString(String[] a, String separator) {

		String result = "";

		if (a.length > 0) {
			result = a[0];

			for (int i=1; i<a.length; i++) {
				result = result + separator + a[i];
			}
		}

		return result;
	}

	/**
	 * removeDuplicateFromString
	 * <p>
	 * @param	str		String
	 * <p>
	 * @return	String
	 */
	public static String removeDuplicateFromString2(String str){

		// the HashSet section causes the returned string to be in reversed order

		if (str != null && str.length() > 0){
			str = str.replace(" ","");

			String[] data = str.split(",");

			List<String> list = Arrays.asList(data);
			Set<String> set = new HashSet<String>(list);

			String[] result = new String[set.size()];
			set.toArray(result);
			str = "";

			for (String s : result) {
				if ("".equals(str))
					str = s;
				else
					str = str + "," + s;
			}
		}
		else
			str = "";

		return str;
	}

	/**
	 * removeDuplicateFromString
	 * <p>
	 * @param	str		String
	 * <p>
	 * @return	String
	 */
	public static String removeDuplicateFromString(String str){

		if (str != null && str.length() > 0){

			str = str.replace(Constant.SPACE,Constant.BLANK);

			String[] data = str.split(",");

			data = deleteDuplicates(data);

			str = "";

			for(int i=0;i<data.length;i++){
				if (str.equals(Constant.BLANK))
					str = data[i];
				else
					str = str + "," + data[i];
			}
		}
		else{
			str = "";
		}

		return str;
	}

	/**
	 * deleteDuplicates
	 * <p>
	 * @param	strs	String[]
	 * <p>
	 * @return	String[]
	 */
	@SuppressWarnings("unchecked")
	public static String[] deleteDuplicates(String[] strs){

		//Logger logger = Logger.getLogger("test");

		try{
			java.util.ArrayList nodups = new java.util.ArrayList() ;

			for(int i = 0 ; i < strs.length ; i++){
				if( (!nodups.contains(strs[i])) && (!strs[i].equals(Constant.BLANK)) )
					nodups.add(strs[i]);
			}

			strs = (String[])nodups.toArray(new String[nodups.size()]);
		}
		catch(Exception e){
			logger.fatal("Util.deleteDuplicates - " + e.toString());
		}

		return(strs);
	}

	/**
	 * getResourceString
	 * <p>
	 * @param	resourceFile
	 * <p>
	 * @return	String
	 */
	public static String getResourceString(String resourceFile){

		BufferedReader inputStream = null;
		StringBuffer inputResource = null;

		try {
			if (resourceFile != null){
				String currentDrive = AseUtil.getCurrentDrive();

				String dataFile = currentDrive + ":\\tomcat\\webapps\\central\\WEB-INF\\resources\\" + resourceFile;

				String line;

				inputStream = new BufferedReader(new FileReader(dataFile));

				if (inputStream != null){
					inputResource = new StringBuffer();

					while ((line = inputStream.readLine()) != null){
						inputResource.append(line);
					}

					inputStream.close();
				} // inputStream != null
			} // resourceFile
		} catch(IOException e){
			logger.fatal("Util - getResourceString: " + resourceFile + "\n" + e.toString());
		} catch(Exception e){
			logger.fatal("Util - getResourceString: " + resourceFile + "\n" + e.toString());
		}

		if (inputResource == null)
			inputResource.append("");

		return inputResource.toString();
	}

	/**
	 * showSessionMappedKeys
	 * <p>
	 * @param	session
	 * @param	campus
	 * <p>
	 * @return	String
	 */
	@SuppressWarnings("unchecked")
	public static String showSessionMappedKeys(HttpSession session,String campus){

		//Logger logger = Logger.getLogger("test");

		int i = 0;

		StringBuffer buf = new StringBuffer();

		HashMap sessionMap = new HashMap();

		String rowColor = "";

		String temp = "";

		try{
			sessionMap = (HashMap)session.getAttribute("aseSessionMap");
			if (sessionMap != null){
				int sessionMapSize = sessionMap.size();
				Vector vector = new Vector(sessionMap.keySet());
				Collections.sort(vector);
				Iterator iterator = vector.iterator();
				while (iterator.hasNext()) {
					String key = iterator.next().toString();
					String value = Encrypter.decrypter(sessionMap.get(key).toString());

					if(value.length() < 20){

						if(value.equals("1")){
							value = "Yes";
						}
						else if(value.equals("0")){
							value = "No";
						}

						buf.append("<tr>"
							+ "<td align=\"left\">" + key + "</td>"
							+ "<td align=\"left\">" + value + "</td>"
							+ "</tr>");

					} // only print shorter values

				} // while

				temp = "<div id=\"container90\"><div id=\"demo_jui\"><table id=\"showSessionMappedKeys\" class=\"display\">"
					+ "<thead><tr>"
					+ "<th align=\"left\">Key</th>"
					+ "<th align=\"left\">Value</th>"
					+ "</tr></thead><tbody>"
					+ buf.toString()
					+ "</tbody></table></div></div>";
			}
		}
		catch(Exception e){
			logger.fatal("showSessionMappedKeys: " + e.toString());
		}

		return temp;

	}

	/**
	 * getSessionMappedKey
	 * <p>
	 * @param	session
	 * @param	key
	 * <p>
	 * @return	String
	 */
	public static String getSessionMappedKey(HttpSession session,String key){

		//Logger logger = Logger.getLogger("test");

		HashMap sessionMap = new HashMap();

		String value = "";

		try{
			sessionMap = (HashMap)session.getAttribute("aseSessionMap");
			if (sessionMap != null)
				value = Encrypter.decrypter((String)sessionMap.get(key));
		}
		catch(Exception e){
			logger.fatal("getSessionMappedKey: " + e.toString());
		}

		return value;

	}

	/**
	 * getINIKeyValues
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	iniKey
	 * <p>
	 * @return	String[]
	 */
	public static String[] getINIKeyValues(Connection conn,String campus,String iniKey){

		String[] listRange = null;

		try{
			AseUtil aseUtil = new AseUtil();

			listRange = aseUtil.lookUpX(conn,
												"tblIni",
												"kval1,kval2",
												"category='System' "
												+ "AND campus='"
												+ campus
												+ "' AND kid='"+iniKey+"'");

			aseUtil = null;
		}
		catch(Exception e){
			logger.fatal("getINIKeyValues: " + e.toString());
		}

		return listRange;

	}

	/**
	 * configureCC
	 * <p>
	 * @param	conn
	 * @param	campus
	 * <p>
	 * @return	String
	 */
	public static String configureCC(Connection conn,String campus){

		StringBuffer output = new StringBuffer();

		try{

			String table = "";
			String where = "";
			String title = "";
			String require = "";

			String image = "";
			String bgColor = "";

			int rowCount = 0;

			int rowsAffected = 0;

			String[] tables = "tblCourseQuestions,tblCampusQuestions,tblProgramQuestions,tblUsers,tblApprover,tblDivision".split(",");

			String[] wheres = new String[tables.length];
			wheres[0] = "WHERE campus='"+campus+"' AND type='Course' AND include='Y'";
			wheres[1] = "WHERE campus='"+campus+"' AND type='Course' AND include='Y'";
			wheres[2] = "WHERE campus='"+campus+"' AND type='Program' AND include='Y'";
			wheres[3] = "WHERE campus='"+campus+"' AND status='Active'";
			wheres[4] = "WHERE campus='"+campus+"'";
			wheres[5] = "WHERE campus='"+campus+"'";

			String[] titles = new String[tables.length];
			titles[0] = "Course questions";
			titles[1] = "Campus questions";
			titles[2] = "Program questions";
			titles[3] = "Campus users";
			titles[4] = "Approval Routing";
			titles[5] = "Divisions";

			String[] required = new String[tables.length];
			required[0] = Constant.ON;			// course questions must be
			required[1] = Constant.OFF;		// campus questions are optional
			required[2] = Constant.OFF;		// programs are optional
			required[3] = Constant.ON;			// users are required
			required[4] = Constant.ON;			// approvers are required
			required[5] = Constant.ON;			// division is a must

			String[] distinct = new String[tables.length];
			distinct[0] = Constant.BLANK;
			distinct[1] = Constant.BLANK;
			distinct[2] = Constant.BLANK;
			distinct[3] = Constant.BLANK;
			distinct[4] = "route";
			distinct[5] = Constant.BLANK;

			output.append("<table width=\"90%\" align=\"left\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\">"
				+ "<tr>"
				+ "<td class=\"textblackth\" width=\"100%\">"
				+ "<img src=\"../images/check1.gif\" border=\"0\">&nbsp;&nbsp;Item passes configuration check"
				+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
				+ "<img src=\"../images/warning.gif\" border=\"0\">&nbsp;&nbsp;Item failed configuration check"
				+ "</td>"
				+ "</tr>"
				+ "</table>"
				+ "<br><br>"
				+ "<table width=\"90%\" align=\"left\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\">"
				+ "<tr bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
				+ "<td class=\"textblackth\" width=\"20%\">Conguration Item</td>"
				+ "<td class=\"textblackth\" width=\"10%\">Required</td>"
				+ "<td class=\"textblackth\" width=\"10%\">Item Count</td>"
				+ "<td class=\"textblackth\" width=\"60%\">Configured</td>"
				+ "</tr>");

			for(int i = 0; i < tables.length; i++){

				++rowCount;

				table = tables[i];
				where = wheres[i];
				title = titles[i];

				// count records
				if (distinct[i].equals(Constant.BLANK)){
					rowsAffected = (int)AseUtil.countRecords(conn,table,where);
				}
				else{
					rowsAffected = (int)AseUtil.countDistinct(conn,distinct[i],table,where);
				}

				// set alternating row colors
				if (rowCount % 2 == 0){
					bgColor = Constant.ODD_ROW_BGCOLOR;
				}
				else{
					bgColor = Constant.EVEN_ROW_BGCOLOR;
				}

				// display passed/failed image
				image = "check1";
				if (required[i].equals(Constant.ON) && rowsAffected == 0){
					image = "warning";
				}

				// display required or not
				require = "NO";
				if (required[i].equals(Constant.ON)){
					require = "YES";
				}

				output.append("<tr bgcolor=\""+bgColor+"\">"
								+ "<td class=\"datacolumn\">" + title + "</td>"
								+ "<td class=\"datacolumn\">" + require + "</td>"
								+ "<td class=\"datacolumn\">" + rowsAffected + "</td>"
								+ "<td>" + "<img src=\"../images/" + image + ".gif\" border=\"0\"" + "</td>"
								+ "</tr>");
			}

			table = "tblINI";
			String sql = "SELECT cm.Question_Ini "
				+ "FROM tblCourseQuestions cq INNER JOIN "
				+ "CCCM6100 cm ON cq.questionnumber = cm.Question_Number "
				+ "AND cq.type = cm.type "
				+ "WHERE (cq.campus=?)  "
				+ "AND (cq.type='Course')  "
				+ "AND (cq.include='Y') "
				+ "AND (cm.campus='SYS')  "
				+ "AND (cm.Question_Ini IS NOT NULL AND cm.Question_Ini <> '')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String ini = AseUtil.nullToBlank(rs.getString("Question_Ini"));

				where = "WHERE campus='"+campus+"' AND category='"+ini+"'";

				rowsAffected = (int)AseUtil.countRecords(conn,table,where);

				if (rowsAffected > 0){

					++rowCount;

					if (rowCount % 2 == 0)
						bgColor = Constant.ODD_ROW_BGCOLOR;
					else
						bgColor = Constant.EVEN_ROW_BGCOLOR;

					output.append("<tr bgcolor=\""+bgColor+"\">"
									+ "<td class=\"datacolumn\">" + ini + "</td>"
									+ "<td class=\"datacolumn\">YES</td>"
									+ "<td class=\"datacolumn\">" + rowsAffected + "</td>"
									+ "<td>" + "<img src=\"../images/check1.gif\" border=\"0\"" + "</td>"
									+ "</tr>");
				}
			} // while
			rs.close();
			ps.close();

			output.append("</table>");
		}
		catch(SQLException e){
			logger.fatal("configureCC: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("configureCC: " + e.toString());
		}

		return output.toString();

	}

}