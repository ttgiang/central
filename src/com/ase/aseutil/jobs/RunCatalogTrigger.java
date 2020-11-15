/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

//
//  RunCatalogTrigger.java
//
package com.ase.aseutil.jobs;

import java.util.Date;
import java.util.Map;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdSchedulerFactory;

import org.apache.log4j.Logger;

public class RunCatalogTrigger {

	static Logger logger = Logger.getLogger(RunCatalogTrigger.class.getName());

	static String jobGroup = "ASE Job Group";

	public RunCatalogTrigger(){
	}

	@SuppressWarnings("unchecked")
	public static void process(Scheduler scheduler,String campus,String user,String alpha,String num,boolean parseHtml,boolean suppress){

		try{
			RunCatalogTask task = new RunCatalogTask();

			JobDetail jobDetail = new JobDetail();
			jobDetail.setName("runCatalogJob");
			jobDetail.setJobClass(RunCatalogJob.class);

			if (scheduler == null){
				scheduler = new StdSchedulerFactory().getScheduler();
			}

			jobDetail.getJobDataMap().put("runCatalogTask", task);
			jobDetail.getJobDataMap().put("scheduler", scheduler);
			jobDetail.getJobDataMap().put("campus", campus);
			jobDetail.getJobDataMap().put("alpha", alpha);
			jobDetail.getJobDataMap().put("num", num);
			jobDetail.getJobDataMap().put("user", user);
			jobDetail.getJobDataMap().put("parseHtml", parseHtml);
			jobDetail.getJobDataMap().put("suppress", suppress);

			Trigger trigger = new SimpleTrigger("runCatalogTrigger",jobGroup,new Date());

			scheduler.start();

			scheduler.scheduleJob(jobDetail, trigger);
		}
		catch(Exception e){
			logger.fatal("RunCatalogTrigger.runCatalogTrigger: " + e.toString());
		}

	}

	public static void main( String[] args ) throws Exception{
		//
	}

}
