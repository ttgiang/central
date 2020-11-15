/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// MsgDB.java
//
package com.ase.aseutil;

import java.sql.SQLException;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class MsgDB {
	static Logger logger = Logger.getLogger(MsgDB.class.getName());

	public MsgDB() throws Exception {
	}

	/*
	 * getMessageDetail <p> @return String
	 */
	public static String getMsgDetail(String bundleName) {
		String message = "";
		try {
			ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AseMessages");
			message = bundle.getString(bundleName);
		} catch (Exception e) {
			logger.fatal("MsgDB: getMsgDetail\n" + e.toString());
			return null;
		}

		return message;
	}

	public void close() throws SQLException {
	}

}