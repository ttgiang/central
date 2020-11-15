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
public class AlphaDBTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.AlphaDBTest#testAlphaDB()}.
	 */
	@Test
	public final void testAlphaDB() {

		boolean success = false;

		try{
			if (getConnection() != null){

				int rowsAffected = AlphaDB.deleteAlpha(getConnection(),getAlpha());
				if (rowsAffected >= 0){
					success = true;
					logger.info("AlphaDBTest.testAlphaDB: deleted");
				}
				else{
					logger.info("AlphaDBTest.testAlphaDB: nothing deleted");
				}

				rowsAffected = AlphaDB.insertAlpha(getConnection(),new Alpha(getAlpha(),"This is a test alpha"));
				if (rowsAffected > 0){
					success = true;
					logger.info("AlphaDBTest.testAlphaDB: inserted");
				}
				else{
					logger.info("AlphaDBTest.testAlphaDB: not inserted");
				}

				success = true;

			} // conn != null
		}
		catch(Exception e){
			success = false;
		}

		assertTrue(success);

	}

}
