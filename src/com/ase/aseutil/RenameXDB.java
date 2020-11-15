/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// RenameXDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.Logger;

public class RenameXDB {

	static Logger logger = Logger.getLogger(RenameXDB.class.getName());

	public RenameXDB() throws Exception {}

   /**
   * insert
   *
   * @param conn 		connection
   * @param kix		String
   * @param approver	String
   *
   * @return int
   *
   */
   public int insert(Connection conn,String kix,String approver){

      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO tblRenameX(historyid,approver) VALUES(?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,kix);
         ps.setString(2,approver);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("RenameX.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * insert
   *
   * @param conn connection
   * @param RenameX renamex
   *
   * @return int
   *
   */
   public int insert(Connection conn,RenameX renamex){
      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO tblRenameX(historyid,approver,approved,comments,auditDate) VALUES(?,?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,renamex.getHistoryid());
         ps.setString(2,renamex.getApprover());

			boolean approved = false;
         if(renamex.getApproved().equals("1")){
				approved = true;
			}

         ps.setBoolean(3,approved);
         ps.setString(4,renamex.getComments());
         ps.setString(5,AseUtil.getCurrentDateTimeString());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("RenameX.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * update
   *
   * @param conn 		connection
   * @param user		String
   * @param kix		String
   * @param approved	String
   * @param comments	String
   *
   * @return int
   *
   */
   public int update(Connection conn,String user,String kix,String approved,String comments){

		//Logger logger = Logger.getLogger("test");

      int rowsAffected = 0;

      try{
			// any user may be on the approver list more than once so we update starting with the
			// min ID and while approval is not yet done

			String sql = "SELECT MIN(id) AS minID FROM tblrenamex WHERE historyid=? AND approver=? AND approved is null";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,kix);
         ps.setString(2,user);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){

				int id = NumericUtil.getInt(rs.getInt("minID"),0);

				if(id > 0){

					ps.close();

					boolean b = false;
					if(approved.equals("1")){
						b = true;
					}

					sql = "UPDATE tblRenameX SET approved=?,comments=?,auditDate=? WHERE historyid=? AND approver=? AND id=?";
					ps = conn.prepareStatement(sql);
					ps.setBoolean(1,b);
					ps.setString(2,comments);
					ps.setString(3,AseUtil.getCurrentDateTimeString());
					ps.setString(4,kix);
					ps.setString(5,user);
					ps.setInt(6,id);
					rowsAffected = ps.executeUpdate();
					ps.close();

				} // id

			}
			rs.close();
			ps.close();

      }
      catch(Exception e){
         logger.fatal("RenameX.update: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete
   *
   * @param conn connection
   * @param id int
   *
   * @return int
   */
   public int delete(Connection conn,int id){
      int rowsAffected = 0;

      try{
         String sql = "DELETE FROM tblRenameX WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("RenameX.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * getRenameX
   *
   * @param conn connection
   * @param id int
   *
   * @return RenameX
   */
   public RenameX getRenameX(Connection conn,int id){
      RenameX renamex = null ;

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT * FROM tblRenameX WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            renamex = new RenameX();
            renamex.setHistoryid(AseUtil.nullToBlank(rs.getString("historyid")));
            renamex.setApprover(AseUtil.nullToBlank(rs.getString("approver")));
            renamex.setApproved(AseUtil.nullToBlank(rs.getString("approved")));
            renamex.setComments(AseUtil.nullToBlank(rs.getString("comments")));
            renamex.setAuditDate(AseUtil.nullToBlank(rs.getString("auditDate")));
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("RenameX.delete: " + e.toString());
      }

      return renamex;

   }

   /**
   * close
   */
	public void close() throws Exception {}

}