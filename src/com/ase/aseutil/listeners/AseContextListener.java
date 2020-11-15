/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

package com.ase.aseutil.listeners;

import java.sql.SQLException;
import java.util.ResourceBundle;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.bundle.BundleDB;

/**
 * Main listener to create data connection
 *
 */
public final class AseContextListener implements ServletContextListener {

	private ServletContext context = null;

	public AseContextListener() {}

	public void contextDestroyed(ServletContextEvent event){

		System.out.println("------------------------------------");
		System.out.println("Curriculum Central has been removed!");

		if (context != null){
			AsePool pool = (AsePool)context.getAttribute("AsePool");
			if (pool != null){
				try{
					pool.destroy(1000);
					System.out.println("Data pool has been removed!");
				}
				catch(SQLException e){
					System.out.println("Error while attempting to destroy data pool!");
				}
				catch(Exception e){
					System.out.println("Error while attempting to destroy data pool!");
				}
			} // pool != null
		} // context != null

		this.context = null;

		System.out.println("------------------------------------");

	}

	public void contextInitialized(ServletContextEvent event) {

		this.context = event.getServletContext();

		System.out.println("------------------------------------");
		System.out.println("Curriculum Central has just started!");

		ResourceBundle resourceBundle = ResourceBundle.getBundle("ase.central.SQLDrivers");
		if (resourceBundle != null){

			try{
				BundleDB bundle = new BundleDB();

				String host = bundle.getBundle(resourceBundle,"host","");
				String uid = bundle.getBundle(resourceBundle,"user","");
				String upw = bundle.getBundle(resourceBundle,"password","");

				boolean debug = false;
				if (debug){
					System.out.println("----------------");
					System.out.println("contextInitialized");
					System.out.println("host: " + host);
					System.out.println("user: " + uid);
					System.out.println("password: " + upw);
				}

				bundle = null;

				if (host != null){
					AsePool asePool = AsePool.getInstance(host,uid,upw);
					if (asePool != null){

						context.setAttribute("AsePool",asePool);

						System.out.println("Data pool has just started for " + host + " ("+uid+")!");

						Connection conn = null;

						try{
							conn = asePool.createLongConnection();

							if (conn != null){
								com.ase.aseutil.SysDB.clearTempTables(conn);
								System.out.println("Temp data cleared!");
							}
						}
						catch( Exception e ){
							System.out.println("unable to clear temp data - " + e.toString());
						}
						finally{
							try{
								if (conn != null){
									conn.close();
									conn = null;
								}
							}
							catch(Exception e){
								System.out.println("unable to clear temp data - " + e.toString());
							}
						}


					} // asepool
				}
				else{
					System.out.println("Data pool not found!");
				}
			}
			catch(java.util.MissingResourceException e){
				//
			}
			catch(Exception e){
				//
			}

		}
		else{
			System.out.println("Data pool not created due to missing bundle!");
		}

		System.out.println("------------------------------------");

	}
}