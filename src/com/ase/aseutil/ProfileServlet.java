/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	final int cancelAction = 1;
	final int deleteAction = 2;
	final int insertAction = 3;
	final int updateAction = 4;

	private AsePool connectionPool;
	static Logger logger = Logger.getLogger(ProfileServlet.class.getName());
	Connection connection;
	int iAction = 0;

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";
		String temp = "";
		String id = "";
		String userid = "";
		String dept = "";
		String division = "";

		/*
			chk tracks whether user completed some task that is required at log in.
			set in the system settings under check, this value is 1 when we want
			program flow to go off the normal path.

			once the user completes what is asked, the check flag in his profile
			is set to 1 so that we are not asking to do it again.
		*/
		String chk = "";

		int rowsAffected = 0;
		int i;

		connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			if (sAction.equalsIgnoreCase("Cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("Save")) iAction = updateAction;

			id = website.getRequestParameter(request,"lid");
			chk = website.getRequestParameter(request,"chk");

			User user = new User();
			userid = website.getRequestParameter(request,"userid");
			user.setUserid(userid);

			division = website.getRequestParameter(request,"division");
			user.setDivision(division);

			dept = website.getRequestParameter(request,"department");
			user.setDepartment(dept);

			user.setEmail(website.getRequestParameter(request,"email"));
			user.setTitle(website.getRequestParameter(request,"title"));
			user.setLocation(website.getRequestParameter(request,"location"));
			user.setSalutation(website.getRequestParameter(request,"salutation"));
			user.setHours(website.getRequestParameter(request,"hours"));
			user.setPhone(website.getRequestParameter(request,"phone"));
			user.setPosition(website.getRequestParameter(request,"position"));
			user.setSendNow(website.getRequestParameter(request,"sendnow",1));
			user.setAttachment(website.getRequestParameter(request,"attachment",0));
			user.setCollege(website.getRequestParameter(request,"college",""));

			user.setWeburl(website.getRequestParameter(request,"weburl", ""));

			// get the string, sort it
			temp = website.getRequestParameter(request,"alphas");
			temp = Util.stringToArrayToString(temp.toUpperCase(),",",false);
			user.setAlphas(temp);

			user.setAuditBy(userid);
			user.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case updateAction:
					rowsAffected = UserDB.updateProfile(connection,user,request,response);
					if (rowsAffected == 1){
						message = "User profile <b>" + userid + "</b> updated successfully";
					}
					else
						message = "Unable to update user profile <b>" + userid + "</b>";

					break;
			}	// switch

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
			session.setAttribute("aseDept", dept);
			session.setAttribute("aseDivision", division);
			url = response.encodeURL("/core/msg.jsp?nomsg=1&rtn=profile");
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	/*
	*
	*/
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}