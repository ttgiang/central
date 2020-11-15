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

public class CCCM6100DBTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.CCCM6100DBTest#testMe()}.
	 */
	@Test
	public final void testMe() {

		assertTrue(runTest(getConnection(),getCampus()));
	}

	public static boolean runTest(Connection conn,String campus) {

		boolean success = false;

		try{
			if (conn != null){

				CCCM6100 ccm = new CCCM6100();

				boolean b = false;
				int i = 0;
				String s = "";

				ccm = CCCM6100DB.getCCCM6100(conn,1,campus,1);
				ccm = CCCM6100DB.getCCCM6100ByFriendlyName(conn,"X18");
				ccm = CCCM6100DB.getCCCM6100ByQuestionNumber(conn,1);
				ccm = CCCM6100DB.getCCCM6100ByID(conn,1);
				ccm = CCCM6100DB.getCCCM6100ByIDCampusCourse(conn,1,campus,"r");
				s = CCCM6100DB.getCCCM6100s(conn);
				i = CCCM6100DB.getCCCMQuestionNumber(conn,campus,"r","X18");
				s = CCCM6100DB.getExplainColumnValue(conn,"X18");
				s = CCCM6100DB.getQuestionTypeColumnValue(conn,"X18");
				s = CCCM6100DB.getSequenceFromQuestionNumbers(conn,campus,1,"1",true);
				s = CCCM6100DB.getCCCM6100ByColumn(conn,"X18");
				s = CCCM6100DB.CCCMInUse(conn,1);
				s = CCCM6100DB.getCCCMQuestionFriendly(conn,1);
				s = CCCM6100DB.displayCourseInUseByAlpha(conn,1,1);
				s = CCCM6100DB.displayCourseInUseByFriendly(conn,"ENG","100",1);
				b = CCCM6100DB.displayCommentsBox(conn,campus,"X18");
				List<CCCM6100> cm = CCCM6100DB.getQuestions(conn,campus,"vw_CourseItems","Y");
				s = CCCM6100DB.getCourseFriendlyNameFromSequence(conn,campus,1);
				s = CCCM6100DB.getCampusFriendlyNameFromSequence(conn,campus,1);
				s = CCCM6100DB.OutlineHelpText(conn);

				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}

}

