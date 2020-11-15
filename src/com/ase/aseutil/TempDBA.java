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

import org.apache.log4j.Logger;

public class TempDBA {

	static Logger logger = Logger.getLogger(TempDBA.class.getName());

	static boolean debug = false;

	/*
	 * TempDBA
	 *	<p>
	 */
	public TempDBA() throws Exception {}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}