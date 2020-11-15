/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

//
// ApproverDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import com.ase.aseutil.ApproverDB;
import com.ase.aseutil.Helper;
import com.ase.aseutil.IniDB;
import com.ase.aseutil.MailerDB;
import com.ase.aseutil.NumericUtil;

import org.apache.log4j.Logger;

public class TempDBZ {

	static Logger logger = Logger.getLogger(TempDBZ.class.getName());

	static boolean debug = false;

	/*
	 * TempDBZ
	 *	<p>
	 */
	public TempDBZ() throws Exception {}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}