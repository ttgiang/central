/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class DebugServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	static Logger logger = Logger.getLogger(DebugServlet.class.getName());

	public DebugServlet(){
		super();
	}

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		String user = "";
		String campus = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			boolean debug = website.getRequestParameter(request, "debug", false);
			String page = website.getRequestParameter(request, "named", "");

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");
			String object = website.getRequestParameter(request, "aseObject");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (object != null && object.length() > 0) sAction = object;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int objectAction = 4;
			final int updateAction = 5;

			if (sAction.equalsIgnoreCase("cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("delete")) { iAction = deleteAction; }
			if (sAction.equalsIgnoreCase("insert")) { iAction = insertAction; }
			if (sAction.equalsIgnoreCase("go")) 	{ iAction = objectAction; }
			if (sAction.equalsIgnoreCase("submit")) { iAction = updateAction; }

			Debug dbg = new Debug(page,debug);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					/*
					rowsAffected = DebugDB.deleteSys(connection,page);

					if (rowsAffected == 1)
						message = "System setting <b>" + page + "</b> deleted successfully";
					else
						message = "Unable to delete System setting <b>" + page + "</b>";
					*/

					break;
				case insertAction:
					if (!DebugDB.isMatch(connection, page)) {
						rowsAffected = DebugDB.insertDebug(connection,dbg);

						if (rowsAffected == 1)
							message = "System setting <b>" + page + "</b> inserted successfully";
						else
							message = "Unable to insert System setting <b>" + page + "</b>";

					} else {
						rowsAffected = -1;
						message = "System setting <b>" + page + "</b> already exists in Curriculum Central";
					}

					break;
				case objectAction:
					object = website.getRequestParameter(request, "obj", "");
					if (!object.equals(Constant.BLANK)){
						rowsAffected = DebugDB.updateObjectDebug(connection,object);
						if (rowsAffected > 0)
							message = "System setting <b>" + object + "</b> updated successfully";
						else
							message = "Unable to update System object <b>" + object + "</b>";
					}
					else{
						message = "Unable to update System object <b>" + object + "</b>";
					}

					break;


				case updateAction:
					rowsAffected = DebugDB.updateDebug(connection,page,debug);
					if (rowsAffected > 0)
						message = "System setting <b>" + page + "</b> updated successfully";
					else
						message = "Unable to update System setting <b>" + page + "</b>";

					break;

				default:

					// by default, if we get here via a link to clear all debug flags,
					// there cannot be any page value and the user must be a sys admin and
					// there is a value of bgs=1
					String bogus = website.getRequestParameter(request, "bgs", "0");
					boolean sysAdmin = SQLUtil.isSysAdmin(connection,user);
					if (page != null && page.equals(Constant.BLANK) && bogus.equals(Constant.ON) && sysAdmin){

						rowsAffected = DebugDB.clearDebugFlags(connection);
						if (rowsAffected >= 1)
							message = "Debuging disabled";
						else
							message = "Unable to disable debug";
					}

					break;

			}

			logger.info(user + " - DebugServlet - " + message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"DebugServlet",user);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?rtn=dbg");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}