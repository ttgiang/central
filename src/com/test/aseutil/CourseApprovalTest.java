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

public class CourseApprovalTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCourseApproval() {

		boolean approved = false;
		boolean approval = false;

		logger.info("========================== CourseApprovalTest.testCourseApproval.START");

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
				String parm3 = getParm3();

				if (parm3.equals(Constant.ON))
					approval = true;
				else
					approval = false;

				int route = IniDB.getIDByCampusCategoryKid(getConnection(),campus,"ApprovalRouting",parm2);

				if (route > 0){
					Msg msg = CourseDB.approveOutline(getConnection(),campus,alpha,num,user,approval,"AseTestCase.testCourseApproval",12,22,66);
					if ( "Exception".equals(msg.getMsg()) ){
						approved = false;
					}
					else if (!"".equals(msg.getMsg())){
						approved = false;
					} // CourseDB.approveOutline
					else{
						approved = true;
					}
				}
				else{
					approved = false;
				}

			} // conn != null
		}
		catch(Exception e){
			approved = false;
		}

		assertTrue(approved);

		logger.info("========================== CourseApprovalTest.testCourseApproval.END");

	}

}
