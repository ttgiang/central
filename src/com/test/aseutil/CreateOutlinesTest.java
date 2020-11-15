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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class CreateOutlinesTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CreateOutlinesTest#testCreateOutlines()}.
	 */
	@Test
	public final void testMe() {

		assertTrue(runMe(getConnection(),getCampus(),getUser()));

	}

	public static boolean runMe(Connection conn,String campus,String user) {

		// create outlines as HTML/PDFs

		boolean success = false;

		try{
			if (conn != null){

				// must clear out table data and recreate
				Tables.campusOutlines();

				Tables.createOutlines(campus,null,null,null,"frce","");

				success = true;
			}
		}
		catch(Exception e){
			success = false;
		}

		return success;

	}


}
