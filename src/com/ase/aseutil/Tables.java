/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
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

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import org.apache.log4j.Logger;
import org.htmlcleaner.CleanerProperties;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.PrettyXmlSerializer;
import org.htmlcleaner.TagNode;

import com.ase.aseutil.jobs.JobName;
import com.ase.aseutil.xml.CreateXml;

public class Tables {

	static Logger logger = Logger.getLogger(Tables.class.getName());

	static String ASE_PROPERTIES = "ase.central.Ase";

	/*
	 * campusOutlines
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public static Msg campusOutlines(){

		 return campusOutlines(Constant.BLANK);

	 }

	 public static Msg campusOutlines(String campus){

		//Logger logger = Logger.getLogger("test");

		String table = "";
		String sql = "";

		Msg msg = new Msg();

		boolean debug = false;

		Connection conn = null;

		int rowsAffected = 0;

		try{

			if (campus == null || campus.equals(Constant.BLANK)){
				campus = "MAN";
			}

			conn = AsePool.createLongConnection();
			if (conn != null){

				AseUtil.logAction(conn, "SYSADM", "ACTION","Create Outlines start","SYSADM","N",campus,"kix");

				msg.setMsg("");

				PreparedStatement ps = null;

				// delete existing data
				sql = "delete from tblCampusOutlines";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();

				// insert data and start from scratch
				table = "tblcourse";
				sql = "insert into tblCampusOutlines (category,coursealpha,coursenum,coursetype) "
					+ "select distinct 'Outline',coursealpha,coursenum,coursetype "
					+ "from " + table + " where coursealpha<>'' AND coursenum<>''";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				AseUtil.logAction(conn, "SYSADM", "ACTION","Inserted " + rowsAffected + " for CUR","SYSADM","N",campus,"kix");

				table = "tblcourseARC";
				sql = "insert into tblCampusOutlines (category,coursealpha,coursenum,coursetype) "
					+ "select distinct 'Outline',coursealpha,coursenum,coursetype "
					+ "from " + table + " where coursealpha<>'' AND coursenum<>''";
				ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				AseUtil.logAction(conn, "SYSADM", "ACTION","Inserted " + rowsAffected + " for ARC","SYSADM","N",campus,"kix");

				ps.close();

				rowsAffected = campusOutlinesX(conn,"","CUR");
				AseUtil.logAction(conn, "SYSADM", "ACTION","Filled " + rowsAffected + " for CUR","SYSADM","N",campus,"kix");

				if (rowsAffected > -1){
					rowsAffected = campusOutlinesX(conn,"","PRE");
					AseUtil.logAction(conn, "SYSADM", "ACTION","Filled " + rowsAffected + " for PRE","SYSADM","N",campus,"kix");

					if (rowsAffected > -1){
						rowsAffected = campusOutlinesX(conn,"ARC","ARC");
						AseUtil.logAction(conn, "SYSADM", "ACTION","Filled " + rowsAffected + " for ARC","SYSADM","N",campus,"kix");
					} // PRE
				} // CUR
			}

			AseUtil.logAction(conn, "SYSADM", "ACTION","Create Outlines END","SYSADM","N",campus,"kix");
		}
		catch( SQLException e ){
			logger.fatal("Tables: campusOutlines - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("Tables: campusOutlines - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}
		}

		if (rowsAffected < 0)
			msg.setMsg("Exception");

		return msg;
	}

	/*
	 * campusOutlinesX - fill IDs in table campus outlines to speed up processing
	 *	<p>
	 * @param	conn
	 * @param	table
	 * @param	type
	 *	<p>
	 * @return int
	 */
	public static int campusOutlinesX(Connection conn,String table,String type){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		String campus = "";
		String campus_2 = "";
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";

		int i = 0;
		int j = 0;
		int id = 0;
		int rowsAffected = -1;

		boolean debug = false;

		try{
			String sql = "";
			String sql2 = "";
			String[] campuses = null;
			String[] aCampuses = null;

			PreparedStatement ps = null;
			ResultSet rs = null;

			campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");
			if (campus != null){
				campuses = campus.split(",");

				sql = "SELECT historyid,coursealpha,CourseNum,campus,coursetitle "
						+ "FROM tblCourse" + table + " WHERE campus<>'TTG' AND coursetype='"+type+"'";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()){
					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					title = AseUtil.nullToBlank(rs.getString("coursetitle"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					campus_2 = campus + "_2";
					num = AseUtil.nullToBlank(rs.getString("CourseNum"));
					sql = "UPDATE tblCampusOutlines SET " + campus + "=?,"+campus_2 + "=?  "
							+ "WHERE coursealpha=? AND coursenum=? AND coursetype=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					ps2.setString(2,title);
					ps2.setString(3,alpha);
					ps2.setString(4,num);
					ps2.setString(5,type);
					rowsAffected += ps2.executeUpdate();
				}
				rs.close();
				ps.close();
			} // campus != null

		}
		catch( SQLException e ){
			rowsAffected = -1;
			logger.fatal("Tables: campusOutlinesX - " + e.toString() + " - " + kix  + " - " + table);
		}
		catch( Exception e ){
			rowsAffected = -1;
			logger.fatal("Tables: campusOutlinesX - " + e.toString() + " - " + kix  + " - " + table);
		}

		return rowsAffected;
	}

	/*
	 * tabs
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public static Msg tabs(){

		//Logger logger = Logger.getLogger("test");

		String sql = "";

		boolean debug = false;

		Msg msg = new Msg();

		AsePool connectionPool = null;
		Connection conn = null;

		int rowsAffected = 0;

		try{
			if (debug) logger.info("-------------------- tabs - START");

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			PreparedStatement ps = null;

			// add tables not already saved
			sql = "INSERT INTO tbltabs (tab,alpha,num) "
					+ "SELECT name,'','' FROM sysobjects WHERE type='U' AND NAME NOT IN (SELECT tab FROM tbltabs)";
			ps = conn.prepareStatement(sql);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Inserted " + rowsAffected + " rows");

			sql = "UPDATE tbltabs "
					+ "SET alpha=?,num=? "
					+ "WHERE tab IN ( "
					+ "SELECT so.name "
					+ "FROM syscolumns sc, sysobjects so "
					+ "WHERE so.id = sc.id "
					+ "AND (so.xtype='U' OR so.xtype='S') "
					+ "AND (sc.name=?) "
					+ "AND so.name NOT LIKE 'Ban%' "
					+ "AND so.name NOT LIKE 'tblTemp%' "
					+ "AND so.name <> 'tblCampusOutlines' "
					+ ") ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,"alpha");
			ps.setString(2,"num");
			ps.setString(3,"alpha");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			ps = conn.prepareStatement(sql);
			ps.setString(1,"coursealpha");
			ps.setString(2,"coursenum");
			ps.setString(3,"coursealpha");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			// delete tables that we are not going to work on.
			ps = conn.prepareStatement("DELETE FROM tblTabs WHERE tab LIKE '[_]%'");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			ps = conn.prepareStatement("DELETE FROM tblTabs WHERE tab LIKE 'banner%'");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			ps = conn.prepareStatement("DELETE FROM tblTabs WHERE tab LIKE 'tbltemp%'");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			ps = conn.prepareStatement("DELETE FROM tblTabs WHERE tab not like 'tbl%'");
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("Updated " + rowsAffected + " rows");

			ps.close();

			if (debug) logger.info("-------------------- tabs - END");
		}
		catch( SQLException e ){
			logger.fatal("Tables: tabs - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("Tables: tabs - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			connectionPool.freeConnection(conn,"Tables","SYSADM");
		}

		return msg;
	}

	/*
	 * doesColumnExist
	 *	<p>
	 * @param	conn		Connection
	 * @param	table		String
	 * @param	column	String
	 *	<p>
	 * @return	boolean
	 *	<p>
	 */
	 public static boolean doesColumnExist(Connection conn,String table,String column){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		boolean exists = false;

		try{
			sql = "SELECT sc.name "
					+ "FROM syscolumns sc, sysobjects so "
					+ "WHERE so.id = sc.id "
					+ "AND (so.xtype='U' OR so.xtype='S') "
					+ "AND so.name=? "
					+ "AND sc.name=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,table);
			ps.setString(2,column);
			ResultSet rs = ps.executeQuery();
			exists = rs.next();
			rs.close();
			ps.close();
		}
		catch( SQLException e ){
			logger.fatal("Tables: tabs - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Tables: tabs - " + e.toString());
		}

		return exists;
	}

	/*
	 * approvalStatus
	 *	<p>
	 * @param	job	JobName
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public static Msg approvalStatus(JobName job){

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		Msg msg = new Msg();

		Connection conn = null;

		int rowsAffected = 0;

		try{
			if (debug) logger.info("-------------------- approvalStatus - START");

			conn = AsePool.createLongConnection();

			if (conn != null){
				/*
					execute this job to correct approval status report. For example,
					when approval report subprogress is REVIEW_IN_APPROVAL, that means we
					should have reviewers. However, if it does not, reset the subprogress
					to null;
				*/

				String kix = null;
				String campus = null;
				String alpha = null;
				String num = null;

				String sql = "SELECT campus,id,coursealpha,coursenum "
						+ "FROM vw_ApprovalStatus "
						+ "WHERE subprogress=? "
						+ "ORDER BY campus";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,Constant.COURSE_REVIEW_IN_APPROVAL);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					kix = AseUtil.nullToBlank(rs.getString("id"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));

					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						CourseDB.setCourseItem(conn,kix,"subprogress","","s");
						if (debug) logger.info("resetting subprogress for " + campus + ": " + alpha + " " + num);
					}

					++rowsAffected;
				}
				rs.close();
				ps.close();

				rs = null;
				ps = null;

				if (job != null){
					job.setTotal(rowsAffected);
					job.setCounter(rowsAffected);
					job.setEndTime(AseUtil.getCurrentDateTimeString());

					// keep this here beccause of the connection object
					com.ase.aseutil.jobs.JobNameDB.writeLogFile(conn,job);
				} //job

				conn.close();
				conn = null;

			}
			else
				if (debug) logger.info("connection not available");

			if (debug) logger.info("-------------------- approvalStatus - END");
		}
		catch( SQLException e ){
			logger.fatal("Tables: approvalStatus - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("Tables: approvalStatus - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Tables: campusOutlines - " + e.toString());
			}
		}

		return msg;
	}

	/*
	 * unmatchedCourseData
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public static Msg unmatchedCourseData(){

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		Msg msg = new Msg();

		AsePool connectionPool = null;
		Connection conn = null;

		int rowsAffected = -1;

		try{

			/*
				read in and create records not found in campus data
			*/

			if (debug) logger.info("-------------------- UNMATCHED COURSE DATA - START");

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			String sql = "SELECT DISTINCT tc.campus, tc.historyid, tc.coursealpha, tc.coursenum, tc.coursetype "
				+ "FROM tblCourse tc LEFT JOIN tblCampusdata tcd ON "
				+ "tc.historyid = tcd.historyid AND "
				+ "tc.campus = tcd.campus "
				+ "WHERE "
				+ "tcd.historyid Is Null AND "
				+ "tcd.campus Is Null "
				+ "ORDER BY tc.campus, tc.coursealpha, tc.coursenum, tc.coursetype ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				rowsAffected = CampusDB.createCampusDataRow(conn,AseUtil.nullToBlank(rs.getString("historyid")));
				if (debug && rowsAffected == 1)
					logger.info("inserted "
						+ AseUtil.nullToBlank(rs.getString("campus"))
						+ " "
						+ AseUtil.nullToBlank(rs.getString("coursealpha"))
						+ " "
						+ AseUtil.nullToBlank(rs.getString("coursenum"))
						+ " "
						+ AseUtil.nullToBlank(rs.getString("coursetype")));
			}
			rs.close();
			ps.close();

			if (debug) logger.info("-------------------- UNMATCHED COURSE DATA - END");
		}
		catch( SQLException e ){
			logger.fatal("Tables: unmatchedCourseData - " + e.toString());
			msg.setMsg("Exception");
		}
		catch( Exception e ){
			logger.fatal("Tables: unmatchedCourseData - " + e.toString());
			msg.setMsg("Exception");
		}
		finally{
			connectionPool.freeConnection(conn,"Tables","SYSADM");
		}

		return msg;
	}

	/*
	 * createOutlines - when campus is not null, we create outline for that campus, alpha, num
	 *	combination only.
	 *	<p>
	 *	@param	campus
	 *	@param	kix
	 *	@param	alpha
	 *	@param	num
	 *	@param	task
	 *	@param	idx
	 *	@param	type
	 *	@param	includeCourseInFileName
	 *	@param	print
	 *	@param	forceCreate
	 *	<p>
	 */
	public static void createOutlines(String campus,String kix,String alpha,String num) throws Exception {

		String type = "";

		createOutlines(campus,kix,alpha,num,"html","",type,false,false);
	}

	public static void createOutlines(String campus,String kix,String alpha,String num,String task) throws Exception {

		String type = "";

		createOutlines(campus,kix,alpha,num,task,"",type,false,false);
	}

	public static void createOutlines(String campus,String kix,String alpha,String num,String task,String idx) throws Exception {

		String type = "";

		createOutlines(null,campus,kix,alpha,num,task,"",type,false,false,false);
	}

	public static void createOutlines(String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													boolean includeCourseInFileName,
													boolean print) throws Exception {

		String type = "";

		createOutlines(null,campus,kix,alpha,num,task,"",type,includeCourseInFileName,print,false);
	}

	public static void createOutlines(String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													String type,
													boolean includeCourseInFileName,
													boolean print) throws Exception {

		createOutlines(null,campus,kix,alpha,num,task,"",type,includeCourseInFileName,print,false);
	}

	public static void createOutlines(Connection conn,
													String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													String type,
													boolean includeCourseInFileName,
													boolean print,
													boolean rawEdit) throws Exception {

		boolean methodCreatedConnection = false;

		// WARNING
		//
		// Do not call createOutlines with forceCreate as the last parameter outside of this routine
		// this routine ensures that only the correct outlines are created
		// creation of outlines should be done only on PRE since they are not yet approved.
		// once approved, they should not be altered to preserve data in use at the time

		try{
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			if (conn != null){
				String currentDrive = AseUtil.getCurrentDrive();
				String documents = SysDB.getSys(conn,"documents");

				// if kix is available, determine proper type to avoid recreating
				// an outline once approved as CUR
				if (kix != null){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
					info = null;
				}

				// file name with complete path
				String fileName = currentDrive
											+ ":"
											+ documents
											+ "outlines\\"
											+ campus
											+ "\\";

				if (includeCourseInFileName){
					fileName = fileName + alpha + "_" + num + "_";
				}

				fileName = fileName + kix + ".html";

				boolean createOutline = false;

				// does it exist?
				File file = new File(fileName);
				boolean exists = file.exists();

				// check for the file's existence. if it is found and the outline is in PRE, allow creation
				// else, if not found, create regardless of type

				if(rawEdit){
					createOutline = true;
				}
				else if (exists && type.equals(Constant.PRE)) {
					createOutline = true;
				}
				else if (!exists) {
					createOutline = true;
				}

				if(createOutline){
					Tables.createOutlines(conn,campus,kix,alpha,num,task,idx,type,includeCourseInFileName,print,true,rawEdit);
				}
			} // conm

			// only if the connection was created here
			if (methodCreatedConnection){

				try{
					conn.close();
					conn = null;
				}
				catch(Exception e){
					logger.fatal("Tables: createOutlines - " + e.toString());
				}

			} // methodCreatedConnection

		}
		catch(Exception e){
			logger.fatal("Tables: createOutlines - " + e.toString());
		}

	}

	public static void createOutlines(Connection conn,
													String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													String type,
													boolean includeCourseInFileName,
													boolean print,
													boolean forceCreate,
													boolean rawEdit) throws Exception {

		//Logger logger = Logger.getLogger("test");

		// SEE NOTE in above routine - DO NOT CALL this routine directly

		boolean debug = false;

		Msg msg = null;

		boolean compressed = true;

		FileWriter fstream = null;
		BufferedWriter output = null;

		String sql = "";
		String holdCampus = "";
		String documents = "";

		String html = "";
		boolean createHTML = false;

		String xml = "";
		boolean createXML = false;

		int rowsAffected = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		boolean methodCreatedConnection = false;

		String table = "tblCourse";
		String outlineYear = "";

		try {

			debug = DebugDB.getDebug(conn,"Tables");

			if (debug){
				if (debug) logger.info("-------------------- CREATEOUTLINES - START");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("task: " + task);
				logger.info("idx: " + idx);
				logger.info("includeCourseInFileName: " + includeCourseInFileName);
				logger.info("print: " + print);
				logger.info("forceCreate: " + forceCreate);
				logger.info("rawEdit: " + rawEdit);
			}

			// let's hope we have a valid connection
			// depending on where this is called, there is an option to use the connection pool
			// or create a manual connection. This is true for SearchDB.createSearchData
			// when null, that's because we didn't provide a connection. if we don't provide one,
			// then we should close the connection when it's created here.
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			// let's hope we have a valid connection
			if (conn != null){

				// just in case a KIX didn't make it in
				if(kix != null && type.length() > 0){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
				}

				if (type == null || type.length() == 0){
					type = "CUR";
				}

				documents = SysDB.getSys(conn,"documents");

				// when updating the HTML table, should HTML file be created also? If yes, this will run a lot longer
				createHTML = false;
				html = SysDB.getSys(conn,"createHTML");
				if (html.equals(Constant.ON)){
					createHTML = true;
				}

				// creating XML is part of practice to create PDF. So far not working
				createXML = false;
				xml = SysDB.getSys(conn,"createXML");
				if (xml.equals(Constant.ON)){
					createXML = true;
				}

				if (debug){
					logger.info("obtained HTML template");
					logger.info("documents: " + documents);
					logger.info("createHTML: " + createHTML);
					logger.info("createXML: " + createXML);
				}

				String htmlHeader = Util.getResourceString("header.ase");
				String htmlFooter = "";

				//
				// outline stamp in footer (ER00038 - HAW)
				//
				String showAuditStampInFooter = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","showAuditStampInFooter");
				if(showAuditStampInFooter.equals(Constant.ON)){
					htmlFooter = Util.getResourceString("footer_stamp.ase");
					Calendar calendar = Calendar.getInstance();
					outlineYear = "" + calendar.get(Calendar.YEAR);
				}
				else{
					htmlFooter = Util.getResourceString("footer.ase");
				}

				// campus is null when running as a scheduled job (CreateOulinesJob.java).
				// otherwise, campus is available for creation of a single outline
				if (campus == null || campus.length() == 0){

					// prepare the table for process (delete jobs first)
					JobsDB.deleteJob("CreateOutlines");

					// tasks are htm or html. htm is for all outlines and html is differential from a certain date
					if (task.equals("all")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourse c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourseARC c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();


					} // "all".equals(task)
					else if (task.equals("diff")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "diff".equals(task)
					else if (task.equals("frce")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "frce".equals(task)
					else if (task.equals("idx")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblHtml h "
							+ "WHERE  c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourseARC c, tblHtml h "
							+ "WHERE  c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "idx".equals(task)
					else if (task.equals("pre")){

						// regenerate for all PRE outlines
						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'PRE','System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursetype='PRE' AND (NOT campus IS NULL) AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					}
					else if (task.equals("test")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursealpha='ENG' "
							+ "AND coursenum='100' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE coursealpha='ENG' "
							+ "AND coursenum='100' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursealpha='ACC' "
							+ "AND coursenum='201' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE coursealpha='ACC' "
							+ "AND coursenum='201' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "test".equals(task)

					if (debug) logger.info("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num, type FROM tbljobs ORDER BY campus,alpha, num, type";

					ps = conn.prepareStatement(sql);
				}
				else{ // else campus == null

					if (type.equals(Constant.ARC)){
						table = "tblCourseARC";
					}
					else{
						table = "tblCourse";
					}

					if (kix !=null && kix.length() > 0){
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
					else if (alpha != null && num != null && type != null && alpha.length() > 0 && num.length() > 0 && type.length() > 0){
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
					}
					else{
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? ORDER BY coursealpha, coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
					}

				} // set up sql

				if (debug){
					logger.info("obtained document folder");
					logger.info("creating outlines - " + task);
					logger.info("table - " + table);
					logger.info("sql - " + sql);
				}

				ResultSet rs = ps.executeQuery();
				while (rs.next() && !debug) {
					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					alpha = AseUtil.nullToBlank(rs.getString("alpha"));
					num = AseUtil.nullToBlank(rs.getString("num"));
					type = AseUtil.nullToBlank(rs.getString("type"));

					if (!campus.equals("TTG")){

						try {
							String fileName = currentDrive
														+ ":"
														+ documents
														+ "outlines\\"
														+ campus
														+ "\\";

							if (includeCourseInFileName){
								fileName = fileName + alpha + "_" + num + "_";
							}

							fileName = fileName + kix + ".html";

							// display log of campus being processed
							if (!campus.equals(holdCampus)){
								holdCampus = campus;
								if (debug) logger.info("processing outlines for: " + holdCampus);
							}

							try{
								// write the HTML
								if (createHTML){
									fstream = new FileWriter(fileName);
									output = new BufferedWriter(fstream);
									output.write(htmlHeader);
									output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<br/>\n");
									output.write(CourseDB.getCourseDescriptionByTypePlus(conn,campus,alpha,num,type) + "</p>");
									if (debug) logger.info("processing outline: " + alpha + " " + num);
									msg = Outlines.viewOutline(conn,kix,"",compressed,print,createHTML);
									String junk = msg.getErrorLog().replace("<br>","<br/>");
									output.write(junk);

									//
									// outline stamp in footer (ER00038 - HAW)
									//
									String tempFooter = htmlFooter;
									if(showAuditStampInFooter.equals(Constant.ON)){
										tempFooter = tempFooter.replace("[FOOTER_COPYRIGHT]","Copyright ©1999-"+outlineYear+" All rights reserved.")
																		.replace("[FOOTER_STATUS_DATE]",Outlines.footerStatus(conn,kix,type));
									} // showAuditStampInFooter

									output.write(tempFooter);

									//
									// tidy up html
									//
									if (createXML){
										CreateXml outlineXML = new CreateXml();
										outlineXML.createXML(conn,campus,kix);
										outlineXML = null;
									} // createXML

								}

								Html.updateHtml(conn,Constant.COURSE,kix);

								// refresh HTML for quick access
								updateCampusOutline(conn,"Outline",campus,kix);

							}
							catch(Exception e){
								logger.fatal("Tables: createOutlines - fail to create outline - "
										+ campus + " - " + kix  + " - " + alpha  + " - " + num
										+ "\n"
										+ e.toString());
							}

						}
						catch(Exception e){
							logger.fatal("Tables: createOutlines - fail to open/create file - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						} finally {
							if (createHTML){
								output.close();
							}
						}

						JobsDB.deleteJobByKix(conn,kix);

					} // campus != ttg

				} // while

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				// only if the connection was created here
				if (methodCreatedConnection){
					conn.close();
					conn = null;
				}

				if (debug) logger.info("connection closed");

			} // if conn != null

			if (debug) logger.info("-------------------- CREATEOUTLINES - END");

		} catch (Exception e) {
			logger.fatal("Tables: createOutlines FAILED3 - "
					+ campus + " - " + kix  + " - " + alpha  + " - " + num
					+ "\n"
					+ e.toString());
		}
		finally{
			// only if the connection was created here
			if (methodCreatedConnection){
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					logger.fatal("Tables: createOutlines - " + e.toString());
				}
			}
		}

		return;
	}

	/**
	 * isMatch
	 * <p>
	 * @param	conn		Connection
	 * @param	category	String
	 * @param	type		String
	 * @param	campus	String
	 * @param	kxi		String
	 * <p>
	 * @return	boolean
	 */
	public static boolean isMatch(Connection conn,String category,String alpha,String num,String type) throws SQLException {

		String sql = "SELECT id FROM tblCampusOutlines "
					+ "WHERE category=? "
					+ "AND coursealpha=? "
					+ "AND coursenum=? "
					+ "AND coursetype=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,category);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,type);
		ResultSet results = ps.executeQuery();
		boolean exists = results.next();
		results.close();
		ps.close();
		return exists;
	}

	/**
	 * updateCampusOutline
	 * <p>
	 * @param	conn		Connection
	 * @param	category	String
	 * @param	type		String
	 * @param	campus	String
	 * @param	kxi		String
	 * <p>
	 * @return	int
	 */
	public static int updateCampusOutline(Connection conn,String category,String campus,String kix) {

		String sql = "";
		String table = "";

		int rowsAffected = 0;
		PreparedStatement ps = null;

		try {
			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String type = info[Constant.KIX_TYPE];

			if (!campus.equals("TTG")){
				if (!isMatch(conn,category,alpha,num,type)){
					sql = "INSERT INTO tblCampusOutlines (category,coursealpha,coursenum,coursetype,"+campus+") VALUES(?,?,?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,category);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
					ps.setString(5,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
				else{
					sql = "UPDATE tblCampusOutlines SET "+campus+"=? "
							+ "WHERE category=? "
							+ "AND coursealpha=? "
							+ "AND coursenum=? "
							+ "AND coursetype=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ps.setString(2,category);
					ps.setString(3,alpha);
					ps.setString(4,num);
					ps.setString(5,type);
					rowsAffected = ps.executeUpdate();
					ps.close();
				}
			} // campus != TTG

		} catch (SQLException e) {
			logger.fatal("Tables: updateCampusOutline - " + e.toString());
		} catch (Exception e) {
			logger.fatal("Tables: updateCampusOutline - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * findColumnName - returns all tables where the column name is found
	 * 					  returns as CSV
	 *	<p>
	 * @param	columnToFind	String
	 *	<p>
	 * @return String
	 */
	 public static String findColumnName(String columnToFind){

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		AsePool connectionPool = null;
		Connection conn = null;

		int rowsAffected = 0;

		String table = "";
		String type = "";
		String column = "";
		String datatype = "";
		int length = 0;
		int id = 0;

		StringBuffer buf = new StringBuffer();

		try{
			if (debug) logger.info("-------------------- findColumnName - START");

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
							+ "WHERE type='U' "
							+ "ORDER BY name, type";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				table = rs.getString("name");
				type = rs.getString("type");
				id = rs.getInt("id");

				sql = "SELECT so.name, sc.name AS [column], systypes.name AS datatype, sc.length "
					+ "FROM syscolumns sc INNER JOIN sysobjects so ON sc.id = so.id "
					+ "INNER JOIN systypes ON sc.xtype = systypes.xtype "
					+ "WHERE (so.xtype='U' OR so.xtype='S')  "
					+ "AND (so.name=?) "
					+ "AND sc.name=? "
					+ "ORDER BY so.name, sc.name";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,table);
				ps2.setString(2,columnToFind);
				rs2 = ps2.executeQuery();
				if(rs2.next()){
					column = rs2.getString("column");
					datatype = rs2.getString("datatype");
					length = rs2.getInt("length");
					buf.append(table + ",");
				}
				rs2.close();
				ps2.close();
			}
			rs.close();
			ps.close();

			if (debug) logger.info("-------------------- findColumnName - END");
		}
		catch( SQLException e ){
			logger.fatal("Tables: findColumnName - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("Tables: findColumnName - " + e.toString());
		}
		finally{
			connectionPool.freeConnection(conn,"SQLUtil","SYSADM");
		}

		return buf.toString();
	}

	/*
	 * createPrograms - when campus is not null, we create outline for that campus, alpha, num
	 *	combination only.
	 *	<p>
	 *	@param	campus
	 *	@param	kix
	 *	@param	alpha
	 *	@param	num
	 *	<p>
	 */
	public static void createPrograms(String campus,String kix,String program,String divisionCode) throws Exception {

		//Logger logger = Logger.getLogger("test");

		boolean debug = false;

		Msg msg = null;

		boolean compressed = true;

		FileWriter fstream = null;
		BufferedWriter output = null;

      Connection conn = null;

		String type = "PRE";
		String sql = "";
		String documents = "";
		String fileName = "";

		int rowsAffected = 0;
		int hid = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		try {
			conn = AsePool.createLongConnection();

			if (conn != null){

				if (debug) {
					logger.info("campus: " + campus);
					logger.info("kix: " + kix);
					logger.info("program: " + program);
					logger.info("divisionCode: " + divisionCode);
					logger.info("got connection");
				}

				String[] info = Helper.getKixInfo(conn,kix);
				type = info[Constant.KIX_TYPE];

				String htmlHeader = Util.getResourceString("programheader.ase");
				String htmlFooter = Util.getResourceString("programfooter.ase");
				if (debug) logger.info("resource HTML");

				documents = SysDB.getSys(conn,"documents");
				if (debug) logger.info("obtained document folder");

				/*
					campus is null when running as a scheduled job (CreateOulinesJob.java).
					otherwise, campus is available for creation of a single program
				*/
				if (campus == null){

					if (debug) logger.info("creating all programs");

					// prepare the table for process (delete jobs first)
					JobsDB.deleteJob("createPrograms");

					// prepare the table for process (insert data)
					sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate,n1) "
						+ "SELECT 'createPrograms',historyid,campus,program,divisioncode,'System',getdate(),hid "
						+ "FROM vw_ProgramForViewing "
						+ "WHERE (NOT campus IS NULL) AND (NOT historyid IS NULL) "
						+ "ORDER BY campus,program,divisionname";
					ps = conn.prepareStatement(sql);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("created " + rowsAffected + " rows in jobs table");

					sql = "SELECT historyid, campus, alpha, num, '' AS type, n1 AS hid "
							+ "FROM tbljobs ORDER BY campus,alpha, num";
					ps = conn.prepareStatement(sql);
				}
				else{
					if (debug) logger.info("creating program for " + campus + " - " + program + " - " + divisionCode);

					sql = "SELECT historyid, campus, program AS alpha, divisioncode AS num, type, hid "
							+ "FROM vw_ProgramForViewing WHERE campus=? AND historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,kix);
				} // if campus == null

				ResultSet rs = ps.executeQuery();

				// creating XML is part of practice to create PDF. So far not working
				boolean createXML = false;
				String xml = SysDB.getSys(conn,"createXML");
				if (xml.equals(Constant.ON)){
					createXML = true;
				}

				boolean htmlCreated = false;

				while (rs.next()) {

					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					program = AseUtil.nullToBlank(rs.getString("alpha"));
					divisionCode = AseUtil.nullToBlank(rs.getString("num"));
					type = AseUtil.nullToBlank(rs.getString("type"));
					hid = rs.getInt("hid");

					try {
						fileName = currentDrive
										+ ":"
										+ documents
										+ "programs\\"
										+ campus
										+ "\\"
										+ kix
										+ ".html";

						if (debug) logger.info(fileName);

						fstream = new FileWriter(fileName);

						output = new BufferedWriter(fstream);

						output.write(htmlHeader);

						output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<br/>\n");

						htmlCreated = false;

						try{
							String junk = ProgramsDB.viewProgram(conn,campus,kix,type);

							junk = junk.replace("<br>","<br/>");

							output.write(junk);

							Html.updateHtml(conn,Constant.PROGRAM,kix);

							htmlCreated = true;
						}
						catch(Exception e){

							logger.fatal("Tables: createPrograms - fail to create program - "
									+ campus + " - " + kix  + " - " + program  + " - " + divisionCode
									+ "\n"
									+ e.toString());
						}

						output.write(htmlFooter);

						if (debug) logger.info("HTML created");
					}
					catch(Exception e){
						logger.fatal("Tables: createPrograms - fail to open/create file - "
								+ campus + " - " + kix  + " - " + program  + " - " + divisionCode
								+ "\n"
								+ e.toString());
					} finally {
						output.close();
					}

					//
					// tidy up html
					// not doing this until file is closed
					//
					try{
						if (createXML && htmlCreated){
							CreateXml outlineXML = new CreateXml();
							outlineXML.createXML(conn,campus,kix);
							outlineXML = null;
						} // createXML
					}
					catch(Exception e){
						//
					}

					//
					// cleaning up
					//
					JobsDB.deleteJobByKix(conn,kix);

				} // while

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				conn.close();
				conn = null;

				if (debug) logger.info("connection closed");

			} // if conn != null

		} catch (Exception e) {
			logger.fatal("Tables: createPrograms FAILED3 - "
					+ campus + " - " + kix  + " - " + program  + " - " + divisionCode
					+ "\n"
					+ e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Tables: createPrograms - " + e.toString());
			}
		}

		return;
	}

	/*
	 * deleteOutline
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	kix
	 *	<p>
	 */
	public static void deleteOutline(Connection conn,String campus,String kix) throws Exception {

		try{
			String currentDrive = AseUtil.getCurrentDrive();
			String documents = SysDB.getSys(conn,"documents");

			String fileName = currentDrive
										+ ":"
										+ documents
										+ "outlines\\"
										+ campus
										+ "\\"
										+ kix + ".html";

			File file = new File(fileName);
			boolean exists = file.exists();
			if (exists) {
				file.delete();
			}
		}
		catch(Exception e){
			logger.fatal("Tables: deleteOutline - " + e.toString());
		}

	}


}