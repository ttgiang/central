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
import java.sql.*;

/**
 * @author tgiang
 *
 */
public class KixCreate extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testKixCreate() {

		boolean test = true;

		logger.info("========================== KixCreate.testKixCreate.START");

		int rowsAffected = 0;
		int inserted = 0;
		int idx = 0;
		String historyid = "";

		Connection conn = null;

		try{

			conn = getConnection();

			if (conn != null){
				String sql = "SELECT idx FROM tblCourseKAU WHERE id = ''";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					historyid = createHistoryID(conn,1);

					idx = rs.getInt("idx");

					sql = "UPDATE tblCourseKAU SET id=?,historyid=? WHERE idx=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,historyid);
					ps.setString(2,historyid);
					ps.setInt(3,idx);
					ps.executeUpdate();
					++rowsAffected;

					logger.info("KixCreate.testKixCreate - " + rowsAffected);
				}
				rs.close();
				ps.close();

				// fill up the table of outlines with preset KIX
				Tables.campusOutlines();
			}
		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}
		finally{
			releaseConnection();
		}

		assertTrue(test);

		logger.info("========================== KixCreate.testKixCreate.END");

	}

	/*
	 * isMatch
	 * <p>
	 */
	public boolean isMatch(Connection conn,String kix) throws SQLException {

		String sql = "SELECT historyid FROM tblCourseKAU WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();

		return exists;
	}

	/*
	 * createHistoryID
	 * <p>
	 * @param	type	int
	 * <p>
	 * @return String
	 */
	public synchronized String createHistoryID(Connection conn,int type) throws Exception {

		/*
			effort to create id without a duplicate. Duplicates happen when requests
			come through so quick that the timer doesn't change fast enough.

			if a connection was not available, we'll create one the old fashion way.
		*/

		boolean duplicate = false;

		String kix = "";

		try{
			kix = SQLUtil.createHistoryID(type,0);

			duplicate = isMatch(conn,kix);

			while(duplicate){
				kix = SQLUtil.createHistoryID(type,0);
				duplicate = isMatch(conn,kix);
			}
		}
		catch(Exception e){
			//logger.fatal("SQLUtil - createHistoryID: " + e.toString());
		} finally {
			//connectionPool.freeConnection(conn,"SQLUtil","");
		}

		return kix;
	}

}
