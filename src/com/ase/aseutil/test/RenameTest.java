/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.test;

import com.test.aseutil.*;

import com.ase.aseutil.*;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import junit.framework.TestCase;
import junit.framework.TestSuite;

public class RenameTest extends AseTestCase  {

	static Logger logger = Logger.getLogger(RenameTest.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 RenameTest(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  RenameTest(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		boolean success = false;

		try{
			if (getConnection() != null){

				logger.info("\tRenameTest started...");

				RenameTest(getConnection(),getCampus(),getKix(),getUser());

				success = true;

				logger.info("\tRenameTest ended...");

			}
		}
		catch( SQLException e ){
			logger.fatal("RenameTest: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("RenameTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static int RenameTest(Connection conn,String campus,String kix,String user) throws Exception {

		int processed = 0;

		try{

			// select users for rename approval
			String[] info = Helper.getKixInfo(conn,kix);
			String fromAlpha = info[Constant.KIX_ALPHA];
			String fromNum = info[Constant.KIX_NUM];

			String toAlpha = "TTG";
			String toNum = fromNum;

			String justification = "justification for rename";

			// create working copy
			RenameDB renameDB = new RenameDB();
			String proposer = CourseDB.getCourseProposer(conn,kix);
			renameDB.insert(conn,new Rename(campus,kix,proposer,fromAlpha,fromNum,toAlpha,toNum,justification));

			// set approvers name
			String formSelect = "THANHG,THANHG01,THANHG02,THANHG";
			boolean setReviewers = renameDB.setApprovers(conn,campus,user,kix,formSelect);

			// do approval
			String[] a = RenameDB.getApprovers(conn,kix).split(",");
			for(int i = 0; i < a.length; i++){
				String approved = "1";
				String comments = "commenting by " + a[i] + " at " + AseUtil.getCurrentDateTimeString();
				renameDB.processApproval(conn,campus,a[i],kix,approved,comments);
			} // for

			renameDB = null;

		}
		catch(Exception e){
			logger.fatal("RenameTest - " + e.toString());
		}

		return processed;

	}

}