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

public class RenameX {

   static Logger logger = Logger.getLogger(RenameX.class.getName());

   private int id;
   private String historyid;
   private String approver;
   private String approved;
   private String comments;
   private String auditDate;

   public RenameX(){

      this.historyid = null;
      this.approver = null;
      this.approved = null;
      this.comments = null;
      this.auditDate = null;

   }

   public RenameX(String historyid,String approver,String approved,String comments){

      this.historyid = historyid;
      this.approver = approver;
      this.approved = approved;
      this.comments = comments;

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
   * setHistoryid
   *
   * @param String
   *
   */
   public void setHistoryid(String value){

      this.historyid = value;

   }

   /**
   * getHistoryid
   *
   * @return String
   */
   public String getHistoryid(){

      return historyid;

   }

   /**
   * setApprover
   *
   * @param String
   *
   */
   public void setApprover(String value){

      this.approver = value;

   }

   /**
   * getApprover
   *
   * @return String
   */
   public String getApprover(){

      return approver;

   }

   /**
   * setApproved
   *
   * @param String
   *
   */
   public void setApproved(String value){

      this.approved = value;

   }

   /**
   * getApproved
   *
   * @return String
   */
   public String getApproved(){

      return approved;

   }

   /**
   * setComments
   *
   * @param String
   *
   */
   public void setComments(String value){

      this.comments = value;

   }

   /**
   * getComments
   *
   * @return String
   */
   public String getComments(){

      return comments;

   }

   /**
   * setAuditDate
   *
   * @param String
   *
   */
   public void setAuditDate(String value){

      this.auditDate = value;

   }

   /**
   * getAuditDate
   *
   * @return String
   */
   public String getAuditDate(){

      return auditDate;

   }

   /**
   * print
   */
   public String toString(){
      return
       "id: " + getId()
      + "historyid: " + getHistoryid()
      + "approver: " + getApprover()
      + "approved: " + getApproved()
      + "comments: " + getComments()
      + "auditDate: " + getAuditDate()
      ;
   }
}