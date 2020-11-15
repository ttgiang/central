/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil;

import com.ase.aseutil.Constant;

public class SQL {

	public static final String ApprovedOutlinesSLO = "SELECT coursealpha,coursenum,coursetitle,effectiveterm,auditdate,proposer, "
			+ Constant.COURSE_OBJECTIVES
			+ " FROM tblCourse WHERE campus=? "
			+ "AND NOT " + Constant.COURSE_OBJECTIVES + " IS NULL "
			+ "ORDER BY coursealpha,coursenum";

	public static final String ApprovedOutlinesNoSLO = "SELECT coursealpha,coursenum,coursetitle,effectiveterm,auditdate,proposer, "
			+ Constant.COURSE_OBJECTIVES
			+ " FROM tblCourse WHERE campus=? AND " + Constant.COURSE_OBJECTIVES + " IS NULL "
			+ "ORDER BY coursealpha,coursenum";

	public static final String EffectiveTerms = "SELECT historyid,Alpha AS courseAlpha,Number as courseNum,Title AS courseTitle,proposer,coursedate "
			+ "FROM vw_EffectiveTerms WHERE campus=? AND term_code=? ORDER BY alpha,number";

	public static final String endDate = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,enddate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(enddate)=? and month(enddate)=? ORDER BY courseAlpha,courseNum";

	public static final String endDateYY = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,enddate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(enddate)=? ORDER BY courseAlpha,courseNum";

	public static final String experimentalDate = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,experimentaldate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(experimentaldate)=? and month(experimentaldate)=? ORDER BY courseAlpha,courseNum";

	public static final String experimentalDateYY = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,experimentaldate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(experimentaldate)=? ORDER BY courseAlpha,courseNum";

	public static final String reviewDate = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,reviewdate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(reviewdate)=? and month(reviewdate)=? ORDER BY courseAlpha,courseNum";

	public static final String reviewDateYY = "SELECT historyid,courseAlpha,courseNum,courseTitle,proposer,reviewdate "
			+ "FROM tblcourse WHERE campus=? AND coursetype='CUR' AND year(reviewdate)=? ORDER BY courseAlpha,courseNum";

	public static final String outlinesShowOutlines = "SELECT tc.historyid, tc.CourseAlpha, tc.CourseNum, tc.coursetitle "
			+ "FROM tblCourse AS tc LEFT OUTER JOIN BANNER AS b "
			+ "ON tc.campus = b.INSTITUTION AND tc.CourseAlpha = b.CRSE_ALPHA AND tc.CourseNum = b.CRSE_NUMBER "
			+ "WHERE tc.campus=? "
			+ "AND tc.Progress=? "
			+ "ORDER BY tc.CourseAlpha, tc.CourseNum ";

	public static final String textMaterials = "SELECT tc.coursealpha,tc.coursenum,tc.coursetitle, "
			+ "tt.Title, tt.Edition,tt.Author,tt.Publisher,tt.yeer,tt.ISBN "
			+ "FROM tblCourse tc, tbltext tt "
			+ "WHERE tc.campus=? AND "
			+ "tc.coursetype=? AND "
			+ "tc.effectiveterm=? AND "
			+ "tc.historyid=tt.historyid "
			+ "ORDER BY tc.coursealpha,tc.coursenum";

	public static final String vw_CampusQuestions =
			"SELECT c.campus, c.questionseq, cc.Question_Number, c.question, c.help, cc.Question_Friendly "
			+ "FROM CCCM6100 cc, tblCampusQuestions c  "
			+ "WHERE c.campus=? "
			+ "AND cc.type = c.type  "
			+ "AND cc.campus = c.campus  "
			+ "AND cc.Question_Number = c.questionnumber "
			+ "AND c.type = 'Campus'  "
			+ "AND c.include = 'Y' "
			+ "ORDER BY c.questionseq";

	public static final String vw_CourseQuestions =
			"SELECT c.campus, c.questionseq, cc.Question_Number, c.question, c.help, cc.Question_Friendly "
			+ "FROM tblCourseQuestions AS c, CCCM6100 cc "
			+ "WHERE c.campus=? "
			+ "AND c.questionnumber = cc.Question_Number  "
			+ "AND c.type = cc.type "
			+ "AND c.type = 'Course'  "
			+ "AND c.include = 'Y' "
			+ "ORDER BY c.questionseq ";

	public static final String vw_ResequenceCampusItems =
			"SELECT q.campus, q.questionseq, c.Question_Friendly, q.type, q.include "
			+ "FROM tblCampusQuestions q INNER JOIN CCCM6100 c "
			+ "ON q.type = c.type  "
			+ "AND q.campus = c.campus  "
			+ "AND q.questionnumber = c.Question_Number "
			+ "WHERE q.type='Campus'  "
			+ "AND q.include='Y' "
			+ "";

	public static final String vw_ResequenceCourseItems =
			"SELECT tcc.campus, tcc.questionseq, CCCM6100.Question_Friendly "
			+ "FROM	tblCourseQuestions AS tcc INNER JOIN CCCM6100 "
			+ "ON tcc.questionnumber = CCCM6100.Question_Number "
			+ "WHERE CCCM6100.type='Course' "
			+ "AND tcc.include = 'Y' "
			+ "";

	public static final String vw_ResequenceProgramItems =
			"SELECT tcc.campus, tcc.questionseq, c.Question_Friendly "
			+ "FROM tblProgramQuestions AS tcc INNER JOIN CCCM6100 c ON "
			+ "tcc.questionnumber = c.Question_Number "
			+ "WHERE c.type='Program' "
			+ "AND tcc.include='Y' "
			+ "AND c.campus <> 'TTG' "
			+ "";

	/**
	 * <p>
	 * @param	hasData	boolean
	 * <p>
	 * @return	String
	 */
	public static String showSLOs(boolean hasData){

		/*
		String sql = "SELECT historyid,coursealpha,coursenum,coursetype,effectiveterm,auditdate,proposer,coursetitle,x18,x43 "
			+ "FROM tblCourse "
			+ "WHERE ";

		if (hasData){
			sql = sql
				+ " ((campus=?) AND (progress=?) AND (CourseType='CUR') AND ((NOT X18 IS NULL) AND (CAST(X18 AS VARCHAR)<>'')))";
		}
		else{
			sql = sql
				+ " ((campus=?) AND (progress=?) AND (CourseType='CUR') AND ((X18 IS NULL) OR (CAST(X18 AS VARCHAR)=''))) ";
		}

		sql = sql + " ORDER BY coursealpha,coursenum";
		*/

		String sql = "SELECT c.historyid, c.CourseAlpha, c.CourseNum, c.CourseType, c.effectiveterm, c.auditdate, c.proposer, c.coursetitle, c.X18, c.X43 ";

		if (hasData){
			sql = sql
				+ "FROM tblCourse AS c INNER JOIN "
				+ "(SELECT historyid FROM tblCourse "
				+ "WHERE (campus = ?) AND (Progress = ?) AND (CourseType = 'CUR') AND (NOT (X18 IS NULL)) AND (CAST(X18 AS VARCHAR) <> '') "
				+ "UNION "
				+ "SELECT historyid FROM tblCourseComp "
				+ "WHERE Campus = ? AND CourseType = 'CUR') AS u ON c.historyid = u.historyid  "
				+ "ORDER BY c.CourseAlpha, c.CourseNum ";
		}
		else{
			sql = sql
				+ "FROM tblCourse c LEFT JOIN tblCourseComp cc ON c.historyid = cc.historyid "
				+ "WHERE (((c.campus)=?) AND c.progress=? AND ((X18 IS NULL) OR (CAST(X18 AS VARCHAR)='')) "
				+ "and ((cc.historyid) Is Null)) ORDER BY c.coursealpha,c.coursenum";
		}

		return sql;

	}

	/**
	 * <p>
	 * @param	hasData	boolean
	 * <p>
	 * @return	String
	 */
	public static String showCompetencies(boolean hasData){

		/*
		String sql = "SELECT historyid,coursealpha,coursenum,coursetype,effectiveterm,auditdate,proposer,coursetitle,x18,x43 "
			+ "FROM tblCourse "
			+ "WHERE ";

		if (hasData){
			sql = sql
				+ " ((campus=?) AND (progress=?) AND (CourseType='CUR') AND ((NOT X43 IS NULL) AND (CAST(X43 AS VARCHAR)<>''))) ";
		}
		else{
			sql = sql
				+ " ((campus=?) AND (progress=?) AND (CourseType='CUR') AND ((X43 IS NULL) OR (CAST(X43 AS VARCHAR)=''))) ";
		}

		sql = sql + " ORDER BY coursealpha,coursenum";
		*/

		String sql = "SELECT c.historyid, c.CourseAlpha, c.CourseNum, c.CourseType, c.effectiveterm, c.auditdate, c.proposer, c.coursetitle, c.X18, c.X43 ";

		if (hasData){
			sql = sql
				+ "FROM tblCourse AS c INNER JOIN "
				+ "(SELECT historyid FROM tblCourse "
				+ "WHERE (campus = ?) AND (Progress = ?) AND (CourseType = 'CUR') AND (NOT (X43 IS NULL)) AND (CAST(X43 AS VARCHAR) <> '') "
				+ "UNION "
				+ "SELECT historyid FROM tblCourseCompetency "
				+ "WHERE Campus = ? AND CourseType = 'CUR') AS u ON c.historyid = u.historyid  "
				+ "ORDER BY c.CourseAlpha, c.CourseNum ";
		}
		else{
			sql = sql
				+ "FROM tblCourse c LEFT JOIN tblCourseCompetency cc ON c.historyid = cc.historyid "
				+ "WHERE (((c.campus)=?) AND c.progress=? AND ((X43 IS NULL) OR (CAST(X43 AS VARCHAR)='')) "
				+ "and ((cc.historyid) Is Null)) ORDER BY c.coursealpha,c.coursenum";
		}

		return sql;

	}

	/**
	 * <p>
	 * @param	progress	String
	 * @param	semester	String
	 * <p>
	 * @return	String
	 */
	public static String showOutlinesModifiedByAcademicYear(String progress){

		return showOutlinesModifiedByAcademicYear(progress,"");

	} // SQL.showOutlinesModifiedByAcademicYear

	public static String showOutlinesModifiedByAcademicYear(String progress,String semester){

		//Logger logger = Logger.getLogger("test");

		String dateField = "";
		String coursetype = "PRE";
		String table = "tblCourse";

		String sql = "";

		if (progress.equals(Constant.COURSE_APPROVED_TEXT)){
			dateField = "coursedate";
			coursetype = "CUR";
		}
		else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
			dateField = "coursedate";
			coursetype = "ARC";
			table = "tblCourseARC";
		}
		else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
			dateField = "auditdate";
			coursetype = "PRE";
		}
		else{
			dateField = "auditdate";
			coursetype = "PRE";
		}

		//
		// include effectiver term (semester) if one is requested
		//
		if(semester != null && semester.length() > 0){
			semester = " AND effectiveterm=? ";
		}
		else{
			semester = "";
		}

		sql = "SELECT DISTINCT historyid,coursealpha,coursenum,proposer,coursetitle,progress,effectiveterm,bt.TERM_DESCRIPTION, " + dateField + " "
			+ "FROM "+table+" left join bannerterms bt on effectiveterm = bt.TERM_CODE WHERE campus=? AND (YEAR("+dateField+") BETWEEN ? AND ?) "
			+ semester;

		if (progress != null && progress.length() > 0){
			sql += "AND coursetype='"+coursetype+"' ";
		}

		sql += "ORDER BY coursealpha,coursenum";

		return sql;

	} // SQL.showOutlinesModifiedByAcademicYear

	public static String showOutlinesModifiedByAcademicYearOBSOLETE(String progress,String semester){

		//Logger logger = Logger.getLogger("test");

		String dateField = "";
		String coursetype = "PRE";
		String table = "tblCourse";

		String sql = "";

		if (progress.equals(Constant.COURSE_APPROVED_TEXT)){
			dateField = "coursedate";
			coursetype = "CUR";
		}
		else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
			dateField = "coursedate";
			coursetype = "ARC";
			table = "tblCourseARC";
		}
		else if (progress.equals(Constant.COURSE_MODIFY_TEXT)){
			dateField = "auditdate";
			coursetype = "PRE";
		}
		else{
			dateField = "auditdate";
			coursetype = "PRE";
		}

		//
		// include effectiver term (semester) if one is requested
		//
		if(semester != null && semester.length() > 0){
			semester = " AND effectiveterm=? ";
		}
		else{
			semester = "";
		}

		sql = "SELECT DISTINCT historyid,coursealpha,coursenum,proposer,coursetitle,progress,effectiveterm, " + dateField + " "
			+ "FROM "+table+" WHERE campus=? AND (YEAR("+dateField+") BETWEEN ? AND ?) " + semester;

		if (progress != null && progress.length() > 0){
			sql += "AND coursetype='"+coursetype+"' ";
		}

		sql += "ORDER BY coursealpha,coursenum";

		return sql;

	} // SQL.showOutlinesModifiedByAcademicYear

	/**
	 * <p>
	 * vw_ApprovalsWithoutTasks
	 * <p>
	 */
	public static String vw_ApprovalsWithoutTasks(){

		String sql = "";

		try{

			/*
				-- approvalLikeTask are tasks with messages like approv and review
				-- outlinesInApproval are outlines in the approval state
				-- this query determines if an outline is missing a task
				-- as it goes through the approval state
				SELECT campus, historyid, route, CourseAlpha, CourseNum, outline
				FROM
				(
					SELECT campus, historyid, route, CourseAlpha, CourseNum, RTRIM(campus) + RTRIM(CourseAlpha) + RTRIM(CourseNum) AS outline
					FROM tblCourse
					WHERE (CourseType = 'PRE') AND (Progress = 'APPROVAL') OR
					(CourseType = 'PRE') AND (subprogress = 'REVIEW_IN_APPROVAL')
				) as outlinesInApproval
				WHERE outline not in
				(
					SELECT outline
					FROM
					(
						SELECT RTRIM(campus) + RTRIM(coursealpha) + RTRIM(coursenum) AS outline
						FROM tblTasks
						WHERE  message like '%approv%' or message like '%review%'
						AND coursetype = 'PRE'
					) as approvalLikeTask
				)
				ORDER BY campus,outline
			*/

			sql = "SELECT campus, historyid, route, CourseAlpha, CourseNum, outline "
					+ "FROM "
					+ "( "
					+ "	SELECT campus, historyid, route, CourseAlpha, CourseNum, RTRIM(campus) + RTRIM(CourseAlpha) + RTRIM(CourseNum) AS outline "
					+ "	FROM tblCourse "
					+ "	WHERE (CourseType = 'PRE') AND (Progress = 'APPROVAL') OR "
					+ "	(CourseType = 'PRE') AND (subprogress = 'REVIEW_IN_APPROVAL') "
					+ ") as outlinesInApproval "
					+ "WHERE outline not in "
					+ "( "
					+ "	SELECT outline "
					+ "	FROM "
					+ "	( "
					+ "		SELECT RTRIM(campus) + RTRIM(coursealpha) + RTRIM(coursenum) AS outline "
					+ "		FROM tblTasks "
					+ "		WHERE  message like '%approv%' or message like '%review%' "
					+ "		AND coursetype = 'PRE' "
					+ "	) as approvalLikeTask "
					+ ") ";

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * vw_getCourseQuestionInfo
	 * <p>
	 */
	public static String vw_getCourseQuestionInfo(){

		String sql = "";

		try{

			sql = "SELECT c.campus, c.questionseq, c.questionnumber, c.counttext, c.extra, c.[permanent], c.append, cm.Question_Friendly, "
					+ "cm.Question_Explain, cm.Question_Len, cm.Question_Max, cm.Question_Type, cm.Question_Ini, c.defalt, c.help, c.question  "
					+ "FROM tblCourseQuestions c INNER JOIN CCCM6100 cm ON c.questionnumber = cm.Question_Number "
					+ "WHERE c.questionseq > 0 AND c.include = 'Y' AND cm.type = 'Course' AND cm.campus = 'Sys'";

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * vw_getCampusQuestionInfo
	 * <p>
	 */
	public static String vw_getCampusQuestionInfo(){

		String sql = "";

		try{

			sql = "SELECT c.campus, c.questionseq, c.questionnumber, c.counttext, c.extra, c.[permanent], c.append, cm.Question_Friendly, "
					+ "cm.Question_Explain, cm.Question_Len, cm.Question_Max, cm.Question_Type, cm.Question_Ini, c.defalt, c.help, c.question "
					+ "FROM tblCampusQuestions c INNER JOIN CCCM6100 cm ON c.campus = cm.campus AND c.questionnumber = cm.Question_Number "
					+ "WHERE c.questionseq > 0 AND c.include = 'Y' AND cm.type = 'Campus'";

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * vw_getProgramQuestionInfo
	 * <p>
	 */
	public static String vw_getProgramQuestionInfo(){

		String sql = "";

		try{

			sql = "SELECT c.campus, c.questionseq, c.questionnumber, c.counttext, c.extra, c.[permanent], c.append, cm.Question_Friendly, "
					+ "cm.Question_Explain, cm.Question_Len, cm.Question_Max, cm.Question_Type, cm.Question_Ini, c.defalt, c.help, c.question  "
					+ "FROM tblProgramQuestions c INNER JOIN CCCM6100 cm ON c.questionnumber = cm.Question_Number "
					+ "WHERE c.questionseq > 0 AND c.include = 'Y' AND cm.type = 'Program' AND cm.campus = 'Sys'";

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * currentTaskOwner
	 * <p>
	 */
	public static String currentTaskOwner(String campus){

		// returns SQL with list of users having tasks and courses are in PRE

		String sql = "";

		try{

			sql = "SELECT DISTINCT t.submittedfor AS id, u.lastname + ', ' + u.firstname AS fullname "
				+ "FROM  tblTasks t INNER JOIN "
				+ "tblUsers u ON t.campus = u.campus AND t.submittedfor = u.userid "
				+ "WHERE t.campus='%_campus_%' "
				+ "UNION "
				+ "SELECT DISTINCT t.proposer AS id, u.lastname + ', ' + u.firstname AS fullname "
				+ "FROM  tblCourse t INNER JOIN "
				+ "tblUsers u ON t.campus = u.campus AND t.proposer = u.userid "
				+ "WHERE t.campus='%_campus_%' and t.coursetype='PRE' ORDER BY fullname";

			sql = sql.replace("%_campus_%", campus);

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * campusUsers
	 * <p>
	 */
	public static String campusUsers(String campus){

		// returns SQL with list of users for a campus

		String sql = "";

		try{

			sql = "SELECT userid, lastname + ', ' + firstname AS fullname FROM tblUsers WHERE campus='%_campus_%' ORDER BY fullname";
			sql = sql.replace("%_campus_%", campus);

		}
		catch(Exception e){
			sql = "";
		}

		return sql;

	}

	/**
	 * <p>
	 * @param	campus	String
	 * @param	college	String
	 * @param	dept		String
	 * @param	level		String
	 * <p>
	 */
	public static String getApproverCDL(String campus,String college,String dept,String level){

		StringBuilder sql = new StringBuilder();

		try{
			AseUtil aseUtil = new AseUtil();

			sql.append("SELECT id,kid FROM tblINI WHERE ")
				.append(" campus=" + aseUtil.toSQL(campus,1))
				.append(" and category='ApprovalRouting' ")
				.append(" and kval1 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(college,1,false)).replace("Null","") + "%'")
				.append(" and kval2 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(dept,1,false)).replace("Null","") + "%'")
				.append(" and kval3 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(level,1,false)).replace("Null","") + "%'")
				.append(" ORDER BY kid");

			aseUtil = null;

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return sql.toString();

	}

	/**
	 * <p>
	 * returns a listing of departments given the college
	 * <p>
	 * @param	campus	String
	 * @param	college	String
	 * <p>
	 */
	public static String getApproverDept(String campus,String college){

		StringBuilder sql = new StringBuilder();

		try{
			String bannerdepartment = "SELECT DISTINCT COURSE_ALPHA, ALPHA_DESCRIPTION + ' (' + COURSE_ALPHA + ')' AS descr "
				+ "FROM BannerAlpha ORDER BY ALPHA_DESCRIPTION + ' (' + COURSE_ALPHA + ')' ";

			AseUtil aseUtil = new AseUtil();

			if(college != null && college.length() > 0){
				sql.append("SELECT DISTINCT ba.COURSE_ALPHA, ba.ALPHA_DESCRIPTION + ' (' + ba.COURSE_ALPHA + ')' AS descr ")
					.append("FROM BannerAlpha ba INNER JOIN ")
					.append("( ")
					.append("SELECT DISTINCT TOP (100) PERCENT kval2 FROM tblINI WHERE ")
					.append(" campus=" + aseUtil.toSQL(campus,1))
					.append(" and category='ApprovalRouting' ")
					.append(" and kval1 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(college,1,false)).replace("Null","") + "%'")
					.append("ORDER BY kval2 ")
					.append(") AS t ON ba.COURSE_ALPHA = t.kval2 ")
					.append("ORDER BY descr ");
			}
			else{
				sql.append(bannerdepartment);
			}

			aseUtil = null;

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return sql.toString();

	}

	/**
	 * <p>
	 * returns a listing of levels given college and department
	 * <p>
	 * @param	campus	String
	 * @param	college	String
	 * @param	dept	String
	 * <p>
	 */
	public static String getApproverLevel(String campus,String college,String dept){

		StringBuilder sql = new StringBuilder();

		try{
			String level = "SELECT level_code,level_descr + ' (' + level_code + ')' as descr "
					+ "FROM BannerLevel ORDER BY level_descr";

			AseUtil aseUtil = new AseUtil();

			if(college != null && college.length() > 0 && dept != null && dept.length() > 0){
				sql.append("SELECT DISTINCT bl.level_code,bl.level_descr + ' (' + bl.level_code + ')' as descr ")
					.append("FROM BannerLevel bl INNER JOIN ")
					.append("( ")
					.append("SELECT DISTINCT TOP (100) PERCENT kval3 FROM tblINI WHERE ")
					.append(" campus=" + aseUtil.toSQL(campus,1))
					.append(" and category='ApprovalRouting' ")
					.append(" and kval1 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(college,1,false)).replace("Null","") + "%'")
					.append(" and kval2 like '%" + AseUtil.nullToBlank(aseUtil.toSQL(dept,1,false)).replace("Null","") + "%'")
					.append(" ORDER BY kval3 ")
					.append(") AS t ON bl.level_code = t.kval3 ")
					.append("ORDER BY descr ");
			}
			else{
				sql.append(level);
			}

			aseUtil = null;

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return sql.toString();

	}

	/**
	 * <p>
	 * @param	campus	String
	 * <p>
	 */
	public static String renameInProgress(String campus){

		String sql = "";

		try{
			sql = "SELECT * FROM tblRename WHERE campus=?";
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return sql;
	}

	/**
	 * <p>
	 * close
	 * <p>
	 */
	public SQL() throws Exception {}

}