/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 *
 */

//
//  SearchDataJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.util.*;
import com.ase.aseutil.AseUtil;
import org.quartz.JobDataMap;

import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import org.apache.log4j.Logger;

public class SearchDataJob extends AseJob {

	static Logger logger = Logger.getLogger(SearchDataJob.class.getName());

	public SearchDataJob(){}

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

			SearchDB s = new SearchDB();

			s.createSearchData(getJob(),"","","");

			s = null;
		}
		catch(Exception e){
			logger.info("SearchDataJob - " + e.toString());
		}
		finally{
			terminate(context);
		} // finally

    } // execute

} // class
