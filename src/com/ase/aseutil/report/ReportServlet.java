/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

//
// ReportServlet.java
//

package com.ase.aseutil.report;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import javax.servlet.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;

import com.ase.aseutil.*;

/**
 * Servlet program to connect to a database and to view report
 *
 */

public class ReportServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;

	static Logger logger = Logger.getLogger(ReportServlet.class.getName());

	private AsePool connectionPool;

	/*
	*
	*/
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		connectionPool = AsePool.getInstance();
	}

	/*
	*
	*/
	public void destroy() {

		connectionPool.destroy();

	}

	/*
	*
	*/
	public void doPost(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

	/*
	*
	*/
	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException  {

		//Logger logger = Logger.getLogger("test");

		WebSite website = new WebSite();
		String report = website.getRequestParameter(request,"rpt");

		HttpSession session = request.getSession(true);
		String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
		String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

		Connection conn = null;

		try{
			conn = connectionPool.getConnection();

			if (report.equals("ApprovedOutlinesSLO")){
				user = com.ase.aseutil.export.Export.exportSLOs(conn,campus,user,report);
			}
			else if (report.equals("ApprovedOutlinesNoSLO")){
				user = com.ase.aseutil.export.Export.exportSLOs(conn,campus,user,report);
			}
			else if (report.equals("ApprovedOutlinesComp")){
				user = com.ase.aseutil.export.Export.exportCompetencies(conn,campus,user,report);
			}
			else if (report.equals("ApprovedOutlinesNoComp")){
				user = com.ase.aseutil.export.Export.exportCompetencies(conn,campus,user,report);
			}
			else if (report.equals("OutlineApprovalStatus")){
				user = com.ase.aseutil.export.Export.exportApprovalStatus(request,conn,campus,user,report);
			}
			else {
				user = com.ase.aseutil.export.Export.exportGeneric(request,conn,campus,user,report);
			}

		}catch (Exception ex){
			logger.fatal(user + " - " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		Msg msg = new Msg();

		session.setAttribute("aseJasperMessage",user);

		String url = response.encodeURL("/core/crsrpt.jsp");

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}
}
