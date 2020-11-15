/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  CronJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.*;

import java.sql.Connection;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

import org.apache.log4j.Logger;

public class CronJob extends AseJob {

	static Logger logger = Logger.getLogger(CronJob.class.getName());

	public CronJob(){}

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

		AseJobParms aseJobParms = null;

		Connection conn = null;

		try{
			init(context);

			aseJobParms = getAseJobParms();

			if (aseJobParms != null){

				conn = AsePool.createLongConnection();

				if(conn != null){
					Cron.deActivateUsers(conn,aseJobParms.getCampus(),"");
				}

			}

		}
		catch(Exception e){
			logger.info("CronJob - " + e.toString());
		}
		finally{

			try{
				if (aseJobParms != null){
					aseJobParms = null;
				}

				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				//
			}

			terminate(context);
		}
    }
}
