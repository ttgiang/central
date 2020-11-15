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

public class RequisiteServlet extends HttpServlet {

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

			int seq = website.getRequestParameter(request,"seq",0);
			String kix = website.getRequestParameter(request,"kix");
			String title = website.getRequestParameter(request,"title");
			String edition = website.getRequestParameter(request,"edition");
			String author = website.getRequestParameter(request,"author");
			String publisher = website.getRequestParameter(request,"publisher");
			String yeer = website.getRequestParameter(request,"yeer");
			String isbn = website.getRequestParameter(request,"isbn");
			String action = website.getRequestParameter(request,"act");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseClose");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSave");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			if (sAction.equalsIgnoreCase("close")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("delete")) iAction = deleteAction;
			if (sAction.equalsIgnoreCase("insert")) iAction = insertAction;
			if (sAction.equalsIgnoreCase("save")) iAction = updateAction;

			Text text = new Text(kix,seq,title,edition,author,publisher,yeer,isbn);

			// on a new entry, add when seq = 0 otherwise update
			if (seq==0 && iAction == updateAction)
				iAction = insertAction;
			else if ("r".equals(action)){
				// remove/delete overrides all other settings prior to here
				String aseCancel = website.getRequestParameter(request, "aseCancel");
				String aseDelete = website.getRequestParameter(request, "aseDelete");

				if (aseCancel != null && aseCancel.length() > 0) iAction = cancelAction;
				if (aseDelete != null && aseDelete.length() > 0) iAction = deleteAction;

				text = TextDB.getText(connection,kix,seq);
				if (text!=null)
					title = text.getTitle();
			}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = TextDB.deleteText(connection,kix,seq);

					if (rowsAffected == 1)
						message = "<b>" + title + "</b> deleted successfully";
					else
						message = "Unable to delete <b>" + title + "</b>";

					break;
				case insertAction:
					rowsAffected = TextDB.insertText(connection,text);

					if (rowsAffected == 1)
						message = "<b>" + title + "</b> inserted successfully";
					else
						message = "Unable to insert <b>" + title + "</b>";

					break;
				case updateAction:
					rowsAffected = TextDB.updateText(connection,text);
					if (rowsAffected == 1)
						message = "<b>" + title + "</b> updated successfully";
					else
						message = "Unable to update <b>" + title + "</b>";

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
			url = response.encodeURL("/core/msg2.jsp?rtn=crsbk");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}