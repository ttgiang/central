/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.test;

import com.test.aseutil.*;

import com.ase.aseutil.*;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import junit.framework.TestCase;
import junit.framework.TestSuite;

public class ModifyTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(ModifyTest.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 modifyTest(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  modifyTest(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean success = false;

		try{
			if (getConnection() != null){

				logger.info("\tModifyTest started...");

				modifyTest(getConnection(),getCampus());

				success = true;

				logger.info("\tModifyTest ended...");

			}
		}
		catch( SQLException e ){
			logger.fatal("ModifyTest: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("ModifyTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static int modifyTest(Connection conn,String campus) throws Exception {

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		int processed = 0;

		try{
			String sql = "";
			PreparedStatement ps = null;

			// clear any pending data
			JobsDB.deleteJob("ApprovalTest");

			// insert data to work with
			sql = "INSERT INTO tblJobs(job,subjob,historyid,campus,alpha,num,type,auditby,auditdate,proposer,route) "
				+ "SELECT 'ApprovalTest','ModifyTest',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate(),proposer,route "
				+ "FROM tblCourse WHERE campus=? AND coursetype='PRE' AND progress='MODIFY'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			int rowsAffected = ps.executeUpdate();
			ps.close();

			int i = 0;

			String[] questions = QuestionDB.getCampusColumms(conn,campus).split(",");

			// for each outline found, do the following
			// run through all questions and update where column starts with "X"

			com.ase.aseutil.CourseDB courseDB = new com.ase.aseutil.CourseDB();

			sql = "select historyid, alpha AS coursealpha,num AS coursenum,proposer,route from tbljobs order by alpha,num";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				try{
					for(i=0;i<questions.length;i++){

						// insert for comments
						if(questions[i].toUpperCase().startsWith("X")){
							courseDB.setCourseItem(conn,
															kix,
															questions[i],
															courseDB.getCourseItem(conn,kix,questions[i]) + "<br><br>" + "TestModify on " + AseUtil.getCurrentDateTimeString(),
															"s");
						}

						// insert as list (extra buttons)
						for(int j = 0; j<5; j++){

							String content = j + ") " + AseUtil.getCurrentDateTimeString();

							if (questions[i].equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
								CompetencyDB.addRemoveCompetency(conn,"a",campus,alpha,num,content,0,proposer,kix);
							}
							else if (questions[i].equalsIgnoreCase(Constant.COURSE_PROGRAM_SLO) || questions[i].equalsIgnoreCase(Constant.IMPORT_PLO)){
								GenericContent gc = new GenericContent(0,kix,campus,alpha,num,"PRE",questions[i],content,"",proposer,0);
								GenericContentDB.insertContent(conn,gc);
							}
							else if (questions[i].equalsIgnoreCase(Constant.COURSE_INSTITUTION_LO) || questions[i].equalsIgnoreCase(Constant.IMPORT_ILO)){
								GenericContent gc = new GenericContent(0,kix,campus,alpha,num,"PRE",questions[i],content,"",proposer,0);
								GenericContentDB.insertContent(conn,gc);
							}
							else if (questions[i].equalsIgnoreCase(Constant.COURSE_GESLO)){
								GenericContent gc = new GenericContent(0,kix,campus,alpha,num,"PRE",questions[i],content,"",proposer,0);
								GenericContentDB.insertContent(conn,gc);
							}
							else if (questions[i].equalsIgnoreCase(Constant.COURSE_CONTENT)){
								ContentDB.addRemoveCourseContent(conn,"a",campus,alpha,num,proposer,content,content,0,kix);
							}
							else if (questions[i].equalsIgnoreCase(Constant.COURSE_PREREQ) || questions[i].equalsIgnoreCase(Constant.COURSE_COREQ)){
								RequisiteDB.addRemoveRequisites(conn,kix,"a",campus,alpha,num,"AX","NX",content,"1",proposer,0,false);
								RequisiteDB.addRemoveRequisites(conn,kix,"a",campus,alpha,num,"AX","NX",content,"2",proposer,0,false);
							}

						} // for j

					} // for i

				}
				catch(Exception e){
					logger.fatal("ModifyTest " + e.toString());
				}

				JobsDB.deleteJobByKix(conn,kix);

				++processed;

			} // while
			rs.close();
			ps.close();

			courseDB = null;

		}
		catch(Exception e){
			logger.fatal("ModifyTest - " + e.toString());
		}

		return processed;

	}

}