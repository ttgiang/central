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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;

public class TempDBW {

	static Logger logger = Logger.getLogger(TempDBW.class.getName());

	static boolean debug = false;

	/*
	 * TempDBW
	 *	<p>
	 */
	public TempDBW() throws Exception {}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}