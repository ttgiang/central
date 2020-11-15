/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 *
 */

//
//  ApprovalStatusJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.Tables;
import com.ase.aseutil.AseUtil;
import org.quartz.JobDataMap;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import org.apache.log4j.Logger;

public class ApprovalStatusJob extends AseJob {

	static Logger logger = Logger.getLogger(ApprovalStatusJob.class.getName());

	public ApprovalStatusJob(){}

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

		try{
			init(context);

			// YOUR CODE GOES HERE

			Tables.approvalStatus(getJob());
		}
		catch(Exception e){
			logger.info("ApprovalStatusJob - " + e.toString());
		}
		finally{
			terminate(context);
		}

    }

}
