/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 *
 */

//
//  CampusOulinesJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.Tables;
import com.ase.aseutil.AseUtil;
import org.quartz.JobDataMap;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import org.apache.log4j.Logger;

public class CampusOulinesJob extends AseJob {

	static Logger logger = Logger.getLogger(CampusOulinesJob.class.getName());

	public CampusOulinesJob(){}

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

			Tables.campusOutlines();
		}
		catch(Exception e){
			logger.info("CampusOulinesJob - " + e.toString());
		}
		finally{
			terminate(context);
		}

    }

}
