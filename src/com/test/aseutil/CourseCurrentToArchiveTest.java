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
public class CourseCurrentToArchiveTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCurrentToArchiveTest#testCourseCurrentToArchive()}.
	 */
	@Test
	public final void testCourseCurrentToArchive() {

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

				String sql = "SELECT historyid,CourseAlpha,CourseNum FROM tblCourse "
					+ "WHERE campus=? AND CourseType='CUR' AND CourseType<>'PRE' "
					+ "ORDER BY CourseAlpha, CourseNum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next() && success == true && counter < 20){
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));

					if (!CourseDB.isMatchARC(conn,kix)){

						String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
						String num = AseUtil.nullToBlank(rs.getString("coursenum"));

						Msg msg = CourseCurrentToArchive.moveCurrentToArchivedX(conn,campus,alpha,num,user);
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
