/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  CourseCatalog.java
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

public class CourseCatalogTask {

	static Logger logger = Logger.getLogger(CourseCatalogJob.class.getName());

	/**
	*/
   public void runTask(String campus, String alpha, String num) {

		try{
			SyllabusDB.writeCatalog(campus,alpha,num);
		}
		catch(Exception e){
			logger.info("CourseCatalogTask.runTask - " + e.toString());
		}

    }
}
