/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 * TODO: set sql to use toSQL
 */

package com.ase.aseutil;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class NumberAutoCompleteServlet extends HttpServlet {

	static Logger logger = Logger.getLogger(NumberAutoCompleteServlet.class.getName());

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;
	String string1 = "";
	String string2 = "";

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		com.ase.aseutil.WebSite website = new com.ase.aseutil.WebSite();
		com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

		String wildCard = "%";
		String sql = "";

		// ltrs - letters typed
		String ltrs = website.getRequestParameter(request, "ltrs", "");
		int prm1 = website.getRequestParameter(request, "prm1", -1);
		String prm2 = website.getRequestParameter(request, "prm2", ""); // campus
		String prm3 = website.getRequestParameter(request, "prm3", ""); // alpha
		String prm4 = website.getRequestParameter(request, "prm4", ""); //
		String prm5 = website.getRequestParameter(request, "prm5", ""); //

		sql = "SELECT idx as one,idx as two "
			+ "FROM tblidx "
			+ "WHERE idx NOT IN "
			+ "( "
			+ "SELECT coursenum "
			+ "FROM tblCourse "
			+ "WHERE campus=? "
			+ "AND coursealpha=? "
			+ ") "
			+ "AND idx LIKE '" + ltrs + "%' "
			+ "ORDER BY seq";

		//System.out.println( "------------------------------" );
		//System.out.println( "ltrs: " + ltrs + ", prms: " + prm1 + "," + prm2 + "," + prm3 + "," + prm4 + "," + prm5 );
		//System.out.println ( sql );

		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		Connection conn = connectionPool.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,prm2);
			ps.setString(2,prm3);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				string1 = AseUtil.nullToBlank(rs.getString("one")).trim();
				string2 = AseUtil.nullToBlank(rs.getString("two")).trim();

				if (!string1.equals(Constant.BLANK) && !string2.equals(Constant.BLANK)){
					response.getWriter().write(string1 + "###" + string2 + "|");
				}
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			session.setAttribute("aseException", "Exception");
			logger.fatal(e.toString());
			throw new ServletException(e);
		} catch (Exception e) {
			session.setAttribute("aseException", "Exception");
			logger.fatal(e.toString());
			throw new ServletException(e);
		} finally {
			connectionPool.freeConnection(conn);
		}

	} // doGet

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}
