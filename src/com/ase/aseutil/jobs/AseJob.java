/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  AseJob.java
//
package com.ase.aseutil.jobs;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.JobDataMap;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;

import com.ase.aseutil.AseUtil;
import com.ase.aseutil.NumericUtil;
import com.ase.aseutil.Constant;
import com.ase.aseutil.Html;

import javax.servlet.http.HttpSession;

public class AseJob implements Job {

	static Logger logger = Logger.getLogger(AseJob.class.getName());

	private JobName job = null;

	private String jobName = null;

	private String jobGroup = null;

	private AseJobParms aseJobParms = null;

	public AseJob(){}

    /**
     * <p>
     * Called to initialize job data
     * </p>
     *
     */
    public void init(JobExecutionContext context) throws JobExecutionException {

		try{
			job = new JobName();

			JobDetail jobDetail = context.getJobDetail();
			if (jobDetail != null){
				jobName = jobDetail.getName();
				jobGroup = jobDetail.getGroup();
				job.setJobName(jobName);
			} // jobDetail

			JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
			if (jobDataMap != null){
				aseJobParms = new AseJobParms();
				aseJobParms.setJobName(jobDataMap.getString("jobname"));
				aseJobParms.setCampus(jobDataMap.getString("campus"));
				aseJobParms.setUser(jobDataMap.getString("user"));
				aseJobParms.setKix(jobDataMap.getString("kix"));
				aseJobParms.setAlpha(jobDataMap.getString("alpha"));
				aseJobParms.setNum(jobDataMap.getString("num"));
				aseJobParms.setType(jobDataMap.getString("type"));

				int recordCount = 0;

				try{
					recordCount = NumericUtil.getInt(jobDataMap.getString("recordCount"),0);
					aseJobParms.setRecordCount(recordCount);
				}
				catch(Exception e){
					aseJobParms.setRecordCount(recordCount);
				}

				aseJobParms.setParm1(jobDataMap.getString("parm1"));
				aseJobParms.setParm2(jobDataMap.getString("parm2"));
				aseJobParms.setParm3(jobDataMap.getString("parm3"));
				aseJobParms.setParm4(jobDataMap.getString("parm4"));
			} // jobDataMap

		}
		catch(Exception e){
			logger.info("AseJob - init ("+jobName+"): " + e.toString());
		}

    } // terminate

    /**
     * <p>
     * Called by a scheduled job when it ends and needs to delete the job
     * </p>
     *
     */
    public void terminate(JobExecutionContext context) throws JobExecutionException {

		try{
			Scheduler scheduler = context.getScheduler();
			if (scheduler != null){

				job.setAuditBy("SYSADM");

				job.setAuditDate(AseUtil.getCurrentDateTimeString());

				job.setResult("scheduled jobs completed successfully");

				com.ase.aseutil.jobs.JobNameDB.updateJobStats(context,job);

				com.ase.aseutil.jobs.JobNameDB.updateJobStartTime(jobName,"",false,null);

				scheduler.deleteJob(jobName,jobGroup);

			} // scheduler
		}
		catch(org.quartz.SchedulerException e){
			logger.info("AseJob - terminate: " + e.toString());
		}
		catch(Exception e){
			logger.info("AseJob - terminate: " + e.toString());
		}

    } // terminate

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

			boolean start = true;

			com.ase.aseutil.jobs.JobNameDB.updateJobStartTime(jobName,"",start);
		}
		catch(Exception e){
			logger.info("AseJob - execute ("+jobName+"): " + e.toString());
		}
		finally{
			terminate(context);
		} // finally

    } // execute

    /**
     *
     * @param	logAction
     *
     */
    public void logAction(String jobName,String progress) {

		try{

			if (progress.equals("start")){
				logger.info(jobName + " starting at - " + AseUtil.getCurrentDateTimeString());
			}
			else if (progress.equals("end")){
				logger.info(jobName + " ending at - " + AseUtil.getCurrentDateTimeString());
			}
			else{
				logger.info(jobName);
			}

		}
		catch(Exception e){
			logger.info("AseJob - logAction ("+jobName+"): " + e.toString());
		}

    } // logAction

	 /**
	  *
	  * doesTriggerExist
	  * <p>
	  * @param	scheduler	Scheduler
	  * @param	jobName		String
	  * <p>
	  */
	public static boolean doesTriggerExist(Scheduler scheduler,String jobName) {

		//Logger logger = Logger.getLogger("test");

		boolean exists = false;

		try{

			if (scheduler != null){

				String[] triggersInGroup = null;

				String[] triggerGroups = scheduler.getTriggerGroupNames();

				if (triggerGroups.length > 0){

					for (int i = 0; i < triggerGroups.length; i++) {

						triggersInGroup = scheduler.getTriggerNames(triggerGroups[i]);

						for (int j = 0; j < triggersInGroup.length; j++) {

							if (jobName.equals(triggersInGroup[j])){
								exists = true;
							} // jobName

						} // for j

					} // for i

				} // triggerGroups != null

			} // scheduler not null

		} catch (Exception e) {
			logger.fatal("AseJob: doesTriggerExist ("+jobName+"): " + e.toString());
		}

		return exists;

	}

	 /**
	  *
	  * getScheduledJobs
	  * <p>
	  * @param	session	HttpSession
	  * <p>
	  */
	public static String getScheduledJobs(HttpSession session) {

		Scheduler scheduler = getScheduler(session,"");

		String data = "";

		if (scheduler != null){
			data =  getScheduledJobs(scheduler);
		}

		return data;

	}

	 /**
	  *
	  * getScheduledJobs
	  * <p>
	  * @param	scheduler	Scheduler
	  * <p>
	  */
	public static String getScheduledJobs(Scheduler scheduler) {

		//Logger logger = Logger.getLogger("test");

		String jobNames = "";

		try{

			if (scheduler != null){

				String[] triggersInGroup = null;

				String[] triggerGroups = scheduler.getTriggerGroupNames();

				if (triggerGroups.length > 0){

					for (int i = 0; i < triggerGroups.length; i++) {

						triggersInGroup = scheduler.getTriggerNames(triggerGroups[i]);

						for (int j = 0; j < triggersInGroup.length; j++) {

							if (jobNames.equals(Constant.BLANK)){
								jobNames = triggersInGroup[j];
							}
							else{
								jobNames = jobNames + "," + triggersInGroup[j];
							} // jobNames

						} // for j

					} // for i

				} // triggerGroups != null

			} // scheduler not null

		} catch (Exception e) {
			logger.fatal("AseJob: getScheduledJobs: " + e.toString());
		}

		return jobNames;

	}

	 /**
	  *
	  * printScheduledJobs
	  * <p>
	  * @param	session	HttpSession
	  * <p>
	  */
	public static String printScheduledJobs(HttpSession session) {

		Scheduler scheduler = getScheduler(session,"");

		String data = "";

		if (scheduler != null){
			data =  printScheduledJobs(scheduler);
		}

		return data;

	}

	 /**
	  *
	  * printScheduledJobs
	  * <p>
	  * @param	scheduler	Scheduler
	  * <p>
	  */
	public static String printScheduledJobs(Scheduler scheduler) {

		//Logger logger = Logger.getLogger("test");

		StringBuffer message = new StringBuffer();

		try{

			if (scheduler != null){

				String[] triggersInGroup = null;

				String[] triggerGroups = scheduler.getTriggerGroupNames();

				if (triggerGroups.length > 0){

					message.append(Html.BR());

					for (int i = 0; i < triggerGroups.length; i++) {

						message.append("Group: " + triggerGroups[i] + " contains the following triggers" + Html.BR());

						triggersInGroup = scheduler.getTriggerNames(triggerGroups[i]);

						message.append("<ul>");

						for (int j = 0; j < triggersInGroup.length; j++) {

							message.append("<li>" + triggersInGroup[j] + "</li>");

						} // for j

						message.append("</ul>");

					} // for i

					message.append(Html.BR());

				} // triggerGroups != null

			} // scheduler not null

		} catch (Exception e) {
			logger.fatal("AseJob: printScheduledJobs: " + e.toString());
		}

		return message.toString();

	}

	 /**
	  *
	  * getScheduler
	  * <p>
	  * @param	session			HttpSession
	  * @param	schedulerName	String
	  * <p>
	  * @return	Scheduler
	  * <p>
	  */
	public static Scheduler getScheduler(HttpSession session,String schedulerName) {

		Scheduler scheduler = null;

		try{

			if (schedulerName == null || schedulerName.length() == 0){
				schedulerName = "aseScheduler";
			}

			scheduler = (Scheduler)session.getAttribute(schedulerName);

			if (scheduler == null){
				GenericJobX genericJobX = new GenericJobX();
				scheduler = genericJobX.getScheduler();
				session.setAttribute(schedulerName,scheduler);
			}

		} catch (Exception e) {
			logger.fatal("AseJob: getScheduler: " + e.toString());
		}

		return scheduler;

	}

	/**
	** Jobname varchar
	**/
	public String getJobName(){ return this.jobName; }
	public void setJobName(String value){ this.jobName = value; }

	/**
	** jobGroup varchar
	**/
	public String getJobGroup(){ return this.jobGroup; }
	public void setJobGroup(String value){ this.jobGroup = value; }

	/**
	** JobName job
	**/
	public JobName getJob(){ return this.job; }
	public void setJob(JobName value){ this.job = value; }

	/**
	** AseJobParms aseJobParms
	**/
	public AseJobParms getAseJobParms(){ return this.aseJobParms; }
	public void setAseJobParms(AseJobParms value){ this.aseJobParms = value; }

	public String toString(){

		return "jobName: " + getJobName() + "<br>" +
		"JobGroup: " + getJobGroup() +  "<br>" +
		"Job: " + getJob() +  "<br>" +
		"AseJobParms: " + aseJobParms +  "<br>" +
		"";
	}

} // class

