/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @descr ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FormsServlet extends HttpServlet {

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

			int lid = website.getRequestParameter(request,"lid",0);
			String title = website.getRequestParameter(request,"title");
			String link = website.getRequestParameter(request,"link");
			String descr = website.getRequestParameter(request,"descr");

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

			Form form = new Form(lid,campus,title,link,descr);

			// on a new entry, add when seq = 0 otherwise update
			if (lid==0 && iAction==updateAction)
				iAction = insertAction;

			//System.out.println("title: " + title);
			//System.out.println("lid: " + lid);
			//System.out.println("link: " + link);
			//System.out.println("descr: " + descr);
			//System.out.println("action: " + action);
			//System.out.println("campus: " + campus);
			//System.out.println("user: " + user);
			//System.out.println("cancel: " + cancel);
			//System.out.println("delete: " + delete);
			//System.out.println("insert: " + insert);
			//System.out.println("submit: " + submit);
			//System.out.println("cancelAction: " + cancelAction);
			//System.out.println("deleteAction: " + deleteAction);
			//System.out.println("insertAction: " + insertAction);
			//System.out.println("updateAction: " + updateAction);
			//System.out.println("sAction: " + sAction);
			//System.out.println("iAction: " + iAction);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = FormDB.deleteForm(connection,lid);

					if (rowsAffected == 1)
						message = "Entry deleted successfully";
					else
						message = "Unable to delete entry";

					break;
				case insertAction:
					rowsAffected = FormDB.insertForm(connection,form);

					if (rowsAffected == 1)
						message = "Entry inserted successfully";
					else
						message = "Unable to insert entry";

					break;
				case updateAction:
					rowsAffected = FormDB.updateForm(connection,form);
					if (rowsAffected == 1)
						message = "Entry updated successfully";
					else
						message = "Unable to update entry";

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
			String currentTab = (String)session.getAttribute("aseCurrentTab");
			String currentNo = (String)session.getAttribute("asecurrentlid");
			url = response.encodeURL("/core/msg2.jsp?rtn=crsfrmsidx");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}