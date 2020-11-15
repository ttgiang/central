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

import org.apache.log4j.Logger;

public class ApproverServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(ApproverServlet.class.getName());

	public void init() throws ServletException {}

	public void destroy() {}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);

		session.setAttribute("aseException", "");

		String sAction = "";
		String message = "";
		String approvers = "";
		String delegated = "";
		int level = 0;
		int route = 0;
		boolean multiLevel = false;

		boolean experimental = false;
		int excludeFromExperimental = 0;

		String id;
		String seq;
		String campus = "";
		String user = "";
		int iAction = 0;
		int rowsAffected = 0;

		String availableDate = "";
		String startDate = "";
		String endDate = "";

		int applyDate = 0;

		boolean debug = false;

		Connection connection = AsePool.createLongConnection();

		try {
			if (debug) logger.info("---------------------------- ApproverServlet - START ");

			WebSite website = new WebSite();

			//campus = session.getAttribute("aseCampus").toString();
			campus = website.getRequestParameter(request,"aseCampus","",true);
			user = website.getRequestParameter(request,"aseUserName","",true);

			id = website.getRequestParameter(request, "lid");
			seq = website.getRequestParameter(request, "seq");

			/*
			 * there is a possible 10 approvers for each phase read from the
			 * form, and concat into a single CSV
			 *
			 * no longer doing this
			 *
			 * for ( i = 0; i < 10; i++ ){ temp =
			 * website.getRequestParameter(request,"approver_" + i); if ( temp !=
			 * null && temp.length() > 0 ){
			 *
			 * if ( approvers.length() > 0 ) approvers = approvers + ",";
			 *
			 * approvers = approvers + temp; } }
			 */

			route = website.getRequestParameter(request,"route",0);
			approvers = website.getRequestParameter(request,"campusUser");
			delegated = website.getRequestParameter(request,"delegated");
			level = website.getRequestParameter(request,"multilevel", 0);
			if (level == 0)
				multiLevel = false;
			else
				multiLevel = true;

			excludeFromExperimental = website.getRequestParameter(request, "experimental", 0);
			if (excludeFromExperimental == 0)
				experimental = false;
			else
				experimental = true;

			availableDate = website.getRequestParameter(request,"availableDate","");
			startDate = website.getRequestParameter(request,"startDate","");
			endDate = website.getRequestParameter(request,"endDate","");
			applyDate = website.getRequestParameter(request,"applyDate",0);

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

			if (sAction.equalsIgnoreCase("cancel")) {iAction = cancelAction;}
			if (sAction.equalsIgnoreCase("delete")) {iAction = deleteAction;}
			if (sAction.equalsIgnoreCase("insert")) {iAction = insertAction;}
			if (sAction.equalsIgnoreCase("submit")) {iAction = updateAction;}

			if (debug){
				logger.info("campus: " + campus);
				logger.info("id: " + id);
				logger.info("user: " + user);
				logger.info("route: " + route);
				logger.info("approvers: " + approvers);
				logger.info("delegated: " + delegated);
				logger.info("level: " + level);
				logger.info("availableDate: " + availableDate);
				logger.info("startDate: " + startDate);
				logger.info("endDate: " + endDate);
			}

			if (availableDate == null || availableDate.length() == 0)
				availableDate = null;

			if (startDate == null || startDate.length() == 0)
				startDate = null;

			if (endDate == null || endDate.length() == 0)
				endDate = null;

			String duplicate = "Duplicate approvers ("+approvers+") not permitted for approval sequence";

			Approver approverDB = new Approver(id,
															seq,
															approvers,
															delegated,
															multiLevel,
															experimental,
															user,
															AseUtil.getCurrentDateTimeString(),
															campus,
															route,
															availableDate,
															startDate,
															endDate);

			switch (iAction) {
				case cancelAction:
					message = "Operation was cancelled";
					break;
				case deleteAction:
					rowsAffected = ApproverDB.deleteApprover(connection,id,route);

					if (rowsAffected == 1)
						message = campus + " approver <b>" + approvers + "</b> at sequence " + seq + " deleted successfully";
					else
						message = "Unable to delete " + campus + " approver <b>" + approvers + "</b> at sequence " + seq + "";

					AseUtil.logAction(connection,
											user,
											"Approval Routing",
											"Approver deleted (route: " + route + "; Approver: " + approvers + " )","","",campus,"");

					break;
				case insertAction:

					rowsAffected = ApproverDB.insertApprover(connection,approverDB,applyDate);

					if (rowsAffected >= 1)
						message = campus + " approver <b>" + approvers + "</b> at sequence " + seq + " inserted successfully";
					else
						message = "Unable to insert " + campus + " approver <b>" + approvers + "</b> at sequence " + seq + "";

					AseUtil.logAction(connection,
											user,
											"Approval Routing",
											"Approver Added (route: " + route + "; Approver: " + approvers + " )","","",campus,"");

					break;
				case updateAction:

					rowsAffected = ApproverDB.updateApprover(connection,approverDB,applyDate);

					if (rowsAffected >= 1)
						message = campus + " approver <b>" + approvers + "</b> at sequence " + seq + " updated successfully";
					else
						message = "Unable to update " + campus + " approver <b>" + approvers + "</b> at sequence " + seq + "";

					AseUtil.logAction(connection,
											user,
											"Approval Routing",
											"Approval updated (route: " + route + "; seq: " + seq + "; Approver: " + approvers + " )","","",campus,"");

					break;
			}

			session.setAttribute("aseApplicationMessage", message);

			if (debug) logger.info("---------------------------- ApproverServlet - END ");

		} catch (Exception e) {
			session.setAttribute("aseApplicationMessage", e.toString());
			session.setAttribute("aseException", "Exception");
			throw new ServletException(e);
		} finally {
			try{
				if (connection != null){
					connection.close();
					connection = null;
				}
			}
			catch(Exception e){
				//
			}
		}

		String url = response.encodeURL("/core/msg.jsp?rtn=appridx&route="+route);

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}