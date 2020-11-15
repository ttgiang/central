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
//  MailerJob.java
//
package com.ase.aseutil.jobs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ase.aseutil.AsePool;
import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Mailer;
import com.ase.aseutil.MailerDB;
import com.ase.aseutil.NumericUtil;

public class MailerJob extends AseJob {

	static Logger logger = Logger.getLogger(MailerJob.class.getName());

	public MailerJob(){}

	/**
	 * sendMailOnce
	 * <p>
	 * @param	conn		Connection
	 * @param	session	javax.servlet.http.HttpSession
	 * @param	testRun	boolean
	 * <p>
	 * @return	String
	 */
	public static String sendMailOnce(Connection conn,boolean testRun) throws Exception {

		//Logger logger = Logger.getLogger("test");

		logger.info("------ sendMailOnce starts ---------------------");

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
				mailer.setCC(AseUtil.nullToBlank(rs.getString("cc")));
				mailer.setSubject(AseUtil.nullToBlank(rs.getString("subject")));
				mailer.setCampus(AseUtil.nullToBlank(rs.getString("campus")));
				mailerDB.sendMail(conn,mailer,"emailSendOnce");
				logger.info("* MailerJob - sendMailOnce to: " + mailer.getTo());
			}

		} catch (Exception e) {
			logger.fatal("MailerJob: sendMailOnce - " + e.toString());
		}

		logger.info("------ sendMailOnce ends ---------------------");

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

		AsePool connectionPool = null;
		Connection conn = null;

		try{
			init(context);

			// YOUR CODE GOES HERE

			connectionPool = AsePool.getInstance();
			conn = connectionPool.getConnection();
			sendMailOnce(conn,true);
		}
		catch(Exception e){
			logger.info("MailerJob - " + e.toString());
		}
		finally{
			connectionPool.freeConnection(conn);

			terminate(context);
		}

    }

}
