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

/**
 * @author tgiang
 *
 */
public class CCTest extends AseTestCase {

	private Connection conn = null;

	/**
	 * Test method for {@link com.ase.aseutil.CourseCreate#CourseCreate()}.
	 */
	@Test
	public final void testCC() {

		logger.info("========================== CCTest.testCC.START");

		boolean flag = true;

		String campus	= null;
		String alpha	= null;
		String num		= null;
		String user		= null;

		try{
			conn = getConnection();

			if (conn != null){

				// cancel
				flag = cancel("LEE","ICS","100",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 100 - " + flag);

				flag = cancel("LEE","ICS","101",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 101 - " + flag);

				flag = cancel("LEE","ICS","102",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 102 - " + flag);

				flag = cancel("LEE","ICS","600",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 600 - " + flag);

				flag = cancel("LEE","ICS","601",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 601 - " + flag);

				flag = cancel("LEE","ICS","602",Constant.SYSADM_NAME);
				logger.info("testCC.cancel: ICS 602 - " + flag);

				// create
				flag = create("LEE","ICS","600",Constant.SYSADM_NAME);
				logger.info("testCC.create: ICS 600 - " + flag);

				flag = create("LEE","ICS","601",Constant.SYSADM_NAME);
				logger.info("testCC.create: ICS 601 - " + flag);

				flag = create("LEE","ICS","602",Constant.SYSADM_NAME);
				logger.info("testCC.create: ICS 602 - " + flag);

				// modify
				flag = modify("LEE","ICS","100",Constant.SYSADM_NAME);
				logger.info("testCC.modify: ICS 100 - " + flag);

				flag = modify("LEE","ICS","101",Constant.SYSADM_NAME);
				logger.info("testCC.modify: ICS 101 - " + flag);

				flag = modify("LEE","ICS","102",Constant.SYSADM_NAME);
				logger.info("testCC.modify: ICS 102 - " + flag);

			} // conn != null
		}
		catch(Exception e){
			flag = false;
		}

		assertTrue(flag);

		logger.info("========================== CCTest.testCC.END");
	}

	/**
	 * cancel
	 */
	public final boolean cancel(String campus,String alpha,String num,String user) {

		boolean flag = false;

		try{
			// attempt a cancel. if successful, a getKix should not be available
			Msg msg = CourseCancel.cancelOutline(conn,campus,alpha,num,user);
			if (msg != null){
				if(msg.getMsg().equals("Exception")){
					flag = false;
				}
				else{
					flag = true;
				} // exception
			}
			else{
				flag = false;
			} // msg != null

		}
		catch(Exception e){
			flag = false;
		}

		return flag;
	}

	/**
	 * create
	 */
	public final boolean create(String campus,String alpha,String num,String user) {

		boolean flag = false;

		try{
			flag = CourseCreate.createOutline(conn,alpha,num,alpha,num,user,campus,Constant.BLANK,Constant.BLANK,Constant.BLANK);
		}
		catch(Exception e){
			flag = false;
		}

		return flag;
	}

	/**
	 * modify
	 */
	public final boolean modify(String campus,String alpha,String num,String user) {

		boolean flag = false;

		try{
			// the user department must match the department selected to modify
			UserDB.setUserDepartment(conn,user,alpha);

			Msg msg = CourseModify.modifyOutline(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);
		}
		catch(Exception e){
			flag = false;
		}

		return flag;
	}

}
