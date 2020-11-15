/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *	public static String drawAlphaIndex(int idx,String type)
 *	public static String drawAlphaIndexBookmark(int idx,String reportName)
 *	public static String drawDiscipline(Connection,String,String)
 *	public static String getContactStaff(Connection conn,String campus)
 *	public static String getKix(Connection,String campus,String alpha,String num,String type)
 *	public static String[] getKixInfoFromForumID(Connection conn,int fid,int item){
 *	public static String[] getKixInfo(Connection conn,String kix)
 *	public static String[] getKixRoute(Connection,String campus,String alpha,String num,String type)
 *	public static String getSupportStaff(Connection conn,String campus)
 *	public static String listCampusOutlinesByType(Connection conn,String campus,String alpha,String type)
 *	public static String listCampusOutlinesByAlpha(Connection conn,String campus,String type,String caller,int idx,String alpha,String num){
 *	public static String listOutlinesForSubmissionWithProgram(Connection conn,String campus,String type,int division){
 *	public static String listOutlineCoreqs(Connection conn,String type,int idx,String alpha,String num)
 *	public static String listOutlineCoreqsX(Connection conn,String kix,request,response)
 *	public static String listOutlineForLinking(Connection conn,String campus,String caller,int idx){
 *	public static String listOutlineForRename(Connection conn,String campus,String caller,int idx){
 *	public static String listOutlinePrereqs(Connection conn,String type,int idx)
 *	public static String listOutlinePrereqsX(Connection conn,String kix,request,response)
 *	public static String listOutlineAssessing(Connection conn,String campus,String caller,String user)
 *	public static String listOutlineAssessments(Connection conn,String campus,String caller,String user)
 *	public static String listOutlineModifications(Connection conn,String campus,String type,String caller,String user)
 *	public static String listOutlineNumbersUsedByAlpha(Connection conn,String alpha,String type){
 *	public static String listOutlineRawEdit(Connection conn,String campus,String type,String caller,int idx)
 *	public static String listOutlineRawEdit(Connection conn,String campus,String type,String caller,int idx,String alpha,String num)
 *	public static String listOutlineDetails(Connection conn,String type,String caller,int idx,String alpha,String num)
 *	public static String listOutlines(Connection conn,String type,int idx)
 *	public static String listOutlines(Connection conn,String type,String caller,int idx)
 *	public static String listOutlines(Connection conn,String campus,String alpha,String num,String type)
 *	public static String listOutlines(Connection conn,String campus,String type,int idx,String[] args)
 *	public static String listOutlinesToDisplay(Connection conn,String type,int idx,String alpha,String num)
 *	public static String listOutlineSLOs(Connection conn,String type,int idx)
 *	public static String listOutlineSLOs(Connection conn,String campus,String user,String type,String caller,int idx)
 *	public static String listWordDocs(Connection conn,String docType)
 *	public static String showAssessmentsToCancel(Connection conn,String campus,String user,String caller)
 *	public static String showCourseProgress(Connection conn,String kix)
 *	public static String showExcludedFromCatalog(Connection,String,int)
 *	public static String showOutlinesByUserProgress(Connection conn,String campus,String user,String progress,String caller)
 * public static String showOutlinesForCompare(Connection conn,String campus,String alpha,String num)
 *	public static String showOutlinesNeedingApproval(Connection conn,String campus,String user,String caller)
 *	public static String showOutlinesNeedingSLOApproval(Connection conn,String campus,String user,String caller)
 *	public static String showOutlinesNeedingSLOReview(Connection conn,String campus,String user,String caller)
 *	public static String showOutlinesToEnableItems(Connection conn,
 *																	String campus,
 *																	String user,
 *																	String progress,
 *																	String caller){
 *	public static String showOutlinesUserMayCancel(Connection conn,String campus,String user)
 * public static STring showSLOApprovalToCancel(Connection conn,String campus,String reviewer,String caller)
 *	public static String showSLOByProgress(Connection conn,String campus,String user,String caller,String progress)
 *	public static String showSLOReadyToApprove(Connection conn,String campus,String user,String caller)
 * public static STring showSLOReviewToCancel(Connection conn,String campus,String reviewer,String caller)
 *	public static String showOutlinesToView(Connection conn,String campus,String type,String caller,int idx)
 *	public static String showLog(Connection conn,String campus,String logType)
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.paging.Paging;

public class Helper {

	static Logger logger = Logger.getLogger(Helper.class.getName());

	public Helper() throws IOException{}

	/**
	 * drawAlphaIndex
	 * <p>
	 * @param	idx			int
	 * @param	type			String
	 * <p>
	 * @return	String
	 */
	public static String drawAlphaIndex(int idx,String type){

		return drawAlphaIndex(idx,type,true,"");
	}

	public static String drawAlphaIndex(int idx,String type,boolean includeAll){

		return drawAlphaIndex(idx,type,true,"");
	}

	public static String drawAlphaIndex(int idx,String type,boolean includeAll,String arg){

		return drawAlphaIndex(idx,type,true,arg,"");

	}

	public static String drawAlphaIndex(int idx,String type,boolean includeAll,String arg,String exportURL){

		StringBuffer buf = new StringBuffer();
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		int x = 0;

		try{
			buf.append("<div class=\"pagination\">");

			for(x=LETTER_A; x<=LETTER_Z; x++){
				if (x==idx)
					buf.append("<span><b>" + (char)x + "</span></b>&nbsp;");
				else
					buf.append("<a href=\"?idx=" + x + "&type=" + type + arg + "\">" + (char)x + "</a>&nbsp;");
			}

			if (includeAll){
				buf.append("<a href=\"?\">ALL</a>&nbsp;");
			}

			if (exportURL != null && exportURL.length() > 0){
				//buf.append("<a href=\""+exportURL+"\" target=\"_blank\">Export</a>&nbsp;");
				buf.append("<a href=\""+exportURL+"\">Export</a>&nbsp;");
			}

			buf.append("<br><br>");
			buf.append("</p></div>");
		}
		catch(Exception ex){
			logger.fatal("Helper: drawAlphaIndex - " + ex.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/**
	 * drawAlphaIndexBookmark
	 * <p>
	 * @param	idx			int
	 * @param	reportName	String
	 * <p>
	 * @return	String
	 */
	public static String drawAlphaIndexBookmark(int idx,String reportName){

		boolean showExport = false;
		StringBuffer buf = new StringBuffer();
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		int x = 0;

		if (!"".equals(reportName))
			showExport = true;

		try{
			buf.append("<div class=\"pagination\">");

			for(x=LETTER_A; x<=LETTER_Z; x++){
				if (x==idx)
					buf.append("<span><b>" + (char)x + "</span></b>&nbsp;");
				else
					buf.append("<a class=\"linkcolumn\" href=\"#" + (char)x + "\">" + (char)x + "</a>&nbsp;");
			}

			if (showExport)
				buf.append("<a href=\"/central/servlet/clone?rpt="+reportName+"\">Export</a>&nbsp;");

			buf.append("<br><br>");
			buf.append("</div>");
		}
		catch(Exception ex){
			logger.fatal("Helper: drawAlphaIndexBookmark - " + ex.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

	/**
	 * drawDiscipline
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	discipline	String
	 * <p>
	 * @return	String
	 */
	public static String drawDiscipline(Connection conn,String campus,String discipline){

		String output = "";

		try{
			AseUtil aseUtil = new AseUtil();

			String SQL = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION " +
				"FROM BannerAlpha ORDER BY ALPHA_DESCRIPTION";
			output = aseUtil.createSelectionBox(conn,SQL,"aseList",discipline,"","1",false,"");
		}
		catch(Exception ex){
			logger.fatal("Helper: drawDiscipline - " + ex.toString());
		}

		return output;
	}

	public static String drawDiscipline2(Connection conn,String campus,String discipline){

		String output = "";

		try{
			AseUtil aseUtil = new AseUtil();

			String SQL = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION + ' ('+COURSE_ALPHA+')' " +
				"FROM BannerAlpha ORDER BY ALPHA_DESCRIPTION";
			output = aseUtil.createSelectionBox(conn,SQL,"aseList",discipline,"","1",false,"");
		}
		catch(Exception ex){
			logger.fatal("Helper: drawDiscipline - " + ex.toString());
		}

		return output;
	}

	/**
	 * getKix
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String getKix(Connection conn,String campus,String alpha,String num,String type){

		//Logger logger = Logger.getLogger("test");

		String kix = "";
		String select = " SELECT historyid FROM ";
		String where = " WHERE campus=? AND coursealpha=? AND coursenum=? ";
		String table = " tblCourse ";

		try{
			String sql = "";

			// set the table
			if (type.equals(Constant.ARC))
				table = " tblCourseARC ";
			else if (type.equals(Constant.CAN))
				table = " tblCourseCAN ";
			else if (type.equals(Constant.CUR))
				table = " tblCourse ";
			else if (type.equals(Constant.PRE))
				table = " tblCourse ";
			else
				table = " tblCourse ";

			// determine other parts of SQL
			if (type.equals(Constant.BLANK)){
				sql = select + " " + table + " " + where;
			}
			else if (type.equals(Constant.CUR) || type.equals(Constant.PRE)){
				where = where + " AND coursetype=? ";
				sql = select + " " + table + " " + where;
			}
			else if (type.equals(Constant.ARC)){
				where = where + " AND coursetype=? ";
				sql = select + " " + table + " " + where + " ORDER BY coursedate DESC ";
			}
			else{
				sql = "SELECT MAX(historyid) AS historyid "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND CourseAlpha=? "
					+ "AND CourseNum=? "
					+ "AND CourseType=? "
					+ "GROUP BY CourseAlpha, CourseNum";
			}

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);

			if (!type.equals(Constant.BLANK)){
				ps.setString(4,type);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
			}

			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}
		catch(Exception ex){
			logger.fatal("Helper: getKix - " + ex.toString());
		}

		return kix;
	}

	/**
	 * getKixRoute
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixRoute(Connection conn,String campus,String alpha,String num,String type){

		//Logger logger = Logger.getLogger("test");

		String[] info = new String[2];
		try{
			String table = "tblCourse";

			if ("ARC".equals(type))
				table = "tblCourseARC";
			else if ("CAN".equals(type))
				table = "tblCourseCAN";
			else
				table = "tblCourse";

			String sql = "SELECT id,route FROM "
							+ table + " "
							+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				info[0] = AseUtil.nullToBlank(rs.getString(1));
				info[1] = AseUtil.nullToBlank(rs.getString(2));
			}
			else{
				info[0] = "";
				info[1] = "0";
			}

			if (info[1] == null || info[1].length() == 0)
				info[1] = "0";

			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: getKixRoute - " + ex.toString());
		}

		return info;
	}

	/**
	 * getKixInfoFromForumID
	 * <p>
	 * @param	conn	Connection
	 * @param	fid	int
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfoFromForumID(Connection conn,int fid){

		String[] info = null;

		try{
			String kix = ForumDB.getKix(conn,fid);

			if (kix != null && kix.length() > 0)
				info = getKixInfo(conn,kix);
		}
		catch(SQLException e){
			logger.fatal("Helper: getKixInfoFromForumID - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Helper: getKixInfoFromForumID - " + e.toString());
		}

		return info;
	}

	/**
	 * getKixInfo
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfo(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int counter = 10;
		String count = "SELECT COUNT(*) AS result ";
		String select = "SELECT coursealpha,coursenum,coursetype,proposer,campus,historyid,route,progress,subprogress,coursetitle ";
		String where = "WHERE historyid=? ";
		String table = "";
		String sql = "";
		String[] info = new String[counter];

		int result = -1;

		boolean debug = false;

		try{
			for (i=0;i<counter;i++){
				info[i] = "";
			}

			String dataType[] = {"s","s","s","s","s","s","i","s","s","s"};

			AseUtil aseUtil = new AseUtil();

			/*
				check to see which table contains the kix. if a row is found,
				that's the table to use. if not, keep looking. if not found
				as an outline, check the program table
			*/

			if (kix != null){
				table = "tblCourse";
				sql = count + " FROM " + table + " " + where;
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					result = rs.getInt("result");
					if (debug) System.out.println("Helper.getKixInfo: " + table);
				} // rs.next

				if (result == 0){
					rs.close();

					table = "tblCourseARC";
					sql = count + " FROM " + table + " " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					if (rs.next()){
						result = rs.getInt("result");
						if (debug) System.out.println("Helper.getKixInfo: " + table);
					}

					if (result == 0){
						rs.close();

						table = "tblCourseCAN";
						sql = count + " FROM " + table + " " + where;
						ps = conn.prepareStatement(sql);
						ps.setString(1,kix);
						rs = ps.executeQuery();
						if (rs.next()){
							result = rs.getInt("result");
							if (debug) System.out.println("Helper.getKixInfo: " + table);
						} // tblCourseCAN
					}
					else{
						table = "tblCourseARC";
					} // result == 0 for tblCourseARC

				} // tblCourse
				else{
					table = "tblCourse";
				} // result == 0 for tblCourse

				rs.close();

				// did we find it in the core tables (tblCourse)
				if (result >= 1){
					sql = select + " FROM " + table + " " + where;
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();

					if (rs.next()){
						info = SQLUtil.resultSetToArray(rs,dataType);
						if (debug) System.out.println("Helper.getKixInfo: " + table);
					}
				}
				else{
					// not found in course tables. check programs and forum

					if (debug) System.out.println("Helper.getKixInfo: program");

					info = ProgramsDB.getKixInfo(conn,kix);

					if (info == null || info[0] == null || info[0].length() == 0){
						if (debug) System.out.println("Helper.getKixInfo: forum");
						info = ForumDB.getKixInfo(conn,kix);
					}
				} // result >= 1

				rs.close();
				ps.close();

			} // kix != null
		}
		catch(Exception ex){
			logger.fatal("Helper: getKixInfo - " + ex.toString());
			info[0] = "";
		}

		return info;
	} // Helper.getKixInfo

	/**
	 * showKixInfo
	 * <p>
	 * @param	info	String[]
	 * <p>
	 */
	public static void showKixInfo(String[] info){

		//Logger logger = Logger.getLogger("test");

		logger.info("------------------------- Helper.showKixInfo.START");

		try{
			if (info != null){
				for (int i=0;i<info.length;i++){
					logger.info(info[i]);
				}
			}
		}
		catch(Exception ex){
			logger.fatal("Helper: getKixInfo - " + ex.toString());
		}

		logger.info("------------------------- Helper.showKixInfo.END");

	}

	/**
	 * getKixInfoFromOldCC
	 * <p>
	 * @param	conn	Connection
	 * @param	kix	String
	 * <p>
	 * @return	String[]
	 */
	public static String[] getKixInfoFromOldCC(Connection conn,String kix){

		//Logger logger = Logger.getLogger("test");

		int i = 0;
		int counter = 8;
		String select = "SELECT coursealpha,coursenum,coursetype,proposer,campus,historyid,route,progress";
		String where = "WHERE historyid=?";
		String table = "";
		String sql = "";
		String[] info = new String[counter];

		try{
			for (i=0;i<counter;i++)
				info[i] = "";

			String dataType[] = {"s","s","s","s","s","s","i","s"};

			AseUtil aseUtil = new AseUtil();

			table = "tblCourseCC2";
			sql = select + " FROM " + table + " " + where;
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				info = SQLUtil.resultSetToArray(rs,dataType);
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: getKixInfoFromOldCC - " + ex.toString());
			info[0] = "";
		}

		return info;
	}

	/**
	 * getKixFromOldCC
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String getKixFromOldCC(Connection conn,String campus,String alpha,String num,String type){

		String kix = "";

		try{
			String sql = "SELECT id " +
				"FROM tblCourseCC2 " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			ResultSet rs = ps.executeQuery();
			if ( rs.next() )
				kix = AseUtil.nullToBlank(rs.getString(1));
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: getKixFromOldCC - " + ex.toString());
		}

		return kix;
	}

	/**
	 * listOutlines - listing outlines including history. use this to list ARC/CAN outlines when
	 *						there are too many to be handled for viewing.
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlines(Connection conn,String campus,String alpha,String num,String type){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String historyid = "";
		String courseDate = "";
		String auditDate = "";
		String proposer = "";
		String title = "";
		String table = "tblCourse";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;

			if (type.equals("ARC")){
				table = "tblCourseARC";
			}
			else if (type.equals("CAN")){
				table = "tblCourseCAN";
			}

			String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");

			sql = "SELECT historyid,effectiveterm,coursedate,auditdate,proposer FROM " + table +
				" WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? " +
				" ORDER BY coursedate DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			rs = ps.executeQuery();
			while ( rs.next() ){
				String term = aseUtil.nullToBlank(rs.getString("effectiveterm"));
				historyid = aseUtil.nullToBlank(rs.getString("historyid"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));

				courseDate = aseUtil.nullToBlank(rs.getString("coursedate"));
				if (courseDate != null && courseDate.length()>0){
					courseDate = aseUtil.ASE_FormatDateTime(courseDate,Constant.DATE_DATETIME);
				}

				auditDate = aseUtil.nullToBlank(rs.getString("auditDate"));
				if (auditDate != null && auditDate.length()>0){
					auditDate = aseUtil.ASE_FormatDateTime(auditDate,Constant.DATE_DATETIME);
				}

				if (courseDate.equals(Constant.BLANK)){
					courseDate = auditDate;
				}

				if (j++ % 2 == 0){
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				}
				else{
					rowColor = Constant.ODD_ROW_BGCOLOR;
				}

				String pdf = "";
				if (enableCCLab.equals(Constant.ON)){
					pdf = "<td class=\"datacolumn\" width=\"05%\"><a href=\"/central/core/vwpdf.jsp?kix="+historyid+"\" target=\"_blank\"><img src=\"/central/images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a></td>";
				}

				// sending back hid=1 to force vwcrsx to not come back this way again
				link = "vwcrsx.jsp?hid=1&cps=" + campus + "&kix=" + historyid + "&t=" + type;
				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
					+ pdf
					+ "<td class=\"linkcolumn\" width=\"20%\"><a href=\"" + link + "\" title=\"" + courseDate + "\" class=\"linkcolumn\">" + courseDate + "</a></td>"
					+ "<td class=\"datacolumn\" width=\"25%\">" + term + " - " + TermsDB.getTermDescription(conn,term) + "</td>"
					+ "<td class=\"datacolumn\" width=\"50%\">" + proposer + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){

				String pdf = "";
				if (enableCCLab.equals(Constant.ON)){
					pdf = "<td class=\"textblackth\" width=\"05%\">View</td>";
				}

				listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr height=\"30\" bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
					+ pdf
					+ "<td class=\"textblackth\" width=\"20%\">Approved Date</td>"
					+ "<td class=\"textblackth\" width=\"25%\">Effective Term</td>"
					+ "<td class=\"textblackth\" width=\"50%\">Proposer</td>"
					+ "</tr>"
					+ listings.toString()
					+ "</table>";
			}
			else{
				listing = "Data not found for selected index";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlines - " + ex.toString());
		}

		return listing;
	}

	public static String listOutlinesOBSOLETE(Connection conn,String campus,String alpha,String num,String type){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String historyid = "";
		String courseDate = "";
		String auditDate = "";
		String proposer = "";
		String title = "";
		String table = "tblCourse";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;

			if ("ARC".equals(type))
				table = "tblCourseARC";
			else if ("CAN".equals(type))
				table = "tblCourseCAN";

			sql = "SELECT historyid,coursedate,auditdate,proposer " +
				" FROM " + table +
				" WHERE campus=? AND " +
				" coursealpha=? AND " +
				" coursenum=? AND " +
				" coursetype=? " +
				" ORDER BY coursedate DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ps.setString(4,type);
			rs = ps.executeQuery();
			while ( rs.next() ){
				historyid = aseUtil.nullToBlank(rs.getString("historyid"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				courseDate = aseUtil.nullToBlank(rs.getString("coursedate"));
				if (courseDate != null && courseDate.length()>0)
					courseDate = aseUtil.ASE_FormatDateTime(courseDate,Constant.DATE_DATETIME);

				auditDate = aseUtil.nullToBlank(rs.getString("auditDate"));
				if (auditDate != null && auditDate.length()>0)
					auditDate = aseUtil.ASE_FormatDateTime(auditDate,Constant.DATE_DATETIME);

				if ("".equals(courseDate))
					courseDate = auditDate;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				// sending back hid=1 to force vwcrsx to not come back this way again
				link = "vwcrsx.jsp?hid=1&cps=" + campus + "&kix=" + historyid + "&t=" + type;
				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
					+ "<td class=\"linkcolumn\" width=\"20%\"><a href=\"" + link + "\" title=\"" + courseDate + "\" class=\"linkcolumn\">" + courseDate + "</a></td>"
					+ "<td class=\"datacolumn\" width=\"80%\">" + proposer + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr height=\"30\" bgcolor=\"" + Constant.HEADER_ROW_BGCOLOR + "\">"
					+ "<td class=\"textblackth\" width=\"20%\">Approved Date</td>"
					+ "<td class=\"textblackth\" width=\"80%\">Proposer</td>"
					+ "</tr>"
					+ listings.toString()
					+ "</table>";
			}
			else{
				listing = "Data not found for selected index";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlines - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlines (unlike the other listOutlines, this one links using alpha and number (no kix))
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlines(Connection conn,String type,int idx){

		StringBuffer listings = new StringBuffer();
		String[] campuses = new String[20];
		String listing = "";
		String alpha = "";
		String num = "";
		String title = "";
		String table = "tblCourse";
		String campus = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				campus = CampusDB.getCampusNames(conn);
				if (!"".equals(campus))
					campuses = campus.split(",");

				campus = "";

				if ("ARC".equals(type))
					table = "tblCourseARC";
				else if ("CAN".equals(type))
					table = "tblCourseCAN";

				sql = "SELECT DISTINCT coursealpha,coursenum " +
					" FROM " + table +
					" WHERE coursealpha like '" + (char)idx + "%' AND " +
					" coursetype=? " +
					" ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"\" width=\"10%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;" + "</td>");
					for (i=0;i<campuses.length;i++){
						if (CourseDB.courseExistByTypeCampus(conn,campuses[i],alpha,num,type)){
							title = CourseDB.getCourseDescriptionByType(conn,campuses[i],alpha,num,type);
							link = "vwcrsx.jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
							listings.append("<td class=\"linkcolumn\" align=\"center\" width=\"8%\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + campuses[i] + "</a></td>");
						}
						else{
							listings.append("<td align=\"center\" valign=\"middle\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>");
						}
					}
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlines - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlinesToDisplay
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * @param	callTo	String
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesToDisplay(Connection conn,
																String type,
																int idx,
																String alpha,
																String num,
																String callTo){

		String listing = "";
		String table = "tblCourse";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type))
					table = "tblCourseARC";
				else if ("CAN".equals(type))
					table = "tblCourseCAN";

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha=? " +
						" AND coursenum=? " +
						" AND coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					ps.setString(3,type);
				}
				else if (alpha.length()>0 && num.length()==0){
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha=? " +
						" AND coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,type);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha like '" + (char)idx + "%' AND " +
						" coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,type);
				}
				rs = ps.executeQuery();

				listing = showCampusWideOutlines(conn,rs,callTo,type);

				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinesToDisplay - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlinesToDisplay - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlinesToDisplayX
	 * <p>
	 * @param	conn			Connection
	 * @param	type			String
	 * @param	idx			int
	 * @param	alpha			String
	 * @param	num			String
	 * @param	caller		String
	 * @param	target		boolean
	 * @param	showTitle	boolean
	 * @param	searchTitle	String
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesToDisplayX(Connection conn,
																String type,
																int idx,
																String alpha,
																String num,
																String caller,
																boolean target){

		return listOutlinesToDisplayX(conn,type,idx,alpha,num,caller,target,false,null);


	}

	public static String listOutlinesToDisplayX(Connection conn,
																String type,
																int idx,
																String alpha,
																String num,
																String caller,
																boolean target,
																boolean showTitle,
																String searchTitle){

		return listOutlinesToDisplayX(conn,type,idx,alpha,num,caller,target,showTitle,searchTitle,null);

	}

	public static String listOutlinesToDisplayX(Connection conn,
																String type,
																int idx,
																String alpha,
																String num,
																String caller,
																boolean target,
																boolean showTitle,
																String searchTitle,
																String userCampus){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		boolean found = false;
		boolean linked = false;

		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		int j = 0;
		int i = 0;

		String rowColor = "";
		String title = "";
		String link = "";
		String temp = "";

		String[] campuses = null;
		String[] campuses_2 = null;
		String[] campusTitles = null;
		StringBuffer listings = new StringBuffer();

		String campus = "";
		String campus_2 = "";
		String historyid = "";

		String inAlpha = alpha;
		String inNum = num;

		//
		// target should only be true for when viewing of CUR outlines.
		//

		String browserTarget = "target=\"_blank\"";

		if (!target){
			browserTarget = "";
		}

		try{

			String enableCCLab = "";

			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0 || searchTitle.length()>0) && !(Constant.BLANK).equals(type)){

				if(userCampus != null){
					enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,userCampus,"System","EnableCCLab");
				}

				String sql = "";
				String sql_2 = "";
				String order = "";
				String where = " AND coursetype=? ";
				PreparedStatement ps;

				campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");
				if (campus != null){
					campuses = campus.split(",");
					campus_2 = campus.replace(",","_2,") + "_2";
					campuses_2 = campus_2.split(",");
					campusTitles = new String[campuses.length];
				}

				sql = "SELECT DISTINCT coursealpha,coursenum," + campus + "," + campus_2 +
						" FROM tblCampusOutlines ";

				order = " ORDER BY coursealpha,coursenum";

				where = " AND coursetype= ?";

				int width = (100-10)/campuses.length;

				if (searchTitle != null && searchTitle.length() > 0){
						for(int x = 0; x < campuses_2.length; x++){
							if (x==0)
								sql_2 = campuses_2[x] + " like '%"+searchTitle+"%' ";
							else
								sql_2 += " OR " + campuses_2[x] + " like '%"+searchTitle+"%' ";
						}
						sql = sql + " WHERE (" + sql_2 + ")" + where + order;
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
				}
				else{
					if (alpha.length()>0 && num.length()>0){
						sql = sql +
							" WHERE coursealpha=? " +
							" AND coursenum=? ";
						sql = sql + where + order;
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
						ps.setString(3,type);
					}
					else if (alpha.length()>0 && num.length()==0){
						sql = sql +
							" WHERE coursealpha=? ";
						sql = sql + where + order;
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,type);
					}
					else{
						sql = sql +
							" WHERE coursealpha like '" + (char)idx + "%' ";
						sql = sql + where + order;
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
					}
				}
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));

					title = "view outline";
					linked = false;
					temp = "";

					for (i=0;i<campuses.length;i++){

						campusTitles[i] = AseUtil.nullToBlank(rs.getString(campuses[i]+"_2"));

						title = campusTitles[i];

						historyid = AseUtil.nullToBlank(rs.getString(campuses[i]));

						// use target only if viewing as HTML
						browserTarget = "target=\"_blank\"";

						if (!historyid.equals(Constant.BLANK)){
							if (type.equals("CUR") && target){
								link = "/central/core/vwhtml.jsp?cps=" + campuses[i] + "&kix=" + historyid;
							}
							else{
								browserTarget = "";
								link = caller + ".jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
							}

							temp += "<td class=\"linkcolumn\" align=\"center\" width=\""+width+"%\">"
								+ "<a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\" "+browserTarget+">" + campuses[i] + "</a>";

							//
							// don't show until we get to the next level of display for Archived terms
							//
							if (enableCCLab.equals(Constant.ON) && !type.equals("ARC")){
								temp += "&nbsp;&nbsp;<a href=\"/central/core/vwpdf.jsp?kix=" + historyid + "\" title=\"" + title + "\" class=\"linkcolumn\" target=\"_blank\">"
									+ "<img src=\"../images/ext/pdf.gif\" title=\"" + title + "\">"
									+ "</a>";
							}

							temp += "</td>";

							linked = true;
						}
						else{
							temp += "<td align=\"center\" valign=\"middle\" width=\""+width+"%\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>";
						} // historyid

					} // for

					if (linked){

						if (j++ % 2 == 0)
							rowColor = Constant.EVEN_ROW_BGCOLOR;
						else
							rowColor = Constant.ODD_ROW_BGCOLOR;

						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
											+ "<td class=\"\" width=\"10%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;" + "</td>"
											+ temp
											+ "</tr>");

						if (showTitle){
							listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
												+ "<td class=\"\" width=\"10%\" valign=\"middle\">&nbsp;</td>"
												+ "<td class=\"\" colspan=\""+campuses.length+"\">");

							listings.append("<br><p><table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
							for (i=0;i<campuses.length;i++){

								if (campusTitles[i] != null && campusTitles[i].length() > 0){
									listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">"
														+ "<td class=\"datacolumn\" width=\"10%\">"+campuses[i]+"</td>"
														+ "<td class=\"datacolumn\" width=\"90%\">"+campusTitles[i]+"</td>"
														+ "</tr>");
								}

							} // for

							listings.append("</table></p>");

							listings.append( "</td>"
												+ "</tr>");
						}

						found = true;
					}
				}
				rs.close();
				ps.close();

				if (found)
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
				else
					listing = "Data not found for selected index";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinesToDisplayX - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlinesToDisplayX - " + ex.toString());
		}

		return listing;
	}

	/**
	 * showCampusWideOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	rs			ResultSet
	 * @param	caller	String
	 * @param	type		String
	 * <p>
	 * @return	String
	 */
	public static String showCampusWideOutlines(Connection conn,ResultSet rs,String caller,String type){

		//Logger logger = Logger.getLogger("test");

		int j = 0;
		int i = 0;

		String alpha = "";
		String num = "";
		String rowColor = "";
		String title = "";
		String link = "";

		String[] campuses = new String[20];
		StringBuffer listings = new StringBuffer();

		String campus = "";
		boolean found = false;

		String listing = null;

		try{
			AseUtil aseUtil = new AseUtil();

			campus = CampusDB.getCampusNames(conn);
			if (!campus.equals(Constant.BLANK)){
				campuses = campus.split(",");
			}

			//
			// we don't really have DEL as a type. This is just another way to prvoide info
			//
			if(type.equals("DEL")){
				type = "ARC";
			}

			campus = "";

			while (rs.next()){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"\" width=\"10%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;" + "</td>");
				for (i=0;i<campuses.length;i++){
					if (CourseDB.courseExistByTypeCampus(conn,campuses[i],alpha,num,type)){
						title = CourseDB.getCourseDescriptionByType(conn,campuses[i],alpha,num,type);
						link = caller + ".jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
						listings.append("<td class=\"linkcolumn\" align=\"center\" width=\"8%\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + campuses[i] + "</a></td>");
					}
					else{
						listings.append("<td align=\"center\" valign=\"middle\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>");
					}
				}
				listings.append("</tr>");

				found = true;
			}

			if (found){
				listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
			}
			else{
				listing = "Data not found for selected index";
			}

		}
		catch( SQLException e ){
			logger.fatal("Helper: showCampusWideOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: showCampusWideOutlines - " + ex.toString());
		}

		return listing;
	}

	public static String showCampusWideOutlinesOBSOLETE(Connection conn,ResultSet rs,String caller,String type){

		int j = 0;
		int i = 0;

		String alpha = "";
		String num = "";
		String rowColor = "";
		String title = "";
		String link = "";

		String[] campuses = new String[20];
		StringBuffer listings = new StringBuffer();

		String campus = "";
		boolean found = false;

		String listing = null;

		try{
			AseUtil aseUtil = new AseUtil();

			campus = CampusDB.getCampusNames(conn);
			if (!"".equals(campus))
				campuses = campus.split(",");

			campus = "";

			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"\" width=\"10%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;" + "</td>");
				for (i=0;i<campuses.length;i++){
					if (CourseDB.courseExistByTypeCampus(conn,campuses[i],alpha,num,type)){
						title = CourseDB.getCourseDescriptionByType(conn,campuses[i],alpha,num,type);
						link = caller + ".jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
						listings.append("<td class=\"linkcolumn\" align=\"center\" width=\"8%\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + campuses[i] + "</a></td>");
					}
					else{
						listings.append("<td align=\"center\" valign=\"middle\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>");
					}
				}
				listings.append("</tr>");

				found = true;
			}

			if (found){
				listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
			}
			else{
				listing = "Data not found for selected index";
			}

		}
		catch( SQLException e ){
			logger.fatal("Helper: showCampusWideOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: showCampusWideOutlines - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlines
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlines(Connection conn,String type,String caller,int idx){

		String listing = "";
		String table = "tblCourse";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type))
					table = "tblCourseARC";

				sql = "SELECT DISTINCT coursealpha,coursenum " +
					" FROM " + table +
					" WHERE coursealpha like '" + (char)idx + "%' AND " +
					" coursetype=? " +
					" ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlines - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlines - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineDetails
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineDetails(Connection conn,String type,String caller,int idx,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		String table = "tblCourse";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				String select = "SELECT DISTINCT coursealpha,coursenum ";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type)){
					table = "tblCourseARC";
				}
				else if ("DEL".equals(type)){
					table = "vw_keeDEL";
				}

				if (alpha.length()>0 && num.length()>0){
					if ("DEL".equals(type)){
						sql = select +
							" FROM " + table +
							" WHERE coursealpha=? AND coursenum=? ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
					}
					else{
						sql = select +
							" FROM " + table +
							" WHERE coursealpha=? AND coursenum=? AND coursetype=? ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,num);
						ps.setString(3,type);
					}
				}
				else if (alpha.length()>0){
					if ("DEL".equals(type)){
						sql = select +
							" FROM " + table +
							" WHERE coursealpha=? ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
					}
					else{
						sql = select +
							" FROM " + table +
							" WHERE coursealpha=? AND coursetype=? ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
						ps.setString(1,alpha);
						ps.setString(2,type);
					}
				}
				else{
					if ("DEL".equals(type)){
						sql = select +
							" FROM " + table +
							" WHERE coursealpha like '" + (char)idx + "%' ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
					}
					else{
						sql = select +
							" FROM " + table +
							" WHERE coursealpha like '" + (char)idx + "%' AND " +
							" coursetype=? ORDER BY coursealpha,coursenum ";
						ps = conn.prepareStatement(sql);
						ps.setString(1,type);
					}
				}
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineDetails - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineDetails - " + ex.toString());
		}

		return listing;
	}

	public static String listOutlineDetailsOBSOLETE(Connection conn,String type,String caller,int idx,String alpha,String num){

		String listing = "";
		String table = "tblCourse";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				String select = "SELECT DISTINCT coursealpha,coursenum ";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type))
					table = "tblCourseARC";

				if (alpha.length()>0 && num.length()>0){
					sql = select +
						" FROM " + table +
						" WHERE coursealpha=? " +
						" AND coursenum=? " +
						" AND coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					ps.setString(3,type);
				}
				else if (alpha.length()>0){
					sql = select +
						" FROM " + table +
						" WHERE coursealpha=? " +
						" AND coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,type);
				}
				else{
					sql = select +
						" FROM " + table +
						" WHERE coursealpha like '" + (char)idx + "%' AND " +
						" coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,type);
				}
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineDetails - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineDetails - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlinesByAlpha
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha 	String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesByAlpha(Connection conn,String type,String caller,int idx,String alpha,String num){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		String table = "tblCourse";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type))
					table = "tblCourseARC";

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha=? AND " +
						" coursenum=? AND " +
						" coursetype=? ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					ps.setString(3,type);
				}
				else if (alpha.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha=? AND " +
						" coursetype=? ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,type);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum " +
						" FROM " + table +
						" WHERE coursealpha like '" + (char)idx + "%' AND " +
						" coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,type);
				}
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinesByAlpha - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlinesByAlpha - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineRawEdit
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlineRawEdit(Connection conn,String campus,String type,String caller,int idx){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){

				String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");

				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				sql = "SELECT DISTINCT historyid,coursealpha,coursenum,progress,proposer FROM tblCourse " +
					"WHERE campus=? AND coursetype=? AND coursealpha like '" + (char)idx + "%' " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				rs = ps.executeQuery();
				while ( rs.next() ){

					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					proposer = aseUtil.nullToBlank(rs.getString("proposer"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type);
					kix = Helper.getKix(conn,campus,alpha,num,type);
					link = caller + ".jsp?cps=" + campus + "&kix=" + kix;

					if (enableCCLab.equals(Constant.ON)){
						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
							.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>")
							.append("<td class=\"datacolumn\"><a href=\"vwpdf.jsp?kix="+kix+"\" title=\"" + title + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a></td>")
							.append("<td class=\"datacolumn\">" + title + "</td>")
							.append("<td class=\"datacolumn\">" + proposer + "</td>")
							.append("<td class=\"datacolumn\">" + progress + "</td>")
							.append("</tr>");
					}
					else{
						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
							.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>")
							.append("<td class=\"datacolumn\">" + title + "</td>")
							.append("<td class=\"datacolumn\">" + proposer + "</td>")
							.append("<td class=\"datacolumn\">" + progress + "</td>")
							.append("</tr>");
					}

					found = true;
				}
				rs.close();
				ps.close();

				if (found){

					if (enableCCLab.equals(Constant.ON)){
						listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"12%\">Edit</td>" +
							"<td class=\"textblackth\" width=\"12%\">View</td>" +
							"<td class=\"textblackth\" width=\"46%\">Title</td>" +
							"<td class=\"textblackth\" width=\"20%\">Proposer</td>" +
							"<td class=\"textblackth\" width=\"20%\">Progress</td>" +
							"</tr>" +
							listings.toString() +
							"</table>";
					}
					else{
						listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
							"<td class=\"textblackth\" width=\"48%\">Title</td>" +
							"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
							"<td class=\"textblackth\" width=\"25%\">Progress</td>" +
							"</tr>" +
							listings.toString() +
							"</table>";
					}

				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineRawEdit - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineRawEdit - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineRawEdit
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineRawEdit(Connection conn,String campus,String type,String caller,int idx,String alpha,String num){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){

				String enableCCLab = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableCCLab");

				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum,progress,proposer FROM tblCourse" +
						" WHERE campus=? AND coursetype=? AND coursealpha=? AND coursenum=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ps.setString(3,alpha);
					ps.setString(4,num);
				}
				else if (alpha.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum,progress,proposer " +
						" FROM tblCourse" +
						" WHERE campus=? AND " +
						" coursetype=? AND " +
						" coursealpha=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ps.setString(3,alpha);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum,progress,proposer " +
						" FROM tblCourse" +
						" WHERE campus=? AND " +
						" coursetype=? AND " +
						" coursealpha like '" + (char)idx + "%' " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
				}
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
					progress = aseUtil.nullToBlank(rs.getString("progress")).trim();
					proposer = aseUtil.nullToBlank(rs.getString("proposer")).trim();

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type);
					kix = Helper.getKix(conn,campus,alpha,num,type);
					link = caller + ".jsp?cps=" + campus + "&kix=" + kix;

					if (enableCCLab.equals(Constant.ON)){
						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
							.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>")
							.append("<td class=\"datacolumn\"><a href=\"vwpdf.jsp?kix="+kix+"\" title=\"" + title + "\" class=\"linkcolumn\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a></td>")
							.append("<td class=\"datacolumn\">" + title + "</td>")
							.append("<td class=\"datacolumn\">" + proposer + "</td>")
							.append("<td class=\"datacolumn\">" + progress + "</td>")
							.append("</tr>");
					}
					else{
						listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
							.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>")
							.append("<td class=\"datacolumn\">" + title + "</td>")
							.append("<td class=\"datacolumn\">" + proposer + "</td>")
							.append("<td class=\"datacolumn\">" + progress + "</td>")
							.append("</tr>");
					}

					found = true;
				}
				rs.close();
				ps.close();

				if (found){

					if (enableCCLab.equals(Constant.ON)){
						listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"12%\">Edit</td>" +
							"<td class=\"textblackth\" width=\"12%\">View</td>" +
							"<td class=\"textblackth\" width=\"46%\">Title</td>" +
							"<td class=\"textblackth\" width=\"20%\">Proposer</td>" +
							"<td class=\"textblackth\" width=\"20%\">Progress</td>" +
							"</tr>" +
							listings.toString() +
							"</table>";
					}
					else{
						listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
							"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
							"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
							"<td class=\"textblackth\" width=\"48%\">Title</td>" +
							"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
							"<td class=\"textblackth\" width=\"25%\">Progress</td>" +
							"</tr>" +
							listings.toString() +
							"</table>";
					}

				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineRawEdit - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineRawEdit - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineForRename
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlineForRename(Connection conn,String campus,String caller,int idx,String type){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";

		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if (idx>=LETTER_A && idx<=LETTER_Z){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				RenameDB renameDB = new RenameDB();

				// show only outlines with 1 copy at the campus. when there is more than
				// 1 copy, that means they have PRE and CUR at the same time and that
				// cannot be renamed
				// when an ouline is created for the first time, it exists as PRE and therefore,
				// it is not correct to select by CUR only
				sql = "SELECT historyid, CourseAlpha, CourseNum, proposer, Progress, coursetitle "
						+ "FROM tblCourse WHERE campus=? "
						+ "AND CourseAlpha LIKE '" + (char)idx + "%' "
						+ "AND coursetype=? ORDER BY CourseAlpha,CourseNum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				rs = ps.executeQuery();
				while (rs.next()){

					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));

					// do not allow rename of on going rename
					if(!renameDB.isMatch(conn,campus,alpha,num)){
						progress = aseUtil.nullToBlank(rs.getString("progress"));
						proposer = aseUtil.nullToBlank(rs.getString("proposer"));
						title = aseUtil.nullToBlank(rs.getString("coursetitle"));
						kix = aseUtil.nullToBlank(rs.getString("historyid"));

						if(!ApproverDB.approvalInProgress(conn,kix)){

							if (j++ % 2 == 0){
								rowColor = Constant.EVEN_ROW_BGCOLOR;
							}
							else{
								rowColor = Constant.ODD_ROW_BGCOLOR;
							}

							link = caller + ".jsp?cps=" + campus + "&kix=" + kix + "&type=" + type;

							listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">")
								.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>")
								.append("<td class=\"datacolumn\">" + title + "</td>")
								.append("<td class=\"datacolumn\">" + proposer + "</td>")
								.append("<td class=\"datacolumn\">" + progress + "</td>")
								.append("</tr>");

							found = true;

						} // approval not in progress

					} // match

				}
				rs.close();
				ps.close();

				renameDB = null;

				if (found){
					listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"48%\">Title</td>" +
						"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
						"<td class=\"textblackth\" width=\"25%\">Progress</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineForRename - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineForRename - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineAssessments - outlines ready for assessment
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	caller	String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineAssessments(Connection conn,String campus,String caller,String user){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		String coursedate = "";
		boolean found = false;
		int i = 0;
		int j = 0;

		String sql = "";
		String dept = "";
		PreparedStatement ps;
		ResultSet rs;

		/*
			display all outlines for this  user.
		*/

		try{
			AseUtil aseUtil = new AseUtil();

			dept = UserDB.getUserDepartment(conn,user);

			// select all ready for assessment but not already going through assessment
			sql = "SELECT DISTINCT coursealpha,coursenum,progress,proposer,coursetitle,historyid,coursedate " +
				" FROM tblCourse " +
				" WHERE campus=? AND " +
				" coursealpha=? AND " +
				" coursetype='CUR' AND " +
				" progress='APPROVED' AND " +
				" coursenum NOT IN " +
				"( " +
				"SELECT coursenum " +
				"FROM tblSLO " +
				"WHERE campus=? AND " +
				"coursealpha=? " +
				") " +
				" ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,dept);
			ps.setString(3,campus);
			ps.setString(4,dept);

			rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				progress = aseUtil.nullToBlank(rs.getString("progress"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				coursedate = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME);

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				link = caller + ".jsp?cps=" + campus + "&kix=" + kix;
				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
				listings.append("<td class=\"linkcolumn\" nowrap><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + title + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + proposer + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + progress + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + coursedate + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
					"<td class=\"textblackth\" width=\"40%\">Title</td>" +
					"<td class=\"textblackth\" width=\"18%\">Proposer</td>" +
					"<td class=\"textblackth\" width=\"18%\">Progress</td>" +
					"<td class=\"textblackth\" width=\"18%\">Course Date</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
			else{
				listing = "Outline not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineAssessments - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineAssessments - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineAssessing
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	caller	String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineAssessing(Connection conn,String campus,String caller,String user){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		String auditdate = "";
		boolean found = false;
		int i = 0;
		int j = 0;

		String sql = "";
		String dept = "";
		PreparedStatement ps;
		ResultSet rs;

		/*
			display all outlines for this  user.
		*/

		try{
			AseUtil aseUtil = new AseUtil();

			dept = UserDB.getUserDepartment(conn,user);

			sql = "SELECT s.CourseAlpha, s.CourseNum,c.coursetitle,s.progress,s.auditby,c.historyid,s.auditdate " +
				"FROM tblCourse as c, tblSLO as s " +
				"WHERE c.historyid=s.hid AND " +
				"c.campus=? AND " +
				"c.coursealpha=? AND " +
				"s.progress=? " +
				"ORDER BY s.coursealpha,s.coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,dept);
			ps.setString(3,"ASSESS");
			rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
				kix = aseUtil.nullToBlank(rs.getString("historyid")).trim();
				progress = aseUtil.nullToBlank(rs.getString("progress")).trim();
				proposer = aseUtil.nullToBlank(rs.getString("auditby")).trim();
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).trim();
				auditdate = aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME);

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				link = caller + ".jsp?cps=" + campus + "&kix=" + kix;
				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");

				if (user.equals(proposer))
					listings.append("<td class=\"linkcolumn\" nowrap><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
				else
					listings.append("<td class=\"linkcolumn\" nowrap>" + alpha + " " + num + "</td>");

				listings.append("<td class=\"datacolumn\" nowrap>" + title + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + proposer + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + progress + "</td>");
				listings.append("<td class=\"datacolumn\" nowrap>" + auditdate + "</td>");
				listings.append("</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
					"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
					"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
					"<td class=\"textblackth\" width=\"40%\">Title</td>" +
					"<td class=\"textblackth\" width=\"18%\">Proposer</td>" +
					"<td class=\"textblackth\" width=\"18%\">Progress</td>" +
					"<td class=\"textblackth\" width=\"18%\">Last Updated</td>" +
					"</tr>" +
					listings.toString() +
					"</table>";
			}
			else{
				listing = "Outline not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineAssessing - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineAssessing - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineModifications
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineModifications(Connection conn,String campus,String type,String caller,String user){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;
		int i = 0;

		String sql = "";
		String dept = "";
		PreparedStatement ps;
		ResultSet rs;

		String tempData = "";
		String tempField = "";
		String tempTitle = "";

		//
		//	display all outlines for this  user. When type is PRE, select by proposer name as well.
		//

		try{
			AseUtil aseUtil = new AseUtil();

			tempField = "coursedate";
			tempTitle = "Course Date";
			if ("PRE".equals(type)){
				tempField = "proposer";
				tempTitle = "Proposer";
			}

			boolean allAlphas = false;

			// get departments and determine if alpha is all access
			dept = UserDB.getUserDepartments(conn,user);
			if(dept.toUpperCase().indexOf("*ALL") > -1){
				allAlphas = true;
			}

			// if not all alpha, get the user department (no 's')
			if(!allAlphas){
				dept = UserDB.getUserDepartment(conn,user);
			}

			if (type.equals("PRE")){
				if(allAlphas){
					sql = "SELECT DISTINCT coursealpha,coursenum,proposer,progress " +
						" FROM tblCourse WHERE campus=? AND coursetype=? ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum,proposer,progress " +
						" FROM tblCourse WHERE campus=? AND coursetype=? AND coursealpha=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ps.setString(3,dept);
				}
			}
			else{
				// take only courses with type='CUR'. If they have 'CUR' and 'PRE' then they are
				// already being modified and shouldn't be allowed to be selected.
				if(allAlphas){
					sql = "SELECT DISTINCT coursealpha,coursenum,MAX(coursedate) AS coursedate,progress " +
						"FROM tblCourse " +
						"WHERE campus=? AND coursetype=? " +
						"GROUP BY CourseAlpha, CourseNum, Progress " +
						"HAVING coursealpha+CourseNum NOT IN " +
						"( " +
						"SELECT DISTINCT coursealpha+coursenum FROM tblCourse WHERE campus=? AND coursetype='PRE' " +
						") " +
						"ORDER BY coursealpha,coursenum ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ps.setString(3,campus);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum,MAX(coursedate) AS coursedate,progress " +
						"FROM tblCourse " +
						"WHERE campus=? AND coursetype=? " +
						"GROUP BY CourseAlpha, CourseNum, Progress " +
						"HAVING coursealpha=? AND " +
						"CourseNum NOT IN " +
						"( " +
						"SELECT DISTINCT coursenum FROM tblCourse " +
						"WHERE campus=? AND coursetype='PRE' AND coursealpha=? " +
						") " +
						"ORDER BY coursealpha,coursenum ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
					ps.setString(3,dept);
					ps.setString(4,campus);
					ps.setString(5,dept);
				}
			}

			rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
				progress = aseUtil.nullToBlank(rs.getString("progress")).trim();
				tempData = aseUtil.nullToBlank(rs.getString(tempField)).trim();

				title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type);
				kix = Helper.getKix(conn,campus,alpha,num,type);
				link = caller + ".jsp?cps=" + campus + "&kix=" + kix;

				listings.append("<tr>");

				if (type.equals("PRE")){
					// don't allow view when not proposer
					if (user.equals(tempData))
						listings.append("<td align=\"left\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					else
						listings.append("<td align=\"left\">" + alpha + " " + num + "</td>");
				}
				else{
					tempData = aseUtil.ASE_FormatDateTime(tempData,Constant.DATE_DATETIME);
					listings.append("<td align=\"left\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
				}

				listings.append("<td align=\"left\">" + title + "</td>"
					+ "<td align=\"left\">" + tempData + "</td>"
					+ "<td align=\"left\">" + progress + "</td>"
					+ "</tr>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<div id=\"container90\"><div id=\"demo_jui\"><table id=\"crsmodappr\" class=\"display\"><thead>" +
					"<tr>" +
					"<th align=\"left\">Outline</th>" +
					"<th align=\"left\">Title</th>" +
					"<th align=\"left\">" + tempTitle + "</th>" +
					"<th align=\"left\">Progress</th>" +
					"</tr></thead><tbody>" +
					listings.toString() +
					"</tbody></table></div></div>";
			}
			else{
				listing = "Outline not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineModifications - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineModifications - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlinePrereqs - displays outlines listed as pre-reqs
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlinePrereqs(Connection conn,String type,String caller,int idx,String alpha,String num){

		String listing = "";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT prereqAlpha AS coursealpha,prereqNum AS coursenum " +
						"FROM tblprereq " +
						"WHERE prereqAlpha=? " +
						"AND prereqNum=? " +
						"AND coursetype=? " +
						"ORDER BY prereqAlpha,prereqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					ps.setString(3,type);
				}
				else if (alpha.length()>0){
					sql = "SELECT DISTINCT prereqAlpha AS coursealpha,prereqNum AS coursenum " +
						"FROM tblprereq " +
						"WHERE prereqAlpha=? " +
						"AND coursetype=? " +
						"ORDER BY prereqAlpha,prereqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,type);
				}
				else{
					sql = "SELECT DISTINCT prereqAlpha AS coursealpha,prereqNum AS coursenum " +
						"FROM tblprereq " +
						"WHERE prereqAlpha like '" + (char)idx + "%' AND " +
						"coursetype=? " +
						"ORDER BY prereqAlpha,prereqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,type);
				}
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinePrereqs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlinePrereqs - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineCoreqs - displays outlines listed as co-reqs
	 * <p>
	 * @param	conn		Connection
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineCoreqs(Connection conn,String type,String caller,int idx,String alpha,String num){

		String listing = "";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT coreqAlpha AS coursealpha,coreqNum AS coursenum " +
						"FROM tblcoreq " +
						"WHERE coreqAlpha=? " +
						"AND coreqNum=? " +
						"AND coursetype=? " +
						"ORDER BY coreqAlpha,coreqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,num);
					ps.setString(3,type);
				}
				else if (alpha.length()>0){
					sql = "SELECT DISTINCT coreqAlpha AS coursealpha,coreqNum AS coursenum " +
						"FROM tblcoreq " +
						"WHERE coreqAlpha=? " +
						"AND coursetype=? " +
						"ORDER BY coreqAlpha,coreqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,alpha);
					ps.setString(2,type);
				}
				else{
					sql = "SELECT DISTINCT coreqAlpha AS coursealpha,coreqNum AS coursenum " +
						"FROM tblcoreq " +
						"WHERE coreqAlpha like '" + (char)idx + "%' AND " +
						"coursetype=? " +
						"ORDER BY coreqAlpha,coreqNum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,type);
				}
				rs = ps.executeQuery();
				listing = showCampusWideOutlines(conn,rs,caller,type);
				rs.close();
				ps.close();
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineCoreqs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineCoreqs - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineSLOs
	 * <p>
	 * @param	conn	Connection
	 * @param	type	String
	 * @param	idx	int
	 * <p>
	 * @return	String
	 */
	public static String listOutlineSLOs(Connection conn,String type,int idx){

		StringBuffer listings = new StringBuffer();
		String[] campuses = new String[20];
		String listing = "";
		String alpha = "";
		String num = "";
		String title = "";
		String campus = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				campus = CampusDB.getCampusNames(conn);
				if (!"".equals(campus))
					campuses = campus.split(",");

				campus = "";

				sql = "SELECT DISTINCT coursealpha,coursenum " +
					"FROM tblCoursecomp " +
					"WHERE coursealpha like '" + (char)idx + "%' AND " +
					"coursetype=? " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,type);
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;


					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td class=\"\" width=\"10%\" valign=\"middle\">" + alpha + " " + num + "&nbsp;" + "</td>");
					for (i=0;i<campuses.length;i++){
						if (CourseDB.courseSLOExistByTypeCampus(conn,campuses[i],alpha,num,type)){
							if ("PRE".equals(type))
								title = CourseDB.getCourseDescriptionByType(conn,campuses[i],alpha,num,"PRE");
							else
								title = CourseDB.getCourseDescription(conn,alpha,num,campuses[i]);

							link = "vwcrsslo.jsp?cps=" + campuses[i] + "&alpha=" + alpha + "&num=" + num + "&t=" + type;
							listings.append("<td class=\"linkcolumn\" align=\"center\" width=\"8%\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + campuses[i] + "</a></td>");
						}
						else{
							listings.append("<td align=\"center\" valign=\"middle\"><font color=\"#c0c0c0\">" + campuses[i] + "</font></td>");
						}
					}
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineSLOs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineSLOs - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineSLOs
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlineSLOs(Connection conn,String campus,String user,String type,String caller,int idx){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String kix = "";
		String title = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				sql = "SELECT DISTINCT historyid,coursealpha,coursenum " +
					"FROM tblCoursecomp " +
					"WHERE campus=? AND " +
					"coursetype=? AND " +
					"coursealpha like '" + (char)idx + "%' " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				rs = ps.executeQuery();
				while ( rs.next() ){
					kix = aseUtil.nullToBlank(rs.getString("historyid")).trim();
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					title = CourseDB.getCourseDescription(conn,alpha,num,campus);
					link = caller + ".jsp?kix=" + kix;
					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\" width=\"10%\"><a href=\"" + link +  "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\" width=\"90%\">" + title + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineSLOs - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineSLOs - " + ex.toString());
		}

		return listing;
	}

	/**
	 * showOutlinesUserMayCancel - outlines that a user can cancel (only proposer)
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesUserMayCancel(Connection conn,String campus,String user){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{

			// for a delete, once initiated, it goes to approval. there is no
			// modificaitons allowed.
			// can cancel approvals for deletes but not allow to see as modifications
			String sql = "SELECT id,coursealpha,coursenum,coursetitle " +
				"FROM tblCourse " +
				"WHERE campus=? AND proposer=? AND coursetype='PRE' AND progress<>? " +
				"ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.COURSE_DELETE_TEXT);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				link = "crscan.jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesUserMayCancel - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	/**
	 * showOutlinesByUserProgress - show outlines by user and outline progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	progress	String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesByUserProgress(Connection conn,
																	String campus,
																	String user,
																	String progress,
																	String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String subprogress = "";

		boolean found = false;
		boolean showLink = false;

		try{
			String sql = "";
			PreparedStatement ps = null;

			if (user == null || user.length() == 0){
				// as administrators, show all modify/approval progress
				// so they may edit enabled items.
				sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress " +
					"FROM tblCourse WHERE campus=? AND (progress=? OR progress=?) " +
					"ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_MODIFY_TEXT);
				ps.setString(3,Constant.COURSE_APPROVAL_TEXT);
			}
			else{
				// when in review, make sure to include review in approval (SQL is different)
				// when in review in approval, don't include proposer's name
				if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress " +
						"FROM tblCourse WHERE campus=? AND proposer=? " +
						"AND progress=? ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
				}
				else if (progress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress " +
							"FROM tblCourse WHERE campus=? " +
							"AND (progress=? AND subprogress=?) ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,Constant.COURSE_APPROVAL_TEXT);
					ps.setString(3,Constant.COURSE_REVIEW_IN_APPROVAL);
				}
				else{
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress " +
						"FROM tblCourse WHERE campus=? " +
						"AND proposer=? AND Progress=? ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
				}
			}
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				showLink = true;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));

				// prevent proposer from cancelling reviews kicked off by approver
				if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL) || subprogress.equals(Constant.COURSE_REVIEW_IN_DELETE)){
					String currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					if (currentApprover != null && !currentApprover.equals(user))
						showLink = false;
				}

				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				link = caller + ".jsp?kix=" + kix;

				if (showLink){
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesByUserProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Outline does not exist for this request</li></ul>";
	} // showOutlinesByUserProgress

	/**
	 * showOutlinesNeedingApproval - outlines that a user needds to do approval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesNeedingApproval(Connection conn,String campus,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT id,CourseAlpha,CourseNum,coursetitle " +
				"FROM tblCourse " +
				"WHERE campus=? AND  " +
				"Progress='APPROVAL' " +
				"ORDER BY coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				if (CourseDB.isNextApprover(conn,campus,alpha,num,user) ){
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					kix = aseUtil.nullToBlank(rs.getString("id"));
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesNeedingApproval - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	/**
	 * showOutlinesNeedingSLOReview - outlines that a user wants reviewed
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesNeedingSLOReview(Connection conn,String campus,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String sql = "";
		int counter = 0;
		boolean found = false;

		try{
			/*
				get all outlines in proposed status for SLO. Once found, are there SLOs to review?
			*/
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT tc.id, ts.CourseAlpha, ts.CourseNum, tc.coursetitle " +
				"FROM tblSLO ts, tblCourse tc " +
				"WHERE ts.hid = tc.historyid AND " +
				"ts.campus=? AND " +
				"tc.proposer=? AND " +
				"ts.progress=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,"MODIFY");
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = aseUtil.nullToBlank(rs.getString("id"));
				if (CompDB.hasSLOsToReview(conn,kix)){
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesNeedingSLOReview - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	/**
	 * showSLOReadyToApprove - outlines that a user can approve must be in APPROVAL progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showSLOReadyToApprove(Connection conn,
																String campus,
																String user,
																String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String progress = "";
		String kix = "";
		String link = "";
		String temp = "";
		boolean found = false;

		try{
			/*
				get all outlines in proposed status. for each found, make sure there isn't a matching
				outline under slo review.
			*/
			if (DistributionDB.hasMember(conn,campus,"SLOApprover",user)){
				AseUtil aseUtil = new AseUtil();
				String sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,progress " +
					"FROM vw_SLOByProgress_2 vw WHERE vw.Campus=? AND progress=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,"APPROVAL");
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					kix = aseUtil.nullToBlank(rs.getString("historyid"));
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
				rs.close();
				ps.close();

				if (found)
					temp = "<ul>" + listing.toString() + "</ul>";
				else
					temp = "Outline does not exist for this request";
			}
			else
				temp = "You are not authorized to approve SLOs";
		}
		catch(Exception ex){
			logger.fatal("Helper: showSLOReadyToApprove - " + ex.toString());
		}

		return temp;
	}

	/**
	 * showOutlinesNeedingSLOApproval - outlines that a user wants approved must be in ASSESSED progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesNeedingSLOApproval(Connection conn,
																			String campus,
																			String user,
																			String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String progress = "";
		String kix = "";
		String link = "";
		String temp = "";
		boolean found = false;

		try{
			/*
				get all outlines in proposed status. for each found, make sure there isn't a matching
				outline under slo review.
			*/
			AseUtil aseUtil = new AseUtil();

			String dept = UserDB.getUserDepartment(conn,user);

			String sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,progress " +
				"FROM vw_SLOByProgress_2 vw " +
				"WHERE vw.Campus=? AND CourseAlpha=? AND progress=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,dept);
			ps.setString(3,"ASSESS");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				progress = aseUtil.nullToBlank(rs.getString("progress"));
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				temp = "<ul>" + listing.toString() + "</ul>";
			else
				temp = "Outline does not exist for this request";

		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesNeedingSLOApproval - " + ex.toString());
		}

		return temp;
	}

	/**
	 * showSLOApprovalToCancel - slo that a proposer can cancel from approval process
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	proposer	String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showSLOApprovalToCancel(Connection conn,String campus,String proposer,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String temp = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT tc.id, tc.CourseAlpha, tc.CourseNum, tc.coursetitle " +
				"FROM tblCourse tc INNER JOIN tblSLO ts ON (tc.campus = ts.campus) AND " +
				"(tc.CourseType = ts.CourseType AND " +
				"tc.CourseNum = ts.CourseNum AND " +
				"tc.CourseAlpha = ts.CourseAlpha) " +
				"WHERE tc.campus=? AND " +
				"tc.Progress='MODIFY' AND " +
				"tc.proposer=? AND " +
				"ts.Progress='APPROVAL' " +
				"ORDER BY tc.coursealpha,tc.coursenum";

			sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,progress " +
				"FROM vw_SLOByProgress_2 vw " +
				"WHERE vw.Campus=? AND " +
				"proposer=? AND " +
				"progress=?";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,proposer);
			ps.setString(3,"APPROVAL");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				temp = "<ul>" + listing.toString() + "</ul>";
			else
				temp = "Outline does not exist for this request";

		}
		catch(Exception ex){
			logger.fatal("Helper: showSLOApprovalToCancel - " + ex.toString());
		}

		return temp;
	}

	/**
	 * showSLOByProgress - display list of SLOs based on it's progress and MODIFY for course
	 *
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	reviewer	String
	 * @param	caller	String
	 * @param	progress	String
	 * <p>
	 * @return	String
	 */
	public static String showSLOByProgress(Connection conn,String campus,String reviewer,String caller,String progress){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String temp = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT tc.id, tc.CourseAlpha, tc.CourseNum, tc.coursetitle " +
				"FROM tblCourse tc INNER JOIN tblSLO ts ON (tc.campus = ts.campus) AND " +
				"(tc.CourseType = ts.CourseType AND " +
				"tc.CourseNum = ts.CourseNum AND " +
				"tc.CourseAlpha = ts.CourseAlpha) " +
				"WHERE tc.campus=? AND " +
				"tc.Progress='MODIFY' AND " +
				"ts.Progress=? " +
				"ORDER BY tc.coursealpha,tc.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,progress);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = aseUtil.nullToBlank(rs.getString("id"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found)
				temp = "<ul>" + listing.toString() + "</ul>";
			else
				temp = "Outline does not exist for this request";

		}
		catch(Exception ex){
			logger.fatal("Helper: showSLOByProgress - " + ex.toString());
		}

		return temp;
	}

	/**
	 * showSLOReviewToCancel - slo that a proposer can cancel from review process
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	proposer	String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showSLOReviewToCancel(Connection conn,String campus,String proposer,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "SELECT tc.id, tc.CourseAlpha, tc.CourseNum, tc.coursetitle " +
				"FROM tblCourse tc INNER JOIN tblSLO ts ON (tc.campus = ts.campus) AND " +
				"(tc.CourseType = ts.CourseType AND " +
				"tc.CourseNum = ts.CourseNum AND " +
				"tc.CourseAlpha = ts.CourseAlpha) " +
				"WHERE tc.campus=? AND " +
				"ts.auditby=? AND " +
				"ts.Progress='REVIEW' " +
				"ORDER BY tc.coursealpha,tc.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,proposer);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				kix = aseUtil.nullToBlank(rs.getString("id"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showSLOReviewToCancel - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	/**
	 * showOutlinesToView - show outlines by course type and alpha index;
	 *	using this for the following: comparing outlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesToView(Connection conn,String campus,String type,String caller,int idx){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String link = "";
		String kix = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		try{
			AseUtil aseUtil = new AseUtil();

			if ((idx>=LETTER_A && idx<=LETTER_Z) && !"".equals(type)){
				String sql = "SELECT coursealpha,coursenum,coursetitle,id " +
					"FROM tblCourse " +
					"WHERE campus=? AND " +
					"coursealpha like '" + (char)idx + "%' AND " +
					"coursetype=? " +
					"ORDER BY coursealpha,coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,type);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					kix = aseUtil.nullToBlank(rs.getString("id"));
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
				rs.close();
				ps.close();
			}
		}
		catch( SQLException se ){
			logger.fatal("Helper: showOutlinesToView\n" + se.toString());
			listing.setLength(0);
		}
		catch( Exception ex ){
			logger.fatal("Helper: showOutlinesToView - " + ex.toString());
			listing.setLength(0);
		}

		if (found){
			return "<ul>" + listing.toString() + "</ul>";
		}
		else{
			return "Outline does not exists for selected index.";
		}
	}

	/*
	 * showExcludedFromCatalog
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 *	<p>
	 * @return String
	 */
	public static String showExcludedFromCatalog(Connection conn,String campus,int idx){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String proposer = "";
		String coursedate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		boolean found = false;
		int i = 0;
		int j = 0;
		String rowColor = "";


		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT id,CourseAlpha,CourseNum,proposer,coursedate " +
				"FROM tblCourse " +
				"WHERE campus=? AND progress=? AND excluefromcatalog=? AND ";

			if (idx>0)
				sql += "coursealpha like '" + (char)idx + "%' AND ";

			sql += "CourseType='CUR' " +
				"ORDER BY coursealpha,coursenum";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"APPROVED");
			ps.setString(3,"1");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				kix = aseUtil.nullToBlank(rs.getString("id"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				proposer = aseUtil.nullToBlank(rs.getString("proposer"));

				coursedate = aseUtil.nullToBlank(rs.getString("coursedate"));
				if (!"".equals(coursedate))
					coursedate = aseUtil.ASE_FormatDateTime(coursedate,Constant.DATE_DATETIME);

				link = "vwcrsx.jsp?kix=" + kix;
				linkOutline = link;

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td>" +
					"<a href=\"" + linkOutline + "\" class=\"linkcolumn\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\"></a>&nbsp;&nbsp;" +
					"</td>" +
					"<td class=\"datacolumn\">" + alpha + " " + num + "</td>" +
					"<td class=\"datacolumn\">" + proposer + "</td>" +
					"<td class=\"datacolumn\">" + coursedate + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("Helper: showExcludedFromCatalog\n" + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("Helper: showExcludedFromCatalog - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">&nbsp;</td>" +
						"<td class=\"textblackTH\">Outline</td>" +
						"<td class=\"textblackTH\">Proposer</td>" +
						"<td class=\"textblackTH\">Approved Date</td>" +
						"</tr>" +
						listing.toString() +
						"</table>";
		else
			return "Outline not found";
	}	// showExcludedFromCatalog

	/*
	 * getSupportStaff
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String
	 */
	public static String getSupportStaff(Connection conn,String campus){

		StringBuffer listing = new StringBuffer();
		boolean found = false;
		int i = 0;
		String rowColor = "";

		try{
			String support = DistributionDB.getDistributionMembers(conn,campus,"Support");

			if (!"".equals(support) && support != null){
				String[] token = new String[20];
				token = support.split(",");
				for (i=0; i<token.length; i++) {

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">" +
						"<td class=\"datacolumn\">" + token[i] + "</td>" +
						"<td class=\"datacolumn\">" + UserDB.getUserEmail(conn,token[i]) + "</td>" +
						"</tr>");

					found = true;
				}
			}
		}
		catch(Exception ex){
			logger.fatal("Helper: getSupportStaff - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">Staff</td>" +
						"<td class=\"textblackTH\">Email</td></tr>" +
						listing.toString() +
						"</table>";
		else
			return "Support staff not available";
	}	// getSupportStaff

	/*
	 * getContactStaff
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 *	<p>
	 * @return String
	 */
	public static String getContactStaff(Connection conn,String campus){

		StringBuffer listing = new StringBuffer();
		boolean found = false;
		int i = 0;
		String rowColor = "";

		try{
			String support = DistributionDB.getDistributionMembers(conn,campus,"Contact");

			if (!"".equals(support) && support != null){
				String[] token = new String[20];
				token = support.split(",");
				for (i=0; i<token.length; i++) {

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">" +
						"<td class=\"datacolumn\">" + token[i] + "</td>" +
						"<td class=\"datacolumn\">" + UserDB.getUserEmail(conn,token[i]) + "</td>" +
						"</tr>");

					found = true;
				}
			}
		}
		catch(Exception ex){
			logger.fatal("Helper: getContactStaff - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">Contact</td>" +
						"<td class=\"textblackTH\">Email</td></tr>" +
						listing.toString() +
						"</table>";
		else
			return "Conact staff not available";
	}	// getContactStaff

	/*
	 * showLog
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	logType	String
	 *	<p>
	 * @return String
	 */
	public static String showLog(Connection conn,String campus,String logType){

		StringBuffer listing = new StringBuffer();
		String rowColor = "";
		String activities = "";
		String period = "";
		String link = "";
		String sql = "";
		String dateField = "dte";
		String table = "tblUserLog";
		boolean found = false;
		int i = 0;

		if ("history".equals(logType)){
			dateField = "dte";
			table = "tblApprovalHist2";
		}
		else if ("mail".equals(logType)){
			dateField = "dte";
			table = "tblMail";
		}
		else if ("user".equals(logType)){
			dateField = "datetime";
			table = "tblUserLog";
		}

		sql = "SELECT YEAR(" + dateField + ") AS Period, COUNT(id) AS Activities " +
			"FROM " + table + " " +
			"GROUP BY YEAR(" + dateField + "),campus " +
			"HAVING campus=? " +
			"ORDER BY YEAR(" + dateField + ")";

		try{
			AseUtil aseUtil = new AseUtil();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				period = aseUtil.nullToBlank(rs.getString("period"));
				activities = aseUtil.nullToBlank(rs.getString("activities"));

				link = "salgs.jsp?src=" + logType + "&prd=" + period;

				if (i++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				listing.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\"><td>" +
					"<a href=\"" + link + "\" class=\"linkcolumn\"><img src=\"../images/del.gif\" border=\"0\" alt=\"delete activities\"></a>&nbsp;&nbsp;" +
					"</td>" +
					"<td class=\"datacolumn\">" + period + "</td>" +
					"<td class=\"datacolumn\">" + activities + "</td>" +
					"</tr>");

				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("Helper: showLog\n" + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("Helper: showLog - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr bgcolor=\"#e1e1e1\" height=\"30\">" +
						"<td class=\"textblackTH\">&nbsp;</td>" +
						"<td class=\"textblackTH\">Period</td>" +
						"<td class=\"textblackTH\">Activities</td></tr>" +
						listing.toString() +
						"</table>";
		else
			return "Activities not found";
	}	// showLog

	/**
	 * listCampusOutlinesByType - showing only the numbers and used for creating new outlines
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	type 		String
	 * <p>
	 * @return	String
	 */
	public static String listCampusOutlinesByType(Connection conn,String campus,String alpha,String type){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String num = "";
		String rowColor = "";
		boolean found = false;
		int i = 0;
		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;

			sql = "SELECT coursenum FROM tblCourse WHERE campus=? AND coursealpha=? AND coursetype=? ORDER BY coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,type);
			rs = ps.executeQuery();
			while ( rs.next() ){
				num = aseUtil.nullToBlank(rs.getString("coursenum"));

				if (!num.equals(Constant.BLANK)){
					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					if (j==1)
						listings.append(num);
					else
						listings.append(", " + num);

					found = true;
				} // num is not empty

			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
			}
			else{
				listing = "Outline not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listCampusOutlinesByType - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listCampusOutlinesByType - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineNumbersUsedByAlpha - outline numbers already used by ALPHA
	 * <p>
	 * @param	conn	Connection
	 * @param	alpha	String
	 * @param	type	String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineNumbersUsedByAlpha(Connection conn,String alpha,String type){

		StringBuffer listings = new StringBuffer();
		String link = "";
		String listing = "";
		String num = "";
		String rowColor = "";
		boolean found = false;
		int i = 0;
		int j = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			String sql = "";
			PreparedStatement ps;
			ResultSet rs;

			sql = "SELECT DISTINCT coursenum " +
				" FROM tblCourse " +
				" WHERE coursealpha=? " +
				" AND coursetype=? " +
				" ORDER BY coursenum";
			ps = conn.prepareStatement(sql);
			ps.setString(1,alpha);
			ps.setString(2,type);
			rs = ps.executeQuery();
			while ( rs.next() ){
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				link = "<a href=\"vwoutline.jsp?type="+type+"&alpha="+alpha+"&num="+num+"\" class=\"linkcolumn\">"+num+"</a>";

				if (j++ % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				if (j==1)
					listings.append(link);
				else
					listings.append(", " + link);

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
			}
			else{
				listing = "Outline not found";
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineNumbersUsedByAlpha - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineNumbersUsedByAlpha - " + ex.toString());
		}

		return listing;
	}

	/*
	 * showOutlinesForCompare
	 *	<p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * @param	String		alpha
	 * @param	String		num
	 *	<p>
	 * @return 	String
	 */
	public static String showOutlinesForCompare(Connection conn,String campus,String alpha,String num){

		StringBuffer listing = new StringBuffer();
		String courseDate = "";
		String sql = "";
		String kix = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();

			sql = "SELECT historyid,coursedate "
				+ " FROM tblCourseARC "
				+ " WHERE campus=? AND CourseAlpha=? AND CourseNum=?"
				+ " ORDER BY coursedate DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				courseDate = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME);
				listing.append("<input type=\"radio\" name=\"radioSelection\" value=\"" + kix + "\">Archived - " + courseDate + "<br/>");
				found = true;
			}
			rs.close();

			sql = "SELECT historyid,coursedate "
				+ " FROM tblCourseCAN "
				+ " WHERE campus=? AND CourseAlpha=? AND CourseNum=?"
				+ " ORDER BY coursedate DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				courseDate = aseUtil.ASE_FormatDateTime(rs.getString("coursedate"),Constant.DATE_DATETIME);
				listing.append("<input type=\"radio\" name=\"radioSelection\" value=\"" + kix + "\">Cancelled - " + courseDate + "<br/>");
				found = true;
			}
			rs.close();

			sql = "SELECT historyid "
				+ " FROM tblCourse "
				+ " WHERE campus=? AND CourseAlpha=? AND CourseNum=? AND coursetype='PRE'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,alpha);
			ps.setString(3,num);
			rs = ps.executeQuery();
			while (rs.next()){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				listing.append("<input type=\"radio\" name=\"radioSelection\" value=\"" + kix + "\">Proposed<br/>");
				found = true;
			}
			rs.close();

			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("Helper: showOutlinesForCompare\n" + sx.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesForCompare - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			sql = listing.toString();
		else
			sql = "Outlines not found";

		return sql;
	}	// showOutlinesForCompare

	/*
	 * listOutlineDates
	 * <p>
	 * @param	Connection	conn
	 * @param	String		campus
	 * @param	int			idx
	 * @param	HttpServletRequest		request
	 * @param	HttpServletResponse		response
	 * <p>
	 * @return String
	 */
	public static String listOutlineDates(Connection conn,
														String campus,
														int idx,
														HttpServletRequest request,
														HttpServletResponse response) throws Exception {

		//Logger logger = Logger.getLogger("test");

		String temp = "";

		if (idx>0){
			AseUtil aseUtil = new AseUtil();
			HttpSession session = request.getSession(true);

			String sql = "SELECT historyid,CourseAlpha AS [Alpha],CourseNum AS [Number],"
				+ "coursetitle AS [Title],coursedate AS [Approval Date],reviewdate As [Next Review Date] "
				+ "FROM tblCourse WHERE campus='"+ campus + "' "
				+ "AND CourseType='CUR' AND NOT (coursedate is null) AND coursealpha like '" + (char)idx + "%' "
				+ "ORDER BY CourseAlpha, CourseNum";

			com.ase.paging.Paging paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setScriptName("/central/core/crsexp.jsp");
			paging.setDetailLink("/central/core/vwcrs.jsp?t=CUR");
			paging.setUrlKeyName("cid");
			paging.setRecordsPerPage(999);
			paging.setAlphaIndex(idx);
			paging.setNavigation(false);
			temp = paging.showRecords(conn, request, response);
			paging = null;
		}

		return temp;
	}

	/**
	 * showAssessmentsToCancel - outlines that a user wants approved must be in ASSESSED progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showAssessmentsToCancel(Connection conn,
																String campus,
																String user,
																String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String progress = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			/*
				get all outlines in proposed status. for each found, make sure there isn't a matching
				outline under slo review.
			*/
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,progress " +
				"FROM vw_SLOByProgress_2 " +
				"WHERE Campus=? AND " +
				"progress=? AND " +
				"proposer=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"ASSESS");
			ps.setString(3,user);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				progress = aseUtil.nullToBlank(rs.getString("progress"));
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showAssessmentsToCancel - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	/**
	 * listWordDocs - word documents
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	docType	String
	 * <p>
	 * @return	String
	 */
	public static String listWordDocs(Connection conn,String campus,String docType){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String kix = "";
		String filename = "";
		String alphaIdx = "";
		String holdIdx = "";
		String num = "";
		String title = "";
		String bookmark = "";
		String sql = "";
		boolean found = false;
		String temp = "";

		try{
			String documentsURL = SysDB.getSys(conn,"documentsURL");

			AseUtil aseUtil = new AseUtil();
			sql = "SELECT filename " +
				"FROM tblDocs " +
				"WHERE campus=? " +
				"AND type=? " +
				"ORDER BY filename";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,docType);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				filename = aseUtil.nullToBlank(rs.getString("filename"));
				alphaIdx = filename.substring(0,1).toUpperCase();

				bookmark = "";
				if (!holdIdx.equals(alphaIdx)){

					bookmark = "<table id=\"aseBookmark\"  width=\"50%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
						+ "<tr bgcolor=#e1e1e1>"
						+ "<td width=\"50%\"><a id=\"" + alphaIdx + "\" name=\"" + alphaIdx + "\" class=\"linkcolumn\">[" + alphaIdx + "]</a></td>"
						+ "<td width=\"50%\" align=\"right\"><a href=\"#top\" class=\"linkcolumn\">back to top</a></td>"
						+ "</tr></table>";
					holdIdx = alphaIdx;
				}

				if (found)
					listing.append("</ul>" + bookmark + "<ul>");

				listing.append("<li><a href=\""+documentsURL+"docs/" + campus.toUpperCase() + "/" + filename + "\" class=\"linkcolumn\" target=\"_blank\">" + filename.toUpperCase() + "</a></li>");

				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				bookmark = "<a id=\"A\" name=\"A\" class=\"linkcolumn\">[A]</a>";

				temp = "<table id=\"asePager\"  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
					+ "<tr><td align=\"center\">"
					+ Helper.drawAlphaIndexBookmark(0,"")
					+ "</td></tr>"
					+ "<tr><td>"
					+ bookmark
					+ "<ul>" + listing.toString() + "</ul>"
					+ "</td></tr>"
					+ "</table>";
			}
			else
				temp = "Document not found";
		}
		catch(Exception ex){
			logger.fatal("Helper: listWordDocs - " + ex.toString());
		}

		return temp;
	}

	/**
	 * showCourseProgress
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return	String
	 */
	public static String showCourseProgress(Connection conn,String kix){

		StringBuffer progress = new StringBuffer();
		boolean found = false;

		try{
			String[] statusTab = CourseDB.getCourseDates(conn,kix);

			progress.append("<TABLE id=\"asePager\" cellSpacing=\"0\" cellPadding=\"5\" width=\"100%\" border=\"0\">");
			progress.append("<TBODY>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Proposer:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[0] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Progress:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[1] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Modify Date:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[2] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\" nowrap>Reason for modification:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[8].replace("\r\n","<br>") + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Effective Term:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[3] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Next Review Date:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[4] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Approved Date:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[6] + "</TD>");
			progress.append("</TR>");
			progress.append("<TR>");
			progress.append("<TD class=\"textblackTH\" width=\"15%\">Last Updated:</TD>");
			progress.append("<TD class=\"datacolumn\" colspan=\"5\">" + statusTab[7] + "</TD>");
			progress.append("</TR>");
			progress.append("</TBODY>");
			progress.append("</TABLE>");
		}
		catch(Exception ex){
			logger.fatal("Helper: showCourseProgress - " + ex.toString());
		}

		return progress.toString();
	}

	/**
	 * listOutlineForDelete
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha		String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listOutlineForDelete(Connection conn,String campus,String type,String caller,int idx,String alpha,String num){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				// selection should only include outlines with a single count on campus.
				// multiple means something else is taking place.

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT c.CourseAlpha, c.CourseNum, c.Progress, c.proposer "
						+ "FROM "
						+ "( "
						+ "	SELECT DISTINCT campus, CourseAlpha, CourseNum "
						+ "	FROM tblCourse "
						+ "	WHERE campus=? "
						+ "	GROUP BY CourseAlpha, CourseNum, coursetype, campus "
						+ "	HAVING CourseAlpha=? AND coursenum=? AND coursetype='CUR' AND COUNT(CourseAlpha)=1 "
						+ ")	AS d, tblCourse c "
						+ "WHERE d.campus = c.campus AND "
						+ "d.CourseAlpha = c.CourseAlpha AND "
						+ "d.CourseNum = c.CourseNum "
						+ "ORDER BY c.CourseAlpha, c.CourseNum ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
				}
				else if (alpha.length()>0){
					sql = "SELECT c.CourseAlpha, c.CourseNum, c.Progress, c.proposer "
						+ "FROM "
						+ "( "
						+ "	SELECT DISTINCT campus, CourseAlpha, CourseNum "
						+ "	FROM tblCourse "
						+ "	WHERE campus=? "
						+ "	GROUP BY CourseAlpha, CourseNum, coursetype, campus "
						+ "	HAVING CourseAlpha=? AND coursetype='CUR' AND COUNT(CourseAlpha)=1 "
						+ ")	AS d, tblCourse c "
						+ "WHERE d.campus = c.campus AND "
						+ "d.CourseAlpha = c.CourseAlpha AND "
						+ "d.CourseNum = c.CourseNum "
						+ "ORDER BY c.CourseAlpha, c.CourseNum ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
				}
				else{
					sql = "SELECT c.CourseAlpha, c.CourseNum, c.Progress, c.proposer "
						+ "FROM "
						+ "( "
						+ "	SELECT DISTINCT campus, CourseAlpha, coursetype, CourseNum "
						+ "	FROM tblCourse "
						+ "	WHERE campus=? "
						+ "	GROUP BY CourseAlpha, CourseNum, campus "
						+ "	HAVING CourseAlpha LIKE '" + (char)idx + "%' AND coursetype='CUR' AND COUNT(CourseAlpha)=1 "
						+ ")	AS d, tblCourse c "
						+ "WHERE d.campus = c.campus AND "
						+ "d.CourseAlpha = c.CourseAlpha AND "
						+ "d.CourseNum = c.CourseNum "
						+ "ORDER BY c.CourseAlpha, c.CourseNum ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
				}
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					proposer = aseUtil.nullToBlank(rs.getString("proposer"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,type);
					kix = Helper.getKix(conn,campus,alpha,num,type);
					link = caller + ".jsp?cps=" + campus + "&kix=" + kix;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("<td class=\"datacolumn\">" + proposer + "</td>");
					listings.append("<td class=\"datacolumn\">" + progress + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"48%\">Title</td>" +
						"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
						"<td class=\"textblackth\" width=\"25%\">Progress</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineForDelete - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineForDelete - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listOutlineForLinking
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	caller	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlineForLinking(Connection conn,String campus,String caller,int idx){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String title = "";
		String kix = "";
		String link = "";
		String rowColor = "";
		String type = "";
		boolean found = false;
		final int LETTER_A = 65;
		final int LETTER_Z = 90;
		int i = 0;
		int j = 0;

		try{
			if (idx>=LETTER_A && idx<=LETTER_Z){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				sql = "SELECT historyid, CourseAlpha, CourseNum, proposer, Progress, coursetitle "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND coursetype='PRE' "
					+ "AND CourseAlpha LIKE '" + (char)idx + "%' "
					+ "ORDER BY CourseAlpha, CourseNum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					progress = aseUtil.nullToBlank(rs.getString("progress"));
					proposer = aseUtil.nullToBlank(rs.getString("proposer"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					kix = aseUtil.nullToBlank(rs.getString("historyid"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					link = caller + ".jsp?cps=" + campus + "&kix=" + kix;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("<td class=\"datacolumn\">" + proposer + "</td>");
					listings.append("<td class=\"datacolumn\">" + progress + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"48%\">Title</td>" +
						"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
						"<td class=\"textblackth\" width=\"25%\">Progress</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlineForLinking - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlineForLinking - " + ex.toString());
		}

		return listing;
	}

	/**
	 * listCampusOutlinesByAlpha
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	type		String
	 * @param	caller	String
	 * @param	idx		int
	 * @param	alpha 	String
	 * @param	num		String
	 * <p>
	 * @return	String
	 */
	public static String listCampusOutlinesByAlpha(Connection conn,
																	String campus,
																	String type,
																	String caller,
																	int idx,
																	String alpha,
																	String num){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		StringBuffer listings = new StringBuffer();
		String table = "tblCourse";
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		String link = "";
		String title = "";
		String rowColor = "";
		int j = 0;
		boolean found = false;

		try{
			if (((idx>=LETTER_A && idx<=LETTER_Z) || alpha.length()>0) && !"".equals(type)){
				AseUtil aseUtil = new AseUtil();

				String sql = "";
				PreparedStatement ps;
				ResultSet rs;

				if ("ARC".equals(type))
					table = "tblCourseARC";

				if (alpha.length()>0 && num.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum,coursetitle " +
						" FROM " + table +
						" WHERE campus=? AND " +
						" coursealpha=? AND " +
						" coursenum=? AND " +
						" coursetype=? ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,num);
					ps.setString(4,type);
				}
				else if (alpha.length()>0){
					sql = "SELECT DISTINCT coursealpha,coursenum,coursetitle " +
						" FROM " + table +
						" WHERE campus=? AND " +
						" coursealpha=? AND " +
						" coursetype=? ";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,alpha);
					ps.setString(3,type);
				}
				else{
					sql = "SELECT DISTINCT coursealpha,coursenum,coursetitle " +
						" FROM " + table +
						" WHERE campus=? AND " +
						" coursealpha like '" + (char)idx + "%' AND " +
						" coursetype=? " +
						" ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,type);
				}
				rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					link = caller + ".jsp?cps=" + campus + "&alpha=" + alpha + "&num=" + num + "&t=" + type;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"12%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"48%\">Title</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("Helper: listCampusOutlinesByAlpha - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listCampusOutlinesByAlpha - " + ex.toString());
		}

		return listing;
	}

	/**
	 * showProgramsUserMayCancel - outlines that a user needds to do approval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showProgramsUserMayCancel(Connection conn,String campus,String user,String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String title = "";
		String kix = "";
		String proposer = "";
		String link = "";
		String sql = "";
		int route = 0;
		boolean found = false;
		String temp = "";

		try{
			sql = "SELECT historyid,title,route,proposer " +
				"FROM tblPrograms " +
				"WHERE campus=? " +
				"AND Progress='APPROVAL' " +
				"AND proposer=? " +
				"ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				title = AseUtil.nullToBlank(rs.getString("title"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				route = rs.getInt("route");
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + title + "  ("+ proposer +")" + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showProgramsNeedingApproval - " + ex.toString());
			listing.setLength(0);
		}

		if (found){
			temp = "<ul>" + listing.toString() + "</ul>";
		}
		else
			temp = "Programs do not exist for this request";

		return temp;
	}

	/**
	 * showProgramsNeedingApproval - outlines that a user needds to do approval
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showProgramsNeedingApproval(Connection conn,String campus,String user,String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String title = "";
		String kix = "";
		String link = "";
		int route = 0;
		boolean found = false;

		try{
			String sql = "SELECT historyid,title,route " +
				"FROM tblPrograms " +
				"WHERE campus=? " +
				"AND Progress='APPROVAL' " +
				"ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				title = AseUtil.nullToBlank(rs.getString("title"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				route = rs.getInt("route");
				if (ProgramsDB.isNextApprover(conn,campus,kix,user,route) ){
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showProgramsNeedingApproval - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Programs do not exist for this request";
	}

	/**
	 * listOutlinesForSubmissionWithProgram
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	division	int
	 * @param	session	HttpSession
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesForSubmissionWithProgram(Connection conn,String campus,int division){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String progress = "";
		String title = "";
		String proposer = "";
		String rowColor = "";
		String kix = "";
		boolean found = false;
		int i = 0;
		int j = 0;

		String sql = "";
		String validation = null;
		String enableOutlineValidation = null;

		try{
			// count sql is similar to the sql used below.
			if (ProgramsDB.countPendingOutlinesForApproval(conn,campus,division) > 0){

				enableOutlineValidation = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableOutlineValidation");

				sql = "SELECT DISTINCT historyid,coursealpha,coursenum,coursetitle,proposer,progress " +
					" FROM tblCourse" +
					" WHERE campus=? " +
					" AND coursetype='PRE' " +
					" AND progress='PENDING' " +
					" AND coursealpha IN " +
					" ( " +
					" SELECT coursealpha " +
					" FROM tblChairs " +
					" WHERE programid=? " +
					" ) " +
					" ORDER BY coursealpha,coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,division);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));
					progress = AseUtil.nullToBlank(rs.getString("progress"));
					proposer = AseUtil.nullToBlank(rs.getString("proposer"));
					title = CourseDB.getCourseDescriptionByType(conn,campus,alpha,num,"PRE");
					kix = AseUtil.nullToBlank(rs.getString("historyid"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"linkcolumn\">" + alpha + " " + num + "</td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("<td class=\"datacolumn\">" + proposer + "</td>");
					listings.append("<td class=\"datacolumn\">" + progress + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"15%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"40%\">Title</td>" +
						"<td class=\"textblackth\" width=\"25%\">Proposer</td>" +
						"<td class=\"textblackth\" width=\"20%\">Progress</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
			} // if counter > 0
		}
		catch( SQLException e ){
			logger.fatal("Helper: listOutlinesForSubmissionWithProgram - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("Helper: listOutlinesForSubmissionWithProgram - " + ex.toString());
		}

		return listing;
	}

	/**
	 * showProgramsByProgress
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	progress
	 * @param	caller
	 * <p>
	 * @return	String
	 */
	public static String showProgramsByProgress(Connection conn,String campus,String progress,String caller){

		StringBuffer listing = new StringBuffer();
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			String sql = "SELECT distinct historyid, title " +
				"FROM tblPrograms WHERE campus=? AND (progress=? OR progress=?) ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,Constant.PROGRAM_MODIFY_PROGRESS);
			ps.setString(3,Constant.PROGRAM_APPROVAL_PROGRESS);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				title = AseUtil.nullToBlank(rs.getString("title"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showProgramsByProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Program does not exist for this request</li></ul>";
	}

	/**
	 * showProgramsByUserProgress
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	progress
	 * @param	user
	 * @param	caller
	 * <p>
	 * @return	String
	 */
	public static String showProgramsByUserProgress(Connection conn,String campus,String progress,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			String sql = "SELECT distinct historyid, title " +
				"FROM tblPrograms WHERE campus=? AND proposer=? AND (progress=? OR progress=?) ORDER BY title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,Constant.PROGRAM_MODIFY_PROGRESS);
			ps.setString(4,Constant.PROGRAM_APPROVAL_PROGRESS);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				title = AseUtil.nullToBlank(rs.getString("title"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showProgramsByUserProgress - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Program does not exist for this request</li></ul>";
	}

	/**
	 * showProgramsInReview - show outlines by user and outline progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showProgramsInReview(Connection conn,String campus,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String divisionname = "";
		String program = "";
		String title = "";
		String kix = "";
		String link = "";
		String effectivedate = "";
		boolean found = false;

		try{
			String sql = "SELECT historyid, divisionname, program, title, effectivedate " +
				"FROM vw_ProgramForViewing " +
				"WHERE campus=? " +
				"AND proposer=? " +
				"AND (Progress=? OR subprogress=?) " +
				"ORDER BY divisionname, Program, title";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,"REVIEW");
			ps.setString(4,Constant.COURSE_REVIEW_IN_APPROVAL);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				divisionname = AseUtil.nullToBlank(rs.getString("divisionname"));
				program = AseUtil.nullToBlank(rs.getString("program"));
				title = AseUtil.nullToBlank(rs.getString("title"));
				effectivedate = AseUtil.nullToBlank(rs.getString("effectivedate"));
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + divisionname + " (" + program + ") - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException ex){
			logger.fatal("Helper: showProgramsInReview - " + ex.toString());
			listing.setLength(0);
		}
		catch(Exception ex){
			logger.fatal("Helper: showProgramsInReview - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Program does not exist for this request</li></ul>";
	}

	/**
	 * listOutlinesForSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 * <p>
	 * @return	String
	 */
	public static String listOutlinesForSLO(Connection conn,String campus,int idx){

		//Logger logger = Logger.getLogger("test");

		String listing = "";
		StringBuffer listings = new StringBuffer();
		final int LETTER_A = 65;
		final int LETTER_Z = 90;

		String alpha = "";
		String num = "";
		String historyid = "";
		String link = "";
		String title = "";
		String rowColor = "";
		int j = 0;
		boolean found = false;

		try{
			if (idx>=LETTER_A && idx<=LETTER_Z){

				AseUtil aseUtil = new AseUtil();

				String sql = "SELECT DISTINCT historyid,coursealpha,coursenum,coursetitle "
					+ " FROM tblCourse "
					+ " WHERE campus=? "
					+ " AND coursealpha like '" + (char)idx + "%' "
					+ " AND coursetype='CUR' "
					+ " ORDER BY coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
					num = aseUtil.nullToBlank(rs.getString("coursenum"));
					title = aseUtil.nullToBlank(rs.getString("coursetitle"));
					historyid = aseUtil.nullToBlank(rs.getString("historyid"));

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;


					link = "ccslox.jsp?kix=" + historyid + "&itm=" + Constant.COURSE_OBJECTIVES;

					listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">");
					listings.append("<td class=\"datacolumn\"><a href=\"" + link + "\" title=\"" + title + "\" class=\"linkcolumn\">" + alpha + " " + num + "</a></td>");
					listings.append("<td class=\"datacolumn\">" + title + "</td>");
					listings.append("<td class=\"datacolumn\" align=\"right\">" + CompDB.getLastUpdated(conn,historyid) + "</td>");
					listings.append("</tr>");

					found = true;
				}
				rs.close();
				ps.close();

				if (found){
					listing = "<table id=\"asePager\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
						"<tr height=\"30\" bgcolor=\"#e1e1e1\">" +
						"<td class=\"textblackth\" width=\"20%\">Outline</td>" +
						"<td class=\"textblackth\" width=\"60%\">Title</td>" +
						"<td class=\"textblackth\" width=\"20%\" align=\"right\">Last Updated</td>" +
						"</tr>" +
						listings.toString() +
						"</table>";
				}
				else{
					listing = "Data not found for selected index";
				}
			}
		}
		catch( SQLException e ){
			logger.fatal("HelperLEE: listOutlinesForSLO - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("HelperLEE: listOutlinesForSLO - " + ex.toString());
		}

		return listing;
	}

	/**
	 * showOutlinesToEnableItems - show outlines by user and outline progress
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * @param	progress	String
	 * @param	caller	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesToEnableItems(Connection conn,
																	String campus,
																	String user,
																	String progress,
																	String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String subprogress = "";

		boolean found = false;
		boolean showLink = false;

		try{
			String sql = "";
			PreparedStatement ps = null;

			if (user == null || user.length() == 0){
				// as administrators, show all modify/approval progress
				// so they may edit enabled items.
				sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
					+ "FROM tblCourse WHERE campus=? AND coursetype='PRE' "
					+ "AND (progress=? OR progress=? OR progress=?) "
					+ "ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_MODIFY_TEXT);
				ps.setString(3,Constant.COURSE_APPROVAL_TEXT);
				ps.setString(4,Constant.COURSE_REVIEW_TEXT);
			}
			else{
				// when in review, make sure to include review in approval (SQL is different)
				// when in review in approval, don't include proposer's name
				if (progress.equals(Constant.COURSE_REVIEW_TEXT)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' "
						+ "AND proposer=? "
						+ "AND (Progress=? OR subprogress=?) "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
					ps.setString(4,Constant.COURSE_REVIEW_IN_APPROVAL);
				}
				else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' AND proposer=? AND Progress=?  "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
				}
				else if (progress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' "
						+ "AND (Progress=? OR subprogress=?) "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,progress);
					ps.setString(3,Constant.COURSE_REVIEW_IN_APPROVAL);
				}
				else{
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' "
						+ "AND (Progress=? OR Progress=? OR Progress=?) "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,Constant.COURSE_MODIFY_TEXT);
					ps.setString(3,Constant.COURSE_REVIEW_TEXT);
					ps.setString(4,Constant.COURSE_REVISE_TEXT);
				}
			}
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				showLink = true;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				// prevent proposer from cancelling reviews kicked off by approver
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
					String currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					if (currentApprover != null && !currentApprover.equals(user))
						showLink = false;
				}

				if (showLink){
					title = AseUtil.nullToBlank(rs.getString("coursetitle"));
					kix = AseUtil.nullToBlank(rs.getString("id"));
					link = caller + ".jsp?kix=" + kix;

					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");

					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesToEnableItems - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Outline does not exist for this request</li></ul>";
	} // Helper: showOutlinesToEnableItems

	public static String showOutlinesToEnableItemsOBSOLETE(Connection conn,
																	String campus,
																	String user,
																	String progress,
																	String caller){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		String subprogress = "";

		boolean found = false;
		boolean showLink = false;

		try{
			String sql = "";
			PreparedStatement ps = null;

			if (user == null || user.length() == 0){
				// as administrators, show all modify/approval progress
				// so they may edit enabled items.
				sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND coursetype='PRE' "
					+ "AND (progress=? OR progress=?) "
					+ "ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,Constant.COURSE_MODIFY_TEXT);
				ps.setString(3,Constant.COURSE_APPROVAL_TEXT);
			}
			else{
				// when in review, make sure to include review in approval (SQL is different)
				// when in review in approval, don't include proposer's name
				if ((Constant.COURSE_REVIEW_TEXT).equals(progress)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' "
						+ "AND proposer=? "
						+ "AND (Progress=? OR subprogress=?) "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,user);
					ps.setString(3,progress);
					ps.setString(4,Constant.COURSE_REVIEW_IN_APPROVAL);
				}
				else if ((Constant.COURSE_REVIEW_IN_APPROVAL).equals(progress)){
					sql = "SELECT distinct id, CourseAlpha, CourseNum, coursetitle, subprogress "
						+ "FROM tblCourse "
						+ "WHERE campus=? "
						+ "AND coursetype='PRE' "
						+ "AND (Progress=? OR subprogress=?) "
						+ "ORDER BY coursealpha,coursenum";
					ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,progress);
					ps.setString(3,Constant.COURSE_REVIEW_IN_APPROVAL);
				}
			}
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				showLink = true;

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));

				// prevent proposer from cancelling reviews kicked off by approver
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				if ((Constant.COURSE_REVIEW_IN_APPROVAL).equals(subprogress)){
					String currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
					if (currentApprover != null && !currentApprover.equals(user))
						showLink = false;
				}

				if (showLink){
					title = AseUtil.nullToBlank(rs.getString("coursetitle"));
					kix = AseUtil.nullToBlank(rs.getString("id"));
					link = caller + ".jsp?kix=" + kix;

					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");

					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showOutlinesToEnableItems - " + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "<ul><li>Outline does not exist for this request</li></ul>";
	}

	/**
	 * listWordDocsJquery - first use of jquery
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	docType		String
	 * @param	docStatus	String
	 * <p>
	 * @return	String
	 */
	public static String listWordDocsJquery(Connection conn,String campus,String docType){

		return listWordDocsJquery(conn,campus,docType,"a");

	}

	public static String listWordDocsJquery(Connection conn,String campus,String docType,String docStatus){

		//Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String filename = "";
		String alphaIdx = "";
		String sql = "";
		String temp = "";

		try{
			if(docStatus.toLowerCase().equals("a")){
				docStatus = "ARC";
			}
			else if(docStatus.toLowerCase().equals("c")){
				docStatus = "CUR";
			}

			String documentsURL = SysDB.getSys(conn,"documentsURL");
			sql = "SELECT filename FROM tblDocs WHERE campus=? AND type=? AND status=? ORDER BY filename";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,docType);
			ps.setString(3,docStatus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				filename = AseUtil.nullToBlank(rs.getString("filename"));
				alphaIdx = filename.substring(0,1).toUpperCase();
				listing.append("<li class=\"ln-"+alphaIdx.toLowerCase()+"\"><a href=\""+documentsURL+"docs/" + campus.toUpperCase() + "/" + filename + "\" class=\"linkcolumn\" target=\"_blank\">" + filename.toUpperCase() + "</a></li>\n");
			}
			rs.close();
			ps.close();
			temp = listing.toString();
		}
		catch(Exception ex){
			logger.fatal("Helper: listWordDocsJquery - " + ex.toString());
		}

		return temp;
	}

	/**
	 * drawNumericIndexBookMark
	 * <p>
	 * @param	idx	int
	 * @param	min	int
	 * @param	max	int
	 * @param	forceSingleRowDisplay	boolean
	 * <p>
	 * @return	String
	 */
	public static String drawNumericIndexBookMark(int idx,int min,int max,boolean forceSingleRowDisplay){

		//Logger logger = Logger.getLogger("test");

		StringBuffer buf = new StringBuffer();

		// 30 per line is a good count
		int lineMax = 30;

		int j = 0;

		try{

			if(max > lineMax){

				// when we have an even number of items, divide evenly by 2;
				// for odd, we want to top row to have 1 more than the bottom row
				if (max % 2 == 0){
					lineMax = ((int)max / 2);
				}
				else{
					lineMax = ((int)max / 2) + 1;
				}
			}

			String si = "";

			buf.append("<div class=\"pagination\">");

			for(int i=min; i<=max; i++){

				if (i<10){
					si = "0" + i;
				}
				else{
					si = "" + i;
				}

				if (i==idx){
					buf.append("<spanX><b>" + si + "</span></b>&nbsp;");
				}
				else{
					buf.append("<a class=\"spanlink\" href=\"#" + i + "\">" + si + "</a>&nbsp;");
				}

				++j;

				// drop to next line only if not forceSingleRowDisplay
				if (j == lineMax && !forceSingleRowDisplay){
					buf.append("<br/><br/>");
					j = 0;
				} // line break

			}

			buf.append("<br><br>");
			buf.append("</div>");
		}
		catch(Exception ex){
			logger.fatal("Helper: drawNumericIndexBookMark - " + ex.toString());
			buf.setLength(0);
		}

		return buf.toString();
	}

}
