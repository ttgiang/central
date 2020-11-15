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

public class SLOLinkServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String url;
		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";
		String src = "";
		String kix = "";
		String campus = "";
		String user = "";
		String currentTab = "";
		String currentNo = "";

		Connection conn = connectionPool.getConnection();

		try {
			WebSite website = new WebSite();

			kix = website.getRequestParameter(request, "kix");
			src = website.getRequestParameter(request, "src");

			campus = website.getRequestParameter(request, "campus");
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			currentTab = website.getRequestParameter(request, "currentTab");
			currentNo = website.getRequestParameter(request, "currentNo");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int submitAction = 2;

			if (sAction.equalsIgnoreCase("Cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("Save")) { iAction = submitAction; }

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled.<br/>";
					break;
				case submitAction:
					rowsAffected = SLODB.saveLinkedData(request,conn,campus,src,kix,user);

					if (rowsAffected > 0)
						message = "Selected content(s) saved successfully.";

					session.setAttribute("aseApplicationMessage", message);

					break;
			}

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn);
		}

		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg2.jsp?rtn=crscntnt&sl=1&ts=" + currentTab + "&no=" + currentNo + "&kix=" + kix);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}