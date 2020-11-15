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
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class UpdateCourseDataTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(UpdateCourseDataTest.class.getName());

	/**
	 * Test method for {@link com.ase.aseutil.UpdateCourseDataTest#testUpdateCourseDataTest()}.
	 */
	@Test
	public final void testUpdateCourseDataTest() {

		// runs through items on a persons' task list and update data
		// for all text fields by appending current date and time.

		assertTrue(runMe(getConnection(),getCampus(),getUser()));

	}

	public static boolean runMe(Connection conn,String campus,String user) {

		boolean success = false;

		// take all create courses and rename to alpha TTG

		try{
			if (conn != null){
				AseUtil aseUtil = new AseUtil();

				String alpha = "";
				String num = "";
				String kix = "";
				String data = "";

				ResultSetMetaData	metaData = null;
				PreparedStatement ps2 = null;
				ResultSet rs2 = null;

				com.ase.aseutil.AntiSpamy as = new com.ase.aseutil.AntiSpamy();

				int i = 0;

				//---------------------------------------------------
				// course data
				//---------------------------------------------------

				// these are columns of data for the specified campus
				String courseItems = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
				String[] aCourseItems = courseItems.split(",");

				// get tasks for the current user
				String sql = "select coursealpha,coursenum from tbltasks where campus=? and submittedfor=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));
					kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					// with the data needed, bring in the outline and update every column for the outline
					sql = "SELECT " + courseItems + " FROM tblCourse WHERE historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					rs2 = ps2.executeQuery();
					if (rs2.next()) {

						metaData = rs2.getMetaData();

						for(i = 0; i < aCourseItems.length; i++){
							if (metaData.getColumnTypeName(i+1).equals("text")){
								data = AseUtil.getCurrentDateTimeString()
												+ Html.BR()
												+ AseUtil.nullToBlank(rs2.getString(aCourseItems[i]))
												+ Html.BR();

								data = as.spamy(data);

								CourseDB.updateCourseItem(conn,aCourseItems[i],data,kix);
							}
						} // for
					} // if
					rs2.close();
					ps2.close();

				} // if rs
				rs.close();
				ps.close();

				//---------------------------------------------------
				// campus data
				//---------------------------------------------------
				// these are columns of data for the specified campus
				courseItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
				aCourseItems = courseItems.split(",");

				// get tasks for the current user
				sql = "select coursealpha,coursenum from tbltasks where campus=? and submittedfor=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				rs = ps.executeQuery();
				while(rs.next()){

					alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					num = AseUtil.nullToBlank(rs.getString("coursenum"));
					kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					// with the data needed, bring in the outline and update every column for the outline
					sql = "SELECT " + courseItems + " FROM tblcampusdata WHERE historyid=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setString(1,kix);
					rs2 = ps2.executeQuery();
					if (rs2.next()) {

						metaData = rs2.getMetaData();

						for(i = 0; i < aCourseItems.length; i++){
							if (metaData.getColumnTypeName(i+1).equals("text")){
								data = AseUtil.getCurrentDateTimeString()
												+ Html.BR()
												+ AseUtil.nullToBlank(rs2.getString(aCourseItems[i]))
												+ Html.BR();

								data = as.spamy(data);

								CourseDB.updateCampusItem(conn,aCourseItems[i],data,kix);
							}
						} // for
					} // if
					rs2.close();
					ps2.close();

				} // if rs
				rs.close();
				ps.close();

				aseUtil = null;

				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}
