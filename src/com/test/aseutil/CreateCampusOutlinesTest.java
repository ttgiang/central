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

import com.ase.aseutil.Tables;

/**
 * @author tgiang
 *
 */
public class CreateCampusOutlinesTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCreateCampusOutlinesTest() {

		boolean test = true;

		logger.info("========================== CreateCampusOutlinesTest.testCreateCampusOutlinesTest.START");

		try{
			Tables.campusOutlines();
		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}
		finally{
			releaseConnection();
		}

		assertTrue(test);

		logger.info("========================== CreateCampusOutlinesTest.testCreateCampusOutlinesTest.END");

	}
}
