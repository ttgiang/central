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
public class CourseRenameTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.CourseRenameTest#testCourseRename()}.
	 */
	@Test
	public final void testCourseRename() {

		assertTrue(runMe(getConnection(),getCampus(),getUser()));
	}

	public static boolean runMe(Connection conn,String campus,String user) {

		boolean success = false;

		// take all create courses and rename to alpha TTG

		try{
			if (conn != null){

				String sql = "select coursealpha,coursenum from tbltasks where campus=? and submittedfor=? and progress='MODIFY' and (historyid is null OR historyid='')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));

					String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					CourseRename.renameOutlineX(campus,alpha,num,"TTG",num,user,kix,"PRE","Testing");
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
