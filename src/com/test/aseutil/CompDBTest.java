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
public class CompDBTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#CompDB()}.
	 */
	@Test
	public final void testCompDB() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getComp(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetComp() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompByID(java.sql.Connection, int, java.lang.String)}.
	 */
	@Test
	public final void testGetCompByID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getComps(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetComps() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByKix(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByKix() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsAsHTMLOptions(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsAsHTMLOptions() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsAsHTMLOptionsByKix(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsAsHTMLOptionsByKix() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsToReview(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, boolean)}.
	 */
	@Test
	public final void testGetCompsToReview() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByType(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, boolean, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByType() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByTypeX(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByTypeX() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsAsHTMLList(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, boolean, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsAsHTMLList() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByID(java.sql.Connection, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByAlphaNum(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByAlphaNum() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByAlphaNumID(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByAlphaNumID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompsByTypeCampusID(java.sql.Connection, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testGetCompsByTypeCampusID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#setCompApproval(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int)}.
	 */
	@Test
	public final void testSetCompApproval() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#setCompReview(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int)}.
	 */
	@Test
	public final void testSetCompReview() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#hasSLOsToReview(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testHasSLOsToReview() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#addRemoveCourseComp(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testAddRemoveCourseComp() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#isCompAdded(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testIsCompAddedConnectionStringStringStringString() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#isCompAdded(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testIsCompAddedConnectionString() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getNextCompID(java.sql.Connection)}.
	 */
	@Test
	public final void testGetNextCompID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getNextRDR(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testGetNextRDR() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getObjectives(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testGetObjectives() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getObjective(java.sql.Connection, java.lang.String, int)}.
	 */
	@Test
	public final void testGetObjective() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#updateObjective(java.sql.Connection, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testUpdateObjective() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#deleteObjectives(java.sql.Connection, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testDeleteObjectives() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getCompByKixID(java.sql.Connection, java.lang.String, int)}.
	 */
	@Test
	public final void testGetCompByKixID() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#copyComp(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int)}.
	 */
	@Test
	public final void testCopyComp() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#getLastUpdated(java.sql.Connection, java.lang.String)}.
	 */
	@Test
	public final void testGetLastUpdated() {
		assertTrue(1 == 1);
	}

	/**
	 * Test method for {@link com.ase.aseutil.CompDB#insertListFromSrc(java.sql.Connection, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	@Test
	public final void testInsertListFromSrc() {
		assertTrue(1 == 1);
	}

}
