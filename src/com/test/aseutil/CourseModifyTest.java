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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * @author tgiang
 *
 */
public class CourseModifyTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseModifyTest#testCourseModify()}.
	 */
	@Test
	public final void testCourseModify() {

		boolean modified = false;

		logger.info("--> CourseModifyTest.testCourseModify.START");

		try{
			if (getConnection() != null){
				modified = runMe(getConnection(),getCampus(),getUser());
			}
		}
		catch(Exception e){
			modified = false;
		}

		assertTrue(modified);

		logger.info("--> CourseModifyTest.testCourseModify.END");

	}

	public static boolean runMe(Connection conn,String campus,String user) {

		boolean modified = false;

		try{

			// test course modification on 10 outlines

			if (conn != null){

				int counter = 0;

				String sql = "SELECT CourseAlpha, CourseNum "
					+ "FROM tblCourse "
					+ "GROUP BY campus, CourseAlpha, CourseNum "
					+ "HAVING campus=? AND (COUNT(id) = 1) AND (CourseAlpha <> '') "
					+ "ORDER BY CourseAlpha, CourseNum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next() && counter < 10){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));

					// set the user department to the current alpha or else CC won't permit modification
					int rowsAffected = UserDB.setUserDepartment(conn,user,alpha);
					if (rowsAffected >= 0){
						Msg msg = CourseModify.modifyOutline(conn,
																			campus,
																			alpha,
																			num,
																			user,
																			Constant.COURSE_MODIFY_TEXT);

						if ("Exception".equals(msg.getMsg())){
							modified = false;
						}
						else if (!"".equals(msg.getMsg())){
							modified = false;
						}
						else{
							modified = true;
						}
					}

					++counter;

				}
				rs.close();
				ps.close();
			}
		}
		catch(Exception e){
			modified = false;
		}

		return modified;

	}

}
