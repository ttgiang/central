/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class SQLValues {

	static Logger logger = Logger.getLogger(SQLValues.class.getName());

	static String ASE_PROPERTIES = "ase.central.Ase";

	/*
	 * getSrcData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	item		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getSrcData(Connection conn,String campus,String kix,String src,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			if (!item.equals("descr")){
				item = "key";
			}

			// GESLO has a grid as well as list of data. We are assuming that they
			// only use one or the other
			if (src.equals(Constant.COURSE_GESLO)){

				String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
				if(useGESLOGrid.equals(Constant.ON)){
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,item);
				}
				else{
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,src,item);
				}

			}
			else{
				if (src.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,item);
				else if (src.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = SQLValues.getTCompetency(conn,campus,kix,item);
				else if (src.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,item);
				else if (src.equals(Constant.COURSE_METHODEVALUATION))
					returnedValues = SQLValues.getTINIMethodEval(conn,campus,kix,item);
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,src,item);
			}

		} catch (SQLException ex) {
			logger.fatal("SQLValues: getSrcData - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getSrcData - " + e.toString());
		}

		return returnedValues;
	}

	/*
	 * getDstData
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	item		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getDstData(Connection conn,String campus,String kix,String dst,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {

			if (!item.equals("descr")){
				item = "key";
			}

			if (dst.equals(Constant.COURSE_GESLO)){

				String useGESLOGrid = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","UseGESLOGrid");
				if(useGESLOGrid.equals(Constant.ON)){
					returnedValues = SQLValues.getTINIGESLO(conn,campus,kix,item);
				}
				else{
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,dst,item);
				}

			}
			else{
				if (dst.equals(Constant.COURSE_COMPETENCIES))
					returnedValues = SQLValues.getTCompetency(conn,campus,kix,item);
				else if (dst.equals(Constant.COURSE_OBJECTIVES))
					returnedValues = SQLValues.getTComp(conn,campus,kix,item);
				else if (dst.equals(Constant.COURSE_METHODEVALUATION))
					returnedValues = SQLValues.getTINIMethodEval(conn,campus,kix,item);
				else if (dst.equals(Constant.COURSE_CONTENT))
					returnedValues = SQLValues.getTContent(conn,campus,kix,item);
				else
					returnedValues = SQLValues.getTGenericContent(conn,campus,kix,dst,item);
			}

		} catch (SQLException ex) {
			logger.fatal("SQLValues: getDstData - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getDstData - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// Generic CONTENT
	//-------------------------------------------------------------------------

	/*
	 * getTGenericContent
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTGenericContent(Connection conn,String campus,String kix,String src,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			String[] info = Helper.getKixInfo(conn,kix);
			String type = info[Constant.KIX_TYPE];

			if ("key".equals(item))
				field = "id";
			else
				field = "comments";

			String sql = "SELECT " + field + " "
				+ "FROM tblGenericContent "
				+ "WHERE campus=? "
				+ "AND coursetype='" + type + "' "
				+ "AND historyid=? "
				+ "AND src=? "
				+ "ORDER BY rdr";
			String xprms[] = {campus,kix,src};
			String xdt[] = {"s","s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,xprms,xdt,kix);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTGenericContent - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTGenericContent - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// CONTENT
	//-------------------------------------------------------------------------

	/*
	 * getTContent
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTContent(Connection conn,String campus,String kix,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			String[] info = Helper.getKixInfo(conn,kix);
			String type = info[Constant.KIX_TYPE];

			if ("key".equals(item))
				field = "contentid";
			else
				field = "longcontent";

			String sql = "SELECT " + field + " "
				+ "FROM tblCourseContent "
				+ "WHERE campus=? "
				+ "AND coursetype='" + type + "' "
				+ "AND historyid=? "
				+ "ORDER BY rdr";
			String xprms[] = {campus,kix};
			String xdt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,xprms,xdt,kix);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTContent - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTContent - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// VALUES
	//-------------------------------------------------------------------------

	/*
	 * getTValues
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	topic		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTValues(Connection conn,String campus,String topic,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			if ("key".equals(item))
				field = "id";
			else
				field = "longdescr";

			String sql = "SELECT " + field + " "
				+ "FROM tblValues "
				+ "WHERE campus=? "
				+ "AND topic=? "
				+ "ORDER BY id";
			String xprms[] = {campus,topic};
			String xdt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,xprms,xdt);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTValues - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTValues - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// COURSE COMPETENCY
	//-------------------------------------------------------------------------

	/*
	 * getTCompetency
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTCompetency(Connection conn,String campus,String kix,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			String[] info = Helper.getKixInfo(conn,kix);
			String type = info[Constant.KIX_TYPE];

			if ("key".equals(item))
				field = "seq";
			else
				field = "content";

			String sql = "SELECT " + field + " "
				+ "FROM tblCourseCompetency "
				+ "WHERE campus=? "
				+ "AND coursetype='" + type + "' "
				+ "AND historyid=? "
				+ "ORDER BY rdr";
			String yprms[] = {campus,kix};
			String ydt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt,kix);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTCompetency - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTCompetency - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// COURSE OBJECTIVES (SLO)
	//-------------------------------------------------------------------------

	/*
	 * getTComp
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTComp(Connection conn,String campus,String kix,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			String[] info = Helper.getKixInfo(conn,kix);
			String type = info[Constant.KIX_TYPE];

			if ("key".equals(item))
				field = "compid";
			else
				field = "comp";

			String sql = "SELECT " + field + " "
				+ "FROM tblCourseComp "
				+ "WHERE campus=? "
				+ "AND coursetype='" + type + "' "
				+ "AND historyid=? "
				+ "ORDER BY rdr";
			String yprms[] = {campus,kix};
			String ydt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt,kix);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTComp - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTComp - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// METHOD EVAL
	//-------------------------------------------------------------------------

	/*
	 * getTINIMethodEval
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	item 		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTINIMethodEval(Connection conn,String campus,String kix,String item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"SQLValues");

			if (debug) logger.info("--------------- SQLValues: getTINIMethodEval - START");

			AseUtil aseUtil = new AseUtil();

			// if method of evaluation has been selected, limit this list to only what was selected;
			// otherwise, show the entire list.
			String sql = "historyid=" + aseUtil.toSQL(kix,1);
			if (debug) logger.info("sql: " + sql);

			String methodEvaluation = aseUtil.lookUp(conn,
																	CourseDB.getCourseTableFromKix(conn,kix),
																	Constant.COURSE_METHODEVALUATION,
																	sql);
			if (debug) logger.info("methodEvaluation: " + methodEvaluation);

			String field = "";

			if ("key".equals(item))
				field = "id";
			else
				field = "kdesc";

			if (debug) logger.info("field: " + field);

			sql = null;

			if (methodEvaluation != null && methodEvaluation.length() > 0){

				if (methodEvaluation.startsWith(",")){
					methodEvaluation = methodEvaluation.substring(1);
				}

				String[] split = SQLValues.splitMethodEval(methodEvaluation);
				if (split != null){
					methodEvaluation = split[0];
				}

				methodEvaluation = CourseDB.methodEvaluationSQL(methodEvaluation);

				if (debug) logger.info("methodEvaluation: " + methodEvaluation);
			} // methodEvaluation

			// DO NOT COMBINE

			if (methodEvaluation != null && methodEvaluation.length() > 0){
				sql = "SELECT " + field + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='MethodEval' "
					+ "AND id IN ("+methodEvaluation+") "
					+ "ORDER BY kdesc";
			}
			else{
				sql = "SELECT " + field + " "
					+ "FROM tblINI "
					+ "WHERE campus=? "
					+ "AND category='MethodEval' "
					+ "ORDER BY kdesc";
			} // methodEvaluation

			if (sql != null){
				String yprms[] = {campus};
				String ydt[] = {"s"};
				returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt,kix);
			}

			if (debug) logger.info("--------------- SQLValues: getTINIMethodEval - END");

		} catch (SQLException e) {
			logger.fatal("SQLValues: getTINIMethodEval - " + e.toString() + "\n kix: " + kix);
		} catch (Exception e) {
			logger.fatal("SQLValues: getTINIMethodEval - " + e.toString() + "\n kix: " + kix);
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// GESLO
	//-------------------------------------------------------------------------

	/*
	 * getTINIGESLO
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTINIGESLO(Connection conn,String campus,String kix,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			if ("key".equals(item))
				field = "id";
			else
				field = "kid + ' - ' + kdesc";

			String sql = "SELECT " + field + " "
				+ "FROM tblINI "
				+ "WHERE campus=? "
				+ "AND category='GESLO' "
				+ "AND id IN (SELECT geid FROM tblGESLO WHERE historyid=?) "
				+ "ORDER BY seq";
			String yprms[] = {campus,kix};
			String ydt[] = {"s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt,kix);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTINIGESLO - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTINIGESLO - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// ILO
	//-------------------------------------------------------------------------

	/*
	 * getTILO
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String[]
	 */
	public static String[] getTILO(Connection conn,String campus,String item) throws Exception {

		// Logger logger = Logger.getLogger("test");

		String[] returnedValues = null;

		try {
			String field = "";

			if ("key".equals(item))
				field = "id";
			else
				field = "shortdescr";

			String sql = "SELECT " + field + " "
						+ "FROM tblValues "
						+ "WHERE campus=? "
						+ "AND (src=? OR src=?) "
						+ "ORDER BY seq";
			String yprms[] = {campus,Constant.COURSE_INSTITUTION_LO,Constant.IMPORT_SLO};
			String ydt[] = {"s","s","s"};
			returnedValues = SQLUtil.resultSetToArray(conn,sql,yprms,ydt);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTILO - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTILO - " + e.toString());
		}

		return returnedValues;
	}

	//-------------------------------------------------------------------------
	// getDstDataCount - START
	//-------------------------------------------------------------------------

	/*
	 * getDstDataCount - count number of records in destination data (if linked)
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 * @param	item		String
	 *	<p>
	 * @return int
	 */
	public static int getDstDataCount(Connection conn,String campus,String kix,String src,String dst) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rtn = 0;

		try {
			String dstName = LinkedUtil.GetKeyNameFromDst(conn,dst);

			if (	dst.equals(Constant.COURSE_COMPETENCIES)
						||	dst.equals(Constant.COURSE_CONTENT)
						||	dst.equals(Constant.COURSE_GESLO)
						||	dst.equals(Constant.COURSE_METHODEVALUATION)
						||	dst.equals(Constant.COURSE_OBJECTIVES)
						||	dst.equals(Constant.COURSE_PROGRAM_SLO)
						||	dst.equals(Constant.COURSE_INSTITUTION_LO)) {
				rtn = SQLValues.getTCourseLinkedCount(conn,campus,kix,src,dstName);
			}
			else{
				rtn = SQLValues.getTGenericContentCount(conn,campus,kix,dstName);
			}

		} catch (SQLException ex) {
			logger.fatal("SQLValues: getDstDataCount - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getDstDataCount - " + e.toString());
		}

		return rtn;
	}

	/*
	 * getTILOCount
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return int
	 */
	public static int getTILOCount(Connection conn,String campus,String item) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String where = "WHERE campus='" + campus + "' AND src='" + item + "'";
			rowsAffected = (int)AseUtil.countRecords(conn,"tblValues",where);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTILOCount - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTILOCount - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getTGenericContentCount
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 *	<p>
	 * @return int
	 */
	public static int getTGenericContentCount(Connection conn,String campus,String kix,String src) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String where = "WHERE campus='" + campus + "' AND historyid='" + kix + "' AND src='" + src + "'";
			rowsAffected = (int)AseUtil.countRecords(conn,"tblGenericContent",where);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTGenericContentCount - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTGenericContentCount - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * getTCourseLinkedCount
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	kix		String
	 * @param	src		String
	 *	<p>
	 * @return int
	 */
	public static int getTCourseLinkedCount(Connection conn,String campus,String kix,String src,String dst) throws Exception {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			String where = "WHERE campus='" + campus + "' AND historyid='" + kix + "' AND src='" + src + "' AND dst='" + dst + "'";
			rowsAffected = (int)AseUtil.countRecords(conn,"tblCourseLinked",where);
		} catch (SQLException ex) {
			logger.fatal("SQLValues: getTCourseLinkedCount - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SQLValues: getTCourseLinkedCount - " + e.toString());
		}

		return rowsAffected;
	}

	//-------------------------------------------------------------------------
	// getDstDataCount - END
	//-------------------------------------------------------------------------

	/*
	 * splitMethodEval
	 *	<p>
	 * @param	value
	 *	<p>
	 * @return String[]
	 */
	public static String[] splitMethodEval(String value) throws Exception {

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

		String[] split = null;
		String left = "";
		String right = "";

		try{
			if(value.indexOf(Constant.SEPARATOR)>-1){
				int junkInt = 0;
				int tempInt = 0;
				String[] tempString = null;
				String[] junkString = null;

				tempString = value.split(",");
				tempInt = tempString.length;

				for(junkInt = 0; junkInt<tempInt; junkInt++){
					junkString = tempString[junkInt].split(Constant.SEPARATOR);

					if (junkInt == 0){
						left = junkString[0];
						right = junkString[1];
					}
					else{
						left = left + "," + junkString[0];
						right = right + "," + junkString[1];
					}
				} // for

				split = new String[2];
				split[0] = left;
				split[1] = right;

			} // value.indexOf(Constant.SEPARATOR)
		}
		catch(Exception e){
			logger.fatal("SQLValues: splitMethodEval - " + e.toString());
		}

		return split;

	}

}