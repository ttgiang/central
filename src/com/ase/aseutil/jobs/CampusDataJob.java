/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  CampusDataJob.java
//
package com.ase.aseutil.jobs;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ase.aseutil.Tables;

public class CampusDataJob extends AseJob {

	static Logger logger = Logger.getLogger(CampusDataJob.class.getName());

	public CampusDataJob(){}

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

			Tables.unmatchedCourseData();
		}
		catch(Exception e){
			logger.info("CampusDataJob - " + e.toString());
		}
		finally{
			terminate(context);
		}

    }

}
