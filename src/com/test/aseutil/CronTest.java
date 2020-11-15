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
public class CronTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testCronTest() {

		boolean completed = true;

		logger.info("========================== CronTest.testCronTest.START");

		try{
			if (getConnection() != null){

				gotConnection();

				showParms();

				Cron.cleanCampusOutlinesTable(getConnection());

				Cron.notYourTurn(getConnection());

				Cron.clearReviewers(getConnection(),null);

				TaskDB.correctProposerName(getConnection());

			} // conn != null
		}
		catch(Exception e){
			completed = false;
		}
		finally{
			releaseConnection();
		}

		assertTrue(completed);

		logger.info("========================== CronTest.testCronTest.END");

	}

}
