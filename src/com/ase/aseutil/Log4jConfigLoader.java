/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// Log4jConfigLoader.java
//
package com.ase.aseutil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class Log4jConfigLoader extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private Thread thread;

	@Override
	public void destroy() {
		thread.interrupt();
		super.destroy();
	}

	@SuppressWarnings("unchecked")
	public void init() throws ServletException {
		super.init();
		LogMonitorThread logMonitorThread = new LogMonitorThread();
		logMonitorThread.setCheckIntervalMillis(10000);
		logMonitorThread.setUrl(Log4jConfigLoader.class.getResource("/log4j.xml"));
		thread = new Thread(logMonitorThread);
		thread.start();
	}
}