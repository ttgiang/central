/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @descr ttgiang
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

public class RequestServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	public void init() throws ServletException {}

	public void destroy() {}

	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";
		String auditDate = "";

		AsePool connectionPool = AsePool.getInstance();
		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			int lid = website.getRequestParameter(request,"lid",0);
			String campus = website.getRequestParameter(request,"campus");
			String userid = website.getRequestParameter(request,"userid");
			String status = website.getRequestParameter(request,"status");
			String descr = website.getRequestParameter(request,"descr");
			String userRequest = website.getRequestParameter(request,"userRequest");
			String comments = website.getRequestParameter(request,"comments");
			String action = website.getRequestParameter(request,"act");

			String cancel = website.getRequestParameter(request, "aseCancel");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSave");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int insertAction = 2;
			final int updateAction = 3;

			if (sAction.equalsIgnoreCase("cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("insert")) iAction = insertAction;
			if (sAction.equalsIgnoreCase("save")) iAction = updateAction;

			auditDate = (new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date());
			Request rqst = new Request(lid,campus,userid,status,userRequest,comments,auditDate,descr);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case insertAction:
					rowsAffected = RequestDB.insertRequest(connection,rqst);

					if (rowsAffected == 1)
						message = "Request inserted successfully";
					else
						message = "Unable to insert request";

					break;
				case updateAction:
					rowsAffected = RequestDB.updateRequest(connection,rqst);
					if (rowsAffected == 1)
						message = "Request updated successfully";
					else
						message = "Unable to update request";

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
			url = response.encodeURL("/core/msg2.jsp");
		} else {
			url = response.encodeURL("/core/msg2.jsp?rtn=rqstidx");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}