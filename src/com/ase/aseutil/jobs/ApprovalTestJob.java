/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  ApprovalTestJob.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.SyllabusDB;
import com.ase.aseutil.JobsDB;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

import org.apache.log4j.Logger;

import com.ase.aseutil.test.*;

public class ApprovalTestJob extends AseJob {

	static Logger logger = Logger.getLogger(ApprovalTestJob.class.getName());

	public ApprovalTestJob(){}

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

			logger.info("Approval testing started...");

 			//AseJobParms aseJobParms = getAseJobParms();

			//ModifyTest mt = new ModifyTest();
			//mt.testMe();
			//mt = null;

			ApprovalTest at = new ApprovalTest();
			at.testMe();
			at = null;

			ApprovalInProgressTest aipt = new ApprovalInProgressTest();
			aipt.testMe();
			aipt = null;

			ApprovalFaskTrackTest aftt = new ApprovalFaskTrackTest();
			aftt.testMe();
			aftt = null;

			ApprovalReviseTest art = new ApprovalReviseTest();
			art.testMe();
			art = null;

			ApprovalDeleteTest adt = new ApprovalDeleteTest();
			adt.testMe();
			adt = null;

			ApprovalModifyTest amt = new ApprovalModifyTest();
			amt.testMe();
			amt = null;

			//aseJobParms = null;

			logger.info("Approval testing ended...");
		}
		catch(Exception e){
			logger.info("ApprovalTestJob - " + e.toString());
		}
		finally{
			terminate(context);
		}
    }

}
