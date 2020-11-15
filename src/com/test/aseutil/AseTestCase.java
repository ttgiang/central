/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// AseTestCase.java
//

package com.test.aseutil;

import com.ase.aseutil.*;

import com.ase.aseutil.bundle.*;

import org.apache.log4j.Logger;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;

import java.util.*;

import java.sql.*;

/**
 *
 */
public class AseTestCase extends TestCase {

	static Logger logger = Logger.getLogger(AseTestCase.class.getName());

	private Connection conn = null;

	private String host = null;
	private String campus = null;
	private String user = null;
	private String alpha = null;
	private String num = null;
	private String type = null;
	private String kix = null;

	private String parm1 = null;		// tonum
	private String parm2 = null;		// approval sequence
	private String parm3 = null;		// true or false
	private String parm4 = null;

	boolean debug = false;

    /**
     * Sets up the test fixture.
     * (Called before every test case method.)
     */
    @Before
    public void setUp() {

		if (debug) logger.info("--> AseTestCase.setUp.START");

		host =	System.getProperty("host");
		kix =	System.getProperty("kix");
		campus =	System.getProperty("campus");
		user = System.getProperty("user");
		alpha = System.getProperty("alpha");
		num =	System.getProperty("num");
		type = System.getProperty("type");

		parm1 = System.getProperty("parm1");
		parm2 = System.getProperty("parm2");
		parm3 = System.getProperty("parm3");
		parm4 = System.getProperty("parm4");

		if (System.getProperty("debug").equals("1")){
			debug = true;
		}
		else{
			debug = false;
		}

		if (debug) logger.info("AseTestCase - setUp: got test system ant properties");

		getConnection();

		if (conn != null){
			if (debug) logger.info("AseTestCase - setUp: got connection");

			if (kix == null){
				kix = Helper.getKix(conn,campus,alpha,num,type);
			}

			showParms();
		}

		if (debug) logger.info("--> AseTestCase.setUp.END");

    }

    /**
     * Tears down the test fixture.
     * (Called after every test case method.)
     */
    @After
    public void tearDown() {

		if (debug) logger.info("--> AseTestCase.tearDown.START");

		try{
			if (conn != null){
				conn.close();
				conn = null;
			}
		}
		catch(Exception e){
			if (debug) logger.info("Connection release error");
		}

		if (debug) logger.info("--> AseTestCase.tearDown.END");
    }

	/**
	 *
	 */
	public Connection getConnection() {

		if (conn == null){

			try{
				BundleDB bundleDB = new BundleDB();

				com.ase.aseutil.bundle.Bundle bundle = bundleDB.getBundleForConnection();

				AsePool asePool = AsePool.getInstance(	bundle.getHost(),
																	bundle.getUid(),
																	bundle.getUpw());

				if (asePool != null){
					conn = asePool.createLongConnection();
				} // asePool

				bundle = null;
				bundleDB = null;
			}
			catch(Exception e){
				logger.fatal("AseTestCase: getConnection - " + e.toString());
			}

		} // conn = null

		return conn;

	}

	/**
	 *
	 */
	public void releaseConnection() {

		try{
			if (conn != null){
				conn.close();
				conn = null;

				if (debug) logger.info("AseTestCase - releaseConnection: Connection released");
			}
		}
		catch(Exception e){
			logger.fatal("AseTestCase: releaseConnection - " + e.toString());
		}

	}

	/**
	 *
	 */
	public String getKix() {
		return this.kix;
	}

	public void setKix(String value) {
		this.kix = value;
	}

	/**
	 *
	 */
	public String getCampus() {
		return this.campus;
	}

	public void setCampus(String value) {
		this.campus = value;
	}

	/**
	 *
	 */
	public String getAlpha() {
		return this.alpha;
	}

	public void setAlpha(String value) {
		this.alpha = value;
	}

	/**
	 *
	 */
	public String getNum() {
		return this.num;
	}

	public void setNum(String value) {
		this.num = value;
	}

	/**
	 *
	 */
	public String getType() {
		return this.type;
	}

	public void setType(String value) {
		this.type = value;
	}

	/**
	 *
	 */
	public String getUser() {
		return this.user;
	}

	public void setUser(String value) {
		this.user = value;
	}

	/**
	 *
	 */
	public String getParm1() {
		return this.parm1;
	}

	public void setParm1(String value) {
		this.parm1 = value;
	}

	/**
	 *
	 */
	public String getParm2() {
		return this.parm2;
	}

	public void setParm2(String value) {
		this.parm2 = value;
	}

	/**
	 *
	 */
	public String getParm3() {
		return this.parm3;
	}

	public void setParm3(String value) {
		this.parm3 = value;
	}

	/**
	 *
	 */
	public String getParm4() {
		return this.parm4;
	}

	public void setParm4(String value) {
		this.parm4 = value;
	}

	/**
	 *
	 */
	public boolean getDebug() {
		return this.debug;
	}

	public void setDebug(boolean value) {
		this.debug = value;
	}

	/**
	 *
	 */
	public Logger getLogger() {
		return this.logger;
	}

	/**
	 *
	 */
	public void gotConnection() {
		if (debug) logger.info("got connection");
	}

	/**
	 *
	 */
	public void showParms() {

		if (debug){
			logger.info("campus: " + campus);
			logger.info("user: " + user);
			logger.info("kix: " + kix);
			logger.info("alpha: " + alpha);
			logger.info("num: " + num);
			logger.info("type: " + type);
			logger.info("parm1: " + parm1);
			logger.info("parm2: " + parm2);
			logger.info("parm3: " + parm3);
			logger.info("parm4: " + parm4);
		}
	}
}
