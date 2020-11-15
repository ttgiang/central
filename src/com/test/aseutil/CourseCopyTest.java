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
public class CourseCopyTest extends AseTestCase  {

	public CourseCopyTest() {
		super();
	}

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCourseCopy() {

		boolean copy = false;

		logger.info("========================== CourseCopyTest.testCourseCopy.START");

		String toNum = getParm1();

		try{

			if (getConnection() != null){

				String campus = getCampus();
				String user = getUser();
				String alpha = getAlpha();
				String num = getNum();
				String type = getType();

				String kix = Helper.getKix(getConnection(),campus,alpha,num,type);

				Msg msg = CourseCopy.copyOutline(getConnection(),
																campus,
																kix,
																kix,
																alpha,
																toNum,
																user,
																"comments");
				if (msg != null){
					if(msg.getMsg().equals("Exception")){
						copy = false;
					}
					else{
						logger.info("kix: " + getKix());
						copy = true;
					} // exception
				}
				else{
					copy = false;
				} // msg != null
			} // conn != null
		}
		catch(Exception e){
			copy = false;
		}

		assertTrue(copy);

		logger.info("========================== CourseCopyTest.testCourseCopy.END");

	}

}
