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

public class CancelPrograms extends AseTestCase  {

	static Logger logger = Logger.getLogger(CancelPrograms.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 CancelPrograms(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  CancelPrograms(String campus){

		Logger logger = Logger.getLogger("test");

		boolean success = true;

		try{
			if (getConnection() != null){

				logger.info("\tCancelPrograms started...");

				success = CancelPrograms(getConnection());

				logger.info("\tCancelPrograms ended...");

			}
		}
		catch( SQLException e ){
			logger.fatal("CancelPrograms: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("CancelPrograms: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static boolean CancelPrograms(Connection conn) throws Exception {

		boolean success = true;

		try{
			String sql = "SELECT campus, historyid, proposer "
					+ "FROM tblPrograms WHERE (campus <> 'TTG') AND (type = 'PRE')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next() && success){

				String campus = rs.getString("campus");
				String kix = rs.getString("historyid");
				String user = rs.getString("proposer");

				Programs program = new Programs();
				program.setCampus(campus);
				program.setHistoryId(kix);
				program.setAuditBy(user);

				Msg msg = ProgramsDB.cancelProgram(conn,program);
				if (msg != null){
					if (msg.getMsg().equals("CancelFailure")){
						success = false;
					}
				}
			} // while
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("CancelPrograms - " + e.toString());
		}

		return success;

	}

}