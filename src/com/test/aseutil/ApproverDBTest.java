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

import java.util.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class ApproverDBTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.ApproverDB#ApproverDB()}.
	 */
	@Test
	public final void testIsMatch() {

		boolean success = false;
		try{
			success = ApproverDB.isMatch(getConnection(),"1",getUser(),getCampus(),0);

			// if we got here, the test works even if no match found
			success = true;
		}
		catch(Exception e){
			//
		}

		assertTrue(success);
	}

	/**
	 * Test method for {@link com.ase.aseutil.ApproverDB#ApproverDB()}.
	 */
	@Test
	public final void testRoutingExists() {

		boolean success = false;
		try{
			success = ApproverDB.routingExists(getConnection(),getCampus(),0);

			// if we got here, the test works even if no match found
			success = true;
		}
		catch(Exception e){
			//
		}

		assertTrue(success);
	}

	/**
	 * Test method for {@link com.ase.aseutil.ApproverDB#ApproverDB()}.
	 */
	@Test
	public final void testApprovalRouting() {

		// runs through all outlines with a routing number and checks
		// for valid routing sequence and approver listing
		boolean success = false;

		try{
			if (getConnection() != null){

				String sql = "SELECT historyid,campus,courseAlpha,courseNum,proposer,route FROM tblcourse WHERE route > 0 "
					+ "ORDER BY campus,courseAlpha,CourseNum";
				PreparedStatement ps = getConnection().prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
					int route = NumericUtil.getInt(rs.getInt("route"),0);

					if (ApproverDB.routingExists(getConnection(),campus,route)){
						ApproverDB.getApprovers(getConnection(),campus,alpha,num,proposer,false,route,kix);
					}
				}
				rs.close();
				ps.close();

				success = true;
			}
		}
		catch(Exception e){
			//
		}

		assertTrue(success);

	}

}
