/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *	public static String createMailNameList(Connection conn,String domain,String mail) throws Exception {
 * public static String getSendMail(Connection conn)
 *
 */

//
//  GenericJobX.java
//
package com.ase.aseutil.jobs;

import java.util.Date;

import com.ase.aseutil.AseUtil;

import org.apache.log4j.Logger;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.JobDataMap;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SchedulerMetaData;
import org.quartz.impl.StdSchedulerFactory;

import java.lang.reflect.*;

public class GenericJobX {

	static Logger logger = Logger.getLogger(GenericJobX.class.getName());

	static String jobGroup = "ASE Job Group";

	/**
	*/
	public GenericJobX(){}

	/**
	*/
	public Scheduler getScheduler() throws Exception {

		logger.info("*------ Starting factory --------");

		SchedulerFactory sf = new StdSchedulerFactory();

		logger.info("*------ Factory created --------");

		Scheduler scheduler = sf.getScheduler();

		logger.info("*------ Scheduler obtained --------");

		return scheduler;
	}

	/**
	*/
	public void endScheduler(Scheduler scheduler) throws Exception {

		if (scheduler != null){
			scheduler.shutdown(true);
			com.ase.aseutil.jobs.JobNameDB.resetJobNames();
		}

		logger.info("*------ Shutdown Complete -----------------");

		SchedulerMetaData metaData = scheduler.getMetaData();

		//logger.info("Executed " + metaData.numJobsExecuted() + " jobs.");
	}

	/**
	*/
	public boolean endJob(Scheduler scheduler,String jobName,String user) throws Exception {

		boolean start = false;

		com.ase.aseutil.jobs.JobNameDB.updateJobStartTime(jobName,user,start,null);

		return scheduler.deleteJob(jobName,jobGroup);

	}

	/**
		schedule a job based on user defined time.
	*/
	public void startJob(Scheduler scheduler,
									String jobName,
									String runTime,
									String user,
									AseJobParms jobParms) throws Exception {

		JobDetail jobDetail = null;

		SchedulerFactory sf = null;

		if (scheduler == null){
			sf = new StdSchedulerFactory();
			scheduler = sf.getScheduler();
		} // scheduler

		if (scheduler != null){
			logger.info("*------ Initialization Complete --------");

			logger.info("jobName: " + jobName);

			if (jobName.equals("ApprovalStatus")){
				jobDetail = new JobDetail(jobName,jobGroup,ApprovalStatusJob.class);
			}
			else if (jobName.equals("ApprovalTest")){
				jobDetail = new JobDetail(jobName,jobGroup,ApprovalTestJob.class);
			}
			else if (jobName.equals("CampusOutlines")){
				jobDetail = new JobDetail(jobName,jobGroup,CampusOulinesJob.class);
			}
			else if (jobName.equals("CourseCatalog")){
				jobDetail = new JobDetail(jobName,jobGroup,CourseCatalogJob.class);
			}
			else if (jobName.equals("CreateOutlines")){
				jobDetail = new JobDetail(jobName,jobGroup,CreateOulinesJob.class);
			}
			else if (jobName.equals("CreatePrograms")){
				jobDetail = new JobDetail(jobName,jobGroup,CreateProgramsJob.class);
			}
			else if (jobName.equals("Cron")){
				jobDetail = new JobDetail(jobName,jobGroup,CronJob.class);
			}
			else if (jobName.equals("DailyJob")){
				jobDetail = new JobDetail(jobName,jobGroup,DailyJob.class);
			}
			else if (jobName.equals("SearchData")){
				jobDetail = new JobDetail(jobName,jobGroup,SearchDataJob.class);
			}
			else if (jobName.equals("TableRefresh")){
				jobDetail = new JobDetail(jobName,jobGroup,TableRefreshJob.class);
			}
			else if (jobName.equals("UnmatchedCourseRecord")){
				jobDetail = new JobDetail(jobName,jobGroup,CampusDataJob.class);
			}

			if (jobDetail != null){

				boolean start = true;

				logger.info("jobDetail");

				// extra parms
				jobDetail.getJobDataMap().put("jobname",jobParms.getJobName());
				jobDetail.getJobDataMap().put("campus",jobParms.getCampus());
				jobDetail.getJobDataMap().put("kix",jobParms.getKix());
				jobDetail.getJobDataMap().put("alpha",jobParms.getAlpha());
				jobDetail.getJobDataMap().put("num",jobParms.getNum());
				jobDetail.getJobDataMap().put("type",jobParms.getType());
				jobDetail.getJobDataMap().put("user",jobParms.getUser());
				jobDetail.getJobDataMap().put("recordCount",jobParms.getRecordCount());
				jobDetail.getJobDataMap().put("parm1",jobParms.getParm1());
				jobDetail.getJobDataMap().put("parm2",jobParms.getParm2());
				jobDetail.getJobDataMap().put("parm3",jobParms.getParm3());
				jobDetail.getJobDataMap().put("parm4",jobParms.getParm4());

				logger.info("job parms");

				com.ase.aseutil.jobs.JobNameDB.updateJobStartTime(jobName,"",start,runTime);

				logger.info("update job time");

				CronTrigger trigger = new CronTrigger(jobName,jobGroup,jobName,jobGroup,runTime);

				logger.info("trigger created");

				scheduler.addJob(jobDetail,true);

				logger.info("job added");

				Date ft = scheduler.scheduleJob(trigger);

				logger.info(jobDetail.getFullName() + " has been scheduled to run at: "
								+ ft
								+ " and repeat based on expression: "
								+ trigger.getCronExpression());

				logger.info("*------ Jobs Scheduled ----------------");

				scheduler.start();

				logger.info("*------ Started Scheduler -----------------");
			}
			else{
				logger.info("*------ Job initialization failed --------");
			} // jobDetail

		}
		else{
			logger.info("*------ Scheduler initialization failed --------");
		} // scheduler

		return;
	}

}
