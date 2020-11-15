/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// ImportServlet.java
//
package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ImportServlet extends TalinServlet {

	private static final long serialVersionUID = 6524277708436373642L;

	static Logger logger = Logger.getLogger(ImportServlet.class.getName());

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
		logger.info("ImportServlet: destroyed...");
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

			WebSite website = new WebSite();

			String arg = website.getRequestParameter(request,"arg");
			String tp = website.getRequestParameter(request,"tp","");
			String key = website.getRequestParameter(request,"k","");

			if ("prereq".equals(tp) || "coreq".equals(tp))
				requisites(request,response,talin,tp,key);
			else if ("xlist".equals(tp))
				xlist(request,response,talin,key);

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
	private void xlist(HttpServletRequest request,
								HttpServletResponse response,
								Talin talin,
								String key){

		AsePool connectionPool = null;
		Connection conn = null;

		HttpSession session = request.getSession(true);
		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try{
			connectionPool = AsePool.getInstance();

			conn = connectionPool.getConnection();

			//String message = Import.crossListed(conn,campus,user,key);

			String message = Import.importData(conn,campus,user,key,"xlist");

			connectionPool.freeConnection(conn,"ImportServlet",user);

			session.setAttribute("aseApplicationMessage", message);

			talin.setPercentage(100);
		}
		catch(Exception e){
			logger.fatal("ImportServlet: " + e.toString());
		}
	}

	/**
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 * @param request
	 * @param response
	 * @param talin
	 */
	private void requisites(HttpServletRequest request,
									HttpServletResponse response,
									Talin talin,
									String tp,
									String key){

		AsePool connectionPool = null;
		Connection conn = null;

		/*
			key is a timestamp created during the upload of the data file. This file is then
			renamed to the timestamp to be unique. it's passed back from GenericUploadServlet.java
			to msg2.jsp where it then is sent to here
		*/

		HttpSession session = request.getSession(true);
		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		try{
			connectionPool = AsePool.getInstance();

			conn = connectionPool.getConnection();

			String message = null;

			tp = tp.toLowerCase();

			if (tp.equals("coreq")){
				//message = Import.requisites(conn,campus,user,Constant.REQUISITES_COREQ,key);
				message = Import.importData(conn,campus,user,key,"coreq");
			}
			else if (tp.equals("prereq")){
				//message = Import.requisites(conn,campus,user,Constant.REQUISITES_PREREQ,key);
				message = Import.importData(conn,campus,user,key,"prereq");
			}
			else
				message = "";

			connectionPool.freeConnection(conn,"ImportServlet",user);

			session.setAttribute("aseApplicationMessage", message);

			talin.setPercentage(100);
		}
		catch(Exception e){
			logger.fatal("ImportServlet: " + e.toString());
		}
	}
}