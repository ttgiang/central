/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  CreateProgramsJob.java
//
package com.ase.aseutil.jobs;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ase.aseutil.Tables;

public class CreateProgramsJob extends AseJob {

	static Logger logger = Logger.getLogger(CreateProgramsJob.class.getName());

	public CreateProgramsJob(){}

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

			String campus = null;
			String kix = null;
			String alpha = null;
			String num = null;

			Tables.createPrograms(campus,kix,alpha,num);
		}
		catch(Exception e){
			logger.info("CreateProgramsJob - " + e.toString());
		}
		finally{
			terminate(context);
		}
    }
}
