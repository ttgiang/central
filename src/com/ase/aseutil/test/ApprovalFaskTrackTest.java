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

public class ApprovalFaskTrackTest extends AseTestCase {

	static Logger logger = Logger.getLogger(ApprovalFaskTrackTest.class.getName());

	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 approvalFaskTrackTest(getCampus());

	 }

	 public final void approvalFaskTrackTest(String campus){

		boolean success = false;

		int rowsAffected = 0;

		try{
			if (getConnection() != null){

				logger.info("\tApprovalFaskTrackTest started...");

				if (getCampus() == null || getCampus().length() == 0){

					String campuses = CampusDB.getCampusNames(getConnection());
					String[] aCampuses = campuses.split(",");
					for (int i = 0; i < aCampuses.length; i++){
						approvalFaskTrackTest(getConnection(),aCampuses[i]);
					}

				}
				else{
					approvalFaskTrackTest(getConnection(),getCampus());
				}

				success = true;

				logger.info("\tApprovalFaskTrackTest ended...");

			}
		}
		catch( SQLException e ){
			logger.fatal("ApprovalFaskTrackTest: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("ApprovalFaskTrackTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static int approvalFaskTrackTest(Connection conn,String campus) throws Exception {

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		try{

			// clear any pending data
			JobsDB.deleteJob("ApprovalTest");

			// insert data to work with
			String sql = "INSERT INTO tblJobs(job,subjob,historyid,campus,alpha,num,type,auditby,auditdate,proposer,route) "
				+ "SELECT 'ApprovalTest','ApprovalFaskTrackTest',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate(),proposer,route "
				+ "FROM vw_ApprovalStatus "
				+ "WHERE campus=? AND progress='APPROVAL'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			int rowsAffected = ps.executeUpdate();
			ps.close();

			int i = 0;

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
					if (route > 0){
						logger.info(i + ": " + proposer + " - " + alpha + " - " + num + " - " + route);

						int maxSeq = ApproverDB.getMaxApproverSeq(conn,campus,route);

						Outlines.deleteTempOutline(conn,kix);

						com.ase.aseutil.ApproverDB.fastTrackApprovers(conn,campus,kix,maxSeq,0,route,proposer);
					}
				}
				catch(Exception e){
					logger.fatal("ApprovalFaskTrackTest " + e.toString());
				}

				JobsDB.deleteJobByKix(conn,kix);

				++i;

			} // while
			rs.close();
			ps.close();
		}
		catch(Exception e){
			logger.fatal("ApprovalFaskTrackTest - " + e.toString());
		}

		return 0;

	}

}