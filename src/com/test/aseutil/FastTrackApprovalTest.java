/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

package com.test.aseutil;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import com.ase.aseutil.*;

import java.io.*;

import java.sql.*;

import org.htmlcleaner.*;


/**
 * @author tgiang
 *
 */
public class FastTrackApprovalTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testMain() {

		boolean test = true;

		logger.info("========================== FastTrackApprovalTest.testMain.START");

		try{

			// collect all outlines from a specified campus and run them through fast track.
			// the routing and the sequence (6) in use may not be correct but we'll run for as many
			// as we can. For some routing, there may be few sequences than 6.

			if (getConnection() != null){

				String progress = "";
				String kix = "";
				String temp = "";
				String fastTrack = "";
				String sql = "";

				int route = 0;

				String select = " Progress,route,id ";

				boolean testing = false;

				sql = "SELECT "
						+ select
						+ " FROM vw_ApprovalStatus "
						+ "WHERE campus=? ";

				// connect pending outlines
				sql += " UNION "
					+ "SELECT Progress, 0 as [route],id "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND CourseType='PRE' "
					+ "AND CourseAlpha<>'' "
					+ "AND progress='PENDING'";

				sql = "SELECT "
					+ select
					+ " FROM ("
					+ sql
					+ ") AS selectedTables ";

				PreparedStatement ps = getConnection().prepareStatement(sql);
				ps.setString(1,getCampus());
				ps.setString(2,getCampus());
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					progress = AseUtil.nullToBlank(rs.getString("progress"));
					route = rs.getInt("route");
					kix = AseUtil.nullToBlank(rs.getString("id"));

					if(progress.equals(Constant.COURSE_APPROVAL_TEXT)){
						logger.info(ApproverDB.fastTrackApprovers(getConnection(),getCampus(),kix,6,0,route,getUser()));
					}

				} // while

				rs.close();
				ps.close();
			} // conn != null
		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}

		test = true;

		assertTrue(test);

		logger.info("========================== FastTrackApprovalTest.testMain.END");

	}

}
