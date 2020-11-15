/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.test;

import com.ase.aseutil.*;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ApprovalUtil {

	static Logger logger = Logger.getLogger(ApprovalUtil.class.getName());

	public static int getApprovalRouteToUse(Connection conn,String campus) throws Exception {

		// retrieves the most used route number

		int route = 0;

		try{
			String sql = "";

			sql = "select * "
			+ "from "
			+ "( "
			+ "select campus, route, count(route) as routes "
			+ "from tblcourse  "
			+ "where campus=? "
			+ "and route > 0 "
			+ "group by campus, route  "
			+ ") as s "
			+ "where routes "
			+ "in  "
			+ "( "
			+ "select max(routes) "
			+ "from "
			+ "( "
			+ "select campus, route, count(route) as routes "
			+ "from tblcourse  "
			+ "where campus=? "
			+ "and route > 0 "
			+ "group by campus, route  "
			+ ") as t "
			+ ") ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				route = NumericUtil.getInt(rs.getInt("route"),0);
			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("Test: approvalY " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test: approvalY " + e.toString());
		}

		return route;

	}

}