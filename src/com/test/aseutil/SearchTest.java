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

import java.sql.*;

import com.ase.aseutil.*;
import com.ase.aseutil.jobs.*;
import com.ase.aseutil.util.*;
import com.ase.aseutil.html.Html2Text;

/**
 * @author tgiang
 *
 */
public class SearchTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testSearch() {

		boolean test = true;

		logger.info("========================== SearchTest.testSearch.START");

		try{
			String campus = getCampus();

			String kix = getKix();

			SearchDB s = new SearchDB();

			s.createSearchData(new JobName(),campus,kix,null);
		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

		test = true;

		assertTrue(test);

		logger.info("========================== SearchTest.testSearch.END");

	}
}
