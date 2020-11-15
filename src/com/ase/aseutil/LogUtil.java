/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServlet;

public class LogUtil extends HttpServlet {

	private static final long serialVersionUID = 12L;

	private static String FILE;

	private static String logFile = "/WEB-INF/etc/ErrorLog.txt";

	public void logToFile(String message) throws IOException {

		FILE = getServletContext().getRealPath(logFile);

		try {
			PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(FILE, true)));

			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a");
			out.println(formatter.format(new java.util.Date()) + message+ "\n");
			out.close();
		} catch (IOException ioe) {
		}
	}

	public void logToFile(String message, Throwable t) throws IOException {

		FILE = getServletContext().getRealPath(logFile);

		try {
			PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(FILE, true)));
			out.print(message);
			out.println(t.toString() + "\n");
			out.close();
		} catch (IOException ioe) {
		}
	}
}
