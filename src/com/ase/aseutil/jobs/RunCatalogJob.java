/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

//
//  RunCatalogJob.java
//
package com.ase.aseutil.jobs;

import java.util.Map;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;

import org.apache.log4j.Logger;

public class RunCatalogJob implements Job {

	static Logger logger = Logger.getLogger(RunCatalogJob.class.getName());

	@SuppressWarnings("unchecked")
	public void execute(JobExecutionContext context) throws JobExecutionException {

		try{

			Map dataMap = context.getJobDetail().getJobDataMap();

			RunCatalogTask task = (RunCatalogTask)dataMap.get("runCatalogTask");
			Scheduler scheduler = (Scheduler)dataMap.get("scheduler");
			String campus = (String)dataMap.get("campus");
			String alpha = (String)dataMap.get("alpha");
			String num = (String)dataMap.get("num");
			String user = (String)dataMap.get("user");

			Boolean parseHtml = (Boolean)dataMap.get("parseHtml");
			Boolean suppress = (Boolean)dataMap.get("suppress");

			task.runCatalogTask(scheduler,campus,user,alpha,num,parseHtml,suppress);
		}
		catch(Exception e){

			System.out.println("RunCatalogJob: " + e.toString());

		}


	}

}
