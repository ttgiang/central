/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 */

package com.ase.aseutil.jobs;

import org.apache.log4j.Logger;

import org.quartz.JobExecutionContext;

import com.ase.aseutil.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.util.Arrays.*;

public class JobNameDB {

	static Logger logger = Logger.getLogger(JobNameDB.class.getName());

	/**
	 * deleteJob
	 * <p>
	 * @param	jobName	String
	 * <p>
	 */
	public static void deleteJobName(String jobName){

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "DELETE FROM tblJobName WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				ps.executeUpdate();
				ps.close();
			}
			else{
				logger.info("FAILED - " + jobName);
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: deleteJob - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: deleteJob - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB","");
		}

		return;
	}

	/**
	 * getJobName
	 * <p>
	 * @param	conn	Connection
	 * @param	id		int
	 * <p>
	 */
	public static JobName getJobName(Connection conn,int id){

		JobName jobName = null;

		try{
			if (id > 0){
				String sql = "SELECT * FROM tblJobName WHERE id=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,id);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					jobName = new JobName();

					AseUtil aseUtil = new AseUtil();

					jobName.setId(rs.getInt("id"));
					jobName.setJobName(AseUtil.nullToBlank(rs.getString("jobname")));
					jobName.setJobTitle(AseUtil.nullToBlank(rs.getString("jobtitle")));
					jobName.setJobDescr(AseUtil.nullToBlank(rs.getString("jobdescr")));

					jobName.setFrequency(AseUtil.nullToBlank(rs.getString("frequency")));
					jobName.setParm1(AseUtil.nullToBlank(rs.getString("parm1")));
					jobName.setParm2(AseUtil.nullToBlank(rs.getString("parm2")));

					jobName.setCounter(rs.getInt("counter"));
					jobName.setTotal(rs.getInt("total"));

					jobName.setStartTime(aseUtil.ASE_FormatDateTime(rs.getString("starttime"),Constant.DATE_DATETIME));
					jobName.setEndTime(aseUtil.ASE_FormatDateTime(rs.getString("endtime"),Constant.DATE_DATETIME));

					jobName.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
					jobName.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));

					jobName.setFireTime(fireTimeToDate(AseUtil.nullToBlank(rs.getString("firetime"))));

					jobName.setSS(rs.getBoolean("SS"));
					jobName.setMM(rs.getBoolean("MM"));
					jobName.setHH(rs.getBoolean("HH"));
					jobName.setDD(rs.getBoolean("DD"));
					jobName.setMN(rs.getBoolean("MN"));
					jobName.setDW(rs.getBoolean("DW"));
					jobName.setYY(rs.getBoolean("YY"));
					jobName.setCMPS(rs.getBoolean("CMPS"));
					jobName.setKIX(rs.getBoolean("KIX"));
					jobName.setALPHA(rs.getBoolean("ALPHA"));
					jobName.setNUM(rs.getBoolean("NUM"));
					jobName.setTYPE(rs.getBoolean("TYPE"));
					jobName.setTASK(rs.getBoolean("TASK"));
					jobName.setIDX(rs.getBoolean("IDX"));

					aseUtil = null;
				}
				rs.close();
				rs = null;
				ps.close();
				ps = null;
			} // id > 0
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: getJobName - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: getJobName - " + e.toString());
		}

		return jobName;
	}

	/**
	 * addJobName
	 * <p>
	 * @param	conn		Connection
	 * @param	jobName		JobName
	 * <p>
	 * @param	int
	 */
	public static int addJobName(Connection conn, JobName jobName){

		int rowsAffected = -1;

		try{
			if (conn != null && jobName != null){
				logger.info("JobNameDB: addJobName - END");
			}

		}
		catch(Exception e){
			logger.fatal("JobNameDB: addJobName - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateJobName
	 * <p>
	 * @param	conn		Connection
	 * @param	jobName		JobName
	 * <p>
	 */
	public static void updateJobName(Connection conn, JobName jobName){

		int rowsAffected = -1;

		try{
			if (conn != null && jobName != null && jobName.getJobName() != null){
				//if (debug) logger.info("JobNameDB: ");
			}
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobName - " + e.toString());
		}

		return;
	}

	/*
	 * getJobNames
	 * <p>
	 * @param	conn	Connection
	 *	<p>
	 *	@return ArrayList
	 */
	public static ArrayList getJobNames(Connection conn) {

		String sql = "SELECT * FROM tbljobname ORDER BY jobtitle";

		ArrayList<JobName> list = null;

		JobName jobName = null;

		try {
			AseUtil aseUtil = new AseUtil();

			list = new ArrayList<JobName>();

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				jobName = new JobName();

				jobName.setId(rs.getInt("id"));
				jobName.setJobName(AseUtil.nullToBlank(rs.getString("jobname")));
				jobName.setJobTitle(AseUtil.nullToBlank(rs.getString("jobtitle")));
				jobName.setJobDescr(AseUtil.nullToBlank(rs.getString("jobdescr")));

				jobName.setFrequency(AseUtil.nullToBlank(rs.getString("frequency")));
				jobName.setParm1(AseUtil.nullToBlank(rs.getString("parm1")));
				jobName.setParm2(AseUtil.nullToBlank(rs.getString("parm2")));

				jobName.setCounter(rs.getInt("counter"));
				jobName.setTotal(rs.getInt("total"));

				jobName.setStartTime(aseUtil.ASE_FormatDateTime(rs.getString("starttime"),Constant.DATE_DATETIME));
				jobName.setEndTime(aseUtil.ASE_FormatDateTime(rs.getString("endtime"),Constant.DATE_DATETIME));

				jobName.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditDate"),Constant.DATE_DATETIME));
				jobName.setAuditBy(AseUtil.nullToBlank(rs.getString("auditBy")));

				jobName.setFireTime(fireTimeToDate(AseUtil.nullToBlank(rs.getString("firetime"))));

				list.add(jobName);
			}

			rs.close();
			ps.close();

			aseUtil = null;

		} catch (Exception e) {
			logger.fatal("JobNameDB: getJobNames - " + e.toString());
		}

		return list;
	}

	/**
	 * updateJobStartTime
	 * <p>
	 * @param	jobName		String
	 * @param	user			String
	 * @param	start			boolean
	 * @param	runTime		String
	 * <p>
	 * @return	int
	 */
	public static int updateJobStartTime(String jobName,String user,boolean start){

		String runTime = null;

		return updateJobStartTime(jobName,user,start,runTime);
	}

	public static int updateJobStartTime(String jobName,String user,boolean start,String runTime){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			if (start){
				connectionPool = AsePool.getInstance();
				conn = connectionPool.getConnection();

				if (conn != null){

					// runTime comes in with the following format
					// runTime = SS MM HH DD MN DW YY
					// sample looks like this "0 17 17 * * ?" (no YY)
					// not all values is provided. Only up to DW at this time (6 elements)

					Timestamp tstamp = new Timestamp(00-00-00);

					if (runTime != null){
						runTime = runTime.replace("*","0");
						runTime = runTime.replace("?","0");
						runTime = runTime.replace(" ",",");

						String[] timeString = runTime.split(",");
						int ss = NumericUtil.getInt(timeString[0],0);
						int mn = NumericUtil.getInt(timeString[1],0);
						int hh = NumericUtil.getInt(timeString[2],0);

						int dd = NumericUtil.getInt(timeString[3],0);
						if (dd == 0){
							dd = Calendar.getInstance().get(Calendar.DATE);
						}

						int mo = NumericUtil.getInt(timeString[4],0);
						if (mo == 0){
							mo = Calendar.getInstance().get(Calendar.MONTH) + 1;
						}

						int yy = 0;

						if (timeString.length < 7){
							yy = Calendar.getInstance().get(Calendar.YEAR);
						}
						else{
							yy = NumericUtil.getInt(timeString[6],0);
						}

						runTime = yy + "-" + mo + "-" + dd + " " + hh + ":" + mn + ":" + ss + ".01";
					}

					String sql = "UPDATE tblJobName SET starttime=?,auditdate=?,auditby=? WHERE jobname=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setTimestamp(1,tstamp.valueOf(runTime));
					ps.setString(2,AseUtil.getCurrentDateTimeString());
					ps.setString(3,user);
					ps.setString(4,jobName);

					rowsAffected = ps.executeUpdate();

					ps.close();
				}
			}
			else{
				resetJobName(jobName);
			}

		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobStartTime - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobStartTime - " + e.toString());
		} finally {

			if (conn != null){
				connectionPool.freeConnection(conn,"JobNameDB - updateJobStartTime","");
			}

		}

		return rowsAffected;
	}

	/**
	 * updateJobCounter
	 * <p>
	 * @param	jobName	String
	 * @param	counter	int
	 * <p>
	 * @return	int
	 */
	public static int updateJobCounter(String jobName,int counter){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET counter=? WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,counter);
				ps.setString(2,jobName);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobCounter - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobCounter - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - updateJobCounter","");
		}

		return rowsAffected;
	}

	/**
	 * updateJobTotal
	 * <p>
	 * @param	jobName	String
	 * @param	total		int
	 * <p>
	 * @return	int
	 */
	public static int updateJobTotal(String jobName,int total){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET total=? WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1,total);
				ps.setString(2,jobName);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobTotal - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobTotal - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - updateJobTotal","");
		}

		return rowsAffected;
	}

	/**
	 * updateJobStats
	 * <p>
	 * @param	jobName	String
	 * @param	counter	int
	 * <p>
	 * @return	int
	 */
	public static int updateJobStats(String jobName,String user,int counter){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET starttime=?,counter=?,auditdate=?,auditby=? WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,AseUtil.getCurrentDateTimeString());
				ps.setInt(2,counter);
				ps.setString(3,AseUtil.getCurrentDateTimeString());
				ps.setString(4,user);
				ps.setString(5,jobName);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobStats - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobStats - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - updateJobStats","");
		}

		return rowsAffected;
	}

	/**
	 * updateJobStats
	 * <p>
	 * @param	context	JobExecutionContext
	 * @param	jobName	String
	 * <p>
	 */
	public static void updateJobStats(JobExecutionContext context,String jobName){

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET firetime=?,jobruntime=?,result=? WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,context.getFireTime().toString());
				ps.setLong(2,context.getJobRunTime());
				ps.setString(3,String.valueOf(context.getResult()));
				ps.setString(4,jobName);
				int rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobStats - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobStats - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - updateJobStats","");
		}

		return;
	}

	/**
	 * updateJobStats
	 * <p>
	 * @param	context	JobExecutionContext
	 * @param	jobName	JobName
	 * <p>
	 */
	public static void updateJobStats(JobExecutionContext context,JobName jobName){

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET firetime=?,jobruntime=?,result=?,counter=?,total=?,starttime=?,endtime=?,auditby=?,auditdate=? "
								+ "WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,context.getFireTime().toString());
				ps.setLong(2,context.getJobRunTime());
				ps.setString(3,String.valueOf(context.getResult()));
				ps.setInt(4,jobName.getCounter());
				ps.setInt(5,jobName.getTotal());
				ps.setString(6,jobName.getStartTime());
				ps.setString(7,jobName.getEndTime());
				ps.setString(8,jobName.getAuditBy());
				ps.setString(9,jobName.getAuditDate());
				ps.setString(10,jobName.getJobName());
				int rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: updateJobStats - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: updateJobStats - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - updateJobStats","");
		}

		return;
	}

	/**
	 * resetJobName
	 */
	public static void resetJobName(String jobName){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){

				// -1 indicates job ended and not running

				String sql = "UPDATE tblJobName SET starttime=null,endtime=null,total=0,counter=0,auditdate=null,auditby=null "
								+ "WHERE jobname=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: resetJobName - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: resetJobName - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - resetJobName","");
		}

		return;
	}

	/**
	 * resetJobNames
	 */
	public static void resetJobNames(){

		int rowsAffected = 0;

		AsePool connectionPool = null;
		Connection conn = null;

		try{

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "UPDATE tblJobName SET starttime=null,endtime=null,total=0,counter=0,auditdate=null,auditby=null";
				PreparedStatement ps = conn.prepareStatement(sql);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
		}
		catch(SQLException se){
			logger.fatal("JobNameDB: resetJobNames - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: resetJobNames - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobNameDB - resetJobNames","");
		}

		return;
	}

	/**
	 * fireTimeToDate
	 */
	public static String fireTimeToDate(String dateTime){

		String fireTime = "";

		try {
			if (dateTime != null && !dateTime.equals(Constant.BLANK)){
				java.util.Date dt = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy").parse(dateTime);

				java.sql.Timestamp ts = new java.sql.Timestamp(dt.getTime());

				AseUtil aseUtil = new AseUtil();

				fireTime = aseUtil.ASE_FormatDateTime(ts, Constant.DATE_DATE_MDY, Locale.getDefault());

				aseUtil = null;
			} // dateTime
		}
		catch(Exception e){
			logger.fatal("JobNameDB: fireTimeToDate - " + e.toString());
		}

		return fireTime;
	}

	/**
	 * getFireTime
	 * <p>
	 * @param	conn		Connection
	 * @param	jobName	String
	 * <p>
	 */
	public static String getFireTime(Connection conn,String job){

		String jobName = null;

		try{
			String sql = "SELECT firetime FROM tblJobName WHERE jobname=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,job);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				jobName = fireTimeToDate(AseUtil.nullToBlank(rs.getString("firetime")));
			}
			rs.close();
			rs = null;
			ps.close();
			ps = null;

		}
		catch(SQLException se){
			logger.fatal("JobNameDB: getFireTime - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobNameDB: getFireTime - " + e.toString());
		}

		return jobName;
	}

	/*
	 * writeLogFile
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	job	JobName
	 *	<p>
	 */
	public static void writeLogFile(Connection conn,JobName job) throws Exception {

		try{
			String currentDrive = AseUtil.getCurrentDrive();

			String documents = SysDB.getSys(conn,"documents");

			String fileName = currentDrive
									+ ":"
									+ documents
									+ "jobs\\"
									+ job.getJobName()
									+ Constant.SPACE
									+ AseUtil.getCurrentDateTimeString().replace("/","").replace(":","")
									+ ".txt";

			fileName = fileName.replace(Constant.SPACE,"-");

			try{
				FileWriter fstream = null;
				BufferedWriter output = null;
				fstream = new FileWriter(fileName);
				if (fstream != null){
					output = new BufferedWriter(fstream);
					output.write(job.toStringLog());
					output.close();
				} // fstream != null
			}
			catch(Exception e){
				logger.fatal("JobNameDB - writeLogFile: " + e.toString());
			}
		}
		catch(Exception e){
			logger.fatal("JobNameDB - writeLogFile: " + e.toString());
		}

	}

}
