/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Bundle.java
//
package com.ase.aseutil.bundle;

import com.ase.aseutil.*;

import java.sql.*;

import java.util.*;

import org.apache.log4j.Logger;

public final class Bundle {

	static Logger logger = Logger.getLogger(Bundle.class.getName());

	private String host = null;
	private String port = null;
	private String db = null;
	private String databaseDriver = null;
	private String driver = null;
	private String url = null;
	private String uid = null;
	private String upw = null;

	public Bundle() throws Exception {}

	/**
	*
	**/
	public String getHost(){ return this.host; }
	public void setHost(String value){ this.host = value; }

	/**
	*
	**/
	public String getPort(){ return this.port; }
	public void setPort(String value){ this.port = value; }

	/**
	*
	**/
	public String getDb(){ return this.db; }
	public void setDb(String value){ this.db = value; }

	/**
	*
	**/
	public String getDatabaseDriver(){ return this.databaseDriver; }
	public void setDatabaseDriver(String value){ this.databaseDriver = value; }

	/**
	*
	**/
	public String getDriver(){ return this.driver; }
	public void setDriver(String value){ this.driver = value; }

	/**
	*
	**/
	public String getUrl(){ return this.url; }
	public void setUrl(String value){ this.url = value; }

	/**
	*
	**/
	public String getUid(){ return this.uid; }
	public void setUid(String value){ this.uid = value; }

	/**
	*
	**/
	public String getUpw(){ return this.upw; }
	public void setUpw(String value){ this.upw = value; }

	public String toString(){
		return "Host: " + getHost() +
		"Host: " + getPort() +
		"Db: " + getDb() +
		"databaseDriver: " + getDatabaseDriver() +
		"Driver: " + getDriver() +
		"Url: " + getUrl() +
		"uid: " + getUid() +
		"upw: " + getUpw() +
		"";
	}
}
