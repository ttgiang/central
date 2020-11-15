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

public class ModifyApprovedPrograms extends AseTestCase  {

	static Logger logger = Logger.getLogger(ModifyApprovedPrograms.class.getName());

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 ModifyApprovedPrograms(getCampus());

	 }
	/*
	 * approval
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */
	 public final void  ModifyApprovedPrograms(String campus){

		Logger logger = Logger.getLogger("test");

		boolean success = true;

		try{
			if (getConnection() != null){

				logger.info("\tModifyApprovedPrograms started...");

				success = ModifyApprovedPrograms(getConnection());

				logger.info("\tModifyApprovedPrograms ended...");

			}
		}
		catch( SQLException e ){
			logger.fatal("ModifyApprovedPrograms: approval - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("ModifyApprovedPrograms: approval - " + e.toString());
		}

		assertTrue(success);

	}

	public static boolean ModifyApprovedPrograms(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		boolean success = true;

		try{
			String sql = "SELECT campus, historyid, type, degreeid, divisionid, title "
					+ "FROM tblPrograms WHERE (campus <> 'TTG') AND (type = 'CUR')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next() && success){
				String campus = rs.getString("campus");
				String kix = rs.getString("historyid");
				String user = "SYSADM";
				String reason = "CC Testing";

				Msg msg = ProgramModify.modifyProgram(conn,campus,kix,user,Constant.PROGRAM_MODIFY_PROGRESS,reason);

				// not editable is not failure. it's safety check
				if (!msg.getMsg().equals("NotEditable")){
					if (msg.getMsg().equals("Exception")){
						success = false;
					}
					else if (!msg.getMsg().equals(Constant.BLANK)){
						success = false;
					}
				}

			}
			rs.close();
			ps.close();

		}
		catch(Exception e){
			logger.fatal("ModifyApprovedPrograms - " + e.toString());
		}

		return success;

	}

}