/**
* Copyright 2007- Applied Software Engineering, LLC. All rights reserved. You
* may not modify, use, reproduce, or distribute this software except in
* compliance with the terms of the License made with Applied Software
* Engineering
*
* @author ttgiang
*/

package com.ase.aseutil;

import org.apache.log4j.Logger;
import java.util.*;
import java.sql.*;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.NumericUtil;

public class Users {

   static Logger logger = Logger.getLogger(Users.class.getName());

   private int id;
   private String campus;
   private String userid;
   private String password;
   private int uh;
   private String firstname;
   private String lastname;
   private java.util.Date auditdate;

   public Users(){

      //super();

      //created = new java.sql.Date(Calendar.getInstance().getTime().getTime());

      this.id = 0;
      this.campus = null;
      this.userid = null;
      this.password = null;
      this.uh = 0;
      this.firstname = null;
      this.lastname = null;
      this.auditdate = null;

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
   * setPassword
   *
   * @param String
   *
   */
   public void setPassword(String value){

      this.password = value;

   }

   /**
   * getPassword
   *
   * @return String
   */
   public String getPassword(){

      return password;

   }

   /**
   * setUh
   *
   * @param int
   *
   */
   public void setUh(int value){

      this.uh = value;

   }

   /**
   * getUh
   *
   * @return int
   */
   public int getUh(){

      return uh;

   }

   /**
   * setFirstname
   *
   * @param String
   *
   */
   public void setFirstname(String value){

      this.firstname = value;

   }

   /**
   * getFirstname
   *
   * @return String
   */
   public String getFirstname(){

      return firstname;

   }

   /**
   * setLastname
   *
   * @param String
   *
   */
   public void setLastname(String value){

      this.lastname = value;

   }

   /**
   * getLastname
   *
   * @return String
   */
   public String getLastname(){

      return lastname;

   }

   /**
   * setAuditdate
   *
   * @param java.util.Date
   *
   */
   public void setAuditdate(java.util.Date value){

      this.auditdate = value;

   }

   /**
   * getAuditdate
   *
   * @return java.util.Date
   */
   public java.util.Date getAuditdate(){

      return auditdate;

   }

   /**
   * insert
   *
   * @param conn connection
   * @param Users users
   *
   * @return int
   *
   */
   public int insert(Connection conn,Users users){
      int rowsAffected = 0;

      try{
         String sql = "INSERT INTO users(id,campus,userid,password,uh,firstname,lastname,auditdate) VALUES(?,?,?,?,?,?,?,?)";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,users.getId());
         ps.setString(2,users.getCampus());
         ps.setString(3,users.getUserid());
         ps.setString(4,users.getPassword());
         ps.setInt(5,users.getUh());
         ps.setString(6,users.getFirstname());
         ps.setString(7,users.getLastname());
         ps.setString(8,users.getAuditdate());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Users.insert: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * update
   *
   * @param conn connection
   * @param Users users
   *
   * @return int
   */
   public int update(Connection conn,Users users){
      int rowsAffected = 0;

      try{
         String sql = "UPDATE users SET id=?,campus=?,userid=?,password=?,uh=?,firstname=?,lastname=?,auditdate=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,users.getId());
         ps.setString(2,users.getCampus());
         ps.setString(3,users.getUserid());
         ps.setString(4,users.getPassword());
         ps.setInt(5,users.getUh());
         ps.setString(6,users.getFirstname());
         ps.setString(7,users.getLastname());
         ps.setString(8,users.getAuditdate());
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Users.update: " + e.toString());
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
         String sql = "DELETE FROM users WHERE XYZ=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         rowsAffected = ps.executeUpdate();
         ps.close();
      }
      catch(Exception e){
         logger.fatal("Users.delete: " + e.toString());
      }

      return rowsAffected;

   }

   /**
   * getUsers
   *
   * @param conn connection
   * @param id int
   *
   * @return Users
   */
   public Users getUsers(Connection conn,int id){
      Users users = null ;

      try{
         AseUtil ae = new AseUtil();
         String sql = "SELECT * FROM users WHERE XYZ=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1,id);
         ResultSet rs = ps.executeQuery();
         if(rs.next()){
            users.setId(NumericUtil.getInt(rs.getInt("id"),0));
            users.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
            users.setUserid(AseUtil.nullToBlank(rs.getString("userid")));
            users.setPassword(AseUtil.nullToBlank(rs.getString("password")));
            users.setUh(NumericUtil.getInt(rs.getInt("uh"),0));
            users.setFirstname(AseUtil.nullToBlank(rs.getString("firstname")));
            users.setLastname(AseUtil.nullToBlank(rs.getString("lastname")));
            users.setAuditdate(ae.ASE_FormatDateTime(rs.geString("auditdate"),Constant.DATE_DATETIME));
         }
         rs.close();
         ps.close();
         ae = null;
      }
      catch(Exception e){
         logger.fatal("Users.delete: " + e.toString());
      }

      return users;

   }

   /**
   * print
   */
   public String toString(){
      return
       "id: " + getId()
      + "campus: " + getCampus()
      + "userid: " + getUserid()
      + "password: " + getPassword()
      + "uh: " + getUh()
      + "firstname: " + getFirstname()
      + "lastname: " + getLastname()
      + "auditdate: " + getAuditdate()
      ;
   }

} // Users