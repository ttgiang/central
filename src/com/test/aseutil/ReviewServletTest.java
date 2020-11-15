/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// ReviewServletTest.java
//
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

import com.ase.aseutil.*;

/**
 * @author tgiang
 *
 */
public class ReviewServletTest extends AseTestCase {

	/**
	 * Test method for {@link com.ase.aseutil.CourseCreate#CourseCreate()}.
	 */
	@Test
	public final void testReviewServlet() {

		boolean reviewed = true;

		logger.info("========================== ReviewServletTest.testReviewServlet.START");

		try{
			if (getConnection() != null){

				// collect all questions used and for each question, create 10 comments

				int[] item = QuestionDB.getCourseEditableItems(getConnection(),getCampus());
				if (item != null){

					int i = 0;
					int j = 0;

					Review review = null;

					for(j=0;j<item.length;j++){

						i = 0;
						reviewed = true;

						while(i<10 && reviewed==true){
							review = new Review();
							review.setId(1);
							review.setUser(getUser());
							review.setAlpha(getAlpha());
							review.setNum(getNum());
							review.setHistory(Helper.getKix(getConnection(),getCampus(),getAlpha(),getNum(),"PRE"));
							review.setComments("ReviewServletTest.testReviewServlet comments: " + i);
							review.setItem(item[j]);
							review.setCampus(getCampus());
							review.setEnable(true);
							review.setAuditDate(AseUtil.getCurrentDateTimeString());
							int rowsAffected = ReviewDB.insertReview(getConnection(),review,"1",Constant.APPROVAL);
							if (rowsAffected == 1)
								reviewed = true;
							else
								reviewed = false;

							++i;
						} // while
					} // for

				} // q

			} // if
		}
		catch(Exception e){
			reviewed = false;
		}

		assertTrue(reviewed);

		logger.info("========================== ReviewServletTest.testReviewServlet.END");

	}

}
