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

public class ExportXMLTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.ExportXMLTest#testMe()}.
	 */
	@Test
	public final void testMe() {

		assertTrue(runTest(getConnection()));
	}

	public static boolean runTest(Connection conn) {

		boolean success = false;

		try{
			if (conn != null){

				try{
					String sql = "SELECT campus,historyid FROM tblcourse WHERE progress='APPROVED'";
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					while(rs.next()){
						String campus = AseUtil.nullToBlank(rs.getString("campus"));
						String kix = AseUtil.nullToBlank(rs.getString("historyid"));
						com.ase.aseutil.export.ExportXML.process(conn,campus,kix);
					}
					rs.close();
					ps.close();
				} catch (SQLException e) {
					logger.fatal("ExportXMLTest: runTest - " + e.toString());
				} catch (Exception e) {
					logger.fatal("ExportXMLTest: runTest - " + e.toString());
				}

				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}

