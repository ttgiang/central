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

public class ApprovalDeleteTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(ApprovalDeleteTest.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 approvalDeleteTest(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  approvalDeleteTest(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean success = false;

		try{
			if (getConnection() != null){

				logger.info("\tApprovalDeleteTest started...");

				if (getCampus() == null || getCampus().length() == 0){

					String campuses = CampusDB.getCampusNames(getConnection());
					String[] aCampuses = campuses.split(",");
					for (int i = 0; i < aCampuses.length; i++){
						approvalDeleteTest(getConnection(),aCampuses[i]);
					}

				}
				else{
					approvalDeleteTest(getConnection(),getCampus());
				}

				success = true;

				logger.info("\tApprovalDeleteTest ended...");
			}
		}
		catch( SQLException e ){
			logger.fatal("ApprovalDeleteTest: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("ApprovalDeleteTest: approval - " + e.toString());
		}

		assertTrue(success);
	}

	public static int approvalDeleteTest(Connection conn,String campus) throws Exception {

		Logger logger = Logger.getLogger("test");

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		try{
			String sql = "";
			PreparedStatement ps = null;

			// clear any pending data
			JobsDB.deleteJob("ApprovalTest");

			// insert data to work with
			sql = "INSERT INTO tblJobs(job,subjob,historyid,campus,alpha,num,type,auditby,auditdate,proposer,route) "
				+ "SELECT 'ApprovalTest','ApprovalDeleteTest',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate(),proposer,route "
				+ "FROM vw_ApprovalStatus "
				+ "WHERE campus=? "
				+ "AND progress='DELETE'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			int rowsAffected = ps.executeUpdate();
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
						route = com.ase.aseutil.test.ApprovalUtil.getApprovalRouteToUse(conn,campus);
						ApproverDB.setApprovalRouting(conn,campus,alpha,num,route);
					}

					logger.info(proposer + " - " + alpha + " - " + num + " - " + route);

					approvalDeleteTest(conn,campus,proposer,alpha,num,route);
				}
				catch(Exception e){
					logger.fatal("ApprovalDeleteTest " + e.toString());
				}

				JobsDB.deleteJobByKix(conn,kix);

				++i;

			} // while
			rs.close();
			ps.close();

			courseDB = null;

		}
		catch(Exception e){
			logger.fatal("ApprovalDeleteTest - " + e.toString());
		}

		return 0;

	}

	public static int approvalDeleteTest(Connection conn,String campus,String user,String alpha,String num,int route) throws Exception {

		Logger logger = Logger.getLogger("test");

		// get all approvers for the route to use
		Approver ap = com.ase.aseutil.ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);

		// split approvers into array of users to approve
		String[] users = ap.getAllApprovers().split(",");

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		boolean approval = true;

		try{

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
			logger.fatal("ApprovalDeleteTest - " + e.toString());
		}

		return 0;

	}

}