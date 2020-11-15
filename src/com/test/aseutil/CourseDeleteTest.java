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
public class CourseDeleteTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseDeleteTest#testCourseDelete()}.
	 */
	@Test
	public final void testCourseDelete() {

		boolean deleted = false;

		try{
			if (getConnection() != null){

				if (CourseDB.courseExistByTypeCampus(getConnection(),getCampus(),getAlpha(),getNum(),"PRE")){

					int rowsAffected = com.ase.aseutil.util.CCUtil.deleteFromAllTables(getUser(),
																					getCampus(),
																					getAlpha(),
																					getNum(),
																					"PRE");
				}
			}

			deleted = true;

		}
		catch(Exception e){
			deleted = false;
		}

		assertTrue(deleted);

	}

	/**
	 * Test method for {@link com.ase.aseutil.CourseDeleteTest#testCourseDeleteAll()}.
	 */
	@Test
	public final void testCourseDeleteAll() {

		assertTrue(runMe(getConnection(),getCampus(),getUser()));

	}

	public static boolean runMe(Connection conn,String campus,String user) {

		boolean deleted = false;

		// take all create courses and rename to alpha TTG

		try{
			if (conn != null){

				String sql = "select coursealpha,coursenum from tbltasks where campus=? and submittedfor=? and (progress='MODIFY' OR progress='NEW') and (historyid is null OR historyid='')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						int rowsAffected = com.ase.aseutil.util.CCUtil.deleteFromAllTables(user,campus,alpha,num,"PRE");
					}

				}
				rs.close();
				ps.close();

				deleted = true;
			}
		}
		catch(Exception e){
			deleted = false;
		}

		return deleted;

	}

}
