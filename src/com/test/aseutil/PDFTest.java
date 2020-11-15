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
import com.ase.aseutil.report.*;
import com.ase.itextpdf.*;

/**
 * @author tgiang
 *
 */
public class PDFTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCancel#CourseCancel()}.
	 */
	@Test
	public final void testMain() {

		boolean test = true;

		logger.info("========================== PDFTest.testMain.START");

		try{
			String campus = null;
			String kix = null;
			String alpha = null;
			String num = null;

			String[] info = null;

			kix = getKix();

			info = Helper.getKixInfo(getConnection(),kix);
			campus = info[Constant.KIX_CAMPUS];
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];

			//Tables.createOutlines(campus,kix,alpha,num);

			String fileName = AseUtil.getCurrentDrive()
								+ ":"
								+ SysDB.getSys(getConnection(),"documents")
								+ "outlines\\"
								+ campus
								+ "\\"
								+ kix;

			HtmlParser h = new HtmlParser(fileName+".html",fileName+".pdf");

			//TableAndHTMLWorker t = new TableAndHTMLWorker(fileName+".html",fileName+".pdf");

		}
		catch(Exception e){
			logger.fatal(e.toString());
			test = false;
		}

		test = true;

		assertTrue(test);

		logger.info("========================== PDFTest.testMain.END");

	}

	public static void main(final String[] args) {
		System.out.println("Foobar Flyer");
		System.out.println("-> jars needed: iText.jar");
		System.out.println("-> resource needed: html");
		System.out.println("-> resulting PDF: pdf");
		try {
			//new HtmlParser("foobar.html","foobar.pdf");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
