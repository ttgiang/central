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

public class Minutes {

   static Logger logger = Logger.getLogger(Minutes.class.getName());

   private int id;
   private String dte;
   private String attendees;
   private String userid;
   private String minutes;

   public Minutes(){

      //super();

      //created = new java.sql.Date(Calendar.getInstance().getTime().getTime());

      this.dte = "";
      this.attendees = "";
      this.userid = "";
      this.minutes = "";

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
   * setDte
   *
   * @param java.util.Date
   *
   */
   public void setDte(String value){

      this.dte = value;

   }

   /**
   * getDte
   *
   * @return java.util.Date
   */
   public String getDte(){

      return dte;

   }

   /**
   * setAttendees
   *
   * @param String
   *
   */
   public void setAttendees(String value){

      this.attendees = value;

   }

   /**
   * getAttendees
   *
   * @return String
   */
   public String getAttendees(){

      return attendees;

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
   * setMinutes
   *
   * @param String
   *
   */
   public void setMinutes(String value){

      this.minutes = value;

   }

   /**
   * getMinutes
   *
   * @return String
   */
   public String getMinutes(){

      return minutes;

   }

   /**
   * print
   */
   public String toString(){
      return
       "id: " + getId()
      + "dte: " + getDte()
      + "attendees: " + getAttendees()
      + "userid: " + getUserid()
      + "minutes: " + getMinutes()
      ;
   }

}