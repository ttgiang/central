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

public final class BundleDB {

	static Logger logger = Logger.getLogger(Bundle.class.getName());

	public BundleDB() throws Exception {}

	/*
	* getBundle
	* <p>
	* @param		Bundle 		ResourceBundle
	* @param		parameter	String
	* @param		defalt		String
	* <p>
	* @return	String
	* <p>
	*/
	public String getBundle(ResourceBundle resourceBundle,String parameter,String defalt) {

		String value = null;

		try{
			value = resourceBundle.getString(parameter);
		}
		catch(java.util.MissingResourceException e){
			value = defalt;
		}
		catch(Exception e){
			value = defalt;
		}

		return value;
	}

	/*
	* getBundleForConnection
	* <p>
	* @return	Bundle
	* <p>
	*/
 	public Bundle getBundleForConnection() {

		com.ase.aseutil.bundle.Bundle bundle = null;

		try{
			ResourceBundle resourceBundle = ResourceBundle.getBundle("ase.central.SQLDrivers");
			if (resourceBundle != null){
				try{
					bundle = new com.ase.aseutil.bundle.Bundle();
					bundle.setHost(getBundle(resourceBundle,"host",""));
					bundle.setPort(getBundle(resourceBundle,"port",""));
					bundle.setDb(getBundle(resourceBundle,"db",""));
					bundle.setDatabaseDriver(getBundle(resourceBundle,"databaseDriver",""));
					bundle.setDriver(getBundle(resourceBundle,"driver",""));
					bundle.setUrl(getBundle(resourceBundle,"url",""));
					bundle.setUid(getBundle(resourceBundle,"user",""));
					bundle.setUpw(getBundle(resourceBundle,"password",""));
				}
				catch(java.util.MissingResourceException e){
					logger.info("Bundle - getBundleForConnection: resource Bundle exception: " + e.toString());
				}
				catch(Exception e){
					logger.info("Bundle - getBundleForConnection: resource Bundle exception: " + e.toString());
				}
			} // Bundle
		}
		catch(MissingResourceException mre){
			logger.fatal(mre.toString());
		}

		return bundle;
	}

}
