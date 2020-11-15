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

public class DegreeServlet extends HttpServlet {

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
		String rtn = "dgridx";

		Connection connection = connectionPool.getConnection();
		try {

			WebSite website = new WebSite();

			int degreeid = website.getRequestParameter(request,"lid",0);
			String alpha = website.getRequestParameter(request,"degreeCode");
			String title = website.getRequestParameter(request,"degreeTitle");
			String descr = website.getRequestParameter(request,"degreeDescr");
			String campus = website.getRequestParameter(request,"campus");
			rtn = website.getRequestParameter(request,"rtn", "dgridx");

			if ("crtpgr".equals(rtn))
				rtn = "prgcrt";

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

			Degree degree = new Degree(degreeid,alpha,title,descr,campus);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = DegreeDB.deleteDegree(connection,degreeid);

					if (rowsAffected == 1)
						message = "Degree deleted successfully";
					else
						message = "Unable to delete Degree Name <b>" + title + "</b>";

					break;
				case insertAction:
					if (!DegreeDB.isMatch(connection,campus,alpha)) {
						rowsAffected = DegreeDB.insertDegree(connection,degree);

						if (rowsAffected == 1)
							message = "Degree inserted successfully";
						else
							message = "Unable to insert Degree";

					} else {
						rowsAffected = -1;
						message = "Degree already exists in Curriculum Central";
					}
					break;
				case updateAction:
					rowsAffected = DegreeDB.updateDegree(connection,degree);

					if (rowsAffected == 1)
						message = "Degree updated successfully";
					else
						message = "Unable to update Degree";

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
			url = response.encodeURL("/core/msg.jsp?rtn=" + rtn);
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