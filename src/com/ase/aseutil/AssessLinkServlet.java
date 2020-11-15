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

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AssessLinkServlet extends HttpServlet {

	static Logger logger = Logger.getLogger(ApproverDB.class.getName());

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
		String kix = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String compid = "";
		String auditby = "";
		String currentTab = "";
		String currentNo = "";
		String rtn = "crscmp";

		Connection connection = connectionPool.getConnection();

		try {
			PreparedStatement ps = null;

			WebSite website = new WebSite();

			kix = website.getRequestParameter(request, "kix","");
			campus = website.getRequestParameter(request, "campus","");
			alpha = website.getRequestParameter(request, "alpha","");
			num = website.getRequestParameter(request, "num","");
			compid = website.getRequestParameter(request, "compid","");
			rtn = website.getRequestParameter(request, "rtn","");

			auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

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
					int numberOfIDs = website.getRequestParameter(request,"numberOfIDs", 0);
					String[] hiddenAssessID = new String[numberOfIDs];
					hiddenAssessID = website.getRequestParameter(request,"assessID").split(",");

					String selectedIDs = "";
					String temp = "";

					// get rid of existing before updating
					String sql = "DELETE FROM tblCourseCompAss WHERE historyid=? AND compid=?";
					ps = connection.prepareStatement(sql);
					ps.setString(1,kix);
					ps.setString(2,compid);
					rowsAffected = ps.executeUpdate();
					ps.close();

					/*
						for all fields, check to see if it was checked. if yes, set
						to 1, else 0;
						the final result is CSV of 0's and 1's of items that can be
						edited.
					*/
					sql = "INSERT INTO tblCourseCompAss(campus,coursealpha,coursenum,coursetype,compid,assessmentid,auditby,auditdate,historyid) VALUES(?,?,?,?,?,?,?,?,?)";
					ps = connection.prepareStatement(sql);
					for (int i = 0; i < numberOfIDs; i++) {
						temp = website.getRequestParameter(request, "assess_" + hiddenAssessID[i]);
						if (temp != null && !temp.equals("")) {
							ps.setString(1, campus);
							ps.setString(2, alpha);
							ps.setString(3, num);
							ps.setString(4, "PRE");
							ps.setInt(5, Integer.parseInt(compid));
							ps.setInt(6, Integer.parseInt(temp));
							ps.setString(7, auditby);
							ps.setString(8, AseUtil.getCurrentDateTimeString());
							ps.setString(9, kix);
							rowsAffected = ps.executeUpdate();
						}
					}
					ps.close();
					message = "Selected assessment(s) saved successfully.";
					break;
			} // switch

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
			url = response.encodeURL("/core/msg2.jsp?rtn="+rtn+"&sl=1&ts=" + currentTab + "&no=" + currentNo + "&kix=" + kix);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}