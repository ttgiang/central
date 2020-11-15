/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
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

public class TaskServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		Connection connection = connectionPool.getConnection();
		WebSite website = new WebSite();

		// used for usrtsks.jsp
		String uid = website.getRequestParameter(request, "uid");
		int sid = website.getRequestParameter(request, "sid", 0);

		// used for usrtsks02.jsp
		String campus = website.getRequestParameter(request, "campus");
		String alpha = website.getRequestParameter(request, "alpha");
		String num = website.getRequestParameter(request, "num");
		String user = website.getRequestParameter(request, "user");
		int code = website.getRequestParameter(request, "code", 0);

		try {

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel.trim();
			if (delete != null && delete.length() > 0) sAction = delete.trim();
			if (submit != null && submit.length() > 0) sAction = submit.trim();

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int submitAction = 3;

			if (sAction.equalsIgnoreCase("no")) {
				iAction = cancelAction;
			}
			else if (sAction.equalsIgnoreCase("yes")) {
				iAction = deleteAction;
			}
			else if (sAction.equalsIgnoreCase("submit")) {
				iAction = submitAction;
			}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = TaskDB.deleteTask(connection,sid,uid);
					if (rowsAffected == 1)
						message = "Task deleted successfully";
					else
						message = "Unable to delete task";

					break;
				case submitAction:
					uid = user;
					rowsAffected = TaskDB.addTask(connection,campus,user,alpha,num,code);
					if (rowsAffected == 1)
						message = "Task created successfully";
					else
						message = "Unable to create task";

					break;
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?rtn=usrtsks&sid="+uid);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}