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

public class PropsServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	public void init() throws ServletException {	}

	public void destroy() {}

	public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		String cancel = "";
		String delete = "";
		String insert = "";
		String preview = "";
		String send = "";
		String submit = "";

		String kix = "";

		final int cancelAction = 1;
		final int deleteAction = 2;
		final int insertAction = 3;
		final int previewAction = 4;
		final int sendAction = 5;
		final int updateAction = 6;

		int id = 0;

		AsePool connectionPool = AsePool.getInstance();
		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			id = website.getRequestParameter(request,"lid",0);
			String propName = website.getRequestParameter(request,"prop");
			String descr = website.getRequestParameter(request, "descr");

			String subject = website.getRequestParameter(request, "subject");
			String content = website.getRequestParameter(request, "content");
			String cc = website.getRequestParameter(request, "cc");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			cancel = website.getRequestParameter(request, "aseCancel");
			delete = website.getRequestParameter(request, "aseDelete");
			insert = website.getRequestParameter(request, "aseInsert");
			preview = website.getRequestParameter(request, "asePreview");
			send = website.getRequestParameter(request, "aseSend");
			submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (preview != null && preview.length() > 0) sAction = preview;
			if (send != null && send.length() > 0) sAction = send;
			if (submit != null && submit.length() > 0) sAction = submit;

			if (sAction.equalsIgnoreCase("cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("delete")) iAction = deleteAction;
			if (sAction.equalsIgnoreCase("insert")) iAction = insertAction;
			if (sAction.equalsIgnoreCase("preview")) iAction = previewAction;
			if (sAction.equalsIgnoreCase("send")) iAction = sendAction;
			if (sAction.equalsIgnoreCase("submit")) iAction = updateAction;

			Props prop = new Props(id,campus,propName,descr,subject,content,cc,auditby);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = PropsDB.deleteProp(connection,id);

					if (rowsAffected == 1)
						message = "Property <b>" + propName + "</b> deleted successfully";
					else
						message = "Unable to delete property <b>" + propName + "</b>";

					break;
				case insertAction:
					rowsAffected = PropsDB.insertProp(connection, prop);

					if (rowsAffected == 1)
						message = "Property <b>" + propName + "</b> inserted successfully";
					else
						message = "Unable to insert property <b>" + propName + "</b>";

					break;
				case previewAction:
					rowsAffected = PropsDB.updateProp(connection,prop);
					if (rowsAffected == 1)
						message = "Property <b>" + propName + "</b> updated successfully";
					else
						message = "Unable to update property <b>" + propName + "</b>";

					break;
				case sendAction:
					MailerDB mailerDB = new MailerDB(connection,auditby,auditby,"","","ENG","100",campus,propName,kix,auditby);
					break;
				case updateAction:
					rowsAffected = PropsDB.updateProp(connection,prop);
					if (rowsAffected == 1)
						message = "Property <b>" + propName + "</b> updated successfully";
					else
						message = "Unable to update property <b>" + propName + "</b>";

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
			if (iAction==previewAction)
				url = response.encodeURL("/core/ntfprvw.jsp?lid="+id);
			else
				url = response.encodeURL("/core/msg.jsp?rtn=ntfidx");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}