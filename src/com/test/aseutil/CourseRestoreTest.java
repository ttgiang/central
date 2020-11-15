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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ase.aseutil.*;
/**
 * @author tgiang
 *
 */
public class CourseRestoreTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseRestoreTest#testRestoreOutline()}.
	 */
	@Test
	public final void testRestoreOutline() {

		boolean canceled = false;

		try{
			if (getConnection() != null){
				canceled = runMe(getConnection(),getCampus(),getUser());
			}
		}
		catch(Exception e){
			canceled = false;
		}

		assertTrue(canceled);

	}

	public static boolean runMe(Connection conn,String campus,String user) {

		boolean success = true;

		int counter = 0;

		try{
			if (conn != null){

				String sql = "SELECT historyid,CourseAlpha,CourseNum FROM tblCourseARC WHERE campus=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next() && success == true && counter < 20){
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));

					if (CourseDB.isCourseRestorable(conn,kix,user)){
						Msg msg = CourseRestore.restoreOutline(conn,kix,user,"ARC");
						if ( "Exception".equals(msg.getMsg()) ){
							success = false;
						}
						else if ( !"".equals(msg.getMsg()) ){
							success = false;
						}

						++counter;
					}

				}
				rs.close();
				ps.close();

			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}
}
