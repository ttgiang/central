/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// HealthCheck.java
//
package com.ase.aseutil.healthcheck;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Html;

/**
 *
 */
public class HealthCheck {

	static Logger logger = Logger.getLogger(HealthCheck.class.getName());

	public HealthCheck() throws Exception {}

	/**
	 * tg00000
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return	int
	 */
	public static int tg00000(Connection conn){

		// correct problems where approved course does not have coursedate.
		// this correct is made only when a course exists as CUR AND PRE
		// because a PRE exists, that means the CUR should have a coursedate
		// a coursedate is same as auditdate

		// this may have occurred only in the beginning (around 2009)

		int rowsAffected = 0;

		String sql = "SELECT campus, CourseAlpha, CourseNum, COUNT(CourseNum) AS counter "
					+ "FROM tblCourse GROUP BY campus, CourseAlpha, CourseNum HAVING (COUNT(CourseNum) > 1)";
		try{

			AseUtil aseUtil = new AseUtil();

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next() ){
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("CourseAlpha"));
				String num = AseUtil.nullToBlank(rs.getString("CourseNum"));

				sql = "SELECT historyid, campus, coursetype, progress, coursedate, auditdate "
						+ "FROM tblCourse WHERE campus=? AND CourseAlpha=? AND coursenum=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ps2.setString(2,alpha);
				ps2.setString(3,num);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next() ){
					String kix = AseUtil.nullToBlank(rs2.getString("historyid"));
					String progress = AseUtil.nullToBlank(rs2.getString("progress"));
					String type = AseUtil.nullToBlank(rs2.getString("coursetype"));
					String courseDate = aseUtil.ASE_FormatDateTime(rs2.getString("courseDate"),Constant.DATE_DATETIME);
					String auditDate = aseUtil.ASE_FormatDateTime(rs2.getString("auditDate"),Constant.DATE_DATETIME);

					if(progress.equals("APPROVED") && type.equals("CUR") && courseDate.equals("") && !auditDate.equals("")){

						System.out.println(campus + " - " + alpha + " - " + num  + auditDate );

						sql = "UPDATE tblCourse SET coursedate=? WHERE campus=? AND historyid=? AND CourseAlpha=? AND coursenum=? AND coursetype=?";
						PreparedStatement ps3 = conn.prepareStatement(sql);
						ps3.setString(1,auditDate);
						ps3.setString(2,campus);
						ps3.setString(3,kix);
						ps3.setString(4,alpha);
						ps3.setString(5,num);
						ps3.setString(6,type);
						ps3.executeUpdate();
						ps3.close();

						++rowsAffected;

					}
				}

				rs2.close();
				ps2.close();

			}

			rs.close();
			ps.close();

			aseUtil = null;

		}
		catch(SQLException e){
			logger.fatal("HealthCheck.tg00000 - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("HealthCheck.tg00000 - " + e.toString());
		}

		return rowsAffected;

	}

}
