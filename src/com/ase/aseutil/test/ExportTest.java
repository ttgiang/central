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

public class ExportTest extends AseTestCase {

	static Logger logger = Logger.getLogger(ExportTest.class.getName());

	/*
	 * export
	 *	<p>
	 * @return	Msg
	 *	<p>
	 */

	/**
	 * Test method for {@link com.test.aseutil.ApprovalDeleteTest#testMe()}.
	 */
	 public final void testMe(){

		 ExportTest(getConnection(),getCampus());

	 }

	 public static void ExportTest(Connection conn,String campus){

		boolean success = false;

		int rowsAffected = 0;

		try{
			if (conn != null){

				logger.info("\tExportTest started...");

				String message = "";

				String rpt = Constant.COURSE_COREQ + "," +
								Constant.COURSE_OBJECTIVES + "," +
								Constant.COURSE_PREREQ + "," +
								Constant.COURSE_COMPETENCIES + "," +
								Constant.COURSE_CONTENT + "," +
								Constant.COURSE_CROSSLISTED + "," +
								Constant.COURSE_PROGRAM_SLO + "," +
								Constant.COURSE_TEXTMATERIAL + "," +
								Constant.COURSE_RECPREP + "," +
								Constant.COURSE_GESLO + "," +
								Constant.COURSE_INSTITUTION_LO;

				String[] rpts = rpt.split(",");

				com.ase.aseutil.export.ExportCSV csv = new com.ase.aseutil.export.ExportCSV();

				for(int j = 0; j < rpts.length; j++){

					if (campus == null || campus.length() == 0){
						String campuses = CampusDB.getCampusNames(conn);
						String[] aCampuses = campuses.split(",");
						for (int i = 0; i < aCampuses.length; i++){
							message = csv.ExportCSV(conn,rpts[j],aCampuses[i],"ASE");
						}
					}
					else{
						message = csv.ExportCSV(conn,rpts[j],campus,"ASE");
					}

				} // for

				success = true;

				logger.info("\tExportTest ended...");

			}
		}
		catch( Exception e ){
			logger.fatal("ExportTest: approval - " + e.toString());
		}

		assertTrue(success);

	}

}