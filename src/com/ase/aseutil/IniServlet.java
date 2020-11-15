/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class IniServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;
	static Logger logger = Logger.getLogger(IniServlet.class.getName());

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		String sAction = "";
		int iAction = 0;
		int rowsAffected = 0;
		String message = "";

		String klanid = "";
		String campus = "";

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String campusWide = website.getRequestParameter(request, "campusWide_0", "N");
			String id = website.getRequestParameter(request, "lid");
			String category = website.getRequestParameter(request, "category");
			String kid = website.getRequestParameter(request, "kid");
			String kdesc = website.getRequestParameter(request, "kdesc");
			String kval1 = website.getRequestParameter(request, "kval1");
			String kval2 = website.getRequestParameter(request, "kval2");
			String kval3 = website.getRequestParameter(request, "kval3");
			String kval4 = website.getRequestParameter(request, "kval4");
			String kval5 = website.getRequestParameter(request, "kval5");
			String kedit = website.getRequestParameter(request, "kedit");

			if (kdesc.equals(Constant.BLANK) && !kid.equals(Constant.BLANK)){
				kdesc = kid;
			}

			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			klanid = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String cancel = website.getRequestParameter(request, "aseCancel");
			String delete = website.getRequestParameter(request, "aseDelete");
			String insert = website.getRequestParameter(request, "aseInsert");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (delete != null && delete.length() > 0) sAction = delete;
			if (insert != null && insert.length() > 0) sAction = insert;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int deleteAction = 2;
			final int insertAction = 3;
			final int updateAction = 4;

			if (sAction.equalsIgnoreCase("cancel")) { iAction = cancelAction; }
			if (sAction.equalsIgnoreCase("delete")) { iAction = deleteAction; }
			if (sAction.equalsIgnoreCase("insert")) { iAction = insertAction; }
			if (sAction.equalsIgnoreCase("submit")) { iAction = updateAction; }

			boolean updateSession = false;

			Ini ini = new Ini(id, category, kid, kdesc, kval1, kval2, kval3,
					kval4, kval5, klanid,
					(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()),
					campus,kedit);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = IniDB.deleteIni(connection, id);

					if (rowsAffected == 1)
						message = "System setting <b>" + category + " - " + kid + "</b> deleted successfully";
					else
						message = "Unable to delete System setting <b>" + kid + "</b>";

					break;
				case insertAction:
					if (!IniDB.isMatch(connection, category, kid)) {
						rowsAffected = IniDB.insertIni(connection,ini,campusWide);

						if (rowsAffected == 1)
							message = "System setting <b>" + category + " - " + kid + "</b> inserted successfully";
						else
							message = "Unable to insert System setting <b>" + kid + "</b>";

					} else {
						rowsAffected = -1;
						message = "System setting <b>" + category + " - " + kid + "</b> already exists in Curriculum Central";
					}

					updateSession = true;


					break;
				case updateAction:

					// a script is available when additional options are required by the user. if so,
					// notify user without updating settings.
					String script = IniDB.getScript(connection,campus,category,kid);

					if(!script.equals(Constant.BLANK)){
						message = "System setting <b>" + category + " - " + kid + "</b> requires additional action."
							+ "<br><br>Click <a href=\"/central/core/inicon.jsp?kid="+kid+"\" class=\"linkcolumn\">here</a> to complete system setting.";

						// set positive to move on
						rowsAffected = 1;
					}
					else{
						rowsAffected = IniDB.updateIni(connection, ini);

						if (rowsAffected == 1){
							message = "System setting <b>" + category + " - " + kid + "</b> updated successfully";
						}
						else{
							message = "Unable to update System setting <b>" + category + " - " + kid + "</b>";
						}

						updateSession = true;
					}

					break;
			}

			if (updateSession){

				AseUtil.logAction(connection, klanid, "ACTION","System setting change ("+ kid + " is " + kval1 + ")","","",campus,"");

				HashMap sessionMap = (HashMap)session.getAttribute("aseSessionMap");

				if (sessionMap == null){
					sessionMap = new HashMap();
				}

				sessionMap.put(kid,new String(Encrypter.encrypter(kval1)));
			}

			session.setAttribute("aseApplicationMessage", message);
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection,"IniServlet",klanid);
		}

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg.jsp");
		} else {
			url = response.encodeURL("/core/msg.jsp?rtn=ini");
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}