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

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class CourseReviewTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseReviewTest#testCreateOutlines()}.
	 */
	@Test
	public final void testCourseReviewTest() {

		//
		// 1) set up a group of reviewers just for kicks
		//
		assertTrue(setUpReviews(getConnection(),getCampus(),getUser()));

		//
		// 2) process reviews from above reviewers
		//
		assertTrue(addReviewerComments(getConnection(),getCampus()));

		//
		// 3) now run through and get all other reviews completed
		//
		assertTrue(addReviewerComments(getConnection()));

	}

	/**
	 * Test method for {@link com.ase.aseutil.CourseReviewTest#testGetReviewers()}.
	 */
	@Test
	public final void testGetReviewers() {

		assertTrue(!getReviewers(getConnection(),getCampus(),getUser()).equals(""));

	}

	/**
	 * Test method for {@link com.ase.aseutil.CourseReviewTest#addReviewerComments()}.
	 */
	@Test
	public final void testAddReviewerComments() {

		assertTrue(addReviewerComments(getConnection(),getCampus()));

	}

	public static boolean setUpReviews(Connection conn,String campus,String user) {

		//
		// send outlines to review
		//

		boolean success = false;

		try{
			if (conn != null){

				String sql = "select coursealpha,coursenum from tbltasks where campus=? and progress='MODIFY' and (historyid is null OR historyid='')";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

					if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						ReviewerDB.setCourseReviewers(conn,
																campus,
																alpha,
																num,
																user,
																getReviewers(conn,campus,user),
																"12/31/2020",
																"comments from proposers to reviewer",
																kix);
					}

				}
				rs.close();
				ps.close();

			}

			success = true;

		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

	public static String getReviewers(Connection conn,String campus,String user) {

		//
		// include 20 reviewers in the test
		//

		String reviewers = "";

		try{
			if (conn != null){

				reviewers = user;

				String sql = "select top 20 userid from tblusers where campus=? and status='Active'";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String userid = AseUtil.nullToBlank(rs.getString("userid"));
					reviewers = reviewers + "," + userid;
				}
				rs.close();
				ps.close();
			}
		}
		catch(Exception e){
			//
		}

		return reviewers;

	}

	public static boolean addReviewerComments(Connection conn,String campus) {

		//
		// create reviewer comments for outlines in review
		//

		boolean success = false;

		try{
			if (conn != null){
				String sql = "select coursealpha,coursenum,historyid,userid from tblreviewers where campus=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String userid = AseUtil.nullToBlank(rs.getString("userid"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));

					if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						Review reviewDB = new Review();
						reviewDB.setId(0);
						reviewDB.setUser(userid);
						reviewDB.setAlpha(alpha);
						reviewDB.setNum(num);
						reviewDB.setHistory(kix);
						reviewDB.setComments("Review comments");
						reviewDB.setItem(10);
						reviewDB.setCampus(campus);
						reviewDB.setEnable(true);
						reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());

						int rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",Constant.REVIEW);

						CourseDB.endReviewerTask(conn,campus,alpha,num,userid);
					}

				}
				rs.close();
				ps.close();
			}

			success = true;

		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

	public static boolean addReviewerComments(Connection conn) {

		//
		// create reviewer comments for outlines in review
		//

		boolean success = false;

		try{
			if (conn != null){
				String sql = "select campus,coursealpha,coursenum,historyid,userid from tblreviewers";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String userid = AseUtil.nullToBlank(rs.getString("userid"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));

					if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
						Review reviewDB = new Review();
						reviewDB.setId(0);
						reviewDB.setUser(userid);
						reviewDB.setAlpha(alpha);
						reviewDB.setNum(num);
						reviewDB.setHistory(kix);
						reviewDB.setComments("Review comments");
						reviewDB.setItem(10);
						reviewDB.setCampus(campus);
						reviewDB.setEnable(true);
						reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());

						int rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",Constant.REVIEW);

						CourseDB.endReviewerTask(conn,campus,alpha,num,userid);
					}

				}
				rs.close();
				ps.close();
			}

			success = true;

		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}
