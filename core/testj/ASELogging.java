/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 *
 * @author ttgiang
 *
 * void close () throws SQLException{}
 *
 */

//
// ASELogging.java
//
package com.ase.aseutil;

import java.io.*;
import java.util.*;
import java.util.logging.*;

public class ASELogging{

	final static int handlerHTML = 0;
	final static int handlerTEXT = 1;
	final static int handlerXML = 2;

	static int handlerType = handlerHTML;

	public ASELogging() throws Exception {}

	public static void main(String[] args) {
		// Get a logger; the logger is automatically created if it doesn't already exist
		Logger logger = Logger.getLogger(ASELogging.class.getName());

		// Create a new handler that uses the simple formatter
		FileHandler fh;
		switch(handlerType){
			case handlerHTML:
				try {
					fh = new FileHandler("mylog.html");
					fh.setFormatter(new AseHtmlFormatter());
					logger.addHandler(fh);
				} catch (IOException e) {}

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
