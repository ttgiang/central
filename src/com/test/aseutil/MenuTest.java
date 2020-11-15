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

import java.sql.*;
import java.io.*;

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class MenuTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testMain() {

		Connection conn = null;

		boolean test = true;

		logger.info("========================== CronTest.testCronTest.START");

		String campus = getCampus();
		String user = getUser();
		String alpha = getAlpha();
		String num = getNum();
		String type = getType();

		try{
			conn = getConnection();

			if (conn != null){

				FileWriter fstream = new FileWriter(AseUtil.getCurrentDrive()
													+ ":"
													+ SysDB.getSys(conn,"documents")
													+ "outlines\\"
													+ campus
													+ "\\"
													+ "test"
													+ ".txt");
				BufferedWriter output = new BufferedWriter(fstream);
				output.write(AseUtil.getCurrentDateTimeString() + "\n");
				output.write("Campus: " + campus + "\n");
				output.write("User: " + user + "\n");
				output.write("alpha: " + alpha + "\n");
				output.write("num: " + num + "\n");

				output.write("\n");
				output.write("Home" + "\n");
				output.write("=======================" + "\n");

				// home
				output.write("\tNews: " + NewsDB.listNews(conn,campus) + "\n");
				output.write("\tTask Count: " + TaskDB.countUserTasks(conn,campus,user) + "\n");

				// my tasks
				output.write("\n");
				output.write("My Task" + "\n");
				output.write("=======================" + "\n");
				output.write("\tTasks: " + TaskDB.showUserTasksJQ(conn,campus,user) + "\n");

				// reports
				output.write("\n");
				output.write("Reports" + "\n");
				output.write("=======================" + "\n");
				output.write("\tApproval Status: " + ApproverDB.showApprovalProgress(conn,campus,user,0) + "\n");
				output.write("\tReview Status: " + ReviewDB.showReviews(conn,campus,user,0) + "\n");
				output.write("\tApprover Sequence 1: " + ApproverDB.showRejectedApprovalSelection(conn,campus) + "\n");
				output.write("\tApprover Sequence 2: " + ApproverDB.showApprovers(conn,campus,0,"","","") + "\n");
				output.write("\tApprover Sequence 3: " + ApproverDB.getRoutingInUse(conn,campus,0) + "\n");

				output.close();

				output = null;
				fstream = null;

			} // conn != null
		}
		catch(Exception e){
			test = false;
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("MenuTest: testMain - " + e.toString());
			}

			releaseConnection();
		}

		assertTrue(test);

		logger.info("========================== CronTest.testCronTest.END");

	}

}
