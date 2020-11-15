/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 * AsePool asePool = AsePool.getInstance(String);
 * AsePool asePool = AsePool.getInstance(request);
 * AsePool asePool = AsePool.getInstance(int drvr,String server,request);
 * AsePool asePool = AsePool.getInstance(Constant.DATABASE_DRIVER_[],request);
 * AsePool asePool = AsePool.getInstance(request,Constant.DATABASE_DRIVER_SQL,"d-2020-101385","cc","sa","");
 * AsePool asePool = AsePool.getInstance(request,Constant.DATABASE_DRIVER_SQL,"szhi03","ccv2","sa","");
 * AsePool asePool = AsePool.getInstance(request,Constant.DATABASE_DRIVER_SQL,"nalo","ccv2","sa","");
 *	public static void getConnectionInstance(String driverType)
 *	public synchronized static AsePool getInstance()
 *	public synchronized static AsePool getInstance(HttpServletRequest request)
 *	public synchronized static AsePool getInstance(Constant.DATABASE_DRIVER_ACCESS,HttpServletRequest request)
 *	public synchronized static AsePool getInstance(HttpServletRequest request,int driverType,String host,String db,String uid,String pw)
 *	public static void killInstance()
 *
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ase.aseutil.bundle.BundleDB;
import com.javaexchange.dbConnectionBroker.DbConnectionBroker;

public class AsePool extends DbConnectionBroker {

	static Logger logger = Logger.getLogger(AsePool.class.getName());

	private static AsePool pool = null;

	private static String host = "";
	private static String port = "1433";
	private static String driver = "net.sourceforge.jtds.jdbc.Driver";
	private static String jtds = "jdbc:jtds:sqlserver";
	private static String url = jtds;
	private static String db = "ccv2";
	private static String user = "";
	private static String password = "";

	public AsePool(String _driverName,
						String _dbUrl,
						String _username,
						String _password,
						int _minConns,
						int _maxConns,
						String _logFilename,
						double _maxConnTimeInDays,
						boolean _logAppend,
						int _maxCheckoutSeconds,
						int _debugLevel) throws IOException {

		super(_driverName,
				_dbUrl,
				_username,
				_password,
				_minConns,
				_maxConns,
				_logFilename,
				_maxConnTimeInDays,
				_logAppend,
				_maxCheckoutSeconds,
				_debugLevel);
	}

	/*
	 * getConnectionInstance
	 *	<p>
	 *	@param thisDriver	int
	 *	@param thisHost	String
	 *	@param thisDb		String
	 *	@param thisUid		String
	 *	@param thisPw		String
	 *	@param seq			int
	 *	<p>
	 */
	public static void getConnectionInstance(int thisDriver,
											String thisHost,
											String thisDb,
											String thisUid,
											String thisPw,
											int seq) {

		String driverType = "";
		String dbDriver = "";
		String OS = "";
		String logFile = "";
		String path = "";

		boolean debug = false;

		try {
			if (pool == null) {

				logFile = AseUtil.getLogFile();

				OS = AseUtil.getOS();

				if (OS.equals("Windows")) {
					path = System.getProperty("user.dir");
					logFile = path.substring(0, 1) + ":" + logFile;
				}

				// what is the driver type
				driverType = Constant.DATABASE_DRIVER_SQL_NAME;

				// get host name
				host = thisHost;
				if (host == null || host.length() == 0){
					host = getHostName();
				}

				// get user name and password
				if (thisUid == null && thisPw == null){
					getDBCredentials();
				}
				else{
					user = thisUid;
					password = thisPw;
				}

				url = jtds + "://" + host + ":" + port + "/" + db;

				if (debug){
					logger.info("AsePool: ======================================");
					logger.info("Driver 		" + driverType);
					logger.info("log folder	" + logFile);
					logger.info("log drive	" + path);
					logger.info("host 		" + host);
					logger.info("port: 		" + port);
					logger.info("db: 			" + "*^%$^$");
					logger.info("driver: 	" + driver);
					logger.info("url: 		" + url);
					logger.info("seq: 		" + seq);
					logger.info("user: 		" + user); //"*$_!@(#");
					logger.info("password: 	" + password); //"!)@(#*$&%^");
				}

				pool = new AsePool(driver,url,user,password,10,50,logFile,1.0,false,180,3);

			}

		} catch (IOException ioe) {
			logger.fatal("AsePool: " + ioe.toString());
		}
	}

	/*
	 * getDBCredentials
	 *	<p>
	 *	@return String
	 */
	private static void getDBCredentials() {

		user = "ccusr";

		if (host.equals("thanh")){
			password = "Snn1q0tw";
		}
		else{
			password = "tw0c0mp1ex4u";
		}

		return;
	}

	/*
	 * getHostName
	 *	<p>
	 *	@return String
	 */
	public static String getHostName() {

		String host = "";

		ResourceBundle dbDriverBundle = ResourceBundle.getBundle("ase.central.SQLDrivers");
		if (dbDriverBundle != null)
			host = dbDriverBundle.getString("host");

		return host;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance() {

		int driver = 0;

		if (pool == null)
			getConnectionInstance(Constant.DATABASE_DRIVER_SQL,getHostName(),"",null,null,1);

		return pool;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@param HttpServletRequest request
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance(HttpServletRequest request) {

		int driver = 0;

		if (pool == null) {
			getConnectionInstance(Constant.DATABASE_DRIVER_SQL,getHostName(),"",null,null,2);
			HttpSession session = request.getSession(true);
		}

		return pool;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@param int 						drvr
	 *	@param String 					server
	 * @param HttpServletRequest 	request
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance(int drvr,String host,HttpServletRequest request) {

		try{
			if (pool == null) {
				getConnectionInstance(Constant.DATABASE_DRIVER_SQL,host,"",null,null,3);

				HttpSession session = request.getSession(true);

				setDatabaseVersion(session,"ccv2");
			}

		} catch (Exception e) {
			logger.fatal("AsePool: " + e.toString());
		}

		return pool;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@param String 					driverType
	 *	@param HttpServletRequest 	request
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance(int driverType,HttpServletRequest request) {

		if (pool == null) {
			getConnectionInstance(driverType,getHostName(),"",null,null,4);
			HttpSession session = request.getSession(true);
		}

		return pool;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@param String 					driverType
	 *	@param HttpServletRequest 	request
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance(HttpServletRequest request,
																	int driverType,
																	String host,
																	String db,
																	String uid,
																	String pw) {
		if (pool==null) {
			getConnectionInstance(driverType,host,db,uid,pw,5);
			HttpSession session = request.getSession(true);
			setDatabaseVersion(session,db);
		}

		return pool;
	}

	/*
	 * getInstance
	 *	<p>
	 *	@param	host
	 *	@param	uid
	 *	@param	upw
	 *	<p>
	 *	@return AsePool
	 */
	public synchronized static AsePool getInstance(String host,String uid,String upw) {

		try{
			boolean debug = false;

			if (pool == null) {
				if (debug){
					logger.info("----------------");
					logger.info("getInstance");
					logger.info("host: " + host);
					logger.info("user: " + uid);
					logger.info("password: " + upw);
				}

				getConnectionInstance(Constant.DATABASE_DRIVER_SQL,host,"",uid,upw,6);
			}
			else{
				if (debug){
					logger.info("----------------");
					logger.info("pool is not null");
				}
			}

		} catch (Exception e) {
			logger.fatal("AsePool: " + e.toString());
		}

		return pool;
	}

	/*
	 * setDatabaseVersion
	 *	<p>
	 *	@param session	HttpSession
	 *	@param db		String
	 */
	public static void setDatabaseVersion(HttpSession session,String db) {
		if (db != null) {
			if (db.trim().lastIndexOf("0")>0)
				session.setAttribute("aseDB", "20");
			else
				session.setAttribute("aseDB", "2");
		}
	}

	/*
	 * killInstance
	 */
	public static void killInstance() {

		if (pool != null) {
			pool = null;
		}

	}

	/*
	 * createLongConnection
	 */
	public static Connection createLongConnection() {

		Connection conn = null;

		try{
			// if null read from property file
			if (host == null || host.length() == 0)
				host = getHostName();

			// if still null read from database using current pool
			if (host == null || host.length() == 0){

				Connection shortConn = null;
				try{
					AsePool connectionPool = AsePool.getInstance();

					shortConn = connectionPool.getConnection();

					if (shortConn != null)
						host = SysDB.getSys(shortConn,"dbHost");
				}
				catch(Exception e){
					logger.fatal("AsePool: createLongConnection - " + e.toString());
				}
				finally{
					try{
						shortConn.close();
						shortConn = null;
					}
					catch(Exception e){
						//logger.fatal("Tables: campusOutlines - " + e.toString());
					}
				}
			}

			// do not combine as else to above if. this needs to executed regardless.
			if (host != null){

				if (user == null || password == null)
					getDBCredentials();

				if (user != null && password != null){
					url = url + "://" + host + ":" + port + "/" + db;

					Class.forName(driver);
					conn = DriverManager.getConnection(url,user,password);
				}
			} // host !+ null;
		}
		catch(Exception e){
			logger.fatal("AsePool: createLongConnection - " + e.toString());
		}

		return conn;
	}

	/*
	* getDefaultConnection
	* <p>
	* @return	Connection
	* <p>
	*/
 	public static Connection getDefaultConnection() {

		Connection conn = null;

		try{
			ResourceBundle resourceBundle = ResourceBundle.getBundle("ase.central.SQLDrivers");
			if (resourceBundle != null){

				try{
					BundleDB bundle = new BundleDB();

					String host = bundle.getBundle(resourceBundle,"host","");
					String port = bundle.getBundle(resourceBundle,"port","");
					String db = bundle.getBundle(resourceBundle,"db","");
					String databaseDriver = bundle.getBundle(resourceBundle,"databaseDriver","");
					String driver = bundle.getBundle(resourceBundle,"driver","");
					String url = bundle.getBundle(resourceBundle,"url","");
					String uid = bundle.getBundle(resourceBundle,"user","");
					String upw = bundle.getBundle(resourceBundle,"password","");

					bundle = null;

					if (host != null && pool != null){
						conn = createLongConnection();
					}
				}
				catch(java.util.MissingResourceException e){
					logger.info("AseTestCase - getConnection: resource bundle exception: " + e.toString());
				}
				catch(Exception e){
					logger.info("AseTestCase - getConnection: resource bundle exception: " + e.toString());
				}
			} // bundle
		}
		catch(MissingResourceException mre){
			logger.fatal(mre.toString());
		}

		return conn;
	}
}
