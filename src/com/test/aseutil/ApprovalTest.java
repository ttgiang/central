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
public class ApprovalTest extends AseTestCase {

	/**
	 * Test method for {@link com.test.aseutil.ApprovalTest#approvalTest()}.
	 */
	@Test
	public final void approvalTest() {

		boolean success = false;

		logger.info("========================== ApprovalTest.approvalTest.START");

		try{
			showParms();

			//com.ase.aseutil.test.ApprovalTest.approvalTest(getCampus());
			//com.ase.aseutil.test.ApprovalInProgressTest.approvalTest(getCampus());
			//com.ase.aseutil.test.ApprovalFaskTrackTest.approvalTest(getCampus());
			//com.ase.aseutil.test.ApprovalReviseTest.approvalTest(getCampus());
			//com.ase.aseutil.test.ApprovalDeleteTest.testApprovalDeleteTest(getCampus());
			//com.ase.aseutil.test.ApprovalModifyTest.approvalTest(getCampus());
		}
		catch(Exception e){
			success = false;
		}

		assertTrue(success);

		logger.info("========================== ApprovalTest.approvalTest.END");

	}

}
