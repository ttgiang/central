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

public class AlphaServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

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

			String disp = website.getRequestParameter(request, "lid");
			String discipline = website.getRequestParameter(request,"discipline");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0)	sAction = cancel;
			if (delete != null && delete.length() > 0)	sAction = delete;
			if (insert != null && insert.length() > 0)	sAction = insert;
			if (submit != null && submit.length() > 0)	sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			if (sAction.equalsIgnoreCase("cancel"))	iAction = cancelAction;
			if (sAction.equalsIgnoreCase("delete"))	iAction = deleteAction;
			if (sAction.equalsIgnoreCase("insert"))	iAction = insertAction;
			if (sAction.equalsIgnoreCase("submit"))	iAction = updateAction;

			Alpha alpha = new Alpha(disp,discipline);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = AlphaDB.deleteAlpha(connection, disp);

					if (rowsAffected == 1)
						message = "Discipline <b>" + disp + "</b> deleted successfully";
					else
						message = "Unable to delete discipline <b>" + disp + "</b>";

					break;
				case insertAction:
					if (!AlphaDB.isMatch(connection,disp)) {
						rowsAffected = AlphaDB.insertAlpha(connection, alpha);

						if (rowsAffected == 1)
							message = "Discipline <b>" + disp + "</b> inserted successfully";
						else
							message = "Unable to insert discipline <b>" + disp + "</b>";

					} else {
						rowsAffected = -1;
						message = "Discipline <b>" + disp + "</b> already exists in Curriculum Central (CC)";
					}
					break;
				case updateAction:
					rowsAffected = AlphaDB.updateAlpha(connection,alpha);

					if (rowsAffected == 1)
						message = "Discipline <b>" + disp + "</b> updated successfully";
					else
						message = "Unable to update discipline <b>" + disp + "</b>";

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
			url = response.encodeURL("/core/msg.jsp?rtn=alphaidx");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}
}