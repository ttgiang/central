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

public class ApprovalInProgressTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(ApprovalInProgressTest.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalInProgressTest#testMe()}.
	 */
	 public final void testMe(){

		 approvalInProgressTest(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  approvalInProgressTest(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean success = false;

		try{
			if (getConnection() != null){

				logger.info("\tApprovalInProgressTest started...");

				if (getCampus() == null || getCampus().length() == 0){

					String campuses = CampusDB.getCampusNames(getConnection());
					String[] aCampuses = campuses.split(",");
					for (int i = 0; i < aCampuses.length; i++){
						approvalInProgressTest(getConnection(),aCampuses[i]);
					}

				}
				else{
					approvalInProgressTest(getConnection(),getCampus());
				}

				success = true;

				logger.info("\tApprovalInProgressTest ended...");
			}
		}
		catch( SQLException e ){
			logger.fatal("ApprovalInProgressTest: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("ApprovalInProgressTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static int approvalInProgressTest(Connection conn,String campus) throws Exception {

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		try{
			String sql = "";
			PreparedStatement ps = null;

			// clear any pending data
			JobsDB.deleteJob("ApprovalTest");

			// put data in for testing
			sql = "INSERT INTO tblJobs(job,subjob,historyid,campus,alpha,num,type,auditby,auditdate,proposer,route)  "
				+ "SELECT 'ApprovalTest','ApprovalInProgressTest',tc.historyid,tc.campus,tt.coursealpha,tt.coursenum,tc.coursetype,tc.proposer,tc.auditdate,tc.proposer,tc.route "
				+ "FROM tblTasks tt INNER JOIN "
				+ "tblCourse tc "
				+ "ON tt.campus = tc.campus "
				+ "AND tt.coursealpha = tc.CourseAlpha "
				+ "AND tt.coursenum = tc.CourseNum "
				+ "WHERE (tt.message LIKE '%approve outline%') "
				+ "AND (tc.campus = ?) "
				+ "AND (tc.CourseType = 'PRE') "
				+ "AND (tc.Progress = 'APPROVAL') "
				+ "AND (tc.route > 0) ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.executeUpdate();
			ps.close();

			int i = 0;

			com.ase.aseutil.CourseDB courseDB = new com.ase.aseutil.CourseDB();

			sql = "select historyid, alpha AS coursealpha,num AS coursenum,proposer,route from tbljobs order by alpha,num";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				int route = NumericUtil.getInt(rs.getInt("route"),0);

				try{
					if (route == 0){
						route = ApprovalUtil.getApprovalRouteToUse(conn,campus);
						ApproverDB.setApprovalRouting(conn,campus,alpha,num,route);
					}

					logger.info(proposer + " - " + alpha + " - " + num + " - " + route);

					courseDB.setCourseForApproval(conn,campus,alpha,num,proposer,Constant.COURSE_APPROVAL_TEXT,route,proposer);

					approvalInProgressTest(conn,campus,proposer,alpha,num,route);
				}
				catch(Exception e){
					logger.fatal("ApprovalInProgressTest " + e.toString());
				}

				JobsDB.deleteJobByKix(conn,kix);

				++i;

			} // while
			rs.close();
			ps.close();

			courseDB = null;

		}
		catch(Exception e){
			logger.fatal("ApprovalInProgressTest - " + e.toString());
		}

		return 0;

	}

	public static int approvalInProgressTest(Connection conn,String campus,String user,String alpha,String num,int route) throws Exception {

		// get all approvers for the route to use
		Approver ap = com.ase.aseutil.ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);

		// split approvers into array of users to approve
		String[] users = ap.getAllApprovers().split(",");

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		boolean approval = true;

		try{
			logger.info(alpha + " - " + num + " - " + route);

			int getLastApproverSequence = ApproverDB.getLastApproverSequence(conn,campus,kix);
			if (getLastApproverSequence <= 0){
				getLastApproverSequence = 0;
			}

			if (getLastApproverSequence < users.length){
				for (int i=getLastApproverSequence;i<users.length;i++){
					String approver = users[i];
					String comments = approver + " - " + AseUtil.getCurrentDateTimeString();
					com.ase.aseutil.CourseApproval.approveOutlineX(conn,campus,alpha,num,approver,approval,comments,i,i*i+1,i*i+2);
				}
			}
		}
		catch(Exception e){
			logger.fatal("ApprovalInProgressTest - " + e.toString());
		}

		return 0;

	}

}