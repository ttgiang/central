/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 * String addToDate(int numberOfDays)
 *	String ASE_FormatCurrency(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
 *	String ASE_FormatDateTime(java.sql.Date date, int ANamedFormat){
 *	String ASE_FormatDateTime(Object ADate, int ANamedFormat){
 *	String ASE_FormatDateTime(Object ADate, int ANamedFormat,Locale locale){
 *	String ASE_FormatDateTime(String date, int ANamedFormat){
 *	String ASE_FormatNumber(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
 *	String ASE_FormatPercent(Object obj, int numDigitsAfterDecimal, int includeLeadingDigit,
 *	String ASE_GetFileType(String contentType)
 *	void absolute(java.sql.ResultSet rs, int row)
 *	String checkLoggedIn( javax.servlet.http.HttpSession session, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpServletRequest request)
 *	String checkSecurity( javax.servlet.http.HttpSession session, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpServletRequest request)
 *	String checkSecurityLevel(int iLevel, javax.servlet.http.HttpSession session, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpServletRequest request)
 * String copyright()
 *	long countRecords(java.sql.Connection conn, String table, String where)
 *	connection cn(String strConn, String username, String password)
 *	public static String createSelectionBoxWithRange(String controlName,
 *																		int start,
 *																		int end,
 *																		boolean required,
 *																		int defaultValue) {
 *	long dbMaxValue(java.sql.Connection conn, String table, String fieldName, String where)
 *	String drawHTMLField(Connection conn,String fieldType,String fieldRef,String fieldName,String fieldValue,int fieldLen,int fieldMax,boolean required)
 *	String emptyOrNullToBlank(String str)
 *	String getCheckBoxValue (String val, String checkVal, String uncheckVal, int ctype)
 * static java.sql.Date getCurrentDate()
 * static String getCurrentDateString()
 *	static String getCurrentDateTimeString()
 *	String getCurrentDirectory()
 *	String getCurrentDrive()
 *	String getDateFormatString(String s){
 *	String getDebugMode(){
 *	String getDriverType(){
 *	String[] getFieldNames( java.sql.ResultSet rs )
 *	String getLogFile(){
 *	String getLoggerLocation(){
 *	String getOptions( java.sql.Connection conn, String sql, boolean isSearch, boolean isRequired, String selectedValue )
 *	String getOptionsLOV( String sLOV, boolean isSearch, boolean isRequired, String selectedValue )
 *	String getOS(){
 *	String getParam(javax.servlet.http.HttpServletRequest req, String paramName)
 *	String getPropertySQL(javax.servlet.http.HttpSession session, String props)
 *	Hashtable getRecordToHash ( java.sql.ResultSet rs, java.util.Hashtable rsHash, String[] aFields )
 *	String getSessionValue(String sessName)
 *	public static String getTestSystem() {
 *	String getTraceFile(){
 *	String getValue(java.sql.ResultSet rs, String strFieldName)
 *	String getValue(java.sql.ResultSet rs, int fieldPosition)
 *	String getValueOrBlank(java.sql.ResultSet rs, String strFieldName)
 *	String getValueHTML(java.sql.ResultSet rs, String fieldName)
 *	String getValFromLOV( String selectedValue , String sLOV)
 *	String getXMLSchemas
 *	public static String HTMLEncode(String s) {
 *	boolean isDate(String s){
 *	boolean isDate(String s, String dateFormat){
 *	boolean isDate(String s, String dateFormat, Locale locale){
 *	boolean isEmpty (int val)
 *	boolean isEmpty (String val)
 *	boolean isNumber (String param)
 *	boolean isNumeric(Object s){
 *	public String join(String[] aryString){
 *	static String loadDriver ()
 *	void logAction( Connection conn,String userid,String script,String action,String alpha,String num,String campus)
 *	void loggerInfo(String p1)
 *	void loggerInfo(String p1, String p2, String p3, String p4, String p5)
 *	void logMail( Connection conn, Mailer mailer,int processed)
 *	String lookUp(java.sql.Connection conn, String table, String fieldName, String where)
 *	String lookUpX(java.sql.Connection conn, String table, String fieldName, String where)
 *	String nullToBlank (String val)
 *	String nullToBlank (int val)
 *	String nullToBlank (java.util.Date val)
 *	String nullToBlank (boolean val)
 *	ResultSet openRecordSet(java.sql.Statement stmt, String sql)
 *	Vector openRecordSet(java.sql.Statement stmt, String sql, int column)
 *	String proceedError(javax.servlet.http.HttpServletResponse response, Exception e)
 *	String replace(String str, String pattern, String replace)
 *	boolean sendMail()
 *	ASE_UnFormatDateTime(String ADate,String dateFormat, Locale locale){
 *	String toHTML(String value)
 *	String toSQL(String value, int type)
 *	String toURL(String strValue)
 *	String toWhereSQL(String fieldName, String fieldVal, int type)
 *	int updateQuestionRecords(java.sql.Connection conn,String no,String type,String campus,String question)
 */

package com.ase.aseutil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Vector;

import javax.servlet.ServletException;

import org.apache.log4j.Logger;

public class AseUtil {

	static Logger logger = Logger.getLogger(AseUtil.class.getName());
	static final String CRLF = "\r\n";
	static final int UNDEFINT = Integer.MIN_VALUE;

	static final int adText 		= 1;
	static final int adDate 		= 2;
	static final int adNumber 		= 3;
	static final int adSearch_ 	= 4;
	static final int ad_Search_ 	= 5;

	static final String appPath = "/";
	static final String DBDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
	static final String strConn = "jdbc:odbc:cc";
	static final String DBusername = "";
	static final String DBpassword = "";
	final String ASE_DATE_SEPARATOR = "/";

	private static final char c[] = { '<', '>', '&', '\"' };
	private static final String expansion[] = { "&lt;", "&gt;", "&amp;", "&quot;" };

	/**
	 * security constants
	 */
	public static final int USER 		= 0;
	public static final int FACULTY 	= 1;
	public static final int CAMPADM 	= 2;
	public static final int SYSADM 	= 3;

	/**
	 * auto complete constants
	 */
	public static final int ALPHA 							= 0;
	public static final int ALPHA_NUMBER 					= 1;
	public static final int NUMBER 							= 2;
	public static final int NUMBER_ALPHA 					= 3;
	public static final int SHORT_ALPHA 					= 4;
	public static final int ALPHA_NUMBER_LIMIT_PREREQ 	= 5;
	public static final int ALPHA_NUMBER_LIMIT_XLIST	= 6;
	public static final int PROGRAM							= 7;
	public static final int DEGREE							= 8;
	public static final int DEPARTMENT						= 9;
	public static final int DIVISION_BANNER				= 10;

	public AseUtil() throws IOException, ServletException {}

	/**
	 * Move absolute to a cursor location
	 * <p>
	 *
	 * @param rs
	 *            java.sql.ResultSet
	 * @param row
	 *            int row to move to
	 */
	public static void absolute(java.sql.ResultSet rs, int row)
			throws java.sql.SQLException {
		for (int x = 1; x < row; x++)
			rs.next();
	}

	/**
	 * Given a statement object, table and where clause, this function reports
	 * the number of records in a table.
	 * <p>
	 * @param conn 	Connection
	 * @param table 	String
	 * @param where	String
	 * <p>
	 * @return long
	 *
	 */
	public static long countRecords(Connection conn,String table,String where) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lNumRecs = 0;

		//
		//	do not include WHERE keyword in SQL statement. It's done at the point where it is called.
		//	we do this because it's possible that we don't do WHERE. We may use HAVING and so much
		//	more.
		//

		String sql = "";

		try {
			Statement stmt = conn.createStatement();
			sql = "SELECT COUNT(0) FROM " + table + " " + where;
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
				lNumRecs = rs.getLong(1);
			rs.close();
			stmt.close();
		} catch (Exception e) {
			logger.fatal("AseUtil: countRecords - " + e.toString() + "\n" + sql);
		}

		return lNumRecs;
	}

	/**
	 * Given a statement object, table and where clause, this function reports
	 * the number of records in a table.
	 * <p>
	 * @param conn 	Connection
	 * @param table 	String
	 * @param where	String
	 * <p>
	 * @return long
	 *
	 */
	public static long countDistinct(Connection conn,String column,String table,String where) throws java.sql.SQLException {

		//Logger logger = Logger.getLogger("test");

		long lNumRecs = 0;

		/*
			do not include WHERE keyword in SQL statement. It's done at the point where it is called.
			we do this because it's possible that we don't do WHERE. We may use HAVING and so much
			more.
		*/

		String sql = "";

		try {
			Statement stmt = conn.createStatement();
			sql = "SELECT COUNT(DISTINCT " + column + ") FROM " + table + " " + where;
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
				lNumRecs = rs.getLong(1);
			rs.close();
			stmt.close();
		} catch (Exception e) {
			logger.fatal("AseUtil: countDistinct - " + e.toString() + "\n" + sql);
		}

		return lNumRecs;
	}

	/**
	 * Creates and returns a connection object
	 * <p>
	 *
	 * @param strConn		String representing the connection
	 * @param username	String representing the username
	 * @param password	String representing the password
	 * @return java.sql.Connection
	 */
	public java.sql.Connection cn(String strConn, String username,String password) throws java.sql.SQLException {

		return java.sql.DriverManager.getConnection(strConn, username, password);
	}

	/**
	 * <p>
	 *
	 * @param conn 		java.sql.Connection
	 * @param table		String table name
	 * @param fieldName	String name of field to get max of
	 * @return int 		highest value
	 */
	public int dbMaxValue(java.sql.Connection conn, String table,String fieldName) {
		try {
			java.sql.Statement stmt = conn.createStatement();
			java.sql.ResultSet rsLookUp = openRecordSet(stmt, "SELECT max("+ fieldName + ") FROM " + table);
			if (!rsLookUp.next()) {
				rsLookUp.close();
				stmt.close();
				return 0;
			}

			int res = rsLookUp.getInt(1);
			rsLookUp.close();
			stmt.close();

			return res;
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * This version has a grouping by clause
	 * <p>
	 *
	 * @param conn			java.sql.Connection
	 * @param table		String table name
	 * @param fieldName	String name of field to get max of
	 * @param where		String where clause to narrow look up
	 * @return int 		highest value
	 */
	public int dbMaxValue(java.sql.Connection conn, String table,String fieldName, String where) {
		try {
			java.sql.Statement stmt = conn.createStatement();
			java.sql.ResultSet rsLookUp = openRecordSet(stmt, "SELECT max("
					+ fieldName + ") FROM " + table
					+ " GROUP BY campus HAVING campus="
					+ toSQL(String.valueOf(where), 1));
			if (!rsLookUp.next()) {
				rsLookUp.close();
				stmt.close();
				return 0;
			}

			int res = rsLookUp.getInt(1);
			rsLookUp.close();
			stmt.close();

			return res;
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * Receives a property string value and returns the SQL with proper access
	 * rights. IE: If access is sysAdm, then allow to view all campuses. For
	 * campAdm, view all from the campus. For faculty, only view faculty type
	 * information. For user, read only.
	 * <p>
	 * @param props String to read property value
	 * <p>
	 * @return String
	 */
	public String getPropertySQL(javax.servlet.http.HttpSession session,String props) {

		String _sql = "";

		try {
			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			if (campus != null) {

				// what campus are we from?
				_sql = campus;

				// for sysadm, don't bother checking on campus
				Object o1 = (String)session.getAttribute("aseUserRights");
				int userLevel = (new Integer(o1.toString())).intValue();
				int accessLevel = SYSADM;

				//if (userLevel >= accessLevel)
				//	_sql = "";
			} else {
				_sql = "";
			}

			String dataType = "SQL";
			session.setAttribute("aseDataType", dataType);
			ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AseQueries" + dataType);
			_sql = bundle.getString(props).replace("_campus_", _sql);

		} catch (Exception e) {
			logger.fatal("AseUtil: getPropertySQL - " + e.toString());
			_sql = "";
		}

		return _sql;
	}

	/**
	 * Receives a property string value and returns the SQL with proper access
	 * rights. IE: If access is sysAdm, then allow to view all campuses. For
	 * campAdm, view all from the campus. For faculty, only view faculty type
	 * information. For user, read only.
	 * <p>
	 * @param props String to read property value
	 * <p>
	 * @return String
	 */
	public String getPropertySQL(String props) {

		String _sql = "";

		try {
			ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AseQueriesSQL");
			_sql = bundle.getString(props);
		} catch (Exception e) {
			logger.fatal("AseUtil: getPropertySQL - " + e.toString());
		}

		return _sql;
	}

	/**
	 * Mimics lookUp from VBA. Returns a looked up value given the table and
	 * where clause
	 * <p>
	 * @param conn			java.sql.Connection
	 * @param table		String table name
	 * @param fieldName	String name of field to look up
	 * @param where		String where clause to narrow look up
	 * <p>
	 * @return String
	 * <p>
	 */
	public String lookUp(java.sql.Connection conn, String table,String fieldName, String where) {

		//Logger logger = Logger.getLogger("test");

		String rtn = "";
		String sql = "";

		try {
			if (table != null && fieldName != null && where != null){
				sql = "SELECT " + fieldName + " FROM " + table + " WHERE " + where;
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					rtn = nullToBlank(rs.getString(1));
					if (rtn == null || rtn.length()==0)
						rtn = "";
				}
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			logger.fatal("AseUtil: lookUp - " + e.toString() + "\n" + sql);
		} catch (Exception e) {
			logger.fatal("AseUtil: lookUp - " + e.toString() + "\n" + sql);
		}

		return rtn;
	}

	/**
	 * Returns a looked up string array given the table, columns and where
	 * clause
	 * <p>
	 * @param conn 		java.sql.Connection
	 * @param table		String table name
	 * @param fieldName	String name of field to look up
	 * @param where		String where clause to narrow look up
	 * <p>
	 * @return String
	 */
	public String[] lookUpX(java.sql.Connection conn,String table,String fieldName,String where) {

		int pos = 0;
		int columns = 1;
		String sql = "";

		// determine number of fields being requested.
		pos = fieldName.indexOf(",", 0);
		while (pos > 0) {
			++columns;
			pos = fieldName.indexOf(",", ++pos);
		}

		String[] res = new String[columns];

		if (columns > 0){
			for (pos = 0; pos < columns; pos++)
				res[pos] = "";

			try {
				if (conn == null)
					conn = ConnDB.getConnection();

				sql = "SELECT " + fieldName + " FROM " + table + " WHERE " + where;
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					for (pos = 0; pos < columns; pos++)
						res[pos] = nullToBlank(rs.getString(pos + 1));
				}
				else{
					res[0] = "NODATA";
				}
				rs.close();
				ps.close();
			} catch (SQLException e) {
				logger.fatal("AseUtil: lookUpX - " + e.toString() + "\n" + sql);
			} catch (Exception e) {
				logger.fatal("AseUtil: lookUpX - " + e.toString() + "\n" + sql);
			}
		} // if columns
		else{
			res[0] = "ERROR";
			res[1] = "";
		}

		return res;
	}

	/**
	 * Given a statement object, table and where clause, this function reports
	 * the number of records in a table.
	 * <p>
	 *
	 * @param conn 		java.sql.Connection
	 * @param no 			String where clause
	 * @param type 		String
	 * @param campus		String
	 * @param question 	String
	 * @return int
	 */
	public int updateQuestionRecords(java.sql.Connection conn, String no,
			String type, String campus, String question)
			throws java.sql.SQLException {

		int rowsAffected = 0;

		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE tblCourseQuestions SET question=? WHERE questionnumber = ? AND type = ? AND campus = ?");
			ps.setString(1, question);
			ps.setString(2, no);
			ps.setString(3, type);
			ps.setString(4, campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			//
		} catch (Exception e) {
			//
		}

		return rowsAffected;
	}

	/**
	 * Returns a String array of field names from a given ResultSet
	 */
	public String[] getFieldNames(java.sql.ResultSet rs) throws java.sql.SQLException {

		java.sql.ResultSetMetaData metaData = rs.getMetaData();
		int count = metaData.getColumnCount();
		String[] aFields = new String[count];

		for (int j = 0; j < count; j++) {
			aFields[j] = metaData.getColumnLabel(j + 1);
		}

		return aFields;
	}

	@SuppressWarnings("unchecked")
	public java.util.Hashtable getRecordToHash(java.sql.ResultSet rs,java.util.Hashtable rsHash,
															String[] aFields) throws java.sql.SQLException {

		for (int i = 0; i < aFields.length; i++) {
			rsHash.put(aFields[i], getValue(rs, aFields[i]));
		}

		return rsHash;
	}

	/*
		returns a value from the session. This routine returns blank to force
		a valid value.
	*/
	public String getSessionValue(javax.servlet.http.HttpSession session,String sessName) {

		String value = "";

		try {
			value = nullToBlank((String)session.getAttribute(sessName));
		} catch (Exception e) {
			value = "";
		}

		return value;
	}

	public String getValue(java.sql.ResultSet rs, String strFieldName) {

		String junk = "";

		if ((rs == null) || (isEmpty(strFieldName)) || ("".equals(strFieldName)))
			junk = "";

		try {
			String sValue = rs.getString(strFieldName).trim();

			if (sValue == null)
				junk = "";
			else
				junk = sValue.trim();

		} catch (Exception e) {
			junk = "";
		}

		return junk;
	}

	public String getValue(java.sql.ResultSet rs, int fieldPosition) {

		String junk = "";

		try {
			ResultSetMetaData metaData = rs.getMetaData();
			String strFieldName = metaData.getColumnLabel(fieldPosition);
			String strTypeName = metaData.getColumnTypeName(fieldPosition);
			String sValue = "";
			int iValue = 0;

			if ((rs == null) || (isEmpty(strFieldName)) || ("".equals(strFieldName)))
				junk = "";

			try {
				sValue = rs.getString(strFieldName);

				if (strTypeName.equals("INTEGER") || strTypeName.equals("DOUBLE")) {
					if (sValue != null)
						iValue = Integer.parseInt(sValue);

					sValue = Integer.toString(iValue);
				} else {
					if (sValue == null)
						sValue = "";
					else
						sValue.trim();
				}

				junk = sValue;
			} catch (Exception e) {
				junk = "";
			}
		} catch (SQLException e) {
			junk = "";
		}

		return junk;
	}

	/**
	 * returns true if the int argument is empty
	 */
	public boolean isEmpty(int val) {
		return val == UNDEFINT;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public boolean isEmpty(String val) {
		return (val == null || val.equals("") || val.equals(Integer
				.toString(UNDEFINT)));
	}

	/**
	 * returns true if the String value is a number
	 */
	public boolean isNumber(String param) {

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
	 * Loads the necessary driver for this database
	 */
	public static String loadDriver() {

		String sErr = "";
		try {
			java.sql.DriverManager.registerDriver((java.sql.Driver) (Class
					.forName(DBDriver).newInstance()));
		} catch (Exception e) {
			sErr = e.toString();
		}

		return (sErr);
	}

	/**
	 * Creates and returns a ResultSet when given the statement object and SQL
	 * statement
	 * <p>
	 *
	 * @param stmt
	 *            java.sql.Statement
	 * @param sql
	 *            String containing SQL
	 * @return java.sql.ResultSet
	 */
	public ResultSet openRecordSet(java.sql.Statement stmt, String sql)
			throws java.sql.SQLException {
		java.sql.ResultSet rs = stmt.executeQuery(sql);
		return (rs);
	}

	/**
	 * Creates and returns a vector when given the statement object and SQL
	 * statement
	 * <p>
	 *
	 * @param stmt
	 *            java.sql.Statement
	 * @param sql
	 *            String containing SQL
	 * @return vector
	 */
	public Vector openRecordSet(java.sql.Statement stmt, String sql, int column)
			throws java.sql.SQLException {

		Vector<String> vector = new Vector<String>();

		java.sql.ResultSet rs = stmt.executeQuery(sql);

		while (rs.next()) {
			vector.addElement(new String(rs.getString(column)));
		}

		rs.close();

		return (vector);
	}

	/**
	 * @return String
	 */
	public String proceedError(javax.servlet.http.HttpServletResponse response,
			Exception e) {
		return e.toString();
	}

	/**
	 * @return String
	 */
	public String toURL(String strValue) {
		if (strValue == null)
			return "";

		if (strValue.compareTo("") == 0)
			return "";

		try {
			strValue = java.net.URLEncoder.encode(strValue, "US-ASCII");
		} catch (Exception ex) {
			strValue = ex.toString();
		}

		return strValue;
	}

	/**
	 * @return String
	 */
	public String toHTML(String value) {
		if (value == null)
			return "";

		value = replace(value, "&", "&amp;");
		value = replace(value, "<", "&lt;");
		value = replace(value, ">", "&gt;");
		value = replace(value, "\"", "&" + "quot;");

		return value;
	}

	/**
	 * @return String
	 */
	public String getValueHTML(java.sql.ResultSet rs, String fieldName) {
		try {
			String value = rs.getString(fieldName);
			if (value != null) {
				return toHTML(value);
			}
		} catch (java.sql.SQLException sqle) {
		}

		return "";
	}

	/**
	 * @return String
	 */
	public String getParam(javax.servlet.http.HttpServletRequest req,String paramName) {
		String param = req.getParameter(paramName);

		if (param == null || param.equals(""))
			return "";

		param = replace(param, "&amp;", "&");
		param = replace(param, "&lt;", "<");
		param = replace(param, "&gt;", ">");
		param = replace(param, "&amp;lt;", "<");
		param = replace(param, "&amp;gt;", ">");

		return param;
	}

	/**
	 * @return String
	 */
	public String replace(String str, String pattern, String replace) {
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
	 * @return String
	 */
	public String toSQL(String value) {

		return toSQL(value,0,true);

	}

	public String toSQL(String value, int type) {

		return toSQL(value,type,true);

	}

	public String toSQL(String value, int type, boolean quote) {

		//
		// return invalid
		//
		if (value == null){
			return "Null";
		}

		//
		// set default
		//
		if(type==0){
			type = adText;
		}

		String param = value;

		if (param.equals("") && (type == adText || type == adDate)) {
			return "Null";
		}

		switch (type) {
			case adText: {
				param = replace(param, "'", "''");
				param = replace(param, "&amp;", "&");

				if(quote){
					param = "'" + param + "'";
				}

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
	 * @return String
	 */
	public String getCheckBoxValue(String val, String checkVal,
			String uncheckVal, int ctype) {
		if (val == null || val.equals(""))
			return toSQL(uncheckVal, ctype);
		else
			return toSQL(checkVal, ctype);
	}

	/**
	 * @return String
	 */
	public String toWhereSQL(String fieldName, String fieldVal, int type) {
		String res = "";

		switch (type) {
			case adText:
				if (!"".equals(fieldVal)) {
					res = " " + fieldName + " like '%" + fieldVal + "%'";
				}
				break;
			case adNumber:
				res = " " + fieldName + " = " + fieldVal + " ";
				break;
			case adDate:
				res = " " + fieldName + " = '" + fieldVal + "' ";
				break;
			default:
				res = " " + fieldName + " = '" + fieldVal + "' ";
		}
		return res;
	}

	public String toWhereSQLX(String fieldName, String fieldVal, int type) {
		String res = "";
		switch (type) {
		case adText:
			if (!"".equals(fieldVal)) {
				res = " [" + fieldName + "] like '%" + fieldVal + "%'";
			}
			break;
		case adNumber:
			res = " [" + fieldName + "] = " + fieldVal + " ";
			break;
		case adDate:
			res = " [" + fieldName + "] = '" + fieldVal + "' ";
			break;
		default:
			res = " [" + fieldName + "] = '" + fieldVal + "' ";
		}
		return res;
	}

	/**
	 * @return String
	 */
	public String getOptions(java.sql.Connection conn, String sql,
			boolean isSearch, boolean isRequired, String selectedValue) {

		StringBuffer sOptions = new StringBuffer();
		String sSel = "";

		if (isSearch)
			sOptions.append("<option value=\"\">All</option>");
		else {
			if (!isRequired)
				sOptions.append("<option value=\"\"></option>");
		}

		try {
			java.sql.Statement stat = conn
					.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
							ResultSet.CONCUR_UPDATABLE);
			java.sql.ResultSet rs = null;
			rs = openRecordSet(stat, sql);

			while (rs.next()) {
				String id = toHTML(rs.getString(1));
				String val = toHTML(rs.getString(1));

				if (id.compareTo(selectedValue) == 0)
					sSel = "SELECTED";
				else
					sSel = "";

				sOptions.append("<option value=\"" + id + "\" " + sSel + ">"
						+ val + "</option>");
			}

			rs.close();
			stat.close();
		} catch (Exception e) {
			sOptions.append("<option value=\"\">" + e.toString() + "</option>");
		}

		return sOptions.toString();
	}

	/**
	 * @return String
	 */
	public String getOptionsLOV(String sLOV, boolean isSearch,
			boolean isRequired, String selectedValue) {
		String sSel = "";
		String slOptions = "";
		StringBuffer sOptions = new StringBuffer();
		String id = "";
		String val = "";
		java.util.StringTokenizer LOV = new java.util.StringTokenizer(sLOV,
				";", true);
		int i = 0;
		String old = ";";

		while (LOV.hasMoreTokens()) {
			id = LOV.nextToken();

			if (!old.equals(";") && (id.equals(";")))
				id = LOV.nextToken();
			else {
				if (old.equals(";") && (id.equals(";")))
					id = "";
			}

			if (!id.equals(""))
				old = id;

			i++;

			if (LOV.hasMoreTokens()) {
				val = LOV.nextToken();

				if (!old.equals(";") && (val.equals(";")))
					val = LOV.nextToken();
				else {
					if (old.equals(";") && (val.equals(";")))
						val = "";
				}

				if (val.equals(";"))
					val = "";

				if (!val.equals(""))
					old = val;
				i++;
			}

			if (id.compareTo(selectedValue) == 0)
				sSel = "SELECTED";
			else
				sSel = "";

			slOptions += "<option value=\"" + id + "\" " + sSel + ">" + val
					+ "</option>";
		}

		if ((i % 2) == 0)
			sOptions.append(slOptions);

		return sOptions.toString();
	}

	/**
	 * @return String
	 */
	public String getValFromLOV(String selectedValue, String sLOV) {

		String sRes = "";
		String id = "";
		String val = "";
		java.util.StringTokenizer LOV = new java.util.StringTokenizer(sLOV,
				";", true);
		int i = 0;
		String old = ";";

		while (LOV.hasMoreTokens()) {
			id = LOV.nextToken();

			if (!old.equals(";") && (id.equals(";")))
				id = LOV.nextToken();
			else {
				if (old.equals(";") && (id.equals(";")))
					id = "";
			}

			if (!id.equals(""))
				old = id;

			i++;

			if (LOV.hasMoreTokens()) {
				val = LOV.nextToken();
				if (!old.equals(";") && (val.equals(";")))
					val = LOV.nextToken();
				else {
					if (old.equals(";") && (val.equals(";")))
						val = "";
				}

				if (val.equals(";"))
					val = "";

				if (!val.equals(""))
					old = val;

				i++;
			}

			if (id.compareTo(selectedValue) == 0)
				sRes = val;
		}

		return sRes;
	}

	/**
	 * @return String
	 */
	public String checkSecurity(javax.servlet.http.HttpSession session,
			javax.servlet.http.HttpServletResponse response,
			javax.servlet.http.HttpServletRequest request) {
		try {

			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			Object o1 = user;

			if (o1 == null || (o1.toString()).equals("")) {
				response.sendRedirect(".jsp?querystring="
						+ toURL(request.getQueryString()) + "&ret_page="
						+ toURL(request.getRequestURI()));
				return "sendRedirect";
			}
		} catch (Exception e) {
			//
		}

		return "";
	}

	/**
	 * @return String
	 */
	public String checkLoggedIn(javax.servlet.http.HttpSession session,
			javax.servlet.http.HttpServletResponse response,
			javax.servlet.http.HttpServletRequest request) {

		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try {
			Object o1 = user;

			if (o1 == null || (o1.toString()).equals("")) {
				return null;
			}
		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return user;
	}

	/**
	 * @return String
	 */
	public String checkSecurityLevel(int iLevel,
			javax.servlet.http.HttpSession session,
			javax.servlet.http.HttpServletResponse response,
			javax.servlet.http.HttpServletRequest request) {

		String sReturn = "";

		try {
			Object o1 = session.getAttribute("aseUserRights");

			int userLevel = (new Integer(o1.toString())).intValue();
			int accessLevel = iLevel;

			if (userLevel >= accessLevel)
				sReturn = "";
			else
				sReturn = "access denied";
		} catch (Exception e) {
			sReturn = e.toString();
		}

		return sReturn;
	}

	/**
	 * @return String
	 */

	public String createSelectionBox(java.sql.Connection conn,
												String sql,
												String controlName,
												String selectedValue) {

		return createSelectionBox(conn, sql, controlName, selectedValue,"","1",false,"");
	}

	public String createSelectionBox(java.sql.Connection conn,
												String sql,
												String controlName,
												String selectedValue,
												boolean required) {

		return createSelectionBox(conn, sql, controlName, selectedValue,"","1",required,"");
	}

	public String createSelectionBox(java.sql.Connection conn,
												String sql,
												String controlName,
												String selectedValue,
												String action,
												boolean required) {

		return createSelectionBox(conn,sql,controlName,selectedValue,action,"1",required,"");
	}

	public String createSelectionBox(Connection conn,
												String sql,
												String controlName,
												String selectedValue,
												String action,
												String size,
												boolean required){
		return createSelectionBox(conn,sql,controlName,selectedValue,action,"1",required,"");
	}

	public String createSelectionBox(Connection conn,
												String sql,
												String controlName,
												String selectedValue,
												String action,
												String size,
												boolean required,
												String onClick) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String strText = "";
		String text2 = "";
		String strSelect = "";
		String requiredInput = "smalltext";

		if (required)
			requiredInput = "smalltextrequired";

		if (size == null || size.length() == 0)
			size = "1";

		try {
			temp.append("<select name=\'" + controlName + "\' size=\'" + size
					+ "\' class=\'" + requiredInput + "\' " + action + " " +  onClick + ">\n");
			temp.append("<option selected value=\'\'>- select -</option>\n");

			java.sql.Statement stmt = conn.createStatement();
			java.sql.ResultSet rs = openRecordSet(stmt, sql);

			while (rs.next()) {
				strText = nullToBlank(rs.getString(1));
				text2 = nullToBlank(rs.getString(2));

				strSelect = "";

				if (strText.equals(selectedValue))
					strSelect = "selected";

				temp.append("<option value=\'" + strText + "\' "
						+ strSelect + ">" + text2 + "</option>\n");
			}

			temp.append("</select>\n");

			rs.close();
			stmt.close();

		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return temp.toString();
	}

	/**
	 * createSelectionBox
	 * <p>
	 * @param	conn				Connection
	 * @param	sql				String
	 * @param	controlName		String
	 * @param	selectedValue	String
	 * @param	action			String
	 * @param	size				String
	 * @param	required			boolean
	 * @param	onClick			String
	 * @param	enable			boolean
	 * @param	ajax				boolean
	 * <p>
	 * @return	String
	 */
	public String createSelectionBox(Connection conn,
												String sql,
												String controlName,
												String selectedValue,
												String action,
												String size,
												boolean required,
												String onClick,
												boolean enable,
												boolean ajax) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String strText = "";
		String text2 = "";
		String strSelect = "";
		String requiredInput = "smalltext";
		String disable = "";

		try{

			if (required){
				requiredInput = "smalltextrequired";
			}

			if (size == null || size.length() == 0){
				size = "1";
			}

			if(!enable){
				disable = "disabled";
			}

			if(!ajax){
				temp.append("<select name=\'" + controlName
								+ "\' id=\'" + controlName
								+ "\' size=\'" + size
								+ "\' class=\'" + controlName + "\' "
								+ disable + " "
								+ action + " "
								+  onClick + ">");
			}

			temp.append("<option selected value=\"\">- select -</option>");

			java.sql.Statement stmt = conn.createStatement();
			java.sql.ResultSet rs = openRecordSet(stmt, sql);

			while (rs.next()) {

				strText = nullToBlank(rs.getString(1));

				text2 = nullToBlank(rs.getString(2));

				strSelect = "";

				if (strText.equals(selectedValue)){
					strSelect = "selected";
				}

				temp.append("<option value=\'" + strText + "\' " + strSelect + " >" + text2 + "</option>");
			}

			if(!ajax){
				temp.append("</select>");
			}

			rs.close();
			stmt.close();

		}
		catch(SQLException e){
			logger.fatal("AseUtil.createSelectionBox - SQLExcception" + e.toString());
		}
		catch(Exception e){
			logger.fatal("AseUtil.createSelectionBox - Excception" + e.toString());
		}

		return temp.toString();
	}

	/**
	 *
	 * @param strList 		String values showing in list box
	 * @param strData 		String values returned to form (if blanks, strList is used)
	 * @param controlName	String name of the form control
	 * @param selectedValue	String if a value is available, it is selected
	 * @param strClassName	String CSS
	 * @param strPattern		String validation patter
	 * @param future1			String when empty, default is ALL, else use BLANK
	 * @param future2			String
	 * <p>
	 * @return String
	 */
	public String createStaticSelectionBox(String strList,
														String strData,
														String controlName,
														String selectedValue,
														String strClassName,
														String strPattern,
														String future1,
														String future2) {

		String[] strValues = new String[100];
		String[] strHidden = new String[100];
		String temp = "";
		String text1 = "";
		String text2 = "";
		String strSelect = "";
		String strCompare = "";
		int i = 0;

		try {

			if (strClassName == null || strClassName.length() == 0)
				strClassName = "smalltext";

			strValues = strList.split(",");
			strHidden = strData.split(",");

			if (strPattern != null && strPattern.length() > 0)
				strPattern = "pattern=\'" + strPattern + "\'";
			else
				strPattern = "";

			if (future2 == null)
				future2 = "1";

			temp = "<select name=\'" + controlName + "\' size=\'" + future2
					+ "\' class=\'" + strClassName + "\' " + strPattern + ">";

			if (future1 != null && future1.length() == 0)
				temp = temp + "<option value=\'\'>- ALL -</option>";
			else if (future1.equals("BLANK"))
				temp = temp + "<option value=\'\'></option>";

			for (i = 0; i < strValues.length; i++) {
				text1 = strValues[i];
				strCompare = text1;
				text2 = strValues[i];

				if (strData != null && strData.length() > 0) {
					text2 = strHidden[i];
					strCompare = text2;
				}

				strSelect = "";

				if (strCompare.equals(selectedValue))
					strSelect = "selected";

				temp = temp + "<option value=\'" + text2 + "\' " + strSelect
						+ ">" + text1 + "</option>";
			}

			temp = temp + "</select>";

		} catch (Exception e) {
			temp = e.toString();
		}

		return temp;
	}

	/**
	 * @return String
	 */
	public String temp() {

		String temp = "";

		try {
			temp = "";
		} catch (Exception e) {
			temp = e.toString();
		}

		return temp;
	}

	/**
	 * @param str	String
	 * @return String
	 */
	public String emptyOrNullToBlank(String str) {

		String temp = "";

		try {
			if (str==null || "null".equals(str))
				temp = "";
			else{
				if (str.length() > 0)
					temp = str.trim();
			}
		} catch (Exception e) {
			temp = e.toString();
		}

		return temp;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToBlank(String val) {

		if (val==null || "null".equals(val) || val.length()== 0)
			val = "";

		if (val.length() > 0)
			val = val.trim();

		return val;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToBlank(int val) {

		String temp = "";

		if (Integer.toString(val) == null)
			temp = "";
		else
			temp = Integer.toString(val);

		return temp;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToBlank(java.util.Date val) {

		String temp = "";

		if (val==null || "null".equals(val))
			temp = "";
		else
			temp = val.toString();

		if (temp.length() > 0)
			temp = temp.trim();

		return temp;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToBlank(boolean val) {

		String temp = "";

		if (val==true)
			temp = "1";
		else
			temp = "0";

		return temp;
	}

	/**
	 * returns string containing HTML field
	 *
	 * <p>
	 *
	 * @param conn 		connection
	 * @param fieldType 	text, radio, check, date
	 * @param fieldRef 	for radio, and check, what to use as the selection list
	 * @param fieldName 	field name
	 * @param fieldValue default value
	 * @param fieldLen 	len of input field
	 * @param fieldMax 	max length allowed for input field
	 * @param lock 		whether the field should be locked down
	 * @param campus 		requires for campus specific controls
	 *
	 */
	public String drawHTMLField(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											boolean lock,
											String campus,
											boolean required) {

	 	String temp = drawHTMLField(conn,
											fieldType,
											fieldRef,
											fieldName,
											fieldValue,
											fieldLen,
											fieldMax,
											lock,
											campus,
											required,
											"");
		return temp;
	}

	public String drawHTMLField(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											boolean lock,
											String campus,
											boolean required,
											String column) {

	 	String temp = drawHTMLField(conn,
											fieldType,
											fieldRef,
											fieldName,
											fieldValue,
											fieldLen,
											fieldMax,
											lock,
											campus,
											required,
											column,
											fieldLen);
		return temp;

	}

	public String drawHTMLField(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											boolean lock,
											String campus,
											boolean required,
											String column,
											int userlen) {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		StringBuffer buf = new StringBuffer();
		String shownValue = fieldValue;
		String hiddenValue = fieldValue;
		String fieldLabel = "";
		String sql = "";
		boolean found = false;

		try{
			if (lock){
				if (fieldType.equals("check")){
					if (fieldRef.equals("MethodInstructions")){
						fieldRef = "MethodInst";
					}
					else if (fieldRef.equals("MethodEvaluations")){
						fieldRef = "MethodEval";
					}

					if (fieldValue==null || fieldValue.length()==0){
						fieldValue = "0";
					}

					sql = "SELECT kdesc FROM tblINI WHERE campus=? AND category=? AND id IN (" + fieldValue + ") ORDER BY kid";

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,fieldRef);
					ResultSet rs = ps.executeQuery();
					shownValue = "";
					while (rs.next()) {
						found = true;
						shownValue = shownValue + "<li>"+rs.getString(1)+"</li>";
					}
					rs.close();
					ps.close();

					if (found){
						shownValue = "<ul>" + shownValue + "</ul>";
					}
				}
				else if (fieldType.equals("radio")) {
					fieldName = "questions_0";

					if (fieldRef.equals("CONSENTPREREQ")){
						// handled below
					}
					else if (fieldRef.equals("CONSENTCOREQ")){
						fieldLabel = "Consent: ";
					}

					if (fieldValue.equals(Constant.OFF)){
						shownValue = "N";
					}
					else{
						shownValue = "Y";
					}
				}

				if (fieldRef.equals("CONSENTPREREQ")){
					buf.append(Outlines.drawPrereq(fieldValue,"",true));
					buf.append("<input type=\'hidden\' value=\'" + hiddenValue + "\' name=\'" + fieldName.trim() + "\'>");
					buf.append("<input type=\'hidden\' value=\'" + hiddenValue + "\' name=\'questions_1\'>");
					buf.append("<input type=\'hidden\' value=\'" + hiddenValue + "\' name=\'questions_2\'>");
				}
				else{
					buf.append(fieldLabel + shownValue.trim());
					buf.append("<input type=\'hidden\' value=\'" + hiddenValue + "\' name=\'" + fieldName.trim() + "\'>");
				}

				temp = buf.toString();
			}
			else{
				temp = drawHTMLFieldX(conn,fieldType,fieldRef,fieldName,fieldValue.trim(),fieldLen,fieldMax,campus,required,column,userlen);
			}
		} catch (SQLException se) {
			logger.fatal(se.toString());
			temp = "";
		} catch (Exception pe) {
			logger.fatal(pe.toString());
			temp = "";
		}

		return temp;
	}

	public String drawHTMLFieldX(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											String campus,
											boolean required) {

		return drawHTMLFieldX(conn,fieldType,fieldRef,fieldName,fieldValue,fieldLen,fieldMax,campus,required,"");

	}

	public String drawHTMLFieldX(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											String campus,
											boolean required,
											String column) {

		return drawHTMLFieldX(conn,fieldType,fieldRef,fieldName,fieldValue,fieldLen,fieldMax,campus,required,column,fieldLen);

	}

	public String drawHTMLFieldX(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											String campus,
											boolean required,
											String column,
											int userlen) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String[] selectedValue;
		String[] selectedName;
		String[] iniValues;
		String[] inputValues;
		String[] userValue;
		String selected = "";
		String sql;
		String HTMLType = "";
		String tempFieldName = "";
		String junk = "";
		String thisValue = "";
		String originalValue = fieldValue;
		String requiredInput = "input";
		String html = "";
		String fieldLabel = "";
		String kval3 = "";

		/*
			depending on the situation, we are now storing list values of CSV as

			869~~5,870~~10,871~~15,872~~3 where the ~~ separates 1 value from
			the next.

			for example, 869~~5, where 869 is key id for some value and 5 is the
			value used there. in this case, 869 is id for Contact Hours and 5 is
			the hours

		*/
		String dropDownValues = "";
		String[] aDropDownValues = null;
		String ddlRange = "";
		String listRangeSQL = "";
		String[] listRange = null;
		boolean includeRange = false;
		int start = 0;
		int end = 0;
		String defaultListValue = "";
		String textCounter = "";

		// 20 was padded to the len to give space for data entry and view. subtract
		// the 20 here to control the limit properly
		int actualFieldLen = fieldLen - 20;

		if (required)
			requiredInput = "inputRequired";

		StringBuffer s1 = new StringBuffer();		// fully spelled out names
		StringBuffer s2 = new StringBuffer();		// ids for s1 values

		boolean found = false;
		boolean countThistext = false;

		int numberOfControls = 0;
		int selectedIndex = 0;
		int i;

		try {

			boolean debug = false;

			String systemCountText = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableTextCounter");

			if (debug){
				logger.info("------------------------------");
				logger.info("fieldType: " + fieldType);
				logger.info("fieldRef: " + fieldRef);
				logger.info("fieldName: " + fieldName);
				logger.info("fieldValue: " + fieldValue);
				logger.info("fieldLen: " + fieldLen);
				logger.info("fieldMax: " + fieldMax);
				logger.info("campus: " + campus);
				logger.info("required: " + required);
				logger.info("column: " + column);
				logger.info("userlen: " + userlen);
			}

			AseUtil ae = new AseUtil();

			iniValues = new String[2];
			iniValues[0] = "";
			iniValues[1] = "";

			if (fieldType.toLowerCase().equals("check")) {

				/*
					if we find ~~ in the fieldValue, it's because we are storing
					double values between commas.

					for example, 869~~5,870~~10,871~~15,872~~3 is similar to

					869,5
					870,10
					871,15
					872,3

					four sets of data as CSV

					this section of code breaks CSV into sub CSV and assign
					accordingly.

					for contact hours, we include a drop down list of hours for selection.

					lookupX returns array of 2 values. in this case, the start and ending
					values for the list range
				*/
				if (fieldRef.equals("ContactHrs")){
					listRangeSQL = "category='System' AND campus='"+campus+"' AND kid='NumberOfContactHoursRangeValue'";
					listRange = ae.lookUpX(conn,"tblIni","kval1,kval2",listRangeSQL);
					if (listRange != null){
						if (	NumericUtil.isInteger(listRange[0]) &&
								NumericUtil.isInteger(listRange[1]) &&
								Integer.parseInt(listRange[1]) > 0){
							includeRange = true;
							start = Integer.parseInt(listRange[0]);
							end = Integer.parseInt(listRange[1]);
							kval3 = IniDB.getIniByCampusCategoryKidKey3(conn,campus,"System","NumberOfContactHoursRangeValue");
						}
					} // listRange != null
				}

				if(fieldValue.indexOf(Constant.SEPARATOR)>-1 || includeRange){

					int junkInt = 0;
					int tempInt = 0;
					String[] tempString = null;
					String[] junkString = null;

					// if statement splits when there is data. else statement
					// sets all to zero
					if(fieldValue.indexOf(Constant.SEPARATOR)>-1){
						String[] split = SQLValues.splitMethodEval(fieldValue);
						if (split != null){
							fieldValue = split[0];
							dropDownValues = split[1];
						}
					}
					else{
						tempString = fieldValue.split(",");
						tempInt = tempString.length;

						for(junkInt = 0; junkInt<tempInt; junkInt++){
							if (junkInt == 0)
								dropDownValues = "0";
							else
								dropDownValues = dropDownValues + ",0";
						} // for
					}

					aDropDownValues = dropDownValues.split(",");

				} // (fieldValue.indexOf(Constant.SEPARATOR)>-1)

				i = 0;
				fieldType = "checkbox";
				ResultSet rs;

				if (!fieldRef.equals(Constant.BLANK)){
					// TO DO Hard coding (key and description display on course mod and other screens)
					if ((Constant.CAMPUS_UHMC).equals(campus) && "MethodEval".equals(fieldRef)){
						sql = "SELECT kid+' - '+kdesc AS descr,id "
							+ "FROM tblINI WHERE campus=? AND category=? ORDER BY seq";
					}
					else{
						sql = "SELECT kdesc,id FROM tblINI WHERE campus=? AND category=? ORDER BY seq";
					}
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,fieldRef);
					rs = ps.executeQuery();
					while (rs.next()) {
						if (i > 0) {
							s1.append(Constant.SEPARATOR);
							s2.append(Constant.SEPARATOR);
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					ps.close();
					selectedValue = s1.toString().split(Constant.SEPARATOR);
					selectedName = s2.toString().split(Constant.SEPARATOR);
				}
				else{
					/*
					 * get the string pointed to by fieldRef. If it contains SELECT
					 * check box data comes from some table. If not, it's a CSV.
					 * this is done to help determine the layout for check and radio
					 * buttons
					 */
					if (!campus.equals(Constant.BLANK))
						junk = "campus=" + ae.toSQL(campus, 1) + " AND kid = " + ae.toSQL(fieldRef, 1);
					else
						junk = "kid = " + ae.toSQL(fieldRef, 1);

					iniValues = ae.lookUpX(conn, "tblINI", "kval1,kval2", junk);

					if (iniValues[0].indexOf("SELECT") >= 0) {
						Statement stmt = conn.createStatement();
						rs = ae.openRecordSet(stmt, iniValues[0]);
						while (rs.next()) {
							if (i > 0) {
								s1.append(Constant.SEPARATOR);
								s2.append(Constant.SEPARATOR);
							}
							s1.append(rs.getString(1));
							s2.append(rs.getString(2));
							i = 1;
						}
						rs.close();
						stmt.close();
						selectedName = s1.toString().split(Constant.SEPARATOR);
						selectedValue = s2.toString().split(Constant.SEPARATOR);
					} else {
						selectedName = iniValues[0].split(Constant.SEPARATOR);
						selectedValue = iniValues[1].split(Constant.SEPARATOR);
					} // iniValues[0].indexOf("SELECT") >= 0
				} // if (!"".equals(fieldRef))

				// it's possible that nothing is available for use
				if (selectedName[0] != null && !"".equals(selectedName[0])){
					/*
					 * for radios, there's only 1 control to work with; for checks
					 * there should be as many controls as the loop above this is
					 * explained down below.
					 */
					numberOfControls = selectedValue.length;
					inputValues = fieldValue.split(",");

					/*
						make the list of available items and list of user selected items
						the same in length.
					*/
					if (inputValues.length < numberOfControls) {
						for (i=inputValues.length; i<numberOfControls; i++) {
							fieldValue += ",0";
						}
					}

					userValue = fieldValue.split(",");

					/*
						in cases where we didn't have data stored to dropDownValues, then we better
						put zeroes in the field so that the rest of this code works.
					*/
					if ("".equals(dropDownValues)){
						for (i=0; i<userValue.length; i++) {
							if (i==0)
								dropDownValues = "0";
							else
								dropDownValues += ",0";
						}

						aDropDownValues = dropDownValues.split(",");
					}

					/*
						 print the controls and their values
						 checkboxes can have different names for controls, but
						 radios must all share 1 single name.
					 */
					temp.append("<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\">");
					for (i=0; i<numberOfControls; i++) {
						selected = "";
						selectedIndex = 0;
						defaultListValue = "";
						found = false;
						while (!found && selectedIndex < numberOfControls){
							if (selectedName[i].equals(userValue[selectedIndex])){
								defaultListValue = aDropDownValues[selectedIndex];
								selected = "checked";
								found = true;
							}
							++selectedIndex;
						}

						tempFieldName = fieldName + "_" + i;

						temp.append("<tr><td valign=\"top\" width=\"05%\">"
								+ "<input type=\'" + fieldType + "\' value=\'" + selectedName[i]
								+ "\' name=\'" + tempFieldName + "\'"
								+ " " + selected + ">"
								+ "</td>");

						if (includeRange){
							ddlRange = ae.createSelectionBoxWithRange(selectedName[i] + "_ddl",start,end,false,defaultListValue,kval3);

							temp.append("<td class=\"datacolumn\" valign=\"top\" width=\"10%\">" + ddlRange + "</td>");
						}

						temp.append("<td class=\"datacolumn\" valign=\"top\">" + selectedValue[i] + "</td>");

						temp.append("</tr>");
					} // for
					temp.append("</table>");
				} // selectedName[0] != null

				/*
				 * form data collection expects at least a field call
				 * 'questions'. when dealing with radios and checks, questions
				 * does not exists since the field are either named with similar
				 * names or created as multiple selections (must be unique).
				 * this hidden field makes it easy to ignore the calendar or
				 * form error
				 */
				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\' id=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\' id=\'numberOfControls\'>");

			} else if (fieldType.toLowerCase().equals("radio")) {

				//
				//	see check box logic for explanation on what's happening here
				//
				if (	column.equals(Constant.CAMPUS_USER_RADIO_LIST_1) ||
						column.equals(Constant.CAMPUS_USER_RADIO_LIST_2) ||
						column.equals(Constant.CAMPUS_USER_RADIO_LIST_3) ||
						column.equals(Constant.COURSE_USER_RADIO_LIST_1) ||
						column.equals(Constant.COURSE_USER_RADIO_LIST_2) ||
						column.equals(Constant.COURSE_USER_RADIO_LIST_3) ||
						column.equals(Constant.COURSE_USER_RADIO_LIST_4) ||
						column.equals(Constant.COURSE_USER_RADIO_LIST_5) ||
						fieldRef.contains("UserDefinedControl_X") ){
					i = 0;
					ResultSet rs;

					sql = "SELECT kdesc,id FROM tblINI WHERE campus=? AND category=? ORDER BY seq";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,fieldRef);
					rs = ps.executeQuery();
					while (rs.next()) {
						if (i > 0) {
							s1.append(",");
							s2.append(",");
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					ps.close();
					selectedValue = s1.toString().split(",");
					selectedName = s2.toString().split(",");
				}
				else{
					junk = "kid = " + ae.toSQL(fieldRef, 1) + " AND campus = " + ae.toSQL(campus, 1);
					iniValues = ae.lookUpX(conn, "tblINI", "kval1,kval2", junk);

					if (iniValues[0].indexOf("SELECT") >= 0) {
						java.sql.Statement stmt = conn.createStatement();
						java.sql.ResultSet rs = ae.openRecordSet(stmt, iniValues[0]);
						i = 0;
						while (rs.next()) {
							if (i > 0) {
								s1.append(",");
								s2.append(",");
							}
							s1.append(rs.getString(1));
							s2.append(rs.getString(2));
							i = 1;
						}
						rs.close();
						stmt.close();
						selectedValue = s1.toString().split(",");
						selectedName = s2.toString().split(",");
					} else {
						selectedValue = iniValues[0].split(",");
						selectedName = iniValues[1].split(",");
					}
				}

				//
				// some known values for CC
				//
				if (fieldRef.equals("YESNO")) {
					fieldValue = "1,0";
				} else if (fieldRef.equals("CONSENTPREREQ")) {
					// handled down below
				} else if (fieldRef.equals("CONSENTCOREQ")) {
					fieldValue = "1,0";
					fieldLabel = "Consent: ";
					selectedValue = "Yes,No".split(",");
					selectedName = "1,0".split(",");

					if (originalValue==null || "".equals(originalValue)){
						originalValue = "1";
					}
				} else if (fieldRef.equals("YN")) {
					fieldValue = "Y,N";
				} else if (fieldRef.equals("STATUS")) {
					fieldValue = "1,0";
					selectedValue = "Active,Inactive".split(",");
					selectedName = "1,0".split(",");
				} else if (fieldRef.equals("UserStatus")) {
					fieldValue = "1,0";
				} else if (fieldRef.equals("CourseStatus")) {
					fieldValue = "1,0";
				} else if (fieldRef.equals("ReasonsForMods")) {
					fieldValue = s2.toString();
				} else if (	column.equals(Constant.CAMPUS_USER_RADIO_LIST_1) ||
								column.equals(Constant.CAMPUS_USER_RADIO_LIST_2) ||
								column.equals(Constant.CAMPUS_USER_RADIO_LIST_3) ||
								column.equals(Constant.COURSE_USER_RADIO_LIST_1) ||
								column.equals(Constant.COURSE_USER_RADIO_LIST_2) ||
								column.equals(Constant.COURSE_USER_RADIO_LIST_3) ||
								column.equals(Constant.COURSE_USER_RADIO_LIST_4) ||
								column.equals(Constant.COURSE_USER_RADIO_LIST_5) ||
								fieldRef.contains("UserDefinedControl_X") ) {
					// C37, C38, C39, X98, X99, X82, X83, X84
					fieldValue = s2.toString();
				}

				//
				// set up for drawing
				//
				userValue = fieldValue.split(",");
				inputValues = fieldValue.split(",");

				if (fieldRef.equals("CONSENTPREREQ")) {
					temp.append(Outlines.drawPrereq(originalValue,fieldName,false));
					numberOfControls = 3;
				}
				else if (fieldRef.equals("ReasonsForMods")) {
					//x46
					temp.append(Html.drawRadio(conn,"ReasonsForMods",fieldName,originalValue,campus,false,false));
				}
				else{

					temp.append(fieldLabel);

					for (i = 0; i < inputValues.length; i++) {

						selected = "";

						if (userValue[i].equals(originalValue)){
							selected = "checked";
						}

						tempFieldName = fieldName + "_0";
						thisValue = inputValues[i];

						temp.append("<input type=\'" + fieldType
								+ "\' value=\'" + selectedName[i] + "\' name=\'"
								+ tempFieldName + "\'" + " " + selected + ">&nbsp;" + selectedValue[i]);

						if(inputValues.length > 2){
							temp.append("<br>");
						}
						else{
							temp.append("&nbsp;&nbsp;");
						}

					} // for

					numberOfControls = 1;
				}

				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\' id=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\' id=\'numberOfControls\'>");
				temp.append("<input type=\'hidden\' value=\'" + fieldRef + "\' name=\'fieldRefConsent\' id=\'fieldRefConsent\'>");
			} else if (fieldType.toLowerCase().equals("date")) {
				if (fieldValue != null && fieldValue.length() > 0){
					int spc = fieldValue.indexOf(" ");
					if (spc > -1)
						fieldValue = fieldValue.substring(0,spc);
				}
				else
					fieldValue = "";

				temp.append("<input size=\"10\" "
						+ " maxlength=\"10\" "
						+ " type=\"text\" class=\"" + requiredInput + "\" "
						+ " value=\"" + fieldValue + "\" "
						+ " id=\"" + fieldName + "\""
						+ " name=\"" + fieldName + "\">");
				temp.append("&nbsp;<A HREF=\"#\" onClick=\"dateCal.select(document.forms[0]."+fieldName+",'anchorDate','MM/dd/yyyy'); return false;\" NAME=\"anchorDate\" ID=\"anchorDate\" class=\"linkcolumn\">(MM/DD/YYYY)</A>");

			} else if (fieldType.toLowerCase().equals("listbox")) {

				if (fieldRef.toLowerCase().indexOf(Constant.COURSE_EFFECTIVETERM)>-1){
					String limitEffectiveTermListing = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","LimitEffectiveTermListing");
					if (limitEffectiveTermListing.equals(Constant.ON)){

						//
						// we'll limit the listing and include at least the currently selected term
						//
						if(!fieldValue.equals(Constant.BLANK)){
							sql = "SELECT TERM_CODE,TERM_DESCRIPTION "
								+ "FROM bannerterms "
								+ "WHERE CAST(substring(term_code,1,4) AS INT) >= YEAR(getdate()) "
								+ "OR TERM_CODE='" + fieldValue + "' "
								+ "ORDER BY TERM_CODE DESC";
						}
						else{
							sql = "SELECT TERM_CODE,TERM_DESCRIPTION "
								+ "FROM bannerterms "
								+ "WHERE CAST(substring(term_code,1,4) AS INT) >= YEAR(getdate()) "
								+ "ORDER BY TERM_CODE DESC";
						}

						temp.append(ae.createSelectionBox(conn,sql,fieldName,fieldValue,required));
					}
					else{
						sql = ae.lookUp(conn, "tblINI", "kval1", "kid = " + ae.toSQL(fieldRef, 1));
						temp.append(ae.createSelectionBox(conn,sql,fieldName,fieldValue,required));
					}
				}
				else{
					sql = ae.lookUp(conn, "tblINI", "kval1", "kid = " + ae.toSQL(fieldRef, 1));
					temp.append(ae.createSelectionBox(conn,sql,fieldName,fieldValue,required));
				}

			} else if (fieldType.toLowerCase().equals("listboxrange")) {

				if ((Constant.COURSE_CREDITS).equals(column)){
					kval3 = IniDB.getIniByCampusCategoryKidKey3(conn,campus,"System","NumberOfCreditsRangeValue");
					temp.append(ae.createSelectionBoxWithRange(fieldName,fieldLen,fieldMax,required,fieldValue,kval3));
				}
				else if ((Constant.COURSE_PROGRAM).equals(column)){
					temp.append(ae.createSelectionBoxWithRange(fieldName,fieldLen,fieldMax,required,fieldValue,kval3));
				}

			} else if (fieldType.toLowerCase().equals("text")) {
				countThistext = true;
				String htmlType = "text";

				if (fieldType.equals("texthidden")){
					htmlType = "hidden";
				}

				// is user providing a desired field input length
				if (NumericUtil.nullToZero(userlen) > 0){
					fieldMax = userlen;
				} // userlen

				temp.append("<input size=\"" + fieldLen + "\" "
						+ " maxlength=\"" + fieldMax + "\" "
						+ " type=\""+htmlType+"\" class=\"" + requiredInput + "\" "
						+ " value=\"" + fieldValue + "\" "
						+ " id=\"" + fieldName + "\" ___"
						+ " name=\"" + fieldName + "\" ___>");

				actualFieldLen = fieldMax;

			} else if (fieldType.toLowerCase().contains("textarea")) {

				countThistext = true;

				// if textarea contains a number, that's the number of characters to set as maxlength
				// if a conversion from text to int is an exception, set default to 200.
				// if not, set the value to fieldMax because we have to do some work around
				// to set the rows=fieldMax and in case we have to to include a text counter,
				// we have to reuse fieldMax again.
				int maxTextAreaChars = 0;
				if (fieldType.indexOf("textarea") > -1) {
					String textArea = fieldType.substring(8);
					try{
						maxTextAreaChars = Integer.parseInt(textArea+"T");
					}
					catch(Exception e){
						maxTextAreaChars = 200;
					}
				}
				else{
					maxTextAreaChars = fieldMax;
				}

				// is user providing a desired field input length
				if (NumericUtil.nullToZero(userlen) > 0){
					maxTextAreaChars = userlen;
				} // userlen

				temp.append("<textarea cols=\'" + fieldLen + "\'"
						+ " rows=\'" + fieldMax + "\'"
						+ " class=\'" + requiredInput + "\'"
						+ " id=\'" + fieldName + "\' ___"
						+ " name=\'" + fieldName + "\' ___>"
						+ fieldValue + "</textarea>");

				fieldMax = maxTextAreaChars;

				actualFieldLen = maxTextAreaChars;

			} else if (fieldType.toLowerCase().equals("wysiwyg")) {
				temp.append("<textarea class=\"" + requiredInput + "\""
						+ " id=\"" + fieldName + "\""
						+ " name=\"" + fieldName + "\">"
						+ fieldValue
						+ "</textarea>"
						+ "<script language=\'javascript1.2\'>"
						+ "generate_wysiwyg(\'" + fieldName + "\');"
						+ "</script>");
			}

			if (systemCountText.equals(Constant.ON) && countThistext){
				textCounter = " onKeyDown=\"textCounter(document.aseForm."+fieldName+",document.aseForm.textLen,"+actualFieldLen+")\""
					+ " onKeyUp=\"textCounter(document.aseForm."+fieldName+",document.aseForm.textLen,"+actualFieldLen+")\"";
				html = temp.toString().replace("___",textCounter);
				html = html
					+ "<p><div  class=\"w3cbutton3\" id=\"inputCounter\"></div>"
					+ "<input readonly class=\"input\" type=\"hidden\" name=\"textLen\" size=\"3\" maxlength=\""+fieldMax+"\" value=\""+actualFieldLen+"\"></p>";
			}
			else{
				html = temp.toString().replace("___","");
			}

		} catch (Exception pe) {
			logger.fatal(pe.toString());
		}

		return html;
	} // drawHTMLFieldX

	/**
	 * radioYESNO
	 * <p>
	 * @param value		String
	 * @param fieldName	String
	 * @param display		boolean
	 * <p>
	 * @return String
	 */
	public static String radioYESNO(String value,String fieldName,boolean display) {

		return radioYESNO(value,fieldName,display,true);
	}

	public static String radioYESNO(String value,String fieldName,boolean display,boolean defalt) {

		String[] selected = new String[2];
		StringBuffer temp = new StringBuffer();

		selected[0] = "";
		selected[1] = "";

		if ("1".equals(value))
			selected[0] = "checked";
		else
			selected[1] = "checked";

		// don't default values
		if (!defalt && value==null || value.equals(Constant.BLANK)){
			selected[0] = "";
			selected[1] = "";
		}

		if (!display){
			temp.append("<input type=\'radio\' value=\'1\' name=\'" + fieldName + "\'" + " " + selected[0] + ">&nbsp;Yes");
			temp.append("<input type=\'radio\' value=\'0\' name=\'" + fieldName + "\'" + " " + selected[1] + ">&nbsp;No");
		}
		else{
			if ("1".equals(value))
				temp.append("YES");
			else
				temp.append("NO");
		}

		return temp.toString();
	}

	/**
	 * @param conn	 	Connection
	 * @param userid	String
	 * @param script	String
	 * @param action	String
	 * @param alpha	String
	 * @param num		String
	 * @param campus	String
	 */
	public static void logAction(Connection conn,
											String userid,
											String script,
											String action,
											String alpha,
											String num,
											String campus) {

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");
		logAction(conn,userid,script,action,alpha,num,campus,kix);
	}

	public static void logAction(Connection conn,
											String userid,
											String script,
											String action,
											String alpha,
											String num,
											String campus,
											String historyid) {

		try {
			if (script.indexOf(".jsp") > -1 ){
				script = "";
			}

			String kix = Helper.getKix(conn,campus,alpha,num,"");
			if (kix == null || kix.equals(Constant.BLANK)){
				if (alpha != null && !alpha.equals(Constant.BLANK)){
					action = action + " - " + alpha;
				}
				alpha = "";
				num = "";
			}

			boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);
			if(!isAProgram){
				com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();
				boolean foundation = fnd.isFoundation(conn,kix);
				if(foundation){
					String[] info = fnd.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_ALPHA];
					num = info[Constant.KIX_NUM];
					action = action + " - " + alpha;
				}
				fnd = null;
			} // isAProgram

			if (action.indexOf(",") > 0){
				action = action.replace(",",", ");
			}

			// prevent size/truncate error
			if (action != null && action.length() > 500){
				action = action.substring(500);
			}

			PreparedStatement ps = conn.prepareStatement("INSERT INTO tblUserLog (userid,script,action,alpha,num,campus,historyid) VALUES(?,?,?,?,?,?,?) ");
			ps.setString(1,userid);
			ps.setString(2,script);
			ps.setString(3,action);
			ps.setString(4,alpha);
			ps.setString(5,num);
			ps.setString(6,campus);
			ps.setString(7,historyid);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("AseUtil: logAction - "
							+ e.toString()
							+ "\n"
							+ "---------------------"
							+ "\n userid: " + userid
							+ "\n script: " + script
							+ "\n action: " + action
							+ "\n alpha: " + alpha
							+ "\n num: " + num
							+ "\n campus: " + campus
							+ "\n historyid: " + historyid
							);
		} catch (Exception e) {
			logger.fatal("AseUtil: logAction - " + e.toString());
		}

	}

	/**
	 * @param p1 String
	 */
	public static void loggerInfo(String p1) {

		try {
			if (p1 == null) p1 = "";
			logger.info(p1);
		} catch (Exception e) {
			logger.fatal("AseUtil: loggerInfo - " + e.toString());
		}

	}

	/**
	 * @param p1 String
	 * @param p2 String
	 * @param p3 String
	 * @param p4 String
	 * @param p5 String
	 */
	public static void loggerInfo(String p1, String p2, String p3, String p4,String p5) {

		try {
			if (p1 == null) p1 = "";
			if (p2 == null) p2 = "";
			if (p3 == null) p3 = "";
			if (p4 == null) p4 = "";
			if (p5 == null) p5 = "";

			logger.info(p1 + " - " + p2 + " - " + p3 + " - " + p4 + " - " + p5);
		} catch (Exception e) {
			logger.fatal("AseUtil: loggerInfo - " + e.toString());
		}

	}

	/**
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logMail(Connection conn,Mailer mailer) {

		// default is all mail sent has been processed
		logMail(conn,mailer,1);
	}

	/**
	 * <p>
	 * @param conn		connection
	 * @param mailer	Mailer
	 */
	public static void logMail(Connection conn, Mailer mailer, int processed) {

		// SAME CODE in MAILERDB

		try {
			String campus = mailer.getCampus();
			String subject = mailer.getSubject();
			String alpha = mailer.getAlpha();
			String num = mailer.getNum();

			String kix = Helper.getKix(conn,campus,alpha,num,"");
			if (kix == null || (Constant.BLANK).equals(kix)){
				subject = subject + " - " + alpha;
				alpha = "";
				num = "";
			}

			// correct file naming for links if needed later
			String attachment = mailer.getAttachment();
			if (attachment != null && attachment.length() > 0){
				attachment = attachment.replace(AseUtil.getCurrentDrive()+":","");
				attachment = attachment.replace("\\\\","\\");
				attachment = attachment.replace("tomcat\\","");
				attachment = attachment.replace("webapps\\","");
				attachment = attachment.replace("\\","/");
			}

			PreparedStatement ps = conn.prepareStatement(
					"INSERT INTO tblMail ([from],[to],cc,bcc,subject,alpha,num,campus,dte,content,processed,attachment) "
				+	"VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ");
			ps.setString(1, mailer.getFrom());
			ps.setString(2, mailer.getTo());
			ps.setString(3, mailer.getCC());
			ps.setString(4, mailer.getBCC());
			ps.setString(5, subject);
			ps.setString(6, alpha);
			ps.setString(7, num);
			ps.setString(8, campus);
			ps.setString(9, getCurrentDateTimeString());
			ps.setString(10, mailer.getContent());
			ps.setInt(11,processed);
			ps.setString(12,attachment);
			int rowsAffected = ps.executeUpdate();
			ps.close();

			//logger.info("AseUtil: logMail - mail sent - FROM: " + mailer.getFrom() + " TO: " + mailer.getTo());

		} catch (Exception e) {
			logger.fatal("AseUtil: logMail - " + e.toString());
		}
	}

	/**
	 * returns string containing join array of strings
	 * <p>
	 * @param aryString array of string to join
	 * <p>
	 * @return String
	 */
	public String join(String[] aryString) {
		StringBuffer str = new StringBuffer();
		String temp = "";

		str.append("");

		if (aryString == null || aryString.length == 0)
			return str.toString();

		for (int i = 0; i < aryString.length; i++) {
			str.append(aryString[i] + ",");
		}

		temp = str.toString();
		temp = temp.substring(0, temp.length() - 1);

		return temp;
	}

	/**
	 * returns string with HTML encoded
	 * <p>
	 *
	 * @param s string to encode
	 * <p>
	 * @return String
	 */
	public static String HTMLEncode(String s) {
		if (s == null)
			return "";

		StringBuffer st = new StringBuffer();

		for (int i = 0; i < s.length(); i++) {
			boolean copy = true;

			char ch = s.charAt(i);

			for (int j = 0; j < c.length; j++) {
				if (c[j] == ch) {
					st.append(expansion[j]);
					copy = false;
					break;
				}
			}

			if (copy)
				st.append(ch);
		}

		return st.toString();
	}

	/**
	 * returns true if the object is a number
	 * <p>
	 *
	 * @param s	string to check
	 * <p>
	 * @return boolean
	 */
	public boolean isNumeric(Object s) {
		try {
			Double.parseDouble((String) s);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public static String getCurrentDirectory() {

		File dir = new File(".");
		String directory = "";
		try {
			directory = dir.getCanonicalPath();
		} catch (Exception e) {
			logger.fatal("AseUtil: currentDirectory - " + e.toString());
		}

		return directory;
	}

	public static String getCurrentDrive() {

		String currentDrive = "";

		try {
			currentDrive = getCurrentDirectory().substring(0, 1);
		} catch (Exception e) {
			logger.fatal("AseUtil: getCurrentDrive - " + e.toString());
		}

		return currentDrive;
	}

	public static String getUploadFolder(Connection conn,String destination) {

		String uploadFolder = null;

		try {
			uploadFolder = getCurrentDrive()
							+ ":"
							+ SysDB.getSys(conn,"documents")
							+ destination;

		} catch (Exception e) {
			logger.fatal("AseUtil: getUploadFolder - " + e.toString());
		}

		return uploadFolder;
	}

	/**
	 * returns getReportFolder
	 * <p>
	 * @return String
	 */
	public static String getReportFolder() {

		String reportFolder = "";

		try {
			reportFolder = getCurrentDirectory().substring(0, 1) + Constant.REPORT_DESIGN_FOLDER;
		} catch (Exception e) {
			logger.fatal("AseUtil: getReportFolder - " + e.toString());
		}

		return reportFolder;
	}

	/**
	 * returns getReportOutputFolder - the folder containing the user report
	 * <p>
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public static String getReportOutputFolder(String campus) {

		String reportOutputFolder = "";

		try {
			reportOutputFolder = getCurrentDirectory().substring(0, 1)
									+ Constant.REPORT_OUTPUT_FOLDER
									+ campus;
		} catch (Exception e) {
			logger.fatal("AseUtil: getReportFolder - " + e.toString());
		}

		return reportOutputFolder;
	}

	/**
	 * returns getCampusLogo
	 * <p>
	 * @param	campus	String
	 * <p>
	 * @return String
	 */
	public static String getCampusLogo(String campus) {

		String campusLogo = "";

		try {
			campusLogo = getCurrentDirectory().substring(0, 1)
									+ Constant.REPORT_LOGO_FOLDER
									+ "logo"
									+ campus + ".jpg";
		} catch (Exception e) {
			logger.fatal("AseUtil: getCampusLogo - " + e.toString());
		}

		return campusLogo;
	}

	/**
	 * returns date formatted string
	 * <p>
	 *
	 * @param s
	 *            string to encode
	 *            <p>
	 * @return String
	 */
	public String getDateFormatString(String s) {
		String format = "";

		if (s.equals("USDATE")) {
			format = "mm/dd/yyyy";
		} else if (s.equals("DATE")) {
			format = "yyyy/mm/dd";
		} else if (s.equals("EURODATE")) {
			format = "dd/mm/yyyy";
		}

		return format;
	}

	/**
	 * returns data type in use (oracle or access)
	 * <p>
	 *
	 * @return String
	 */
	public static String getDriverType() {

		String driverType = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		driverType = bundle.getString("databaseDriver");

		return driverType;
	}

	/**
	 * returns data type in use (oracle or access)
	 * <p>
	 *
	 * @return String
	 */
	public static String getTestSystem() {

		String testSystem = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		testSystem = bundle.getString("testSystem");

		return testSystem;
	}

	/**
	 * returns data type in use (oracle or access)
	 * <p>
	 *
	 * @return int
	 */
	public static int getDriverType(int x) {

		//String driverType = null;

		//ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		//driverType = bundle.getString("databaseDriver");

		//if ("Access".equals(driverType))
		//	driver = Constant.DATABASE_DRIVER_ACCESS;
		//else if ("AccessSQL".equals(driverType))
		//	driver = Constant.DATABASE_DRIVER_ACCESSSQL;
		//else if ("Oracle".equals(driverType))
		//	driver = Constant.DATABASE_DRIVER_ORACLE;
		//else if ("SQL".equals(driverType))
		//	driver = Constant.DATABASE_DRIVER_SQL;

		int driver = 0;

		driver = Constant.DATABASE_DRIVER_SQL;

		return driver;
	}

	/**
	 * returns debug mode
	 * <p>
	 *
	 * @return String
	 */
	public static String getDebugMode() {

		String debugMode = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		debugMode = bundle.getString("debugMode");

		return debugMode;
	}

	/**
	 * returns the logging file name
	 * <p>
	 *
	 * @return String
	 */
	public static String getLogFile() {

		String logFile = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		logFile = bundle.getString("logFile");

		return logFile;
	}

	/**
	 * returns the home folder
	 * <p>
	 *
	 * @return String
	 */
	public static String getHome() {

		String home = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		home = bundle.getString("home");

		return home;
	}

	/**
	 * returns the tracing file name
	 * <p>
	 *
	 * @return String
	 */
	public static String getTraceFile() {

		String traceFile = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		traceFile = bundle.getString("traceFile");

		return traceFile;
	}

	/**
	 * returns the location for logger files
	 * <p>
	 *
	 * @return String
	 */
	public static String getLoggerLocation() {

		String logger = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		logger = bundle.getString("logger");

		return logger;
	}

	/**
	 * returns the location of xml schemas
	 * <p>
	 *
	 * @return String
	 */
	public static String getXMLSchemas() {

		String xmlSchemas = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		xmlSchemas = bundle.getString("xmlSchemas");

		return xmlSchemas;
	}

	/**
	 * returns the OS used for this app
	 * <p>
	 *
	 * @return String
	 */
	public static String getOS() {

		String OS = null;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		OS = bundle.getString("OS");

		return OS;
	}

	/**
	 * returns string with HTML encoded
	 * <p>
	 * @param s	date string to work on
	 * <p>
	 * @return boolean
	 */
	public boolean isDate(String s) {

		if (s == null)
			return true;

		String format = "";
		DateFormat df = DateFormat.getInstance();

		format = getDateFormatString("MM/dd/yyyy");

		try {
			if (format.length() > 0) {
				df = new SimpleDateFormat(format);
				((SimpleDateFormat) df).parse(s);
			} else {
				df.parse(s);
			}

			return true;
		} catch (ParseException e) {
			return false;
		}
	}

	/**
	 * returns string with HTML encoded
	 * <p>
	 * @param s				date string to work on
	 * @param dateFormat	date format
	 * <p>
	 * @return boolean
	 */
	public boolean isDate(String s,String dateFormat) {

		if (s == null)
			return true;

		String format = "";
		DateFormat df = DateFormat.getInstance();

		format = getDateFormatString(dateFormat);

		try {
			if (format.length() > 0) {
				df = new SimpleDateFormat(format);
				((SimpleDateFormat) df).parse(s);
			} else {
				df.parse(s);
			}

			return true;
		} catch (ParseException e) {
			return false;
		}
	}

	/**
	 * returns string with HTML encoded
	 * <p>
	 *
	 * @param s
	 *            date string to work on
	 * @param dateFormat
	 *            date format
	 * @param locale
	 *            location
	 *            <p>
	 * @return boolean
	 */
	public boolean isDate(String s, String dateFormat, Locale locale) {

		if (s == null)
			return true;

		String format = "";
		DateFormat df = DateFormat.getInstance();

		format = getDateFormatString(dateFormat);

		try {
			if (format.length() > 0) {
				df = new SimpleDateFormat(format, locale);
				((SimpleDateFormat) df).parse(s);
			} else {
				df.parse(s);
			}

			return true;
		} catch (ParseException e) {
			return false;
		}
	}

	/**
	 * returns string date in requested format
	 * <p>
	 * @param date 			String
	 * @param aNamedFormat 	int
	 * <p>
	 * @return String
	 */
	public String ASE_FormatDateTime(String date, int aNamedFormat) {
		String temp = "";

		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date);
			java.sql.Timestamp ts = new java.sql.Timestamp(dt.getTime());
			temp = ASE_FormatDateTime(ts, aNamedFormat, Locale.getDefault());
		} catch (Exception e) {
			temp = "";
		}

		return temp;
	}

	public String ASE_FormatDateTime(java.sql.Date date, int aNamedFormat) {
		java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
		return ASE_FormatDateTime(ts, aNamedFormat, Locale.getDefault());
	}

	public String ASE_FormatDateTime(Object date, int aNamedFormat) {
		return ASE_FormatDateTime(date, aNamedFormat, Locale.getDefault());
	}

	public String ASE_FormatDateTime(Object ADate, int aNamedFormat, Locale locale) {

		if (ADate == null)
			return "";

		if (!(ADate instanceof Timestamp))
			return ADate.toString();

		SimpleDateFormat formatter;
		DateFormat dateformat;
		Timestamp ts = (Timestamp)ADate;
		String output = "";
		try {
			switch (aNamedFormat) {
				case 0:
					dateformat = DateFormat.getDateTimeInstance(DateFormat.SHORT,DateFormat.DEFAULT, locale);
					output = dateformat.format(ts);
					break;
				case Constant.DATE_LONG:
					dateformat = DateFormat.getDateInstance(DateFormat.LONG, locale);
					output = dateformat.format(ts);
					break;
				case Constant.DATE_SHORT:
					formatter = new SimpleDateFormat("MM/dd/yy", locale);
					output = formatter.format(ts);
					break;
				case Constant.DATE_DEFAULT:
					dateformat = DateFormat.getTimeInstance(DateFormat.DEFAULT,locale);
					output = dateformat.format(ts);
					break;
				case Constant.DATE_TIME:
					formatter = new SimpleDateFormat("H:k:ss", locale);
					output = formatter.format(ts);
					break;
				case Constant.DATE_DATE_YMD:
					formatter = new SimpleDateFormat("yyyy/MM/dd", locale);
					output = formatter.format(ts);
					break;
				case Constant.DATE_DATE_MDY:
					formatter = new SimpleDateFormat(Constant.CC_DATE_FORMAT, locale);
					output = formatter.format(ts);
					break;
				case Constant.DATE_DATE_DMY:
					formatter = new SimpleDateFormat("dd/MM/yyyy", locale);
					output = formatter.format(ts);
					break;
				case Constant.DATE_DATETIME:
					formatter = new SimpleDateFormat("MM/dd/yyyy h:mm a", locale);
					output = formatter.format(ts);
					break;
				default:
					dateformat = DateFormat.getDateTimeInstance(
							java.text.DateFormat.SHORT,
							java.text.DateFormat.DEFAULT, locale);
					output = dateformat.format(ts);
					break;
			}
		} catch (Exception e) {
			output = "";
		}

		// correct date problem when it returns as something like
		// String output = "09/08/2016 12:00 AM";
		if (!output.equals(Constant.BLANK) && output.indexOf("12:00") > -1){
			output = output.substring(0,output.indexOf("12:00")-1);
		}

		return output;
	}

	/**
	 * returns Timestamp
	 * <p>
	 * @param ADate 		date object
	 * @param dateFormat	format
	 * @param locale		location
	 * <p>
	 * @return Timestamp
	 */
	public java.sql.Timestamp ASE_UnFormatDateTime(String ADate,
			String dateFormat, Locale locale) {

		if (ADate == null)
			return null;

		DateFormat df = DateFormat.getInstance();
		String format = "";
		ADate = ADate.trim().replaceAll("  ", " ");

		String[] arDateTime = ADate.split(" ");
		if (arDateTime.length == 0) {
			return null;
		}

		format = getDateFormatString(dateFormat);

		try {
			if (format.length() > 0) {
				df = new SimpleDateFormat(format, locale);
				return new java.sql.Timestamp(((SimpleDateFormat) df).parse(
						ADate).getTime());
			} else {
				return new java.sql.Timestamp(df.parse(ADate).getTime());
			}
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * returns currency formatted
	 * <p>
	 *
	 * @param obj
	 * @param numDigitsAfterDecimal
	 * @param includeLeadingDigit
	 * @param useParensForNegativeNumbers
	 * @param groupDigits
	 * @param locale
	 *            <p>
	 * @return String
	 */
	public String ASE_FormatCurrency(Object obj, int numDigitsAfterDecimal,
			int includeLeadingDigit, int useParensForNegativeNumbers,
			int groupDigits, Locale locale) {
		double value = 0;
		try {
			value = Double.parseDouble((String) obj);
		} catch (Exception e) {
			return (String) obj;
		}

		DecimalFormat formatter = (DecimalFormat) DecimalFormat
				.getCurrencyInstance(locale);
		StringBuffer pattern = new StringBuffer();

		if (includeLeadingDigit != 0) {
			pattern.append("\u00A40");
		} else {
			pattern.append("\u00A4#");
		}

		if (numDigitsAfterDecimal > 0) {
			pattern.append(".");
			for (int i = 0; i < numDigitsAfterDecimal; i++) {
				pattern.append("0");
			}
		}

		if (useParensForNegativeNumbers != 0) {
			pattern.append(";(" + pattern + ")");
		}

		formatter.applyPattern(pattern.toString());

		if (groupDigits != 0) {
			formatter.setGroupingUsed(true);
			formatter.setGroupingSize(3);
		}

		try {
			return formatter.format(value);
		} catch (Exception e) {
			return (String) obj;
		}
	}

	/**
	 * returns string formatted number
	 * <p>
	 *
	 * @param obj
	 * @param numDigitsAfterDecimal
	 * @param includeLeadingDigit
	 * @param useParensForNegativeNumbers
	 * @param groupDigits
	 * @param locale
	 *            <p>
	 * @return String
	 */
	public String ASE_FormatNumber(Object obj, int numDigitsAfterDecimal,
			int includeLeadingDigit, int useParensForNegativeNumbers,
			int groupDigits, Locale locale) {
		double value = 0;
		try {
			value = Double.parseDouble((String) obj);
		} catch (Exception e) {
			return (String) obj;
		}
		DecimalFormat formatter = (DecimalFormat) DecimalFormat
				.getNumberInstance(locale);

		StringBuffer pattern = new StringBuffer();
		if (includeLeadingDigit != 0) {
			pattern.append("0");
		} else {
			pattern.append("#");
		}
		if (numDigitsAfterDecimal > 0) {
			pattern.append(".");
			for (int i = 0; i < numDigitsAfterDecimal; i++) {
				pattern.append("0");
			}
		}
		if (useParensForNegativeNumbers != 0) {
			pattern.append(";(" + pattern + ")");
		}
		formatter.applyPattern(pattern.toString());
		if (groupDigits != 0) {
			formatter.setGroupingUsed(true);
			formatter.setGroupingSize(3);
		}
		try {
			return formatter.format(value);
		} catch (Exception e) {
			return (String) obj;
		}
	}

	/**
	 * returns string formatted percent
	 * <p>
	 *
	 * @param obj
	 * @param numDigitsAfterDecimal
	 * @param includeLeadingDigit
	 * @param useParensForNegativeNumbers
	 * @param groupDigits
	 * @param locale
	 *            <p>
	 * @return String
	 */
	public String ASE_FormatPercent(Object obj, int numDigitsAfterDecimal,
			int includeLeadingDigit, int useParensForNegativeNumbers,
			int groupDigits, Locale locale) {
		double value = 0;
		try {
			value = Double.parseDouble((String) obj);
		} catch (Exception e) {
			return (String) obj;
		}
		DecimalFormat formatter = (DecimalFormat) DecimalFormat
				.getPercentInstance(locale);
		StringBuffer pattern = new StringBuffer();
		if (includeLeadingDigit != 0) {
			pattern.append("0");
		} else {
			pattern.append("#");
		}
		if (numDigitsAfterDecimal > 0) {
			pattern.append(".");
			for (int i = 0; i < numDigitsAfterDecimal; i++) {
				pattern.append("0");
			}
		}
		pattern.append("%");
		if (useParensForNegativeNumbers != 0) {
			pattern.append(";(" + pattern + ")");
		}
		formatter.applyPattern(pattern.toString());
		if (groupDigits != 0) {
			formatter.setGroupingUsed(true);
			formatter.setGroupingSize(3);
		}
		try {
			return formatter.format(value);
		} catch (Exception e) {
			return (String) obj;
		}
	}

	/**
	 * returns string with HTML encoded
	 * <p>
	 *
	 * @param s
	 *            string to encode
	 *            <p>
	 * @return String
	 */
	public String ASE_GetFileType(String s) {
		if (s.equals("image/gif") || s.equals("image/jpeg")
				|| s.equals("image/tiff") || s.equals("image/x-png")) {
			return "image/";
		} else if (s.equals("application/pdf")
				|| s.equals("application/msword")
				|| s.equals("application/mspowerpoint")
				|| s.equals("application/ms-excel")
				|| s.equals("application/ms-powerpoint")
				|| s.equals("application/rtf")) {
			return "doc/";
		} else {
			return "";
		}
	}

	/**
	 * returns sql date
	 * <p>
	 * <p>
	 *
	 * @return java.sql.Date
	 */
	public static java.sql.Date getCurrentDate() {

		//java.util.Date today = new java.util.Date();
		//return new java.sql.Date(today.getTime());

		long longDate = 0;

		try{

			com.ase.aseutil.datetime.DateTime dt = new com.ase.aseutil.datetime.DateTime();
			int yy = dt.getYear();
			int mm = dt.getMonth();
			int dd = dt.getDay();

			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			String today = "" + mm + "/" + dd + "/" + yy;
			java.util.Date date = formatter.parse(today);

			longDate = date.getTime();

		}
		catch(ParseException e){
			logger.fatal("AseUtil.getCurrentDate - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("AseUtil.getCurrentDate - " + e.toString());
		}

		return new java.sql.Date(longDate);

	}

	/**
	 * returns string with current date
	 * <p>
	 * <p>
	 *
	 * @return String
	 */
	public static String getCurrentDateString() {

		//DateFormat dateFormat = new SimpleDateFormat(Constant.CC_DATE_FORMAT);
		//java.util.Date today = new java.util.Date();
		//return dateFormat.format(today.getTime());

		Calendar calendar = new GregorianCalendar(TimeZone.getDefault());
		DateFormat dateFormat = new SimpleDateFormat(Constant.CC_DATE_FORMAT);
		dateFormat.setTimeZone(TimeZone.getTimeZone("HST"));

		return dateFormat.format(calendar.getTime());

	}

	/**
	 * returns string with current date and time
	 * <p>
	 * <p>
	 *
	 * @return String
	 */
	public static String getCurrentDateTimeString() {

		//DateFormat dateFormat = new SimpleDateFormat(Constant.CC_DATE_FORMAT_SS);
		//java.util.Date today = new java.util.Date();
		//return dateFormat.format(today.getTime());

		Calendar calendar = new GregorianCalendar(TimeZone.getDefault());
		DateFormat dateFormat = new SimpleDateFormat(Constant.CC_DATE_FORMAT_SS);
		dateFormat.setTimeZone(TimeZone.getTimeZone("HST"));

		return dateFormat.format(calendar.getTime());

	}

	/**
	 * addToDate
	 * <p>
	 * @param numberOfDays int
	 * <p>
	 * @return String
	 */
	public static String addToDate(int numberOfDays) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, numberOfDays);
		String DATE_FORMAT = "MM/dd/yyyy";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		return sdf.format(cal.getTime());
	}

	/**
	 * Displays copyright
	 *
	 * <p>
	 *
	 *	@return	String
	 */
	public String copyright() {

		String _copyright = "Copyright ©1999-2007 All rights reserved.";

		try {
			//ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
			//_copyright = bundle.getString("copyright");
			int year = Calendar.getInstance().get(Calendar.YEAR);
			_copyright = "Copyright ©1999-"+year+" All rights reserved.";
		} catch (Exception e) {
			logger.fatal("AseUtil: copyright - " + e.toString());
		}

		return _copyright;
	}

	/**
	 * returns sendMail request YES or NO
	 * <p>
	 *
	 * @return boolean
	 */
	public static boolean sendMail() {

		boolean send = false;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		String sendText = bundle.getString("sendMail");
		if (sendText != null && sendText.equalsIgnoreCase("yes"))
			send = true;

		return send;
	}

	/**
	 * expandText
	 * <p>
	 * @param	text
	 * @param	ifText
	 * @param	elseText
	 * @param	otherwise
	 * <p>
	 * @return String
	 */
	public static String expandText(String text,String ifText,String elseText,String otherwise) {

		String expandedText = "";

		if (text != null){
			if (text.equals(Constant.ON))
				expandedText = ifText;
			else if (text.equals(Constant.OFF))
				expandedText = elseText;
			else
				expandedText = otherwise;
		}
		else
			expandedText = otherwise;

		return expandedText;
	}

	/**
	 * showTimer
	 */
	public static String showTimer(){

		return getCurrentDateTimeString();

	}

	/**
	 * createSelectionBoxWithRange
	 * <p>
	 *
	 * @return String
	 */
	public static String createSelectionBoxWithRange(String controlName,
																		int start,
																		int end,
																		boolean required,
																		String defaultValue) {

		String temp = createSelectionBoxWithRange(controlName,
																start,
																end,
																required,
																defaultValue,
																"");
		return temp;
	}

	public static String createSelectionBoxWithRange(String controlName,
																		int start,
																		int end,
																		boolean required,
																		String defaultValue,
																		String xtraValues) {

		StringBuffer temp = new StringBuffer();
		String requiredInput = "smalltext";
		String strSelect = "";
		String size = "1";

		if (required)
			requiredInput = "smalltextrequired";

		try {
			temp.append("<select name=\'" + controlName + "\' size=\'1\' class=\'" + requiredInput + "\'>\n");

			if (start >= 0 && end > 0){
				for(int i=start; i<=end; i++){
					strSelect = "";

					if ((""+i).equals(defaultValue))
						strSelect = "selected";

					temp.append("<option value=\'" + i + "\' " + strSelect + ">" + i + "</option>\n");
				}
			}
			else
				temp.append("<option value=\'0\'>0</option>\n");

			if (xtraValues != null && !(Constant.BLANK).equals(xtraValues)){
				String[] aXtraValues = xtraValues.split(",");
				if (aXtraValues != null){
					int iXtraValues = aXtraValues.length;
					for(int i = 0; i < iXtraValues; i++){
						strSelect = "";

						if ((aXtraValues[i]).equals(defaultValue))
							strSelect = "selected";

						temp.append("<option value=\'" + aXtraValues[i] + "\' " + strSelect + ">" + aXtraValues[i] + "</option>\n");
					}
				}
			}

			temp.append("</select>\n");

		} catch (Exception e) {
			temp.append(e.toString());
		}

		return temp.toString();
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static String nullToValue(String val,String defalt) {

		if (val==null || val.equals("null") || val.length()== 0)
			val = defalt;

		if (val.length() > 0)
			val = val.trim();

		return val;
	}

	/**
	 * returns true if the String argument is empty
	 */
	public static int nullToValue(int val,int defalt) {

		int temp = 0;

		if (Integer.toString(val) == null)
			temp = defalt;
		else
			temp = val;

		return temp;
	}

}