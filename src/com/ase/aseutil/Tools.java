/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

package com.ase.aseutil;

import java.io.File;

import org.apache.log4j.Logger;

public class Tools {

	static Logger logger = Logger.getLogger(Tools.class.getName());

	/**
	 * readClassFolder
	 */
	public static void readFolder(String folderName,String filter) {

		if (folderName != null){
			File dir = new File(folderName);

			String[] children = dir.list();
			if (children == null) {
				 // Either dir does not exist or is not a directory
			} else {
				 for (int i=0; i<children.length; i++) {
					  String filename = children[i];

					  if (filter != null){
					  		if (filename.indexOf(filter)>-1)
					  			System.out.println("filtered: " + filename);
						}
					  else
					  		System.out.println(filename);
				 }
			}
		}
	}

	/**
	 * getCurrentWorkingDirectory
	 */
	public static String getCurrentWorkingDirectory() {

		return System.getProperty("user.dir");

	}

	/**
	 * getCurrentDrive
	 */
	public static String getCurrentDrive() {

		String currentDrive = "";

		try {
			File dir = new File (".");

			currentDrive = dir.getCanonicalPath();

			if (currentDrive != null)
				currentDrive = currentDrive.substring(0,1);
		}
		catch(Exception e) {
			logger.fatal("Tools - getCurrentDrive: " + e.toString());
		}

		return currentDrive;
	}

	/**
	 * readClassFolder
	 */
	public static void readClassFolder() {

		try {
			String currentDrive = getCurrentDrive();

			if (currentDrive != null){
				currentDrive = currentDrive+"://tomcat//webapps//central//WEB-INF//classes//com//ase//aseutil";
				readFolder(currentDrive,"class");
			}

		}
		catch(Exception e) {
			logger.fatal("Tools - getCurrentDrive: " + e.toString());
		}

		return;
	}

}