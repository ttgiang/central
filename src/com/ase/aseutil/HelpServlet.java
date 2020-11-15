/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HelpServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String id = website.getRequestParameter(request, "lid");
			String category = website.getRequestParameter(request, "category");
			String title = website.getRequestParameter(request, "title");
			String subtitle = website.getRequestParameter(request, "subtitle");
			String content = website.getRequestParameter(request, "questions");
			String campus = website.getRequestParameter(request, "campus");

			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			if (sAction.equalsIgnoreCase("cancel")) {iAction = cancelAction;}
			if (sAction.equalsIgnoreCase("delete")) {iAction = deleteAction;}
			if (sAction.equalsIgnoreCase("insert")) {iAction = insertAction;}
			if (sAction.equalsIgnoreCase("submit")) {iAction = updateAction;}
			if (sAction.equalsIgnoreCase("save")) {iAction = updateAction;}

			Help help = new Help(id, category, title, subtitle, content,
					auditby, (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()), campus);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = HelpDB.deleteHelp(connection, id);

					if (rowsAffected == 1)
						message = "Help topic <b>" + category + "</b> deleted successfully";
					else
						message = "Unable to delete help topic <b>" + category + "</b>";

					break;
				case insertAction:
					rowsAffected = HelpDB.insertHelp(connection, help);

					if (rowsAffected == 1)
						message = "Help topic <b>" + category + "</b> inserted successfully";
					else
						message = "Unable to insert help topic <b>" + category + "</b>";

					break;
				case updateAction:
					rowsAffected = HelpDB.updateHelp(connection, help);

					if (rowsAffected == 1)
						message = "Help topic <b>" + category + "</b> updated successfully";
					else
						message = "Unable to update help topic <b>" + category + "</b>";

					break;
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?rtn=hlpidx");
		}

		getServletContext().getRequestDispatcher(url)
				.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}