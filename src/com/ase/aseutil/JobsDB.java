/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 *
 * @author ttgiang
 *
 *
 */

package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class JobsDB {

	static Logger logger = Logger.getLogger(JobsDB.class.getName());

	/**
	 * deleteJob
	 * <p>
	 * @param	jobName	String
	 * <p>
	 */
	public static void deleteJob(String jobName){

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();

			if (conn != null){
				String sql = "DELETE FROM tblJobs WHERE job=?";
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
			logger.fatal("JobsDB: deleteJob - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobsDB: deleteJob - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"JobsDB","");
		}

		return;
	}

	/**
	 * deleteJobByKix
	 * <p>
	 * @param	jobName	String
	 * <p>
	 */
	public static void deleteJobByKix(Connection conn, String kix){

		try{
			String sql = "DELETE FROM tblJobs WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.executeUpdate();
			ps.close();
		}
		catch(SQLException se){
			logger.fatal("JobsDB: deleteJobByKix - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobsDB: deleteJobByKix - " + e.toString());
		}

		return;
	}

	/**
	 * getJob
	 * <p>
	 * @param	conn		Connection
	 * @param	jobName	String
	 * <p>
	 */
	public static Jobs getJob(Connection conn, String jobName){

		Jobs jobs = null;
		try{
			if (conn == null)
				conn = ConnDB.getConnection();

			if (jobName != null){
				String sql = "SELECT * FROM tblJobs WHERE job=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobName);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					jobs = new Jobs();
					AseUtil aseUtil = new AseUtil();

					jobs.setId(rs.getInt("id"));
					jobs.setHistoryID(AseUtil.nullToBlank(rs.getString("historyid")));
					jobs.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
					jobs.setAlpha(AseUtil.nullToBlank(rs.getString("alpha")));
					jobs.setNum(AseUtil.nullToBlank(rs.getString("num")));
					jobs.setAuditBy(AseUtil.nullToBlank(rs.getString("auditby")));
					jobs.setAuditDate(aseUtil.ASE_FormatDateTime(rs.getString("auditdate"),Constant.DATE_DATETIME));
					jobs.setS1(AseUtil.nullToBlank(rs.getString("s1")));
					jobs.setS2(AseUtil.nullToBlank(rs.getString("s2")));
					jobs.setS3(AseUtil.nullToBlank(rs.getString("s3")));
					jobs.setN1(rs.getInt("n1"));
					jobs.setN2(rs.getInt("n2"));
					jobs.setN3(rs.getInt("n3"));
					jobs.setT1(AseUtil.nullToBlank(rs.getString("t1")));
					jobs.setT2(AseUtil.nullToBlank(rs.getString("t2")));
					jobs.setT2(AseUtil.nullToBlank(rs.getString("t3")));
				}
				rs.close();
				rs = null;
				ps.close();
				ps = null;
			}
		}
		catch(SQLException se){
			logger.fatal("JobsDB: getJob - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobsDB: getJob - " + e.toString());
		}

		return jobs;
	}

	/**
	 * addJob
	 * <p>
	 * @param	conn		Connection
	 * @param	jobs		Jobs
	 * <p>
	 * @param	int
	 */
	public static int addJob(Connection conn, Jobs jobs){

		int rowsAffected = -1;

		try{
			if (conn == null)
				conn = ConnDB.getConnection();

			if (conn != null && jobs != null){
				String sql = "INSERT INTO tblJobs (job,historyid,campus,alpha,num,auditby,auditdate,s1,s2,s3,n1,n2,n3,t1,t2,t3) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobs.getJob());
				ps.setString(2,jobs.getHistoryID());
				ps.setString(3,jobs.getCampus());
				ps.setString(4,jobs.getAlpha());
				ps.setString(5,jobs.getNum());
				ps.setString(6,jobs.getAuditBy());
				ps.setString(7,jobs.getAuditDate());
				ps.setString(8,jobs.getS1());
				ps.setString(9,jobs.getS2());
				ps.setString(10,jobs.getS3());
				ps.setInt(11,jobs.getN1());
				ps.setInt(12,jobs.getN2());
				ps.setInt(13,jobs.getN3());
				ps.setString(14,jobs.getT1());
				ps.setString(15,jobs.getT2());
				ps.setString(16,jobs.getT3());
				ps.executeUpdate();
				ps.close();
				ps = null;
			}

		}
		catch(SQLException se){
			logger.fatal("JobsDB: addJob - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobsDB: addJob - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * updateJob
	 * <p>
	 * @param	conn		Connection
	 * @param	jobs		Jobs
	 * <p>
	 */
	public static void updateJob(Connection conn, Jobs jobs){

		int rowsAffected = -1;

		try{
			if (conn == null)
				conn = ConnDB.getConnection();

			if (conn != null && jobs != null && jobs.getJob() != null){
				String sql = "UPDATE tblJobs "
					+ "SET job=?,historyid=?,campus=?,alpha=?,num=?,auditby=?,auditdate=?,s1=?,s2=?,s3=?,n1=?,n2=?,n3=?,t1=?,t2=?,t3=? "
					+ "WHERE job=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,jobs.getJob());
				ps.setString(2,jobs.getHistoryID());
				ps.setString(3,jobs.getCampus());
				ps.setString(4,jobs.getAlpha());
				ps.setString(5,jobs.getNum());
				ps.setString(6,jobs.getAuditBy());
				ps.setString(7,jobs.getAuditDate());
				ps.setString(8,jobs.getS1());
				ps.setString(9,jobs.getS2());
				ps.setString(10,jobs.getS3());
				ps.setInt(11,jobs.getN1());
				ps.setInt(12,jobs.getN2());
				ps.setInt(13,jobs.getN3());
				ps.setString(14,jobs.getT1());
				ps.setString(15,jobs.getT2());
				ps.setString(16,jobs.getT3());
				ps.setString(17,jobs.getJob());
				rowsAffected = ps.executeUpdate();
				ps.close();
				ps = null;

				if (rowsAffected < 1)
					addJob(conn,jobs);

			}
		}
		catch(SQLException se){
			logger.fatal("JobsDB: updateJob - " + se.toString());
		}
		catch(Exception e){
			logger.fatal("JobsDB: updateJob - " + e.toString());
		}

		return;
	}

	/**
	 * countNumberInJob - Count number of instances of a job
	 * <p>
	 * @param conn		Connection
	 * @param jobName	String
	 * <p>
	 * @return long
	 *
	 */
	public static long countNumberInJob(Connection conn,String jobName) throws java.sql.SQLException {

		long lRecords = 0;

		try {
			String sql = "SELECT Count(id) AS CountOfid "
						+ "FROM tblJobs "
						+ "WHERE job=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,jobName);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				lRecords = rs.getLong(1);
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("ApproverDB: countNumberInJob - " + e.toString());
		}

		return lRecords;
	}

}