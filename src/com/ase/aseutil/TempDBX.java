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
import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class TempDBX {

	static Logger logger = Logger.getLogger(TempDBX.class.getName());

	static boolean debug = false;

	/*
	 * TempDBX
	 *	<p>
	 */
	public TempDBX() throws Exception {}

	/*
	 * close
	 *	<p>
	 * @return void
	 */
	public void close() throws SQLException {}

}
