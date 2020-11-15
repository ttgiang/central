/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// ASELogger.java
//
package com.ase.aseutil;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.FileHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;
import java.util.logging.XMLFormatter;

public class ASELogger{

	final static int handlerHTML = 0;
	final static int handlerTEXT = 1;
	final static int handlerXML = 2;

	static int handlerType = handlerHTML;

	Logger logger;

	public ASELogger() throws Exception {
		// Get a logger; the logger is automatically created if it doesn't already exist
		logger = Logger.getLogger(ASELogger.class.getName());
	}

	public void createLogger(String user) throws Exception {

		// Create a new handler that uses the simple formatter
		FileHandler fh;
		String extension = "";

		switch(handlerType){
			case handlerHTML:
				extension = "html";
				break;
			case handlerTEXT:
				extension = "txt";
				break;
			case handlerXML:
				extension = "xml";
				break;
		}

		String loggerLocation = AseUtil.getLoggerLocation();
		String OS = AseUtil.getOS();
		String path = "";

		if ("Windows".equals(OS)) {
			path = System.getProperty("user.dir");
			loggerLocation = path.substring(0, 1) + ":" + loggerLocation;
		}

		user = loggerLocation + user + "." + extension;

		switch(handlerType){
			case handlerHTML:
				try {
					fh = new FileHandler(user);
					fh.setFormatter(new AseHtmlFormatter());
					logger.addHandler(fh);
				} catch (IOException ioe) {
					System.out.println(ioe.toString());
				} catch (Exception e) {
					System.out.println(e.toString());
				}

				break;
			case handlerTEXT:
				try {
					fh = new FileHandler(user);
					fh.setFormatter(new SimpleFormatter());
					logger.addHandler(fh);
				} catch (IOException ioe) {
					System.out.println(ioe.toString());
				} catch (Exception e) {
					System.out.println(e.toString());
				}

				break;
			case handlerXML:
				try {
					fh = new FileHandler(user);
					fh.setFormatter(new XMLFormatter());
					logger.addHandler(fh);
				} catch (IOException ioe) {
					System.out.println(ioe.toString());
				} catch (Exception e) {
					System.out.println(e.toString());
				}

				break;
		}
	}

	public void logSevere(String msg){
		logger.severe(msg);
	}

	public void logWarning(String msg){
		logger.warning(msg);
	}

	public void logInfo(String msg){
		logger.info(msg);
	}

	public void logConfig(String msg){
		logger.config(msg);
	}

	public void logFine(String msg){
		logger.fine(msg);
	}

	public void logFiner(String msg){
		logger.finer(msg);
	}

	public void logFinest(String msg){
		logger.finest(msg);
	}

	public void turnOff(){
		logger.setLevel(Level.OFF);
	}

	public static void main(String[] args) {
		// Get a logger; the logger is automatically created if it doesn't already exist
		Logger logger = Logger.getLogger(ASELogger.class.getName());

		// Create a new handler that uses the simple formatter
		FileHandler fh;
		switch(handlerType){
			case handlerHTML:
				try {
					fh = new FileHandler("mylog.html");
					fh.setFormatter(new AseHtmlFormatter());
					logger.addHandler(fh);
				} catch (Exception e) {}

				break;
			case handlerTEXT:
				try {
					fh = new FileHandler("mylog.txt");
					fh.setFormatter(new SimpleFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

				break;
			case handlerXML:
				try {
					fh = new FileHandler("mylog.xml");
					fh.setFormatter(new XMLFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

				break;
		}
	}
}

class AseHtmlFormatter extends java.util.logging.Formatter {

	public AseHtmlFormatter() throws Exception {}

	// This method is called for every log records
	public String format(LogRecord rec) {
		StringBuffer buf = new StringBuffer(1000);

		if (rec.getLevel().intValue() >= Level.WARNING.intValue()) {
			buf.append("<b>");
			buf.append(rec.getLevel());
			buf.append("</b>");
		} else {
			buf.append(rec.getLevel());
		}

		buf.append(' ');

		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a");
		java.util.Date today = new java.util.Date();

		buf.append(dateFormat.format(today.getTime()));
		//buf.append(rec.getSourceClassName() + ":");
		//buf.append(rec.getSourceMethodName() + ":");
		buf.append(' ');

		buf.append(formatMessage(rec));
		buf.append('\n');

		return buf.toString();
	}

	// This method is called just after the handler using this formatter is created
	public String getHead(Handler h) {
		return "<HTML><HEAD>"+(new Date())+"</HEAD><BODY><PRE>\n";
	}

	// This method is called just after the handler using this formatter is closed
	public String getTail(Handler h) {
		return "</PRE></BODY></HTML>\n";
	}
}

