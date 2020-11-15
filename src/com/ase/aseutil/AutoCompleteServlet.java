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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AutoCompleteServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	private AsePool connectionPool;
	static String alphaSQL;
	static String alphaNumberSQL;
	String string1 = "";
	String string2 = "";

	static {
		alphaSQL = "";
		alphaNumberSQL = "";
	}

	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	public void destroy() {
		connectionPool.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		com.ase.aseutil.WebSite website = new com.ase.aseutil.WebSite();
		com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

		// all data comes from tblCourse with the exception of ARC
		String table = "tblCourse";
		String wildCard = "%";

		/*
		 * ltrs - letters typed
		 */

		String ltrs = website.getRequestParameter(request, "ltrs", "");
		int prm1 = website.getRequestParameter(request, "prm1", -1);
		String prm2 = website.getRequestParameter(request, "prm2", ""); // course alpha
		String prm3 = website.getRequestParameter(request, "prm3", ""); // course type
		String prm4 = website.getRequestParameter(request, "prm4", ""); // campus
		String prm5 = website.getRequestParameter(request, "prm5", ""); // progress

		if (prm5.equals("wildcard"))
			prm5 = wildCard;

		String SQL = "";

		// oracle is case sensitive
		prm2 = prm2.toUpperCase();
		if (prm4 != null && prm4.length() > 0) {
			prm4 = prm4.toUpperCase();
		}

		// dataType from session determines MS-Access or Oracle database
		HttpSession session = request.getSession(true);
		session.setAttribute("aseException", "");

		String dataType = "SQL";

		if (prm1 > -1) {

			if (prm3.equals("ARC")){
				table = "tblCourseArc";
			}

			switch (prm1) {

				case AseUtil.ALPHA:
					SQL = "SELECT upper(COURSE_ALPHA),upper(ALPHA_DESCRIPTION) FROM BannerAlpha WHERE upper(ALPHA_DESCRIPTION) like '"
							+ ltrs.toUpperCase() + wildCard + "'";

					break;

				case AseUtil.ALPHA_NUMBER:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus= '" + prm4 + "' AND upper(coursealpha)='" + prm2 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					} else {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus = '" + prm4 + "' AND coursetype='" + prm3 + "' AND upper(coursealpha)='"
								+ prm2 + "' AND progress like '" + prm5 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					}
					break;

				case AseUtil.ALPHA_NUMBER_LIMIT_PREREQ:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus = '" + prm4 + "' AND upper(coursealpha)='" + prm2 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					} else {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus = '" + prm4 + "' AND coursetype='" + prm3 + "' AND upper(coursealpha)='"
								+ prm2 + "' AND progress like '" + prm5 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					}
					break;

				case AseUtil.ALPHA_NUMBER_LIMIT_XLIST:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus = '" + prm4 + "' AND upper(coursealpha)='" + prm2 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					} else {
						SQL = "SELECT DISTINCT coursenum, RTRIM(coursenum) + ' - ' + coursetitle FROM "
								+ table
								+ " WHERE campus = '" + prm4 + "' AND coursetype='" + prm3 + "' AND upper(coursealpha)='"
								+ prm2 + "' AND progress like '" + prm5 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					}
					break;

				case AseUtil.NUMBER:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT coursenum, coursenum FROM " + table
								+ " WHERE campus = '" + prm4
								+ "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					} else {
						SQL = "SELECT DISTINCT coursenum, coursenum FROM " + table
								+ " WHERE campus = '" + prm4 + "' AND coursetype='"
								+ prm3 + "' AND coursenum like '" + ltrs + wildCard
								+ "' ORDER BY coursenum";
					}
					break;

				case AseUtil.NUMBER_ALPHA:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT upper(coursealpha), upper(coursealpha) FROM "
								+ table
								+ " WHERE campus = '"
								+ prm4
								+ "' AND coursenum='"
								+ prm2
								+ "' AND upper(coursealpha) like '"
								+ ltrs
								+ wildCard + "'";
					} else {
						SQL = "SELECT DISTINCT upper(coursealpha), upper(coursealpha) FROM "
								+ table
								+ " WHERE campus = '"
								+ prm4
								+ "' AND coursetype='"
								+ prm3
								+ "' AND coursenum='"
								+ prm2
								+ "' AND upper(coursealpha) like '"
								+ ltrs
								+ wildCard + "'";
					}
					break;

				case AseUtil.SHORT_ALPHA:
					if (prm5.equals("OUTLINE")) {
						SQL = "SELECT DISTINCT upper(coursealpha), upper(coursealpha) FROM "
								+ table
								+ " WHERE campus = '"
								+ prm4
								+ "' AND upper(coursealpha) like '"
								+ ltrs
								+ wildCard + "'";
					} else {
						SQL = "SELECT DISTINCT alpha1, alpha2 "
								+ "FROM "
								+ "( "
								+ "SELECT DISTINCT upper(coursealpha) alpha1, upper(coursealpha) alpha2 FROM "
								+ table
								+ " WHERE campus = '"
								+ prm4
								+ "' AND coursetype='"
								+ prm3
								+ "' AND upper(coursealpha) like '"
								+ ltrs
								+ wildCard + "' "
								+ "UNION "
								+ "SELECT DISTINCT upper(COURSE_ALPHA) AS alpha1, upper(COURSE_ALPHA) AS alpha2 FROM "
								+ "banneralpha "
								+ "WHERE upper(COURSE_ALPHA) like '"
								+ ltrs
								+ wildCard + "' "
								+ ") AS t "
								+ "ORDER BY alpha1 ";
						}
					break;

				case AseUtil.PROGRAM:
					SQL = "SELECT historyid, title FROM tblPrograms "
							+ "WHERE campus='" + prm4 + "' "
							+ "AND type='" + prm3 + "' "
							+ "AND UPPER(title) like '" + ltrs.toUpperCase() + wildCard + "' "
							+ "ORDER BY title";
					break;

				case AseUtil.DEGREE:
					SQL = "SELECT degree_alpha, degree_title + ' - ' + degree_alpha FROM tblDegree "
							+ "WHERE UPPER(degree_title) like '" + ltrs.toUpperCase() + wildCard + "' "
							+ "ORDER BY degree_title";
					break;

				case AseUtil.DEPARTMENT:
					SQL = "SELECT divid, divisionname + ' - ' + divisioncode FROM tblDivision "
							+ "WHERE campus='" + prm4 + "' "
							+ "AND UPPER(divisionname) like '" + ltrs.toUpperCase() + wildCard + "' "
							+ "ORDER BY divisionname";
					break;

				case AseUtil.DIVISION_BANNER:
					SQL = "SELECT DIVISION_CODE, DIVS_DESCRIPTION + ' (' + DIVISION_CODE + ')' FROM BannerDivision "
							+ "WHERE UPPER(DIVS_DESCRIPTION) like '" + ltrs.toUpperCase() + wildCard + "' "
							+ "ORDER BY DIVS_DESCRIPTION";
					break;
			}

			//System.out.println( "------------------------------" );
			//System.out.println( "ltrs: " + ltrs + ", prms: " + prm1 + "," + prm2 + "," + prm3 + "," + prm4 + "," + prm5 );
			//System.out.println ( SQL );

			Connection connection = connectionPool.getConnection();
			try {
				Statement statement = connection.createStatement();
				ResultSet results = statement.executeQuery(SQL);
				while (results.next()) {
					string1 = AseUtil.nullToBlank(results.getString(1)).trim();
					string2 = AseUtil.nullToBlank(results.getString(2)).trim();

					if (!"".equals(string1) && !"".equals(string2))
						response.getWriter().write(
								string1 + "###" + string2 + "|");
				}
				results.close();
				statement.close();
			} catch (Exception e) {
				session.setAttribute("aseException", "Exception");
				throw new ServletException(e);
			} finally {
				connectionPool.freeConnection(connection);
			}
		} // if prm2
	} // doGet

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}
