/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.xml.DOMConfigurator;

public class Log4jInit extends HttpServlet {

	private static final long serialVersionUID = 12L;

	public void init() {

		String path = getServletContext().getRealPath("/");

		String log4jFile = getInitParameter("log4jProperties");

		String xmlFile = path + log4jFile;

		if (xmlFile != null) {
			if (xmlFile.indexOf(".properties") > -1)
				PropertyConfigurator.configure(xmlFile);
			else
				DOMConfigurator.configure(xmlFile);
		}
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		// if needed
		// session = req.getSession(true);
	}
}
