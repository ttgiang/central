/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CourseServlet extends HttpServlet {

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

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";
		String nextNo = "";
		String newNo = "";
		String currentTab = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();
			String currentNo = website.getRequestParameter(request, "lastNo");
			nextNo = website.getRequestParameter(request, "no");
			newNo = website.getRequestParameter(request, "newNo");
			currentTab = website.getRequestParameter(request, "currentTab");
			String questions = website.getRequestParameter(request, "questions");
			String formAction = website.getRequestParameter(request,"formAction");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String type = website.getRequestParameter(request, "questionType");

			final int cancelAction = 1;
			final int finishAction = 2;
			final int insertAction = 3;
			final int submitAction = 4;

			if (formAction.equalsIgnoreCase("c")) {
				iAction = cancelAction;
			}
			if (formAction.equalsIgnoreCase("f")) {
				iAction = finishAction;
			}
			if (formAction.equalsIgnoreCase("i")) {
				iAction = insertAction;
			}
			if (formAction.equalsIgnoreCase("s")) {
				iAction = submitAction;
			}

			switch (iAction) {
			case cancelAction:
				message = "Operation was cancelled";
				nextNo = null;
				break;
			case insertAction:
				rowsAffected = 0;
				try {
					PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO tblCourseQuestions (question, type, questionnumber, campus, auditby) VALUES (?,?,?,?,?)");
					preparedStatement.setString(1, questions);
					preparedStatement.setString(2, type);
					preparedStatement.setString(3, newNo);
					preparedStatement.setString(4, campus);
					preparedStatement.setString(5, auditby);
					rowsAffected = preparedStatement.executeUpdate();
					preparedStatement.close();
				} catch (SQLException e) {
					rowsAffected = -1;
				}

				// was the update successful?
				if (rowsAffected == 1)
					message = type + " question number <b>" + newNo
							+ "</b> inserted successfully.";
				else
					message = "Unable to insert " + type
							+ " question number <b>" + currentNo + "</b>";

				break;
			case finishAction:
			case submitAction:
				rowsAffected = 0;
				try {
					PreparedStatement preparedStatement = connection
							.prepareStatement("UPDATE tblCourseQuestions SET question=? WHERE questionnumber = ? AND type = ? AND campus = ?");
					preparedStatement.setString(1, questions);
					preparedStatement.setString(2, currentNo);
					preparedStatement.setString(3, type);
					preparedStatement.setString(4, campus);
					rowsAffected = preparedStatement.executeUpdate();
					preparedStatement.close();
				} catch (SQLException e) {
					rowsAffected = -1;
				}

				// was the update successful?
				if (rowsAffected == 1) {
					// this is the default message
					message = type + " question number <b>" + currentNo
							+ "</b> updated successfully.";

					// for finish action, we end editing
					if (iAction == finishAction) {
						message = message + "<br><br>Modification has ended.";
						nextNo = null;
					}
				} else
					message = "Unable to update " + type
							+ " question number <b>" + currentNo + "</b>";

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
			session.setAttribute("aseQuestionNo", nextNo);
			session.setAttribute("aseQuestionTab", currentTab);
			url = response.encodeURL("/core/msg.jsp?rtn=crsedt");
		}

		getServletContext().getRequestDispatcher(url)
				.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}