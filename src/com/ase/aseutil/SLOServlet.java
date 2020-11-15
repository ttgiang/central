/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class SLOServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(SLOServlet.class.getName());
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

		int iAction = 0;
		int rowsAffected = 0;

		String sAction = "";
		String message = "";

		String alpha = "";
		String num = "";
		String type = "";

		boolean debug = false;

		WebSite website = new WebSite();

		Connection conn = connectionPool.getConnection();

		String caller = website.getRequestParameter(request, "caller");
		String kix = website.getRequestParameter(request, "kix");
		if (!kix.equals("")){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
		}

		try {
			debug = DebugDB.getDebug(conn,"SLOServlet");

			String progress = website.getRequestParameter(request, "progress");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String auditby = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");
			submit = submit.trim();

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			else if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int insertAction = 2;

			if (sAction.equalsIgnoreCase("Continue")) iAction = insertAction;
			else if (sAction.equalsIgnoreCase("Yes")) iAction = insertAction;
			else if (sAction.equalsIgnoreCase("Cancel")) iAction = cancelAction;

			SLO slo = new SLO(campus,alpha,num,progress,auditby,kix);

			if (debug){
				logger.info("campus: " + campus);
				logger.info("cancel: " + cancel);
				logger.info("submit: " + submit);
				logger.info("sAction: " + sAction);
				logger.info("iAction: " + iAction);
				logger.info("progress: " + progress);
				logger.info("caller: " + caller);
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
			}

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case insertAction:
					rowsAffected = SLODB.insertSLO(conn, slo);

					if (rowsAffected >= 0)
						message = "Requested operation completed successfully";
					else
						message = "Unable to save SLO request";

					break;
			}

			if (iAction != cancelAction)
				JSIDDB.updateJSID(conn,"","",caller,alpha,num,"CUR",auditby);

			session.setAttribute("aseApplicationMessage", message);

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?nomsg=1&rtn="+caller+"&kix="+kix);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}