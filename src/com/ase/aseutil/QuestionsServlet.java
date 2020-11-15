/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class QuestionsServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;

	public void init() throws ServletException {
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
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String questionnumber = website.getRequestParameter(request,"questionnumber");
			String question = website.getRequestParameter(request, "question");
			String question_friendly = website.getRequestParameter(request,"question_friendly");
			String question_type = website.getRequestParameter(request,"question_type");
			String question_ini = website.getRequestParameter(request,"question_ini");
			String formAction = website.getRequestParameter(request,"formAction");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			final int cancelAction = 1;
			final int submitAction = 2;

			if (formAction.equalsIgnoreCase("c")) {
				iAction = cancelAction;
			}
			if (formAction.equalsIgnoreCase("s")) {
				iAction = submitAction;
			}

			switch (iAction) {
			case cancelAction:
				message = "Operation was cancelled";
				break;
			case submitAction:
				rowsAffected = 0;
				try {
					PreparedStatement preparedStatement = connection
							.prepareStatement("UPDATE tblCourseQuestions SET question=?,question_friendly=?,question_type=?,question_ini=? WHERE questionnumber = ? AND campus = ?");
					preparedStatement.setString(1, question);
					preparedStatement.setString(2, question_friendly);
					preparedStatement.setString(3, question_type);
					preparedStatement.setString(4, question_ini);
					preparedStatement.setString(5, questionnumber);
					preparedStatement.setString(6, campus);
					rowsAffected = preparedStatement.executeUpdate();
					preparedStatement.close();
				} catch (SQLException e) {
					rowsAffected = -1;
				}

				if (rowsAffected == 1)
					message = "Question number <b>" + questionnumber
							+ "</b> updated successfully.";
				else
					message = "Unable to update question number <b>"
							+ questionnumber + "</b>";

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
			url = response.encodeURL("/core/msg.jsp?rtn=crsquest");
		}

		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}