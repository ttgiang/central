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
public class CourseCancelTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancelTest#testCourseCancel()}.
	 */
	@Test
	public final void testCourseCancel() {

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

		try{
			if (conn != null){

				String sql = "select coursealpha,coursenum from tbltasks where campus=? and submittedfor=? "
							+ "and progress='MODIFY' and (historyid is null OR historyid='')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next() && success){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));

					Msg msg = CourseCancel.cancelOutlineX(conn,
																		campus,
																		alpha,
																		num,
																		user);

					if ("Exception".equals(msg.getMsg())){
						success = false;
					}
					else if (!"".equals(msg.getMsg())){
						success = false;
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
