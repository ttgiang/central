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

import org.apache.log4j.Logger;

public class SysServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	static Logger logger = Logger.getLogger(SysServlet.class.getName());

	public SysServlet(){
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

			String named = website.getRequestParameter(request, "named", "");
			String valu = website.getRequestParameter(request, "valu", "");
			String global = website.getRequestParameter(request, "global", "");
			String descr = website.getRequestParameter(request, "descr", "");

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

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

			if (sAction.equalsIgnoreCase("cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("delete")) { iAction = deleteAction; }
			if (sAction.equalsIgnoreCase("insert")) { iAction = insertAction; }
			if (sAction.equalsIgnoreCase("submit")) { iAction = updateAction; }

			Sys sys = new Sys(global,named,valu,descr);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = SysDB.deleteSys(connection,named);

					if (rowsAffected == 1)
						message = "System setting <b>" + named + "</b> deleted successfully";
					else
						message = "Unable to delete System setting <b>" + named + "</b>";

					break;
				case insertAction:
					if (!SysDB.isMatch(connection, named)) {
						rowsAffected = SysDB.insertSys(connection,sys);

						if (rowsAffected == 1)
							message = "System setting <b>" + named + "</b> inserted successfully";
						else
							message = "Unable to insert System setting <b>" + named + "</b>";

					} else {
						rowsAffected = -1;
						message = "System setting <b>" + named + "</b> already exists in Curriculum Central";
					}

					break;
				case updateAction:
					rowsAffected = SysDB.updateSys(connection,named,valu,descr);
					if (rowsAffected == 1)
						message = "System setting <b>" + named + "</b> updated successfully";
					else
						message = "Unable to update System setting <b>" + named + "</b>";

					break;
			}

			logger.info(user + " - SysServlet - " + message);
			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"SysServlet",user);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?rtn=sys");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}