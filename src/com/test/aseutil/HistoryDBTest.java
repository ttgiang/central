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
public class HistoryDBTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.HistoryDBTest#testMe()}.
	 */
	@Test
	public final void testHasHistory() {

		assertTrue(runHasHistory(getConnection(),getCampus()));
	}

	public static boolean runHasHistory(Connection conn,String campus) {

		boolean success = false;

		// select distinct historyid to test with

		try{
			if (conn != null){

				String sql = "SELECT DISTINCT historyid FROM tblApprovalHist WHERE campus=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					success = HistoryDB.hasHistory(conn,campus,AseUtil.nullToBlank(rs.getString("historyid")));
				}
				rs.close();
				ps.close();

				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}
