/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class EmailListServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;
	static Logger logger = Logger.getLogger(EmailListServlet.class.getName());

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";
		String listName = "";

		int iAction = 0;
		int rowsAffected = 0;
		int i;

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");
			int lid = website.getRequestParameter(request, "lid", 0);

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

			EmailLists emailList = new EmailLists();
			emailList.setListID(lid);
			listName = website.getRequestParameter(request,"listName");
			emailList.setTitle(listName);
			emailList.setMembers(website.getRequestParameter(request,"formSelect"));
			emailList.setCampus(campus);
			emailList.setAuditBy(auditby);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = EmailListsDB.deleteList(connection, lid);
					if (rowsAffected == 1)
						message = "Email list <b>" + listName + "</b> deleted successfully";
					else
						message = "Unable to delete email list <b>" + listName + "<br/>";

					break;
				case insertAction:
					rowsAffected = EmailListsDB.insertList(connection,emailList);
					if (rowsAffected == 1)
						message = "Email list <b>" + listName + "</b> inserted successfully";
					else
						message = "Unable to insert email list <b>" + listName + "<br/>";

					break;
				case updateAction:
					rowsAffected = EmailListsDB.updateList(connection,emailList);
					if (rowsAffected == 1)
						message = "Email list <b>" + listName + "</b> updated successfully";
					else
						message = "Unable to update email list <b>" + listName + "<br/>";

					break;
			}

			logger.info(auditby + " EmailList List - " + message);
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
			url = response.encodeURL("/core/msg.jsp?rtn=emailidx");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}