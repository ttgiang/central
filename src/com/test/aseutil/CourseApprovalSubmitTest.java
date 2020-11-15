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
/**
 * @author tgiang
 *
 */

public class CourseApprovalSubmitTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCourseApprovalSubmit() {

		boolean submitted = false;

		logger.info("========================== CourseApprovalSubmitTest.testCourseApprovalSubmit.START");

		try{
			if (getConnection() != null){

				gotConnection();

				showParms();

				String campus = getCampus();
				String user = getUser();
				String alpha = getAlpha();
				String num = getNum();
				String type = getType();

				String parm2 = getParm2();

				int route = IniDB.getIDByCampusCategoryKid(getConnection(),campus,"ApprovalRouting",parm2);

				if (route > 0){

					//start the approval request
					Msg msg = CourseDB.setCourseForApproval(getConnection(),campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);
					if ( "Exception".equals(msg.getMsg()) ){
						submitted = false;
					}
					else if (!(Constant.BLANK).equals(msg.getMsg())){
						submitted = false;
					}
					else{
						submitted = true;
					} // if msg CourseDB.setCourseForApproval

				}
				else{
					submitted = false;
				}


			} // conn != null
		}
		catch(Exception e){
			submitted = false;
		}

		assertTrue(submitted);

		logger.info("========================== CourseApprovalSubmitTest.testCourseApprovalSubmit.END");

	}



}
