/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *	public static int deleteSyllabus(Connection connection, String id)
 *	public static Syllabus getSyllabus(Connection connection,String campus,int id)
 *	public static int insertSyllabus(Connection connection, Syllabus syllabus)
 *	public static int listCatalog(Connection connection,String campus,int idx,String discipline)
 *	public static int updateSyllabus(Connection connection, Syllabus syllabus)
 * public static String writeSyllabus(Connection conn, int sid, String campus,String user)
 *
 */

//
// SyllabusDB.java
//
package com.ase.aseutil;

import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import com.ase.aseutil.db.FileDrop;

import org.apache.log4j.Logger;

public class SyllabusDB {

	static Logger logger = Logger.getLogger(SyllabusDB.class.getName());

	public SyllabusDB() throws Exception {}

	/*
	 * getSyllabus
	 *	<p>
	 *	@return Syllabus
	 */
	public static Syllabus getSyllabus(Connection connection,String campus,int id) {

		Syllabus syllabus = null;
		String temp = "";

		try {

			String sql = "SELECT coursealpha,coursenum,semester,yeer,userid,textbooks,grading,comments,auditdate,attach "
				+ "FROM tblSyllabus "
				+ "WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, String.valueOf(id));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				AseUtil aseUtil = new AseUtil();
				syllabus = new Syllabus();
				syllabus.setAlpha(AseUtil.nullToBlank(rs.getString("coursealpha")));
				syllabus.setNum(AseUtil.nullToBlank(rs.getString("coursenum")));
				syllabus.setSemester(AseUtil.nullToBlank(rs.getString("semester")));
				syllabus.setYear(AseUtil.nullToBlank(rs.getString("yeer")));
				syllabus.setUserID(AseUtil.nullToBlank(rs.getString("userid")));
				syllabus.setTextBooks(AseUtil.nullToBlank(rs.getString("textbooks")));
				syllabus.setGrading(AseUtil.nullToBlank(rs.getString("grading")));
				syllabus.setComments(AseUtil.nullToBlank(rs.getString("comments")));
				syllabus.setAttach(AseUtil.nullToBlank(rs.getString("attach")));
				syllabus.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
				String kix = Helper.getKix(connection,campus,syllabus.getAlpha(),syllabus.getNum(),"CUR");
				syllabus.setObjectives(CompDB.getObjectives(connection,kix));
				rs.close();

				sql = "SELECT " + Constant.EXPLAIN_PREREQ + ","
					+ Constant.EXPLAIN_COREQ + ","
					+ Constant.COURSE_PREREQ + ","
					+ Constant.COURSE_COREQ + ","
					+ Constant.COURSE_RECPREP + " "
					+ "FROM tblCourse, tblCampusdata  "
					+ "WHERE tblCourse.historyid = tblCampusdata.historyid "
					+ "AND tblCourse.historyid=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,kix);
				rs = ps.executeQuery();
				if (rs.next()) {
					temp = Outlines.drawPrereq(AseUtil.nullToBlank(rs.getString(Constant.COURSE_PREREQ)),"",true);

					syllabus.setPrereq(temp);

					if (CCCM6100DB.displayCommentsBox(connection,campus,Constant.COURSE_PREREQ)){
						syllabus.setPrereq("<br/><br/>" + AseUtil.nullToBlank(rs.getString(Constant.EXPLAIN_PREREQ)));
					}

					syllabus.setCoreq(AseUtil.nullToBlank(rs.getString(Constant.COURSE_COREQ)));

					if (CCCM6100DB.displayCommentsBox(connection,campus,Constant.COURSE_COREQ)){
						syllabus.setCoreq("<br/><br/>" + AseUtil.nullToBlank(rs.getString(Constant.EXPLAIN_COREQ)));
					}

					syllabus.setRecprep(AseUtil.nullToBlank(rs.getString(Constant.COURSE_RECPREP)));
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SyllabusDB: getSyllabus - " + e.toString());
			syllabus = null;
		} catch (Exception ex) {
			logger.fatal("SyllabusDB: getSyllabus - " + ex.toString());
			syllabus = null;
		}

		return syllabus;
	}

	/*
	 * getSyllabusData
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	<p>
	 *	@return Syllabus
	 */
	public static Syllabus getSyllabusData(Connection conn,String kix) throws Exception {

		Syllabus syllabus = null;

		try {
			String getSQL = "SELECT tblCourse.campus, " + Constant.COURSE_TEXTMATERIAL
				+ "," + Constant.EXPLAIN_PREREQ
				+ "," + Constant.EXPLAIN_COREQ
				+ "," + Constant.COURSE_PREREQ
				+ "," + Constant.COURSE_COREQ
				+ "," + Constant.COURSE_RECPREP
				+ ",gradingoptions "
				+ "FROM tblCourse, tblCampusdata  "
				+ "WHERE tblCourse.historyid = tblCampusdata.historyid "
				+ "AND tblCourse.historyid=?";
			PreparedStatement ps = conn.prepareStatement(getSQL);
			ps.setString(1,kix);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				syllabus = new Syllabus();
				syllabus.setTextBooks(AseUtil.nullToBlank(resultSet.getString(Constant.COURSE_TEXTMATERIAL)));

				String campus = AseUtil.nullToBlank(resultSet.getString("campus"));
				String prereqs = AseUtil.nullToBlank(resultSet.getString(Constant.COURSE_PREREQ));
				prereqs = Outlines.drawPrereq(prereqs,"",true);

				syllabus.setPrereq(prereqs);

				if (CCCM6100DB.displayCommentsBox(conn,campus,Constant.COURSE_PREREQ)){
					syllabus.setPrereq("<br/><br/>" + AseUtil.nullToBlank(resultSet.getString(Constant.EXPLAIN_PREREQ)));
				}

				syllabus.setCoreq(AseUtil.nullToBlank(resultSet.getString(Constant.COURSE_COREQ)));

				if (CCCM6100DB.displayCommentsBox(conn,campus,Constant.COURSE_COREQ)){
					syllabus.setCoreq("<br/><br/>" + AseUtil.nullToBlank(resultSet.getString(Constant.EXPLAIN_COREQ)));
				}

				syllabus.setRecprep(AseUtil.nullToBlank(resultSet.getString(Constant.COURSE_RECPREP)));
				syllabus.setGrading(AseUtil.nullToBlank(resultSet.getString("gradingoptions")));
				syllabus.setObjectives(CompDB.getObjectives(conn,kix));
			}
			resultSet.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("SyllabusDB: getSyllabus - " + e.toString());
		}

		return syllabus;
	}

	/*
	 * insertSyllabus
	 *	<p>
	 *	@return int
	 */
	public static int insertSyllabus(Connection connection, Syllabus syllabus) {
		int rowsAffected = 0;
		try {
			String insertSQL = "INSERT INTO tblSyllabus (coursealpha,coursenum,semester,yeer,userid,textbooks,objectives,grading,comments,attach) VALUES (?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = connection.prepareStatement(insertSQL);
			ps.setString(1, syllabus.getAlpha());
			ps.setString(2, syllabus.getNum());
			ps.setString(3, syllabus.getSemester());
			ps.setString(4, syllabus.getYear());
			ps.setString(5, syllabus.getUserID());
			ps.setString(6, syllabus.getTextBooks());
			ps.setString(7, syllabus.getObjectives());
			ps.setString(8, syllabus.getGrading());
			ps.setString(9, syllabus.getComments());
			ps.setString(10, syllabus.getAttach());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SyllabusDB: insertSyllabus - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * deleteSyllabus
	 *	<p>
	 *	@return int
	 */
	public static int deleteSyllabus(Connection connection, String id) {
		int rowsAffected = 0;
		try {
			String deleteSQL = "DELETE FROM tblSyllabus WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(deleteSQL);
			ps.setString(1, id);
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SyllabusDB: deleteSyllabus - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/*
	 * updateSyllabus
	 *	<p>
	 *	@return int
	 */
	public static int updateSyllabus(Connection connection, Syllabus syllabus) {
		int rowsAffected = 0;
		try {
			String updateSQL = "UPDATE tblSyllabus SET coursealpha=?,coursenum=?,semester=?,yeer=?,textbooks=?,objectives=?,grading=?,comments=?,auditdate=?,attach=? WHERE id =?";
			PreparedStatement ps = connection.prepareStatement(updateSQL);
			ps.setString(1, syllabus.getAlpha());
			ps.setString(2, syllabus.getNum());
			ps.setString(3, syllabus.getSemester());
			ps.setString(4, syllabus.getYear());
			ps.setString(5, syllabus.getTextBooks());
			ps.setString(6, syllabus.getObjectives());
			ps.setString(7, syllabus.getGrading());
			ps.setString(8, syllabus.getComments());
			ps.setString(9, syllabus.getAuditDate());
			ps.setString(10, syllabus.getAttach());
			ps.setString(11, syllabus.getSyllabusID());
			rowsAffected = ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("SyllabusDB: updateSyllabus - " + e.toString());
			return 0;
		}
		return rowsAffected;
	}

	/**
	 * reads the syllabus template file and formulate new content
	 *
	 * @param conn 	Connection
	 * @param sid		syllabus id
	 * @param campus	String
	 * @param user		String
	 */
	public static String writeSyllabus(Connection conn,int sid,String campus,String user) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer contents = new StringBuffer();
		String content = "";
		String kix = "";
		String template = "";
		String temp = "";

		String division = "";
		String title = "";
		String credits = "";
		String prereq = "";
		String coreq = "";
		String recprep = "";
		String objectives = "";
		String descr = "";

		boolean LEE_ENG100 = false;

		try {
			// use buffering, reading one line at a time
			// FileReader always assumes default encoding is OK!
			// TODO file mapping and getting course data below (asepool as well)

			AseUtil aseUtil = new AseUtil();
			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);

			Syllabus syllabus = SyllabusDB.getSyllabus(conn,campus,sid);

			if (campus.equals(Constant.CAMPUS_LEE) && "ENG".equals(syllabus.getAlpha()) && "100".equals(syllabus.getNum())){
				template = "_syllabus_eng100.tpl";
				LEE_ENG100 = true;
			}
			else{
				template = "_syllabus.tpl";
			}

			File aFile = new File(currentDrive + ":\\tomcat\\webapps\\central\\core\\templates\\" + campus + template);
			BufferedReader input = new BufferedReader(new FileReader(aFile));

			try {
				String line = null; // not declared within while loop
				/*
				 * readLine is a bit quirky : it returns the content of a line
				 * MINUS the newline. it returns null only for the END of the
				 * stream. it returns an empty String if two newlines appear in
				 * a row.
				 */
				while ((line = input.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}

				/*
				 * 1) If all is OK, replace holders with data 2) Get remaining
				 * items 3) Get instructor info 4) Get disability statement
				 */
				if (contents != null) {
					String campusName = aseUtil.lookUp(conn, "tblCampus", "campusdescr", "campus='" + campus + "'");

					content = contents.toString();

					content = content.replace("@@campus@@", campusName);
					content = content.replace("@@semester@@", syllabus.getSemester());
					content = content.replace("@@year@@", syllabus.getYear());
					content = content.replace("@@alpha@@", syllabus.getAlpha());
					content = content.replace("@@number@@", syllabus.getNum());

					String sql = "SELECT division,title,credits,prereq,coreq,CoursePreReq,CourseCoReq,recprep,coursedescr "
						+ "FROM vw_WriteSyllabus "
						+ "WHERE campus=? "
						+ "AND CourseAlpha=? "
						+ "AND CourseNum=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,syllabus.getAlpha());
					ps.setString(3,syllabus.getNum());
					ResultSet results = ps.executeQuery();
					if (results.next()) {
						division = AseUtil.nullToBlank(results.getString("division"));
						title = AseUtil.nullToBlank(results.getString("title"));
						credits = AseUtil.nullToBlank(results.getString("credits"));

						prereq = AseUtil.nullToBlank(results.getString("CoursePreReq"));
						String displayOrConsentForPreReqs = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");
						if (displayOrConsentForPreReqs.equals(Constant.ON)){
							prereq = Outlines.drawPrereq(prereq,"",true);
						}

						prereq = prereq
									+ "<br/>"
									+ AseUtil.nullToBlank(results.getString("prereq"));

						coreq = AseUtil.nullToBlank(results.getString("CourseCoReq"))
									+ "<br/>"
									+ AseUtil.nullToBlank(results.getString("coreq"));

						recprep = AseUtil.nullToBlank(results.getString("recprep"));
						content = content.replace("@@course@@", syllabus.getAlpha() + " " + syllabus.getNum() + ": " + title);
						descr = AseUtil.nullToBlank(results.getString("coursedescr"));
					} else {
						content = content.replace("@@course@@", syllabus.getAlpha() + " " + syllabus.getNum());
					}
					results.close();
					ps.close();

					if (prereq.equals(Constant.BLANK)) 	prereq = "None";
					if (coreq.equals(Constant.BLANK))	coreq = "None";
					if (recprep.equals(Constant.BLANK))	recprep = "None";

					content = content.replace("@@division@@", division);
					content = content.replace("@@title@@", title);
					content = content.replace("@@credit@@", credits);

					String instructor[] = new String[4];
					instructor = aseUtil.lookUpX(conn,
														"tblUsers",
														"lastname,firstname,hours,location,phone",
														"userid='" + user + "'");

					if ("NODATA".equals(instructor[0])) {
						content = content.replace("@@instructor@@","[MISSING INFO]");
						content = content.replace("@@hours@@", "[MISSING INFO]");content = content.replace("@@office@@","[MISSING INFO]");
						content = content.replace("@@contact@@","[MISSING INFO]");
					} else {
						content = content.replace("@@instructor@@",instructor[1] + " " + instructor[0]);
						content = content.replace("@@hours@@", instructor[2]);
						content = content.replace("@@office@@", instructor[3]);
						content = content.replace("@@contact@@", instructor[4]);
					}

					content = content.replace("@@catdesc@@", descr);
					content = content.replace("@@coreq@@", coreq);
					content = content.replace("@@prereq@@", prereq);
					content = content.replace("@@recprep@@", recprep);
					content = content.replace("@@textbooks@@", syllabus.getTextBooks());
					content = content.replace("@@grading@@", syllabus.getGrading());

					kix = Helper.getKix(conn,campus,syllabus.getAlpha(),syllabus.getNum(),"CUR");

					// objectives may be pulled from the main course table or from line item entries
					objectives = CompDB.getObjectives(conn,kix);

					if (objectives != null && objectives.length() > 0){
						objectives += Html.BR();
					}

					objectives += CompDB.getCompsAsHTMLList(conn,syllabus.getAlpha(),syllabus.getNum(),campus,"CUR",kix,false,"");

					content = content.replace("@@objectives@@", objectives);

					if (LEE_ENG100){
						temp = aseUtil.lookUp(conn, "tblStatement","statement", "type='ENG100' AND campus='" + campus + "'");
						content = content.replace("@@eng100@@", temp);
					}

					String comments = syllabus.getComments();
					if (comments.equals(Constant.BLANK)){
						comments = "N/A";
					}

					content = content.replace("@@comments@@", comments);

					String disability = aseUtil.lookUp(conn, "tblStatement","statement", "type='Disability' AND campus='" + campus + "'");
					content = content.replace("@@disability@@", disability);
				}
			} finally {
				input.close();
			}
		} catch (IOException ex) {
			logger.fatal("SyllabusDB IOException: writeSyllabus - " + ex.toString());
			content = null;
		} catch (Exception e) {
			logger.fatal("SyllabusDB Exception: writeSyllabus - " + e.toString());
			content = null;
		}

		return content;
	}

	/**
	 * listCatalog
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	idx			int
	 * @param	discipline	String
	 * <p>
	 * @return	String
	 */
	public static String listCatalog(Connection conn,String campus,int idx,String discipline){

		StringBuffer listings = new StringBuffer();
		String listing = "";
		String alpha = "";
		String num = "";
		String title = "";
		String descr = "";
		String prereq = "";
		String coreq = "";
		String recprep = "";
		String credits = "";
		String link = "";
		String kix = "";
		String rowColor = Constant.ODD_ROW_BGCOLOR;

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

			sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,credits,coursedescr,X15 AS Prereq,X16 AS [CoReq],X17 AS RecPrep " +
				"FROM tblCourse ";

			if (!discipline.equals(Constant.BLANK))
				sql += "WHERE campus=? AND coursealpha=? AND ";
			else
				sql += "WHERE campus=? AND ";

			if (idx>0 && idx<999)
				sql += "coursealpha like '" + (char)idx + "%' AND ";

			sql += "coursetype='CUR' AND " +
					"excluefromcatalog='0' " +
					"ORDER BY coursealpha,coursenum";

			ps = conn.prepareStatement(sql);

			if (!discipline.equals(Constant.BLANK)){
				ps.setString(1,campus);
				ps.setString(2,discipline);
			}
			else{
				ps.setString(1,campus);
			}

			rs = ps.executeQuery();
			while ( rs.next() ){
				kix = aseUtil.nullToBlank(rs.getString("historyid"));
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha"));
				num = aseUtil.nullToBlank(rs.getString("coursenum"));
				title = aseUtil.nullToBlank(rs.getString("coursetitle"));
				credits = aseUtil.nullToBlank(rs.getString("credits"));
				descr = aseUtil.nullToBlank(rs.getString("coursedescr"));

				prereq = aseUtil.nullToBlank(rs.getString("Prereq"))
						+ Html.BR()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,"CUR",Constant.REQUISITES_PREREQ,"");
				if (prereq.equals(Constant.BLANK)){
					prereq = "None";
				}

				coreq = aseUtil.nullToBlank(rs.getString("CoReq"))
						+ Html.BR()
						+ RequisiteDB.getRequisites(conn,campus,alpha,num,"CUR",Constant.REQUISITES_COREQ,"");
				if (coreq.equals(Constant.BLANK)){
					coreq = "None";
				}

				recprep = aseUtil.nullToBlank(rs.getString("RecPrep"))
							+ Html.BR()
							+ ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
				if (recprep.equals(Constant.BLANK)){
					recprep = "None";
				}

				listings.append("<tr height=\"30\" bgcolor=\"" + rowColor + "\">" +
					"<td colspan=\"2\" class=\"textblackth\">" + alpha + " " + num + " - " + title + " (" + credits + ")" + "</td></tr>" +
					"<tr height=\"30\"><td colspan=\"2\" class=\"datacolumn\">" + descr + "</td></tr>" +
					"<tr><td colspan=\"2\" class=\"textblackth\">&nbsp;</td></tr>" +
					"<tr height=\"30\"><td width=\"15%\" class=\"textblackth\">PreRequisite:&nbsp;</td><td class=\"datacolumn\">" + prereq + "</td></tr>" +
					"<tr><td colspan=\"2\" class=\"textblackth\">&nbsp;</td></tr>" +
					"<tr height=\"30\"><td width=\"15%\" class=\"textblackth\">Co-Requisite:&nbsp;</td><td class=\"datacolumn\">" + coreq + "</td></tr>" +
					"<tr><td colspan=\"2\" class=\"textblackth\">&nbsp;</td></tr>" +
					"<tr height=\"30\"><td width=\"15%\" class=\"textblackth\">Rec Preparation:&nbsp;</td><td class=\"datacolumn\">" + recprep + "</td></tr>" +
					"<tr height=\"30\"><td colspan=\"2\" class=\"textblackth\">&nbsp;</td></tr>");
				found = true;
			}
			rs.close();
			ps.close();

			if (found){
				listing = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" + listings.toString() + "</table>";
			}
			else{
				listing = "Data not found for catalog";
			}
		}
		catch( SQLException e ){
			logger.fatal("SyllabusDB: listCatalog - " + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("SyllabusDB: listCatalog - " + ex.toString());
		}

		return listing;
	}

	/*
	 * getSyllabi
	 * <p>
	 * @param	conn	Connection
	 * @param	user	String
	 * @param	idx	int
	 * <p>
	 * @return Banner
	 */
	public static List<Syllabus> getSyllabi(Connection conn,String user,int idx) {

		List<Syllabus> SyllabusData = null;

		try {
			if (SyllabusData == null){

				AseUtil ae = new AseUtil();

            SyllabusData = new LinkedList<Syllabus>();

				String sql = "SELECT id,Coursealpha,Coursenum,yeer,Semester,AuditDate "
								+ "FROM tblSyllabus "
								+ "WHERE userid=? "
								+ "ORDER BY coursealpha, coursenum, yeer DESC";

				if (idx > 0){
					sql = "SELECT id,Coursealpha,Coursenum,yeer,Semester,AuditDate "
							+ "FROM tblSyllabus "
							+ "WHERE userid=? "
							+ "AND Coursealpha like '"+(char)idx+"%' "
							+ "ORDER BY coursealpha, coursenum, yeer DESC";
				}

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
            	SyllabusData.add(new Syllabus(
										ae.nullToBlank(rs.getString("id")),
										ae.nullToBlank(rs.getString("Coursealpha")),
										ae.nullToBlank(rs.getString("Coursenum")),
										ae.nullToBlank(rs.getString("yeer")),
										ae.nullToBlank(rs.getString("Semester")),
										ae.ASE_FormatDateTime(rs.getString("AuditDate"),Constant.DATE_DATETIME)
									));
				} // while
				rs.close();
				ps.close();

				ae = null;
			} // if
		} catch (SQLException e) {
			logger.fatal("SyllabusDB: getSyllabi - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("SyllabusDB: getSyllabi - " + e.toString());
			return null;
		}

		return SyllabusData;
	}

	/*
	 * writeCatalog - writes out the catalog file
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 *	@param	alpha			String
	 *	@param	num			String
	 *	@param	parseHtml	boolean
	 *	@param	suppress		boolean
	 *	<p>
	 *	@return String
	 */
	public static String writeCatalog(String campus,String alpha,String num) {

		return writeCatalog(campus,"",alpha,num);

	}

	public static String writeCatalog(String campus,String user,String alpha,String num) {

		return writeCatalog(campus,user,alpha,num,true,true);

	}

	public static String writeCatalog(String campus,String user,String alpha,String num,boolean parseHtml,boolean suppress) {

		String catalog = "";

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();
			if (conn != null){
				catalog = writeCatalog(conn,campus,alpha,num,parseHtml,suppress);

				// place in file drop for user when creating full catalog
				if (catalog != null && num.equals(Constant.BLANK)){
					FileDrop fd = new FileDrop();
					fd.insert(conn,campus,user,catalog,"Course Catalog","Alpha: " + alpha + "; Num: " + num);
					fd = null;

					Mailer mailer = new Mailer();
					mailer.setCampus(campus);
					mailer.setAlpha("");
					mailer.setNum("");
					mailer.setFrom(user);
					mailer.setTo(user);
					mailer.setContent("Your course catalog was processed and the resulting output is available for viewing in Curriculum Central (CC).");
					mailer.setSubject("Curriculum Central (CC) Course Catalog is Available");
					mailer.setPersonalizedMail(true);
					MailerDB mailerDB = new MailerDB(conn,mailer);
					mailer = null;
				}

			}
		} catch( Exception e ){
			logger.fatal("SyllabusDB: writeCatalog - " + e.toString());
		} finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("SyllabusDB: writeCatalog - " + e.toString());
			}
		}

		return catalog;

	}

	/*
	 * writeCatalog - writes out the catalog file
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	parseHtml	boolean
	 * @param	suppress		boolean
	 *	<p>
	 *	@return String
	 */
	public static String writeCatalog(Connection conn,String campus,String alpha,String num,boolean parseHtml) {

		return writeCatalog(conn,campus,alpha,num,parseHtml,true);

	}

	/*
	 * writeCatalog - writes out the catalog file
	 *	<p>
	 *	@param	conn			Connection
	 *	@param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	parseHtml	boolean
	 * @param	suppress		boolean
	 *	<p>
	 *	@return String
	 */
	public static String writeCatalog(Connection conn,String campus,String alpha,String num,boolean parseHtml,boolean suppress) {

		//Logger logger = Logger.getLogger("test");

		String temp = "";
		String junk = "";
		String sql = "";
		String kix = "";
		String dataColumns = "";
		String documents = "";
		String fileName = "";
		String filePath = "";

		final int CATALOG_OUTLINE	= 0;
		final int CATALOG_ALPHA		= 1;
		final int CATALOG_ALL		= 2;

		int i = 0;
		int j = 0;
		int k = 0;

		int totalLines = 0;

		// assuming a maximum of 20 lines max for catalog template
		String[] lines = new String[200];
		String[] fields = new String[200];

		FileWriter fstream = null;
		BufferedWriter outStream = null;

		String errorMessage = "";
		boolean error = false;
		boolean dataFound = false;

		int condition = -1;

		boolean debug = false;

		try{
			String catalog = StmtDB.getCatalogStatement(conn,campus);

			if (!catalog.equals(Constant.BLANK)){

				//-----------------------------------------------
				// correct HTML tag for <cc_nb>
				//-----------------------------------------------
				catalog = catalog.replace("&lt;","<").replace("&gt;",">");

				//-----------------------------------------------
				// make it easier to find br
				//-----------------------------------------------
				catalog = catalog.replace("<br />","<br/>").replace("<br>","<br/>");

				//-----------------------------------------------
				// let's break template into single line items breaking at </P>
				// the idea is to keep the lines as entered by the user. once lines
				// are created, we'll process data elements accordingly
				//-----------------------------------------------
				j = catalog.indexOf("</p>");
				while (j > -1){

					// there should be a single line break or paragraph marker per line
					// find them, then adjust for line format
					lines[totalLines] = catalog.substring(0,j+4);
					catalog = catalog.substring(j+4);

					++totalLines;

					j = catalog.indexOf("</p>");

				} // while

				if (debug) {
					System.out.println("======================== lines");
					for (int xyz=0; xyz<totalLines; xyz++) {
						System.out.println(xyz + ": " + lines[xyz]);
					}
				}

				//-----------------------------------------------
				// 1) extract text catalog by removing all HTML tags
				// 2) once columns are isolated, remove brackets
				//-----------------------------------------------
				if (totalLines > 0){

					// 1
					for (k=0;k<totalLines;k++){
						temp = lines[k];
						i = temp.indexOf("<");
						j = 0;
						while(i > -1){
							j = temp.indexOf(">");
							if(j > -1){
								junk = temp.substring(i,j+1);
								temp = temp.replace(junk,"");
							} // valid end tag
							i = temp.indexOf("<");
						} // while

						fields[k] = temp;
					} // for

					if (debug) {
						System.out.println("---------------------- fields1");
						for (int xyz=0; xyz<totalLines; xyz++) {
							System.out.println(xyz + ": " + fields[xyz]);
						}
					}

					// 2
					for (k=0;k<totalLines;k++){
						dataColumns = "";
						j = 0;
						temp = fields[k];
						i = temp.indexOf("[");
						while(i > -1){
							j = temp.indexOf("]");
							if(j > -1){
								junk = temp.substring(i,j+1);
								if (junk.startsWith("[") && junk.endsWith("]")){
									if (dataColumns.equals(Constant.BLANK)){
										dataColumns = junk;
									}
									else{
										dataColumns = dataColumns + "," + junk;
									}
									temp = temp.replace(junk,"");
								} // found column
							} // valid end tag
							i = temp.indexOf("[");
						} // while

						fields[k] = dataColumns;

					} // for

					if (debug) {
						System.out.println("---------------------- fields2");
						for (int xyz=0; xyz<totalLines; xyz++) {
							System.out.println(xyz + ": " + fields[xyz]);
						}
					}

					//------------------------------------------------
					// create SQL from fields
					//------------------------------------------------
					for (i=0;i<totalLines;i++){
						if (!fields[i].equals(Constant.BLANK)){
							if (sql.equals(Constant.BLANK)){
								sql = fields[i];
							}
							else{
								sql = sql + "," + fields[i];
							} // sql
						} // valid field
					} // for

					if (debug) {
						System.out.println("----------------------- columns");
						System.out.println(sql);
					}

					//-----------------------------------------------
					// what data are we processing
					//-----------------------------------------------
					if (alpha != null && alpha.length() > 0 && num != null && num.length() > 0 ){
						condition = CATALOG_OUTLINE;
					}
					else if (alpha != null && alpha.length() > 0 && (num == null || num.length() == 0) ){
						condition = CATALOG_ALPHA;
					}
					else{
						condition = CATALOG_ALL;
					}

					//-----------------------------------------------
					// with valid SQL, lets do it
					//-----------------------------------------------
					if (!sql.equals(Constant.BLANK) && condition > -1){

						// remove square brackets used during creation of template
						sql = sql.replace("[","").replace("]","");

						// using strinb builder to lessen load on String
						StringBuilder sb = new StringBuilder();

						if (condition == CATALOG_OUTLINE){
							sb.append("SELECT c.historyid,")
								.append(sql)
								.append(" ")
								.append("FROM tblCourse c,tblCampusdata cd ")
								.append("WHERE c.campus=? ")
								.append("AND c.coursetype='CUR' ")
								.append("AND c.CourseAlpha=? ")
								.append("AND c.CourseNum=? ")
								.append("AND c.historyid=cd.historyid ")
								.append("ORDER BY c.CourseAlpha,c.CourseNum");
						}
						else if (condition == CATALOG_ALPHA){
							sb.append("SELECT c.historyid," + sql + " ")
								.append("FROM tblCourse c,tblCampusdata cd ")
								.append("WHERE c.campus=? ")
								.append("AND c.coursetype='CUR' ")
								.append("AND c.CourseAlpha=? ")
								.append("AND (NOT c.coursedate IS NULL) ")
								.append("AND c.historyid=cd.historyid ")
								.append("ORDER BY c.CourseAlpha,c.CourseNum");
						}
						else{
							sb.append("SELECT c.historyid," + sql + " ")
								.append("FROM tblCourse c,tblCampusdata cd ")
								.append("WHERE c.campus=? ")
								.append("AND c.coursetype='CUR' ")
								.append("AND (NOT c.coursedate IS NULL) ")
								.append("AND c.historyid=cd.historyid ")
								.append("ORDER BY c.CourseAlpha,c.CourseNum");
						} // condition

						sql = sb.toString();

						try {
							String htmlHeader = Util.getResourceString("header.ase");
							String htmlFooter = Util.getResourceString("footer.ase");

							documents = SysDB.getSys(conn,"documents");

							fileName = "catalog_" + campus + "_" + SQLUtil.createHistoryID(1) + ".htm";

							filePath = AseUtil.getCurrentDrive()
											+ ":" + documents + "outlines\\" + campus + "\\" + fileName;

							fstream = new FileWriter(filePath);
							outStream = new BufferedWriter(fstream);
							outStream.write(htmlHeader);

							// get data
							PreparedStatement ps = conn.prepareStatement(sql);

							// define proper parameters
							if (condition == CATALOG_OUTLINE){
								ps.setString(1,campus);
								ps.setString(2,alpha);
								ps.setString(3,num);
							}
							else if (condition == CATALOG_ALPHA){
								ps.setString(1,campus);
								ps.setString(2,alpha);
							}
							else{
								ps.setString(1,campus);
							}
							ResultSet rs = ps.executeQuery();
							while (rs.next()){

								dataFound = true;

								kix = AseUtil.nullToBlank(rs.getString("historyid"));
								String[] info = Helper.getKixInfo(conn,kix);
								alpha = info[Constant.KIX_ALPHA];
								num = info[Constant.KIX_NUM];

								// loop through all lines and fill in data
								for (i=0;i<totalLines;i++){

									// work with 1 line at a time
									temp = lines[i];

									// does the line have data column? If yes, process data
									if(temp.contains("[c.") || temp.contains("[cd.") ){

										// how many columns to print on this line
										String[] columns = fields[i].split(",");

										for(j=0;j<columns.length;j++){

											String column = columns[j];

											// clean up for data read from recordset
											dataColumns = columns[j].replace("c.","")
																			.replace("cd.","")
																			.replace("[","")
																			.replace("]","");

											// get our data
											String data = AseUtil.nullToBlank(rs.getString(dataColumns));

											//data has faulty list tags should be removed
											data = data.replace("&nbsp;"," ").replace("<ul></ul>","");

											// clean user embedded formatting
											if(parseHtml){
												// sanitize the data to get it in proper form
												data = com.ase.aseutil.html.HtmlSanitizer.sanitize(data);

												// now remove to avoid losing format
												data = com.ase.aseutil.html.HtmlUtils.htmlContentParser(data);
											}

											// some lines are conditioned to not print when empty
											if (data.equals(Constant.BLANK) && lines[i].contains("{cc_nb}")){
												temp = "";
											}
											else{
												temp = temp.replace(column,
																			Outlines.formatOutline(conn,
																										dataColumns,
																										campus,
																										alpha,
																										num,
																										"CUR",
																										kix,
																										data,
																										true,
																										campus,
																										suppress))
																.replace("{cc_nb}","");
											}
										} // j
									}
									else{

										if(temp.equals(Constant.BLANK)){
											temp = "<br/>";
										}

									} // if data column

									// remove CC default formatting
									temp = temp.replace("datacolumn","").replace("dataColumn","").replace("textblackth","");

									outStream.write(temp.replace("{cc_nb}","").replace("{/cc_nb}",""));
								} // for

							}
							rs.close();
							ps.close();

							if (!dataFound){
								error = true;
								errorMessage = "Processing error: Data not found for requested catalog (alpha="+alpha+"; num="+num+")";
								outStream.write(errorMessage);
							}

							outStream.write(htmlFooter);

						} catch (SQLException e) {
							error = true;
							errorMessage = "Processing error: Template contains error. Review your template and try again.";
							logger.fatal("SyllabusDB: writeCatalog - " + e.toString());
						} catch (Exception e) {
							error = true;
							errorMessage = "Processing error: Template contains error. Review your template and try again.";
							logger.fatal("SyllabusDB: writeCatalog - " + e.toString());
						} finally {
							outStream.close();
						}

					}
					else{
						error = true;
						errorMessage = "Processing error: Unable to form data selection statement.";
						logger.fatal(errorMessage);
					} // if sql

				} // if totalLines > 0

			} // we have catalog

		} catch (Exception e) {
			logger.fatal("SyllabusDB: writeCatalog - " + e.toString());
		}

		junk = SysDB.getSys(conn,"documentsURL") + "outlines/" + campus + "/" + fileName;
		if (error){
			junk = errorMessage;
		}

		return junk;

	}

	/*
	 * close
	 */
	public void close() throws SQLException {}

}