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

public class ValuesServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;
	static Logger logger = Logger.getLogger(ValuesServlet.class.getName());

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

		String auditBy = "";
		String campus = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			int id = website.getRequestParameter(request, "lid", 0);
			String topic = website.getRequestParameter(request, "topic");
			String src = website.getRequestParameter(request, "src");
			String subTopic = website.getRequestParameter(request, "subTopic");
			int seq = website.getRequestParameter(request, "seq", 0);
			String shortDescr = website.getRequestParameter(request, "shortDescr");
			String longDescr = website.getRequestParameter(request, "longDescr");

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			auditBy = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

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

			Values values = new Values(id,
												campus,
												topic,
												subTopic,
												shortDescr,
												longDescr,
												auditBy,
												seq,
												topic);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = ValuesDB.deleteValues(connection, id);

					if (rowsAffected == 1)
						message = "Table value <b>" + topic + " - " + subTopic + "</b> deleted successfully";
					else
						message = "Unable to delete table value <b>" + topic + " - " + subTopic + "</b>";

					break;
				case insertAction:
					rowsAffected = ValuesDB.insertValues(connection,values);

					if (rowsAffected == 1)
						message = "Table value <b>" + topic + " - " + subTopic + "</b> inserted successfully";
					else
						message = "Unable to insert table value <b>" + topic + " - " + subTopic + "</b>";

					break;
				case updateAction:
					rowsAffected = ValuesDB.updateValues(connection, values);
					if (rowsAffected == 1)
						message = "Table value <b>" + topic + " - " + subTopic + "</b> updated successfully";
					else
						message = "Unable to update table value <b>" + topic + " - " + subTopic + "</b>";

					break;
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"ValuesServlet",auditBy);
		}

		String url = response.encodeURL("/core/msg.jsp?rtn=val");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}