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
public class CourseCreateTest extends AseTestCase  {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCreate#CourseCreate()}.
	 */
	@Test
	public final void testCourseCreate() {

		boolean created = false;

		try{
			if (getConnection() != null){
				created = CourseCreate.createOutline(getConnection(),
																	getAlpha(),
																	getNum(),
																	"TEST",
																	"TEST",
																	getUser(),
																	getCampus(),
																	Constant.BLANK,
																	Constant.BLANK,
																	Constant.BLANK);

			}
		}
		catch(Exception e){
			created = false;
			logger.info(e.toString());
		}

		assertTrue(created);

	}

}
