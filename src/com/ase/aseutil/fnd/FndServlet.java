/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil.fnd;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.Encrypter;
import com.ase.aseutil.WebSite;

public class FndServlet extends HttpServlet {

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
		try {
			WebSite website = new WebSite();

			int seq = website.getRequestParameter(request, "seq", 0);
			int en = website.getRequestParameter(request, "en", 0);
			int qn = website.getRequestParameter(request, "qn", 0);
			String id = website.getRequestParameter(request, "lid");
			String type = website.getRequestParameter(request, "type");
			String data = website.getRequestParameter(request, "data");

			String hallmark = "";
			String explanatory = "";
			String question = "";

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

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

			if (sAction.equalsIgnoreCase("cancel")) 	iAction = cancelAction;
			if (sAction.equalsIgnoreCase("delete"))	iAction = deleteAction;
			if (sAction.equalsIgnoreCase("insert"))	iAction = insertAction;
			if (sAction.equalsIgnoreCase("submit"))	iAction = updateAction;

			//
			// type and seq must always be available. they determine type and sequence of hallmarks
			// when en is available and qn = 0, then we are working with explanatory
			// when en > 0 and qn > 0, the we have a question
			//
			if(en == 0 && qn == 0){
				hallmark = data;
			}
			else if(en > 0 && qn == 0){
				explanatory = data;
			}
			else if(en > 0 && qn > 0){
				question = data;
			}

			Fnd fnd = new Fnd(id,
									seq,
									en,
									qn,
									type,
									hallmark,
									explanatory,
									question,
									campus,
									auditby,(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = FndDB.deleteFnd(connection, id);

					if (rowsAffected == 1)
						message = "Foundation hallmark <b>" + type
								+ "</b> deleted successfully";
					else
						message = "Unable to delete Foundation hallmark <b>" + type
								+ "</b>";

					break;
				case insertAction:
					rowsAffected = FndDB.insertFnd(connection, fnd);

					if (rowsAffected == 1)
						message = "Foundation hallmark <b>" + type
								+ "</b> inserted successfully";
					else
						message = "Unable to insert Foundation hallmark <b>" + type
								+ "</b>";

					break;
				case updateAction:
					rowsAffected = FndDB.updateFnd(connection, fnd);

					if (rowsAffected == 1)
						message = "Foundation hallmark <b>" + type
								+ "</b> updated successfully";
					else
						message = "Unable to update Foundation hallmark <b>" + type
								+ "</b>";

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
			url = response.encodeURL("/core/msg.jsp?rtn=fndidx");
		}

		getServletContext().getRequestDispatcher(url)
				.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}