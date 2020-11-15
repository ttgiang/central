/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 */

//
//  CourseCatalogTrigger.java
//
package com.ase.aseutil.jobs;

import java.util.Date;

import com.ase.aseutil.AseUtil;

import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdSchedulerFactory;

public class CourseCatalogTrigger {

	static Logger logger = Logger.getLogger(CourseCatalogTrigger.class.getName());

	static String jobGroup = "ASE Job Group";

	/**
	*/
	public CourseCatalogTrigger(){}

	@SuppressWarnings("unchecked")
	public static void process(Scheduler scheduler,String campus,String alpha,String num){

		try{

			boolean debug = true;

			if (debug) logger.info("*------ CourseCatalogTrigger start ---------------------");

			CourseCatalogTask task = new CourseCatalogTask();

			JobDetail job = new JobDetail();
			job.setName("CourseCatalogJob");
			job.setJobClass(CourseCatalogJob.class);

			Map dataMap = job.getJobDataMap();
			dataMap.put("courseCatalogTask", task);
			dataMap.put("campus", campus);
			dataMap.put("alpha", alpha);
			dataMap.put("num", num);

			Trigger trigger = new SimpleTrigger("courseCatalogTrigger",jobGroup,new Date());

			if (scheduler == null){
				scheduler = new StdSchedulerFactory().getScheduler();
			}

			scheduler.start();

			scheduler.scheduleJob(job, trigger);

			if (debug) logger.info("*------ CourseCatalogTrigger end ---------------------");

		}
		catch(Exception e){
			logger.info("CourseCatalogTask.runTask - " + e.toString());
		}

	}

	public static void main( String[] args ) throws Exception{
		//
	}
}

