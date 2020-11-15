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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class ReorderServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(ReorderServlet.class.getName());

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
		int list = 0;
		int rowsAffected = 0;
		String message = "";
		Msg msg = new Msg();

		Connection connection = connectionPool.getConnection();
		try {
			WebSite website = new WebSite();

			String cancel = website.getRequestParameter(request, "aseCancel");
			String submit = website.getRequestParameter(request, "aseSubmit");

			if (cancel != null && cancel.length() > 0) sAction = cancel;
			if (submit != null && submit.length() > 0) sAction = submit;

			final int cancelAction = 1;
			final int updateAction = 2;

			if (sAction.equalsIgnoreCase("cancel")) iAction = cancelAction;
			if (sAction.equalsIgnoreCase("update")) iAction = updateAction;

			String kix = website.getRequestParameter(request,"kix");
			String campus = website.getRequestParameter(request,"campus");

			// old ids used for updating of rows
			String ids = website.getRequestParameter(request,"ids");

			// old rdr entries
			String rdrs = website.getRequestParameter(request,"rdrs");

			// list that we are reordering (pre, co-req, comp, content)
			list = website.getRequestParameter(request,"list",0);

			String sql = "";
			String key = "";
			String table = "";
			String[] entries = ids.split(",");
			String[] oldRDR = rdrs.split(",");
			int numberOfEntries = entries.length;
			int[] data = new int[numberOfEntries];
			PreparedStatement ps = null;
			int row = 0;
			int i = 0;

			boolean updated = false;

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case updateAction:
					switch(list){
						case Constant.COURSE_ITEM_PREREQ:
							table = "tblPrereq";
							key = "id";
							break;
						case Constant.COURSE_ITEM_COREQ:
							table = "tblcoreq";
							key = "id";
							break;
						case Constant.COURSE_ITEM_SLO:
							table = "tblcoursecomp";
							key = "compid";
							break;
						case Constant.COURSE_ITEM_CONTENT:
							table = "tblcoursecontent";
							key = "contentid";
							break;
						case Constant.COURSE_ITEM_COMPETENCIES:
							table = "tblCourseCompetency";
							key = "seq";
							break;
						case Constant.COURSE_ITEM_COURSE_RECPREP:
							table = "tblExtra";
							key = "id";
							break;
						case Constant.COURSE_ITEM_PROGRAM_SLO:
							table = "tblGenericContent";
							key = "id";
							break;
						case Constant.COURSE_ITEM_ILO:
							table = "tblGenericContent";
							key = "id";
							break;
						case Constant.COURSE_ITEM_GESLO:
							table = "tblGenericContent";
							key = "id";
							break;
					}

					try{
						// loop through number of entries on form and update to new order.
						// update only when the old and new are not the same values
						for(i=0;i<numberOfEntries;i++){
							data[i] = website.getRequestParameter(request,"order_"+entries[i],0);
							if (data[i] != Integer.parseInt(oldRDR[i])){
								sql = "UPDATE " + table + " "
									+ "SET rdr=? "
									+ "WHERE campus=? AND "
									+ "historyid=? AND "
									+ key + "=?";
								ps = connection.prepareStatement(sql);
								ps.setInt(1,data[i]);
								ps.setString(2,campus);
								ps.setString(3,kix);
								ps.setInt(4,Integer.parseInt(entries[i]));
								row = ps.executeUpdate();

								updated = true;
							}
						}

						if (updated)
							ps.close();

						message = "List was reordered successfully";

						msg.setCode(list);
						msg.setMsg(message);
					}
					catch(SQLException se){
						logger.fatal(se.toString());
						msg.setCode(-1);
						msg.setMsg("Exception");
					}
					catch(Exception e){
						logger.fatal(e.toString());
						msg.setCode(-1);
						msg.setMsg("Exception");
					}

					break;
			}
		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(connection);
		}

		session.setAttribute("aseMsg",msg);

		String url;
		if (rowsAffected == -1) {
			url = response.encodeURL("/core/msg3.jsp");
		} else {
			url = response.encodeURL("/core/msg3.jsp?rtn=crsrdr&l="+list);
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}