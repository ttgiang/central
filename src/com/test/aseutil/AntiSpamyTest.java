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

/**
 * @author tgiang
 *
 */
public class AntiSpamyTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.AntiSpamy#spamy(java.lang.String)}.
	 */
	@Test
	public final void testSpamy() {

		boolean spamy = false;

		try{

			com.ase.aseutil.AntiSpamy as = new com.ase.aseutil.AntiSpamy();

			String data = as.spamy("This is a test");
			String explain = as.spamy(data);
			spamy = true;

			as = null;
		}
		catch(Exception e){
			//
		}

		assertTrue(spamy);
	}

}
