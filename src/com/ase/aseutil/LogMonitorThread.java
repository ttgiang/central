/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 */

//
// LogMonitorThread.java
//
package com.ase.aseutil;

import java.io.File;
import java.net.URL;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

public class LogMonitorThread implements Runnable {

	private static Logger log = Logger.getLogger(LogMonitorThread.class);
	boolean interruped;
	private long checkIntervalMillis = 10000;
	private URL url;
	private File file;

	// stores the last modification time of the file
	private long lastModified = 0;

	public void run() {
		System.out.println("Initialize " + url.getPath());
		file = new File(url.getPath());
		// PropertyConfigurator.configure(url);
		DOMConfigurator.configure(url);
		lastModified = file.lastModified();
		monitor();
	}

	private void monitor() {

		log.info("Starting log4j monitor");

		while (!interruped) {
			// check if File changed
			long temp = file.lastModified();
			if (lastModified != temp) {
				log.info("Initialize log4j configuration " + url.getPath());
				// PropertyConfigurator.configure(url);
				DOMConfigurator.configure(url);
				lastModified = temp;
			}
			else
				log.debug("Log4j configuration is not modified");

			try {
				Thread.currentThread().sleep(checkIntervalMillis);
			} catch (InterruptedException e) {
				interruped = true;
			}
		}

		log.info("Shutting down log4j monitor");
	}

	public URL getUrl() {
		return url;
	}

	public void setUrl(URL url) {
		this.url = url;
	}

	public long getCheckIntervalMillis() {
		return checkIntervalMillis;
	}

	/**
	* Sets the interval for checking the url for changes. Unit is
	* milliseconds, 10000 = 10 seconds
	*
	* @param checkIntervalMillis
	*/
	public void setCheckIntervalMillis(long checkIntervalMillis) {
		this.checkIntervalMillis = checkIntervalMillis;
	}

	public boolean isInterruped() {
		return interruped;
	}

	public void setInterruped(boolean interruped) {
		this.interruped = interruped;
	}
}