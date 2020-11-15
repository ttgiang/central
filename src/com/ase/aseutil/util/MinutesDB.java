/**
* Copyright 2007- Applied Software Engineering, LLC. All rights reserved. You
* may not modify, use, reproduce, or distribute this software except in
* compliance with the terms of the License made with Applied Software
* Engineering
*
* @author ttgiang
*/

package com.ase.aseutil.util;

import org.apache.log4j.Logger;

import java.util.*;
import java.sql.*;

import java.util.LinkedList;
import java.util.List;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Generic;

public class MinutesDB {

   static Logger logger = Logger.getLogger(MinutesDB.class.getName());

   /**
   * insert
   *
   * @param conn 		connection
   * @param minutes	MinutesDB
   *
   * @return int
   *
   */
   public int insert(Connection conn,Minutes minutes){
      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO tblMinutes(dte,attendees,userid,minutes) VALUES(?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,minutes.getDte());
         ps.setString(2,minutes.getAttendees());
         ps.setString(3,minutes.getUserid());
         ps.setString(4,minutes.getMinutes());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("MinutesDB.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * update
   *
   * @param conn 		connection
   * @param minutes	Minutes
   *
   * @return int
   */
   public int update(Connection conn,Minutes minutes){
      int rowsAffected = 0;

      try{
         String sql = "UPDATE tblMinutes SET dte=?,attendees=?,userid=?,minutes=? WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,AseUtil.getCurrentDateTimeString());
         ps.setString(2,minutes.getAttendees());
         ps.setString(3,minutes.getUserid());
         ps.setString(4,minutes.getMinutes());
         ps.setInt(5,minutes.getId());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("MinutesDB.update: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete
   *
   * @param conn 	connection
   * @param id 	int
   *
   * @return int
   */
   public int delete(Connection conn,int id){
      int rowsAffected = 0;

      try{
         String sql = "DELETE FROM tblMinutes WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("MinutesDB.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * getMinutes
   *
   * @param conn connection
   * @param id int
   *
   * @return Minutes
   */
   public Minutes getMinutes(Connection conn,int id){
      Minutes minutes = null ;

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT * FROM tblMinutes WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            minutes.setDte(ae.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME));
            minutes.setAttendees(AseUtil.nullToBlank(rs.getString("attendees")));
            minutes.setUserid(AseUtil.nullToBlank(rs.getString("userid")));
            minutes.setMinutes(AseUtil.nullToBlank(rs.getString("minutes")));
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("MinutesDB.delete: " + e.toString());
      }

      return minutes;

   }

	/*
	 * getMinutes - returns list of programs or outlines to review for user
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return List
	 */
	public static List<Generic> getMinutes(Connection conn) {

		List<Generic> genericData = null;

		try {
			if (genericData == null){

				AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT * FROM tblMinutes ORDER BY dte DESC";

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											"" + rs.getInt("id"),
											AseUtil.nullToBlank(rs.getString("userid")),
											AseUtil.nullToBlank(rs.getString("attendees")),
											ae.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_SHORT),
											"",
											"",
											"",
											"",
											"",
											""
										));
				} // while
				rs.close();
				ps.close();

				ae = null;

			} // if
		} catch (SQLException e) {
			logger.fatal("MinutesDB: getMinutes\n" + e.toString());
		} catch (Exception e) {
			logger.fatal("MinutesDB: getMinutes\n" + e.toString());
		}

		return genericData;
	}

}