/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

//
//  CourseCatalogJob.java
//
package com.ase.aseutil.jobs;

import java.util.Date;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.SyllabusDB;

import java.util.Map;
import org.quartz.Job;
import org.apache.log4j.Logger;
import org.quartz.Trigger;
import org.quartz.SimpleTrigger;
import org.quartz.JobDetail;
import org.quartz.JobDataMap;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SchedulerMetaData;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.JobExecutionException;
import org.quartz.JobExecutionContext;

public class CourseCatalogJob extends AseJob {

	static Logger logger = Logger.getLogger(CourseCatalogJob.class.getName());

	/**
	*/
	public CourseCatalogJob(){}

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

				String campus = aseJobParms.getCampus();
				String alpha = aseJobParms.getAlpha();
				String num = aseJobParms.getNum();

				String catalog = SyllabusDB.writeCatalog(campus,alpha,num);

System.out.println("---------------");
System.out.println(catalog);
			}

		}
		catch(Exception e){
			logger.info("CourseCatalogJob - " + e.toString());
		}
    }

}

