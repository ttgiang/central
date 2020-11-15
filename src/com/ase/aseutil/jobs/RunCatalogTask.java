/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineernig
 * @author ttgiang
 *
 *
 */

//
//  RunCatalogTask.java
//
package com.ase.aseutil.jobs;

import com.ase.aseutil.SyllabusDB;
import org.quartz.Scheduler;

import org.apache.log4j.Logger;

public class RunCatalogTask {

	static Logger logger = Logger.getLogger(RunCatalogTask.class.getName());

	public void runCatalogTask(Scheduler scheduler,String campus,String user,String alpha,String num,boolean parseHtml,boolean suppress) {

		try{

			String catalog = SyllabusDB.writeCatalog(campus,user,alpha,num,parseHtml,suppress);

			// not a good idea to shutdown the scheduler here. allow the session
			// to keep the one schedudler that was created until sysadm shuts it down
			if(scheduler != null){
				//scheduler.shutdown();
			}

		}
		catch(Exception e){
			logger.info("RunCatalogTask.runCatalogTask - " + e.toString());
		}

	}

}
