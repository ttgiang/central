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
public class MiscDBTest extends AseTestCase {

	/**
	 * Test method for {@link com.test.aseutil.MiscDBTest#MiscDBTest()}.
	 */
	@Test
	public final void MiscDBTest() {

		boolean success = false;

		logger.info("========================== MiscDBTest.MiscDBTest.START");

		try{
			String user = "SYSADM";
			String kix = "";
			String val = "";
			String descr = "";

			MiscDB.getMisc(getConnection(),user);
			MiscDB.getReviewMisc(getConnection(),kix);
			MiscDB.deleteMisc(getConnection(),kix);
			MiscDB.deleteReviewMisc(getConnection(),kix);
			MiscDB.deleteStickyMisc(getConnection(),kix);
			MiscDB.deleteStickyMisc(getConnection(),kix,user);
			MiscDB.insertSitckyNotes(getConnection(),kix,user,val);
			MiscDB.getStickyNotes(getConnection(),kix,user);
			MiscDB.getMiscByHistoryUserID(getConnection(),getCampus(),kix,user);
			MiscDB.getEdit1(getConnection(),kix);
			MiscDB.getEdit2(getConnection(),kix);
			MiscDB.getEnabledItems(getConnection(),kix,1);
			MiscDB.getEnabledItemsCSV(getConnection(),kix,2);
			MiscDB.getCourseEditFromMiscEdit(getConnection(),getCampus(),kix,1);
			MiscDB.getCourseEditFlags(getConnection(),getCampus(),kix,1);
			MiscDB.getProgramEdit1(getConnection(),kix);
			MiscDB.getProgramEdit2(getConnection(),kix);
			MiscDB.getProgramEnabledItems(getConnection(),kix);
			MiscDB.getProgramEditFromMiscEdit(getConnection(),getCampus(),kix,1);
			MiscDB.getMiscNote(getConnection(),kix,descr);
			MiscDB.deleteMiscNote(getConnection(),kix,descr);
			MiscDB.getColumn(getConnection(),kix,"edited");

		}
		catch(Exception e){
			success = false;
		}

		assertTrue(success);

		logger.info("========================== MiscDBTest.MiscDBTest.END");

	}

}
