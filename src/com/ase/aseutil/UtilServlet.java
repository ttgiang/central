/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 */

//
// UtilServlet.java
//
package com.ase.aseutil;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class UtilServlet extends TalinServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(UtilServlet.class.getName());

	/**
	**
	**/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	**
	**/
	public void destroy() {
		logger.info("UtilServlet: destroyed...");
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		Object o = session.getAttribute("Talin");
		Talin talin;

		if (o == null) {
			talin = new Talin();

			session.setAttribute("Talin", talin);

			Thread t = new Thread(talin);

			t.start();

			//DO SOMETHING HERE - START

			doSometing(request,response,talin);

			//DO SOMETHING HERE - END
		} else {
			talin = (Talin) o;
		}

		response.setContentType("text/html");

		switch (talin.getPercentage()) {
			case -1:
				isError(response.getOutputStream());
				return;
			case 100:
				session.removeAttribute("Talin");
				getServletContext().getRequestDispatcher("/core/talin.jsp").forward(request, response);
				return;
			default:
				isBusy(talin, request, response);
				return;
		}
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @param talin
	 */
	private void doSometing(HttpServletRequest request,
									HttpServletResponse response,
									Talin talin){

		HttpSession session = null;

		String message = null;
		String campus = null;
		String user = null;
		String skew = null;
		String task = null;
		String idx = null;

		boolean failure = false;

		try{
			session = request.getSession(true);

			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			boolean debug = false;

			Msg msg = new Msg();

			Enc enc = EncDB.getEnc(request,"aseLinker");
			if (enc != null){
				campus = enc.getCampus();
				user = enc.getUser();
				skew = enc.getSkew();
				task = enc.getKey1();
				idx = enc.getKey2();

				if (debug){
					logger.info("campus: " + campus);
					logger.info("user: " + user);
					logger.info("skew: " + skew);
				}

				if (task.equals("fco"))
					msg = Tables.campusOutlines(campus);
				else if (task.equals("frce") || task.equals("htm") || task.equals("html") || task.equals("idx") || task.equals("pre"))
					Tables.createOutlines(null,"","","",task,idx);
				else if (task.equals("ft"))
					msg = Tables.tabs();
				else if (task.equals("fd"))
					msg = DebugDB.fillDebugTables();

				if ("".equals(msg.getMsg()))
					message = "Operation completed successfully";
				else
					failure = true;

				talin.setPercentage(100);
			}
			else{
				failure = true;
			}

			// if doSomething made it through, logging would include all
			// we needed to know. However, if an error occur, this logging
			// tells us what we should know about the error.
			if (failure){
				// force end
				talin.setPercentage(100);
				logger.info("UtilServlet: START");
				logger.info("UtilServlet: " + message);
				logger.info("UtilServlet: END");
				message = "Unable to process request";
			}
		}
		catch(Exception e){
			logger.fatal("UtilServlet: " + e.toString());
		} finally {
			session.setAttribute("aseApplicationMessage", message);
		}

	}
}