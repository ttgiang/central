/**
* Copyright 2007- Applied Software Engineering, LLC. All rights reserved. You
* may not modify, use, reproduce, or distribute this software except in
* compliance with the terms of the License made with Applied Software
* Engineering
*
* @author ttgiang
*/

package com.ase.aseutil.db;

import org.apache.log4j.Logger;

import java.io.*;
import java.util.*;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.NumericUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Generic;

public class FileDrop {

   static Logger logger = Logger.getLogger(FileDrop.class.getName());

   private int id;
   private String campus;
   private String userid;
   private String location;
   private String auditdate;
   private String src;
   private String descr;

   public FileDrop(){

      this.id = 0;
      this.campus = null;
      this.userid = null;
      this.location = null;
      this.auditdate = null;
      this.src = null;
      this.descr = null;

   }

   /**
   * setId
   *
   * @param int
   *
   */
   public void setId(int value){

      this.id = value;

   }

   /**
   * getId
   *
   * @return int
   */
   public int getId(){

      return id;

   }

   /**
   * setCampus
   *
   * @param String
   *
   */
   public void setCampus(String value){

      this.campus = value;

   }

   /**
   * getCampus
   *
   * @return String
   */
   public String getCampus(){

      return campus;

   }

   /**
   * setUserid
   *
   * @param String
   *
   */
   public void setUserid(String value){

      this.userid = value;

   }

   /**
   * getUserid
   *
   * @return String
   */
   public String getUserid(){

      return userid;

   }

   /**
   * setLocation
   *
   * @param String
   *
   */
   public void setLocation(String value){

      this.location = value;

   }

   /**
   * getLocation
   *
   * @return String
   */
   public String getLocation(){

      return location;

   }

   /**
   * setAuditdate
   *
   * @param String
   *
   */
   public void setAuditdate(String value){

      this.auditdate = value;

   }

   /**
   * getAuditdate
   *
   * @return String
   */
   public String getAuditdate(){

      return auditdate;

   }

   /**
   * setSrc
   *
   * @param String
   *
   */
   public void setSrc(String value){

      this.src = value;

   }

   /**
   * getSrc
   *
   * @return String
   */
   public String getSrc(){

      return src;

   }

   /**
   * setDescr
   *
   * @param String
   *
   */
   public void setDescr(String value){

      this.descr = value;

   }

   /**
   * getDescr
   *
   * @return String
   */
   public String getDescr(){

      return descr;

   }

   /**
   * insert
   *
   * @param conn connection
   * @param FileDrop filedrop
   *
   * @return int
   *
   */
   public int insert(Connection conn,FileDrop filedrop){
      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO tblfiledrop(campus,userid,location,auditdate,src,descr) VALUES(?,?,?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,filedrop.getCampus());
         ps.setString(2,filedrop.getUserid());
         ps.setString(3,filedrop.getLocation());
         ps.setString(4,AseUtil.getCurrentDateTimeString());
         ps.setString(5,filedrop.getSrc());
         ps.setString(6,filedrop.getDescr());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * insert
   *
   * @param conn 		connection
   * @param campus	String
   * @param userid	String
   * @param location	String
   * @param src		String
   * @param descr		String
   *
   * @return int
   *
   */
   public int insert(Connection conn,String campus,String userid,String location,String src){

		return insert(conn,campus,userid,location,src,null);
	}

   public int insert(Connection conn,String campus,String userid,String location,String src,String descr){

      int rowsAffected = 0;

      try{
			// before adding, delete data older than 5 days
			delete(conn);

         String sql = "INSERT INTO tblfiledrop(campus,userid,location,auditdate,src,descr) VALUES(?,?,?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,userid);
         ps.setString(3,location);
         ps.setString(4,AseUtil.getCurrentDateTimeString());
         ps.setString(5,src);
         ps.setString(6,descr);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.insert: " + e.toString());
      }

      return rowsAffected;

   }


   /**
   * update
   *
   * @param conn connection
   * @param FileDrop filedrop
   *
   * @return int
   */
   public int update(Connection conn,FileDrop filedrop){
      int rowsAffected = 0;

      try{
         String sql = "UPDATE tblfiledrop SET campus=?,userid=?,location=?,auditdate=? WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,filedrop.getCampus());
         ps.setString(2,filedrop.getUserid());
         ps.setString(3,filedrop.getLocation());
         ps.setString(4,AseUtil.getCurrentDateTimeString());
         ps.setInt(5,filedrop.getId());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.update: " + e.toString());
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
         String sql = "DELETE FROM tblfiledrop WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * delete files 5 days and older
   *
   * @param conn connection
   *
   * @return int
   */
   public int delete(Connection conn){
      int rowsAffected = 0;

      try{
         String sql = "delete from tblfiledrop where auditdate < (getdate()-5)";
         PreparedStatement ps = conn.prepareStatement(sql);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * clearDroppedFiles
   *
   * @param conn 		connection
   * @param campus	String
   * @param user		String
   *
   * @return int
   */
   public int clearDroppedFiles(Connection conn,String campus,String user){

		//Logger logger = Logger.getLogger("test");

      int rowsAffected = 0;

      try{

			File file = null;

			String currentDrive = AseUtil.getCurrentDrive();

         String sql = "select id, location from tblfiledrop where campus=? AND userid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,user);
         ResultSet rs = ps.executeQuery();
         while(rs.next()){

				boolean delete = false;
				boolean deleteFile = false;

				int id = rs.getInt("id");
				String location = AseUtil.nullToBlank(rs.getString("location"));

				// which message type do we have
				if(location.toLowerCase().contains("processing error")){
					delete = true;

				}
				else{
					location = currentDrive + ":\\tomcat\\webapps\\" + location.replace("/","\\").substring(1);
					file = new File(location);
					if(file.exists()){
						delete = true;
						deleteFile = true;
					}
				} // processing error

				// do we delete?
				if(delete){
					sql = "delete from tblfiledrop where campus=? AND userid=? and id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,campus);
					ps2.setString(2,user);
					ps2.setInt(3,id);
					rowsAffected = ps2.executeUpdate();
					ps2.close();

					if(rowsAffected == 1 && deleteFile){
						try{
							file.delete();
						}
						catch(Exception e){
							logger.fatal(e.toString());
						}
					}
				}

			} // while
			rs.close();
         ps.close();

      }
      catch(Exception e){
         logger.fatal("FileDrop.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * getFileDrop
   *
   * @param conn connection
   * @param id int
   *
   * @return FileDrop
   */
   public FileDrop getFileDrop(Connection conn,int id){
      FileDrop filedrop = null ;

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT * FROM tblfiledrop WHERE id=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,filedrop.getId());
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            filedrop.setId(NumericUtil.getInt(rs.getInt("id"),0));
            filedrop.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
            filedrop.setUserid(AseUtil.nullToBlank(rs.getString("userid")));
            filedrop.setLocation(AseUtil.nullToBlank(rs.getString("location")));
           	filedrop.setAuditdate(ae.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
            filedrop.setSrc(AseUtil.nullToBlank(rs.getString("src")));
            filedrop.setDescr(AseUtil.nullToBlank(rs.getString("descr")));
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("FileDrop.getFileDrop: " + e.toString());
      }

      return filedrop;

   }

   /**
   * getFileCount - returns number of files dropped for user at campus
   *
   * @param conn 		connection
   * @param campus	String
   * @param user		String
   *
   * @return int
   */
   public int getFileCount(Connection conn,String campus,String user){

      int rowsAffected = 0;

      try{
         String sql = "SELECT count(id) as counter FROM tblfiledrop WHERE campus=? AND userid=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1,campus);
         ps.setString(2,user);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
				rowsAffected = com.ase.aseutil.NumericUtil.getInt(rs.getInt("counter"),0);
         }
         rs.close();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("FileDrop.getFileCount: " + e.toString());
      }

      return rowsAffected;

   }

	/*
	 * getDroppedFiles
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getDroppedFiles(Connection conn,String campus,String user) throws Exception {

		List<Generic> genericData = null;

		try {
			if (genericData == null){
	         AseUtil ae = new AseUtil();

            genericData = new LinkedList<Generic>();

				String sql = "SELECT location,auditdate,src,descr FROM tblFiledrop WHERE campus=? AND userid=? ORDER BY auditdate DESC";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					genericData.add(new Generic(
											AseUtil.nullToBlank(rs.getString("location")),
											ae.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME),
											AseUtil.nullToBlank(rs.getString("src")),
											AseUtil.nullToBlank(rs.getString("descr")),
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
			logger.fatal("FileDrop: getDroppedFiles - " + e.toString());
			return null;
		} catch (Exception e) {
			logger.fatal("FileDrop: getDroppedFiles - " + e.toString());
			return null;
		}

		return genericData;
	}

   /**
   * print
   */
   public String toString(){
      return
       "id: " + getId()
      + "campus: " + getCampus()
      + "userid: " + getUserid()
      + "location: " + getLocation()
      + "auditdate: " + getAuditdate()
      + "src: " + getSrc()
      + "descr: " + getDescr()
      ;
   }

}