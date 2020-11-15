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

public class Rename {

   static Logger logger = Logger.getLogger(Rename.class.getName());

   private int id;
   private String campus;
   private String historyid;
   private String proposer;
   private String fromAlpha;
   private String fromNum;
   private String toAlpha;
   private String toNum;
   private String progress;
   private String justification;
   private String approvers;

   public Rename(){
      this.campus = null;
      this.historyid = null;
      this.proposer = null;
      this.fromAlpha = null;
      this.fromNum = null;
      this.toAlpha = null;
      this.toNum = null;
      this.progress = null;
      this.justification = null;
      this.approvers = null;
   }

   public Rename(String campus,
   					String historyid,
   					String proposer,
   					String fromAlpha,
   					String fromNum,
   					String toAlpha,
   					String toNum,
   					String justification){
      this.campus = campus;
      this.historyid = historyid;
      this.proposer = proposer;
      this.fromAlpha = fromAlpha;
      this.fromNum = fromNum;
      this.toAlpha = toAlpha;
      this.toNum = toNum;
      this.justification = justification;
      this.approvers = "";
   }

   public Rename(String campus,
   					String historyid,
   					String proposer,
   					String fromAlpha,
   					String fromNum,
   					String toAlpha,
   					String toNum,
   					String justification,
   					String approvers){
      this.campus = campus;
      this.historyid = historyid;
      this.proposer = proposer;
      this.fromAlpha = fromAlpha;
      this.fromNum = fromNum;
      this.toAlpha = toAlpha;
      this.toNum = toNum;
      this.justification = justification;
      this.approvers = approvers;
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
   * setProposer
   *
   * @param String
   *
   */
   public void setProposer(String value){

      this.proposer = value;

   }

   /**
   * getProposer
   *
   * @return String
   */
   public String getProposer(){

      return proposer;

   }

   /**
   * setFromAlpha
   *
   * @param String
   *
   */
   public void setFromAlpha(String value){

      this.fromAlpha = value;

   }

   /**
   * getFromAlpha
   *
   * @return String
   */
   public String getFromAlpha(){

      return fromAlpha;

   }

   /**
   * setFromNum
   *
   * @param String
   *
   */
   public void setFromNum(String value){

      this.fromNum = value;

   }

   /**
   * getFromNum
   *
   * @return String
   */
   public String getFromNum(){

      return fromNum;

   }

   /**
   * setToAlpha
   *
   * @param String
   *
   */
   public void setToAlpha(String value){

      this.toAlpha = value;

   }

   /**
   * getToAlpha
   *
   * @return String
   */
   public String getToAlpha(){

      return toAlpha;

   }

   /**
   * setToNum
   *
   * @param String
   *
   */
   public void setToNum(String value){

      this.toNum = value;

   }

   /**
   * getToNum
   *
   * @return String
   */
   public String getToNum(){

      return toNum;

   }

   /**
   * setProgress
   *
   * @param String
   *
   */
   public void setProgress(String value){

      this.progress = value;

   }

   /**
   * getProgress
   *
   * @return String
   */
   public String getProgress(){

      return progress;

   }

   /**
   * setJustification
   *
   * @param String
   *
   */
   public void setJustification(String value){

      this.justification = value;

   }

   /**
   * getJustification
   *
   * @return String
   */
   public String getJustification(){

      return justification;

   }

   /**
   * setApprovers
   *
   * @param String
   *
   */
   public void setApprovers(String value){

      this.approvers = value;

   }

   /**
   * getApprovers
   *
   * @return String
   */
   public String getApprovers(){

      return approvers;

   }

   /**
   * print
   */
   public String toString(){
      return
       "id: " + getId()
      + "campus: " + getCampus()
      + "historyid: " + getHistoryid()
      + "proposer: " + getProposer()
      + "fromAlpha: " + getFromAlpha()
      + "fromNum: " + getFromNum()
      + "toAlpha: " + getToAlpha()
      + "toNum: " + getToNum()
      + "progress: " + getProgress()
      + "justification: " + getJustification()
      + "approvers: " + getApprovers()
      ;
   }

}