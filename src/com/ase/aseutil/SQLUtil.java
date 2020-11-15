/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 * String createHistoryID(int type)
 *	public static String createCSV(Connection conn,String campus) {
 *	public static synchronized String encode(String s) {
 *	public static boolean isSysAdmin(Connection,user)
 *	public static boolean isCampusAdmin(Connection,user)
 *	public static boolean isCCChair(Connection,user)
 *	public static String removeJavaScriptTags(String content) throws Exception {
 *	public static String[] resultSetToArray(Connection conn,String sql,String[] prms,String[] dt) throws Exception {
 *	public static String resultSetToCSV(Connection conn,String sql,String key) throws Exception {
 *	public static synchronized String getHtmlRows(ResultSet results) throws SQLException {
 *	public static String showUserLog(Connection conn,String,String,String,String,String,String) {
 *	public static String verifySQL(Connection conn,String prop,boolean debug) {
 *
 */

package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.paging.Paging;

public class SQLUtil {

	static Logger logger = Logger.getLogger(SQLUtil.class.getName());
	static String ASE_PROPERTIES = "ase.central.Ase";

	static final int UNDEFINT = Integer.MIN_VALUE;
	static final int adText 		= 1;
	static final int adDate 		= 2;
	static final int adNumber 		= 3;
	static final int adSearch_ 	= 4;
	static final int ad_Search_ 	= 5;

	public static synchronized String getHtmlRows(ResultSet results) throws SQLException {

		StringBuffer htmlRows = new StringBuffer();
		ResultSetMetaData metaData = results.getMetaData();
		int columnCount = metaData.getColumnCount();

		htmlRows.append("<tr>");
		for (int i = 1; i <= columnCount; i++)
			htmlRows.append("<td><b>" + metaData.getColumnName(i) + "</td>");
		htmlRows.append("</tr>");

		while (results.next()) {
			htmlRows.append("<tr>");
			for (int i = 1; i <= columnCount; i++)
				htmlRows.append("<td>" + results.getString(i) + "</td>");
		}
		htmlRows.append("</tr>");

		return htmlRows.toString();
	}

	public static synchronized String encode(String s) {
		if (s == null)
			return s;
		StringBuffer sb = new StringBuffer(s);
		for (int i = 0; i < sb.length(); i++) {
			char ch = sb.charAt(i);
			if (ch == 39) { // 39 is the ASCII code for an apostrophe
				sb.insert(i++, "'");
			}
		}
		return sb.toString();
	}

	/*
	 * verifySQL	- verify that our property file contains valid SQL statement
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	prop		String
	 *	@param	debug		boolean
	 *	<p>
	 *	@return	String
	 */
	public static String verifySQL(Connection conn,String prop,boolean debug) {

		StringBuffer contents = new StringBuffer();
		StringBuffer results = new StringBuffer();
		String index = "";
		String comment = "";
		int success = 0;
		int failure = 0;
		int total = 0;
		int skipped = 0;

		try {
			AseUtil aseUtil = new AseUtil();

			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);

			File aFile = new File(currentDrive + ":\\tomcat\\webapps\\central\\props\\ase\\central\\AseQueries" + prop + ".properties");

			BufferedReader input = new BufferedReader(new FileReader(aFile));

			try {
				String line = null; // not declared within while loop
				int i = 0;
				while ((line = input.readLine()) != null) {
					++total;

					comment = line.substring(0,1);
					index = line.substring(0,line.indexOf("="));

					if (!"#".equals(comment)){
						line = line.toLowerCase();
						line = line.substring(line.indexOf("=")+1);
						line = line.replace("%_index_%","A%");
						line = line.replace("%_campus_%","LEE%");
						line = line.replace("campus=?","campus=\'LEE\'");
						line = line.replace("_alpha_","ICS");
						line = line.replace("coursealpha=?","coursealpha=\'ICS\'");
						line = line.replace("_num_","241");
						line = line.replace("coursenum=?","coursenum=\'241\'");
						line = line.replace("_sql_","LEE");
						line = line.replace("_type_","PRE");
						line = line.replace("coursetype=?","coursetype=\'PRE\'");
						line = line.replace("_camp_","LEE");
						line = line.replace("_coursetype_","PRE");
						line = line.replace("_campus_","LEE");
						line = line.replace("_submittedfor_",Constant.SYSADM_NAME);
						line = line.replace("_coursetype_","PRE");
						line = line.replace("_coursetype_","PRE");
						line = line.replace("_historyID_","200810607");

						try{
							Statement s = conn.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
							ResultSet rs = s.executeQuery(line);
							if (rs.next()){
								rs.last();
								int count = rs.getRow();
								contents.append(i + ": " + index + " (" + count + ")<br>");
								contents.append(System.getProperty("line.separator"));
								++success;
							}
							else{
								contents.append(i + ": <b>" + index + "</b>&nbsp;(0)<br>");
								++success;
							}
							rs.close();
							s.close();
						}
						catch(SQLException se){
							contents.append(i + ": " + index + se.toString() + "<br>");
							++failure;
						}
						catch(Exception xse){
							contents.append(i + ": " + index + xse.toString() + "<br>");
							++failure;
						}
					}
					else{
						contents.append(i + ": <b>" + index + "</b><br>");
						++skipped;
					}	// if

					++i;

				} // while
			} finally {
				input.close();
			}
		} catch (IOException ex) {
			contents.append(ex.toString());
		} catch (Exception e) {
			contents.append(e.toString());
		}

		if (debug){
			contents.setLength(0);
			contents.append("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\"><td colspan=\"2\" class=\"textblackTH\">" + prop + " Driver</td></tr>" +
						"<tr height=\"30\"><td width=\"15%\" class=\"textblackTH\">Total</td><td class=\"datacolumn\">" + total + "</td></tr>" +
						"<tr height=\"30\"><td width=\"15%\" class=\"textblackTH\">Success</td><td class=\"datacolumn\">" + success + "</td></tr>" +
						"<tr height=\"30\"><td width=\"15%\" class=\"textblackTH\">Failure</td><td class=\"datacolumn\">" + failure + "</td></tr>" +
						"<tr height=\"30\"><td width=\"15%\" class=\"textblackTH\">Skipped</td><td class=\"datacolumn\">" + skipped + "</td></tr>" +
						"</table>");
		}

		return contents.toString();
	}

	/*
	 * createHistoryID
	 * <p>
	 * @param	type	int
	 * <p>
	 * @return String
	 */
	public static synchronized String createHistoryID(int type) throws Exception {

		/*
			effort to create id without a duplicate. Duplicates happen when requests
			come through so quick that the timer doesn't change fast enough.

			if a connection was not available, we'll create one the old fashion way.
		*/

		boolean duplicate = false;

		String kix = "";

		AsePool connectionPool = AsePool.getInstance();

		Connection conn = null;

		try{
			conn = connectionPool.getConnection();

			if (conn != null){
				kix = createHistoryID(type,0);

				duplicate = isMatch(conn,kix);

				while(duplicate){
					kix = SQLUtil.createHistoryID(type,0);
					duplicate = isMatch(conn,kix);
				}
			}
			else
				kix = SQLUtil.createHistoryID(type,0);
		}
		catch(Exception e){
			logger.fatal("SQLUtil - createHistoryID: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"SQLUtil","");
		}

		return kix;
	}

	public static boolean isMatch(Connection conn,String kix) throws SQLException {

		String sql = "SELECT historyid FROM tblCourse WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();

		return exists;
	}

	/*
	 * createHistoryID
	 * <p>
	 * @param	type	int
	 * <p>
	 * @return String
	 */
	public static synchronized String createHistoryID(int type,int ignoreThisArg) throws Exception {

		String historyID = "";
		String alpha = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
		String[] alphaArray = alpha.split(",");

		int year = 0;
		int year2 = 0;
		int month = 0;
		int day = 0;
		int hour = 0;
		int min = 0;
		int sec = 0;

		try {
			Calendar cal = new GregorianCalendar();
			year = cal.get(Calendar.YEAR); 			// 2002
			year2 = year - 2000;
			month = cal.get(Calendar.MONTH) + 1; 	// 0=Jan, 1=Feb, ...
			day = cal.get(Calendar.DAY_OF_MONTH); 	// 1...
			hour = cal.get(Calendar.HOUR);
			min = cal.get(Calendar.MINUTE);
			sec = cal.get(Calendar.SECOND);

			Random generator = new Random(hour*min*sec);
			int r = generator.nextInt(256) + 1;

			switch(type){
				case 1:
					historyID = "" + alphaArray[sec] + min + alphaArray[hour] + day + alphaArray[month] + year2 + r;
					break;
				case 2:
					UUID uuid = UUID.randomUUID();
					historyID = "" + uuid;
					break;
				case 3:
					historyID = "" + System.currentTimeMillis();
					break;
				case 4:
					historyID = "" + alphaArray[year2] + alphaArray[month] + alphaArray[day] + alphaArray[hour] + alphaArray[min] + alphaArray[sec];
					break;
				case 5:
					historyID = "" + year + month + day + hour + min + sec;
					break;
				case 6:
					historyID = "" + year2 + month + day + hour + min + sec;
					break;
				default:
					historyID = "" + alphaArray[sec] + min + alphaArray[hour] + day + alphaArray[month] + year2 + r;
			}
		} catch (Exception e) {
			logger.fatal("SQLUtil: createHistoryID\n" + e.toString());
			historyID = "";
		}

		return historyID;
	}

	/*
	 * showUserLog
	 * <p>
	 * @param	Connection	conn
	 * @param	String		year
	 * @param	String		month
	 * @param	String		day
	 * @param	String		hour
	 * @param	String		minute
	 * @param	String		minute
	 * @param	String		message
	 * @param	HttpServletRequest		request
	 * @param	HttpServletResponse		response
	 * <p>
	 * @return String
	 */
	public static String showUserLog(Connection conn,
												String year,
												String month,
												String day,
												String hour,
												String minute,
												String message,
												HttpServletRequest request,
												HttpServletResponse response) throws Exception {

		String temp = "";
		String select = "";
		String from = "";
		String where = "";
		String orderBy = "";
		String sql = "";

		HttpSession session = request.getSession(true);
		AseUtil aseUtil = new AseUtil();

		select = "SELECT id,[Date],Message ";
		from = "FROM jdbclog ";
		where = "WHERE id > 0 ";
		orderBy = "ORDER BY [date]";

		if (!"".equals(year)){
			where = where + " AND year([date])="+year;
		}

		if (!"".equals(month)){
			where = where + " AND month([date])="+month;
			orderBy = orderBy + ",month([date])";

			if (!"".equals(day)){
				where = where + " AND day([date])="+day;
				orderBy = orderBy + ",day([date])";

				if (!"".equals(hour)){
					where = where + " AND {fn HOUR([date])}="+hour;
					orderBy = orderBy + ",{fn HOUR([date])}";

					if (!"".equals(minute)){
						where = where + " AND {fn MINUTE([date])}="+minute;
						orderBy = orderBy + ",{fn MINUTE([date])}";
					}
				}
			}
		}

		if (!"".equals(message))
			where = where + " AND message like '%" + message + "%'";

		sql = select + " " + from + " " +  where + " " +  orderBy;

		Paging paging = new com.ase.paging.Paging();
		paging.setSQL(sql);
		paging.setDetailLink("/central/core/crslg.jsp?y=");
		paging.setAllowAdd(false);
		paging.setRecordsPerPage(99);
		temp = paging.showRecords(conn,request,response);
		paging = null;

		return temp;
	}

	/*
	 * showUserLog
	 * <p>
	 * @param	conn
	 * @param	dte
	 * @param	message
	 * @param	request
	 * @param	response
	 * <p>
	 * @return String
	 */
	public static String showUserLog(Connection conn,
												String priority,
												String dte,
												String message,
												HttpServletRequest request,
												HttpServletResponse response) throws Exception {

		String temp = "";
		String select = "";
		String from = "";
		String where = "";
		String orderBy = "";
		String sql = "";

		HttpSession session = request.getSession(true);
		AseUtil aseUtil = new AseUtil();

		select = "SELECT id, priority, CAST([date] AS varchar(20)) AS dte,Message ";
		from = "FROM jdbclog ";
		where = "WHERE id > 0 ";
		orderBy = "ORDER BY id";

		if (!"".equals(priority))
			where = where + " AND priority = '" + priority + "'";

		if (!"".equals(dte))
			where = where + " AND CAST([date] AS varchar(20)) like '%" + dte + "%'";

		if (!"".equals(message))
			where = where + " AND message like '%" + message + "%'";

		sql = select + " " + from + " " +  where + " " +  orderBy;

		Paging paging = new com.ase.paging.Paging();
		paging.setSQL(sql);
		paging.setDetailLink("/central/core/crslg.jsp?y=");
		paging.setAllowAdd(false);
		paging.setRecordsPerPage(99);
		temp = paging.showRecords(conn,request,response);
		paging = null;

		return temp;
	}

	/*
	 * isCampusAdmin
	 *	<p>
	 * @param	conn	Connection
	 * @param	user	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean isCampusAdmin(Connection conn,String user) throws Exception {

		boolean campusAdmin = false;

		try {
			if(user != null){
				String sql = "SELECT userid FROM tblUsers WHERE userid=? AND userlevel=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,user);
				ps.setInt(2,Constant.CAMPADM);
				ResultSet rs = ps.executeQuery();
				campusAdmin = rs.next();
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("SQLUtil.isCampusAdmin: " + e.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil.isCampusAdmin: " + e.toString());
		}

		return campusAdmin;
	}

	/*
	 * isSysAdmin
	 *	<p>
	 * @param	conn	Connection
	 * @param	user	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean isSysAdmin(Connection conn,String user) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean systemAdmin = false;

		try {
			if(user != null){
				String sql = "SELECT userid FROM tblUsers WHERE userid=? AND userlevel=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,user);
				ps.setInt(2,Constant.SYSADM);
				ResultSet rs = ps.executeQuery();
				systemAdmin = rs.next();
				rs.close();
				ps.close();
			}
		} catch (SQLException se) {
			logger.fatal("SQLUtil: isSysAdmin\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: isSysAdmin\n" + e.toString());
		}

		return systemAdmin;
	}

	/*
	 * isCCChair
	 *	<p>
	 * @param	conn	Connection
	 * @param	user	String
	 *	<p>
	 * @return boolean
	 */
	public static boolean isCCChair(Connection conn,String user) throws Exception {

		boolean ccChair = false;

		try {
			String sql = "SELECT userid FROM tblUsers WHERE userid=? AND position like '%CURRICULUM COMMITTEE CHAIR%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			ccChair = rs.next();
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("SQLUtil: isCCChair\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: isCCChair\n" + e.toString());
		}

		return ccChair;
	}

	/*
	 * resultSetToArray
	 *	<p>
	 * @param	conn	Connection
	 * @param	sql	String
	 * @param	prms	String[]
	 * @param	dt		String[]
	 *	<p>
	 * @return String[]
	 */
	public static String[] resultSetToArray(Connection conn,String sql,String[] prms,String[] dt) throws Exception {

		return resultSetToArray(conn,sql,prms,dt,"");
	}

	/*
	 * resultSetToArray
	 *	<p>
	 * @param	conn	Connection
	 * @param	sql	String
	 * @param	prms	String[]
	 * @param	dt		String[]
	 * @param	kix	String
	 *	<p>
	 * @return String[]
	 */
	public static String[] resultSetToArray(Connection conn,String sql,String[] prms,String[] dt,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String rtn[] = null;
		int numRows = 0;
		int i = 0;

		try {
			// prepare statement with parameters
			// with result set, get number of rows then convert to array
			PreparedStatement ps = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			for(i=0;i<prms.length;i++){
				if ("s".equals(dt[i])){
					ps.setString((i+1),prms[i]);
				}
				else{
					ps.setInt((i+1),Integer.parseInt(prms[i]));
				}
			}

			// read and place data into array
			i = 0;
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				rs.last();
				numRows = rs.getRow();
				rs.beforeFirst();
				rtn = new String[numRows];
				while (rs.next()) {
					rtn[i++] = AseUtil.nullToBlank(rs.getString(1));
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SQLUtil.resultSetToArray ("+kix+"): " + e.toString() + "; sql: " + sql);
		} catch (Exception e) {
			logger.fatal("SQLUtil.resultSetToArray ("+kix+"): " + e.toString() + "; sql: " + sql);
		}

		return rtn;
	}

	/*
	 * resultSetToArray - convert a result set into an array of data
	 *	<p>
	 * @param	rs				ResultSet
	 * @param	dataType		String[]
	 *	<p>
	 * @return String[]
	 */
	public static String[] resultSetToArray(ResultSet rs,String[] dataType) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String rtn[] = null;
		int i = 0;
		int j = 0;

		try {
			if (rs != null && dataType != null){
				rtn = new String[dataType.length];
				for (i=0;i<dataType.length;i++){
					if ("s".equals(dataType[i]))
						rtn[i] = AseUtil.nullToBlank(rs.getString(++j));
					else if ("i".equals(dataType[i]))
						rtn[i] = NumericUtil.intToString(rs.getInt(++j));
					else
						rtn[i] = AseUtil.nullToBlank(rs.getString(++j));
				}
			} // (rs != null && dataType != null)
		} catch (SQLException se) {
			logger.fatal("SQLUtil: resultSetToArray - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: resultSetToArray - " + e.toString());
		}

		return rtn;
	}

	/*
	 * resultSetToVector
	 *	<p>
	 * @param	conn	Connection
	 * @param	sql	String
	 * @param	prms	String[]
	 * @param	dt		String[]
	 *	<p>
	 * @return ArrayList
	 */
	public static ArrayList resultSetToVector(Connection conn,String sql,String[] prms,String[] dt) throws Exception {

		//Logger logger = Logger.getLogger("test");

		ArrayList<Generic> list = new ArrayList<Generic>();
		int numRows = 0;
		int i = 0;

		try {
			// prepare statement with parameters
			// with result set, get number of rows then convert to array
			PreparedStatement ps = conn.prepareStatement(sql);
			for(i=0;i<prms.length;i++){
				if ("s".equals(dt[i]))
					ps.setString((i+1),prms[i]);
				else
					ps.setInt((i+1),Integer.parseInt(prms[i]));
			}

			// read and place data into array
			i = 0;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Generic generic = new Generic();
				generic.setString1(AseUtil.nullToBlank(rs.getString(1)));
				generic.setString2(AseUtil.nullToBlank(rs.getString(2)));
				list.add(generic);
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("SQLUtil: resultSetToVector - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: resultSetToVector - " + e.toString());
		}

		return list;
	}

	/*
	 * createCSV
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String
	 */
	public static String createCSV(Connection conn,String campus) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int i = 0;
		String[] col = null;
		StringBuffer data = new StringBuffer();

		try {
			AseUtil aseUtil = new AseUtil();
			WebSite website = new WebSite();
			String temp = "";
			String delimiter = ",";
			String sql = "SELECT * "
				+ "FROM tblINI "
				+ "WHERE campus=? AND "
				+ "category='MethodEval' "
				+ "ORDER BY seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ResultSet rs = ps.executeQuery();

			// figure out column names
			ResultSetMetaData rsmd = rs.getMetaData();
			col = new String[rsmd.getColumnCount()];
			for(i=0;i<rsmd.getColumnCount();i++){
				col[i] = rsmd.getColumnLabel(i + 1);
			}

			// go through all columns and format
			while (rs.next()){
				for(i=0;i<rsmd.getColumnCount();i++){
					temp = website.clearHTMLTags(aseUtil.nullToBlank(rs.getString(col[i])));
					if (i==0)
						data.append(temp);
					else
						data.append(delimiter + temp);
				}
				data.append("<br/>");
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SQLUtil - createCSV: " + e.toString());
		} catch (Exception ex) {
			logger.fatal("SQLUtil - createCSV: - " + ex.toString());
		}

		return data.toString();
	}

	/*
	 * completeSQLParms
	 * <p>
	 * @param	conn	Connection
	 * @param	sql	String
	 * @param	kix	String
	 */
	public static String completeSQLParms(Connection conn,String sql,String kix) {

		//Logger logger = Logger.getLogger("test");

		String temp = "";

		try{

			String[] info = Helper.getKixInfo(conn,kix);
			String as = "coursealpha,coursenum,coursetype,proposer,campus,historyid";
			String a[] = as.split(",");
			int i = 0;
			int il = 0;

			il = a.length;

			sql = sql.replace("SET historyid=?","SET historyid='" + kix + "'");
			sql = sql.replace("WHERE historyid=?","WHERE historyid='" + kix + "'");
			sql = sql.replace("OR historyid=?","OR historyid='" + kix + "'");

			for (i=0;i<il;i++){
				temp = a[i]+"=?";
				sql = sql.replace(temp,info[i]);
			}

		}
		catch(Exception e){
			logger.fatal("completeSQLParms - " + e.toString());
		}

		return sql;
	}

	/*
	 * resultSetToCSV - resultset returning 1 column that is returned as CSV
	 *							a single key value is allowed (campus, kix, etc)
	 *	<p>
	 * @param	conn	Connection
	 * @param	sql	String
	 * @param	key	String
	 *	<p>
	 * @return String
	 */
	public static String resultSetToCSV(Connection conn,String sql,String key) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			if (key!=null && key.length()>0){
				ps.setString(1,key);
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if ((Constant.BLANK).equals(csv))
					csv = AseUtil.nullToBlank(rs.getString(1));
				else
					csv = csv + "," + AseUtil.nullToBlank(rs.getString(1));
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("SQLUtil: resultSetToCSV - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: resultSetToCSV - " + e.toString());
		}

		return csv;
	}


	/*
	 * resultSetToCSV - resultset returning 1 column that is returned as CSV
	 *	<p>
	 * @param	rs		ResultSet
	 *	<p>
	 * @return String
	 */
	public static String resultSetToCSV(ResultSet rs) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String csv = "";

		try {
			while (rs.next()) {
				if (csv.equals(Constant.BLANK)){
					csv = AseUtil.nullToBlank(rs.getString(1));
				}
				else{
					csv = csv + "," + AseUtil.nullToBlank(rs.getString(1));
				}
			}
			rs.close();

		} catch (SQLException e) {
			logger.fatal("SQLUtil: resultSetToCSV - " + e.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: resultSetToCSV - " + e.toString());
		}

		return csv;
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

	/*
	 * removeJavaScriptTags - remove script tags from content
	 *	<p>
	 * @param	content	String
	 *	<p>
	 * @return String
	 */
	 public static Msg sqlSchema(){

		//Logger logger = Logger.getLogger("test");

		boolean debug = true;

		Msg msg = new Msg();

		AsePool connectionPool = null;
		Connection conn = null;

		int rowsAffected = 0;

		String table = "";
		String type = "";
		String column = "";
		String datatype = "";
		int length = 0;
		int id = 0;

		try{
			if (debug) logger.info("-------------------- sqlSchema - START");

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			PreparedStatement ps2 = null;
			ResultSet rs2 = null;

			/*
				1) Start with collection of tables (type = U for tables; V for views; K for index)
				2) Use table to get collection of columns
				3) if not table, then it's a view

				the index SQL is not correct. Need to understand where the code is stored
			*/

			String sql = "SELECT id,name,rtrim(type) as [type] "
							+ "FROM sysobjects "
							+ "WHERE type='K' "
							+ "OR type='U' "
							+ "OR type='V' "
							+ "ORDER BY name, type";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				table = rs.getString("name");
				type = rs.getString("type");
				id = rs.getInt("id");

				if ("K".equals(type.substring(0))){
					sql = "SELECT text FROM syscomments WHERE id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,id);
					rs2 = ps2.executeQuery();
					if(rs2.next()){
						System.out.println(rs2.getString(1));
					}
					rs2.close();
					ps2.close();
				}
				else if ("U".equals(type.substring(0))){
					sql = "SELECT so.name, sc.name AS [column], systypes.name AS datatype, sc.length "
						+ "FROM syscolumns sc INNER JOIN sysobjects so ON sc.id = so.id "
						+ "INNER JOIN systypes ON sc.xtype = systypes.xtype "
						+ "WHERE (so.xtype='U' OR so.xtype='S')  "
						+ "AND (so.name=?) "
						+ "ORDER BY so.name, sc.name";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,table);
					rs2 = ps2.executeQuery();
					while(rs2.next()){
						column = rs2.getString("column");
						datatype = rs2.getString("datatype");
						length = rs2.getInt("length");
						//System.out.println(table + " - " + type + " - " + column + " - " + datatype + " - " + length);
					}
					rs2.close();
					ps2.close();
				}
				else if ("V".equals(type.substring(0))){
					sql = "SELECT text FROM syscomments WHERE id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,id);
					rs2 = ps2.executeQuery();
					if(rs2.next()){
						//System.out.println(rs2.getString(1));
					}
					rs2.close();
					ps2.close();
				}
			}
			rs.close();
			ps.close();

			if (debug) logger.info("-------------------- sqlSchema - END");
		}
		catch( SQLException e ){
			logger.fatal("SQLUtil: sqlSchema - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("SQLUtil: sqlSchema - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			connectionPool.freeConnection(conn,"SQLUtil","SYSADM");
		}

		return msg;
	}

	/*
	 * executeCQL
	 *	<p>
	 * @param	conn
	 * @param	sql
	 *	<p>
	 * @return int
	 */
	 public static int executeCQL(Connection conn,String sql,boolean writeXML,String user){

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		boolean run = false;

		ResultSet rs = null;

		try{

			boolean isSysadm = SQLUtil.isSysAdmin(conn,user);

			if(isSysadm){

				logger.info("-------------------- executeCQL - START");

				// updates and deletes don't come back with recordsets to work with
				if (	sql.toLowerCase().startsWith("alter") ||
						sql.toLowerCase().startsWith("delete") ||
						sql.toLowerCase().startsWith("update")
						){
					run = true;
				}

				PreparedStatement ps = conn.prepareStatement(sql);

				if (run){
					rowsAffected = ps.executeUpdate();
				}
				else{
					rs = ps.executeQuery();

					if(rs.next()){

						if (writeXML){
							rowsAffected = 1;

							ResultSetMetaData rsmd = rs.getMetaData();

							int numberOfColumns = rsmd.getColumnCount();

							String columnName = "";

							String temp = "";

							String fileName = AseUtil.getCurrentDrive()
												+ ":"
												+ SysDB.getSys(conn,"documents")
												+ "outlines\\"
												+ "xml.xml";

							FileWriter fstream = new FileWriter(fileName);

							BufferedWriter output = new BufferedWriter(fstream);

							output.write("<CC>\n");

							do{
								output.write("\t<record>\n");

								for (int i = 0; i < numberOfColumns; i++) {

									columnName = rsmd.getColumnName(i + 1);

									temp = AseUtil.nullToBlank(rs.getString(columnName));

									if (columnName == null || columnName.length() == 0){
										columnName = "column";
									}

									output.write("\t\t<" + columnName + ">" + temp + "</" + columnName + ">\n");

								} // for

								output.write("\t</record>\n");

							} while (rs.next());

							output.write("</CC>\n");

							output.close();

							fstream = null;
						}
						else{
							rowsAffected = 1;
						} // writeXML

					} // if rs

					rs.close();
				} // if run

				ps.close();

				logger.info("-------------------- executeCQL - END");

			}
			else{
				//
			}	// isSysadm

		}
		catch( SQLException e ){
			logger.fatal("SQLUtil: executeCQL - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("SQLUtil: executeCQL - " + e.toString());
		}
		finally{
		}

		return rowsAffected;
	} // SQLUtil: executeCQL

	/*
	 * hasAccess
	 *	<p>
	 * @param	conn	Connection
	 * @param	user	String
	 * @param	level	int
	 *	<p>
	 * @return boolean
	 */
	public static boolean hasAccess(Connection conn,String user,int level) throws Exception {

		boolean userHasAccess = false;

		try {
			String sql = "SELECT count(userid) as counter FROM tblUsers WHERE userid=? AND userlevel>=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ps.setInt(2,level);
			ResultSet rs = ps.executeQuery();
			if (rs.next() && rs.getInt("counter") > 0){
				userHasAccess = true;
			}
			rs.close();
			ps.close();

		} catch (SQLException se) {
			logger.fatal("SQLUtil: hasAccess - " + se.toString());
		} catch (Exception e) {
			logger.fatal("SQLUtil: hasAccess -" + e.toString());
		}

		return userHasAccess;
	}

	/**
	*	SAME set of calls as found in AseUtil. More appropriate here (START)
	**/

	/**
	 * @return String
	 */
	public static String toSQL(String value, int type) {

		String param = value;

		if (value == null){
			return "Null";
		}

		if (param.equals(Constant.BLANK) && (type == adText || type == adDate)) {
			return "Null";
		}

		switch (type) {
			case adText: {
				param = replace(param, "'", "''");
				param = replace(param, "&amp;", "&");
				param = "'" + param + "'";
				break;
			}
			case adSearch_:
			case ad_Search_: {
				param = replace(param, "'", "''");
				break;
			}
			case adNumber: {
				try {
					if (!isNumber(value) || "".equals(param))
						param = "null";
					else
						param = value;
				} catch (NumberFormatException nfe) {
					param = "null";
				}
				break;
			}
			case adDate: {
				param = "'" + param + "'";
				break;
			}
		}
		return param;
	}

	/**
	 * returns true if the int argument is empty
	 */
	public static boolean isEmpty(int val) {
		return val == UNDEFINT;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static boolean isEmpty(String val) {
		return (val == null || val.equals("") || val.equals(Integer
				.toString(UNDEFINT)));
	}

	/**
	 * returns true if the String value is a number
	 */
	public static boolean isNumber(String param) {

		boolean result;

		if (param == null || param.equals(""))
			return true;

		param = param.replace('d', '_').replace('f', '_');

		try {
			Double dbl = new Double(param);
			result = true;
		} catch (NumberFormatException nfe) {
			result = false;
		}

		return result;
	}

	/**
	 * @return String
	 */
	public static String replace(String str, String pattern, String replace) {

		if (replace == null) {
			replace = "";
		}

		int s = 0, e = 0;
		StringBuffer result = new StringBuffer((int) str.length() * 2);

		while ((e = str.indexOf(pattern, s)) >= 0) {
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}

		result.append(str.substring(s));

		return result.toString();
	}

	/**
	*	SAME set of calls as found in AseUtil. More appropriate here (END)
	**/


}