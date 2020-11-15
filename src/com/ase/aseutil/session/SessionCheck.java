/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 */

//
// SessionCheck.java
//

package com.ase.aseutil.session;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Generic;
import com.ase.aseutil.UserDB;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.LinkedList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

public class SessionCheck extends HttpServlet {

	static Logger logger = Logger.getLogger(SessionCheck.class.getName());

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {

		HttpSession session = request.getSession(false);

		if (session == null){
			response.sendRedirect("/central/exp/notauth.jsp");
		} else {
			response.sendRedirect("/central/core/cas.jsp");
		}

	}

    /**
     * checkSession
     * <p>
     * @param request	HttpServletRequest
     * <p>
     * @return String
     */
    public static String checkSession(HttpServletRequest request) {

		String rtn = "";

		try {
			if (request == null){
				rtn = "";
			}
			else{

				HttpSession session = request.getSession(false);

				if (session == null){
					rtn = "";
				}
				else{
					String aseApplicationTitle = AseUtil.nullToBlank((String)session.getAttribute("aseApplicationTitle"));
					String aseCampus = AseUtil.nullToBlank((String)session.getAttribute("aseCampus"));
					String aseUserName = AseUtil.nullToBlank((String)session.getAttribute("aseUserName"));
					String aseDept = AseUtil.nullToBlank((String)session.getAttribute("aseDept"));
					String aseDivision = AseUtil.nullToBlank((String)session.getAttribute("aseDivision"));

					rtn = "r2d2";

					if (	aseApplicationTitle.equals(Constant.BLANK) ||
							aseCampus.equals(Constant.BLANK) ||
							aseUserName.equals(Constant.BLANK) ||
							aseDept.equals(Constant.BLANK) ||
							aseDivision.equals(Constant.BLANK) ) {
						rtn = "";
					} //

				}

			} // request

		} catch (Exception e) {
			logger.fatal("SessionChecker: checkSession - " + e.toString());
		}

		return rtn;
    }

	/*
	 * getSessionUsage
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	idx		int
	 *	<p>
	 *	@return int
	 */
	public static List<Generic> getSessionUsage(Connection conn,String campus,int idx) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try{
			if (genericData == null){

				AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				// active participant of a post
				String sql = "SELECT id,UserName,campus,Page,Alpha,Num,Audit AS LastAction,Start AS SessionStart,"
							+ "EndDate AS SessionEnd,DATEDIFF(minute, start, enddate) AS TimeOnline "
							+ "FROM tblJSID WHERE campus=? ";

				if (idx>0){
					sql += " AND username LIKE '" + (char)idx + "%' ";
				}

				sql += "  ORDER BY audit DESC";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){

					String userid = AseUtil.nullToBlank(rs.getString("username"));

					genericData.add(new Generic(
											userid,
											AseUtil.nullToBlank(rs.getString("page")),
											AseUtil.nullToBlank(rs.getString("alpha")),
											AseUtil.nullToBlank(rs.getString("num")),
											AseUtil.nullToBlank(ae.ASE_FormatDateTime(rs.getString("LastAction"),Constant.DATE_DATETIME)),
											AseUtil.nullToBlank(ae.ASE_FormatDateTime(rs.getString("SessionStart"),Constant.DATE_DATETIME)),
											AseUtil.nullToBlank(ae.ASE_FormatDateTime(rs.getString("SessionEnd"),Constant.DATE_DATETIME)),
											AseUtil.nullToBlank(rs.getString("TimeOnline")),
											UserDB.getLastFirstName(conn,userid)
										));
				} // rs
				rs.close();
				ps.close();

				ae = null;

			} // GenericData == null
		}
		catch(SQLException e){
			logger.fatal("SessionCheck - getSessionUsage: " + e.toString());
			return null;
		}
		catch(Exception e){
			logger.fatal("SessionCheck - getSessionUsage: " + e.toString());
			return null;
		}

		return genericData;
	} // SessionCheck - getSessionUsage


}
