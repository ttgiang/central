/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// UserLog.java
//
package com.ase.aseutil;

import org.apache.log4j.Logger;

import java.util.LinkedList;
import java.util.List;

import java.sql.*;

public class UserLog {

	static Logger logger = Logger.getLogger(UserLog.class.getName());

	/**
	* Id numeric identity
	**/
	private int id = 0;

	/**
	* Userid varchar
	**/
	private String userid = null;

	/**
	* Script varchar
	**/
	private String script = null;

	/**
	* Action varchar
	**/
	private String action = null;

	/**
	* Alpha varchar
	**/
	private String alpha = null;

	/**
	* Num varchar
	**/
	private String num = null;

	/**
	* Datetime smalldatetime
	**/
	private String datetime = null;

	/**
	* Campus varchar
	**/
	private String campus = null;

	/**
	* Historyid varchar
	**/
	private String historyid = null;

	public UserLog (int id,String userid,String script,String action,String alpha,String num,String datetime,String campus,String historyid){
		this.id = id;
		this.userid = userid;
		this.script = script;
		this.action = action;
		this.alpha = alpha;
		this.num = num;
		this.datetime = datetime;
		this.campus = campus;
		this.historyid = historyid;
	}

	/**
	** Id numeric identity
	**/
	public int getId(){ return this.id; }
	public void setId(int value){ this.id = value; }

	/**
	** Userid varchar
	**/
	public String getUserid(){ return this.userid; }
	public void setUserid(String value){ this.userid = value; }

	/**
	** Script varchar
	**/
	public String getScript(){ return this.script; }
	public void setScript(String value){ this.script = value; }

	/**
	** Action varchar
	**/
	public String getAction(){ return this.action; }
	public void setAction(String value){ this.action = value; }

	/**
	** Alpha varchar
	**/
	public String getAlpha(){ return this.alpha; }
	public void setAlpha(String value){ this.alpha = value; }

	/**
	** Num varchar
	**/
	public String getNum(){ return this.num; }
	public void setNum(String value){ this.num = value; }

	/**
	** Datetime smalldatetime
	**/
	public String getDatetime(){ return this.datetime; }
	public void setDatetime(String value){ this.datetime = value; }

	/**
	** Campus varchar
	**/
	public String getCampus(){ return this.campus; }
	public void setCampus(String value){ this.campus = value; }

	/**
	** Historyid varchar
	**/
	public String getHistoryid(){ return this.historyid; }
	public void setHistoryid(String value){ this.historyid = value; }

	/*
	 * getActivities
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	userid		String
	 * @param	srch			String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	activity		String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getActivities(Connection conn,
															String campus,
															String userid,
															String action,
															String srch,
															String alpha,
															String num,
															String activity) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			AseUtil ae = new AseUtil();

			genericData = new LinkedList<Generic>();

			userid = ae.toSQL(userid,1).replace("Null","").replace("'","");
			action = ae.toSQL(action,1).replace("Null","").replace("'","");
			srch = ae.toSQL(srch,1).replace("Null","").replace("'","");
			alpha = ae.toSQL(alpha,1).replace("Null","").replace("'","");
			num = ae.toSQL(num,1).replace("Null","").replace("'","");
			activity = ae.toSQL(activity,1).replace("Null","").replace("'","");

			String sql = "SELECT id,userid,script,substring([action],0,75) as [action],alpha,num,[datetime] "
								+ "FROM vw_userlog "
								+ "WHERE (campus='SYS' OR campus=?) "
								+ "AND userid like '%"+userid+"%' "
								+ "AND script like '%"+action+"%' "
								+ "AND [action] like '%"+srch+"%' "
								+ "AND alpha like '%"+alpha+"%' "
								+ "AND num like '%"+num+"%' "
								+ "AND convert(varchar,[datetime],101) like '%"+activity+"%' "
								+ "ORDER BY [datetime] ASC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("id")),
										AseUtil.nullToBlank(rs.getString("userid")),
										AseUtil.nullToBlank(rs.getString("script")),
										AseUtil.nullToBlank(rs.getString("action")),
										AseUtil.nullToBlank(rs.getString("alpha")),
										AseUtil.nullToBlank(rs.getString("num")),
										ae.ASE_FormatDateTime(rs.getString("datetime"),Constant.DATE_DATETIME),
										"",
										"",
										""
									));
			} // while
			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("UserLog: getActivities - " + e.toString());
		} catch (Exception e) {
			logger.fatal("UserLog: getActivities - " + e.toString());
		}

		return genericData;
	}

	/*
	 * getActivities
	 * <p>
	 * @param	conn			Connection
	 * @param	campus		String
	 * @param	userid		String
	 * @param	srch			String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	activity		String
	 * <p>
	 * @return 	Generic
	 */
	public static List<Generic> getActivities(Connection conn,String campus,String kix) throws Exception {

		//Logger logger = Logger.getLogger("test");

		List<Generic> genericData = null;

		try {
			AseUtil ae = new AseUtil();

			genericData = new LinkedList<Generic>();

			String sql = "SELECT id,userid,script,substring([action],0,75) as [action],alpha,num,[datetime] "
								+ "FROM tbluserlog WHERE (campus='SYS' OR campus=?) AND historyid=? "
								+ "ORDER BY ID desc ";

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				genericData.add(new Generic(
										AseUtil.nullToBlank(rs.getString("id")),
										AseUtil.nullToBlank(rs.getString("userid")),
										AseUtil.nullToBlank(rs.getString("script")),
										AseUtil.nullToBlank(rs.getString("action")),
										AseUtil.nullToBlank(rs.getString("alpha")),
										AseUtil.nullToBlank(rs.getString("num")),
										ae.ASE_FormatDateTime(rs.getString("datetime"),Constant.DATE_SHORT),
										"",
										"",
										""
									));
			} // while
			rs.close();
			ps.close();

			ae = null;

		} catch (SQLException e) {
			logger.fatal("UserLog: getActivities - " + e.toString());
		} catch (Exception e) {
			logger.fatal("UserLog: getActivities - " + e.toString());
		}

		return genericData;
	}

	public String toString(){
		return "Id: " + getId() +
		"Userid: " + getUserid() +
		"Script: " + getScript() +
		"Action: " + getAction() +
		"Alpha: " + getAlpha() +
		"Num: " + getNum() +
		"Datetime: " + getDatetime() +
		"Campus: " + getCampus() +
		"Historyid: " + getHistoryid() +
		"";
	}
}
