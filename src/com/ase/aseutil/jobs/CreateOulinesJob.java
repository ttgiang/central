/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  CreateOulinesJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.Tables;
import com.ase.aseutil.JobsDB;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

import org.apache.log4j.Logger;

public class CreateOulinesJob extends AseJob {

	static Logger logger = Logger.getLogger(CreateOulinesJob.class.getName());

	public CreateOulinesJob(){}

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

		try{
			init(context);

			aseJobParms = getAseJobParms();

			if (aseJobParms != null){

				String task = aseJobParms.getParm1();

				logAction("*------ Create Outline ---------------------","start");

				if (task == null || task.length() == 0){
					task = "frce";
				}

				// must clear out table data and recreate
				Tables.campusOutlines();

				Tables.createOutlines(aseJobParms.getCampus(),
												null,							//kix
												null,							//alpha
												null,							//num
												task,
												""								// idx
												);

				logAction("*------ Create Outline ---------------------","end");
			}

		}
		catch(Exception e){
			logger.info("CreateOulinesJob - " + e.toString());
		}
		finally{
			if (aseJobParms != null){
				aseJobParms = null;
			}

			terminate(context);
		}
    }
}
