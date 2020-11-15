/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *	public static String createMailNameList(Connection conn,String domain,String mail) throws Exception {
 * public static String getSendMail(Connection conn)
 *
 */

//
//  DailyJob.java
//
package com.ase.aseutil.jobs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobDataMap;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.CampusDB;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Cron;
import com.ase.aseutil.Mailer;
import com.ase.aseutil.MailerDB;
import com.ase.aseutil.NumericUtil;
import com.ase.aseutil.QuestionDB;
import com.ase.aseutil.TaskDB;

public class DailyJob extends AseJob {

	static Logger logger = Logger.getLogger(DailyJob.class.getName());

	public DailyJob(){}

	/**
	 * sendMailOnce
	 * <p>
	 * @param	conn		Connection
	 * <p>
	 * @return	String
	 */
	public static String sendMailOnce(Connection conn) throws Exception {

		//Logger logger = Logger.getLogger("test");

		try {
			Mailer mailer = null;
			MailerDB mailerDB = new MailerDB();

			String sql = "SELECT * FROM tblMail WHERE processed=0 AND cc='DAILY'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int id = NumericUtil.nullToZero(rs.getInt("id"));
				mailer = new Mailer();
				mailer.setId(id);
				mailer.setFrom(AseUtil.nullToBlank(rs.getString("from")));
				mailer.setTo(AseUtil.nullToBlank(rs.getString("to")));
				mailer.setCC("");
				mailer.setSubject(AseUtil.nullToBlank(rs.getString("subject")));
				mailer.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				mailerDB.sendMail(conn,mailer,"emailSendOnce");
			}

		} catch (Exception e) {
			logger.fatal("DailyJob: sendMailOnce - " + e.toString());
		}

		return "";
	}


    /**
     * <p>
     * Called by the <code>{@link org.quartz.Scheduler}</code> when a
     * <code>{@link org.quartz.Trigger}</code> fires that is associated with
     * the <code>Job</code>.
     * </p>
     *
     * @throws JobExecutionException
     *             if there is an exception while executing the job.
     */
    public void execute(JobExecutionContext context) throws JobExecutionException {

		Connection conn = null;

		int jobCount = 0;
		int totalJobs = 3;

		try{

			init(context);

			// YOUR CODE GOES HERE

			logAction("*------ DailyJob ---------------------","start");

			conn = AsePool.createLongConnection();

			if (conn != null){

				//
				// JOB 1
				//
				sendMailOnce(conn);
				++jobCount;

				//
				// handled by TaskDB.removeStrayReviewers
				//
				//Cron.clearReviewers(conn,null);
				//++jobCount;

				//
				// handled by TaskDB with each login
				//
				//TaskDB.correctProposerName(conn);
				//++jobCount;

				//
				// JOB 2
				//
				Cron.cleanCampusOutlinesTable(conn);
				++jobCount;

				//
				// JOB 3
				//
				// update course/campus questions
				String campuses = CampusDB.getCampusNames(conn);
				if (!campuses.equals(Constant.BLANK)){

					int rowsAffected = 0;

					String[] campus = campuses.split(",");

					QuestionDB questionDB = new QuestionDB();

					for(int i=0;i<campus.length;i++){
						//rowsAffected = questionDB.resequenceItems(conn,"c",campus[i],"SYSADM");
						//rowsAffected = questionDB.resequenceItems(conn,"p",campus[i],"SYSADM");
						//rowsAffected = questionDB.resequenceItems(conn,"r",campus[i],"SYSADM");
					}

					questionDB = null;
					++jobCount;
				}

				AseUtil.logAction(conn,
									"SYSADM",
									"ACTION",
									"Daily jobs",
									"",
									"",
									"SYS",
									"");

				com.ase.aseutil.jobs.JobName job = getJob();
				if (job != null){
					job.setTotal(jobCount);
					job.setCounter(totalJobs);
					job.setEndTime(AseUtil.getCurrentDateTimeString());

					// keep this here beccause of the connection object
					com.ase.aseutil.jobs.JobNameDB.writeLogFile(conn,job);
				} //job


			} // if conn

			logAction("*------ DailyJob ---------------------","end");

		}
		catch(Exception e){
			logger.info("DailyJob - " + e.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("DialyJob: " + e.toString());
			}

			terminate(context);
		}

    }

}
